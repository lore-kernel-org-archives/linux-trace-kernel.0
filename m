Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934344606C;
	Fri, 31 Jul 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514538; cv=none; b=cAInZvTOQRGKvlvXge96Ibd1kz5p5qMLqp7vxGNS4+dFVuhUux8TdsPrLvXVPkwloI465SCiRbTFabG/MByD15lZmN6VH7R6kbqn86RbHkOLjq+OzuDhIZxdhMzct5ml+f14nE/DejR7ZZwfOd9XIfmolVXvH23nEgzl9H4jMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514538; c=relaxed/simple;
	bh=EC4Qldz0I8//eu8X9qUqICG1s0ODDvI3gx2a299M5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEkdGWQHZGfvC5/MQp14CHHkl3dwr/vQdTr0h3wus82Vos8c1Ai64xXvknkAdExpx06s8ZWIlEIbhr6mfmU6VJUnGP1j2qXNlSI06sWW3DJhGXpUlvrEYg9iKheqjF+oJg2hXbwMRua5mCJsrSZ6iJD9apQeWVkGJm6vJSJvBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D5ysb3m8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D5ysb3m8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC70204C;
	Fri, 31 Jul 2026 09:15:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419BA3F86F;
	Fri, 31 Jul 2026 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785514531; bh=EC4Qldz0I8//eu8X9qUqICG1s0ODDvI3gx2a299M5Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5ysb3m8w0oV0jAuBPN2EE+x7/QiB3HmzsLsl9Of48PCq8y3Avccb+Y8RjUcWjGAw
	 rOgeZKxweIvJrVq0r88o419dcChgko7LZGWsupv8c7SKqE0dJYqqxK/kbRxbJNaEn6
	 KdEEXCxRq4MU5tuCGf1pHIl25TaKJf1Xf9FZlbJ8=
Date: Fri, 31 Jul 2026 17:15:25 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Message-ID: <amzKHV5fBeRFhwlJ@J2N7QTR9R3>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
 <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>

On Mon, Jul 27, 2026 at 12:25:48PM +0000, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> Static inline should be enough to actually inline functions for most
> compilers, but my Clang-19 somehow thinks it's better to outline them.
> These tiny helpers then live in normal .text sections instead of
> .noinstr sections, violating noinstr.
> 
> Mark them __always_inline so the compiler can never outline them.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/include/asm/esr.h       | 2 +-
>  arch/arm64/include/asm/percpu.h    | 2 +-
>  arch/arm64/include/asm/preempt.h   | 4 ++--
>  arch/arm64/include/asm/ptrace.h    | 4 ++--
>  arch/arm64/kernel/debug-monitors.c | 2 +-
>  include/linux/kprobes.h            | 8 ++++----
>  6 files changed, 11 insertions(+), 11 deletions(-)

I think this should be split into separate patches. In particular, the
preempt count helpers are used in mane other places than debug
exceptions, and if those are used in noinstr code today, we need to
backport those as fixes.

Mark.

> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index f816f5d77f1a..a75bfdb7e5fe 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -437,7 +437,7 @@
>  #ifndef __ASSEMBLER__
>  #include <asm/types.h>
>  
> -static inline unsigned long esr_brk_comment(unsigned long esr)
> +static __always_inline unsigned long esr_brk_comment(unsigned long esr)
>  {
>  	return esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
>  }
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index b57b2bb00967..d4cae47fde8c 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -29,7 +29,7 @@ static inline unsigned long __hyp_my_cpu_offset(void)
>  	return read_sysreg(tpidr_el2);
>  }
>  
> -static inline unsigned long __kern_my_cpu_offset(void)
> +static __always_inline unsigned long __kern_my_cpu_offset(void)
>  {
>  	unsigned long off;
>  
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 932ea4b62042..326f221c3f56 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)
>  	return !current_thread_info()->preempt.need_resched;
>  }
>  
> -static inline void __preempt_count_add(int val)
> +static __always_inline void __preempt_count_add(int val)
>  {
>  	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
>  	pc += val;
>  	WRITE_ONCE(current_thread_info()->preempt.count, pc);
>  }
>  
> -static inline void __preempt_count_sub(int val)
> +static __always_inline void __preempt_count_sub(int val)
>  {
>  	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
>  	pc -= val;
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 39582511ad72..460726224299 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -336,11 +336,11 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
>  struct task_struct;
>  int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
>  
> -static inline unsigned long instruction_pointer(struct pt_regs *regs)
> +static __always_inline unsigned long instruction_pointer(struct pt_regs *regs)
>  {
>  	return regs->pc;
>  }
> -static inline void instruction_pointer_set(struct pt_regs *regs,
> +static __always_inline void instruction_pointer_set(struct pt_regs *regs,
>  		unsigned long val)
>  {
>  	regs->pc = val;
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index a970ab6327cd..66cb8151f5df 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -146,7 +146,7 @@ postcore_initcall(debug_monitors_init);
>  /*
>   * Single step API and exception handling.
>   */
> -static void set_user_regs_spsr_ss(struct user_pt_regs *regs)
> +static __always_inline void set_user_regs_spsr_ss(struct user_pt_regs *regs)
>  {
>  	regs->pstate |= DBG_SPSR_SS;
>  }
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c4f3bb24429..5880445ed0f0 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -384,17 +384,17 @@ static inline void kprobe_ftrace_kill(void) {}
>  struct kprobe *get_kprobe(void *addr);
>  
>  /* kprobe_running() will just return the current_kprobe on this CPU */
> -static inline struct kprobe *kprobe_running(void)
> +static __always_inline struct kprobe *kprobe_running(void)
>  {
>  	return __this_cpu_read(current_kprobe);
>  }
>  
> -static inline void reset_current_kprobe(void)
> +static __always_inline void reset_current_kprobe(void)
>  {
>  	__this_cpu_write(current_kprobe, NULL);
>  }
>  
> -static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
> +static __always_inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
>  {
>  	return this_cpu_ptr(&kprobe_ctlblk);
>  }
> @@ -449,7 +449,7 @@ static inline struct kprobe *get_kprobe(void *addr)
>  {
>  	return NULL;
>  }
> -static inline struct kprobe *kprobe_running(void)
> +static __always_inline struct kprobe *kprobe_running(void)
>  {
>  	return NULL;
>  }
> -- 
> 2.47.3
> 
