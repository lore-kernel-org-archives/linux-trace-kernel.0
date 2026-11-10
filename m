Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274832;
	b=vDdyTmCBSUWKShJgYYLuwWJ+1xYKf7dQ4mB16Jz4klwG/hFRkoD64e66pS6SMrHM2C48
	 K8wtC8722S6/R+HTBMaMDJYwiuR8FH0vf3PSvJ/5uHSbg7V0ratkbY5ZFhyqyL5AO5Wb/
	 qsaxTuig0vD97aotCEa0uk6ig5zvsTFfyw2DQIiJoA+x9y/hus2JHzI2SAJemd/C7ah+i
	 HkvtIGjIBgpEu/9SDCXHieJxlEwRcNvRL5nyjdkLSt8GLwG+MBGK2WNikSt0BN2qBdlF1
	 m73Sa4+0wKDiuq3g4BayTDtWgh8KjKzk5WHQLEqgOO8BTXanM+jPJUSRVRHdBHgDHyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UMZmxeT8DrkfoX8iPkUmOMynSFGrCqoB3ITufkHW3bs=;
	b=H717HJvYjrOSGh03PHdLFEputf2sW3sVL5qOCwL1bbOy+S/apBPCieXQCgPLnTKfH8xQ
	 LjgBWpHEP5FMK8+Uy2P0lDPkAUTdrIWnOEXO4rcPSUiHIzcm64wgCZjnUJcrlGlpuFrxV
	 7PiN4lPY2uHtOF/UBYk6vot8KQ3auR+MzFzAipARvoJu8Wq/knw7KkCASVZaNV0X/cAKp
	 4Kw+XUtPAbdZwLUYPb8LUYRJiDvHbuNdZlJ/A7JQwOTKPwifNuZPbjFl3KP2IZWpo/jPW
	 TcW/PyWHqSvPOaFHA5VNnnG9yf0qJIhHVFTlhLpgiV6pRIKbvDJL/uV0wNhYxZtf0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVTJUOb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A32606A325
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVTJUOb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABC61F0089F;
	Tue, 10 Nov 2026 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274831;
	bh=UMZmxeT8DrkfoX8iPkUmOMynSFGrCqoB3ITufkHW3bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVTJUOb9c4t1OehyV5+7A+cmULgvrsTFTvm5MYsFqzOvdI6QwVRnWmEvdB4Huel6X
	 wNU++jf/XWkjOz3DsWLbTqBVfwkCoFpG1yUbDf7prjPaBTbBMMrVZXe7el9Ii7/muf
	 tOXE40rCgkk9amt41/PfmeByu/VA6lIy7YX8QbBChiO3PiHYrR/8OWUK0tVBnqPSy8
	 dCMJgGcNLDntQD9ZeK2zVILpY6dlvlREQnsK9XKu/E82TaloJ6l9XghqxOzIj/CDkN
	 KecuL4b0Z0WR5X8zplqcsxc35XICG4d5cm1DwM++OF8lmdUZelW+nnB3aMiRHOrZ5o
	 9E7OXyMD0kZSA==
Message-ID: <sashiko-outbox-205975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] kprobes: Add KUnit test cases for kprobes
 regressions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179427362063.291326.12590758885048682193.stgit@devnote2>
References: <179427358690.291326.2078291446658598883.stgit@devnote2>
 <179427362063.291326.12590758885048682193.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:40:30 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] kprobes: test_optprobe_rearm_unoptimizing() misses jump
  overwrite on re-arm
--

commit d9ce37575f42c89c2d4a066b90a06cb4ee50df98
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Add KUnit test cases for kprobes regressions

This commit adds four KUnit test cases to lib/tests/test_kprobes.c covering
regressions in kprobes registration, ftrace ops switching, and optimization
state transitions.

> diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
> index 06e729e4de051..d692612bc2245 100644
> --- a/lib/tests/test_kprobes.c
> +++ b/lib/tests/test_kprobes.c
[ ... ]
> +/* Test for: kprobes: Do not overwrite jump instruction when re-arming u=
noptimizing probe */
> +static void test_optprobe_rearm_unoptimizing(struct kunit *test)
> +{
> +	struct kprobe opt_kp =3D {
> +		.symbol_name =3D "kprobe_opt_target",
> +		.pre_handler =3D kp_pre_handler,
> +	};
> +
> +	current_test =3D test;
> +	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&opt_kp));
> +
> +	/* Allow background optimizer thread to jump-optimize the probe */
> +	wait_for_kprobe_optimizer();
> +
> +	/* Temporarily disable probe (queues on unoptimizing_list, leaves jump)=
 */
> +	KUNIT_EXPECT_EQ(test, 0, disable_kprobe(&opt_kp));
> +
> +	/* Immediately re-enable (re-arm) before optimizer thread unoptimizes */
> +	KUNIT_EXPECT_EQ(test, 0, enable_kprobe(&opt_kp));
> +
> +	/* Verify jump opcode was not corrupted by an unaligned INT3 overwrite =
*/
> +	preh_val =3D 0;
> +	opt_target(rand1);
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +
> +	unregister_kprobe(&opt_kp);
> +}
> +#endif

[Severity: Medium]
Does test_optprobe_rearm_unoptimizing() pass even when enable_kprobe()
overwrites the jump instruction at opt_kp.addr with a breakpoint?

When disable_kprobe() runs on the optimized probe, __disarm_kprobe() queues
it on unoptimizing_list and skips arch_disarm_kprobe(), leaving the jump in
place.  However, enable_kprobe() calls __arm_kprobe(), which unconditionally
calls arch_arm_kprobe() before optimize_kprobe():

kernel/kprobes.c:__arm_kprobe() {
    ...
	arch_arm_kprobe(p);
	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
}

arch_arm_kprobe() overwrites the jump opcode at p->addr with a breakpoint,
while optimize_kprobe() sees KPROBE_FLAG_OPTIMIZED and
optprobe_queued_unopt(op), dequeues the probe from unoptimizing_list, and
returns early without re-optimizing it.  This leaves the probe permanently
de-optimized with a breakpoint at p->addr while KPROBE_FLAG_OPTIMIZED
remains set.  Because hitting that breakpoint still invokes kp_pre_handler(=
),
checking only that preh_val is non-zero does not detect that the jump opcode
was overwritten.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179427358690.291326=
.2078291446658598883.stgit@devnote2?part=3D4
