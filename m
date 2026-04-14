Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1F2DA75C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186704; cv=none; b=rGvYpeYCb6khhN2jIHOlDWcxUvQhgDD/mdMUCOw5DNE+tWQnKDKQYBe21iBZf8R0wJCeEMGMOL46NxY9Vcg1gccCdNydU7vDCeV+BOiCA+OfgK6obtniwBc1aZaPzzjpB4JStSicqqJg/4oV7WDbizVQt0e+zyMGq3tLiLSwoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186704; c=relaxed/simple;
	bh=tQFfyfhVurzi6HFvZeSjwn3hHXowrfiG+0GHddv7jiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN66H1RSjsqoFHn/wtnlMRKCB4iWfWGp/d/QZ9QE0Asm6S9VNZIY5B/U877YXS00tPo8WpR5dct0WlD0gR5Pjpuo7tLASa6FmYZpxnCk4tQjG3iNirwXyAVSJTMQmuyRhz0Hobw4ypfx5EW6kgrew+1wPznKeshk7CavgPU4V0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CME/EBdY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CME/EBdY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so91913895e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186700; x=1776791500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqMuMIPqGZhECnMazPqsxGt2Vxf0shcWAHgruuCSXf0=;
        b=CME/EBdY9L74hYFF9vBUko5k+4Vc3Qd589sBnhZziKWNlKjOTWFuQXR2g0DtMk3cPx
         D985wTq8bgQNKijg7HyNW+LmHruZWmG1jBW1HyMd4dsOIHGPymNemmGDe3l7QOMpAIJf
         U0KV9aVhiyVpKVRdJH/f4PrZf2iHTGf3heLISUdkGv3BnTLmLOnT8ROHMg8eW6a1TUGE
         +Kja12xuT5weHWJXJn7neTDTbqCsdY8Yg/rkLcO7TFeTAQ7hxZHs///pCQiNAAYG6bWP
         Eukzjao68BzxDaNvicXgKDhyp6wUVwx0DSZZ4E0Ocf8U9TuJo/xKd68ikr/NiLpBAZBU
         pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186700; x=1776791500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqMuMIPqGZhECnMazPqsxGt2Vxf0shcWAHgruuCSXf0=;
        b=N+aYWXvf7Y12yW+Yp1ad0/7CqXOtVNcb00G4hBVDGysa2RWicR+cLlhbCvM7sUJKiu
         0Ge3zI+leq6bZQqPYUchl8Q073Hc2L83m5+wR4PJsToBNbz+29A4CMiUr9vrjIFe50LT
         k1A6506JSIgxDTVYaw6KMkBQstRKtvOE57lQz28LNLUgg8E/SBUfc55cH7UXIGAmqveQ
         pMGVQacU88hcxS7QNfLkubLm8ZL3qWP0crqpFNcqercfL5INloPf8trf57KD3y286Cw4
         u6X09SsFPcFZaDULuAbKIBPQ0vpEm4VNLo3UvIRXuvshoCz+KPQkF4V5f8SLCA8LyXyi
         rqJg==
X-Forwarded-Encrypted: i=1; AFNElJ/DIGxuQLiGIJ/1K5XJWITu213ftCoAurnWLirI6kkYJufkjKb4WtYQ9xDyKP1eExeFS3advCJAbMBiTIog/CVoy4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XUEs22sOps+wvBjty8D7fvzx+kjVyGrZy5Ej6j0CKfGQ0enw
	AXI7WzzK/XTxGkjJ0t569p7RLu7kBm5WwROap1G4z2vSfvHQWaVf6lIW
X-Gm-Gg: AeBDieuzZi5v1aaFUdZkz0I97LdUPIatnNQSRd1r01WTf0RTpYx6/wC/2bjYpTmXR8Q
	FNnJPGuCc+1zopYzPIZ3fyW7qdodcTK+82uucVxaPeuphjVdT70YsJuOrL/cPNKFkh+Zqnz2iwb
	Wmoqj0QtbvV5YvqRizORns4fX+4e+lscYuICnr4att+R3WypTZk67gc4fQ2H6jEC6oEHGO1eNYz
	1DnbDFuRisdME1x1XUsfR6bZyooaGxXwi/16opqFE8hzi9NFfWPsmvZatsNvbecaX26oS9eTQZ1
	gv4BOiWt37mpGqbf6aKAsHuHXKAT5hR8xPx46eDfx443o73U82GQvRmSWyh5MQABtRHzJE6iF2V
	7Eq89GEUWC83wxCgQibBYh9mpZb2KX/ELpENzIzLJWQM0lxlrv/qGbAaqr0WZ2AUeZQstgxGGqO
	YcF69ITaC0DBbNpTRHVHI31cqF+nIpoeE29l0+J1Ng1a/TlDrHqQEMSXblE0dtDZZe7FisRi9d7
	0l4ZL7HB4aYaADx
X-Received: by 2002:a05:600c:4504:b0:488:9db9:5235 with SMTP id 5b1f17b1804b1-488d6867c23mr248019775e9.22.1776186699706;
        Tue, 14 Apr 2026 10:11:39 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee019e44sm111827645e9.15.2026.04.14.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:11:38 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:11:37 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	rostedt@goodmis.org, ardb@kernel.org, chenmiao.ku@gmail.com,
	johannes@sipsolutions.net, nsc@kernel.org, masahiroy@kernel.org,
	tytso@mit.edu, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] openrisc: Add utilities and clean up simulation of
 instructions
Message-ID: <ad51SeeF2Gv06mgQ@antec>
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
 <20260407185650.79816-2-sahilcdq0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407185650.79816-2-sahilcdq0@gmail.com>

Hello Sahil,

Thanks for your patches.  I have a few questions. so this is not really a
technical review at the moment just some main items.

On Wed, Apr 08, 2026 at 12:26:49AM +0530, Sahil Siddiq wrote:
> Introduce new instruction-related utilities and macros for OpenRISC.
> This is in preparation for patches that add tracing support such as
> KProbes.
> 
> Simulate l.adrp. Fix bugs in simulation of l.jal and l.jalr. Earlier,

Why emulate l.adrp?  We don't really use this yet in any OpenRISC code.  This
instruction is meant to be used to help -fpic code, see:

  https://openrisc.io/proposals/ladrp

> PC was being updated and then saved in the link register r9, resulting
> in a corrupted page table (bad page map in process). Instead, update
> PC after storing it in r9.
> 
> Move instruction simulation to its own file to enable reuse. Clean it
> up and replace hardcoded values with computed expressions.
> 
> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> ---
>  arch/openrisc/include/asm/insn-def.h | 61 +++++++++++++++++++++--
>  arch/openrisc/include/asm/spr_defs.h |  1 +
>  arch/openrisc/kernel/Makefile        |  2 +-
>  arch/openrisc/kernel/insn.c          | 74 ++++++++++++++++++++++++++++
>  arch/openrisc/kernel/jump_label.c    |  2 +-
>  arch/openrisc/kernel/traps.c         | 41 +--------------
>  6 files changed, 136 insertions(+), 45 deletions(-)
>  create mode 100644 arch/openrisc/kernel/insn.c
> 
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> index 1e0c028a5b95..c98f9770c52e 100644
> --- a/arch/openrisc/include/asm/insn-def.h
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -3,13 +3,66 @@
>   * Copyright (C) 2025 Chen Miao
>   */
>  
> +#include <asm/spr.h>
> +#include <asm/spr_defs.h>
> +
>  #ifndef __ASM_OPENRISC_INSN_DEF_H
>  #define __ASM_OPENRISC_INSN_DEF_H
>  
> -/* or1k instructions are always 32 bits. */
> -#define	OPENRISC_INSN_SIZE		4
> -
>  /* or1k nop instruction code */
> -#define OPENRISC_INSN_NOP     0x15000000U
> +#define INSN_NOP	0x15000000U

Why remove the OPENRISC_ namespace from thse definitions?

Other architectures like arm64, riscv have namespaces on these similar
definitions.

> +
> +#define INSN_CSYNC	0x23000000U
> +#define INSN_MSYNC	0x22000000U
> +#define INSN_PSYNC	0x22800000U
> +
> +#define OPCODE_TRAP	0x21000000U
> +#define OPCODE_SYS	0x20000000U
> +#define OPCODE_MACRC	0x18010000U
> +
> +struct pt_regs;
> +
> +enum six_bit_opcodes {

I don't see why we need to name this six_bit as such.  OpenRISC
instructions have either fir most significant 6-bits or 11-bits
as opcodes but we still use the first 6-bits to drive the logic.

> +	l_rfe = 0x09,
> +	l_lwa = 0x1b,
> +	l_mfspr = 0x2d,
> +	l_mtspr = 0x30,
> +	l_swa = 0x33,
> +	l_j = 0x00,
> +	l_jal = 0x01,
> +	l_adrp = 0x02,
> +	l_bnf = 0x03,
> +	l_bf = 0x04,
> +	l_jr = 0x11,
> +	l_jalr = 0x12,
> +};
> +
> +struct insn {
> +	unsigned int opcode: 6;
> +	unsigned int operands: 26;
> +};
> +
> +union openrisc_instruction {
> +	unsigned int word;
> +	struct insn opcodes_6bit;
> +};
> +
> +#define OPENRISC_INSN_SIZE  (sizeof(union openrisc_instruction))
> +
> +/* Helpers for working with l.trap */
> +static inline unsigned long __emit_trap(unsigned int code)
> +{
> +	return (code & 0xffff) | OPCODE_TRAP;
> +}
> +
> +static inline bool has_delay_slot(void)
> +{
> +	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
> +
> +	return !(cpucfgr & SPR_CPUCFGR_ND);
> +}

This is for handling CPU's that do not have delay slots.  We didn't do this
before, why are you doing it now?  Should we mention this in the git commit
message?

Also, since this is a static configuration for the CPU should we use static keys
for this?

> +
> +void simulate_pc(struct pt_regs *regs, unsigned int jmp);
> +void simulate_branch(struct pt_regs *regs, unsigned int jmp, bool has_delay_slot);
>  
>  #endif /* __ASM_OPENRISC_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
> index f0b6b492e9f4..5d13a9b96263 100644
> --- a/arch/openrisc/include/asm/spr_defs.h
> +++ b/arch/openrisc/include/asm/spr_defs.h
> @@ -179,6 +179,7 @@
>  #define SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
>  #define SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
>  #define SPR_CPUCFGR_OV64S  0x00000200  /* ORVDX64 supported */
> +#define SPR_CPUCFGR_ND     0x00000400  /* No delay slot */
>  #define SPR_CPUCFGR_RES	   0xfffffc00  /* Reserved */
>  
>  /*
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 19e0eb94f2eb..150779fbf010 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -5,7 +5,7 @@
>  
>  always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>  
> -obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
> +obj-y	:= head.o insn.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
>  	   sys_call_table.o unwinder.o cacheinfo.o
>  
> diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
> new file mode 100644
> index 000000000000..2c97eceee6d7
> --- /dev/null
> +++ b/arch/openrisc/kernel/insn.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * OpenRISC instruction utils
> + *
> + * Linux architectural port borrowing liberally from similar works of
> + * others.  All original copyrights apply as per the original source
> + * declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#include <linux/ptrace.h>
> +#include <asm/insn-def.h>
> +
> +void simulate_pc(struct pt_regs *regs, unsigned int jmp)
> +{
> +	int displacement;
> +	unsigned int rd, op;
> +
> +	displacement = sign_extend32(((jmp) & 0x7ffff) << 13, 31);
> +	rd = (jmp & 0x3ffffff) >> 21;
> +	op = jmp >> 26;
> +
> +	switch (op) {
> +	case l_adrp:
> +		regs->gpr[rd] = displacement + (regs->pc & (-8192));
> +		return;
> +	default:
> +		break;
> +	}
> +}

This function is not used, what will it be used for? Could you mention it in the
commit message?  Also could you document it?

> +
> +void simulate_branch(struct pt_regs *regs, unsigned int jmp_insn, bool has_delay_slot)

Since you are using this for more than just instruction simulation now, maybe
its good to document what it does. For example when we use it below we surround
it with the in_delay_slot check.

> +{
> +	int displacement;
> +	unsigned int rb, op, jmp;
> +
> +	displacement = sign_extend32(((jmp_insn) & 0x3ffffff) << 2, 27);
> +	rb = (jmp_insn & 0x0000ffff) >> 11;
> +	op = jmp_insn >> 26;

Naming this variable jmp is a bit misleading.  Maybe something like
link_displacement, link_offset or fallthrough?

> +	jmp = has_delay_slot ? 2 * OPENRISC_INSN_SIZE : OPENRISC_INSN_SIZE;
> +
> +	switch (op) {
> +	case l_j: /* l.j */
> +		regs->pc += displacement;
> +		return;
> +	case l_jal: /* l.jal */
> +		regs->gpr[9] = regs->pc + jmp;
> +		regs->pc += displacement;
> +		return;
> +	case l_bnf: /* l.bnf */
> +		if (regs->sr & SPR_SR_F)
> +			regs->pc += jmp;
> +		else
> +			regs->pc += displacement;
> +		return;
> +	case l_bf: /* l.bf */
> +		if (regs->sr & SPR_SR_F)
> +			regs->pc += displacement;
> +		else
> +			regs->pc += jmp;
> +		return;
> +	case l_jr: /* l.jr */
> +		regs->pc = regs->gpr[rb];
> +		return;
> +	case l_jalr: /* l.jalr */
> +		regs->gpr[9] = regs->pc + jmp;
> +		regs->pc = regs->gpr[rb];
> +		return;
> +	default:
> +		break;
> +	}
> +}
> diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
> index ab7137c23b46..fe082eb847a4 100644
> --- a/arch/openrisc/kernel/jump_label.c
> +++ b/arch/openrisc/kernel/jump_label.c
> @@ -34,7 +34,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>  
>  		insn = offset;
>  	} else {
> -		insn = OPENRISC_INSN_NOP;
> +		insn = INSN_NOP;
>  	}
>  
>  	if (early_boot_irqs_disabled)
> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index c195be9cc9fc..ee87a3af34fc 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c
> @@ -32,6 +32,7 @@
>  
>  #include <asm/bug.h>
>  #include <asm/fpu.h>
> +#include <asm/insn-def.h>
>  #include <asm/io.h>
>  #include <asm/processor.h>
>  #include <asm/unwinder.h>
> @@ -269,47 +270,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
>  
>  static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
>  {
> -	int displacement;
> -	unsigned int rb, op, jmp;
> -
>  	if (unlikely(in_delay_slot(regs))) {
>  		/* In delay slot, instruction at pc is a branch, simulate it */
> -		jmp = *((unsigned int *)regs->pc);
> -
> -		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
> -		rb = (jmp & 0x0000ffff) >> 11;
> -		op = jmp >> 26;
> -
> -		switch (op) {
> -		case 0x00: /* l.j */
> -			regs->pc += displacement;
> -			return;
> -		case 0x01: /* l.jal */
> -			regs->pc += displacement;
> -			regs->gpr[9] = regs->pc + 8;
> -			return;
> -		case 0x03: /* l.bnf */
> -			if (regs->sr & SPR_SR_F)
> -				regs->pc += 8;
> -			else
> -				regs->pc += displacement;
> -			return;
> -		case 0x04: /* l.bf */
> -			if (regs->sr & SPR_SR_F)
> -				regs->pc += displacement;
> -			else
> -				regs->pc += 8;
> -			return;
> -		case 0x11: /* l.jr */
> -			regs->pc = regs->gpr[rb];
> -			return;
> -		case 0x12: /* l.jalr */
> -			regs->pc = regs->gpr[rb];
> -			regs->gpr[9] = regs->pc + 8;
> -			return;
> -		default:
> -			break;
> -		}
> +		simulate_branch(regs, *((unsigned int *)regs->pc), has_delay_slot());
>  	} else {
>  		regs->pc += 4;
>  	}
> -- 
> 2.53.0
> 
