Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE484E2F20
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801192; cv=none; b=ZeISkcjYw2z/IAf3i97gsSpLY450+SDDx9WAhHxJPJbQqA2VYJR8PyNv6trovSJPj63asuksnmvRGsERr8fuGJLEpFrMd9CU4O2E0YFrU9pXKn/KDXf2+wszYz0bZPqIfrJaDT6to1Wp2hRKsDTRcoKgp974vhHyPTvy0vppCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801192; c=relaxed/simple;
	bh=Rdzjp3sw1dlqpcPMGe9dhLiVAtW6Zw0neKxa/ZZEf3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gVD0bcU2CYANCDVgxVyLQKoqUR7CD6DhwkRr1V7K7prvcCXLg0dxur0mh2vWlsx1aUOQehg8Be4K7CDYhZdJQMYadSgURU4KLN5QFcSy37DwEXQLJhSXwPWTFs8XQLmnHcuyg/XtfzsAOmZMj9mg9HthLr3d5P8VnPlZXzwpuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJHVCmqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJHVCmqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E971F000FF;
	Wed, 30 Sep 2026 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790801191;
	bh=BNqhjjSrnu5p/4yAp2EfgK+mWjc9SqEI0NzOZ8/JVi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJHVCmqUYRBtZ1D36IyvY3xAQ6XQF3dyc65kRwQNxqgufPCXpIKDrpd8knD3tB2Qj
	 SGRjnvvh2N7NTAV5Rxja0HI6vBORW3+e4cWicaPOGyH21meCFogl0u2Mv1nXD24SLB
	 7dWRas42dxN3H8fISvkLNM64jg7oN47eFhFC92L4paxjborycQtUl3nTT39g1criCA
	 bdqe9A89W2O0dx1iGJLqtAksVsnn4LNUCh8VrOOGVUl0AX7bSqReDFoJA3cTFMBhh3
	 lwqZ3EmhI3IIQ4FbUjeZar/NO2/u0G7gMUxnmZsXbtGkBGIlP+IBOHh46hUEaMsfz1
	 s+pq/CQQGgRdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] openrisc: Add utilities and clean up simulation
 of instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930203129.51048-2-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
 <20260930203129.51048-2-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:46:30 +0000
Message-Id: <20260930204630.E2E971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] openrisc: instruction simulator corrupts sr via gpr[0] aliasing
- [High] openrisc: silent text patching failure on RO memory
- [Low] build: undefined Kprobe constants and handlers in traps.c
--

commit 55276d42aa86ee1b0ca046c1e956df26c99385de
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add utilities and clean up simulation of instructions

Introduce new instruction-related utilities and macros for OpenRISC.
This is in preparation for patches that add tracing support such as
KProbes and Kretprobes.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1=
.4-rev0.pdf

> diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
> new file mode 100644
> index 0000000000000..285658512b433
> --- /dev/null
> +++ b/arch/openrisc/kernel/insn.c

[ ... ]

> +void simulate_pc(struct pt_regs *regs, unsigned long pc_insn)
> +{
> +	int page_offset;
> +	unsigned int rd, op;
> +
> +	page_offset =3D sign_extend32(
> +		(pc_insn & OPENRISC_ADRP_IMM_MASK) << OPENRISC_ADRP_IMM_SHIFT, 31);
> +	rd =3D (pc_insn & OPENRISC_ADRP_REG_MASK) >> OPENRISC_ADRP_REG_SHIFT;
> +	op =3D get_6_bit_opcode(pc_insn);
> +
> +	switch (op) {
> +	case OPENRISC_OPCODE_ADRP:
> +		regs->gpr[rd] =3D page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);

[Severity: High]
Does this code corrupt the Status Register (sr) if rd is 0?

In OpenRISC's pt_regs, gpr[0] aliases to the Status Register (sr). If a pro=
be
is placed on an instruction like l.adrp r0, ..., writing to regs->gpr[rd]
without checking if rd =3D=3D 0 could inadvertently overwrite the kernel's =
sr.

> +		regs->pc +=3D OPENRISC_INSN_SIZE;
> +		return;
> +	default:
> +		break;
> +	}
> +}
> +
> +void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
> +{
> +	int displacement;
> +	unsigned int rb, op, link_offset, temp;
> +
> +	displacement =3D sign_extend32(
> +		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
> +	rb =3D (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
> +	op =3D get_6_bit_opcode(jmp_insn);
> +	link_offset =3D OPENRISC_INSN_SIZE;

[ ... ]

> +	switch (op) {
> +	case OPENRISC_OPCODE_J: /* l.j */
> +		regs->pc +=3D displacement;
> +		return;

[ ... ]

> +	case OPENRISC_OPCODE_JR: /* l.jr */
> +		regs->pc =3D regs->gpr[rb];

[Severity: High]
Similarly, does this code read the Status Register instead of 0 if rb is 0?

Since gpr[0] aliases to sr in pt_regs, an instruction like l.jr r0 would end
up reading the sr rather than 0 in simulate_branch().

> +		return;
> +	case OPENRISC_OPCODE_JALR: /* l.jalr */
> +		temp =3D regs->pc + link_offset;
> +		regs->pc =3D regs->gpr[rb];
> +		regs->gpr[9] =3D temp;
> +		return;
> +	default:
> +		break;
> +	}
> +}

> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 000a9cc10e6f6..0f69c36472d55 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -255,6 +255,10 @@ void __init setup_arch(char **cmdline_p)
>  	/* paging_init() sets up the MMU and marks all pages as reserved */
>  	paging_init();
> =20
> +	/* determine if the processor supports delay slots */
> +	if (mfspr(SPR_CPUCFGR) & SPR_CPUCFGR_ND)
> +		static_branch_disable(&delay_slot);
> +

[Severity: High]
Does this static branch update silently fail to patch read-only memory?

Since this is called immediately after paging_init() marks the kernel text
as read-only, and interrupts are disabled, jump label text patching will
fall back to copy_to_kernel_nofault(). This might silently fail to write
to the read-only memory, leaving the delay_slot key incorrectly enabled
on CPUs without delay slots and leading to corrupted return addresses.

>  	*cmdline_p =3D boot_command_line;
> =20
>  	printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");

> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index c195be9cc9fcc..c9ab630ec8950 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c

[ ... ]

> @@ -215,6 +216,32 @@ asmlinkage void do_trap(struct pt_regs *regs, unsign=
ed long address)
>  	if (user_mode(regs)) {
>  		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
>  	} else {
> +		unsigned long trap, bcode;
> +
> +		if (get_kernel_nofault(trap, (unsigned long *)regs->pc) < 0)
> +			return;
> +
> +		/*
> +		 * Trap instruction was probably removed and no further processing
> +		 * is required.
> +		 */
> +		if ((trap & OPENRISC_MASK_TRAP) !=3D OPENRISC_INSN_TRAP)
> +			return;
> +
> +		bcode =3D (trap & OPENRISC_MASK_BCODE);
> +		switch (bcode) {
> +		case BRK_KPROBE_BP:
> +			if (kprobe_breakpoint_handler(regs))

[Severity: Low]
Will this unconditionally break the build during a git bisect?

BRK_KPROBE_BP and kprobe_breakpoint_handler() do not appear to be defined
until a follow-up commit ("openrisc: Add KProbes"). Introducing their usage
here in do_trap() will result in undefined constants and undeclared functio=
ns
when compiling this commit.

> +				return;
> +			break;
> +		case BRK_KPROBE_SSTEPBP:
> +			if (kprobe_singlestep_handler(regs))
> +				return;
> +			break;
> +		default:
> +			break;
> +		}
> +
>  		pr_emerg("KERNEL: Illegal trap exception 0x%.8lx\n", regs->pc);
>  		die("Die:", regs, SIGILL);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930203129.5104=
8-1-sahilcdq0@gmail.com?part=3D1
