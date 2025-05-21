Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED218DF8D;
	Wed, 21 May 2025 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848655; cv=none; b=n8LmQP3Zk0ri8tPBAtYLNZ9I+wEkpkSRTaqmaWEsxOIhZ/Inuvsfp63740AZbbJ5HAXBpSV9e9xqJcft4LK350HHo2SxPjekMGZ/iB1RZfnMUQZB/6hQPUS6PRZlKaBAppSQmKni32DFX7JFhyl6yPGaavArEzbl+zfw5RLa4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848655; c=relaxed/simple;
	bh=3j1dEns/ysP04rHFNrID0DSREkdArRli7uOeEBQIntI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4lj3Hdit3NBvoArY5ejAUL7mXEiMpjPrmYDVgWMVa9KNplLdrgpvMf0fJoJI2gx1NKC1HUrhKdS9oHiqkJFnsBlNCHxuPqc/wj+y6EbtCF3doNlJUyOUGJIfep34IgdDnpQvxB4Evs4V6oKzCR9rIColl81b+0YY1+YWphawCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69940C4CEE4;
	Wed, 21 May 2025 17:30:54 +0000 (UTC)
Date: Wed, 21 May 2025 13:31:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John <john.cs.hey@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [Bug] soft lockup in syscall_exit_to_user_mode in Linux kernel
 v6.15-rc5
Message-ID: <20250521133137.1b2f2cac@gandalf.local.home>
In-Reply-To: <CAP=Rh=OFdom8bL-KiWf88AyVZkJWnAJ+HBO7rE_74sOFzK=apQ@mail.gmail.com>
References: <CAP=Rh=OFdom8bL-KiWf88AyVZkJWnAJ+HBO7rE_74sOFzK=apQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 00:40:29 +0800
John <john.cs.hey@gmail.com> wrote:

> Root Cause Analysis:
> The root cause is unbounded recursion or excessive iteration in
> lock_acquire() initiated via perf tracepoints that fire during slab
> allocations and trace buffer updates. Specifically:
> tracing_gen_ctx_irq_test() is invoked while tracing kernel contexts
> (e.g., IRQ/softirq nesting).
> This tracepoint triggers perf_trace_lock_acquire() and further invokes
> lock_acquire() from lockdep.

tracing_gen_ctx_irq_test() is not a tracepoint. It's a simple routine to
find out how to fill the "common_flags" part of a trace event.

Here's the entire function:

unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
{
	unsigned int trace_flags = irqs_status;
	unsigned int pc;

	pc = preempt_count();

	if (pc & NMI_MASK)
		trace_flags |= TRACE_FLAG_NMI;
	if (pc & HARDIRQ_MASK)
		trace_flags |= TRACE_FLAG_HARDIRQ;
	if (in_serving_softirq())
		trace_flags |= TRACE_FLAG_SOFTIRQ;
	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
		trace_flags |= TRACE_FLAG_BH_OFF;

	if (tif_need_resched())
		trace_flags |= TRACE_FLAG_NEED_RESCHED;
	if (test_preempt_need_resched())
		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
}

The functions it calls are:

static __always_inline int preempt_count(void)
{
	return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
}

# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)

static __always_inline bool tif_need_resched(void)
{
	return tif_test_bit(TIF_NEED_RESCHED);
}

static __always_inline bool test_preempt_need_resched(void)
{
	return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
}

static unsigned short migration_disable_value(void)
{
#if defined(CONFIG_SMP)
	return current->migration_disabled;
#else
	return 0;
#endif
}

Nothing there should cause any recursion or issue. It's basically testing
various states and then returns a flags value.

It does not call lock_acquire().


> Inside lock_acquire(), the kernel attempts to inspect instruction
> addresses via __kernel_text_address(), which cascades into
> unwind_get_return_address() and stack_trace_save().
> However, these introspection functions are not expected to run in
> real-time-sensitive softirq context and they do not contain preemption
> or rescheduling points. With sufficient recursion or stress (e.g.,
> slab allocation with tracepoints and lockdep active), CPU#0 gets
> trapped and triggers the watchdog.
> 
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.
> 
> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.
> 

Looking at the backtrace you have:

kernel_text_address+0x35/0xc0 kernel/extable.c:94
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:369 [inline]
 unwind_get_return_address+0x59/0xa0 arch/x86/kernel/unwind_orc.c:364
 arch_stack_walk+0x9c/0xf0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x59/0x70 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]

KASAN is a very intrusive debugging utility that often causes soft lockups
and such when used with other debugging utilities.

If you can reproduce a softlockup without KASAN enabled, I'd then be more
worried about this. Usually when I trigger a softlockup and have KASAN
enabled, I just disable KASAN.

-- Steve
