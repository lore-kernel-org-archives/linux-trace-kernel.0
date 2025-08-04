Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A51F4612;
	Mon,  4 Aug 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319037; cv=none; b=tnv6SoaXRcLYASbCGlwpT9XRLh6XAhywwTllf3p9n5vtEdws7uHJBLSwrKUHWtQEUtRcgUzet6xjG3Q8gd2iRx1RYGcEsojmBmIG5U+Vicxs7uakJfp9ljLqpAZJS/rfFQIblpGAvldUjodZ7qqwzUDbmWkuTU/mZJgmIkYeDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319037; c=relaxed/simple;
	bh=Lv0zUTekwP29mYEeNY8FP4NK5pv608kruRZBw117cek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmnpBLWhqj1nMQoaUHvFxcq0QJzEirbGBh3bSkUSMcOtCOItle/YT9f3iGpCTEW7db07/BCsffnnMAI1PxQ/NmfbfoieGGzL483pCw7tmV7i8VLmmOqW10ZX4KnajsHz7licwqeV4cIhEHxaZtclEZQ7wCtrmz7WI0cweY9rCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bwdx61Fwbz9t2k;
	Mon,  4 Aug 2025 16:19:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aafYWNPsnuTc; Mon,  4 Aug 2025 16:19:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bwdx60NySz9t2V;
	Mon,  4 Aug 2025 16:19:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0679F8B766;
	Mon,  4 Aug 2025 16:19:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 25xDQtsmUhRS; Mon,  4 Aug 2025 16:19:53 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BF56C8B763;
	Mon,  4 Aug 2025 16:19:53 +0200 (CEST)
Message-ID: <7e1adda9-4348-4c4e-953e-3fd21e4ff3c5@csgroup.eu>
Date: Mon, 4 Aug 2025 16:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc/ftrace: support
 CONFIG_FUNCTION_GRAPH_RETVAL
To: Aditya Bodkhe <adityab1@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 venkat88@linux.ibm.com
References: <20250722085648.1640-1-adityab1@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250722085648.1640-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/07/2025 à 10:56, Aditya Bodkhe a écrit :
> commit a1be9ccc57f0 ("function_graph: Support recording and printing the
> return value of function") introduced support for function graph return
> value tracing.
> 
> Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
> ftrace_regs") further refactored and optimized the implementation,
> making `struct fgraph_ret_regs` unnecessary.
> 
> This patch enables the above modifications for powerpc all, ensuring that
> function graph return value tracing is available on this architecture.
> 
> In this patch we have redefined two functions:
> - 'ftrace_regs_get_return_value()' - the existing implementation on
> ppc returns -ve of return value based on some conditions not
> relevant to our patch.
> - 'ftrace_regs_get_frame_pointer()' - always returns 0 in current code .
> 
> We also allocate stack space to equivalent of 'SWITCH_FRAME_SIZE',
> allowing us to directly use predefined offsets like 'GPR3' and 'GPR4'
> this keeps code clean and consistent with already defined offsets .
> 
> After this patch, v6.14+ kernel can also be built with FPROBE on powerpc
> but there are a few other build and runtime dependencies for FPROBE to
> work properly. The next patch addresses them.
> 
> Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> 
> Changelog:
> v1 -> v2:
> - Added explanation for redefining ftrace_regs_get_return_value()
> and ftrace_regs_get_frame_pointer()
> - Explained why stack space equivalent to 'SWITCH_FRAME_SIZE' is allocated.
> 
>   arch/powerpc/Kconfig                     |  1 +
>   arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
>   arch/powerpc/kernel/trace/ftrace_entry.S | 42 ++++++++++++++----------
>   3 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3e0cc83f120..9163521bc4b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -250,6 +250,7 @@ config PPC
>   	select HAVE_FUNCTION_ARG_ACCESS_API
>   	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
>   	select HAVE_FUNCTION_ERROR_INJECTION
> +	select HAVE_FUNCTION_GRAPH_FREGS
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
>   	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index 82da7c7a1d12..6ffc9c9cf4e3 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -50,6 +50,21 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>   		asm volatile("mfmsr %0" : "=r" ((_regs)->msr));	\
>   	} while (0)
>   
> +#undef ftrace_regs_get_return_value
> +static __always_inline unsigned long
> +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> +{
> +	return arch_ftrace_regs(fregs)->regs.gpr[3];
> +}
> +#define ftrace_regs_get_return_value ftrace_regs_get_return_value
> +
> +#undef ftrace_regs_get_frame_pointer
> +static __always_inline unsigned long
> +ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> +{
> +	return arch_ftrace_regs(fregs)->regs.gpr[1];
> +}
> +
>   static __always_inline void
>   ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>   				    unsigned long ip)
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 3565c67fc638..3da14d8271d9 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -409,23 +409,31 @@ EXPORT_SYMBOL(_mcount)
>   _GLOBAL(return_to_handler)
>   	/* need to save return values */
>   #ifdef CONFIG_PPC64
> -	std	r4,  -32(r1)
> -	std	r3,  -24(r1)
> +	stdu	r1, -SWITCH_FRAME_SIZE(r1)
> +	std	r4, GPR4(r1)
> +	std	r3, GPR3(r1)
> +	/* Save previous stack pointer (r1) */
> +	addi	r3, r1, SWITCH_FRAME_SIZE
> +	std	r3, GPR1(r1)
>   	/* save TOC */
> -	std	r2,  -16(r1)
> -	std	r31, -8(r1)
> +	std	r2, 24(r1)
> +	std	r31, 32(r1)
>   	mr	r31, r1
> -	stdu	r1, -112(r1)
> -
> +	/* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
> +	addi	r3, r1, STACK_INT_FRAME_REGS
>   	/*
>   	 * We might be called from a module.
>   	 * Switch to our TOC to run inside the core kernel.
>   	 */
>   	LOAD_PACA_TOC()
>   #else
> -	stwu	r1, -16(r1)
> -	stw	r3, 8(r1)
> -	stw	r4, 12(r1)
> +	stwu	r1, -SWITCH_FRAME_SIZE(r1)
> +	stw	r4, GPR4(r1)
> +	stw	r3, GPR3(r1)
> +	addi	r3, r1, SWITCH_FRAME_SIZE
> +	stw	r3, GPR1(r1)
> +	/* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
> +	addi	r3, r1, STACK_INT_FRAME_REGS
>   #endif
> 
>   
>   	bl	ftrace_return_to_handler
> @@ -435,15 +443,15 @@ _GLOBAL(return_to_handler)
>   	mtlr	r3
>   
>   #ifdef CONFIG_PPC64
> -	ld	r1, 0(r1)
> -	ld	r4,  -32(r1)
> -	ld	r3,  -24(r1)
> -	ld	r2,  -16(r1)
> -	ld	r31, -8(r1)
> +	ld	r4,  GPR4(r1)
> +	ld	r3,  GPR3(r1)
> +	ld	r2,  24(r1)
> +	ld	r31, 32(r1)
> +	ld	r1,  0(r1)
>   #else
> -	lwz	r3, 8(r1)
> -	lwz	r4, 12(r1)
> -	addi	r1, r1, 16
> +	lwz	r3, GPR3(r1)
> +	lwz	r4, GPR4(r1)
> +	addi	r1, r1, SWITCH_FRAME_SIZE
>   #endif
>   
>   	/* Jump back to real return address */

