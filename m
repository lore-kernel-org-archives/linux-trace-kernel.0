Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025891419A4;
	Mon,  8 Jun 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911303; cv=none; b=p8WJrUBIfuxzd9VtZ7NBpuPud8F+gmorDFG3ZCH48T0qScssOSXuYHZ4WtabU4OFsR6K62uUfv9P9EWrCkjUJrqT4+3RY4xNU1BojV1nG6gCyDn3AV5afs13bpIvOXkA58qIM6ARPLlxl82gtoDxqj/VIxgevgcJ9woVPzH+YFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911303; c=relaxed/simple;
	bh=etuSTnMPrlLsvTGi8WLbVDFCV8wD6goyss0U+98gk98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChsX0eHU20P5+IZkE+04HS8fUFlI0U7fwqSV1pqdQH0FLtIIMM43+suK1OV6SIxRFirxhbCdI9GJEczYSg2FEaVPkgsuDLVq9x8X7E73ecC5y3ivRro5Zv7mKIOL0MqSIPtvDTHrR37UAitSPmYYD0NvMGAUVmQisWpzit5US6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a8lKvyq+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8lKvyq+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Tsj5SDXNxCIBGDmoRYg1mESVF/vVfOT5aym0N/V1qY=; b=a8lKvyq+boHcTdrPEw41/v312R
	DBSbiTTxR9uL2OHi/zTGk/tQFazavQVzW6o6T05xzcWqxVBgGqGvOkS2d3Dk2ACExIxpnXQMvKr0G
	T2JS7E5e572frYse6Jsh1Fe3L6g3G9yS+dzkgtMrUDqiS71lgKSWnwwRVOevqgVzd6J3kKgf9T7nO
	+ojoNvHXweclZBuAzraKD3Ojahhjg3XuFEVPAcMmFEl21EUQzCkP5nkquW0xt9dFb5fA3tgVmoZf5
	45NiYrlIkoXDZam2/odG9PDAfhlweDsNUvHJp3zL1fuaMhIHk1/IKpDnmIHSYIHFveOWcgaLyhX2X
	tOFzHPmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWWNf-00000000naU-1OMt;
	Mon, 08 Jun 2026 09:34:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6B9D30036F; Mon, 08 Jun 2026 11:34:49 +0200 (CEST)
Date: Mon, 8 Jun 2026 11:34:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-ID: <20260608093449.GH4149641@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
 <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>


+Live patching folks

On Mon, Jun 08, 2026 at 09:52:37AM +0800, Tengda Wu wrote:

> Background: We are verifying the support of live patches for functions that
> have a kretprobe. The specific verification method is as follows:
> 
> We construct a function foo() that calls bar():
> 
> void bar(void)
> {
>     for (;;) {
>         schedule();
>     }
> }
> 
> void foo(void)
> {
>     bar();
> }
> 
> A kretprobe is attached to bar():
> 
> echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
> echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
> 
> Then foo() is triggered. The expected behavior is that bar() will call
> schedule() and yield the CPU.
> 
> After that, the live patch is activated to attempt replacing the implementation
> of foo(). The expectation is that this should succeed.

This wholly depends on how foo() calls bar(), if it is a normal call,
then no, it should not succeed, because foo() is still on the stack.

If it is a tail-call, then yes, because foo() is no longer relevant.

> However, in reality, because the task that called schedule() is still in the
> RUNNING state,

So calling schedule() without setting state is dodgy in the first place.
Who is doing this? All wait primitives will set this to
TASK_UNINTERRUPTIBLE or something along those lines.

> the condition task_is_running(tsk) inside rethook_find_ret_addr()
> is not satisfied, causing the function to return early. This, in turn,
> prevents stack_trace_save_tsk_reliable() from determining the stack as
> reliable, leading to a failure in activating the live patch.
> 
> **Not sure if this is correct:**
> 
> We believe that after a task voluntarily calls schedule(), when the stack
> is expected to be reliable, it is a safe time to activate a live patch.

Calling schedule() without setting state is a no-op and really shouldn't
count much at all.

> Additionally, a similar tsk->on_cpu check can be found elsewhere in the
> kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
> Therefore, we propose changing the task_is_running(tsk) condition to
> tsk->on_cpu.

Anyway, I'm wondering what the purpose of this check here is, there is
no real comment, and commit 5120d167e21c ("rethook: Remove warning
messages printed for finding return address of a frame.") is just pure
voodoo as well.

Also, note the comment that goes with the usage of
task_on_another_cpu(); that thing is racy as all heck.

So it really comes down to what the purpose of this check is.

I suspect the issue at hand is that tsk->rethook elements, such as
iterated by __rethook_find_ret_addr() are not safe to be accessed for a
running task.

Notably while rethook_recycle() has some RCU thing on, that objpool
thing (and the recycle name itself) seems to strongly suggest iterating
these things is not sound (you could start with things from this task,
hit a recycled entry and continue iterating rethooks from another task).

Also note that the current check is also racy, nothing really prevents a
wakeup from happening right after you observe task_is_running() being
false. The task can then get scheduled in on another CPU and tear down
its rethooks concurrent with __rethook_find_ret_addr().


Now, livepatch itself calls unwind from a proper context, but unwinds in
general are not. This rethook stuff doesn't seem to be sound in general.
