Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647221;
	b=gt+3IW67oPywS4oMN5RhACWo6/DHlKMVOZO9GNu91ciQczOy/zoDNRiZ3Kih9MFgRQKT
	 KL81LmmFx3kDZPbZBgkAiW4m2IpAajktBjEN1uQddU8AXQj15GJxBzsypHG3lhruf2Brz
	 pF3HU0HGMPP0BwdV5uj+3GyV3L9fG6awcQKbm7Z7eRRG2ZzzcL4F47wvNPgpEypNlLs8R
	 4bIMdGKpG9E//xHidyd8mzQCzDM07Pr5JORQmysNu1ayLfJkFGpJfwcs3ylNriA/biRxA
	 pgo87cJfxrN+ML0MIHotZLNZJRApIO0pfk9otAplRbfFW19HncrGQvejsQe5jP3BZmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JQFZ/MiV3ZcZfkYiA/xuZEezD1IBVGLGNq4NiARPB90=;
	b=fzeZFqzsFmabfwNFClv2KwSb5tbUd+0Jo9iExxu38NNuavnUvc9Nwr6tySpZAqlYox1z
	 ljBmG2/6FuSJG0b3kYsCOZOJQHLsEoP1kzOwJXAD6RHIgOnImsuq5i1MGgpb2jQ+wM/BN
	 257vSp9B49ECLREQB63Y4DXCVkej1CzoiJ/cXYthanbyJR7XHJwb1CbMz2sptZcrMm2gy
	 nlBUMJ8UxH7EOY7NDwaGx8w1sIqSyBNW7KU3pwKlSNNSra3uZOkgWVgdRJT0SYahZNL+I
	 0/agwx4wN/zcTwVECboBshPPHyiq/OCYrlIRtgEq4Mo9klEHyQjUOf/jcnTppqkZMNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrJYA2z8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8572606A319;
	Thu, 22 Oct 2026 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrJYA2z8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296E1F000C1;
	Thu, 22 Oct 2026 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647220;
	bh=JQFZ/MiV3ZcZfkYiA/xuZEezD1IBVGLGNq4NiARPB90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrJYA2z8lo2Fmz/QPcQYrZB300ogLvBckCiFb1N8k2NEpdHz6IbMi5+jMB8bwxGbK
	 e6PnzWQmzV1q/wyKe5ElHpr5A7WPKx6ugrDyjC0hvjNOdKCRpbHy0vyWjrFoQS9SQ0
	 dprwEmbVMbQjAlYlL1LXODxzeqvjoPZv66BuhVnp/0e9iORYaim9uGiwMqUYbhYqX9
	 mst4OZHV73gh1KfGISdRekKzlIyIEpbwAiFlONYxaposwobD4+Tixtwj50yLqCti3O
	 5cxIHyDgySf5yhQ5ciq+mN6t330zZZ5k3uIPrVJ9F7BfkyFAL1G8SSt5PnSZYkKiu0
	 pglfUeUl787uA==
Message-ID: <sashiko-outbox-181033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] rv: Test IRQ-exit softirq provenance and
 handoff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022050712.75035-10-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <20261022050712.75035-10-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 05:33:39 +0000
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
- [High] rv: rq->nr_pinned leak on kunit_skip() under guard(migrate)() in i=
rqstate tests
- [Medium] rv: broken nested IRQ filter in irqstate_inline_hardirq_entry() =
and exit
- [Medium] rv: missing local_bh_blocked() check and early wait in hardirq e=
xit tests
--

commit 7fb79c597a519150ad675f18bceb7d2417080c8b
Author: Karl Mehltretter <kmehltretter@gmail.com>

rv: Test IRQ-exit softirq provenance and handoff

This commit extends the irqstate KUnit test suite to cover inline softirq
processing during hardirq exit, hardirq provenance tracking, and monitor
synchronization. It also adds tests verifying late work handoff to ksoftirqd
and ktimerd at the softirq and hardirq exit boundaries.

> diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/=
trace/rv/monitors/irqstate/irqstate_kunit.c
> index e3928d10b2825..31e827cdba1c6 100644
> --- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
> +++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
[ ... ]
> @@ -893,6 +984,39 @@ static bool irqstate_empty_worker_matches(struct irq=
state_empty_worker_ctx *empt
>  	return !empty_ctx->real_worker || softirq_kunit_empty_worker_active();
>  }
> =20
> +static void irqstate_inline_hardirq_entry(void *data, unsigned int depth)
> +{
> +	struct irqstate_inline_bh_ctx *inline_ctx =3D data;
> +
> +	/* Inline softirq processing enables IRQs; ignore a nested real IRQ. */
> +	if (!READ_ONCE(inline_ctx->armed) || current !=3D inline_ctx->owner ||
> +	    depth !=3D 1)
> +		return;
> +	inline_ctx->hardirq_entries++;
> +	if (inline_ctx->event_index !=3D 0)
> +		inline_ctx->bad_order =3D true;
> +	inline_ctx->event_index++;
> +	if (hardirq_count() !=3D HARDIRQ_OFFSET || in_serving_softirq() ||
> +	    !irqs_disabled())
> +		inline_ctx->bad_boundary_context =3D true;
> +}
> +
> +static void irqstate_inline_hardirq_exit(void *data, unsigned int depth)
> +{
> +	struct irqstate_inline_bh_ctx *inline_ctx =3D data;
> +
> +	if (!READ_ONCE(inline_ctx->armed) || current !=3D inline_ctx->owner ||
> +	    depth !=3D 1)
> +		return;
> +	inline_ctx->hardirq_exits++;
> +	if (inline_ctx->event_index !=3D 3)
> +		inline_ctx->bad_order =3D true;
> +	inline_ctx->event_index++;
> +	if (hardirq_count() !=3D HARDIRQ_OFFSET || in_serving_softirq() ||
> +	    !irqs_disabled())
> +		inline_ctx->bad_boundary_context =3D true;
> +}

[Severity: Medium]
Will checking depth !=3D 1 in irqstate_inline_hardirq_entry() and
irqstate_inline_hardirq_exit() actually filter out a real hardware interrupt
that arrives while inline softirq processing runs with interrupts enabled?

In the rv_test_irqstate_irq_exit_inline() -> irq_exit_rcu() ->
__do_softirq() -> handle_softirqs() path, softirq_handle_begin() replaces
HARDIRQ_OFFSET with SOFTIRQ_OFFSET before local_irq_enable() enables
interrupts:

kernel/softirq.c:softirq_handle_begin() {
	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
	lockdep_softirqs_off(_RET_IP_);
	WARN_ON_ONCE(irq_count() !=3D SOFTIRQ_OFFSET);
}

Because HARDIRQ_OFFSET has been cleared, a real hardware interrupt arriving
during the IRQ-enabled softirq window enters irq_enter_rcu() with
hardirq_count() equal to HARDIRQ_OFFSET (so depth is 1, while
in_serving_softirq() is non-zero), and exits irq_exit_rcu() with depth equal
to 1 as well.

As a result, depth !=3D 1 is false for that interrupt in both
irqstate_inline_hardirq_entry() and irqstate_inline_hardirq_exit(), causing
both probes to increment hardirq_entries, hardirq_exits, and event_index and
to set bad_order and bad_boundary_context. Should both callbacks also ignore
events when in_serving_softirq() is true?

[ ... ]
> +/* Work first raised at the final hardirq boundary must reach ksoftirqd.=
 */
> +static void rv_test_irqstate_hardirq_exit_handoff(struct kunit *test)
> +{
> +	struct irqstate_hardirq_exit_ctx *exit_ctx;
> +	struct rv_kunit_ctx *ctx =3D test->priv;
> +	unsigned long flags;
> +	int ret;
> +
> +	prepare_test(test, &rv_irqstate_ops.mon);
> +	guard(migrate)();
> +	exit_ctx =3D kunit_kzalloc(test, sizeof(*exit_ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, exit_ctx);
> +	tasklet_setup(&exit_ctx->tasklet, irqstate_hardirq_exit_tasklet);
> +	exit_ctx->owner =3D current;
> +	exit_ctx->owner_cpu =3D raw_smp_processor_id();
> +	exit_ctx->softirqd =3D this_cpu_ksoftirqd();
> +	KUNIT_ASSERT_NOT_NULL(test, exit_ctx->softirqd);
> +	if (local_softirq_pending() ||
> +	    !wait_task_inactive(exit_ctx->softirqd, TASK_INTERRUPTIBLE)) {
> +		kunit_skip(test, "Requires an idle local ksoftirqd");
> +		return;
> +	}

[Severity: High]
Does calling kunit_skip() or failing a KUNIT_ASSERT_*() while guard(migrate=
)()
is active leak the per-CPU rq->nr_pinned counter?

guard(migrate)() calls migrate_disable(), which increments rq->nr_pinned
(this_rq_pinned()) and relies on the C cleanup attribute to invoke
migrate_enable() at scope exit. However, kunit_skip() and failing
KUNIT_ASSERT_*() macros call kunit_try_catch_throw():

lib/kunit/try-catch.c:kunit_try_catch_throw() {
	try_catch->try_result =3D -EFAULT;
	kthread_exit(0);
}

Because kunit_try_catch_throw() is noreturn and exits the KUnit runner
kthread directly via kthread_exit(0) -> do_exit(0) without unwinding C stack
frames, the guard(migrate)() cleanup never runs and do_exit() does not call
migrate_enable(). That leaves rq->nr_pinned permanently elevated on the CPU,
which makes rq_has_pinned_tasks(rq) stay true and causes subsequent CPU
hotplug offline operations to hang in balance_hotplug_wait().

The same pattern occurs in rv_test_irqstate_hardirq_exit_timer_handoff()
below, and when force_irqthreads() is enabled on a !CONFIG_PREEMPT_RT kernel
to run rv_test_irqstate_hardirq_exit_timer_handoff(), the following test
rv_test_irqstate_irq_exit_inline() diverts its softirq to ksoftirqd
(ran_inline is false) and deterministically hits kunit_skip() under
guard(migrate)().

> +
> +	ret =3D register_trace_hardirq_context_exit(
> +		irqstate_hardirq_exit_raise, exit_ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	exit_ctx->attached =3D true;
> +	KUNIT_ASSERT_EQ(test, 0,
> +			kunit_add_action_or_reset(test,
> +						  irqstate_hardirq_exit_cleanup,
> +						  exit_ctx));
> +	attach_irqstate_test_probes();
> +	KUNIT_ASSERT_EQ(test, 0,
> +			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
> +						  NULL));
> +
> +	local_irq_save(flags);
> +	if (local_softirq_pending() || task_is_running(exit_ctx->softirqd)) {
> +		local_irq_restore(flags);
> +		kunit_skip(test, "Local ksoftirqd stopped being idle");
> +		return;
> +	}

[Severity: Medium]
Could rv_test_irqstate_hardirq_exit_handoff() and
rv_test_irqstate_hardirq_exit_timer_handoff() fail or spuriously skip due to
missing a local_bh_blocked() check on CONFIG_PREEMPT_RT and waiting for
worker inactivity before registering tracepoints?

In __irq_exit_rcu(), waking ksoftirqd for softirq work raised during
trace_hardirq_context_exit() is gated on should_wake_ksoftirqd():

kernel/softirq.c:__irq_exit_rcu() {
	if (irq_count() =3D=3D HARDIRQ_OFFSET &&
	    unlikely(local_softirq_pending()) &&
	    should_wake_ksoftirqd()) {
		wakeup_softirqd();
		ksoftirqd_wake_requested =3D true;
	}
}

On CONFIG_PREEMPT_RT, should_wake_ksoftirqd() checks
!this_cpu_read(softirq_ctrl.cnt) (!local_bh_blocked()). Because BH-disabled
sections on PREEMPT_RT are preemptible and can block on RT locks
(TASK_RTLOCK_WAIT), another task on the local CPU (or ksoftirqd itself after
clearing local_softirq_pending() and blocking in TASK_RTLOCK_WAIT, where
task_is_running() is false) can hold softirq_ctrl.cnt non-zero while
local_softirq_pending() is 0 and task_is_running(softirqd) is false. In that
case __irq_exit_rcu() skips wakeup_softirqd() and the assertion on
softirqd_already_runnable fails.

Additionally, unlike rv_test_irqstate_irq_exit_inline(), both handoff tests
call wait_task_inactive() before register_trace_hardirq_context_exit(),
register_trace_sched_waking(), and attach_irqstate_test_probes(), which can
sleep on mutexes and queue RCU work that wakes ksoftirqd or ktimerd after t=
he
wait has already finished. Would it be better to attach the probes before
waiting for the workers to go inactive, and also check local_bh_blocked()?

> +	WRITE_ONCE(exit_ctx->armed, true);
> +	irq_enter_rcu();
> +	irq_exit_rcu();
> +	exit_ctx->tasklet_pending =3D
> +		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
> +	exit_ctx->softirqd_already_runnable =3D
> +		!wake_up_process(exit_ctx->softirqd);
> +	WRITE_ONCE(exit_ctx->armed, false);
> +	local_irq_restore(flags);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022050712.7503=
5-1-kmehltretter@gmail.com?part=3D9
