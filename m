Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794747700;
	b=q44XnWK0CmIqxqEMo6Kb2x39D9HTi15AiIDfohqAaUUMfxhV+oe9YjVQ3je6XndFbPfQ
	 WYlKozuVHjow6jffTbfllmXThezBVCA7c8erujGWdXTAGZ3JI0DBMx6e8Gn2ER7Ceyu0V
	 H3CjGt5rVGfKNAdVmIB2aIRa2WHUMSN1cn6yriyami39cTIiBauB7OpMrWIHgqU40n5X+
	 bKzm8uGUcybOjr5d7ONEMZfVjFUrD4MQOJPEfyIUCy1YaCGKyM4InbnrCPRUxf4Uw/NNt
	 NzcCUljTn/5/9p4w/O0Nk+KY+7HuHMWTHCvX3/E3pgjtzURhCOi7Slh5Pz3PDp4z+JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RKTInV6SNsPGRtW41siEsQUjvIqVTNTz+N2ulZmOutU=;
	b=U+ihnnqr9tP7SmMQfG6VV4a6f0+LDjkvcESM0KqNXkv71RUe/3hlirb7vlKnzxkKnjsI
	 TAwzkEjDBi+OmO9TMvSX8KhTSIpp4IL3ELiyWzeFHXuwaQpFMYRueBBtP9CYSkMT/96OH
	 clHGqva+HHvkpDpLfKbUk8YUOk02cqiEi2fuuUOtJ5iWKIwAkEFdyMKTE2k5TThVcQv4x
	 JqmmcCMbCjxLv+PtpSEZfQQWoftDzRWvjsGpwNnqL3x7f0q65Z0aosodrtJDHrxRwFncj
	 7jq/db2gaxEw1wmQ+6qKyhZAoClz99EgO3e6GPybipqmtwqM0xzE2BZ+Y3oHzL7F9GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izp7oMqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC02606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izp7oMqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3C51F000C4;
	Sun, 15 Nov 2026 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794747699;
	bh=RKTInV6SNsPGRtW41siEsQUjvIqVTNTz+N2ulZmOutU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Izp7oMqqsmc3qHv97PXAqwJdC9P0yudHMy4Dpgvjoc8yyk2YO3cpTpCUK4wE/pf0A
	 JuHNJcI9Qs4lB7wjE3iqBGB20nrnZyfrqdoquPx1K+RZNdj1gQcaPOOUW6nxBdvT/W
	 r/b5P9UmGSckna0m3Z9dtIW0Sf9gwArPz6LUPyu5Toc37NSx0ktJIMXadZcsUNYuBw
	 8SearbsrWrRI49DdDX0btV7RWVMgbEM+YD80q0g7fXL+mC3uCnmdMB+WMQbNLjEaC6
	 E49da6tAhypAPEELtQ+8JeaebecV31D/uK8VPnPJZ4uYrGMB5C/O0QP0HCUv3WQ4i8
	 LFaz+dpjfG/8Q==
Message-ID: <sashiko-outbox-215511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] riscv: probes: reject probes inside an LR/SC
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261115-probes-in-lrsc-v4-2-48b9b036bd1d@mobileye.com>
References: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
 <20261115-probes-in-lrsc-v4-2-48b9b036bd1d@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:01:39 +0000
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
- [Medium] riscv: probes: unbounded symbol scan and 0x0000 body match in
  LR/SC check
- [Medium] riscv: probes: uprobe_in_lrsc_body() accepts probe when first
  page read fails
--

commit adb0f0de869819463b6310d8616d49420ae15ca8
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: probes: reject probes inside an LR/SC sequence

This commit rejects kprobes and uprobes placed inside a constrained LR/SC
atomic sequence by scanning forward up to 16 allowed body instructions for
a matching SC instruction.

> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b8882..78a6f2ac6808c 100644
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

[ ... ]

> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 63ee5066def5c..b8df722ac19f7 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -49,35 +49,49 @@ static void __kprobes arch_simulate_insn(struct kprob=
e *p, struct pt_regs *regs)
>  	post_kprobe_handler(p, kcb, regs);
>  }
> =20
> -static bool __kprobes arch_check_kprobe(unsigned long addr)
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
> +static int __kprobes arch_check_kprobe(unsigned long addr)
>  {
>  	unsigned long tmp, offset;
> =20
>  	/* start iterating at the closest preceding symbol */
>  	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
> -		return false;
> +		return -EILSEQ;
> =20
>  	tmp =3D addr - offset;
> =20
>  	while (tmp <=3D addr) {
>  		if (tmp =3D=3D addr)
> -			return true;
> +			if (riscv_probe_in_lrsc_body((u16 *)addr, RISCV_LRSC_SCAN_BYTES))
> +				return -EINVAL;
> +			else
> +				return 0;

[Severity: Medium]
Can arch_check_kprobe() scan past the end of the enclosing symbol and into
an unmapped page?

The commit message states that kprobes scan up to the end of the enclosing
symbol, but arch_check_kprobe() passes NULL for symbolsize to
kallsyms_lookup_size_offset() and always scans RISCV_LRSC_SCAN_BYTES (72
bytes) from addr. In addition, the RVC_OPCODE_C0 check in
riscv_insn_is_lrsc_body() only tests funct3 =3D=3D 0 without requiring a
non-zero immediate in bits 12:5, so 0x0000 (illegal instruction and zero
padding at the end of a module text section) is treated as a valid
c.addi4spn body instruction. Probing near the end of a function can
therefore scan across symbol boundaries or through trailing zero padding
into an unmapped module vmalloc guard page, causing an unhandled kernel
page fault while holding kprobe_mutex and text_mutex.

Clamping the scan length to symbolsize - offset and rejecting nzuimm =3D=3D=
 0
for c.addi4spn would prevent scanning past the symbol or across zero
padding.

[ ... ]

> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index eb177d0ce8ab0..d97a102621665 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -28,6 +28,34 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *reg=
s)
>  	return instruction_pointer(regs);
>  }
> =20
> +/*
> + * Is the instruction at addr inside a constrained LR/SC sequence? Only =
the
> + * probed instruction was copied, so read the text that follows it from =
the
> + * task. The caller holds mmap_lock, as uprobe_write_opcode() requires t=
oo.
> + * Text that cannot be read ends the scan early, which accepts the probe.
> + */
> +static bool uprobe_in_lrsc_body(struct mm_struct *mm, unsigned long addr)
> +{
> +	u16 buf[RISCV_LRSC_SCAN_BYTES / sizeof(u16)];
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	size_t got =3D 0;
> +	int len;
> +
> +	while (got < sizeof(buf)) {
> +		len =3D min_t(size_t, sizeof(buf) - got,
> +			    PAGE_SIZE - offset_in_page(addr + got));
> +		page =3D get_user_page_vma_remote(mm, addr + got, FOLL_FORCE, &vma);
> +		if (IS_ERR(page))
> +			break;
> +		uprobe_copy_from_page(page, addr + got, (void *)buf + got, len);
> +		put_page(page);
> +		got +=3D len;
> +	}
> +
> +	return riscv_probe_in_lrsc_body(buf, got);
> +}
> +
>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_stru=
ct *mm,
>  			     unsigned long addr)
>  {
> @@ -53,6 +81,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprob=
e, struct mm_struct *mm,
>  		return -EINVAL;
>  	}
> =20
> +	if (uprobe_in_lrsc_body(mm, addr))
> +		return -EINVAL;
> +
>  	return 0;
>  }

[Severity: Medium]
Does uprobe_in_lrsc_body() accept a probe on an sc instruction or inside an
LR/SC sequence if get_user_page_vma_remote() fails on the first page?

When the first get_user_page_vma_remote() call fails (for example due to a
pending fatal signal or -ENOMEM), the loop breaks with got =3D=3D 0 and
riscv_probe_in_lrsc_body(buf, 0) returns false without even checking the
probed instruction already copied in auprobe->insn.
arch_uprobe_analyze_insn() then returns 0, so prepare_uprobe() sets
UPROBE_COPY_INSN on the uprobe permanently; subsequent mappings or tasks
skip prepare_uprobe() and install the breakpoint inside the LR/SC sequence,
livelocking the target task when hit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-probes-in-=
lrsc-v4-0-48b9b036bd1d@mobileye.com?part=3D2
