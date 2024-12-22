Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653933D1;
	Sun, 22 Dec 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734874060; cv=none; b=SDI5JudsPccjD8VqwWA6Xds4BZu4ASDdwBxsIL33SJWYfvY8Mqaqsf5rbAhEsIV/YkQCmoKMPYdrU3+50XzXTXHldz0YqmjmSDK1W8QKSj7u7/A9zlNMb+Cp4OliQ/ZyDZyCIgmr9wqBPyZxKmzkblbOXqfG96Lu10PHXYiVb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734874060; c=relaxed/simple;
	bh=vE5Ex4RbVNPBJiSc6deG+TN+uBf2Cpy+VxJxXpgIpws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2nU5NH96D6+g5dJgIfHorKHXrybuKqY71cWU30Crd2vvnxVmiPupSWXVrU+6b1IfD9+rzyq5yWwHZin2WAxkVVUt1rNSoE8bo3HhznlEvsavUHqaZm1I77Yqyt6CbF+d0sKBvny+dFxGcv6XCPKgK/OL1On6m8a/BGg9WLBlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=QJAFBbQa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="QJAFBbQa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15E68240005;
	Sun, 22 Dec 2024 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1734874050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBi/+Xd8HtagTzm/ZTCPArqfARuKQKxyZkR5QHdtjAA=;
	b=QJAFBbQahgb9beQVPtQ/t3aDhnyCxyaaw3QuYWLQc5d5JAX6ubEeL571Y86swcBb8X1KlR
	PEWCqTY9MM/txvHWyxGESOcUlggTecB+aqNmjBKYCcPUR0cLOHufn1vWECneLtkMtXdk5E
	AP3G09aBLDIeaVBeZP0O7WKP55DD+eWoKFmMztx+QvZMAUsl4ozZhGjXn79lW7NW1EptNd
	HqNrRk3zzmax1WAl8a/6lc2hnA6gWb4ha2N5xijKaIO1TA35N11y4YTMmYQbJMBIG8aNtW
	/luB/tVU716Ynx2fSgNw/sgyooayWawk/aGQMfK66SZJYRv2JdZ9Ard/Q2Oflg==
Message-ID: <9387ffac-27cf-4b24-89d7-c61ced4cfca5@yoseli.org>
Date: Sun, 22 Dec 2024 14:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arch: m68k: Add STACKTRACE support
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
 <20241204-add-m68k-tracing-support-v4-2-e24fe5ef3b6b@yoseli.org>
 <599c48cd-f49b-4a70-9acb-4b90e667e490@linux-m68k.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <599c48cd-f49b-4a70-9acb-4b90e667e490@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 22/12/2024 14:14, Greg Ungerer wrote:
> Hi JM,
> 
> On 4/12/24 17:14, Jean-Michel Hautbois wrote:
>> In order to use tracing, implement a basic arch_stack_walk() based on
>> the one in PowerPC.
>> Tested on a M54418 coldfire.
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> ---
>>   arch/m68k/Kconfig             |  5 ++++
>>   arch/m68k/kernel/Makefile     |  1 +
>>   arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   3 files changed, 76 insertions(+)
>>
>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>> index 
>> 793ab1e2762609725bbf793f6dffecfa3ecfff0f..3ad8596aab71190807f8c11dd5876aa1198760f3 100644
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -106,6 +106,11 @@ config BOOTINFO_PROC
>>         Say Y to export the bootinfo used to boot the kernel in a
>>         "bootinfo" file in procfs.  This is useful with kexec.
>> +config STACKTRACE_SUPPORT
>> +    def_bool MMU_COLDFIRE
> 
> Modulo testing is there any reason this is enabled only for MMU ColdFire 
> targets?

You said it, modulo testing (and lack of knowledge on my side to be 
certain it is not coldfire specific) :-).

If it can be tested on other machines, I would be glad to change it !

Thanks,
JM

> There doesn't look to be anything that is ColdFire specific in these 
> changes,
> looks like it should work on any m68k machine.
> 
> Regards
> Greg
> 
> 
> 
>> +    select ARCH_STACKWALK
>> +    select ARCH_WANT_FRAME_POINTERS
>> +
>>   menu "Platform setup"
>>   source "arch/m68k/Kconfig.cpu"
>> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
>> index 
>> 6c732ed3998b714a4842ee29c977550a61979779..cb02bcfe04c6b265fa97db9237395a262e649989 100644
>> --- a/arch/m68k/kernel/Makefile
>> +++ b/arch/m68k/kernel/Makefile
>> @@ -23,3 +23,4 @@ obj-$(CONFIG_UBOOT)        += uboot.o
>>   obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
>> +obj-y    += stacktrace.o
>> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/ 
>> stacktrace.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..4c2fb6b0cf675ee5a3a21393a50603fea98a1b03
>> --- /dev/null
>> +++ b/arch/m68k/kernel/stacktrace.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Stack trace utility functions etc.
>> + *
>> + * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
>> + */
>> +
>> +#include <asm/current.h>
>> +#include <asm/ptrace.h>
>> +#include <linux/sched.h>
>> +#include <linux/sched/task_stack.h>
>> +#include <linux/stacktrace.h>
>> +
>> +static inline unsigned long current_stack_frame(void)
>> +{
>> +    unsigned long sp;
>> +
>> +    asm volatile("movl %%fp, %0" : "=r"(sp));
>> +    return sp;
>> +}
>> +
>> +static inline int validate_sp(unsigned long sp, struct task_struct 
>> *task)
>> +{
>> +    unsigned long stack_start, stack_end;
>> +
>> +    if (task == current)
>> +        stack_start = (unsigned long)task_stack_page(task);
>> +    else
>> +        stack_start = (unsigned long)task->thread.esp0;
>> +
>> +    stack_end = stack_start + THREAD_SIZE;
>> +
>> +    if (sp < stack_start || sp >= stack_end)
>> +        return 0;
>> +
>> +    return 1;
>> +}
>> +
>> +void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn 
>> consume_entry, void *cookie,
>> +                       struct task_struct *task, struct pt_regs *regs)
>> +{
>> +    unsigned long sp;
>> +
>> +    if (regs && !consume_entry(cookie, regs->pc))
>> +        return;
>> +
>> +    if (regs)
>> +        sp = (unsigned long) regs;
>> +    else if (task == current)
>> +        sp = current_stack_frame();
>> +    else
>> +        sp = task->thread.ksp;
>> +
>> +    for (;;) {
>> +        unsigned long *stack = (unsigned long *) sp;
>> +        unsigned long newsp, ip;
>> +
>> +        if (!validate_sp(sp, task))
>> +            return;
>> +
>> +        newsp = stack[0];
>> +        ip = stack[1];
>> +
>> +        if (!consume_entry(cookie, ip))
>> +            return;
>> +
>> +        sp = newsp;
>> +    }
>> +}
>>
> 

