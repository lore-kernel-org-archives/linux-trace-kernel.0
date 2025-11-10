Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B8228CA9;
	Mon, 10 Nov 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807414; cv=none; b=swqDMtQdIj0zAa66o+8rAHxopbhDjfZmbhcLxa48HfGJJhjhBpbGfUpnkqm7sDTgnamgrZyG0Pq7MEAqWlsnIC5+M2jCF/gYuKvOWOIw6LA3wQUJa6F2jm7JO4Hi9RunBgv7HUSZ2N6K726v4Z/PUD3dL1U8FfUh/+EW8OK5UUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807414; c=relaxed/simple;
	bh=LUtbT91H3DhIKZrotvziImI3ANn6jNp8Cap1TntTPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXIP/+5rUKqolSYVEAlUB/my1aQ4PYvc16nM8qTAM7HrkKtG0GASxuCrLYWbU6MVp3Aga7mRIEFI8Dbkd9WuSM+Ah2Q5pVFn7pdCo8tpcj9szAynJjUVMvf+u04Mu/xJrgoh9+pRjfoMupLzOLUqBr8ngkLi2KoGgkbPHhw3gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E61FB16028D;
	Mon, 10 Nov 2025 20:43:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0BC9520025;
	Mon, 10 Nov 2025 20:43:28 +0000 (UTC)
Date: Mon, 10 Nov 2025 15:43:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Sven
 Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251110154337.774db22f@gandalf.local.home>
In-Reply-To: <20251011164156.3678012-1-dolinux.peng@gmail.com>
References: <20251011164156.3678012-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s76w5duqdwo1zq9emzr9ypq3hnomj4u4
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0BC9520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mw2KA0WgsqLCmaKAg5ow/KKINX7mTlVA=
X-HE-Tag: 1762807408-309557
X-HE-Meta: U2FsdGVkX197jsELElpyfpF1efj8sJ+wFtyerYtGdIqJEKykrRc3uWkcnhsAg/ilj9EmR/iTFWxyaEQYVOrVEt5rPCJ+Drvrog5FFofd+sJtFEks8Mek7z8cbH+3NJy7tn2R/BoRTFWqr0XQWRrkTw8W68cI3m/EvIe2wvcKeTZhlF4vFkTGWqpAzl/YXPXWATFuO4XXKRV7F+f0Jl5+fjFiM9Tfrf2ForsP9MROhyMXIJkZl6oNt4fHTgP5xMBWLN55D0+/H9qfgf7Bz1jOHauf/gPoSCBRXD+7Pb/j8HkCLCw4tZa6cBMBn+bnaFpOOLIyxjzTnNlk24oKa95AafIc3yC2D50egQDqhKNBYmAlq1OlqZurFZiTF3i6q03qr69ojIOABxe1VnNjqdOlvLhUemnTgoXnfq4waLPIgiybCmDSd5j/XAngErct1+LeKcHuObG6UueqaH1hV5E/VYbb8CS2In9F

On Sun, 12 Oct 2025 00:41:56 +0800
pengdonglin <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>

Sorry for the late reply. I finally got around to looking at this.

> 
> Currently, funcgraph-args and funcgraph-retaddr cannot be used together. This patch
> resolves the conflict by having funcgraph-retaddr reuse the implementation of
> funcgraph-args -- specifically, storing the return address in the last entry of the
> args array.
> 
> As a result, both features now coexist seamlessly and function as intended.
> 
> To verify the change, use perf to trace vfs_write with both options enabled:
> 
>  # perf_6_17 ftrace -G vfs_write --graph-opts args,retaddr
>  ......
>  0)               |  down_read(sem=0xffff8880100bea78) { /* <-n_tty_write+0xa3/0x540 */
>  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
>  0)   0.079 us    |    preempt_count_add(val=1); /* <-down_read+0x3b/0x160 */
>  0)   0.077 us    |    preempt_count_sub(val=1); /* <-down_read+0x8b/0x160 */
>  0)   0.754 us    |  }
> 
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
>  include/linux/ftrace.h               |  11 --
>  kernel/trace/trace.h                 |   7 --
>  kernel/trace/trace_entries.h         |  29 +-----
>  kernel/trace/trace_functions_graph.c | 148 +++++++++++----------------
>  kernel/trace/trace_selftest.c        |   1 -
>  5 files changed, 58 insertions(+), 138 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e9b5..88cb54d73bdb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
>  	int depth;
>  } __packed;
>  
> -/*
> - * Structure that defines an entry function trace with retaddr.
> - * It's already packed but the attribute "packed" is needed
> - * to remove extra padding at the end.
> - */
> -struct fgraph_retaddr_ent {
> -	unsigned long func; /* Current function */
> -	int depth;
> -	unsigned long retaddr;  /* Return address */
> -} __packed;

I really like the clean up, but unfortunately, this breaks user space.

We still need the retaddr event, as that is what user space expects.

That said, this could do the same thing as the func-args. That is, it can
add the function arguments after the retaddr field.

>  	TRACE_GRAPH_RET,
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index a7f4b9a47a71..b618b6a673b7 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -16,6 +16,12 @@
>  #include "trace.h"
>  #include "trace_output.h"
>  
> +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> +#define  STORE_RETADDR  1
> +#else
> +#define  STORE_RETADDR  0
> +#endif
> +
>  /* When set, irq functions will be ignored */
>  static int ftrace_graph_skip_irqs;
>  
> @@ -29,19 +35,17 @@ struct fgraph_cpu_data {
>  
>  struct fgraph_ent_args {
>  	struct ftrace_graph_ent_entry	ent;
> -	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
> -	unsigned long			args[FTRACE_REGS_MAX_ARGS];
> +	/* Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS+STORE_RETADDR) entries,
> +	 * and the last entry is used to store the retaddr
> +	 */
> +	unsigned long			args[FTRACE_REGS_MAX_ARGS + STORE_RETADDR];

I'm thinking, if it is a different event, then it can still use the same
array. But retaddr will be first, and not last.

>  };
>  
>  struct fgraph_data {
>  	struct fgraph_cpu_data __percpu *cpu_data;
>  
>  	/* Place to preserve last processed entry. */
> -	union {
> -		struct fgraph_ent_args		ent;
> -		/* TODO allow retaddr to have args */
> -		struct fgraph_retaddr_ent_entry	rent;
> -	};
> +	struct fgraph_ent_args		ent;

Where this could still be the same.

>  	struct ftrace_graph_ret_entry	ret;
>  	int				failed;
>  	int				cpu;
> @@ -127,11 +131,19 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
>  	struct ring_buffer_event *event;
>  	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct ftrace_graph_ent_entry *entry;
> +	unsigned long retaddr = 0;
>  	int size;
> +	int i = 0;
>  
>  	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
>  	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
>  
> +	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> +	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> +		retaddr = ftrace_graph_top_ret_addr(current);
> +		size += sizeof(long);
> +	}
> +
>  	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
>  	if (!event)
>  		return 0;
> @@ -141,11 +153,17 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
>  
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>  	if (fregs) {
> -		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
> +		for (; i < FTRACE_REGS_MAX_ARGS; i++)
>  			entry->args[i] = ftrace_regs_get_argument(fregs, i);
>  	}
>  #endif
>  
> +	/*
> +	 * Store retaddr to [0] if fregs is NULL, else to [FTRACE_REGS_MAX_ARGS]
> +	 */
> +	if (retaddr)
> +		entry->args[i] = retaddr;
> +

Move this up before the args.

>  	trace_buffer_unlock_commit_nostack(buffer, event);
>  
>  	return 1;
> @@ -158,38 +176,6 @@ int __trace_graph_entry(struct trace_array *tr,
>  	return __graph_entry(tr, trace, trace_ctx, NULL);
>  }
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> -int __trace_graph_retaddr_entry(struct trace_array *tr,
> -				struct ftrace_graph_ent *trace,
> -				unsigned int trace_ctx,
> -				unsigned long retaddr)
> -{
> -	struct ring_buffer_event *event;
> -	struct trace_buffer *buffer = tr->array_buffer.buffer;
> -	struct fgraph_retaddr_ent_entry *entry;
> -
> -	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_ENT,
> -					  sizeof(*entry), trace_ctx);

The reserve would need to use TRACE_GRAPH_RETADDR_ENT if retaddr is set.
But I still think you can consolidate the code.

-- Steve

> -	if (!event)
> -		return 0;
> -	entry	= ring_buffer_event_data(event);
> -	entry->graph_ent.func = trace->func;
> -	entry->graph_ent.depth = trace->depth;
> -	entry->graph_ent.retaddr = retaddr;
> -	trace_buffer_unlock_commit_nostack(buffer, event);
> -
> -	return 1;
> -}
> -#else
> -int __trace_graph_retaddr_entry(struct trace_array *tr,
> -				struct ftrace_graph_ent *trace,
> -				unsigned int trace_ctx,
> -				unsigned long retaddr)
> -{
> -	return 1;
> -}
> -#endif
> -
>  static inline int ftrace_graph_ignore_irqs(void)
>  {
>  	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
