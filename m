Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590042;
	b=mVvMfFiFROBap/LB6Nm5iJLb369mpRugqx0h/MhCV+yTmdTDbwT91oh81e1ffH5FR8w3
	 RSv2MFSIIT75t3aD8yMJoDISxhTneLxhBp/x14XLSSC5IHpgNIEDCZlk0v42twHD2lW/E
	 5xs3evli5GCxHMVcYgukKDrLaUzoCdLkgZ5eUmh1wqrpurkJy+YSdfTYf7N9i6nazc6XN
	 k0T+hrF2j55EKXptNqvpUjk1MpePT7jei3YLvjkPfM5TQmu1mkxBkggI7VjH3P1EAwY20
	 Qa70tPhk3KAJ0B6XRh8LpSmwJPB+aNME6tTH6PACde1e+BK0gyzwb/liWbm8BT7Z9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eV4EMck7ua2oji763Ozbv/4xPFFvkfSPPx49JgMp1mI=;
	b=pKLs/Izaj1+h/h4GK+W0iygrAYESdH+DUq3E0UY4Olk8Ca+++lJn5hkg0muxVuiBUaFf
	 rPnwKsg24vRd+L8/49242rR44UVAed7oow1ku/Vt/zwysMyA/Di32oGVLGpdnabE5qHuC
	 YNJG+mlLxszEl4DySreGfhZwajpWb4zdWrdWYnOurV2WHUbMT413kbUNKtZrajro7kMRS
	 dOS+1VjMFCBmbGb9TCbD/pdEpVLh3bYZnq0YWVVR3VXQXSpmh2HysIEdTsJorKtxEsnms
	 X/EZ7zQ88YrcU7KPYgnQNdiRaIBwb2RitZWQV9uixtITU4dde6ibufoNn3JmAEKQSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnzxSZ4k;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDF606A334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 17:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBDF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnzxSZ4k
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37600b0db49so2014079eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590041; x=1795194841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eV4EMck7ua2oji763Ozbv/4xPFFvkfSPPx49JgMp1mI=;
        b=qnzxSZ4kbNFeuamd3ULxqjw2hD29N/BlR3b2nwnNRwm5fBOyZNVaaTj3Fiu1dfeg4Y
         KoBmlhElIkUO/nQDd6WhfkVupES6TXVLbAxoZl7zcQWtWcCYMxqdPMK4elr115jFtg6T
         skGDTsYt2q2uDQkWa4PdvOARtynd+wbf7Rl3m/k7gMbxl0Hk65QjtxVHKFrCbTStImfa
         z4oCjmvMsXYivdcThiI7dhzZBr/o82/+6GB0EbuDB06AET5MEPmIwesJT6IaNZZciao4
         4wWGyhGqGCybnJhG4VEpr+KgML1V7LN6BA/0C7/L5Xme+O2MFW3b/UhtBrjFgQFleG4a
         PsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590041; x=1795194841;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eV4EMck7ua2oji763Ozbv/4xPFFvkfSPPx49JgMp1mI=;
        b=OefB70GKF9e8Fcl7MTASPWphbXMp01OshSYxjqer+d9HZzmjuwzjspNpoO085RShbE
         lw+QjveLEOyXcbtJ3nJPsi9QeUHUUgMyQGeutRGL1jWQxIM0fg3rW5UvgSkBJ8sEaror
         giS29nqK2qRkxwUXe6W4UWcwv99LvvUTzE4a0S/xXVtMCrKHuGtABYZGwNsfdsHjfb54
         EyeOd33gVFscztjrbDdbtv/ZlC6hfSWiE61lXeob19/018J/l1Gxupy107zstoxlXoWP
         EW1R9QwRrbcv8+rH/IXn8x5CwrErdcqe+/Xv/tGxbdZQ8GH/tVfaK0PSMDYK8WmprwKW
         nwZQ==
X-Forwarded-Encrypted: i=1; AL+hErHppWMoUwEnaxkNNcD7Ei12Spn5UzbTH3lJVY/WkN34ZJjd+TnJPT4gf34I7Gg/OylBkhosFozaxaD6rVSoixOgg8I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0MgFIJVhpkXX6ZS9gtQ8VHoLs6HDbwDtiOP3YibIvBjoMU3M9
	qQg5MUuvFVwxNcHiz26GvV9wqCGlN98I7rp1hBRWURY59RO6XwDANPtf
X-Gm-Gg: AYBFou1xAsnQ7YAVy/iUxbtdfre8uP1wUB3w2s5LMLRALrReYp5yXY0t++VsJfdRDFp
	/gwww7BiCL+v+HbiBvpNkYQLym0hEoIGAKFOtXhVDNzSWbCvBqup1ZMjRpETYCSadP2fUjntYRZ
	JcsYomdlzbJwVljkRGQcBVW2Rvpnh7YYNeOWsBQYfOjTkZWB3NCaZAC683utnYxpFA84NCw3/aF
	P3aP1ieBlMf6xYXkx923OelXNuWNDmUrsxpijal2JIhghuCYucnPPmkjwDVwAU1rR31p+EZHaNX
	JxXrwJILJbe9vxJV8XxfxoCWx7zR/SPrXoVMeUKB6WK29eAzL5Q+JOv1ysoQzgKawI/+dFMi4uJ
	a4N0Uh7D0WcuQ7SgHtBPin9110u98q+2AWcpNpJIo1B4FXdPbVUWFjkahBaY8fxSS/MoRm5+oVV
	lb9WXlspAUBGo2Di5O4ydLlWECp2zlwIE5prw8EHYTodJXgX2Q3VOBR/L3tx9hl74Q55DhxMoaX
	mqDnkRdU1bvoNgP2RMyvNh7tUuPfR1mwOxh40wZR8GgFSI+Ymrm/0UVvp0my5zkEv70M5Ef
X-Received: by 2002:a05:7022:b047:10b0:145:ac96:3917 with SMTP id a92af1059eb24-1b505b5c57bmr1894404c88.21.1794590041100;
        Fri, 13 Nov 2026 09:14:01 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm8678898c88.14.2026.11.13.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:14:00 -0800 (PST)
Message-ID: <33becbe3-867a-4e54-8471-7f0101af8623@gmail.com>
Date: Fri, 13 Nov 2026 22:43:55 +0530
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil <sahilcdq0@gmail.com>
Subject: Re: [PATCH v3 2/4] openrisc: Add KProbes
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-3-sahilcdq0@gmail.com> <avAo140Wc1CerVwf@antec>
Content-Language: en-US
In-Reply-To: <avAo140Wc1CerVwf@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 1:16 PM, Stafford Horne wrote:
> On Tue, Oct 27, 2026 at 01:42:38AM +0530, Sahil Siddiq wrote:
>> Add KProbes support for OpenRISC. This work is primarily based
>> on similar work done for LoongArch, MIPS and RISC-V.
>>
>> KProbes make it possible to trap at almost any address in the
>> kernel to collect performance/debugging info.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/kprobes.c:
>>    - (kprobe_local_irq_save): New function
>>    - (kprobe_local_irq_restore): Likewise
>>    - (arch_prepare_kprobe): Use copy_from_kernel_nofault()
>>    - (post_kprobe_handler): Enable preemption before returning early for reentered KProbe
>>    - (setup_singlestep): Disable IRQs by toggling bits in SR register
>>    - (kprobe_breakpoint_handler): Use result from get_kernel_nofault()
>>    - (kprobe_fault_handler):
>>      Enable preemption after handling reentered KProbe
>>      Restore IRQs by toggling bits in SR register
>>
>> Changes v1 -> v2:
>> - arch/openrisc/include/asm/kprobes.h:
>>     - (struct prev_kprobe): Add restore_pc
>>     - (struct kprobe_ctlblk): Move restore_pc from global "struct arch_specific_insn"
>> - arch/openrisc/kernel/kprobes.c:
>>     - Use macros instead of magic values
>>     - Use "get_kernel_nofault" instead of directly dereferencing address
>>     - (insns_need_simulation): Use "daley slot" static key
>>     - (arch_prepare_kprobe): Prevent KProbe insertion if instruction in delay slot also requires simulation
>>     - (save_previous_kprobe): Use "restore_pc"
>>     - (restore_previous_kprobe): Likewise
>>     - (post_kprobe_handler): Don't re-enable preemption if KProbe is nested
>>     - (setup_singlestep): Use "restore_pc"
>>     - (reenter_kprobe): Return false in case of unrecoverable KProbe
>>     - (kprobe_singlestep_handler): Enable interrupt in pt_regs->sr
>>     - (kprobe_fault_handler): Likewise
>>
>>   arch/openrisc/Kconfig                   |   1 +
>>   arch/openrisc/configs/or1ksim_defconfig |   2 +
>>   arch/openrisc/configs/virt_defconfig    |   2 +
>>   arch/openrisc/include/asm/asm.h         |  22 ++
>>   arch/openrisc/include/asm/break.h       |  19 ++
>>   arch/openrisc/include/asm/insn-def.h    |   6 +
>>   arch/openrisc/include/asm/kprobes.h     |  77 +++++
>>   arch/openrisc/kernel/Makefile           |   1 +
>>   arch/openrisc/kernel/entry.S            |  16 +
>>   arch/openrisc/kernel/kprobes.c          | 426 ++++++++++++++++++++++++
>>   arch/openrisc/kernel/traps.c            |  29 ++
>>   arch/openrisc/lib/memcpy.c              |   2 +
>>   arch/openrisc/lib/memset.S              |   4 +
>>   arch/openrisc/mm/fault.c                |   5 +
>>   samples/kprobes/kprobe_example.c        |   8 +
>>   15 files changed, 620 insertions(+)
>>   create mode 100644 arch/openrisc/include/asm/asm.h
>>   create mode 100644 arch/openrisc/include/asm/break.h
>>   create mode 100644 arch/openrisc/include/asm/kprobes.h
>>   create mode 100644 arch/openrisc/kernel/kprobes.c
>>
>> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
>> index 9156635dd264..d240533b424b 100644
>> --- a/arch/openrisc/Kconfig
>> +++ b/arch/openrisc/Kconfig
>> @@ -27,6 +27,7 @@ config OPENRISC
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>   	select HAVE_PCI
>> +	select HAVE_KPROBES
>>   	select HAVE_UID16
>>   	select HAVE_PAGE_SIZE_8KB
>>   	select HAVE_REGS_AND_STACK_ACCESS_API
>> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
>> index 769705ac24d5..24d2915e7609 100644
>> --- a/arch/openrisc/configs/or1ksim_defconfig
>> +++ b/arch/openrisc/configs/or1ksim_defconfig
>> @@ -10,7 +10,9 @@ CONFIG_EXPERT=y
>>   # CONFIG_KALLSYMS is not set
>>   CONFIG_BUILTIN_DTB_NAME="or1ksim"
>>   CONFIG_HZ_100=y
>> +CONFIG_OPENRISC=y
> 
> I am not sure this is needed, did you generate this file with make
> savedefconfig?  I thought CONFIG_OPENRISC would be set for every openrisc build
> by default so not needed in the *_defconfig.
> 

Ah, yes. I hadn't noticed that CONFIG_OPENRISC is set automatically. This does not need to be set
manually. I'll remove it from both defconfig files.

>>   CONFIG_JUMP_LABEL=y
>> +CONFIG_KPROBES=y
>>   CONFIG_MODULES=y
>>   # CONFIG_BLOCK is not set
>>   CONFIG_SLUB_TINY=y
>> diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
>> index 0b9979b35ca8..2eccb506032f 100644
>> --- a/arch/openrisc/configs/virt_defconfig
>> +++ b/arch/openrisc/configs/virt_defconfig
>> @@ -11,8 +11,10 @@ CONFIG_OPENRISC_HAVE_INST_SEXT=y
>>   CONFIG_NR_CPUS=8
>>   CONFIG_SMP=y
>>   CONFIG_HZ_100=y
>> +CONFIG_OPENRISC=y
>>   # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
>>   CONFIG_JUMP_LABEL=y
>> +CONFIG_KPROBES=y
>>   # CONFIG_COMPAT_BRK is not set
>>   CONFIG_NET=y
>>   CONFIG_PACKET=y
>> diff --git a/arch/openrisc/include/asm/asm.h b/arch/openrisc/include/asm/asm.h
>> new file mode 100644
>> index 000000000000..aafe08029b4b
>> --- /dev/null
>> +++ b/arch/openrisc/include/asm/asm.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Macros for OpenRISC asm
>> + *
>> + * Linux architectural port borrowing nearly verbatim from
>> + * LoongArch and Arm. All original copyrights apply as per
>> + * the original source declaration.
>> + */
>> +
>> +#ifndef __ASM_ASM_H
>> +#define __ASM_ASM_H
>> +
>> +#ifdef CONFIG_KPROBES
>> +#define _ASM_NOKPROBE(symbol)			\
>> +	.pushsection "_kprobe_blacklist", "aw";	\
>> +	.long symbol;				\
>> +	.popsection
>> +#else
>> +#define _ASM_NOKPROBE(symbol)
>> +#endif
>> +
>> +#endif /* __ASM_ASM_H */
>> diff --git a/arch/openrisc/include/asm/break.h b/arch/openrisc/include/asm/break.h
>> new file mode 100644
>> index 000000000000..04a74d863eef
>> --- /dev/null
>> +++ b/arch/openrisc/include/asm/break.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * OpenRISC trap codes used internally by the kernel
>> + *
>> + * Linux architectural port borrowing liberally from similar works of
>> + * others.  All original copyrights apply as per the original source
>> + * declaration.
>> + *
>> + * Modifications for the OpenRISC architecture:
>> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
>> + */
>> +
>> +#ifndef __ASM_BREAK_H
>> +#define __ASM_BREAK_H
>> +
>> +#define BRK_KPROBE_BP       512     /* Kprobe break */
>> +#define BRK_KPROBE_SSTEPBP  1024    /* Kprobe single-step software implementation */
>> +
>> +#endif /* __ASM_BREAK_H */
>> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
>> index ccbda049171f..3680c0a94faf 100644
>> --- a/arch/openrisc/include/asm/insn-def.h
>> +++ b/arch/openrisc/include/asm/insn-def.h
>> @@ -54,6 +54,12 @@ struct pt_regs;
>>   
>>   #define OPENRISC_INSN_SIZE	4
>>   
>> +/* Helpers for working with l.trap */
>> +static inline unsigned long __emit_trap(unsigned long code)
>> +{
>> +	return (code & OPENRISC_MASK_BCODE) | OPENRISC_INSN_TRAP;
>> +}
>> +
>>   static __always_inline unsigned char get_6_bit_opcode(unsigned long insn)
>>   {
>>   	return (insn >> OPENRISC_OPCODE_SHIFT) & OPENRISC_OPCODE_MASK;
>> diff --git a/arch/openrisc/include/asm/kprobes.h b/arch/openrisc/include/asm/kprobes.h
>> new file mode 100644
>> index 000000000000..2b5847002141
>> --- /dev/null
>> +++ b/arch/openrisc/include/asm/kprobes.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * OpenRISC Linux
>> + *
>> + * Linux architectural port borrowing liberally from similar works of
>> + * others.  All original copyrights apply as per the original source
>> + * declaration.
>> + *
>> + * OpenRISC implementation:
>> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
>> + */
>> +
>> +#ifndef __ASM_OPENRISC_KPROBES_H
>> +#define __ASM_OPENRISC_KPROBES_H
>> +
>> +#include <asm-generic/kprobes.h>
>> +
>> +#ifdef CONFIG_KPROBES
>> +#include <asm/break.h>
>> +#include <asm/cacheflush.h>
>> +
>> +#define	 __ARCH_WANT_KPROBES_INSN_SLOT
>> +
>> +struct pt_regs;
>> +struct kprobe;
>> +
>> +typedef u32 kprobe_opcode_t;
>> +
>> +/*
>> + * MAX_INSN_SIZE is used as the number of slots in an executable
>> + * page for single-stepping out of line (SSOL). We need two slots
>> + * since we single-step using software breakpoints. The probed
>> + * instruction is placed in the first slot with a breakpoint
>> + * instruction in the second slot.
>> + */
>> +#define MAX_INSN_SIZE	2
>> +
>> +/* Architecture specific copy of original instruction */
>> +struct arch_specific_insn {
>> +	/* copy of original instruction */
>> +	kprobe_opcode_t *insn;
>> +};
>> +
>> +struct prev_kprobe {
>> +	struct kprobe *kp;
>> +	unsigned int status;
>> +	unsigned long restore_pc;
>> +};
>> +
>> +/* per-cpu kprobe control block */
>> +struct kprobe_ctlblk {
>> +	unsigned int kprobe_status;
>> +	unsigned long irq_flags;
>> +	/* address of next instruction in case of SSOL */
>> +	unsigned long restore_pc;
>> +	struct prev_kprobe prev_kprobe;
>> +};
>> +
>> +#define flush_insn_slot(p)		do { } while (0)
> 
> On openrisc I think we need to implement flush_insn_slot.  As our
> copy's only affect data caches instruction caches may end up being
> stale.  This is really hard to detect as context switches invalidate
> a lot of the instruction cache lines, but not all.
> 
> I fixed this for text patching recently with commit aca063c90245
> ("openrisc: Fix jump_label smp syncing")

Understood. In the same commit [1], you have also mentioned that
invalidating all the cache lines is less expensive than keeping
track of which line needs to be invalidated.

In case of KProbes, where a KProbe at a specific instruction is
armed or disarmed:

void arch_arm_kprobe(struct kprobe *p) {
     patch_insn_write(p->addr, KPROBE_BP_INSN);
     flush_insn_slot(p);
}

void arch_disarm_kprobe(struct kprobe *p) {
     patch_insn_write(p->addr, p->opcode);
     flush_insn_slot(p);
}

Should only that page be invalidated? Or is it ok to invalidate all
lines?

>> +#define kretprobe_blacklist_size	0
>> +
>> +void arch_remove_kprobe(struct kprobe *p);
>> +int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>> +bool kprobe_breakpoint_handler(struct pt_regs *regs);
>> +bool kprobe_singlestep_handler(struct pt_regs *regs);
>> +#else /* !CONFIG_KPROBES */
>> +static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool kprobe_singlestep_handler(struct pt_regs *regs)
>> +{
>> +	return false;
>> +}
>> +#endif /* CONFIG_KPROBES */
>> +#endif /* __ASM_OPENRISC_KPROBES_H */
>> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
>> index 150779fbf010..2ac824867963 100644
>> --- a/arch/openrisc/kernel/Makefile
>> +++ b/arch/openrisc/kernel/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>>   obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>>   obj-$(CONFIG_MODULES)		+= module.o
>>   obj-$(CONFIG_OF)		+= prom.o
>> +obj-$(CONFIG_KPROBES)		+= kprobes.o
>>   obj-y	+= patching.o
>>   
>>   clean:
>> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
>> index c7e90b09645e..cd28bf1f7a3b 100644
>> --- a/arch/openrisc/kernel/entry.S
>> +++ b/arch/openrisc/kernel/entry.S
>> @@ -15,6 +15,7 @@
>>   #include <linux/linkage.h>
>>   #include <linux/pgtable.h>
>>   
>> +#include <asm/asm.h>
>>   #include <asm/processor.h>
>>   #include <asm/unistd.h>
>>   #include <asm/thread_info.h>
>> @@ -640,6 +641,7 @@ ENTRY(_sys_call_handler)
>>   	/* r30 is the only register we clobber in the fast path */
>>   	/* r30 already saved */
>>   /*	l.sw    PT_GPR30(r1),r30 */
>> +_ASM_NOKPROBE(_sys_call_handler)
> 
> How is this working for these not function symbols?  _ASM_NOKPROBE registers a
> sybmol (in this case just a macro address) into the _kprobe_blacklist.  I think
> withing kprobe.c it uses these _kprobe_blacklist entries to detect ranges that
> cannot be probed.  However, in this case I think you are not able to get range
> information.

_ASM_NOKPROBE and NOKPROBE_SYMBOL (for functions in C) expand to the
same thing functionally. The kernel treats these labels as symbols as
well. I verified this using "nm".

When a KProbe is registered using an address instead of the symbol_name,
"register_kprobe()" [2] at kernel/kprobes.c indirectly calls
"within_kprobe_blacklist()" [3] which performs "kprobe_lookup_name()".
It then checks if that name is in the blacklist. This blacklist
includes the names of the asm functions as well.

I wrote this test module [4] to verify that an address in memcpy's range,
for example, is also blacklisted.

>>   _syscall_check_trace_enter:
>>   	/* syscalls run with interrupts enabled */
>> @@ -652,12 +654,14 @@ _syscall_check_trace_enter:
>>   	l.sfne	r30,r0
>>   	l.bf	_syscall_trace_enter
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_check_trace_enter)
>>   
>>   _syscall_check:
>>   	/* Ensure that the syscall number is reasonable */
>>   	l.sfgeui r11,__NR_syscalls
>>   	l.bf	_syscall_badsys
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_check)
>>   
>>   _syscall_call:
>>   	l.movhi r29,hi(sys_call_table)
>> @@ -668,12 +672,14 @@ _syscall_call:
>>   
>>   	l.jalr  r29
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_call)
>>   
>>   _syscall_return:
>>   	/* All syscalls return here... just pay attention to ret_from_fork
>>   	 * which does it in a round-about way.
>>   	 */
>>   	l.sw    PT_GPR11(r1),r11           // save return value
>> +_ASM_NOKPROBE(_syscall_return)
>>   
>>   #if 0
>>   _syscall_debug:
>> @@ -708,6 +714,7 @@ _syscall_check_trace_leave:
>>   	l.sfne	r30,r0
>>   	l.bf	_syscall_trace_leave
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_check_trace_leave)
>>   
>>   /* This is where the exception-return code begins... interrupts need to be
>>    * disabled the rest of the way here because we can't afford to miss any
>> @@ -744,6 +751,7 @@ _syscall_check_work:
>>   	/* _work_pending needs to be called with interrupts disabled */
>>   	l.j	_work_pending
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_check_work)
>>   
>>   _syscall_resume_userspace:
>>   //	ENABLE_INTERRUPTS(r29)
>> @@ -800,6 +808,7 @@ _syscall_resume_userspace:
>>   	l.mtspr r0,r13,SPR_EPCR_BASE
>>   	l.mtspr r0,r15,SPR_ESR_BASE
>>   	l.rfe
>> +_ASM_NOKPROBE(_syscall_resume_userspace)
>>   
>>   /* End of hot path!
>>    * Keep the below tracing and error handling out of the hot path...
>> @@ -829,6 +838,7 @@ _syscall_trace_enter:
>>   
>>   	l.j	_syscall_check
>>   	 l.lwz	r8,PT_GPR8(r1)
>> +_ASM_NOKPROBE(_syscall_trace_enter)
>>   
>>   _syscall_trace_leave:
>>   	l.jal	do_syscall_trace_leave
>> @@ -836,6 +846,7 @@ _syscall_trace_leave:
>>   
>>   	l.j	_syscall_check_work
>>   	 l.nop
>> +_ASM_NOKPROBE(_syscall_trace_leave)
>>   
>>   _syscall_badsys:
>>   	/* Here we effectively pretend to have executed an imaginary
>> @@ -845,6 +856,7 @@ _syscall_badsys:
>>   	 */
>>   	l.j	_syscall_return
>>   	 l.addi	r11,r0,-ENOSYS
>> +_ASM_NOKPROBE(_syscall_badsys)
>>   
>>   /******* END SYSCALL HANDLING *******/
>>   
>> @@ -870,6 +882,7 @@ EXCEPTION_ENTRY(_trap_handler)
>>   
>>   	l.j     _ret_from_exception
>>   	 l.nop
>> +_ASM_NOKPROBE(_trap_handler)
>>   
>>   /* ---[ 0xf00: Reserved exception ]-------------------------------------- */
>>   
>> @@ -1004,6 +1017,8 @@ ENTRY(_ret_from_exception)
>>   	 l.nop
>>   	l.j	_resume_userspace
>>   	 l.nop
>> +_ASM_NOKPROBE(_ret_from_exception)
>> +_ASM_NOKPROBE(_ret_from_intr)
>>   
>>   ENTRY(ret_from_fork)
>>   	l.jal	schedule_tail
>> @@ -1038,6 +1053,7 @@ ENTRY(ret_from_fork)
>>   
>>   	l.j	_syscall_return
>>   	 l.nop
>> +_ASM_NOKPROBE(ret_from_fork)
>>   
>>   /* ========================================================[ switch ] === */
>>   
>> diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobes.c
>> new file mode 100644
>> index 000000000000..0b8762e340d5
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/kprobes.c
>> @@ -0,0 +1,426 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Kernel probes (KProbes) for OpenRISC
>> + *
>> + * Linux architectural port borrowing liberally from similar works of
>> + * others.  All original copyrights apply as per the original source
>> + * declaration.
>> + *
>> + * OpenRISC implementation:
>> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
>> + */
>> +
>> +#include <linux/kprobes.h>
>> +#include <asm/cpuinfo.h>
>> +#include <asm/insn-def.h>
>> +#include <asm/text-patching.h>
>> +
>> +DEFINE_PER_CPU(struct kprobe *, current_kprobe);
>> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>> +
>> +#define KPROBE_BP_INSN		__emit_trap(BRK_KPROBE_BP)
>> +#define KPROBE_SSTEPBP_INSN	__emit_trap(BRK_KPROBE_SSTEPBP)
> 
> Could you maybe add a comment about why these instructions are not supported?

Sure, I'll do that.

>> [...]
>>   
>>   static int __init kprobe_init(void)
> 
> I think this is looking pretty good.
> 
> Thank You,
> 
> -Stafford

Thanks,
Sahil

[1] https://github.com/torvalds/linux/commit/1be031de802ba486a7605b52eda825f128b026e2
[2] https://github.com/torvalds/linux/blob/master/kernel/kprobes.c#L2002
[3] https://github.com/torvalds/linux/blob/master/kernel/kprobes.c#L1730
[4] https://github.com/valdaarhun/or-dev/blob/main/home/kprobes_blacklist.c

