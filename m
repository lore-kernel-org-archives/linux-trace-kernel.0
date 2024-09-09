Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0C1C286;
	Mon,  9 Sep 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894258; cv=none; b=sVVUzZ+62dBulOxFxEJJ1NVVsIfVN8cC3zJUMvE6KEMjfg6KSxu0FK3/L0JQi0MzuU8jb2yNG8TnFQHsUJtzm0HMZi0T5nWLnY3TL7YeFHZfq5PcKKaUoCKFrrtHusUK+9yAbacqFSDAePJjsr5KykJ17+t6pGspe4Jo71vlPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894258; c=relaxed/simple;
	bh=ltl+e7qvQSFa6Ln9RRzbpSDQC/9PCYBgd6N5egTzrK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJcTfBfw3pi8UOvXj3NQFx1EuQCKOAvTYDHD83hKm6HRSYxtpUCRYFTREzMkn21ViB0QuO+iGF5DFd0euia1wL2D8j1O15AT8l9z0OcREdVM3kWn+qW7vkL3Lp1KonK9HXrphQdS9mCfa6r9RvVNg+eSxuT8BqNzbOPhd9UHuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4A6C4CEC5;
	Mon,  9 Sep 2024 15:04:17 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:04:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
Message-ID: <20240909110415.33cb5f22@gandalf.local.home>
In-Reply-To: <20240908142544.1409032-1-dolinux.peng@gmail.com>
References: <20240908142544.1409032-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Sep 2024 07:25:44 -0700
Donglin Peng <dolinux.peng@gmail.com> wrote:

Hi Donglin!

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

I wonder if we should make this look more like the function tracer when it
shows the parent. That is:

  4)               |  load_elf_binary() { /* <-bprm_execve+0x249/0x600 */

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
>  include/linux/ftrace.h               |   1 +
>  kernel/trace/fgraph.c                |   1 +
>  kernel/trace/trace.h                 |   1 +
>  kernel/trace/trace_entries.h         |  19 ++++-
>  kernel/trace/trace_functions_graph.c | 105 ++++++++++++++++++---------
>  5 files changed, 92 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fd5e84d0ec47..bdf51163b3b8 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1011,6 +1011,7 @@ static inline void ftrace_init(void) { }
>   */
>  struct ftrace_graph_ent {
>  	unsigned long func; /* Current function */
> +	unsigned long retaddr;  /* Return address */
>  	int depth;
>  } __packed;
>  
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f..fcc4162c10f6 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -622,6 +622,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
> +	trace.retaddr = ret;
>  
>  	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
>  	if (offset < 0)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd3e3069300e..87e02815b030 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -870,6 +870,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>  #define TRACE_GRAPH_GRAPH_TIME          0x400
>  #define TRACE_GRAPH_PRINT_RETVAL        0x800
>  #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
> +#define TRACE_GRAPH_PRINT_RETADDR       0x2000
>  #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>  #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index c47422b20908..8b8753319dd3 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -71,6 +71,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>  	perf_ftrace_event_register
>  );
>  
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  /* Function call entry */
>  FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>  
> @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>  	F_STRUCT(
>  		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
>  		__field_packed(	unsigned long,	graph_ent,	func		)
> +		__field_packed(	unsigned long,	graph_ent,	retaddr		)
>  		__field_packed(	int,		graph_ent,	depth		)
>  	),
>  

Let's make this a new event, so that when this option is not enabled, we
don't waste the ring buffer. For function tracing, every element added to
the event will add megabytes extra to the ring buffer.

It should be possible to switch what event gets created at the time of the
trace. Even calling different functions to do it.

Thanks,

-- Steve


> @@ -86,8 +88,6 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>  );
>  
>  /* Function return entry */
> -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -
>  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  	TRACE_GRAPH_RET,
> @@ -110,6 +110,21 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  #else
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
>  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  	TRACE_GRAPH_RET,
