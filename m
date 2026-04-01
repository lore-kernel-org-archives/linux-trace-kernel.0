Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFB33D6C1;
	Wed,  1 Apr 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071884; cv=none; b=TWLr5DjD3OkjFJJTNVWgRFuH3AGeI3hKU55w7m9lWlNQFwsXSxfVgc3ud+4Btvm02SZrfjRIo2WxaRS/4Uyka0/J30+YCJ0Y+S0O66JeUvuskn7d18JkS0tlLr2KKgYKN+ExIS4un9iE2hbUIA1T9kDin2L1ZSTMDDwRB9jNs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071884; c=relaxed/simple;
	bh=Kw0V75LMzAaGneIciiZjh5kTr1OlD19V1VO0p77g1OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUE+fHFYHPR51VC0p39GE2HwHgfOoEX7cso0WNvMs0OYmumsePiz8bgeTGCA0FVN+8ZUuTxRwcM2s+obKYYK9twMyMbW5qbg/26F3eCWl1W3rmWhyRA6xGzV1DDXz0Zrfl/y5cuIiluC43PD9Tf4ft8f5vD03lxO5ozsnqTpwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkHUS6SA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7TuyQ7d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkHUS6SA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7TuyQ7d"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775071880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BEYKGdjf+g+G32MKhHElrcCQM0YZm2QGSoc2z7OSDvc=;
	b=hkHUS6SAygL3p7ypgc44g22ge9JQUtgpHArha2HqaYT+YiYw9djmjbXt29S0MOD5gpPRhA
	SYAIuGZNMk3S3JQO+oeRFWjb5QqdA8b3E+Mz4T7owDSPfWquETPWyxXLwwS3e7F0MS9bqq
	QAHM5A1s/AwttQKrhlJ9acWvKGIBTo9tZaf4kEaQPBSMXaw+GIoSJI0i0nZSjkzxPRSz0o
	rKFQph0JOKFsyudq4aClw/HJ+P4uC3Cbrpol2iYAeKsyJqG+wJCvN6MuDDTYNa6zccsbOt
	PMOlIoUp+yOYaoe8M/30l6yZlzUhOPYHNP3UliQyMChpOR9XBJ+Lu6jlr8T+3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775071880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BEYKGdjf+g+G32MKhHElrcCQM0YZm2QGSoc2z7OSDvc=;
	b=u7TuyQ7d8zq1XH60v/GTLA9MyTqC2im5p1dxcHCrU62dVVjMXJN9+9I+ejaB3Oo54S47nt
	hkpMi6Y9EOuFBbAA==
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brian
 Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>, Ian Rogers
 <irogers@google.com>, Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v3 0/3] tracing: Read user data from futex system call
 trace event
In-Reply-To: <20260331181349.062575155@kernel.org>
References: <20260331181349.062575155@kernel.org>
Date: Wed, 01 Apr 2026 21:31:19 +0200
Message-ID: <87zf3m7a0o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 31 2026 at 14:13, Steven Rostedt wrote:
> We are looking at the performance of futexes and require a bit more
> information when tracing them.
>
> The two patches here extend the system call reading of user space to

s/two/three/ :)

> create specific handling of the futex system call. It now reads the
> user space relevant data (the addr, utime and addr2), as well as
> parses the flags. This adds a little smarts to the trace event as
> it only shows the parameters that are relevant, as well as parses
> utime as either a timespec or as val2 depending on the futex_op.
>
> Here's an example of the new output:
>
>  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e834 (0x4a7) tid: 1191, FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e834 (0) tid: 0, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAIT|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (4aa), val3: 0)
>  sys_futex(uaddr: 0x56196292e834 (0x4aa) tid: 1194, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
>  sys_futex(uaddr: 0x7f7ed6b29990 (0x4ab), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME)
>  sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
>  sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)

I understand what you are trying to achieve, but do we really need all
the complexity of decoding and pretty printing in the kernel?

Isn't it sufficient to store and expose the raw data and use post
processing to make it readable?

I've been doing complex futex analysis for two decades with a small set
of python scripts which translate raw text or binary trace data into
human readable information.

I agree that it's useful to have the actual timeout value and other data
which is missing today, but that still does not require all this
customized printing.

The initial idea of having at least some information about the data
entry (type, meaning etc.) in $event/format and use that for kernel text
output and for user space tools to analyze a binary trace has been
definitely the right way to go.

But that now deviates because $event/format cannot carry that
information you translate to in the kernel. It will still describe raw
event data, no?

So why not keeping the well known and working solution of identifying
the data in the format, print it raw and leave the post processing to
user space tools in case there is a need.

You actually make it harder to do development. Look at the patch series
related to robust futexes:

  https://lore.kernel.org/lkml/20260330114212.927686587@kernel.org/

So your decoding:

>  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG)

fails to decode the new flag and the usage of uaddr2 unless I go and add
it in the first place _before_ working on the code. Right now it is just
printing op as a hex value and it just works when a new bit is added.

Stick 100 lines of python into tools/tracing and be done with it. I'm
happy to contribute to that.

Aside of that:

  Putting the decoder (futex_print_syscall) into the futex code itself
  is admittedly a smart move to offload the work of keeping that up to
  date to the people who are actually working on futexes.

TBH, I'm not interested to deal with that at all. If you want this
ftrace magic pretty printing, then stick it into kernel/trace or if
there is a real technical reason (hint there is none) into
kernel/futex/trace.c and take ownership of it. But please do not burden
others with your fancy toy of the day.

Thanks,

        tglx
