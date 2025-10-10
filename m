Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9A201278
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118497; cv=none; b=nmFUWVGLgokHcCGWbiCQ3IgqiMVu21eHTKVBKkriKQygJjRJ/xH8WWEPLLi7MLoxl4MhKiDuQsaH0w9FkeBHCZbT5K8o6pkaV6dzyCU3PYqENtIqck/0T6zpSzkeg8Oq5t2o+2Xk4ZvDngC10JmMXc7AblZo1/6GThmsiF3baCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118497; c=relaxed/simple;
	bh=XfqhlII4PjtW4or6k7WVcAjehOR0VEsfSVEyAm2tvpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaejyqC6Nmj+LNbFz3cbovkgDEtsiueCqmE32nsS+iPf5/+FsId3Ar04wiNphkwzA5D47+P94I/hj5xn7WRKML1PyZPx9mJJGG7QdL/kTu+GK+Ij67GLQAQEzT0gQVN93c2UKuhf3v96u4t3tot1vxPJsR9nYH6ea+4AE04uplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2n2i0DD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2n2i0DD"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-80ff41475cdso37522666d6.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118495; x=1760723295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HDKcRyh3PZKdHNMvnRZkTba9f0/5qU6T/Ayx2+vV5I=;
        b=U2n2i0DD8pIrZWeBPvIrK0fZ04579t9mXVSX1TOlUvBxlNbI9cnuv9Ts/NwZxbYFc2
         3HZmc3aqo/nqiXpwOOGJjciyFYGBT4n8y6GnSRbdtVWfYCgwaRO+BoRMrfatVdQCOshA
         oSN0KgHEqVVutHFAoIhwNSMIKsGuZT1vTz/ptk4/S8ht3wDQkFajhsJQMFOS5l9nTEXa
         FdE5ia29LDkJQATn1rWS8OauHc7YjriM8QIt2HLTbXO2B/quycPWrv4KuDV0MyAzNRLP
         jI4SEpOo+iSLGcMtp8DMYK6QxeHVlOJuLWI5LaR8QDqJdrNRpoP4v9bsVnNijffPUDWE
         Q84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118495; x=1760723295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HDKcRyh3PZKdHNMvnRZkTba9f0/5qU6T/Ayx2+vV5I=;
        b=t6Op1LFWPjCCrhbIGnYzbm2x5XyyVwJoCVDR5WjTSpXmP7mR0/MVvUGcVNeBTcYFyE
         s6LWWQrwwUKhCH7sR8Ncpte6GTDcxfgAa6jm2Dyq3rojRAIqnj2/qTNXVohRCEOUCMwh
         RVUV3Dv8a/c2gNYypDpqJwbGW6bgr4tdb8Af24cX65g0sXYrZR7qpdraM7rdmOjX5GQx
         BJJ7uyNccH3YcFIJOGvbd2LJIPDvNNhBht81m6jDpcpdI2EASAiwb+Zi/058IyteCqnU
         ia3dJWZDa/DNdDEOgF2BLZ3XRvXksNMaZx5lyquXB+PVV1tJzj/4WaqvLsRaip12qlK4
         p/0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+YKg/yQ5kMNtPbgGTFYtAlvVTWOXLwF817ETMwPajtIBeHpHx7IUQSHcwNQk3SumJz7p+bsX2QkELGJXULEMSTBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/giEegisll6xWST7ZW2vXOLiR5rjWbxHbf94xRZGlVataRIYm
	WoJY63yIpoWjUQ99RaDAyb1BVXrQPpMh1/Htp4QXJ9jPjCnTYeRDNqev
X-Gm-Gg: ASbGncvDifMM/hgDCXoLcfEM3P/QbydTp6rDn3OBt4G6137Fql+mTksQfAtUKg62FS3
	fWpeoAhnPHwQl+T2ypzPgwaJsc6sJtV61mI+Qkw2KCG/MK9eSZqv0pdvTBdHJs8Hfkl6WK/PwFq
	teKPNfwedVD2ns3sgdcarl5W6GGMYxVgSrTYr+95VIo4D4p+hVD3zOOygKtfvJlbfhdkL4GjOL+
	GTJMFN+yGq0cVYWH/gVjqaYopJ6tC91dhvC5VnwgWX2efrlLseXRlzWWhQUhrXnTXwzdQJzacgD
	j6kFFfXh92qUbCWKosKZxEGuMG7vq1Tyz0vN5bReoySLJtxThvQZqEDSgCKY8qtL8/rcO/iKi9M
	941DlTiGrSoIhrtNgj4GaJebYioLBAwDoog2TI78WkljMkiqQ
X-Google-Smtp-Source: AGHT+IHt1fltqSOQNAwaJvgXJiJNUt/Iy268/HwGtU21DjWYu9BdYiR8Fuy0ro1CN7LEJs+CaTZBBA==
X-Received: by 2002:ac8:5751:0:b0:4de:74f8:b2a4 with SMTP id d75a77b69052e-4e6ead7789cmr174443161cf.53.1760118494834;
        Fri, 10 Oct 2025 10:48:14 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3574e7esm20215986d6.41.2025.10.10.10.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:48:14 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:48:12 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, ardb@kernel.org, willy@infradead.org,
	guoren@kernel.org, ziy@nvidia.com, akpm@linux-foundation.org,
	bjorn@rivosinc.com, ajones@ventanamicro.com, parri.andrea@gmail.com,
	cleger@rivosinc.com, yongxuan.wang@sifive.com, inochiama@gmail.com,
	samuel.holland@sifive.com, charlie@rivosinc.com,
	conor.dooley@microchip.com, yikming2222@gmail.com,
	andybnac@gmail.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] riscv: add support for Ziccid
Message-ID: <aOlG3Mb6_vN4uuA7@yury>
References: <20251009134514.8549-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134514.8549-1-cuiyunhui@bytedance.com>

On Thu, Oct 09, 2025 at 09:45:14PM +0800, Yunhui Cui wrote:
> The Ziccid extension provides hardware synchronization between
> Dcache and Icache. With this hardware support, there's no longer
> a need to trigger remote hart execution of fence.i via IPI.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/cacheflush.h |  4 ++--
>  arch/riscv/include/asm/hwcap.h      |  1 +
>  arch/riscv/include/asm/switch_to.h  | 10 ++++++++++
>  arch/riscv/kernel/cpufeature.c      |  1 +
>  arch/riscv/kernel/ftrace.c          |  2 +-
>  arch/riscv/kernel/hibernate.c       |  2 +-
>  arch/riscv/kernel/jump_label.c      |  2 +-
>  arch/riscv/mm/cacheflush.c          | 16 ++++++++++++++--
>  8 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 0092513c3376c..3a8cdf30bb4b1 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -68,7 +68,7 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
>  
>  #else /* CONFIG_SMP */
>  
> -void flush_icache_all(void);
> +void flush_icache_all(bool force);
>  void flush_icache_mm(struct mm_struct *mm, bool local);
>  
>  #endif /* CONFIG_SMP */
> @@ -80,7 +80,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>  #define flush_icache_range flush_icache_range
>  static inline void flush_icache_range(unsigned long start, unsigned long end)
>  {
> -	flush_icache_all();
> +	flush_icache_all(false);
>  }
>  
>  extern unsigned int riscv_cbom_block_size;
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index affd63e11b0a3..ad97d8955b501 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -106,6 +106,7 @@
>  #define RISCV_ISA_EXT_ZAAMO		97
>  #define RISCV_ISA_EXT_ZALRSC		98
>  #define RISCV_ISA_EXT_ZICBOP		99
> +#define RISCV_ISA_EXT_ZICCID		100
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 0e71eb82f920c..b8a9e455efe9e 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -98,7 +98,17 @@ static inline bool switch_to_should_flush_icache(struct task_struct *task)
>  	bool stale_thread = task->thread.force_icache_flush;
>  	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
>  
> +	asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICCID, 1)
> +		 : : : : ziccid);
> +

Instead of opencoded 'asm goto', can you try the riscv_has_extension() here
and everywhere?

	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICCID))
          	return thread_migrated && (stale_mm || stale_thread);
        else
        	return thread_migrated && stale_thread;

Thanks,
Yury
                

>  	return thread_migrated && (stale_mm || stale_thread);
> +
> +ziccid:
> +	/*
> +	 * Process switching writes to SATP, which flushes the pipeline,
> +	 * so only the thread scenario is considered.
> +	 */
> +	return thread_migrated && stale_thread;
>  #else
>  	return false;
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 67b59699357da..2da82aa2dbf0a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> +	__RISCV_ISA_EXT_DATA(ziccid, RISCV_ISA_EXT_ZICCID),
>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 8d18d6727f0fc..431448e818363 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -43,7 +43,7 @@ void arch_ftrace_update_code(int command)
>  {
>  	command |= FTRACE_MAY_SLEEP;
>  	ftrace_modify_all_code(command);
> -	flush_icache_all();
> +	flush_icache_all(false);
>  }
>  
>  static int __ftrace_modify_call(unsigned long source, unsigned long target, bool validate)
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> index 671b686c01587..388f10e187bae 100644
> --- a/arch/riscv/kernel/hibernate.c
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
>  	} else {
>  		suspend_restore_csrs(hibernate_cpu_context);
>  		flush_tlb_all();
> -		flush_icache_all();
> +		flush_icache_all(true);
>  
>  		/*
>  		 * Tell the hibernation core that we've just restored the memory.
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index b4c1a6a3fbd28..680b29f4c09c4 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -51,5 +51,5 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>  
>  void arch_jump_label_transform_apply(void)
>  {
> -	flush_icache_all();
> +	flush_icache_all(false);
>  }
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index d83a612464f6c..01f9f7a45e8d2 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -12,19 +12,24 @@
>  #ifdef CONFIG_SMP
>  
>  #include <asm/sbi.h>
> +#include <asm/alternative-macros.h>
>  
>  static void ipi_remote_fence_i(void *info)
>  {
>  	return local_flush_icache_all();
>  }
>  
> -void flush_icache_all(void)
> +void flush_icache_all(bool force)
>  {
>  	local_flush_icache_all();
>  
>  	if (num_online_cpus() < 2)
>  		return;
>  
> +	if (!force)
> +		asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0,
> +			RISCV_ISA_EXT_ZICCID, 1)
> +			: : : : ziccid);
>  	/*
>  	 * Make sure all previous writes to the D$ are ordered before making
>  	 * the IPI. The RISC-V spec states that a hart must execute a data fence
> @@ -41,6 +46,7 @@ void flush_icache_all(void)
>  		sbi_remote_fence_i(NULL);
>  	else
>  		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> +ziccid:;
>  }
>  EXPORT_SYMBOL(flush_icache_all);
>  
> @@ -61,13 +67,17 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  
>  	preempt_disable();
>  
> +	local_flush_icache_all();
> +
> +	asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICCID, 1)
> +		 : : : : ziccid);
> +
>  	/* Mark every hart's icache as needing a flush for this MM. */
>  	mask = &mm->context.icache_stale_mask;
>  	cpumask_setall(mask);
>  	/* Flush this hart's I$ now, and mark it as flushed. */
>  	cpu = smp_processor_id();
>  	cpumask_clear_cpu(cpu, mask);
> -	local_flush_icache_all();
>  
>  	/*
>  	 * Flush the I$ of other harts concurrently executing, and mark them as
> @@ -91,6 +101,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>  	}
>  
> +ziccid:;
> +
>  	preempt_enable();
>  }
>  
> -- 
> 2.39.5
