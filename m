Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11432494D8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268210; cv=none; b=Tmq9TDrPTUFNx8Mj+bHUE8qeKppmwGw6+tW+R7e1FRlD2qJZ8AL8Arx/gOI6iB6T1sca2BRTc2ykgqDTi5pBY250pVQhf7R34vIpFHI6OSowwWt5YPxqrll2kBJ9Ctm2OrosWF1DywIXfd57J62ZMtTyNeV62plWu6gyAHlf9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268210; c=relaxed/simple;
	bh=T76ciC7MvD6Uq6qKE1gKRXHkh8/nQlep+GS6D4H+5gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O23AQY/Ropgnqk9rHWv78aro1IefdmyhKVfueH/lhhNQ8Q6cUiWQhN3/qXxFJ7gL5yqhdxWKswzzqls1QCuaBWgdjG5i/SDkWkS88NMPid0sL6sR8IlPBKysXdxrUbXYHrTgpkGbn6jIK51eLGLNVGrM4hBS0ujTBa4lHYWWh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiYwTjA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiYwTjA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D6EC2BC87
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760268209;
	bh=T76ciC7MvD6Uq6qKE1gKRXHkh8/nQlep+GS6D4H+5gU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BiYwTjA1WXiDDZ6k1pLc0b+PVyq6vXvaXJOZF4TiaEg3k2huYIgxz5uiIWihe7xx0
	 argw5VZRtvF7yvFH0XbmOvh0rZc5EIGTsLQphvKJutV+Re/G93hVAnGO/5Vd5s/oV9
	 BpVI41JFcsEueP3VZuSaN5D1ccT/o0TFTic9XbmluMz1UuFcuYBBBwteLFMr+aqlHW
	 1ddfWukU9fy6Xto3ZNWKhaDND0UbOc23zwq/V6B3oWgI4q8NIj9J3LJ5Uhc8IKvH5F
	 0/hDSffDn5lByMu0/A6fKW6w/j0c0gjpfd5s+MEWpAB9/vhUnj99cOFfrDLdMa3mmb
	 8b438qCPpYpnw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b303f755aso27765545e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 04:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwOy1/RvHu9eMCN5VoDPsF1y1ivC2xWdt2o5RdI4EL4je5hcs5KY3aBetYYpM6TO/6uqaugjy7Uuc5atR9bWd713Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdTNp8dbeOEJjLgQVPUlRLNz0bC2DgL9nRW1hwMwpu5LB/noQ
	45jTEvL2zTeNanW3meV2MeMF/tCHJXDTpo0DHgfjCyhGymSrCViNYUx3Pa5kIGQgfvXsW+NF0F7
	AEC9zGCO5Y4HHYBISL3g8mY70mFPej+Y=
X-Google-Smtp-Source: AGHT+IHWkSwxpRdIU93ruDljUo6L3O36dcwVKmHU88EIC562kkwkQS6D3HE2q9MMHT5O3SbUtodlQg41kAKRXUo7tRc=
X-Received: by 2002:a05:600c:1c23:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-46fa9a892a0mr122801735e9.7.1760268207732; Sun, 12 Oct 2025
 04:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009134514.8549-1-cuiyunhui@bytedance.com>
In-Reply-To: <20251009134514.8549-1-cuiyunhui@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 12 Oct 2025 19:23:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJD3G1gyh8ucf6OSp2Y0=xHKGRLQakrTwqiLbzG+G0uw@mail.gmail.com>
X-Gm-Features: AS18NWD6MJ72Wu3veu27hAB-l8__trDKgDBlFxv_dFmO-FnASlGZT1S2onigZrQ
Message-ID: <CAJF2gTTJD3G1gyh8ucf6OSp2Y0=xHKGRLQakrTwqiLbzG+G0uw@mail.gmail.com>
Subject: Re: [PATCH RFC] riscv: add support for Ziccid
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, 
	willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org, 
	bjorn@rivosinc.com, ajones@ventanamicro.com, parri.andrea@gmail.com, 
	cleger@rivosinc.com, yongxuan.wang@sifive.com, inochiama@gmail.com, 
	samuel.holland@sifive.com, charlie@rivosinc.com, conor.dooley@microchip.com, 
	yikming2222@gmail.com, andybnac@gmail.com, yury.norov@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:45=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> The Ziccid extension provides hardware synchronization between
> Dcache and Icache. With this hardware support, there's no longer
> a need to trigger remote hart execution of fence.i via IPI.
Ziccid only means I/D $ coherent, we still need "fence.i" & IPI to
flush the instructions stalled in the pipeline.

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
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index 0092513c3376c..3a8cdf30bb4b1 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -68,7 +68,7 @@ static inline void flush_cache_vmap(unsigned long start=
, unsigned long end)
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
>  static inline void flush_icache_range(unsigned long start, unsigned long=
 end)
>  {
> -       flush_icache_all();
> +       flush_icache_all(false);
>  }
>
>  extern unsigned int riscv_cbom_block_size;
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index affd63e11b0a3..ad97d8955b501 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -106,6 +106,7 @@
>  #define RISCV_ISA_EXT_ZAAMO            97
>  #define RISCV_ISA_EXT_ZALRSC           98
>  #define RISCV_ISA_EXT_ZICBOP           99
> +#define RISCV_ISA_EXT_ZICCID           100
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920c..b8a9e455efe9e 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -98,7 +98,17 @@ static inline bool switch_to_should_flush_icache(struc=
t task_struct *task)
>         bool stale_thread =3D task->thread.force_icache_flush;
>         bool thread_migrated =3D smp_processor_id() !=3D task->thread.pre=
v_cpu;
>
> +       asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICC=
ID, 1)
> +                : : : : ziccid);
> +
>         return thread_migrated && (stale_mm || stale_thread);
> +
> +ziccid:
> +       /*
> +        * Process switching writes to SATP, which flushes the pipeline,
> +        * so only the thread scenario is considered.
> +        */
> +       return thread_migrated && stale_thread;
>  #else
>         return false;
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 67b59699357da..2da82aa2dbf0a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>         __RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> +       __RISCV_ISA_EXT_DATA(ziccid, RISCV_ISA_EXT_ZICCID),
>  };
>
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 8d18d6727f0fc..431448e818363 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -43,7 +43,7 @@ void arch_ftrace_update_code(int command)
>  {
>         command |=3D FTRACE_MAY_SLEEP;
>         ftrace_modify_all_code(command);
> -       flush_icache_all();
> +       flush_icache_all(false);
>  }
>
>  static int __ftrace_modify_call(unsigned long source, unsigned long targ=
et, bool validate)
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.=
c
> index 671b686c01587..388f10e187bae 100644
> --- a/arch/riscv/kernel/hibernate.c
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
>         } else {
>                 suspend_restore_csrs(hibernate_cpu_context);
>                 flush_tlb_all();
> -               flush_icache_all();
> +               flush_icache_all(true);
>
>                 /*
>                  * Tell the hibernation core that we've just restored the=
 memory.
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_labe=
l.c
> index b4c1a6a3fbd28..680b29f4c09c4 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -51,5 +51,5 @@ bool arch_jump_label_transform_queue(struct jump_entry =
*entry,
>
>  void arch_jump_label_transform_apply(void)
>  {
> -       flush_icache_all();
> +       flush_icache_all(false);
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
>         return local_flush_icache_all();
>  }
>
> -void flush_icache_all(void)
> +void flush_icache_all(bool force)
>  {
>         local_flush_icache_all();
>
>         if (num_online_cpus() < 2)
>                 return;
>
> +       if (!force)
> +               asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0,
> +                       RISCV_ISA_EXT_ZICCID, 1)
> +                       : : : : ziccid);
>         /*
>          * Make sure all previous writes to the D$ are ordered before mak=
ing
>          * the IPI. The RISC-V spec states that a hart must execute a dat=
a fence
> @@ -41,6 +46,7 @@ void flush_icache_all(void)
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> +ziccid:;
>  }
>  EXPORT_SYMBOL(flush_icache_all);
>
> @@ -61,13 +67,17 @@ void flush_icache_mm(struct mm_struct *mm, bool local=
)
>
>         preempt_disable();
>
> +       local_flush_icache_all();
> +
> +       asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICC=
ID, 1)
> +                : : : : ziccid);
> +
>         /* Mark every hart's icache as needing a flush for this MM. */
>         mask =3D &mm->context.icache_stale_mask;
>         cpumask_setall(mask);
>         /* Flush this hart's I$ now, and mark it as flushed. */
>         cpu =3D smp_processor_id();
>         cpumask_clear_cpu(cpu, mask);
> -       local_flush_icache_all();
>
>         /*
>          * Flush the I$ of other harts concurrently executing, and mark t=
hem as
> @@ -91,6 +101,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                 on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>         }
>
> +ziccid:;
> +
>         preempt_enable();
>  }
>
> --
> 2.39.5
>


--=20
Best Regards
 Guo Ren
