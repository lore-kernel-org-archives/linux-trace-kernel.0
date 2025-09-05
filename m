Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614D283686;
	Fri,  5 Sep 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063273; cv=none; b=hi0A/HaewmVme6Yv6hWarZVpg0rdU2b6enqYQzj2YyKtB1kO3ynrLH0IYgzYtadC7/A0s983D9aXdwWoDy95TPELMbrKdjBjegP6qWFkzg+ld5t6oZM+VgrO4jKQthy/kdoDY152Xro486t3IasYZmpXsk+8m0LDevgLRdScWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063273; c=relaxed/simple;
	bh=BbqlXQX6NiftlnJjVrouj1jPgYZT7eGHUP9KaTmFWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU1AQL3kPXIUpKYPrhKNsYs+145bYbWjFkALK+MIFCmTCld8XRJ99FlUUqRhWKfsMKyCu+wk9GOZxTaW/lHfYJVw61Va6Hssq5Hsue3Om7GAgxuIWGoc3Yz4YcX7oozsbu1eoMb14GN9Nl6mRsDLPN/q7aoVPjdREaSUH6PHQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6B6152B;
	Fri,  5 Sep 2025 02:07:41 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4798D3F694;
	Fri,  5 Sep 2025 02:07:46 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:07:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: panfan <panfan@qti.qualcomm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, samitolvanen@google.com, song@kernel.org,
	ardb@kernel.org, dylanbhatch@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kdong@qti.qualcomm.com,
	haijianc@qti.qualcomm.com
Subject: Re: [PATCH v2] arm64: ftrace: fix unreachable PLT for ftrace_caller
 in init_module with CONFIG_DYNAMIC_FTRACE
Message-ID: <aLqoWwLvGIo_qz6h@J2N7QTR9R3>
References: <20250905032236.3220885-1-panfan@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905032236.3220885-1-panfan@qti.qualcomm.com>

On Thu, Sep 04, 2025 at 08:22:36PM -0700, panfan wrote:
> On arm64, it has been possible for a module's sections to be placed more
> than 128M away from each other since commit:
> 
>   commit 3e35d303ab7d ("arm64: module: rework module VA range selection")
> 
> Due to this, an ftrace callsite in a module's .init.text section can be
> out of branch range for the module's ftrace PLT entry (in the module's
> .text section). Any attempt to enable tracing of that callsite will
> result in a BRK being patched into the callsite, resulting in a fatal
> exception when the callsite is later executed.
> 
> Fix this by adding an additional trampoline for .init.text, which will
> be within range.
> 
> No additional trampolines are necessary due to the way a given
> module's executable sections are packed together. Any executable
> section beginning with ".init" will be placed in MOD_INIT_TEXT,
> and any other executable section, including those beginning with ".exit",
>  will be placed in MOD_TEXT.
> 
> Fixes: 3e35d303ab7d ("arm64: module: rework module VA range selection")
> 
> Signed-off-by: panfan <panfan@qti.qualcomm.com>

Thanks for respinning this! This looks good to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Catalin, Will, I assume you'll add a CC stable when picking this up.

Mark.

> ---
> v2:
>    - Add an explicit check to ensure the address is within MOD_INIT_TEXT
>      or MOD_TEXT.
>    - Simplify the commit message.
> 
> Link: https://lore.kernel.org/all/20250819063418.1263119-1-panfan@qti.qualcomm.com/   # v1
> ---
>  arch/arm64/include/asm/module.h     |  1 +
>  arch/arm64/include/asm/module.lds.h |  1 +
>  arch/arm64/kernel/ftrace.c          | 13 ++++++++++---
>  arch/arm64/kernel/module-plts.c     | 12 +++++++++++-
>  arch/arm64/kernel/module.c          | 11 +++++++++++
>  5 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 79550b22ba19..fb9b88eebeb1 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -19,6 +19,7 @@ struct mod_arch_specific {
>  
>  	/* for CONFIG_DYNAMIC_FTRACE */
>  	struct plt_entry	*ftrace_trampolines;
> +	struct plt_entry	*init_ftrace_trampolines;
>  };
>  
>  u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
> index b9ae8349e35d..fb944b46846d 100644
> --- a/arch/arm64/include/asm/module.lds.h
> +++ b/arch/arm64/include/asm/module.lds.h
> @@ -2,6 +2,7 @@ SECTIONS {
>  	.plt 0 : { BYTE(0) }
>  	.init.plt 0 : { BYTE(0) }
>  	.text.ftrace_trampoline 0 : { BYTE(0) }
> +	.init.text.ftrace_trampoline 0 : { BYTE(0) }
>  
>  #ifdef CONFIG_KASAN_SW_TAGS
>  	/*
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 5a890714ee2e..5adad37ab4fa 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -258,10 +258,17 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	return ftrace_modify_code(pc, 0, new, false);
>  }
>  
> -static struct plt_entry *get_ftrace_plt(struct module *mod)
> +static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
>  {
>  #ifdef CONFIG_MODULES
> -	struct plt_entry *plt = mod->arch.ftrace_trampolines;
> +	struct plt_entry *plt = NULL;
> +
> +	if (within_module_mem_type(addr, mod, MOD_INIT_TEXT))
> +		plt = mod->arch.init_ftrace_trampolines;
> +	else if (within_module_mem_type(addr, mod, MOD_TEXT))
> +		plt = mod->arch.ftrace_trampolines;
> +	else
> +		return NULL;
>  
>  	return &plt[FTRACE_PLT_IDX];
>  #else
> @@ -332,7 +339,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
>  	if (WARN_ON(!mod))
>  		return false;
>  
> -	plt = get_ftrace_plt(mod);
> +	plt = get_ftrace_plt(mod, pc);
>  	if (!plt) {
>  		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
>  		return false;
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index bde32979c06a..7afd370da9f4 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -283,7 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  	unsigned long core_plts = 0;
>  	unsigned long init_plts = 0;
>  	Elf64_Sym *syms = NULL;
> -	Elf_Shdr *pltsec, *tramp = NULL;
> +	Elf_Shdr *pltsec, *tramp = NULL, *init_tramp = NULL;
>  	int i;
>  
>  	/*
> @@ -298,6 +298,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  		else if (!strcmp(secstrings + sechdrs[i].sh_name,
>  				 ".text.ftrace_trampoline"))
>  			tramp = sechdrs + i;
> +		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> +				 ".init.text.ftrace_trampoline"))
> +			init_tramp = sechdrs + i;
>  		else if (sechdrs[i].sh_type == SHT_SYMTAB)
>  			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
>  	}
> @@ -363,5 +366,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
>  	}
>  
> +	if (init_tramp) {
> +		init_tramp->sh_type = SHT_NOBITS;
> +		init_tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> +		init_tramp->sh_addralign = __alignof__(struct plt_entry);
> +		init_tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
> +	}
> +
>  	return 0;
>  }
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 40148d2725ce..d6d443c4a01a 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -466,6 +466,17 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
>  	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
>  
>  	mod->arch.ftrace_trampolines = plts;
> +
> +	s = find_section(hdr, sechdrs, ".init.text.ftrace_trampoline");
> +	if (!s)
> +		return -ENOEXEC;
> +
> +	plts = (void *)s->sh_addr;
> +
> +	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
> +
> +	mod->arch.init_ftrace_trampolines = plts;
> +
>  #endif
>  	return 0;
>  }
> -- 
> 2.34.1
> 
