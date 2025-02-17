Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18C21D59D;
	Mon, 17 Feb 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810306; cv=none; b=S+gA2AsxButU31PPDm8yfi1vMG6CdRdbROqQhVCv3wWko0d4Etmu+RbKCmd/GpgywuXXGQ00oWet6qybCXLmLBuYoqttU0NX2S0cIYUd3bsI9lxbaUG1SMAbsO7crE9Uy6MUerkBfA/d8DXmzbbeUJMO5bFhfs1c2NIxDjHmyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810306; c=relaxed/simple;
	bh=gJssyFMbKSFlkJOhj2UTG0SBRegf3zS5G+kMehMWhxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tM5JhYXM1gk39mLdzk+a/65LIQv6jRZc/sZjGYq6sbX7gr/r+4v4KCrWUMA6tnQWcNcu99k8FS4h/1uEpMCXIjXmho1+TjoyFNgLMwRdj/BY+V9RmCnQTcpICNVcGeKT3iNywYpQs/ODtbWaIu9YPDGoaeWPIgrDMuV81jy71no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FD1C4CED1;
	Mon, 17 Feb 2025 16:38:25 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:38:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250217113844.5ad7893c@gandalf.local.home>
In-Reply-To: <20250213090819.419470-4-gmonaco@redhat.com>
References: <20250213090819.419470-1-gmonaco@redhat.com>
	<20250213090819.419470-4-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 10:08:01 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 9ea4c404bd4ef..cc3be04fe9986 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -824,6 +824,19 @@ DECLARE_TRACE(sched_compute_energy_tp,
>  		 unsigned long max_util, unsigned long busy_time),
>  	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
>  
> +DECLARE_TRACE(sched_entry_tp,
> +	TP_PROTO(bool preempt, unsigned long ip),
> +	TP_ARGS(preempt, ip));
> +
> +DECLARE_TRACE(sched_exit_tp,
> +	TP_PROTO(bool is_switch, unsigned long ip),
> +	TP_ARGS(is_switch, ip));
> +
> +DECLARE_TRACE_CONDITION(sched_set_state_tp,
> +	TP_PROTO(struct task_struct *tsk, int curr_state, int state),
> +	TP_ARGS(tsk, curr_state, state),
> +	TP_CONDITION(!!curr_state != !!state));

I don't think you need to pass in state. Just have it be:

	TP_CONDITION(!!(tsk->__state) != !!state));


> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea9..4aa6af026e05c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -491,6 +491,19 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> +/* need a wrapper since we may need to trace from modules */
> +EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
> +
> +/*
> + * Do not call this function directly since it won't check if the tp is enabled.
> + * Call the helper macro trace_set_current_state instead.
> + */
> +void __do_trace_set_current_state(int state_value)
> +{
> +	__do_trace_sched_set_state_tp(current, current->__state, state_value);

And this should not be using the internal macros of a trace point. It should be:

	trace_sched_set_state_tp(current, state_value);

(I removed the current->__state as mentioned above).


> +}
> +EXPORT_SYMBOL(__do_trace_set_current_state);
> +

-- Steve
