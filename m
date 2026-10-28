Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793159861;
	b=f1XqszroFqT8U7ByHzmKeYMW7nwXwEEalP7RjNx0qE3HQfwI75DYOVvSeSZoSAXK+V4/
	 2TVBKZvF+f+eJM133JyFnhQNHO/2f/Rm+Q5hgK4o5BgYL/a5doiu4RNQ8t5VSwf3ADS20
	 WzPpnT4c3NvTboZqPmgmSKH5jP7lI1TNIpE4qTuejHSQb3SD6xrAerFn3QcCkVOQiotjy
	 0A2bW3mqDAxchRC+q5WnoFj2//GmmwTKxecysDsS4O703KiGnrkBk2m1jV5RsB/UPqok8
	 DSB40cp5oq8Ql/rqTJ1N14w1o0qBQgycf1weQwFvdB3d5J2ZaX0bHjwDjvovM4QDqlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LdDS6KYDzJ/oVKmzl6A3jbAlVTd7hn4RSeZTrpSGhHg=;
	b=ws3NiYllQ8jkLc0YJ3BZY3sC08hlkH1V+IHbDrIzXTJ5qLn2ekEo6xEs+pr+7YreCnTc
	 zNzYUFTQ8zA4XfSZOXr+7bUdXzpBSY9PKPpyemUYzEM1snt/Nyr6yMQc9DYpdQDTZdPgd
	 SJiPH57VhqI+VMOV1ixN3nTDR4DZAD61vvWTViG5fqBkhlnULnJVlmr40x7gecTFBFvNn
	 DEAko2hiZ9tVEPJOZYSIrNztxmX592dPDai8kj6bRW2+0rE0nzGMTuqcsD41E0N0T/Lgj
	 Ikrf7ux/SKp/V5gXjOaMeZuG5pYA1SuG+Ngn2uzBdVV2Lhx62gL+yYP0n5rb9de5sjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gpgg/EGp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B7606A31A;
	Wed, 28 Oct 2026 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpgg/EGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653A1F01825;
	Wed, 28 Oct 2026 03:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793159860;
	bh=LdDS6KYDzJ/oVKmzl6A3jbAlVTd7hn4RSeZTrpSGhHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gpgg/EGpmMB723mqPbY7OOOD1P6n3seyd1glrnnLY6rthjzqY1DgUgusvwQAjciPF
	 ta8jtdzZOpVqswtk2X6LHHe1tvBt4jFO3232KrP6zKEjcz3cYkfD28BAv6QfINDs4V
	 Imjit55qhCaOmZfWBHawCdBqjJairX0nN5q3v5AG8r0UcfebOzqg4PxA93Z8H947Pq
	 P2ctZNafyDrElhLE8jzkFMm4LBwllgzFiWIbPY41LzlkkB37uXMsHWJBkhuktWuDdt
	 EvclwypcDjrUVOnyTJ6sx/QEKKee683CNuQInHDiIB5raIXqgTeJEydjGKGm9Adwqa
	 5ady9t6KH4VxA==
Message-ID: <sashiko-outbox-187457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/13] entry: Classify ordinary hardirq
 return-tail work as hardirq context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261028033127.82193-11-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-11-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:57:39 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] entry: irqentry_exit_to_kernel_mode_after_preempt() breaks preempt=
irqsoff
- [Medium] softirq: irqentry_hardirq_tail_exit() repeats wakeups with wake_=
flags =3D 0
- [Medium] entry: irqentry_hardirq_tail_exit() wakes softirq threads after =
preempt check
--

commit d2af631b0f352ba4a12e0eb8fa80f5ff66476c74
Author: Karl Mehltretter <kmehltretter@gmail.com>

entry: Classify ordinary hardirq return-tail work as hardirq context

This commit stages a fresh hardirq-count attempt and restores lockdep
classification across traceable return-tail work on return from ordinary
hardirqs. It adds irqentry_hardirq_tail_enter() and
irqentry_hardirq_tail_exit() around the post-preemption return tail so
return-tail callbacks run as hardirq context.

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-c=
ommon.h
> index 6f649f6613312..f51aafc1b49fd 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -383,6 +383,32 @@ irqentry_hardirq_count_state_set(irqentry_state_t *s=
tate,
>  		IRQENTRY_HARDIRQ_APPLIED : IRQENTRY_HARDIRQ_REJECTED;
>  }
> =20
> +/**
> + * irqentry_hardirq_tail_enter - Stage ordinary-hardirq return-tail state
> + * @state: Pointer to state returned by the matching irqentry_hardirq_en=
ter()
> + *
> + * Make a fresh staged hardirq-count attempt and establish the lockdep
> + * classification which traceable return-tail work needs. Accounting, RC=
U and
> + * tick handling belong to the completed interrupt and must not be repea=
ted
> + * here.
> + */
> +static __always_inline void
> +irqentry_hardirq_tail_enter(irqentry_state_t *state)
> +{
> +	struct irqentry_hardirq_cookie cookie;
> +
> +	if (!state->hardirq)
> +		return;
> +
> +	cookie =3D irqentry_hardirq_count_start();
> +	lockdep_hardirq_enter();
> +
> +	instrumentation_begin();
> +	irqentry_hardirq_count_finish(cookie);
> +	instrumentation_end();
> +	irqentry_hardirq_count_state_set(state, cookie);
> +}

[ ... ]

> @@ -543,6 +574,31 @@ static __always_inline void irqentry_hrtimer_rearm_d=
eferred(void)
>  static __always_inline void
>  irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentr=
y_state_t state)
>  {
> +	struct ct_irq_exit_state ct_state =3D { };
> +
> +	if (state.hardirq) {
> +		if (!regs_irqs_disabled(regs)) {
> +			instrumentation_begin();
> +			hrtimer_rearm_deferred();
> +			/* Tell the tracer that the return will enable IRQs. */
> +			trace_hardirqs_on_prepare();
> +			lockdep_hardirqs_on_prepare_irqtail();
> +			instrumentation_end();
> +		}
> +
> +		if (state.exit_rcu)
> +			ct_state =3D ct_irq_exit_prepare();
> +
> +		irqentry_hardirq_tail_exit(irqentry_hardirq_count_state(state));

[Severity: High]
Does ordering trace_hardirqs_on_prepare() before irqentry_hardirq_tail_exit=
()
cause a regression for the preemptirqsoff tracer when returning to
preemptible, IRQ-enabled kernel mode?

In irqentry_exit_to_kernel_mode(), irqentry_hardirq_tail_enter() stages
HARDIRQ_OFFSET in preempt_count() and calls:

irqentry_hardirq_count_finish()
  preempt_latency_start(HARDIRQ_OFFSET)
    trace_preempt_off()

Next, when !regs_irqs_disabled(regs),
irqentry_exit_to_kernel_mode_after_preempt() calls trace_hardirqs_on_prepar=
e()
while HARDIRQ_OFFSET is still set in preempt_count(). In
kernel/trace/trace_irqsoff.c:

void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
{
	if (!preempt_trace(preempt_count()) && irq_trace())
		stop_critical_timing(a0, a1);
}

When the preemptirqsoff tracer is active (both CONFIG_IRQSOFF_TRACER and
CONFIG_PREEMPT_TRACER enabled, so trace_type has both TRACER_IRQS_OFF and
TRACER_PREEMPT_OFF), preempt_trace(preempt_count()) evaluates to true becau=
se
preempt_count() contains HARDIRQ_OFFSET. As a result, tracer_hardirqs_on()
skips stop_critical_timing(), while trace_hardirqs_on_prepare() still clears
tracing_irq_cpu.

Immediately after that, irqentry_hardirq_tail_exit() calls:

irqentry_hardirq_exit_prepare()
  irqentry_hardirq_count_sub_prepare()
    preempt_latency_stop(HARDIRQ_OFFSET)
      trace_preempt_on()
        tracer_preempt_on()

In kernel/trace/trace_irqsoff.c:

void tracer_preempt_on(unsigned long a0, unsigned long a1)
{
	if (preempt_trace(preempt_count()) && !irq_trace())
		stop_critical_timing(a0, a1);
}

Because hardware interrupts remain disabled at the CPU until the exception
return instruction, irqs_disabled() is still true, so irq_trace() evaluates=
 to
true and tracer_preempt_on() also skips stop_critical_timing().

Finally, irqentry_hardirq_exit_finish() removes HARDIRQ_OFFSET via
__preempt_count_sub(HARDIRQ_OFFSET). Won't this leave per_cpu(tracing_cpu, =
cpu)
stuck active after returning to preemptible, IRQ-enabled kernel execution, =
as
well as emitting extra preempt_disable, irq_enable, and preempt_enable trace
events in inverted order?

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 169c559832501..85b167db37c29 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -837,6 +837,27 @@ irq_exit_wake_late_softirqs(unsigned int wake_flags)
>  		irq_exit_wake_ksoftirqd();
>  }
> =20
> +/**
> + * irqentry_hardirq_tail_exit - Close work and remove return-tail state
> + * @cookie: Staged hardirq-count cookie from irqentry_hardirq_tail_enter=
()
> + *
> + * Run every instrumentable teardown operation, including the final work=
er
> + * closure, before conditionally removing any applied raw hardirq count =
and
> + * ending lockdep nesting.
> + */
> +void noinstr
> +irqentry_hardirq_tail_exit(struct irqentry_hardirq_cookie cookie)
> +{
> +	bool do_sub;
> +
> +	instrumentation_begin();
> +	do_sub =3D irqentry_hardirq_exit_prepare(cookie);
> +	irq_exit_wake_late_softirqs(0);
> +	instrumentation_end();
> +
> +	irqentry_hardirq_exit_finish(do_sub);
> +}

[Severity: Medium]
Can passing a hardcoded 0 to irq_exit_wake_late_softirqs(0) in
irqentry_hardirq_tail_exit() cause redundant wake_up_process() calls for
ksoftirqd and ktimerd?

During the earlier main hardirq exit in irq_exit_rcu_preempt_counted_prepar=
e(),
__irq_exit_rcu(true) records IRQ_EXIT_WAKE_KSOFTIRQD and IRQ_EXIT_WAKE_KTIM=
ERD
in wake_flags so irq_exit_wake_late_softirqs(wake_flags) avoids waking those
threads a second time. However, local_softirq_pending() or
local_timers_pending_force_th() remains non-zero until the woken thread
actually runs on the CPU and clears the pending bits.

If irqentry_exit_to_kernel_mode_preempt() does not switch to the worker thr=
ead
(for example, on any interrupt from an RCU-idle context where state.exit_rc=
u is
true, when the interrupted kernel context has preemption disabled, when
regs_irqs_disabled(regs) is true, or when current has higher priority),
irqentry_hardirq_tail_exit() runs with those pending bits still set:

irq_exit_wake_late_softirqs(0)
  if (!ksoftirqd_wake_requested)
      ksoftirqd_wake_requested =3D irq_exit_wake_ksoftirqd();
  if (!ktimerd_wake_requested)
      ktimerd_wake_requested =3D irq_exit_wake_timersd();

Because wake_flags is 0, won't this call wakeup_softirqd() or wake_timersd()
a second time even when no return-tail callback raised new work, and do so
after trace_hardirqs_on_prepare(), ct_irq_exit_prepare(), and
irqentry_hardirq_exit_prepare() have already completed?

[Severity: Medium]
What happens if a return-tail callback raises softirq or forced-thread timer
work while returning to a preemptible kernel context?

In irqentry_exit_to_kernel_mode():

	instrumentation_begin();
	irqentry_exit_to_kernel_mode_preempt(regs, state);
	instrumentation_end();

	irqentry_hardirq_tail_enter(&state);
	irqentry_exit_to_kernel_mode_after_preempt(regs, state);

the preemption check in irqentry_exit_to_kernel_mode_preempt() runs before =
the
hardirq return tail is entered.

If a callback inside the return tail (such as during hrtimer_rearm_deferred=
(),
trace_hardirqs_on_prepare(), lockdep_hardirqs_on_prepare_irqtail(), or
irqentry_hardirq_exit_prepare()) raises softirq or timer work,
irq_exit_wake_late_softirqs(0) in irqentry_hardirq_tail_exit() wakes ksofti=
rqd
or ktimerd while HARDIRQ_OFFSET is still set in preempt_count(), setting
need_resched() on current. Immediately afterwards,
irqentry_hardirq_exit_finish() drops HARDIRQ_OFFSET via
__preempt_count_sub(HARDIRQ_OFFSET) without checking for rescheduling.

Could this return to a preemptible kernel task with need_resched() set and
miss preempting for the newly woken worker thread (including a higher-prior=
ity
SCHED_FIFO ktimerd/ksoftirqd under PREEMPT_RT or force_irqthreads)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028033127.8219=
3-1-kmehltretter@gmail.com?part=3D10
