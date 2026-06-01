Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA938836C;
	Mon,  1 Jun 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300346; cv=none; b=qp7LR2cHopILDtJy3VZx5WFNumpc/9/icagKadDyrEX0pnRyZDnl9SYj/3KUZWMI5U4QGBXknZ3Tq1DW5qEsjh7XS+uLmCInItnCobQFnNd0zaXkkW/mmOXKrSEGB9amdS0o5Zzsj7DuOFG6X2PXLKqy9Sj2qcLPYQhHTuinIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300346; c=relaxed/simple;
	bh=42myBATTs69D0UXk5hfmLuUSmJ47ktaJ+tfWCLtERTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=osm0IgGiUvLywLZyrPn4SRaOBDoME5OttI+vbUDcmrEAwe9Q31A6rXKFcL+heEWvYqh1J03EQtx5uhVu04rlsaNxOBTXYQLYvgAgS0gwW9Hnte5s18oGcMWQz6iBozCo/HzahzHsbNMgei0RjMRa4HlWI4CPr+pvtOepJzZGuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzMCQk7R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gLzxmz3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzMCQk7R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gLzxmz3T"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20gkQJyg6mfNHQMTqAzuyHynZ2IeDQksyf9+QQ9FA5M=;
	b=jzMCQk7R7xzanH3/gPvuiH14JOEsASryewa3G7CE9PRSPdCtK/9k2rsowA4IZk53lO8tOK
	Gq2XkSx9ZOf8i4ufp6feu+76H5tjMMHRwmhZanKzcSyCZtorwJRgU+BwfjslC1nq66AkkR
	NAqCnQUGONsLZIWbn0mCe7nvJ7Ytr8N0HpP1P26QxjKS4Xspw3xiBxSmfjUfjzsT14FEqY
	DwhYakDpouXMuPNnL2M5I3mGaHbNqxtNn4OV088J6mQXfElvJYw/7kLlp+Fiq8GDXqg7sq
	cHA1t3OMoswsJATxGO611Rz227Ki0FYd894zZkgnyrH8AW2FhFci6UHI9iUmMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20gkQJyg6mfNHQMTqAzuyHynZ2IeDQksyf9+QQ9FA5M=;
	b=gLzxmz3Tf+A3Eq8FI33Y1lifWVVSZDfJHmU6Sat0UlcBJAz5Wl5EgM32IMD15oGqsln7cn
	/IKiZT20reeWsUCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 08/13] rv: Ensure synchronous cleanup for HA monitors
In-Reply-To: <20260530141652.58084-9-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-9-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 09:52:24 +0200
Message-ID: <874ijmy9xj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>  static bool ha_mon_initializing;
> +static bool ha_mon_destroying;
>  
>  static int ha_monitor_init(void)
>  {
>  	int ret;
>  
> +	WRITE_ONCE(ha_mon_destroying, false);
>  	ha_mon_initializing = true;
>  	ret = da_monitor_init();
>  	if (ret == 0)
> @@ -152,6 +155,7 @@ static int ha_monitor_init(void)
>  
>  static void ha_monitor_destroy(void)
>  {
> +	WRITE_ONCE(ha_mon_destroying, true);
>  	ha_monitor_disable_hook();
>  	da_monitor_destroy();
>  }
> @@ -302,12 +306,30 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
>  	return false;
>  }
>  
> +/*
> + * __ha_monitor_timer_callback - generic callback representation
> + *
> + * This callback runs in an RCU read-side critical section to allow the
> + * destruction sequence to easily synchronize_rcu() with all pending timers
> + * after asynchronously disabling them. The ha_mon_destroying check ensures
> + * any callback entering the RCU section after synchronize_rcu() completes
> + * will see the flag and bail out immediately.
> + */
>  static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
>  {
> -	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
>  	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
> -	u64 time_ns = ha_get_ns();
> -
> +	enum states curr_state;
> +	u64 time_ns;
> +
> +	guard(rcu)();
> +	if (unlikely(READ_ONCE(ha_mon_destroying)))

Instead of this global variable, can we instead use da_mon->monitoring?

> +		return;
> +	/* Ensure consistent curr_state if we race with da_monitor_reset */
> +	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
> +	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> +		return;
> +
> +	time_ns = ha_get_ns();
>  	ha_get_env_string(&env_string, ha_mon, time_ns);
>  	ha_react(curr_state, EVENT_NONE, env_string.buffer);
>  	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
> -- 
> 2.54.0
