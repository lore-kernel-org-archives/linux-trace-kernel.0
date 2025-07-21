Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBA19DF5F;
	Mon, 21 Jul 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110108; cv=none; b=VRS5BhpIRYDKWUFZ1+VYy6JAiS8i7Ufc8vagD49NxbxXOrjOdqq2rruDVs+DzpphHzUN20hsrW+uT8Xb3+pvYfqFwbyei+9DM8h4LJVTF0J3s73vvukDj4fqSf5tp6HTzPp2Y7z892B3bznquxp8VZJ0tYiHh7kLkF5BxOmybHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110108; c=relaxed/simple;
	bh=3DS3uzjG6N3WCOFHWoA5fZXa7WeXVp78DTzHs+kqFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2q4u1JvZHVvu0evWFDeXx5JwfiiJEPIxohboWelYdnrO91ntIa1OcKFoc7gvN3CE6OZukr1bX+nTuS9Cs8Aks3i74DJEMMGiFEqTl/54YH2HFAvcBld0BK5G688NqNWqtC4qgkjvuz6xKb3FVcC8JQps5e3Y6tQwwgaoq5dnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXoDpa8N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGQW52UR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXoDpa8N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGQW52UR"
Date: Mon, 21 Jul 2025 17:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753110105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ9eChO3kN1XuAeYWrh3QXFMKp+D4y3Q8Wq3aIbkrn8=;
	b=OXoDpa8NdUIP5XVjf+qdYOMFt2Q9xs7VpTiLyyWWYwNb5RQsrYtTNtDabOyqgD2qaybUma
	ggr7wq+ufZN9VCELdTRhe953uJl9TbTdKOyQvL1+2YIiiKZOjEfBBvO/hnR668ZGFgCZrs
	HBlCmKJBSm5KqaeKA0UtQB8Zbk07LIT4SPVtXIfOXQscy1vwli/7MC29CDln0me9KpkO9B
	Fa397OXeNUpNIPMeR9dOaR+p7gvuiUez3n4g6r0lkN2kH52+HKybCuYcxPU0RsIdCfkKCk
	cHI6f8KZNcOjRMuYVpAMz2gco+j1n5ikgoA6govRezrO2XKj082oi3jBVCuEFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753110105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ9eChO3kN1XuAeYWrh3QXFMKp+D4y3Q8Wq3aIbkrn8=;
	b=pGQW52UR+/1WO1G1PFYzV8MajAzd9qV1TfdjLiWRKQLUUj0DT6Wvrp/JG20YGtzPLVHAlk
	5HMDzQzprTgcgiCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 10/14] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250721150143.sl2MIKSi@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
 <20250721082325.71554-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721082325.71554-11-gmonaco@redhat.com>

On Mon, Jul 21, 2025 at 10:23:20AM +0200, Gabriele Monaco wrote:
> DA monitor can be accessed from multiple cores simultaneously, this is
> likely, for instance when dealing with per-task monitors reacting on
> events that do not always occur on the CPU where the task is running.
> This can cause race conditions where two events change the next state
> and we see inconsistent values. E.g.:
> 
>   [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
>   [63] event_srs: 27: sleepable x sched_set_state_sleepable -> sleepable
>   [63] error_srs: 27: event sched_switch_suspend not expected in the state running
> 
> In this case the monitor fails because the event on CPU 62 wins against
> the one on CPU 63, although the correct state should have been
> sleepable, since the task get suspended.
> 
> Detect if the current state was modified by using try_cmpxchg while
> storing the next value. If it was, try again reading the current state.
> After a maximum number of failed retries, react by calling a special
> tracepoint, print on the console and reset the monitor.
> 
> Remove the functions da_monitor_curr_state() and da_monitor_set_state()
> as they only hide the underlying implementation in this case.
> 
> Monitors where this type of condition can occur must be able to account
> for racing events in any possible order, as we cannot know the winner.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>
>  static inline bool										\
>  da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
>  {												\
> -	type curr_state = da_monitor_curr_state_##name(da_mon);					\
> -	type next_state = model_get_next_state_##name(curr_state, event);			\
> -												\
> -	if (next_state != INVALID_STATE) {							\
> -		da_monitor_set_state_##name(da_mon, next_state);				\
> -												\
> -		trace_event_##name(model_get_state_name_##name(curr_state),			\
> -				   model_get_event_name_##name(event),				\
> -				   model_get_state_name_##name(next_state),			\
> -				   model_is_final_state_##name(next_state));			\
> -												\
> -		return true;									\
> +	enum states_##name curr_state, next_state;						\
> +												\
> +	curr_state = READ_ONCE(da_mon->curr_state);						\
> +	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
> +		next_state = model_get_next_state_##name(curr_state, event);			\
> +		if (next_state == INVALID_STATE) {						\
> +			cond_react_##name(curr_state, event);					\
> +			trace_error_##name(model_get_state_name_##name(curr_state),		\
> +					   model_get_event_name_##name(event));			\
> +			return false;								\
> +		}										\
> +		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
> +			trace_event_##name(model_get_state_name_##name(curr_state),		\
> +					   model_get_event_name_##name(event),			\
> +					   model_get_state_name_##name(next_state),		\
> +					   model_is_final_state_##name(next_state));		\
> +			return true;								\
> +		}										\
>  	}											\
>  												\
> -	cond_react_##name(curr_state, event);							\
> -												\
> -	trace_error_##name(model_get_state_name_##name(curr_state),				\
> -			   model_get_event_name_##name(event));					\
> -												\
> +	trace_rv_retries_error(#name, smp_processor_id());					\
> +	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
> +		" retries reached, resetting monitor %s", #name);				\

smp_processor_id() requires preemption to be disabled.

At the moment, trace point handler is called with preemption disabled, so
we are fine. But there is plan to change that:
https://lore.kernel.org/lkml/20241206120709.736f943e@gandalf.local.home/T/#u

Perhaps use get_cpu() and put_cpu() instead?

Nam
