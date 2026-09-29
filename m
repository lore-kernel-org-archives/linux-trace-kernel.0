Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E695526A80
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687928; cv=none; b=J660UtHr7R80uDPD9Fa420Up5WwaQyhZogrJn11AM53sYYs1SUH3hmigLQdzikU7biLDCiDLysPHiSRgRzgAtdpPvS1Zzr2i7peArkwb4XPmwq7dPi/mEtZiUHqqhpzOcMTC1f/kiUxPlACCCyG5pnoSAzH3OHpUg5gzmO0M+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687928; c=relaxed/simple;
	bh=cn+YxdfZ3qy0RyFhR4SBQeNCdqMgSpxkA1goLymnjZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWWZ2KQvxtb6azkr8/bIzl5A+YQ2O1TzdvXqOsjRuRXQqkz/ORMa5FK/y44BvRsKSzI4QImRFPdpbae+gC8ymyK5q2uRWU62RfD6IeIxN4aJ+ROtBdqowVRyRfePIPwdGNwU15LcBrqcTCQRcpyljMa/A2T6B8DC2qwL1v6H1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdEXen7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdEXen7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7971F000FF;
	Tue, 29 Sep 2026 13:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687926;
	bh=zuxolwCw8YVZwYxzuZy2l3/JWbgSJRD/WXk//MiD5zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MdEXen7snsYFdy6OLC0eDI/uFu+iJLV1s6WtVjPY1Stxc3FsN/mcPcRih6EO3EJzO
	 HE74TEFbtYXP2iK7jEAooINLKPgGcyYqrXwdlG54vns01VSBSLz2jJoiru67du12QH
	 O0DJnjgWwUuTrRCSCYUJMcAVMFD5Jo6yqrISBPHMG7wjaRsZc1PD4SvlJOyyrDZXmu
	 o95+g60G+PKk2Mcy3ZekHYKPnqDZ7qq3KRvo7colOoXHb78WmpQuj4wawZkdAGdu/q
	 7+x/jBXY/CXeEAGvQNTAtaSlYd67TM9aBRewXGZp3q1/WjaXlmJZwSE8Oex6rUg27n
	 KUD7pAXCmKqKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] rv: Add KUnit test for throttle monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929124908.177676-10-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
 <20260929124908.177676-10-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:18:46 +0000
Message-Id: <20260929131846.8B7971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rv: flaky KUnit test in throttle monitor due to tick granularity
- [Low] rv: missing handle_exit callback in rv_throttle_ops API
--

commit 393b9dd1a461f953ed6e0221a5c4e2b0850aa791
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Add KUnit test for throttle monitor

Add a test case for the throttle monitor to validate reactions occur
when a task gets throttled on time but switched back in without replenish
or runs longer than its runtime.

> diff --git a/kernel/trace/rv/monitors/throttle/throttle.c b/kernel/trace/=
rv/monitors/throttle/throttle.c
> index b22a2abe59fe0..2b181c46b7b65 100644
> --- a/kernel/trace/rv/monitors/throttle/throttle.c
> +++ b/kernel/trace/rv/monitors/throttle/throttle.c
[ ... ]
> @@ -283,3 +283,20 @@ module_exit(unregister_throttle);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
>  MODULE_DESCRIPTION("throttle: throttle dl entities when they use up thei=
r runtime.");
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +#include <kunit/visibility.h>
> +#include "throttle_kunit.h"
> +
> +const struct rv_throttle_ops rv_throttle_ops =3D {
> +	.mon =3D RV_MON_OPS_INIT(),
> +	.handle_dl_replenish =3D handle_dl_replenish,
> +	.handle_dl_throttle =3D handle_dl_throttle,
> +	.handle_sched_enqueue =3D handle_sched_enqueue,
> +	.handle_sched_switch =3D handle_sched_switch,
> +	.handle_sys_enter =3D handle_sys_enter,
> +	.handle_newtask =3D handle_newtask,
> +	.handle_dl_server_stop =3D handle_dl_server_stop,
> +};

[Severity: Low]
Did you intentionally omit the handle_exit callback from the rv_throttle_ops
struct?

While teardown_test cleans up the hash table and prevents memory leaks duri=
ng
tests, the missing function pointer prevents KUnit tests from manually
simulating the task exit cleanup lifecycle to verify state destruction when
a task dies.

> +EXPORT_SYMBOL_IF_KUNIT(rv_throttle_ops);
> +#endif
> diff --git a/kernel/trace/rv/monitors/throttle/throttle_kunit.c b/kernel/=
trace/rv/monitors/throttle/throttle_kunit.c
> new file mode 100644
> index 0000000000000..8194095dbab81
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/throttle/throttle_kunit.c
[ ... ]
> +	/* Task runs longer than runtime */
> +	rv_throttle_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNIN=
G);
> +	rv_throttle_ops.handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
> +	udelay(10 + TICK_USEC);
> +	rv_throttle_ops.handle_dl_throttle(NULL, &target->dl, 0, DL_TASK);
> +	RV_KUNIT_EXPECT_REACTION(test, ctx);

[Severity: Medium]
Will this delay calculation spuriously fail on specific kernel tick rates?

The monitor expiration threshold is calculated as 10000 + TICK_NSEC
nanoseconds.

Due to integer truncation in jiffies math (e.g. at HZ=3D300, TICK_USEC is 3=
333
and TICK_NSEC is 3333333), the injected delay (10 + TICK_USEC, or 3343000 n=
s)
would fall 333 ns short of the mathematical threshold (3343333 ns).

Depending on execution overhead, could the constraint check=20
time_ns - reset_time <=3D ha_mon->expire evaluate to true, generating no
reaction and causing this RV_KUNIT_EXPECT_REACTION assertion to fail?

> +}
> +
> +#else
> +#define rv_test_throttle rv_test_stub
> +#endif
> diff --git a/kernel/trace/rv/monitors/throttle/throttle_kunit.h b/kernel/=
trace/rv/monitors/throttle/throttle_kunit.h
> new file mode 100644
> index 0000000000000..d730497deca4d
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/throttle/throttle_kunit.h
[ ... ]
> +extern const struct rv_throttle_ops {
> +	struct rv_kunit_mon mon;
> +	void (*handle_dl_replenish)(void *data, struct sched_dl_entity *dl_se,
> +				int cpu, u8 type);
> +	void (*handle_dl_throttle)(void *data, struct sched_dl_entity *dl_se,
> +			       int cpu, u8 type);
> +	void (*handle_sched_enqueue)(void *data, struct task_struct *tsk, int c=
pu);
> +	void (*handle_sched_switch)(void *data, bool preempt,
> +				struct task_struct *prev,
> +				struct task_struct *next,
> +				unsigned int prev_state);
> +	void (*handle_sys_enter)(void *data, struct pt_regs *regs, long id);
> +	void (*handle_newtask)(void *data, struct task_struct *task, u64 flags);
> +	void (*handle_dl_server_stop)(void *data, struct sched_dl_entity *dl_se,
> +				  int cpu, u8 type);
> +} rv_throttle_ops;

[Severity: Low]
Does this struct definition also need the handle_exit callback added to
properly export the API for the test environment?

> +#endif
> +
> +#endif /* __THROTTLE_KUNIT_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929124908.1776=
76-1-gmonaco@redhat.com?part=3D9
