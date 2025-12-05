Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7703314C1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942111; cv=none; b=f7rwJdLEVI/4Nf3k6nYYHSffRfNIIwmJgWGOoD0X55xohFxYeFa1qNhsmDFrFVuaqMWh4+rzBTlbPMkmrokf4gWFkv1NZoGgNvBKB3KEqpCQZ/q8j5jGQFf0lZlBmLbagSt/J6p4qMger2j241ab5tU4EZfylxXPY7IOt60Tdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942111; c=relaxed/simple;
	bh=YfXNi9cdRvPJl6S42y5MP79RVjPlHSkUH7YsAbqnv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0lhTdmD2FPzJlQjdFBUeXtWNmY8yC7UoS7XvOIyIQQkfQdhhAY1d3fRyeD5E5FT/HZXLubbNMYrJ19WH4WNox+D4LUoVs+PYbmtqT8f31dOppvZfuY50Uiw5gZEg7wUz0ikaMjcnZSUXO+s2RLRR4vWmU/axLapmGCa3Hx8P2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtY5AD/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtY5AD/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764942104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9GJmzLJTF6vGcmdQglUQGwIHc7i2wQi+5BPsszP2DU=;
	b=gtY5AD/jnVC8xNrhV8a0/0VQg4D/v9XjzoUGrIBZDJ57QsmzFg6NN5STecrber8igwgwYf
	aOMS7KhdLo7Yc3DGz2oLwxkdxE7UEQ9NU0XP80nHm/Gxtf6ygvI1Zc8mh8YiuIrIiejJ+F
	sUPFbg6Fv29u/I+77re/iV2EDvLK3vQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-mrIdv6K-OQ-pwxkVCqQbbA-1; Fri,
 05 Dec 2025 08:41:40 -0500
X-MC-Unique: mrIdv6K-OQ-pwxkVCqQbbA-1
X-Mimecast-MFC-AGG-ID: mrIdv6K-OQ-pwxkVCqQbbA_1764942099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9CED195608E;
	Fri,  5 Dec 2025 13:41:38 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092D5180045B;
	Fri,  5 Dec 2025 13:41:32 +0000 (UTC)
Date: Fri, 5 Dec 2025 08:41:30 -0500
From: Phil Auld <pauld@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 09/13] sched: Add deadline tracepoints
Message-ID: <20251205134130.GB400972@pauld.westford.csb>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205131621.135513-10-gmonaco@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Dec 05, 2025 at 02:16:17PM +0100 Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl_se, cpu):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl_se, cpu):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_server_start(dl_se, cpu):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl_se, cpu):
>     Called when a deadline server is stopped
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

These seem like they might be useful outside of the RV context as well.

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> ---
> 
> Notes:
>     V3:
>     * Rename dl argument to dl_se in tracepoints
> 
>  include/trace/events/sched.h | 16 ++++++++++++++++
>  kernel/sched/core.c          |  4 ++++
>  kernel/sched/deadline.c      |  7 +++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..366b2e8ec40c 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,22 @@ DECLARE_TRACE(sched_set_need_resched,
>  	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
>  	TP_ARGS(tsk, cpu, tif));
>  
> +DECLARE_TRACE(sched_dl_throttle,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> +	TP_ARGS(dl_se, cpu));
> +
> +DECLARE_TRACE(sched_dl_replenish,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> +	TP_ARGS(dl_se, cpu));
> +
> +DECLARE_TRACE(sched_dl_server_start,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> +	TP_ARGS(dl_se, cpu));
> +
> +DECLARE_TRACE(sched_dl_server_stop,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> +	TP_ARGS(dl_se, cpu));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5516778c19eb..3aed0ed6f2e9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -122,6 +122,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 319439fe1870..2192e9f42e02 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -733,6 +733,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
>  		dl_se->dl_throttled = 1;
>  		dl_se->dl_defer_armed = 1;
>  	}
> +	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
>  }
>  
>  /*
> @@ -850,6 +851,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	if (dl_se->dl_throttled)
>  		dl_se->dl_throttled = 0;
>  
> +	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
> +
>  	/*
>  	 * If this is the replenishment of a deferred reservation,
>  	 * clear the flag and return.
> @@ -1341,6 +1344,7 @@ static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
>  	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
>  		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
>  			return;
> +		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
>  		dl_se->dl_throttled = 1;
>  		if (dl_se->runtime > 0)
>  			dl_se->runtime = 0;
> @@ -1504,6 +1508,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  
>  throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> +		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
>  		dl_se->dl_throttled = 1;
>  
>  		/* If requested, inform the user about runtime overruns. */
> @@ -1795,6 +1800,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>  	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
>  		return;
>  
> +	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq));
>  	dl_se->dl_server_active = 1;
>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>  	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
> @@ -1806,6 +1812,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>  	if (!dl_server(dl_se) || !dl_server_active(dl_se))
>  		return;
>  
> +	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq));
>  	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
>  	hrtimer_try_to_cancel(&dl_se->dl_timer);
>  	dl_se->dl_defer_armed = 0;
> -- 
> 2.52.0
> 
> 

-- 

