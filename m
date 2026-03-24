Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC0239085;
	Tue, 24 Mar 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378968; cv=none; b=G5MlY7DK2nQpPrhnmlgnpVnrCruCaDFwCbyjEHQzLjHrbf4YdTX9EEOat8ghrRgDPfSdZOYOC7ikw+gGohPGsMyH1H1aLYd1cJdu19mAfKrPdF//WoVWVjUKq/NpkabSxq+fC3x+k4qBF0UCRnSegl9bunqVYmA61PkQULSKo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378968; c=relaxed/simple;
	bh=pLADkz47Gi6G2xqFECg+KAw/tEwaX0Gk5QNHrL+Ja1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qwj94lsdaL/8zYkzVhexNMJcpDZpGeteb+wIws6Ua5juJ5vE/+S59fnusasg5wyXUquCe350nCwzoa/hr5xKWCssw229Se4T7KIYM6D8VoFf3WMUrU7uAwzaRHk0cVtgKNmPSM3oz/2WQlQzVo5aTlXHSo/OcUJQU+0sepGit5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 84DAE5875A;
	Tue, 24 Mar 2026 18:53:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 52DDE41;
	Tue, 24 Mar 2026 18:53:05 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:53:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tracing: drain deferred trigger frees if kthread
 startup fails
Message-ID: <20260324145347.29d8ee75@gandalf.local.home>
In-Reply-To: <20260310064715.527906-3-atwellwea@gmail.com>
References: <20260310064715.527906-1-atwellwea@gmail.com>
	<20260310064715.527906-3-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 52DDE41
X-Stat-Signature: h4pojkar4dzkwehjisye7c5wxpt4quig
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vYR1P7wsVSGfjTF+LiWTz9Xhq3KtXLDM=
X-HE-Tag: 1774378385-130353
X-HE-Meta: U2FsdGVkX18tIg+/ueuE6N8C+J4Sz7foWLk1VvuUjnOaZh7FLK7zbHJIigaaB5b068hpdbfAqgutQcCOJ6CqnQngiSBac0OHyJ0JqBLh/VM8doqmQZ7J5q0vUOLIHV1Tt70j7jN0VglEfp/M49PNQwlFUaTclhFze+F4fEh02aLm5iQBaVa33ylkHOgVXKPObmmJ5xWiBbGdeOw+sbPSbitaEbd+EdmmbiM926C21jCuSz/JQ9yY3PBjtLPd0Dt7Vz/W47XSE48LgR6riKL5/pYY1gnlVl3N6uEZKju/haZD8cUHgVwNnI8m50rXDGRhmoIE4aftqXDHpJlfF3aWxsYE5Z/vAxHA

On Tue, 10 Mar 2026 00:47:15 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> Boot-time trigger registration can fail before the trigger-data cleanup
> kthread exists. Deferring those frees until late init is fine, but the
> post-boot fallback must still drain the deferred list if kthread
> creation never succeeds.
> 
> Otherwise, boot-deferred nodes can accumulate on
> trigger_data_free_list, later frees fall back to synchronously freeing
> only the current object, and the older queued entries are leaked
> forever.
> 
> Keep the deferred boot-time behavior, but when kthread creation fails,
> drain the whole queued list synchronously. Do the same in the late-init
> drain path so queued entries are not stranded there either.
> 
> Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 79 ++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d5230b759a2d..428b46272ac8 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -22,6 +22,39 @@ static struct task_struct *trigger_kthread;
>  static struct llist_head trigger_data_free_list;
>  static DEFINE_MUTEX(trigger_data_kthread_mutex);
>  
> +static int trigger_kthread_fn(void *ignore);
> +
> +static void trigger_start_kthread_locked(void)
> +{
> +	lockdep_assert_held(&trigger_data_kthread_mutex);
> +
> +	if (!trigger_kthread) {
> +		struct task_struct *kthread;
> +
> +		kthread = kthread_create(trigger_kthread_fn, NULL,
> +					 "trigger_data_free");

This only creates the thread and doesn't start it. The function name is
confusing. Please change it to:

	trigger_create_kthread_locked()


> +		if (!IS_ERR(kthread))
> +			WRITE_ONCE(trigger_kthread, kthread);
> +	}
> +}
> +
> +static void trigger_data_free_queued_locked(void)
> +{
> +	struct event_trigger_data *data, *tmp;
> +	struct llist_node *llnodes;
> +
> +	lockdep_assert_held(&trigger_data_kthread_mutex);
> +
> +	llnodes = llist_del_all(&trigger_data_free_list);
> +	if (!llnodes)
> +		return;
> +
> +	tracepoint_synchronize_unregister();
> +
> +	llist_for_each_entry_safe(data, tmp, llnodes, llist)
> +		kfree(data);
> +}
> +
>  /* Bulk garbage collection of event_trigger_data elements */
>  static int trigger_kthread_fn(void *ignore)
>  {
> @@ -56,30 +89,50 @@ void trigger_data_free(struct event_trigger_data *data)
>  	if (data->cmd_ops->set_filter)
>  		data->cmd_ops->set_filter(NULL, data, NULL);
>  
> +	/*
> +	 * Boot-time trigger registration can fail before kthread creation
> +	 * works. Keep the deferred-free semantics during boot and let late
> +	 * init start the kthread to drain the list.
> +	 */
> +	if (system_state == SYSTEM_BOOTING && !trigger_kthread) {
> +		llist_add(&data->llist, &trigger_data_free_list);
> +		return;
> +	}
> +
>  	if (unlikely(!trigger_kthread)) {
>  		guard(mutex)(&trigger_data_kthread_mutex);
> +
> +		trigger_start_kthread_locked();
>  		/* Check again after taking mutex */
>  		if (!trigger_kthread) {
> -			struct task_struct *kthread;
> -
> -			kthread = kthread_create(trigger_kthread_fn, NULL,
> -						 "trigger_data_free");
> -			if (!IS_ERR(kthread))
> -				WRITE_ONCE(trigger_kthread, kthread);
> +			llist_add(&data->llist, &trigger_data_free_list);
> +			/* Drain the queued frees synchronously if startup failed. */

                                                       s/startup/creation/

> +			trigger_data_free_queued_locked();
> +			return;
>  		}
>  	}

-- Steve

>  
> -	if (!trigger_kthread) {
> -		/* Do it the slow way */
> -		tracepoint_synchronize_unregister();
> -		kfree(data);
> -		return;
> -	}
> -
>  	llist_add(&data->llist, &trigger_data_free_list);
>  	wake_up_process(trigger_kthread);
>  }
>  
> +static int __init trigger_data_free_init(void)
> +{
> +	guard(mutex)(&trigger_data_kthread_mutex);
> +
> +	if (llist_empty(&trigger_data_free_list))
> +		return 0;
> +
> +	trigger_start_kthread_locked();
> +	if (trigger_kthread)
> +		wake_up_process(trigger_kthread);
> +	else
> +		trigger_data_free_queued_locked();
> +
> +	return 0;
> +}
> +late_initcall(trigger_data_free_init);
> +
>  static inline void data_ops_trigger(struct event_trigger_data *data,
>  				    struct trace_buffer *buffer,  void *rec,
>  				    struct ring_buffer_event *event)

