Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF694345CBF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135681; cv=none; b=Wi+gfZNoV5pe5+VXVCU4Va3W4w8K5b1y6uQqe4lRTUNxxIIA5FO4ID3gywSn8/Svw2BIvBvY10dK0VzU1eAdgsSG3uqaqJGfdjDvdzPw1Vh/zcck7eqoVfYcRZUrak+NTYA5VLlLT1PbGnjCvl0IgDZIIf28tZI/ERD9DgK3XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135681; c=relaxed/simple;
	bh=iYz4WgbG+JJ8a42uSEuI6Mq+PJXh0vYb8kFS4ud8nsw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHWe3RSnAPDGNrsOBW9Am0Hhm8r7u7oOTcfvmiNMghElLce+N/715rWa0RZozUdAc9X2DfbXW2saYg04MSVgijWBOzd+CqyXI+it0K1+qvdQXpUzPXFLvJigdP1xNkIHYxNl3od0lIl48gFu0vKfgUc+r5q7c113hH3Rs5KpVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuiaWDig; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuiaWDig"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7f811da1eedso32376117b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782135678; x=1782740478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP3NGepcMuhROLFUFK7LlQ99xK8MbURk7N7GJYY4SJk=;
        b=QuiaWDigCHwvhiFKS5Voie8PVfTaWbCEBgkNLIECw1N1HkJAtX71+BV5uGMNg3wDHY
         ICRnqNZ2mwzG52xzD81FVuYnDkY3ru9NOsQRi3v8hWX4jOu34bL2IG94AKHtGGqsI6LW
         jv1BYju8zlV9zIGQnMg7cLKiOPMSnLdxv7DhaslQgztFRyL6b+sshHRwu3qiS0MYo89y
         L0+/XJBoa/SG5OwVUKFvXc8hZJRPr9JZ6QjSYsAzf1ykmkyUekty9ujKPGtW9m7P91/c
         b7NIlgMozQ4UCMYEFPxWVCV1oNEiFycQCLXk1AJZafDMsEzyhJOl3nBcEuE0dlo8zGJS
         3KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135678; x=1782740478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP3NGepcMuhROLFUFK7LlQ99xK8MbURk7N7GJYY4SJk=;
        b=Ojm/HeuOGUX7801WgX1r7l01G1a8uVHqeDEOXqutIfArrecXbPmhWzwb/59sRJJIVO
         sTJEtbZIgKFCx8qND64SlIrfucZHOlMtpXHZSkDwo+TaTtzA6Szd8xmNxBW+6pO0TG8d
         SUHBINc1/czTLa4nVmGGAN4LGSJQ0Yo0pjjPgwuOLdCFPcxArLLn7xtidvvp24nC+o94
         F7CGT9COFYw9zCFhoQ4EC7GaJRm+ul5o9tmS4T6XgfjX7Xjy3MOUvCaQ53DEUi5Zwlbo
         6F50NrHrWGhToBNweuRwTkcN6XMu9yE5koQWLU6t/al5hznjWB/m0mzfVSseIFOAoLcg
         LN5w==
X-Forwarded-Encrypted: i=1; AHgh+RpOFZnm7CwP9GllV/LUKIC6/urw83JYuy518Pmw+/ofiOzDKlhsEGNMHXLRikueg6G7aFXMVtYxSIZeIH2e7dc0xKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUKTlgzDPsiU0mkh3bot+aqi3n2dzds01gjM3/LWPMDF0Q+HQ
	kajmIDfCG9JzbUoqRHdPaX0olpN6BGP9bNDFiITO+6n/5OlQtg0fyx8b
X-Gm-Gg: AfdE7cl4rUEtColka0eT0BmT/Om+w0U64lwFpSdLsKN7Va8kS3JRB/+4UpHnGVUhpwt
	fbStJGB8QcVBHm84FfDU3Bd/gteO0f3rwtN5eabwvCy2kmumDF/RBx0OD4shSg+jvc4V+8INaOg
	Hmjvq/TuullyE/KTSVZ3WhBJZI6gUuB9OZC1tb2+KFkPFCg/t0vypzvZwqcdHP3xQDsGD0P1vxo
	69+RbpgKkU0Gv4ixyZ9yowd4af0a1E6pZrxmDRO4lo+m5guBnYFl6bIFfaqFCz8xCkFhInILokN
	Z6Y6s7UQsTBNcPovxBxUx63nPhfobdA4JjJUWYFJM205m48VO5r1obIr96sA9Q9ngAPGMYIqaBt
	EcWjTfdC/9MgTUbBLBAdERfwnzniXciPGRvh0hBLzVXJyGDwkZlsNbVkL5ViehQLthTTa/B8kFH
	CrAMj/2NM=
X-Received: by 2002:a05:690c:6284:b0:7f8:7e31:28af with SMTP id 00721157ae682-801340bcfcfmr132551367b3.49.1782135677501;
        Mon, 22 Jun 2026 06:41:17 -0700 (PDT)
Received: from localhost ([38.101.158.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf6703bsm31379457b3.16.2026.06.22.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:41:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 09:41:16 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
Message-ID: <ajk7fN5v31kCfGVp@yury>
References: <20260622130739.375198646@kernel.org>
 <20260622131029.655382134@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622131029.655382134@kernel.org>

On Mon, Jun 22, 2026 at 09:07:40AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to remove the include to trace_printk.h from kernel.h the tracing
> control prototypes need to be separated into their own header file as they
> are used in other common header files like rcu.h. There's no point in
> removing trace_printk.h from kernel.h if it just gets added back to other
> common headers.
> 
> Prototypes are very cheap for the compiler and should not be an issue.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Suggested-by: Yury Norov <yury.norov@gmail.com>

> ---
> Changes since v1: https://patch.msgid.link/20260621093811.007634476@kernel.org
> 
> - Instead of moving back into kernel.h, create a new trace_controls.h
>   header.
> 
>  arch/powerpc/xmon/xmon.c         |  1 +
>  arch/s390/kernel/ipl.c           |  1 +
>  arch/s390/kernel/machine_kexec.c |  1 +
>  drivers/gpu/drm/i915/i915_gem.h  |  1 +
>  drivers/tty/sysrq.c              |  1 +
>  include/linux/trace_controls.h   | 54 ++++++++++++++++++++++++++++++++
>  include/linux/trace_printk.h     | 51 ------------------------------
>  kernel/debug/debug_core.c        |  1 +
>  kernel/panic.c                   |  1 +
>  kernel/rcu/rcu.h                 |  2 ++
>  kernel/rcu/rcutorture.c          |  1 +
>  kernel/trace/trace.h             |  1 +
>  kernel/trace/trace_benchmark.c   |  1 +
>  lib/sys_info.c                   |  1 +
>  14 files changed, 67 insertions(+), 51 deletions(-)
>  create mode 100644 include/linux/trace_controls.h
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index cb3a3244ae6f..2135f319e0dd 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -27,6 +27,7 @@
>  #include <linux/highmem.h>
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
> +#include <linux/trace_controls.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/smp.h>
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 3c346b02ceb9..baac66cc4de4 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -22,6 +22,7 @@
>  #include <linux/debug_locks.h>
>  #include <linux/vmalloc.h>
>  #include <linux/secure_boot.h>
> +#include <linux/trace_controls.h>
>  #include <asm/asm-extable.h>
>  #include <asm/machine.h>
>  #include <asm/diag.h>
> diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
> index baeb3dcfc1c8..33f9a89eb3ad 100644
> --- a/arch/s390/kernel/machine_kexec.c
> +++ b/arch/s390/kernel/machine_kexec.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/reboot.h>
>  #include <linux/ftrace.h>
> +#include <linux/trace_controls.h>
>  #include <linux/debug_locks.h>
>  #include <linux/cpufeature.h>
>  #include <asm/guarded_storage.h>
> diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
> index 20b3cb29cfff..1da8fb61c09e 100644
> --- a/drivers/gpu/drm/i915/i915_gem.h
> +++ b/drivers/gpu/drm/i915/i915_gem.h
> @@ -116,6 +116,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
>  #endif
>  
>  #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
> +#include <linux/trace_controls.h>
>  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
>  #define GEM_TRACE_ERR(...) do {						\
>  	pr_err(__VA_ARGS__);						\
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699a..d3f72dc430b8 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -324,6 +324,7 @@ static const struct sysrq_key_op sysrq_showstate_blocked_op = {
>  };
>  
>  #ifdef CONFIG_TRACING
> +#include <linux/trace_controls.h>
>  #include <linux/ftrace.h>
>  
>  static void sysrq_ftrace_dump(u8 key)
> diff --git a/include/linux/trace_controls.h b/include/linux/trace_controls.h
> new file mode 100644
> index 000000000000..995b97e963b4
> --- /dev/null
> +++ b/include/linux/trace_controls.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_TRACE_CONTROLS_H
> +#define _LINUX_TRACE_CONTROLS_H
> +
> +
> +/*
> + * General tracing related utility functions - trace_printk(),
> + * tracing_on/tracing_off and tracing_start()/tracing_stop
> + *
> + * Use tracing_on/tracing_off when you want to quickly turn on or off
> + * tracing. It simply enables or disables the recording of the trace events.
> + * This also corresponds to the user space /sys/kernel/tracing/tracing_on
> + * file, which gives a means for the kernel and userspace to interact.
> + * Place a tracing_off() in the kernel where you want tracing to end.
> + * From user space, examine the trace, and then echo 1 > tracing_on
> + * to continue tracing.
> + *
> + * tracing_stop/tracing_start has slightly more overhead. It is used
> + * by things like suspend to ram where disabling the recording of the
> + * trace is not enough, but tracing must actually stop because things
> + * like calling smp_processor_id() may crash the system.
> + *
> + * Most likely, you want to use tracing_on/tracing_off.
> + */
> +enum ftrace_dump_mode {
> +	DUMP_NONE,
> +	DUMP_ALL,
> +	DUMP_ORIG,
> +	DUMP_PARAM,
> +};
> +
> +#ifdef CONFIG_TRACING
> +void tracing_on(void);
> +void tracing_off(void);
> +int tracing_is_on(void);
> +void tracing_snapshot(void);
> +void tracing_snapshot_alloc(void);
> +void tracing_start(void);
> +void tracing_stop(void);
> +void trace_dump_stack(int skip);

The function description says:

  record a stack back trace in the trace buffer

So, to me it sounds like it should go to the trace_printk.h.

> +void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);

Same here, based on the function name, it relates to ftrace.h, not the
tracing control itself.

For example, lib/sys_info.c only calls ftrace_dump, and already
includes ftrace.h. If you place ftrace_dump() as suggested, you can
include only ftrace.h in there, and don't include trace_printk.h and
trace_control.h

Thanks,
Yury

> +#else
> +static inline void tracing_start(void) { }
> +static inline void tracing_stop(void) { }
> +static inline void tracing_on(void) { }
> +static inline void tracing_off(void) { }
> +static inline int tracing_is_on(void) { return 0; }
> +static inline void tracing_snapshot(void) { }
> +static inline void tracing_snapshot_alloc(void) { }
> +static inline void trace_dump_stack(int skip) { }
> +static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
> +#endif
> +
> +#endif /* _LINUX_TRACE_CONTROLS_H */
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index 3d54f440dccf..a488ea9e9f85 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -7,43 +7,7 @@
>  #include <linux/stddef.h>
>  #include <linux/stringify.h>
>  
> -/*
> - * General tracing related utility functions - trace_printk(),
> - * tracing_on/tracing_off and tracing_start()/tracing_stop
> - *
> - * Use tracing_on/tracing_off when you want to quickly turn on or off
> - * tracing. It simply enables or disables the recording of the trace events.
> - * This also corresponds to the user space /sys/kernel/tracing/tracing_on
> - * file, which gives a means for the kernel and userspace to interact.
> - * Place a tracing_off() in the kernel where you want tracing to end.
> - * From user space, examine the trace, and then echo 1 > tracing_on
> - * to continue tracing.
> - *
> - * tracing_stop/tracing_start has slightly more overhead. It is used
> - * by things like suspend to ram where disabling the recording of the
> - * trace is not enough, but tracing must actually stop because things
> - * like calling smp_processor_id() may crash the system.
> - *
> - * Most likely, you want to use tracing_on/tracing_off.
> - */
> -
> -enum ftrace_dump_mode {
> -	DUMP_NONE,
> -	DUMP_ALL,
> -	DUMP_ORIG,
> -	DUMP_PARAM,
> -};
> -
>  #ifdef CONFIG_TRACING
> -void tracing_on(void);
> -void tracing_off(void);
> -int tracing_is_on(void);
> -void tracing_snapshot(void);
> -void tracing_snapshot_alloc(void);
> -
> -extern void tracing_start(void);
> -extern void tracing_stop(void);
> -
>  static inline __printf(1, 2)
>  void ____trace_printk_check_format(const char *fmt, ...)
>  {
> @@ -149,8 +113,6 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
>  extern int __trace_bputs(unsigned long ip, const char *str);
>  extern int __trace_puts(unsigned long ip, const char *str);
>  
> -extern void trace_dump_stack(int skip);
> -
>  /*
>   * The double __builtin_constant_p is because gcc will give us an error
>   * if we try to allocate the static variable to fmt if it is not a
> @@ -173,19 +135,7 @@ __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
>  
>  extern __printf(2, 0) int
>  __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
> -
> -extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
>  #else
> -static inline void tracing_start(void) { }
> -static inline void tracing_stop(void) { }
> -static inline void trace_dump_stack(int skip) { }
> -
> -static inline void tracing_on(void) { }
> -static inline void tracing_off(void) { }
> -static inline int tracing_is_on(void) { return 0; }
> -static inline void tracing_snapshot(void) { }
> -static inline void tracing_snapshot_alloc(void) { }
> -
>  static inline __printf(1, 2)
>  int trace_printk(const char *fmt, ...)
>  {
> @@ -196,7 +146,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
>  {
>  	return 0;
>  }
> -static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  #endif /* CONFIG_TRACING */
>  
>  #endif
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index b276504c1c6b..f9c83a470c98 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -27,6 +27,7 @@
>  
>  #define pr_fmt(fmt) "KGDB: " fmt
>  
> +#include <linux/trace_controls.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/clocksource.h>
>  #include <linux/serial_core.h>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..1415e910371d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -9,6 +9,7 @@
>   * This function is used through-out the kernel (including mm and fs)
>   * to indicate a major problem.
>   */
> +#include <linux/trace_controls.h>
>  #include <linux/debug_locks.h>
>  #include <linux/sched/debug.h>
>  #include <linux/interrupt.h>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index fa6d30ce73d1..b3e2c8f25a4f 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -280,6 +280,8 @@ extern int rcu_cpu_stall_notifiers;
>  
>  #ifdef CONFIG_RCU_STALL_COMMON
>  
> +#include <linux/trace_controls.h>
> +
>  extern int rcu_cpu_stall_ftrace_dump;
>  extern int rcu_cpu_stall_suppress;
>  extern int rcu_cpu_stall_timeout;
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 882a158ada7b..76bf0184b267 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -39,6 +39,7 @@
>  #include <linux/srcu.h>
>  #include <linux/slab.h>
>  #include <linux/trace_clock.h>
> +#include <linux/trace_controls.h>
>  #include <asm/byteorder.h>
>  #include <linux/torture.h>
>  #include <linux/vmalloc.h>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 80fe152af1dd..2537c33ddd49 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -22,6 +22,7 @@
>  #include <linux/ctype.h>
>  #include <linux/once_lite.h>
>  #include <linux/ftrace_regs.h>
> +#include <linux/trace_controls.h>
>  #include <linux/llist.h>
>  
>  #include "pid_list.h"
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index e19c32f2a938..69cc39008c36 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -3,6 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/trace_clock.h>
> +#include <linux/trace_controls.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace_benchmark.h"
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index f32a06ec9ed4..e3c9ca05601b 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -8,6 +8,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/nmi.h>
>  #include <linux/sched/debug.h>
> +#include <linux/trace_controls.h>
>  #include <linux/string.h>
>  #include <linux/sysctl.h>
>  
> -- 
> 2.53.0
> 
