Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B40258CDC;
	Thu, 21 Aug 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778731; cv=none; b=uPTG6/gl24uhkt7Rhq3hNjpvrVrdWkwE/skH33X4wdUbh83GhL35kvkq/Dr1s+wcU61eIYbS0yIuK6Xp3+00Aj33jNZFW2Aj7+CU0tfgsnb8m7fxMoHWO8HbN6DQINuCcUxL5qAHyDsK/Fb5hUShT0VuDkTC0+EijH7o9BhDbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778731; c=relaxed/simple;
	bh=H67F/aSoT2bAJ26vjA4tgQFXsQYWBKeBzptjwlgxkhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+mIE+3XgyqmOtmMrAunatan/epAZhWV4PTZgtSVgdyPPBZ6Z6mD5mjKIG9yXnoa8v3KfzorfocObB/HXmuuk8f5HoPXHassTj6vPbwuQ952Nj/U/oWi34JU62e8GKGMU9SOe8D75TXizBqc3FcnieDVkYrJXOUY7Z8sxCLYdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMeo6jM5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EIR+974/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMeo6jM5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EIR+974/"
Date: Thu, 21 Aug 2025 14:18:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755778728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avv++b3z378qpSW0WJb94dLZTms5R2Ugc3V1r+Dk0p8=;
	b=SMeo6jM5QuzfRtqDe9u7nqCtR6t8Ep4QX0LSmFgd88e8D0GKjAy/RhB5V14ETcQ7tU4fAU
	e0R0LvAZgTcFhN6tgp6ys5nJIaNzxbDglqKcjZlNCpbWpL5JaPKBbvpxqoqxKprPmmVtrW
	H9+IY0sUlNbChJDNtOi2h9fzH/MEGeERwd8b3x6Dx3rei37GxwY1kB3aDh9IGGufqykpS+
	edFXqevX94vh+fyr4eix97Dx62EtLonRBv1YqgdJE6Z5VGTTVHRC6nsfrSMNWcr5CqH1+i
	xTL0INMxtSLgU74/y+fBpY+ClWRYlKfBI2OZAsVp2mv9hPsC4sF8hUyBy2n1hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755778728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avv++b3z378qpSW0WJb94dLZTms5R2Ugc3V1r+Dk0p8=;
	b=EIR+974/VdIJ8btrPrsUOOtS9bOHRiOgKTgsyfs2PnYqrEhPEmuCtADuI6pHXniafBaWN1
	GTCbaie4sd2zxPDw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <20250821121846.N0S9tb6x@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-9-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:00PM +0200, Gabriele Monaco wrote:
> Deterministic automata define which events are allowed in every state,
> but cannot define more sophisticated constraint taking into account the
> system's environment (e.g. time or other states not producing events).
> 
> Add the Hybrid Automata monitor type as an extension of Deterministic
> automata where each state transition is validating a constraint on a
> finite number of environment variables.
> Hybrid automata can be used to implement timed automata, where the
> environment variables are clocks.
> 
> Also implement the necessary functionality to handle clock constraints
> (ns or jiffy granularity) on state and events.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

So you have figured out how to deal with the time problem. Cool!

> ---
>  include/linux/rv.h         |  26 +++
>  include/rv/da_monitor.h    |  45 ++++-
>  include/rv/ha_monitor.h    | 384 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/rv/Kconfig    |  13 ++
>  kernel/trace/rv/rv_trace.h |  63 ++++++
>  5 files changed, 526 insertions(+), 5 deletions(-)
>  create mode 100644 include/rv/ha_monitor.h
> 
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 3134681553b4..6a7594080db1 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -83,11 +83,37 @@ struct ltl_monitor {};
>  
>  #endif /* CONFIG_RV_LTL_MONITOR */
>  
> +#ifdef CONFIG_RV_HA_MONITOR
> +/*
> + * In the future, hybrid automata may rely on multiple
> + * environment variables, e.g. different clocks started at
> + * different times or running at different speed.
> + * For now we support only 1 variable.
> + */
> +#define MAX_HA_ENV_LEN 1
> +
> +/*
> + * Hybrid automaton per-object variables.
> + */
> +struct ha_monitor {
> +	struct da_monitor da_mon;
> +	u64 env_store[MAX_HA_ENV_LEN];
> +	struct hrtimer timer;
> +};
> +#define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
> +
> +#else
> +
> +struct ha_monitor { };
> +
> +#endif /* CONFIG_RV_HA_MONITOR */
> +
>  #define RV_PER_TASK_MONITOR_INIT	(CONFIG_RV_PER_TASK_MONITORS)
>  
>  union rv_task_monitor {
>  	struct da_monitor	da_mon;
>  	struct ltl_monitor	ltl_mon;
> +	struct ha_monitor	ha_mon;
>  };

I'm curious, instead of a new monitor type, would the entire thing be
simpler if these new features are added as extension to DA monitor instead?

The existing "pure DA" monitors would just not use the constraint and timer
stuffs and would behave same as before.

Just an idea, I'm not sure how it would look like. But I think we might
reduce some line count.

> +/*
> + * ha_monitor_reset_all_stored - reset all environment variables in the monitor
> + */
> +static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
> +{
> +	for (int i = 0; i < ENV_MAX_STORED; i++)
> +		smp_store_mb(ha_mon->env_store[i], ENV_INVALID_VALUE);

Why is memory barrier needed here?

I think checkpatch.pl should complain about this? Please add a comment
explaining the purpose of this memory barrier.

The same applied for the other memory barriers.

> +}
> +
> +/*
> + * ha_monitor_init_env - setup timer and reset all environment
> + *
> + * Called from a hook in the DA start functions, it supplies the da_mon
> + * corresponding to the current ha_mon.
> + * Not all hybrid automata require the timer, still set it for simplicity.
> + */
> +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> +{
> +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> +
> +	ha_monitor_reset_all_stored(ha_mon);
> +	if (unlikely(!ha_mon->timer.base))
> +		hrtimer_setup(&ha_mon->timer, ha_monitor_timer_callback,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +}
> +
> +/*
> + * ha_monitor_reset_env - stop timer and reset all environment
> + *
> + * Called from a hook in the DA reset functions, it supplies the da_mon
> + * corresponding to the current ha_mon.
> + * Not all hybrid automata require the timer, still clear it for simplicity.
> + */
> +static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
> +{
> +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> +
> +	ha_monitor_reset_all_stored(ha_mon);
> +	/* Initialisation resets the monitor before initialising the timer */
> +	if (likely(ha_mon->timer.base))
> +		ha_cancel_timer(ha_mon);
> +}

Looking at hrtimer->timer.base seems quite hacky. It seems that this could
be broken due to a future hrtimer's refactoring.

Instead, how about moving hrtimer_setup() into monitor's enabling function?
Then you can always hrtimer_cancel() here.

> +/*
> + * ha_cancel_timer - Cancel the timer and return whether it expired
> + *
> + * Return true if the timer was cancelled after expiration but before the
> + * callback could run.
> + */
> +static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
> +{
> +	ktime_t remaining;
> +
> +	if (!hrtimer_active(&ha_mon->timer))
> +		return false;
> +	remaining = hrtimer_get_remaining(&ha_mon->timer);
> +	if (hrtimer_try_to_cancel(&ha_mon->timer) == 1 && remaining < 0)
> +		return true;
> +	return false;
> +}

This is still racy. The timer could expire after hrtimer_get_remaining(),
but before hrtimer_try_to_cancel()

Is it really important that we need to care about the tiny window "after
expiration but before the callback could run"? What if we just use
hrtimer_cancel() here?

Nam
