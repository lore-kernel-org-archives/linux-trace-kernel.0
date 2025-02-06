Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA92253F6;
	Thu,  6 Feb 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836089; cv=none; b=LjuXkYibNrUP20gJDCRZywzhVC6vTsj7d8xEFx9DfJSBZ6eerxmuFCOsWwPjLUBs8R1mWL0FcWQHOoGUYUBpZP8R8p/kQs/oXZBLJ/9Y7+7y39/l0dvklpTwb4P3SfTmDj2IUcLEPFCoVqzT4btXlSUjSU0Uj54J064SJi0IPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836089; c=relaxed/simple;
	bh=V0JsiYdVm+TnlGhbMq/rHuoUGqWlW0oL4PdrJcHMJJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=etXkLPRsVYCFao8h5Mc9LHUp3QXjfRiie3yq1pzpRqIBxNnppA2Yyl0urVUAbDafg4K3EUcHOHlksK+e6Hj2nXmg2X0Ie7qLMiJYkNTVpKByiR2vW2jQW/PD1BPBiMi3L1O3hEvW2+dj2CsqlXUxgpL4H8CssKn57NQGFt8TxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5S2RJ1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5S2RJ1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD44C4CEDD;
	Thu,  6 Feb 2025 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738836088;
	bh=V0JsiYdVm+TnlGhbMq/rHuoUGqWlW0oL4PdrJcHMJJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a5S2RJ1NEhw8KYAvf2Qqlt8BmfWgqamoE/VeFKBjxBOI7zrGpadfK8jM68fo/r0bO
	 KKSg3XMDfwmgDOp3cGgwEdQlGtA6EnKKMo/m7d3jUBf48YwOYdIjxO0kF5MhzWkwXz
	 KwrU6DfNm7mvNFXNdmvYhIBE0gYPUx7+MIJTa3R3hqjpW/7u+prMZBtUVtYLxvLj+f
	 wc8SrEI3NBlFyCDtldDPgGINSLwy1xZ7vkGvVxfR7GNFKfqWLd7VVJoaID3BWu8hUC
	 4ub8cG68ct19iKUwwdFdBgi4UHStG8xe6rHw5XaGjKyR5tg4kx5dvFc7/QK2b+GWcO
	 8o/29IYzpfQZA==
Date: Thu, 6 Feb 2025 19:01:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 8/8] tracing: Update modules to persistent instances
 when loaded
Message-Id: <20250206190124.1518c3bf070e862da7993d9e@kernel.org>
In-Reply-To: <20250205225104.264333506@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.264333506@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When a module is loaded and a persistent buffer is actively tracing, add
> it to the list of modules in the persistent memory.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c        | 25 +++++++++++++++++++++++
>  kernel/trace/trace.h        |  2 ++
>  kernel/trace/trace_events.c | 40 ++++++++++++++++++++++++++-----------
>  3 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7b4027804cd4..443f2bc5b856 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10088,6 +10088,30 @@ static void trace_module_remove_evals(struct module *mod)
>  static inline void trace_module_remove_evals(struct module *mod) { }
>  #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
>  
> +static bool trace_array_active(struct trace_array *tr)
> +{
> +	if (tr->current_trace != &nop_trace)
> +		return true;
> +
> +	/* 0 is no events, 1 is all disabled */
> +	return trace_events_enabled(tr, NULL) > 1;
> +}
> +
> +static void trace_module_record(struct module *mod)
> +{
> +	struct trace_array *tr;
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		/* Update any persistent trace array that has already been started */
> +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> +		    TRACE_ARRAY_FL_BOOT) {
> +			/* Only update if the trace array is active */
> +			if (trace_array_active(tr))

Do we really need this check? It seems that we can just save_mod() if the
above condition is true.

> +				save_mod(mod, tr);
> +		}
> +	}
> +}
> +
>  static int trace_module_notify(struct notifier_block *self,
>  			       unsigned long val, void *data)
>  {
> @@ -10096,6 +10120,7 @@ static int trace_module_notify(struct notifier_block *self,
>  	switch (val) {
>  	case MODULE_STATE_COMING:
>  		trace_module_add_evals(mod);
> +		trace_module_record(mod);
>  		break;
>  	case MODULE_STATE_GOING:
>  		trace_module_remove_evals(mod);

Don't we need to remove the module entry when a module is removed?
(everytime we remove a module, trace data is cleared?)

Thank you,

> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 3a020fb82a34..90493220c362 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -786,6 +786,8 @@ extern void trace_find_cmdline(int pid, char comm[]);
>  extern int trace_find_tgid(int pid);
>  extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
>  
> +extern int trace_events_enabled(struct trace_array *tr, const char *system);
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  extern unsigned long ftrace_update_tot_cnt;
>  extern unsigned long ftrace_number_of_pages;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 4cb275316e51..107767afe0ab 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1811,28 +1811,28 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  	return cnt;
>  }
>  
> -static ssize_t
> -system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
> -		   loff_t *ppos)
> +/*
> + * Returns:
> + *   0 : no events exist?
> + *   1 : all events are disabled
> + *   2 : all events are enabled
> + *   3 : some events are enabled and some are enabled
> + */
> +int trace_events_enabled(struct trace_array *tr, const char *system)
>  {
> -	const char set_to_char[4] = { '?', '0', '1', 'X' };
> -	struct trace_subsystem_dir *dir = filp->private_data;
> -	struct event_subsystem *system = dir->subsystem;
>  	struct trace_event_call *call;
>  	struct trace_event_file *file;
> -	struct trace_array *tr = dir->tr;
> -	char buf[2];
>  	int set = 0;
> -	int ret;
>  
> -	mutex_lock(&event_mutex);
> +	guard(mutex)(&event_mutex);
> +
>  	list_for_each_entry(file, &tr->events, list) {
>  		call = file->event_call;
>  		if ((call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
>  		    !trace_event_name(call) || !call->class || !call->class->reg)
>  			continue;
>  
> -		if (system && strcmp(call->class->system, system->name) != 0)
> +		if (system && strcmp(call->class->system, system) != 0)
>  			continue;
>  
>  		/*
> @@ -1848,7 +1848,23 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
>  		if (set == 3)
>  			break;
>  	}
> -	mutex_unlock(&event_mutex);
> +
> +	return set;
> +}
> +
> +static ssize_t
> +system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
> +		   loff_t *ppos)
> +{
> +	const char set_to_char[4] = { '?', '0', '1', 'X' };
> +	struct trace_subsystem_dir *dir = filp->private_data;
> +	struct event_subsystem *system = dir->subsystem;
> +	struct trace_array *tr = dir->tr;
> +	char buf[2];
> +	int set;
> +	int ret;
> +
> +	set = trace_events_enabled(tr, system ? system->name : NULL);
>  
>  	buf[0] = set_to_char[set];
>  	buf[1] = '\n';
> -- 
> 2.45.2
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
