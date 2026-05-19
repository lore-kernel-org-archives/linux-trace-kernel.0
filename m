Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DB322768
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209303; cv=none; b=PbtRuGlKrqr0K6cJ6qSW7jOBxCD9xmxmH4HCufZi6h10yw3MLhIt2LLX8mzPiskSxy2zGf+0kzxSfk2ZKvbaCigXsXmxV0JhQYqHRsyhxG+nF6OLQqV0zafDAzOk6tY0Wp7qNRFX8INN1RgjYGazsdIcpyWry5mHmXo+osp6N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209303; c=relaxed/simple;
	bh=nV7WD83XgBhBpbt7nF3gMrpHMOjwjKxA+MCBYmwz6uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES7X3U4MyZWXKSMsNlkNd7mJCc4scLJKJ793W9JHES7dkOzkhv3NIEPSfqhqIS54ybu+59k7JchNU2mJ2Fv79FA8kDkey+IG/bCIOpZYcnxXE9C0wrMloRXQifOxZo0P/J6tA9Pvd+8wb72W5o3GoFYExK/ZFQdfOh6z0CoIpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmAtg6Fw; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmAtg6Fw"
Message-ID: <5f8ceba5-ec25-4c19-a74b-ed98715e89b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779209299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glnbXn1JbnE9jsBUXe7hfEp+aHNF35/HuC4r58RXzjo=;
	b=vmAtg6Fw4ZPo0/LHVPv074byG6QWqRm6zuOmy7+Gczwch/DWDyBdohY+5vx7l5ADZ6RihV
	06ONCti9ON+PCF8w8r+06xJGJ/aipSlDnO/9bt/9DwMsiBFByKhWueMfmZhAvVV0v6l41v
	Z0y9QANXvb8yBn7Um6oFTzBn9hmLtDQ=
Date: Wed, 20 May 2026 00:48:11 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-7-gmonaco@redhat.com>
 <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
 <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/18/26 19:54, Gabriele Monaco wrote:
> On Sun, 2026-05-17 at 17:12 +0800, Wen Yang wrote:
>> The guard(rcu)() + synchronize_rcu() mechanism for HA timer callbacks
>> is correct.
>>
>> One concern: TOCTOU between the pre-check and guard(rcu)().
> 
> Yes, this could happen, but I'm not sure it's really a big issue:
> 
>>
>> da_monitor_reset() calls reset_hook BEFORE clearing monitoring:
>>
>>     da_monitor_reset_hook(da_mon);        /* ha_cancel_timer [async]   */
>>     WRITE_ONCE(da_mon->monitoring, 0);    /* cleared AFTER reset_hook  */
>>     da_mon->curr_state = model_get_initial_state();
>>
>> This may creates a window where the callback pre-check passes but the
>> monitor is reset before guard(rcu)() is acquired:
> 
> If a callback is running, there was a violation because the timer expired, so it
> isn't wrong to report, although we are unloading the monitor.
> 
>>
>>     /* __ha_monitor_timer_callback() */
>>     if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
>>         return;
>>
>>     /* passes: monitoring=1
>>      *
>>      * WINDOW ─ CPU A runs da_monitor_reset_all() here:
>>      *   ha_cancel_timer()  [returns: callback is running, cannot cancel]
>>      *   WRITE_ONCE(monitoring, 0)
>>      *   curr_state = model_get_initial_state()
>>      */
>>     guard(rcu)();
>>     curr_state = READ_ONCE(ha_mon->da_mon.curr_state);  /* initial_state */
>>     /* no second da_monitoring() check */
>>     ha_react(curr_state, EVENT_NONE, env_string.buffer); /* spurious call */
>>     ha_trace_error_env(ha_mon, ...);                     /* fires
>> unconditionally */
>>
>> Result: spurious ha_trace_error_env() for initial_state.  For existing
>> monitors (stall/nomiss/opid), model_should_send_event_env(initial, NONE)
>> returns false, so no false-positive reaction, but the trace event fires.
>> Monitors where initial_state carries a constraint would produce a false
>> positive.
> 
> I'm not sure what you mean here, if I understand the situation correctly: the
> callback is running (so we should react), da_monitor_reset() is too late to stop
> it but somehow manages to reset curr_state on time for the callback to see it
> change: react reports the wrong state in an otherwise valid reaction.
> 
>>
>> Proposed fix : re-check inside the RCU critical section:
>>
>>     guard(rcu)();
>>     if (unlikely(!da_monitoring(&ha_mon->da_mon)))  /* re-check here */
>>         return;
>>     curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
> 
> I'm not sure that's going to fix it anyway, RCU cannot synchronise readers,
> checking again would at most (mildly) reduce the race window, not remove it.
> 
> What we could do is to play with barriersin for the callback to either:
> * see monitoring = 1 AND the old curr_state
> * see monitoring = 0 AND the new curr_state
> 
> Something like:
> 
> void __ha_monitor_timer_callback() {
> 	guard(rcu)(); //this is only for waiters, let them wait more
> 
> 	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> 		return;
> 	smp_rmb();
> 	curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
> 	...
> }
> 
> void da_monitor_reset() {
> 	da_monitor_reset_hook(da_mon);
> 	WRITE_ONCE(da_mon->monitoring, 0);
> 	smp_wmb();
> 	WRITE_ONCE(da_mon->curr_state, model_get_initial_state());
> }
> 
> Coupled with your patch [1] adding more atomic accesses to da_mon->monitoring
> should probably do the trick.
> 
> Am I missing anything?
> 

The goal is right.  One thing worth double-checking is the load order
in the callback against the "SMP BARRIER PAIRING" section of
Documentation/memory-barriers.txt, which states:

   [!] Note that the stores before the write barrier would normally be
   expected to match the loads after the read barrier or the
   address-dependency barrier, and vice versa ...

So, we should to swap the read order in the callback so that it matches
the standard pattern:

   void __ha_monitor_timer_callback() {
         guard(rcu)();
         curr_state = READ_ONCE(ha_mon->da_mon.curr_state);  /* B: 
before rmb */
         smp_rmb();
         if (unlikely(!da_monitoring(&ha_mon->da_mon)))       /* A: 
after rmb */
                 return;
         /*
          * Reached here: monitoring = 1 (old_A).
          * Standard wmb/rmb guarantee: curr_state (read before rmb) is also
          * old, i.e. not initial_state.
          */
         ha_react(curr_state, EVENT_NONE, env_string.buffer);
         ...
   }

   void da_monitor_reset() {
         da_monitor_reset_hook(da_mon);
         WRITE_ONCE(da_mon->monitoring, 0);   /* A: before wmb */
         smp_wmb();
         WRITE_ONCE(da_mon->curr_state, model_get_initial_state());  /* 
B: after wmb */
   }



--
Best wishes,
Wen

> 
> [1] -
> https://lore.kernel.org/lkml/8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.1778522945.git.wen.yang@linux.dev
> 
>>
>>
>> --
>> Best wishes,
>> Wen
>>
>>
>> On 5/12/26 22:02, Gabriele Monaco wrote:
>>> HA monitors may start timers, all cleanup functions currently stop the
>>> timers asynchronously to avoid sleeping in the wrong context.
>>> Nothing makes sure running callbacks terminate on cleanup.
>>>
>>> Run the entire HA timer callback in an RCU read-side critical section,
>>> this way we can simply synchronize_rcu() with any pending timer and are
>>> sure any cleanup using kfree_rcu() runs after callbacks terminated.
>>> Additionally make sure any unlikely callback running late won't run any
>>> code if the monitor is marked as disabled.
>>>
>>> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
>>> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> ---
>>>    include/rv/da_monitor.h | 23 +++++++++++++++++++----
>>>    include/rv/ha_monitor.h | 18 ++++++++++++++++--
>>>    2 files changed, 35 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
>>> index a4a13b62d1a4..402d3b935c08 100644
>>> --- a/include/rv/da_monitor.h
>>> +++ b/include/rv/da_monitor.h
>>> @@ -57,6 +57,15 @@ static struct rv_monitor rv_this;
>>>    #define da_monitor_reset_hook(da_mon)
>>>    #endif
>>>    
>>> +/*
>>> + * Hook to allow the implementation of hybrid automata: define it with a
>>> + * function that waits for the termination of all monitors background
>>> + * activities (e.g. all timers). This hook can sleep.
>>> + */
>>> +#ifndef da_monitor_sync_hook
>>> +#define da_monitor_sync_hook()
>>> +#endif
>>> +
>>>    /*
>>>     * Type for the target id, default to int but can be overridden.
>>>     * A long type can work as hash table key (PER_OBJ) but will be downgraded
>>> to
>>> @@ -179,6 +188,7 @@ static inline int da_monitor_init(void)
>>>    static inline void da_monitor_destroy(void)
>>>    {
>>>    	da_monitor_reset_all();
>>> +	da_monitor_sync_hook();
>>>    }
>>>    
>>>    #ifndef da_implicit_guard
>>> @@ -232,6 +242,7 @@ static inline int da_monitor_init(void)
>>>    static inline void da_monitor_destroy(void)
>>>    {
>>>    	da_monitor_reset_all();
>>> +	da_monitor_sync_hook();
>>>    }
>>>    
>>>    #ifndef da_implicit_guard
>>> @@ -319,6 +330,7 @@ static inline void da_monitor_destroy(void)
>>>    	}
>>>    
>>>    	da_monitor_reset_all();
>>> +	da_monitor_sync_hook();
>>>    
>>>    	rv_put_task_monitor_slot(task_mon_slot);
>>>    	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
>>> @@ -497,10 +509,9 @@ static void da_monitor_reset_all(void)
>>>    	struct da_monitor_storage *mon_storage;
>>>    	int bkt;
>>>    
>>> -	rcu_read_lock();
>>> +	guard(rcu)();
>>>    	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
>>>    		da_monitor_reset(&mon_storage->rv.da_mon);
>>> -	rcu_read_unlock();
>>>    }
>>>    
>>>    static inline int da_monitor_init(void)
>>> @@ -516,13 +527,17 @@ static inline void da_monitor_destroy(void)
>>>    	int bkt;
>>>    
>>>    	tracepoint_synchronize_unregister();
>>> +	scoped_guard(rcu) {
>>> +		hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
>>> +			da_monitor_reset_hook(&mon_storage->rv.da_mon);
>>> +		}
>>> +	}
>>> +	da_monitor_sync_hook();
>>>    	/*
>>>    	 * This function is called after all probes are disabled and no
>>> longer
>>>    	 * pending, we can safely assume no concurrent user.
>>>    	 */
>>> -	synchronize_rcu();
>>>    	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
>>> -		da_monitor_reset_hook(&mon_storage->rv.da_mon);
>>>    		hash_del_rcu(&mon_storage->node);
>>>    		kfree(mon_storage);
>>>    	}
>>> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
>>> index d59507e8cb30..47ff1a41febe 100644
>>> --- a/include/rv/ha_monitor.h
>>> +++ b/include/rv/ha_monitor.h
>>> @@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor
>>> *da_mon,
>>>    #define da_monitor_event_hook ha_monitor_handle_constraint
>>>    #define da_monitor_init_hook ha_monitor_init_env
>>>    #define da_monitor_reset_hook ha_monitor_reset_env
>>> +#define da_monitor_sync_hook() synchronize_rcu()
>>>    
>>>    #include <rv/da_monitor.h>
>>>    #include <linux/seq_buf.h>
>>> @@ -237,12 +238,25 @@ static bool ha_monitor_handle_constraint(struct
>>> da_monitor *da_mon,
>>>    	return false;
>>>    }
>>>    
>>> +/*
>>> + * __ha_monitor_timer_callback - generic callback representation
>>> + *
>>> + * This callback runs in an RCU read-side critical section to allow the
>>> + * destruction sequence to easily synchronize_rcu() with all pending timer
>>> + * after asynchronously disabling them.
>>> + */
>>>    static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
>>>    {
>>> -	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
>>>    	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
>>> -	u64 time_ns = ha_get_ns();
>>> +	enum states curr_state;
>>> +	u64 time_ns;
>>> +
>>> +	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
>>> +		return;
>>>    
>>> +	guard(rcu)();
>>> +	curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
>>> +	time_ns = ha_get_ns();
>>>    	ha_get_env_string(&env_string, ha_mon, time_ns);
>>>    	ha_react(curr_state, EVENT_NONE, env_string.buffer);
>>>    	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
> 
