Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC4198A25;
	Wed,  9 Oct 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478998; cv=none; b=lTRvpK8igGLM/vFSZ3G7SrepMwCGDnZ7tAC9Y5WjcJwqJoy1V+i2yVtPdVVSLsXY4mCzcK9bd/Pzr4R3HJiT02zkSpDLXj3dXnhN8Zzw5GPlhk5LV8IQ0zRcwQdioMW8GtBiek2XeOYT4cMWm0o0gx6MGOvtq8RvzdiFUY82UZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478998; c=relaxed/simple;
	bh=cJYQT3pUHI0vJPwt6Xk5wsgZHy+Q8X5/iiS5hUoKyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HldFbsaAhTlXgQb/PaJdk8dQ/0nPFyqQnzyWhWBiw0iJhQrYBSzh5w0KjBgcbumXEtzhUtjNhgCYAI/TOuLKt+w47NrzkJjuyjzIkU0VbDmuNwnh3bdV2Di+eoCNXLMojluYz9xV0GFvpNh3w6aZJVESvibZ2N7DhnzB71id5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXIacV4Z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXIacV4Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W4vAvWfJ3r8piE5vQC7Xpi8Qfy+6fcrJmdiJulu4Dig=; b=rXIacV4ZasTLVgie3bNrUpp4nR
	QEB9ZDFEP6lMNW1VVe7ORy/lvZQqVYcZrKnWruvjsH6IM7KbluG8AGm74fDmANJGVZEPvJBx6xcdn
	dztpoSqD7Mm+t7RTjJeyoC5e2ArRm6i1j9JC9gQvNR75GvkeBDEHApVPs9GjfIMmfvu0LbZ/KYGT6
	p0FZMcByEghwrfl1ZogJdBLp31eArNfaw9Tl4mIK5sh6ZBXLeyvahgwriMGZrJjxdATwROm3EacUU
	xdxRZuBMUpw7D28iKNhgIiPJJN40OIaOvYfyCrtdx8pQA7iTO5Wfwzuy0vXXuQRDQ0wnno8g+2gEm
	SC4C1GWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syWLM-00000004xYw-18dM;
	Wed, 09 Oct 2024 13:03:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E283730057A; Wed,  9 Oct 2024 15:03:07 +0200 (CEST)
Date: Wed, 9 Oct 2024 15:03:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] riscv: add PREEMPT_LAZY support
Message-ID: <20241009130307.GN17263@noisy.programming.kicks-ass.net>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009105709.887510-4-bigeasy@linutronix.de>

On Wed, Oct 09, 2024 at 12:50:57PM +0200, Sebastian Andrzej Siewior wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> riscv has switched to GENERIC_ENTRY, so adding PREEMPT_LAZY is as simple
> as adding TIF_NEED_RESCHED_LAZY related definitions and enabling
> ARCH_HAS_PREEMPT_LAZY.
> 
> [bigeasy: Replace old PREEMPT_AUTO bits with new PREEMPT_LAZY ]
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/riscv/Kconfig                   | 1 +
>  arch/riscv/include/asm/thread_info.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 62545946ecf43..3516c58480612 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,6 +39,7 @@ config RISCV
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>  	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>  	select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 9c10fb180f438..8b5a5ddea4293 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -107,6 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>   * - pending work-to-be-done flags are in lowest half-word
>   * - other flags in upper half-word(s)
>   */
> +#define TIF_NEED_RESCHED_LAZY	0       /* Lazy rescheduling needed */
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>  #define TIF_SIGPENDING		2	/* signal pending */
>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */

So for x86 I shuffled the flags around to have the two NEED_RESCHED ones
side-by-side. Not strictly required ofcourse, but...
