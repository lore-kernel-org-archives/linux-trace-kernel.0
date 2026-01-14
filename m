Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98642184;
	Wed, 14 Jan 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768349263; cv=none; b=Xuvse9d3rANNI1dAzPHxwqBaLGcyf+1XAS49WH48wPUiZBDvW8+F5pAZtuxt+pcMAVCZySuNW8VYjWpsegfK6BE9XbDE7yjFc0HlbYzRGqJ/P36LGVq6YPRblO8Z4+oe0flKeb63n3QXJzgtT1G1+uGJwH+QlRddBJTRz04S0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768349263; c=relaxed/simple;
	bh=mRcJM1sPgpaagXL/gypCVs95fqo57KyskFtRMw+AzE0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cFAsQUuNblPrzL3/IiPPtm4G9SKkWAQTYx3pJyVgBJNw75zgmgSnyH4+tLZIJE1V9YHFp3CodMX+erkqiGiWD3SterLWzTZCvBTlZj35sDmf13A/AgodHUcEd/WmVm5Lnu0OlgwbBithhOcC1T5Zkztd7t31NriSOo9Wc5pNMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE6JmlqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE6JmlqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C66C116C6;
	Wed, 14 Jan 2026 00:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768349263;
	bh=mRcJM1sPgpaagXL/gypCVs95fqo57KyskFtRMw+AzE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fE6JmlqYhIgRx8Lx+9fdRYc9wrxjuRmclOfKGf0KrxG8pyMXcqrs3qgr8iS8yyw74
	 AX1IdU7MmF3jQCi2TRn30onzEnpaq0gwPmE/Ga3VJKGOhnhk+cac7UyZnKgoO7Qifz
	 FVoJBRCYD0DWLTMOLscCweCIRIeZ92/78DLh0KIJi1Cjy1cc2Qllf/l6NeLIPgVTS/
	 aq1/68U9+pVT+DNy/0K4n3afajdm/a8+9cWDOZSnK4KtsMSfbLrWVVRp6VvoktRhRg
	 VWWBt9lBRggLKdRk/LLFVPa/xnj48XkLpy4sUI9BkFiEOJoOZSQuPnEz+Kl8Lf+2xD
	 rDaNYxC2yZMBA==
Date: Wed, 14 Jan 2026 09:07:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH] tracing: Have show_event_trigger/filter format a bit
 more in columns
Message-Id: <20260114090738.e791b28f94479116fa32ffa6@kernel.org>
In-Reply-To: <20260112153408.18373e73@gandalf.local.home>
References: <20260112153408.18373e73@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 15:34:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> By doing:
> 
>  # trace-cmd sqlhist -e -n futex_wait select TIMESTAMP_DELTA_USECS as lat from sys_enter_futex as start join sys_exit_futex as end on start.common_pid = end.common_pid
> 
> and
> 
>  # trace-cmd start -e futex_wait -f 'lat > 100' -e page_pool_state_release -f 'pfn == 1'
> 
> The output of the show_event_trigger and show_event_filter files are well
> aligned because of the inconsistent 'tab' spacing:
> 
>  ~# cat /sys/kernel/tracing/show_event_triggers
> syscalls:sys_exit_futex	hist:keys=common_pid:vals=hitcount:__lat_12046_2=common_timestamp.usecs-$__arg_12046_1:sort=hitcount:size=2048:clock=global:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__lat_12046_2) [active]
> syscalls:sys_enter_futex	hist:keys=common_pid:vals=hitcount:__arg_12046_1=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]
> 
>  ~# cat /sys/kernel/tracing/show_event_filters
> synthetic:futex_wait	(lat > 100)
> page_pool:page_pool_state_release	(pfn == 1)
> 
> This makes it not so easy to read. Instead, force the spacing to be at
> least 32 bytes from the beginning (one space if the system:event is longer
> than 30 bytes):
> 
>  ~# cat /sys/kernel/tracing/show_event_triggers
> syscalls:sys_exit_futex          hist:keys=common_pid:vals=hitcount:__lat_8125_2=common_timestamp.usecs-$__arg_8125_1:sort=hitcount:size=2048:clock=global:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__lat_8125_2) [active]
> syscalls:sys_enter_futex         hist:keys=common_pid:vals=hitcount:__arg_8125_1=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]
> 
>  ~# cat /sys/kernel/tracing/show_event_filters
> synthetic:futex_wait             (lat > 100)
> page_pool:page_pool_state_release (pfn == 1)
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> [
>   This is based on top of these patches:
>     https://lore.kernel.org/linux-trace-kernel/20260105142939.2655342-1-atomlin@atomlin.com/
> ]
>  kernel/trace/trace_events.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 36936697fa2a..f372a6374164 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1662,6 +1662,18 @@ static void t_stop(struct seq_file *m, void *p)
>  	mutex_unlock(&event_mutex);
>  }
>  
> +static int get_call_len(struct trace_event_call *call)
> +{
> +	int len;
> +
> +	/* Get the length of "<system>:<event>" */
> +	len = strlen(call->class->system) + 1;
> +	len += strlen(trace_event_name(call));
> +
> +	/* Set the index to 32 bytes to separate event from data */
> +	return len >= 32 ? 1 : 32 - len;
> +}
> +
>  /**
>   * t_show_filters - seq_file callback to display active event filters
>   * @m: The seq_file interface for formatted output
> @@ -1676,14 +1688,17 @@ static int t_show_filters(struct seq_file *m, void *v)
>  	struct trace_event_file *file = v;
>  	struct trace_event_call *call = file->event_call;
>  	struct event_filter *filter;
> +	int len;
>  
>  	guard(rcu)();
>  	filter = rcu_dereference(file->filter);
>  	if (!filter || !filter->filter_string)
>  		return 0;
>  
> -	seq_printf(m, "%s:%s\t%s\n", call->class->system,
> -		   trace_event_name(call), filter->filter_string);
> +	len = get_call_len(call);
> +
> +	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
> +		   trace_event_name(call), len, "", filter->filter_string);
>  
>  	return 0;
>  }
> @@ -1702,6 +1717,7 @@ static int t_show_triggers(struct seq_file *m, void *v)
>  	struct trace_event_file *file = v;
>  	struct trace_event_call *call = file->event_call;
>  	struct event_trigger_data *data;
> +	int len;
>  
>  	/*
>  	 * The event_mutex is held by t_start(), protecting the
> @@ -1710,9 +1726,11 @@ static int t_show_triggers(struct seq_file *m, void *v)
>  	if (list_empty(&file->triggers))
>  		return 0;
>  
> +	len = get_call_len(call);
> +
>  	list_for_each_entry_rcu(data, &file->triggers, list) {
> -		seq_printf(m, "%s:%s\t", call->class->system,
> -			   trace_event_name(call));
> +		seq_printf(m, "%s:%s%*.s", call->class->system,
> +			   trace_event_name(call), len, "");
>  
>  		data->cmd_ops->print(m, data);
>  	}
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
