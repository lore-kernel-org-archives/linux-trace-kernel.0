Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EA2FFDCB
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009197; cv=none; b=afesfDeeHRxyu9mpmv1+SI0+MybMzJCZB3F9c1IX7JzTsjd5MwbM+Yp0qZKyhdx0CjMYHquApCnNbvH3aCDTv68caF2hQob/w9SeOmk80Jg1XYDNiRKsjb+3WY3oLp5boi6tsJEIPli8boW/WYolMLBIOngsh+genDowYe+3FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009197; c=relaxed/simple;
	bh=cqBO63r8ZuOczl2CeWs6zojdAIAki+P89fSk1rMYxzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdkAYuK5HNHaS/d1ndBTqSbvNVEviCoPAB0y1hwYkCQSsWnj8oSh+oawmJHF0MdRjm04iX9DTuoCophfUgyxju7xXa7frQ8hJFOi94yvTp7UMLGaccPie1lfyhhutYUZvKsElZY+9TZ93PEGjLeywl5SpfnhcKFE3nPB+Id4z7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cL1ziFoX; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cL1ziFoX"
Message-ID: <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779009193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X3H5sT9P6eY6Kz/IMnHbquzT2X02mswPnVBEBU+iXE=;
	b=cL1ziFoXtgo/R9be6Y6GLkwlyZcgEhaL8sDUtcceOCXfxvbATk8yNJC2uZRWHA53cJjDex
	jd7E4+Ew0ffGK+9HgGvvyc9uzuUtoxUsLC5AxbiSRqpUUNg8rwQDg0hcRn6wdklOhLO6Yn
	Hp1E2eWJK0ad2LwbBGaDN33iYRXL5Dw=
Date: Sun, 17 May 2026 17:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-7-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The guard(rcu)() + synchronize_rcu() mechanism for HA timer callbacks
is correct.

One concern: TOCTOU between the pre-check and guard(rcu)().

da_monitor_reset() calls reset_hook BEFORE clearing monitoring:

   da_monitor_reset_hook(da_mon);        /* ha_cancel_timer [async]   */
   WRITE_ONCE(da_mon->monitoring, 0);    /* cleared AFTER reset_hook  */
   da_mon->curr_state = model_get_initial_state();

This may creates a window where the callback pre-check passes but the
monitor is reset before guard(rcu)() is acquired:

   /* __ha_monitor_timer_callback() */
   if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
       return;

   /* passes: monitoring=1
    *
    * WINDOW ─ CPU A runs da_monitor_reset_all() here:
    *   ha_cancel_timer()  [returns: callback is running, cannot cancel]
    *   WRITE_ONCE(monitoring, 0)
    *   curr_state = model_get_initial_state()
    */
   guard(rcu)();
   curr_state = READ_ONCE(ha_mon->da_mon.curr_state);  /* initial_state */
   /* no second da_monitoring() check */
   ha_react(curr_state, EVENT_NONE, env_string.buffer); /* spurious call */
   ha_trace_error_env(ha_mon, ...);                     /* fires 
unconditionally */

Result: spurious ha_trace_error_env() for initial_state.  For existing
monitors (stall/nomiss/opid), model_should_send_event_env(initial, NONE)
returns false, so no false-positive reaction, but the trace event fires.
Monitors where initial_state carries a constraint would produce a false
positive.

Proposed fix : re-check inside the RCU critical section:

   guard(rcu)();
   if (unlikely(!da_monitoring(&ha_mon->da_mon)))  /* re-check here */
       return;
   curr_state = READ_ONCE(ha_mon->da_mon.curr_state);


--
Best wishes,
Wen


On 5/12/26 22:02, Gabriele Monaco wrote:
> HA monitors may start timers, all cleanup functions currently stop the
> timers asynchronously to avoid sleeping in the wrong context.
> Nothing makes sure running callbacks terminate on cleanup.
> 
> Run the entire HA timer callback in an RCU read-side critical section,
> this way we can simply synchronize_rcu() with any pending timer and are
> sure any cleanup using kfree_rcu() runs after callbacks terminated.
> Additionally make sure any unlikely callback running late won't run any
> code if the monitor is marked as disabled.
> 
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h | 23 +++++++++++++++++++----
>   include/rv/ha_monitor.h | 18 ++++++++++++++++--
>   2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index a4a13b62d1a4..402d3b935c08 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -57,6 +57,15 @@ static struct rv_monitor rv_this;
>   #define da_monitor_reset_hook(da_mon)
>   #endif
>   
> +/*
> + * Hook to allow the implementation of hybrid automata: define it with a
> + * function that waits for the termination of all monitors background
> + * activities (e.g. all timers). This hook can sleep.
> + */
> +#ifndef da_monitor_sync_hook
> +#define da_monitor_sync_hook()
> +#endif
> +
>   /*
>    * Type for the target id, default to int but can be overridden.
>    * A long type can work as hash table key (PER_OBJ) but will be downgraded to
> @@ -179,6 +188,7 @@ static inline int da_monitor_init(void)
>   static inline void da_monitor_destroy(void)
>   {
>   	da_monitor_reset_all();
> +	da_monitor_sync_hook();
>   }
>   
>   #ifndef da_implicit_guard
> @@ -232,6 +242,7 @@ static inline int da_monitor_init(void)
>   static inline void da_monitor_destroy(void)
>   {
>   	da_monitor_reset_all();
> +	da_monitor_sync_hook();
>   }
>   
>   #ifndef da_implicit_guard
> @@ -319,6 +330,7 @@ static inline void da_monitor_destroy(void)
>   	}
>   
>   	da_monitor_reset_all();
> +	da_monitor_sync_hook();
>   
>   	rv_put_task_monitor_slot(task_mon_slot);
>   	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
> @@ -497,10 +509,9 @@ static void da_monitor_reset_all(void)
>   	struct da_monitor_storage *mon_storage;
>   	int bkt;
>   
> -	rcu_read_lock();
> +	guard(rcu)();
>   	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
>   		da_monitor_reset(&mon_storage->rv.da_mon);
> -	rcu_read_unlock();
>   }
>   
>   static inline int da_monitor_init(void)
> @@ -516,13 +527,17 @@ static inline void da_monitor_destroy(void)
>   	int bkt;
>   
>   	tracepoint_synchronize_unregister();
> +	scoped_guard(rcu) {
> +		hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
> +			da_monitor_reset_hook(&mon_storage->rv.da_mon);
> +		}
> +	}
> +	da_monitor_sync_hook();
>   	/*
>   	 * This function is called after all probes are disabled and no longer
>   	 * pending, we can safely assume no concurrent user.
>   	 */
> -	synchronize_rcu();
>   	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
> -		da_monitor_reset_hook(&mon_storage->rv.da_mon);
>   		hash_del_rcu(&mon_storage->node);
>   		kfree(mon_storage);
>   	}
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index d59507e8cb30..47ff1a41febe 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
>   #define da_monitor_event_hook ha_monitor_handle_constraint
>   #define da_monitor_init_hook ha_monitor_init_env
>   #define da_monitor_reset_hook ha_monitor_reset_env
> +#define da_monitor_sync_hook() synchronize_rcu()
>   
>   #include <rv/da_monitor.h>
>   #include <linux/seq_buf.h>
> @@ -237,12 +238,25 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
>   	return false;
>   }
>   
> +/*
> + * __ha_monitor_timer_callback - generic callback representation
> + *
> + * This callback runs in an RCU read-side critical section to allow the
> + * destruction sequence to easily synchronize_rcu() with all pending timer
> + * after asynchronously disabling them.
> + */
>   static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
>   {
> -	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
>   	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
> -	u64 time_ns = ha_get_ns();
> +	enum states curr_state;
> +	u64 time_ns;
> +
> +	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> +		return;
>   
> +	guard(rcu)();
> +	curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
> +	time_ns = ha_get_ns();
>   	ha_get_env_string(&env_string, ha_mon, time_ns);
>   	ha_react(curr_state, EVENT_NONE, env_string.buffer);
>   	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
