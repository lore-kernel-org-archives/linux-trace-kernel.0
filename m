Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6E1F7544;
	Wed, 27 Nov 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706815; cv=none; b=tud7YF7Ta3c1cu8S56fftYn+GBA4N3aZ7WS4zLdXC0EW/q81dgAeN35U/tNCHeM4PRLqmrJyzP0KEUk6bECm1SUuaoXodqVK072ys71G6liESHaouVBX8OrjciTPJ7OQxbfOCgd9u6Nqee/Pb2FHTxL9yiNaWy/Zx10hP66nfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706815; c=relaxed/simple;
	bh=28dQTrG3He6iFEKXXDoA7pxzEaS5Xh5bp7DgOEMy9QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWKdlm3sO2x/rCrxnxIZO7nJA8XXpHh+VQuKI8HaJVc7kU2smrP7uDCI42Zkj1GjYKr9XUb9qS7KGQNA/ysJ7pvr/7kFJkpX/wTKe6uoubbmuqB0BTT7kAUtp4dt1OQAzvM8H2waFscSDUHzY9d4m8v5jZKOYAqClzAyti2XWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ZTdRLNIW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ZTdRLNIW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C266324000B;
	Wed, 27 Nov 2024 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732706804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwU4mXYYTdimQrB6vSMf2Y5tX570CcargndAnexCjxE=;
	b=ZTdRLNIWRKx+BEau5xXr5cOhELhrhLPO7QwX8nOxq5xJ0We9L4Un05XWBcumeHRc0huJ93
	jGKe9CI7ifTLyy7PHDpmDuSgAxr4wbWcWnUzYv1gDQmBqaudE7IThZuH18Sc37Cx52Zpdi
	97gzRYLVrmYiqYnpAdhf3xKeKx0Xzx3GWSOa8m/ZqOEAhvRJ89TEV+s1nn/kW3X7BYLjTG
	RaXz/eC6oOIHwv4WzZWIz9eKKNcpnxpW2b/0GrwH9inxtVewdOLTOh3EdzdygG7shwkIhc
	T4I4o7Er3cuNHbVCpc9phdjjJEvJL2aTWm+WSCjCKY9cBMm8Xh9zmaXuy77UtQ==
Message-ID: <501c04d7-1a7d-4000-a948-e9effb281a05@yoseli.org>
Date: Wed, 27 Nov 2024 12:26:43 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] arch: m68k: Add STACKTRACE support
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, Greg Ungerer <gerg@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-2-0883d704525b@yoseli.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241021-add-m68k-tracing-support-v1-2-0883d704525b@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi there,

On 21/10/2024 11:44, Jean-Michel Hautbois wrote:
> In order to use tracing, implement a basic arch_stack_walk() based on
> the one in PowerPC.
> Tested on a M54418 coldfire.

Well, I said it was tested, but it was only compile tested basically.
AFAICT now, I think it is not working as when I use wakeup_rt as a 
tracer, I don't have the stack trace:

# wakeup_rt latency trace v1.1.5 on 6.12.0-10380-gb66f06337b66-dirty
# --------------------------------------------------------------------
# latency: 2000 us, #18/18, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
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
kworker/-11        0dnh5.    0us :       11:120:R   + [000]      22: 
98:R irq_work/0
kworker/-11        0dnh5.    0us : <stack trace>
kworker/-11        0dnh5.    0us : 0
kworker/-11        0d..3.    0us : __schedule
kworker/-11        0d..3.    0us :       11:120:R ==> [000]      22: 
98:R irq_work/0
kworker/-11        0d..3.    0us : <stack trace>
  telnetd-229       0Dnh4.    0us :      229:120:R   + [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0Dnh4.    0us : <stack trace>
  telnetd-229       0Dnh4.    0us : 0
  telnetd-229       0D..3.    0us : __schedule
  telnetd-229       0D..3.    0us :      229:120:R ==> [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0D..3.    0us : <stack trace>
  telnetd-229       0dn.5.    0us :      229:120:R   + [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0dn.5.    0us : <stack trace>
  telnetd-229       0dn.5.    0us#: 0
  telnetd-229       0d..3. 2000us : __schedule
  telnetd-229       0d..3. 2000us :      229:120:R ==> [000]     118: 
49:R irq/100-enet-fe
  telnetd-229       0d..3. 2000us : <stack trace>

Geert, Greg, and maybe other highly skilled m68k people, could you 
please help me with this particular function :-) ?

Thanks !
JM

> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/Kconfig             |  5 ++++
>   arch/m68k/kernel/Makefile     |  1 +
>   arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 76 insertions(+)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index ab3375475721fa63418c40d4ba6ac76679ebc77d..7142f9759181a90269ae1ba9e682d331ee2ddbf6 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -40,6 +40,7 @@ config M68K
>   	select UACCESS_MEMCPY if !MMU
>   	select ZONE_DMA
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select ARCH_STACKWALK
>   
>   config CPU_BIG_ENDIAN
>   	def_bool y
> @@ -107,6 +108,10 @@ config BOOTINFO_PROC
>   	  Say Y to export the bootinfo used to boot the kernel in a
>   	  "bootinfo" file in procfs.  This is useful with kexec.
>   
> +config STACKTRACE_SUPPORT
> +	bool
> +	default y
> +
>   menu "Platform setup"
>   
>   source "arch/m68k/Kconfig.cpu"
> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
> index f335bf3268a108a45bab079fbf0a1c8ead9beb71..4efe92af0b711b19cb1d5129f74e67a739e289b1 100644
> --- a/arch/m68k/kernel/Makefile
> +++ b/arch/m68k/kernel/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_UBOOT)		+= uboot.o
>   
>   obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>   
> +obj-y	+= stacktrace.o
> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/stacktrace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..06c7459373bd25b3bb3540cfe2a909259c1db3ce
> --- /dev/null
> +++ b/arch/m68k/kernel/stacktrace.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Stack trace utility functions etc.
> + *
> + * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
> + */
> +
> +#include <asm/current.h>
> +#include <asm/ptrace.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/stacktrace.h>
> +
> +static inline unsigned long current_stack_frame(void)
> +{
> +	unsigned long sp;
> +
> +	asm volatile("movl %%sp, %0" : "=r"(sp));
> +	return sp;
> +}
> +
> +static inline int validate_sp(unsigned long sp, struct task_struct *task)
> +{
> +	unsigned long stack_start, stack_end;
> +
> +	if (task == current)
> +		stack_start = (unsigned long)task_stack_page(task);
> +	else
> +		stack_start = (unsigned long)task->thread.esp0;
> +
> +	stack_end = stack_start + THREAD_SIZE;
> +
> +	if (sp < stack_start || sp >= stack_end)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> +					   struct task_struct *task, struct pt_regs *regs)
> +{
> +	unsigned long sp;
> +
> +	if (regs && !consume_entry(cookie, regs->pc))
> +		return;
> +
> +	if (regs)
> +		sp = (unsigned long) regs;
> +	else if (task == current)
> +		sp = current_stack_frame();
> +	else
> +		sp = task->thread.ksp;
> +
> +	for (;;) {
> +		unsigned long *stack = (unsigned long *) sp;
> +		unsigned long newsp, ip;
> +
> +		if (!validate_sp(sp, task))
> +			return;
> +
> +		newsp = stack[0];
> +		ip = stack[1];
> +
> +		if (!consume_entry(cookie, ip))
> +			return;
> +
> +		sp = newsp;
> +	}
> +}
> 

