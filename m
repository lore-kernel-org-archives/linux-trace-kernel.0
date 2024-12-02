Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FC1DB940;
	Mon,  2 Dec 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162011; cv=none; b=qigAh9rpHpNnhDUCrmr6oDogcLCXkVFNfqhVYbNcl0aBpIq991NjdRUtVztSIoqUt3vdhVh3fdbX4Ja5dw/spPKV4O6mWYfGZllCA0nrcobUfV0HjLg/YWMSqmBwEzjLvUhOUkWTaw9b9pTFGw/1rjY92pIiwfzSUpHWc8Xu4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162011; c=relaxed/simple;
	bh=lc6WgeExQ+hWB9ZfwfnAcabToLH2FzedHtL2FERcLRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVbOxrtrDHtM+rhb85dK4ZCdFh5A/YhrQAaRgTHzQ9xnjTzSslbV362rXi+jovJqwbSjMcpt1Dkmm7LC1rBXmX2Jaclh8GHmT7f1dLSkU2uHn1dbKgR3c9g09qOvXnoyrRv2jK9Yg9E/IZyVnZuZnxDi+WtOFUf/dLMn89FO4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=VCeTD+rZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="VCeTD+rZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EC65C0009;
	Mon,  2 Dec 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733162006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOG1NlpvLRlcxi8vGnjnlAA8v4MMzXA9kbAwPiLSGD4=;
	b=VCeTD+rZ2aeUuLZ6X32xzZE9GFd+kn19pWlOzX4NBEKnWEAFGIz0Qipvrigs+lb8/QbNKD
	C7X1nogQWqF8GDZL6Is7S+zwD9C6A0XkZFIMOAjC1HOoysr6fVeYNg3NK3mmLluI7Gh6SV
	nVZSXJE3Yv9sL5B1Ty+AzaEVt+ddNy0BG1A94VMSfhWFQc8SvICjuVAIg+l7FKTdv6701J
	Zm8k5McyXj+EbWeSH95Ub9O05QLihd9RNKPXHiGP7MitK5RBRv8dBNPFPXN6mMoR0IRHR/
	IgTJO5hs55wO+DnR7LRZY3yo6yX0F2wUox7mkSyJAHeqZ1V6B1O12+a4/W/ifA==
Message-ID: <1d0e141c-1afe-4646-8e6f-584e2a0706e2@yoseli.org>
Date: Mon, 2 Dec 2024 18:53:25 +0100
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

Hi Greg,

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
> 

It gives me a few things when I use wakeup_rt but timerlat is not giving 
me any stack:

# cd /sys/kernel/debug/tracing/
# echo 500 > osnoise/stop_tracing_total_us
# echo 500 > osnoise/print_stack
# echo timerlat > current_tracer
# echo 1 > tracing_on
# tail -21 trace
# tail -21 trace
       timerlat/0-299     [000] .....   635.167643: #59035 context 
thread timer_latency    202352 ns
     kworker/u5:1-242     [000] d.h1.   635.168494: #59036 context 
irq timer_latency     51504 ns
       timerlat/0-299     [000] .....   635.168714: #59036 context 
thread timer_latency    272032 ns
             bash-230     [000] d.h..   635.169496: #59037 context 
irq timer_latency     54592 ns
       timerlat/0-299     [000] .....   635.169693: #59037 context 
thread timer_latency    250448 ns
             bash-230     [000] d.h..   635.170491: #59038 context 
irq timer_latency     48784 ns
       timerlat/0-299     [000] .....   635.170717: #59038 context 
thread timer_latency    275960 ns
             bash-230     [000] d.h..   635.171497: #59039 context 
irq timer_latency     54472 ns
       timerlat/0-299     [000] .....   635.171695: #59039 context 
thread timer_latency    252936 ns
             bash-230     [000] d.h1.   635.172495: #59040 context 
irq timer_latency     53064 ns
       timerlat/0-299     [000] .....   635.172696: #59040 context 
thread timer_latency    253144 ns
             bash-230     [000] d.h1.   635.173491: #59041 context 
irq timer_latency     49864 ns
       timerlat/0-299     [000] .....   635.173683: #59041 context 
thread timer_latency    241248 ns
             bash-230     [000] d.h1.   635.174495: #59042 context 
irq timer_latency     52648 ns
       timerlat/0-299     [000] .....   635.174691: #59042 context 
thread timer_latency    249216 ns
             bash-230     [000] d.h..   635.175536: #59043 context 
irq timer_latency     94496 ns
       timerlat/0-299     [000] .....   635.175762: #59043 context 
thread timer_latency    321592 ns
             bash-324     [000] d.h..   635.176825: #59044 context 
irq timer_latency    383560 ns
       timerlat/0-299     [000] .....   635.177044: #59044 context 
thread timer_latency    603280 ns
       timerlat/0-299     [000] ...1.   635.177091: <stack trace>
       timerlat/0-299     [000] .....   635.177141: timerlat_main: stop 
tracing hit on cpu 0

As you can see, stack_trace appears, but nothing is displayed so I 
suppose it does not walk at all...

Thanks,
JM
