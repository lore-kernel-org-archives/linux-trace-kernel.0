Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6230641A903
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971696; cv=none; b=tEX3/cYPYPYj/SsCsN7I3NDZQe5jkkP8+BhKps9vmbOONvrxHALknZDdz9FdQoTrdsCAIHlZ6TzV85HlnpKdsJ0TqdmAMJSBntmBWRzMDZKGV5fjMoyihjYd1vtEuhShJo9T0lmfslOqWL4n94H//IB7huBBanJKwChHUwpnV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971696; c=relaxed/simple;
	bh=wv77D7G88Q1mwYqoccyTeDetaqH0r37s5vrkZuCT6pI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qL18B3AcGjyLu063su/FAEDVxOTDQg87dKOPpvCX3pKLAW62lwHDmgrDCLOW1ijqJfsbRaGxk1wXckugv6dA+WyvGfCVW8I6yuVKb405k5JphNZFAVmqcrjw/cjSto5tIQ3WIITwcK3k9dv5Caa0P24lixt3HIhUw5vpVvMK/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/qJGHED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/qJGHED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77291F00893;
	Wed, 14 Oct 2026 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791971695;
	bh=Y9mpwEcOLFQMqQ1z7vTnNnnvV9rOYCThb5Y3lwentQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/qJGHED+xxFza3yTDQttBxeE4D9W05AHD0Z0tEEUP6DmaRdGM/DN9MsXsWOYUnhs
	 pesxy3PxvlIBntRo1Om3eO0kaMX8RV2YHqhHJIzlyPq7xu2vcuMAu6Suu7QMUbLh2t
	 3qYIBAiSiJeW1eNufOq3k6H++m5jLoHTC/rKbct2yxjXP99J9s1kPZwlnXUl7TFSnt
	 z46FhvOU07LVZHldnkyjTQIykZERVWvBOgYi/VGm2Gk1Jlop2WmuJxVYPdzS21Pfir
	 hU8gISep2hVFk2zk6c6pveL69cJjJJaJNQ7XFHNIQI9Ju357K5HgYiTZsMJ1aWQelV
	 6q/eLHfTVRg1A==
Message-ID: <sashiko-outbox-171103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] riscv: kprobes: add KUnit test for LR/SC
 sequence rejection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaofeng Yuan" <yuanxiaofeng@eswincomputing.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261014094415.374-3-yuanxiaofeng@eswincomputing.com>
References: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
 <20261014094415.374-3-yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 09:54:54 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kprobes: stack-allocated kprobe leak and UAF on unexpected test fa=
ilure
--

commit 10b8cab517db949a43dcca583dbcd1f20f6d68e8
Author: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

riscv: kprobes: add KUnit test for LR/SC sequence rejection

This commit extends the kprobes KUnit test to verify that register_kprobe()
correctly handles an LR/SC sequence. It asserts that probes are accepted
around the sequence but rejected if placed directly on the LR, SC, or any
instruction inside the sequence.

> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/=
kernel/tests/kprobes/test-kprobes.c
> index 027424a3ff7b1..2727537569739 100644
> --- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c

[ ... ]

> +static void test_kprobe_lrsc(struct kunit *test)
> +{
> +	/*
> +	 * test_kprobes_lrsc_offsets[] points, in order, at an instruction
> +	 * right before an LR/SC sequence, the LR itself, an instruction
> +	 * inside the sequence, the SC, and an instruction right after it.
> +	 */
> +	bool reject[] =3D { false, true, true, true, false };
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(reject); i++) {
> +		struct kprobe kp =3D {};
> +
> +		kp.pre_handler =3D kprobe_dummy_handler;
> +		kp.addr =3D (kprobe_opcode_t *)test_kprobes_lrsc_offsets[i];
> +
> +		if (reject[i]) {
> +			KUNIT_EXPECT_LT(test, register_kprobe(&kp), 0);
> +		} else {
> +			KUNIT_EXPECT_EQ(test, register_kprobe(&kp), 0);
> +			unregister_kprobe(&kp);
> +		}

[Severity: High]
Does this leave the stack-allocated kprobe registered if register_kprobe()=
=20
unexpectedly succeeds?=20

In the rejection path where reject[i] is true, KUNIT_EXPECT_LT() will log=20
a test failure if register_kprobe(&kp) returns 0, but execution will
continue. Because unregister_kprobe(&kp) is only called in the else block,=
=20
the kprobe remains in the global kprobe list.

Since struct kprobe kp is allocated on the stack within the loop, advancing
to the next iteration zeroes out the reused stack memory. When the function=
=20
eventually returns, the stack frame is popped. This would leave a dangling
pointer in the kprobes subsystem, causing a use-after-free or kernel panic=
=20
on subsequent kprobe operations or interrupts.

Should there be a check to unregister the kprobe if the registration=20
unexpectedly succeeds in the reject path?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014094415.374-=
1-yuanxiaofeng@eswincomputing.com?part=3D2
