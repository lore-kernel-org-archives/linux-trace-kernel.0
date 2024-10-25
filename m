Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4959A50;
	Fri, 25 Oct 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818056; cv=none; b=UE9wT/r5M1cOgaFQZtLtUvvZ1ipYqvEUICSXHkC9fADa/Vr5SRBHh210bL/TzpLtbgSwQvhp9t6e79RRFSKTFk40H37WMiHxu1VUF25VYsjSxBI+XtY0Z3LooqJj6sl/GVLZaTN38+8mkfSfoNvDMZnuOQYBw8o742w6AV3cQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818056; c=relaxed/simple;
	bh=c7LWaHBGNEtWh1lD48toNptASSDPjGMQHo1Uhw3hwm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/Cqltotiw7u/FkAnFjeABjsSjE9u7xGmwFeTfgo7njnLihC9S5d1P3E8POUKftPob3Y7sykZta+/wyVwSkMqjAltW3DN6QLUNoFTccy5Q6ZsEZzw1FoD0/9SptfOVcts+LukESCJWeCoEWMbubWbWUIFRWGkXjVWmKKSFAcADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E598C4CEC7;
	Fri, 25 Oct 2024 01:00:55 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:00:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] fgraph: Free ret_stacks when graph tracing is done
Message-ID: <20241024210051.2a436bc4@rorschach.local.home>
In-Reply-To: <20241025000044.d81eeaeed5802df08e785c10@kernel.org>
References: <20241024092723.817582319@goodmis.org>
	<20241024092952.549693956@goodmis.org>
	<20241025000044.d81eeaeed5802df08e785c10@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 00:00:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > ---
> >  kernel/trace/fgraph.c | 113 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 99 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 0b7cf2507569..3c7f115217b4 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1144,6 +1144,7 @@ void ftrace_graph_init_task(struct task_struct *t)
> >  	t->curr_ret_stack = 0;
> >  	t->curr_ret_depth = -1;
> >  
> > +	mutex_lock(&ftrace_lock);
> >  	if (ftrace_graph_active) {
> >  		unsigned long *ret_stack;
> >  
> > @@ -1155,6 +1156,7 @@ void ftrace_graph_init_task(struct task_struct *t)
> >  			return;  
> 
> The above `return;` shows that you miss unlocking ftrace_lock. B^)

Bah, I added this locking after doing most my tests and then seeing
this needed protection. The return was here before the mutex, but I
missed it when I added the mutexes. I'll switch this with guard.

> 
> >  		graph_init_task(t, ret_stack);
> >  	}
> > +	mutex_unlock(&ftrace_lock);
> >  }
> >  
> >  void ftrace_graph_exit_task(struct task_struct *t)
> > @@ -1292,19 +1294,106 @@ static void ftrace_graph_disable_direct(bool disable_branch)
> >  	fgraph_direct_gops = &fgraph_stub;
> >  }
> >  
> > -/* The cpu_boot init_task->ret_stack will never be freed */
> > -static int fgraph_cpu_init(unsigned int cpu)
> > +static void __fgraph_cpu_init(unsigned int cpu)
> >  {
> >  	if (!idle_task(cpu)->ret_stack)
> >  		ftrace_graph_init_idle_task(idle_task(cpu), cpu);
> > +}
> > +
> > +static int fgraph_cpu_init(unsigned int cpu)
> > +{
> > +	if (ftrace_graph_active)
> > +		__fgraph_cpu_init(cpu);
> >  	return 0;
> >  }
> >  
> > +struct ret_stack_free_data {
> > +	struct list_head		list;
> > +	struct task_struct		*task;
> > +};
> > +
> > +static void remove_ret_stack(struct task_struct *t, struct list_head *head, int list_index)
> > +{
> > +	struct ret_stack_free_data *free_data;
> > +
> > +	/* If the ret_stack is still in use, skip this */
> > +	if (t->curr_ret_depth >= 0)
> > +		return;
> > +
> > +	free_data = (struct ret_stack_free_data*)(t->ret_stack + list_index);
> > +	list_add(&free_data->list, head);
> > +	free_data->task = t;
> > +}
> > +
> > +static void free_ret_stacks(void)
> > +{
> > +	struct ret_stack_free_data *free_data, *n;
> > +	struct task_struct *g, *t;
> > +	LIST_HEAD(stacks);
> > +	int list_index;
> > +	int list_sz;
> > +	int cpu;
> > +
> > +	/* Calculate the size in longs to hold ret_stack_free_data */
> > +	list_sz = DIV_ROUND_UP(sizeof(struct ret_stack_free_data), sizeof(long));
> > +
> > +	/*
> > +	 * We do not want to race with __ftrace_return_to_handler() where this
> > +	 * CPU can see the update to curr_ret_depth going to zero before it
> > +	 * actually does. As tracing is disabled, the ret_stack is not going
> > +	 * to be used anymore and there will be no more callbacks. Use
> > +	 * the top of the stack as the link list pointer to attach this  
> 
> > +	 * ret_stack to @head. Then at the end, run an RCU trace synthronization
> > +	 * which will guarantee that there are no more uses of the ret_stacks
> > +	 * and they can all be freed.  
> 
> Just a comment.
> This part can mislead, the ret_stacks here are the ret_stacks which can be
> used by currently running callbacks on other CPUs. Some other ret_stack are
> still used and the owner tasks are in sleep.

OK, I'll update the comment.

> 
> > +	 */
> > +	list_index = SHADOW_STACK_MAX_OFFSET - list_sz;
> > +
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, t) {
> > +		if (t->ret_stack)
> > +			remove_ret_stack(t, &stacks, list_index);
> > +	}
> > +	read_unlock(&tasklist_lock);
> > +
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		t = idle_task(cpu);
> > +		if (t->ret_stack)
> > +			remove_ret_stack(t, &stacks, list_index);
> > +	}
> > +	cpus_read_unlock();
> > +
> > +	/* Make sure nothing is using the ret_stacks anymore */
> > +	synchronize_rcu_tasks_trace();
> > +
> > +	list_for_each_entry_safe(free_data, n, &stacks, list) {
> > +		unsigned long *stack = free_data->task->ret_stack;
> > +
> > +		free_data->task->ret_stack = NULL;
> > +		kmem_cache_free(fgraph_stack_cachep, stack);
> > +	}
> > +}
> > +
> > +static __init int fgraph_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",  
> 
> nit: Shouldn't we update the name first?

Heh, I guess ;-)

Thank for the review!

-- Steve

> 
> 
> Thank you,
> 
> > +				fgraph_cpu_init, NULL);
> > +	if (ret < 0) {
> > +		pr_warn("fgraph: Error to init cpu hotplug support\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +core_initcall(fgraph_init)
> > +
> >  int register_ftrace_graph(struct fgraph_ops *gops)
> >  {
> > -	static bool fgraph_initialized;
> >  	int command = 0;
> >  	int ret = 0;
> > +	int cpu;
> >  	int i = -1;
> >  
> >  	mutex_lock(&ftrace_lock);
> > @@ -1319,17 +1408,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >  		}
> >  	}
> >  
> > -	if (!fgraph_initialized) {
> > -		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
> > -					fgraph_cpu_init, NULL);
> > -		if (ret < 0) {
> > -			pr_warn("fgraph: Error to init cpu hotplug support\n");
> > -			return ret;
> > -		}
> > -		fgraph_initialized = true;
> > -		ret = 0;
> > -	}
> > -
> >  	if (!fgraph_array[0]) {
> >  		/* The array must always have real data on it */
> >  		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
> > @@ -1346,6 +1424,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >  
> >  	ftrace_graph_active++;
> >  
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		__fgraph_cpu_init(cpu);
> > +	}
> > +	cpus_read_unlock();
> > +
> >  	if (ftrace_graph_active == 2)
> >  		ftrace_graph_disable_direct(true);
> >  
> > @@ -1418,6 +1502,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
> >  		ftrace_graph_entry = ftrace_graph_entry_stub;
> >  		unregister_pm_notifier(&ftrace_suspend_notifier);
> >  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
> > +		free_ret_stacks();
> >  	}
> >   out:
> >  	gops->saved_func = NULL;
> > -- 
> > 2.45.2
