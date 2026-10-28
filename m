Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793159684;
	b=Ipe5hgn/W7dPe7uoIsinbpsQwm//bZT3eoBpBZ+agcVJNXqwzdCaHS7E5F1Fnj2JFslV
	 n/du2vBLy196Xwj2r8XomP4VO7uF1BboQg61+/CsfTeg4IfnyeiqumVOUJ8m948AhRAN8
	 Gt9+1rW/J6v++eXwaFQp6FzmBNIwkw1q60MVqFkmaEik0CPomRbsbqt58BTVLrHxh75P+
	 IcqU/xpwNiQZEJTSIsElZ5HpckcDWbSLypfkIqdugJp5S69UXoL5XHDhWjXZ5UdYxq7R1
	 80s6aqw3R/en4SuPu4ULmQNDtiacQNtefn3bDeyelBqFYSGKllf51QW5m7r+/ErvItQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u1fT2br2PPhfyT44RccE953APTZQz2VKbIORqtZHQ4A=;
	b=Rt4roEzGjx3GR1jPZd0VSgsugVqsyW7E53tPpfbtGmTGF7eS+VCjWZsz78U0HFeSsfXV
	 FBcb6RTFSWvC7/nPIhsxjaPpRlG9D/TsLGC4UIt2J8MoFg+kNvUU/9WgXY+RxXZma7Ow1
	 VxJk+Zpp/xmY56BjORESy3s8h9ENSCI33pU/H9hu7iGp4Y3ahJ5fbCz94UHiaHN/z5lN/
	 lpHB4EnhPOOCh59i5Nnx+90aWoW1rc6ASLpsbD9cOHH9XShnAfIcg4nPKDb279MUkIPd8
	 Py3g2jeGX/8dIyNUAfeD3uzL39TcYjCzj2KNPFlNgXJ5afXKPn4LpPVNOvthulYEsQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cq/P3r6L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF51606A31D;
	Wed, 28 Oct 2026 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cq/P3r6L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5C1F01825;
	Wed, 28 Oct 2026 03:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793159683;
	bh=u1fT2br2PPhfyT44RccE953APTZQz2VKbIORqtZHQ4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cq/P3r6L6omdLhoSp4fZVTCQ0wkyXXn1xEzYaH+WDjFbyDo5eGCzox/hjTqRVGVYX
	 0HWzCpZeTwTZtlPEPsxQb0OI1gnU4o2mnB8+KLs8tgYeHVJK/P+fHIlQq4/614XqPJ
	 SIUaewyGD3ibU6F4fRCxU1ODOHmzDVIhTaoC+OlrWJiVjAhfCMEnMMweuQkUN3C9le
	 qaJ+m89ktZ2R/7B5vWqzXvy7Ckx97u/+hn7fvyNOTmdshv8CVuSGHjfZr2Bzl1CIdO
	 2WNOPKnvKiTVbJFC2skgCDpA280fvaav5S9g7vXAIckrO8ULATsDTCVOmei2hF8OQm
	 aXCMlhnCSvqTw==
Message-ID: <sashiko-outbox-187453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/13] entry: Add the pre-counted
 ordinary-hardirq entry/exit contract
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261028033127.82193-6-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-6-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:54:42 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] entry: irqentry_hardirq_enter() breaks preemptirqsoff critical t=
iming start
- [Medium] softirq: invoke_softirq() drops ksoftirqd wake flag after inline=
 handoff
--

commit 50eb58fd97f0b74442817ebd3d3092c57116862f
Author: Karl Mehltretter <kmehltretter@gmail.com>

entry: Add the pre-counted ordinary-hardirq entry/exit contract

This commit adds staged hardirq entry and retained exit helpers so that
ordinary hardirqs can install HARDIRQ_OFFSET and lockdep hardirq state
before entry tracing, and keep them installed until all traceable exit
callbacks have completed.

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 2f5229132466c..9d207c37c5707 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
>  #include <linux/futex.h>
> +#include <linux/hardirq.h>
>  #include <linux/highmem.h>
>  #include <linux/irq-entry-common.h>
>  #include <linux/jump_label.h>
> @@ -120,6 +121,42 @@ noinstr irqentry_state_t irqentry_enter(struct pt_re=
gs *regs)
>  	return irqentry_enter_from_kernel_mode(regs);
>  }
> =20
> +/**
> + * irqentry_hardirq_enter - Establish state for ordinary hardirq entry
> + * @regs: Pointer to the interrupted register state
> + *
> + * Attempt a staged raw hardirq-count addition before anything instrumen=
table
> + * can run and record whether it was applied. Then establish IRQ-disable=
d and
> + * hardirq lockdep state before context tracking or irqflag tracing can =
invoke
> + * callbacks. The caller must have distinguished an ordinary hardirq from
> + * NMI-like entry and must finish the staged attempt with
> + * irq_enter_rcu_preempt_counted().
> + *
> + * Returns: An opaque object for the matching irqentry exit operation.
> + */
> +noinstr irqentry_state_t irqentry_hardirq_enter(struct pt_regs *regs)
> +{
> +	struct irqentry_hardirq_cookie cookie;
> +	irqentry_state_t ret;
> +
> +	cookie =3D irqentry_hardirq_count_start();
> +
> +	if (user_mode(regs)) {
> +		ret =3D (irqentry_state_t) {
> +			.exit_rcu =3D false,
> +		};
> +		irqentry_hardirq_count_state_set(&ret, cookie);
> +
> +		__enter_from_user_mode(regs, true);
> +		rseq_note_user_irq_entry();
> +		return ret;
> +	}
> +
> +	ret =3D __irqentry_enter_from_kernel_mode(regs, true);
> +	irqentry_hardirq_count_state_set(&ret, cookie);
> +	return ret;
> +}

[Severity: Medium]
Does staging HARDIRQ_OFFSET in irqentry_hardirq_enter() before calling
__enter_from_user_mode() or __irqentry_enter_from_kernel_mode() prevent the
preemptirqsoff latency tracer from starting critical timing when an ordinary
hardirq interrupts user mode or preemptible kernel mode?

When trace_type has both TRACER_IRQS_OFF and TRACER_PREEMPT_OFF enabled and
an interrupt arrives while preempt_count() is 0:

1. irqentry_hardirq_enter() calls irqentry_hardirq_count_start(), which adds
HARDIRQ_OFFSET to preempt_count() while hardware interrupts are disabled.

2. __enter_from_user_mode() or __irqentry_enter_from_kernel_mode() then cal=
ls
trace_hardirqs_off_finish() -> tracer_hardirqs_off():

kernel/trace/trace_irqsoff.c:tracer_hardirqs_off() {
	if (!preempt_trace(preempt_count()) && irq_trace())
		start_critical_timing(a0, a1);
}

Because HARDIRQ_OFFSET is already present in preempt_count(),
preempt_trace(preempt_count()) evaluates to true, so tracer_hardirqs_off()
assumes preemption was already disabled before IRQs were turned off and ski=
ps
start_critical_timing().

3. Later, irq_enter_rcu_preempt_counted() calls
irqentry_hardirq_count_finish() -> preempt_latency_start(HARDIRQ_OFFSET) ->
trace_preempt_off() -> tracer_preempt_off():

kernel/trace/trace_irqsoff.c:tracer_preempt_off() {
	if (preempt_trace(preempt_count()) && !irq_trace())
		start_critical_timing(a0, a1);
}

Because hardware interrupts are disabled, irq_trace() evaluates to true, so
tracer_preempt_off() assumes tracer_hardirqs_off() already started critical
timing and also skips start_critical_timing().

As a result, neither callback starts critical timing for the hardirq and any
subsequent softirq exit processing.

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 7fc2200392cdf..169c559832501 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c

[ ... ]

> @@ -525,12 +529,12 @@ static inline void ksoftirqd_run_end(void)
>  	local_irq_enable();
>  }
> =20
> -static inline bool should_wake_ksoftirqd(void)
> +static __always_inline bool should_wake_ksoftirqd(void)
>  {
>  	return true;
>  }
> =20
> -static inline void invoke_softirq(void)
> +static inline bool invoke_softirq(void)
>  {
>  	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
>  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> @@ -548,9 +552,11 @@ static inline void invoke_softirq(void)
>  		 */
>  		do_softirq_own_stack();
>  #endif
> -	} else {
> -		wakeup_softirqd();
> +		return false;
>  	}
> +
> +	wakeup_softirqd();
> +	return true;
>  }

[Severity: Medium]
When invoke_softirq() runs __do_softirq() or do_softirq_own_stack() on
!CONFIG_PREEMPT_RT, can returning false unconditionally cause
irq_exit_wake_late_softirqs() to repeat a wakeup_softirqd() call that was
already performed by handle_softirqs()?

Inside handle_softirqs(), if softirqs are re-raised during inline draining
and the loop stops because need_resched() is set, the time limit is reached,
or max_restart is exhausted, handle_softirqs() wakes ksoftirqd itself while
leaving the remaining bits set in local_softirq_pending():

kernel/softirq.c:handle_softirqs() {
	...
	pending =3D local_softirq_pending();
	if (pending) {
		if (time_before(jiffies, end) && !need_resched() &&
		    --max_restart)
			goto restart;

		wakeup_softirqd();
	}
	...
}

Because invoke_softirq() still returns false after __do_softirq() or
do_softirq_own_stack(), __irq_exit_rcu() does not set
IRQ_EXIT_WAKE_KSOFTIRQD in wake_flags.

When irq_exit_rcu_preempt_counted_prepare() then runs:

	wake_flags =3D __irq_exit_rcu(true);
	do_sub =3D irqentry_hardirq_exit_prepare(cookie);
	irq_exit_wake_late_softirqs(wake_flags);

irq_exit_wake_late_softirqs() sees ksoftirqd_wake_requested as false while
local_softirq_pending() is still non-zero from the earlier handoff, causing
irq_exit_wake_ksoftirqd() to call wakeup_softirqd() a second time after
irqentry_hardirq_exit_prepare() has already emitted trace_preempt_on().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028033127.8219=
3-1-kmehltretter@gmail.com?part=3D5
