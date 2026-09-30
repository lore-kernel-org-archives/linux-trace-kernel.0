Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8C515997
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800883; cv=none; b=pQ7Z40Wb3mO3OZeRSZxFKxjDmlJ/t+pY1i1H/IakJUoWfb5elKzJAXASx5k2yrBXZW9HilmxJkHFrejD8QXbEsuCLFGp+DYgHttIgkP4lUdBi0KrMdtFnF36yzJh3VSN7ojj7BG3+AiJbW1rMk2eraDpa15THOvTYzs3XfknTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800883; c=relaxed/simple;
	bh=mzFxz7860MvsuNThCe6wiMMaq3kFcXLfutPRqu9GzHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moR70ZvxIr7YF/Ee58mNZIxmUkjaqRz9kXcmG+2TOKVAwSdqi0TmtnQru0QEhtVMwARB9Eb0NeB7jNuMu1TkdwMdfDTX8UpF1rsdskSobJC2K9MOjmHtkw0arAZpRoSKg5BS8jH5RUIh9ON6HQ1yBSfwHsAdPkJUhd0XxebWXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlT4K1wA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlT4K1wA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3061F000FF;
	Wed, 30 Sep 2026 20:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800882;
	bh=PhsQ5g2e/Tyz2fhnSjlYVa+G6FSZsCXj2EcGeTFyByA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlT4K1wA8smX0XqCjbMlJwAqlgcNLLOT9namEXtgeVsFqDfRllc2kn6XcmIcOzk/n
	 b9dnX65kHqsvlHppYlK/y+exZdK4n63i06UvJmwGNzktnIs+gZdxswxCZNRD6c4Vsh
	 H8ThZhUoQa4rD/2xvSLBgkQaRVAmJIKcxeOpzQNx6GfjpH/KeelR2UtxP72USWM2UB
	 IVsgXB2ew80kZLAJCojDzD+hLcG/QbY1I3Q2JiZDCvCdE2t9limORB3Nsza1U5DrGL
	 tXJ1j65mnARDGZsw1Dr3ixKmXXZIv/ataDGCD+CKm6w5TQPlDUp3be+pfW7fYu80mb
	 t2+dukA08bKvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930203129.51048-4-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
 <20260930203129.51048-4-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:41:21 +0000
Message-Id: <20260930204121.ED3061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] openrisc: uninitialized return value causes kprobe test to uncon=
ditionally fail
- [Medium] openrisc: flaky test in test_kprobes_adrp due to missing alignme=
nt
--

commit d52f067996dd8c21d999dffa9e89c92071ac2e93
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add unit tests for KProbes on branch instructions

Tests already exist lib/tests to verify the generic functionality of
KProbes. Add unit tests to verify that KProbes work on instructions
that require simulation in the OpenRISC ISA, and that the corresponding
delay slots are handled correctly.

> diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openris=
c/kernel/tests/test_kprobes_asm.S
> new file mode 100644
> index 0000000000000..a9fcf99b55ae1
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S

[ ... ]

> +SYM_FUNC_START(test_kprobes_adrp)
> +	l.addi	r13,r0,0
> +	l.addi	r15,r9,0
> +	l.addi	r17,r0,-8192
> +	l.jal	1f
> +	l.nop
> +1:	l.and	r19,r9,r17
> +test_kprobes_adrp_addr:
> +	l.adrp	r21,0
> +	l.sfeq	r21,r19

[Severity: Medium]
Will this test be flaky due to a lack of alignment directives?

The test verifies the l.adrp instruction by evaluating if it computes the
same page base as the 1: label. It derives the page address of 1: by masking
its address with -8192, and compares it to the page base computed by l.adrp
on the next instruction.

Since there is no alignment directive, the 1: label and the l.adrp
instruction might straddle an 8KB page boundary during linkage (e.g., if 1:
is at 0x1FFC and l.adrp is at 0x2000). If they cross the boundary, the two
page bases won't match, causing the test to incorrectly branch away to the
failure path.

> +	l.bnf	2f
> +	l.nop
> +	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +2:	l.addi	r9,r15,0
> +	l.jr	r9

[Severity: Medium]
Does this function omit setting the return register, causing the kprobe test
to unconditionally fail?

The inline assembly successfully loads the magic value into r13 but omits
the l.addi r11, r13, 0 instruction required by the OpenRISC calling
convention to move it into the return register (r11) before returning.

Because of this, test_kprobes_adrp() will return whatever garbage data was
in r11.

> +	l.nop
> +SYM_FUNC_END(test_kprobes_adrp)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930203129.5104=
8-1-sahilcdq0@gmail.com?part=3D3
