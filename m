Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D91D79B4;
	Mon,  2 Dec 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180480; cv=none; b=XnaKdFaQVbUHlwZ2f2XMhJ5W2GnfcV9yZNu7JKLl/aBKxNAWnfQxb0PhuoJCRDxzbGoHxi344d5ocwZFT/983L3MtltpUbh5pCB9B3GignSLebkyAsxjjD7dcwxI0fbeCsaBRa+pM8NAKKfJZqNKbm2oSW5icnd/SLOO6P8iPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180480; c=relaxed/simple;
	bh=O40mKIuVkUdaPGlRuJu+ExjHuIkuF5fFK8LoYE40cs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ53GjzQxhsK9zJHMMFJ38E+33ugafFotFHDWEZmMowiZ/fq/WC0vHA3N+Zbnd6IX2RNv/x4h2Ge+ViURb6FHAeZbacc7cTlWi6MjWjM+amgWYsu2Odq/eIsrV4E6fl1SsgDoI/5uxiFKizfIWjv/q7GErMYObbtZ0H0zeXDcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FC0C4CED1;
	Mon,  2 Dec 2024 23:01:18 +0000 (UTC)
Message-ID: <34055476-e711-4e7e-9bc1-ba3e29ddbff1@linux-m68k.org>
Date: Tue, 3 Dec 2024 09:01:16 +1000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] arch: m68k: Add STACKTRACE support
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-2-0883d704525b@yoseli.org>
 <501c04d7-1a7d-4000-a948-e9effb281a05@yoseli.org>
 <a2efe6f7-4bfe-468b-9512-c60f646281b1@linux-m68k.org>
 <7fef0321-5a24-4d8d-9717-8fe02f80b8c2@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <7fef0321-5a24-4d8d-9717-8fe02f80b8c2@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JM,

On 3/12/24 00:52, Jean-Michel Hautbois wrote:
> On 02/12/2024 15:41, Greg Ungerer wrote:
>> On 27/11/24 21:26, Jean-Michel Hautbois wrote:
>>> On 21/10/2024 11:44, Jean-Michel Hautbois wrote:
>>>> In order to use tracing, implement a basic arch_stack_walk() based on
>>>> the one in PowerPC.
>>>> Tested on a M54418 coldfire.
>>>
>>> Well, I said it was tested, but it was only compile tested basically.
>>> AFAICT now, I think it is not working as when I use wakeup_rt as a tracer, I don't have the stack trace:
>>>
>>> # wakeup_rt latency trace v1.1.5 on 6.12.0-10380-gb66f06337b66-dirty
>>> # --------------------------------------------------------------------
>>> # latency: 2000 us, #18/18, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
>>> #    -----------------
>>> #    | task: irq/100-enet-fe-118 (uid:0 nice:0 policy:1 rt_prio:50)
>>> #    -----------------
>>> #
>>> #                    _------=> CPU#
>>> #                   / _-----=> irqs-off/BH-disabled
>>> #                  | / _----=> need-resched
>>> #                  || / _---=> hardirq/softirq
>>> #                  ||| / _--=> preempt-depth
>>> #                  |||| / _-=> migrate-disable
>>> #                  ||||| /     delay
>>> #  cmd     pid     |||||| time  |   caller
>>> #     \   /        ||||||  \    |    /
>>> kworker/-11        0dnh5.    0us :       11:120:R   + [000]      22: 98:R irq_work/0
>>> kworker/-11        0dnh5.    0us : <stack trace>
>>> kworker/-11        0dnh5.    0us : 0
>>> kworker/-11        0d..3.    0us : __schedule
>>> kworker/-11        0d..3.    0us :       11:120:R ==> [000]      22: 98:R irq_work/0
>>> kworker/-11        0d..3.    0us : <stack trace>
>>>   telnetd-229       0Dnh4.    0us :      229:120:R   + [000]     118: 49:R irq/100-enet-fe
>>>   telnetd-229       0Dnh4.    0us : <stack trace>
>>>   telnetd-229       0Dnh4.    0us : 0
>>>   telnetd-229       0D..3.    0us : __schedule
>>>   telnetd-229       0D..3.    0us :      229:120:R ==> [000]     118: 49:R irq/100-enet-fe
>>>   telnetd-229       0D..3.    0us : <stack trace>
>>>   telnetd-229       0dn.5.    0us :      229:120:R   + [000]     118: 49:R irq/100-enet-fe
>>>   telnetd-229       0dn.5.    0us : <stack trace>
>>>   telnetd-229       0dn.5.    0us#: 0
>>>   telnetd-229       0d..3. 2000us : __schedule
>>>   telnetd-229       0d..3. 2000us :      229:120:R ==> [000]     118: 49:R irq/100-enet-fe
>>>   telnetd-229       0d..3. 2000us : <stack trace>
>>>
>>> Geert, Greg, and maybe other highly skilled m68k people, could you please help me with this particular function :-) ?
>>>
>>> Thanks !
>>> JM
>>>
>>>>
>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>> ---
>>>>   arch/m68k/Kconfig             |  5 ++++
>>>>   arch/m68k/kernel/Makefile     |  1 +
>>>>   arch/m68k/kernel/stacktrace.c | 70 ++++++++++++++++++++++++++++++++ +++++++++++
>>>>   3 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>>>> index ab3375475721fa63418c40d4ba6ac76679ebc77d..7142f9759181a90269ae1ba9e682d331ee2ddbf6 100644
>>>> --- a/arch/m68k/Kconfig
>>>> +++ b/arch/m68k/Kconfig
>>>> @@ -40,6 +40,7 @@ config M68K
>>>>       select UACCESS_MEMCPY if !MMU
>>>>       select ZONE_DMA
>>>>       select TRACE_IRQFLAGS_SUPPORT
>>>> +    select ARCH_STACKWALK
>>>>   config CPU_BIG_ENDIAN
>>>>       def_bool y
>>>> @@ -107,6 +108,10 @@ config BOOTINFO_PROC
>>>>         Say Y to export the bootinfo used to boot the kernel in a
>>>>         "bootinfo" file in procfs.  This is useful with kexec.
>>>> +config STACKTRACE_SUPPORT
>>>> +    bool
>>>> +    default y
>>>> +
>>>>   menu "Platform setup"
>>>>   source "arch/m68k/Kconfig.cpu"
>>>> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
>>>> index f335bf3268a108a45bab079fbf0a1c8ead9beb71..4efe92af0b711b19cb1d5129f74e67a739e289b1 100644
>>>> --- a/arch/m68k/kernel/Makefile
>>>> +++ b/arch/m68k/kernel/Makefile
>>>> @@ -31,3 +31,4 @@ obj-$(CONFIG_UBOOT)        += uboot.o
>>>>   obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
>>>> +obj-y    += stacktrace.o
>>>> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/ stacktrace.c
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000..06c7459373bd25b3bb3540cfe2a909259c1db3ce
>>>> --- /dev/null
>>>> +++ b/arch/m68k/kernel/stacktrace.c
>>>> @@ -0,0 +1,70 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +/*
>>>> + * Stack trace utility functions etc.
>>>> + *
>>>> + * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
>>>> + */
>>>> +
>>>> +#include <asm/current.h>
>>>> +#include <asm/ptrace.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/sched/task_stack.h>
>>>> +#include <linux/stacktrace.h>
>>>> +
>>>> +static inline unsigned long current_stack_frame(void)
>>>> +{
>>>> +    unsigned long sp;
>>>> +
>>>> +    asm volatile("movl %%sp, %0" : "=r"(sp));
>>>> +    return sp;
>>>> +}
>>
>> If I am understanding what this is intended to do then this is probably not right.
>> This will be returning the current stack pointer, which will almost certainly not
>> be the current stack frame pointer. This will be the top of stack at the call site,
>> which will be after the pushed locals and saved registers at the very least for m68k.
>>
>> Does your kernel config have CONFIG_FRAME_POINTER enabled?
>> The default for m68k is usually disabled. Without this there won't be a
>> chain of frame pointers to follow like the code is trying to do below in
>> arch_stack_walk().
> 
> Sorry for my preceding mail, it *is* better:
> # tail -10 trace
> #                  |||| / _-=> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>    <idle>-0         0dnh5.   11us+:        0:120:R   + [000]     119: 49:R irq/104-enet-fe
>    <idle>-0         0dnh5.   42us+: <stack trace>
>    <idle>-0         0dnh5.   57us!: wake_up_process <-__handle_irq_event_percpu
>    <idle>-0         0d..3.  282us+: __schedule <-schedule_idle
>    <idle>-0         0d..3.  302us+:        0:120:R ==> [000]     119: 49:R irq/104-enet-fe
>    <idle>-0         0d..3.  325us : <stack trace>

Oh, yeah, there is more required.

The current_stack_frame() function needs to change to actually return
with the start of the frame pointer chain. You need it to look like this:


static inline unsigned long current_stack_frame(void)
{
         unsigned long sp;

         asm volatile("movl %%fp, %0" : "=r"(sp));
         return sp;
}


Note that it is returning the "%fp" register - the current frame pointer.

Regards
Greg



> JM
> 
>> Regards
>> Greg
>>
>>
>>>> +static inline int validate_sp(unsigned long sp, struct task_struct *task)
>>>> +{
>>>> +    unsigned long stack_start, stack_end;
>>>> +
>>>> +    if (task == current)
>>>> +        stack_start = (unsigned long)task_stack_page(task);
>>>> +    else
>>>> +        stack_start = (unsigned long)task->thread.esp0;
>>>> +
>>>> +    stack_end = stack_start + THREAD_SIZE;
>>>> +
>>>> +    if (sp < stack_start || sp >= stack_end)
>>>> +        return 0;
>>>> +
>>>> +    return 1;
>>>> +}
>>>> +
>>>> +void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>>>> +                       struct task_struct *task, struct pt_regs *regs)
>>>> +{
>>>> +    unsigned long sp;
>>>> +
>>>> +    if (regs && !consume_entry(cookie, regs->pc))
>>>> +        return;
>>>> +
>>>> +    if (regs)
>>>> +        sp = (unsigned long) regs;
>>>> +    else if (task == current)
>>>> +        sp = current_stack_frame();
>>>> +    else
>>>> +        sp = task->thread.ksp;
>>>> +
>>>> +    for (;;) {
>>>> +        unsigned long *stack = (unsigned long *) sp;
>>>> +        unsigned long newsp, ip;
>>>> +
>>>> +        if (!validate_sp(sp, task))
>>>> +            return;
>>>> +
>>>> +        newsp = stack[0];
>>>> +        ip = stack[1];
>>>> +
>>>> +        if (!consume_entry(cookie, ip))
>>>> +            return;
>>>> +
>>>> +        sp = newsp;
>>>> +    }
>>>> +}
>>>>
>>>
> 
> 
