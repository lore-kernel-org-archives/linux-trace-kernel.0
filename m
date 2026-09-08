Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BB572670
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883466; cv=none; b=CLryDaygKR+O8+aE0J9QqdYlHd9oHmvmDUnAcxTJ//JtxR66gnwlqkbTtEiYUan10dhoZ+VYzkXfDzCkqpVF/EJJFXASy26RJAHh9K+7GjB4vNByYOjU5GMyoV6pMsEWKLiuUgaGZxVJSxP1DsQsO0u3sSwcuKQ4tv77xaWpej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883466; c=relaxed/simple;
	bh=wwjGm1sChVlECtSsAuFj34DqSRyAk3CmYXTBcmAKUdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGrKmcjnVP+7Efed1iJwR2KoQ+mDV6aOxTF8PCGaTRkWCG/I5E/L8Y3GGBZhXlBdaN/4UkCcbKWwHwM501C6N+P0g+nrzU7Cab1Iz6NYKKTaJkY7uvtGusnQP7WJ2rYRKRlJBvVVm6rAtyUt33OJW8BuipkyCALzuZ/ta6Mqxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=YDl5jKPP; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="YDl5jKPP"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D61B880614;
	Tue,  8 Sep 2026 16:04:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 1931E34;
	Tue,  8 Sep 2026 16:04:20 +0000 (UTC)
Date: Tue, 8 Sep 2026 12:05:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lahoz Fernando <flahoz@ikerlan.es>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [BUG?] tracing: unexpected behavior trying to keep IRQ code
 away from traces
Message-ID: <20260908120534.390672a8@gandalf.local.home>
In-Reply-To: <PAWPR03MB92138194E34B81962AA24738A2B52@PAWPR03MB9213.eurprd03.prod.outlook.com>
References: <PAWPR03MB92138194E34B81962AA24738A2B52@PAWPR03MB9213.eurprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1931E34
X-Stat-Signature: cwu38m4mygprkxuuckrb861f5e64zdwi
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/V74UreVB8DQRvMtsey9IYkoEAd6H2kk0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=rGc/x/gncOgl7pBCzKKeNcSWmvRouaaT0k0LCfkc4Dk=; b=YDl5jKPP0lsjfLZpTpMb4tltEU0knbAvNYRW/wRrw44/FEurX28Xqq1PLePJGKPMfKm/RkBYU96MD38KWQ+VKPL8qXd7MCRH1VnqtgC+Xd8Kwt13o/KxDaCET6qkQy5OyiaR52DxGLYhCyOWNW0Kb5bmDKJa8GW5UT5hsxxmcs0=
X-HE-Tag: 1788883460-219209
X-HE-Meta: U2FsdGVkX1+dmktGRiJOtIqX3HBM4mtJzVnjfMCcv6dV9y8Hqe2rIWcj0VKKklvZiAtkRamSloU9D/y0L0m88eYspw8N1YodpHI+ViuedqlsMebnLjJnNduzBeXhq4kuV3lIsdryxllSn1k8F+brnKiIreL/TLIcJyFcEk8ph4orVemzc2A+0R/yB51NsKNX+VBUkFZ6BdmEoJCPjQR2Xc1byHmUL96JcRkOfnPqJITMM0mxylaBV2ywY6ysr9TEBXe2s5MEdB2V54Dra+22opxGyOw9bW/OQLuOhT3FoRGFtXVRM5VkCJ/nbPqDLpTRGyDnGGZjqIiSE+wvCAXkAKQ1ERjmyMNMkNtyVdf86qyZpNazYtvLv3qU1aRg40EmZsdzkA3TYvB5HrnP8oXpRg==

On Mon, 7 Sep 2026 09:07:57 +0000
Lahoz Fernando <flahoz@ikerlan.es> wrote:

> Hello,
> 
> It seems that code executed during IRQ entry/exit may be traced as task context
> because HARDIRQ_OFFSET is not reflected in preempt_count until irq_enter_rcu()
> is called. As a result, both in_task() and in_hardirq() may incorrectly classify
> some IRQ-entry code, causing IRQ-related functions to appear even when IRQ
> tracing is disabled.
> 
> 
> I've been developing a minimal syscall tracer using ftrace's api from a kernel
> module. During the process I've tried to prevent interrupt-related code from
> appearing in the trace data, therefore I use the in_task() macro to filter
> everything that is not in running in "task context". However, some functions
> executed in hardirq context bypass the check, as they are executed before
> preempt_count is updated.
> 
> I was not certain whether this was a bug on how the flag is set or the intended
> behaviour, so, I traced the same code using the function-graph-tracer with
> 'funcgraph-irqs' option active, but I saw the same behaviour.

It's a bug that's been know about since 2009 :-/

Yes, because we use preempt_count to determine if an event is in interrupt
context or not, and there's some places that trigger events (function
tracer) before the preempt count is updated, we can report the wrong context.

This is well known, and is the reason behind the TRANSITION_BIT in the
recursion protection lock[1]. The recursion detection tests if an event was
triggered in the same context, and if it is, it drops the event. But it was
reported that not all entry into interrupts were traced, and that's because
if an interrupt went off while it was recording an event in task context,
the recursion would detect it as the same context recursion (not allowed)
and drop it. But once the preempt_count was updated, the rest of the
interrupt events were traced.

> 
> 
> I'm using a fully preemptive kernel, compiled for both aarch64 (this one runs
> on an evaluation board) and riscv (this one runs on qemu). I have not checked
> if it happens in any other arch. I first saw this behaviour in v6.15.5 with
> aarch64, but it's still present in v7.2.2. I have not checked older versions.

It happens on all archs that can trace before preempt_count is updated. I
detected it on x86.

> 
> 
> The root of the problem seems to be that there is instrumentable code that
> executes on every IRQ before and after HARDIRQ_OFFSET is added/substracted to
> preempt_count, so function tracers cannot correctly filter IRQ using in_hardirq().
> 
> 	(All the source I show comes from kernel v7.2.2)
> 
> 	In file: "/arch/arm64/kernel/entry-common.c" (lines 501-513)
> 
> 		static __always_inline void __el1_irq(struct pt_regs *regs,
> 		                                      void (*handler)(struct pt_regs *))
> 		{
> 			irqentry_state_t state;
> 
> 			state = arm64_enter_from_kernel_mode(regs);
> 
> 			irq_enter_rcu();  // <-- `preempt_count_add(HARDIRQ_OFFSET)`
> 			do_interrupt_handler(regs, handler);
> 			irq_exit_rcu();   // <-- `preempt_count_sub(HARDIRQ_OFFSET);`
> 
> 			arm64_exit_to_kernel_mode(regs, state);
> 		}
> 
> I've tried to wrap this function between preempt_count_add(HARDIRQ_OFFSET)
> and preempt_count_sub(HARDIRQ_OFFSET), but kernel won't finish booting up.

And you are now seeing why we haven't fixed it since 2009 ;-)

> 
> Similarly, this also happens in riscv, as it can be seen in file
> "/arch/riscv/kernel/traps.c" (lines 424-445) that irq_enter_rcu is called after
> the equivalent function to arm64_enter_from_kernel_mode.
> 
> 
> Test using function graph tracer:
> 
> As I said, I wanted to check if IRQs also appeared inside the trace file while
> option funcgraph-irqs was disabled. Ftrace's documentation
> (https://docs.kernel.org/trace/ftrace.html) decribes this parameter as follows:
> 
> 	"When disabled, functions that happen inside an interrupt will not be traced."
> 
> so I expected it to remove every function called inside __el1_irq from the trace.
> 
> I isolated CPU 3 for it to run the test program alone with taskset.
> I traced with the following configuration:
> 
> 	TRACEFS="/sys/kernel/tracing"
> 
> 	# Stop tracing and clean buffer
> 	echo 0 > "${TRACEFS}/tracing_on"
> 	: > "${TRACEFS}/trace"
> 
> 	# Trace only CPU 3 with 1GB buffer
> 	echo 8 > "${TRACEFS}/tracing_cpumask"
> 	echo 1048576 > "${TRACEFS}/per_cpu/cpu3/buffer_size_kb"
> 
> 	echo local > "${TRACEFS}/trace_clock"
> 	echo function_graph > "${TRACEFS}/current_tracer"
> 
> 	for opt in 'funcgraph-proc' 'funcgraph-tail' 'irq-info' 'nofuncgraph-irqs'; do
> 		echo "$opt" > "${TRACEFS}/trace_options"
> 	done
> 
> 	# Clean filters and trace only syscalls
> 	: > "${TRACEFS}/set_graph_function"
> 	echo "__arm64_sys_*" > "${TRACEFS}/set_graph_function"
> 
> The resulting trace shows only syscalls code, being sometimes interrupted by
> code inside __el1_irq:
> 
>  ...
>  3) randbyt-14268  |               |            mntput() {                  //__arm64_sys_openat
>  3) randbyt-14268  |               |              mntput_no_expire() {      //__arm64_sys_openat
>  3) randbyt-14268  |   1.180 us    |                __rcu_irq_enter_check_tick(); //IRQ CODE
>  3) randbyt-14268  |   1.900 us    |                irq_enter_rcu();
>  3) randbyt-14268  |   1.340 us    |                idle_cpu();
>  3) randbyt-14268  |               |                tick_nohz_irq_exit() {
>  ...
>  3) randbyt-14268  | + 13.072 us   |                } /* tick_nohz_irq_exit */
>  3) randbyt-14268  |               |                raw_irqentry_exit_cond_resched() {
>  3) randbyt-14268  |               |                  preempt_schedule_irq() {
>  ...
>  3) randbyt-14268  | + 73.637 us   |                  } /* preempt_schedule_irq */
>  3) randbyt-14268  | + 75.938 us   |                } /* raw_irqentry_exit_cond_resched */
>  3) randbyt-14268  |   0.960 us    |                __rcu_read_lock();
>  3) randbyt-14268  |   1.070 us    |                __rcu_read_unlock();    //IRQ CODE
>  3) randbyt-14268  | ! 146.225 us  |              } /* mntput_no_expire */  //__arm64_sys_openat
>  3) randbyt-14268  | ! 148.385 us  |            } /* mntput */              //__arm64_sys_openat
>  ...
> 
> >From here I suspected that funcgraph-irqs' implementation relied on the same  
> flags I checked in my custom tracer, so I searched inside the graph tracer code
> and found this early-exit condition being called from graph_entry:
> 
> 	In file: "/kernel/trace/trace_functions_graph.c" (lines 209-217)
> 
> 		static inline int ftrace_graph_ignore_irqs(struct trace_array *tr)
> 		{
> 			if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
> 				return 0;
> 
> 			if (tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))
> 				return 0;
> 
> 			return in_hardirq();
> 		}
> 
> Both in_task() an in_hardirq() macros check preempt_count, which has the fault
> of not being fully set before any code executes on IRQ context.

Correct.

> 
> 
> I do not know whether preempt_count is intended to provide precise context
> information during IRQ entry/exit transitions. If not, would there be a
> recommended mechanism for tracers that need to distinguish task and IRQ contexts
> during these early entry stages?

It would require looking at the hardware flags directly *at every event*,
which would greatly impact performance of the tracer.

> 
> For my tracer I patched __el1_irq in aarch64, making it noinline instead of
> __always_inline. That way I can catch its beginning and end registering a
> ftrace_direct routine with the minimal changes to vanilla Linux.
> I have not tried any fix for riscv.
> 
> Is this behavior intentional, meaning that code executed before irq_enter_rcu()
> is considered outside hardirq context, or is this an unintended limitation of
> tracing based on preempt_count?

It's the limitation of using preempt_count to determine irq context as it
is the fastest way to do so. Basically, we just need to cope with this and
try to find other means to handle it.

Ideally, the preempt_count update would be moved to locations that happen
before any events (function or otherwise) trigger. But that is no easy
task. Maybe something you could do? ;-)

-- Steve


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/trace_recursion.h#n35
