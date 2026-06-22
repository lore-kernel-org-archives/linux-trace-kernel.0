Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CC3CB2D9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144070; cv=none; b=THjWiYBFZ7Iu0Yy5+pEq0mSQfbiewme2a9DZstAexZnRSc6fPrpBPKoYEdtYzZH9YpuzfIUt+qJfrZoPHT/iWoGzQYLclp4QslkP+1H4sGKekczkmLkL/8gAND+p86kCI5wa/0BQTkued2Cbw1dhBFW+4XyTrso2BJ7XM+kDFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144070; c=relaxed/simple;
	bh=lrZwY1IAVvsZ7vbGsommQByFvXAB4qaKufAQfcZg0ac=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnWMJWi/jG4KiE+a1rhYyoDgrUMaCbkEN3ZKbPT0uJRrLKS0bya0BuEek5LZeBNKHWH41GEuBWrKxZURljqolRtwGYgiJWsstMsEuRcKROXANbUXcPNbUMWFlNi6LQCtv5L1pW6MtosQiCKkRib6bNuA1nn/X0G95i7MhbIZ0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXcyrCSo; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXcyrCSo"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30b9e755555so10129725eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782144068; x=1782748868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCs1+JlVbIzJXmpXd/KXD8WIz/8olSzw0J3KnS4mUu0=;
        b=NXcyrCSoFvAsa1MqMqfvZAZLcdMxn39nHxewng8Q/bC/JxkdIM7pT8en/hUxPeP2sQ
         s+o+9mDHW4h4Hui9s5gc+BUn1ImQls5ZN51Q7ll2RVev76dZQ84WmendaGnKEza4WjZz
         YyiNkWcKmiGLApvQkft6g/HcX7aGfd4GacB7dMykRv27iUVDOxlQxlyaFlQNZaRGz86u
         mjAcDCjfkL7djEjG+NKQJE/XHwc/nmOG1LZR/ZX47dP2Idi8LFMrxc8A2CPv/u/ctj+y
         CO/3eG6bIEj3klcktorQYoBupekqtbw7/8a5wtplBV+upJJGlXLSkrEDUHMcoj5MQFuw
         sA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144068; x=1782748868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCs1+JlVbIzJXmpXd/KXD8WIz/8olSzw0J3KnS4mUu0=;
        b=Kp5IWFnE9ZqJUUHbKzyl/WW3Hj3oGeEaNhBu+PBOv4rAvmnwz4/ERJ9Fm4v5SX3hll
         9jd64dBtfNmj1B0Y8YbLmXnHnTXNOBhsaYbTXOXXEsuwyNUaKfAwsDHfl5sO4HJ4NuL0
         oPHwMpa3rz0UHct16EJ3dv/KwZX3jHcHQh5R574IXH5jQYUlL7VnqpyxxoisUW3pcGn1
         /tCtkfVd0t8MIuAL8AmyFdVEzMx2FLkL9NJJ8/BHzIHANX5QMbqiI2v0KANqusqFG7T0
         yB+gliw9JgblD1NWv/TyJ/mQObXgy31vX0gfzti79IWvKkEIROFxC4xxajDizcbTFMnz
         xyFg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8CbB2otV+I4oa/e0+b6TSlyMJumhPMW9l8KPhM2jYyUQa/J1nL2pdeDGgWIZxW/V5po7Ijhx/Qk7TSxprurD9q6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rBGwpthTZ0yIeo1n6/chhWxrNXsf8M6x1pAKQnkXZ+IPYioa
	vmYDmt1yM5lcd06VR+QLxFSg6EXa8+gWzV2DJ6QnxYRR0tvkteN3b3xE
X-Gm-Gg: AfdE7ck4um+fpMntAU84nKLHps/8CHkkOifcPD6SVnbWknEmlbzwRyK6qHFSXwKaFAm
	X75WP/vYxtNAndPpKWmM3TvN6EYgzMvP61Q9NNIxznby4UgSpsc9a880+4A1rz1+4WGEr5oxxqv
	TH03QSR9w5npCHwvFM6jvmUMOhWLm5QBDKzltZ+4R56vBOv5SniTFh/x1/9RbouXoHxuw7HoKjc
	ZZgmSIB+i+cyP+vZ0ou+p3rNeef0rAjEBGP041r906+umO7CpbcEKYrWN3d9MinLTe7SqNEpAIu
	6d7qLq/PLSM62WlpIKc4QbiixVBnGzJ98RLB3FKv+BQu/LO2ayLQNHGzwW4xaWIwT+6n5B1JtQF
	PFTj7V72Q0sMpNSgbTKGt+ee9lYYiFdo4AWTHjelepFvfuUSpaxxB1Dx7NTSkZtykQpFnRi1aJQ
	ajCHgHj5HY
X-Received: by 2002:a05:7300:72c5:b0:30b:9eb0:4899 with SMTP id 5a478bee46e88-30c0711feb0mr11993578eec.20.1782144067597;
        Mon, 22 Jun 2026 09:01:07 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c44ec51b9sm3281121eec.29.2026.06.22.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:01:06 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 12:01:05 -0400
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
Subject: Re: [PATCH v2 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <ajlcOU1o5Omy4q57@yury>
References: <20260622130739.375198646@kernel.org>
 <20260622131029.816825024@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622131029.816825024@kernel.org>

On Mon, Jun 22, 2026 at 09:07:41AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There have been complaints about trace_printk.h causing more build time
> for being in kernel.h. Move it out of kernel.h and place it in the headers
> and C files that use it.
> 
> Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/

Link is nice, but can you explain in the commit message what those
complaints exactly are? There's enough opinions shared to make a nice
summary. I even think it's important enough to become a Documentation
rule.
 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> Changes since v1: https://patch.msgid.link/20260621093811.168514984@kernel.org
> 
> - Just remove trace_printk.h and fix up all the places that need it.
> 
>  arch/powerpc/kvm/book3s_xics.c         | 1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.h    | 1 +
>  drivers/gpu/drm/i915/i915_gem.h        | 1 +
>  drivers/hwtracing/stm/dummy_stm.c      | 4 ++++
>  drivers/infiniband/hw/hfi1/trace_dbg.h | 1 +
>  drivers/usb/early/xhci-dbc.c           | 1 +
>  fs/ext4/inline.c                       | 1 +
>  include/linux/ftrace.h                 | 2 ++
>  include/linux/kernel.h                 | 1 -
>  include/linux/sunrpc/debug.h           | 1 +
>  include/linux/trace_printk.h           | 5 +++--
>  kernel/trace/ring_buffer_benchmark.c   | 1 +
>  samples/fprobe/fprobe_example.c        | 1 +
>  samples/ftrace/ftrace-direct-too.c     | 1 -
>  samples/trace_printk/trace-printk.c    | 1 +
>  15 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
> index 74a44fa702b0..ef5eb596a56e 100644
> --- a/arch/powerpc/kvm/book3s_xics.c
> +++ b/arch/powerpc/kvm/book3s_xics.c
> @@ -26,6 +26,7 @@
>  #if 1
>  #define XICS_DBG(fmt...) do { } while (0)
>  #else
> +#include <linux/trace_printk.h>
>  #define XICS_DBG(fmt...) trace_printk(fmt)
>  #endif
>  
> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
> index b54ee4f25af1..f6f223090760 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
> @@ -35,6 +35,7 @@
>  #define I915_GFP_ALLOW_FAIL (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
>  
>  #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GTT)
> +#include <linux/trace_printk.h>

So, before it was included unconditionally, now it's included. It
looks technically correct, but conceptually - I'm not sure.

I'm not a developer of this driver, but ... here we need trace_printk.h
if TRACE_GTT is enabled, in the next header TRACE_GEM needs it. To me
it sounds like the whole driver simply needs trace_printk.h.

>  #define GTT_TRACE(...) trace_printk(__VA_ARGS__)
>  #else
>  #define GTT_TRACE(...)
> diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
> index 1da8fb61c09e..f490052e8964 100644
> --- a/drivers/gpu/drm/i915/i915_gem.h
> +++ b/drivers/gpu/drm/i915/i915_gem.h
> @@ -117,6 +117,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
>  
>  #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
>  #include <linux/trace_controls.h>
> +#include <linux/trace_printk.h>
>  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
>  #define GEM_TRACE_ERR(...) do {						\
>  	pr_err(__VA_ARGS__);						\
> diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
> index 38528ffdc0b3..784f9af7ccba 100644
> --- a/drivers/hwtracing/stm/dummy_stm.c
> +++ b/drivers/hwtracing/stm/dummy_stm.c
> @@ -14,6 +14,10 @@
>  #include <linux/stm.h>
>  #include <uapi/linux/stm.h>
>  
> +#ifdef DEBUG
> +#include <linux/trace_printk.h>
> +#endif
> +

Same here. The cost of adding the header in a particular C file is
unmeasurable. But playing "#undef DEBUG #ifdef DEBUG" games looks
weird.

Imagine, the developer has this DEBUG enabled, then adds another
debugging trace_pritnk() out of the DEBUG block, compiles his patch
well, then sends to the user, who has DEBUG disabled; and now we hit
the same problem as in the config-based case.

Let's put it simple: dummy_stm just needs trace_printk.h.

>  static ssize_t notrace
>  dummy_stm_packet(struct stm_data *stm_data, unsigned int master,
>  		 unsigned int channel, unsigned int packet, unsigned int flags,
> diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
> index 58304b91380f..30df5e246586 100644
> --- a/drivers/infiniband/hw/hfi1/trace_dbg.h
> +++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
> @@ -103,6 +103,7 @@ __hfi1_trace_def(IOCTL);
>   */
>  
>  #ifdef HFI1_EARLY_DBG
> +#include <linux/trace_printk.h>
>  #define hfi1_dbg_early(fmt, ...) \
>  	trace_printk(fmt, ##__VA_ARGS__)
>  #else
> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
> index 41118bba9197..955c73bd601f 100644
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -30,6 +30,7 @@ static struct xdbc_state xdbc;
>  static bool early_console_keep;
>  
>  #ifdef XDBC_TRACE
> +#include <linux/trace_printk.h>
>  #define	xdbc_trace	trace_printk
>  #else
>  static inline void xdbc_trace(const char *fmt, ...) { }
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 8045e4ff270c..0eff4a0c6a6c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -934,6 +934,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>  }
>  
>  #ifdef INLINE_DIR_DEBUG
> +#include <linux/trace_printk.h>
>  void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
>  			  void *inline_start, int inline_size)
>  {
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 02bc5027523a..b5336a81e619 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -8,6 +8,8 @@
>  #define _LINUX_FTRACE_H
>  
>  #include <linux/trace_recursion.h>
> +#include <linux/trace_controls.h>
> +#include <linux/trace_printk.h>
>  #include <linux/trace_clock.h>
>  #include <linux/jump_label.h>
>  #include <linux/kallsyms.h>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5570a16cbb1..e87a40fbd152 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -31,7 +31,6 @@
>  #include <linux/build_bug.h>
>  #include <linux/sprintf.h>
>  #include <linux/static_call_types.h>
> -#include <linux/trace_printk.h>
>  #include <linux/util_macros.h>
>  #include <linux/wordpart.h>
>  
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index ab61bed2f7af..7524f5d82fba 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -29,6 +29,7 @@ extern unsigned int		nlm_debug;
>  # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
>  
>  # if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
> +#  include <linux/trace_printk.h>
>  #  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
>  # else
>  #  define __sunrpc_printk(fmt, ...)	printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index a488ea9e9f85..74ce4f8995c4 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -1,11 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_TRACE_PRINTK_H
>  #define _LINUX_TRACE_PRINTK_H
> +#if !defined(__ASSEMBLY__) && !defined(__GENKSYMS__) && !defined(BUILD_VDSO)
>  
> -#include <linux/compiler_attributes.h>
>  #include <linux/instruction_pointer.h>
>  #include <linux/stddef.h>
>  #include <linux/stringify.h>
> +#include <linux/stdarg.h>
>  
>  #ifdef CONFIG_TRACING
>  static inline __printf(1, 2)
> @@ -147,5 +148,5 @@ ftrace_vprintk(const char *fmt, va_list ap)
>  	return 0;
>  }
>  #endif /* CONFIG_TRACING */
> -
> +#endif /* !defined(__ASSEMBLY__) && !defined(__GENKSYMS__) && !defined(BUILD_VDSO) */
>  #endif
> diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
> index 593e3b59e42e..2bb25caebb75 100644
> --- a/kernel/trace/ring_buffer_benchmark.c
> +++ b/kernel/trace/ring_buffer_benchmark.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2009 Steven Rostedt <srostedt@redhat.com>
>   */
>  #include <linux/ring_buffer.h>
> +#include <linux/trace_printk.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
>  #include <uapi/linux/sched/types.h>
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index bfe98ce826f3..de81b9b4ca7d 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -12,6 +12,7 @@
>  
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
> +#include <linux/trace_printk.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/fprobe.h>
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index bf2411aa6fd7..159190f4103f 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/module.h>
> -
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
>  #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
> diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
> index cfc159580263..ff37aeb8523e 100644
> --- a/samples/trace_printk/trace-printk.c
> +++ b/samples/trace_printk/trace-printk.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/trace_printk.h>
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/irq_work.h>
> -- 
> 2.53.0
> 
