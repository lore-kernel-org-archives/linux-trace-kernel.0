Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1042022E2;
	Fri, 18 Oct 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264899; cv=none; b=QkBkmZoWs/KjCz/2Ou8hbz5dKXPJtz1axbV5m/vAkGcaOorYgHiY/tXa6BtmZ3b5CwTxO1z7ti+d0/1RawZpK+Zo9sSI0AZd/yP7XvgiI4y7DtOHj3wR6CyfSJGTOPZNUnK1WNTyhvLECdRCbueAJv2TdfQZiDKDmSkoMZkrzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264899; c=relaxed/simple;
	bh=Eo5wuFuRpaLEIgjilNUa0Gym27FY4otmWggnMJqNR/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvRDeQqNy/dKphHRaQ0zBFWKYf163x1nNiysrwg+h0Aw99tupMsas+5Sd+OjfVxIhjvWBBGuXiNrMHfKgQgQ0q9c/+ETlCHguQPCPjD4hc1fF9tZDyas6NVFQjsAtMJHSvkLAX8b3hqSS7FgqHZJJvGcYvX1MMP5FBVh4SJJprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3386C4CEC5;
	Fri, 18 Oct 2024 15:21:37 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:22:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Fix function name for trampoline
Message-ID: <20241018112203.75307abe@gandalf.local.home>
In-Reply-To: <20241012124152.2078-1-tatsuya.s2862@gmail.com>
References: <20241012124152.2078-1-tatsuya.s2862@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 21:41:51 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> The issue that unrelated function name is shown on stack trace like
> following even though it should be trampoline code address is caused by
> the creation of trampoline code in the area where .init.text section
> of module was freed after module is loaded.
> 
> bash-1344    [002] .....    43.644608: <stack trace>
>   => (MODULE INIT FUNCTION)
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe  
> 
> To resolve this, when function address of stack trace entry is in
> trampoline, output without looking up symbol name.
> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
> V1 -> V2: Instead of checking trampoline when displaying "trace" results,
> 	  it stores trampoline when generating the stacktrace entry.

I'm sorry. I guess I wasn't clear. I meant to do the tests in the recording
of the trampoline, and do not add them or replace them. I rather not add
this meta data to the ring buffer.

> 
>  kernel/trace/trace.c         | 24 ++++++++++++++++--------
>  kernel/trace/trace_entries.h |  2 ++
>  kernel/trace/trace_output.c  |  7 +++++++
>  3 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c69ca1f1088..92a8e76a0cd7 100644
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
> @@ -2986,6 +2989,11 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	memcpy(&entry->caller, fstack->calls,
>  	       flex_array_size(entry, caller, nr_entries));
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	entry->trampoline = tr->ops ? tr->ops->trampoline : 0;
> +	entry->trampoline_size = tr->ops ? tr->ops->trampoline_size : 0;
> +#endif
> +
>  	if (!call_filter_check_discard(call, entry, buffer, event))
>  		__buffer_unlock_commit(buffer, event);
>  

I meant here we can add something like:

/* Make the marker not exactly -1, but max int to be something somewhat unique */
#define FTRACE_TRAMPOLINE_MARKER	((unsigned long)MAX_INT)


	if (regs) {
		nr_entries = stack_trace_save_regs(regs, fstack->calls,
						   size, skip);
	} else {
		nr_entries = stack_trace_save(fstack->calls, size, skip);
	}

+	if (tr->ops && tr->ops->trampoline) {
+		unsigned long tramp_start = tr->ops->trampoline;
+		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
+		unsigned long *calls = fstack->calls;
+
+		/* Mark any trampolines */
+		for (int i = 0; i < nr_entries; i++) {
+			if (calls[i] >= tramp_start && calls[i] < tramp_end) {
+				calls[i] = FTRACE_TRAMPOLINE_MARKER;
+		}
+	}
+
	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
				    struct_size(entry, caller, nr_entries),
				    trace_ctx);
	if (!event)
		goto out;
	entry = ring_buffer_event_data(event);

	entry->size = nr_entries;
	memcpy(&entry->caller, fstack->calls,
	       flex_array_size(entry, caller, nr_entries));


> @@ -3005,7 +3013,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>  	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
>  		return;
>  
> -	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
>  }
>  
>  void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
> @@ -3014,7 +3022,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>  	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  
>  	if (rcu_is_watching()) {
> -		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
> +		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>  		return;
>  	}
>  
> @@ -3031,7 +3039,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>  		return;
>  
>  	ct_irq_enter_irqson();
> -	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>  	ct_irq_exit_irqson();
>  }
>  
> @@ -3048,8 +3056,8 @@ void trace_dump_stack(int skip)
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
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index c47422b20908..81b84241e3b3 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -190,6 +190,8 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
>  
>  	F_STRUCT(
>  		__field(	int,		size	)
> +		__field(	unsigned long,	trampoline	)
> +		__field(	unsigned long,	trampoline_size	)
>  		__stack_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES, size)
>  	),
>  
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 868f2f912f28..fbd066e9c9fa 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1246,6 +1246,13 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>  			break;
>  
>  		trace_seq_puts(s, " => ");
> +		if (field->trampoline && field->trampoline_size &&
> +			(*p) + delta >= field->trampoline &&
> +			(*p) + delta < field->trampoline + field->trampoline_size) {

Then the above can simply be:

		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
			continue;
		}

since the value is useless anyway.

-- Steve


> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);
> +			trace_seq_puts(s, " [FTRACE TRAMPOLINE]\n");
> +			continue;
> +		}
>  		seq_print_ip_sym(s, (*p) + delta, flags);
>  		trace_seq_putc(s, '\n');
>  	}

