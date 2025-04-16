Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B20209673;
	Wed, 16 Apr 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826380; cv=none; b=G4xO52yfr8/wm6Lfdg9jPUkevS7FXft/3ZxRe7GinFIBCl5x/LnrrH6AS2Wq35r5AqxtY/tUEC8DLAP51nQcYYP72lMRX15Bv5ButNcQXzUi6rtbYoBOjQXDfdVZZFb3Iv6z6B44nRBqi0AnEr24BvfT5fWSrQ2Hf5eY6tMi43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826380; c=relaxed/simple;
	bh=2r1Acswmzhjq3+S12S+Csmh4foxN7PUxu5mf+ncbnJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDuz2imrwJ90pwb3tziDBBmNkS47TpmrZr1A2Riv5SMMfQ9egbwx2iq42/RX9BQvE5daOFh3eJXi6pGl7Ro0TkIQZw0fEdy9zC1CUwEAPYI6Bir6s8Rq3Yt17uU32kFI2oxy+wC9HJUNF7TEptY7pJ3lMhSImSHIOSuUXQB5IcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2146C4CEE4;
	Wed, 16 Apr 2025 17:59:38 +0000 (UTC)
Date: Wed, 16 Apr 2025 14:01:15 -0400
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
Message-ID: <20250416140115.5b836b33@gandalf.local.home>
In-Reply-To: <20250416174714.GGZ__tIi3yNzNKoKFE@fat_crate.local>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
	<20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
	<20250414182050.213480aa@gandalf.local.home>
	<20250416174714.GGZ__tIi3yNzNKoKFE@fat_crate.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 19:47:14 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Apr 14, 2025 at 06:20:50PM -0400, Steven Rostedt wrote:
> > It's useful for me ;-)  
> 
> That's why I CCed you.
> 
> I suspected you'd have "your mustard to share". :-P

:-)

> 
> >  # cd /sys/kernel/tracing
> >  # echo 's:user_faults u64 delta;' >> dynamic_events
> >  # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs' >> events/exceptions/page_fault_user_enter/trigger
> >  # echo 'hist:keys=common_pid:delta=common_timestamp.usecs-$ts0:onmatch(exceptions.page_fault_user_enter).trace(user_faults,$delta)' >> events/exceptions/page_fault_user_exit/trigger
> > 
> >  # cd /work/git/trace-cmd.git
> >  # echo 'hist:keys=delta.log2:sort=delta if COMM == "cc1"' > /sys/kernel/tracing/events/synthetic/user_faults/trigger  
> 
> OMG, this tracing thing has turned into a language almost. I hope you're
> documenting those fancy use cases...

The above was created by:

 # trace-cmd sqlhist -e -n user_faults SELECT TIMESTAMP_DELTA_USECS as delta FROM page_fault_user_enter as start JOIN \
     page_fault_user_exit as end ON start.common_pid = end.common_pid

It also shows the kernel commands, which I took and sanitized a bit.

;-)

> 
> >  # make
> > [..]
> > 
> >  # cat /sys/kernel/tracing/events/synthetic/user_faults/hist
> > # event histogram
> > #
> > # trigger info: hist:keys=delta.log2:vals=hitcount:sort=delta.log2:size=2048 if COMM == "cc1" [active]
> > #
> > 
> > { delta: ~ 2^0  } hitcount:          1
> > { delta: ~ 2^1  } hitcount:        334
> > { delta: ~ 2^2  } hitcount:       4090
> > { delta: ~ 2^3  } hitcount:      86037
> > { delta: ~ 2^4  } hitcount:     108790
> > { delta: ~ 2^5  } hitcount:      27387
> > { delta: ~ 2^6  } hitcount:       6015
> > { delta: ~ 2^7  } hitcount:        481
> > { delta: ~ 2^8  } hitcount:        134
> > { delta: ~ 2^9  } hitcount:         74
> > { delta: ~ 2^10 } hitcount:         54
> > { delta: ~ 2^11 } hitcount:          6
> > 
> > Totals:
> >     Hits: 233403
> >     Entries: 12
> >     Dropped: 0
> > 
> > 
> > The above shows a histogram in microseconds where the buckets increase in a
> > power of two. The biggest bucket is between 2^4 (16) and 2^5 (32) microseconds
> > with 108790 hits.
> > 
> > The longest bucket of 2^11 (2ms) to 2^12 (4ms) had 6 hits.
> > 
> > And when sframes is supported, it will be able to show the user space stack
> > trace of where the longest page faults occur.  
> 
> Ok, so AFAIU, this gives you how long user page faults take and apparently for
> someone this is important info.

This was just a simple example. I rather see where in the kernel it happens.
I can still use the synthetic events and user stack trace to find where the
big faults occur.

> 
> Now if only that info were in the commit message along with the usage scenario
> so that people can *actually* do what you guys are bragging about...

I plan on adding things like this to Documentation/trace/debugging.rst

I need to get time out to add a bunch of helpful tricks there.

-- Steve
