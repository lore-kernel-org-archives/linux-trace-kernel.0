Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A818DB29;
	Tue,  3 Jun 2025 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942439; cv=none; b=L6fqDWHBODVtvHFAiNBxphL9WxZZM5IWs/rSxdWGAPwxn47e1Gi+jb3K1Q64PqW4ECfc0cCWAVV9LoCDddt08dr3F1AQdZ7i5gQLuV3edU4J6WOoveTWLLs4Sv7YFtpWJiepigcsot0DoTicDroP6wP+iFanfWFtK3vyZtkIzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942439; c=relaxed/simple;
	bh=p9NjpU4OCCgM7bTR4DIZZaxlvncFkcQUC79/F9rivEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktMNihGruZIl+v801DfnzEGsvbnBcDg07lqpFfl+cTCGlfdDSlg+4pLnrqpTxRMqyMGdoq4Nz1lWAqHpp37gf3gvJtNNPKzjAMnvhN8EX1vDaocq4IwXinQKZAY9Q9XtDXF55JE1VWYy7atztnjnagryWesvhWPUezM05EpQ6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bBPbv4FNNz9s92;
	Tue,  3 Jun 2025 10:52:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7IUxrE3Y_nw; Tue,  3 Jun 2025 10:52:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bBPbm3Y1Nz9vY6;
	Tue,  3 Jun 2025 10:52:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 742888B765;
	Tue,  3 Jun 2025 10:52:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IcNMaBpAWABq; Tue,  3 Jun 2025 10:52:20 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD8958B763;
	Tue,  3 Jun 2025 10:52:19 +0200 (CEST)
Message-ID: <840249c5-2602-4178-a408-f7d502111f79@csgroup.eu>
Date: Tue, 3 Jun 2025 10:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
To: Aditya Bodkhe <adityab1@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 Aditya Bodkhe <aditya.b1@linux.ibm.com>
References: <20250528134820.74121-1-adityab1@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250528134820.74121-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/05/2025 à 15:48, Aditya Bodkhe a écrit :
> [Vous ne recevez pas souvent de courriers de adityab1@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> 
> commit a1be9ccc57f0 ("function_graph: Support recording and printing the
> return value of function") introduced support for function graph return
> value tracing.
> 
> Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
> ftrace_regs") further refactored and optimized the implementation,
> making `struct fgraph_ret_regs` unnecessary.
> 
> This patch enables the above modifications for powerpc64, ensuring that
> function graph return value tracing is available on this architecture.

Why only powerpc64 ?

I see nothing specific to powerpc64 in your patch, will it work on 
powerpc32 too ?

> 
> After this patch, v6.14+ kernel can also be built with FPROBE on powerpc
> but there are a few other build and runtime dependencies for FPROBE to
> work properly. The next patch addresses them.
> 
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> ---
>   arch/powerpc/Kconfig                     |  1 +
>   arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
>   arch/powerpc/kernel/trace/ftrace_entry.S | 41 ++++++++++++++----------
>   3 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3e0cc83f120..9163521bc4b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -250,6 +250,7 @@ config PPC
>          select HAVE_FUNCTION_ARG_ACCESS_API
>          select HAVE_FUNCTION_DESCRIPTORS        if PPC64_ELF_ABI_V1
>          select HAVE_FUNCTION_ERROR_INJECTION
> +       select HAVE_FUNCTION_GRAPH_FREGS
>          select HAVE_FUNCTION_GRAPH_TRACER
>          select HAVE_FUNCTION_TRACER             if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
>          select HAVE_GCC_PLUGINS                 if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index 82da7c7a1d12..6ffc9c9cf4e3 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -50,6 +50,21 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>                  asm volatile("mfmsr %0" : "=r" ((_regs)->msr)); \
>          } while (0)
> 
> +#undef ftrace_regs_get_return_value
> +static __always_inline unsigned long
> +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> +{
> +       return arch_ftrace_regs(fregs)->regs.gpr[3];
> +}
> +#define ftrace_regs_get_return_value ftrace_regs_get_return_value
> +
> +#undef ftrace_regs_get_frame_pointer
> +static __always_inline unsigned long
> +ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> +{
> +       return arch_ftrace_regs(fregs)->regs.gpr[1];
> +}
> +

Why unset and redefine ftrace_regs_get_return_value() and 
ftrace_regs_get_frame_pointer() ? Please explain why the default ones 
can't be used on powerpc.

>   static __always_inline void
>   ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>                                      unsigned long ip)
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 3565c67fc638..eafbfb7584ed 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -409,23 +409,30 @@ EXPORT_SYMBOL(_mcount)
>   _GLOBAL(return_to_handler)
>          /* need to save return values */
>   #ifdef CONFIG_PPC64
> -       std     r4,  -32(r1)
> -       std     r3,  -24(r1)
> +       stdu    r1, -SWITCH_FRAME_SIZE(r1)
> +       std     r4, GPR4(r1)
> +       std     r3, GPR3(r1)
> +  /* Save previous stack pointer (r1) */
> +       addi    r3, r1, SWITCH_FRAME_SIZE
> +       std     r3, GPR1(r1)
>          /* save TOC */
> -       std     r2,  -16(r1)
> -       std     r31, -8(r1)
> +       std     r2,  24(r1)
> +       std     r31, 32(r1)
>          mr      r31, r1
> -       stdu    r1, -112(r1)
> -
> +  /* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
> +       addi    r3,  r1, STACK_INT_FRAME_REGS

Some of the changes seems to only be renaming and should be done in a 
cleanup/preparatory patch in order to only focus on real necessary 
changes in this patch.

>          /*
>           * We might be called from a module.
>           * Switch to our TOC to run inside the core kernel.
>           */
>          LOAD_PACA_TOC()
>   #else
> -       stwu    r1, -16(r1)
> -       stw     r3, 8(r1)
> -       stw     r4, 12(r1)
> +       stwu    r1, -SWITCH_FRAME_SIZE(r1)

Why do we need such a big frame size just to save two registers ?

> +       stw     r4, GPR4(r1)
> +       stw     r3, GPR3(r1)
> +       addi    r3, r1, SWITCH_FRAME_SIZE
> +       stw     r3, GPR1(r1)
 > +       addi    r3, r1, STACK_INT_FRAME_REGS

Why is this needed ?

>   #endif
> 
>          bl      ftrace_return_to_handler
> @@ -435,15 +442,15 @@ _GLOBAL(return_to_handler)
>          mtlr    r3
> 
>   #ifdef CONFIG_PPC64
> -       ld      r1, 0(r1)
> -       ld      r4,  -32(r1)
> -       ld      r3,  -24(r1)
> -       ld      r2,  -16(r1)
> -       ld      r31, -8(r1)
> +       ld      r4,  GPR4(r1)
> +       ld      r3,  GPR3(r1)
> +       ld      r2,  24(r1)
> +       ld      r31, 32(r1)
> +       ld      r1,  0(r1)
>   #else
> -       lwz     r3, 8(r1)
> -       lwz     r4, 12(r1)
> -       addi    r1, r1, 16
> +       lwz     r3, GPR3(r1)
> +       lwz     r4, GPR4(r1)
> +       addi    r1, r1, SWITCH_FRAME_SIZE
>   #endif
> 
>          /* Jump back to real return address */
> --
> 2.43.5
> 

