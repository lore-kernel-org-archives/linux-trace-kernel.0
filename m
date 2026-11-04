Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751915;
	b=IIlfb+hEovtk+84Lxcy0PiEZrBbtAuWCfSvpdtpJpd/AqNr5y7jOiBCLt865kBz5G6x8
	 B0+EG1fgRSa/gQAOMfhiNIWKm33eEQfYU3/u/mKvELFwTMSmD/ynkODYeZlZ+Rfi+x9Ib
	 r04bvEg1u4hXzHem4SJIo2HSPaHDyEXrAE+Kht3G1ZGmCztrTfOqgbTVvx726uw522TIa
	 mgfNRYXUH3JLANX3UTUPXmcS81Ql9yKlTIDZaT5+SH6j/EV8WPtc+04qaEJM8uyjdzVtg
	 qZ6GimasrlAYhWcbhlh4ssaweN+Hv55+QqEzr+8TdJL8f/cxyt45FLKGhoW9oIvpTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BZs+4k1o+tG4wzLKryOffSsOJRoP3BAqcybXzzxP964=;
	b=eQVD9honYqm7dUg+L6Et6nGDl1icSRONUvPjR1iXcs7e8F682VXeHlvY9xOiTeLUFe5J
	 WO9N3JsZoS3kTN9+yxEX93eNxWEVZGSKiOMDZAesaaCvWNa46Ob4gzyBTR3ZkayGAKRq1
	 N0HPxpNSsy11ZN4BUc7iFQ9d01KeiT1QfRWPbBLDLeVxnXXOY3jp68Zy4sR43tR2PjV9h
	 6fLTm+WOh6uojcRl2sETAahsgpKoAK5NDJB4dX/CXOgBlXLIv6prljrDb041Jmw2Yve9L
	 kb/H0HGs+T5NCAcgzaykl6DvOpVwrAqHaKc90d+N91vGxj+J7+1NEdLmNjKI7IMaV0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrwZ1yNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A5606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrwZ1yNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3331F000C1;
	Wed,  4 Nov 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751914;
	bh=BZs+4k1o+tG4wzLKryOffSsOJRoP3BAqcybXzzxP964=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrwZ1yNhBcmU/nPGbcNsrYrxnD78tCp+Eh3FYjEGkEZvteGjmRtcwP2MK9xXmL4wO
	 Xoj113dREXXp4m85MCmneSzvEGyi6IaYyO2xlS8y4XK09IMDn2bNVml3uCAC0FfgIq
	 kp00lJDtv7UlA6WOWH1fCIN7e7XaDQhIDSoOSYoZbAfojtF92cms2rsEZ3OA6JQmI8
	 n04SNRJbr/nQqnbB6HLJr/9v5K1OPSURu1E5Gfh9RMneo3pHZSAkhAWU+eu8a2JQg/
	 O4j1tr8WLTwtqu5W5H8DDVruyRFBUPTrxh9Dvf4IYckBvV0BAU+PB/ZMS7bKXk5fye
	 m65V+AiB7IiYQ==
Message-ID: <sashiko-outbox-196309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] kprobes: Add KUnit test cases for kprobes
 regressions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179375037150.247640.2739381151766036732.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
 <179375037150.247640.2739381151766036732.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:25:14 +0000
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
- [Medium] kprobes: test_optprobe_rearm_unoptimizing() probes ftrace entry
- [Medium] kprobes: stack UAF if KUNIT_ASSERT_EQ() aborts with registered k=
probe
- [Low] kprobes: unexported wait_for_kprobe_optimizer() breaks module build
--

commit 879cc55db87246da67610c427cb32cb35c372768
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Add KUnit test cases for kprobes regressions

This commit adds four KUnit test cases to lib/tests/test_kprobes.c to
verify fixes for regressions in kretprobe unregistration, kretprobe
re-registration, ftrace ops switching, and optprobe re-arming.

> diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
> index 06e729e4de051..c20f70cc63d73 100644
> --- a/lib/tests/test_kprobes.c
> +++ b/lib/tests/test_kprobes.c
[ ... ]
> +#if defined(CONFIG_KPROBES_ON_FTRACE)
> +/* Test for: kprobes: Switch ftrace ops when adding probe with post_hand=
ler */
> +static void test_kprobe_ftrace_post_handler_switch(struct kunit *test)
> +{
> +	struct kprobe kp_entry =3D {
> +		.symbol_name =3D "kprobe_target",
> +		.pre_handler =3D kp_pre_handler,
> +	};
> +	struct kprobe kp_post =3D {
> +		.symbol_name =3D "kprobe_target",
> +		.post_handler =3D kp_post_handler,
> +	};
> +
> +	current_test =3D test;
> +
> +	/* 1. Register first probe without post_handler (armed with kprobe_ftra=
ce_ops) */
> +	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&kp_entry));
> +
> +	/* 2. Register second probe with post_handler at same IP (must switch o=
ps) */
> +	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&kp_post));

[Severity: Medium]
In test_kprobe_ftrace_post_handler_switch(), kp_entry is allocated on the
test kthread stack. If the second register_kprobe(&kp_post) call fails (for
example, if alloc_aggr_kprobe() or ftrace ops switching fails), the asserti=
on
macro aborts the test immediately via:

  __kunit_abort()
    -> kunit_try_catch_throw()
      -> kthread_exit(0)

Would this exit the kthread and free its stack while kp_entry is still
registered in kprobe_table, leaving a dangling stack pointer that causes a
stack use-after-free?

The same question applies to test_optprobe_rearm_unoptimizing() below, where
opt_kp is on the stack and registered before the assertions on
disable_kprobe(&opt_kp) and enable_kprobe(&opt_kp).

> +
> +	/* 3. Execute target function to trigger both */
> +	preh_val =3D 0;
> +	posth_val =3D 0;
> +	target(rand1);
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +	KUNIT_EXPECT_NE(test, 0, posth_val);
> +
> +	/* 4. Unregistering must successfully disarm without -ENOENT */
> +	unregister_kprobe(&kp_post);
> +	unregister_kprobe(&kp_entry);
> +}
> +#endif
> +
> +#if defined(CONFIG_OPTPROBES)
> +/* Test for: kprobes: Do not overwrite jump instruction when re-arming u=
noptimizing probe */
> +static void test_optprobe_rearm_unoptimizing(struct kunit *test)
> +{
> +	struct kprobe opt_kp =3D {
> +		.symbol_name =3D "kprobe_target",
> +		.pre_handler =3D kp_pre_handler,
> +	};
> +
> +	current_test =3D test;
> +	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&opt_kp));

[Severity: Medium]
Does test_optprobe_rearm_unoptimizing() actually exercise jump optimization
when ftrace-based kprobes are enabled?

Because opt_kp is registered at kprobe_target with offset 0, on kernels with
ftrace-based kprobes enabled, register_kprobe() marks the probe as an ftrace
kprobe:

  register_kprobe()
    -> check_kprobe_address_safe()
      -> check_ftrace_location()
         if (ftrace_location(addr) =3D=3D addr)
             p->flags |=3D KPROBE_FLAG_FTRACE;

Then __register_kprobe() calls try_to_optimize_kprobe(), which bails out
immediately:

  try_to_optimize_kprobe()
    if (kprobe_ftrace(p))
        return;

As a result, disable_kprobe() and enable_kprobe() take the ftrace disarm/arm
paths instead of queuing opt_kp on unoptimizing_list and re-arming an
optimized probe. Should opt_kp be placed at a non-zero instruction offset
within kprobe_target, or target a notrace function, so that jump optimizati=
on
is actually used?

> +
> +	/* Allow background optimizer thread to jump-optimize the probe */
> +	wait_for_kprobe_optimizer();

[Severity: Low]
Can this break the build when the test is compiled as a loadable module?

In lib/Kconfig.debug, this test suite is tristate:

  config KPROBES_SANITY_TEST
  	tristate "Kprobes sanity tests" if !KUNIT_ALL_TESTS

However, wait_for_kprobe_optimizer() in kernel/kprobes.c is not exported to
modules, causing modpost to fail with an undefined symbol when the test is
built as a module with optprobes enabled. Should wait_for_kprobe_optimizer()
be exported, or should this test be guarded like the stack_trace_save_regs()
callers earlier in lib/tests/test_kprobes.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179375029807.247640=
.13024754173032838618.stgit@devnote2?part=3D8
