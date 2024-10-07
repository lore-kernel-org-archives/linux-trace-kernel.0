Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FD1D318A;
	Mon,  7 Oct 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303863; cv=none; b=nrVe6faq/iqId+8P2uio87wCz3ZXr/h/k+SnyZZaAyMEy44hs+fCG+7IEzLTyh2yLXWSOPIdjnLFRWNrSQLfWubfTXyxjsCiOemPU826I4NyhWHXFCu/Qc6y5caMgpdo6I25C9/G5aoau3yhZ+xgtfcvdz9QmnF1qYKDQT1Ji+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303863; c=relaxed/simple;
	bh=UU6wLBGnm1CbrpwWS2xyw4JVMQssEeBg4IEK1MEqFBA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ShYMbX8TrfaddRAd1qc73Jw943EWfs4WHO7X/YVDTAQVeUrPQDhSwHNn7ZTHkTobBIgHkgQ8MUkSBkK6ALbEmRgVZ4gj0pVUaGxpa6DBqlcxU1okrBU1htSsH/8cvdliN5LZ3num8wvM/CVGig5x1Cj5RzbRlQ/kJw/ujs+wcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAHNuIDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAHNuIDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FDC4CECF;
	Mon,  7 Oct 2024 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728303863;
	bh=UU6wLBGnm1CbrpwWS2xyw4JVMQssEeBg4IEK1MEqFBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAHNuIDZTPFabM7bIaxGgjuStXbKn94uubuHpRWi7tne8m4DFsSFCAB5EkrnPDS97
	 w5Hz26GSrPObEO3o+1+bkxR8u/Fij4ZGlbQMOc1n8huc03ICARzrD2FmrvFSKlUix1
	 fiiS1hc7qJLnlm/WeY735GKTVHoqiC12VecsPS/rfyFUDKwM/M9J4AnSZle7mOrgdp
	 IOLcj8DbNy0EwNj3o4O+eKnnyIoH5X1SCZ9P8hZaLO9Ki+txIbQkX7k3AcdbpZxTg0
	 qsAz17u7sdI07cSAobUqm3WTKS5eXb6nAg3nkfJL87KJ3LdgM9RPJk7GUe97LhKZtg
	 F7dDHVH7oHm/w==
Date: Mon, 7 Oct 2024 21:24:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v4] ftrace: Get the true parent ip for function tracer
Message-Id: <20241007212417.64a199fbe0c80fc4e2cd4b7b@kernel.org>
In-Reply-To: <20241007113537.19686-1-jeff.xie@linux.dev>
References: <20241007113537.19686-1-jeff.xie@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 19:35:37 +0800
Jeff Xie <jeff.xie@linux.dev> wrote:

> When using both function tracer and function graph simultaneously,
> it is found that function tracer sometimes captures a fake parent ip
> (return_to_handler) instead of the true parent ip.
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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> ---
> v4:
>   https://lore.kernel.org/linux-trace-kernel/20241005101320.766c1100@rorschach.local.home/
> - fixed the crash when accessing the "current" if the arch has not implemented noinstr
>   thanks steve for the testing and the detailed explanation
> 
> v3:
>   https://lore.kernel.org/linux-trace-kernel/20240910001326.87f27e6b312f1d956cf352a2@kernel.org/
> - fixed build error when CONFIG_FUNCTION_GRAPH_TRACER=n suggested by Masami
> 
> v2:
>   https://lore.kernel.org/linux-trace-kernel/20240821095910.1888d7fa@gandalf.local.home/
> - Adding __always_inline to function_get_true_parent_ip suggested by Steve
> 
>  kernel/trace/trace_functions.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..46b663d22c37 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -176,6 +176,27 @@ static void function_trace_start(struct trace_array *tr)
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  }
>  
> +#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_ARCH_WANTS_NO_INSTR)
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
> +#else
> +static __always_inline unsigned long
> +function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
> +{
> +	return parent_ip;
> +}
> +#endif
> +
>  static void
>  function_trace_call(unsigned long ip, unsigned long parent_ip,
>  		    struct ftrace_ops *op, struct ftrace_regs *fregs)
> @@ -193,6 +214,8 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
> +
>  	trace_ctx = tracing_gen_ctx();
>  
>  	cpu = smp_processor_id();
> @@ -241,6 +264,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  	 * recursive protection is performed.
>  	 */
>  	local_irq_save(flags);
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = raw_smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	disabled = atomic_inc_return(&data->disabled);
> @@ -309,6 +333,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	if (atomic_read(&data->disabled))
> @@ -356,6 +381,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	 * recursive protection is performed.
>  	 */
>  	local_irq_save(flags);
> +	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  	cpu = raw_smp_processor_id();
>  	data = per_cpu_ptr(tr->array_buffer.data, cpu);
>  	disabled = atomic_inc_return(&data->disabled);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
