Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830917BA9;
	Sun, 20 Oct 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729415936; cv=none; b=p8f9lNATl8a4Dm2t8+YOybyQ6cli5CeeLzLkZoo9LhV+jkJb5x2c5H9O9gIB7Ji9RLa7DjVjQrwP+z4TNChFjzOpCXLiFDJCzBZXs9OyHgp68dZdvqqNvrYEYYB1XoK0A125uy8CsFBfpZU66qTUB5tKiYDAYjeZYjhgSEUEVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729415936; c=relaxed/simple;
	bh=+KwvgRRpNYiwqi5glbPQvoGH0TmtRZj4+T5MYvWNIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+jrAZwaVuT9q0UogxxeosmYoXYyJK85PiHmuQJ9EXOMjk3ez1lQVbzncF+X65N9iG3ZcWF5JCV2o1uem6cPJ1Q9NQphit3ra+PDTHBJIpRmxg0ZaT30sVQdORZAzPZWjMZJLk0HPXtkv8DOIsmmnXv3DH+rK2t+k+jm5FlfPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C846EC4CEC6;
	Sun, 20 Oct 2024 09:18:55 +0000 (UTC)
Date: Sun, 20 Oct 2024 05:18:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Fix function name for trampoline
Message-ID: <20241020051853.637e7fc0@rorschach.local.home>
In-Reply-To: <20241019115749.9499-2-tatsuya.s2862@gmail.com>
References: <20241019115749.9499-2-tatsuya.s2862@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 11:57:48 +0000
Tatsuya S <tatsuya.s2862@gmail.com> wrote:


Thanks, this is getting close. One small fix.

Also note, the subject should be "tracing:" and not "ftrace:".
"ftrace:" is used for the function hooking mechanism (basically the
ftrace.c file). This is just the tracing infrastructure. I know it's
confusing because the tracing infrastructure uses the name "ftrace_" as
a prefix, but that's mostly due to legacy reasons when the tracing
infrastructure basically only did function tracing.


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
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
> V2 -> V3: Instead of saving the trampoline address, marker was introduced.
> V1 -> V2: Instead of checking trampoline when displaying "trace" results,
> 	  it stores trampoline when generating the stacktrace entry.
> 
>  include/linux/ftrace.h      |  7 +++++++
>  kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
>  kernel/trace/trace_output.c |  4 ++++
>  3 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fd5e84d0ec47..39a32fd7b116 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1188,4 +1188,11 @@ unsigned long arch_syscall_addr(int nr);
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> +/*
> + * This is used only to distinguish
> + * function address from trampoline code.
> + * So this value has no meaning.
> + */
> +#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)

This doesn't need to be in include/linux, please move this to
kernel/trace/trace.h.

Thanks,

-- Steve


> +
>  #endif /* _LINUX_FTRACE_H */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c69ca1f1088..60d156c34e43 100644
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

