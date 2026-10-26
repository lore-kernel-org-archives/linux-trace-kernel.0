Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046916;
	b=lARCYNCxEsSGF8ccVaYDaOtiFbj7rQrvbFTM/X3GmMI5VeCW+6EK7Wv3d/7ELVImSej1
	 Sakpb9MQoiswbyEoIj6/knA3+lzipDtbWrM4XsSn09H2JYHeLy4Hv11iKYQQwJAh0hxqN
	 afg2sB48Oe+MrguWculdgd4WCph/+jRYy8M89a/tCWhJZVEqmtR4oTAl5RKrt/MVVKJPs
	 5L6cExXOBumCboJFmcd8XhtydTHvo9NTZIUy/ZKxVAYsZ4f1SYJzB+IFe5ZGlkVtCQSRv
	 wMNFNkgrHGsKkSrO3f4eFfYo71r1bXUGoDBoPaFPL7hBA70FyHA+I0L89+1mtIispuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=de9kZLbkmNhJQv31HcUDFu3JKxMke+dCKPkScF18UIo=;
	b=f8a2q3jonDyG+ePdgULWujWSTh76ZoRZYYMyD2W98VNXiVN14HwHtwi4rD1VdLGoXfr2
	 0+mDu9VvzDNg71Xbg9EUBispiP6vqufcz57ZTPjcKkT8QYW1LmHQfpfMyult5NDGnnV6h
	 PHKi0iXb0aTQgwVaetxF/h7SaDjMq7xzugKc8zzc+Bhvx+RvqKjsOSc/c5OQbFd54z+BG
	 TtzgFQ5jihVaFdn1oAY/SHHdXlReKH1I/g1vhKcCAbwRZlZBsfVU6CGiftYGGB09sRauq
	 +5AAUTjTKrCuKZ71XkBENJYx0D9dFt+mgFV9eJyB1CyB0pEAG7fIINl8uwnPRru5N/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a75jJtrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A5606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a75jJtrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B331F01825;
	Mon, 26 Oct 2026 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793046915;
	bh=de9kZLbkmNhJQv31HcUDFu3JKxMke+dCKPkScF18UIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a75jJtrARanrhBjyjuMmMK5ydDpFSx3rEWXyjFwOnAVsDZGooBVHLuDvINU/vHvvb
	 URls2j+ZlFZB/TgcmIA9GNITULz+eJw6JRaL2Q2I68xMIfBb5U9slxh+vA8iX4MI8C
	 +v6w5tpxIe9HL6KBZG0LaOr4R5bWuXyzGY1qVG39RsGdC6rpBTlL9R7oYd1AY+fjxl
	 T/3IfPc3Xu3sHT+NBzX2d/7aFuNP+N4qHJGfV6DYmmzppJ2MRtuDNY/j7xq1lj7Bap
	 LY9JREBchXlr5Zk1+zVxX0SEWrA2ONylJTb5BN7Vo7D9JsNqVF8syVrF3m8CX4dJ98
	 w3mGB+MXRVL0w==
Message-ID: <sashiko-outbox-185730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] openrisc: Add KProbes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026201240.107462-3-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-3-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:35:14 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] openrisc: kprobes: kprobe_local_irq_restore() clobbers SR cond=
ition flags
- [High] openrisc: kprobes: save_previous_kprobe() fails to preserve irq_fl=
ags
- [High] openrisc: kprobes: uninitialized next_insn and unvalidated delay s=
lot
- [High] openrisc: mm: do_page_fault() calls kprobe_page_fault() before vma=
lloc_fault
- [High] openrisc: kprobes: broken fault recovery in kprobe_fault_handler()
- [High] openrisc: kprobes: missing SMP icache invalidation on text patching
- [High] openrisc: kprobes: missing _ASM_NOKPROBE on exception return and f=
ault paths
- [Medium] openrisc: kprobes: kprobe_breakpoint_handler() fallthrough on re=
entry error
--

commit 6ecc71ed745d7593292c3d83156be5a2c1382625
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add KProbes

This commit adds KProbes support for the OpenRISC architecture, including
instruction simulation for branches and PC-relative instructions,
out-of-line single-stepping using software breakpoints, and trap/fault
handler integration.

> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index 18e68680471eb..cbc38405d99f5 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
[ ... ]
> @@ -1004,6 +1017,8 @@ ENTRY(_ret_from_exception)
>  	 l.nop
>  	l.j	_resume_userspace
>  	 l.nop
> +_ASM_NOKPROBE(_ret_from_exception)
> +_ASM_NOKPROBE(_ret_from_intr)

[Severity: High]
Are the remaining exception return labels and low-level fault entry stubs a=
lso
supposed to be blacklisted with _ASM_NOKPROBE?

_ASM_NOKPROBE(symbol) only blacklists the symbol range up to the next symbol
in kallsyms. In arch/openrisc/kernel/entry.S, _ret_from_exception immediate=
ly
branches backwards to _restore_all (taken on all kernel-mode exception
returns, including _trap_handler) or jumps backwards to _resume_userspace a=
nd
_work_pending:

arch/openrisc/kernel/entry.S:
    _resume_userspace:
        ...
    _work_pending:
        ...
    _restore_all:
        ...
        RESTORE_ALL

    ENTRY(_ret_from_intr)
    ENTRY(_ret_from_exception)
        l.lwz   r4,PT_SR(r1)
        l.andi  r3,r4,SPR_SR_SM
        l.sfeqi r3,0
        l.bnf   _restore_all
         l.nop
        l.j     _resume_userspace
         l.nop
    _ASM_NOKPROBE(_ret_from_exception)
    _ASM_NOKPROBE(_ret_from_intr)

Because _resume_userspace, _work_pending, _restore_all, and skip_hardirqs_on
are separate symbols preceding _ret_from_exception, they are not covered by
_ASM_NOKPROBE(_ret_from_exception). Probing _restore_all causes _trap_handl=
er
to trap recursively on return and clobbers SPR_EPCR_BASE, SPR_ESR_BASE, and=
 r1
inside RESTORE_ALL.

Similarly, the page-fault and exception entry stubs in
arch/openrisc/kernel/entry.S (_dtlb_miss_page_fault_handler,
_data_page_fault_handler, _itlb_miss_page_fault_handler,
_insn_page_fault_handler, _bus_fault_handler, _illegal_instruction_handler,
_alignment_handler, _external_irq_handler, and _timer_handler) and the MMU-=
off
TLB miss handlers in arch/openrisc/kernel/head.S (dtlb_miss_handler and
itlb_miss_handler, which live in .text and execute before SPR_EPCR_BASE and
SPR_ESR_BASE are saved) lack _ASM_NOKPROBE annotations.

[ ... ]
> diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobe=
s.c
> new file mode 100644
> index 0000000000000..0b8762e340d5a
> --- /dev/null
> +++ b/arch/openrisc/kernel/kprobes.c
> @@ -0,0 +1,426 @@
[ ... ]
> +int arch_prepare_kprobe(struct kprobe *p)
> +{
> +	kprobe_opcode_t insn;
> +	kprobe_opcode_t prev_insn, next_insn;
> +	bool exec_delay_slot =3D false;
> +
> +	/* Attempt to probe at unaligned address */
> +	if ((unsigned long)p->addr & 0x3)
> +		return -EILSEQ;
> +
> +	if (unlikely(copy_from_kernel_nofault(&insn, p->addr, OPENRISC_INSN_SIZ=
E)))
> +		return -EFAULT;
> +
> +	p->opcode =3D insn;
> +
> +	if (insn_not_supported(insn)) {
> +		pr_notice("Can't insert KProbe at blacklisted instruction.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
> +			OPENRISC_INSN_SIZE) =3D=3D 0 && is_branch_insn(prev_insn)) {
> +		if (static_branch_likely(&delay_slot)) {
> +			pr_notice("Can't insert KProbe in delay slot.\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (copy_from_kernel_nofault(&next_insn, p->addr + 1, OPENRISC_INSN_SIZ=
E) =3D=3D 0 &&
> +	    insns_need_simulation(next_insn, &exec_delay_slot) && is_branch_ins=
n(insn)) {
> +		if (static_branch_likely(&delay_slot)) {
> +			pr_notice("Can't insert KProbe if following instruction is in a delay=
 slot and depends on PC.\n");
> +			return -EINVAL;
> +		}
> +	}
> +
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
> +			patch_insn_write(p->ainsn.insn, next_insn);
> +		else
> +			patch_insn_write(p->ainsn.insn, p->opcode);
> +		patch_insn_write(&p->ainsn.insn[1], KPROBE_SSTEPBP_INSN);
> +	}
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(arch_prepare_kprobe);

[Severity: High]
Can arch_prepare_kprobe() patch uninitialized stack bytes or unsupported
delay-slot instructions into p->ainsn.insn?

There appear to be three issues with how prev_insn and next_insn are valida=
ted
in arch_prepare_kprobe():

1. next_insn is declared uninitialized on the stack. When p->addr points to=
 a
branch instruction with delay slots enabled and
copy_from_kernel_nofault(&next_insn, p->addr + 1, OPENRISC_INSN_SIZE) retur=
ns
an error, the first if statement simply evaluates to false without returning
-EFAULT. Subsequent execution calls insns_need_simulation(insn,
&exec_delay_slot), which sets exec_delay_slot =3D true, and then writes the
uninitialized next_insn variable into the executable slot via
patch_insn_write(p->ainsn.insn, next_insn).

2. When exec_delay_slot is true, next_insn is placed into p->ainsn.insn[0] =
to
be single-stepped out of line, but insn_not_supported(next_insn) is never
checked. A branch whose delay slot contains an instruction rejected by
insn_not_supported() (such as l.mfspr, l.mtspr, l.lwa, l.swa, l.trap, l.sys,
or l.rfe) will bypass the instruction blacklist.

3. Reading prev_insn from p->addr - 1 via copy_from_kernel_nofault() inspec=
ts
patched kernel text directly without checking get_kprobe(p->addr - 1). If an
armed kprobe already exists on a branch instruction at p->addr - 1, the mem=
ory
at p->addr - 1 holds KPROBE_BP_INSN rather than the original branch opcode,=
 so
is_branch_insn(prev_insn) returns false and allows a second kprobe to be
registered inside the branch's delay slot at p->addr.

> +
> +void arch_arm_kprobe(struct kprobe *p)
> +{
> +	patch_insn_write(p->addr, KPROBE_BP_INSN);
> +	flush_insn_slot(p);
> +}
> +NOKPROBE_SYMBOL(arch_arm_kprobe);
> +
> +void arch_disarm_kprobe(struct kprobe *p)
> +{
> +	patch_insn_write(p->addr, p->opcode);
> +	flush_insn_slot(p);
> +}
> +NOKPROBE_SYMBOL(arch_disarm_kprobe);

[Severity: High]
How are instruction caches synchronized across CPUs on SMP when kprobes are
prepared, armed, or disarmed?

In arch/openrisc/include/asm/kprobes.h, flush_insn_slot(p) is defined as a
no-op:

    #define flush_insn_slot(p)		do { } while (0)

And patch_insn_write() only flushes the local CPU's dcache and icache via
local SPR writes. On SMP systems (such as virt_defconfig where CONFIG_SMP=
=3Dy
and CONFIG_KPROBES=3Dy), remote CPUs can retain stale instructions in their
icache.

In particular, if CPU A disarms a kprobe via arch_disarm_kprobe(), CPU B may
still fetch the stale KPROBE_BP_INSN from its local icache and enter
do_trap():

arch/openrisc/kernel/traps.c:do_trap() {
    ...
		if (get_kernel_nofault(trap, (unsigned long *)regs->pc) < 0)
			return;

		/*
		 * Trap instruction was probably removed and no further processing
		 * is required.
		 */
		if ((trap & OPENRISC_MASK_TRAP) !=3D OPENRISC_INSN_TRAP)
			return;
    ...
}

Because get_kernel_nofault() reads the restored non-trap opcode from the
dcache, do_trap() returns to the same regs->pc without invalidating the loc=
al
icache, causing CPU B to trap repeatedly in an infinite loop on the stale
icache line.

[ ... ]
> +static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->prev_kprobe.kp =3D kprobe_running();
> +	kcb->prev_kprobe.status =3D kcb->kprobe_status;
> +	kcb->prev_kprobe.restore_pc =3D kcb->restore_pc;
> +}
> +NOKPROBE_SYMBOL(save_previous_kprobe);
> +
> +static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->kprobe_status =3D kcb->prev_kprobe.status;
> +	kcb->restore_pc =3D kcb->prev_kprobe.restore_pc;
> +	set_current_kprobe(kcb->prev_kprobe.kp);
> +}
> +NOKPROBE_SYMBOL(restore_previous_kprobe);

[Severity: High]
Should struct prev_kprobe and save_previous_kprobe() also save and restore
kcb->irq_flags?

When an outer kprobe enters setup_singlestep(), kprobe_local_irq_save() sto=
res
the original interrupt-enabled regs->sr into kcb->irq_flags and clears
SPR_SR_IEE | SPR_SR_TEE in regs->sr. If a nested kprobe is then hit while
kcb->kprobe_status is KPROBE_HIT_SS, reenter_kprobe() calls
setup_singlestep(p, regs, kcb, 1), which calls save_previous_kprobe(kcb) and
then kprobe_local_irq_save(kcb, regs).

Because save_previous_kprobe() does not preserve kcb->irq_flags, the nested
kprobe_local_irq_save() overwrites kcb->irq_flags with the nested trap's
regs->sr (which has SPR_SR_IEE | SPR_SR_TEE cleared). When the outer kprobe
later completes single-stepping in kprobe_singlestep_handler(),
kprobe_local_irq_restore() restores the clobbered kcb->irq_flags, leaving
local interrupts and timer ticks permanently disabled on that CPU.

Also, in kprobe_fault_handler(), restore_previous_kprobe(kcb) is called bef=
ore
kprobe_local_irq_restore(kcb, regs), which would restore the outer kprobe's
irq_flags into kcb before restoring the inner faulted kprobe's irq_flags in=
to
regs->sr.

> +
> +/*
> + * kprobe_local_irq_(save|restore) disable/enable interrupts
> + * on exiting from the exception handler respectively. This is
> + * achieved by toggling the IEE and TEE bits in regs->sr with
> + * the changes taking effect after returning from the exception
> + * handler.
> + *
> + * Interrupts need to be disabled for the period during which an
> + * instruction is single-stepped.
> + */
> +static void __kprobes kprobe_local_irq_save(struct kprobe_ctlblk *kcb,
> +						struct pt_regs *regs)
> +{
> +	kcb->irq_flags =3D regs->sr;
> +	regs->sr =3D (regs->sr & ~(SPR_SR_IEE|SPR_SR_TEE)) | ARCH_IRQ_DISABLED;
> +}
> +
> +static void __kprobes kprobe_local_irq_restore(struct kprobe_ctlblk *kcb,
> +						struct pt_regs *regs)
> +{
> +	regs->sr =3D kcb->irq_flags;
> +}

[Severity: Critical]
Does kprobe_local_irq_restore() clobber architectural condition flags updat=
ed
by the single-stepped instruction?

On OpenRISC, regs->sr (the Supervision Register) contains not only the
interrupt enable bits (SPR_SR_IEE | SPR_SR_TEE) but also the ALU and
comparison status flags: SPR_SR_F (condition flag), SPR_SR_CY (carry flag),
and SPR_SR_OV (overflow flag).

In setup_singlestep(), kprobe_local_irq_save() snapshots the entire
pre-instruction regs->sr into kcb->irq_flags. After the instruction in
cur->ainsn.insn[0] is single-stepped and updates SPR_SR_F, SPR_SR_CY, or
SPR_SR_OV, kprobe_singlestep_handler() calls kprobe_local_irq_restore(), wh=
ich
overwrites the entire regs->sr with the pre-instruction kcb->irq_flags.

Whenever a kprobe is placed on a comparison instruction (such as l.sfeq or
l.sfne), a flag-modifying arithmetic instruction, or a branch with such an
instruction in its delay slot, the flag update is lost and subsequent
conditional branches (l.bf / l.bnf) or conditional moves (l.cmov) can take =
the
wrong path. Should kprobe_local_irq_save() and kprobe_local_irq_restore() o=
nly
save and restore the (SPR_SR_IEE | SPR_SR_TEE) bits in regs->sr?

[ ... ]
> +bool kprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +	struct kprobe *p, *curr_kprobe;
> +	struct kprobe_ctlblk *kcb;
> +	kprobe_opcode_t *addr =3D (kprobe_opcode_t *)regs->pc;
> +	kprobe_opcode_t insn;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing.
> +	 */
> +	preempt_disable();
> +
> +	kcb =3D get_kprobe_ctlblk();
> +	curr_kprobe =3D kprobe_running();
> +	p =3D get_kprobe(addr);
> +	if (p) {
> +		if (curr_kprobe) {
> +			if (reenter_kprobe(p, regs, kcb))
> +				return true;
> +		} else {
> +			/* Probe hit */
> +			set_current_kprobe(p);
> +			kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
> +			/*
> +			 * If there's no pre-handler or it returns 0, continue
> +			 * processing the KProbe as usual. A non-zero return
> +			 * value implies the saved registers have been modified
> +			 * and the execution path might deviate from what's
> +			 * expected. Reset the KProbe and return.
> +			 */
> +			if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +				setup_singlestep(p, regs, kcb, 0);
> +			} else {
> +				reset_current_kprobe();
> +				preempt_enable_no_resched();
> +			}
> +			return true;
> +		}
> +	}
> +
> +	/*
> +	 * The breakpoint instruction was removed right after we hit it
> +	 * possibly by another cpu. If the original instruction was also
> +	 * a trap instruction then return to the trap handler for further
> +	 * processing, else no further processing is required.
> +	 */
> +	if (get_kernel_nofault(insn, addr) < 0
> +		|| (insn & OPENRISC_MASK_TRAP) !=3D OPENRISC_INSN_TRAP) {
> +		preempt_enable_no_resched();
> +		return true;
> +	}
> +
> +	preempt_enable_no_resched();
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_breakpoint_handler);

[Severity: Medium]
What happens in kprobe_breakpoint_handler() when reenter_kprobe() returns
false?

If curr_kprobe is non-NULL and reenter_kprobe(p, regs, kcb) returns false (=
for
example, when kcb->kprobe_status =3D=3D KPROBE_REENTER), execution falls ou=
t of
the if (p) block into the disarmed-breakpoint check at the bottom of
kprobe_breakpoint_handler(). If the probe is concurrently disarmed or if
get_kernel_nofault() fails, kprobe_breakpoint_handler() will return true
instead of failing; otherwise it returns false with current_kprobe still set
and the outer kprobe's preempt_disable() still held.

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
> +
> +		if (kcb->kprobe_status =3D=3D KPROBE_REENTER)
> +			restore_previous_kprobe(kcb);
> +		else
> +			reset_current_kprobe();
> +
> +		kprobe_local_irq_restore(kcb, regs);
> +		preempt_enable_no_resched();
> +		break;
> +	}
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(kprobe_fault_handler);

[Severity: High]
Does kprobe_fault_handler() need to handle faults during KPROBE_HIT_ACTIVE /
KPROBE_HIT_SSDONE and faults on delay-slot instructions?

There look to be a few issues in kprobe_fault_handler():

1. KPROBE_HIT_ACTIVE and KPROBE_HIT_SSDONE are not handled in the switch
statement. If a user-registered pre_handler or post_handler (such as a BPF =
or
ftrace kprobe handler) triggers a page fault via copy_from_kernel_nofault()=
 or
copy_from_user_nofault(), kprobe_fault_handler() does not invoke
fixup_exception() / search_exception_tables() and returns 0. In task contex=
t,
do_page_fault() in arch/openrisc/mm/fault.c then re-enables interrupts and
calls mmap_read_lock(mm) while preemption and pagefaults are disabled.

2. In the KPROBE_HIT_SS and KPROBE_REENTER cases, regs->pc is unconditional=
ly
set to (unsigned long)cur->addr. However, if cur->opcode is a branch
instruction with delay slots enabled, setup_singlestep() has already run
simulate_branch() (updating regs->pc and overwriting r9 for l.jal / l.jalr),
and the instruction being single-stepped in cur->ainsn.insn[0] is the
delay-slot instruction from cur->addr + 1. Rewinding regs->pc to cur->addr
means exception table lookups in do_page_fault() search for the branch addr=
ess
cur->addr instead of the faulting delay-slot address cur->addr + 1, or
re-execute the branch with r9 already overwritten.

3. Under KPROBE_HIT_SS and KPROBE_REENTER, kprobe_fault_handler() does not
verify that cur->ainsn.insn is non-NULL and that instruction_pointer(regs)
matches (unsigned long)cur->ainsn.insn before rewinding regs->pc.

[ ... ]
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 29e232d78d828..5263a832562fb 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
>  #include <linux/extable.h>
> +#include <linux/kprobes.h>
>  #include <linux/sched/signal.h>
>  #include <linux/perf_event.h>
> =20
> @@ -55,6 +56,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, uns=
igned long address,
> =20
>  	tsk =3D current;
> =20
> +	if (kprobe_page_fault(regs, vector))
> +		return;
> +
>  	/*
>  	 * We fault-in kernel-space virtual memory on-demand. The
>  	 * 'reference' page table is init_mm.pgd.

[Severity: High]
Should kprobe_page_fault() be called after the vmalloc_fault check in
do_page_fault()?

In arch/openrisc/mm/fault.c, vmalloc mappings are lazily synchronized from
init_mm.pgd into current_pgd[cpu] via the vmalloc_fault path right below th=
is
check:

arch/openrisc/mm/fault.c:do_page_fault() {
    ...
	if (kprobe_page_fault(regs, vector))
		return;
    ...
	if (address >=3D VMALLOC_START &&
	    (vector !=3D 0x300 && vector !=3D 0x400) &&
	    !user_mode(regs))
		goto vmalloc_fault;
    ...
}

Because kprobe SSOL instruction pages (p->ainsn.insn) are allocated from
vmalloc space via get_insn_slot(), the first time a process hits a kprobe a=
nd
jumps to p->ainsn.insn (or single-steps an instruction that accesses vmalloc
or module memory), an ITLB/DTLB miss triggers do_page_fault() to lazily
populate current_pgd[cpu] from init_mm.pgd.

Calling kprobe_page_fault() before the vmalloc_fault check causes
kprobe_fault_handler() to intercept this lazy vmalloc fault while in
KPROBE_HIT_SS, abort single-stepping, reset regs->pc back to cur->addr, and
skip post_handler. Once vmalloc_fault finishes updating the PGD and returns,
execution resumes at cur->addr and hits the kprobe breakpoint a second time
(and if cur->addr was a branch instruction such as l.jalr r9, simulate_bran=
ch()
already overwrote r9 before the ITLB miss on p->ainsn.insn).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026201240.1074=
62-1-sahilcdq0@gmail.com?part=3D2
