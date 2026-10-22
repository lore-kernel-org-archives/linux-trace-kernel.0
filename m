Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647198;
	b=IidxbtNK5OGBREw+qhCXq/kFKB9w91xf2vpzNLJtBYK8jN3D+tMhsQcCZ7ENGM1+2TCF
	 UYc19UWu38VhasSglR090EF5/M2qQQhM/zwYm5mHUKjI8LDCkDEXyT+EoOboK8mEd/nrS
	 S4GxVtPNRQBC4+sy8C8+Lg3k1jhu6aha5vVy3VSAaPKQjRigGt/YhEziDixvrBdGlv099
	 Zlwmf+sMynBMlce4TfdKGv5bsRC6aD1xMn5HnvEVbq7rXo5LLv6sO7M5eytZM1E0R513w
	 c9IMd3CtmXb4h+HQPqwQ3rxX+cxDem6Jc0ABFfIHryr30+Mlhh0Gp5sb0PVLYUEthYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q4RqrinK9LsGYWI5esNb2rulRFrnYZVl9D8CHAi44Uw=;
	b=oAZTYBNpy3RTU1nDfP4kQwS0LO2MWbY/rPLzwxa4P2Q/KZcZbUul9ioP6hZWgaBjsUN4
	 19r2kUX9Sfn6IZkFEZZjh/PNZ9EKvp78A8k9bv+DYpqD5KpQu6h19yT72dHml1miWr9z6
	 BqMN59NPtVfJGTsJpx2dyaZSx30XPZ5oOKHtH4XgqLDCEAIyFB43fD//e1VpP58wGkIgl
	 CKY1TKwOc2LJiZDXMjY/K7S2ozkmmvp6Ei55plXxMZyiDaeD+s6Qv44WR2Pp8kQRaGLa4
	 WGwSYg3dQw0GHroyYEMkgC/Uellg3h2gnhPjL/siHilg1F8HldhdKs85AbbcCHUFmjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N625fQ0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD41606A319;
	Thu, 22 Oct 2026 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N625fQ0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF111F000C2;
	Thu, 22 Oct 2026 05:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647197;
	bh=Q4RqrinK9LsGYWI5esNb2rulRFrnYZVl9D8CHAi44Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N625fQ0apUXM3X8xk6Vqu42xoYa/t1AvH3Qhoht+FCermWPieDo+vTarBCW/2z8oe
	 KvODAt0X2GmMt5btYwVnj1T1N1WOmAbwjMWyQxOjJ4/CpZj5VACjzEawingcDIAtQN
	 eQT7ZMmh5d0I83jf2UfKnYq4PyL03sQriOqKCybh7Ohqk02rTMPKA6xQWAC2RSGqai
	 t6i3ESBEhVdUJ8+SXRUhXKu7MPdEpw65hkgZkOmz9gj4/DNixxLVDmqihtcf8xu7eJ
	 dByu+G4UFXrCUgX9MhqpJ+jHx80huAXJmov6OlzD767HEYn7VbxkjN8/KVbPr3bj+B
	 PLc0iRGHIA9KQ==
Message-ID: <sashiko-outbox-181031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/9] rv: Add KUnit coverage for IRQ context
 transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022050712.75035-7-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <20261022050712.75035-7-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 05:33:16 +0000
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
- [High] rv: kunit: rq->nr_pinned leak on kunit_skip() under guard(migrate)=
()
--

commit 3183a8d5a8d274f51929b98832f2ad4013dd57a7
Author: Karl Mehltretter <kmehltretter@gmail.com>

rv: Add KUnit coverage for IRQ context transitions

This commit adds KUnit test cases for the irqstate runtime verification
monitor covering generated state tables, invalid transitions, enable-time
synchronization, nested hardirqs, shared IRQ actions, PREEMPT_RT serving
intervals, and live tracepoint wiring.

> diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/=
trace/rv/monitors/irqstate/irqstate_kunit.c
> new file mode 100644
> index 0000000000000..c5b8834fea3d9
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
> @@ -0,0 +1,1384 @@

[ ... ]

> +/* Exercise non-RT inline softirq processing from a real hardirq exit. */
> +static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
> +{

[ ... ]

> +	KUNIT_ASSERT_FALSE(test, in_interrupt());
> +	KUNIT_ASSERT_FALSE(test, irqs_disabled());
> +	KUNIT_ASSERT_EQ(test, softirq_count(), 0U);
> +	guard(migrate)();
> +	inline_ctx->owner =3D current;
> +	inline_ctx->owner_cpu =3D raw_smp_processor_id();
> +	inline_ctx->softirqd =3D this_cpu_ksoftirqd();
> +	KUNIT_ASSERT_NOT_NULL(test, inline_ctx->softirqd);
> +	if (local_softirq_pending() ||
> +	    !wait_task_inactive(inline_ctx->softirqd, TASK_INTERRUPTIBLE)) {
> +		kunit_skip(test, "Requires an idle local ksoftirqd");
> +		return;
> +	}
> +	saved_count =3D preempt_count();
> +	saved_softirq =3D softirq_count();
> +	local_irq_save(flags);
> +	if (local_softirq_pending() || task_is_running(inline_ctx->softirqd)) {
> +		local_irq_restore(flags);
> +		kunit_skip(test, "Local ksoftirqd stopped being idle");
> +		return;
> +	}
> +	WRITE_ONCE(inline_ctx->armed, true);
> +	WRITE_ONCE(inline_ctx->raise_on_exit, true);
> +	irq_enter_rcu();
> +	tasklet_schedule(&inline_ctx->tasklet);
> +	irq_exit_rcu();
> +	ran_inline =3D inline_ctx->tasklet_runs !=3D 0;
> +	inline_ctx->exit_tasklet_pending =3D
> +		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
> +	/*
> +	 * A zero return means the exit handoff already made ksoftirqd runnable.
> +	 * A one return also makes the failure path safe to drain.
> +	 */
> +	inline_ctx->softirqd_already_runnable =3D
> +		!wake_up_process(inline_ctx->softirqd);
> +	WRITE_ONCE(inline_ctx->armed, false);
> +	local_irq_restore(flags);
> +
> +	/* Drain a tasklet diverted to ksoftirqd before inspecting or skipping.=
 */
> +	kunit_release_action(test, irqstate_inline_bh_kill_all, inline_ctx);
> +	if (!ran_inline) {
> +		kunit_skip(test, "IRQ exit diverted pending softirq to ksoftirqd");
> +		return;
> +	}

[Severity: High]
Does calling kunit_skip() or KUNIT_ASSERT_*() while guard(migrate)() is
active in kernel/trace/rv/monitors/irqstate/irqstate_kunit.c leak the
runqueue nr_pinned counter?

In rv_test_irqstate_irq_exit_inline(), guard(migrate)() invokes
migrate_disable() -> __migrate_disable() in include/linux/sched.h:

	guard(preempt)();
	this_rq_pinned()++;
	p->migration_disabled =3D 1;

Inside that scope, rv_test_irqstate_irq_exit_inline() calls kunit_skip()
when local_softirq_pending() is non-zero, when ksoftirqd is not idle, or
when !ran_inline (for example, when forced IRQ threading diverts the
tasklet to ksoftirqd). However, kunit_skip() in include/kunit/test.h is:

	#define kunit_skip(test, fmt, ...)				\
		do {							\
			kunit_mark_skipped((test), fmt, ##__VA_ARGS__);	\
			kunit_try_catch_throw(&((test)->try_catch));	\
		} while (0)

Both kunit_skip() and failed KUNIT_ASSERT_*() macros call
kunit_try_catch_throw(), which terminates the KUnit runner kthread directly
via kthread_exit(0) -> do_exit(0) without returning to the caller or
unwinding the C stack.

Because scope-based cleanup destructors do not run when kthread_exit(0)
exits the thread, migrate_enable() -> __migrate_enable() never executes to
decrement this_rq_pinned() (rq->nr_pinned). Wouldn't that leave
rq_has_pinned_tasks(rq) permanently true on that CPU and cause subsequent
CPU hotplug offline operations to hang in balance_hotplug_wait()?

The same issue also applies if any KUNIT_ASSERT_*() fails while
guard(migrate)() is held in rv_test_irqstate(),
rv_test_irqstate_shared_actions(), rv_test_irqstate_sync(),
rv_test_irqstate_irq_exit_inline(), rv_test_irqstate_preempt(),
rv_test_irqstate_rt_prepare_irq(), and rv_test_irqstate_rt_prepare_switch().
Could migration disabling be managed with a kunit_add_action_or_reset()
cleanup action, or released before calling kunit_skip() and KUNIT_ASSERT_*()
macros?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022050712.7503=
5-1-kmehltretter@gmail.com?part=3D6
