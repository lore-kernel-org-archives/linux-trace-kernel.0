Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036833D6CA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779010822; cv=none; b=QIhSckZoiNBeGjSvzrdJHM9M+cw2fXTDOhnA5aIF0viCXM/YxoOe31JTZjMlZXPOrW6d+lMXsLP23joq6JbJilX4FS98AEPW6hBpSs+S2SH2J2km1ZZ8gZyFF0AJjN1ALuZzkFUABMtOsIn2+nLoS3Uiixs5QGlVo62O81LwPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779010822; c=relaxed/simple;
	bh=i67e9c5FNKDXhx36ZKL1T4D9gz5YCJmxBF6F1gNtOWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGFr7xbRorH1tFWRitGp5OET1wSQDiDNSwu6Wua0MffaoSO726EMsIFtyKkAv8eQzw9Cuu776QRqz3nFycfpNZyn5VZyAswWCrItnTpNgbXOTcgDST2w18nTRCLggZrVxuvNigctRYXqijFn2/9780EOjMf31ugm3Sof550rBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOKCToyE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOKCToyE"
Message-ID: <843882d4-3cf1-403f-8d49-172c8efb8201@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779010808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k146BUx3U7Bz0H9Q8qzdFZFAi8DRHJxF1PFFUbgAjRk=;
	b=kOKCToyEMQ8d8D405uAdDy3zLrX7Fo5kMPvdyY98M3ANBEwKY894fwJDs4AWjgSRX42qHb
	w8K4MGqagXy+Y4jXcQDx4M9+Oe6goVkkLJv//g77emBZNDNh4nHLq8vxErZg/ZTRW22S7F
	ZiFhVNsKQOkjhdA5BqQXr3tcv47wvh8=
Date: Sun, 17 May 2026 17:40:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 8/9] rv: Add automatic cleanup handlers for per-task HA
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-9-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

ha_cancel_timer_sync() is the right choice for task exit; the
ha_mon_initializing guard correctly handles the init-window race.

One issue: after ha_monitor_disable_hook(), an in-flight
ha_handle_sched_process_exit() handler may still be executing.  It
reads task_mon_slot via da_get_monitor() (&p->rv[task_mon_slot]);
da_monitor_sync_hook() = synchronize_rcu() cannot drain it because
tracepoint handlers run outside any RCU read-side section.  If
rv_put_task_monitor_slot() writes RV_PER_TASK_MONITOR_INIT to
task_mon_slot first, the handler dereferences an OOB index.

This is the same race Patch 5 closes for PER_OBJ with
tracepoint_synchronize_unregister(); the PER_TASK da_monitor_destroy()
needs the same call (and so does every other PER_TASK monitor, not only
the new exit handler).

Could you add tracepoint_synchronize_unregister() to the PER_TASK
da_monitor_destroy() ?  Alternatively, we can carry the fix on top of
your series.

--
Best wishes,
Wen


On 5/12/26 22:02, Gabriele Monaco wrote:
> Hybrid automata monitors may start timers, depending on the model, these
> may remain active on an exiting task and cause false positives or even
> access freed memory.
> 
> Add an enable/disable hook in the HA code, currently only populated by
> the per-task handler for registration and deregistration.
> This hooks to the sched_process_exit event and ensures the timer is
> stopped for every exiting task. The handler is enabled automatically but
> may be disabled, for instance if the monitor uses the event for another
> purpose (but should still manually ensure timers are stopped).
> 
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/ha_monitor.h | 44 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 11ae85bad492..1bdf866e9c63 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -28,6 +28,7 @@ static inline void ha_monitor_init_env(struct da_monitor *da_mon);
>   static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
>   static inline void ha_setup_timer(struct ha_monitor *ha_mon);
>   static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
> +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
>   static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
>   					 enum states curr_state,
>   					 enum events event,
> @@ -38,6 +39,26 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
>   #define da_monitor_reset_hook ha_monitor_reset_env
>   #define da_monitor_sync_hook() synchronize_rcu()
>   
> +#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
> +/*
> + * Automatic cleanup handlers for per-task HA monitors, only skip if you know
> + * what you are doing (e.g. you want to implement cleanup manually in another
> + * handler doing more things).
> + */
> +static void ha_handle_sched_process_exit(void *data, struct task_struct *p,
> +					 bool group_dead);
> +
> +#define ha_monitor_enable_hook()                                             \
> +	rv_attach_trace_probe(__stringify(MONITOR_NAME), sched_process_exit, \
> +			      ha_handle_sched_process_exit)
> +#define ha_monitor_disable_hook()                                            \
> +	rv_detach_trace_probe(__stringify(MONITOR_NAME), sched_process_exit, \
> +			      ha_handle_sched_process_exit)
> +#else
> +#define ha_monitor_enable_hook()
> +#define ha_monitor_disable_hook()
> +#endif
> +
>   #include <rv/da_monitor.h>
>   #include <linux/seq_buf.h>
>   
> @@ -124,12 +145,14 @@ static int ha_monitor_init(void)
>   
>   	ha_mon_initializing = true;
>   	ret = da_monitor_init();
> +	ha_monitor_enable_hook();
>   	ha_mon_initializing = false;
>   	return ret;
>   }
>   
>   static void ha_monitor_destroy(void)
>   {
> +	ha_monitor_disable_hook();
>   	da_monitor_destroy();
>   }
>   
> @@ -230,6 +253,18 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
>   {
>   	CONCATENATE(trace_error_env_, MONITOR_NAME)(id, curr_state, event, env);
>   }
> +
> +#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
> +static void ha_handle_sched_process_exit(void *data, struct task_struct *p,
> +					 bool group_dead)
> +{
> +	struct da_monitor *da_mon = da_get_monitor(p);
> +
> +	if (likely(!ha_monitor_uninitialized(da_mon)))
> +		ha_cancel_timer_sync(to_ha_monitor(da_mon));
> +}
> +#endif
> +
>   #endif /* RV_MON_TYPE */
>   
>   /*
> @@ -455,6 +490,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
>   {
>   	return timer_delete(&ha_mon->timer);
>   }
> +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> +{
> +	timer_delete_sync(&ha_mon->timer);
> +}
>   #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
>   /*
>    * Helper functions to handle the monitor timer.
> @@ -506,6 +545,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
>   {
>   	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
>   }
> +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> +{
> +	hrtimer_cancel(&ha_mon->hrtimer);
> +}
>   #else /* HA_TIMER_NONE */
>   /*
>    * Start function is intentionally not defined, monitors using timers must
> @@ -516,6 +559,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
>   {
>   	return false;
>   }
> +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
>   #endif
>   
>   #endif
