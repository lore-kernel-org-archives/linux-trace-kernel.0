Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123996;
	b=WdzZB20TLwjF1kPzWV0H2r0gsIcPrmGhC9wRuPf+ukisJNMa03Db1gzbjnLVIIWbDnvh
	 WyN1Mr0OqgIZI396Ktr2t1+AoDAxCaGMYnsgYpBY+oFowA8DW7iPwcViGaaggRDJLix/O
	 Wgj2PJTR8SJWabLMw7tLMqzyB5LovFOAlq0DtHHd4Cv/B1KyRNp/T2h7fN87s56Zh5uzU
	 bEEHPoIh+sTrACnYKTuJbs+iUFzndO7dy5jdfIvLUSavfTd1LH1jIrFxjk+Bj8q3h7QEp
	 U/WnRaHHBuLLvNxaiFbpHr/RrAA7wqLQ4NlaB2fVz7W35kGo9Hlxr0bBK2XIb01u/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xz37wOUeL+YQ92f30AjLn2EszBNt4cJV/UqqJ2db2fc=;
	b=kYd51DzvwKCDr8tWQgT+tH/mBCiBSU4ZuyIDikKZAFZoBnUpv210HacntiHoc13cSeO/
	 puY7+ea0GIrvT83L5/OwIhauZGVDKdHBdgG379T7OQhnXNYyPOVPYr3q8lkiTaDumEEgt
	 6cc4RpwLKE/IUZ/1qZ09Ej+EUpcqu71+EMOm1RnIIK3M2gR4fWC0em8CEhLhaA5VMCOGO
	 zoOKaZ1+aUnJD2RkfxxiqXT28835O7r5VyQqnCoifxBSiznuWFnIAdU4ffwoagHZRYcjQ
	 h3PB0C3Cw7fiRZBXuX/Dd+Z/eo0d6WmpYY4MD2yPlpGCaaBXCsUjjc8944QzpZMuLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9u+jvG3;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42179606A322
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 07:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42179606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9u+jvG3
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso2030445e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794123994; x=1794728794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xz37wOUeL+YQ92f30AjLn2EszBNt4cJV/UqqJ2db2fc=;
        b=F9u+jvG3MwNdXciPw+QO0vFuXu1J/VIA6s/bydFqYNv0QU2SLARysZYJ5RpL+u9bXi
         5onsZniXZudkXW7nEt4/jVT78LY/3TQZmTg3o+CIcKdwhjBxURvfz1IHSBGHPYkGP7m5
         5lGBZOA/4rojtkX7+/HwNzfmQtDRGF25MVqovQw8RupIkzWepW1//iQB845j1+zpKlE5
         OomxKPXNhv+LAkcqnWFAxsxnS+6LNqg9KkpuVCTGy/stBcLS2cWnPUZ6foneZP9Hzz7r
         GKoYLrSGfyK+YwD7Z5f/Q91oz0ct3ZVs4UESZI3137UVlHiQqy/tW8wUeeHuInmAKsc4
         d+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123994; x=1794728794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xz37wOUeL+YQ92f30AjLn2EszBNt4cJV/UqqJ2db2fc=;
        b=DfocjbxkNYlUTYLcFsYR4gCgP2Y4tsmdLMPaqbHOyCPp9qygvWpPunX8Q+zYt4Yos5
         WEvrGCgbxEVrSWO4SgN/iv0ngdFGiUB96ieNphlCfJJ/IBzS7PfoG63sD1C1+pDV3TXN
         qvGMo0OgfMfkYEjX/YIBsvFGFxhxyUtUPKSccqQUoHjYB0y/QhVVt6sOOKQG2lPd6pOH
         HLNZ9pepOB6WURSt+EL7lsA3NXNTQW86FDQbeXUqHxtSuF1e2aGoFAsH+oDm+Xo/mxQP
         wOVCRBCPwTCPXZJm6E/vRqB9fe/lCD5ATp3nacMb0pOrcUlxf1E5egS76ojuhZq+VNUy
         8vMg==
X-Forwarded-Encrypted: i=1; AL+hErHnVl5jk3CnxXWzdRcNDycnYq14np9w0bhWYyus6wfPGith18ez4eEOst6zAYjgfqGlCehJNBoBe8Uw4CHh4KT6gF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Q7Oz8o97dXrAKCc4zJma52QP9+jfZV/SXqkeLCzjSziazdj7
	U05p04CmYyG6oZ1aqqkP2tTG12ZfcUhsWQhv/iCVx8PenNEx9eWVGnB7
X-Gm-Gg: AYBFou0H71rLLqTxxJQg0Z7fcHAiWIzDEk9KqT1NfhquqtQglCUnVYfFw3L1aNtPpxP
	tqN6LYFTvcCVL/EeqeECFPUWbROS3szR+QIFI5WWt9hjhTb9rPC7xYUWuPP0KauTy+UvuNtMMSL
	j4Awv+tE/OgGVdg+EzgFaZeWseS+SBJQErniu5wtgnzqqmZVlvhAHcIXrzba2rFthEFfMyXScH3
	tqiQETLPtYhO7E7iXWWJx162mSwJOdZYcuTEfE91A3wFdXPxEUEOC2QUrZCFLfKjMFLkhCBBHme
	6TomzZLqf+JNrYhcFMSkEzem7vIReuDg3DKVp0VoXbuuqvyGB+KGiCTlfpY5oUcQ6341GUOp7n9
	CmH5w0oiJoVEjh/adyBQ1dgT7FutwK1nq3j8Unwm4sVSEQYj7Sg4Me5YbohbHyuuPhnMzAf7Cif
	VBHpUJnaFQEHsKgofP/s4wNTupMjt2w/nU54OHoR1NAmTEYPS9mVwkNncwjLWBjNM2jvyqS2EyR
	aIdS9f7Z4/Y+Qv9YBQPxZw71u2bWHnHr1KIm1+/JhOyP2WlNlRw3GY+sWNP5grwyxXlL9GWyc2f
	ZJNG225uP9apXymeFxM4b0NfZj+xatWj/fSjXSV/Hy3lf0BGurEG987yGeA07irZk9Pk2s6yAQq
	EszRsJ4+9Nmz7TmbScjrMg4NIED8=
X-Received: by 2002:a05:600c:1c0e:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4b963c6d797mr16655595e9.25.1794123993190;
        Sat, 07 Nov 2026 23:46:33 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm162132985e9.1.2026.11.07.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:46:31 -0800 (PST)
Date: Sun, 8 Nov 2026 07:46:31 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] openrisc: Add KProbes
Message-ID: <avAo140Wc1CerVwf@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-3-sahilcdq0@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026201240.107462-3-sahilcdq0@gmail.com>

On Tue, Oct 27, 2026 at 01:42:38AM +0530, Sahil Siddiq wrote:
> Add KProbes support for OpenRISC. This work is primarily based
> on similar work done for LoongArch, MIPS and RISC-V.
> 
> KProbes make it possible to trap at almost any address in the
> kernel to collect performance/debugging info.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> ---
> Changes v2 -> v3:
> - arch/openrisc/kernel/kprobes.c:
>   - (kprobe_local_irq_save): New function
>   - (kprobe_local_irq_restore): Likewise
>   - (arch_prepare_kprobe): Use copy_from_kernel_nofault()
>   - (post_kprobe_handler): Enable preemption before returning early for reentered KProbe
>   - (setup_singlestep): Disable IRQs by toggling bits in SR register
>   - (kprobe_breakpoint_handler): Use result from get_kernel_nofault()
>   - (kprobe_fault_handler):
>     Enable preemption after handling reentered KProbe
>     Restore IRQs by toggling bits in SR register
> 
> Changes v1 -> v2:
> - arch/openrisc/include/asm/kprobes.h:
>    - (struct prev_kprobe): Add restore_pc
>    - (struct kprobe_ctlblk): Move restore_pc from global "struct arch_specific_insn"
> - arch/openrisc/kernel/kprobes.c:
>    - Use macros instead of magic values
>    - Use "get_kernel_nofault" instead of directly dereferencing address
>    - (insns_need_simulation): Use "daley slot" static key
>    - (arch_prepare_kprobe): Prevent KProbe insertion if instruction in delay slot also requires simulation
>    - (save_previous_kprobe): Use "restore_pc"
>    - (restore_previous_kprobe): Likewise
>    - (post_kprobe_handler): Don't re-enable preemption if KProbe is nested
>    - (setup_singlestep): Use "restore_pc"
>    - (reenter_kprobe): Return false in case of unrecoverable KProbe
>    - (kprobe_singlestep_handler): Enable interrupt in pt_regs->sr
>    - (kprobe_fault_handler): Likewise
> 
>  arch/openrisc/Kconfig                   |   1 +
>  arch/openrisc/configs/or1ksim_defconfig |   2 +
>  arch/openrisc/configs/virt_defconfig    |   2 +
>  arch/openrisc/include/asm/asm.h         |  22 ++
>  arch/openrisc/include/asm/break.h       |  19 ++
>  arch/openrisc/include/asm/insn-def.h    |   6 +
>  arch/openrisc/include/asm/kprobes.h     |  77 +++++
>  arch/openrisc/kernel/Makefile           |   1 +
>  arch/openrisc/kernel/entry.S            |  16 +
>  arch/openrisc/kernel/kprobes.c          | 426 ++++++++++++++++++++++++
>  arch/openrisc/kernel/traps.c            |  29 ++
>  arch/openrisc/lib/memcpy.c              |   2 +
>  arch/openrisc/lib/memset.S              |   4 +
>  arch/openrisc/mm/fault.c                |   5 +
>  samples/kprobes/kprobe_example.c        |   8 +
>  15 files changed, 620 insertions(+)
>  create mode 100644 arch/openrisc/include/asm/asm.h
>  create mode 100644 arch/openrisc/include/asm/break.h
>  create mode 100644 arch/openrisc/include/asm/kprobes.h
>  create mode 100644 arch/openrisc/kernel/kprobes.c
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 9156635dd264..d240533b424b 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -27,6 +27,7 @@ config OPENRISC
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_PCI
> +	select HAVE_KPROBES
>  	select HAVE_UID16
>  	select HAVE_PAGE_SIZE_8KB
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 769705ac24d5..24d2915e7609 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -10,7 +10,9 @@ CONFIG_EXPERT=y
>  # CONFIG_KALLSYMS is not set
>  CONFIG_BUILTIN_DTB_NAME="or1ksim"
>  CONFIG_HZ_100=y
> +CONFIG_OPENRISC=y

I am not sure this is needed, did you generate this file with make
savedefconfig?  I thought CONFIG_OPENRISC would be set for every openrisc build
by default so not needed in the *_defconfig.

>  CONFIG_JUMP_LABEL=y
> +CONFIG_KPROBES=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
>  CONFIG_SLUB_TINY=y
> diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
> index 0b9979b35ca8..2eccb506032f 100644
> --- a/arch/openrisc/configs/virt_defconfig
> +++ b/arch/openrisc/configs/virt_defconfig
> @@ -11,8 +11,10 @@ CONFIG_OPENRISC_HAVE_INST_SEXT=y
>  CONFIG_NR_CPUS=8
>  CONFIG_SMP=y
>  CONFIG_HZ_100=y
> +CONFIG_OPENRISC=y
>  # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
>  CONFIG_JUMP_LABEL=y
> +CONFIG_KPROBES=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> diff --git a/arch/openrisc/include/asm/asm.h b/arch/openrisc/include/asm/asm.h
> new file mode 100644
> index 000000000000..aafe08029b4b
> --- /dev/null
> +++ b/arch/openrisc/include/asm/asm.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Macros for OpenRISC asm
> + *
> + * Linux architectural port borrowing nearly verbatim from
> + * LoongArch and Arm. All original copyrights apply as per
> + * the original source declaration.
> + */
> +
> +#ifndef __ASM_ASM_H
> +#define __ASM_ASM_H
> +
> +#ifdef CONFIG_KPROBES
> +#define _ASM_NOKPROBE(symbol)			\
> +	.pushsection "_kprobe_blacklist", "aw";	\
> +	.long symbol;				\
> +	.popsection
> +#else
> +#define _ASM_NOKPROBE(symbol)
> +#endif
> +
> +#endif /* __ASM_ASM_H */
> diff --git a/arch/openrisc/include/asm/break.h b/arch/openrisc/include/asm/break.h
> new file mode 100644
> index 000000000000..04a74d863eef
> --- /dev/null
> +++ b/arch/openrisc/include/asm/break.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * OpenRISC trap codes used internally by the kernel
> + *
> + * Linux architectural port borrowing liberally from similar works of
> + * others.  All original copyrights apply as per the original source
> + * declaration.
> + *
> + * Modifications for the OpenRISC architecture:
> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#ifndef __ASM_BREAK_H
> +#define __ASM_BREAK_H
> +
> +#define BRK_KPROBE_BP       512     /* Kprobe break */
> +#define BRK_KPROBE_SSTEPBP  1024    /* Kprobe single-step software implementation */
> +
> +#endif /* __ASM_BREAK_H */
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> index ccbda049171f..3680c0a94faf 100644
> --- a/arch/openrisc/include/asm/insn-def.h
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -54,6 +54,12 @@ struct pt_regs;
>  
>  #define OPENRISC_INSN_SIZE	4
>  
> +/* Helpers for working with l.trap */
> +static inline unsigned long __emit_trap(unsigned long code)
> +{
> +	return (code & OPENRISC_MASK_BCODE) | OPENRISC_INSN_TRAP;
> +}
> +
>  static __always_inline unsigned char get_6_bit_opcode(unsigned long insn)
>  {
>  	return (insn >> OPENRISC_OPCODE_SHIFT) & OPENRISC_OPCODE_MASK;
> diff --git a/arch/openrisc/include/asm/kprobes.h b/arch/openrisc/include/asm/kprobes.h
> new file mode 100644
> index 000000000000..2b5847002141
> --- /dev/null
> +++ b/arch/openrisc/include/asm/kprobes.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * OpenRISC Linux
> + *
> + * Linux architectural port borrowing liberally from similar works of
> + * others.  All original copyrights apply as per the original source
> + * declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#ifndef __ASM_OPENRISC_KPROBES_H
> +#define __ASM_OPENRISC_KPROBES_H
> +
> +#include <asm-generic/kprobes.h>
> +
> +#ifdef CONFIG_KPROBES
> +#include <asm/break.h>
> +#include <asm/cacheflush.h>
> +
> +#define	 __ARCH_WANT_KPROBES_INSN_SLOT
> +
> +struct pt_regs;
> +struct kprobe;
> +
> +typedef u32 kprobe_opcode_t;
> +
> +/*
> + * MAX_INSN_SIZE is used as the number of slots in an executable
> + * page for single-stepping out of line (SSOL). We need two slots
> + * since we single-step using software breakpoints. The probed
> + * instruction is placed in the first slot with a breakpoint
> + * instruction in the second slot.
> + */
> +#define MAX_INSN_SIZE	2
> +
> +/* Architecture specific copy of original instruction */
> +struct arch_specific_insn {
> +	/* copy of original instruction */
> +	kprobe_opcode_t *insn;
> +};
> +
> +struct prev_kprobe {
> +	struct kprobe *kp;
> +	unsigned int status;
> +	unsigned long restore_pc;
> +};
> +
> +/* per-cpu kprobe control block */
> +struct kprobe_ctlblk {
> +	unsigned int kprobe_status;
> +	unsigned long irq_flags;
> +	/* address of next instruction in case of SSOL */
> +	unsigned long restore_pc;
> +	struct prev_kprobe prev_kprobe;
> +};
> +
> +#define flush_insn_slot(p)		do { } while (0)

On openrisc I think we need to implement flush_insn_slot.  As our
copy's only affect data caches instruction caches may end up being
stale.  This is really hard to detect as context switches invalidate
a lot of the instruction cache lines, but not all.

I fixed this for text patching recently with commit aca063c90245
("openrisc: Fix jump_label smp syncing")

> +#define kretprobe_blacklist_size	0
> +
> +void arch_remove_kprobe(struct kprobe *p);
> +int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> +bool kprobe_breakpoint_handler(struct pt_regs *regs);
> +bool kprobe_singlestep_handler(struct pt_regs *regs);
> +#else /* !CONFIG_KPROBES */
> +static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +	return false;
> +}
> +
> +static inline bool kprobe_singlestep_handler(struct pt_regs *regs)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_KPROBES */
> +#endif /* __ASM_OPENRISC_KPROBES_H */
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 150779fbf010..2ac824867963 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_OF)		+= prom.o
> +obj-$(CONFIG_KPROBES)		+= kprobes.o
>  obj-y	+= patching.o
>  
>  clean:
> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index c7e90b09645e..cd28bf1f7a3b 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
> @@ -15,6 +15,7 @@
>  #include <linux/linkage.h>
>  #include <linux/pgtable.h>
>  
> +#include <asm/asm.h>
>  #include <asm/processor.h>
>  #include <asm/unistd.h>
>  #include <asm/thread_info.h>
> @@ -640,6 +641,7 @@ ENTRY(_sys_call_handler)
>  	/* r30 is the only register we clobber in the fast path */
>  	/* r30 already saved */
>  /*	l.sw    PT_GPR30(r1),r30 */
> +_ASM_NOKPROBE(_sys_call_handler)

How is this working for these not function symbols?  _ASM_NOKPROBE registers a
sybmol (in this case just a macro address) into the _kprobe_blacklist.  I think
withing kprobe.c it uses these _kprobe_blacklist entries to detect ranges that
cannot be probed.  However, in this case I think you are not able to get range
information.

>  _syscall_check_trace_enter:
>  	/* syscalls run with interrupts enabled */
> @@ -652,12 +654,14 @@ _syscall_check_trace_enter:
>  	l.sfne	r30,r0
>  	l.bf	_syscall_trace_enter
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_check_trace_enter)
>  
>  _syscall_check:
>  	/* Ensure that the syscall number is reasonable */
>  	l.sfgeui r11,__NR_syscalls
>  	l.bf	_syscall_badsys
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_check)
>  
>  _syscall_call:
>  	l.movhi r29,hi(sys_call_table)
> @@ -668,12 +672,14 @@ _syscall_call:
>  
>  	l.jalr  r29
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_call)
>  
>  _syscall_return:
>  	/* All syscalls return here... just pay attention to ret_from_fork
>  	 * which does it in a round-about way.
>  	 */
>  	l.sw    PT_GPR11(r1),r11           // save return value
> +_ASM_NOKPROBE(_syscall_return)
>  
>  #if 0
>  _syscall_debug:
> @@ -708,6 +714,7 @@ _syscall_check_trace_leave:
>  	l.sfne	r30,r0
>  	l.bf	_syscall_trace_leave
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_check_trace_leave)
>  
>  /* This is where the exception-return code begins... interrupts need to be
>   * disabled the rest of the way here because we can't afford to miss any
> @@ -744,6 +751,7 @@ _syscall_check_work:
>  	/* _work_pending needs to be called with interrupts disabled */
>  	l.j	_work_pending
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_check_work)
>  
>  _syscall_resume_userspace:
>  //	ENABLE_INTERRUPTS(r29)
> @@ -800,6 +808,7 @@ _syscall_resume_userspace:
>  	l.mtspr r0,r13,SPR_EPCR_BASE
>  	l.mtspr r0,r15,SPR_ESR_BASE
>  	l.rfe
> +_ASM_NOKPROBE(_syscall_resume_userspace)
>  
>  /* End of hot path!
>   * Keep the below tracing and error handling out of the hot path...
> @@ -829,6 +838,7 @@ _syscall_trace_enter:
>  
>  	l.j	_syscall_check
>  	 l.lwz	r8,PT_GPR8(r1)
> +_ASM_NOKPROBE(_syscall_trace_enter)
>  
>  _syscall_trace_leave:
>  	l.jal	do_syscall_trace_leave
> @@ -836,6 +846,7 @@ _syscall_trace_leave:
>  
>  	l.j	_syscall_check_work
>  	 l.nop
> +_ASM_NOKPROBE(_syscall_trace_leave)
>  
>  _syscall_badsys:
>  	/* Here we effectively pretend to have executed an imaginary
> @@ -845,6 +856,7 @@ _syscall_badsys:
>  	 */
>  	l.j	_syscall_return
>  	 l.addi	r11,r0,-ENOSYS
> +_ASM_NOKPROBE(_syscall_badsys)
>  
>  /******* END SYSCALL HANDLING *******/
>  
> @@ -870,6 +882,7 @@ EXCEPTION_ENTRY(_trap_handler)
>  
>  	l.j     _ret_from_exception
>  	 l.nop
> +_ASM_NOKPROBE(_trap_handler)
>  
>  /* ---[ 0xf00: Reserved exception ]-------------------------------------- */
>  
> @@ -1004,6 +1017,8 @@ ENTRY(_ret_from_exception)
>  	 l.nop
>  	l.j	_resume_userspace
>  	 l.nop
> +_ASM_NOKPROBE(_ret_from_exception)
> +_ASM_NOKPROBE(_ret_from_intr)
>  
>  ENTRY(ret_from_fork)
>  	l.jal	schedule_tail
> @@ -1038,6 +1053,7 @@ ENTRY(ret_from_fork)
>  
>  	l.j	_syscall_return
>  	 l.nop
> +_ASM_NOKPROBE(ret_from_fork)
>  
>  /* ========================================================[ switch ] === */
>  
> diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobes.c
> new file mode 100644
> index 000000000000..0b8762e340d5
> --- /dev/null
> +++ b/arch/openrisc/kernel/kprobes.c
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Kernel probes (KProbes) for OpenRISC
> + *
> + * Linux architectural port borrowing liberally from similar works of
> + * others.  All original copyrights apply as per the original source
> + * declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#include <linux/kprobes.h>
> +#include <asm/cpuinfo.h>
> +#include <asm/insn-def.h>
> +#include <asm/text-patching.h>
> +
> +DEFINE_PER_CPU(struct kprobe *, current_kprobe);
> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> +
> +#define KPROBE_BP_INSN		__emit_trap(BRK_KPROBE_BP)
> +#define KPROBE_SSTEPBP_INSN	__emit_trap(BRK_KPROBE_SSTEPBP)

Could you maybe add a comment about why these instructions are not supported?

> +static bool insn_not_supported(kprobe_opcode_t insn)
> +{
> +	switch (insn) {
> +	case OPENRISC_INSN_CSYNC:
> +	case OPENRISC_INSN_MSYNC:
> +	case OPENRISC_INSN_PSYNC:
> +		return true;
> +	}
> +
> +	if ((insn & OPENRISC_MASK_TRAP) == OPENRISC_INSN_TRAP)
> +		return true;
> +
> +	if ((insn & OPENRISC_MASK_SYS) == OPENRISC_INSN_SYS)
> +		return true;
> +
> +	if ((insn & OPENRISC_MASK_MACRC) == OPENRISC_INSN_MACRC)
> +		return true;
> +
> +	unsigned char opcode = get_6_bit_opcode(insn);
> +
> +	switch (opcode) {
> +	case OPENRISC_OPCODE_RFE:
> +	case OPENRISC_OPCODE_LWA:
> +	case OPENRISC_OPCODE_MFSPR:
> +	case OPENRISC_OPCODE_MTSPR:
> +	case OPENRISC_OPCODE_SWA:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(insn_not_supported)
> +
> +static bool is_branch_insn(kprobe_opcode_t insn)
> +{
> +	unsigned char opcode = get_6_bit_opcode(insn);
> +
> +	switch (opcode) {
> +	case OPENRISC_OPCODE_BF:
> +	case OPENRISC_OPCODE_BNF:
> +	case OPENRISC_OPCODE_J:
> +	case OPENRISC_OPCODE_JAL:
> +	case OPENRISC_OPCODE_JALR:
> +	case OPENRISC_OPCODE_JR:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(is_branch_insn)
> +
> +static bool is_pc_insn(kprobe_opcode_t insn)
> +{
> +	unsigned char opcode = get_6_bit_opcode(insn);
> +
> +	if (opcode == OPENRISC_OPCODE_ADRP)
> +		return true;
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(is_pc_insn)
> +
> +static bool insns_need_simulation(kprobe_opcode_t insn, bool *exec_delay_slot)
> +{
> +	*exec_delay_slot = false;
> +
> +	if (is_branch_insn(insn)) {
> +		if (static_branch_likely(&delay_slot))
> +			*exec_delay_slot = true;
> +		return true;
> +	}
> +
> +	if (is_pc_insn(insn))
> +		return true;
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(insns_need_simulation)
> +
> +int arch_prepare_kprobe(struct kprobe *p)
> +{
> +	kprobe_opcode_t insn;
> +	kprobe_opcode_t prev_insn, next_insn;
> +	bool exec_delay_slot = false;
> +
> +	/* Attempt to probe at unaligned address */
> +	if ((unsigned long)p->addr & 0x3)
> +		return -EILSEQ;
> +
> +	if (unlikely(copy_from_kernel_nofault(&insn, p->addr, OPENRISC_INSN_SIZE)))
> +		return -EFAULT;
> +
> +	p->opcode = insn;
> +
> +	if (insn_not_supported(insn)) {
> +		pr_notice("Can't insert KProbe at blacklisted instruction.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
> +			OPENRISC_INSN_SIZE) == 0 && is_branch_insn(prev_insn)) {
> +		if (static_branch_likely(&delay_slot)) {
> +			pr_notice("Can't insert KProbe in delay slot.\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (copy_from_kernel_nofault(&next_insn, p->addr + 1, OPENRISC_INSN_SIZE) == 0 &&
> +	    insns_need_simulation(next_insn, &exec_delay_slot) && is_branch_insn(insn)) {
> +		if (static_branch_likely(&delay_slot)) {
> +			pr_notice("Can't insert KProbe if following instruction is in a delay slot and depends on PC.\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (insns_need_simulation(insn, &exec_delay_slot) && !exec_delay_slot) {
> +		p->ainsn.insn = NULL;
> +	} else {
> +		/*
> +		 * Single step probed instruction or, in case of branch instructions, single
> +		 * step instruction in delay slot.
> +		 */
> +		p->ainsn.insn = get_insn_slot();
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
> +
> +void arch_remove_kprobe(struct kprobe *p)
> +{
> +	if (p->ainsn.insn) {
> +		free_insn_slot(p->ainsn.insn, 0);
> +		p->ainsn.insn = NULL;
> +	}
> +}
> +NOKPROBE_SYMBOL(arch_remove_kprobe);
> +
> +static void set_current_kprobe(struct kprobe *p)
> +{
> +	__this_cpu_write(current_kprobe, p);
> +}
> +NOKPROBE_SYMBOL(set_current_kprobe);
> +
> +static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->prev_kprobe.kp = kprobe_running();
> +	kcb->prev_kprobe.status = kcb->kprobe_status;
> +	kcb->prev_kprobe.restore_pc = kcb->restore_pc;
> +}
> +NOKPROBE_SYMBOL(save_previous_kprobe);
> +
> +static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->kprobe_status = kcb->prev_kprobe.status;
> +	kcb->restore_pc = kcb->prev_kprobe.restore_pc;
> +	set_current_kprobe(kcb->prev_kprobe.kp);
> +}
> +NOKPROBE_SYMBOL(restore_previous_kprobe);
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
> +	kcb->irq_flags = regs->sr;
> +	regs->sr = (regs->sr & ~(SPR_SR_IEE|SPR_SR_TEE)) | ARCH_IRQ_DISABLED;
> +}
> +
> +static void __kprobes kprobe_local_irq_restore(struct kprobe_ctlblk *kcb,
> +						struct pt_regs *regs)
> +{
> +	regs->sr = kcb->irq_flags;
> +}
> +
> +static void post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb,
> +				struct pt_regs *regs)
> +{
> +	instruction_pointer_set(regs, kcb->restore_pc);
> +
> +	if (kcb->kprobe_status == KPROBE_REENTER) {
> +		restore_previous_kprobe(kcb);
> +		preempt_enable_no_resched();
> +		return;
> +	}
> +
> +	kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +
> +	if (cur->post_handler)
> +		cur->post_handler(cur, regs, 0);
> +
> +	reset_current_kprobe();
> +	preempt_enable_no_resched();
> +}
> +NOKPROBE_SYMBOL(post_kprobe_handler);
> +
> +static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> +			     struct kprobe_ctlblk *kcb, int reenter)
> +{
> +	kprobe_opcode_t insn;
> +
> +	if (reenter) {
> +		save_previous_kprobe(kcb);
> +		set_current_kprobe(p);
> +		kcb->kprobe_status = KPROBE_REENTER;
> +	} else {
> +		kcb->kprobe_status = KPROBE_HIT_SS;
> +	}
> +
> +	/* Emulate instruction if required. */
> +	insn = p->opcode;
> +	if (is_pc_insn(insn)) {
> +		simulate_pc(regs, insn);
> +		kcb->restore_pc = regs->pc;
> +		/* No SSOL is required here, so call post-process immediately. */
> +		post_kprobe_handler(p, kcb, regs);
> +		return;
> +	}
> +
> +	if (is_branch_insn(insn)) {
> +		simulate_branch(regs, insn);
> +		/* Save target addr before updating PC to SSOL slot */
> +		kcb->restore_pc = regs->pc;
> +	} else
> +		kcb->restore_pc = regs->pc + OPENRISC_INSN_SIZE;
> +
> +	if (p->ainsn.insn) {
> +		/* Disable IRQs before single stepping */
> +		kprobe_local_irq_save(kcb, regs);
> +		instruction_pointer_set(regs, (unsigned long)p->ainsn.insn);
> +	} else {
> +		/*
> +		 * The instruction is a branch but delay slots are disabled.
> +		 * Simply call the post-handler.
> +		 */
> +		post_kprobe_handler(p, kcb, regs);
> +	}
> +}
> +NOKPROBE_SYMBOL(setup_singlestep);
> +
> +static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
> +			   struct kprobe_ctlblk *kcb)
> +{
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SS:
> +	case KPROBE_HIT_SSDONE:
> +	case KPROBE_HIT_ACTIVE:
> +		kprobes_inc_nmissed_count(p);
> +		setup_singlestep(p, regs, kcb, 1);
> +		break;
> +	case KPROBE_REENTER:
> +		pr_warn("Unrecoverable KProbe detected.\n");
> +		dump_kprobe(p);
> +		WARN_ON_ONCE(1);
> +		return false;
> +	default:
> +		WARN_ON(1);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +NOKPROBE_SYMBOL(reenter_kprobe);
> +
> +bool kprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +	struct kprobe *p, *curr_kprobe;
> +	struct kprobe_ctlblk *kcb;
> +	kprobe_opcode_t *addr = (kprobe_opcode_t *)regs->pc;
> +	kprobe_opcode_t insn;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing.
> +	 */
> +	preempt_disable();
> +
> +	kcb = get_kprobe_ctlblk();
> +	curr_kprobe = kprobe_running();
> +	p = get_kprobe(addr);
> +	if (p) {
> +		if (curr_kprobe) {
> +			if (reenter_kprobe(p, regs, kcb))
> +				return true;
> +		} else {
> +			/* Probe hit */
> +			set_current_kprobe(p);
> +			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
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
> +		|| (insn & OPENRISC_MASK_TRAP) != OPENRISC_INSN_TRAP) {
> +		preempt_enable_no_resched();
> +		return true;
> +	}
> +
> +	preempt_enable_no_resched();
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_breakpoint_handler);
> +
> +bool kprobe_singlestep_handler(struct pt_regs *regs)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	unsigned long addr = instruction_pointer(regs);
> +
> +	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
> +	    ((unsigned long)&cur->ainsn.insn[1] == addr)) {
> +		/* Single stepping has been completed. Enable IRQs. */
> +		kprobe_local_irq_restore(kcb, regs);
> +		post_kprobe_handler(cur, kcb, regs);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_singlestep_handler);
> +
> +int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
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
> +		if (kcb->kprobe_status == KPROBE_REENTER)
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
> +
> +int __init arch_init_kprobes(void)
> +{
> +	return 0;
> +}
> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index a59abbca3555..2d6b29ea8c4f 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c
> @@ -30,10 +30,12 @@
>  #include <linux/kallsyms.h>
>  #include <linux/uaccess.h>
>  
> +#include <asm/break.h>
>  #include <asm/bug.h>
>  #include <asm/fpu.h>
>  #include <asm/insn-def.h>
>  #include <asm/io.h>
> +#include <asm/kprobes.h>
>  #include <asm/processor.h>
>  #include <asm/unwinder.h>
>  #include <asm/sections.h>
> @@ -216,10 +218,37 @@ asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
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
> +		if ((trap & OPENRISC_MASK_TRAP) != OPENRISC_INSN_TRAP)
> +			return;
> +
> +		bcode = (trap & OPENRISC_MASK_BCODE);
> +		switch (bcode) {
> +		case BRK_KPROBE_BP:
> +			if (kprobe_breakpoint_handler(regs))
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
>  }
> +NOKPROBE_SYMBOL(do_trap)
>  
>  asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
>  {
> diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> index e2af9b510804..701262a40134 100644
> --- a/arch/openrisc/lib/memcpy.c
> +++ b/arch/openrisc/lib/memcpy.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/export.h>
>  
> +#include <linux/kprobes.h>
>  #include <linux/string.h>
>  
>  #ifdef CONFIG_OR1K_1200
> @@ -122,4 +123,5 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
>  }
>  #endif
>  
> +NOKPROBE_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memcpy);
> diff --git a/arch/openrisc/lib/memset.S b/arch/openrisc/lib/memset.S
> index c3ac2a8b68d3..14e63af12d73 100644
> --- a/arch/openrisc/lib/memset.S
> +++ b/arch/openrisc/lib/memset.S
> @@ -9,6 +9,8 @@
>   * Copyright (C) 2015 Olof Kindgren <olof.kindgren@gmail.com>
>   */
>  
> +#include <asm/asm.h>
> +
>  	.global memset
>  	.type	memset, @function
>  memset:
> @@ -92,3 +94,5 @@ memset:
>  
>  4:	l.jr		r9
>  	 l.ori		r11, r3, 0
> +
> +_ASM_NOKPROBE(memset)
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 29e232d78d82..5263a832562f 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
>  #include <linux/extable.h>
> +#include <linux/kprobes.h>
>  #include <linux/sched/signal.h>
>  #include <linux/perf_event.h>
>  
> @@ -55,6 +56,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	tsk = current;
>  
> +	if (kprobe_page_fault(regs, vector))
> +		return;
> +
>  	/*
>  	 * We fault-in kernel-space virtual memory on-demand. The
>  	 * 'reference' page table is init_mm.pgd.
> @@ -351,3 +355,4 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  		return;
>  	}
>  }
> +NOKPROBE_SYMBOL(do_page_fault)
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 53ec6c8b8c40..84e26ebef70b 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -59,6 +59,10 @@ static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>  	pr_info("<%s> p->addr = 0x%p, era = 0x%lx, estat = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->csr_era, regs->csr_estat);
>  #endif
> +#ifdef CONFIG_OPENRISC
> +	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->pc, regs->sr);
> +#endif
>  
>  	/* A dump_stack() here will give a stack backtrace */
>  	return 0;
> @@ -100,6 +104,10 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  	pr_info("<%s> p->addr = 0x%p, estat = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->csr_estat);
>  #endif
> +#ifdef CONFIG_OPENRISC
> +	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->sr);
> +#endif
>  }
>  
>  static int __init kprobe_init(void)

I think this is looking pretty good.

Thank You,

-Stafford
