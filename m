Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A440636
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164473; cv=none; b=b8X6BfChNHLa+T3NssiIGDSoH+me3hivyF0YjU6d1HGkg8NSNLpTnnY1RsubLmcJ4u8ASBEVuc9QgK94TfkP4S8vKtJ8IQQ3Eh0LvG5kZu4CWu6xaPRC58rR3PxBC3fz/uIoiuRndkHjDqA+fNdDnXukIwvaS+4nZu6A5Mgt4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164473; c=relaxed/simple;
	bh=aU4R9c59dK9wsG9ESNAzE3qyiRSPY+xthf7eC7FIPJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UGVr6Lt35gHGb7U7d9DoA0vJQZrSxX2mEPo8rxBnSvqzTBQmR1PO8DIGN70uvkMycj4TZb8rlOcmd9xLLSdQkllWyFKLj55v/IZvOPrgPybfyZ4ViRLuk6EuSE+o4KHBIs8gjxe5IVnAbQWYo6e8cxWv9Duv26HVR9vozKsm178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw+PSoNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw+PSoNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3882C1F000E9;
	Wed, 19 Aug 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164471;
	bh=JR3kECnf0Jq19uwZhyBeRPQo0kBCt1oNbXxcJUyBb2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nw+PSoNVn27zRZrJIrGdesr856cxUOGnREYNuZwyyz4K8Jij3aWfCFuV1ZVwWYzmV
	 bt3ylfvcnd1j4Nwa9sMX9BhrBbpc0/7nycUw+8Wt+3oCR6vWNC7V5Pst8jQQyCaXn8
	 8Q1KmPcI2XTzat9AXr5j1npgsgI5AtKID/1gzh9zjvITtHaXLYIXNDJ+un8bqwFvmc
	 AAG+k4af02FNNe+KqhBOoxz9Xi05YVcteWsmHkBCJ2yXrX4pmKtJpsAHlsmP0CzSa8
	 qdJ9InqZW8Ywf5deTfLyUCoDQfrpLBDy9+mv1RmculD6T6blxiRUkS6BGn/4UkRApK
	 Y3MNWRc8qxJIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] rv: Add tlob hybrid automaton monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <392de71fe1497f2b9d8ce06c387ec83c4b116c47.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <392de71fe1497f2b9d8ce06c387ec83c4b116c47.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:34:30 +0000
Message-Id: <20260819183431.3882C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Relying on the empty stub `ha_cancel_timer_sync()` leaves the =
budget timer active when windows close, causing Use-After-Free panics on ti=
mer expiry.
- [High] Concurrent task exit during `tlob_unbind_reap()` causes Use-After-=
Free and list corruption.
- [High] `tlob_destroy_task()` dereferences `ha_mon` outside of the RCU rea=
d-side critical section, causing a Use-After-Free.
- [High] The clock anchor `ha_mon->env_store[clk_elapsed_tlob]` is never in=
itialized, causing immediate hrtimer firing due to integer underflow.
- [High] `tlob_destroy_task()` uses a PID lookup to find the monitor, riski=
ng UAF and corruption of an unrelated task's monitor due to PID recycling.
- [High] Dangling pointer in the RV framework hash table leading to UAF if =
`da_handle_start_run_event` fails.
- [Medium] Unbinding uprobes while a task is actively monitored permanently=
 leaks its mempool slot.
- [Medium] Missing initialization of the `stopping` flag on fresh allocatio=
ns allows sched tracepoints to trigger invalid monitor transitions.
--

--- Patch [6]: [PATCH v5 6/9] rv: Add tlob hybrid automaton monitor ---
commit 2dbaa3c57b50d6013814617edf9ea93aed73291d
Author: Wen Yang <wen.yang@linux.dev>
Subject: rv: Add tlob hybrid automaton monitor

This commit adds tlob (task latency over budget), a per-task hybrid
automaton RV monitor. It tracks wall-clock time across a user-delimited
code section and emits an error when elapsed time exceeds a configurable
budget.

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monit=
ors/tlob/tlob.c
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
[ ... ]
> @@ -218,6 +218,22 @@ static inline void ha_setup_invariants(struct ha_mon=
itor *ha_mon,
>  				       enum states curr_state, enum events event,
>  				       enum states next_state, u64 time_ns)
>  {
[ ... ]
> +	if (atomic_read_acquire(&ha_get_target(ha_mon)->stopping)) {
> +		/*
> +		 * Restart (stopped -> running): arm the timer, then clear
> +		 * stopping so __tlob_acc() admits sched events only once the
> +		 * state is already running_tlob.  _release pairs with the
> +		 * acquires in __tlob_acc/tlob_reset_notify.
> +		 */
> +		if (next_state < state_max_tlob)
> +			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_n=
s);
> +		atomic_set_release(&ha_get_target(ha_mon)->stopping, 0);
> +		return;
> +	}
> +
> +	if (next_state < state_max_tlob)
> +		ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns=
);

[Severity: High]
Does this path forget to initialize the clock anchor?

ha_setup_invariants() does not seem to assign
ha_mon->env_store[clk_elapsed_tlob] =3D time_ns here. Because it remains at=
 the
uninitialized sentinel value, won't the elapsed time calculation underflow
and cause the relative hrtimer to fire immediately upon window start?

> +	else
> +		ha_cancel_timer(ha_mon);
> +}
[ ... ]
> @@ -480,6 +480,41 @@ static int tlob_start_task(struct task_struct *task,=
 u64 threshold_ns, void *bin
>  {
[ ... ]
> +	ws =3D tlob_ws_alloc();
> +	if (!ws)
> +		return -ENOSPC;
> +
> +	ws->task =3D task;

[Severity: Medium]
Should the stopping flag be initialized to 1 here?

For a fresh allocation, tlob_ws_alloc() zeroes the memory, leaving
ws->stopping =3D 0. If a scheduler event happens during start before
ha_setup_invariants() is reached, won't __tlob_acc() allow it through while
in stopped_tlob, causing an invalid transition and monitor reset?

> +	get_task_struct(task);
> +	ws->threshold_ns =3D threshold_ns;
> +	ws->last_ts =3D ktime_get();
> +	raw_spin_lock_init(&ws->entry_lock);
> +	ws->binding =3D binding;
> +	if (binding)
> +		list_add_tail(&ws->started_node,
> +			      &((struct tlob_uprobe_binding *)binding)->started_list);
> +
> +	/* Dispatch failed (pool exhausted or monitor disabled): unwind the slo=
t. */
> +	if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
> +		if (binding)
> +			list_del_init(&ws->started_node);
> +		put_task_struct(task);
> +		tlob_ws_direct_return(ws);
> +		return -ENOSPC;
> +	}

[Severity: High]
By directly freeing ws via tlob_ws_direct_return(ws) without calling
da_destroy_storage(task->pid), does this leave a dangling pointer in the
framework hash table?

If da_handle_start_run_event() fails, it appears it has already allocated
storage in the RCU-protected da_monitor_ht hash table. Subsequent tracepoin=
ts
might dereference this freed memory.

> +
> +	return 0;
> +}
[ ... ]
> @@ -623,20 +623,32 @@ static void tlob_destroy_task(struct task_struct *t=
ask)
>  {
> +	struct ha_monitor *ha_mon;
> +	struct tlob_task_state *ws;
> +
> +	scoped_guard(rcu) {
> +		ha_mon =3D ha_get_monitor(task->pid, NULL);

[Severity: High]
Is it safe to look up the monitor by task->pid here?

If tlob_unbind_reap() delays calling tlob_destroy_task() for a task that has
already exited, the original PID might be recycled and assigned to a new
process. If this new process is also monitored by tlob, could this blindly
claim and destroy the new process's monitor while leaking the original
task state?

> +		if (!ha_mon)
> +			return;
> +		ws =3D ha_get_target(ha_mon);
> +		if (WARN_ON_ONCE(!ws))
> +			return;
> +		if (atomic_cmpxchg_release(&ws->destroying, 0, 1) !=3D 0)
> +			return;
> +	}
> +
> +	tlob_detach_from_binding(ws);
> +
> +	/* Force the window ended: @task may never have reached STOP or a timer=
. */
> +	atomic_set(&ws->stopping, 1);
> +	ha_cancel_timer_sync(ha_mon);

[Severity: High]
Is ha_mon still safe to dereference after the RCU read-side critical section
ends?

The scoped_guard(rcu) block closes just above, dropping the RCU lock. If the
monitor is concurrently disabled, ha_monitor_destroy() issues
synchronize_rcu() and frees the monitor storage. Could the storage be freed
before the teardown calls on ha_mon execute here?

[Severity: Critical]
Is this stub definition intentional?

If ha_cancel_timer_sync() is defined as an empty inline stub in
include/rv/ha_monitor.h, it seems the hrtimer is never actually dequeued.
When tlob_destroy_task() subsequently frees the monitor storage, could the
still-active timer fire and execute its callback on freed memory?

> +
> +	scoped_guard(rcu) {
> +		da_monitor_reset(&ha_mon->da_mon);
> +	}
> +	da_destroy_storage(task->pid);
[ ... ]
> @@ -748,16 +748,22 @@ static void tlob_unbind_reap(struct tlob_uprobe_bin=
ding *b)
>  {
> +	struct tlob_task_state *ws, *tmp;
> +	LIST_HEAD(to_destroy);
> +
> +	scoped_guard(spinlock, &tlob_ws_lock) {
> +		list_for_each_entry_safe(ws, tmp, &b->started_list, started_node) {
> +			list_del_init(&ws->started_node);
> +			ws->binding =3D NULL;
> +			if (atomic_read(&ws->stopping))
> +				list_add_tail(&ws->started_node, &to_destroy);
> +		}
> +	}

[Severity: Medium]
Does this sequence permanently leak the mempool slot for active tasks?

If an active task is unbound, its ws->binding is set to NULL but it is not
added to to_destroy. Since the uprobe is unregistered, the stop probe never
fires. Even if it could, tlob_stop_task() returns -EALREADY because
ws->binding is NULL. Will the task remain in running_tlob forever, leaking
its pool slot until the task exits?

> +
> +	list_for_each_entry_safe(ws, tmp, &to_destroy, started_node) {

[Severity: High]
Can concurrent task exits cause list corruption and use-after-free here?

tlob_unbind_reap() populates to_destroy and clears ws->binding under lock,
then drops the lock and iterates to_destroy locklessly.

If a task exits concurrently:
handle_sched_process_exit()
  tlob_destroy_task()
    tlob_detach_from_binding()

Because ws->binding is already NULL, tlob_detach_from_binding() returns
early without acquiring the lock or calling list_del_init().
tlob_destroy_task() then frees ws, and when tlob_unbind_reap() resumes
iterating, it accesses the freed ws object.

> +		list_del_init(&ws->started_node);
> +		tlob_destroy_task(ws->task);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D6
