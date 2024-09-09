Received: from 189.cn (ptr.189.cn [183.61.185.101])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9442374C;
	Mon,  9 Sep 2024 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847391; cv=none; b=mCwODi9KMJC1u4flWzpgfAIOMrqtPSO+wFxO7LXcFLtC+shQ2Cj78i4U2LsbzzK2cdL4KS6pTfSNYhXs/E2smF5x0ecXxfhHSRs8V+MP6NIaB3XFeCKXSGa+l8HozMoIRjSweChxyrP1ge+akzxCkvoiyDXx9h8fvCY7zerEZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847391; c=relaxed/simple;
	bh=NeTm5k9daSHqM3VfbZAbrvocaD2lCXFY0Ly2p0NqWfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7RU3ogN3bobMiAQSss4oE/jd9vUVDHPUFp+uZCL/2R6Dr438+aMgf2mY6MEBLl1HkGODy7lDvBxYtxCU1chEPYya8iSKIS56e3T00Jt3R3hGNKIQ0ULzWz3DOJ/pRRp4QDrDNUcXd6avmEjNBmdARrjnhjsRNtCfAx/mdbaJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:45078.1798752469
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-123.150.8.42 (unknown [10.158.242.145])
	by 189.cn (HERMES) with SMTP id DA5031001F4;
	Mon,  9 Sep 2024 09:58:03 +0800 (CST)
Received: from  ([123.150.8.42])
	by gateway-153622-dep-68cfdf7599-zbmfg with ESMTP id d3a7be86d7504ebbb85cd3adc1c08cc1 for dolinux.peng@gmail.com;
	Mon, 09 Sep 2024 09:58:03 CST
X-Transaction-ID: d3a7be86d7504ebbb85cd3adc1c08cc1
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <821313a0-1183-472e-98a2-10c1dcdb269b@189.cn>
Date: Mon, 9 Sep 2024 09:58:02 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240908142544.1409032-1-dolinux.peng@gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20240908142544.1409032-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

it's a practical improvement for me, save time to read code. btw, how is 
the overhead?

/Song

在 2024/9/8 22:25, Donglin Peng 写道:
> When using function_graph tracer to analyze the flow of kernel function
> execution, it is often necessary to quickly locate the exact line of code
> where the call occurs. While this may be easy at times, it can be more
> time-consuming when some functions are inlined or the flow is too long.
> 
> This feature aims to simplify the process by recording the return address
> of traced funcions and printing it when outputing trace logs.
> 
> To distinguish the return value, 'V=' is used as the prefix for the kernel
> return value, and 'A=' is used as the prefix for the return address in trace
> logs. A new trace option named 'funcgraph-retaddr' has been added, and the
> option 'sym-addr' can control the format of the return address.
> 
> See below logs with both funcgraph-retval and funcgraph-retaddr enabled.
> 
> 4)               |  load_elf_binary() { /* A=bprm_execve+0x249/0x600 */
> 4)               |    load_elf_phdrs() { /* A=load_elf_binary+0x84/0x1730 */
> 4)               |      __kmalloc_noprof() { /* A=load_elf_phdrs+0x4a/0xb0 */
> 4) + 47.910 us   |        __cond_resched(); /* V=0x0 A=__kmalloc_noprof+0x28c/0x390 */
> 4) ! 204.142 us  |      } /* __kmalloc_noprof V=0xffff888201e32c00 */
> 4)               |      kernel_read() { /* A=load_elf_phdrs+0x6c/0xb0 */
> 4)               |        rw_verify_area() { /* A=kernel_read+0x2b/0x50 */
> 4)               |          security_file_permission() {
> 4)               |            selinux_file_permission() { /* A=security_file_permission+0x26/0x40 */
> 4)               |              __inode_security_revalidate() { /* A=selinux_file_permission+0x6d/0x140 */
> 4)   1.182 us    |                __cond_resched(); /* V=0x0 A=__inode_security_revalidate+0x5f/0x80 */
> 4)   4.138 us    |              } /* __inode_security_revalidate V=0x0 */
> 4)   1.513 us    |              avc_policy_seqno(); /* V=0x0 A=selinux_file_permission+0x107/0x140 */
> 4) + 12.133 us   |            } /* selinux_file_permission V=0x0 */
> 4) + 39.834 us   |          } /* security_file_permission V=0x0 */
> 4) + 42.710 us   |        } /* rw_verify_area V=0x0 */
> 
> Then, we can use the faddr2line to locate the source code, for example:
> 
> $ ./scripts/faddr2line ./vmlinux load_elf_phdrs+0x6c/0xb0
> load_elf_phdrs+0x6c/0xb0:
> elf_read at fs/binfmt_elf.c:471
> (inlined by) load_elf_phdrs at fs/binfmt_elf.c:531
> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>   include/linux/ftrace.h               |   1 +
>   kernel/trace/fgraph.c                |   1 +
>   kernel/trace/trace.h                 |   1 +
>   kernel/trace/trace_entries.h         |  19 ++++-
>   kernel/trace/trace_functions_graph.c | 105 ++++++++++++++++++---------
>   5 files changed, 92 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fd5e84d0ec47..bdf51163b3b8 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1011,6 +1011,7 @@ static inline void ftrace_init(void) { }
>    */
>   struct ftrace_graph_ent {
>   	unsigned long func; /* Current function */
> +	unsigned long retaddr;  /* Return address */
>   	int depth;
>   } __packed;
>   
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f..fcc4162c10f6 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -622,6 +622,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>   
>   	trace.func = func;
>   	trace.depth = ++current->curr_ret_depth;
> +	trace.retaddr = ret;
>   
>   	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
>   	if (offset < 0)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd3e3069300e..87e02815b030 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -870,6 +870,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>   #define TRACE_GRAPH_GRAPH_TIME          0x400
>   #define TRACE_GRAPH_PRINT_RETVAL        0x800
>   #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
> +#define TRACE_GRAPH_PRINT_RETADDR       0x2000
>   #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>   #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>   
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index c47422b20908..8b8753319dd3 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -71,6 +71,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>   	perf_ftrace_event_register
>   );
>   
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>   /* Function call entry */
>   FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>   
> @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>   	F_STRUCT(
>   		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
>   		__field_packed(	unsigned long,	graph_ent,	func		)
> +		__field_packed(	unsigned long,	graph_ent,	retaddr		)
>   		__field_packed(	int,		graph_ent,	depth		)
>   	),
>   
> @@ -86,8 +88,6 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>   );
>   
>   /* Function return entry */
> -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -
>   FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>   
>   	TRACE_GRAPH_RET,
> @@ -110,6 +110,21 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>   
>   #else
>   
> +/* Function call entry */
> +FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> +
> +	TRACE_GRAPH_ENT,
> +
> +	F_STRUCT(
> +		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> +		__field_packed(	unsigned long,	graph_ent,	func		)
> +		__field_packed(	int,		graph_ent,	depth		)
> +	),
> +
> +	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
> +);
> +
> +/* Function return entry */
>   FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>   
>   	TRACE_GRAPH_RET,
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 13d0387ac6a6..655535d57763 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -63,6 +63,8 @@ static struct tracer_opt trace_opts[] = {
>   	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
>   	/* Display function return value in hexadecimal format ? */
>   	{ TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
> +	/* Display function return address ? */
> +	{ TRACER_OPT(funcgraph-retaddr, TRACE_GRAPH_PRINT_RETADDR) },
>   #endif
>   	/* Include sleep time (scheduled out) between entry and return */
>   	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
> @@ -651,50 +653,86 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
>   #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>   
>   #define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
> +#define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
>   
> -static void print_graph_retval(struct trace_seq *s, unsigned long retval,
> -				bool leaf, void *func, bool hex_format)
> +static bool print_graph_retaddr(struct trace_seq *s, struct ftrace_graph_ent *graph_ent,
> +				u32 trace_flags, bool comment)
>   {
> -	unsigned long err_code = 0;
> +	if (unlikely(graph_ent->retaddr ==
> +		 (unsigned long)dereference_kernel_function_descriptor(return_to_handler)))
> +		return false;
>   
> -	if (retval == 0 || hex_format)
> -		goto done;
> +	if (comment)
> +		trace_seq_puts(s, " /*");
>   
> -	/* Check if the return value matches the negative format */
> -	if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> -		(((u64)retval) >> 32) == 0) {
> -		/* sign extension */
> -		err_code = (unsigned long)(s32)retval;
> -	} else {
> -		err_code = retval;
> +	trace_seq_puts(s, " A=");
> +	seq_print_ip_sym(s, graph_ent->retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
> +
> +	if (comment)
> +		trace_seq_puts(s, " */");
> +
> +	return true;
> +}
> +
> +static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent *graph_ent,
> +				struct ftrace_graph_ret *graph_ret,
> +				u32 opt_flags, u32 trace_flags)
> +{
> +	unsigned long err_code = 0;
> +	unsigned long retval = graph_ret->retval;
> +	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
> +	bool print_retaddr = !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
> +	bool print_retval = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL);
> +	void *func = (void *)graph_ret->func;
> +
> +	if (print_retval && retval && !hex_format) {
> +		/* Check if the return value matches the negative format */
> +		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> +			(((u64)retval) >> 32) == 0) {
> +			err_code = sign_extend64(retval, 31);
> +		} else {
> +			err_code = retval;
> +		}
> +
> +		if (!IS_ERR_VALUE(err_code))
> +			err_code = 0;
>   	}
>   
> -	if (!IS_ERR_VALUE(err_code))
> -		err_code = 0;
> +	if (print_retaddr && graph_ent && unlikely(graph_ent->retaddr ==
> +		 (unsigned long)dereference_kernel_function_descriptor(return_to_handler)))
> +		print_retaddr = false;
>   
> -done:
> -	if (leaf) {
> -		if (hex_format || (err_code == 0))
> -			trace_seq_printf(s, "%ps(); /* = 0x%lx */\n",
> -					func, retval);
> +	if (graph_ent) {
> +		trace_seq_printf(s, "%ps();", func);
> +		if (print_retval || print_retaddr)
> +			trace_seq_puts(s, " /*");
>   		else
> -			trace_seq_printf(s, "%ps(); /* = %ld */\n",
> -					func, err_code);
> +			trace_seq_putc(s, '\n');
>   	} else {
> +		print_retaddr = false;
> +		trace_seq_printf(s, "} /* %ps", func);
> +	}
> +
> +	if (print_retval) {
>   		if (hex_format || (err_code == 0))
> -			trace_seq_printf(s, "} /* %ps = 0x%lx */\n",
> -					func, retval);
> +			trace_seq_printf(s, " V=0x%lx", retval);
>   		else
> -			trace_seq_printf(s, "} /* %ps = %ld */\n",
> -					func, err_code);
> +			trace_seq_printf(s, " V=%ld", err_code);
>   	}
> +
> +	if (print_retaddr)
> +		print_graph_retaddr(s, graph_ent, trace_flags, false);
> +
> +	if (!graph_ent || print_retval || print_retaddr)
> +		trace_seq_puts(s, " */\n");
>   }
>   
>   #else
>   
>   #define __TRACE_GRAPH_PRINT_RETVAL 0
> +#define __TRACE_GRAPH_PRINT_RETADDR 0
>   
> -#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} while (0)
> +#define print_graph_retval(_seq, _ent, _ret, _opt_flags, _trace_flags) do {} while (0)
>   
>   #endif
>   
> @@ -746,9 +784,8 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>   	 * Write out the function return value if the option function-retval is
>   	 * enabled.
>   	 */
> -	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
> -		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
> -				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> +	if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RETADDR))
> +		print_graph_retval(s, call, graph_ret, flags, tr->trace_flags);
>   	else
>   		trace_seq_printf(s, "%ps();\n", (void *)call->func);
>   
> @@ -788,7 +825,10 @@ print_graph_entry_nested(struct trace_iterator *iter,
>   	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>   		trace_seq_putc(s, ' ');
>   
> -	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
> +	trace_seq_printf(s, "%ps() {", (void *)call->func);
> +	if (flags & __TRACE_GRAPH_PRINT_RETADDR)
> +		print_graph_retaddr(s, call, tr->trace_flags, true);
> +	trace_seq_putc(s, '\n');
>   
>   	if (trace_seq_has_overflowed(s))
>   		return TRACE_TYPE_PARTIAL_LINE;
> @@ -1032,9 +1072,8 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
>   	 * Always write out the function name and its return value if the
>   	 * function-retval option is enabled.
>   	 */
> -	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
> -		print_graph_retval(s, trace->retval, false, (void *)trace->func,
> -			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> +	if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RETADDR)) {
> +		print_graph_retval(s, NULL, trace, flags, tr->trace_flags);
>   	} else {
>   		/*
>   		 * If the return function does not have a matching entry,
