Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398859;
	b=0x8pRY9MArFqEXgXccEGjnyKEeVIhNhXp9WmLHwLFjvYiRJNybA/hkuSsV7Ov15wGJ9V
	 +V6d7Ifeip7ACqWjGAAt5vuz0QtXIEo+CCCz6oh6PVDSpXVdSJ7m6CDvEaS6xdIeYk6Mf
	 +Gvx6XbtcdqO45qUZR2K9RTJ4MJS+nKjZQM0sWJT5g503G7eDh5lc07gUZFbkDUUu6gXX
	 APanwy451u3e71JmPqe33+zvidnauHeHXWd24jLJfIYccIERFBpGVGA3wmXcH2tk4e83I
	 pfTpRNyQw2GDZ1h3LN/TZv2NPCThr+EtRamSsyBl6R8/vvCcuKg4QkN+f6xB+mouKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xYLCU8vwoBcCtlldq8fNcmgIoz1v1nvSB1xjqLP6UJw=;
	b=4FXCzeNuM/Ux1zf/84j/BLNuJ/yCQQklNocAyNabKTrXxIfWCx8BfdjSYFtn7jVFOPqB
	 MHtmENtoDKCyUuJxSdGArLUS0+IFjMDFABP+MNdxQL7oAqe5/Xn4lwHFoBUcXN4MnI085
	 0/njLbOO5EdosUemD4ZA+MACWbHq+G0p2QUZNejApXOYcej6G34D0q3C5dvzdjSVlSNVA
	 Z1wpr2F6+MnlLeAmY5SFsLklMQwLkj76HSIGomEJciruDSl4FEk5B5c51YrPhKwq9pz1S
	 /N7CbuS5BGwDse46WkLzHBUdkeMFAfJ19EcTk79AraY+Ho956haNTqaB8tYPy8pRUiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KUoLI/gV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B91606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUoLI/gV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD461F00A05;
	Wed, 11 Nov 2026 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794398858;
	bh=xYLCU8vwoBcCtlldq8fNcmgIoz1v1nvSB1xjqLP6UJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KUoLI/gVTZXQWUNExHqOV8zwviWf/C14Wdv01xUAKGsGoLckqMQ0lCB25G9r+lzMl
	 CvqI8DhyIOBeCZjYjdOVhUeKEPeYzqvRBCf0SE2PZojoTBY7kgDvMf781AAV3I7GKo
	 grmk0zv41LoyX35HaYMemgwM8Y4E0JoRou+Fs58MhHzk61G0Bdr+4USewk5bZEe9xP
	 nND9ePsTipP/4932W6faOAK+971W+8KRXPLlSOeqlC+rsp0b0/xgbt4pl2FoDla7Ve
	 7oi20Ji11BLToNrnjL4lw9bWESE9WP1CXbUBsZqbbdxaxhF4JxEaLueDVlh4PPcMqe
	 dF48IzrEsnZcQ==
Message-ID: <sashiko-outbox-208936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: probes: reject probes inside an LR/SC sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111-probes-in-lrsc-v1-1-4f99ddea5f68@mobileye.com>
References: <20261111-probes-in-lrsc-v1-1-4f99ddea5f68@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:07:38 +0000
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
- [Medium] riscv: probes: arch_prepare_kprobe() returns -EILSEQ for
  LR/SC probes
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] riscv/kprobes: out-of-bounds read in riscv_probe_decode_insn()
  [1]
--

commit 231a5b2589b5c10fae9eb5a24fcd30822aa304a2
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: probes: reject probes inside an LR/SC sequence

This commit rejects kprobes and uprobes placed on lr or sc instructions or
inside the body of a constrained LR/SC sequence so breakpoint traps do not
repeatedly clear the reservation.

> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b8882..6a4f55b07d04a 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c

[ ... ]

> @@ -23,6 +111,12 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct =
arch_probe_insn *api)
>  	 */
>  	RISCV_INSN_REJECTED(system,		insn);
>  	RISCV_INSN_REJECTED(fence,		insn);
> +	/*
> +	 * The breakpoint trap drops the reservation, so a probe on either
> +	 * end of an LR/SC sequence makes the SC fail on every retry.
> +	 */
> +	RISCV_INSN_REJECTED(lr,			insn);
> +	RISCV_INSN_REJECTED(sc,			insn);

[Severity: High]
This problem wasn't introduced by this patch, but can
riscv_probe_decode_insn() trigger an out-of-bounds page fault [1]
when probing a 16-bit compressed instruction at the end of a page?

arch_prepare_kprobe() safely reads 16-bit parcels into p->opcode, but then
passes p->addr to riscv_probe_decode_insn(), which unconditionally
dereferences *addr as a 32-bit probe_opcode_t:

arch/riscv/kernel/probes/kprobes.c:arch_prepare_kprobe() {
	...
	/* copy instruction */
	p->opcode =3D (kprobe_opcode_t)(*insn++);
	if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
		p->opcode |=3D (kprobe_opcode_t)(*insn) << 16;

	/* decode instruction */
	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
	...
}

If a 16-bit instruction sits in the last two bytes of a mapped page next
to an unmapped page, the 32-bit read of *addr crosses the page boundary
and faults.  Passing &p->opcode instead of p->addr to
riscv_probe_decode_insn() (as arch_uprobe_analyze_insn() already does)
would avoid reading past the instruction.

[ ... ]

> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 9e2afabf94e80..1ade363910c96 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -49,19 +49,28 @@ static void __kprobes arch_simulate_insn(struct kprob=
e *p, struct pt_regs *regs)
>  	post_kprobe_handler(p, kcb, regs);
>  }
> =20
> +/*
> + * Walk the instructions from the enclosing symbol up to addr to check t=
hat
> + * addr is an instruction boundary. Then reject a probe inside an LR/SC
> + * sequence: the breakpoint trap drops the reservation, so the SC would =
fail
> + * and the loop would hit the probe again on every retry. The sequence is
> + * recognised by a forward scan with the constrained-sequence rules, as =
for
> + * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) d=
oes
> + * not taint the rest of the function.
> + */
>  static bool __kprobes arch_check_kprobe(unsigned long addr)
>  {
> -	unsigned long tmp, offset;
> +	unsigned long tmp, size, offset;
> =20
>  	/* start iterating at the closest preceding symbol */
> -	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
> +	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
>  		return false;
> =20
>  	tmp =3D addr - offset;
> =20
>  	while (tmp <=3D addr) {
>  		if (tmp =3D=3D addr)
> -			return true;
> +			return !riscv_probe_in_lrsc_body((u16 *)addr, size - offset);

[Severity: Medium]
Does rejecting LR/SC body and sc instructions inside arch_check_kprobe()
cause arch_prepare_kprobe() to return -EILSEQ instead of -EINVAL?

arch_prepare_kprobe() returns -EILSEQ whenever arch_check_kprobe() returns
false, and trace_kprobe_create_internal() maps -EILSEQ to BAD_INSN_BNDRY
("Probe point is not an instruction boundary").  Because
riscv_probe_in_lrsc_body() also returns true at n =3D 0 when the probed
instruction itself is sc, kprobes on sc or inside an LR/SC body fail with
-EILSEQ and report a bad instruction boundary, whereas kprobes on lr and
uprobes return -EINVAL (leaving RISCV_INSN_REJECTED(sc, insn) in
riscv_probe_decode_insn() unreachable for kprobes).

[1] https://sashiko.dev/#/bug/linux-812af091-20d1-4915-97a6-741f51e07022

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-probes-in-=
lrsc-v1-1-4f99ddea5f68@mobileye.com?part=3D1
