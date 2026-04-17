Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D74314A86;
	Fri, 17 Apr 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441191; cv=none; b=Hxa7yVU5idpTyXz7LRcSpNj/VHMHCw2tBZ1qlpunFoG9q6e60pVLXJ/qkWafUz0WJRUTxCp1I62CLi9ESErqAldkLAq+EgrrloRRBt6vNNwNjioZ9+xlPhl499p9fVyV3O8HYTkM6REh0NR6NkqyRhrvbz8j1npF6+afM7xxMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441191; c=relaxed/simple;
	bh=3fTK5p2hRefmwuJxhrwI+FEodsik7kTHPIfo5r2Nk5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWD99Dyht9T+3Wz2hCKw5g54uepbxgbbkOS7NYrwnsj8vXfyWCDUrUqrQmKR2WU6PidKpIwhJLVOgReFf1o2vqxvWhkucQFQDgwfH6ee7nwOqGuQKFY1sPRZjt2AKD8/7PtrFaIOECdC/AEUUVh47s/hx1686oxXCd5WOIjalLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 37961B3BF3;
	Fri, 17 Apr 2026 15:53:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id D5D132F;
	Fri, 17 Apr 2026 15:53:05 +0000 (UTC)
Date: Fri, 17 Apr 2026 11:52:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
Subject: Re: [PATCH] trace: propagate registration failure from
 tracing_start_*_record()
Message-ID: <20260417115258.65e216be@fedora>
In-Reply-To: <20260417063827.84146-1-yashsuthar983@gmail.com>
References: <20260417063827.84146-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5D132F
X-Rspamd-Server: rspamout06
X-Stat-Signature: mrxfnmhb6frhj5b91srui4yg5zqhbrd9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ShbHFGTkTFtlFpWu0cJzoCno/ww4UVjM=
X-HE-Tag: 1776441185-751222
X-HE-Meta: U2FsdGVkX1+IJFG2J9XE2WzgFmbmf1ov0MvORIU3mE+DLfJ4OBxXku9H+gWxlVuxnmjNpyTUkSI=

On Fri, 17 Apr 2026 12:08:27 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> syzbot reported a WARN in tracepoint_probe_unregister():
> 
> tracing_start_sched_switch() increments sched_cmdline_ref /
> sched_tgid_ref before calling tracing_sched_register(), and its
> return value is discarded because the API is void. When the first
> register_trace_sched_*() fails (e.g. kmalloc under memory pressure
> or failslab), the function's fail_deprobe* labels roll back any
> partial probe registration, but the caller's refcount has already
> been bumped. The state is now desynced: refs > 0 but no probes in
> tp->funcs.
> 
> Later, when the caller pairs the start with a stop, the refcount
> walks back to 0 and tracing_sched_unregister() calls
> unregister_trace_sched_*() against an empty tp->funcs.
> func_remove() returns -ENOENT and the
> WARN_ON_ONCE(IS_ERR(old)) in tracepoint_remove_func() fires.
> 
> Fix: make tracing_start_sched_switch() and the two exported
> wrappers, tracing_start_cmdline_record() and
> tracing_start_tgid_record(), return int; register the probes
> before bumping the refcount; and propagate the error to callers
> so refs are only held on behalf of a caller whose registration
> actually succeeded.
> 
> Fixes: d914ba37d714 ("tracing: Add support for recording tgid of tasks")
> Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=f93e97cd824071a2577a40cde9ecd957f59f87eb

Did you use AI to create any of this? If so you must disclose it. This
reads very much like an AI patch.

> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  kernel/trace/trace.c                 |  6 +++---
>  kernel/trace/trace.h                 |  4 ++--
>  kernel/trace/trace_events.c          | 28 +++++++++++++++++++--------
>  kernel/trace/trace_functions.c       |  8 +++++++-
>  kernel/trace/trace_functions_graph.c |  6 +++++-
>  kernel/trace/trace_sched_switch.c    | 29 ++++++++++++++++++----------
>  kernel/trace/trace_selftest.c        |  7 ++++++-
>  7 files changed, 62 insertions(+), 26 deletions(-)

NAK on all this. If you are under severe memory constraints that causes
this to fail, then you'll be hitting a bunch more errors.

> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8bd4ec08fb36..e936eed99b27 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3320,7 +3320,7 @@ void trace_printk_init_buffers(void)
>  	 * allocated here, then this was called by module code.
>  	 */
>  	if (global_trace.array_buffer.buffer)
> -		tracing_start_cmdline_record();
> +		(void)tracing_start_cmdline_record();

WTF??? Why are you adding the typecast of (void) here? Don't do that!


>  }
>  EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
>  
> @@ -3329,7 +3329,7 @@ void trace_printk_start_comm(void)
>  	/* Start tracing comms if trace printk is set */
>  	if (!buffers_allocated)
>  		return;
> -	tracing_start_cmdline_record();
> +	(void)tracing_start_cmdline_record();
>  }
>  
>  static void trace_printk_start_stop_comm(int enabled)
> @@ -3338,7 +3338,7 @@ static void trace_printk_start_stop_comm(int enabled)
>  		return;
>  
>  	if (enabled)
> -		tracing_start_cmdline_record();
> +		(void)tracing_start_cmdline_record();
>  	else
>  		tracing_stop_cmdline_record();
>  }
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b6d42fe06115..6fe2c8429560 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -751,9 +751,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
>  int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		      struct ftrace_regs *fregs);
>  
> -void tracing_start_cmdline_record(void);
> +int tracing_start_cmdline_record(void);
>  void tracing_stop_cmdline_record(void);
> -void tracing_start_tgid_record(void);
> +int tracing_start_tgid_record(void);
>  void tracing_stop_tgid_record(void);
>  
>  int register_tracer(struct tracer *type);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 137b4d9bb116..e6713aa80a03 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -734,9 +734,9 @@ void trace_event_enable_cmd_record(bool enable)
>  			continue;
>  
>  		if (enable) {
> -			tracing_start_cmdline_record();
> -			set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
> -		} else {
> +			if (!tracing_start_cmdline_record())
> +				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
> +		} else if (file->flags & EVENT_FILE_FL_RECORDED_CMD) {
>  			tracing_stop_cmdline_record();
>  			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
>  		}
> @@ -755,9 +755,9 @@ void trace_event_enable_tgid_record(bool enable)
>  			continue;
>  
>  		if (enable) {
> -			tracing_start_tgid_record();
> -			set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
> -		} else {
> +			if (!tracing_start_tgid_record())
> +				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
> +		} else if (file->flags & EVENT_FILE_FL_RECORDED_TGID) {
>  			tracing_stop_tgid_record();
>  			clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
>  				  &file->flags);
> @@ -847,14 +847,26 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
>  
>  			if (tr->trace_flags & TRACE_ITER(RECORD_CMD)) {
> +				ret = tracing_start_cmdline_record();
> +				if (ret) {
> +					pr_info("event trace: Could not enable event %s\n",
> +						trace_event_name(call));
> +					break;
> +				}
>  				cmd = true;
> -				tracing_start_cmdline_record();
>  				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
>  			}
>  
>  			if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
> +				ret = tracing_start_tgid_record();
> +				if (ret) {
> +					if (cmd)
> +						tracing_stop_cmdline_record();
> +					pr_info("event trace: Could not enable event %s\n",
> +						trace_event_name(call));
> +					break;
> +				}
>  				tgid = true;
> -				tracing_start_tgid_record();
>  				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
>  			}
>  
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index c12795c2fb39..14d099734345 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -146,6 +146,8 @@ static bool handle_func_repeats(struct trace_array *tr, u32 flags_val)
>  static int function_trace_init(struct trace_array *tr)
>  {
>  	ftrace_func_t func;
> +	int ret;
> +
>  	/*
>  	 * Instance trace_arrays get their ops allocated
>  	 * at instance creation. Unless it failed
> @@ -165,7 +167,11 @@ static int function_trace_init(struct trace_array *tr)
>  
>  	tr->array_buffer.cpu = raw_smp_processor_id();
>  
> -	tracing_start_cmdline_record();
> +	ret = tracing_start_cmdline_record();
> +	if (ret) {
> +		ftrace_reset_array_ops(tr);
> +		return ret;
> +	}
>  	tracing_start_function_trace(tr);
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 1de6f1573621..6b27ed62fee8 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -487,7 +487,11 @@ static int graph_trace_init(struct trace_array *tr)
>  	ret = register_ftrace_graph(tr->gops);
>  	if (ret)
>  		return ret;
> -	tracing_start_cmdline_record();
> +	ret = tracing_start_cmdline_record();
> +	if (ret) {
> +		unregister_ftrace_graph(tr->gops);
> +		return ret;
> +	}
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index c46d584ded3b..683ea4ca1498 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -89,12 +89,22 @@ static void tracing_sched_unregister(void)
>  	unregister_trace_sched_wakeup(probe_sched_wakeup, NULL);
>  }
>  
> -static void tracing_start_sched_switch(int ops)
> +static int tracing_start_sched_switch(int ops)
>  {
> -	bool sched_register;
> +	int ret = 0;
>  
>  	mutex_lock(&sched_register_mutex);
> -	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
> +
> +	/*
> +	 * If the registration fails, do not bump the reference count : the
> +	 * caller must observe the failure so it can avoid a later matching
> +	 * stop that would otherwise unregister probes that were never added.
> +	 */
> +	if (!sched_cmdline_ref && !sched_tgid_ref) {
> +		ret = tracing_sched_register();
> +		if (ret)
> +			goto out;
> +	}
>  
>  	switch (ops) {
>  	case RECORD_CMDLINE:
> @@ -105,10 +115,9 @@ static void tracing_start_sched_switch(int ops)
>  		sched_tgid_ref++;
>  		break;
>  	}
> -
> -	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
> -		tracing_sched_register();

The only change that should deal with this would be:

	if (sched_register && (sched_cmdline_ref || sched_tgid_ref)) {
		WARN_ONCE(tracing_sched_register() < 0,
			"Failed to register trace command line caching. Requires reboot to fix");
	}

-- Steve



> +out:
>  	mutex_unlock(&sched_register_mutex);
> +	return ret;
>  }
>  
>  static void tracing_stop_sched_switch(int ops)
> @@ -130,9 +139,9 @@ static void tracing_stop_sched_switch(int ops)
>  	mutex_unlock(&sched_register_mutex);
>  }
>  
> -void tracing_start_cmdline_record(void)
> +int tracing_start_cmdline_record(void)
>  {
> -	tracing_start_sched_switch(RECORD_CMDLINE);
> +	return tracing_start_sched_switch(RECORD_CMDLINE);
>  }
>  
>  void tracing_stop_cmdline_record(void)
> @@ -140,9 +149,9 @@ void tracing_stop_cmdline_record(void)
>  	tracing_stop_sched_switch(RECORD_CMDLINE);
>  }
>  
> -void tracing_start_tgid_record(void)
> +int tracing_start_tgid_record(void)
>  {
> -	tracing_start_sched_switch(RECORD_TGID);
> +	return tracing_start_sched_switch(RECORD_TGID);
>  }
>  
>  void tracing_stop_tgid_record(void)
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index d88c44f1dfa5..238e7451f8e4 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -1084,7 +1084,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  		warn_failed_init_tracer(trace, ret);
>  		goto out;
>  	}
> -	tracing_start_cmdline_record();
> +	ret = tracing_start_cmdline_record();
> +	if (ret) {
> +		unregister_ftrace_graph(&fgraph_ops);
> +		warn_failed_init_tracer(trace, ret);
> +		goto out;
> +	}
>  
>  	/* Sleep for a 1/10 of a second */
>  	msleep(100);

