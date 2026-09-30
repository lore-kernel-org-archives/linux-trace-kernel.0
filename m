Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0024E2F20
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801167; cv=none; b=VY+ggCc/h7/1G0h1by0IoWe3EwV1w7y2AGRdmiByxIPeFCvvxacFEj/r90hPjN2aFI4HUjL0hn5g6ZFtLzsZMoG+OWS46t5Va5dhuiYaUiw0lgJG1IapubCNBzHJmpax3pqYTQuV66zITTNEAFthVxaNLuNyC4X2NTR5PKYEz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801167; c=relaxed/simple;
	bh=g47kOafakZM3nHLAcsnEs80cq9NEHltQwu9KTbDIsr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aKiAWRW9YyeQNhRMVi2lnfygD4AVkbPsqmfbc3D0QOWYHTgchPhI1KmD0lRaNq35KGVcJUz6GYHnnXIMlYml1czr7W3HWDBVxOeSR1aWIt4jCYnqAcCVsgx+lyd2LB1T2LKmBwCzbch5LBTEBPQX/HgX99maDZIngKPjsIAz2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSZbUiIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSZbUiIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389441F000FF;
	Wed, 30 Sep 2026 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790801165;
	bh=xy4clPnuc/mQvi24a9/239NtxZTpzw00EZDX8wwaGQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSZbUiIYhMkRK8bZiDd1AySa2xWU2ll7CpnZzZcZycky1baZHKrs5vjrU/1A69pfl
	 ThhcM2DtYwOEgc3AMdW05hgIZcd18YMTx6biSCDrYg8un9J2dJUxY/m06yMhM78VbE
	 bN6dlHPRX5oVa21wNlXHRukU9drA4vIZWrc3PvdI6NyRh9088OfTDOHS+Uee80f+/z
	 i/HjsMM7C1aVaohdG2lbmV2wDLdv4YQAwC51lmolfZ59gdSo06rXHQdqBjTR3g3RHd
	 fqpwhmwKIkagnK0ewxm8Tzmhp0OB3q+bosi0BCYa+Q5MocTkqz1B6lFKmpyqS8NT2J
	 /oRops2MbZ4uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] openrisc: Add KProbes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930203129.51048-3-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
 <20260930203129.51048-3-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:46:04 +0000
Message-Id: <20260930204605.389441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] kprobes: unsafe direct memory access in arch_prepare_kprobe()
- [High] kprobes: unsafe direct memory access in kprobe_breakpoint_handler()
- [High] kprobes: SSOL executes with interrupts enabled due to missing regs=
->sr update
- [High] kprobes: preemption count and lockdep state leak on KPROBE_REENTER
- [Medium] kprobes: missing NOKPROBE_SYMBOL() for simulate_branch() and sim=
ulate_pc()
- [Medium] kprobes: l.jalr state corruption on delay slot page fault
--

commit a255007d852431d07365105e6070af0de294b166
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add KProbes
   =20
Add KProbes support for OpenRISC, based on similar work done for LoongArch,
MIPS and RISC-V. KProbes make it possible to trap at almost any address in =
the
kernel to collect performance/debugging info.

> diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobe=
s.c
> new file mode 100644
> index 0000000000000..3268ffb0d7077
> --- /dev/null
> +++ b/arch/openrisc/kernel/kprobes.c

[ ... ]

> +int arch_prepare_kprobe(struct kprobe *p)
> +{

[ ... ]

> +	if (insns_need_simulation(insn, &exec_delay_slot) && !exec_delay_slot) {
> +		p->ainsn.insn =3D NULL;
> +	} else {
> +		/*
> +		 * Single step probed instruction or, in case of branch instructions, =
single
> +		 * step instruction in delay slot.
> +		 */
> +		p->ainsn.insn =3D get_insn_slot();
> +		if (!p->ainsn.insn)
> +			return -ENOMEM;
> +
> +		if (exec_delay_slot)
> +			patch_insn_write(p->ainsn.insn, *(p->addr + 1));

[Severity: High]
Does this directly dereference p->addr + 1, bypassing the safety provided
by copy_from_kernel_nofault() used earlier in the function? If the delay sl=
ot
instruction falls into an unmapped page, couldn't this cause a kernel panic
during probe registration?

> +		else
> +			patch_insn_write(p->ainsn.insn, p->opcode);
> +		patch_insn_write(&p->ainsn.insn[1], KPROBE_SSTEPBP_INSN);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static void post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk=
 *kcb,
> +				struct pt_regs *regs)
> +{
> +	instruction_pointer_set(regs, kcb->restore_pc);
> +
> +	if (kcb->kprobe_status =3D=3D KPROBE_REENTER) {
> +		restore_previous_kprobe(kcb);
> +		return;

[Severity: High]
Does this early return skip calling preempt_enable_no_resched()? If a reent=
rant
kprobe finishes single-stepping, this seems to permanently leak the preempt=
ion
count disabled in kprobe_breakpoint_handler(), which could lead to a system
lockup.

> +	}
> +
> +	kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
> +
> +	if (cur->post_handler)
> +		cur->post_handler(cur, regs, 0);
> +
> +	reset_current_kprobe();
> +	preempt_enable_no_resched();
> +}

[ ... ]

> +static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> +			     struct kprobe_ctlblk *kcb, int reenter)
> +{
> +	kprobe_opcode_t insn;
> +
> +	if (reenter) {
> +		save_previous_kprobe(kcb);
> +		set_current_kprobe(p);
> +		kcb->kprobe_status =3D KPROBE_REENTER;
> +	} else {
> +		kcb->kprobe_status =3D KPROBE_HIT_SS;
> +	}
> +
> +	/* Emulate instruction if required. */
> +	insn =3D p->opcode;
> +	if (is_branch_insn(insn)) {
> +		simulate_branch(regs, insn);

[Severity: Medium]
Since simulate_branch() and simulate_pc() are executed during Kprobe handli=
ng,
should they be marked with NOKPROBE_SYMBOL() in arch/openrisc/kernel/insn.c?
Without it, placing a kprobe on these functions and hitting another branch-=
related
kprobe could cause a reentrant probe loop and trigger the "Unrecoverable KP=
robe
detected" panic.

> +		/* Save target addr before updating PC to SSOL slot */
> +		kcb->restore_pc =3D regs->pc;
> +	} else if (is_pc_insn(insn)) {
> +		simulate_pc(regs, insn);
> +		kcb->restore_pc =3D regs->pc;
> +		/* No SSOL is required here, so call post-process immediately. */
> +		post_kprobe_handler(p, kcb, regs);
> +		return;
> +	} else
> +		kcb->restore_pc =3D regs->pc + OPENRISC_INSN_SIZE;
> +
> +	if (p->ainsn.insn) {
> +		/* Disable IRQs before single stepping */
> +		local_irq_save(kcb->irq_flags);

[Severity: High]
Does this only disable interrupts for the exception handler itself, without
modifying regs->sr? Since OpenRISC's exception handler returns using regs->=
sr,
it appears the single-step out-of-line (SSOL) instruction would execute with
interrupts enabled, violating atomicity and allowing reentrant interrupts.

> +		instruction_pointer_set(regs, (unsigned long)p->ainsn.insn);
> +	} else {
> +		/*
> +		 * The instruction is a branch but delay slots are disabled.
> +		 * Simply call the post-handler.
> +		 */
> +		post_kprobe_handler(p, kcb, regs);
> +	}
> +}

[ ... ]

> +bool kprobe_breakpoint_handler(struct pt_regs *regs)
> +{

[ ... ]

> +	/*
> +	 * The breakpoint instruction was removed right after we hit it
> +	 * possibly by another cpu. If the original instruction was also
> +	 * a trap instruction then return to the trap handler for further
> +	 * processing, else no further processing is required.
> +	 */
> +	if (get_kernel_nofault(insn, addr) < 0
> +		|| (*addr & OPENRISC_MASK_TRAP) !=3D OPENRISC_INSN_TRAP) {

[Severity: High]
Is this directly dereferencing *addr instead of using the safely read 'insn'
variable? If the probe is concurrently unregistered and the memory is unmap=
ped,
dereferencing *addr directly could cause a kernel panic, defeating the safe=
ty of
get_kernel_nofault().

> +		preempt_enable_no_resched();
> +		return true;
> +	}
> +
> +	preempt_enable_no_resched();
> +	return false;
> +}

[ ... ]

> +int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +	struct kprobe *cur =3D kprobe_running();
> +	struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> +
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		/*
> +		 * The instruction being single-stepped caused a page fault.
> +		 * Reset the current KProbe and set PC to the probe's address.
> +		 * Then allow the page fault handler to continue as usual.
> +		 */
> +		instruction_pointer_set(regs, (unsigned long)cur->addr);

[Severity: Medium]
If a page fault occurs during the delay slot of an "l.jalr r9" instruction,
doesn't rewinding the PC to the branch instruction cause state corruption?
simulate_branch() permanently modifies regs->gpr[9], so re-executing the
branch after the fault handler returns would jump to the return address ins=
tead
of the original target.

> +
> +		if (kcb->kprobe_status =3D=3D KPROBE_REENTER) {
> +			restore_previous_kprobe(kcb);

[Severity: High]
Does this KPROBE_REENTER path skip local_irq_restore() and
preempt_enable_no_resched()? This appears to leak the preemption count and
corrupt the lockdep state when a page fault occurs during a reentrant kprob=
e.

> +		} else {
> +			regs->sr |=3D kcb->irq_flags;
> +			local_irq_restore(kcb->irq_flags);
> +			reset_current_kprobe();
> +			preempt_enable_no_resched();
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930203129.5104=
8-1-sahilcdq0@gmail.com?part=3D2
