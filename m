Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B93432E8E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604418; cv=none; b=SH4xWVF9afKIueBsjtxqI7qcmlIpd7YpovY5OcRS6UlHoeRcxqXN+1Q/y1EZ670byKL6OtxBsxEJiQzY/NSXz9zvIW31EyCG+Ggp9Z3cYSZ3Y6QQ+JgD/gxcmNPurACCYNMC13vOcycVoqgd9B6f+Few5tCUNEY/Yl3ZcW33mtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604418; c=relaxed/simple;
	bh=jy+M/Ef5F3mIbwU+SLhYZ/vrVyGS4YlsGeu/7uS6ahA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YcGRMAU91aydkkqMWuuETL+5LoKCOiWHUefO8CGmW3K4VLLAps5JkKEEdu6+SP5rFxRkYE/k3RzvY1qiWpnm9CYOeY/z9u0Ggk6H7iINcTmV61DtTLtetW4O0mbAJQpLZxeKsXBFY9+WLHQmL6lKRhGtYewTGFJjsQxWzmaQc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOjhwDhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOjhwDhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02321F000E9;
	Thu, 13 Aug 2026 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604407;
	bh=QEUT35ngPwtBHB6GyXU9lR5fWdeTLmwYXy7zE07KtXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOjhwDhzyLDfoydklNNa5+OiOfTmrq4nsWDSiGO3wS2CoV9ZRpM45taAb6atWOhNH
	 INkZ3HMkt0uBU8BeNQ45zDnvSz6+v4Wn6PM9hoq2dfb7CIhJ/gSLrgu0DDYcPWbc1F
	 5sPqQ1mz+9VvPLa2KAKhcnOJeUYMn9NdPX2MAjjlvht10NuZ2EmCu/TbKuGjQ+Kllu
	 V5m+9YjOQJHKfOPbsh+X9lxhS9roztlqQCf8LNe6PRSgo6uR4x29yNWmB/KOK1OG5p
	 YjBXPYaR42uNI+GuLrdL3zLdl5v9X2EWUCC0VkxV2PAJfkmvh2fqtwCdSY80lFIosY
	 oYFASY7+LB3Jg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] arm64/kprobes: Make the entire Kprobe
 noinstr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xia" <hongyan.xia@transsion.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <9df18d2d664974aa05cfe39261d13c7366c8ef8a.1786603168.git.hongyan.xia@transsion.com>
References: <cover.1786603168.git.hongyan.xia@transsion.com>
 <9df18d2d664974aa05cfe39261d13c7366c8ef8a.1786603168.git.hongyan.xia@transsion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:00:06 +0000
Message-Id: <20260813070006.E02321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Functions converted to `noinstr` directly call non-noinstr and i=
nstrumentable code without using the required `instrumentation_begin()` / `=
instrumentation_end()` wrappers, violating strict non-instrumentation bound=
aries.
--

--- Patch [3]: [RFC PATCH v2 3/4] arm64/kprobes: Make the entire Kprobe noi=
nstr ---
commit 3ef2956d1a4e614b73b64bbc64be2a2e20e577e4
Author: Hongyan Xia <hongyan.xia@transsion.com>
arm64/kprobes: Make the entire Kprobe noinstr

This commit converts the kprobe handling path to use noinstr instead of
__kprobes, ensuring the code between debug_exception entry and exit is
strictly non-instrumentable. It also marks leaf helpers as __always_inline
and explicitly leaves the instruction simulation path as future work.

> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probe=
s/kprobes.c
> index 0e66abf9958e2..5ec5f4ef99852 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
[ ... ]
> -static void __kprobes setup_singlestep(struct kprobe *p,
> -				       struct pt_regs *regs,
> -				       struct kprobe_ctlblk *kcb, int reenter)
> +static void noinstr setup_singlestep(struct kprobe *p,
> +				     struct pt_regs *regs,
> +				     struct kprobe_ctlblk *kcb, int reenter)
>  {
[ ... ]
>  	if (p->ainsn.xol_insn) {
>  		/* prepare for single stepping */
>  		slot =3D (unsigned long)p->ainsn.xol_insn;
> =20
>  		kprobes_save_local_irqflag(kcb, regs);
>  		instruction_pointer_set(regs, slot);
>  	} else {
>  		/* insn simulation */
>  		arch_simulate_insn(p, regs);

[Severity: Medium]
Since setup_singlestep() is now marked noinstr, is it safe to call
arch_simulate_insn() here without instrumentation_begin() and
instrumentation_end()? The commit message notes the simulation path isn't
noinstr yet, so calling it directly from a noinstr function could trigger
objtool validation failures and issues with KASAN/KCOV.

>  	}
>  }
> =20
> -static int __kprobes reenter_kprobe(struct kprobe *p,
> -				    struct pt_regs *regs,
> -				    struct kprobe_ctlblk *kcb)
> +static int noinstr reenter_kprobe(struct kprobe *p,
> +				  struct pt_regs *regs,
> +				  struct kprobe_ctlblk *kcb)
>  {
>  	switch (kcb->kprobe_status) {
>  	case KPROBE_HIT_SSDONE:
>  	case KPROBE_HIT_ACTIVE:
>  		kprobes_inc_nmissed_count(p);
>  		setup_singlestep(p, regs, kcb, 1);
>  		break;
>  	case KPROBE_HIT_SS:
>  	case KPROBE_REENTER:
>  		pr_warn("Failed to recover from reentered kprobes.\n");
>  		dump_kprobe(p);
>  		BUG();
>  		break;
>  	default:
>  		WARN_ON(1);

[Severity: Medium]
Similarly, reenter_kprobe() is now noinstr but makes calls to instrumentable
functions like pr_warn(), dump_kprobe(), BUG(), and WARN_ON(). Should these=
 be
wrapped in instrumentation_begin() / instrumentation_end() to prevent
instrumentation from running in an un-instrumentable context?

>  		return 0;
>  	}
> =20
>  	return 1;
>  }
> =20
> -static void __kprobes
> +static void noinstr
>  post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struc=
t pt_regs *regs)
>  {
>  	/* return addr restore if non-branching insn */
>  	if (cur->ainsn.xol_restore !=3D 0)
>  		instruction_pointer_set(regs, cur->ainsn.xol_restore);
> =20
>  	/* restore back original saved kprobe variables and continue */
>  	if (kcb->kprobe_status =3D=3D KPROBE_REENTER) {
>  		restore_previous_kprobe(kcb);
>  		return;
>  	}
>  	/* call post handler */
>  	kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
>  	if (cur->post_handler)
>  		cur->post_handler(cur, regs, 0);

[Severity: Medium]
Does the call to cur->post_handler() also need to be wrapped in
instrumentation_begin() / instrumentation_end()? User-supplied post handlers
are instrumentable, so executing them directly from a noinstr context might
violate strict non-instrumentation boundaries if the probe triggers in early
exception entry.

> =20
>  	reset_current_kprobe();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786603168.gi=
t.hongyan.xia@transsion.com?part=3D3
