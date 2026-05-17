Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A33C3430
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038046; cv=none; b=d2WanCWSWJmBBy1qhL+IVo/dJa/uOqgUXUIaDGNJRVPAZuTFPxWT3o2N2N2i/QdBAfhwAzrfwuqXbwR6e12A0ouL0rZ6CucOF4zA/cSncM9LV3iz6vfJrJtNV8zd4KzZhCL8LPopixCy0NyUfFa1UCUl79Fx83oXUhmH4DbKlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038046; c=relaxed/simple;
	bh=rx8b0v6Y1F1NN8R7DVaccWKzbuAjk3YDbSs2EHXY1Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWcT6M/9gESdY14vY0uxLvngfxFHM7FPIPT6n3r5jbz51CZS4UstNriC2QfXHEk/6eaICHni8nNHAtQIQCtGu9OZWEwD6Yz5NQ1lJWdFO8nMCrzHYHDgVTJZNz8uUo2CAgbLph4rwULQfR0eU7Is8BMEJs9CbnpZtVFt9An27XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NK/j2dif; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NK/j2dif"
Message-ID: <6d2f3490-5e30-4966-a3cd-372a34e10ba2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779038028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPtkhrGz8ZMQnVzYJCieq+2dXOHxMdSskkfFmlAHsY4=;
	b=NK/j2difn6+Ga245CWvu7jtHjnWxFU3HbGVsrASp5nxaTmNf89/As7vN6X2loqeKk8bX8X
	jKF5nuijAY0NHiqnP6lRenvWOjNZtGgRNSUbJIGmwGLXbN8sKUucrFKAgtbT2GQKsKqeDO
	eFGTsDPeHw1/mWVUdcLhXRWlzZNhmbw=
Date: Mon, 18 May 2026 01:13:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Re: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated
 storage pool for per-object monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org
References: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
 <20260515083002.106512-1-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260515083002.106512-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Gabriele,

Thanks again for the thorough review and for the design sketch.
Below is a consolidated reply grouped by patch, describing what has been
implemented in v3.


-- Patch 02: per-task slot ordering / ha_monitor_reset_env

Dropped from v3; v3 is rebased on top of your series [1].

[1] - 
https://lore.kernel.org/lkml/20260512140250.262190-8-gmonaco@redhat.com


-- Patch 03: verificationtest-ktap

 > And isn't it clearer to do:
 >   dir=$(realpath "$(dirname "$0")")

Agreed and applied:

   dir=$(realpath "$(dirname "$0")")
   export PATH="$dir:$PATH"
   "$dir/../ftrace/ftracetest" -K -v --rv "$dir"

 > Then if you really really need to call it directly, do you need to
 > override PATH?

Yes.  The ftracetest check_requires logic calls `command -v <binary>` to
satisfy `requires: <name>:program` directives.  Without the script's
directory in PATH those checks evaluate to exit_unsupported and test cases
are skipped rather than run.  The make path avoids this only because make
sets OUTDIR and the runner appends it to PATH internally.


-- Patch 04: pre-allocated storage pool

 > Since you're using spinlocks, isn't that going to sleep on PREEMPT_RT?

User-mode uprobe handlers run with preempt_count == 0, fully preemptible on
both PREEMPT_RT and non-PREEMPT_RT.  The strongest evidence is in tlob
itself: tlob_start_task() takes a mutex and calls kmem_cache_zalloc(...,
GFP_KERNEL) from the uprobe entry handler; both are illegal in atomic
context and would trigger lockdep splats immediately.

On PREEMPT_RT, spinlock_t becoming a sleeping lock in the uprobe handler 
iscfine: both call sites (da_create_or_get_pool() from the handler and
da_pool_return_cb() from the rcuc kthread) are in sleepable task context.


 > We can have a macro DA_MON_ALLOCATION_STRATEGY = {DA_ALLOC_AUTO,
 > DA_ALLOC_POOL, DA_ALLOC_MANUAL} where DA_MON_POOL also requires
 > DA_MON_POOL_SIZE to be defined (force that with an #error).
 >
 > Anyway, this way you probably wouldn't need to define a different init
 > function and let everything handled more transparently.
 >
 > Also you don't need to call da_create_or_get() explicitly,
 > da_handle_start_event() should do it for you.

Agreed on all counts.  We plan to implement this in v3 as follows.
The three strategies would be a compile-time selection in da_monitor.h:

   DA_ALLOC_AUTO   (default) - lock-free kmalloc_nolock on the hot path;
                               unbounded capacity.

   DA_ALLOC_POOL             - pre-allocated fixed-size pool; 
DA_MON_POOL_SIZE
                               required, enforced with #error if missing.

   DA_ALLOC_MANUAL           - caller pre-inserts storage via
                               da_create_empty_storage() before the first
                               da_handle_start_event(); the framework only
                               links the target field.

da_monitor_init_prealloc() would be removed; da_monitor_init() would
select pool or kmalloc initialisation internally based on the strategy.

da_handle_start_event() and da_handle_start_run_event() would both call
da_prepare_storage() at compile time:

   DA_ALLOC_AUTO   -> da_create_storage()        (kmalloc_nolock)
   DA_ALLOC_POOL   -> da_create_or_get_pool()
   DA_ALLOC_MANUAL -> da_fill_empty_storage()    (link target into pre-
                      allocated slot; no allocation on the hot path)

No explicit da_create_or_get() call would be needed in any monitor.

da_create_or_get_kmalloc() would be removed: as you noted, a caller that
uses kmalloc_nolock does so because locking is forbidden; a GFP_KERNEL
fallback is equally forbidden if the lockless attempt fails, so the
function has no viable use case.

tlob would define:
   #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
   #define DA_MON_POOL_SIZE            TLOB_MAX_MONITORED

nomiss would define:
   #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL

and call da_create_empty_storage() from handle_sys_enter() (the
sched_setscheduler syscall path), which runs in safe task context;
da_fill_empty_storage() would then link the sched_dl_entity target on
the first da_handle_start_run_event() call in handle_sched_switch().


-- Patch 05: generic uprobe infrastructure

Carried unchanged into v3 (as part of the 08-b split described below).


-- Patch 06: rvgen __init arrow reset

Thanks, carried unchanged into v3.


 > Why don't you make it a separate event (e.g. "start_tlob") [...] then
 > you also wouldn't need to call reset() and start_timer() manually.

Good suggestion.  We plan to use a dedicated start_tlob event instead,
with a self-loop in tlob.dot:

   "running" -> "running" [ label = "start;reset(clk_elapsed)" ]

da_handle_start_run_event(task->pid, ws, start_tlob) would put the
monitor into running and deliver start_tlob, which resets clk_elapsed
and arms the budget hrtimer via the generated ha_setup_invariants() —
no manual reset() or start_timer() calls needed.

One guard would be added in tlob's ha_setup_invariants() to make the
self-loop work correctly:

   if (next_state == curr_state && event != start_tlob)
       return;

Without this, the start_tlob self-loop would be treated the same as any
repeated switch_in (already running) and ha_setup_invariants() would
return early, leaving the timer unarmed.  Does this look right to you?


-- Patch 08: tlob monitor

--- Patch structure ---

 > Could you have everything that isn't strictly tlob-related in another
 > patch.

Agreed.  With the ioctl interface deferred (see below), v3 would keep
patch 08 as the tlob monitor only:

   05-b: rv: extend uprobe API with three-phase detach helpers
         (rv_uprobe.c, rv_uprobe.h, rv_uprobe_detach refactoring)
         — extension of patch 05, independent of tlob

   08:   rv/tlob: add the tlob monitor itself
         (tlob.c, tlob.h, tlob_trace.h, Kconfig/Makefile, Documentation,
          rv_trace.h include; ha_monitor.h EVENT_NONE_LBL override
          bundled here as it is only needed by tlob)

The chardev infrastructure (rv_chardev.c, rv.h additions) and the UAPI
header (include/uapi/linux/rv.h) would move to a follow-up series
together with the ioctl self-instrumentation feature.

--- ioctl interface design ---

 > I'm not particularly fond of ioctls, they aren't that flexible and in
 > this way I don't really see an added value.
 > [...] cannot the same thing be achieved using uprobes alone, e.g. by
 > registering a function address or the current instruction pointer?
 > [...] wouldn't a sysfs/tracefs file achieve a similar purpose without
 > much of the boilerplate code?

Fair point.  We plan to ship v3 with the tracefs/uprobe interface only
and defer the ioctl (/dev/rv chardev) to a follow-up series once there
is a concrete in-tree user that requires it.

The unique value of the ioctl is that TLOB_IOCTL_TRACE_STOP returns a
synchronous per-call result (-EOVERFLOW or 0) to the calling thread,
which neither uprobes nor tracefs writes can provide.  We want to keep
that option open for later, but agree it should not block the initial
tlob submission.

Does this approach work for you?

What is your preference?

--- Handler simplification ---

 > Perhaps keep the handler simpler by moving this reporting to a helper
 > function and use guard(rcu)() there.

Done.  The accumulation logic is extracted into three inline helpers, each
using scoped_guard(rcu) and returning bool (true if the task is monitored):

   tlob_acc_running(prev)   - accumulate running_ns on sched-out
   tlob_acc_waiting(next)   - accumulate waiting_ns on sched-in
   tlob_acc_sleeping(task)  - accumulate sleeping_ns on wakeup

handle_sched_switch() and handle_sched_wakeup() become one-liners:

   static void handle_sched_switch(...)
   {
       bool prev_preempted = (prev_state == 0);

       if (tlob_acc_running(prev))
           da_handle_event(prev->pid, NULL,
                           prev_preempted ? preempt_tlob : sleep_tlob);
       if (tlob_acc_waiting(next))
           da_handle_event(next->pid, NULL, switch_in_tlob);
   }

 > You probably don't need these. da_handle_event should skip tasks without
 > a monitor.

Agreed; the do_prev/do_next flags are gone.  The helpers return false
for unmonitored tasks, and da_handle_event() skips them too — both paths
are no-ops for tasks with no pool entry.

--- scoped_guard(rcu) ---

 > That should be a scoped_guard(rcu), definitely use guards if you have
 > return paths, the compiler is going to clean up (unlock) for you.

Applied to all RCU-protected sections in tlob_start_task() and
tlob_stop_task().  tlob_start_task() now uses guard(mutex) for the
serialised duplicate-check (replacing the explicit mutex_lock/unlock),
and tlob_stop_task() uses scoped_guard(rcu) for the atomic CAS section:

   scoped_guard(rcu) {
       ws = da_get_target_by_id(task->pid);
       if (!ws)
           return -ESRCH;
       ...
       if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
           return -EAGAIN;
   }

--- tlob_stop_all removal ---

 > All this function does should be done by da_monitor_destroy. We could
 > add a way to pass some additional deallocation for all the other cleanup
 > you're doing on each storage.  Something like a da_extra_cleanup() you
 > can define as whatever you need and gets called in all per-obj
 > destruction paths.

Agreed.  tlob_stop_all() (~50 lines) has been removed entirely.

A da_extra_cleanup() hook macro is introduced in da_monitor.h: the default
is a no-op; a monitor may override it before including the header.  tlob
defines:

   static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
   {
       struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
       struct tlob_task_state *ws = da_get_target(ha_mon);

       if (!ws)
           return;
       if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
           return;
       ha_cancel_timer_sync(ha_mon);
       atomic_dec(&tlob_num_monitored);
       put_task_struct(ws->task);
       call_rcu(&ws->rcu, tlob_free_rcu);
   }
   #define da_extra_cleanup tlob_extra_cleanup

da_monitor_destroy() iterates remaining entries via da_extra_cleanup +
hash_del_rcu + call_rcu, then waits for all callbacks via rcu_barrier().
tlob's disable path is now simply:

   static void __tlob_destroy_monitor(void)
   {
       da_monitor_destroy();
   }

--- EVENT_NONE_LBL ---

 > Why don't you just override EVENT_NONE_LBL (and if you prefer call it
 > MONITOR_TIMER_EVENT_NAME) without the need for another function?

Done.  model_get_timer_event_name() has been removed from automata.h.
In ha_monitor.h, EVENT_NONE_LBL is now overridable:

   #ifndef EVENT_NONE_LBL
   #define EVENT_NONE_LBL "none"
   #endif

tlob.c defines it before including the model header:

   #define EVENT_NONE_LBL "budget_exceeded"

The two call sites in ha_monitor.h that previously called
model_get_timer_event_name() now use EVENT_NONE_LBL directly.

--- KUnit config / tristate ---

 > Do you need to add this here? Since you have a patch adding KUnit tests
 > to tlob, cannot you put everything kunit-related there?
 > I couldn't build it as module.

Agreed on moving the Kconfig entry to patch 09.

The module build issue is fixed by exporting the symbols needed by the
test via EXPORT_SYMBOL_IF_KUNIT (EXPORTED_FOR_KUNIT_TESTING namespace);
tlob_kunit.c imports the namespace with MODULE_IMPORT_NS.  We plan to
keep tristate rather than changing to bool.  Does that work for you?

--- detail_env_tlob tracepoint ---

 > Since you are not documenting the detail_env_tlob tracepoint, is it
 > something really required? I would at the very least document its usage.

Fair point.  detail_env_tlob emits (running_ns, waiting_ns, sleeping_ns)
so the user can see which phase consumed the budget: high sleeping_ns
indicates I/O latency, high waiting_ns indicates scheduler pressure, high
running_ns indicates a compute overrun.  Without this breakdown the user
only knows the total elapsed time exceeded the threshold, not why.


--- Documentation ---

 > This is standard tracepoints usage, there's nothing about tlob we should
 > document here.
 > Same here, standard RV [for enable/desc tracefs files].
 > And this is duplicating what mentioned above about uprobes, isn't it?

Agreed.  The following have been removed:

   - "Violation events" section: generic trace-cmd examples and cat-trace
     instructions (standard tracepoints usage).
   - tracefs files: "enable (rw)" and "desc (ro)" entries (standard RV).
   - tracefs files: "monitor (rw)" description condensed to one line with
     a cross-reference to the uprobes section above.

In their place, a new "Violation tracepoints" subsection documents both
tlob-specific tracepoints with fields and a worked example:

   error_env_tlob: id, state, event ("budget_exceeded"), env ("clk_elapsed")

   detail_env_tlob: id, threshold_us, running_ns, waiting_ns, sleeping_ns
     Use sleeping_ns to diagnose I/O latency, waiting_ns for scheduler
     pressure, running_ns for compute overruns.

   Example:
     trace-cmd record -e error_env_tlob -e detail_env_tlob &
     # ... run workload ...
     trace-cmd report

 > Is kernel code going to use this API? RV monitors are meant to be
 > enabled by userspace. What's the use-case here?

Agreed.  The uprobe interface is driven from userspace; tlob_start_task()
and tlob_stop_task() are the internal implementation functions it calls,
not a public API for external kernel modules.  The hypothetical
kernel-module use case would be removed from the documentation; the
kernel-doc block is retained for code maintainers.

 > That's probably a bit too detailed for this page. If you really want
 > this information somewhere couldn't it stay in the code?

Agreed; moved to comments in handle_sched_switch() and
handle_sched_wakeup().  The "Limitations" subsection is retained.


-- Patch 09: KUnit tests

 > What caught my eyes are tests enrolling tracepoints handlers. If you
 > go there you're no longer doing unit testing, what's the advantage of
 > testing the entire monitor here over doing that in selftests?

Agreed.  The three suites that register tracepoint handlers or create
kthreads (tlob_sched_integration, tlob_trace_output, tlob_violation_react)
have been removed from KUnit and will be added to selftests in v3.

Two pure unit test suites remain in KUnit:

   tlob_task_api:
     Tests tlob_start_task / tlob_stop_task return values (-ENODEV,
     -EALREADY, -ESRCH, -EOVERFLOW, -ENOSPC, -ERANGE) via direct calls
     (these functions are the internal implementation used by both the
     uprobe and, in future, the ioctl interface).
     No tracepoints, no scheduling.

   tlob_uprobe_format:
     Tests the uprobe line parser (tlob_parse_uprobe_line,
     tlob_parse_remove_line) against valid and invalid input strings.
     Pure string parsing; no scheduling, no tracepoints.

This also resolves the tristate-vs-bool issue: with only pure unit tests
there is no dependency on sched_setscheduler_nocheck, so bool is correct.


--  Patch 10: selftests

--- PREEMPT_RT RCU stall ---

 > I run it on a VM and have it hanging at step 9 [...] rcu_preempt stall.
 > Did you see that? Am I doing something wrong?

Thanks for reporting.  The patch changed ha_monitor.h from
HRTIMER_MODE_REL_HARD (the existing upstream value) to REL_SOFT; the
stall appeared on PREEMPT_RT after that change.  We have not fully
confirmed whether REL_SOFT is the root cause — REL_SOFT defers the
callback to the ktimers kthread, which could starve rcu_preempt under
certain PREEMPT_RT configurations, but other factors may be involved.

We plan to revert to HRTIMER_MODE_REL_HARD at both sites in ha_monitor.h
as the conservative choice:

   ha_setup_timer():     HRTIMER_MODE_REL_SOFT -> HRTIMER_MODE_REL_HARD
   ha_start_timer_ns():  HRTIMER_MODE_REL_SOFT -> HRTIMER_MODE_REL_HARD

Do you have more insight into the stall, or does REL_HARD resolve it on
your setup?

--- Selftest structure ---

 > This should be tested together with the other monitors (enable/disable),
 > we could at most expand those with the check_requires.
 > Let's focus on tlob-only features in this patch.

Agreed.  In v3 we plan to drop tracefs.tc (covered by the generic
rv_monitor_enable_disable.tc) and keep only the six uprobe-specific
test cases under test.d/tlob/

ioctl.tc is deferred with the ioctl interface to the follow-up series.
The KUnit integration tests (sched_switch accounting, budget-expiry
tracepoint) would be moved to selftests as additional test cases.

--
Thanks,
Wen


On 5/15/26 16:30, Gabriele Monaco wrote:
> So this is what I meant. It's quick and dirty but seems to work as far
> as I could test it.
> 
> I didn't change too much around to avoid confusing more, but it probably
> needs a refactor for the functions positions and names. Some AI can do
> that later after we agree on how it should look.
> 
> The main idea is (using current function names):
> 
> da_handle_start_[run_]_event() calls da_prepare_storage(), this
> makes sure the storage is there and usable based on the strategy:
> 1. da_create_storage() plain allocation with kmalloc_nolock
> 2. da_create_or_get_pool() get a slot from the pool
> 3. da_fill_empty_storage() only set the target in a storage manually
>     allocated before
> 
> The reason why you'd need 3. is that since da_handle_start_event() is
> called from a tracepoint, you may in no way be able to allocate from
> there, then you use manually somewhere else with
> da_create_empty_storage() if you don't have the target and
> da_create_or_get() if you do (this one is misleading, we should probably
> simplify further).
> 
> The newly created 2. might be useful if you aren't on preempt-rt and
> cannot sleep but also don't want a manual allocation (beware of lock
> dependencies, it doesn't always work).
> 
> Now, I left your da_create_or_get_kmalloc() unwired because I don't
> really see the use case (you use kmalloc_nolock because you cannot lock,
> so if it fails you don't try a kmalloc). But if we really want to offer
> a possibility to allocate with GFP_KERNEL, we can make 1. more
> configurable.
> 
> Does this make sense to you?
> 
> Thanks,
> Gabriele
> 
> ---
>   include/rv/da_monitor.h                  | 160 ++++++++++-------------
>   kernel/trace/rv/monitors/nomiss/nomiss.c |   2 +-
>   kernel/trace/rv/monitors/tlob/tlob.c     |  15 +--
>   3 files changed, 74 insertions(+), 103 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 74aa95d9a284..3b4a36245531 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -21,6 +21,7 @@
>   #include <linux/sched.h>
>   #include <linux/slab.h>
>   #include <linux/hashtable.h>
> +#include <linux/mempool.h>
>   
>   /*
>    * Per-cpu variables require a unique name although static in some
> @@ -67,6 +68,35 @@ static struct rv_monitor rv_this;
>   #define da_id_type int
>   #endif
>   
> +#define DA_ALLOC_AUTO 0
> +#define DA_ALLOC_POOL 1
> +#define DA_ALLOC_MANUAL 2
> +
> +/*
> + * Allow the per-object monitors to run allocation manually, necessary if the
> + * start condition is in a context problematic for allocation (e.g. scheduling).
> + * In such case, if the storage was pre-allocated without a target, set it now.
> + */
> +#ifndef DA_MON_ALLOCATION_STRATEGY
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
> +#endif
> +#ifndef DA_MON_POOL_SIZE
> +#define DA_MON_POOL_SIZE 0
> +#endif
> +#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_MANUAL
> +#define da_prepare_storage da_fill_empty_storage
> +
> +#elif DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
> +#define da_prepare_storage da_create_or_get_pool
> +#if DA_MON_POOL_SIZE == 0
> +#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be non-zero"
> +#endif
> +
> +#else
> +#define da_prepare_storage da_create_storage
> +#endif /* DA_MON_ALLOCATION_STRATEGY */
> +
> +
>   static void react(enum states curr_state, enum events event)
>   {
>   	rv_react(&rv_this,
> @@ -448,62 +478,38 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
>   }
>   
>   /*
> - * Per-object pool state.
> - *
> - * Zero-initialised by default (storage == NULL ⟹ kmalloc mode).  A monitor
> - * opts into pool mode by calling da_monitor_init_prealloc(N) instead of
> - * da_monitor_init(), which sets storage to a non-NULL kcalloc'd array.
> - *
> - * Because every field is wrapped in this struct and the struct itself is a
> - * per-TU static, each monitor that includes this header gets a completely
> - * independent pool.  A kmalloc monitor (e.g. nomiss) and a pool monitor
> - * (e.g. tlob) therefore coexist without any interference.
> - *
> - * da_pool_return_cb runs from softirq on non-PREEMPT_RT, so irqsave is
> - * required to prevent deadlock with task-context callers.  On PREEMPT_RT
> - * it runs from an rcuc kthread where spinlock_t is a sleeping lock.
> - */
> -struct da_per_obj_pool {
> -	struct da_monitor_storage  *storage;  /* non-NULL ⟹ pool mode */
> -	struct da_monitor_storage **free;     /* kmalloc'd pointer stack */
> -	unsigned int                free_top;
> -	spinlock_t                  lock;
> -};
> -
> -static struct da_per_obj_pool da_pool = {
> -	.lock = __SPIN_LOCK_UNLOCKED(da_pool.lock),
> -};
> + * Per-object pool state using kmem_cache and mempool.
> + */
> +static struct kmem_cache *da_mon_cache;
> +static mempool_t *da_mon_pool;
>   
>   static void da_pool_return_cb(struct rcu_head *head)
>   {
>   	struct da_monitor_storage *ms =
>   		container_of(head, struct da_monitor_storage, rcu);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&da_pool.lock, flags);
> -	da_pool.free[da_pool.free_top++] = ms;
> -	spin_unlock_irqrestore(&da_pool.lock, flags);
> +	mempool_free(ms, da_mon_pool);
>   }
>   
> -/* Pops a slot from the pre-allocated pool; returns -ENOSPC if exhausted. */
> -static inline int da_create_or_get_pool(da_id_type id, monitor_target target)
> +/* Pops a slot from the pre-allocated pool; returns NULL if exhausted. */
> +static inline struct da_monitor *da_create_or_get_pool(da_id_type id,
> +						       monitor_target target,
> +						       struct da_monitor *da_mon)
>   {
>   	struct da_monitor_storage *mon_storage;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&da_pool.lock, flags);
> -	if (!da_pool.free_top) {
> -		spin_unlock_irqrestore(&da_pool.lock, flags);
> -		return -ENOSPC;
> -	}
> -	mon_storage = da_pool.free[--da_pool.free_top];
> -	spin_unlock_irqrestore(&da_pool.lock, flags);
> +	if (da_mon)
> +		return da_mon;
>   
> +	mon_storage = mempool_alloc_preallocated(da_mon_pool);
> +	if (!mon_storage)
> +		return NULL;
> +
> +	memset(mon_storage, 0, sizeof(*mon_storage));
>   	mon_storage->id = id;
>   	mon_storage->target = target;
>   	guard(rcu)();
>   	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
> -	return 0;
> +	return &mon_storage->rv.da_mon;
>   }
>   
>   /*
> @@ -547,11 +553,12 @@ static inline int da_create_or_get_kmalloc(da_id_type id, monitor_target target)
>   }
>   
>   /* Create the per-object storage if not already there. */
> -static inline int da_create_or_get(da_id_type id, monitor_target target)
> +// NOTE: this is only needed for manual allocation!
> +// we can refactor to have it only defined there, leaving it for now
> +static inline void da_create_or_get(da_id_type id, monitor_target target)
>   {
> -	if (da_pool.storage)
> -		return da_create_or_get_pool(id, target);
> -	return da_create_or_get_kmalloc(id, target);
> +	guard(rcu)();
> +	da_create_storage(id, target, da_get_monitor(id, target));
>   }
>   
>   /*
> @@ -573,7 +580,7 @@ static inline void da_destroy_storage(da_id_type id)
>   		return;
>   	da_monitor_reset_hook(&mon_storage->rv.da_mon);
>   	hash_del_rcu(&mon_storage->node);
> -	if (da_pool.storage)
> +	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
>   		call_rcu(&mon_storage->rcu, da_pool_return_cb);
>   	else
>   		kfree_rcu(mon_storage, rcu);
> @@ -591,41 +598,26 @@ static __maybe_unused void da_monitor_reset_all(void)
>   }
>   
>   /*
> - * da_monitor_init_prealloc - initialise with a pre-allocated storage pool
> - *
> - * Allocates @prealloc_count storage slots up-front so that da_create_or_get()
> - * and da_destroy_storage() never call kmalloc/kfree.  Must be called instead
> - * of da_monitor_init() for monitors that require pool mode.
> + * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
>    */
> -static inline int da_monitor_init_prealloc(unsigned int prealloc_count)
> +static inline int da_monitor_init(void)
>   {
>   	hash_init(da_monitor_ht);
> +	if (DA_MON_ALLOCATION_STRATEGY != DA_ALLOC_POOL)
> +		return 0;
>   
> -	da_pool.storage = kcalloc(prealloc_count, sizeof(*da_pool.storage),
> -				  GFP_KERNEL);
> -	if (!da_pool.storage)
> +	da_mon_cache = kmem_cache_create(__stringify(DA_MON_NAME) "_cache",
> +					 sizeof(struct da_monitor_storage),
> +					 0, 0, NULL);
> +	if (!da_mon_cache)
>   		return -ENOMEM;
>   
> -	da_pool.free = kmalloc_array(prealloc_count, sizeof(*da_pool.free),
> -				     GFP_KERNEL);
> -	if (!da_pool.free) {
> -		kfree(da_pool.storage);
> -		da_pool.storage = NULL;
> +	da_mon_pool = mempool_create_slab_pool(DA_MON_POOL_SIZE, da_mon_cache);
> +	if (!da_mon_pool) {
> +		kmem_cache_destroy(da_mon_cache);
> +		da_mon_cache = NULL;
>   		return -ENOMEM;
>   	}
> -
> -	da_pool.free_top = 0;
> -	for (unsigned int i = 0; i < prealloc_count; i++)
> -		da_pool.free[da_pool.free_top++] = &da_pool.storage[i];
> -	return 0;
> -}
> -
> -/*
> - * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
> - */
> -static inline int da_monitor_init(void)
> -{
> -	hash_init(da_monitor_ht);
>   	return 0;
>   }
>   
> @@ -641,11 +633,10 @@ static inline void da_monitor_destroy_pool(void)
>   	 * pending callback.
>   	 */
>   	rcu_barrier();
> -	kfree(da_pool.storage);
> -	da_pool.storage = NULL;
> -	kfree(da_pool.free);
> -	da_pool.free = NULL;
> -	da_pool.free_top = 0;
> +	mempool_destroy(da_mon_pool);
> +	da_mon_pool = NULL;
> +	kmem_cache_destroy(da_mon_cache);
> +	da_mon_cache = NULL;
>   }
>   
>   static inline void da_monitor_destroy_kmalloc(void)
> @@ -676,23 +667,12 @@ static inline void da_monitor_destroy_kmalloc(void)
>    */
>   static inline void da_monitor_destroy(void)
>   {
> -	if (da_pool.storage)
> +	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
>   		da_monitor_destroy_pool();
>   	else
>   		da_monitor_destroy_kmalloc();
>   }
>   
> -/*
> - * Allow the per-object monitors to run allocation manually, necessary if the
> - * start condition is in a context problematic for allocation (e.g. scheduling).
> - * In such case, if the storage was pre-allocated without a target, set it now.
> - */
> -#ifdef DA_SKIP_AUTO_ALLOC
> -#define da_prepare_storage da_fill_empty_storage
> -#else
> -#define da_prepare_storage da_create_storage
> -#endif /* DA_SKIP_AUTO_ALLOC */
> -
>   #endif /* RV_MON_TYPE */
>   
>   #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
> diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
> index 31f90f3638d8..f089cc0e2f10 100644
> --- a/kernel/trace/rv/monitors/nomiss/nomiss.c
> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -18,7 +18,7 @@
>   #define RV_MON_TYPE RV_MON_PER_OBJ
>   #define HA_TIMER_TYPE HA_TIMER_WHEEL
>   /* The start condition is on sched_switch, it's dangerous to allocate there */
> -#define DA_SKIP_AUTO_ALLOC
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
>   typedef struct sched_dl_entity *monitor_target;
>   #include "nomiss.h"
>   #include <rv/ha_monitor.h>
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
> index 90e7035a0b55..486a6bac5cf9 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -88,8 +88,8 @@ struct tlob_task_state {
>   
>   #define RV_MON_TYPE RV_MON_PER_OBJ
>   #define HA_TIMER_TYPE HA_TIMER_HRTIMER
> -/* Pool mode: da_handle_start_event uses da_fill_empty_storage, not kmalloc. */
> -#define DA_SKIP_AUTO_ALLOC
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
> +#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
>   
>   /* Type for da_monitor_storage.target; must be defined before the includes. */
>   typedef struct tlob_task_state *monitor_target;
> @@ -428,7 +428,6 @@ int tlob_start_task(struct task_struct *task, u64 threshold_us)
>   	struct da_monitor *da_mon;
>   	struct ha_monitor *ha_mon;
>   	u64 now_ns;
> -	int ret;
>   
>   	if (!da_monitor_enabled())
>   		return -ENODEV;
> @@ -457,14 +456,6 @@ int tlob_start_task(struct task_struct *task, u64 threshold_us)
>   	ws->last_ts = ktime_get();
>   	raw_spin_lock_init(&ws->entry_lock);
>   
> -	/* Claim a pool slot (no kmalloc; DA_SKIP_AUTO_ALLOC + prealloc). */
> -	ret = da_create_or_get(task->pid, ws);
> -	if (ret) {
> -		put_task_struct(task);
> -		kmem_cache_free(tlob_state_cache, ws);
> -		return ret;
> -	}
> -
>   	atomic_inc(&tlob_num_monitored);
>   
>   	/* Hold RCU across handle + timer setup to keep da_mon valid. */
> @@ -955,7 +946,7 @@ static int __tlob_init_monitor(void)
>   
>   	atomic_set(&tlob_num_monitored, 0);
>   
> -	retval = da_monitor_init_prealloc(TLOB_MAX_MONITORED);
> +	retval = da_monitor_init();
>   	if (retval) {
>   		kmem_cache_destroy(tlob_state_cache);
>   		tlob_state_cache = NULL;
> 
