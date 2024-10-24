Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764701E32CF;
	Thu, 24 Oct 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783286; cv=none; b=nDuSUC5Hc1or47VWJ37HZYv8xMM2APeJaBQ4xTzhVRkQZ8VaK6gebrNCn1Csy8n8AGULEjeMz6ONK05H3JzNZheL19TBs/ojJT590PYNzkShzBfqW3X3EHXQcEOWCG8jMaNN+76q+ohfckbCVFoZnr7LasJbYztvH2OBXaw+wRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783286; c=relaxed/simple;
	bh=rU2UyjO1s88B+A8vM/eeOZclPr5qfuS9ztIVbc4jOus=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jyEuItsQUCPYwRn72K0mO13Wzp3oSoWmciHfIUTqUb8XPDEYq6OVN58KHCXUbjW+eWIMwD1TRfI9u+YuL+KSkZRDqcDQKZqqHhHO+IIiGRL+m7ytFs2jNEpz/Ou+bL1EgbPoyxvNTlsvD/JzKAFP1AfzUPgtJcg6+mLBp1seVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2wtmxZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2wtmxZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BE4C4CEC7;
	Thu, 24 Oct 2024 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783286;
	bh=rU2UyjO1s88B+A8vM/eeOZclPr5qfuS9ztIVbc4jOus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2wtmxZAh0mHiX+Gjp5lrpwt8SgK1kjudOPJsog20hoTb2B+OrAfmwDHFbWkwDXLM
	 vGZash402ZNiqPDTVj9zeKbIMOrUMoP9BwTf5b+N2FMd7ihDEnz0R5XlC9saEwkxdl
	 ESEQktrfu0CdTjE1u7bEEtu2M9KwicV4IycAXLoNf2d+ciAzSG5fx0rHug4LCDfVVg
	 MciT4uxRAcb3u9aEtBYeQaisaU9ZD74Gu1GN8kX0Ue5j9TBmnGqSnaYmT9qFzEV0cB
	 LSkS2D9Ph/fIr+WmJNH9XCYXmX264w0h1+TpgWobJ4dX0Qfbfax4ulnos+K0gWlRk5
	 TzabtYU4CIwJA==
Date: Fri, 25 Oct 2024 00:21:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] fgraph: Free ret_stack when task is done with it
Message-Id: <20241025002121.ef5dc8be87e1b6baa2dd544c@kernel.org>
In-Reply-To: <20241024092952.709200360@goodmis.org>
References: <20241024092723.817582319@goodmis.org>
	<20241024092952.709200360@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 05:27:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The shadow stack used for function graph is only freed when function graph
> is done for those tasks that are no longer using them. That's because a
> function that does a long sleep (like poll) could be traced, and its
> original return address on the stack has been replaced with a pointer to a
> trampoline, but that return address is saved on the shadow stack. It can
> not be freed until the function returns and there's no more return
> addresses being stored on the shadow stack.
> 
> Add a static_branch test in the return part of the function graph code
> that is called after the return address on the shadow stack is popped. If
> the shadow stack is empty, call an irq_work that will call a work queue
> that will run the shadow stack freeing code again. This will clean up all
> the shadow stacks that were not removed when function graph ended but are
> no longer being used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 3c7f115217b4..7520ceba7748 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -174,6 +174,11 @@ int ftrace_graph_active;
>  
>  static struct kmem_cache *fgraph_stack_cachep;
>  
> +DEFINE_STATIC_KEY_FALSE(fgraph_ret_stack_cleanup);
> +static struct workqueue_struct *fgraph_ret_stack_wq;
> +static struct work_struct fgraph_ret_stack_work;
> +static struct irq_work fgraph_ret_stack_irq_work;
> +
>  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
>  static unsigned long fgraph_array_bitmask;
>  
> @@ -849,8 +854,15 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  	 */
>  	barrier();
>  	current->curr_ret_stack = offset - FGRAPH_FRAME_OFFSET;
> -
>  	current->curr_ret_depth--;
> +
> +	/*
> +	 * If function graph is done and this task is no longer using ret_stack
> +	 * then start the work to free it.
> +	 */
> +	if (static_branch_unlikely(&fgraph_ret_stack_cleanup) && current->curr_ret_depth < 0)
> +		irq_work_queue(&fgraph_ret_stack_irq_work);
> +
>  	return ret;
>  }
>  
> @@ -1375,6 +1387,21 @@ static void free_ret_stacks(void)
>  	}
>  }
>  
> +static void fgraph_ret_stack_work_func(struct work_struct *work)
> +{
> +	mutex_lock(&ftrace_lock);
> +	if (!ftrace_graph_active)
> +		free_ret_stacks();
> +	mutex_unlock(&ftrace_lock);
> +}

Hmm, will you scan all tasks everytime? Shouldn't we have another global
list of skipped tasks in remove_ret_stack(), like below?

static void remove_ret_stack(struct task_struct *t, struct list_head *freelist, struct list_head *skiplist, int list_index)
{
	struct ret_stack_free_data *free_data;
	struct list_head *head;

	/* If the ret_stack is still in use, skip this */
	if (t->curr_ret_depth >= 0)
		head = skiplist;
	else
		head = freelist;

	free_data = (struct ret_stack_free_data*)(t->ret_stack + list_index);
	list_add(&free_data->list, head);
	free_data->task = t;
}

Then we can scan only skiplist in free_ret_stacks() in fgraph_ret_stack_work_func().

Of course this will need to decouple preparing freelist/skiplist and
actual free function.

Thank you,

> +
> +static void fgraph_ret_stack_irq_func(struct irq_work *iwork)
> +{
> +	if (unlikely(!fgraph_ret_stack_wq))
> +		return;
> +	queue_work(fgraph_ret_stack_wq, &fgraph_ret_stack_work);
> +}
> +
>  static __init int fgraph_init(void)
>  {
>  	int ret;
> @@ -1385,6 +1412,12 @@ static __init int fgraph_init(void)
>  		pr_warn("fgraph: Error to init cpu hotplug support\n");
>  		return ret;
>  	}
> +	fgraph_ret_stack_wq = alloc_workqueue("fgraph_ret_stack_wq",
> +				      WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +	WARN_ON(!fgraph_ret_stack_wq);
> +
> +	INIT_WORK(&fgraph_ret_stack_work, fgraph_ret_stack_work_func);
> +	init_irq_work(&fgraph_ret_stack_irq_work, fgraph_ret_stack_irq_func);
>  	return 0;
>  }
>  core_initcall(fgraph_init)
> @@ -1434,6 +1467,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  		ftrace_graph_disable_direct(true);
>  
>  	if (ftrace_graph_active == 1) {
> +		static_branch_disable(&fgraph_ret_stack_cleanup);
>  		ftrace_graph_enable_direct(false, gops);
>  		register_pm_notifier(&ftrace_suspend_notifier);
>  		ret = start_graph_tracing();
> @@ -1502,6 +1536,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		ftrace_graph_entry = ftrace_graph_entry_stub;
>  		unregister_pm_notifier(&ftrace_suspend_notifier);
>  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
> +		static_branch_enable(&fgraph_ret_stack_cleanup);
>  		free_ret_stacks();
>  	}
>   out:
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
