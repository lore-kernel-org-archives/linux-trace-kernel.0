Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB603218CD;
	Tue, 23 Sep 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624326; cv=none; b=ByHv0JjDXzRY8aA3ZQ8mFPZIM13IJydiQ8sXta/yOiVXNz+1ohGhlFvG6CazMMx7ZUUYYSH9jl+T0e+BEC1oQ6zgZZgdAvYxupgOzbFcFui4MDQHI9G+KoleDZxDhoQB4AVw3DTwF/1PHs+1+hENc5hbLaAj0acWZ8DhFPOg4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624326; c=relaxed/simple;
	bh=JjX2ynu/W6OBq8ZyqQlyX1+0pijP/ECiYAl8aLM+jKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIE3eM6ehiP8QUJm/KNES+kj303cdpqRSyI1QAKdSnRW3CVnUbONJNjIHR+wJ5D6d1nZaj3XXEN4GEeTq2vDS+VgrFbgSfDglg5aU3Csc6K/7mfAxlnca3wtWiy5E5/+cBKPlxZEwhCVuFWJmiv0uhb+kgHoEEXFMRfd0Dc6zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b/O5ExwW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/O5ExwW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J7dwxUkVz8VKBuMDUTrackuVoC/kTqhJZSzT12+rz3A=; b=b/O5ExwWKrrLRVTUoksRyYHchJ
	NWgCFRMR4ax0Wti9iG4tI56tXnoQXNoVu4qFiEhKLCQDA1vdltPG9oAKLbWhq9serHxcrN2F5IpxU
	tWZFsXwbqeUXOo+FXauTxQvHhY9JFUN0slBxyWU9G+jhOHhURwF/v+Mi+K1LN/Rm/j/dk14bk5xg8
	O5/iRXdLUCa0UiOCzGDJHB1mWLWhESYff4fgvTASTGdm02WdsIZBqlSs4a5sGZf+xccuIwJLk0rAu
	23jB6svvl0t87/Zp6399BKqv8WR0tq46kt5fzjP3hwlkborTOecefaMLpZSmdI1088WHPNz86pNbl
	bWlnv6FA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10WK-0000000A6ff-0pYl;
	Tue, 23 Sep 2025 10:45:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBE9630049C; Tue, 23 Sep 2025 12:45:15 +0200 (CEST)
Date: Tue, 23 Sep 2025 12:45:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 2/2] unwind deferred/x86: Do not defer stack tracing
 for compat tasks
Message-ID: <20250923104515.GF3419281@noisy.programming.kicks-ass.net>
References: <20250827193644.527334838@kernel.org>
 <20250827193828.514833400@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827193828.514833400@kernel.org>

On Wed, Aug 27, 2025 at 03:36:46PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently compat tasks are not supported. If a deferred user space stack
> trace is requested on a compat task, it should fail and return an error so
> that the profiler can use an alternative approach (whatever it uses
> today).
> 
> Add a arch_unwind_can_defer() macro that is called in
> unwind_deferred_request(). Have x86 define it to a function that makes
> sure that the current task is running in 64bit mode, and if it is not, it
> returns false. This will cause unwind_deferred_request() to error out and
> the caller can use the current method of user space stack tracing.

Changelog seems to forget mentioning *why* we can't unwind compat.

I'm sure I've seen compat FP unwind support at some point in this
series. Did that go missing somewhere?

Also, these two patches are in the wrong order, first you enable things,
including compat tasks, and then you go 'whoopsie, no compats'.

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250820190639.843442474@kernel.org
> 
> - Added #include <linux/compat.h> to use user_64bit_mode() in
>   unwind_user.h. When adding this to the ftrace code, it failed to build
>   due to the missing header.
> 
>  arch/x86/include/asm/unwind_user.h | 12 ++++++++++++
>  include/linux/unwind_deferred.h    |  5 +++++
>  kernel/unwind/deferred.c           |  3 +++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
> index 8597857bf896..0cef2e3b08c8 100644
> --- a/arch/x86/include/asm/unwind_user.h
> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -2,6 +2,18 @@
>  #ifndef _ASM_X86_UNWIND_USER_H
>  #define _ASM_X86_UNWIND_USER_H
>  
> +#ifdef CONFIG_IA32_EMULATION
> +#include <linux/compat.h>
> +/* Currently compat mode is not supported for deferred stack trace */
> +static inline bool arch_unwind_can_defer(void)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	return user_64bit_mode(regs);
> +}
> +# define arch_unwind_can_defer	arch_unwind_can_defer
> +#endif /* CONFIG_IA32_EMULATION */
> +
>  #define ARCH_INIT_USER_FP_FRAME							\
>  	.cfa_off	= (s32)sizeof(long) *  2,				\
>  	.ra_off		= (s32)sizeof(long) * -1,				\
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index 26122d00708a..0124865aaab4 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -16,6 +16,11 @@ struct unwind_work {
>  	int				bit;
>  };
>  
> +/* Architectures can add a test to not defer unwinding */
> +#ifndef arch_unwind_can_defer
> +# define arch_unwind_can_defer()	(true)
> +#endif
> +
>  #ifdef CONFIG_UNWIND_USER
>  
>  enum {
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index dc6040aae3ee..3601b2efe48d 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -237,6 +237,9 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  
>  	*cookie = 0;
>  
> +	if (!arch_unwind_can_defer())
> +		return -EINVAL;
> +
>  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
>  	    !user_mode(task_pt_regs(current)))
>  		return -EINVAL;

Should not this arch hook be after all the 'normal' early exits?
