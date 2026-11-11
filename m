Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417716;
	b=3JMr+mWsF8kb99YzeBhhvvXejMfD6Sr2/GVrOiwXFFEuwtSgoWyIgLE1E4VkdUbkgNX8
	 5Woh+J8dBS5AKQ37pf+tjZ5ZSIrq67rtUBwaZNjqPcBUIzoBG16Tdj8FZIIW7kaOdDsNQ
	 RYe7wpwgV2yaEG4EtvzwpSJTDtIOVRrzYAilxSoY/VTp8xAiYdNoX/GHGgRrAq15j2Pby
	 jkokKchUnu7qM7Z8dP7psq+qhUr6toHUwLT0hQzUPzU8kAwM5uPTg2L78hnc43ebkF8zr
	 z2ALhouep0zWg2M+JnrXT01L1IpG9lP6/4uddxXWZQqniOb1etTLqaGWBr1Ir5Gevsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fnb4qeT9Yt4MhBhSS789gXYc6c2xVlpbBHsVmn3Exbw=;
	b=qgAADkcQFMqx3Tr5MsVNQSRh/3stXDkP0bq347oLUiGSvcOWrKKQHgfHwioLNsZzzhHR
	 5pcEnNNkCIDWSQIPIFAdxBk3fiRIS5zqEWmhrRv2dGtvJNVLi0BJlK7az4WJg3C2GWuA+
	 pVdGdt/se3rhuBTkaXTfb2RXBfGfyyTsviSkgNtRx1Ym6qB/fS3sE95WUleqwjn8ip6Cy
	 aYsfr4BFEmwgCY2BbzEt+S8N3FRG7K+T66qNW0rcvEXTfPnTyZ5+3O8C8QSM0MrC0TKr6
	 XJGB6IeL0NDac4jVReL2GJw3mXAr3oZs7QIT+KLPDT8WK0rbzKBF6eT+xXLJCGPOg7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iScpH8R5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA0606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iScpH8R5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5863F1F00A06;
	Wed, 11 Nov 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417716;
	bh=Fnb4qeT9Yt4MhBhSS789gXYc6c2xVlpbBHsVmn3Exbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iScpH8R5H+4ZbktthjJ6Bt2hatO2Un5US6oZ0oP7lcYE5Bua+RwV1lLSPNVBvi0EV
	 yZwfY1XNmo2c/0UmMTOdd2xy3O6og2qkJsl6fnQILqcHAsYOpbG696drUGrhUcpetc
	 GNKMZSiejZscAqe+mUwYmN2MY1UhGoDwQi0+VddL19Oxq/F15t+d0vhfCLyYaAxWSE
	 E/JZggZtBX4R4P4Jhn06OoTp9W/gY4DtNJ4DHq2aaMXOATKEJog12l8eHxvqXpvx2K
	 0tQQXmYi0Uk978osdmTOGbgBDG5gMcaeFLIQbjZehdJdXHIgSiANic7TYhM3xhexRl
	 aBnWGIFI3Y9IA==
Message-ID: <sashiko-outbox-209404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] riscv: probes: reject probes inside an LR/SC
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
 <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:21:55 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] riscv: probes: riscv_probe_in_lrsc_body() returns false when
  probing lr
- [Low] riscv: probes: missing Fixes trailer on LR/SC probe rejection
  fix
--

commit fa1e6ee354b2fc2997caf3fb258fcb6a4fda3097
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

> riscv: probes: reject probes inside an LR/SC sequence
>
> A kprobe or uprobe replaces an instruction with a breakpoint. The trap
> clears the hart's reservation, so if the breakpoint sits on the lr, on
> the sc, or on any instruction between them, the sc fails, the loop
> branches back to the lr and the probe fires again. The sequence never
> completes.
>
> This has always been possible on RISC-V, because cmpxchg and the
> conditional atomics are LR/SC loops. arm64 has the same problem and
> rejects probes inside an exclusive-load/store-exclusive region.
>
> Breakpoint can be on the lr unless it is part of the LR/SC loop.
>
> For the instructions between LR and SC, use the rules for a constrained
> LR/SC sequence: at most 16 instructions between lr and sc, all base
> integer instructions other than loads, stores, JALR, FENCE, SYSTEM and
> backward jumps or branches, or their compressed forms. Scan forward
> from the probed instruction. Reaching an sc through permitted
> instructions only means the probe sits inside a sequence; any other
> instruction, an lr, the end of the window or the end of the readable
> text means it does not. Only a sequence that follows these rules is
> guaranteed to make progress, so a probe inside any other one is
> already on unsupported ground. Scanning forward rather than tracking
> state from the start of the function also keeps an lr that has no sc,
> such as the one in __cmpwait() before wrs.nto, from affecting probes
> later in the same function.
>
> kprobes scan the kernel text up to the end of the enclosing symbol.
> uprobes have only the probed instruction copied, so they read the
> text that follows it from the task, which the caller's mmap_lock
> allows.
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

[Severity: Low]
Since this fixes a livelock present since kprobes and uprobes support was
added on RISC-V, should this include Fixes tags?

  Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
  Fixes: 74784081aac8 ("riscv: Add uprobes supported")

[ ... ]

> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b8882..0789754f682cb 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -4,11 +4,102 @@
>  #include <linux/kprobes.h>
>  #include <linux/module.h>
>  #include <linux/kallsyms.h>
> +#include <linux/bug.h>
>  #include <asm/sections.h>
> =20
>  #include "decode-insn.h"
>  #include "simulate-insn.h"
> =20
> +/*
> + * Can insn sit between the lr and the sc of a constrained LR/SC sequenc=
e?
> + * The ISA allows base integer instructions there, except loads, stores,
> + * JALR, FENCE, SYSTEM, backward jumps and taken backward branches, plus
> + * their compressed forms. Backward branches are treated as not allowed:
> + * the retry branch follows the sc, so one inside the body is not a
> + * constrained sequence.
> + */
> +static bool __kprobes riscv_insn_is_lrsc_body(u32 insn)
> +{
> +	u32 funct3;
> +
> +	if (GET_INSN_LENGTH(insn) =3D=3D 2) {
> +		switch (insn & RVC_INSN_OPCODE_MASK) {
> +		case RVC_OPCODE_C0:
> +			/* c.addi4spn; the rest of the quadrant is loads and stores */
> +			return (insn & RVC_INSN_FUNCT3_MASK) =3D=3D 0;
> +		case RVC_OPCODE_C1:
> +			/* Arithmetic, c.j, c.jal and branches, bit 12 is the offset sign */
> +			if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn) ||
> +			    riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
> +				return !(insn & BIT(12));
> +			return true;
> +		case RVC_OPCODE_C2:
> +			funct3 =3D (insn & RVC_INSN_FUNCT3_MASK) >> RVC_INSN_FUNCT3_OPOFF;
> +			if (funct3 =3D=3D 0)	/* c.slli */
> +				return true;
> +			if (funct3 =3D=3D 4)	/* c.mv, c.add, but not c.jr, c.jalr, c.ebreak */
> +				return !riscv_insn_is_c_jr(insn) &&
> +				       !riscv_insn_is_c_jalr(insn) &&
> +				       !riscv_insn_is_c_ebreak(insn);
> +			return false;	/* stack loads and stores */
> +		}
> +		return false;
> +	}
> +
> +	switch (insn & RV_INSN_OPCODE_MASK) {
> +	case RVG_OPCODE_OP_IMM:
> +	case RVG_OPCODE_OP_IMM_32:
> +	case RVG_OPCODE_LUI:
> +	case RVG_OPCODE_AUIPC:
> +		return true;
> +	case RVG_OPCODE_OP:
> +	case RVG_OPCODE_OP_32:
> +		/* funct7 0 or 0x20 is base I; anything else is M, B or another extens=
ion */
> +		return !((insn & RV_INSN_FUNCT7_MASK) & ~(0x20U << RV_INSN_FUNCT7_OPOF=
F));
> +	case RVG_OPCODE_BRANCH:
> +	case RVG_OPCODE_JAL:
> +		/* forward only, bit 31 is the offset sign */
> +		return !(insn & BIT(31));
> +	}
> +	return false;
> +}
> +
> +/*
> + * Does the instruction at the start of buf lie inside a constrained LR/=
SC
> + * sequence? Such a sequence holds at most RISCV_LRSC_MAX_BODY instructi=
ons
> + * between the lr and the sc, all from the set above. Walk forward from =
the
> + * probed instruction: reaching an sc through permitted instructions only
> + * means the probe sits in the body; anything else, including an lr that
> + * opens a new sequence, means it does not. The walk stops at the end of
> + * buf, so a short buffer only makes the answer more permissive.
> + */
> +bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
> +{
> +	size_t off =3D 0;
> +	u32 insn;
> +	int n;
> +
> +	for (n =3D 0; n < RISCV_LRSC_MAX_BODY + 2; n++) { // 2 for LR and SC it=
self
> +		if (off + 2 > len)
> +			return false;
> +		insn =3D buf[off / 2];
> +		if (GET_INSN_LENGTH(insn) =3D=3D 4) {
> +			if (off + 4 > len)
> +				return false;
> +			insn |=3D (u32)buf[off / 2 + 1] << 16;
> +		}
> +		/* if probed instruction is not lr, scan one instruction less */
> +		if (n =3D=3D 0 && !riscv_insn_is_lr(insn))
> +			n++;
> +		if (riscv_insn_is_sc(insn))
> +			return true;
> +		if (!riscv_insn_is_lrsc_body(insn))
> +			return false;

[Severity: High]
Does riscv_probe_in_lrsc_body() always return false when the probed
instruction at n =3D=3D 0 is lr?

When riscv_insn_is_lr(insn) is true at n =3D=3D 0, execution still falls
through to riscv_insn_is_lrsc_body(insn).  Because riscv_insn_is_lrsc_body()
rejects RVG_OPCODE_AMO, it returns false on the first iteration without
scanning for a matching sc, allowing probes on lr inside an LR/SC loop to
be accepted and livelock when single-stepped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-probes-in-=
lrsc-v2-0-b2525b7e1e8e@mobileye.com?part=3D2
