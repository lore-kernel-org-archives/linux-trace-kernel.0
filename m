Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647010;
	b=t+X32YGAKBvkLOGwD4h0ulcRglk+/d0NnRICbOY7ByWhPLnx/fzdDKpiAybiJBUjBhok
	 vLnHBpQthKcxsnZGIK15Lif/AitJsgIkYQtj0mtC93y/DxNGLzJ6QUWR6kcujV1Asio4F
	 ge26D6gg2joQ8Gj9TXQroQRdxhoVE9x4jFQBSLR+UYGSmMk2esdUbJgmhfLNA6kZwJDkv
	 jHYB0G9D+z1VX6PKRBw/5hrP+bF/VzLmanbbMf6OD3oA2lzdV3yotyGrW5QvU2Es95VHC
	 /9VnB7VsaukyQv2j9FhhzZm+HlGK9NFBwlVUnyfjZs6lQkL8irW9PeilXWQ/SH10a9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q4/bQKHayLNmlb/IKtRwFFm/FEB26sdUihmdPCs5Tsc=;
	b=kyRc6H9ULR9JzqodxzmupYTwNlp4bQTeISlC7wXyNWLeGlJ75GxDjJVME2BEmtrdfSwb
	 fKYUakUCpPOaYDE1aZ9edh6mUxrbwfuIu0MfaAuHExvmKoc304Uj0mXNCvDak3QuVIW1e
	 R1u9PnRgd9LVDhS3N9ludR4Q6MxKX9v4yHR2rDBLbbE9cQPfRJNncCyToGTQB9TE1Oe8I
	 yIjEjkXOo8Bx8zz82oBTBVQ0xvffCxc9ROW8a9mP8HrOLgEgkepms+o834uw2aWcqYUbp
	 AbWC1j3XKxTzA/OS4+kTuRxzXKVSHTML1S18Cz0gG1aUeg/Id/l/tglALyaXxduOWpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUBjcYR4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834C606A31B;
	Thu, 22 Oct 2026 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUBjcYR4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A097C1F000C1;
	Thu, 22 Oct 2026 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647009;
	bh=Q4/bQKHayLNmlb/IKtRwFFm/FEB26sdUihmdPCs5Tsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUBjcYR4+a9dSpbOmXDeGK2gMU1HlHPzE/KbfNREvMPA0/oIv0kiTZvWqh/K0VIFW
	 Yex7xFP3NXkq71sCtRpQSoDitEYdtZpm2OuFahOjHdvHF+s4l8VUzklIKHZIPuveSx
	 bx1Jej1dpMeRXNDZ711VW+QXDOsXMjArXXG085NWbH7dGCtpiOjKssSdHGvDyraWBD
	 lXUaExOAQEpOFIy87TSAO3Q+pzbiu8kA2p9n3CZpHz6bve475/GxALnJ9cVZ6PnHbD
	 LQy6yZLmYbJjdwtEJHC/fHbA+oht+t3xBzNumkXFXINHQ2HW5bKnemUDWhlb9u/p3E
	 fLRWK2G2HLwlg==
Message-ID: <sashiko-outbox-181026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] rv: Add KUnit coverage for IRQ-exit scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022050712.75035-8-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <20261022050712.75035-8-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 05:30:09 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rv: leaked rq->nr_pinned on assertion abort in rv_test_irqexit_l=
ive()
--

commit 69d8a9063a6f40de41bbbc2fc85512c36f8a0acb
Author: Karl Mehltretter <kmehltretter@gmail.com>

rv: Add KUnit coverage for IRQ-exit scheduling

This commit adds KUnit test cases for the irqexit runtime verification
monitor, covering its state transitions, synchronization, and live
invocations of preempt_schedule_irq() including task switching and CPU
migration.

> diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c b/kernel/tr=
ace/rv/monitors/irqexit/irqexit_kunit.c
> new file mode 100644
> index 0000000000000..56a9442e2f704
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
[ ... ]
> +static void rv_test_irqexit_live(struct kunit *test)
> +{
> +	struct rv_monitor *mon =3D rv_irqexit_ops.mon.rv_this;
> +	struct rv_kunit_ctx *ctx =3D test->priv;
> +	struct irqexit_live_ctx *live =3D (void *)test->param_value;
> +	struct task_struct *worker;
> +	unsigned int entries, exits, switches_out, switches_in;
> +	unsigned int first_entries, first_switches;
> +	unsigned long flags;
> +	bool worker_done;
> +
> +	KUNIT_ASSERT_FALSE(test, mon->enabled);
> +	live->owner =3D current;
> +	get_task_struct(live->owner);
> +	init_completion(&live->worker_done);
> +
> +	active_ctx =3D ctx;
> +	mon->react =3D rv_kunit_mock_react;
> +	rv_mock_current(NULL);
> +	KUNIT_ASSERT_EQ(test, 0,
> +			kunit_add_action_or_reset(test, irqexit_live_cleanup, live));
> +	/* The worker must run on this CPU inside the explicit scheduling loop.=
 */
> +	guard(migrate)();
> +	worker =3D kthread_create(irqexit_live_worker, live, "rv-irqexit-test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
> +	live->worker =3D worker;
> +	kthread_bind(worker, smp_processor_id());
> +	sched_set_fifo(worker);
> +	KUNIT_ASSERT_EQ(test, 0,
> +			register_trace_event_irqexit(irqexit_observe_event, live));
> +	live->observer_attached =3D true;
> +	KUNIT_ASSERT_EQ(test, irqexit_observe_boundaries(live), 0);
> +
> +	mon->enabled =3D 1;
> +
> +	KUNIT_ASSERT_EQ(test, preempt_count(), 0);

[Severity: Medium]
Does this leak the per-CPU rq->nr_pinned counter if any of the KUNIT_ASSERT=
_*
checks inside the guard(migrate)() scope fail?

In kernel/trace/rv/monitors/irqexit/irqexit_kunit.c, rv_test_irqexit_live()
enters guard(migrate)(), which calls migrate_disable() -> __migrate_disable=
()
in include/linux/sched.h:

	this_rq_pinned()++;
	p->migration_disabled =3D 1;

If a subsequent assertion fails (such as KUNIT_ASSERT_NOT_ERR_OR_NULL() aft=
er
kthread_create(), or KUNIT_ASSERT_EQ() after register_trace_event_irqexit(),
irqexit_observe_boundaries(), or preempt_count()), KUnit aborts the test ca=
se
via __kunit_abort() -> kunit_try_catch_throw() in lib/kunit/try-catch.c:

void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
{
	try_catch->try_result =3D -EFAULT;
	kthread_exit(0);
}

Because kthread_exit(0) terminates the KUnit runner kthread directly via
do_exit(0) without unwinding the C stack, the scope cleanup destructor for
guard(migrate)() (__migrate_enable()) never runs. Neither kthread_exit() nor
do_exit() decrements this_rq_pinned(), leaving rq->nr_pinned permanently
elevated on that CPU and causing any later CPU hotplug offline operation to
hang in balance_hotplug_wait() waiting for !rq_has_pinned_tasks(rq).

Could migration disabling be narrowed with scoped_guard(migrate) or explicit
migrate_disable() / migrate_enable() around the non-asserting section, or
cleaned up via a KUnit action when current->migration_disabled is set?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022050712.7503=
5-1-kmehltretter@gmail.com?part=3D7
