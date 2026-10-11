Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D8317173
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748217; cv=none; b=XwD8T9hQQUs0DFCTO3kD746mejKV2gUnK2rIrdOfOLMipr+Jadn73w7RuR5cvUd79XZiaHaKhezFkHxz83gHK0vL3HvWoQW+ZMHLxc01N7NqrFWLYJPmlVafclosduezqe/1Nl1tQ2i6BSqQhJLepstzIXJQOqFAt8+JJDsmrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748217; c=relaxed/simple;
	bh=MxcvgYCYBHYbDZwu3ivlvcpFTryF3j6qAm4hNKhnaLc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OgKyuckMIqJtbpO7hczsZwzLPFhXsYtA5VRSA7YjQ9MDZkM0gzdSOGQIfY/KpBR1cysCUPUPH3NFDCVXhUbO6/vUe2qHPYCFNQ7e9AbWBS+RV6e/1ZL+EKzmCuOpI/s/BfJy9KrFM/0JWigy7fau03s4duAvWO3+57jvDwXqpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7i6RSox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7i6RSox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D421F0089C;
	Sun, 11 Oct 2026 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748216;
	bh=oeAFSLmFKfg+mBG2e4bvvADAc1fQ+mDN8/tglogUSXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7i6RSoxvVfbwsykb/1rmYUYAT2D/ImcIy/VVwODax+Ty6ojjoQtKmqbm8dsX+WIk
	 0lZOU3qwJ0k6TdVeOG7gNaLNHlMl5kzNfOJmEoKn/D2RycXlJYtoH+/h87DUN29Tbd
	 JJFk7rYw9ugpNEMh5WPUOFE5hiFq4+trbEoO2ye7LCLspW96f3eXilHQRSWKduNlGj
	 FDpV6LYs9TfaiHhyiF0+Ua2LWxQo3nNj/3BxEnlN8/hWRA56R2Zo8dzp6ObVtep6XC
	 rCRXMd6FBBiSHOvmv3xMSnt9W1CkZedngv9Q41hAlY9GGAOM1L4Ia0WYF69uL5No/6
	 WyVz6muZ0khZQ==
Message-ID: <sashiko-outbox-167420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] rv: Add a KUnit test for the storage free path
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <448c421a47452ebddc6502ba3435eb91c1749601.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <448c421a47452ebddc6502ba3435eb91c1749601.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:50:15 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rv: Use-After-Free in rv_test_rvtest_arm_after_destroy due to dr=
opped RCU lock
--

commit 62c45f491a4a036b9788ee3cd149fc4c81f32003
Author: Wen Yang <wen.yang@linux.dev>

rv: Add a KUnit test for the storage free path

The test resolves a storage, desstroys it with da_destroy_storage(), and
then arms the HA timer through the stale pointer. The free hook must
disarm that timer too, so it never fires and no reaction is reported.

> diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_moni=
tors_test.c
> index 3ad11195e664a..b30e49419e34b 100644
> --- a/kernel/trace/rv/rv_monitors_test.c
> +++ b/kernel/trace/rv/rv_monitors_test.c
> @@ -146,6 +227,83 @@ static void rv_test_dummy(struct kunit *test)
>  	active_ctx =3D NULL;
>  }
> =20
> +/*
> + * rv_test_rvtest_underflow - the HA clock math must not underflow as u64
> + *
> + * An invariant checked while the uptime is below the budget holds, and a
> + * timer armed after the budget elapsed expires now.
> + */
> +static void rv_test_rvtest_underflow(struct kunit *test)
> +{
> +	struct ha_monitor *ha_mon;
> +	struct da_monitor *da_mon;
> +	const int id =3D 4242;
> +
> +	prepare_test(test, &rvtest_mon);
> +	da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +	scoped_guard(rcu)
> +		da_mon =3D da_get_monitor(id, NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, da_mon);
> +	ha_mon =3D to_ha_monitor(da_mon);
> +
> +	/* Uptime below the budget: time_ns - expire_ns would underflow. */
> +	ha_reset_clk_ns(ha_mon, clk_rvtest, 0);

[Severity: Medium]
Are we dereferencing an RCU-protected pointer outside of its RCU read-side
critical section here?

The scoped_guard(rcu) is used without braces, meaning the RCU read-side
critical section ends immediately after da_get_monitor(). The da_mon variab=
le
is then used by to_ha_monitor() and passed to ha_reset_clk_ns().

Even if there is no concurrent deletion in this specific test environment,
isn't this an RCU read-side violation that dereferences an RCU-protected
pointer after the lock is released?

> +	KUNIT_EXPECT_TRUE(test, ha_check_invariant_ns(ha_mon, clk_rvtest, 0,
> +						      RVTEST_BUDGET_NS));
> +
> +	/*
> +	 * Budget already elapsed: expire - passed would underflow and queue
> +	 * the timer at KTIME_SEC_MAX.
> +	 */
> +	da_monitor_reset(&ha_mon->da_mon);
> +	ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
> +	ha_start_timer_ns(ha_mon, clk_rvtest, RVTEST_BUDGET_NS,
> +			  RVTEST_BUDGET_NS + NSEC_PER_SEC);
> +	KUNIT_EXPECT_TRUE(test,
> +			  ktime_before(hrtimer_get_expires(&ha_mon->hrtimer),
> +				       ktime_get() + NSEC_PER_SEC));
> +
> +	ha_cancel_timer_sync(ha_mon);
> +}
> +
> +/*
> + * rv_test_rvtest_arm_after_destroy - a storage outlived by its own timer
> + *
> + * da_destroy_storage() cancels the timer, then unlinks:
> + *
> + *	da_monitor_reset_hook()		cancels
> + *	hash_del_rcu()
> + *	call_rcu()
> + *
> + * A reader that resolved the storage before the unlink can arm past that
> + * cancel.  Handlers resolve and use under one guard(rcu)(), so the two =
steps
> + * are issued separately here.
> + */
> +static void rv_test_rvtest_arm_after_destroy(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx =3D test->priv;
> +	const int id =3D 4242;
> +	struct da_monitor *stale;
> +
> +	prepare_test(test, &rvtest_mon);
> +
> +	da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +	scoped_guard(rcu)			/* resolve before the unlink */
> +		stale =3D da_get_monitor(id, NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, stale);
> +
> +	da_destroy_storage(id);			/* cancel, unlink, call_rcu */
> +	ha_start_timer_ns(to_ha_monitor(stale), clk_rvtest,
> +			  RVTEST_BUDGET_NS, ha_get_ns());

[Severity: Medium]
Does this sequence result in an actual use-after-free rather than just
simulating one?

Similar to the above, stale is resolved within a scoped_guard(rcu) that
ends immediately. da_destroy_storage() then unlinks the object and defers
its destruction via call_rcu().=20

Since the test thread no longer holds the RCU read lock, it can be preempte=
d,
allowing the RCU grace period to complete and free the stale object. When
the test thread resumes, doesn't calling ha_start_timer_ns() write to the
freed memory?

To safely simulate the race mentioned in the comment, shouldn't the test ho=
ld
the RCU lock continuously across both the lookup and the timer arming steps?

> +
> +	rcu_barrier();
> +
> +	msleep(600);
> +	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D5
