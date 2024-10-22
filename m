Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273319D06E;
	Tue, 22 Oct 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605107; cv=none; b=TAE+cnsiCNoTW2A4+8sQhwycFjuaXPNLv6Fg1ST+oFhxltboCP7J1YKmDRmYcmqfjB62sTXQ32/2H6OtPZA15iARbk1Y5/3ToN1rd+9AV0XnvWslnPOyCEH9qHKgGsZ05BB3cMljqiJkMY8eJdfXIUKzYU9hflXICObNn8dkWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605107; c=relaxed/simple;
	bh=0dYhrO3cdLqDyeSrNGp649WKMlUusxaP/x5CsNscNOo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B7n5iKDznDTE17jJ4jlmMD/R5Seytvil+cf4pMFR6CKC9z+9M4xOPytbwSXyFxD8wUYd2NKYOTOeWTCFxTrCAjrxka03S0DWWOeoABvsg4fVtsocF1Bx8ul9MhfIBD53qhXAzN0pEY2FDFsof3RBTmH8WhHkdj50UxgXuJ96oQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHsxKtoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHsxKtoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE006C4CEC3;
	Tue, 22 Oct 2024 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605107;
	bh=0dYhrO3cdLqDyeSrNGp649WKMlUusxaP/x5CsNscNOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHsxKtoBldbVxpAuloSM9i1rR9V0j9Gnv8YXifRV3dgRbQ5W3myECujSBCQrP8ZWo
	 uFNNH96MSPEysvvvDifhJYmkuMdlRtvQkOi1XmmwGz/mjG6IE7y1xuFhMhOZWC4tis
	 w0Jlyl6c7OcmQctVrev7GDE4sRziA34GV6yJd4mJFGIXTk0Ztgs4PSDdivTCko/bDL
	 UkGDi4RO23+eO93vemj7NfG7zH7XTFIiVIbUBUmANceJa2fUSYkXyDvqJStW5vTwbI
	 t1xwxbwcK4+sFTBZ2AbUSxGcZmZmAiq0u4SazBf5tcupf2n5GixZ76NZImTqszVsSX
	 bk+x8Wojf7V+g==
Date: Tue, 22 Oct 2024 22:51:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: Fix function name for trampoline
Message-Id: <20241022225143.6fb54c2c0900f523326d403f@kernel.org>
In-Reply-To: <20241021071454.34610-2-tatsuya.s2862@gmail.com>
References: <20241021071454.34610-2-tatsuya.s2862@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 07:14:53 +0000
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> The issue that unrelated function name is shown on stack trace like
> following even though it should be trampoline code address is caused by
> the creation of trampoline code in the area where .init.text section
> of module was freed after module is loaded.
> 
> bash-1344    [002] .....    43.644608: <stack trace>
> => (MODULE INIT FUNCTION)
> => vfs_write
> => ksys_write
> => do_syscall_64
> => entry_SYSCALL_64_after_hwframe
> 
> To resolve this, when function address of stack trace entry is in
> trampoline, output without looking up symbol name.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
> V3 -> V4: Change header file to define FTRACE_TRAMPOLINE_MARKER.
> 	  Rename category name of commit message.
> V2 -> V3: Instead of saving the trampoline address, marker was introduced.
> V1 -> V2: Instead of checking trampoline when displaying "trace" results,
> 	  it stores trampoline when generating the stacktrace entry.
> 
>  kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
>  kernel/trace/trace.h        |  7 +++++++
>  kernel/trace/trace_output.c |  4 ++++
>  3 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a8f52b6527ca..3d86937da610 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -988,7 +988,8 @@ static inline void trace_access_lock_init(void)
>  #endif
>  
>  #ifdef CONFIG_STACKTRACE
> -static void __ftrace_trace_stack(struct trace_buffer *buffer,
> +static void __ftrace_trace_stack(struct trace_array *tr,
> +				 struct trace_buffer *buffer,
>  				 unsigned int trace_ctx,
>  				 int skip, struct pt_regs *regs);
>  static inline void ftrace_trace_stack(struct trace_array *tr,
> @@ -997,7 +998,8 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>  				      int skip, struct pt_regs *regs);
>  
>  #else
> -static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
> +static inline void __ftrace_trace_stack(struct trace_array *tr,
> +					struct trace_buffer *buffer,
>  					unsigned int trace_ctx,
>  					int skip, struct pt_regs *regs)
>  {
> @@ -2928,7 +2930,8 @@ struct ftrace_stacks {
>  static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
>  static DEFINE_PER_CPU(int, ftrace_stack_reserve);
>  
> -static void __ftrace_trace_stack(struct trace_buffer *buffer,
> +static void __ftrace_trace_stack(struct trace_array *tr,
> +				 struct trace_buffer *buffer,
>  				 unsigned int trace_ctx,
>  				 int skip, struct pt_regs *regs)
>  {
> @@ -2975,6 +2978,20 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  		nr_entries = stack_trace_save(fstack->calls, size, skip);
>  	}
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	/* Mark entry of stack trace as trampoline code */
> +	if (tr->ops && tr->ops->trampoline) {
> +		unsigned long tramp_start = tr->ops->trampoline;
> +		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
> +		unsigned long *calls = fstack->calls;
> +
> +		for (int i = 0; i < nr_entries; i++) {
> +			if (calls[i] >= tramp_start && calls[i] < tramp_end)
> +				calls[i] = FTRACE_TRAMPOLINE_MARKER;
> +		}
> +	}
> +#endif
> +
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
>  				    struct_size(entry, caller, nr_entries),
>  				    trace_ctx);
> @@ -3005,7 +3022,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>  	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
>  		return;
>  
> -	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
>  }
>  
>  void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
> @@ -3014,7 +3031,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>  	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  
>  	if (rcu_is_watching()) {
> -		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
> +		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>  		return;
>  	}
>  
> @@ -3031,7 +3048,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>  		return;
>  
>  	ct_irq_enter_irqson();
> -	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>  	ct_irq_exit_irqson();
>  }
>  
> @@ -3048,8 +3065,8 @@ void trace_dump_stack(int skip)
>  	/* Skip 1 to skip this function. */
>  	skip++;
>  #endif
> -	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
> -			     tracing_gen_ctx(), skip, NULL);
> +	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
> +				tracing_gen_ctx(), skip, NULL);
>  }
>  EXPORT_SYMBOL_GPL(trace_dump_stack);
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index c866991b9c78..30d6675c78cf 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -2176,4 +2176,11 @@ static inline int rv_init_interface(void)
>  }
>  #endif
>  
> +/*
> + * This is used only to distinguish
> + * function address from trampoline code.
> + * So this value has no meaning.
> + */
> +#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 868f2f912f28..c14573e5a903 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1246,6 +1246,10 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>  			break;
>  
>  		trace_seq_puts(s, " => ");
> +		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
> +			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
> +			continue;
> +		}
>  		seq_print_ip_sym(s, (*p) + delta, flags);
>  		trace_seq_putc(s, '\n');
>  	}
> -- 
> 2.47.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
