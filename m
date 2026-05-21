Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35E3E5ECF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385239; cv=none; b=EpFwZKiAOUFVAiDaH+j3yVoqcAoww59fTyGTSswlWruTHf2DDJalH+X9I7FENhD4B28iLT2wfwJ2037v+/2fJLRsg6eFLOSKqmj7kUzb1AmVO6Qtd6EsGSOE5bJDln8sXI6irBOKdBJIv/fdFGAFrVBNpzV1GxCzCZbRuPPdW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385239; c=relaxed/simple;
	bh=uDySTGbh5BBDhFN3iqbs1TkV9X054TLb1gXsAUoxrts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eH1jARWDbxNMotSsgOl5v+/W6P1bUllP87Jk/CAm+SUEOMcsEJrDuIv3y59MWeRprAHfJxPMjWPeyiJdm9aptrEud3SCePIeSixnYuxx1YUC+08meng7e1ifFivYkZFtmb7upoZhGutmkPrsPhsgUeJSrsfxLyrW6U/QY1I1vcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HHV7YH5h; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HHV7YH5h"
Message-ID: <7917085b-fef1-4017-b289-eefe84332ff5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779385224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTmi1pdy0/8Cp/Y6S0qRx//7vuCd+vVqsBlO+kF0Hc=;
	b=HHV7YH5hyww99RRplNrxY4EKskjiFmS0OQE3eG5AbC1TyU1aq2m4aFCnGeXuML01rMr8Xy
	0RLlVFnQpYvliPvHhG6iWb/UP/fWrfZX+3nirYskmhmissCSBA6ySTo4u1Uv4/Pe8Gz/J9
	r4DM/SzDdVu3fDj4WSa42bP6muALagY=
Date: Fri, 22 May 2026 01:40:18 +0800
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
 <6d2f3490-5e30-4966-a3cd-372a34e10ba2@linux.dev>
 <5183dc18d63b617ab0f19290e8a790fa6898f372.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <5183dc18d63b617ab0f19290e8a790fa6898f372.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/19/26 19:14, Gabriele Monaco wrote:
> Hi Wen,
> 
> On Mon, 2026-05-18 at 01:13 +0800, Wen Yang wrote:
>>
>> Yes.  The ftracetest check_requires logic calls `command -v <binary>` to
>> satisfy `requires: <name>:program` directives.  Without the script's
>> directory in PATH those checks evaluate to exit_unsupported and test cases
>> are skipped rather than run.  The make path avoids this only because make
>> sets OUTDIR and the runner appends it to PATH internally.
>>
> 
> So you're overriding PATH so the selftest's binaries can be found from
> the test, right?
> 
> Wouldn't it be simpler to just put the absolute paths in the tests and
> don't touch PATH.
> 
> If the selftests are run via makefile, it ensures the required binaries
> are built and available, so there's no need to go through the `requires:
> <name>:program` infrastructure (that's more about what's installed on
> the system.
> 
> Or if you don't want anything hardcoded, you could pass the $OUTDIR from
> the environment and use that in scripts, whatever looks cleaner.
> 
> Does it make sense to you?
> 
>>
>> -- Patch 04: pre-allocated storage pool
>>
>>   > Since you're using spinlocks, isn't that going to sleep on PREEMPT_RT?
>>
>> User-mode uprobe handlers run with preempt_count == 0, fully preemptible on
>> both PREEMPT_RT and non-PREEMPT_RT.  The strongest evidence is in tlob
>> itself: tlob_start_task() takes a mutex and calls kmem_cache_zalloc(...,
>> GFP_KERNEL) from the uprobe entry handler; both are illegal in atomic
>> context and would trigger lockdep splats immediately.
>>
>> On PREEMPT_RT, spinlock_t becoming a sleeping lock in the uprobe handler
>> iscfine: both call sites (da_create_or_get_pool() from the handler and
>> da_pool_return_cb() from the rcuc kthread) are in sleepable task context.
>>
> 
> Yeah exactly, the uprobe is fine with anything (even the automatic
> `kmalloc_nolock`), but sure preallocation at least guarantees the slots
> are there.
> 
>>   > We can have a macro DA_MON_ALLOCATION_STRATEGY = {DA_ALLOC_AUTO,
>>   > DA_ALLOC_POOL, DA_ALLOC_MANUAL} where DA_MON_POOL also requires
>>   > DA_MON_POOL_SIZE to be defined (force that with an #error).
>>   >
>>   > Anyway, this way you probably wouldn't need to define a different init
>>   > function and let everything handled more transparently.
>>   >
>>   > Also you don't need to call da_create_or_get() explicitly,
>>   > da_handle_start_event() should do it for you.
>>
>> Agreed on all counts.  We plan to implement this in v3 as follows.
>> The three strategies would be a compile-time selection in da_monitor.h:
>>
>>     DA_ALLOC_AUTO   (default) - lock-free kmalloc_nolock on the hot path;
>>                                 unbounded capacity.
>>
>>     DA_ALLOC_POOL             - pre-allocated fixed-size pool;
>> DA_MON_POOL_SIZE
>>                                 required, enforced with #error if missing.
>>
>>     DA_ALLOC_MANUAL           - caller pre-inserts storage via
>>                                 da_create_empty_storage() before the first
>>                                 da_handle_start_event(); the framework only
>>                                 links the target field.
>>
>> da_monitor_init_prealloc() would be removed; da_monitor_init() would
>> select pool or kmalloc initialisation internally based on the strategy.
>>
>> da_handle_start_event() and da_handle_start_run_event() would both call
>> da_prepare_storage() at compile time:
>>
>>     DA_ALLOC_AUTO   -> da_create_storage()        (kmalloc_nolock)
>>     DA_ALLOC_POOL   -> da_create_or_get_pool()
>>     DA_ALLOC_MANUAL -> da_fill_empty_storage()    (link target into pre-
>>                        allocated slot; no allocation on the hot path)
>>
>> No explicit da_create_or_get() call would be needed in any monitor.
>>
>> da_create_or_get_kmalloc() would be removed: as you noted, a caller that
>> uses kmalloc_nolock does so because locking is forbidden; a GFP_KERNEL
>> fallback is equally forbidden if the lockless attempt fails, so the
>> function has no viable use case.
>>
>> tlob would define:
>>     #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
>>     #define DA_MON_POOL_SIZE            TLOB_MAX_MONITORED
>>
>> nomiss would define:
>>     #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
>>
>> and call da_create_empty_storage() from handle_sys_enter() (the
>> sched_setscheduler syscall path), which runs in safe task context;
>> da_fill_empty_storage() would then link the sched_dl_entity target on
>> the first da_handle_start_run_event() call in handle_sched_switch().
> 
> Yeah good point, there's no need to make it a special path even if we
> have the target ready, da_handle_start_run_event() can do it just fine.
> 
>>
>>
>> -- Patch 05: generic uprobe infrastructure
>>
>> Carried unchanged into v3 (as part of the 08-b split described below).
>>
>>
>> -- Patch 06: rvgen __init arrow reset
>>
>> Thanks, carried unchanged into v3.
>>
> 
> Well, if you don't need reset() on the __init arrow we can drop this,
> right? Also it doesn't seem fully wired with the rest and requires a
> separate event to do handle_monitor_start(), which can be only just
> another handler for tlob, nothing general.
> 
>>
>>   > Why don't you make it a separate event (e.g. "start_tlob") [...] then
>>   > you also wouldn't need to call reset() and start_timer() manually.
>>
>> Good suggestion.  We plan to use a dedicated start_tlob event instead,
>> with a self-loop in tlob.dot:
>>
>>     "running" -> "running" [ label = "start;reset(clk_elapsed)" ]
>>
>> da_handle_start_run_event(task->pid, ws, start_tlob) would put the
>> monitor into running and deliver start_tlob, which resets clk_elapsed
>> and arms the budget hrtimer via the generated ha_setup_invariants() —
>> no manual reset() or start_timer() calls needed.
>>
>> One guard would be added in tlob's ha_setup_invariants() to make the
>> self-loop work correctly:
>>
>>     if (next_state == curr_state && event != start_tlob)
>>         return;
>>
>> Without this, the start_tlob self-loop would be treated the same as any
>> repeated switch_in (already running) and ha_setup_invariants() would
>> return early, leaving the timer unarmed.  Does this look right to you?
>>
> 
> If you just add a separate event rvgen should take care of everything,
> you should be able to take ha_verify_constraint() and friends as-is from
> the generated code.
> 
> But yeah, that's what it would end up doing.
> 
>>
>> -- Patch 08: tlob monitor
>>
>> --- Patch structure ---
>>
>>   > Could you have everything that isn't strictly tlob-related in another
>>   > patch.
>>
>> Agreed.  With the ioctl interface deferred (see below), v3 would keep
>> patch 08 as the tlob monitor only:
>>
>>     05-b: rv: extend uprobe API with three-phase detach helpers
>>           (rv_uprobe.c, rv_uprobe.h, rv_uprobe_detach refactoring)
>>           — extension of patch 05, independent of tlob
>>
>>     08:   rv/tlob: add the tlob monitor itself
>>           (tlob.c, tlob.h, tlob_trace.h, Kconfig/Makefile, Documentation,
>>            rv_trace.h include; ha_monitor.h EVENT_NONE_LBL override
>>            bundled here as it is only needed by tlob)
>>
>> The chardev infrastructure (rv_chardev.c, rv.h additions) and the UAPI
>> header (include/uapi/linux/rv.h) would move to a follow-up series
>> together with the ioctl self-instrumentation feature.
>>
>> --- ioctl interface design ---
>>
>>   > I'm not particularly fond of ioctls, they aren't that flexible and in
>>   > this way I don't really see an added value.
>>   > [...] cannot the same thing be achieved using uprobes alone, e.g. by
>>   > registering a function address or the current instruction pointer?
>>   > [...] wouldn't a sysfs/tracefs file achieve a similar purpose without
>>   > much of the boilerplate code?
>>
>> Fair point.  We plan to ship v3 with the tracefs/uprobe interface only
>> and defer the ioctl (/dev/rv chardev) to a follow-up series once there
>> is a concrete in-tree user that requires it.
>>
>> The unique value of the ioctl is that TLOB_IOCTL_TRACE_STOP returns a
>> synchronous per-call result (-EOVERFLOW or 0) to the calling thread,
>> which neither uprobes nor tracefs writes can provide.  We want to keep
>> that option open for later, but agree it should not block the initial
>> tlob submission.
>>
>> Does this approach work for you?
>>
>> What is your preference?
> 
> Yeah looks good to me.
> Ioctls are cumbersome to set up also for the user, perhaps another sysfs
> file in the monitor directory would keep the control entirely in tlob.c
> and give you roughly the same value with easier setup.
> 
> Heck we might even think of an RV reactor that does that: e.g. creates a
> file where reads sleep until the first reaction (-EOVERFLOW) and returns
> 0 in other scenarios. I'm gonna have a thought on that, but anyway I
> don't see why a sysfs file cannot do this.
> 
> Let's defer it for now.
> 
>>
>> --- Handler simplification ---
>>
>>   > Perhaps keep the handler simpler by moving this reporting to a helper
>>   > function and use guard(rcu)() there.
>>
>> Done.  The accumulation logic is extracted into three inline helpers, each
>> using scoped_guard(rcu) and returning bool (true if the task is monitored):
>>
>>     tlob_acc_running(prev)   - accumulate running_ns on sched-out
>>     tlob_acc_waiting(next)   - accumulate waiting_ns on sched-in
>>     tlob_acc_sleeping(task)  - accumulate sleeping_ns on wakeup
>>
>> handle_sched_switch() and handle_sched_wakeup() become one-liners:
>>
>>     static void handle_sched_switch(...)
>>     {
>>         bool prev_preempted = (prev_state == 0);
>>
>>         if (tlob_acc_running(prev))
>>             da_handle_event(prev->pid, NULL,
>>                             prev_preempted ? preempt_tlob : sleep_tlob);
>>         if (tlob_acc_waiting(next))
>>             da_handle_event(next->pid, NULL, switch_in_tlob);
>>     }
> 
> Yeah sounds good.
> 
>>
>>   > You probably don't need these. da_handle_event should skip tasks without
>>   > a monitor.
>>
>> Agreed; the do_prev/do_next flags are gone.  The helpers return false
>> for unmonitored tasks, and da_handle_event() skips them too — both paths
>> are no-ops for tasks with no pool entry.
>>
>> --- scoped_guard(rcu) ---
>>
>>   > That should be a scoped_guard(rcu), definitely use guards if you have
>>   > return paths, the compiler is going to clean up (unlock) for you.
>>
>> Applied to all RCU-protected sections in tlob_start_task() and
>> tlob_stop_task().  tlob_start_task() now uses guard(mutex) for the
>> serialised duplicate-check (replacing the explicit mutex_lock/unlock),
>> and tlob_stop_task() uses scoped_guard(rcu) for the atomic CAS section:
>>
>>     scoped_guard(rcu) {
>>         ws = da_get_target_by_id(task->pid);
>>         if (!ws)
>>             return -ESRCH;
>>         ...
>>         if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
>>             return -EAGAIN;
>>     }
> 
> Perfect.
> 
>>
>> --- tlob_stop_all removal ---
>>
>>   > All this function does should be done by da_monitor_destroy. We could
>>   > add a way to pass some additional deallocation for all the other cleanup
>>   > you're doing on each storage.  Something like a da_extra_cleanup() you
>>   > can define as whatever you need and gets called in all per-obj
>>   > destruction paths.
>>
>> Agreed.  tlob_stop_all() (~50 lines) has been removed entirely.
>>
>> A da_extra_cleanup() hook macro is introduced in da_monitor.h: the default
>> is a no-op; a monitor may override it before including the header.  tlob
>> defines:
>>
>>     static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
>>     {
>>         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
>>         struct tlob_task_state *ws = da_get_target(ha_mon);
>>
>>         if (!ws)
>>             return;
>>         if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
>>             return;
> 
>>         ha_cancel_timer_sync(ha_mon);
> After my patch making timer callbacks RCU read-side critical section,
> you won't need that, just let the usual reset asynchronously stop the
> timer and put everything that needs it stopped in your RCU callback.
> 
> Of course make sure the timer was stopped before this extra cleanup, so
> put the macro accordingly.
> 
> I don't think da_extra_cleanup in general should be expected to sleep
> and call_rcu should do the heavy lifting (it may run from any tracepoint).
> 
> Anyway we can see it later after that's merged.
> 
>>         atomic_dec(&tlob_num_monitored);
>>         put_task_struct(ws->task);
>>         call_rcu(&ws->rcu, tlob_free_rcu);
>>     }
>>     #define da_extra_cleanup tlob_extra_cleanup
>>
>> da_monitor_destroy() iterates remaining entries via da_extra_cleanup +
>> hash_del_rcu + call_rcu, then waits for all callbacks via rcu_barrier().
>> tlob's disable path is now simply:
>>
>>     static void __tlob_destroy_monitor(void)
>>     {
>>         da_monitor_destroy();
>>     }
> 
> Looks good, let's see the full picture.
> 
>> --- EVENT_NONE_LBL ---
>>
>>   > Why don't you just override EVENT_NONE_LBL (and if you prefer call it
>>   > MONITOR_TIMER_EVENT_NAME) without the need for another function?
>>
>> Done.  model_get_timer_event_name() has been removed from automata.h.
>> In ha_monitor.h, EVENT_NONE_LBL is now overridable:
>>
>>     #ifndef EVENT_NONE_LBL
>>     #define EVENT_NONE_LBL "none"
>>     #endif
>>
>> tlob.c defines it before including the model header:
>>
>>     #define EVENT_NONE_LBL "budget_exceeded"
>>
>> The two call sites in ha_monitor.h that previously called
>> model_get_timer_event_name() now use EVENT_NONE_LBL directly.
>>
>> --- KUnit config / tristate ---
>>
>>   > Do you need to add this here? Since you have a patch adding KUnit tests
>>   > to tlob, cannot you put everything kunit-related there?
>>   > I couldn't build it as module.
>>
>> Agreed on moving the Kconfig entry to patch 09.
>>
>> The module build issue is fixed by exporting the symbols needed by the
>> test via EXPORT_SYMBOL_IF_KUNIT (EXPORTED_FOR_KUNIT_TESTING namespace);
>> tlob_kunit.c imports the namespace with MODULE_IMPORT_NS.  We plan to
>> keep tristate rather than changing to bool.  Does that work for you?
> 
> Yeah it's good as long as it works as module too.
> 
> I might have a look at making my patch module-ready, for now it just
> can't work but I wonder if we can do something nicer to allow it
> (like in your case a bunch of exports, a separate file and a standalone
> testcase, perhaps all wrapped in some helper).
> 
>>
>> --- detail_env_tlob tracepoint ---
>>
>>   > Since you are not documenting the detail_env_tlob tracepoint, is it
>>   > something really required? I would at the very least document its usage.
>>
>> Fair point.  detail_env_tlob emits (running_ns, waiting_ns, sleeping_ns)
>> so the user can see which phase consumed the budget: high sleeping_ns
>> indicates I/O latency, high waiting_ns indicates scheduler pressure, high
>> running_ns indicates a compute overrun.  Without this breakdown the user
>> only knows the total elapsed time exceeded the threshold, not why.
>>
> 
> Alright, then this can go into the docs.
> 
>>
>> --- Documentation ---
>>
>>   > This is standard tracepoints usage, there's nothing about tlob we should
>>   > document here.
>>   > Same here, standard RV [for enable/desc tracefs files].
>>   > And this is duplicating what mentioned above about uprobes, isn't it?
>>
>> Agreed.  The following have been removed:
>>
>>     - "Violation events" section: generic trace-cmd examples and cat-trace
>>       instructions (standard tracepoints usage).
>>     - tracefs files: "enable (rw)" and "desc (ro)" entries (standard RV).
>>     - tracefs files: "monitor (rw)" description condensed to one line with
>>       a cross-reference to the uprobes section above.
>>
>> In their place, a new "Violation tracepoints" subsection documents both
>> tlob-specific tracepoints with fields and a worked example:
>>
>>     error_env_tlob: id, state, event ("budget_exceeded"), env ("clk_elapsed")
>>
>>     detail_env_tlob: id, threshold_us, running_ns, waiting_ns, sleeping_ns
>>       Use sleeping_ns to diagnose I/O latency, waiting_ns for scheduler
>>       pressure, running_ns for compute overruns.
>>
>>     Example:
>>       trace-cmd record -e error_env_tlob -e detail_env_tlob &
>>       # ... run workload ...
>>       trace-cmd report
> 
> Yeah sounds good, also pointing out to enable the monitor.
> We might think of a general way to do this kind of thing in
> tools/rv, although detail_env_tlob is non-standard.
> 
>>   > Is kernel code going to use this API? RV monitors are meant to be
>>   > enabled by userspace. What's the use-case here?
>>
>> Agreed.  The uprobe interface is driven from userspace; tlob_start_task()
>> and tlob_stop_task() are the internal implementation functions it calls,
>> not a public API for external kernel modules.  The hypothetical
>> kernel-module use case would be removed from the documentation; the
>> kernel-doc block is retained for code maintainers.
>>
>>   > That's probably a bit too detailed for this page. If you really want
>>   > this information somewhere couldn't it stay in the code?
>>
>> Agreed; moved to comments in handle_sched_switch() and
>> handle_sched_wakeup().  The "Limitations" subsection is retained.
>>
>> -- Patch 09: KUnit tests
>>
>>   > What caught my eyes are tests enrolling tracepoints handlers. If you
>>   > go there you're no longer doing unit testing, what's the advantage of
>>   > testing the entire monitor here over doing that in selftests?
>>
>> Agreed.  The three suites that register tracepoint handlers or create
>> kthreads (tlob_sched_integration, tlob_trace_output, tlob_violation_react)
>> have been removed from KUnit and will be added to selftests in v3.
>>
>> Two pure unit test suites remain in KUnit:
>>
>>     tlob_task_api:
>>       Tests tlob_start_task / tlob_stop_task return values (-ENODEV,
>>       -EALREADY, -ESRCH, -EOVERFLOW, -ENOSPC, -ERANGE) via direct calls
>>       (these functions are the internal implementation used by both the
>>       uprobe and, in future, the ioctl interface).
>>       No tracepoints, no scheduling.
>>
>>     tlob_uprobe_format:
>>       Tests the uprobe line parser (tlob_parse_uprobe_line,
>>       tlob_parse_remove_line) against valid and invalid input strings.
>>       Pure string parsing; no scheduling, no tracepoints.
>>
>> This also resolves the tristate-vs-bool issue: with only pure unit tests
>> there is no dependency on sched_setscheduler_nocheck, so bool is correct.
>>
> 
> Yeah looks good.
> 
>>
>> --  Patch 10: selftests
>>
>> --- PREEMPT_RT RCU stall ---
>>
>>   > I run it on a VM and have it hanging at step 9 [...] rcu_preempt stall.
>>   > Did you see that? Am I doing something wrong?
>>
>> Thanks for reporting.  The patch changed ha_monitor.h from
>> HRTIMER_MODE_REL_HARD (the existing upstream value) to REL_SOFT; the
>> stall appeared on PREEMPT_RT after that change.  We have not fully
>> confirmed whether REL_SOFT is the root cause — REL_SOFT defers the
>> callback to the ktimers kthread, which could starve rcu_preempt under
>> certain PREEMPT_RT configurations, but other factors may be involved.
>>
>> We plan to revert to HRTIMER_MODE_REL_HARD at both sites in ha_monitor.h
>> as the conservative choice:
>>
>>     ha_setup_timer():     HRTIMER_MODE_REL_SOFT -> HRTIMER_MODE_REL_HARD
>>     ha_start_timer_ns():  HRTIMER_MODE_REL_SOFT -> HRTIMER_MODE_REL_HARD
>>
>> Do you have more insight into the stall, or does REL_HARD resolve it on
>> your setup?
> 
> Right, good point, any specific reason why you wanted REL_SOFT?
> 
> I indeed always test under PREEMPT_RT but I still see the same splat
> also after reverting REL_HARD..
> Could you reproduce it on your setup?
> 
> My config is nothing special: what vng gives you adding
> PREEMPT_RT/RCU_PREEMPT and lockdep (PROVE_LOCKING/PROVE_RCU).
> 

Hi Gabriele, 

 

No specific reason for REL_SOFT — not intentional, reverting to 
REL_HARD.
 

Reproduced the stall on the same config (PREEMPT_RT + 
PROVE_LOCKING/PROVE_RCU). 

Root cause is a cleanup ordering bug in uprobe_detail_waiting.tc, 
unrelated to REL_SOFT/REL_HARD:
 

   # original cleanup — wrong order 

   echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR"  # (A) 

   kill "$hog_pid"                                              # (B) 

 
                                                              (A) 
triggers synchronize_srcu() in the kernel. But tlob_target is stuck 
mid-uprobe_notify_resume holding an SRCU read lock, preempted by the 
FIFO-99 hog -> so the reader never finishes and (B) is never reached. 
rcuc/0 (a kthread on PREEMPT_RT) is also starved by the hog -> RCU stall.
 

   Fix: kill the hog first: 
 

   kill "$hog_pid"; wait "$hog_pid" 

   echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 


On the PREEMPT_RT it is more reliably triggered there because rcuc/0
runs as a preemptible kthread rather than in softirq, making it easier
for the hog to monopolise the CPU long enough to hit the stall.

Thank you for the thorough review and valuable suggestions. We are 
working through all of them and running the full test suite.
We expect to post v3 within the next two days.

--
Best wishes,
Wen


>>
>> --- Selftest structure ---
>>
>>   > This should be tested together with the other monitors (enable/disable),
>>   > we could at most expand those with the check_requires.
>>   > Let's focus on tlob-only features in this patch.
>>
>> Agreed.  In v3 we plan to drop tracefs.tc (covered by the generic
>> rv_monitor_enable_disable.tc) and keep only the six uprobe-specific
>> test cases under test.d/tlob/
>>
>> ioctl.tc is deferred with the ioctl interface to the follow-up series.
>> The KUnit integration tests (sched_switch accounting, budget-expiry
>> tracepoint) would be moved to selftests as additional test cases.
>>
> 
> Thanks,
> Gabriele
> 
