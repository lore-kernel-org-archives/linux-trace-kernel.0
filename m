Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A844064F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163973; cv=none; b=bpZF+xwsemBVir7G3Mu3j4VmnGvFR3ztR4HXG0/D0ajQlTok8zoY73YGzUG+j6K0qxscC88sNwHGbpZCiuFhyBhzcZcJLJ1sJW+JVb8gA4H8/PwdTn4HdpgM8PBxZQpymh9AvdGVx0vZ0aP5c0+iBZ/v+NQB2H9HqNwtSriSbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163973; c=relaxed/simple;
	bh=is+JXDU8qjK+6X8mQp9R2SPWhzgBfEyC61B3UjXF3S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3IChnAkOeunCLbIjQ6hyTZnoJQDkSS9xN3HiYtMM9bscRwtcQ3RSJGvcBDi8+d3FnwK/Pocg/4UNDMh7Yg/D3rzzxCGSQxNkdLzrN88WEhTANjLfJdVAWXgYZBUwrZfkfvx0cpa8/vRXjie3OnwbfQ908YD1RKrtGwlbfOIl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AO1hcwh5; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AO1hcwh5"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=is+JXDU8qjK+6X8mQp9R2SPWhzgBfEyC61B3UjXF3S0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163968; v=1; x=1787768768;
 b=AO1hcwh5iwHo7ozz1SrVpobHhTTisUtNYtVbaoH5dKJcnHnm4bd3M1mjSjzJv0QKyjcj1SgM
 jonP7+PlX9fOqi5FvvuDd7QZHXZFAvcC85AWctfktXnOvxRY627z2AX9WIpwJdeMI7XJPyJ7BIW
 tV5TcDKukQmTRZV34rdc4ivI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from [192.168.1.71] (218.1.223.168)
	by smtp.migadu.com with ESMTPS id d7635118fbf84be8;
	Wed, 19 Aug 2026 18:25:58 +0000
X-Mizu-Trace-ID: d7635118fbf84be8
X-Migadu-Flow: FLOW_OUT
Message-ID: <ad70933e-4bf6-4e72-90dd-1c685ff12427@linux.dev>
Date: Thu, 20 Aug 2026 02:25:53 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1783524627.git.wen.yang@linux.dev>
 <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
 <34e1dfd9b5c8ded4fba878714754813fb60c2431.camel@redhat.com>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <34e1dfd9b5c8ded4fba878714754813fb60c2431.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/17/26 21:46, Gabriele Monaco wrote:
> On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Per-object DA storage allocation is currently limited to kmalloc on
>> demand. Add a compile-time selector so monitors can choose among three
>> strategies:
>>
>>    DA_ALLOC_AUTO   (default) - kmalloc per object on the monitor path
>>    DA_ALLOC_POOL             - pre-allocated fixed-size llist pool;
>>                                selected by defining DA_MON_POOL_SIZE
>>    DA_ALLOC_MANUAL           - caller pre-inserts storage; framework
>>                                only links the target field
>>
>> The pool strategy uses a lock-free llist (cmpxchg, no spinlock) so
>> pool release is safe from RCU callback context without acquiring a
>> lock. Moving allocation before the measurement window also prevents
>> kmalloc latency.
> 
> Measurement window here is tlob's, remember RV isn't itself a measurement
> tool (yet, perhaps).
> And isn't this also happening with other methods? We're trying to do
> allocation when the monitor starts (so before this measurement window).
> 
> I'm a bit puzzled since you're mentioning it many times, when have we
> done /allocations/ from RCU callbacks?
> We surely do deallocations (kfree_rcu) but allocations are at most in RCU
> read-side critical sections and it's perfectly fine to take sleeping
> spinlocks there (that's a special kind of sleep under PREEMPT_RT).
> Besides I'm not quite sure spinlocks are that bad in RCU callbacks
> either (kfree surely takes them).
> I'm not sure what you mean here but I don't think deallocation was ever
> a problem, was it?
> 
>> nomiss is updated to DA_ALLOC_MANUAL.
>>
>> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> ---
>>   include/rv/da_monitor.h                  | 247 +++++++++++++++++++----
>>   include/rv/ha_monitor.h                  |   6 +
>>   kernel/trace/rv/monitors/nomiss/nomiss.c |   6 +-
>>   3 files changed, 221 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
>> index 34b8fba9ecd4..9c9acc123e3b 100644
>> --- a/include/rv/da_monitor.h
>> +++ b/include/rv/da_monitor.h
>> @@ -14,7 +14,56 @@
>>   #ifndef _RV_DA_MONITOR_H
>>   #define _RV_DA_MONITOR_H
>>   
>> +/*
>> + * Allocation strategies for RV_MON_PER_OBJ monitors.
>> + *
>> + * Select the strategy with a single define before including this header:
>> + *
>> + *   #define DA_MON_POOL_SIZE N          - pool mode; N pre-allocated slots.
>> + *                                         Implies DA_ALLOC_POOL
>> automatically.
>> + *   #define DA_MON_ALLOCATION_STRATEGY \
>> + *           DA_ALLOC_MANUAL             - manual mode (see below).
>> + *   (neither)                           - auto mode (default).
>> + *
>> + * Do not define both DA_MON_POOL_SIZE and DA_MON_ALLOCATION_STRATEGY.
>> + *
>> + * DA_ALLOC_AUTO   - lock-free kmalloc on the hot path; unbounded capacity.
>> + * DA_ALLOC_POOL   - pre-allocated fixed-size pool; set by defining
>> DA_MON_POOL_SIZE.
>> + * DA_ALLOC_MANUAL - caller inserts storage before da_handle_start_event();
>> + *                   the framework only links the target field.
>> + */
>> +#define DA_ALLOC_AUTO   0
>> +#define DA_ALLOC_POOL   1
>> +#define DA_ALLOC_MANUAL 2
>> +
>> +#ifdef DA_MON_POOL_SIZE
>> +#ifdef DA_MON_ALLOCATION_STRATEGY
>> +#error "Define only one of DA_MON_POOL_SIZE or DA_MON_ALLOCATION_STRATEGY"
>> +#endif
>> +#if DA_MON_POOL_SIZE == 0
>> +#error "DA_MON_POOL_SIZE must be non-zero"
>> +#endif
>> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
>> +#endif
> 
> Longer ifdefs should have comments to make them readable, like
> 
>    #endif /* DA_MON_POOL_SIZE */
> 
>> +
>> +#ifndef DA_MON_ALLOCATION_STRATEGY
>> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
>> +#endif
>> +
>> +/*
>> + * Provide a zero default so da_monitor_init() can reference
>> + * DA_MON_POOL_SIZE in a plain C if() without an #if guard; the
>> + * compiler eliminates the dead branch.
>> + */
>> +#ifndef DA_MON_POOL_SIZE
>> +#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
>> +#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined and non-zero"
>> +#endif
>> +#define DA_MON_POOL_SIZE 0
>> +#endif
> 
> Same here, better to have a comment.
> 
>> +
>>   #include <rv/automata.h>
>> +#include <linux/llist.h>
>>   #include <linux/rv.h>
>>   #include <linux/stringify.h>
>>   #include <linux/bug.h>
>> @@ -66,6 +115,16 @@ static struct rv_monitor rv_this;
>>   #define da_monitor_sync_hook()
>>   #endif
>>   
>> +/*
>> + * Per-object teardown hook, called after da_monitor_reset_all() +
>> + * da_monitor_sync_hook() and before hash_del_rcu() for each entry.
>> + * All HA timer callbacks have completed at this point.
>> + * Define before including this header.  Default: no-op.
>> + */
>> +#ifndef da_extra_cleanup
>> +#define da_extra_cleanup(da_mon)
>> +#endif
>> +
>>   /*
>>    * Type for the target id, default to int but can be overridden.
>>    * A long type can work as hash table key (PER_OBJ) but will be downgraded to
>> @@ -404,6 +463,12 @@ struct da_monitor_storage {
>>   	union rv_task_monitor rv;
>>   	struct hlist_node node;
>>   	struct rcu_head rcu;
>> +	/*
>> +	 * Mutually exclusive with rcu: rcu is live during the RCU callback
>> +	 * flight; free_node when the slot is in da_pool_free_list.
>> +	 * Present in all monitors to avoid #if-gating the pool helpers.
>> +	 */
> 
> I really don't understand much more about it by this comment, perhaps
> drop it here and make the separate usages clearer later?
> 
> By the way, if they are /really/ mutually exclusive and you want to save
> space, why not having them in an anonymous union?
> 

Thanks.
The comment and the field are gone: the llist pool is replaced by a
mempool (see below), so the pool slot no longer needs a dual-purpose
field at all.


>> +	struct llist_node free_node;
>>   };
>>   
>>   #ifndef DA_MONITOR_HT_BITS
>> @@ -495,18 +560,6 @@ static inline da_id_type da_get_id(struct da_monitor
>> *da_mon)
>>   	return container_of(da_mon, struct da_monitor_storage, rv.da_mon)-
>>> id;
>>   }
>>   
>> -/*
>> - * da_create_or_get - create the per-object storage if not already there
>> - *
>> - * This needs a lookup so should be guarded by RCU, the condition is checked
>> - * directly in da_create_storage()
>> - */
>> -static inline void da_create_or_get(da_id_type id, monitor_target target)
>> -{
>> -	guard(rcu)();
>> -	da_create_storage(id, target, da_get_monitor(id, target));
>> -}
>> -
>>   /*
>>    * da_fill_empty_storage - store the target in a pre-allocated storage
>>    *
>> @@ -537,15 +590,79 @@ static inline monitor_target
>> da_get_target_by_id(da_id_type id)
>>   	return mon_storage->target;
>>   }
>>   
>> +/*
>> + * Lock-free llist (cmpxchg) rather than kmem_cache/mempool: on
>> + * PREEMPT_RT spinlock_t becomes a sleeping lock, which is forbidden
>> + * in the rcuc kthread context where RCU callbacks run.
> 
> This comment kind of implies we were using a kmem_cache, it's great for
> a changelog and helped me understand why you're doing this, but doesn't
> belong to the final version as is.
> 
>> + *
>> + * Multiple producers (any context, any CPU) call llist_add; a single
>> + * consumer (llist_del_first, serialised by the monitor's start lock)
> 
> Which monitor's start lock? There is no such a thing defined anywhere,
> maybe you wanted to say that monitors using this allocation scheme MUST
> lock during their start event. This by the way needs to be a global lock
> among all instances of the monitor (as you're indeed doing in tlob).
> 
> With that in mind, I don't really see how this is better than the
> original mempool: you still need to lock. There's nothing wrong in
> freeing stuff from RCU callbacks, that's what they're for.

Thanks, v5 drops the llist stack and uses a pre-allocated mempool:

   - mempool_init_kmalloc_pool(&da_monitor_pool, DA_MON_POOL_SIZE, ...)
     eager-allocates all slots at init;
   - mempool_alloc_preallocated() pops a slot without touching the
     allocator, bounding start latency and returning NULL when the pool
     is exhausted (-ENOSPC);
   - mempool_free() from RCU-callback context is safe (no lock taken).

This is the mempool you pointed at in v4, with the allocation moved
before the monitor start instead of on it.

> 
>> + * needs no additional synchronisation.
>> + *
>> + * Per-TU statics: each PER_OBJ monitor gets its own pool instance;
>> + * da_pool_storage and da_pool_free_list are NULL/empty and the pool
>> + * paths are dead code for non-pool monitors.
>> + */
> 
>> +static struct da_monitor_storage *da_pool_storage;
>> +static LLIST_HEAD(da_pool_free_list);
> 
> ...
> 
>> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
>> @@ -17,8 +17,8 @@
>>   
>>   #define RV_MON_TYPE RV_MON_PER_OBJ
>>   #define HA_TIMER_TYPE HA_TIMER_WHEEL
>> -/* The start condition is on sched_switch, it's dangerous to allocate there
>> */
>> -#define DA_SKIP_AUTO_ALLOC
>> +/* Allocate storage in sched_setscheduler; sched_switch is too hot to alloc.
>> */
>> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
>>   typedef struct sched_dl_entity *monitor_target;
>>   #include "nomiss.h"
>>   #include <rv/ha_monitor.h>
>> @@ -214,7 +214,7 @@ static void handle_sys_enter(void *data, struct pt_regs
>> *regs, long id)
>>   	if (p->policy == SCHED_DEADLINE)
>>   		da_reset(EXPAND_ID_TASK(p));
>>   	else if (new_policy == SCHED_DEADLINE)
>> -		da_create_or_get(EXPAND_ID_TASK(p));
>> +		da_create_empty_storage(get_entity_id(&p->dl, task_cpu(p),
>> DL_TASK));
> 
> I'm starting to doubt this is the right thing to do. We do have the
> target (p) and that function doesn't check if the id already has a
> storage (which shouldn't happen but well, doesn't hurt checking).
> 
> This simplification is probably just not worth it, and doesn't look
> related to the rest of the change.
> 

Reverted. nomiss.c is untouched in v5 (still DA_SKIP_AUTO_ALLOC and
da_create_or_get()); patch 1 now only touches da_monitor.h.

--
Best wishes,
Wen
