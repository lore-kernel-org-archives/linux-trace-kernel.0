Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37072C3757
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Apr 2026 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233467; cv=none; b=oQ9E2HN4FEtzaxRpPesul4FnepsgHSU8LC5bxBy0jnTtySD13UzOBIjRlKY2CoNs72FvI4RBH9DH7f39skTfFQpD4nfYZkzGUzGgTd/460kYOdkdq/bjj6j6m4fO0kuUEQVbmmtA5pQ4ovlDSsbSaJnyA4q7TcrAqwTBp+7FNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233467; c=relaxed/simple;
	bh=HG6JDrGtfQaRx9o8IdU6ob0KxbXWBXuFq6lG0QDLE04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9GOhKCn6jCT1UjOGQe9IYJHLlwuUSeWdp86a+KMbkGvlpKbgg851V3T35Z+7Xzfk8qs+MPU+lUs8dZBDAZK/zrDFhMir5eKbiYdsoPubdIATv28bnhV01hcE1FHN5aAhPFDHaIlbRr8fJn+d9SmBK+GvXf/Lol0GVAeUvl8yyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4ue3nDC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ue3nDC"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so5710062b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776233464; x=1776838264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D4ixRbcWbP2Euvq/IISGe50nb00WAHqUYDMp6lVcso=;
        b=X4ue3nDCPBKKvC/8/nvvDsl2w5lOvxIy6gRBitaiwYBuqUDzpBliTEh1HDAfenSuVD
         ieBV5UCdWyDBanXeEa8JSSOpe8JJfHCFM4Fo4eYtD4c35sbQxjAuAP7DcqDIy+kb5F5N
         dUy1RCoqgnqVclI1aZRGSUDUcr8sf7D1whe55BdB/kFdjXsLUUyEwjIMaYZWNrqmkEuk
         kt85DEQAeyX9K7CoSVOcHs4BYQaOSdmOxGMvYaKAgXGsuU7Di0r1m+fKviyUduYD9OAT
         zq0Zmroi0QJhCHwUrba58kBO3Z1RJiH7/uHQOHxe+y9gjKwFqiVMkQ+GBbQaGxA40SgB
         yR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233464; x=1776838264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D4ixRbcWbP2Euvq/IISGe50nb00WAHqUYDMp6lVcso=;
        b=nQGEGLYHfROtrb49m6xV9sHAIe8EoiIkJoGghvpBTsZ5ozrb7qbatAPB4wLe19WsUc
         RxcH7+OzJKo8uT5VJ+zbrku4X7Udkh4wmeMVihHY9yY5Ij+wlpMzjSg6+yrKd9QR9gaV
         bALlYy0lmO0w4rhnDYQGTPoMpSspnhRfNVmJo8dD/w03rxQ/HmtXsw0V5q3e+lUpyrxZ
         QSRjiVV89DBckgqYsoSZ4ka+56GxDVlf6hFm3IaqjLLDIaH2jRTrgcSetBphfZ55W6Nb
         RCCcgGGnbu0If+/jmPQzEH9HNRh/tfU6UZD6+nlwoXIFzo4UaGE0xNpDk1LlflYAjhlu
         SNQw==
X-Forwarded-Encrypted: i=1; AFNElJ/O+nCObGnpP10XxvnL33TqmPinAquuJ1WqDfNWUJfuIgONE6X4TSzY8/942zG/BFkrDE/1hMQcdStGb74nFeHSYXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuWssgFDB15hzxCg9Fs5+Dfv9KLcGiJ9hiJgHmyamSXjf8BpA
	GlACyx3LOtJBwexlXjiPuRoLb0Nsh4VCkeiSimgZxj+ZdoYwl67q+wi3
X-Gm-Gg: AeBDiev4nzDmUQqf7yfpxI3N7sOqeiqGKzIh0Facc4lxoSmNt436aAKFj7NokaQYRzU
	D1Fs3xOa3lY8LBkkNjV/gCgX8vr4ZmQ/HbFDe9ENDHpqn9trSuuZ1PftpCZW2txm5I4vLlrwxrV
	ON+Bup9IinvcVh/tlsienPNu2r8PtbCdYolnf5zHGk510QoWLtBwnkNRjZNiRgzH40H97k5sC9O
	AzzBqKazk+lHdHCNilZEm40pzr3fGlWbCcCoIrOOtq+6tfTT4gdFwkgNipjA9GkraWuQosrLaEX
	mdpXwbO8lvxF4JQwIcqzc9J3dKnyPCSIlMNsDN1SHd5cJ3m9gQVKN1Cc4LJ0Lly+JJZbOfnPMlY
	Usey3osMi9fyWkkozesJmN+V4RtTd/ZdbMnYrHXhxtJ93DUZe0FUyrkBKo2711xlGa9Jwow3FKo
	EEXtlWnazRo6xf8Rr4Y3HpmLamof+6vhhmKvqv5BiNMF25WmD3movMIATkLSLb7v8=
X-Received: by 2002:a05:6a00:bc8d:b0:82f:6858:3f6 with SMTP id d2e1a72fcca58-82f685808afmr1082773b3a.0.1776233463801;
        Tue, 14 Apr 2026 23:11:03 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c42:151c:9ad5:78a0:5dfa:8cb7? ([2401:4900:1c42:151c:9ad5:78a0:5dfa:8cb7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0ca3sm978653b3a.30.2026.04.14.23.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 23:11:03 -0700 (PDT)
Message-ID: <1c8c1663-b1f6-4306-b602-182b02273140@gmail.com>
Date: Wed, 15 Apr 2026 11:40:56 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] openrisc: Add utilities and clean up simulation of
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
 ardb@kernel.org, chenmiao.ku@gmail.com, johannes@sipsolutions.net,
 nsc@kernel.org, masahiroy@kernel.org, tytso@mit.edu,
 linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
 <20260407185650.79816-2-sahilcdq0@gmail.com> <ad51SeeF2Gv06mgQ@antec>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <ad51SeeF2Gv06mgQ@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

Thank you for your review.

On 4/14/26 10:41 PM, Stafford Horne wrote:
> Hello Sahil,
> 
> Thanks for your patches.  I have a few questions. so this is not really a
> technical review at the moment just some main items.
> 
> On Wed, Apr 08, 2026 at 12:26:49AM +0530, Sahil Siddiq wrote:
>> Introduce new instruction-related utilities and macros for OpenRISC.
>> This is in preparation for patches that add tracing support such as
>> KProbes.
>>
>> Simulate l.adrp. Fix bugs in simulation of l.jal and l.jalr. Earlier,
> 
> Why emulate l.adrp?  We don't really use this yet in any OpenRISC code.  This
> instruction is meant to be used to help -fpic code, see:
> 
>    https://openrisc.io/proposals/ladrp

Right, I couldn't find l.adrp in the kernel's image after compilation. But I
was thinking, in case l.adrp is used somewhere in the future (for e.g. in a
custom kernel module) and a probe is placed at that instruction, we would need
to emulate that instruction. This is because the target address is calculated
using the instruction's address (InsnAddr & -8192). If l.adrp is moved to an
out-of-line slot to single-step for KProbes, the slot's address will be used to
generate the target address instead of the original address.

Since l.adrp is not really used anywhere and it's highly unlikely that it will
be probed, an alternative could be to add l.adrp to the blacklist so that probes
at this instruction are never inserted.

>> PC was being updated and then saved in the link register r9, resulting
>> in a corrupted page table (bad page map in process). Instead, update
>> PC after storing it in r9.
>>
>> Move instruction simulation to its own file to enable reuse. Clean it
>> up and replace hardcoded values with computed expressions.
>>
>> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>>   arch/openrisc/include/asm/insn-def.h | 61 +++++++++++++++++++++--
>>   arch/openrisc/include/asm/spr_defs.h |  1 +
>>   arch/openrisc/kernel/Makefile        |  2 +-
>>   arch/openrisc/kernel/insn.c          | 74 ++++++++++++++++++++++++++++
>>   arch/openrisc/kernel/jump_label.c    |  2 +-
>>   arch/openrisc/kernel/traps.c         | 41 +--------------
>>   6 files changed, 136 insertions(+), 45 deletions(-)
>>   create mode 100644 arch/openrisc/kernel/insn.c
>>
>> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
>> index 1e0c028a5b95..c98f9770c52e 100644
>> --- a/arch/openrisc/include/asm/insn-def.h
>> +++ b/arch/openrisc/include/asm/insn-def.h
>> @@ -3,13 +3,66 @@
>>    * Copyright (C) 2025 Chen Miao
>>    */
>>   
>> +#include <asm/spr.h>
>> +#include <asm/spr_defs.h>
>> +
>>   #ifndef __ASM_OPENRISC_INSN_DEF_H
>>   #define __ASM_OPENRISC_INSN_DEF_H
>>   
>> -/* or1k instructions are always 32 bits. */
>> -#define	OPENRISC_INSN_SIZE		4
>> -
>>   /* or1k nop instruction code */
>> -#define OPENRISC_INSN_NOP     0x15000000U
>> +#define INSN_NOP	0x15000000U
> 
> Why remove the OPENRISC_ namespace from thse definitions?
> 
> Other architectures like arm64, riscv have namespaces on these similar
> definitions.

Oh, got it. I hadn't checked those architectures at that point. I was
following the convention in LoongArch and the namespace wasn't there. I'll
revert this change.

>> +
>> +#define INSN_CSYNC	0x23000000U
>> +#define INSN_MSYNC	0x22000000U
>> +#define INSN_PSYNC	0x22800000U
>> +
>> +#define OPCODE_TRAP	0x21000000U
>> +#define OPCODE_SYS	0x20000000U
>> +#define OPCODE_MACRC	0x18010000U

I'll add the namespace here.

>> +struct pt_regs;
>> +
>> +enum six_bit_opcodes {
> 
> I don't see why we need to name this six_bit as such.  OpenRISC
> instructions have either fir most significant 6-bits or 11-bits
> as opcodes but we still use the first 6-bits to drive the logic.

Maybe it should be renamed to something that indicates this is related
to probes (I wasn't able to come up with a better name).

The enums are used in a few places in KProbe's implementation to check
if an instruction requires emulation, has been blacklisted, or can be
single-stepped in an out-of-line slot. An alternative would be to use
macros (similar to OPCODE_SYS) but that won't have type checking. Either
way, I think it's better than using raw values in multiple places.

Shall I simply rename the enum type, or shall I switch to macros? What
are your thoughts?

>> +	l_rfe = 0x09,
>> +	l_lwa = 0x1b,
>> +	l_mfspr = 0x2d,
>> +	l_mtspr = 0x30,
>> +	l_swa = 0x33,
>> +	l_j = 0x00,
>> +	l_jal = 0x01,
>> +	l_adrp = 0x02,
>> +	l_bnf = 0x03,
>> +	l_bf = 0x04,
>> +	l_jr = 0x11,
>> +	l_jalr = 0x12,
>> +};
>> +
>> +struct insn {
>> +	unsigned int opcode: 6;
>> +	unsigned int operands: 26;
>> +};
>> +
>> +union openrisc_instruction {
>> +	unsigned int word;
>> +	struct insn opcodes_6bit;
>> +};
>> +
>> +#define OPENRISC_INSN_SIZE  (sizeof(union openrisc_instruction))
>> +
>> +/* Helpers for working with l.trap */
>> +static inline unsigned long __emit_trap(unsigned int code)
>> +{
>> +	return (code & 0xffff) | OPCODE_TRAP;
>> +}
>> +
>> +static inline bool has_delay_slot(void)
>> +{
>> +	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
>> +
>> +	return !(cpucfgr & SPR_CPUCFGR_ND);
>> +}
> 
> This is for handling CPU's that do not have delay slots.  We didn't do this
> before, why are you doing it now?  Should we mention this in the git commit
> message?

I am not entirely sure why CPUs with no delay slot were not taken into account
initially. The "in_delay_slot" function in traps.c [1] always assumes (for the
case where SPR_SR_DSX is not implemented) that the CPU has a delay slot if PC is
a branch instruction.

Given that the specification allows CPUs not to have a delay slot, I thought I
would include that as well. With no SPR_SR_DSX, if it can be guaranteed that PC
will be a branch instruction only when delay slots are enabled, then there should
be no change in behaviour in "simulate_branch" even with the addition of the
"has_delay_slot" check.

However, if PC can be a branch instruction even when there are no delay slots, then
"simulate_branch" now adds 4 to regs->pc instead of adding 8 unconditionally. Please
correct me if I am wrong.

"has_delay_slot" is particularly important for KProbes, since a probe at a branch
instruction with a delay slot means the branch will have to be emulated followed
by single-stepping of the delay slot instruction.

But if there are no delay slots, then only branch emulation is required.

> Also, since this is a static configuration for the CPU should we use static keys
> for this?

Yes, I think static keys can be used here. If the more likely case is that a delay
slot exists, we can make that the more likely branch.

>> +
>> +void simulate_pc(struct pt_regs *regs, unsigned int jmp);
>> +void simulate_branch(struct pt_regs *regs, unsigned int jmp, bool has_delay_slot);
>>   
>>   #endif /* __ASM_OPENRISC_INSN_DEF_H */
>> diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
>> index f0b6b492e9f4..5d13a9b96263 100644
>> --- a/arch/openrisc/include/asm/spr_defs.h
>> +++ b/arch/openrisc/include/asm/spr_defs.h
>> @@ -179,6 +179,7 @@
>>   #define SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
>>   #define SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
>>   #define SPR_CPUCFGR_OV64S  0x00000200  /* ORVDX64 supported */
>> +#define SPR_CPUCFGR_ND     0x00000400  /* No delay slot */
>>   #define SPR_CPUCFGR_RES	   0xfffffc00  /* Reserved */
>>   
>>   /*
>> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
>> index 19e0eb94f2eb..150779fbf010 100644
>> --- a/arch/openrisc/kernel/Makefile
>> +++ b/arch/openrisc/kernel/Makefile
>> @@ -5,7 +5,7 @@
>>   
>>   always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>>   
>> -obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
>> +obj-y	:= head.o insn.o setup.o or32_ksyms.o process.o dma.o \
>>   	   traps.o time.o irq.o entry.o ptrace.o signal.o \
>>   	   sys_call_table.o unwinder.o cacheinfo.o
>>   
>> diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
>> new file mode 100644
>> index 000000000000..2c97eceee6d7
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/insn.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * OpenRISC instruction utils
>> + *
>> + * Linux architectural port borrowing liberally from similar works of
>> + * others.  All original copyrights apply as per the original source
>> + * declaration.
>> + *
>> + * OpenRISC implementation:
>> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
>> + */
>> +
>> +#include <linux/ptrace.h>
>> +#include <asm/insn-def.h>
>> +
>> +void simulate_pc(struct pt_regs *regs, unsigned int jmp)
>> +{
>> +	int displacement;
>> +	unsigned int rd, op;
>> +
>> +	displacement = sign_extend32(((jmp) & 0x7ffff) << 13, 31);
>> +	rd = (jmp & 0x3ffffff) >> 21;
>> +	op = jmp >> 26;
>> +
>> +	switch (op) {
>> +	case l_adrp:
>> +		regs->gpr[rd] = displacement + (regs->pc & (-8192));
>> +		return;
>> +	default:
>> +		break;
>> +	}
>> +}
> 
> This function is not used, what will it be used for? Could you mention it in the
> commit message?  Also could you document it?

"simulate_pc" is used by KProbes for single-stepping l.adrp. At the moment, it's
not being used anywhere else. Maybe I should move this function to the second commit
which has the KProbe changes.

Also, this function can be removed altogether if we choose to blacklist l.adrp.

>> +
>> +void simulate_branch(struct pt_regs *regs, unsigned int jmp_insn, bool has_delay_slot)
> 
> Since you are using this for more than just instruction simulation now, maybe
> its good to document what it does. For example when we use it below we surround
> it with the in_delay_slot check.

I am a little confused here. The core of the function was already wrapped in the
"in_delay_slot" check [2]. I moved it to a new file so instruction emulation could be
used in other places as well(e.g., in KProbes). Functionality wise, the function is
still the same with the added feature that it also supports CPUs with no delay slot.

>> +{
>> +	int displacement;
>> +	unsigned int rb, op, jmp;
>> +
>> +	displacement = sign_extend32(((jmp_insn) & 0x3ffffff) << 2, 27);
>> +	rb = (jmp_insn & 0x0000ffff) >> 11;
>> +	op = jmp_insn >> 26;
> 
> Naming this variable jmp is a bit misleading.  Maybe something like
> link_displacement, link_offset or fallthrough?

Sure, I'll rename this.

>> +	jmp = has_delay_slot ? 2 * OPENRISC_INSN_SIZE : OPENRISC_INSN_SIZE;
>> +
>> +	switch (op) {
>> +	case l_j: /* l.j */
>> +		regs->pc += displacement;
>> +		return;
>> +	case l_jal: /* l.jal */
>> +		regs->gpr[9] = regs->pc + jmp;
>> +		regs->pc += displacement;
>> +		return;
>> +	case l_bnf: /* l.bnf */
>> +		if (regs->sr & SPR_SR_F)
>> +			regs->pc += jmp;
>> +		else
>> +			regs->pc += displacement;
>> +		return;
>> +	case l_bf: /* l.bf */
>> +		if (regs->sr & SPR_SR_F)
>> +			regs->pc += displacement;
>> +		else
>> +			regs->pc += jmp;
>> +		return;
>> +	case l_jr: /* l.jr */
>> +		regs->pc = regs->gpr[rb];
>> +		return;
>> +	case l_jalr: /* l.jalr */
>> +		regs->gpr[9] = regs->pc + jmp;
>> +		regs->pc = regs->gpr[rb];
>> +		return;
>> +	default:
>> +		break;
>> +	}
>> +}
>> diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
>> index ab7137c23b46..fe082eb847a4 100644
>> --- a/arch/openrisc/kernel/jump_label.c
>> +++ b/arch/openrisc/kernel/jump_label.c
>> @@ -34,7 +34,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>>   
>>   		insn = offset;
>>   	} else {
>> -		insn = OPENRISC_INSN_NOP;
>> +		insn = INSN_NOP;
>>   	}
>>   
>>   	if (early_boot_irqs_disabled)
>> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
>> index c195be9cc9fc..ee87a3af34fc 100644
>> --- a/arch/openrisc/kernel/traps.c
>> +++ b/arch/openrisc/kernel/traps.c
>> @@ -32,6 +32,7 @@
>>   
>>   #include <asm/bug.h>
>>   #include <asm/fpu.h>
>> +#include <asm/insn-def.h>
>>   #include <asm/io.h>
>>   #include <asm/processor.h>
>>   #include <asm/unwinder.h>
>> @@ -269,47 +270,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
>>   
>>   static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
>>   {
>> -	int displacement;
>> -	unsigned int rb, op, jmp;
>> -
>>   	if (unlikely(in_delay_slot(regs))) {
>>   		/* In delay slot, instruction at pc is a branch, simulate it */
>> -		jmp = *((unsigned int *)regs->pc);
>> -
>> -		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
>> -		rb = (jmp & 0x0000ffff) >> 11;
>> -		op = jmp >> 26;
>> -
>> -		switch (op) {
>> -		case 0x00: /* l.j */
>> -			regs->pc += displacement;
>> -			return;
>> -		case 0x01: /* l.jal */
>> -			regs->pc += displacement;
>> -			regs->gpr[9] = regs->pc + 8;
>> -			return;
>> -		case 0x03: /* l.bnf */
>> -			if (regs->sr & SPR_SR_F)
>> -				regs->pc += 8;
>> -			else
>> -				regs->pc += displacement;
>> -			return;
>> -		case 0x04: /* l.bf */
>> -			if (regs->sr & SPR_SR_F)
>> -				regs->pc += displacement;
>> -			else
>> -				regs->pc += 8;
>> -			return;
>> -		case 0x11: /* l.jr */
>> -			regs->pc = regs->gpr[rb];
>> -			return;
>> -		case 0x12: /* l.jalr */
>> -			regs->pc = regs->gpr[rb];
>> -			regs->gpr[9] = regs->pc + 8;
>> -			return;
>> -		default:
>> -			break;
>> -		}
>> +		simulate_branch(regs, *((unsigned int *)regs->pc), has_delay_slot());
>>   	} else {
>>   		regs->pc += 4;
>>   	}
>> -- 
>> 2.53.0
>>

Thanks,
Sahil

[1] https://github.com/openrisc/linux/blob/for-next/arch/openrisc/kernel/traps.c#L248
[2] https://github.com/openrisc/linux/blob/for-next/arch/openrisc/kernel/traps.c#L275-L312

