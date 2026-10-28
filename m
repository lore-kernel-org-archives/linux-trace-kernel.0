Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793159477;
	b=vYo/ltzD66FXCPQFkyd5PUBZ76aPiLJAF2T5TIkvpszN8GGZAA8x901LEZZ68AutMdnM
	 RJmm0lEy53x4J0orKXU1Dxkixs78rCdVsblYV7zKQW7/QdPScWgeLdj79SQLMKfY99dd8
	 +Fkk3QSCei6U0kIGLMtp78GQi7Qe2/pridocE7fNALomOP2vYtBSk2xV2PNClblHfHmGx
	 4iEXarKK3ULI60PE/48cdC1mKbFsk7QIM4ojTBJwmN0tKVEPY87Bla8dbYiG65OjVR6aT
	 Q+ygRBvsoWnC7+/RI+WZh8rPu5Qp4J0nLRymWYeuPVhkX0fmNGDiF/T4hFHhupDq7OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159477;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8qtZEtNk142TpRoxmSCaOn+jQTO7rPmHhdimqqTaAXo=;
	b=3TCSSnhRRn8+uy9Nj+x0XY9GGsNIqD3AScMtrbKl1VehQRpb2DD+UoQ1vCZrSuYf09af
	 Idp5/eK8Yp4fUJhf79rqzl4QRoUp8t9M9lSE1DapPWFzIpgTVkK4AsUpAEiVF4c8aqOVA
	 74Yu5DFyb7Aqmr5ld80EK5eLx78zmgZoNzi51lpCkvnX9E6ii23GIDKMZZF71260Ob0CU
	 6MXLlYgfJJgChU3b+ZpmUuq/M+bYXMhIIU59K407+DvyxB0/hE9UzveFLdh1FLvbNIVgK
	 Lrjw5jRveQYKHL2lr8p9xsyQmT4LZwiYtF7iS72fZVd5OpZZYpHzaK6hS+G6zUBsD+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSmRGO7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC99606A31E;
	Wed, 28 Oct 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSmRGO7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F8B1F01825;
	Wed, 28 Oct 2026 03:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793159476;
	bh=8qtZEtNk142TpRoxmSCaOn+jQTO7rPmHhdimqqTaAXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSmRGO7a82I4IO8/3OJJvX18J7Fo8K3qy0ns7b0Xn3KGY4vSVBLt4BkWCLEtWiMbY
	 c96aLiKZOUBqdyZ74ebhIIrS9vS2t7iBHZeCupcCkrXzNNg6DpPL9EsonKT92HOt0M
	 0F06Ci1A1lPyU9KQ9keT4vh1Qh64pdN+GYLpJUl6wICF6kCVAclRZbsVySiNHW6z4G
	 Yrz0IPYqI4/9M0MQ352ez71rnD71xoEsqDjl/RtDZ1n+f1ORkdmHCItOzO2ER9qtkQ
	 sQVWdgyG54KuAHCbUzAO8MIQFvRFULY3T564zdNsVFyIQ4pgGTyM+VVdDC2LgS5ziM
	 lZ8v+8J2yh7bQ==
Message-ID: <sashiko-outbox-187447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/13] entry: Skip inactive IRQ-return reschedule
 calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261028033127.82193-7-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-7-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:51:16 +0000
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
- [Medium] entry: missing __always_inline on irqentry_exit_to_kernel_mode_p=
reempt()
--

commit b2284e95ad33bdfe152568730c196eaa50875e40
Author: Karl Mehltretter <kmehltretter@gmail.com>

entry: Skip inactive IRQ-return reschedule calls

This commit checks preempt_count() in irqentry_exit_to_kernel_mode_preempt()
to avoid calling irqentry_exit_cond_resched() when preemption is disabled, =
and
marks arm64's preempt_count() as __always_inline for noinstr callers.

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-c=
ommon.h
> index 289e308d2d46c..e1fd9155410c1 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -503,7 +503,7 @@ static inline void irqentry_exit_to_kernel_mode_preem=
pt(struct pt_regs *regs,
>  	if (regs_irqs_disabled(regs) || state.exit_rcu)
>  		return;
> =20
> -	if (IS_ENABLED(CONFIG_PREEMPTION))
> +	if (IS_ENABLED(CONFIG_PREEMPTION) && !preempt_count())
>  		irqentry_exit_cond_resched();
>  }

[Severity: Medium]
Should irqentry_exit_to_kernel_mode_preempt() in
include/linux/irq-entry-common.h also be marked __always_inline (like its
companions irqentry_enter_from_kernel_mode(),
irqentry_exit_to_kernel_mode_after_preempt(), and
irqentry_exit_to_kernel_mode())?

On arm64, __el1_irq() and arm64_exit_to_kernel_mode() call noinstr function
arm64_exit_to_kernel_mode_preempt() in arch/arm64/kernel/entry-common.c, wh=
ich
invokes irqentry_exit_to_kernel_mode_preempt() directly without
instrumentation_begin():

    static void noinstr arm64_exit_to_kernel_mode_preempt(struct pt_regs *r=
egs,
                                                          irqentry_state_t =
state)
    {
            irqentry_exit_to_kernel_mode_preempt(regs, state);
            __arm64_exit_to_kernel_mode(regs, state);
    }

While preempt_count() in arch/arm64/include/asm/preempt.h is changed to
__always_inline so Clang does not outline the new check into instrumentable
text, irqentry_exit_to_kernel_mode_preempt() itself remains static inline:

    static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs =
*regs,
                                                            irqentry_state_=
t state)

Because noinstr in include/linux/compiler_types.h strips sanitizer and
profiling attributes (__no_kcsan, __no_sanitize_address, __no_profile,
__no_sanitize_coverage, __no_sanitize_memory) whereas inline only adds
notrace, building with Clang and CONFIG_KASAN=3Dy, CONFIG_KCSAN=3Dy, or
CONFIG_GCOV_KERNEL=3Dy can cause LLVM to refuse to inline a non-__always_in=
line
callee due to mismatched attributes.

If that happens, couldn't Clang inline preempt_count() into
irqentry_exit_to_kernel_mode_preempt() and then outline
irqentry_exit_to_kernel_mode_preempt() itself into instrumentable .text,
allowing sanitizer instrumentation or kprobes to run on the noinstr return
path even when state.exit_rcu or regs_irqs_disabled(regs) is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028033127.8219=
3-1-kmehltretter@gmail.com?part=3D6
