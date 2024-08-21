Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131311AF4E6;
	Wed, 21 Aug 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248723; cv=none; b=BTOLk3EgDcJr/jQOsq33SYmMtLKmH1q+ekMGEFj0uD58z9OXiQ2NGO+JN7uotVWtSqiBfboBmJ6npqZcXXofgo31yC73cAX2KoRHK84K/GjWtMcT4ldP6C4YFM7m9no4gy9ffnufjREbIf5/OspF4HuH94upxmYHQA2DIKwxy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248723; c=relaxed/simple;
	bh=WyrUTCc68PqwXWIJQvIyO6ArRzLAXayFx6Ziao2Grg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfwPZ/yZxzbySeHjPkbkqBSaDbZBYavR8r5PjkfK7NPyWsfa6D0YFCh82ww39PhCzNekh0+hvQEzNtXb3PUqqEGgdelOyIytIzKecLvA7Iy5VBqgwTueTgrw8G9NUheZF0KRX1RCxXpGLnJH6o13HGDQmcD4mGyerhqzig4CPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38FDC32781;
	Wed, 21 Aug 2024 13:58:41 +0000 (UTC)
Date: Wed, 21 Aug 2024 09:59:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com
Subject: Re: [PATCH] ftrace: Get the true parent ip for function tracer
Message-ID: <20240821095910.1888d7fa@gandalf.local.home>
In-Reply-To: <20240821132755.2766674-1-jeff.xie@linux.dev>
References: <20240821132755.2766674-1-jeff.xie@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 21:27:55 +0800
Jeff Xie <jeff.xie@linux.dev> wrote:

Hi Jeff,

Thanks for the patch.

> Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> ---
>  kernel/trace/trace_functions.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..273b8c7eeb2d 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -176,6 +176,19 @@ static void function_trace_start(struct trace_array *tr)
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  }
>  
> +static unsigned long
> +function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)

I wonder if we should make this inline, or even __always_inline, as this
will be called in a very hot path, and I want to make sure that the
compiler always inlines it. It likely should, but we should also give the
compiler a hint that it should.

-- Steve


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

