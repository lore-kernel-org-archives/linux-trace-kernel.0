Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576E393DC2;
	Thu, 16 Apr 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352207; cv=none; b=DjfT00c/pZsMH4MTPBFNKUaNpyoQyuGYRg4wRiqXsVs3CZZozrR/mXDq38ZSe8Cut05Pmep3VlGadf1wAxF5p64DlUdi5NQT5Umq1oh11bfjy9t1AWSjXJcvP7gekv+eGQg9BxZCZl7tImfjRU4oV4LElqs1BZ43rEfzdmLHXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352207; c=relaxed/simple;
	bh=uUYEBbd53VsoDROysb5gzFhNI2HbSVVpdX6HZjD2uyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ml9aQl7U8Per97VO1skOITuQ6ikP1inRXZn6lKu4tQkr9edDVIcn0s4xcojcUjA8DERva5EcW9h6QBu/3KEJmNN/z3S4NYnDQfbqKDPXyLe/OBqnrxJL5EM5vakV8qmTfy0luSl+oMvkasiayIoMq6GjonNHu/zTrrHtrC2LMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7gLMEpc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7gLMEpc"
Message-ID: <228deda8-3685-4f07-afd5-d3f3ca531154@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776352198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDTB9h0flZi3e2ILhCuwSoR+2IjruFd4FbWpVrjR+q0=;
	b=B7gLMEpcbgDDTJs9Qi3+3+8/OwvOjfnWUt/nXQnxYJQcyDT2G72YTuPldTBNnX1xsyi+87
	DgV9ZvkrIY4F9PBF+AouCPjlbMF/naB408r0bXCLt4jO7jSYMW9OrZqdjjt2aYD+Ep4e8f
	Yl/6E8h1WaXuDu+5z8pM94TkMKBmaYM=
Date: Thu, 16 Apr 2026 23:09:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/4] rv/tlob: Add tlob deterministic automaton monitor
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1776020428.git.wen.yang@linux.dev>
 <ccf53a89b3b65e5728403dc097fde94ac2591d98.1776020428.git.wen.yang@linux.dev>
 <74a624434b59c00f9407909b8696f041536d9418.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <74a624434b59c00f9407909b8696f041536d9418.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/13/26 16:19, Gabriele Monaco wrote:
> On Mon, 2026-04-13 at 03:27 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Add the tlob (task latency over budget) RV monitor. tlob tracks the
>> monotonic elapsed time (CLOCK_MONOTONIC) of a marked per-task code
>> path, including time off-CPU, and fires a per-task hrtimer when the
>> elapsed time exceeds a configurable budget.
>>
>> Three-state DA (unmonitored/on_cpu/off_cpu) driven by trace_start,
>> switch_in/out, and budget_expired events. Per-task state lives in a
>> fixed-size hash table (TLOB_MAX_MONITORED slots) with RCU-deferred
>> free.
>>
>> Two userspace interfaces:
>>   - tracefs: uprobe pair registration via the monitor file using the
>>     format "pid:threshold_us:offset_start:offset_stop:binary_path"
>>   - /dev/rv ioctls (CONFIG_RV_CHARDEV): TLOB_IOCTL_TRACE_START /
>>     TRACE_STOP; TRACE_STOP returns -EOVERFLOW on violation
>>
>> Each /dev/rv fd has a per-fd mmap ring buffer (physically contiguous
>> pages). A control page (struct tlob_mmap_page) at offset 0 exposes
>> head/tail/dropped for lockless userspace reads; struct tlob_event
>> records follow at data_offset. Drop-new policy on overflow.
>>
>> UAPI: include/uapi/linux/rv.h (tlob_start_args, tlob_event,
>>        tlob_mmap_page, ioctl numbers), monitor_tlob.rst,
>>        ioctl-number.rst (RV_IOC_MAGIC=0xB9).
>>
> 
> I'm not fully grasping all the requirements for the monitors yet, but I see you
> are reimplementing a lot of functionality in the monitor itself rather than
> within RV, let's see if we can consolidate some of them:
> 
>   * you're using timer expirations, can we do it with timed automata? [1]
>   * RV automata usually don't have an /unmonitored/ state, your trace_start event
> would  be the start condition (da_event_start) and the monitor will get non-
> running at each violation (it calls da_monitor_reset() automatically), all
> setup/cleanup logic should be handled implicitly within RV. I believe that would
> also save you that ugly trace_event_tlob() redefinition.
>   * you're maintaining a local hash table for each task_struct, that could use
> the per-object monitors [2] where your "object" is in fact your struct,
> allocated when you start the monitor with all appropriate fields and indexed by
> pid
>   * you are handling violations manually, considering timed automata trigger a
> full fledged violation on timeouts, can you use the RV-way (error tracepoints or
> reactors only)? Do you need the additional reporting within the
> tracepoint/ioctl? Cannot the userspace consumer desume all those from other
> events and let RV do just the monitoring?
>   * I like the uprobe thing, we could probably move all that to a common helper
> once we figure out how to make it generic.
> 
> Note: [1] and [2] didn't reach upstream yet, but should reach linux-next soon.
> 

Thanks for the review.  Here's my plan for each point -- let me know if 
the direction looks right.


- Timed automata

The HA framework [1] is a good match when the timeout threshold is 
global or state-determined, but tlob needs a per-invocation threshold 
supplied at TRACE_START time -- fitting that into HA would require 
framework changes.

My plan is to use da_monitor_init_hook() -- the same mechanism HA 
monitors use internally -- to arm the per-invocation hrtimer once 
da_create_storage() has stored the monitor_target.  This gives the same 
"timer fires => violation" semantics without touching the HA infrastructure.

If you see a cleaner way to pass per-invocation data through HA I'm 
happy to go that route.


- Unmonitored state / da_handle_start_event

Fair point.  I'll drop the explicit unmonitored state and the
trace_event_tlob() redefinition.  tlob_start_task() will use
da_handle_start_event() to allocate storage, set initial state to on_cpu,
and fire the init hook to arm the timer in one shot.  tlob_stop_task()
calls da_monitor_reset() directly.

- Per-object monitors

Will do.  The custom hash table goes away; I'll switch to RV_MON_PER_OBJ
with:

     typedef struct tlob_task_state *monitor_target;

da_get_target_by_id() handles the sched_switch hot path lookup.


- RV-way violations

Agreed.  budget_expired will be declared INVALID in all states so the
framework calls react() (error_tlob tracepoint + any registered reactor)
and da_monitor_reset() automatically.  tlob won't emit any tracepoint of
its own.

One note on the /dev/tlob ioctl: TLOB_IOCTL_TRACE_STOP returns -EOVERFLOW
to the caller when the budget was exceeded.  This is just a syscall 
return code -- not a second reporting path -- to let in-process 
instrumentation react inline without polling the trace buffer.
Let me know if you have concerns about keeping this.


- Generic uprobe helper

Proposed interface:

     struct rv_uprobe *rv_uprobe_attach_path(
             struct path *path, loff_t offset,
             int (*entry_fn)(struct rv_uprobe *, struct pt_regs *, __u64 *),
             int (*ret_fn)  (struct rv_uprobe *, unsigned long func,
                             struct pt_regs *, __u64 *),
             void *priv);

     struct rv_uprobe *rv_uprobe_attach(
             const char *binpath, loff_t offset,
             int (*entry_fn)(struct rv_uprobe *, struct pt_regs *, __u64 *),
             int (*ret_fn)  (struct rv_uprobe *, unsigned long func,
                             struct pt_regs *, __u64 *),
             void *priv);

     void rv_uprobe_detach(struct rv_uprobe *p);

struct rv_uprobe exposes three read-only fields to monitors (offset, 
priv, path); the uprobe_consumer and callbacks would be kept private to 
the implementation, so monitors need not include <linux/uprobes.h>.

rv_uprobe_attach() resolves the path and delegates to 
rv_uprobe_attach_path(); the latter avoids a redundant kern_path() when 
registering multiple probes on the same binary:

     kern_path(binpath, LOOKUP_FOLLOW, &path);
     b->start = rv_uprobe_attach_path(&path, offset_start, entry_fn, 
NULL, b);
     b->stop  = rv_uprobe_attach_path(&path, offset_stop,  stop_fn, 
NULL, b);
     path_put(&path);

Does the interface look reasonable, or did you have a different shape in 
mind?


--
Best wishes,
Wen


> 
> [1] -
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=rv/for-next&id=f5587d1b6ec938afb2f74fe399a68020d66923e4
> [2] -
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=rv/for-next&id=da282bf7fadb095ee0a40c32ff0126429c769b45
> 
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> ---
>>   Documentation/trace/rv/index.rst              |   1 +
>>   Documentation/trace/rv/monitor_tlob.rst       | 381 +++++++
>>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>   include/uapi/linux/rv.h                       | 181 ++++
>>   kernel/trace/rv/Kconfig                       |  17 +
>>   kernel/trace/rv/Makefile                      |   2 +
>>   kernel/trace/rv/monitors/tlob/Kconfig         |  51 +
>>   kernel/trace/rv/monitors/tlob/tlob.c          | 986 ++++++++++++++++++
>>   kernel/trace/rv/monitors/tlob/tlob.h          | 145 +++
>>   kernel/trace/rv/monitors/tlob/tlob_trace.h    |  42 +
>>   kernel/trace/rv/rv.c                          |   4 +
>>   kernel/trace/rv/rv_dev.c                      | 602 +++++++++++
>>   kernel/trace/rv/rv_trace.h                    |  50 +
>>   13 files changed, 2463 insertions(+)
>>   create mode 100644 Documentation/trace/rv/monitor_tlob.rst
>>   create mode 100644 include/uapi/linux/rv.h
>>   create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
>>   create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
>>   create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
>>   create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
>>   create mode 100644 kernel/trace/rv/rv_dev.c
>>
>> diff --git a/Documentation/trace/rv/index.rst
>> b/Documentation/trace/rv/index.rst
>> index a2812ac5c..4f2bfaf38 100644
>> --- a/Documentation/trace/rv/index.rst
>> +++ b/Documentation/trace/rv/index.rst
>> @@ -15,3 +15,4 @@ Runtime Verification
>>      monitor_wwnr.rst
>>      monitor_sched.rst
>>      monitor_rtapp.rst
>> +   monitor_tlob.rst
>> diff --git a/Documentation/trace/rv/monitor_tlob.rst
>> b/Documentation/trace/rv/monitor_tlob.rst
>> new file mode 100644
>> index 000000000..d498e9894
>> --- /dev/null
>> +++ b/Documentation/trace/rv/monitor_tlob.rst
>> @@ -0,0 +1,381 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Monitor tlob
>> +============
>> +
>> +- Name: tlob - task latency over budget
>> +- Type: per-task deterministic automaton
>> +- Author: Wen Yang <wen.yang@linux.dev>
>> +
>> +Description
>> +-----------
>> +
>> +The tlob monitor tracks per-task elapsed time (CLOCK_MONOTONIC, including
>> +both on-CPU and off-CPU time) and reports a violation when the monitored
>> +task exceeds a configurable latency budget threshold.
>> +
>> +The monitor implements a three-state deterministic automaton::
>> +
>> +                              |
>> +                              | (initial)
>> +                              v
>> +                    +--------------+
>> +          +-------> | unmonitored  |
>> +          |         +--------------+
>> +          |                |
>> +          |          trace_start
>> +          |                v
>> +          |         +--------------+
>> +          |         |   on_cpu     |
>> +          |         +--------------+
>> +          |           |         |
>> +          |  switch_out|         | trace_stop / budget_expired
>> +          |            v         v
>> +          |  +--------------+  (unmonitored)
>> +          |  |   off_cpu    |
>> +          |  +--------------+
>> +          |     |         |
>> +          |     | switch_in| trace_stop / budget_expired
>> +          |     v         v
>> +          |  (on_cpu)  (unmonitored)
>> +          |
>> +          +-- trace_stop (from on_cpu or off_cpu)
>> +
>> +  Key transitions:
>> +    unmonitored   --(trace_start)-->   on_cpu
>> +    on_cpu        --(switch_out)-->    off_cpu
>> +    off_cpu       --(switch_in)-->     on_cpu
>> +    on_cpu        --(trace_stop)-->    unmonitored
>> +    off_cpu       --(trace_stop)-->    unmonitored
>> +    on_cpu        --(budget_expired)-> unmonitored   [violation]
>> +    off_cpu       --(budget_expired)-> unmonitored   [violation]
>> +
>> +  sched_wakeup self-loops in on_cpu and unmonitored; switch_out and
>> +  sched_wakeup self-loop in off_cpu.  budget_expired is fired by the one-shot
>> hrtimer; it always
>> +  transitions to unmonitored regardless of whether the task is on-CPU
>> +  or off-CPU when the timer fires.
>> +
>> +State Descriptions
>> +------------------
>> +
>> +- **unmonitored**: Task is not being traced.  Scheduling events
>> +  (``switch_in``, ``switch_out``, ``sched_wakeup``) are silently
>> +  ignored (self-loop).  The monitor waits for a ``trace_start`` event
>> +  to begin a new observation window.
>> +
>> +- **on_cpu**: Task is running on the CPU with the deadline timer armed.
>> +  A one-shot hrtimer was set for ``threshold_us`` microseconds at
>> +  ``trace_start`` time.  A ``switch_out`` event transitions to
>> +  ``off_cpu``; the hrtimer keeps running (off-CPU time counts toward
>> +  the budget).  A ``trace_stop`` cancels the timer and returns to
>> +  ``unmonitored`` (normal completion).  If the hrtimer fires
>> +  (``budget_expired``) the violation is recorded and the automaton
>> +  transitions to ``unmonitored``.
>> +
>> +- **off_cpu**: Task was preempted or blocked.  The one-shot hrtimer
>> +  continues to run.  A ``switch_in`` event returns to ``on_cpu``.
>> +  A ``trace_stop`` cancels the timer and returns to ``unmonitored``.
>> +  If the hrtimer fires (``budget_expired``) while the task is off-CPU,
>> +  the violation is recorded and the automaton transitions to
>> +  ``unmonitored``.
>> +
>> +Rationale
>> +---------
>> +
>> +The per-task latency budget threshold allows operators to express timing
>> +requirements in microseconds and receive an immediate ftrace event when a
>> +task exceeds its budget.  This is useful for real-time tasks
>> +(``SCHED_FIFO`` / ``SCHED_DEADLINE``) where total elapsed time must
>> +remain within a known bound.
>> +
>> +Each task has an independent threshold, so up to ``TLOB_MAX_MONITORED``
>> +(64) tasks with different timing requirements can be monitored
>> +simultaneously.
>> +
>> +On threshold violation the automaton records a ``tlob_budget_exceeded``
>> +ftrace event carrying the final on-CPU / off-CPU time breakdown, but does
>> +not kill or throttle the task.  Monitoring can be restarted by issuing a
>> +new ``trace_start`` event (or a new ``TLOB_IOCTL_TRACE_START`` ioctl).
>> +
>> +A per-task one-shot hrtimer is armed at ``trace_start`` for exactly
>> +``threshold_us`` microseconds.  It fires at most once per monitoring
>> +window, performs an O(1) hash lookup, records the violation, and injects
>> +the ``budget_expired`` event into the DA.  When ``CONFIG_RV_MON_TLOB``
>> +is not set there is zero runtime cost.
>> +
>> +Usage
>> +-----
>> +
>> +tracefs interface (uprobe-based external monitoring)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The ``monitor`` tracefs file allows any privileged user to instrument an
>> +unmodified binary via uprobes, without changing its source code.  Write a
>> +four-field record to attach two plain entry uprobes: one at
>> +``offset_start`` fires ``tlob_start_task()`` and one at ``offset_stop``
>> +fires ``tlob_stop_task()``, so the latency budget covers exactly the code
>> +region between the two offsets::
>> +
>> +  threshold_us:offset_start:offset_stop:binary_path
>> +
>> +``binary_path`` comes last so it may freely contain ``:`` (e.g. paths
>> +inside a container namespace).
>> +
>> +The uprobes fire for every task that executes the probed instruction in
>> +the binary, consistent with the native uprobe semantics.  All tasks that
>> +execute the code region get independent per-task monitoring slots.
>> +
>> +Using two plain entry uprobes (rather than a uretprobe for the stop) means
>> +that a mistyped offset can never corrupt the call stack; the worst outcome
>> +of a bad ``offset_stop`` is a missed stop that causes the hrtimer to fire
>> +and report a budget violation.
>> +
>> +Example  --  monitor a code region in ``/usr/bin/myapp`` with a 5 ms
>> +budget, where the region starts at offset 0x12a0 and ends at 0x12f0::
>> +
>> +  echo 1 > /sys/kernel/tracing/rv/monitors/tlob/enable
>> +
>> +  # Bind uprobes: start probe starts the clock, stop probe stops it
>> +  echo "5000:0x12a0:0x12f0:/usr/bin/myapp" \
>> +      > /sys/kernel/tracing/rv/monitors/tlob/monitor
>> +
>> +  # Remove the uprobe binding for this code region
>> +  echo "-0x12a0:/usr/bin/myapp" >
>> /sys/kernel/tracing/rv/monitors/tlob/monitor
>> +
>> +  # List registered uprobe bindings (mirrors the write format)
>> +  cat /sys/kernel/tracing/rv/monitors/tlob/monitor
>> +  # -> 5000:0x12a0:0x12f0:/usr/bin/myapp
>> +
>> +  # Read violations from the trace buffer
>> +  cat /sys/kernel/tracing/trace
>> +
>> +Up to ``TLOB_MAX_MONITORED`` tasks may be monitored simultaneously.
>> +
>> +The offsets can be obtained with ``nm`` or ``readelf``::
>> +
>> +  nm -n /usr/bin/myapp | grep my_function
>> +  # -> 0000000000012a0 T my_function
>> +
>> +  readelf -s /usr/bin/myapp | grep my_function
>> +  # -> 42: 0000000000012a0  336 FUNC GLOBAL DEFAULT  13 my_function
>> +
>> +  # offset_start = 0x12a0 (function entry)
>> +  # offset_stop  = 0x12a0 + 0x50 = 0x12f0 (or any instruction before return)
>> +
>> +Notes:
>> +
>> +- The uprobes fire for every task that executes the probed instruction,
>> +  so concurrent calls from different threads each get independent
>> +  monitoring slots.
>> +- ``offset_stop`` need not be a function return; it can be any instruction
>> +  within the region.  If the stop probe is never reached (e.g. early exit
>> +  path bypasses it), the hrtimer fires and a budget violation is reported.
>> +- Each ``(binary_path, offset_start)`` pair may only be registered once.
>> +  A second write with the same ``offset_start`` for the same binary is
>> +  rejected with ``-EEXIST``.  Two entry uprobes at the same address would
>> +  both fire for every task, causing ``tlob_start_task()`` to be called
>> +  twice; the second call would silently fail with ``-EEXIST`` and the
>> +  second binding's threshold would never take effect.  Different code
>> +  regions that share the same ``offset_stop`` (common exit point) are
>> +  explicitly allowed.
>> +- The uprobe binding is removed when ``-offset_start:binary_path`` is
>> +  written to ``monitor``, or when the monitor is disabled.
>> +- The ``tag`` field in every ``tlob_budget_exceeded`` event is
>> +  automatically set to ``offset_start`` for the tracefs path, so
>> +  violation events for different code regions are immediately
>> +  distinguishable even when ``threshold_us`` values are identical.
>> +
>> +ftrace ring buffer (budget violation events)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When a monitored task exceeds its latency budget the hrtimer fires,
>> +records the violation, and emits a single ``tlob_budget_exceeded`` event
>> +into the ftrace ring buffer.  **Nothing is written to the ftrace ring
>> +buffer while the task is within budget.**
>> +
>> +The event carries the on-CPU / off-CPU time breakdown so that root-cause
>> +analysis (CPU-bound vs. scheduling / I/O overrun) is immediate::
>> +
>> +  cat /sys/kernel/tracing/trace
>> +
>> +Example output::
>> +
>> +  myapp-1234 [003] .... 12345.678: tlob_budget_exceeded: \
>> +    myapp[1234]: budget exceeded threshold=5000 \
>> +    on_cpu=820 off_cpu=4500 switches=3 state=off_cpu tag=0x00000000000012a0
>> +
>> +Field descriptions:
>> +
>> +``threshold``
>> +  Configured latency budget in microseconds.
>> +
>> +``on_cpu``
>> +  Cumulative on-CPU time since ``trace_start``, in microseconds.
>> +
>> +``off_cpu``
>> +  Cumulative off-CPU (scheduling + I/O wait) time since ``trace_start``,
>> +  in microseconds.
>> +
>> +``switches``
>> +  Number of times the task was scheduled out during this window.
>> +
>> +``state``
>> +  DA state when the hrtimer fired: ``on_cpu`` means the task was executing
>> +  when the budget expired (CPU-bound overrun); ``off_cpu`` means the task
>> +  was preempted or blocked (scheduling / I/O overrun).
>> +
>> +``tag``
>> +  Opaque 64-bit cookie supplied by the caller via ``tlob_start_args.tag``
>> +  (ioctl path) or automatically set to ``offset_start`` (tracefs uprobe
>> +  path).  Use it to distinguish violations from different code regions
>> +  monitored by the same thread.  Zero when not set.
>> +
>> +To capture violations in a file::
>> +
>> +  trace-cmd record -e tlob_budget_exceeded &
>> +  # ... run workload ...
>> +  trace-cmd report
>> +
>> +/dev/rv ioctl interface (self-instrumentation)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Tasks can self-instrument their own code paths via the ``/dev/rv`` misc
>> +device (requires ``CONFIG_RV_CHARDEV``).  The kernel key is
>> +``task_struct``; multiple threads sharing a single fd each get their own
>> +independent monitoring slot.
>> +
>> +**Synchronous mode**  --  the calling thread checks its own result::
>> +
>> +  int fd = open("/dev/rv", O_RDWR);
>> +
>> +  struct tlob_start_args args = {
>> +      .threshold_us = 50000,   /* 50 ms */
>> +      .tag          = 0,       /* optional; 0 = don't care */
>> +      .notify_fd    = -1,      /* no fd notification */
>> +  };
>> +  ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
>> +
>> +  /* ... code path under observation ... */
>> +
>> +  int ret = ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
>> +  /* ret == 0:          within budget  */
>> +  /* ret == -EOVERFLOW: budget exceeded */
>> +
>> +  close(fd);
>> +
>> +**Asynchronous mode**  --  a dedicated monitor thread receives violation
>> +records via ``read()`` on a shared fd, decoupling the observation from
>> +the critical path::
>> +
>> +  /* Monitor thread: open a dedicated fd. */
>> +  int monitor_fd = open("/dev/rv", O_RDWR);
>> +
>> +  /* Worker thread: set notify_fd = monitor_fd in TRACE_START args. */
>> +  int work_fd = open("/dev/rv", O_RDWR);
>> +  struct tlob_start_args args = {
>> +      .threshold_us = 10000,   /* 10 ms */
>> +      .tag          = REGION_A,
>> +      .notify_fd    = monitor_fd,
>> +  };
>> +  ioctl(work_fd, TLOB_IOCTL_TRACE_START, &args);
>> +  /* ... critical section ... */
>> +  ioctl(work_fd, TLOB_IOCTL_TRACE_STOP, NULL);
>> +
>> +  /* Monitor thread: blocking read() returns one or more tlob_event records.
>> */
>> +  struct tlob_event ntfs[8];
>> +  ssize_t n = read(monitor_fd, ntfs, sizeof(ntfs));
>> +  for (int i = 0; i < n / sizeof(struct tlob_event); i++) {
>> +      struct tlob_event *ntf = &ntfs[i];
>> +      printf("tid=%u tag=0x%llx exceeded budget=%llu us "
>> +             "(on_cpu=%llu off_cpu=%llu switches=%u state=%s)\n",
>> +             ntf->tid, ntf->tag, ntf->threshold_us,
>> +             ntf->on_cpu_us, ntf->off_cpu_us, ntf->switches,
>> +             ntf->state ? "on_cpu" : "off_cpu");
>> +  }
>> +
>> +**mmap ring buffer**  --  zero-copy consumption of violation events::
>> +
>> +  int fd = open("/dev/rv", O_RDWR);
>> +  struct tlob_start_args args = {
>> +      .threshold_us = 1000,   /* 1 ms */
>> +      .notify_fd    = fd,     /* push violations to own ring buffer */
>> +  };
>> +  ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
>> +
>> +  /* Map the ring: one control page + capacity data records. */
>> +  size_t pagesize = sysconf(_SC_PAGESIZE);
>> +  size_t cap = 64;   /* read from page->capacity after mmap */
>> +  size_t len = pagesize + cap * sizeof(struct tlob_event);
>> +  void *map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +
>> +  struct tlob_mmap_page *page = map;
>> +  struct tlob_event *data =
>> +      (struct tlob_event *)((char *)map + page->data_offset);
>> +
>> +  /* Consumer loop: poll for events, read without copying. */
>> +  while (1) {
>> +      poll(&(struct pollfd){fd, POLLIN, 0}, 1, -1);
>> +
>> +      uint32_t head = __atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE);
>> +      uint32_t tail = page->data_tail;
>> +      while (tail != head) {
>> +          handle(&data[tail & (page->capacity - 1)]);
>> +          tail++;
>> +      }
>> +      __atomic_store_n(&page->data_tail, tail, __ATOMIC_RELEASE);
>> +  }
>> +
>> +Note: ``read()`` and ``mmap()`` share the same ring and ``data_tail``
>> +cursor.  Do not use both simultaneously on the same fd.
>> +
>> +``tlob_event`` fields:
>> +
>> +``tid``
>> +  Thread ID (``task_pid_vnr``) of the violating task.
>> +
>> +``threshold_us``
>> +  Budget that was exceeded, in microseconds.
>> +
>> +``on_cpu_us``
>> +  Cumulative on-CPU time at violation time, in microseconds.
>> +
>> +``off_cpu_us``
>> +  Cumulative off-CPU time at violation time, in microseconds.
>> +
>> +``switches``
>> +  Number of context switches since ``TRACE_START``.
>> +
>> +``state``
>> +  1 = timer fired while task was on-CPU; 0 = timer fired while off-CPU.
>> +
>> +``tag``
>> +  Cookie from ``tlob_start_args.tag``; for the tracefs uprobe path this
>> +  equals ``offset_start``.  Zero when not set.
>> +
>> +tracefs files
>> +-------------
>> +
>> +The following files are created under
>> +``/sys/kernel/tracing/rv/monitors/tlob/``:
>> +
>> +``enable`` (rw)
>> +  Write ``1`` to enable the monitor; write ``0`` to disable it and
>> +  stop all currently monitored tasks.
>> +
>> +``desc`` (ro)
>> +  Human-readable description of the monitor.
>> +
>> +``monitor`` (rw)
>> +  Write ``threshold_us:offset_start:offset_stop:binary_path`` to bind two
>> +  plain entry uprobes in *binary_path*.  The uprobe at *offset_start* fires
>> +  ``tlob_start_task()``; the uprobe at *offset_stop* fires
>> +  ``tlob_stop_task()``.  Returns ``-EEXIST`` if a binding with the same
>> +  *offset_start* already exists for *binary_path*.  Write
>> +  ``-offset_start:binary_path`` to remove the binding.  Read to list
>> +  registered bindings, one
>> +  ``threshold_us:0xoffset_start:0xoffset_stop:binary_path`` entry per line.
>> +
>> +Specification
>> +-------------
>> +
>> +Graphviz DOT file in tools/verification/models/tlob.dot
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 331223761..8d3af68db 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -385,6 +385,7 @@ Code  Seq#    Include
>> File                                             Comments
>>   0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h
>> Marvell CN10K DPI driver
>>   0xB8  all    uapi/linux/mshv.h
>> Microsoft Hyper-V /dev/mshv driver
>>                                                                         
>> <mailto:linux-hyperv@vger.kernel.org>
>> +0xB9  00-3F  linux/rv.h
>> Runtime Verification (RV) monitors
>>   0xBA  00-0F  uapi/linux/liveupdate.h                                   Pasha
>> Tatashin
>>                                                                         
>> <mailto:pasha.tatashin@soleen.com>
>>   0xC0  00-0F  linux/usb/iowarrior.h
>> diff --git a/include/uapi/linux/rv.h b/include/uapi/linux/rv.h
>> new file mode 100644
>> index 000000000..d1b96d8cd
>> --- /dev/null
>> +++ b/include/uapi/linux/rv.h
>> @@ -0,0 +1,181 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * UAPI definitions for Runtime Verification (RV) monitors.
>> + *
>> + * All RV monitors that expose an ioctl self-instrumentation interface
>> + * share the magic byte RV_IOC_MAGIC (0xB9), registered in
>> + * Documentation/userspace-api/ioctl/ioctl-number.rst.
>> + *
>> + * A single /dev/rv misc device serves as the entry point.  ioctl numbers
>> + * encode both the monitor identity and the operation:
>> + *
>> + *   0x01 - 0x1F  tlob (task latency over budget)
>> + *   0x20 - 0x3F  reserved for future RV monitors
>> + *
>> + * Usage examples and design rationale are in:
>> + *   Documentation/trace/rv/monitor_tlob.rst
>> + */
>> +
>> +#ifndef _UAPI_LINUX_RV_H
>> +#define _UAPI_LINUX_RV_H
>> +
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +/* Magic byte shared by all RV monitor ioctls. */
>> +#define RV_IOC_MAGIC	0xB9
>> +
>> +/* -----------------------------------------------------------------------
>> + * tlob: task latency over budget monitor  (nr 0x01 - 0x1F)
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +/**
>> + * struct tlob_start_args - arguments for TLOB_IOCTL_TRACE_START
>> + * @threshold_us: Latency budget for this critical section, in microseconds.
>> + *               Must be greater than zero.
>> + * @tag:         Opaque 64-bit cookie supplied by the caller.  Echoed back
>> + *               verbatim in the tlob_budget_exceeded ftrace event and in any
>> + *               tlob_event record delivered via @notify_fd.  Use it to
>> identify
>> + *               which code region triggered a violation when the same thread
>> + *               monitors multiple regions sequentially.  Set to 0 if not
>> + *               needed.
>> + * @notify_fd:   File descriptor that will receive a tlob_event record on
>> + *               violation.  Must refer to an open /dev/rv fd.  May equal
>> + *               the calling fd (self-notification, useful for retrieving the
>> + *               on_cpu_us / off_cpu_us breakdown after TRACE_STOP returns
>> + *               -EOVERFLOW).  Set to -1 to disable fd notification; in that
>> + *               case violations are only signalled via the TRACE_STOP return
>> + *               value and the tlob_budget_exceeded ftrace event.
>> + * @flags:       Must be 0.  Reserved for future extensions.
>> + */
>> +struct tlob_start_args {
>> +	__u64 threshold_us;
>> +	__u64 tag;
>> +	__s32 notify_fd;
>> +	__u32 flags;
>> +};
>> +
>> +/**
>> + * struct tlob_event - one budget-exceeded event
>> + *
>> + * Consumed by read() on the notify_fd registered at TLOB_IOCTL_TRACE_START.
>> + * Each record describes a single budget exceedance for one task.
>> + *
>> + * @tid:          Thread ID (task_pid_vnr) of the violating task.
>> + * @threshold_us: Budget that was exceeded, in microseconds.
>> + * @on_cpu_us:    Cumulative on-CPU time at violation time, in microseconds.
>> + * @off_cpu_us:   Cumulative off-CPU (scheduling + I/O wait) time at
>> + *               violation time, in microseconds.
>> + * @switches:     Number of context switches since TRACE_START.
>> + * @state:        DA state at violation: 1 = on_cpu, 0 = off_cpu.
>> + * @tag:          Cookie from tlob_start_args.tag; for the tracefs uprobe
>> path
>> + *               this is the offset_start value.  Zero when not set.
>> + */
>> +struct tlob_event {
>> +	__u32 tid;
>> +	__u32 pad;
>> +	__u64 threshold_us;
>> +	__u64 on_cpu_us;
>> +	__u64 off_cpu_us;
>> +	__u32 switches;
>> +	__u32 state;   /* 1 = on_cpu, 0 = off_cpu */
>> +	__u64 tag;
>> +};
>> +
>> +/**
>> + * struct tlob_mmap_page - control page for the mmap'd violation ring buffer
>> + *
>> + * Mapped at offset 0 of the mmap region returned by mmap(2) on a /dev/rv fd.
>> + * The data array of struct tlob_event records begins at offset @data_offset
>> + * (always one page from the mmap base; use this field rather than hard-
>> coding
>> + * PAGE_SIZE so the code remains correct across architectures).
>> + *
>> + * Ring layout:
>> + *
>> + *   mmap base + 0             : struct tlob_mmap_page  (one page)
>> + *   mmap base + data_offset   : struct tlob_event[capacity]
>> + *
>> + * The mmap length determines the ring capacity.  Compute it as:
>> + *
>> + *   raw    = sysconf(_SC_PAGESIZE) + capacity * sizeof(struct tlob_event)
>> + *   length = (raw + sysconf(_SC_PAGESIZE) - 1) & ~(sysconf(_SC_PAGESIZE) -
>> 1)
>> + *
>> + * i.e. round the raw byte count up to the next page boundary before
>> + * passing it to mmap(2).  The kernel requires a page-aligned length.
>> + * capacity must be a power of 2.  Read @capacity after a successful
>> + * mmap(2) for the actual value.
>> + *
>> + * Producer/consumer ordering contract:
>> + *
>> + *   Kernel (producer):
>> + *     data[data_head & (capacity - 1)] = event;
>> + *     // pairs with load-acquire in userspace:
>> + *     smp_store_release(&page->data_head, data_head + 1);
>> + *
>> + *   Userspace (consumer):
>> + *     // pairs with store-release in kernel:
>> + *     head = __atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE);
>> + *     for (tail = page->data_tail; tail != head; tail++)
>> + *         handle(&data[tail & (capacity - 1)]);
>> + *     __atomic_store_n(&page->data_tail, tail, __ATOMIC_RELEASE);
>> + *
>> + * @data_head and @data_tail are monotonically increasing __u32 counters
>> + * in units of records.  Unsigned 32-bit wrap-around is handled correctly
>> + * by modular arithmetic; the ring is full when
>> + * (data_head - data_tail) == capacity.
>> + *
>> + * When the ring is full the kernel drops the incoming record and increments
>> + * @dropped.  The consumer should check @dropped periodically to detect loss.
>> + *
>> + * read() and mmap() share the same ring buffer.  Do not use both
>> + * simultaneously on the same fd.
>> + *
>> + * @data_head:   Next write slot index.  Updated by the kernel with
>> + *               store-release ordering.  Read by userspace with load-
>> acquire.
>> + * @data_tail:   Next read slot index.  Updated by userspace.  Read by the
>> + *               kernel to detect overflow.
>> + * @capacity:    Actual ring capacity in records (power of 2).  Written once
>> + *               by the kernel at mmap time; read-only for userspace
>> thereafter.
>> + * @version:     Ring buffer ABI version; currently 1.
>> + * @data_offset: Byte offset from the mmap base to the data array.
>> + *               Always equal to sysconf(_SC_PAGESIZE) on the running kernel.
>> + * @record_size: sizeof(struct tlob_event) as seen by the kernel.  Verify
>> + *               this matches userspace's sizeof before indexing the array.
>> + * @dropped:     Number of events dropped because the ring was full.
>> + *               Monotonically increasing; read with __ATOMIC_RELAXED.
>> + */
>> +struct tlob_mmap_page {
>> +	__u32  data_head;
>> +	__u32  data_tail;
>> +	__u32  capacity;
>> +	__u32  version;
>> +	__u32  data_offset;
>> +	__u32  record_size;
>> +	__u64  dropped;
>> +};
>> +
>> +/*
>> + * TLOB_IOCTL_TRACE_START - begin monitoring the calling task.
>> + *
>> + * Arms a per-task hrtimer for threshold_us microseconds.  If args.notify_fd
>> + * is >= 0, a tlob_event record is pushed into that fd's ring buffer on
>> + * violation in addition to the tlob_budget_exceeded ftrace event.
>> + * args.notify_fd == -1 disables fd notification.
>> + *
>> + * Violation records are consumed by read() on the notify_fd (blocking or
>> + * non-blocking depending on O_NONBLOCK).  On violation,
>> TLOB_IOCTL_TRACE_STOP
>> + * also returns -EOVERFLOW regardless of whether notify_fd is set.
>> + *
>> + * args.flags must be 0.
>> + */
>> +#define TLOB_IOCTL_TRACE_START		_IOW(RV_IOC_MAGIC, 0x01, struct
>> tlob_start_args)
>> +
>> +/*
>> + * TLOB_IOCTL_TRACE_STOP - end monitoring the calling task.
>> + *
>> + * Returns 0 if within budget, -EOVERFLOW if the budget was exceeded.
>> + */
>> +#define TLOB_IOCTL_TRACE_STOP		_IO(RV_IOC_MAGIC,  0x02)
>> +
>> +#endif /* _UAPI_LINUX_RV_H */
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index 5b4be87ba..227573cda 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -65,6 +65,7 @@ source "kernel/trace/rv/monitors/pagefault/Kconfig"
>>   source "kernel/trace/rv/monitors/sleep/Kconfig"
>>   # Add new rtapp monitors here
>>   
>> +source "kernel/trace/rv/monitors/tlob/Kconfig"
>>   # Add new monitors here
>>   
>>   config RV_REACTORS
>> @@ -93,3 +94,19 @@ config RV_REACT_PANIC
>>   	help
>>   	  Enables the panic reactor. The panic reactor emits a printk()
>>   	  message if an exception is found and panic()s the system.
>> +
>> +config RV_CHARDEV
>> +	bool "RV ioctl interface via /dev/rv"
>> +	depends on RV
>> +	default n
>> +	help
>> +	  Register a /dev/rv misc device that exposes an ioctl interface
>> +	  for RV monitor self-instrumentation.  All RV monitors share the
>> +	  single device node; ioctl numbers encode the monitor identity.
>> +
>> +	  When enabled, user-space programs can open /dev/rv and use
>> +	  monitor-specific ioctl commands to bracket code regions they
>> +	  want the kernel RV subsystem to observe.
>> +
>> +	  Say Y here if you want to use the tlob self-instrumentation
>> +	  ioctl interface; otherwise say N.
>> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
>> index 750e4ad6f..cc3781a3b 100644
>> --- a/kernel/trace/rv/Makefile
>> +++ b/kernel/trace/rv/Makefile
>> @@ -3,6 +3,7 @@
>>   ccflags-y += -I $(src)		# needed for trace events
>>   
>>   obj-$(CONFIG_RV) += rv.o
>> +obj-$(CONFIG_RV_CHARDEV) += rv_dev.o
>>   obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
>>   obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
>>   obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
>> @@ -17,6 +18,7 @@ obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
>>   obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
>>   obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
>>   obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
>> +obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
>>   # Add new monitors here
>>   obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>>   obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
>> diff --git a/kernel/trace/rv/monitors/tlob/Kconfig
>> b/kernel/trace/rv/monitors/tlob/Kconfig
>> new file mode 100644
>> index 000000000..010237480
>> --- /dev/null
>> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +config RV_MON_TLOB
>> +	depends on RV
>> +	depends on UPROBES
>> +	select DA_MON_EVENTS_ID
>> +	bool "tlob monitor"
>> +	help
>> +	  Enable the tlob (task latency over budget) monitor. This monitor
>> +	  tracks the elapsed time (CLOCK_MONOTONIC) of a marked code path
>> within a
>> +	  task (including both on-CPU and off-CPU time) and reports a
>> +	  violation when the elapsed time exceeds a configurable budget
>> +	  threshold.
>> +
>> +	  The monitor implements a three-state deterministic automaton.
>> +	  States: unmonitored, on_cpu, off_cpu.
>> +	  Key transitions:
>> +	    unmonitored    --(trace_start)-->    on_cpu
>> +	    on_cpu   --(switch_out)-->     off_cpu
>> +	    off_cpu  --(switch_in)-->      on_cpu
>> +	    on_cpu   --(trace_stop)-->    unmonitored
>> +	    off_cpu  --(trace_stop)-->    unmonitored
>> +	    on_cpu   --(budget_expired)--> unmonitored
>> +	    off_cpu  --(budget_expired)--> unmonitored
>> +
>> +	  External configuration is done via the tracefs "monitor" file:
>> +	    echo pid:threshold_us:binary:offset_start:offset_stop >
>> .../rv/monitors/tlob/monitor
>> +	    echo -pid             > .../rv/monitors/tlob/monitor  (remove
>> task)
>> +	    cat                     .../rv/monitors/tlob/monitor  (list
>> tasks)
>> +
>> +	  The uprobe binding places two plain entry uprobes at offset_start
>> and
>> +	  offset_stop in the binary; these trigger tlob_start_task() and
>> +	  tlob_stop_task() respectively.  Using two entry uprobes (rather
>> than a
>> +	  uretprobe) means that a mistyped offset can never corrupt the call
>> +	  stack; the worst outcome is a missed stop, which causes the hrtimer
>> to
>> +	  fire and report a budget violation.
>> +
>> +	  Violation events are delivered via a lock-free mmap ring buffer on
>> +	  /dev/rv (enabled by CONFIG_RV_CHARDEV).  The consumer mmap()s the
>> +	  device, reads records from the data array using the head/tail
>> indices
>> +	  in the control page, and advances data_tail when done.
>> +
>> +	  For self-instrumentation, use TLOB_IOCTL_TRACE_START /
>> +	  TLOB_IOCTL_TRACE_STOP via the /dev/rv misc device (enabled by
>> +	  CONFIG_RV_CHARDEV).
>> +
>> +	  Up to TLOB_MAX_MONITORED tasks may be monitored simultaneously.
>> +
>> +	  For further information, see:
>> +	    Documentation/trace/rv/monitor_tlob.rst
>> +
>> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
>> b/kernel/trace/rv/monitors/tlob/tlob.c
>> new file mode 100644
>> index 000000000..a6e474025
>> --- /dev/null
>> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
>> @@ -0,0 +1,986 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * tlob: task latency over budget monitor
>> + *
>> + * Track the elapsed wall-clock time of a marked code path and detect when
>> + * a monitored task exceeds its per-task latency budget.  CLOCK_MONOTONIC
>> + * is used so both on-CPU and off-CPU time count toward the budget.
>> + *
>> + * Per-task state is maintained in a spinlock-protected hash table.  A
>> + * one-shot hrtimer fires at the deadline; if the task has not called
>> + * trace_stop by then, a violation is recorded.
>> + *
>> + * Up to TLOB_MAX_MONITORED tasks may be tracked simultaneously.
>> + *
>> + * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
>> + */
>> +#include <linux/file.h>
>> +#include <linux/fs.h>
>> +#include <linux/ftrace.h>
>> +#include <linux/hash.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/kernel.h>
>> +#include <linux/ktime.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/namei.h>
>> +#include <linux/poll.h>
>> +#include <linux/rv.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/atomic.h>
>> +#include <linux/rcupdate.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/tracefs.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/uprobes.h>
>> +#include <kunit/visibility.h>
>> +#include <rv/instrumentation.h>
>> +
>> +/* rv_interface_lock is defined in kernel/trace/rv/rv.c */
>> +extern struct mutex rv_interface_lock;
>> +
>> +#define MODULE_NAME "tlob"
>> +
>> +#include <rv_trace.h>
>> +#include <trace/events/sched.h>
>> +
>> +#define RV_MON_TYPE RV_MON_PER_TASK
>> +#include "tlob.h"
>> +#include <rv/da_monitor.h>
>> +
>> +/* Hash table size; must be a power of two. */
>> +#define TLOB_HTABLE_BITS		6
>> +#define TLOB_HTABLE_SIZE		(1 << TLOB_HTABLE_BITS)
>> +
>> +/* Maximum binary path length for uprobe binding. */
>> +#define TLOB_MAX_PATH			256
>> +
>> +/* Per-task latency monitoring state. */
>> +struct tlob_task_state {
>> +	struct hlist_node	hlist;
>> +	struct task_struct	*task;
>> +	u64			threshold_us;
>> +	u64			tag;
>> +	struct hrtimer		deadline_timer;
>> +	int			canceled;	/* protected by entry_lock */
>> +	struct file		*notify_file;	/* NULL or held reference */
>> +
>> +	/*
>> +	 * entry_lock serialises the mutable accounting fields below.
>> +	 * Lock order: tlob_table_lock -> entry_lock (never reverse).
>> +	 */
>> +	raw_spinlock_t		entry_lock;
>> +	u64			on_cpu_us;
>> +	u64			off_cpu_us;
>> +	ktime_t			last_ts;
>> +	u32			switches;
>> +	u8			da_state;
>> +
>> +	struct rcu_head		rcu;	/* for call_rcu() teardown */
>> +};
>> +
>> +/* Per-uprobe-binding state: a start + stop probe pair for one binary region.
>> */
>> +struct tlob_uprobe_binding {
>> +	struct list_head	list;
>> +	u64			threshold_us;
>> +	struct path		path;
>> +	char			binpath[TLOB_MAX_PATH];	/* canonical
>> path for read/remove */
>> +	loff_t			offset_start;
>> +	loff_t			offset_stop;
>> +	struct uprobe_consumer	entry_uc;
>> +	struct uprobe_consumer	stop_uc;
>> +	struct uprobe		*entry_uprobe;
>> +	struct uprobe		*stop_uprobe;
>> +};
>> +
>> +/* Object pool for tlob_task_state. */
>> +static struct kmem_cache *tlob_state_cache;
>> +
>> +/* Hash table and lock protecting table structure (insert/delete/canceled).
>> */
>> +static struct hlist_head tlob_htable[TLOB_HTABLE_SIZE];
>> +static DEFINE_RAW_SPINLOCK(tlob_table_lock);
>> +static atomic_t tlob_num_monitored = ATOMIC_INIT(0);
>> +
>> +/* Uprobe binding list; protected by tlob_uprobe_mutex. */
>> +static LIST_HEAD(tlob_uprobe_list);
>> +static DEFINE_MUTEX(tlob_uprobe_mutex);
>> +
>> +/* Forward declaration */
>> +static enum hrtimer_restart tlob_deadline_timer_fn(struct hrtimer *timer);
>> +
>> +/* Hash table helpers */
>> +
>> +static unsigned int tlob_hash_task(const struct task_struct *task)
>> +{
>> +	return hash_ptr((void *)task, TLOB_HTABLE_BITS);
>> +}
>> +
>> +/*
>> + * tlob_find_rcu - look up per-task state.
>> + * Must be called under rcu_read_lock() or with tlob_table_lock held.
>> + */
>> +static struct tlob_task_state *tlob_find_rcu(struct task_struct *task)
>> +{
>> +	struct tlob_task_state *ws;
>> +	unsigned int h = tlob_hash_task(task);
>> +
>> +	hlist_for_each_entry_rcu(ws, &tlob_htable[h], hlist,
>> +				 lockdep_is_held(&tlob_table_lock))
>> +		if (ws->task == task)
>> +			return ws;
>> +	return NULL;
>> +}
>> +
>> +/* Allocate and initialise a new per-task state entry. */
>> +static struct tlob_task_state *tlob_alloc(struct task_struct *task,
>> +					  u64 threshold_us, u64 tag)
>> +{
>> +	struct tlob_task_state *ws;
>> +
>> +	ws = kmem_cache_zalloc(tlob_state_cache, GFP_ATOMIC);
>> +	if (!ws)
>> +		return NULL;
>> +
>> +	ws->task = task;
>> +	get_task_struct(task);
>> +	ws->threshold_us = threshold_us;
>> +	ws->tag = tag;
>> +	ws->last_ts = ktime_get();
>> +	ws->da_state = on_cpu_tlob;
>> +	raw_spin_lock_init(&ws->entry_lock);
>> +	hrtimer_setup(&ws->deadline_timer, tlob_deadline_timer_fn,
>> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	return ws;
>> +}
>> +
>> +/* RCU callback: free the slab once no readers remain. */
>> +static void tlob_free_rcu_slab(struct rcu_head *head)
>> +{
>> +	struct tlob_task_state *ws =
>> +		container_of(head, struct tlob_task_state, rcu);
>> +	kmem_cache_free(tlob_state_cache, ws);
>> +}
>> +
>> +/* Arm the one-shot deadline timer for threshold_us microseconds. */
>> +static void tlob_arm_deadline(struct tlob_task_state *ws)
>> +{
>> +	hrtimer_start(&ws->deadline_timer,
>> +		      ns_to_ktime(ws->threshold_us * NSEC_PER_USEC),
>> +		      HRTIMER_MODE_REL);
>> +}
>> +
>> +/*
>> + * Push a violation record into a monitor fd's ring buffer (softirq context).
>> + * Drop-new policy: discard incoming record when full.  smp_store_release on
>> + * data_head pairs with smp_load_acquire in the consumer.
>> + */
>> +static void tlob_event_push(struct rv_file_priv *priv,
>> +			    const struct tlob_event *info)
>> +{
>> +	struct tlob_ring *ring = &priv->ring;
>> +	unsigned long flags;
>> +	u32 head, tail;
>> +
>> +	spin_lock_irqsave(&ring->lock, flags);
>> +
>> +	head = ring->page->data_head;
>> +	tail = READ_ONCE(ring->page->data_tail);
>> +
>> +	if (head - tail > ring->mask) {
>> +		/* Ring full: drop incoming record. */
>> +		ring->page->dropped++;
>> +		spin_unlock_irqrestore(&ring->lock, flags);
>> +		return;
>> +	}
>> +
>> +	ring->data[head & ring->mask] = *info;
>> +	/* pairs with smp_load_acquire() in the consumer */
>> +	smp_store_release(&ring->page->data_head, head + 1);
>> +
>> +	spin_unlock_irqrestore(&ring->lock, flags);
>> +
>> +	wake_up_interruptible_poll(&priv->waitq, EPOLLIN | EPOLLRDNORM);
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_KUNIT)
>> +void tlob_event_push_kunit(struct rv_file_priv *priv,
>> +			  const struct tlob_event *info)
>> +{
>> +	tlob_event_push(priv, info);
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(tlob_event_push_kunit);
>> +#endif /* CONFIG_KUNIT */
>> +
>> +/*
>> + * Budget exceeded: remove the entry, record the violation, and inject
>> + * budget_expired into the DA.
>> + *
>> + * Lock order: tlob_table_lock -> entry_lock.  tlob_stop_task() sets
>> + * ws->canceled under both locks; if we see it here the stop path owns
>> cleanup.
>> + * fput/put_task_struct are done before call_rcu(); the RCU callback only
>> + * reclaims the slab.
>> + */
>> +static enum hrtimer_restart tlob_deadline_timer_fn(struct hrtimer *timer)
>> +{
>> +	struct tlob_task_state *ws =
>> +		container_of(timer, struct tlob_task_state, deadline_timer);
>> +	struct tlob_event info = {};
>> +	struct file *notify_file;
>> +	struct task_struct *task;
>> +	unsigned long flags;
>> +	/* snapshots taken under entry_lock */
>> +	u64 on_cpu_us, off_cpu_us, threshold_us, tag;
>> +	u32 switches;
>> +	bool on_cpu;
>> +	bool push_event = false;
>> +
>> +	raw_spin_lock_irqsave(&tlob_table_lock, flags);
>> +	/* stop path sets canceled under both locks; if set it owns cleanup
>> */
>> +	if (ws->canceled) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		return HRTIMER_NORESTART;
>> +	}
>> +
>> +	/* Finalize accounting and snapshot all fields under entry_lock. */
>> +	raw_spin_lock(&ws->entry_lock);
>> +
>> +	{
>> +		ktime_t now = ktime_get();
>> +		u64 delta_us = ktime_to_us(ktime_sub(now, ws->last_ts));
>> +
>> +		if (ws->da_state == on_cpu_tlob)
>> +			ws->on_cpu_us += delta_us;
>> +		else
>> +			ws->off_cpu_us += delta_us;
>> +	}
>> +
>> +	ws->canceled  = 1;
>> +	on_cpu_us     = ws->on_cpu_us;
>> +	off_cpu_us    = ws->off_cpu_us;
>> +	threshold_us  = ws->threshold_us;
>> +	tag           = ws->tag;
>> +	switches      = ws->switches;
>> +	on_cpu        = (ws->da_state == on_cpu_tlob);
>> +	notify_file   = ws->notify_file;
>> +	if (notify_file) {
>> +		info.tid          = task_pid_vnr(ws->task);
>> +		info.threshold_us = threshold_us;
>> +		info.on_cpu_us    = on_cpu_us;
>> +		info.off_cpu_us   = off_cpu_us;
>> +		info.switches     = switches;
>> +		info.state        = on_cpu ? 1 : 0;
>> +		info.tag          = tag;
>> +		push_event        = true;
>> +	}
>> +
>> +	raw_spin_unlock(&ws->entry_lock);
>> +
>> +	hlist_del_rcu(&ws->hlist);
>> +	atomic_dec(&tlob_num_monitored);
>> +	/*
>> +	 * Hold a reference so task remains valid across da_handle_event()
>> +	 * after we drop tlob_table_lock.
>> +	 */
>> +	task = ws->task;
>> +	get_task_struct(task);
>> +	raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +
>> +	/*
>> +	 * Both locks are now released; ws is exclusively owned (removed from
>> +	 * the hash table with canceled=1).  Emit the tracepoint and push the
>> +	 * violation record.
>> +	 */
>> +	trace_tlob_budget_exceeded(ws->task, threshold_us, on_cpu_us,
>> +				   off_cpu_us, switches, on_cpu, tag);
>> +
>> +	if (push_event) {
>> +		struct rv_file_priv *priv = notify_file->private_data;
>> +
>> +		if (priv)
>> +			tlob_event_push(priv, &info);
>> +	}
>> +
>> +	da_handle_event(task, budget_expired_tlob);
>> +
>> +	if (notify_file)
>> +		fput(notify_file);		/* ref from fget() at
>> TRACE_START */
>> +	put_task_struct(ws->task);		/* ref from tlob_alloc() */
>> +	put_task_struct(task);			/* extra ref from
>> get_task_struct() above */
>> +	call_rcu(&ws->rcu, tlob_free_rcu_slab);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +/* Tracepoint handlers */
>> +
>> +/*
>> + * handle_sched_switch - advance the DA and accumulate on/off-CPU time.
>> + *
>> + * RCU read-side for lock-free lookup; entry_lock for per-task accounting.
>> + * da_handle_event() is called after rcu_read_unlock() to avoid holding the
>> + * read-side critical section across the RV framework.
>> + */
>> +static void handle_sched_switch(void *data, bool preempt,
>> +				struct task_struct *prev,
>> +				struct task_struct *next,
>> +				unsigned int prev_state)
>> +{
>> +	struct tlob_task_state *ws;
>> +	unsigned long flags;
>> +	bool do_prev = false, do_next = false;
>> +	ktime_t now;
>> +
>> +	rcu_read_lock();
>> +
>> +	ws = tlob_find_rcu(prev);
>> +	if (ws) {
>> +		raw_spin_lock_irqsave(&ws->entry_lock, flags);
>> +		if (!ws->canceled) {
>> +			now = ktime_get();
>> +			ws->on_cpu_us += ktime_to_us(ktime_sub(now, ws-
>>> last_ts));
>> +			ws->last_ts = now;
>> +			ws->switches++;
>> +			ws->da_state = off_cpu_tlob;
>> +			do_prev = true;
>> +		}
>> +		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
>> +	}
>> +
>> +	ws = tlob_find_rcu(next);
>> +	if (ws) {
>> +		raw_spin_lock_irqsave(&ws->entry_lock, flags);
>> +		if (!ws->canceled) {
>> +			now = ktime_get();
>> +			ws->off_cpu_us += ktime_to_us(ktime_sub(now, ws-
>>> last_ts));
>> +			ws->last_ts = now;
>> +			ws->da_state = on_cpu_tlob;
>> +			do_next = true;
>> +		}
>> +		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +	if (do_prev)
>> +		da_handle_event(prev, switch_out_tlob);
>> +	if (do_next)
>> +		da_handle_event(next, switch_in_tlob);
>> +}
>> +
>> +static void handle_sched_wakeup(void *data, struct task_struct *p)
>> +{
>> +	struct tlob_task_state *ws;
>> +	unsigned long flags;
>> +	bool found = false;
>> +
>> +	rcu_read_lock();
>> +	ws = tlob_find_rcu(p);
>> +	if (ws) {
>> +		raw_spin_lock_irqsave(&ws->entry_lock, flags);
>> +		found = !ws->canceled;
>> +		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	if (found)
>> +		da_handle_event(p, sched_wakeup_tlob);
>> +}
>> +
>> +/* -----------------------------------------------------------------------
>> + * Core start/stop helpers (also called from rv_dev.c)
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +/*
>> + * __tlob_insert - insert @ws into the hash table and arm its deadline timer.
>> + *
>> + * Re-checks for duplicates and capacity under tlob_table_lock; the caller
>> + * may have done a lock-free pre-check before allocating @ws.  On failure @ws
>> + * is freed directly (never in table, so no call_rcu needed).
>> + */
>> +static int __tlob_insert(struct task_struct *task, struct tlob_task_state
>> *ws)
>> +{
>> +	unsigned int h;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&tlob_table_lock, flags);
>> +	if (tlob_find_rcu(task)) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		if (ws->notify_file)
>> +			fput(ws->notify_file);
>> +		put_task_struct(ws->task);
>> +		kmem_cache_free(tlob_state_cache, ws);
>> +		return -EEXIST;
>> +	}
>> +	if (atomic_read(&tlob_num_monitored) >= TLOB_MAX_MONITORED) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		if (ws->notify_file)
>> +			fput(ws->notify_file);
>> +		put_task_struct(ws->task);
>> +		kmem_cache_free(tlob_state_cache, ws);
>> +		return -ENOSPC;
>> +	}
>> +	h = tlob_hash_task(task);
>> +	hlist_add_head_rcu(&ws->hlist, &tlob_htable[h]);
>> +	atomic_inc(&tlob_num_monitored);
>> +	raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +
>> +	da_handle_start_run_event(task, trace_start_tlob);
>> +	tlob_arm_deadline(ws);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * tlob_start_task - begin monitoring @task with latency budget
>> @threshold_us.
>> + *
>> + * @notify_file: /dev/rv fd whose ring buffer receives a tlob_event on
>> + *               violation; caller transfers the fget() reference to tlob.c.
>> + *               Pass NULL for synchronous mode (violations only via
>> + *               TRACE_STOP return value and the tlob_budget_exceeded event).
>> + *
>> + * Returns 0, -ENODEV, -EEXIST, -ENOSPC, or -ENOMEM.  On failure the caller
>> + * retains responsibility for any @notify_file reference.
>> + */
>> +int tlob_start_task(struct task_struct *task, u64 threshold_us,
>> +		    struct file *notify_file, u64 tag)
>> +{
>> +	struct tlob_task_state *ws;
>> +	unsigned long flags;
>> +
>> +	if (!tlob_state_cache)
>> +		return -ENODEV;
>> +
>> +	if (threshold_us > (u64)KTIME_MAX / NSEC_PER_USEC)
>> +		return -ERANGE;
>> +
>> +	/* Quick pre-check before allocation. */
>> +	raw_spin_lock_irqsave(&tlob_table_lock, flags);
>> +	if (tlob_find_rcu(task)) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		return -EEXIST;
>> +	}
>> +	if (atomic_read(&tlob_num_monitored) >= TLOB_MAX_MONITORED) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		return -ENOSPC;
>> +	}
>> +	raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +
>> +	ws = tlob_alloc(task, threshold_us, tag);
>> +	if (!ws)
>> +		return -ENOMEM;
>> +
>> +	ws->notify_file = notify_file;
>> +	return __tlob_insert(task, ws);
>> +}
>> +EXPORT_SYMBOL_GPL(tlob_start_task);
>> +
>> +/**
>> + * tlob_stop_task - stop monitoring @task before the deadline fires.
>> + *
>> + * Sets canceled under entry_lock (inside tlob_table_lock) before calling
>> + * hrtimer_cancel(), racing safely with the timer callback.
>> + *
>> + * Returns 0 if within budget, -ESRCH if the entry is gone (deadline already
>> + * fired, or TRACE_START was never called).
>> + */
>> +int tlob_stop_task(struct task_struct *task)
>> +{
>> +	struct tlob_task_state *ws;
>> +	struct file *notify_file;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&tlob_table_lock, flags);
>> +	ws = tlob_find_rcu(task);
>> +	if (!ws) {
>> +		raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +		return -ESRCH;
>> +	}
>> +
>> +	/* Prevent handle_sched_switch from updating accounting after
>> removal. */
>> +	raw_spin_lock(&ws->entry_lock);
>> +	ws->canceled = 1;
>> +	raw_spin_unlock(&ws->entry_lock);
>> +
>> +	hlist_del_rcu(&ws->hlist);
>> +	atomic_dec(&tlob_num_monitored);
>> +	raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +
>> +	hrtimer_cancel(&ws->deadline_timer);
>> +
>> +	da_handle_event(task, trace_stop_tlob);
>> +
>> +	notify_file = ws->notify_file;
>> +	if (notify_file)
>> +		fput(notify_file);
>> +	put_task_struct(ws->task);
>> +	call_rcu(&ws->rcu, tlob_free_rcu_slab);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tlob_stop_task);
>> +
>> +/* Stop monitoring all tracked tasks; called on monitor disable. */
>> +static void tlob_stop_all(void)
>> +{
>> +	struct tlob_task_state *batch[TLOB_MAX_MONITORED];
>> +	struct tlob_task_state *ws;
>> +	struct hlist_node *tmp;
>> +	unsigned long flags;
>> +	int n = 0, i;
>> +
>> +	raw_spin_lock_irqsave(&tlob_table_lock, flags);
>> +	for (i = 0; i < TLOB_HTABLE_SIZE; i++) {
>> +		hlist_for_each_entry_safe(ws, tmp, &tlob_htable[i], hlist) {
>> +			raw_spin_lock(&ws->entry_lock);
>> +			ws->canceled = 1;
>> +			raw_spin_unlock(&ws->entry_lock);
>> +			hlist_del_rcu(&ws->hlist);
>> +			atomic_dec(&tlob_num_monitored);
>> +			if (n < TLOB_MAX_MONITORED)
>> +				batch[n++] = ws;
>> +		}
>> +	}
>> +	raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
>> +
>> +	for (i = 0; i < n; i++) {
>> +		ws = batch[i];
>> +		hrtimer_cancel(&ws->deadline_timer);
>> +		da_handle_event(ws->task, trace_stop_tlob);
>> +		if (ws->notify_file)
>> +			fput(ws->notify_file);
>> +		put_task_struct(ws->task);
>> +		call_rcu(&ws->rcu, tlob_free_rcu_slab);
>> +	}
>> +}
>> +
>> +/* uprobe binding helpers */
>> +
>> +static int tlob_uprobe_entry_handler(struct uprobe_consumer *uc,
>> +				     struct pt_regs *regs, __u64 *data)
>> +{
>> +	struct tlob_uprobe_binding *b =
>> +		container_of(uc, struct tlob_uprobe_binding, entry_uc);
>> +
>> +	tlob_start_task(current, b->threshold_us, NULL, (u64)b-
>>> offset_start);
>> +	return 0;
>> +}
>> +
>> +static int tlob_uprobe_stop_handler(struct uprobe_consumer *uc,
>> +				    struct pt_regs *regs, __u64 *data)
>> +{
>> +	tlob_stop_task(current);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Register start + stop entry uprobes for a binding.
>> + * Both are plain entry uprobes (no uretprobe), so a wrong offset never
>> + * corrupts the call stack; the worst outcome is a missed stop (hrtimer
>> + * fires and reports a budget violation).
>> + * Called with tlob_uprobe_mutex held.
>> + */
>> +static int tlob_add_uprobe(u64 threshold_us, const char *binpath,
>> +			   loff_t offset_start, loff_t offset_stop)
>> +{
>> +	struct tlob_uprobe_binding *b, *tmp_b;
>> +	char pathbuf[TLOB_MAX_PATH];
>> +	struct inode *inode;
>> +	char *canon;
>> +	int ret;
>> +
>> +	b = kzalloc(sizeof(*b), GFP_KERNEL);
>> +	if (!b)
>> +		return -ENOMEM;
>> +
>> +	if (binpath[0] != '/') {
>> +		kfree(b);
>> +		return -EINVAL;
>> +	}
>> +
>> +	b->threshold_us = threshold_us;
>> +	b->offset_start = offset_start;
>> +	b->offset_stop  = offset_stop;
>> +
>> +	ret = kern_path(binpath, LOOKUP_FOLLOW, &b->path);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	if (!d_is_reg(b->path.dentry)) {
>> +		ret = -EINVAL;
>> +		goto err_path;
>> +	}
>> +
>> +	/* Reject duplicate start offset for the same binary. */
>> +	list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
>> +		if (tmp_b->offset_start == offset_start &&
>> +		    tmp_b->path.dentry == b->path.dentry) {
>> +			ret = -EEXIST;
>> +			goto err_path;
>> +		}
>> +	}
>> +
>> +	/* Store canonical path for read-back and removal matching. */
>> +	canon = d_path(&b->path, pathbuf, sizeof(pathbuf));
>> +	if (IS_ERR(canon)) {
>> +		ret = PTR_ERR(canon);
>> +		goto err_path;
>> +	}
>> +	strscpy(b->binpath, canon, sizeof(b->binpath));
>> +
>> +	b->entry_uc.handler = tlob_uprobe_entry_handler;
>> +	b->stop_uc.handler  = tlob_uprobe_stop_handler;
>> +
>> +	inode = d_real_inode(b->path.dentry);
>> +
>> +	b->entry_uprobe = uprobe_register(inode, offset_start, 0, &b-
>>> entry_uc);
>> +	if (IS_ERR(b->entry_uprobe)) {
>> +		ret = PTR_ERR(b->entry_uprobe);
>> +		b->entry_uprobe = NULL;
>> +		goto err_path;
>> +	}
>> +
>> +	b->stop_uprobe = uprobe_register(inode, offset_stop, 0, &b->stop_uc);
>> +	if (IS_ERR(b->stop_uprobe)) {
>> +		ret = PTR_ERR(b->stop_uprobe);
>> +		b->stop_uprobe = NULL;
>> +		goto err_entry;
>> +	}
>> +
>> +	list_add_tail(&b->list, &tlob_uprobe_list);
>> +	return 0;
>> +
>> +err_entry:
>> +	uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
>> +	uprobe_unregister_sync();
>> +err_path:
>> +	path_put(&b->path);
>> +err_free:
>> +	kfree(b);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Remove the uprobe binding for (offset_start, binpath).
>> + * binpath is resolved to a dentry for comparison so symlinks are handled
>> + * correctly.  Called with tlob_uprobe_mutex held.
>> + */
>> +static void tlob_remove_uprobe_by_key(loff_t offset_start, const char
>> *binpath)
>> +{
>> +	struct tlob_uprobe_binding *b, *tmp;
>> +	struct path remove_path;
>> +
>> +	if (kern_path(binpath, LOOKUP_FOLLOW, &remove_path))
>> +		return;
>> +
>> +	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
>> +		if (b->offset_start != offset_start)
>> +			continue;
>> +		if (b->path.dentry != remove_path.dentry)
>> +			continue;
>> +		uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
>> +		uprobe_unregister_nosync(b->stop_uprobe,  &b->stop_uc);
>> +		list_del(&b->list);
>> +		uprobe_unregister_sync();
>> +		path_put(&b->path);
>> +		kfree(b);
>> +		break;
>> +	}
>> +
>> +	path_put(&remove_path);
>> +}
>> +
>> +/* Unregister all uprobe bindings; called from disable_tlob(). */
>> +static void tlob_remove_all_uprobes(void)
>> +{
>> +	struct tlob_uprobe_binding *b, *tmp;
>> +
>> +	mutex_lock(&tlob_uprobe_mutex);
>> +	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
>> +		uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
>> +		uprobe_unregister_nosync(b->stop_uprobe,  &b->stop_uc);
>> +		list_del(&b->list);
>> +		path_put(&b->path);
>> +		kfree(b);
>> +	}
>> +	mutex_unlock(&tlob_uprobe_mutex);
>> +	uprobe_unregister_sync();
>> +}
>> +
>> +/*
>> + * tracefs "monitor" file
>> + *
>> + * Read:  one "threshold_us:0xoffset_start:0xoffset_stop:binary_path\n"
>> + *        line per registered uprobe binding.
>> + * Write: "threshold_us:offset_start:offset_stop:binary_path" - add uprobe
>> binding
>> + *        "-offset_start:binary_path"                         - remove uprobe
>> binding
>> + */
>> +
>> +static ssize_t tlob_monitor_read(struct file *file,
>> +				 char __user *ubuf,
>> +				 size_t count, loff_t *ppos)
>> +{
>> +	/* pid(10) + threshold(20) + 2 offsets(2*18) + path(256) + delimiters
>> */
>> +	const int line_sz = TLOB_MAX_PATH + 72;
>> +	struct tlob_uprobe_binding *b;
>> +	char *buf, *p;
>> +	int n = 0, buf_sz, pos = 0;
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&tlob_uprobe_mutex);
>> +	list_for_each_entry(b, &tlob_uprobe_list, list)
>> +		n++;
>> +	mutex_unlock(&tlob_uprobe_mutex);
>> +
>> +	buf_sz = (n ? n : 1) * line_sz + 1;
>> +	buf = kmalloc(buf_sz, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&tlob_uprobe_mutex);
>> +	list_for_each_entry(b, &tlob_uprobe_list, list) {
>> +		p = b->binpath;
>> +		pos += scnprintf(buf + pos, buf_sz - pos,
>> +				 "%llu:0x%llx:0x%llx:%s\n",
>> +				 b->threshold_us,
>> +				 (unsigned long long)b->offset_start,
>> +				 (unsigned long long)b->offset_stop,
>> +				 p);
>> +	}
>> +	mutex_unlock(&tlob_uprobe_mutex);
>> +
>> +	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Parse "threshold_us:offset_start:offset_stop:binary_path".
>> + * binary_path comes last so it may freely contain ':'.
>> + * Returns 0 on success.
>> + */
>> +VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
>> +					    char **path_out,
>> +					    loff_t *start_out, loff_t
>> *stop_out)
>> +{
>> +	unsigned long long thr;
>> +	long long start, stop;
>> +	int n = 0;
>> +
>> +	/*
>> +	 * %llu : decimal-only (microseconds)
>> +	 * %lli : auto-base, accepts 0x-prefixed hex for offsets
>> +	 * %n   : records the byte offset of the first path character
>> +	 */
>> +	if (sscanf(buf, "%llu:%lli:%lli:%n", &thr, &start, &stop, &n) != 3)
>> +		return -EINVAL;
>> +	if (thr == 0 || n == 0 || buf[n] == '\0')
>> +		return -EINVAL;
>> +	if (start < 0 || stop < 0)
>> +		return -EINVAL;
>> +
>> +	*thr_out   = thr;
>> +	*start_out = start;
>> +	*stop_out  = stop;
>> +	*path_out  = buf + n;
>> +	return 0;
>> +}
>> +
>> +static ssize_t tlob_monitor_write(struct file *file,
>> +				  const char __user *ubuf,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	char buf[TLOB_MAX_PATH + 64];
>> +	loff_t offset_start, offset_stop;
>> +	u64 threshold_us;
>> +	char *binpath;
>> +	int ret;
>> +
>> +	if (count >= sizeof(buf))
>> +		return -EINVAL;
>> +	if (copy_from_user(buf, ubuf, count))
>> +		return -EFAULT;
>> +	buf[count] = '\0';
>> +
>> +	if (count > 0 && buf[count - 1] == '\n')
>> +		buf[count - 1] = '\0';
>> +
>> +	/* Remove request: "-offset_start:binary_path" */
>> +	if (buf[0] == '-') {
>> +		long long off;
>> +		int n = 0;
>> +
>> +		if (sscanf(buf + 1, "%lli:%n", &off, &n) != 1 || n == 0)
>> +			return -EINVAL;
>> +		binpath = buf + 1 + n;
>> +		if (binpath[0] != '/')
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&tlob_uprobe_mutex);
>> +		tlob_remove_uprobe_by_key((loff_t)off, binpath);
>> +		mutex_unlock(&tlob_uprobe_mutex);
>> +
>> +		return (ssize_t)count;
>> +	}
>> +
>> +	/*
>> +	 * Uprobe binding:
>> "threshold_us:offset_start:offset_stop:binary_path"
>> +	 * binpath points into buf at the start of the path field.
>> +	 */
>> +	ret = tlob_parse_uprobe_line(buf, &threshold_us,
>> +				     &binpath, &offset_start, &offset_stop);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&tlob_uprobe_mutex);
>> +	ret = tlob_add_uprobe(threshold_us, binpath, offset_start,
>> offset_stop);
>> +	mutex_unlock(&tlob_uprobe_mutex);
>> +	return ret ? ret : (ssize_t)count;
>> +}
>> +
>> +static const struct file_operations tlob_monitor_fops = {
>> +	.open	= simple_open,
>> +	.read	= tlob_monitor_read,
>> +	.write	= tlob_monitor_write,
>> +	.llseek	= noop_llseek,
>> +};
>> +
>> +/*
>> + * __tlob_init_monitor / __tlob_destroy_monitor - called with
>> rv_interface_lock
>> + * held (required by da_monitor_init/destroy via
>> rv_get/put_task_monitor_slot).
>> + */
>> +static int __tlob_init_monitor(void)
>> +{
>> +	int i, retval;
>> +
>> +	tlob_state_cache = kmem_cache_create("tlob_task_state",
>> +					     sizeof(struct tlob_task_state),
>> +					     0, 0, NULL);
>> +	if (!tlob_state_cache)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < TLOB_HTABLE_SIZE; i++)
>> +		INIT_HLIST_HEAD(&tlob_htable[i]);
>> +	atomic_set(&tlob_num_monitored, 0);
>> +
>> +	retval = da_monitor_init();
>> +	if (retval) {
>> +		kmem_cache_destroy(tlob_state_cache);
>> +		tlob_state_cache = NULL;
>> +		return retval;
>> +	}
>> +
>> +	rv_this.enabled = 1;
>> +	return 0;
>> +}
>> +
>> +static void __tlob_destroy_monitor(void)
>> +{
>> +	rv_this.enabled = 0;
>> +	tlob_stop_all();
>> +	tlob_remove_all_uprobes();
>> +	/*
>> +	 * Drain pending call_rcu() callbacks from tlob_stop_all() before
>> +	 * destroying the kmem_cache.
>> +	 */
>> +	synchronize_rcu();
>> +	da_monitor_destroy();
>> +	kmem_cache_destroy(tlob_state_cache);
>> +	tlob_state_cache = NULL;
>> +}
>> +
>> +/*
>> + * tlob_init_monitor / tlob_destroy_monitor - KUnit wrappers that acquire
>> + * rv_interface_lock, satisfying the lockdep_assert_held() inside
>> + * rv_get/put_task_monitor_slot().
>> + */
>> +VISIBLE_IF_KUNIT int tlob_init_monitor(void)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +	ret = __tlob_init_monitor();
>> +	mutex_unlock(&rv_interface_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(tlob_init_monitor);
>> +
>> +VISIBLE_IF_KUNIT void tlob_destroy_monitor(void)
>> +{
>> +	mutex_lock(&rv_interface_lock);
>> +	__tlob_destroy_monitor();
>> +	mutex_unlock(&rv_interface_lock);
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(tlob_destroy_monitor);
>> +
>> +VISIBLE_IF_KUNIT int tlob_enable_hooks(void)
>> +{
>> +	rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
>> +	rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(tlob_enable_hooks);
>> +
>> +VISIBLE_IF_KUNIT void tlob_disable_hooks(void)
>> +{
>> +	rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
>> +	rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(tlob_disable_hooks);
>> +
>> +/*
>> + * enable_tlob / disable_tlob - called by rv_enable/disable_monitor() which
>> + * already holds rv_interface_lock; call the __ variants directly.
>> + */
>> +static int enable_tlob(void)
>> +{
>> +	int retval;
>> +
>> +	retval = __tlob_init_monitor();
>> +	if (retval)
>> +		return retval;
>> +
>> +	return tlob_enable_hooks();
>> +}
>> +
>> +static void disable_tlob(void)
>> +{
>> +	tlob_disable_hooks();
>> +	__tlob_destroy_monitor();
>> +}
>> +
>> +static struct rv_monitor rv_this = {
>> +	.name		= "tlob",
>> +	.description	= "Per-task latency-over-budget monitor.",
>> +	.enable		= enable_tlob,
>> +	.disable	= disable_tlob,
>> +	.reset		= da_monitor_reset_all,
>> +	.enabled	= 0,
>> +};
>> +
>> +static int __init register_tlob(void)
>> +{
>> +	int ret;
>> +
>> +	ret = rv_register_monitor(&rv_this, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (rv_this.root_d) {
>> +		tracefs_create_file("monitor", 0644, rv_this.root_d, NULL,
>> +				    &tlob_monitor_fops);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit unregister_tlob(void)
>> +{
>> +	rv_unregister_monitor(&rv_this);
>> +}
>> +
>> +module_init(register_tlob);
>> +module_exit(unregister_tlob);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Wen Yang <wen.yang@linux.dev>");
>> +MODULE_DESCRIPTION("tlob: task latency over budget per-task monitor.");
>> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h
>> b/kernel/trace/rv/monitors/tlob/tlob.h
>> new file mode 100644
>> index 000000000..3438a6175
>> --- /dev/null
>> +++ b/kernel/trace/rv/monitors/tlob/tlob.h
>> @@ -0,0 +1,145 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _RV_TLOB_H
>> +#define _RV_TLOB_H
>> +
>> +/*
>> + * C representation of the tlob automaton, generated from tlob.dot via rvgen
>> + * and extended with tlob_start_task()/tlob_stop_task() declarations.
>> + * For the format description see
>> Documentation/trace/rv/deterministic_automata.rst
>> + */
>> +
>> +#include <linux/rv.h>
>> +#include <uapi/linux/rv.h>
>> +
>> +#define MONITOR_NAME tlob
>> +
>> +enum states_tlob {
>> +	unmonitored_tlob,
>> +	on_cpu_tlob,
>> +	off_cpu_tlob,
>> +	state_max_tlob,
>> +};
>> +
>> +#define INVALID_STATE state_max_tlob
>> +
>> +enum events_tlob {
>> +	trace_start_tlob,
>> +	switch_in_tlob,
>> +	switch_out_tlob,
>> +	sched_wakeup_tlob,
>> +	trace_stop_tlob,
>> +	budget_expired_tlob,
>> +	event_max_tlob,
>> +};
>> +
>> +struct automaton_tlob {
>> +	char *state_names[state_max_tlob];
>> +	char *event_names[event_max_tlob];
>> +	unsigned char function[state_max_tlob][event_max_tlob];
>> +	unsigned char initial_state;
>> +	bool final_states[state_max_tlob];
>> +};
>> +
>> +static const struct automaton_tlob automaton_tlob = {
>> +	.state_names = {
>> +		"unmonitored",
>> +		"on_cpu",
>> +		"off_cpu",
>> +	},
>> +	.event_names = {
>> +		"trace_start",
>> +		"switch_in",
>> +		"switch_out",
>> +		"sched_wakeup",
>> +		"trace_stop",
>> +		"budget_expired",
>> +	},
>> +	.function = {
>> +		/* unmonitored */
>> +		{
>> +			on_cpu_tlob,		/* trace_start    */
>> +			unmonitored_tlob,	/* switch_in      */
>> +			unmonitored_tlob,	/* switch_out     */
>> +			unmonitored_tlob,	/* sched_wakeup   */
>> +			INVALID_STATE,		/* trace_stop     */
>> +			INVALID_STATE,		/* budget_expired */
>> +		},
>> +		/* on_cpu */
>> +		{
>> +			INVALID_STATE,		/* trace_start    */
>> +			INVALID_STATE,		/* switch_in      */
>> +			off_cpu_tlob,		/* switch_out     */
>> +			on_cpu_tlob,		/* sched_wakeup   */
>> +			unmonitored_tlob,	/* trace_stop     */
>> +			unmonitored_tlob,	/* budget_expired */
>> +		},
>> +		/* off_cpu */
>> +		{
>> +			INVALID_STATE,		/* trace_start    */
>> +			on_cpu_tlob,		/* switch_in      */
>> +			off_cpu_tlob,		/* switch_out     */
>> +			off_cpu_tlob,		/* sched_wakeup   */
>> +			unmonitored_tlob,	/* trace_stop     */
>> +			unmonitored_tlob,	/* budget_expired */
>> +		},
>> +	},
>> +	/*
>> +	 * final_states: unmonitored is the sole accepting state.
>> +	 * Violations are recorded via ntf_push and tlob_budget_exceeded.
>> +	 */
>> +	.initial_state = unmonitored_tlob,
>> +	.final_states = { 1, 0, 0 },
>> +};
>> +
>> +/* Exported for use by the RV ioctl layer (rv_dev.c) */
>> +int tlob_start_task(struct task_struct *task, u64 threshold_us,
>> +		    struct file *notify_file, u64 tag);
>> +int tlob_stop_task(struct task_struct *task);
>> +
>> +/* Maximum number of concurrently monitored tasks (also used by KUnit). */
>> +#define TLOB_MAX_MONITORED	64U
>> +
>> +/*
>> + * Ring buffer constants (also published in UAPI for mmap size calculation).
>> + */
>> +#define TLOB_RING_DEFAULT_CAP	64U	/* records allocated at open()  */
>> +#define TLOB_RING_MIN_CAP	 8U	/* minimum accepted by mmap()   */
>> +#define TLOB_RING_MAX_CAP	4096U	/* maximum accepted by mmap()   */
>> +
>> +/**
>> + * struct tlob_ring - per-fd mmap-capable violation ring buffer.
>> + *
>> + * Allocated as a contiguous page range at rv_open() time:
>> + *   page 0:    struct tlob_mmap_page  (shared with userspace)
>> + *   pages 1-N: struct tlob_event[capacity]
>> + */
>> +struct tlob_ring {
>> +	struct tlob_mmap_page	*page;
>> +	struct tlob_event	*data;
>> +	u32			 mask;
>> +	spinlock_t		 lock;
>> +	unsigned long		 base;
>> +	unsigned int		 order;
>> +};
>> +
>> +/**
>> + * struct rv_file_priv - per-fd private data for /dev/rv.
>> + */
>> +struct rv_file_priv {
>> +	struct tlob_ring	ring;
>> +	wait_queue_head_t	waitq;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_KUNIT)
>> +int tlob_init_monitor(void);
>> +void tlob_destroy_monitor(void);
>> +int tlob_enable_hooks(void);
>> +void tlob_disable_hooks(void);
>> +void tlob_event_push_kunit(struct rv_file_priv *priv,
>> +			  const struct tlob_event *info);
>> +int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
>> +			   char **path_out,
>> +			   loff_t *start_out, loff_t *stop_out);
>> +#endif /* CONFIG_KUNIT */
>> +
>> +#endif /* _RV_TLOB_H */
>> diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h
>> b/kernel/trace/rv/monitors/tlob/tlob_trace.h
>> new file mode 100644
>> index 000000000..b08d67776
>> --- /dev/null
>> +++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Snippet to be included in rv_trace.h
>> + */
>> +
>> +#ifdef CONFIG_RV_MON_TLOB
>> +/*
>> + * tlob uses the generic event_da_monitor_id and error_da_monitor_id event
>> + * classes so that both event classes are instantiated.  This avoids a
>> + * -Werror=unused-variable warning that the compiler emits when a
>> + * DECLARE_EVENT_CLASS has no corresponding DEFINE_EVENT instance.
>> + *
>> + * The event_tlob tracepoint is defined here but the call-site in
>> + * da_handle_event() is overridden with a no-op macro below so that no
>> + * trace record is emitted on every scheduler context switch.  Budget
>> + * violations are reported via the dedicated tlob_budget_exceeded event.
>> + *
>> + * error_tlob IS kept active so that invalid DA transitions (programming
>> + * errors) are still visible in the ftrace ring buffer for debugging.
>> + */
>> +DEFINE_EVENT(event_da_monitor_id, event_tlob,
>> +	     TP_PROTO(int id, char *state, char *event, char *next_state,
>> +		      bool final_state),
>> +	     TP_ARGS(id, state, event, next_state, final_state));
>> +
>> +DEFINE_EVENT(error_da_monitor_id, error_tlob,
>> +	     TP_PROTO(int id, char *state, char *event),
>> +	     TP_ARGS(id, state, event));
>> +
>> +/*
>> + * Override the trace_event_tlob() call-site with a no-op after the
>> + * DEFINE_EVENT above has satisfied the event class instantiation
>> + * requirement.  The tracepoint symbol itself exists (and can be enabled
>> + * via tracefs) but the automatic call from da_handle_event() is silenced
>> + * to avoid per-context-switch ftrace noise during normal operation.
>> + */
>> +#undef trace_event_tlob
>> +#define trace_event_tlob(id, state, event, next_state, final_state)	\
>> +	do { (void)(id); (void)(state); (void)(event);			\
>> +	     (void)(next_state); (void)(final_state); } while (0)
>> +#endif /* CONFIG_RV_MON_TLOB */
>> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
>> index ee4e68102..e754e76d5 100644
>> --- a/kernel/trace/rv/rv.c
>> +++ b/kernel/trace/rv/rv.c
>> @@ -148,6 +148,10 @@
>>   #include <rv_trace.h>
>>   #endif
>>   
>> +#ifdef CONFIG_RV_MON_TLOB
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(tlob_budget_exceeded);
>> +#endif
>> +
>>   #include "rv.h"
>>   
>>   DEFINE_MUTEX(rv_interface_lock);
>> diff --git a/kernel/trace/rv/rv_dev.c b/kernel/trace/rv/rv_dev.c
>> new file mode 100644
>> index 000000000..a052f3203
>> --- /dev/null
>> +++ b/kernel/trace/rv/rv_dev.c
>> @@ -0,0 +1,602 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * rv_dev.c - /dev/rv misc device for RV monitor self-instrumentation
>> + *
>> + * A single misc device (MISC_DYNAMIC_MINOR) serves all RV monitors.
>> + * ioctl numbers encode the monitor identity:
>> + *
>> + *   0x01 - 0x1F  tlob (task latency over budget)
>> + *   0x20 - 0x3F  reserved
>> + *
>> + * Each monitor exports tlob_start_task() / tlob_stop_task() which are
>> + * called here.  The calling task is identified by current.
>> + *
>> + * Magic: RV_IOC_MAGIC (0xB9), defined in include/uapi/linux/rv.h
>> + *
>> + * Per-fd private data (rv_file_priv)
>> + * ------------------------------------
>> + * Every open() of /dev/rv allocates an rv_file_priv (defined in tlob.h).
>> + * When TLOB_IOCTL_TRACE_START is called with args.notify_fd >= 0, violations
>> + * are pushed as tlob_event records into that fd's per-fd ring buffer
>> (tlob_ring)
>> + * and its poll/epoll waitqueue is woken.
>> + *
>> + * Consumers drain records with read() on the notify_fd; read() blocks until
>> + * at least one record is available (unless O_NONBLOCK is set).
>> + *
>> + * Per-thread "started" tracking (tlob_task_handle)
>> + * -------------------------------------------------
>> + * tlob_stop_task() returns -ESRCH in two distinct situations:
>> + *
>> + *   (a) The deadline timer already fired and removed the tlob hash-table
>> + *       entry before TRACE_STOP arrived -> budget was exceeded -> -EOVERFLOW
>> + *
>> + *   (b) TRACE_START was never called for this thread -> programming error
>> + *       -> -ESRCH
>> + *
>> + * To distinguish them, rv_dev.c maintains a lightweight hash table
>> + * (tlob_handles) that records a tlob_task_handle for every task_struct *
>> + * for which a successful TLOB_IOCTL_TRACE_START has been
>> + * issued but the corresponding TLOB_IOCTL_TRACE_STOP has not yet arrived.
>> + *
>> + * tlob_task_handle is a thin "session ticket"  --  it carries only the
>> + * task pointer and the owning file descriptor.  The heavy per-task state
>> + * (hrtimer, DA state, threshold) lives in tlob_task_state inside tlob.c.
>> + *
>> + * The table is keyed on task_struct * (same key as tlob.c), protected
>> + * by tlob_handles_lock (spinlock, irq-safe).  No get_task_struct()
>> + * refcount is needed here because tlob.c already holds a reference for
>> + * each live entry.
>> + *
>> + * Multiple threads may share the same fd.  Each thread has its own
>> + * tlob_task_handle in the table, so concurrent TRACE_START / TRACE_STOP
>> + * calls from different threads do not interfere.
>> + *
>> + * The fd release path (rv_release) calls tlob_stop_task() for every
>> + * handle in tlob_handles that belongs to the closing fd, ensuring cleanup
>> + * even if the user forgets to call TRACE_STOP.
>> + */
>> +#include <linux/file.h>
>> +#include <linux/fs.h>
>> +#include <linux/gfp.h>
>> +#include <linux/hash.h>
>> +#include <linux/mm.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/poll.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/uaccess.h>
>> +#include <uapi/linux/rv.h>
>> +
>> +#ifdef CONFIG_RV_MON_TLOB
>> +#include "monitors/tlob/tlob.h"
>> +#endif
>> +
>> +/* -----------------------------------------------------------------------
>> + * tlob_task_handle - per-thread session ticket for the ioctl interface
>> + *
>> + * One handle is allocated by TLOB_IOCTL_TRACE_START and freed by
>> + * TLOB_IOCTL_TRACE_STOP (or by rv_release if the fd is closed).
>> + *
>> + * @hlist:  Hash-table linkage in tlob_handles (keyed on task pointer).
>> + * @task:   The monitored thread.  Plain pointer; no refcount held here
>> + *          because tlob.c holds one for the lifetime of the monitoring
>> + *          window, which encompasses the lifetime of this handle.
>> + * @file:   The /dev/rv file descriptor that issued TRACE_START.
>> + *          Used by rv_release() to sweep orphaned handles on close().
>> + * -----------------------------------------------------------------------
>> + */
>> +#define TLOB_HANDLES_BITS	5
>> +#define TLOB_HANDLES_SIZE	(1 << TLOB_HANDLES_BITS)
>> +
>> +struct tlob_task_handle {
>> +	struct hlist_node	hlist;
>> +	struct task_struct	*task;
>> +	struct file		*file;
>> +};
>> +
>> +static struct hlist_head tlob_handles[TLOB_HANDLES_SIZE];
>> +static DEFINE_SPINLOCK(tlob_handles_lock);
>> +
>> +static unsigned int tlob_handle_hash(const struct task_struct *task)
>> +{
>> +	return hash_ptr((void *)task, TLOB_HANDLES_BITS);
>> +}
>> +
>> +/* Must be called with tlob_handles_lock held. */
>> +static struct tlob_task_handle *
>> +tlob_handle_find_locked(struct task_struct *task)
>> +{
>> +	struct tlob_task_handle *h;
>> +	unsigned int slot = tlob_handle_hash(task);
>> +
>> +	hlist_for_each_entry(h, &tlob_handles[slot], hlist) {
>> +		if (h->task == task)
>> +			return h;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * tlob_handle_alloc - record that @task has an active monitoring session
>> + *                     opened via @file.
>> + *
>> + * Returns 0 on success, -EEXIST if @task already has a handle (double
>> + * TRACE_START without TRACE_STOP), -ENOMEM on allocation failure.
>> + */
>> +static int tlob_handle_alloc(struct task_struct *task, struct file *file)
>> +{
>> +	struct tlob_task_handle *h;
>> +	unsigned long flags;
>> +	unsigned int slot;
>> +
>> +	h = kmalloc(sizeof(*h), GFP_KERNEL);
>> +	if (!h)
>> +		return -ENOMEM;
>> +	h->task = task;
>> +	h->file = file;
>> +
>> +	spin_lock_irqsave(&tlob_handles_lock, flags);
>> +	if (tlob_handle_find_locked(task)) {
>> +		spin_unlock_irqrestore(&tlob_handles_lock, flags);
>> +		kfree(h);
>> +		return -EEXIST;
>> +	}
>> +	slot = tlob_handle_hash(task);
>> +	hlist_add_head(&h->hlist, &tlob_handles[slot]);
>> +	spin_unlock_irqrestore(&tlob_handles_lock, flags);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * tlob_handle_free - remove the handle for @task and free it.
>> + *
>> + * Returns 1 if a handle existed (TRACE_START was called), 0 if not found
>> + * (TRACE_START was never called for this thread).
>> + */
>> +static int tlob_handle_free(struct task_struct *task)
>> +{
>> +	struct tlob_task_handle *h;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&tlob_handles_lock, flags);
>> +	h = tlob_handle_find_locked(task);
>> +	if (h) {
>> +		hlist_del_init(&h->hlist);
>> +		spin_unlock_irqrestore(&tlob_handles_lock, flags);
>> +		kfree(h);
>> +		return 1;
>> +	}
>> +	spin_unlock_irqrestore(&tlob_handles_lock, flags);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * tlob_handle_sweep_file - release all handles owned by @file.
>> + *
>> + * Called from rv_release() when the fd is closed without TRACE_STOP.
>> + * Calls tlob_stop_task() for each orphaned handle to drain the tlob
>> + * monitoring entries and prevent resource leaks in tlob.c.
>> + *
>> + * Handles are collected under the lock (short critical section), then
>> + * processed outside it (tlob_stop_task() may sleep/spin internally).
>> + */
>> +#ifdef CONFIG_RV_MON_TLOB
>> +static void tlob_handle_sweep_file(struct file *file)
>> +{
>> +	struct tlob_task_handle *batch[TLOB_HANDLES_SIZE];
>> +	struct tlob_task_handle *h;
>> +	struct hlist_node *tmp;
>> +	unsigned long flags;
>> +	int i, n = 0;
>> +
>> +	spin_lock_irqsave(&tlob_handles_lock, flags);
>> +	for (i = 0; i < TLOB_HANDLES_SIZE; i++) {
>> +		hlist_for_each_entry_safe(h, tmp, &tlob_handles[i], hlist) {
>> +			if (h->file == file) {
>> +				hlist_del_init(&h->hlist);
>> +				batch[n++] = h;
>> +			}
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&tlob_handles_lock, flags);
>> +
>> +	for (i = 0; i < n; i++) {
>> +		/*
>> +		 * Ignore -ESRCH: the deadline timer may have already fired
>> +		 * and cleaned up the tlob entry.
>> +		 */
>> +		tlob_stop_task(batch[i]->task);
>> +		kfree(batch[i]);
>> +	}
>> +}
>> +#else
>> +static inline void tlob_handle_sweep_file(struct file *file) {}
>> +#endif /* CONFIG_RV_MON_TLOB */
>> +
>> +/* -----------------------------------------------------------------------
>> + * Ring buffer lifecycle
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +/*
>> + * tlob_ring_alloc - allocate a ring of @cap records (must be a power of 2).
>> + *
>> + * Allocates a physically contiguous block of pages:
>> + *   page 0     : struct tlob_mmap_page  (control page, shared with
>> userspace)
>> + *   pages 1..N : struct tlob_event[cap] (data pages)
>> + *
>> + * Each page is marked reserved so it can be mapped to userspace via mmap().
>> + */
>> +static int tlob_ring_alloc(struct tlob_ring *ring, u32 cap)
>> +{
>> +	unsigned int total = PAGE_SIZE + cap * sizeof(struct tlob_event);
>> +	unsigned int order = get_order(total);
>> +	unsigned long base;
>> +	unsigned int i;
>> +
>> +	base = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> +	if (!base)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < (1u << order); i++)
>> +		SetPageReserved(virt_to_page((void *)(base + i *
>> PAGE_SIZE)));
>> +
>> +	ring->base  = base;
>> +	ring->order = order;
>> +	ring->page  = (struct tlob_mmap_page *)base;
>> +	ring->data  = (struct tlob_event *)(base + PAGE_SIZE);
>> +	ring->mask  = cap - 1;
>> +	spin_lock_init(&ring->lock);
>> +
>> +	ring->page->capacity    = cap;
>> +	ring->page->version     = 1;
>> +	ring->page->data_offset = PAGE_SIZE;
>> +	ring->page->record_size = sizeof(struct tlob_event);
>> +	return 0;
>> +}
>> +
>> +static void tlob_ring_free(struct tlob_ring *ring)
>> +{
>> +	unsigned int i;
>> +
>> +	if (!ring->base)
>> +		return;
>> +
>> +	for (i = 0; i < (1u << ring->order); i++)
>> +		ClearPageReserved(virt_to_page((void *)(ring->base + i *
>> PAGE_SIZE)));
>> +
>> +	free_pages(ring->base, ring->order);
>> +	ring->base = 0;
>> +	ring->page = NULL;
>> +	ring->data = NULL;
>> +}
>> +
>> +/* -----------------------------------------------------------------------
>> + * File operations
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +static int rv_open(struct inode *inode, struct file *file)
>> +{
>> +	struct rv_file_priv *priv;
>> +	int ret;
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	ret = tlob_ring_alloc(&priv->ring, TLOB_RING_DEFAULT_CAP);
>> +	if (ret) {
>> +		kfree(priv);
>> +		return ret;
>> +	}
>> +
>> +	init_waitqueue_head(&priv->waitq);
>> +	file->private_data = priv;
>> +	return 0;
>> +}
>> +
>> +static int rv_release(struct inode *inode, struct file *file)
>> +{
>> +	struct rv_file_priv *priv = file->private_data;
>> +
>> +	tlob_handle_sweep_file(file);
>> +	tlob_ring_free(&priv->ring);
>> +	kfree(priv);
>> +	file->private_data = NULL;
>> +	return 0;
>> +}
>> +
>> +static __poll_t rv_poll(struct file *file, poll_table *wait)
>> +{
>> +	struct rv_file_priv *priv = file->private_data;
>> +
>> +	if (!priv)
>> +		return EPOLLERR;
>> +
>> +	poll_wait(file, &priv->waitq, wait);
>> +
>> +	/*
>> +	 * Pairs with smp_store_release(&ring->page->data_head, ...) in
>> +	 * tlob_event_push().  No lock needed: head is written by the kernel
>> +	 * producer and read here; tail is written by the consumer and we
>> only
>> +	 * need an approximate check for the poll fast path.
>> +	 */
>> +	if (smp_load_acquire(&priv->ring.page->data_head) !=
>> +	    READ_ONCE(priv->ring.page->data_tail))
>> +		return EPOLLIN | EPOLLRDNORM;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * rv_read - consume tlob_event violation records from this fd's ring buffer.
>> + *
>> + * Each read() returns a whole number of struct tlob_event records.  @count
>> must
>> + * be at least sizeof(struct tlob_event); partial-record sizes are rejected
>> with
>> + * -EINVAL.
>> + *
>> + * Blocking behaviour follows O_NONBLOCK on the fd:
>> + *   O_NONBLOCK clear: blocks until at least one record is available.
>> + *   O_NONBLOCK set:   returns -EAGAIN immediately if the ring is empty.
>> + *
>> + * Returns the number of bytes copied (always a multiple of sizeof
>> tlob_event),
>> + * -EAGAIN if non-blocking and empty, or a negative error code.
>> + *
>> + * read() and mmap() share the same ring and data_tail cursor; do not use
>> + * both simultaneously on the same fd.
>> + */
>> +static ssize_t rv_read(struct file *file, char __user *buf, size_t count,
>> +		       loff_t *ppos)
>> +{
>> +	struct rv_file_priv *priv = file->private_data;
>> +	struct tlob_ring *ring;
>> +	size_t rec = sizeof(struct tlob_event);
>> +	unsigned long irqflags;
>> +	ssize_t done = 0;
>> +	int ret;
>> +
>> +	if (!priv)
>> +		return -ENODEV;
>> +
>> +	ring = &priv->ring;
>> +
>> +	if (count < rec)
>> +		return -EINVAL;
>> +
>> +	/* Blocking path: sleep until the producer advances data_head. */
>> +	if (!(file->f_flags & O_NONBLOCK)) {
>> +		ret = wait_event_interruptible(priv->waitq,
>> +			/* pairs with smp_store_release() in the producer */
>> +			smp_load_acquire(&ring->page->data_head) !=
>> +			READ_ONCE(ring->page->data_tail));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/*
>> +	 * Drain records into the caller's buffer.  ring->lock serialises
>> +	 * concurrent read() callers and the softirq producer.
>> +	 */
>> +	while (done + rec <= count) {
>> +		struct tlob_event record;
>> +		u32 head, tail;
>> +
>> +		spin_lock_irqsave(&ring->lock, irqflags);
>> +		/* pairs with smp_store_release() in the producer */
>> +		head = smp_load_acquire(&ring->page->data_head);
>> +		tail = ring->page->data_tail;
>> +		if (head == tail) {
>> +			spin_unlock_irqrestore(&ring->lock, irqflags);
>> +			break;
>> +		}
>> +		record = ring->data[tail & ring->mask];
>> +		WRITE_ONCE(ring->page->data_tail, tail + 1);
>> +		spin_unlock_irqrestore(&ring->lock, irqflags);
>> +
>> +		if (copy_to_user(buf + done, &record, rec))
>> +			return done ? done : -EFAULT;
>> +		done += rec;
>> +	}
>> +
>> +	return done ? done : -EAGAIN;
>> +}
>> +
>> +/*
>> + * rv_mmap - map the per-fd violation ring buffer into userspace.
>> + *
>> + * The mmap region covers the full ring allocation:
>> + *
>> + *   offset 0          : struct tlob_mmap_page  (control page)
>> + *   offset PAGE_SIZE  : struct tlob_event[capacity]  (data pages)
>> + *
>> + * The caller must map exactly PAGE_SIZE + capacity * sizeof(struct
>> tlob_event)
>> + * bytes starting at offset 0 (vm_pgoff must be 0).  The actual capacity is
>> + * read from tlob_mmap_page.capacity after a successful mmap(2).
>> + *
>> + * Private mappings (MAP_PRIVATE) are rejected: the shared data_tail field
>> + * written by userspace must be visible to the kernel producer.
>> + */
>> +static int rv_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct rv_file_priv *priv = file->private_data;
>> +	struct tlob_ring    *ring;
>> +	unsigned long        size = vma->vm_end - vma->vm_start;
>> +	unsigned long        ring_size;
>> +
>> +	if (!priv)
>> +		return -ENODEV;
>> +
>> +	ring = &priv->ring;
>> +
>> +	if (vma->vm_pgoff != 0)
>> +		return -EINVAL;
>> +
>> +	ring_size = PAGE_ALIGN(PAGE_SIZE + ((unsigned long)(ring->mask + 1) *
>> +					    sizeof(struct tlob_event)));
>> +	if (size != ring_size)
>> +		return -EINVAL;
>> +
>> +	if (!(vma->vm_flags & VM_SHARED))
>> +		return -EINVAL;
>> +
>> +	return remap_pfn_range(vma, vma->vm_start,
>> +			       page_to_pfn(virt_to_page((void *)ring->base)),
>> +			       ring_size, vma->vm_page_prot);
>> +}
>> +
>> +/* -----------------------------------------------------------------------
>> + * ioctl dispatcher
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +static long rv_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>> +{
>> +	unsigned int nr = _IOC_NR(cmd);
>> +
>> +	/*
>> +	 * Verify the magic byte so we don't accidentally handle ioctls
>> +	 * intended for a different device.
>> +	 */
>> +	if (_IOC_TYPE(cmd) != RV_IOC_MAGIC)
>> +		return -ENOTTY;
>> +
>> +#ifdef CONFIG_RV_MON_TLOB
>> +	/* tlob: ioctl numbers 0x01 - 0x1F */
>> +	switch (cmd) {
>> +	case TLOB_IOCTL_TRACE_START: {
>> +		struct tlob_start_args args;
>> +		struct file *notify_file = NULL;
>> +		int ret, hret;
>> +
>> +		if (copy_from_user(&args,
>> +				   (struct tlob_start_args __user *)arg,
>> +				   sizeof(args)))
>> +			return -EFAULT;
>> +		if (args.threshold_us == 0)
>> +			return -EINVAL;
>> +		if (args.flags != 0)
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * If notify_fd >= 0, resolve it to a file pointer.
>> +		 * fget() bumps the reference count; tlob.c drops it
>> +		 * via fput() when the monitoring window ends.
>> +		 * Reject non-/dev/rv fds to prevent type confusion.
>> +		 */
>> +		if (args.notify_fd >= 0) {
>> +			notify_file = fget(args.notify_fd);
>> +			if (!notify_file)
>> +				return -EBADF;
>> +			if (notify_file->f_op != file->f_op) {
>> +				fput(notify_file);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		ret = tlob_start_task(current, args.threshold_us,
>> +				      notify_file, args.tag);
>> +		if (ret != 0) {
>> +			/* tlob.c did not take ownership; drop ref. */
>> +			if (notify_file)
>> +				fput(notify_file);
>> +			return ret;
>> +		}
>> +
>> +		/*
>> +		 * Record session handle.  Free any stale handle left by
>> +		 * a previous window whose deadline timer fired (timer
>> +		 * removes tlob_task_state but cannot touch tlob_handles).
>> +		 */
>> +		tlob_handle_free(current);
>> +		hret = tlob_handle_alloc(current, file);
>> +		if (hret < 0) {
>> +			tlob_stop_task(current);
>> +			return hret;
>> +		}
>> +		return 0;
>> +	}
>> +	case TLOB_IOCTL_TRACE_STOP: {
>> +		int had_handle;
>> +		int ret;
>> +
>> +		/*
>> +		 * Atomically remove the session handle for current.
>> +		 *
>> +		 *   had_handle == 0: TRACE_START was never called for
>> +		 *                    this thread -> caller bug -> -ESRCH
>> +		 *
>> +		 *   had_handle == 1: TRACE_START was called.  If
>> +		 *                    tlob_stop_task() now returns
>> +		 *                    -ESRCH, the deadline timer already
>> +		 *                    fired -> budget exceeded -> -EOVERFLOW
>> +		 */
>> +		had_handle = tlob_handle_free(current);
>> +		if (!had_handle)
>> +			return -ESRCH;
>> +
>> +		ret = tlob_stop_task(current);
>> +		return (ret == -ESRCH) ? -EOVERFLOW : ret;
>> +	}
>> +	default:
>> +		break;
>> +	}
>> +#endif /* CONFIG_RV_MON_TLOB */
>> +
>> +	return -ENOTTY;
>> +}
>> +
>> +/* -----------------------------------------------------------------------
>> + * Module init / exit
>> + * -----------------------------------------------------------------------
>> + */
>> +
>> +static const struct file_operations rv_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= rv_open,
>> +	.release	= rv_release,
>> +	.read		= rv_read,
>> +	.poll		= rv_poll,
>> +	.mmap		= rv_mmap,
>> +	.unlocked_ioctl	= rv_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl	= rv_ioctl,
>> +#endif
>> +	.llseek		= noop_llseek,
>> +};
>> +
>> +/*
>> + * 0666: /dev/rv is a self-instrumentation device.  All ioctls operate
>> + * exclusively on the calling task (current); no task can monitor another
>> + * via this interface.  Opening the device does not grant any privilege
>> + * beyond observing one's own latency, so world-read/write is appropriate.
>> + */
>> +static struct miscdevice rv_miscdev = {
>> +	.minor	= MISC_DYNAMIC_MINOR,
>> +	.name	= "rv",
>> +	.fops	= &rv_fops,
>> +	.mode	= 0666,
>> +};
>> +
>> +static int __init rv_ioctl_init(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < TLOB_HANDLES_SIZE; i++)
>> +		INIT_HLIST_HEAD(&tlob_handles[i]);
>> +
>> +	return misc_register(&rv_miscdev);
>> +}
>> +
>> +static void __exit rv_ioctl_exit(void)
>> +{
>> +	misc_deregister(&rv_miscdev);
>> +}
>> +
>> +module_init(rv_ioctl_init);
>> +module_exit(rv_ioctl_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("RV ioctl interface via /dev/rv");
>> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
>> index 4a6faddac..65d6c6485 100644
>> --- a/kernel/trace/rv/rv_trace.h
>> +++ b/kernel/trace/rv/rv_trace.h
>> @@ -126,6 +126,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
>>   #include <monitors/snroc/snroc_trace.h>
>>   #include <monitors/nrp/nrp_trace.h>
>>   #include <monitors/sssw/sssw_trace.h>
>> +#include <monitors/tlob/tlob_trace.h>
>>   // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
>>   
>>   #endif /* CONFIG_DA_MON_EVENTS_ID */
>> @@ -202,6 +203,55 @@ TRACE_EVENT(rv_retries_error,
>>   		__get_str(event), __get_str(name))
>>   );
>>   #endif /* CONFIG_RV_MON_MAINTENANCE_EVENTS */
>> +
>> +#ifdef CONFIG_RV_MON_TLOB
>> +/*
>> + * tlob_budget_exceeded - emitted when a monitored task exceeds its latency
>> + * budget.  Carries the on-CPU / off-CPU time breakdown so that the cause
>> + * of the overrun (CPU-bound vs. scheduling/I/O latency) is immediately
>> + * visible in the ftrace ring buffer without post-processing.
>> + */
>> +TRACE_EVENT(tlob_budget_exceeded,
>> +
>> +	TP_PROTO(struct task_struct *task, u64 threshold_us,
>> +		 u64 on_cpu_us, u64 off_cpu_us, u32 switches,
>> +		 bool state_is_on_cpu, u64 tag),
>> +
>> +	TP_ARGS(task, threshold_us, on_cpu_us, off_cpu_us, switches,
>> +		state_is_on_cpu, tag),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(comm,		task->comm)
>> +		__field(pid_t,		pid)
>> +		__field(u64,		threshold_us)
>> +		__field(u64,		on_cpu_us)
>> +		__field(u64,		off_cpu_us)
>> +		__field(u32,		switches)
>> +		__field(bool,		state_is_on_cpu)
>> +		__field(u64,		tag)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(comm);
>> +		__entry->pid		= task->pid;
>> +		__entry->threshold_us	= threshold_us;
>> +		__entry->on_cpu_us	= on_cpu_us;
>> +		__entry->off_cpu_us	= off_cpu_us;
>> +		__entry->switches	= switches;
>> +		__entry->state_is_on_cpu = state_is_on_cpu;
>> +		__entry->tag		= tag;
>> +	),
>> +
>> +	TP_printk("%s[%d]: budget exceeded threshold=%llu on_cpu=%llu
>> off_cpu=%llu switches=%u state=%s tag=0x%016llx",
>> +		__get_str(comm), __entry->pid,
>> +		__entry->threshold_us,
>> +		__entry->on_cpu_us, __entry->off_cpu_us,
>> +		__entry->switches,
>> +		__entry->state_is_on_cpu ? "on_cpu" : "off_cpu",
>> +		__entry->tag)
>> +);
>> +#endif /* CONFIG_RV_MON_TLOB */
>> +
>>   #endif /* _TRACE_RV_H */
>>   
>>   /* This part must be outside protection */
> 
