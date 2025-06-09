Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBE215766;
	Mon,  9 Jun 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490793; cv=none; b=c2w80bz9Jpg5TPyBYyRGFBsC9ZRgxJZMNxFjo3poevE9RXrt2/qyU6lTpo+DN3PbGUgsXgdcgM651mf87+2RAXr+ObY/DczII+wvFo+kNZIoRCI9rakjkPARgH68I6bqYUsjq6xZF5ZNaEV+ZGpATiX89ZnXCpmEaE4Q7K+4ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490793; c=relaxed/simple;
	bh=4abGnwIone7ePw6F2MTDhlNwDOoT+2r0m9g9eAvFQjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu8M8Fc+e986vdX881akn7hHTL6IwmHo89ykGFL/75kwcZbMIl/drMYw3nAeq6SHLizS0QNFImB+HXm1odCUsk1VyhOicE7NmPysDjidnxLB/YDQiNxemfmDDC2SIdnE2P/iaqhFZw10HTl6cE1TNZz0Ruh1Ewfz8L7deePzEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs0frPTP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs0frPTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D174C4CEEB;
	Mon,  9 Jun 2025 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490793;
	bh=4abGnwIone7ePw6F2MTDhlNwDOoT+2r0m9g9eAvFQjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bs0frPTPUzeZhB7xcJqML+/23l1Ul7E/PDG+1Q/XInOXY7+kxsojg4yN4/y/+mD+U
	 H4qUTUVk8JnAUF4DNo8sc37HhatzjVAzUfl+mD750DVNwouUjaj1X1BPDAMQbR2HOr
	 0Z+GtLzlqH4SNdDn1inSP68Siu4fsQs4lmWsqdsQtiEftPu1c3I0MI5FLdkmTPhu6f
	 vX7dZamIC90ys2XNVKRk1Uy5V0mcy2+3Zn76texuh2+ZSXMyMkwPMFwg5KDXC0wTaJ
	 EZHvznruqVgLLmKA6tASDKl8on4Tk35ZkXnMk23cX37E71LjryUJxOiV2EeSG9unf5
	 SzIVw0PcUHiGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5CB8CE0B6C; Mon,  9 Jun 2025 10:39:52 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:39:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Use queue_rcu_work() to free filters
Message-ID: <0ee99715-7877-4d94-9ae5-5b0e23f34aae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250609131732.04fd303b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609131732.04fd303b@gandalf.local.home>

On Mon, Jun 09, 2025 at 01:17:32PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Freeing of filters requires to wait for both an RCU grace period as well as
> a RCU task trace wait period after they have been detached from their
> lists. The trace task period can be quite large so the freeing of the
> filters was moved to use the call_rcu*() routines. The problem with that is
> that the callback functions of call_rcu*() is done from a soft irq and can
> cause latencies if the callback takes a bit of time.
> 
> The filters are freed per event in a system and the syscalls system
> contains an event per system call, which can be over 700 events. Freeing 700
> filters in a bottom half is undesirable.
> 
> Instead, move the freeing to use queue_rcu_work() which is done in task
> context.
> 
> Link: https://lore.kernel.org/all/9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop/
> 
> Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you, and looks good to me.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Note, I added a Fixes tag but not a stable tag as this is a nice-to-have
> but doesn't hit the level of critical fix to backport or add to an rc
> release. If someone wants to back port it, feel free.
> 
>  kernel/trace/trace_events_filter.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index ea8b364b6818..b6fe8167ef01 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1344,13 +1344,14 @@ struct filter_list {
>  
>  struct filter_head {
>  	struct list_head	list;
> -	struct rcu_head		rcu;
> +	union {
> +		struct rcu_head		rcu;
> +		struct rcu_work		rwork;
> +	};
>  };
>  
> -
> -static void free_filter_list(struct rcu_head *rhp)
> +static void free_filter_list(struct filter_head *filter_list)
>  {
> -	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
>  	struct filter_list *filter_item, *tmp;
>  
>  	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
> @@ -1361,9 +1362,20 @@ static void free_filter_list(struct rcu_head *rhp)
>  	kfree(filter_list);
>  }
>  
> +static void free_filter_list_work(struct work_struct *work)
> +{
> +	struct filter_head *filter_list;
> +
> +	filter_list = container_of(to_rcu_work(work), struct filter_head, rwork);
> +	free_filter_list(filter_list);
> +}
> +
>  static void free_filter_list_tasks(struct rcu_head *rhp)
>  {
> -	call_rcu(rhp, free_filter_list);
> +	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
> +
> +	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
> +	queue_rcu_work(system_wq, &filter_list->rwork);
>  }
>  
>  /*
> @@ -1462,7 +1474,7 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
>  	tracepoint_synchronize_unregister();
>  
>  	if (head)
> -		free_filter_list(&head->rcu);
> +		free_filter_list(head);
>  
>  	list_for_each_entry(file, &tr->events, list) {
>  		if (file->system != dir || !file->filter)
> @@ -2307,7 +2319,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	return 0;
>   fail:
>  	/* No call succeeded */
> -	free_filter_list(&filter_list->rcu);
> +	free_filter_list(filter_list);
>  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  	return -EINVAL;
>   fail_mem:
> @@ -2317,7 +2329,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	if (!fail)
>  		delay_free_filter(filter_list);
>  	else
> -		free_filter_list(&filter_list->rcu);
> +		free_filter_list(filter_list);
>  
>  	return -ENOMEM;
>  }
> -- 
> 2.47.2
> 
