Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68647271459;
	Tue, 27 May 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353043; cv=none; b=h/Pg7oZnCR4lo5rwz2jAxygQRFAA+gYjBK4iExIhJr9TDJDmaI9pv3t4DfPQiDiODiP5XtUwqFWuYek3FG7fCq8VX1b80I0sA37YZtUXjMNUKVQGYURpgtieuidq5s/wsioJoj13+Vl2OsOnNi/VyfQsF7R8OHgSxOm7vTIJPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353043; c=relaxed/simple;
	bh=YPFs7o1pRRdS96m8/sYCeukS83lHaWXXuwQF3hlGcx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP3wyddRMQRXUx3Rh+VaHt+8EIcbXpinTyPSiHqU7zM7FrJorV5DEXn5BrUQnY99MPjusFlGL0stiKKtHlLE4EkEypxW3L31Js9EfX8ukW122wZUNum6ag/A7lLIv7pf59XIMAgIhi/TJjZQJMyyHb1B+kH3Dhhp5qlGG27yQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lM93n7el; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6b5rbTN1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lM93n7el";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6b5rbTN1"
Date: Tue, 27 May 2025 15:37:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748353037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JO6gI2ty1BBSgBwH8ImLfjoNHgWaxGFBPO8/nnHGiak=;
	b=lM93n7elEmx3f8AfKLDFsZ8IxgItqachQCS2yeUo0CRiVbN1WAK5EOtu/4DnvduuYSZJGF
	kZ7MKQwwQ+gHPZSUzH5lgIxHSBWC6caNHuCY/65McqFU0jXUG5eJnaD9VlAglozYj/XLyp
	QwI0oAUGeYAtVTWy7h+hzd9SdRKHiGR2IxZHnp80QU+Xw5CovYF4Ew8629nhzLVuq0AXmN
	CGGIcJ89AI5Z0CHM7aphY4aJ8Kk15FPsLHpjxO1L9vdXju72DC/Me3yvPuKUaRmhmPLAxb
	AGHQD2G1xeBXytmAxDU0YkI02FjgiynQlceDu0oM3PEQhtdOoTAKORswv7Fgbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748353037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JO6gI2ty1BBSgBwH8ImLfjoNHgWaxGFBPO8/nnHGiak=;
	b=6b5rbTN1sN6/DeexP7ywcdO3CQ8f0ftxhgPlJMuCbZR8/6Qz/A4Kfo7juDef4JmBh/DRnW
	4Mk0pZogCUHLeBAg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 12/12] rv: Add opid per-cpu monitor
Message-ID: <20250527133712.CFW5AcNE@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-13-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:14AM +0200, Gabriele Monaco wrote:
> Add a per-cpu monitor as part of the sched model:
> * opid: operations with preemption and irq disabled
>     Monitor to ensure wakeup and need_resched occur with irq and
>     preemption disabled or in irq handlers.

This monitor reports some warnings:

$ perf record -e rv:error_opid --call-graph dwarf -a -- ./stress-epoll
(stress-epoll program from
https://github.com/rouming/test-tools/blob/master/stress-epoll.c)

$ perf script
stress-epoll   315 [003]   527.674724: rv:error_opid: event preempt_disable not expected in the state preempt_disabled
	ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
	ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
	ffffffff9fdfba0d handle_preempt_disable+0x3d ([kernel.kallsyms])
	ffffffff9fdd32d0 __traceiter_preempt_disable+0x30 ([kernel.kallsyms])
	ffffffff9fdd38fe trace_preempt_off+0x4e ([kernel.kallsyms])
	ffffffff9fee6c1c vfs_write+0x12c ([kernel.kallsyms])
	ffffffff9fee7128 ksys_write+0x68 ([kernel.kallsyms])
	ffffffffa0bdbd92 do_syscall_64+0xb2 ([kernel.kallsyms])
	ffffffff9fa00130 entry_SYSCALL_64_after_hwframe+0x77 ([kernel.kallsyms])
	           f833f __GI___libc_write+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
	           f833f __GI___libc_write+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
	            1937 thread_work+0x47 (/root/test-tools/stress-epoll)
	           891f4 start_thread+0x304 (/usr/lib/x86_64-linux-gnu/libc.so.6)
	          10989b clone3+0x2b (/usr/lib/x86_64-linux-gnu/libc.so.6)

stress-epoll   318 [002]   527.674759: rv:error_opid: event preempt_disable not expected in the state disabled
	ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
	ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
	ffffffff9fdfba0d handle_preempt_disable+0x3d ([kernel.kallsyms])
	ffffffff9fdd32d0 __traceiter_preempt_disable+0x30 ([kernel.kallsyms])
	ffffffff9fdd38fe trace_preempt_off+0x4e ([kernel.kallsyms])
	ffffffffa0bec1aa _raw_spin_lock_irq+0x1a ([kernel.kallsyms])
	ffffffff9ff4fe73 eventfd_write+0x63 ([kernel.kallsyms])
	ffffffff9fee6be5 vfs_write+0xf5 ([kernel.kallsyms])
	ffffffff9fee7128 ksys_write+0x68 ([kernel.kallsyms])
	ffffffffa0bdbd92 do_syscall_64+0xb2 ([kernel.kallsyms])
	ffffffff9fa00130 entry_SYSCALL_64_after_hwframe+0x77 ([kernel.kallsyms])
	           f833f __GI___libc_write+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
	           f833f __GI___libc_write+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
	            1937 thread_work+0x47 (/root/test-tools/stress-epoll)
	           891f4 start_thread+0x304 (/usr/lib/x86_64-linux-gnu/libc.so.6)
	          10989b clone3+0x2b (/usr/lib/x86_64-linux-gnu/libc.so.6)

I'm not sure what I'm looking at here. Do you think these are kernel bugs,
or the monitor is missing some corner cases?

Best regards,
Nam
