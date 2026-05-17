Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69F2F3C26;
	Sun, 17 May 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009375; cv=none; b=EayUW6b9AgpafBS9cr5Ib2+T+U1aQXXaiDRHRpoeSOZPzFJHIFQn8cAYFuzfL2rNVTHEUcHUD2PzZYbcDVBNW6wAVIHIeMdfquF2/G8qWtgodJA2l8fhP3ZrhUwQhkuRd7ihPasYG2ztg0wWPtGAGAoyvBKTJy5EylCslGcmd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009375; c=relaxed/simple;
	bh=lEeKAVs+A7htvBIMxaKefADK2RaRnc7+HdLBfkRha/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAxhpjkBk4r8lMDiHPi5+xO7t2ljBrxQGeWKdr/gTpmX2AqQaHYbpaEq4qWMj1JH1AwQEXDA3U/VyRPpTolOHRPlCn/FndVKHNNF6Hynp8bNP+kkPT2lT77YhxFU43AELBVDCgoZE52AWxZ5H9EvsmfK/nfPyPZwc3qngoVqfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EkwhRdRx; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EkwhRdRx"
Message-ID: <4c623c63-682d-495c-86e6-6ed8832d3480@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779009371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3P8wZuJ7kjlEfC+TU2NCo0rq1vzU1BYH9e7NhsM3IE=;
	b=EkwhRdRxjc9xd+lurr1cgyzGOeDzmvjtYndRqzm+lM16Pd7AiVTmv2F1aphfRkQzcuijAj
	zs7V0MH7z3Mrd5t9cU4IAyH+gE7TtrUVimpCF9HaV7imd/fwAwCo//cMGtl6CFn33PQ0+t
	VFaCuZOdOzDVN/G7JU9AT+gHddM+2b8=
Date: Sun, 17 May 2026 17:15:50 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/9] rv: Do not rely on clean monitor when initialising HA
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-8-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


The ha_mon_initializing flag correctly
guards the init path against stale monitoring=1 (from either a previous
different monitor type or a race during teardown of the previous instance).


Reviewed-by: Wen Yang <wen.yang@linux.dev>


On 5/12/26 22:02, Gabriele Monaco wrote:
> Hybrid Automata monitors hook into the DA implementation when doing
> da_monitor_reset(). This function is called both on initialisation and
> teardown, HA monitors try to cancel a timer only when it's initialised
> relying on the da_mon->monitoring flag. This flag could however be
> corrupted during initialisation. This happens for instance on per-task
> monitors that share the same storage with different type of monitors
> like LTL or in case of races during a previous teardown.
> 
> Stop relying on the monitoring flag during initialisation, assume that
> can have any value, so skip timer cancellation in any case when a local
> flag is set. New monitors (e.g. new tasks) are always zero-initialised
> so they are safe.
> 
> Reported-by: Wen Yang <wen.yang@linux.dev>
> Closes: https://lore.kernel.org/lkml/d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/ha_monitor.h                       | 31 ++++++++++++++++++-
>   kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +--
>   kernel/trace/rv/monitors/opid/opid.c          |  4 +--
>   kernel/trace/rv/monitors/stall/stall.c        |  4 +--
>   .../rvgen/rvgen/templates/dot2k/main.c        |  4 +--
>   5 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 47ff1a41febe..11ae85bad492 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -116,6 +116,35 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
>   #define ha_get_ns() 0
>   #endif /* HA_CLK_NS */
>   
> +static bool ha_mon_initializing;
> +
> +static int ha_monitor_init(void)
> +{
> +	int ret;
> +
> +	ha_mon_initializing = true;
> +	ret = da_monitor_init();
> +	ha_mon_initializing = false;
> +	return ret;
> +}
> +
> +static void ha_monitor_destroy(void)
> +{
> +	da_monitor_destroy();
> +}
> +
> +/*
> + * ha_monitor_uninitialized - are fields like the timer initialized?
> + *
> + * On a clean monitor, we can assume an active monitor (monitoring) is
> + * initialized, however the monitoring field cannot be trusted during
> + * initialization.
> + */
> +static inline bool ha_monitor_uninitialized(struct da_monitor *da_mon)
> +{
> +	return ha_mon_initializing || !da_monitoring(da_mon);
> +}
> +
>   /* Should be supplied by the monitor */
>   static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
>   static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> @@ -160,7 +189,7 @@ static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
>   	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
>   
>   	/* Initialisation resets the monitor before initialising the timer */
> -	if (likely(da_monitoring(da_mon)))
> +	if (likely(!ha_monitor_uninitialized(da_mon)))
>   		ha_cancel_timer(ha_mon);
>   }
>   
> diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
> index 31f90f3638d8..8ead8783c29f 100644
> --- a/kernel/trace/rv/monitors/nomiss/nomiss.c
> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -227,7 +227,7 @@ static int enable_nomiss(void)
>   {
>   	int retval;
>   
> -	retval = da_monitor_init();
> +	retval = ha_monitor_init();
>   	if (retval)
>   		return retval;
>   
> @@ -263,7 +263,7 @@ static void disable_nomiss(void)
>   	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
>   	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
>   
> -	da_monitor_destroy();
> +	ha_monitor_destroy();
>   }
>   
>   static struct rv_monitor rv_this = {
> diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
> index 4594c7c46601..2922318c6112 100644
> --- a/kernel/trace/rv/monitors/opid/opid.c
> +++ b/kernel/trace/rv/monitors/opid/opid.c
> @@ -73,7 +73,7 @@ static int enable_opid(void)
>   {
>   	int retval;
>   
> -	retval = da_monitor_init();
> +	retval = ha_monitor_init();
>   	if (retval)
>   		return retval;
>   
> @@ -90,7 +90,7 @@ static void disable_opid(void)
>   	rv_detach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
>   	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
>   
> -	da_monitor_destroy();
> +	ha_monitor_destroy();
>   }
>   
>   /*
> diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monitors/stall/stall.c
> index 9ccfda6b0e73..3c38fb1a0159 100644
> --- a/kernel/trace/rv/monitors/stall/stall.c
> +++ b/kernel/trace/rv/monitors/stall/stall.c
> @@ -103,7 +103,7 @@ static int enable_stall(void)
>   {
>   	int retval;
>   
> -	retval = da_monitor_init();
> +	retval = ha_monitor_init();
>   	if (retval)
>   		return retval;
>   
> @@ -120,7 +120,7 @@ static void disable_stall(void)
>   	rv_detach_trace_probe("stall", sched_switch, handle_sched_switch);
>   	rv_detach_trace_probe("stall", sched_wakeup, handle_sched_wakeup);
>   
> -	da_monitor_destroy();
> +	ha_monitor_destroy();
>   }
>   
>   static struct rv_monitor rv_this = {
> diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> index bf0999f6657a..889446760e3c 100644
> --- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> @@ -35,7 +35,7 @@ static int enable_%%MODEL_NAME%%(void)
>   {
>   	int retval;
>   
> -	retval = da_monitor_init();
> +	retval = %%MONITOR_CLASS%%_monitor_init();
>   	if (retval)
>   		return retval;
>   
> @@ -50,7 +50,7 @@ static void disable_%%MODEL_NAME%%(void)
>   
>   %%TRACEPOINT_DETACH%%
>   
> -	da_monitor_destroy();
> +	%%MONITOR_CLASS%%_monitor_destroy();
>   }
>   
>   /*
