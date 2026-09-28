Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E54364EB8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585677; cv=none; b=ojGrrW4LCjyENHLkEWIS+uHpmyBMktAq4W1CfGWQ5lFUyNTLvS8xGk+ChM6oOcQCA2geDSdwlaL8MFvzlWZT0FyajsL8AnfUmbaq5N2IUOU0V07wlgVRmNO5mUoCU1ja72k2/qJa1OEuBs1pZXzCdCEJutb0PRgSeXdddvSD2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585677; c=relaxed/simple;
	bh=RyZMVZujsetzqhB4TYSDXBOumsr10OqKdJTtYNdwhyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L576Fx3ULzkyClZpIs3AD31Q5cCcHCzult7uVCNUrDf4uWJFUevroJdiTa0x3Ljq1uU7ZtYvEdmcKrzq98yX5126X25EmKn/WBhoHmzKflgBh2YnBxaEFHQEfgdpWWGEMdlZUXYthO9Oh/Eics+ra2m36BNVYwtAYFzIwn7/7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLyK3AH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLyK3AH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E61F00893;
	Mon, 28 Sep 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585675;
	bh=1xJa9IUJMARvIln8uTwLgKp0prN+s04kxafbLxgRdtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLyK3AH2ts2x+Qvl3ASX4radwVfZ5hKVbwt+nTEvSkkHejBKffaEMVCXTjarTqpkc
	 z/lc8NhwGAhH1YWUPsygmYY/ScWHljgqizyb7Isi448wYBQh5YuV3AqCyX2AbmbYzt
	 vpF2v+z7wMK4/+uEZIRtUVVbtmbTQtmStAoh9wXWSuzuDu6vaUjpeDj9sjdxXHEDGs
	 3XDmQwH9bhevnJxUgjqhataMXBR595NNvyt2UagwRF5sAyGeb8wVRQPZniADI97Erl
	 AgZCtYxb1/G308xWJRnmrUu5cZzu4J7wz/B7O3eortU3cFUEahT5zbRb3mF7d8Udr4
	 PxzQ8Xsw03F7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] lib/tests: add KUnit test for nested objpool pushes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shashank Mohan Jain" <jain.sm@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260928084125.67104-3-jain.sm@gmail.com>
References: <20260928084125.67104-1-jain.sm@gmail.com>
 <20260928084125.67104-3-jain.sm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:54:35 +0000
Message-Id: <20260928085435.6D9E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] lib/tests: UAF and memory leaks on KUnit assertion failure or time=
out
- [High] lib/tests: module unload UAF due to unsafe kthread completion
- [Medium] lib/tests: missing memory barrier causes stale reads of test sta=
tistics
--

commit 6bf48aebedba8949a86524af4e186a561332ca36
Author: Shashank Mohan Jain <jain.sm@gmail.com>

    lib/tests: add KUnit test for nested objpool pushes
   =20
    objpool_push() only pushes to the slot of the local CPU, but a push from
    NMI context (a kretprobe'd function returning in NMI) can interrupt it
    and push to the same slot.

diff --git a/lib/tests/objpool_kunit.c b/lib/tests/objpool_kunit.c
new file mode 100644
index 0000000000000..d86ef00dd0887
--- /dev/null
+++ b/lib/tests/objpool_kunit.c
@@ -0,0 +1,329 @@
[ ... ]
> +static int op_task_fn(void *data)
> +{
[ ... ]
> +	while (ctx->remote_pop && !READ_ONCE(ctx->popper_done)) {

[Severity: Medium]
Will this polling cause stale reads of test statistics?

The flag is polled using READ_ONCE without an acquire barrier.

> +		/* keep one reserve object for the teardown */
> +		if (ctx->nreserve > 1) {
> +			obj =3D ctx->reserve[--ctx->nreserve];
> +			atomic_set(&obj->held, 0);
> +			local_irq_save(flags);
> +			__objpool_try_add_slot(obj, &ctx->pool, ctx->cpu);
> +			local_irq_restore(flags);
> +		}
> +		schedule_timeout_uninterruptible(1);
> +	}
> +
> +	complete(&ctx->done);
> +	return 0;
> +}

[Severity: High]
Can this create a module unload race condition?

The kthread signals completion before fully exiting. The thread can be pree=
mpted
before returning, and because the main test thread returns immediately after
wait_for_completion(), module unload could proceed before this kthread has
fully exited module text. If the module is removed, the kthread will resume
execution in unmapped memory.

[ ... ]
> +static int op_popper_fn(void *data)
> +{
[ ... ]
> +	while (!READ_ONCE(ctx->stop)) {
> +		obj =3D objpool_pop(&ctx->pool);
> +		if (obj)
> +			op_popped(ctx, obj);
> +		cond_resched();
> +	}
> +	WRITE_ONCE(ctx->popper_done, true);

[Severity: Medium]
Does this need a release barrier?

The completion flag is published using WRITE_ONCE without a release barrier,
allowing prior statistic updates to be reordered. On weakly ordered
architectures, op_task_fn might observe the completion state before the
statistic updates (like ctx->pops and ctx->doubles) are globally visible.

> +	return 0;
> +}

[ ... ]
> +static void op_run(struct kunit *test, bool remote_pop)
> +{
[ ... ]
> +	/* take every object out of the pool; hand them to the stocks */
> +	while (n < OP_NR_OBJS && (obj =3D objpool_pop(&ctx->pool)))
> +		ctx->objs[n++] =3D obj;
> +	KUNIT_ASSERT_EQ(test, n, OP_NR_OBJS);

[Severity: High]
Does an assertion failure here leak memory?

If this assertion fails, the test aborts and skips objpool_fini(), leaking
the pool internals.

[ ... ]
> +	task =3D kthread_create(op_task_fn, ctx, "objpool_kunit_push");
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(task));
> +	kthread_bind(task, cpu);
> +	if (remote_pop) {
> +		popper =3D kthread_create(op_popper_fn, ctx, "objpool_kunit_pop");
> +		KUNIT_ASSERT_FALSE(test, IS_ERR(popper));

[Severity: High]
Would an assertion failure here leak the kthread and the objpool?

If the KUNIT_ASSERT_FALSE macro triggers a test abort, the already-created
'task' thread is never stopped or freed, and the objpool is leaked.

> +		kthread_bind(popper, pcpu);
> +		wake_up_process(popper);
> +	}
> +	wake_up_process(task);
> +	wait_for_completion(&ctx->done);

[Severity: High]
Is there a use-after-free risk if the test times out here?

If the test times out while waiting for completion, KUnit will free ctx wit=
hout
stopping the kthreads. The background kthreads will continue running, access
the freed ctx memory, and trigger a use-after-free.

Additionally, because the main thread returns immediately after this comple=
tion,
it does not wait for the kthreads to fully exit. As mentioned above, this
exposes the test to a module unload crash where the kthreads resume executi=
on
in unmapped memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928084125.6710=
4-1-jain.sm@gmail.com?part=3D2
