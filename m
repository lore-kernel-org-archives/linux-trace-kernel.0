Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442D2F2619
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848890; cv=none; b=Mzi8akxRNDRoch+9P0Rv1MC62vZMrHX3953MwQ7i1PIQnexvyX8wAAvmyR8/wfRUuE2tXHlfmlwR0ugpxPDY2Uy1jhRStz30nFN9Qf0AGn0EyY+u3FYkzja4pw1kaowptinYfecHUzdzIdnHSb3GqdEiDhotFFcYd+kG6RU9Tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848890; c=relaxed/simple;
	bh=cAIrCu+6kxRFUa6KFwBiM5npVeEBHPxsrWWrguScXZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l03A5sv1/QRiHV98PHl31/bp0Wha1nCWF/4rOzMd2wc0FsMmbmx5rmM3iTiz4QdymSxuPadU06tvmz5o3uZslx1TATHiZ5KpwwUWODFtKvcLPhmR6uNVCqFifLTfTwvk6SxY6zlqOuQCyf6F/fHAs+QHYXSlWu4eGzU8ikNMLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3zQSMCy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3zQSMCy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNPlRA0izmccyvc+Wf/j9i2Yw/xYRld9Kbs1ok6SO0s=;
	b=G3zQSMCykxNXXhdpvcxXMKylgCingOsBsITCbkpcDoSuL+OUMRUWhkoYuthzCGgwIjJhtX
	2ydZjwWfBVjYSBvOX3A96vdPnPkfjzx6yAb96DtJdsMzgV1eBDC4Y5sesffITiKSIiXPBu
	sq4KReIjFOiVctSIdYbdBiSI6lk4TlE=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 6/9] rv/tlob: add tlob hybrid automaton monitor
Date: Mon,  8 Jun 2026 00:13:54 +0800
Message-Id: <629023dbcc4389fcc6ec46d88c98eb19aa0abc36.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add tlob (task latency over budget), a per-task hybrid automaton RV
monitor that tracks elapsed wall-clock time across a user-delimited
code section and emits error_env_tlob when the elapsed time exceeds a
configurable budget.

The monitor uses RV_MON_PER_OBJ with three states (running, waiting,
sleeping) driven by sched_switch and sched_wakeup tracepoints, and a
single clock invariant clk_elapsed < budget enforced by an hrtimer
(HRTIMER_MODE_REL_HARD).  On violation, detail_env_tlob provides a
per-state time breakdown (running_ns, waiting_ns, sleeping_ns).

Per-task state is managed via DA_ALLOC_POOL to avoid allocation on the
scheduler tracepoint path.  Uprobe pairs are registered through the
tracefs monitor file as "p PATH:OFFSET_START OFFSET_STOP threshold=NS".

Also adds ha_cancel_timer_sync() to ha_monitor.h, a blocking cancel
variant needed by tlob's stop_task path to ensure the hrtimer callback
has completed before the per-task monitor state is freed.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 Documentation/trace/rv/index.rst           |   1 +
 Documentation/trace/rv/monitor_tlob.rst    | 177 ++++
 kernel/trace/rv/Kconfig                    |   1 +
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/tlob/Kconfig      |  12 +
 kernel/trace/rv/monitors/tlob/tlob.c       | 968 +++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h       | 148 ++++
 kernel/trace/rv/monitors/tlob/tlob_trace.h |  49 ++
 kernel/trace/rv/rv_trace.h                 |   1 +
 9 files changed, 1358 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 29769f06bb0f..1501545b5f08 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -16,5 +16,6 @@ Runtime Verification
    monitor_wwnr.rst
    monitor_sched.rst
    monitor_rtapp.rst
+   monitor_tlob.rst
    monitor_stall.rst
    monitor_deadline.rst
diff --git a/Documentation/trace/rv/monitor_tlob.rst b/Documentation/trace/rv/monitor_tlob.rst
new file mode 100644
index 000000000000..c651272eab89
--- /dev/null
+++ b/Documentation/trace/rv/monitor_tlob.rst
@@ -0,0 +1,177 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Monitor tlob
+============
+
+- Name: tlob - task latency over budget
+- Type: per-object hybrid automaton (RV_MON_PER_OBJ)
+- Author: Wen Yang <wen.yang@linux.dev>
+
+Description
+-----------
+
+The tlob monitor tracks per-task elapsed wall-clock time (CLOCK_MONOTONIC,
+spanning running, waiting, and sleeping states) and reports a violation when
+the monitored task exceeds a configurable per-invocation budget threshold.
+
+The monitor implements a three-state hybrid automaton with a single clock
+environment variable ``clk_elapsed``.  The clock invariant
+``clk_elapsed < BUDGET_NS()`` is active in all three states; when it is
+violated the HA timer fires and the framework emits ``error_env_tlob``
+then calls ``da_monitor_reset()`` automatically::
+
+                  | (initial, via task_start)
+                  v
+           +--------------+
+           |   running    | <-----------+
+           +--------------+             |
+             |         |                |
+           sleep     preempt        switch_in
+             |         |                |
+             v         v                |
+        +---------+  +---------+        |
+        | sleeping|  | waiting | -------+
+        +---------+  +---------+
+             |            ^
+             +---wakeup---+
+
+  Key transitions:
+    running  --(sleep)------> sleeping   (task blocks waiting for a resource)
+    running  --(preempt)----> waiting    (task preempted, back in runqueue)
+    sleeping --(wakeup)-----> waiting    (resource available, enters runqueue)
+    waiting  --(switch_in)--> running    (scheduler picks task, back on CPU)
+
+  ``tlob_start_task()`` calls ``da_handle_start_run_event(task->pid, ws, start_tlob)``.
+  The ``start_tlob`` self-loop on the ``running`` state triggers
+  ``ha_setup_invariants()``, which resets ``clk_elapsed`` and arms the budget
+  timer automatically.  ``tlob_stop_task()`` cancels the HA timer synchronously
+  via ``ha_cancel_timer_sync()``, then calls ``da_monitor_reset()``.
+
+The non-running condition (monitor not yet started or reset after a
+stop/violation) is handled implicitly by the RV framework
+(``da_mon->monitoring == 0``) — it is not an explicit DA state.
+
+Per-task state lives in ``struct tlob_task_state`` which is stored as
+``monitor_target`` in the framework's ``da_monitor_storage``, indexed by
+pid.  The per-invocation ``threshold_ns`` is read via
+``ha_get_target(ha_mon)->threshold_ns`` inside the HA constraint functions,
+following the same pattern as the ``nomiss`` monitor.
+
+Usage
+-----
+
+tracefs interface (uprobe-based external monitoring)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``monitor`` tracefs file instruments an unmodified binary via uprobes.
+The format follows the ftrace ``uprobe_events`` convention (``PATH:OFFSET``
+for the probe location, ``key=value`` for configuration parameters)::
+
+  p PATH:OFFSET_START OFFSET_STOP threshold=NS
+
+The uprobe at ``OFFSET_START`` fires ``tlob_start_task()``; the uprobe at
+``OFFSET_STOP`` fires ``tlob_stop_task()``.  Both offsets are ELF file
+offsets of entry points in ``PATH``.  ``PATH`` may contain ``:``; the last
+``:`` in the ``PATH:OFFSET_START`` token is the separator.
+
+To remove a binding, use ``-PATH:OFFSET_START``::
+
+  echo 1 > /sys/kernel/tracing/rv/monitors/tlob/enable
+
+  echo "p /usr/bin/myapp:0x12a0 0x12f0 threshold=5000000" \
+      > /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+  # Remove a binding
+  echo "-/usr/bin/myapp:0x12a0" > /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+  # List registered bindings
+  cat /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+  # Read violations from the trace buffer
+  cat /sys/kernel/tracing/trace
+
+Violation tracepoints
+~~~~~~~~~~~~~~~~~~~~~
+
+Two tracepoints are emitted together on a budget violation:
+
+``error_env_tlob``
+  Standard HA clock-invariant tracepoint (emitted by the RV framework).
+  Fields: ``id`` (task pid), ``state``, ``event`` (``"budget_exceeded"``),
+  ``env`` (``"clk_elapsed"``).
+
+``detail_env_tlob``
+  Tlob-specific breakdown of elapsed time per DA state.
+  Fields: ``id`` (task pid), ``threshold_ns``, ``running_ns``,
+  ``waiting_ns``, ``sleeping_ns``.
+
+  Use ``detail_env_tlob`` to diagnose *which phase* consumed the budget:
+  high ``sleeping_ns`` indicates I/O latency; high ``waiting_ns`` indicates
+  scheduler pressure; high ``running_ns`` indicates a compute overrun.
+
+Example: correlate the two tracepoints to see the breakdown::
+
+  trace-cmd record -e error_env_tlob -e detail_env_tlob &
+  # ... run workload ...
+  trace-cmd report
+
+tracefs files
+~~~~~~~~~~~~~
+
+The following files are specific to tlob under
+``/sys/kernel/tracing/rv/monitors/tlob/``:
+
+``monitor`` (rw)
+  Write ``p PATH:OFFSET_START OFFSET_STOP threshold=NS``
+  to bind two entry uprobes.  Write ``-PATH:OFFSET_START`` to remove a
+  binding.  Read to list registered bindings in the same format.
+  See the `tracefs interface (uprobe-based external monitoring)`_ section above.
+
+Kernel API
+----------
+
+``tlob_start_task`` and ``tlob_stop_task`` are the implementation-level
+functions called by the uprobe entry/exit handlers; the interface is
+driven from userspace.
+
+.. kernel-doc:: kernel/trace/rv/monitors/tlob/tlob.c
+   :functions: tlob_start_task tlob_stop_task
+
+``tlob_start_task(task, threshold_ns)``
+  Begin monitoring *task* with a total latency budget of *threshold_ns*
+  nanoseconds.  Allocates per-task state, sets initial DA state to
+  ``running``, resets ``clk_elapsed``, and arms the HA budget timer.
+  Returns 0, -ENODEV (monitor disabled), -ERANGE (threshold out of range),
+  -EALREADY (already monitoring), -ENOSPC (at capacity), or -ENOMEM.
+
+``tlob_stop_task(task)``
+  Stop monitoring *task*.  Synchronously cancels the HA timer via
+  ``ha_cancel_timer_sync()``, checks ``da_monitoring()`` to determine outcome.
+  Returns 0 (clean stop, within budget), -EOVERFLOW (budget was exceeded),
+  -ESRCH (not monitored), or -EAGAIN (concurrent stop racing).
+
+Design notes
+------------
+
+Limitations:
+
+- The initial DA state is always ``running``, set by feeding the synthetic
+  event ``switch_in_tlob`` to ``da_handle_start_event()``.  Monitoring a non-current
+  task that is already in waiting or sleeping state at call time misclassifies
+  the first interval as ``running_ns``.
+- ``TASK_STOPPED`` and ``TASK_TRACED`` carry ``prev_state != 0`` and are
+  therefore counted as ``sleeping_ns``, indistinguishable from
+  I/O-blocked time.
+- ``sched_wakeup_new`` is not hooked.  In practice this is not an issue
+  because ``tlob_start_task`` is always called from a running context.
+
+Specification
+-------------
+
+Graphviz DOT file in tools/verification/models/tlob.dot.
+
+KUnit tests under ``kernel/trace/rv/monitors/tlob/tlob_kunit.c``
+(CONFIG_TLOB_KUNIT_TEST).
+
+User-space integration tests under ``tools/testing/selftests/verification/``
+(requires CONFIG_RV_MON_TLOB=y and root).
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e2e0033a00b9..ed2de31d0312 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -85,6 +85,7 @@ source "kernel/trace/rv/monitors/sleep/Kconfig"
 source "kernel/trace/rv/monitors/stall/Kconfig"
 source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
+source "kernel/trace/rv/monitors/tlob/Kconfig"
 # Add new deadline monitors here
 
 # Add new monitors here
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f139b904bea3..ae59e97f8682 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
+obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
 # Add new monitors here
 obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
new file mode 100644
index 000000000000..b29a375de228
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_TLOB
+	depends on RV && UPROBES && HIGH_RES_TIMERS
+	select HA_MON_EVENTS_ID
+	select RV_UPROBE
+	bool "tlob monitor"
+	help
+	  Enable the tlob (task latency over budget) hybrid-automaton RV
+	  monitor.  tlob tracks per-task elapsed wall-clock time across a
+	  user-delimited code section and emits error_env_tlob when the
+	  elapsed time exceeds a configurable per-invocation budget.
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
new file mode 100644
index 000000000000..d8e0c4794720
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -0,0 +1,968 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob: task latency over budget monitor
+ *
+ * Track the elapsed wall-clock time of a marked code path and detect when
+ * a monitored task exceeds its per-task latency budget.  CLOCK_MONOTONIC
+ * is used so both on-CPU and off-CPU time count toward the budget.
+ *
+ * On a budget violation, two tracepoints are emitted from the hrtimer
+ * callback: error_env_tlob signals the violation, and detail_env_tlob
+ * provides a per-state time breakdown (running_ns, waiting_ns, sleeping_ns)
+ * that pinpoints whether the overrun occurred in running, waiting, or sleeping state.
+ *
+ * The monitor uses RV_MON_PER_OBJ: per-task state (struct tlob_task_state)
+ * is stored as monitor_target in the framework's hash table.
+ *
+ * One HA clock invariant is enforced:
+ *   clk_elapsed < BUDGET_NS()   (active in all states)
+ *
+ * tlob_start_task() uses da_handle_start_run_event(start_tlob) to initialise
+ * the monitor: the DA framework sets the initial state and processes the start
+ * event, which resets clk_elapsed and arms the budget hrtimer via
+ * ha_setup_invariants().  The HA timer is cancelled synchronously by
+ * ha_cancel_timer_sync() in tlob_stop_task().
+ *
+ * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
+ */
+#include <linux/hrtimer.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/rv.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/tracefs.h>
+#include <kunit/visibility.h>
+#include <rv/instrumentation.h>
+#include <rv/rv_uprobe.h>
+#include "../../rv.h"
+
+#define MODULE_NAME "tlob"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+
+/*
+ * Per-task latency monitoring state.  One instance per monitoring window.
+ * Stored as monitor_target in da_monitor_storage; freed via call_rcu.
+ */
+struct tlob_task_state {
+	struct task_struct	*task;		/* via get_task_struct */
+	u64			threshold_ns;	/* budget in nanoseconds */
+
+	/* 1 = cleanup claimed; ha_setup_invariants won't restart the timer. */
+	atomic_t		stopping;
+
+	/* Serialises the ns accumulators; held briefly (hardirq-safe). */
+	raw_spinlock_t		entry_lock;
+	u64			running_ns;	/* time in running state  */
+	u64			waiting_ns;	/* time in waiting state  */
+	u64			sleeping_ns;	/* time in sleeping state */
+	ktime_t			last_ts;
+
+	struct rcu_head		rcu;		/* for call_rcu() teardown */
+};
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
+
+/* Type for da_monitor_storage.target; must be defined before the includes. */
+typedef struct tlob_task_state *monitor_target;
+
+/* Forward-declared so da_monitor_reset_hook works before ha_monitor.h. */
+static inline void tlob_reset_notify(struct da_monitor *da_mon);
+#define da_monitor_reset_hook tlob_reset_notify
+
+/* Override EVENT_NONE_LBL so the timer-fired violation shows "budget_exceeded". */
+#define EVENT_NONE_LBL "budget_exceeded"
+
+#include "tlob.h"
+
+/*
+ * DA_MON_POOL_SIZE must be defined HERE: after tlob.h (which defines
+ * TLOB_MAX_MONITORED) and before #include <rv/ha_monitor.h> (which
+ * transitively includes da_monitor.h and expands __da_monitor_init_pool
+ * using this macro).  Placing the define before tlob.h or after
+ * ha_monitor.h both cause a build error.
+ */
+#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
+
+/*
+ * Forward-declare tlob_extra_cleanup so the #define below is valid when
+ * da_monitor.h (included via ha_monitor.h) expands da_extra_cleanup inside
+ * da_monitor_destroy().  The full definition follows after ha_monitor.h.
+ */
+static inline void tlob_extra_cleanup(struct da_monitor *da_mon);
+#define da_extra_cleanup tlob_extra_cleanup
+
+#include <rv/ha_monitor.h>
+
+/*
+ * Called from da_monitor_reset() on both normal stop and hrtimer expiry.
+ * On violation (stopping==0), emits detail_env_tlob.
+ */
+static inline void tlob_reset_notify(struct da_monitor *da_mon)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+	struct tlob_task_state *ws;
+
+	ha_monitor_reset_env(da_mon);
+
+	ws = ha_get_target(ha_mon);
+	if (!ws)
+		return;
+
+	/*
+	 * Emit per-state breakdown on budget violation only.
+	 * stopping==0: timer callback owns this path (genuine overrun).
+	 * stopping==1: normal stop claimed ownership first; skip.
+	 */
+	if (!atomic_read(&ws->stopping)) {
+		unsigned int curr_state = READ_ONCE(da_mon->curr_state);
+		u64 running_ns, waiting_ns, sleeping_ns, partial_ns;
+		unsigned long flags;
+
+		/*
+		 * Snapshot accumulators; partial_ns covers curr_state time
+		 * not yet folded in (transition-out pending).
+		 */
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		partial_ns   = ktime_get_ns() - ktime_to_ns(ws->last_ts);
+		running_ns   = ws->running_ns  +
+			       (curr_state == running_tlob  ? partial_ns : 0);
+		waiting_ns   = ws->waiting_ns  +
+			       (curr_state == waiting_tlob  ? partial_ns : 0);
+		sleeping_ns  = ws->sleeping_ns +
+			       (curr_state == sleeping_tlob ? partial_ns : 0);
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+
+		trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_ns,
+				      running_ns, waiting_ns, sleeping_ns);
+	}
+}
+
+#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
+
+/* HA constraint functions (called by ha_monitor_handle_constraint) */
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env, u64 time_ns)
+{
+	if (env == clk_elapsed_tlob)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	return ENV_INVALID_VALUE;
+}
+
+/*
+ * ha_verify_invariants - clk_elapsed < BUDGET_NS must hold in all states.
+ *
+ * The invariant is uniform across running/waiting/sleeping; check it
+ * unconditionally rather than enumerating each state.
+ */
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns);
+}
+
+/*
+ * Convert invariant (deadline) to guard (reset anchor) on state transitions.
+ *
+ * The conversion is identical for every departing state; skip only self-loops.
+ */
+static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state != next_state)
+		ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+}
+
+/* No per-event guard conditions for tlob; invariants suffice. */
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	return true;
+}
+
+/*
+ * Arm or cancel the HA budget timer on state transitions.
+ *
+ * The timer must run in every monitored state (running/waiting/sleeping),
+ * so arm it whenever next_state is any of the three.  On a self-loop caused
+ * by a non-start event the timer is already running; skip the redundant
+ * restart.  On a true state change the old timer is implicitly superseded by
+ * the new ha_start_timer_ns() call.
+ *
+ * Guard on stopping: sched_switch events can arrive after ha_cancel_timer_sync,
+ * restarting the timer and triggering an ODEBUG "activate active" splat.
+ * The _acquire pairs with the cmpxchg_release in tlob_stop_task.
+ */
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != start_tlob)
+		return;
+
+	if (next_state < state_max_tlob) {
+		if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
+			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	} else {
+		ha_cancel_timer(ha_mon);
+	}
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	if (!ha_verify_invariants(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	ha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);
+
+	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
+
+	return true;
+}
+
+static struct kmem_cache *tlob_state_cache;
+
+/* Uprobe binding list; protected by tlob_uprobe_mutex. */
+static LIST_HEAD(tlob_uprobe_list);
+static DEFINE_MUTEX(tlob_uprobe_mutex);
+
+/* Serialises duplicate-check + da_handle_start_run_event() for the same pid. */
+static DEFINE_MUTEX(tlob_start_mutex);
+
+
+/* Per-uprobe-binding state: a start + stop probe pair for one binary region. */
+struct tlob_uprobe_binding {
+	struct list_head	list;
+	u64			threshold_ns;
+	char			binpath[TLOB_MAX_PATH];
+	loff_t			offset_start;
+	loff_t			offset_stop;
+	struct rv_uprobe	*start_probe;
+	struct rv_uprobe	*stop_probe;
+};
+
+/* RCU callback: free the slab once no readers remain. */
+static void tlob_free_rcu(struct rcu_head *head)
+{
+	struct tlob_task_state *ws =
+		container_of(head, struct tlob_task_state, rcu);
+	kmem_cache_free(tlob_state_cache, ws);
+}
+
+/*
+ * da_extra_cleanup - per-task teardown called by da_monitor_destroy().
+ *
+ * Claims cleanup ownership via CAS; cancels the budget timer; decrements the
+ * monitored-task counter; and schedules the slab free via call_rcu().
+ * Must run before da_monitor_reset() (i.e. before hash_del_rcu()) so that
+ * ha_cancel_timer_sync() can safely access the still-registered ha_monitor.
+ */
+static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+	struct tlob_task_state *ws = ha_get_target(ha_mon);
+
+	if (!ws)
+		return;
+
+	if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
+		return;
+
+	ha_cancel_timer_sync(ha_mon);
+	put_task_struct(ws->task);
+	call_rcu(&ws->rcu, tlob_free_rcu);
+}
+
+/*
+ * __tlob_acc - accumulate elapsed ns into one per-state counter.
+ *
+ * Looks up the task's tlob_task_state under RCU, adds the interval
+ * [ws->last_ts, now] to the field at @offset within the state struct,
+ * and updates last_ts.  Returns true if the task is monitored.
+ *
+ * entry_lock is a raw spinlock so this is safe from hardirq context.
+ */
+static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
+			       size_t offset)
+{
+	struct tlob_task_state *ws;
+	unsigned long flags;
+
+	scoped_guard(rcu) {
+		ws = da_get_target_by_id(task->pid);
+		if (!ws)
+			return false;
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		*(u64 *)((char *)ws + offset) += ktime_to_ns(ktime_sub(now, ws->last_ts));
+		ws->last_ts = now;
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+	}
+	return true;
+}
+
+/* Accumulate running_ns for prev; returns true if prev is monitored. */
+static inline bool tlob_acc_running(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, offsetof(struct tlob_task_state, running_ns));
+}
+
+/* Accumulate waiting_ns for next; returns true if next is monitored. */
+static inline bool tlob_acc_waiting(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, offsetof(struct tlob_task_state, waiting_ns));
+}
+
+/*
+ * handle_sched_switch - advance the DA on every context switch.
+ *
+ * Generates three DA events:
+ *   prev, prev_state != 0  -> sleep_tlob    (running -> sleeping)
+ *   prev, prev_state == 0  -> preempt_tlob  (running -> waiting)
+ *   next                   -> switch_in_tlob (waiting -> running)
+ *
+ * A single ktime_get() at handler entry is shared by both acc calls so that
+ * prev's running_ns and next's waiting_ns share the same context-switch
+ * timestamp; neither absorbs handler overhead into its accumulator.
+ *
+ * No waiting->sleeping edge exists: a task can only block voluntarily
+ * (call schedule()) while it is executing on CPU, which corresponds to
+ * the running DA state.  A task in the waiting state is TASK_RUNNING in
+ * kernel terms (on the runqueue) and cannot block itself.
+ *
+ * da_handle_event() is called unconditionally: it skips tasks that have no
+ * monitor entry in the hash table.
+ */
+static void handle_sched_switch(void *data, bool preempt_unused,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	ktime_t now = ktime_get();
+	bool prev_preempted = (prev_state == 0);
+
+	/*
+	 * No guard on tlob_num_monitored here: da_handle_event() internally
+	 * calls da_monitor_handling_event() which checks both rv_monitoring_on()
+	 * and da_monitoring(da_mon).  The hash lookup inside da_get_monitor()
+	 * simply returns NULL for unmonitored tasks, which is equally fast as
+	 * an atomic_read() guard.  By omitting the guard we avoid touching the
+	 * tlob_num_monitored cacheline on every global context-switch.
+	 */
+	if (tlob_acc_running(prev, now))
+		da_handle_event(prev->pid, NULL,
+				prev_preempted ? preempt_tlob : sleep_tlob);
+	if (tlob_acc_waiting(next, now))
+		da_handle_event(next->pid, NULL, switch_in_tlob);
+}
+
+/* Accumulate sleeping_ns on wakeup; returns true if task is monitored. */
+static inline bool tlob_acc_sleeping(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, offsetof(struct tlob_task_state, sleeping_ns));
+}
+
+/*
+ * handle_sched_wakeup - sleeping -> waiting transition.
+ *
+ * try_to_wake_up() skips TASK_RUNNING tasks, so this never fires for a
+ * task already in running or waiting state.
+ */
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	ktime_t now = ktime_get();
+
+	/* Same reasoning as handle_sched_switch: rely on hash-lookup fast path. */
+	if (tlob_acc_sleeping(p, now))
+		da_handle_event(p->pid, NULL, wakeup_tlob);
+}
+
+/*
+ * handle_sched_process_exit - clean up if a task exits without TRACE_STOP.
+ *
+ * Called in do_exit() context; the task still has a valid pid here.
+ * tlob_stop_task() returns -ESRCH if the task is not monitored, which is fine.
+ */
+static void handle_sched_process_exit(void *data, struct task_struct *p,
+				       bool group_dead)
+{
+	tlob_stop_task(p);
+}
+
+
+
+/**
+ * tlob_start_task - begin monitoring @task with budget @threshold_ns ns.
+ * @task:         Task to monitor; may be current or another task.
+ * @threshold_ns: Latency budget in nanoseconds (wall-clock; running + waiting + sleeping).
+ *                Must be in [1000, TLOB_MAX_THRESHOLD_NS].
+ *
+ * Returns 0, -ENODEV, -ERANGE, -EALREADY, -ENOMEM, or -ENOSPC.
+ */
+int tlob_start_task(struct task_struct *task, u64 threshold_ns)
+{
+	struct tlob_task_state *ws;
+
+	if (!da_monitor_enabled())
+		return -ENODEV;
+
+	if (threshold_ns < 1000 || threshold_ns > TLOB_MAX_THRESHOLD_NS)
+		return -ERANGE;
+
+	/* Serialise duplicate-check + pool-slot claim for the same pid. */
+	guard(mutex)(&tlob_start_mutex);
+
+	if (da_get_target_by_id(task->pid))
+		return -EALREADY;
+
+	ws = kmem_cache_zalloc(tlob_state_cache, GFP_KERNEL);
+	if (!ws)
+		return -ENOMEM;
+
+	ws->task = task;
+	get_task_struct(task);
+	ws->threshold_ns = threshold_ns;
+	ws->last_ts = ktime_get();
+	raw_spin_lock_init(&ws->entry_lock);
+
+	/*
+	 * da_handle_start_run_event() claims a pool slot via da_prepare_storage(),
+	 * initialises the monitor, and delivers start_tlob in one step: the
+	 * generated ha_setup_invariants() resets clk_elapsed and arms the timer.
+	 * Returns 0 if the pool is exhausted (-ENOSPC).
+	 */
+	if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
+		put_task_struct(task);
+		kmem_cache_free(tlob_state_cache, ws);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tlob_start_task);
+
+/**
+ * tlob_stop_task - stop monitoring @task.
+ * @task: Task to stop.
+ *
+ * CAS on ws->stopping (0->1) under RCU claims cleanup ownership;
+ * the winner cancels the timer synchronously and frees all resources.
+ *
+ * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
+ * or -EAGAIN (concurrent caller claimed cleanup).
+ */
+int tlob_stop_task(struct task_struct *task)
+{
+	struct da_monitor *da_mon;
+	struct ha_monitor *ha_mon;
+	struct tlob_task_state *ws;
+	bool budget_exceeded;
+
+	scoped_guard(rcu) {
+		ws = da_get_target_by_id(task->pid);
+		if (!ws)
+			return -ESRCH;
+
+		da_mon = da_get_monitor(task->pid, NULL);
+		if (unlikely(!da_mon)) {
+			/* ws in hash but da_mon gone; internal inconsistency. */
+			WARN_ON_ONCE(1);
+			return -ESRCH;
+		}
+
+		ha_mon = to_ha_monitor(da_mon);
+
+		/*
+		 * CAS (0->1) claims cleanup ownership under RCU (ws guaranteed valid).
+		 * _release pairs with atomic_read_acquire in ha_setup_invariants.
+		 */
+		if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
+			return -EAGAIN;
+	}
+
+	/* Wait for in-flight timer callback before reading da_monitoring. */
+	ha_cancel_timer_sync(ha_mon);
+
+	/* Timer fired first -> budget exceeded; otherwise reset normally. */
+	scoped_guard(rcu) {
+		budget_exceeded = !da_monitoring(da_mon);
+		if (!budget_exceeded)
+			da_monitor_reset(da_mon);
+	}
+	da_destroy_storage(task->pid);
+
+	put_task_struct(ws->task);
+	call_rcu(&ws->rcu, tlob_free_rcu);
+	return budget_exceeded ? -EOVERFLOW : 0;
+}
+EXPORT_SYMBOL_GPL(tlob_stop_task);
+
+
+static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_regs *regs,
+				     __u64 *data)
+{
+	struct tlob_uprobe_binding *b = p->priv;
+
+	tlob_start_task(current, b->threshold_ns);
+	return 0;
+}
+
+static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct pt_regs *regs,
+				    __u64 *data)
+{
+	tlob_stop_task(current);
+	return 0;
+}
+
+/*
+ * Register start + stop entry uprobes for a binding.
+ * Called with tlob_uprobe_mutex held.
+ */
+static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
+			   loff_t offset_start, loff_t offset_stop)
+{
+	struct tlob_uprobe_binding *b, *tmp_b;
+	char pathbuf[TLOB_MAX_PATH];
+	struct path path;
+	char *canon;
+	int ret;
+
+	if (binpath[0] != '/')
+		return -EINVAL;
+
+	b = kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	b->threshold_ns = threshold_ns;
+	b->offset_start = offset_start;
+	b->offset_stop  = offset_stop;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto err_free;
+
+	if (!d_is_reg(path.dentry)) {
+		ret = -EINVAL;
+		goto err_path;
+	}
+
+	/* Reject duplicate start offset for the same binary. */
+	list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
+		if (tmp_b->offset_start == offset_start &&
+		    tmp_b->start_probe->path.dentry == path.dentry) {
+			ret = -EEXIST;
+			goto err_path;
+		}
+	}
+
+	canon = d_path(&path, pathbuf, sizeof(pathbuf));
+	if (IS_ERR(canon)) {
+		ret = PTR_ERR(canon);
+		goto err_path;
+	}
+	strscpy(b->binpath, canon, sizeof(b->binpath));
+
+	/* Both probes share b (priv) and path; attach_path refs path itself. */
+	b->start_probe = rv_uprobe_attach_path(&path, offset_start,
+					       tlob_uprobe_entry_handler, NULL, b);
+	if (IS_ERR(b->start_probe)) {
+		ret = PTR_ERR(b->start_probe);
+		b->start_probe = NULL;
+		goto err_path;
+	}
+
+	b->stop_probe = rv_uprobe_attach_path(&path, offset_stop,
+					      tlob_uprobe_stop_handler, NULL, b);
+	if (IS_ERR(b->stop_probe)) {
+		ret = PTR_ERR(b->stop_probe);
+		b->stop_probe = NULL;
+		goto err_start;
+	}
+
+	path_put(&path);
+	list_add_tail(&b->list, &tlob_uprobe_list);
+	return 0;
+
+err_start:
+	rv_uprobe_detach(b->start_probe);
+err_path:
+	path_put(&path);
+err_free:
+	kfree(b);
+	return ret;
+}
+
+static int tlob_remove_uprobe_by_key(loff_t offset_start, const char *binpath)
+{
+	struct tlob_uprobe_binding *b, *tmp;
+	struct path remove_path;
+	int ret;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
+	if (ret)
+		return ret;
+
+	ret = -ENOENT;
+	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
+		if (b->offset_start != offset_start)
+			continue;
+		if (b->start_probe->path.dentry != remove_path.dentry)
+			continue;
+		list_del(&b->list);
+		rv_uprobe_detach(b->start_probe);
+		rv_uprobe_detach(b->stop_probe);
+		kfree(b);
+		ret = 0;
+		break;
+	}
+
+	path_put(&remove_path);
+	return ret;
+}
+
+static void tlob_remove_all_uprobes(void)
+{
+	struct tlob_uprobe_binding *b, *tmp;
+	LIST_HEAD(pending);
+
+	mutex_lock(&tlob_uprobe_mutex);
+	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
+		list_move(&b->list, &pending);
+		rv_uprobe_unregister_nosync(b->start_probe);
+		rv_uprobe_unregister_nosync(b->stop_probe);
+	}
+	mutex_unlock(&tlob_uprobe_mutex);
+
+	if (list_empty(&pending))
+		return;
+
+	/*
+	 * One global barrier for all probes dequeued above; no new handlers
+	 * for any of them can fire after this returns.
+	 */
+	rv_uprobe_sync();
+
+	list_for_each_entry_safe(b, tmp, &pending, list) {
+		rv_uprobe_free(b->start_probe);
+		rv_uprobe_free(b->stop_probe);
+		kfree(b);
+	}
+}
+
+static ssize_t tlob_monitor_read(struct file *file,
+				 char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	const int line_sz = TLOB_MAX_PATH + 128;
+	struct tlob_uprobe_binding *b;
+	char *buf, *p;
+	int n = 0, buf_sz, pos = 0;
+	ssize_t ret;
+
+	mutex_lock(&tlob_uprobe_mutex);
+	list_for_each_entry(b, &tlob_uprobe_list, list)
+		n++;
+
+	buf_sz = (n ? n : 1) * line_sz + 1;
+	buf = kmalloc(buf_sz, GFP_KERNEL);
+	if (!buf) {
+		mutex_unlock(&tlob_uprobe_mutex);
+		return -ENOMEM;
+	}
+
+	list_for_each_entry(b, &tlob_uprobe_list, list) {
+		p = b->binpath;
+		pos += scnprintf(buf + pos, buf_sz - pos,
+				 "p %s:0x%llx 0x%llx threshold=%llu\n",
+				 p,
+				 (unsigned long long)b->offset_start,
+				 (unsigned long long)b->offset_stop,
+				 b->threshold_ns);
+	}
+	mutex_unlock(&tlob_uprobe_mutex);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * Parse "p PATH:OFFSET_START OFFSET_STOP threshold=NS".
+ * PATH may contain ':'; the last ':' separates path from offset.
+ * Returns 0, -EINVAL, or -ERANGE.
+ */
+static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
+				  char **path_out,
+				  loff_t *start_out, loff_t *stop_out)
+{
+	unsigned long long thr = 0, stop_val = 0;
+	long long start_val;
+	char *p, *path_token, *token, *colon;
+	bool got_stop = false, got_thr = false;
+	int n;
+
+	/* Must start with "p " */
+	if (buf[0] != 'p' || buf[1] != ' ')
+		return -EINVAL;
+
+	p = buf + 2;
+	while (*p == ' ')
+		p++;
+
+	/* First space-delimited token is PATH:OFFSET_START */
+	path_token = strsep(&p, " \t");
+	if (!path_token || !*path_token)
+		return -EINVAL;
+
+	/* Split at last ':' to handle paths that contain ':'. */
+	colon = strrchr(path_token, ':');
+	if (!colon || colon - path_token < 2)
+		return -EINVAL;
+	*colon = '\0';
+
+	if (path_token[0] != '/')
+		return -EINVAL;
+
+	n = 0;
+	if (sscanf(colon + 1, "%lli%n", &start_val, &n) != 1 || n == 0)
+		return -EINVAL;
+	if (start_val < 0)
+		return -EINVAL;
+
+	/* Remaining tokens: OFFSET_STOP threshold=NS */
+	while (p && (token = strsep(&p, " \t")) != NULL) {
+		if (!*token)
+			continue;
+		if (strncmp(token, "threshold=", 10) == 0) {
+			if (kstrtoull(token + 10, 0, &thr))
+				return -EINVAL;
+			if (thr < 1000 || thr > TLOB_MAX_THRESHOLD_NS)
+				return -ERANGE;
+			got_thr = true;
+		} else if (!got_stop) {
+			long long sv;
+
+			n = 0;
+			if (sscanf(token, "%lli%n", &sv, &n) != 1 || n == 0)
+				return -EINVAL;
+			if (sv < 0)
+				return -EINVAL;
+			stop_val = (unsigned long long)sv;
+			got_stop = true;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	if (!got_stop || !got_thr)
+		return -EINVAL;
+	if (start_val == (long long)stop_val)
+		return -EINVAL;
+
+	*thr_out   = thr;
+	*path_out  = path_token;
+	*start_out = (loff_t)start_val;
+	*stop_out  = (loff_t)stop_val;
+	return 0;
+}
+
+/* Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention). */
+static int tlob_parse_remove_line(char *buf, char **path_out, loff_t *start_out)
+{
+	char *binpath, *colon;
+	long long off;
+	int n = 0;
+
+	if (buf[0] != '-')
+		return -EINVAL;
+	binpath = buf + 1;
+	if (binpath[0] != '/')
+		return -EINVAL;
+	colon = strrchr(binpath, ':');
+	if (!colon || colon - binpath < 2)
+		return -EINVAL;
+	*colon = '\0';
+	if (sscanf(colon + 1, "%lli%n", &off, &n) != 1 || n == 0)
+		return -EINVAL;
+	*path_out  = binpath;
+	*start_out = (loff_t)off;
+	return 0;
+}
+
+VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(char *buf)
+{
+	loff_t offset_start, offset_stop;
+	u64 threshold_ns;
+	char *binpath;
+	int ret;
+
+	if (buf[0] == '-') {
+		ret = tlob_parse_remove_line(buf, &binpath, &offset_start);
+		if (ret)
+			return ret;
+		mutex_lock(&tlob_uprobe_mutex);
+		ret = tlob_remove_uprobe_by_key(offset_start, binpath);
+		mutex_unlock(&tlob_uprobe_mutex);
+		return ret;
+	}
+	ret = tlob_parse_uprobe_line(buf, &threshold_ns, &binpath,
+				     &offset_start, &offset_stop);
+	if (ret)
+		return ret;
+	mutex_lock(&tlob_uprobe_mutex);
+	ret = tlob_add_uprobe(threshold_ns, binpath, offset_start, offset_stop);
+	mutex_unlock(&tlob_uprobe_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_create_or_delete_uprobe);
+
+static ssize_t tlob_monitor_write(struct file *file,
+				  const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	char buf[TLOB_MAX_PATH + 128];
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+	if (count > 0 && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	return tlob_create_or_delete_uprobe(buf) ?: (ssize_t)count;
+}
+
+static const struct file_operations tlob_monitor_fops = {
+	.open	= simple_open,
+	.read	= tlob_monitor_read,
+	.write	= tlob_monitor_write,
+	.llseek	= noop_llseek,
+};
+
+static int __tlob_init_monitor(void)
+{
+	int retval;
+
+	tlob_state_cache = kmem_cache_create("tlob_task_state",
+					     sizeof(struct tlob_task_state),
+					     0, 0, NULL);
+	if (!tlob_state_cache)
+		return -ENOMEM;
+
+	retval = ha_monitor_init();
+	if (retval) {
+		kmem_cache_destroy(tlob_state_cache);
+		tlob_state_cache = NULL;
+		return retval;
+	}
+
+	rv_this.enabled = 1;
+	return 0;
+}
+
+static void __tlob_destroy_monitor(void)
+{
+	rv_this.enabled = 0;
+	/*
+	 * Remove uprobes first; rv_uprobe_sync() inside ensures all in-flight
+	 * handlers have finished before we proceed.
+	 */
+	tlob_remove_all_uprobes();
+
+	/*
+	 * da_monitor_destroy() iterates any remaining entries via da_extra_cleanup
+	 * (tlob_extra_cleanup), cancels their timers, and frees their state.
+	 * rcu_barrier() inside drains both da_pool_return_cb and tlob_free_rcu
+	 * callbacks before the pool arrays are freed.
+	 */
+	ha_monitor_destroy();
+	kmem_cache_destroy(tlob_state_cache);
+	tlob_state_cache = NULL;
+}
+
+static int tlob_enable_hooks(void)
+{
+	rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("tlob", sched_process_exit, handle_sched_process_exit);
+	return 0;
+}
+
+static void tlob_disable_hooks(void)
+{
+	rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("tlob", sched_process_exit, handle_sched_process_exit);
+}
+
+static int enable_tlob(void)
+{
+	int retval;
+
+	retval = __tlob_init_monitor();
+	if (retval)
+		return retval;
+
+	return tlob_enable_hooks();
+}
+
+static void disable_tlob(void)
+{
+	tlob_disable_hooks();
+	__tlob_destroy_monitor();
+}
+
+static struct rv_monitor rv_this = {
+	.name		= "tlob",
+	.description	= "Per-task latency-over-budget monitor.",
+	.enable		= enable_tlob,
+	.disable	= disable_tlob,
+	.reset		= da_monitor_reset_all,
+	.enabled	= 0,
+};
+
+static int __init register_tlob(void)
+{
+	int ret;
+
+	ret = rv_register_monitor(&rv_this, NULL);
+	if (ret)
+		return ret;
+
+	if (rv_this.root_d) {
+		if (!tracefs_create_file("monitor", 0644, rv_this.root_d, NULL,
+					 &tlob_monitor_fops)) {
+			rv_unregister_monitor(&rv_this);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void __exit unregister_tlob(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_tlob);
+module_exit(unregister_tlob);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wen Yang <wen.yang@linux.dev>");
+MODULE_DESCRIPTION("tlob: task latency over budget per-task monitor.");
diff --git a/kernel/trace/rv/monitors/tlob/tlob.h b/kernel/trace/rv/monitors/tlob/tlob.h
new file mode 100644
index 000000000000..b6724e629c69
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RV_TLOB_H
+#define _RV_TLOB_H
+
+/*
+ * C representation of the tlob hybrid automaton.
+ *
+ * Three-state HA following sched_stat / wwnr monitor naming conventions:
+ *
+ *   running  (initial) - task is executing on CPU          [sched_stat: runtime]
+ *   waiting             - task is in runqueue, awaiting CPU [sched_stat: wait   ]
+ *   sleeping            - task is blocked, awaiting resource[sched_stat: sleep  ]
+ *
+ * Events (derived from sched_switch / sched_wakeup tracepoints):
+ *   start     - tlob_start_task()               running  → running  (resets clock, arms timer)
+ *   sleep     - sched_switch, prev_state != 0   running  → sleeping
+ *   preempt   - sched_switch, prev_state == 0   running  → waiting
+ *   wakeup    - sched_wakeup                    sleeping → waiting
+ *   switch_in - sched_switch, next == task      waiting  → running
+ *
+ * One HA clock invariant:
+ *   clk_elapsed < BUDGET_NS()  active in all states  (total latency budget)
+ *
+ * tlob_start_task() uses da_handle_start_run_event(start_tlob) to initialise
+ * the monitor: the DA framework sets the initial state and then processes the
+ * start event, which resets clk_elapsed and arms the budget hrtimer via the
+ * generated ha_setup_invariants().
+ * tlob_stop_task() calls ha_cancel_timer_sync() + da_monitor_reset() directly.
+ *
+ * For the format description see:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#include <linux/rv.h>
+#include <linux/sched.h>
+
+#define MONITOR_NAME tlob
+
+enum states_tlob {
+	running_tlob,
+	waiting_tlob,
+	sleeping_tlob,
+	state_max_tlob,
+};
+
+#define INVALID_STATE state_max_tlob
+
+enum events_tlob {
+	start_tlob,
+	sleep_tlob,
+	preempt_tlob,
+	wakeup_tlob,
+	switch_in_tlob,
+	event_max_tlob,
+};
+
+/*
+ * HA environment variable: clk_elapsed is the only clock.
+ * It measures wall-clock time since task_start and is active in all states.
+ */
+enum envs_tlob {
+	clk_elapsed_tlob,
+	env_max_tlob,
+	env_max_stored_tlob = env_max_tlob,
+};
+
+_Static_assert(env_max_stored_tlob <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_CLK_NS
+
+struct automaton_tlob {
+	char *state_names[state_max_tlob];
+	char *event_names[event_max_tlob];
+	char *env_names[env_max_tlob];
+	unsigned char function[state_max_tlob][event_max_tlob];
+	unsigned char initial_state;
+	bool final_states[state_max_tlob];
+};
+
+static const struct automaton_tlob automaton_tlob = {
+	.state_names = {
+		"running",
+		"waiting",
+		"sleeping",
+	},
+	.event_names = {
+		"start",
+		"sleep",
+		"preempt",
+		"wakeup",
+		"switch_in",
+	},
+	.env_names = {
+		"clk_elapsed",
+	},
+	.function = {
+		/* running */
+		{
+			running_tlob,	/* start     (tlob_start_task, resets clock)  */
+			sleeping_tlob,	/* sleep     (sched_switch, prev_state != 0) */
+			waiting_tlob,	/* preempt   (sched_switch, prev_state == 0) */
+			INVALID_STATE,	/* wakeup    (TASK_RUNNING can't be woken)   */
+			INVALID_STATE,	/* switch_in (already on CPU)                */
+		},
+		/* waiting */
+		{
+			INVALID_STATE,	/* start     (not in running state)          */
+			INVALID_STATE,	/* sleep     (not on CPU)                    */
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* wakeup    (already TASK_RUNNING)          */
+			running_tlob,	/* switch_in                                 */
+		},
+		/* sleeping */
+		{
+			INVALID_STATE,	/* start     (not in running state)          */
+			INVALID_STATE,	/* sleep     (already sleeping)              */
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			waiting_tlob,	/* wakeup                                    */
+			INVALID_STATE,	/* switch_in (must go through waiting first) */
+		},
+	},
+	.initial_state = running_tlob,
+	.final_states = { 1, 0, 0 },
+};
+
+/* Maximum number of concurrently monitored tasks. */
+#define TLOB_MAX_MONITORED	64U
+
+/* Maximum binary path length for uprobe binding. */
+#define TLOB_MAX_PATH		256
+
+/*
+ * Upper bound on the monitoring budget (1 hour = 3 600 000 000 000 ns).
+ * The ns-resolution accumulators (running_ns, waiting_ns, sleeping_ns)
+ * are u64; keeping the window below this limit ensures they stay well
+ * clear of u64 overflow and covers every realistic latency-monitoring
+ * use case.
+ */
+#define TLOB_MAX_THRESHOLD_NS	3600000000000ULL
+
+/* Exported to ioctl/uprobe layers and KUnit */
+int tlob_start_task(struct task_struct *task, u64 threshold_ns);
+int tlob_stop_task(struct task_struct *task);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int tlob_create_or_delete_uprobe(char *buf);
+#endif /* CONFIG_KUNIT */
+
+#endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h b/kernel/trace/rv/monitors/tlob/tlob_trace.h
new file mode 100644
index 000000000000..1ac4900d38e8
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_TLOB
+DEFINE_EVENT(event_da_monitor_id, event_tlob,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_tlob,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_tlob,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+
+/*
+ * detail_env_tlob - per-state latency breakdown emitted on budget violation.
+ *
+ * Fired immediately after error_env_tlob from the hrtimer callback.
+ * Fields show how much time was spent in each DA state since tlob_start_task().
+ * running_ns + waiting_ns + sleeping_ns ≈ total elapsed time (threshold_ns exceeded).
+ */
+TRACE_EVENT(detail_env_tlob,
+	TP_PROTO(int id, u64 threshold_ns,
+		 u64 running_ns, u64 waiting_ns, u64 sleeping_ns),
+	TP_ARGS(id, threshold_ns, running_ns, waiting_ns, sleeping_ns),
+	TP_STRUCT__entry(
+		__field(int,	id)
+		__field(u64,	threshold_ns)
+		__field(u64,	running_ns)
+		__field(u64,	waiting_ns)
+		__field(u64,	sleeping_ns)
+	),
+	TP_fast_assign(
+		__entry->id		= id;
+		__entry->threshold_ns	= threshold_ns;
+		__entry->running_ns	= running_ns;
+		__entry->waiting_ns	= waiting_ns;
+		__entry->sleeping_ns	= sleeping_ns;
+	),
+	TP_printk("pid=%d threshold_ns=%llu running_ns=%llu waiting_ns=%llu sleeping_ns=%llu",
+		__entry->id, __entry->threshold_ns,
+		__entry->running_ns, __entry->waiting_ns, __entry->sleeping_ns)
+);
+#endif /* CONFIG_RV_MON_TLOB */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9622c269789c..a4bc215c1f15 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -189,6 +189,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/tlob/tlob_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
-- 
2.43.0

