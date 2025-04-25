Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29A197A76;
	Fri, 25 Apr 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562906; cv=none; b=cQ1K6uXZXg98D3In86od7+z8lQM5U38BB2kLSEMlMGV7iQ4O39xNopKa2iSPhL+G4LGxaPDY4fWrFUN6XE/umaXfqRhFFM7//ZPH9mjhJESv9v8l7Z+34bab9s+rKwmmk3JJifo/yLcn6phZgyxQIL9K6358N8/88fQkSLrNhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562906; c=relaxed/simple;
	bh=Aqx/cGOnrFZrNXciPbrn78v2PMFDC23F0QG2WsnTUAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBVc48hBAFSb4lFkHVtOXEBDojUSJ4hhMHqD3eghinYk1qkxI8xebFpz21i1/bcIY1QKD5gbTDCfT0FAWcGwXrX1JUHq2wiZFox4pvdRJfkeu0eARHg1zmluQpnBqZKHkEg+mwvXyfOKvTGTL4TIrjW/NoXdnGivLI+5o45aB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QP+MzwIH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylRA9HdN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP+MzwIH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylRA9HdN"
Date: Fri, 25 Apr 2025 08:34:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745562902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gN1TQUuXLsT2GFpQe5TlMWweD4/kCA/3ex6aTZSUynk=;
	b=QP+MzwIHrh3yixUpvyxhXttXLqSsRO67GyQEnS+Jfgv3+4B3KZLaAZtvAXSa1OVZgjEpo2
	tXouI1+GGKPI9UkbGXj7Je9aYTMLjRJEUHCWhapAV8RKwOAMzqMPBLW2MiTpM/qbTKuDPd
	wZjqd462yiTY4zBIiwGfWJs8vgdLcvI2rRd8QOkClX0iIuiCwcSG8XAIOuMn8qyc4JqgRQ
	pfNa+uGHNVcfCA9wSMDPy1c8xlXNk6FJaGfGet5xIdvL0ol0WPtTZyBsBUDxhY7zPdFDk3
	LkI/HCfwq9T7UTMhdhN4bV8q/weGirzjbSHZcwRRDqXdYghPZ4H8WLdTzNSQ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745562902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gN1TQUuXLsT2GFpQe5TlMWweD4/kCA/3ex6aTZSUynk=;
	b=ylRA9HdNcA4lGr446Fp7K5Sc9rG4TOiJbQhHtCK10Wa360QNdEZdtI1NXoUXIdT6OXqOuN
	soSqi48tUvoDn9Dg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
Message-ID: <20250425063456.NBE35YHR@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
 <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>

On Thu, Apr 24, 2025 at 03:55:34PM +0200, Gabriele Monaco wrote:
> I've been playing with these monitors, code-wise they look good.
> I tested a bit and they seem to work without many surprises by doing
> something as simple as:
> 
> perf stat -e rv:error_sleep stress-ng --cpu-sched 1 -t 10s
>   -- shows several errors --

This one is a monitor's bug.

The monitor mistakenly sees the task getting woken up, *then* sees it going
to sleep.

This is due to trace_sched_switch() being called with a stale 'prev_state'.
'prev_state' is read at the beginning of __schedule(), but
trace_sched_switch() is invoked a bit later. Therefore if task->__state is
changed inbetween, 'prev_state' is not the value of task->__state.

The monitor checks (prev_state & TASK_INTERRUPTIBLE) to determine if the
task is going to sleep. This can be incorrect due to the race above. The
monitor sees the task going to sleep, but actually it is just preempted.

I think this also answers the race you observed with the srs monitor?

> perf stat -e rv:error_sleep stress-ng --prio-inv 1 --prio-inv-policy rr
>   -- shows only 1 error (normal while starting the program?) --
> 
> Not quite sound, but does it look a reasonable test to you?

The above command use mutexes with priority inheritance. That is good for
real-time. The errors are due to real-time tasks being delayed by
waitpid().

Priority inheritance can be disabled with "--prio-inv-type none". Then you
will see lots of errors with mutexes.

> I quickly tried the same with the other monitor comparing the number of
> errors with the page_faults generated by perf, but that didn't make too
> much sense. Perhaps I'm doing something wrong here though (the number
> reported by perf for page faults feels a bit too high).
> 
> perf stat -e page-faults -e rv:error_pagefault stress-ng --cyclic 1

This command run a non-real-time thread to do setup, and a cyclic real-time
thread. The number of pagefaults of each thread would be roughly
proportional to the code size executed by each thread. As the non-real-time
thread's code size is bigger, it sounds reasonable that the number of
pagefaults is greater than the number of monitor's warnings.
> 
> Anyway, the monitor looks good to me
> 
>   Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> but it'd be nice if you have tips to share how to quickly test it (e.g.
> without writing a custom workload).

I tested the monitor on a real system. My system has some real-time audio
processing processes (pipewire, firefox running youtube), yours also
should.

But thanks so much for testing with stress-ng. My testing didn't stress the
system enough for the above race to happen. I will give stress-ng a few
runs before the next version.

Best regards,
Nam
