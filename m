Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C21FC115;
	Tue,  3 Dec 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250086; cv=none; b=fdJOoLahMNQp8xArrme678uzr6dHc+wN568acLDraHxSjYLqgm0tDPJY63c3Ok/9mRiaPKXkKoz/2B7O8C3Xa2tYjZPeHjfMnr4EU0u+0fqFjCXxBdEZL+QjX8JgEmqbTGOgUaH7gr/jODjPFCi6X2wzb0UlZd7L32R16XEItr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250086; c=relaxed/simple;
	bh=zS4qtpdn7aiktftVenb232RqgB+OjbB2dPrk2l7SAws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shDTynEoBd+VGwUVWKl81dlKN+yahUXdqy86SaImnougZC4dZe21H7CReKOYp6UHc5vptJ5m7gkRoFtxIiEbv/9WdsrOmqppghBEHp4KVrd1pFRsbdbCZrerca+U/vhHqc/PBtxbuM1EipU4mnDcFS8Ie+QX3dQ53HOfzMs2cgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0ci3AAg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0ci3AAg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4502996a12.3;
        Tue, 03 Dec 2024 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733250084; x=1733854884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOOtRiVxPLw8heRpNXCI9X3oBVHzt9oZL/WipJD0qEs=;
        b=l0ci3AAgS0ULCktqY/2x5mTjoJWsDR7f8+2A0ObOHlJjyPwkDFopulFUwuWwDT3qfM
         Fv3x9QbKZpZrgWB0xfemam7QrdbS0tX3k7RbydHsKu9yE5QagqdqVaCK1M/wPwWGR+Vc
         /PPtQwauZNqeYePl6FBgDWroFRw7ZYjf0vgrk8YLZNuQpLmzF/7H+rcgCs186cZ722HO
         RS3qzgCW72qlvRCxwOKZ8538z5G7Q+Cl91yMFGCAoNcYP+Co1nRbPvy3mOJJo0jgceln
         9VC3aUqhL9cOxgzV3VyjDuon8+LAKRGrcSbpxN5rRtcg2yhd6BI4Of16kCH488sakImV
         z6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250084; x=1733854884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOOtRiVxPLw8heRpNXCI9X3oBVHzt9oZL/WipJD0qEs=;
        b=RRr2mDHTCoA/8uDcCfNCtTqbcKKPqHvU6BX8IMnvvoBDuwBJbYVyDyT6qRMONEUXqx
         Hw2TqoZ9B5DUFkwlyT7OQH+uFa0q85XvgJsoMM28B+9YHx/HFn2+j1MT/CKFF/BiAF/V
         RHfKkjZ1gPgdHU0WIKv1N53Q5OOgBSjbUXeU8T6ezQ0mRuvmjFNBefx/6xPQjb66wPJE
         zNofOk7KW3E67/qNz5Kj12zO2pm2Vk7L3R4DWDxa/QeupCO1lsdG+8xNM7OiBfqaHWjO
         wKgUSFrflKOzawq4ZFf/0cszJZPqNJgqbdbThiAKTvgiutFgvtHFGelFrswmJYjrxAme
         UU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSFgf1Rk6l4Zdsomvj8NgiNNHvkf+NYAG3xRF0D8D2NhMcT88GnokK7OVzfWyrQ+aUDdJxXvi5gaG6XH9e0p2MNc9J@vger.kernel.org, AJvYcCWtKSbrlnz67ZQFJtNKv2xLtQLHzKJoruUAa1/S1F8Hff3zqUqPHcucYy4IPViXJ9rgeKsWNhy4aMc8MtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLofncvzY/BUkvOd585ir8tcNpA6P6Fmn98so1pxBw3N8nrwR5
	JRVNFPE9H4eFUKPaVLO7L2YnAFPCOSS2seWPxrjMayRfWQserb5giSZrxw==
X-Gm-Gg: ASbGnctORxfozW/ugED3ptb3AnKdvuQA6sq8whDIUxULvz5oPVjS6imscA6sw1L7Rup
	zrKrQVF+rmu1xet61ULO+qvL8hzwdoRhKzCykmh0WRZubJzuMBeMBOucgVKbjdfRdK/gXHima6/
	bnuZC0uwqC0CyY6wZ/WtSYjBc0ddvQOr7IJzKaXBv4YKh3Fp03KLZb+WcHz2u16QegSqPeHHzzH
	TvbfJAQyYATQRhOHIQnIe4dLZZ3CEhs8vO+qYVSHtiSdQK9JVYIUW3wwZO8XOzxv7Bvom7R31ld
	2TA4TiM2Doc1N0ZT3m+qwV79Ibq+GWJT2u8riGfIprhQONXWRPvGf41a/h3g6J+q
X-Google-Smtp-Source: AGHT+IH1xfWsizP1u/LF/LRYJ+Hz2nxFK2DspdsxBhKhc+S50pRHcv38dpzLh2Sr00Q1fRHoaXmpIg==
X-Received: by 2002:a05:6a20:918d:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1e1653a7c14mr5073785637.1.1733250084216;
        Tue, 03 Dec 2024 10:21:24 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:1063:266d:3cf0:ce5b? ([2001:df0:0:200c:1063:266d:3cf0:ce5b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c388f0bsm10006665a12.54.2024.12.03.10.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 10:21:23 -0800 (PST)
Message-ID: <eb313fe1-f586-4613-acb6-63b12859da71@gmail.com>
Date: Wed, 4 Dec 2024 07:21:46 +1300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arch: m68k: Add STACKTRACE support
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
 <20241203-add-m68k-tracing-support-v2-2-77302097a9f4@yoseli.org>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <20241203-add-m68k-tracing-support-v2-2-77302097a9f4@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Jean-Michel,

good work on adding

On 4/12/24 06:21, Jean-Michel Hautbois wrote:
> In order to use tracing, implement a basic arch_stack_walk() based on
> the one in PowerPC.
> Tested on a M54418 coldfire.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/Kconfig             |  6 ++++
>   arch/m68k/kernel/Makefile     |  1 +
>   arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 77 insertions(+)
>
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 793ab1e2762609725bbf793f6dffecfa3ecfff0f..6ba3238ba2c68acaf5974396739e629b09eee3ca 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -40,6 +40,8 @@ config M68K
>   	select UACCESS_MEMCPY if !MMU
>   	select ZONE_DMA
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select ARCH_STACKWALK
> +	select ARCH_WANT_FRAME_POINTERS

How much does that add to kernel size? It's only needed for debugging so 
some folks may prefer to save a little on code size (not to mention the 
extra frame pointer save on each call) ...

Cheers,

     Michael


>   
>   config CPU_BIG_ENDIAN
>   	def_bool y
> @@ -106,6 +108,10 @@ config BOOTINFO_PROC
>   	  Say Y to export the bootinfo used to boot the kernel in a
>   	  "bootinfo" file in procfs.  This is useful with kexec.
>   
> +config STACKTRACE_SUPPORT
> +	bool
> +	default y
> +
Any reason why you can't place the two 'select' statements in this 
conditional?
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
