Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E9208983;
	Mon,  2 Dec 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151175; cv=none; b=cLCJsOK2BZG+0U9ZAkyLss05h63FUbAFUH842xSc5bxrNCjjeTNaDqJifQ47b9tKgu+qhVwbQbJdNnwRaA23DN4LYeqNW264lh/+DeHq9VeAS5eiK+42NHp1SQ/w/TsOmZYh1YEorG2ZXLe7XtMLRxVAWMIbBWTfz/m+1QdFR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151175; c=relaxed/simple;
	bh=JNAutYvvRsU3z28k3MKoS0K4sWzEbVp3JENNeTXHgD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpJATuHMp2KAot71l+D7e+FdearbS4PD2/ENF5GqaRuYFOESxKm+U49iQjHioBr3aFBzSoHXUfAY7DwbP21y5Fw2xoZTZOlSFoQSjNqPasydW0vILip7snKcavgpHIovHTgL2io5kGysqmBaQqJmMClvv8s+vREUN3PByDVnzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=YfUqlpug; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="YfUqlpug"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DA0B1C000C;
	Mon,  2 Dec 2024 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733151171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llabfjTSfzGZra+dtmKNVF6kqf6OUjNm/Zx+/J9c3Zk=;
	b=YfUqlpugAtwT9fBiRC2CV9fHNqM7XRuNuSGb68HGkHrVPhLd5QIF95w0oDCyCu2nqd0pcK
	1GJwUhpWnp9U9/BwbmIId3kblsVRKAa4LZKualY1B0kA8J13nVdu93cjgmTiXxlVzb3ZIa
	+kgKVTuNEu6rzb5TOitdLDTuBLgGIBCx+xW7yrFIQgFOy/Egvh2d2SzJVGqtqgtbRl9hmH
	NJ3u4okEQyrMY/hWQqfRBNnCjSDHPR5pMHIvUAIhA4SadT1/EJ1Y3K6LZLnFF7ak+VBe1K
	PxP6Z+OOHh/cWW9g09kABXW3Nr0FIQGQZs38UxyMm0PyNrDbm8mlvUe65utqDw==
Message-ID: <7fef0321-5a24-4d8d-9717-8fe02f80b8c2@yoseli.org>
Date: Mon, 2 Dec 2024 15:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] arch: m68k: Add STACKTRACE support
To: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-2-0883d704525b@yoseli.org>
 <501c04d7-1a7d-4000-a948-e9effb281a05@yoseli.org>
 <a2efe6f7-4bfe-468b-9512-c60f646281b1@linux-m68k.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <a2efe6f7-4bfe-468b-9512-c60f646281b1@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Re-hi !

On 02/12/2024 15:41, Greg Ungerer wrote:
> Hi JM,
> 
> On 27/11/24 21:26, Jean-Michel Hautbois wrote:
>> Hi there,
>>
>> On 21/10/2024 11:44, Jean-Michel Hautbois wrote:
>>> In order to use tracing, implement a basic arch_stack_walk() based on
>>> the one in PowerPC.
>>> Tested on a M54418 coldfire.
>>
>> Well, I said it was tested, but it was only compile tested basically.
>> AFAICT now, I think it is not working as when I use wakeup_rt as a 
>> tracer, I don't have the stack trace:
>>
>> # wakeup_rt latency trace v1.1.5 on 6.12.0-10380-gb66f06337b66-dirty
>> # --------------------------------------------------------------------
>> # latency: 2000 us, #18/18, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
>> #    -----------------
>> #    | task: irq/100-enet-fe-118 (uid:0 nice:0 policy:1 rt_prio:50)
>> #    -----------------
>> #
>> #                    _------=> CPU#
>> #                   / _-----=> irqs-off/BH-disabled
>> #                  | / _----=> need-resched
>> #                  || / _---=> hardirq/softirq
>> #                  ||| / _--=> preempt-depth
>> #                  |||| / _-=> migrate-disable
>> #                  ||||| /     delay
>> #  cmd     pid     |||||| time  |   caller
>> #     \   /        ||||||  \    |    /
>> kworker/-11        0dnh5.    0us :       11:120:R   + [000]      22: 
>> 98:R irq_work/0
>> kworker/-11        0dnh5.    0us : <stack trace>
>> kworker/-11        0dnh5.    0us : 0
>> kworker/-11        0d..3.    0us : __schedule
>> kworker/-11        0d..3.    0us :       11:120:R ==> [000]      22: 
>> 98:R irq_work/0
>> kworker/-11        0d..3.    0us : <stack trace>
>>   telnetd-229       0Dnh4.    0us :      229:120:R   + [000]     118: 
>> 49:R irq/100-enet-fe
>>   telnetd-229       0Dnh4.    0us : <stack trace>
>>   telnetd-229       0Dnh4.    0us : 0
>>   telnetd-229       0D..3.    0us : __schedule
>>   telnetd-229       0D..3.    0us :      229:120:R ==> [000]     118: 
>> 49:R irq/100-enet-fe
>>   telnetd-229       0D..3.    0us : <stack trace>
>>   telnetd-229       0dn.5.    0us :      229:120:R   + [000]     118: 
>> 49:R irq/100-enet-fe
>>   telnetd-229       0dn.5.    0us : <stack trace>
>>   telnetd-229       0dn.5.    0us#: 0
>>   telnetd-229       0d..3. 2000us : __schedule
>>   telnetd-229       0d..3. 2000us :      229:120:R ==> [000]     118: 
>> 49:R irq/100-enet-fe
>>   telnetd-229       0d..3. 2000us : <stack trace>
>>
>> Geert, Greg, and maybe other highly skilled m68k people, could you 
>> please help me with this particular function :-) ?
>>
>> Thanks !
>> JM
>>
>>>
>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>> ---
>>>   arch/m68k/Kconfig             |  5 ++++
>>>   arch/m68k/kernel/Makefile     |  1 +
>>>   arch/m68k/kernel/stacktrace.c | 70 ++++++++++++++++++++++++++++++++ 
>>> +++++++++++
>>>   3 files changed, 76 insertions(+)
>>>
>>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>>> index 
>>> ab3375475721fa63418c40d4ba6ac76679ebc77d..7142f9759181a90269ae1ba9e682d331ee2ddbf6 100644
>>> --- a/arch/m68k/Kconfig
>>> +++ b/arch/m68k/Kconfig
>>> @@ -40,6 +40,7 @@ config M68K
>>>       select UACCESS_MEMCPY if !MMU
>>>       select ZONE_DMA
>>>       select TRACE_IRQFLAGS_SUPPORT
>>> +    select ARCH_STACKWALK
>>>   config CPU_BIG_ENDIAN
>>>       def_bool y
>>> @@ -107,6 +108,10 @@ config BOOTINFO_PROC
>>>         Say Y to export the bootinfo used to boot the kernel in a
>>>         "bootinfo" file in procfs.  This is useful with kexec.
>>> +config STACKTRACE_SUPPORT
>>> +    bool
>>> +    default y
>>> +
>>>   menu "Platform setup"
>>>   source "arch/m68k/Kconfig.cpu"
>>> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
>>> index 
>>> f335bf3268a108a45bab079fbf0a1c8ead9beb71..4efe92af0b711b19cb1d5129f74e67a739e289b1 100644
>>> --- a/arch/m68k/kernel/Makefile
>>> +++ b/arch/m68k/kernel/Makefile
>>> @@ -31,3 +31,4 @@ obj-$(CONFIG_UBOOT)        += uboot.o
>>>   obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
>>> +obj-y    += stacktrace.o
>>> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/ 
>>> stacktrace.c
>>> new file mode 100644
>>> index 
>>> 0000000000000000000000000000000000000000..06c7459373bd25b3bb3540cfe2a909259c1db3ce
>>> --- /dev/null
>>> +++ b/arch/m68k/kernel/stacktrace.c
>>> @@ -0,0 +1,70 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/*
>>> + * Stack trace utility functions etc.
>>> + *
>>> + * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
>>> + */
>>> +
>>> +#include <asm/current.h>
>>> +#include <asm/ptrace.h>
>>> +#include <linux/sched.h>
>>> +#include <linux/sched/task_stack.h>
>>> +#include <linux/stacktrace.h>
>>> +
>>> +static inline unsigned long current_stack_frame(void)
>>> +{
>>> +    unsigned long sp;
>>> +
>>> +    asm volatile("movl %%sp, %0" : "=r"(sp));
>>> +    return sp;
>>> +}
> 
> If I am understanding what this is intended to do then this is probably 
> not right.
> This will be returning the current stack pointer, which will almost 
> certainly not
> be the current stack frame pointer. This will be the top of stack at the 
> call site,
> which will be after the pushed locals and saved registers at the very 
> least for m68k.
> 
> Does your kernel config have CONFIG_FRAME_POINTER enabled?
> The default for m68k is usually disabled. Without this there won't be a
> chain of frame pointers to follow like the code is trying to do below in
> arch_stack_walk().

Sorry for my preceding mail, it *is* better:
# tail -10 trace
#                  |||| / _-=> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
   <idle>-0         0dnh5.   11us+:        0:120:R   + [000]     119: 
49:R irq/104-enet-fe
   <idle>-0         0dnh5.   42us+: <stack trace>
   <idle>-0         0dnh5.   57us!: wake_up_process 
<-__handle_irq_event_percpu
   <idle>-0         0d..3.  282us+: __schedule <-schedule_idle
   <idle>-0         0d..3.  302us+:        0:120:R ==> [000]     119: 
49:R irq/104-enet-fe
   <idle>-0         0d..3.  325us : <stack trace>

JM

> Regards
> Greg
> 
> 
>>> +static inline int validate_sp(unsigned long sp, struct task_struct 
>>> *task)
>>> +{
>>> +    unsigned long stack_start, stack_end;
>>> +
>>> +    if (task == current)
>>> +        stack_start = (unsigned long)task_stack_page(task);
>>> +    else
>>> +        stack_start = (unsigned long)task->thread.esp0;
>>> +
>>> +    stack_end = stack_start + THREAD_SIZE;
>>> +
>>> +    if (sp < stack_start || sp >= stack_end)
>>> +        return 0;
>>> +
>>> +    return 1;
>>> +}
>>> +
>>> +void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn 
>>> consume_entry, void *cookie,
>>> +                       struct task_struct *task, struct pt_regs *regs)
>>> +{
>>> +    unsigned long sp;
>>> +
>>> +    if (regs && !consume_entry(cookie, regs->pc))
>>> +        return;
>>> +
>>> +    if (regs)
>>> +        sp = (unsigned long) regs;
>>> +    else if (task == current)
>>> +        sp = current_stack_frame();
>>> +    else
>>> +        sp = task->thread.ksp;
>>> +
>>> +    for (;;) {
>>> +        unsigned long *stack = (unsigned long *) sp;
>>> +        unsigned long newsp, ip;
>>> +
>>> +        if (!validate_sp(sp, task))
>>> +            return;
>>> +
>>> +        newsp = stack[0];
>>> +        ip = stack[1];
>>> +
>>> +        if (!consume_entry(cookie, ip))
>>> +            return;
>>> +
>>> +        sp = newsp;
>>> +    }
>>> +}
>>>
>>

