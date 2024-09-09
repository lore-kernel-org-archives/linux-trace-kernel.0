Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BD23775;
	Mon,  9 Sep 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894810; cv=none; b=fTg+w8OYjBRVgHn7gqxQAB5pmy26kA6PugZX/0p2Wxkz7gQEXOGLngwT4kqaIH+4hP587aVFbK8gE5d8ICxCKWzn41nYYsL98h1/CU+4ZMUpK3wNBKfRpztMLXovlNF6RnD7fte46mHtjL7mSArs6cWs+HiaumJoHXgUQYWWMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894810; c=relaxed/simple;
	bh=LXNT4Z6GvggPgU1hWsYIMeaZPLiQWY/+X+IdN6qNy6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZSvn+oCcSspjYHwXoPba4kdbY0CtyLbONIvNPY47U+aL/8q4Yde4vRxSAkMl05FSGnszEyjXRwN7vEehsl2VYN0CzgBJd5BRFEBOxZMy4pqG+H6IF5NtrsPKONQC8GxNAeN6LnV1BN64Xq968fOU54NvL+hPZGfmc4iETBkWPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoUGTfvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoUGTfvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86405C4CEC5;
	Mon,  9 Sep 2024 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894809;
	bh=LXNT4Z6GvggPgU1hWsYIMeaZPLiQWY/+X+IdN6qNy6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QoUGTfvkgAR7XOTmR7zBo+YdCIo5OouyYpCHAnj5x9gpbRIllicl07wJS+g987u8N
	 +RaXyOpy7x2iueOfS7Gh7URq+41oyEcBoRZmVZA0brdbrahcv+Uqn6jVhZPdo6ZEdw
	 Nqpcc9+6CY/sGhtQYTR9SF1XNyQXFgUvnh0FPlOxxfOimsA/MUwNzzun6Pt+ZAAp8G
	 j3BtrtH46Z1TCfuvqHNXxrPvAyu8Hw7RgNA0Kpz3DgutL6P9Jmx73zfSTXpWa0z/HL
	 eeCN/LWsvksLjfy2FHHRm8tS3FolZHpzv6n/XRtQqicQxaekGYrbWX7THJhddwaM2H
	 6FNmWIGxFkF8A==
Date: Tue, 10 Sep 2024 00:13:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com
Subject: Re: [PATCH v2] ftrace: Get the true parent ip for function tracer
Message-Id: <20240910001326.87f27e6b312f1d956cf352a2@kernel.org>
In-Reply-To: <20240821233021.2785584-1-jeff.xie@linux.dev>
References: <20240821233021.2785584-1-jeff.xie@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 07:30:21 +0800
Jeff Xie <jeff.xie@linux.dev> wrote:

> Currently, when using both function tracer and function graph simultaneously,
> it is found that function tracer sometimes captures a fake parent ip(return_to_handler)
> instead of the true parent ip.
> 
> This issue is easy to reproduce. Below are my reproduction steps:
> 
> jeff-labs:~/bin # ./trace-net.sh
> 
> jeff-labs:~/bin # cat /sys/kernel/debug/tracing/instances/foo/trace | grep return_to_handler
>     trace-net.sh-405     [001] ...2.    31.859501: avc_has_perm+0x4/0x190 <-return_to_handler+0x0/0x40
>     trace-net.sh-405     [001] ...2.    31.859503: simple_setattr+0x4/0x70 <-return_to_handler+0x0/0x40
>     trace-net.sh-405     [001] ...2.    31.859503: truncate_pagecache+0x4/0x60 <-return_to_handler+0x0/0x40
>     trace-net.sh-405     [001] ...2.    31.859505: unmap_mapping_range+0x4/0x140 <-return_to_handler+0x0/0x40
>     trace-net.sh-405     [001] ...3.    31.859508: _raw_spin_unlock+0x4/0x30 <-return_to_handler+0x0/0x40
>     [...]
> 

Can you also add 

> The following is my simple trace script:
> 
> <snip>
> jeff-labs:~/bin # cat ./trace-net.sh
> TRACE_PATH="/sys/kernel/debug/tracing"
> 
> set_events() {
>         echo 1 > $1/events/net/enable
>         echo 1 > $1/events/tcp/enable
>         echo 1 > $1/events/sock/enable
>         echo 1 > $1/events/napi/enable
>         echo 1 > $1/events/fib/enable
>         echo 1 > $1/events/neigh/enable
> }
> 
> set_events ${TRACE_PATH}
> echo 1 > ${TRACE_PATH}/options/sym-offset
> echo 1 > ${TRACE_PATH}/options/funcgraph-tail
> echo 1 > ${TRACE_PATH}/options/funcgraph-proc
> echo 1 > ${TRACE_PATH}/options/funcgraph-abstime
> 
> echo 'tcp_orphan*' > ${TRACE_PATH}/set_ftrace_notrace
> echo function_graph > ${TRACE_PATH}/current_tracer
> 
> INSTANCE_FOO=${TRACE_PATH}/instances/foo
> if [ ! -e $INSTANCE_FOO ]; then
>         mkdir ${INSTANCE_FOO}
> fi
> set_events ${INSTANCE_FOO}
> echo 1 > ${INSTANCE_FOO}/options/sym-offset
> echo 'tcp_orphan*' > ${INSTANCE_FOO}/set_ftrace_notrace
> echo function > ${INSTANCE_FOO}/current_tracer
> 
> echo 1 > ${TRACE_PATH}/tracing_on
> echo 1 > ${INSTANCE_FOO}/tracing_on
> 
> echo > ${TRACE_PATH}/trace
> echo > ${INSTANCE_FOO}/trace
> </snip>
> 
> Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> ---
> v2:
> - Adding __always_inline to function_get_true_parent_ip suggested by Steve
> 
>  kernel/trace/trace_functions.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..d989e927c898 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -176,6 +176,19 @@ static void function_trace_start(struct trace_array *tr)
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  }
>  
> +static __always_inline unsigned long
> +function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
> +{
> +	unsigned long true_parent_ip;
> +	int idx = 0;
> +
> +	true_parent_ip = parent_ip;
> +	if (unlikely(parent_ip == (unsigned long)&return_to_handler))
> +		true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,
> +				(unsigned long *)fregs->regs.sp);
> +	return true_parent_ip;
> +}

Can this work without CONFIG_FUNCTION_GRAPH_TRACER? Maybe it cause a build error
because return_to_handler is not defined.

Could you check it?

Thank you,

> +
>  static void
>  function_trace_call(unsigned long ip, unsigned long parent_ip,
>  		    struct ftrace_ops *op, struct ftrace_regs *fregs)
> @@ -193,6 +206,8 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
> +
>  	trace_ctx = tracing_gen_ctx();
>  
>  	cpu = smp_processor_id();
> @@ -241,6 +256,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  	 * recursive protection is performed.
>  	 */
>  	local_irq_save(flags);
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = raw_smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	disabled = atomic_inc_return(&data->disabled);
> @@ -309,6 +325,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	if (atomic_read(&data->disabled))
> @@ -356,6 +373,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	 * recursive protection is performed.
>  	 */
>  	local_irq_save(flags);
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = raw_smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	disabled = atomic_inc_return(&data->disabled);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
