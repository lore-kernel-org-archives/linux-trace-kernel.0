Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F147A41;
	Fri,  6 Sep 2024 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594557; cv=none; b=ulE4vvNHcFBO3tLZMN0MacAQJW/gvw7DqFdIsX3CZCPmhoPPgAoJ8aGcIPFPOZjChVCZiEOzxugxzD6Jr8ekcq3+nACQMa3+hZ49i0RJ9cG2eqcmJwrvDtYmqrMYL8NjtWCKKlKiUzeqX+/bk1qPlw4p61OedBPLI3AFp+cpU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594557; c=relaxed/simple;
	bh=sMTYgMxIa65uRurbvgNTVuyGdvf2aXHD/6I22Pc64BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkxNg6SSZczv619XFwgmLZMbz+tlXk9KzbG/a0A0ze871bWopIMZX3WHgd6YEAZFSwxyzjXaKIyamjCegl9gRjuhSvH/MXy01aHMOUCfKYjvxNuio5CQS0zS5GOpCbDwk3euow/v73FlmRSRVKQ/MOBWTSlCeUm4Y5qQhdkGtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0MfJ21x4z4f3jdL;
	Fri,  6 Sep 2024 11:48:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60E291A058E;
	Fri,  6 Sep 2024 11:49:11 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgCHusa2e9pmHuwaAg--.1207S3;
	Fri, 06 Sep 2024 11:49:11 +0800 (CST)
Message-ID: <dcac0917-0cb8-c0d1-e5bb-0144c38a65f3@huaweicloud.com>
Date: Fri, 6 Sep 2024 11:49:10 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 7/7] tracing: add arguments to function tracer
Content-Language: en-US
To: Sven Schnelle <svens@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240904065908.1009086-1-svens@linux.ibm.com>
 <20240904065908.1009086-8-svens@linux.ibm.com>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240904065908.1009086-8-svens@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHusa2e9pmHuwaAg--.1207S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CFW5KF47WF4kGw1xWF43trb_yoWkXFy7p3
	WxtF4DGr4UJF4qka4xuan5CFyfJ3yrJFW7KFs7t34rZr4DJr1aqFnFqasFqw15t3yDArya
	va4jvw4DKr45Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/9/4 14:59, Sven Schnelle wrote:
> Wire up the code to print function arguments in the function tracer.
> This functionality can be enabled/disabled during compile time by
> setting CONFIG_FUNCTION_TRACE_ARGS and during runtime with
> options/func-args.
> 
>          ping-689     [004] b....    77.170220: dummy_xmit(skb = 0x82904800, dev = 0x882d0000) <-dev_hard_start_xmit
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   kernel/trace/trace.c              |  8 +++++-
>   kernel/trace/trace.h              |  4 ++-
>   kernel/trace/trace_entries.h      |  7 +++--
>   kernel/trace/trace_functions.c    | 46 +++++++++++++++++++++++++++----
>   kernel/trace/trace_irqsoff.c      |  4 +--
>   kernel/trace/trace_output.c       | 14 ++++++++--
>   kernel/trace/trace_sched_wakeup.c |  4 +--
>   7 files changed, 71 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebe7ce2f5f4a..8118e4c8c649 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2864,7 +2864,7 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
>   
>   void
>   trace_function(struct trace_array *tr, unsigned long ip, unsigned long
> -	       parent_ip, unsigned int trace_ctx)
> +	       parent_ip, unsigned int trace_ctx, struct ftrace_regs *regs)
>   {
>   	struct trace_event_call *call = &event_function;
>   	struct trace_buffer *buffer = tr->array_buffer.buffer;
> @@ -2878,6 +2878,12 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
>   	entry	= ring_buffer_event_data(event);
>   	entry->ip			= ip;
>   	entry->parent_ip		= parent_ip;
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +	if (regs)
> +		entry->regs		= *regs;
> +	else
> +		memset(&entry->regs, 0, sizeof(struct ftrace_regs));
> +#endif
>   
>   	if (!call_filter_check_discard(call, entry, buffer, event)) {
>   		if (static_branch_unlikely(&trace_function_exports_enabled))
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd3e3069300e..13cf6f97f7e0 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -673,7 +673,8 @@ unsigned long trace_total_entries(struct trace_array *tr);
>   void trace_function(struct trace_array *tr,
>   		    unsigned long ip,
>   		    unsigned long parent_ip,
> -		    unsigned int trace_ctx);
> +		    unsigned int trace_ctx,
> +		    struct ftrace_regs *regs);
>   void trace_graph_function(struct trace_array *tr,
>   		    unsigned long ip,
>   		    unsigned long parent_ip,
> @@ -870,6 +871,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>   #define TRACE_GRAPH_GRAPH_TIME          0x400
>   #define TRACE_GRAPH_PRINT_RETVAL        0x800
>   #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
> +#define TRACE_GRAPH_ARGS		0x2000
>   #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>   #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>   
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index c47422b20908..f2021ab52da2 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -61,8 +61,11 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>   	TRACE_FN,
>   
>   	F_STRUCT(
> -		__field_fn(	unsigned long,	ip		)
> -		__field_fn(	unsigned long,	parent_ip	)
> +		__field_fn(	unsigned long,		ip		)
> +		__field_fn(	unsigned long,		parent_ip	)
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +		__field_struct( struct ftrace_regs,	regs		)

Only function arguments are printed, they are several registers in ftrace_regs,
would it be better to store what are needed?
Although different archs save function arguments in different registers, store
the entire ftrace_regs are much more simple..

> +#endif
>   	),
>   
>   	F_printk(" %ps <-- %ps",

F_printk should also match F_STRUCT, otherwise 'format' info may be incorrect,
it may confuse data parsing in user tools.

> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..7ff651a0b45a 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -25,6 +25,9 @@ static void
>   function_trace_call(unsigned long ip, unsigned long parent_ip,
>   		    struct ftrace_ops *op, struct ftrace_regs *fregs);
>   static void
> +function_args_trace_call(unsigned long ip, unsigned long parent_ip,
> +			 struct ftrace_ops *op, struct ftrace_regs *fregs);
> +static void
>   function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>   			  struct ftrace_ops *op, struct ftrace_regs *fregs);
>   static void
> @@ -42,9 +45,10 @@ enum {
>   	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
>   	TRACE_FUNC_OPT_STACK		= 0x1,
>   	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
> +	TRACE_FUNC_OPT_ARGS		= 0x4,
>   
>   	/* Update this to next highest bit. */
> -	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
> +	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8
>   };
>   
>   #define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
> @@ -114,6 +118,8 @@ static ftrace_func_t select_trace_function(u32 flags_val)
>   	switch (flags_val & TRACE_FUNC_OPT_MASK) {
>   	case TRACE_FUNC_NO_OPTS:
>   		return function_trace_call;
> +	case TRACE_FUNC_OPT_ARGS:
> +		return function_args_trace_call;
>   	case TRACE_FUNC_OPT_STACK:
>   		return function_stack_trace_call;
>   	case TRACE_FUNC_OPT_NO_REPEATS:
> @@ -198,7 +204,34 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>   	cpu = smp_processor_id();
>   	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>   	if (!atomic_read(&data->disabled))
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
> +
> +	ftrace_test_recursion_unlock(bit);
> +}
> +
> +static void
> +function_args_trace_call(unsigned long ip, unsigned long parent_ip,
> +			 struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct trace_array *tr = op->private;
> +	struct trace_array_cpu *data;
> +	unsigned int trace_ctx;
> +	int bit;
> +	int cpu;
> +
> +	if (unlikely(!tr->function_enabled))
> +		return;
> +
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +
> +	trace_ctx = tracing_gen_ctx();
> +
> +	cpu = smp_processor_id();
> +	data = per_cpu_ptr(tr->array_buffer.data, cpu);
> +	if (!atomic_read(&data->disabled))
> +		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>   
>   	ftrace_test_recursion_unlock(bit);
>   }
> @@ -247,7 +280,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>   
>   	if (likely(disabled == 1)) {
>   		trace_ctx = tracing_gen_ctx_flags(flags);
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>   #ifdef CONFIG_UNWINDER_FRAME_POINTER
>   		if (ftrace_pids_enabled(op))
>   			skip++;
> @@ -329,7 +362,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>   	trace_ctx = tracing_gen_ctx_flags(flags);
>   	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
>   
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>   
>   out:
>   	ftrace_test_recursion_unlock(bit);
> @@ -368,7 +401,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>   		trace_ctx = tracing_gen_ctx_flags(flags);
>   		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
>   
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>   		__trace_stack(tr, trace_ctx, STACK_SKIP);
>   	}
>   
> @@ -382,6 +415,9 @@ static struct tracer_opt func_opts[] = {
>   	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
>   #endif
>   	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +	{ TRACER_OPT(func-args, TRACE_FUNC_OPT_ARGS) },
> +#endif
>   	{ } /* Always set a last empty entry */
>   };
>   
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index fce064e20570..096002c99d70 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -150,7 +150,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
>   
>   	trace_ctx = tracing_gen_ctx_flags(flags);
>   
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>   
>   	atomic_dec(&data->disabled);
>   }
> @@ -278,7 +278,7 @@ __trace_function(struct trace_array *tr,
>   	if (is_graph(tr))
>   		trace_graph_function(tr, ip, parent_ip, trace_ctx);
>   	else
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>   }
>   
>   #else
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 70405c4cceb6..8fdee7b9cdba 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1058,9 +1058,13 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
>   }
>   
>   static void print_fn_trace(struct trace_seq *s, unsigned long ip,
> -			   unsigned long parent_ip, int flags)
> +			   unsigned long parent_ip,
> +			   struct ftrace_regs *fregs,
> +			   int flags)
>   {
>   	seq_print_ip_sym(s, ip, flags);
> +	if (fregs)
> +		print_function_args(s, fregs, ip);
>   
>   	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
>   		trace_seq_puts(s, " <-");
> @@ -1074,10 +1078,14 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
>   {
>   	struct ftrace_entry *field;
>   	struct trace_seq *s = &iter->seq;
> +	struct ftrace_regs *fregs = NULL;
>   
>   	trace_assign_type(field, iter->ent);
>   
> -	print_fn_trace(s, field->ip, field->parent_ip, flags);
> +#if IS_ENABLED(CONFIG_FUNCTION_TRACE_ARGS)
> +	fregs = &field->regs;
> +#endif
> +	print_fn_trace(s, field->ip, field->parent_ip, fregs, flags);
>   	trace_seq_putc(s, '\n');
>   
>   	return trace_handle_return(s);
> @@ -1742,7 +1750,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
>   
>   	trace_assign_type(field, iter->ent);
>   
> -	print_fn_trace(s, field->ip, field->parent_ip, flags);
> +	print_fn_trace(s, field->ip, field->parent_ip, NULL, flags);
>   	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
>   	trace_print_time(s, iter,
>   			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 130ca7e7787e..39043c955761 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -224,7 +224,7 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
>   		return;
>   
>   	local_irq_save(flags);
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>   	local_irq_restore(flags);
>   
>   	atomic_dec(&data->disabled);
> @@ -309,7 +309,7 @@ __trace_function(struct trace_array *tr,
>   	if (is_graph(tr))
>   		trace_graph_function(tr, ip, parent_ip, trace_ctx);
>   	else
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>   }
>   
>   static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)

-- 
Thanks,
Zheng Yejian

