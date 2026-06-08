Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8C3382CB;
	Mon,  8 Jun 2026 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887412; cv=none; b=WnYKTfRMY3mYsqFweLLCZQyBHrskf5hJ72raAsPI0i3GZ1nwHkVgUvEUTKfDyiUOD7J2hI6AzzkQFWTJtoyp0uqC5oWAK0ogdilzSt36Y35f3IynJdjXQQiNOnbI1Sf4omFm9oKMMI6jaqxldfrZ5QpP3AX2CQakzDRbLtMcTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887412; c=relaxed/simple;
	bh=25cx7dL4+3ERQX8rgNALfAeh75lQ7xLb98exPLJBYzY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cy3mogO5qpFFXFx3mw5GiQg5o2d2bdOHzlVcd4CqoPwwLgduTdK4gwRhUs5bMZR4cxNiEXCsSGWQ4aRAVwtj5PPFg9aX+wlK3dgHZYYdyq3JKDP62BrUMNqdKoonCuYxWKutpyFd09RfpER4kr2RwObtgG5e8xVujUbcwijl3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO/DjtGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO/DjtGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0B1F00893;
	Mon,  8 Jun 2026 02:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780887410;
	bh=l9SVAsKZOzAb9JIYqxr8k4tu8mfpJ5Iw8JGlHaR8lMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FO/DjtGEPdSVBiOpMDFN7O987whhIj2pGWEmWPtkVUast4tz2lFqNqamv21zHgoee
	 iH8IXP05VP+TN2xAMt07D42R155KXOSKHp80as0rGu9F9hM5OM4wEuttglbDvg4CGS
	 xpL1SOY4qYWIXztWUdHQvGWK0JcVArp7uhY5m8b30lee3Ejw4L/FqwrjdmJYCI9H+6
	 JDb0132WcpxbwsIS+yC9msr2XyDAwugEIYNBwPoLhIHaZk3SskfCSec3masWiPet3E
	 rH6Hdoa6R6qgHAhAS4pvIGOPib++po/rZc6oaGOzatJQ1zy75/A8N0f44uYMc6XKht
	 wHpiBNE/eXexw==
Date: Mon, 8 Jun 2026 11:56:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260608115646.97d80d30aed182d468496449@kernel.org>
In-Reply-To: <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
	<20260526123719.482f07a3843e207e22d95378@kernel.org>
	<94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
	<20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
	<20260604093445.GF3126523@noisy.programming.kicks-ass.net>
	<20260605224341.c926299d613b6102912c9a3f@kernel.org>
	<679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 09:52:37 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> 
> 
> On 2026/6/5 21:43, Masami Hiramatsu wrote:
> > On Thu, 4 Jun 2026 11:34:45 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Mon, Jun 01, 2026 at 08:40:01AM +0900, Masami Hiramatsu wrote:
> >>
> >>> Peter, is it OK to drop @rq from task_on_cpu()? 
> >>
> >> Sure.
> >>
> >>> Then we can use it from rethook.
> >>
> >> Well, it is in sched/sched.h, which is an internal header, and no you
> >> cannot use that header in rethook.
> > 
> > Ah, OK. Hmm, then we should not use it. Maybe ->on_cpu is also internal
> > state?
> > 
> >>
> >> But lets step back first, what is the actual problem here, why are we
> >> looking at ->on_cpu at all?
> > 
> > Tengda, can you explain it?
> > I think you want to take a stacktrace on !current process, and
> > rethook_find_ret_addr() is rejected i the task is running state.
> > 
> > But if you can share actual situation what you need, it is
> > helpful for us to understand.
> > 
> > Thank you,
> > 
> > 
> 
> 
> Sure.
> 
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
> 
> However, in reality, because the task that called schedule() is still in the
> RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
> is not satisfied, causing the function to return early. This, in turn,
> prevents stack_trace_save_tsk_reliable() from determining the stack as
> reliable, leading to a failure in activating the live patch.

Hmm is the bar() doing infinite loop, or limited loop but take a long time
so just yield a while? Anyway, it seems like a non-good design pattern.
Is it possible to avoid busy loops and instead use Workers, or wait for
something to complete or for input within a loop?

> 
> **Not sure if this is correct:**
> 
> We believe that after a task voluntarily calls schedule(), when the stack
> is expected to be reliable, it is a safe time to activate a live patch.

In this case, I don't know how to block the loop inside the bar.
Even if !tsk->on_cpu, the tsk can restart running right after checking
the flag.

> Additionally, a similar tsk->on_cpu check can be found elsewhere in the
> kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
> Therefore, we propose changing the task_is_running(tsk) condition to
> tsk->on_cpu.

Yes, but the caller said there is another check to ensure the race.

        /*                  
         * Refuse to unwind the stack of a task while it's executing on another
         * CPU.  This check is racy, but that's ok: the unwinder has other
         * checks to prevent it from going off the rails.
         */
        if (task_on_another_cpu(task))
                goto err;

Josh, do you know how this avoid the race case?

Thank you,

> 
> Thanks,
> Tengda
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
