Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4651311B6;
	Mon,  2 Sep 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267515; cv=none; b=ZU7aX3kfdZqf2y4QRWGYdsjYquJPUgrrvF4GQE3/NxKKQav6xrMQ4cWrt3969BK2OhqryabZvNjY0f+6feacNjohR5FYMKZ15ZDYpmR5D81dOOHBLN1Q08HE9vIbLzmwAq9xIRXENdhi8EEv9p5n9SUFSAyT2dsKdEe67mhwH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267515; c=relaxed/simple;
	bh=6G0WikpuT511QB+jY7ycUkOXtA8tcBDdvEbRQRRMmPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgXmhyUOIEcraygYarcPza5p1eL+LIQXFWnBL5DkaATCdhKSHZMQrnAPXZz57Wak+GNrzwdnWmXKzRvk27OeknlSwdx9fggfRhl+woyJGyVXGeFf8tDLMEztWMxGFCPqvCtwIr6THUbCFrD6kkGJAXsU/2v7WWOOQLBRziXZsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC761063;
	Mon,  2 Sep 2024 01:58:56 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C613F73F;
	Mon,  2 Sep 2024 01:58:27 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:58:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, maz@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, anshuman.khandual@arm.com,
	ptosi@google.com, mcgrof@kernel.org, rppt@kernel.org,
	kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Replace linked list with switch statement for
 breakpoint handlers
Message-ID: <ZtV-Lkfrea56egPc@J2N7QTR9R3>
References: <20240831064141.3933745-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831064141.3933745-1-liaochang1@huawei.com>

On Sat, Aug 31, 2024 at 06:41:41AM +0000, Liao Chang wrote:
> v2->v1:
> Fix a bug of releasing spinlock in kgdb_arch_exit().
> 
> As suggested by Mark Rutland [0], this patch remove the linked list used
> for breakpoint handlers and instroduces a switch statement based on the
> immediate value.
> 
> To minimize the code duplication, a new enum break_hook_type is defined
> to encapsulate all supported breakpoint types, used as indices in switch
> statement. Macros iterate_break_hook() and __HOOK() generate a series of
> switch statements for getting/setting handlers based on the immediate
> value from ESR or the imm field of struct break_hook.
> 
> After that, All breakpint related immediate macros must now end with
> _BRK_IMM, and breakpoint related mask macros must end with _BRK_MASK.
> 
> A new user field is added to struct break_hook to separate user and
> kernel breakpint exceptions. This force the callers to be explicit about
> the exception level that they come from [1]. Currently, only the uprobe
> uses this field.
> 
> To prevent race condition during break_hook unregistration (primarily by
> KGDB), a spinlock is defined in kgdb code. While there's still a
> potential race where a CPU might be executing KGDB break_hook while
> another CPU unregister it. this issue existed even before this
> refactoring.
> 
> [0] https://lore.kernel.org/all/Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com/
> [1] https://lore.kernel.org/all/20190301132809.24653-7-will.deacon@arm.com/
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

This isn't what I meant; I want to get rid of the break_hook entirely,
and have something like early_brk64() be used consistently, e.g.

| bool __handle_el1_brk(struct pt_regs *regs, unsigned long esr)
| {
| 	u16 imm = esr_brk_comment(esr);
| 
| 	switch (imm) {
| 	case BRK_IMM_CFI_BASE ... (BRK_IMM_CFI_BASE | BRK_IMM_CFI_MASK):
| 		return brk_cfi_handler(regs, esr);
| 	case BRK_IMM_KASAN_BASE ... (BRK_IMM_KASAN_BASE | BRK_IMM_KASAN_MASK):
| 		return brk_kasan_handler(regs, esr);
| 
| 	[ ... other BRK IMMs handled here ... ]
| 
| 	default:
| 		return false;
| 	}
| }
| 
| void handle_el1_brk(struct pt_regs *regs, unsigned long esr)
| {
| 	if (__handle_el1_brk(regs, esr))
| 		return;
| 	
| 	[ ... handler failure here ... ]
| }

... with a separate path for EL0 which only needs to handle uprobes.

As I mentioned, last I looked at that it required some rework of kgdb
and some larger structural rework. I had meant that KGDB would have to
handle the hooks always being in place.

Overall that should remove code since all the register_*_hook()
functions and related bits could be deleted.

As-is, I don't think this patch is the way to go.

Mark.

> ---
>  arch/arm64/include/asm/brk-imm.h        |   6 +-
>  arch/arm64/include/asm/debug-monitors.h |   7 +-
>  arch/arm64/include/asm/esr.h            |   2 +-
>  arch/arm64/kernel/debug-monitors.c      | 110 ++++++++++++++++++------
>  arch/arm64/kernel/kgdb.c                |   6 ++
>  arch/arm64/kernel/probes/kprobes.c      |   2 +-
>  arch/arm64/kernel/probes/uprobes.c      |   3 +-
>  arch/arm64/kernel/traps.c               |   4 +-
>  8 files changed, 100 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> index beb42c62b6ac..a0c2ae4386ab 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -23,7 +23,7 @@
>   */
>  #define KPROBES_BRK_IMM			0x004
>  #define UPROBES_BRK_IMM			0x005
> -#define KPROBES_BRK_SS_IMM		0x006
> +#define KPROBES_SS_BRK_IMM		0x006
>  #define KRETPROBES_BRK_IMM		0x007
>  #define FAULT_BRK_IMM			0x100
>  #define KGDB_DYN_DBG_BRK_IMM		0x400
> @@ -36,7 +36,7 @@
>  
>  #define CFI_BRK_IMM_TARGET		GENMASK(4, 0)
>  #define CFI_BRK_IMM_TYPE		GENMASK(9, 5)
> -#define CFI_BRK_IMM_BASE		0x8000
> -#define CFI_BRK_IMM_MASK		(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
> +#define CFI_BRK_IMM			0x8000
> +#define CFI_BRK_MASK			(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
>  
>  #endif
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 13d437bcbf58..8aedb7c01f69 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -41,7 +41,7 @@
>  
>  /* kprobes BRK opcodes with ESR encoding  */
>  #define BRK64_OPCODE_KPROBES	(AARCH64_BREAK_MON | (KPROBES_BRK_IMM << 5))
> -#define BRK64_OPCODE_KPROBES_SS	(AARCH64_BREAK_MON | (KPROBES_BRK_SS_IMM << 5))
> +#define BRK64_OPCODE_KPROBES_SS	(AARCH64_BREAK_MON | (KPROBES_SS_BRK_IMM << 5))
>  /* uprobes BRK opcodes with ESR encoding  */
>  #define BRK64_OPCODE_UPROBES	(AARCH64_BREAK_MON | (UPROBES_BRK_IMM << 5))
>  
> @@ -74,15 +74,12 @@ void register_kernel_step_hook(struct step_hook *hook);
>  void unregister_kernel_step_hook(struct step_hook *hook);
>  
>  struct break_hook {
> -	struct list_head node;
>  	int (*fn)(struct pt_regs *regs, unsigned long esr);
>  	u16 imm;
>  	u16 mask; /* These bits are ignored when comparing with imm */
> +	int user; /* Breakpoint exception from userspace */
>  };
>  
> -void register_user_break_hook(struct break_hook *hook);
> -void unregister_user_break_hook(struct break_hook *hook);
> -
>  void register_kernel_break_hook(struct break_hook *hook);
>  void unregister_kernel_break_hook(struct break_hook *hook);
>  
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 56c148890daf..0fc2710a7154 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -403,7 +403,7 @@ static inline bool esr_is_data_abort(unsigned long esr)
>  static inline bool esr_is_cfi_brk(unsigned long esr)
>  {
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_BRK64 &&
> -	       (esr_brk_comment(esr) & ~CFI_BRK_IMM_MASK) == CFI_BRK_IMM_BASE;
> +	       (esr_brk_comment(esr) & ~CFI_BRK_MASK) == CFI_BRK_IMM;
>  }
>  
>  static inline bool esr_fsc_is_translation_fault(unsigned long esr)
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 024a7b245056..0b92a58682e2 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -276,47 +276,103 @@ static int single_step_handler(unsigned long unused, unsigned long esr,
>  }
>  NOKPROBE_SYMBOL(single_step_handler);
>  
> -static LIST_HEAD(user_break_hook);
> -static LIST_HEAD(kernel_break_hook);
> -
> -void register_user_break_hook(struct break_hook *hook)
> -{
> -	register_debug_hook(&hook->node, &user_break_hook);
> -}
> -
> -void unregister_user_break_hook(struct break_hook *hook)
> -{
> -	unregister_debug_hook(&hook->node);
> -}
> +enum break_hook_type {
> +	KPROBES = 0,
> +	UPROBES,
> +	KPROBES_SS,
> +	KRETPROBES,
> +	FAULT,
> +	KGDB_DYN_DBG,
> +	KGDB_COMPILED_DBG,
> +	BUG,
> +	KASAN,
> +	UBSAN,
> +	CFI,
> +	NR_BRK,
> +};
> +
> +static struct break_hook *break_hooks[NR_BRK];
> +
> +#define iterate_break_hook(imm) ({	\
> +	switch (imm) {			\
> +	__HOOK(KPROBES)			\
> +	__HOOK(UPROBES)			\
> +	__HOOK(KPROBES_SS)		\
> +	__HOOK(KRETPROBES)		\
> +	__HOOK(FAULT)			\
> +	__HOOK(KGDB_DYN_DBG)		\
> +	__HOOK(KGDB_COMPILED_DBG)	\
> +	__HOOK(BUG)			\
> +	__HOOK(KASAN)			\
> +	__HOOK(UBSAN)			\
> +	__HOOK(CFI)			\
> +	default :			\
> +		break;			\
> +	}				\
> +})
> +
> +#undef __HOOK
> +#define __HOOK(nr)		\
> +	case nr ## _BRK_IMM:	\
> +	{ return break_hooks[nr]; }
> +
> +static struct break_hook *find_break_hook(unsigned long imm)
> +{
> +	iterate_break_hook(imm);
> +	return NULL;
> +}
> +
> +#undef __HOOK
> +#define __HOOK(nr)		\
> +	case nr ## _BRK_IMM:	\
> +	{ break_hooks[nr] = hook; break; }
>  
>  void register_kernel_break_hook(struct break_hook *hook)
>  {
> -	register_debug_hook(&hook->node, &kernel_break_hook);
> +	iterate_break_hook(hook->imm);
>  }
>  
> +#undef __HOOK
> +#define __HOOK(nr)		\
> +	case nr ## _BRK_IMM:	\
> +	{ break_hooks[nr] = NULL; break; }
> +
>  void unregister_kernel_break_hook(struct break_hook *hook)
>  {
> -	unregister_debug_hook(&hook->node);
> +	iterate_break_hook(hook->imm);
>  }
>  
> +#undef __HOOK
> +#define __HOOK(nr)		\
> +	do {			\
> +		if (!hook) 	\
> +			hook = find_break_hook(imm & ~(nr ## _BRK_MASK)); \
> +	} while (0)
> +
>  static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>  {
> -	struct break_hook *hook;
> -	struct list_head *list;
> -	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
> +	unsigned long imm = esr_brk_comment(esr);
> +	struct break_hook *hook = NULL;
>  
> -	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
> +	hook = find_break_hook(imm);
> +	if (likely(hook))
> +		goto call_hook;
>  
> -	/*
> -	 * Since brk exception disables interrupt, this function is
> -	 * entirely not preemptible, and we can use rcu list safely here.
> -	 */
> -	list_for_each_entry_rcu(hook, list, node) {
> -		if ((esr_brk_comment(esr) & ~hook->mask) == hook->imm)
> -			fn = hook->fn;
> -	}
> +#ifdef CONFIG_KASAN_SW_TAGS
> +	__HOOK(KASAN);
> +#endif
> +#ifdef CONFIG_UBSAN_TRAP
> +	__HOOK(UBSAN);
> +#endif
> +#ifdef CONFIG_CFI_CLANG
> +	__HOOK(CFI);
> +#endif
> +
> +call_hook:
> +	if (hook && (user_mode(regs) == hook->user))
> +		return hook->fn(regs, esr);
>  
> -	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
> +	return DBG_HOOK_ERROR;
>  }
>  NOKPROBE_SYMBOL(call_break_hook);
>  
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 4e1f983df3d1..e491a5704e61 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -304,6 +304,8 @@ static struct notifier_block kgdb_notifier = {
>  	.priority	= -INT_MAX,
>  };
>  
> +static DEFINE_SPINLOCK(kgdb_hook_lock);
> +
>  /*
>   * kgdb_arch_init - Perform any architecture specific initialization.
>   * This function will handle the initialization of any architecture
> @@ -316,9 +318,11 @@ int kgdb_arch_init(void)
>  	if (ret != 0)
>  		return ret;
>  
> +	spin_lock(&kgdb_hook_lock);
>  	register_kernel_break_hook(&kgdb_brkpt_hook);
>  	register_kernel_break_hook(&kgdb_compiled_brkpt_hook);
>  	register_kernel_step_hook(&kgdb_step_hook);
> +	spin_unlock(&kgdb_hook_lock);
>  	return 0;
>  }
>  
> @@ -329,9 +333,11 @@ int kgdb_arch_init(void)
>   */
>  void kgdb_arch_exit(void)
>  {
> +	spin_lock(&kgdb_hook_lock);
>  	unregister_kernel_break_hook(&kgdb_brkpt_hook);
>  	unregister_kernel_break_hook(&kgdb_compiled_brkpt_hook);
>  	unregister_kernel_step_hook(&kgdb_step_hook);
> +	spin_unlock(&kgdb_hook_lock);
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 4268678d0e86..b0e28d48bb19 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -360,7 +360,7 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
>  }
>  
>  static struct break_hook kprobes_break_ss_hook = {
> -	.imm = KPROBES_BRK_SS_IMM,
> +	.imm = KPROBES_SS_BRK_IMM,
>  	.fn = kprobe_breakpoint_ss_handler,
>  };
>  
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index d49aef2657cd..24130161c62d 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -190,6 +190,7 @@ static int uprobe_single_step_handler(struct pt_regs *regs,
>  static struct break_hook uprobes_break_hook = {
>  	.imm = UPROBES_BRK_IMM,
>  	.fn = uprobe_breakpoint_handler,
> +	.user = 1,
>  };
>  
>  /* uprobe single step handler hook */
> @@ -199,7 +200,7 @@ static struct step_hook uprobes_step_hook = {
>  
>  static int __init arch_init_uprobes(void)
>  {
> -	register_user_break_hook(&uprobes_break_hook);
> +	register_kernel_break_hook(&uprobes_break_hook);
>  	register_user_step_hook(&uprobes_step_hook);
>  
>  	return 0;
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9e22683aa921..6aefb0ba41ec 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -1025,8 +1025,8 @@ static int cfi_handler(struct pt_regs *regs, unsigned long esr)
>  
>  static struct break_hook cfi_break_hook = {
>  	.fn = cfi_handler,
> -	.imm = CFI_BRK_IMM_BASE,
> -	.mask = CFI_BRK_IMM_MASK,
> +	.imm = CFI_BRK_IMM,
> +	.mask = CFI_BRK_MASK,
>  };
>  #endif /* CONFIG_CFI_CLANG */
>  
> -- 
> 2.34.1
> 
