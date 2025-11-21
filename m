Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3C2C0279;
	Fri, 21 Nov 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737931; cv=none; b=euWD+3dEbvnG483cO4t7SKgJm8MyHItw8onLjKaQ/gpRWLA3VD3w9uZbc/DgsEvlBu8VsKoLrAn87mXit4JVWkUnsxsReD3tzgVdl4N8KpHGYKW607cucOIPwyEWqK13QIKkSOpabRqpqoEEYtDM6advXYiZpT9LmW4n8wSJ5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737931; c=relaxed/simple;
	bh=gTQb9zo6vJvBTD8yU804MMnfH1N6e8z1FQ01YQ3ekTs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EmeU7glDcxexQyJxXmYzwifSLPRPpfjv2FJdy4RH1XadMAeJnKP10nlxtsLazEXCP0ZHHvD5JxSHbXA4UeHvekvHdSkeHlhxqaxl2lJ8HrBRFyRipvFamIBMK5/UJC1j/G9bJs9h3vafSYFYWUe4aHfNM6KIpYg9mK4ra2GldPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWi2xbAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWi2xbAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E340FC4CEF1;
	Fri, 21 Nov 2025 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737931;
	bh=gTQb9zo6vJvBTD8yU804MMnfH1N6e8z1FQ01YQ3ekTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWi2xbAhYaKnytMDqTg1B7XULya8oqdTR4IS7EUp6z+KIMZxuZJEe2tgbGMTCDFav
	 wXCoeB+yY08vDCdpsWYWeqCrHyMH8K7UVjEPAnin+lyWo/jPqLtalrzdkMAqM20lx7
	 janchBkw+xDLGNE++FkuCNc4uYOiatWBFpivfgAZ1w4tj9A0rDMmutQkvQFmU194V6
	 BlHBjcbIoCc2V5PXCakomCC7lRyVRPtfjU8N62z1D6Ji2YNyePZ7QBfGznSiL7UFbf
	 3yGRs7YhH1WzpKW2H16OeeytxmpJQ0Obwa/rxn0aJApx+uGflhmJo240VzMt2vdiX1
	 HjWmGlR3KZeHg==
Date: Sat, 22 Nov 2025 00:12:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing: Add bulk garbage collection of freeing
 event_trigger_data
Message-Id: <20251122001206.57ad6d77b96726421503da41@kernel.org>
In-Reply-To: <20251120205710.151041470@kernel.org>
References: <20251120205600.570673392@kernel.org>
	<20251120205710.151041470@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:56:02 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The event trigger data requires a full tracepoint_synchronize_unregister()
> call before freeing. That call can take 100s of milliseconds to complete.
> In order to allow for bulk freeing of the trigger data, it can not call
> the tracepoint_synchronize_unregister() for every individual trigger data
> being free.
> 
> Create a kthread that gets created the first time a trigger data is freed,
> and have it use the lockless llist to get the list of data to free, run
> the tracepoint_synchronize_unregister() then free everything in the list.
> 
> By freeing hundreds of event_trigger_data elements together, it only
> requires two runs of the synchronization function, and not hundreds of
> runs. This speeds up the operation by orders of magnitude (milliseconds
> instead of several seconds).
> 

I have some nitpicks, but basically looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.h                |  1 +
>  kernel/trace/trace_events_trigger.c | 56 +++++++++++++++++++++++++++--
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5863800b1ab3..fd5a6daa6c25 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1808,6 +1808,7 @@ struct event_trigger_data {
>  	char				*name;
>  	struct list_head		named_list;
>  	struct event_trigger_data	*named_data;
> +	struct llist_node		llist;
>  };
>  
>  /* Avoid typos */
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index e5dcfcbb2cd5..16e3449f3cfe 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -6,26 +6,76 @@
>   */
>  
>  #include <linux/security.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/ctype.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
> +#include <linux/llist.h>

nit: Shouldn't we include this in "trace.h" too, because llist_node is used?

>  
>  #include "trace.h"
>  
>  static LIST_HEAD(trigger_commands);
>  static DEFINE_MUTEX(trigger_cmd_mutex);
>  
> +static struct task_struct *trigger_kthread;
> +static struct llist_head trigger_data_free_list;
> +static DEFINE_MUTEX(trigger_data_kthread_mutex);
> +
> +/* Bulk garbage collection of event_trigger_data elements */
> +static int trigger_kthread_fn(void *ignore)
> +{
> +	struct event_trigger_data *data, *tmp;
> +	struct llist_node *llnodes;
> +
> +	/* Once this task starts, it lives forever */
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (llist_empty(&trigger_data_free_list))
> +			schedule();
> +
> +		__set_current_state(TASK_RUNNING);
> +
> +		llnodes = llist_del_all(&trigger_data_free_list);
> +
> +		/* make sure current triggers exit before free */
> +		tracepoint_synchronize_unregister();
> +
> +		llist_for_each_entry_safe(data, tmp, llnodes, llist)
> +			kfree(data);
> +	}
> +
> +	return 0;
> +}
> +
>  void trigger_data_free(struct event_trigger_data *data)
>  {
>  	if (data->cmd_ops->set_filter)
>  		data->cmd_ops->set_filter(NULL, data, NULL);
>  
> -	/* make sure current triggers exit before free */
> -	tracepoint_synchronize_unregister();
> +	if (unlikely(!trigger_kthread)) {
> +		guard(mutex)(&trigger_data_kthread_mutex);
> +		/* Check again after taking mutex */
> +		if (!trigger_kthread) {
> +			struct task_struct *kthread;
> +
> +			kthread = kthread_create(trigger_kthread_fn, NULL,
> +						 "trigger_data_free");
> +			if (!IS_ERR(kthread))
> +				WRITE_ONCE(trigger_kthread, kthread);
> +		}
> +	}
> +

Hmm,
	/* This continues above error case, but we should do it without lock. */
?

> +	if (!trigger_kthread) {
> +		/* Do it the slow way */
> +		tracepoint_synchronize_unregister();
> +		kfree(data);
> +		return;
> +	}
>  
> -	kfree(data);
> +	llist_add(&data->llist, &trigger_data_free_list);
> +	wake_up_process(trigger_kthread);
>  }
>  
>  static inline void data_ops_trigger(struct event_trigger_data *data,
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
