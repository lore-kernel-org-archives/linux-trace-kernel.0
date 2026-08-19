Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7F3C1D7F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164494; cv=none; b=rgJJ6qpsjF85e9PnavLuxtmqIZyTljM1shBIlEKIxLNcZAMmc3DTdf+p44+SEA828Sq+zEbyqI8ztnnAJWp6Vb23J+IgbnVZ0ftFclwnh5fsm99mkEwnkvFk0mVwNUPKXlIuqs6SPA0//rU0RHzfvM/orRAdW6T3L1wbkhfnhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164494; c=relaxed/simple;
	bh=kMcvVDWSZZxeNodMOi4yBpdzpa4gkw0l+yLfTm8Ute0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIovvgzfa19fOXsSsBj8iCZ1XFWAHDF2bW/aSGr2/lilXocuO/VuiwkMzaPmBOggNQpe5zgK/4CWSE6FTOm/w/i2j5PCn0JJFswOGTxuScrj4ELy6kiMwylUxHJaGLAKGa0tHtCw84ru6qvAH7JGcBy4dEw0Fwy7KuBL8j1m3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K34xmKIp; arc=none smtp.client-ip=95.215.58.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K34xmKIp"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kMcvVDWSZZxeNodMOi4yBpdzpa4gkw0l+yLfTm8Ute0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787164490; v=1; x=1787769290;
 b=K34xmKIpFYTaKVxPn++Z6Ugd36+uOEXkdq1CzdVvaI7w0Dl/MQvK5sf2KH7Es4OU6DvsMiNL
 /31a6m02D3E+7inr4stx8HfTEP5AChN8PMH0tgIukll13bt93TkODHpQrkxhSSo1NvVILDChxk8
 4hW3FZcHSs4nWNVFK/sYhV5Q=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from [192.168.1.71] (218.1.223.168)
	by smtp.migadu.com with ESMTPS id 426cd27b0159082e;
	Wed, 19 Aug 2026 18:34:50 +0000
X-Mizu-Trace-ID: 426cd27b0159082e
X-Migadu-Flow: FLOW_OUT
Message-ID: <d0ef8e7e-13a6-49d9-b553-aa940f6cc3a1@linux.dev>
Date: Thu, 20 Aug 2026 02:34:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] rv/tlob: add tlob hybrid automaton monitor
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1783524627.git.wen.yang@linux.dev>
 <09d656759685edcb0fbeead775300094e7ca5002.1783524627.git.wen.yang@linux.dev>
 <9fab4d73b21d588d216d57079d34455deb211a88.camel@redhat.com>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <9fab4d73b21d588d216d57079d34455deb211a88.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/20/26 22:49, Gabriele Monaco wrote:
> On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> +/* Uprobe binding list; protected by tlob_uprobe_mutex. */
>> +static LIST_HEAD(tlob_uprobe_list);
>> +static DEFINE_MUTEX(tlob_uprobe_mutex);
>> +
>> +/*
>> + * Serialises duplicate-check + da_handle_start_run_event() per pid.
>> + * spinlock_t not raw_spinlock_t: uprobe handlers run under Tasks Trace
>> + * SRCU (rcu_read_lock_trace()), which permits sleeping on PREEMPT_RT.
>> + */
> 
> I don't think these comments add much value. spinlock_t is allowed in
> RCU critical sections anyway (it's some sort of preemption and RCU is
> preemptible under PREEMPT_RT).
> 
> Of course if it isn't really required we don't use a raw spinlock, you
> don't need a justification here.
> 
>> +static DEFINE_SPINLOCK(tlob_start_lock);
>> +
>> +/* Per-uprobe-binding state: a start + stop probe pair for one binary region.
>> */
>> +struct tlob_uprobe_binding {
>> +	struct list_head	list;
>> +	u64			threshold_ns;
>> +	char			binpath[TLOB_MAX_PATH];
>> +	loff_t			offset_start;
>> +	loff_t			offset_stop;
>> +	DECLARE_RV_UPROBE(start_probe);
>> +	DECLARE_RV_UPROBE(stop_probe);
>> +};
>> +
>> +/*
>> + * Per-task teardown invoked by da_monitor_destroy() for each hash entry.
>> + * CAS on stopping (0->1) claims exclusive cleanup ownership.
> 
> I find reading acronyms extremely annoying, since non-locking algorithms
> are already complex on their own, why don't you just say cmpxchg (which
> is searchable) instead of CAS. Sure CAS isn't an obscure acronym but I
> could find at least another 4 different definitions in the kernel tree.
> 
>> + *
>> + * No per-entry ha_cancel_timer_sync(): da_monitor_destroy() calls
>> + * da_monitor_reset_all() + synchronize_rcu() before this hook, and
>> + * ha_mon_destroying prevents new timer callbacks from running.
>> + */
>> +static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
>> +{
>> +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
>> +	struct tlob_task_state *ws = ha_get_target(ha_mon);
>> +
>> +	if (!ws)
>> +		return;
>> +
>> +	if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
>> +		return;
>> +
>> +	put_task_struct(ws->task);
>> +	/*
>> +	 * da_monitor_destroy() has already called synchronize_rcu(); no
>> +	 * reader holds ws.  Return the slot directly without call_rcu.
>> +	 */
>> +	llist_add(&ws->free_node, &tlob_ws_free_list);
>> +}
>> +
>> +static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
>> +			       enum tlob_acc_idx idx)
>> +{
>> +	struct tlob_task_state *ws;
>> +	unsigned long flags;
>> +
>> +	guard(rcu)();
>> +	ws = da_get_target_by_id(task->pid);
>> +	if (!ws)
>> +		return false;
>> +	raw_spin_lock_irqsave(&ws->entry_lock, flags);
>> +	ws->accs_ns[idx] += ktime_to_ns(ktime_sub(now, ws->last_ts));
>> +	ws->last_ts = now;
>> +	raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
>> +	return true;
>> +}
>> +
>> +/* Accumulate running_ns for prev; returns true if prev is monitored. */
>> +static inline bool tlob_acc_running(struct task_struct *task, ktime_t now)
>> +{
>> +	return __tlob_acc(task, now, TLOB_ACC_RUNNING);
>> +}
>> +
>> +/* Accumulate waiting_ns for next; returns true if next is monitored. */
> 
> There's no next and prev here, plus you're describing __tlob_acc()'s
> behaviour 3 times, I'd say just document that (even if it isn't the
> primary facing function) and that's all.
> 
>> +static inline bool tlob_acc_waiting(struct task_struct *task, ktime_t now)
>> +{
>> +	return __tlob_acc(task, now, TLOB_ACC_WAITING);
>> +}
>> +
>> +/*
>> + * handle_sched_switch - advance the DA on every context switch.
>> + *
>> + * Generates three DA events:
>> + *   prev, prev_state != 0  -> sleep_tlob    (running -> sleeping)
>> + *   prev, prev_state == 0  -> preempt_tlob  (running -> waiting)
>> + *   next                   -> switch_in_tlob (waiting -> running)
>> + *
>> + * A single ktime_get() at handler entry is shared by both acc calls so that
>> + * prev's running_ns and next's waiting_ns share the same context-switch
>> + * timestamp; neither absorbs handler overhead into its accumulator.
>> + *
>> + * No waiting->sleeping edge exists: a task can only block voluntarily
>> + * (call schedule()) while it is executing on CPU, which corresponds to
>> + * the running DA state.  A task in the waiting state is TASK_RUNNING in
>> + * kernel terms (on the runqueue) and cannot block itself.
>> + *
>> + * da_handle_event() is called unconditionally: it skips tasks that have no
>> + * monitor entry in the hash table.
>> + */
>> +static void handle_sched_switch(void *data, bool preempt_unused,
>> +				struct task_struct *prev,
>> +				struct task_struct *next,
>> +				unsigned int prev_state)
>> +{
>> +	ktime_t now = ktime_get();
>> +	bool prev_preempted = (prev_state == 0);
>> +
>> +	if (tlob_acc_running(prev, now))
>> +		da_handle_event(prev->pid, NULL,
>> +				prev_preempted ? preempt_tlob : sleep_tlob);
>> +	if (tlob_acc_waiting(next, now))
>> +		da_handle_event(next->pid, NULL, switch_in_tlob);
>> +}
>> +
>> +/* Accumulate sleeping_ns on wakeup; returns true if task is monitored. */
>> +static inline bool tlob_acc_sleeping(struct task_struct *task, ktime_t now)
>> +{
>> +	return __tlob_acc(task, now, TLOB_ACC_SLEEPING);
>> +}
>> +
>> +/*
>> + * handle_sched_wakeup - sleeping -> waiting transition.
>> + *
>> + * try_to_wake_up() skips TASK_RUNNING tasks, so this never fires for a
>> + * task already in running or waiting state.
>> + */
>> +static void handle_sched_wakeup(void *data, struct task_struct *p)
>> +{
>> +	ktime_t now = ktime_get();
>> +
>> +	if (tlob_acc_sleeping(p, now))
>> +		da_handle_event(p->pid, NULL, wakeup_tlob);
>> +}
>> +
>> +/*
>> + * handle_sched_process_exit - clean up if a task exits without TRACE_STOP.
>> + *
>> + * Called in do_exit() context; the task still has a valid pid here.
>> + * tlob_stop_task() returns -ESRCH if the task is not monitored, which is
>> fine.
>> + */
>> +static void handle_sched_process_exit(void *data, struct task_struct *p,
>> +				       bool group_dead)
>> +{
>> +	tlob_stop_task(p);
>> +}
>> +
>> +/**
>> + * tlob_start_task - begin monitoring @task with budget @threshold_ns ns.
>> + * @task:         Task to monitor; may be current or another task.
>> + * @threshold_ns: Latency budget in nanoseconds (wall-clock; running +
>> + *                waiting + sleeping).
>> + *                Must be in [1000, TLOB_MAX_THRESHOLD_NS].
>> + *
>> + * Returns 0, -ENODEV, -ERANGE, -EALREADY, or -ENOSPC (pool at capacity).
>> + */
>> +int tlob_start_task(struct task_struct *task, u64 threshold_ns)
>> +{
>> +	struct tlob_task_state *ws;
>> +
>> +	if (!da_monitor_enabled())
>> +		return -ENODEV;
>> +
>> +	if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
>> +	    threshold_ns > TLOB_MAX_THRESHOLD_NS)
>> +		return -ERANGE;
>> +
>> +	/* Serialise duplicate-check + pool-slot claim; see tlob_start_lock.
>> */
>> +	guard(spinlock)(&tlob_start_lock);
>> +
>> +	/*
>> +	 * __da_get_mon_storage() uses hash_for_each_possible_rcu(), which
>> +	 * requires an RCU read-side critical section.  On PREEMPT_RT,
>> +	 * spinlock_t is an rt_mutex and does not satisfy this requirement.
>> +	 */
> 
> Also this is probably misleading, getting the monitor requires RCU, then
> the fact some in some configuration something other than read_lock_rcu()
> would work too (e.g. disabling preemption) is irrelevant.
> 
>> +	scoped_guard(rcu) {
>> +		if (da_get_target_by_id(task->pid))
>> +			return -EALREADY;
>> +	}
>> +
>> +	/*
>> +	 * Both tlob_ws_alloc() and da_handle_start_run_event() pop from
>> +	 * pre-allocated pools of size TLOB_MAX_MONITORED; NULL return means
>> +	 * the pool is at capacity.
>> +	 */
>> +	ws = tlob_ws_alloc();
>> +	if (!ws)
>> +		return -ENOSPC;
>> +
>> +	ws->task = task;
>> +	get_task_struct(task);
>> +	ws->threshold_ns = threshold_ns;
>> +	ws->last_ts = ktime_get();
>> +	raw_spin_lock_init(&ws->entry_lock);
>> +
>> +	/*
>> +	 * da_handle_start_run_event() claims a pool slot via
>> da_prepare_storage(),
>> +	 * initialises the monitor, and delivers start_tlob in one step: the
>> +	 * generated ha_setup_invariants() resets clk_elapsed and arms the
>> timer.
>> +	 * Returns 0 if the da_monitor_storage pool is exhausted.
>> +	 */
> 
> And try not to be too specific about the internal implementation of the
> library, that can change without notice, we don't want to have to update
> all comments.
> 
> Here it is indeed non-trivial to assume no space if
> da_handle_start_run_event() fails, but that's only consequence of the
> fact that this ws is certainly new (by construction) and the monitor is
> enabled: da_handle_start_run_event() can only fail if allocation failed.
> 
> da_handle_start_* functions return 1 if an event was handled, this is
> by the way not documented..
> 
> You could simply say something like:
> 
>   da_handle_start_run_event() returns false if no event was handled, in
> this case it can happen only if memory allocation failed
> 
>> +	if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
>> +		put_task_struct(task);
>> +		tlob_ws_direct_return(ws);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tlob_start_task);
>> +
>> +/**
>> + * tlob_stop_task - stop monitoring @task.
>> + * @task: Task to stop.
>> + *
>> + * CAS on ws->stopping (0->1) under RCU claims cleanup ownership;
>> + * the winner cancels the timer synchronously and frees all resources.
>> + *
>> + * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
>> + * or -EAGAIN (concurrent caller claimed cleanup).
>> + */
>> +int tlob_stop_task(struct task_struct *task)
>> +{
>> +	struct da_monitor *da_mon;
>> +	struct ha_monitor *ha_mon;
>> +	struct tlob_task_state *ws;
>> +	bool budget_exceeded;
>> +
>> +	scoped_guard(rcu) {
>> +		ws = da_get_target_by_id(task->pid);
>> +		if (!ws)
>> +			return -ESRCH;
>> +
>> +		da_mon = da_get_monitor(task->pid, NULL);
>> +		if (unlikely(WARN_ON_ONCE(!da_mon)))
>> +			return -ESRCH;
>> +
>> +		ha_mon = to_ha_monitor(da_mon);
>> +
>> +		/*
>> +		 * CAS (0->1) claims cleanup ownership under RCU (ws
>> guaranteed valid).
>> +		 * _release pairs with atomic_read_acquire in
>> ha_setup_invariants.
>> +		 */
>> +		if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
>> +			return -EAGAIN;
>> +	}
>> +	/*
>> +	 * ws and ha_mon are used below outside the RCU guard.  This is safe:
>> +	 * the winning CAS (stopping: 0->1) is the only path that frees ws,
>> +	 * and da_destroy_storage() below is the only call that returns the
>> +	 * pool slot.  No concurrent path can free either object.
>> +	 */
>> +
>> +	/* Wait for in-flight timer callback before reading da_monitoring. */
>> +	ha_cancel_timer_sync(ha_mon);
>> +
>> +	/* Timer fired first -> budget exceeded; otherwise reset normally. */
>> +	scoped_guard(rcu) {
>> +		budget_exceeded = !da_monitoring(da_mon);
>> +		if (!budget_exceeded)
>> +			da_monitor_reset(da_mon);
>> +	}
>> +	da_destroy_storage(task->pid);
> 
> Here you're playing with the state machine, that looks fragile from a
> monitor code.
> You could probably have budget_exceeded as part of your target and set
> it from tlob_reset_notify() when you know there was an expiration.
> 
> Perhaps "stop" could be yet another event in the state machine, bringing
> to the "stopped" state, which would automatically call reset(), you only
> need to grab ws->stopping before handling the event for
> tlob_reset_notify() to work as expected.
> Though you'd probably still need ha_cancel_timer_sync() for the rare but
> not impossible in-flight timer not yet in RCU critical section..
> 
> I'd rather avoid as much as possible bringing in ha_mon/da_mon, but you
> probably cannot do better here, just you could avoid relying on
> da_monitoring().
> 
> What do you think?
> 

Thanks.
I took this wholesale, it is exactly how v5 is structured now:

- tlob.dot gains a "stopped" state and a "stop" event (running ->
   stopped, only from running; stopped -> running on "start").
- tlob_stop_task() no longer resets or frees anything.  It claims the
   window with a cmpxchg on ws->stopping, waits for the in-flight timer
   with ha_cancel_timer_sync() (as you predicted, still needed), then
   dispatches da_handle_event(pid, NULL, stop_tlob).  The entry stays in
   the hash table, parked.
- budget_exceeded moved into the target: tlob_reset_notify() sets
   ws->budget_exceeded on genuine timer expiry, and tlob_stop_task()
   reads it back.  No reliance on da_monitoring() anywhere on the stop
   path.
- A later "start" for the same task restarts the parked window in
   place: same pool slot, hash entry and task_struct reference, no
   allocation.  ha_setup_invariants() clears ws->stopping on the start
   transition, so __tlob_acc() keeps scheduler events off the parked
   entry (the model has no stopped self-loops).
- ws->stopping is per-window (cleared on restart); final teardown is
   claimed per-task through ws->destroying (tlob_extra_cleanup() on
   monitor disable switches to destroying too).  This lets
   handle_sched_process_exit() call stop then destroy, and lets unbind
   reap tasks parked under a removed binding (tlob_unbind_reap(), closing
   the leak where parked tasks lingered until exit).

The stop path still touches ha_mon (to read the target and cancel the
timer) but no longer touches da_mon or its monitoring flag.


--
Best wishes,
Wen
