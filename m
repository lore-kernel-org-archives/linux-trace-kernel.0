Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FD1A0BFA;
	Mon, 14 Apr 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669160; cv=none; b=sGevEmE0Fh6QePRsng3IRyVFYNpTtHz3pxQFRaxBg+5OTVtE88cHcg3c0UpbE8lUTypGg2BrpK/kVAygn6tUni9qY2BFkmLxgo+proMo9eGCgKAT14WV6lPx8xqOLvRsHmg7V3EWGWvbUkEbB1wx8LSJuS3y0P6rdG+e9ewdVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669160; c=relaxed/simple;
	bh=wazrb6p70nMSbfR4wfH6K//sev3lSxv9Y5wdY1L/exo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwyoGZ5EIZKE2Zr09U1ia6ipen9/p57ZBArjpDOJoTMCQs0r+eh/opPxMhFjKEnTW9fESAq8yvGaUfjMYKhm9Bz1QPaL49X6PYQYJ8CYldcOjKZQT8b1WAnS7pJt3kGx0oxAn61uct8gQAeVMWZ2SNdtrDQp3T7wbq5K3kA1LYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C18C4CEE2;
	Mon, 14 Apr 2025 22:19:18 +0000 (UTC)
Date: Mon, 14 Apr 2025 18:20:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250414182050.213480aa@gandalf.local.home>
In-Reply-To: <20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
	<20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 22:54:41 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Apr 14, 2025 at 03:35:41PM -0500, Junxuan Liao wrote:
> > Rename page_fault_{user,kernel} to page_fault_{user,kernel}_enter, and
> > add the exit counterparts. This might be useful for measuring page fault  
> 				  ^^^^^^^^^^^^^^^^
> 
> Well, come back when it really becomes useful.

It's useful for me ;-)

 # cd /sys/kernel/tracing
 # echo 's:user_faults u64 delta;' >> dynamic_events
 # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs' >> events/exceptions/page_fault_user_enter/trigger
 # echo 'hist:keys=common_pid:delta=common_timestamp.usecs-$ts0:onmatch(exceptions.page_fault_user_enter).trace(user_faults,$delta)' >> events/exceptions/page_fault_user_exit/trigger

 # cd /work/git/trace-cmd.git
 # echo 'hist:keys=delta.log2:sort=delta if COMM == "cc1"' > /sys/kernel/tracing/events/synthetic/user_faults/trigger
 # make
[..]

 # cat /sys/kernel/tracing/events/synthetic/user_faults/hist
# event histogram
#
# trigger info: hist:keys=delta.log2:vals=hitcount:sort=delta.log2:size=2048 if COMM == "cc1" [active]
#

{ delta: ~ 2^0  } hitcount:          1
{ delta: ~ 2^1  } hitcount:        334
{ delta: ~ 2^2  } hitcount:       4090
{ delta: ~ 2^3  } hitcount:      86037
{ delta: ~ 2^4  } hitcount:     108790
{ delta: ~ 2^5  } hitcount:      27387
{ delta: ~ 2^6  } hitcount:       6015
{ delta: ~ 2^7  } hitcount:        481
{ delta: ~ 2^8  } hitcount:        134
{ delta: ~ 2^9  } hitcount:         74
{ delta: ~ 2^10 } hitcount:         54
{ delta: ~ 2^11 } hitcount:          6

Totals:
    Hits: 233403
    Entries: 12
    Dropped: 0


The above shows a histogram in microseconds where the buckets increase in a
power of two. The biggest bucket is between 2^4 (16) and 2^5 (32) microseconds
with 108790 hits.

The longest bucket of 2^11 (2ms) to 2^12 (4ms) had 6 hits.

And when sframes is supported, it will be able to show the user space stack
trace of where the longest page faults occur.

-- Steve
