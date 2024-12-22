Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230618B476;
	Sun, 22 Dec 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734873270; cv=none; b=bJPHpl2+a/+XXmtCOTRa4Lm9mDHAzoItfgIgCxE4BxoH38v6Am0+rwDSI4GwQOQanEOc3e9RZu4MXrP41gtX3R3SMLwx/7U7aq9e4SesxXIkIOByXiw7yoV8pdtHnqRRftqvWrDC6mIuC26wUGWRfcmq2EPseNqc6bxRaIAQhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734873270; c=relaxed/simple;
	bh=ZJ+fPKv7i/IwKxFNUV21pFxg+Z9WuQ3ZFKR2GbbVfmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAbwpE643OoNuXBAFyKQHtQOkia5QQEKxUNBhzCMvOamKjyrWYiajOdsJzGnHtvuyJhvbnKlS8Uqv9QWozRTV2jVD4+36ekR5uXx1h5W6Jd7t3ao87TijViG6R42PyoZJ6ucbdHWhomO2FTOT5SJwTFM/sgLHiZatqO0/1T5z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215ADC4CECD;
	Sun, 22 Dec 2024 13:14:27 +0000 (UTC)
Message-ID: <599c48cd-f49b-4a70-9acb-4b90e667e490@linux-m68k.org>
Date: Sun, 22 Dec 2024 23:14:25 +1000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arch: m68k: Add STACKTRACE support
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
 <20241204-add-m68k-tracing-support-v4-2-e24fe5ef3b6b@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20241204-add-m68k-tracing-support-v4-2-e24fe5ef3b6b@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi JM,

On 4/12/24 17:14, Jean-Michel Hautbois wrote:
> In order to use tracing, implement a basic arch_stack_walk() based on
> the one in PowerPC.
> Tested on a M54418 coldfire.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/Kconfig             |  5 ++++
>   arch/m68k/kernel/Makefile     |  1 +
>   arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 76 insertions(+)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 793ab1e2762609725bbf793f6dffecfa3ecfff0f..3ad8596aab71190807f8c11dd5876aa1198760f3 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -106,6 +106,11 @@ config BOOTINFO_PROC
>   	  Say Y to export the bootinfo used to boot the kernel in a
>   	  "bootinfo" file in procfs.  This is useful with kexec.
>   
> +config STACKTRACE_SUPPORT
> +	def_bool MMU_COLDFIRE

Modulo testing is there any reason this is enabled only for MMU ColdFire targets?
There doesn't look to be anything that is ColdFire specific in these changes,
looks like it should work on any m68k machine.

Regards
Greg



> +	select ARCH_STACKWALK
> +	select ARCH_WANT_FRAME_POINTERS
> +
>   menu "Platform setup"
>   
>   source "arch/m68k/Kconfig.cpu"
> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
> index 6c732ed3998b714a4842ee29c977550a61979779..cb02bcfe04c6b265fa97db9237395a262e649989 100644
> --- a/arch/m68k/kernel/Makefile
> +++ b/arch/m68k/kernel/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_UBOOT)		+= uboot.o
>   
>   obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>   
> +obj-y	+= stacktrace.o
> diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/stacktrace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4c2fb6b0cf675ee5a3a21393a50603fea98a1b03
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
> +	asm volatile("movl %%fp, %0" : "=r"(sp));
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

