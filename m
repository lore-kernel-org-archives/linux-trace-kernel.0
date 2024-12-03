Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF916FF4E;
	Tue,  3 Dec 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207162; cv=none; b=tidx1JrLnkMD4EaW3gFPW/6W65H5v+mAq+9yNx7bnn9fyQn71suNA4YNeC3vXSk3O//ndx+CQQ8FyjsIna0OVoFlTixZR7ekBfcwM3sTsHmxkFOgKnS1j1Fuvub09PVfAVGZojiVbDD0Sx1SFLTfmR2Ss9OFD9r7ZSPuF3ybHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207162; c=relaxed/simple;
	bh=U2KVR6xA4C5R+KlB8AO5eqYS6d25V7Zmakjh/dMgBeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3pgUX8RKIwoT6mGqUygkZYQWeR7juKGIGrEh413RfwKPsTw1es6YnGyFnoh3aBFzDwhSSJ++j9ANTVvd/7AEsKdyAY/DUN3ZAbhdm3Hl6khjXqFKWu/Gc01Sua0agBf70Qwh6wRmvRgbT934uLURw54TsNwjcWJ1OrPC561v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=PJNGtvPB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="PJNGtvPB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C33C8FF804;
	Tue,  3 Dec 2024 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733207156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHMXGWCbJaM9d7MCisbx79aN5ojBcfA9iJMYz0MFyR4=;
	b=PJNGtvPBQs1rmicWd/1+nH6UTVqjuLZmkDwtpWg8I7TqGSifSbmXjNzPrv124CJTcdNuu9
	EWtvniRX/qJcZl5Nr78e93mY517CQqRcRKARzszD52vWcwDf0GS2pzxUrs3yYf6rFhbd2L
	3RzXYxP0bpqWRQqwwz8KWD49xG1fYoXbZHa1ewX6+VprzdXW33zaJUkDkPGKUe3mZSzpvI
	juxc9S5K6VtTWACsSLxJx518hDEWmPxfv4l+Pz+aUqHlvi7dL2icJSvjZwBr9a7ua8E45h
	fuLsOh7cQGMXSihZCxKO0/U+Gw18M2O5oBpnOAyBEs5LtVkjAuBPFZEa0o8C2w==
Message-ID: <70ee3b94-1589-4d41-b68f-1ef16b4f13c4@yoseli.org>
Date: Tue, 3 Dec 2024 07:25:55 +0100
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
 <7fef0321-5a24-4d8d-9717-8fe02f80b8c2@yoseli.org>
 <34055476-e711-4e7e-9bc1-ba3e29ddbff1@linux-m68k.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <34055476-e711-4e7e-9bc1-ba3e29ddbff1@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 03/12/2024 00:01, Greg Ungerer wrote:
> Hi JM,
> 
> On 3/12/24 00:52, Jean-Michel Hautbois wrote:
>> On 02/12/2024 15:41, Greg Ungerer wrote:
>>> On 27/11/24 21:26, Jean-Michel Hautbois wrote:
>>>> On 21/10/2024 11:44, Jean-Michel Hautbois wrote:
>>>>> In order to use tracing, implement a basic arch_stack_walk() based on
>>>>> the one in PowerPC.
>>>>> Tested on a M54418 coldfire.
>>>>
>>>> Well, I said it was tested, but it was only compile tested basically.
>>>> AFAICT now, I think it is not working as when I use wakeup_rt as a 
>>>> tracer, I don't have the stack trace:
>>>>
>>>> # wakeup_rt latency trace v1.1.5 on 6.12.0-10380-gb66f06337b66-dirty
>>>> # --------------------------------------------------------------------
>>>> # latency: 2000 us, #18/18, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
>>>> #    -----------------
>>>> #    | task: irq/100-enet-fe-118 (uid:0 nice:0 policy:1 rt_prio:50)
>>>> #    -----------------
>>>> #
>>>> #                    _------=> CPU#
>>>> #                   / _-----=> irqs-off/BH-disabled
>>>> #                  | / _----=> need-resched
>>>> #                  || / _---=> hardirq/softirq
>>>> #                  ||| / _--=> preempt-depth
>>>> #                  |||| / _-=> migrate-disable
>>>> #                  ||||| /     delay
>>>> #  cmd     pid     |||||| time  |   caller
>>>> #     \   /        ||||||  \    |    /
>>>> kworker/-11        0dnh5.    0us :       11:120:R   + [000]      22: 
>>>> 98:R irq_work/0
>>>> kworker/-11        0dnh5.    0us : <stack trace>
>>>> kworker/-11        0dnh5.    0us : 0
>>>> kworker/-11        0d..3.    0us : __schedule
>>>> kworker/-11        0d..3.    0us :       11:120:R ==> [000]      22: 
>>>> 98:R irq_work/0
>>>> kworker/-11        0d..3.    0us : <stack trace>
>>>>   telnetd-229       0Dnh4.    0us :      229:120:R   + [000]     
>>>> 118: 49:R irq/100-enet-fe
>>>>   telnetd-229       0Dnh4.    0us : <stack trace>
>>>>   telnetd-229       0Dnh4.    0us : 0
>>>>   telnetd-229       0D..3.    0us : __schedule
>>>>   telnetd-229       0D..3.    0us :      229:120:R ==> [000]     
>>>> 118: 49:R irq/100-enet-fe
>>>>   telnetd-229       0D..3.    0us : <stack trace>
>>>>   telnetd-229       0dn.5.    0us :      229:120:R   + [000]     
>>>> 118: 49:R irq/100-enet-fe
>>>>   telnetd-229       0dn.5.    0us : <stack trace>
>>>>   telnetd-229       0dn.5.    0us#: 0
>>>>   telnetd-229       0d..3. 2000us : __schedule
>>>>   telnetd-229       0d..3. 2000us :      229:120:R ==> [000]     
>>>> 118: 49:R irq/100-enet-fe
>>>>   telnetd-229       0d..3. 2000us : <stack trace>
>>>>
>>>> Geert, Greg, and maybe other highly skilled m68k people, could you 
>>>> please help me with this particular function :-) ?
>>>>
>>>> Thanks !
>>>> JM
>>>>
>>>>>
>>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>>> ---
>>>>>   arch/m68k/Kconfig             |  5 ++++
>>>>>   arch/m68k/kernel/Makefile     |  1 +
>>>>>   arch/m68k/kernel/stacktrace.c | 70 ++++++++++++++++++++++++++++++ 
>>>>> ++ +++++++++++
>>>>>   3 files changed, 76 insertions(+)
>>>>>
>>>>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>>>>> index 
>>>>> ab3375475721fa63418c40d4ba6ac76679ebc77d..7142f9759181a90269ae1ba9e682d331ee2ddbf6 100644
>>>>> --- a/arch/m68k/Kconfig
>>>>> +++ b/arch/m68k/Kconfig
>>>>> @@ -40,6 +40,7 @@ config M68K
>>>>>       select UACCESS_MEMCPY if !MMU
>>>>>       select ZONE_DMA
>>>>>       select TRACE_IRQFLAGS_SUPPORT
>>>>> +    select ARCH_STACKWALK
>>>>>   config CPU_BIG_ENDIAN
>>>>>       def_bool y
>>>>> @@ -107,6 +108,10 @@ config BOOTINFO_PROC
>>>>>         Say Y to export the bootinfo used to boot the kernel in a
>>>>>         "bootinfo" file in procfs.  This is useful with kexec.
>>>>> +config STACKTRACE_SUPPORT
>>>>> +    bool
>>>>> +    default y
>>>>> +
>>>>>   menu "Platform setup"
>>>>>   source "arch/m68k/Kconfig.cpu"
>>>>> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
>>>>> index 
>>>>> f335bf3268a108a45bab079fbf0a1c8ead9beb71..4efe92af0b711b19cb1d5129f74e67a739e289b1 100644
>>>>> --- a/arch/m68k/kernel/Makefile
>>>>> +++ b/arch/m68k/kernel/Makefile
>>>>> @@ -31,3 +31,4 @@ obj-$(CONFIG_UBOOT)        += uboot.o
>>>>>   obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
>>>>> +obj-y    += stacktrace.o
>>>>> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/ 
>>>>> stacktrace.c
>>>>> new file mode 100644
>>>>> index 
>>>>> 0000000000000000000000000000000000000000..06c7459373bd25b3bb3540cfe2a909259c1db3ce
>>>>> --- /dev/null
>>>>> +++ b/arch/m68k/kernel/stacktrace.c
>>>>> @@ -0,0 +1,70 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +/*
>>>>> + * Stack trace utility functions etc.
>>>>> + *
>>>>> + * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
>>>>> + */
>>>>> +
>>>>> +#include <asm/current.h>
>>>>> +#include <asm/ptrace.h>
>>>>> +#include <linux/sched.h>
>>>>> +#include <linux/sched/task_stack.h>
>>>>> +#include <linux/stacktrace.h>
>>>>> +
>>>>> +static inline unsigned long current_stack_frame(void)
>>>>> +{
>>>>> +    unsigned long sp;
>>>>> +
>>>>> +    asm volatile("movl %%sp, %0" : "=r"(sp));
>>>>> +    return sp;
>>>>> +}
>>>
>>> If I am understanding what this is intended to do then this is 
>>> probably not right.
>>> This will be returning the current stack pointer, which will almost 
>>> certainly not
>>> be the current stack frame pointer. This will be the top of stack at 
>>> the call site,
>>> which will be after the pushed locals and saved registers at the very 
>>> least for m68k.
>>>
>>> Does your kernel config have CONFIG_FRAME_POINTER enabled?
>>> The default for m68k is usually disabled. Without this there won't be a
>>> chain of frame pointers to follow like the code is trying to do below in
>>> arch_stack_walk().
>>
>> Sorry for my preceding mail, it *is* better:
>> # tail -10 trace
>> #                  |||| / _-=> migrate-disable
>> #                  ||||| /     delay
>> #  cmd     pid     |||||| time  |   caller
>> #     \   /        ||||||  \    |    /
>>    <idle>-0         0dnh5.   11us+:        0:120:R   + [000]     119: 
>> 49:R irq/104-enet-fe
>>    <idle>-0         0dnh5.   42us+: <stack trace>
>>    <idle>-0         0dnh5.   57us!: wake_up_process <- 
>> __handle_irq_event_percpu
>>    <idle>-0         0d..3.  282us+: __schedule <-schedule_idle
>>    <idle>-0         0d..3.  302us+:        0:120:R ==> [000]     119: 
>> 49:R irq/104-enet-fe
>>    <idle>-0         0d..3.  325us : <stack trace>
> 
> Oh, yeah, there is more required.
> 
> The current_stack_frame() function needs to change to actually return
> with the start of the frame pointer chain. You need it to look like this:
> 
> 
> static inline unsigned long current_stack_frame(void)
> {
>          unsigned long sp;
> 
>          asm volatile("movl %%fp, %0" : "=r"(sp));
>          return sp;
> }
> 
> 
> Note that it is returning the "%fp" register - the current frame pointer.

Oh, thank you for this !
It is now really helpful !

# cd /sys/kernel/debug/tracing/
# echo wakeup_rt > current_tracer
# echo 1 > tracing_on
#  echo 0 > tracing_max_latency
# chrt -f 5 sleep 1
# echo 0 > tracing_on
# cat trace
# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 6.13.0-rc1-00093-g2b74d5f38b38-dirty
# --------------------------------------------------------------------
# latency: 405 us, #6/6, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: irq/100-enet-fe-118 (uid:0 nice:0 policy:1 rt_prio:50)
#    -----------------
#
#                    _------=> CPU#
#                   / _-----=> irqs-off/BH-disabled
#                  | / _----=> need-resched
#                  || / _---=> hardirq/softirq
#                  ||| / _--=> preempt-depth
#                  |||| / _-=> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
  telnetd-229       0Dnh4.   13us+:      229:120:R   + [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0Dnh4.   53us+: <stack trace>
  => __trace_stack
  => probe_wakeup
  => try_to_wake_up
  => wake_up_process
  => __handle_irq_event_percpu
  => handle_irq_event
  => handle_level_irq
  => generic_handle_irq
  => do_IRQ
  => inthandler
  => ip_finish_output2
  => __ip_finish_output
  => ip_output
  => __ip_queue_xmit
  => ip_queue_xmit
  => __tcp_transmit_skb
  => tcp_write_xmit
  => __tcp_push_pending_frames
  => tcp_push
  => tcp_sendmsg_locked
  => tcp_sendmsg
  => inet_sendmsg
  => sock_write_iter
  => vfs_write
  => ksys_write
  => sys_write
  => system_call
  telnetd-229       0Dnh4.   68us!: wake_up_process 
<-__handle_irq_event_percpu
  telnetd-229       0D..3.  348us+: __schedule <-preempt_schedule_irq
  telnetd-229       0D..3.  368us+:      229:120:R ==> [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0D..3.  395us : <stack trace>
  => __trace_stack
  => probe_wakeup_sched_switch
  => __schedule
  => preempt_schedule_irq
  => Lkernel_return
  => ip_finish_output2
  => __ip_finish_output
  => ip_output
  => __ip_queue_xmit
  => ip_queue_xmit
  => __tcp_transmit_skb
  => tcp_write_xmit
  => __tcp_push_pending_frames
  => tcp_push
  => tcp_sendmsg_locked
  => tcp_sendmsg
  => inet_sendmsg
  => sock_write_iter
  => vfs_write
  => ksys_write
  => sys_write
  => system_call

I will use it and see if I can have more informations but, this makes 
ftrace working nicely now, and I will submit a real patch now !

Thanks,
JM
