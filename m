Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF142571A2;
	Mon,  9 Jun 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471680; cv=none; b=rJBVQb0fNhLJkdVHKdJOTHqXmd29Yn2mIpiID4CVmPLo9YWGGXaNslR4wEj3CApclo5v2JdS7ZlDGR5pDJ6uOs+qxHUL9J+CJmk8Ym+sJFYPyeYiHmj9/2hw+XMv50gY5ZaH94bEc8OWUoiR2GBWsBfbyZR0rY/sXp7i/tfMl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471680; c=relaxed/simple;
	bh=AZB1OZFZxYUvXl5ut3W63UUUIRkqlcSAxhLmulnAKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7wYYbAr/J/U3LzIEiZplUpDPDebDm73vniZWv/R9KGMJk6BZM4UTd92d/NEnDiPBvkfP+wE6RZGf32kx3jn1mfaPrfbJQGhuEGqRXqt1PMwlpcTypwhLHobsAD7mOFJm6ltipDEiboS1PXFkvncDYh5CuNAPT7lwWC6fAT9Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2vNb/nk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2vNb/nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939FDC4CEED;
	Mon,  9 Jun 2025 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749471679;
	bh=AZB1OZFZxYUvXl5ut3W63UUUIRkqlcSAxhLmulnAKoM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n2vNb/nk04ZSPMsH7o3sbJKuhVIW9On/l4qzD38hEAdyjrCuOav38far+SkoGHgKh
	 sDM8PVBJncURRkSL4IcNYPaAZGfdobbP8WGV7FbwUoetMxNAaHlDaVkm6LzwCeY+VO
	 gEr3IR7gxwHqIyyvKugkUP1MNNfxj7JlEwKj8jg1D3SI35lro0Kafll61g0o4C86Wk
	 QVj4N5crPDC6vQiXu9UQPXt8ANN8I/f1webzIUWsR+trKsrADHIMPc60igCy8kpVv3
	 9RuNH31Xu9k3bt4+aJ+ThHJbx9fYXCPUSX52KHktWFiujWgYV7CbEvRsIl2yAsUPer
	 hCmBlqKG+L6bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3085ACE0B6C; Mon,  9 Jun 2025 05:21:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 05:21:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix MOESSBAUER <felix.moessbauer@siemens.com>,
	Julien Flot <julien.flot@siemens.com>
Subject: Re: [PATCH v2] tracing: Fix regression of filter waiting a long time
 on RCU synchronization
Message-ID: <9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250606201936.1e3d09a9@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606201936.1e3d09a9@batman.local.home>

On Fri, Jun 06, 2025 at 08:20:20PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When faultable trace events were added, a trace event may no longer use
> normal RCU to synchronize but instead used synchronize_rcu_tasks_trace().
> This synchronization takes a much longer time to synchronize.
> 
> The filter logic would free the filters by calling
> tracepoint_synchronize_unregister() after it unhooked the filter strings
> and before freeing them. With this function now calling
> synchronize_rcu_tasks_trace() this increased the time to free a filter
> tremendously. On a PREEMPT_RT system, it was even more noticeable.
> 
>  # time trace-cmd record -p function sleep 1
>  [..]
>  real	2m29.052s
>  user	0m0.244s
>  sys	0m20.136s
> 
> As trace-cmd would clear out all the filters before recording, it could
> take up to 2 minutes to do a recording of "sleep 1".
> 
> To find out where the issues was:
> 
>  ~# trace-cmd sqlhist -e -n sched_stack  select start.prev_state as state, end.next_comm as comm, TIMESTAMP_DELTA_USECS as delta,  start.STACKTRACE as stack from sched_switch as start join sched_switch as end on start.prev_pid = end.next_pid
> 
> Which will produce the following commands (and -e will also execute them):
> 
>  echo 's:sched_stack s64 state; char comm[16]; u64 delta; unsigned long stack[];' >> /sys/kernel/tracing/dynamic_events
>  echo 'hist:keys=prev_pid:__arg_18057_2=prev_state,__arg_18057_4=common_timestamp.usecs,__arg_18057_7=common_stacktrace' >> /sys/kernel/tracing/events/sched/sched_switch/trigger
>  echo 'hist:keys=next_pid:__state_18057_1=$__arg_18057_2,__comm_18057_3=next_comm,__delta_18057_5=common_timestamp.usecs-$__arg_18057_4,__stack_18057_6=$__arg_18057_7:onmatch(sched.sched_switch).trace(sched_stack,$__state_18057_1,$__comm_18057_3,$__delta_18057_5,$__stack_18057_6)' >> /sys/kernel/tracing/events/sched/sched_switch/trigger
> 
> The above creates a synthetic event that creates a stack trace when a task
> schedules out and records it with the time it scheduled back in. Basically
> the time a task is off the CPU. It also records the state of the task when
> it left the CPU (running, blocked, sleeping, etc). It also saves the comm
> of the task as "comm" (needed for the next command).
> 
> ~# echo 'hist:keys=state,stack.stacktrace:vals=delta:sort=state,delta if comm == "trace-cmd" &&  state & 3' > /sys/kernel/tracing/events/synthetic/sched_stack/trigger
> 
> The above creates a histogram with buckets per state, per stack, and the
> value of the total time it was off the CPU for that stack trace. It filters
> on tasks with "comm == trace-cmd" and only the sleeping and blocked states
> (1 - sleeping, 2 - blocked).
> 
> ~# trace-cmd record -p function sleep 1
> 
> ~# cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -18
> { state:          2, stack.stacktrace         __schedule+0x1545/0x3700
>          schedule+0xe2/0x390
>          schedule_timeout+0x175/0x200
>          wait_for_completion_state+0x294/0x440
>          __wait_rcu_gp+0x247/0x4f0
>          synchronize_rcu_tasks_generic+0x151/0x230
>          apply_subsystem_event_filter+0xa2b/0x1300
>          subsystem_filter_write+0x67/0xc0
>          vfs_write+0x1e2/0xeb0
>          ksys_write+0xff/0x1d0
>          do_syscall_64+0x7b/0x420
>          entry_SYSCALL_64_after_hwframe+0x76/0x7e
> } hitcount:        237  delta:   99756288  <<--------------- Delta is 99 seconds!
> 
> Totals:
>     Hits: 525
>     Entries: 21
>     Dropped: 0
> 
> This shows that this particular trace waited for 99 seconds on
> synchronize_rcu_tasks() in apply_subsystem_event_filter().
> 
> In fact, there's a lot of places in the filter code that spends a lot of
> time waiting for synchronize_rcu_tasks_trace() in order to free the
> filters.
> 
> Add helper functions that will use call_rcu*() variants to asynchronously
> free the filters. This brings the timings back to normal:
> 
>  # time trace-cmd record -p function sleep 1
>  [..]
>  real	0m14.681s
>  user	0m0.335s
>  sys	0m28.616s
> 
> And the histogram also shows this:
> 
> ~# cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -21
> { state:          2, stack.stacktrace         __schedule+0x1545/0x3700
>          schedule+0xe2/0x390
>          schedule_timeout+0x175/0x200
>          wait_for_completion_state+0x294/0x440
>          __wait_rcu_gp+0x247/0x4f0
>          synchronize_rcu_normal+0x3db/0x5c0
>          tracing_reset_online_cpus+0x8f/0x1e0
>          tracing_open+0x335/0x440
>          do_dentry_open+0x4c6/0x17a0
>          vfs_open+0x82/0x360
>          path_openat+0x1a36/0x2990
>          do_filp_open+0x1c5/0x420
>          do_sys_openat2+0xed/0x180
>          __x64_sys_openat+0x108/0x1d0
>          do_syscall_64+0x7b/0x420
> } hitcount:          2  delta:      77044
> 
> Totals:
>     Hits: 55
>     Entries: 28
>     Dropped: 0
> 
> Where the total waiting time of synchronize_rcu_tasks_trace() is 77
> milliseconds.

Nice!!!

One concern below.

> Cc: stable@vger.kernel.org
> Reported-by: "Flot, Julien" <julien.flot@siemens.com>
> Tested-by: Julien Flot <julien.flot@siemens.com>
> Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
> Closes: https://lore.kernel.org/all/240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250605161701.35f7989a@gandalf.local.home
> 
> - Fix accessing file->filter as it is tagged as __rcu.
>   https://lore.kernel.org/all/202506070406.BQGH3VyM-lkp@intel.com/
> 
>  kernel/trace/trace_events_filter.c | 186 +++++++++++++++++++++--------
>  1 file changed, 138 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2048560264bb..711520081741 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1335,22 +1335,139 @@ static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
>  	}
>  }
>  
> +struct filter_list {
> +	struct list_head	list;
> +	struct event_filter	*filter;
> +};
> +
> +struct filter_head {
> +	struct list_head	list;
> +	struct rcu_head		rcu;
> +};
> +
> +
> +static void free_filter_list(struct rcu_head *rhp)
> +{
> +	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
> +	struct filter_list *filter_item, *tmp;
> +
> +	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
> +		__free_filter(filter_item->filter);
> +		list_del(&filter_item->list);
> +		kfree(filter_item);
> +	}

If the series of synchronize_rcu() calls was taking 99 seconds,
we might well be going through the above loop quite a few times, all
within a bh-disabled region of code.  For example, the calls from both
filter_free_subsystem_filters() and process_system_preds() look like
they can queue a very large number of entries.

So...

> +	kfree(filter_list);
> +}
> +
> +static void free_filter_list_tasks(struct rcu_head *rhp)
> +{
> +	call_rcu(rhp, free_filter_list);

...why not use queue_rcu_work() in place of call_rcu() here, thus avoiding
possible response-time issues?

Or is there something that I am missing that limits the length of the
list passed to free_filter_list()?

							Thanx, Paul

> +}
> +
> +/*
> + * The tracepoint_synchronize_unregister() is a double rcu call.
> + * It calls synchronize_rcu_tasks_trace() followed by synchronize_rcu().
> + * Instead of waiting for it, simply call these via the call_rcu*()
> + * variants.
> + */
> +static void delay_free_filter(struct filter_head *head)
> +{
> +	call_rcu_tasks_trace(&head->rcu, free_filter_list_tasks);
> +}
> +
> +static void try_delay_free_filter(struct event_filter *filter)
> +{
> +	struct filter_head *head;
> +	struct filter_list *item;
> +
> +	head = kmalloc(sizeof(*head), GFP_KERNEL);
> +	if (!head)
> +		goto free_now;
> +
> +	INIT_LIST_HEAD(&head->list);
> +
> +	item = kmalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item) {
> +		kfree(head);
> +		goto free_now;
> +	}
> +
> +	item->filter = filter;
> +	list_add_tail(&item->list, &head->list);
> +	delay_free_filter(head);
> +	return;
> +
> + free_now:
> +	/* Make sure the filter is not being used */
> +	tracepoint_synchronize_unregister();
> +	__free_filter(filter);
> +}
> +
>  static inline void __free_subsystem_filter(struct trace_event_file *file)
>  {
>  	__free_filter(file->filter);
>  	file->filter = NULL;
>  }
>  
> +static inline void event_set_filter(struct trace_event_file *file,
> +				    struct event_filter *filter)
> +{
> +	rcu_assign_pointer(file->filter, filter);
> +}
> +
> +static inline void event_clear_filter(struct trace_event_file *file)
> +{
> +	RCU_INIT_POINTER(file->filter, NULL);
> +}
> +
>  static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
> -					  struct trace_array *tr)
> +					  struct trace_array *tr,
> +					  struct event_filter *filter)
>  {
>  	struct trace_event_file *file;
> +	struct filter_head *head;
> +	struct filter_list *item;
> +
> +	head = kmalloc(sizeof(*head), GFP_KERNEL);
> +	if (!head)
> +		goto free_now;
> +
> +	INIT_LIST_HEAD(&head->list);
> +
> +	item = kmalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item) {
> +		kfree(head);
> +		goto free_now;
> +	}
> +
> +	item->filter = filter;
> +	list_add_tail(&item->list, &head->list);
>  
>  	list_for_each_entry(file, &tr->events, list) {
>  		if (file->system != dir)
>  			continue;
> -		__free_subsystem_filter(file);
> +		item = kmalloc(sizeof(*item), GFP_KERNEL);
> +		if (!item)
> +			goto free_now;
> +		item->filter = event_filter(file);
> +		list_add_tail(&item->list, &head->list);
> +		event_clear_filter(file);
>  	}
> +
> +	delay_free_filter(head);
> +	return;
> + free_now:
> +	tracepoint_synchronize_unregister();
> +
> +	if (head)
> +		free_filter_list(&head->rcu);
> +
> +	list_for_each_entry(file, &tr->events, list) {
> +		if (file->system != dir || !file->filter)
> +			continue;
> +		__free_filter(file->filter);
> +	}
> +	__free_filter(filter);
>  }
>  
>  int filter_assign_type(const char *type)
> @@ -2120,22 +2237,6 @@ static inline void event_set_filtered_flag(struct trace_event_file *file)
>  		trace_buffered_event_enable();
>  }
>  
> -static inline void event_set_filter(struct trace_event_file *file,
> -				    struct event_filter *filter)
> -{
> -	rcu_assign_pointer(file->filter, filter);
> -}
> -
> -static inline void event_clear_filter(struct trace_event_file *file)
> -{
> -	RCU_INIT_POINTER(file->filter, NULL);
> -}
> -
> -struct filter_list {
> -	struct list_head	list;
> -	struct event_filter	*filter;
> -};
> -
>  static int process_system_preds(struct trace_subsystem_dir *dir,
>  				struct trace_array *tr,
>  				struct filter_parse_error *pe,
> @@ -2144,11 +2245,16 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	struct trace_event_file *file;
>  	struct filter_list *filter_item;
>  	struct event_filter *filter = NULL;
> -	struct filter_list *tmp;
> -	LIST_HEAD(filter_list);
> +	struct filter_head *filter_list;
>  	bool fail = true;
>  	int err;
>  
> +	filter_list = kmalloc(sizeof(*filter_list), GFP_KERNEL);
> +	if (!filter_list)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&filter_list->list);
> +
>  	list_for_each_entry(file, &tr->events, list) {
>  
>  		if (file->system != dir)
> @@ -2175,7 +2281,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  		if (!filter_item)
>  			goto fail_mem;
>  
> -		list_add_tail(&filter_item->list, &filter_list);
> +		list_add_tail(&filter_item->list, &filter_list->list);
>  		/*
>  		 * Regardless of if this returned an error, we still
>  		 * replace the filter for the call.
> @@ -2195,31 +2301,22 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	 * Do a synchronize_rcu() and to ensure all calls are
>  	 * done with them before we free them.
>  	 */
> -	tracepoint_synchronize_unregister();
> -	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
> -		__free_filter(filter_item->filter);
> -		list_del(&filter_item->list);
> -		kfree(filter_item);
> -	}
> +	delay_free_filter(filter_list);
>  	return 0;
>   fail:
>  	/* No call succeeded */
> -	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
> -		list_del(&filter_item->list);
> -		kfree(filter_item);
> -	}
> +	free_filter_list(&filter_list->rcu);
>  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  	return -EINVAL;
>   fail_mem:
>  	__free_filter(filter);
> +
>  	/* If any call succeeded, we still need to sync */
>  	if (!fail)
> -		tracepoint_synchronize_unregister();
> -	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
> -		__free_filter(filter_item->filter);
> -		list_del(&filter_item->list);
> -		kfree(filter_item);
> -	}
> +		delay_free_filter(filter_list);
> +	else
> +		free_filter_list(&filter_list->rcu);
> +
>  	return -ENOMEM;
>  }
>  
> @@ -2361,9 +2458,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
>  
>  		event_clear_filter(file);
>  
> -		/* Make sure the filter is not being used */
> -		tracepoint_synchronize_unregister();
> -		__free_filter(filter);
> +		try_delay_free_filter(filter);
>  
>  		return 0;
>  	}
> @@ -2387,11 +2482,8 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
>  
>  		event_set_filter(file, filter);
>  
> -		if (tmp) {
> -			/* Make sure the call is done with the filter */
> -			tracepoint_synchronize_unregister();
> -			__free_filter(tmp);
> -		}
> +		if (tmp)
> +			try_delay_free_filter(tmp);
>  	}
>  
>  	return err;
> @@ -2417,9 +2509,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  		filter = system->filter;
>  		system->filter = NULL;
>  		/* Ensure all filters are no longer used */
> -		tracepoint_synchronize_unregister();
> -		filter_free_subsystem_filters(dir, tr);
> -		__free_filter(filter);
> +		filter_free_subsystem_filters(dir, tr, filter);
>  		return 0;
>  	}
>  
> -- 
> 2.47.2
> 
