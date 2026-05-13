Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11463A5E77
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650372; cv=none; b=avEeedXG8aDPU+yYgI0D946KiJVUX+k8EKgyfDZrtLy1hlOQD+A0JGvNnep39X2qBwb/KId0Aqsl5D7PzSO3euWYb02Q6KEcDwP2WzkAUHYnMo7V1lC26Ihb9jnxdP4vMJB05c+jSwgQKVQzDKa143coOUdu0Z4PD5+ZT5FvF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650372; c=relaxed/simple;
	bh=kSbEm7k58Eo6lWtNEuFinBdUBfjgQ7eoeLviWwnfWkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOXzaqEEpEMagUA40Xrra7qheKC4UMAis64CSpr/dnkU5fbipm5jLv82BFM/YTFOaQWg7G1UqnYCbSaO1tZif0aTFhIjgp/yNbvAbeVfmgt8WdU5VG4XROLrEYQGO4yf0pJCyx0FHxQBQpl0jSL61T2csHjz7/Py/Wsk0REQtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCmKNPgd; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCmKNPgd"
Message-ID: <cb929b8b-5bfb-4afe-ba50-45620c38ea96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778650367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHAIdS14F1xCMUzmy/sos/gkrsZKrIkMdmnfzXNcQAw=;
	b=tCmKNPgdqOvnIfkFzHi7b9nRGz1cCaPjWwgT4b3a6uoFDJ0Xs5HNoSfPEd79RsoMjmjmEV
	1ZhhPZ43l0qf4bhLHVq130uGSg+hUSc4ojnYiQvEF1YbRk9KjzB1iL2DJU9wmePRjJnHeX
	m0KQJLIx01hodVBKWmdMy2s29OpmtwI=
Date: Wed, 13 May 2026 13:32:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 02/10] rv/da: fix per-task da_monitor_destroy()
 ordering and sync
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
References: <cover.1778522945.git.wen.yang@linux.dev>
 <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
 <f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com>
 <8e80cbcf739304de95356f1fac677261628977fa.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <8e80cbcf739304de95356f1fac677261628977fa.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/12/26 17:09, Gabriele Monaco wrote:
> On Tue, 2026-05-12 at 10:27 +0200, Gabriele Monaco wrote:
>> On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
>>> From: Wen Yang <wen.yang@linux.dev>
>>>
>>> The following two paths race:
>>>
>>>    CPU 0 (disable_stall/__rv_disable_monitor)  CPU 1 (wwnr probe handler)
>> 							^ did you mean stall?
> 
> Ok I got it now, so essentially you'd reproduce it like:
> 
> * start a DA per-task monitor (no timer)
> * stop it, a handler is still running after reset, it sets monitoring back to 1
> * start an HA per-task monitor
> 
> that would use the same slot that is now looking like:
> 
>   { monitoring = 1, timer.function = NULL }
> 
> because it was not initialised as HA but monitoring was reset in the race.
> 
> Thinking about this again, it isn't just an issue with per-task monitors, all
> monitors reusing slots would suffer from it.
> Besides, relying on monitoring can be fragile when using LTL monitors on the
> same task (those don't even have monitoring).
> 
> Perhaps the solution isn't that trivial, I'm going to give one more thought on
> it, but thanks again for bringing this up!
> 
> Gabriele
> 
>>>    ------------------------------------------  -----------------------------
>>>    disable_stall()
>>>      da_monitor_destroy()
>>>        da_monitor_reset_all()          <------ [task T: monitoring=0]
>>>                                                da_monitor_start(&T->rv[n])
>>>                                                /* no timer_setup */
>>>                                                 monitoring=1  <----
>>>    tracepoint_synchronize_unregister()
>>>    // CPU 1 probe has already returned; sync returns
>>>
>>> Later, enable_stall() acquires the same slot and calls da_monitor_init():
>>>
>>>    da_monitor_reset_all()
>>>      da_monitor_reset(&T->rv[slot])    // monitoring=1, timer.function==0
>>>        ha_monitor_reset_env()
>>>          ha_cancel_timer()
>>>            timer_delete(&ha_mon->timer)  // ODEBUG: timer never initialised
>>>
>>>    ODEBUG: assert_init not available (active state 0)
>>>    object type: timer_list
>>>    Call trace: timer_delete <- da_monitor_reset_all <- enable_stall
>>>
>>> Call tracepoint_synchronize_unregister() inside da_monitor_destroy()
>>> before da_monitor_reset_all().  The unregister_trace_xxx() calls in the
>>> monitor's disable() have already disconnected the tracepoints; the sync
>>> here drains any handler still in flight, so no new monitoring=1 can
>>> appear after da_monitor_reset_all() clears the slot.
>>>
>>> Also fix the slot release ordering: release the slot only after
>>> reset_all() to avoid accessing rv[] with an out-of-bounds index.
>>>
>>> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
>>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>>> ---
>>
>> Thanks for the fix, I have a similar one waiting for submission.
>>
>> These are technically 2 separate fixes though: the ordering with unset
>> task_mon_slot (independent on HA) and the synchronisation with pending
>> tracepoints. They probably deserve separate patches and visibility, the first
>> has always been around and we're technically overwriting who knows what.
>>
>>
>> The explanation above is a bit hard to follow though, are you talking about a
>> handler for the same (stall) monitor running after the reset, effectively
>> undoing it by setting the monitoring flag?
>>
>> Then this is indeed an issue with ha_monitor_reset_env() which expects a clean
>> environment.
>>
>> So that's basically what you'd see now much more often because in fact we
>> don't
>> reset the right slot (though, again, that's a different issue).
>>
>>
>> Calling tracepoint_synchronize_unregister() there too would surely fix, but it
>> used to be kinda slow. But it's probably gotten faster since now tracepoints
>> use
>> SRCU, so we can wait for a dedicated grace period.
>>
>> I liked the idea to wait cumulatively in the end, but that's just making
>> things
>> harder.. Let's do like this:
>>
>> Prepare 2 separate patches as fixes, put the task slot one first (would ease
>> backporting), mention this issue with the race condition only in the second.
>> You can send them independently and I'll add them to the tree as urgent.
>>
>>
>> I'm soon going to send my set of fixes that will also include the task slot
>> patch (not removing to ease my life with conflicts).
>>

Hi Gabriele,

Thanks for both messages.  Two patches are ready; let me address
your follow-up concerns before sending.

   1. "all monitors reusing slots would suffer from it"

      Only RV_MON_PER_TASK uses the rv_get/put_task_monitor_slot()
      pool.  RV_MON_GLOBAL and RV_MON_PER_CPU each have dedicated
      storage (a single static variable and a per-cpu variable) and
      never share slots across monitor types.  The race is exclusive
      to PER_TASK, so fixing that variant's da_monitor_destroy() is
      the correct scope.

   2. "LTL monitors don't even have monitoring"

      tracepoint_synchronize_unregister() does not rely on the
      monitoring flag at all.  It is a system-wide barrier — it
      calls synchronize_rcu_tasks_trace() followed by
      synchronize_srcu(&tracepoint_srcu) — draining every in-flight
      tracepoint handler on every CPU regardless of which monitor
      dispatched it.  LTL handlers are covered without any special
      treatment.

The slot-ordering issue (patch 1) affects all per-task DA monitors,
not only HA ones — "independent on HA" — because
RV_PER_TASK_MONITOR_INIT equals CONFIG_RV_PER_TASK_MONITORS (one
past the end of rv[]), so da_monitor_reset_all() overwrites whatever
follows rv[] in task_struct whenever any per-task monitor is
disabled.

Also corrected "wwnr probe handler" to "stall probe handler" in
patch 2 per your annotation.

Please let me know if the above reasoning addresses your concerns.


--
Best wishes,
Wen

>>
>>>   include/rv/da_monitor.h | 18 ++++++++++++++++--
>>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
>>> index 00ded3d5ab3f..d04bb3229c75 100644
>>> --- a/include/rv/da_monitor.h
>>> +++ b/include/rv/da_monitor.h
>>> @@ -304,6 +304,20 @@ static int da_monitor_init(void)
>>>   
>>>   /*
>>>    * da_monitor_destroy - return the allocated slot
>>> + *
>>> + * Call tracepoint_synchronize_unregister() before reset_all() to close
>>> + * the race where an in-flight non-HA probe handler sets monitoring=1
>>> + * (without calling timer_setup()) after da_monitor_reset_all() has
>>> + * already cleared the slot but before the caller's own sync completes.
>>> + * Without this barrier, an HA_TIMER_WHEEL monitor that later acquires
>>> + * the same slot would call timer_delete() on a never-initialised
>>> + * timer_list, triggering ODEBUG warnings.
>>> + *
>>> + * Note: tracepoint_synchronize_unregister() is a system-wide barrier
>>> + * that waits for all CPUs to finish any in-flight tracepoint handlers.
>>> + * The caller's own __rv_disable_monitor() issues a second sync after
>>> + * returning from disable(); that redundant call is harmless on the
>>> + * infrequent admin (enable/disable) path.
>>>    */
>>>   static inline void da_monitor_destroy(void)
>>>   {
>>> @@ -311,10 +325,10 @@ static inline void da_monitor_destroy(void)
>>>   		WARN_ONCE(1, "Disabling a disabled monitor: "
>>> __stringify(MONITOR_NAME));
>>>   		return;
>>>   	}
>>> +	tracepoint_synchronize_unregister();
>>> +	da_monitor_reset_all();
>>>   	rv_put_task_monitor_slot(task_mon_slot);
>>>   	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
>>> -
>>> -	da_monitor_reset_all();
>>>   }
>>>   
>>>   #elif RV_MON_TYPE == RV_MON_PER_OBJ
> 
