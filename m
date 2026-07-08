Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5E42DA23
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525172; cv=none; b=SfYtjLfii2fqBc8wVS8/jAillT2BjDp8nraLygReol6zAf2Fb219wAk2vz6pprLcoBaATj1whE3ofRBCI5wOoDCvrpp3flQtqzB/4A3Ex2ABZOokI4/QPpDNew8zWhuJ/7rnryqZ6TsTUok4ewBl45NUexM1bk7usXKaI1RUurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525172; c=relaxed/simple;
	bh=IduFOnSpLrmX00ZXna7Bgahm7/1OaRGxIxuPbfwvSvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ol4Y9nyimgYpToQFhpCzlG6qwBBBdrqeoHT3OMdwA4DRmnkCMnUmnEbPxjbLtUChXKZmMqzEqPlg3/QH3widHbvesZrgvXAnXloyf94QCyoEhc2suzktln/TRCgYsQ3NKcRa6PtrX90O0MnPteYJrgXfkIusuZaxkf+jHGOYRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EenfgAnt; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EenfgAnt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xRcpJn0GSoaGlO07mbKiSOMW7jjXXCjV9jUXhHgVx4=;
	b=EenfgAntTSRoW9ms/oxvs8C/gz5YD5/sBBHagMshvIYqGVG/nFcJL9k9y7nkVsbNh58WBb
	GJgCkYWFQtuQBvKAKroZXiRSvx3xaCIQL4q8gE2eivJi4WihRZxcRL8K/21O+1dGVTtbKQ
	0tlLhgp18vx/EHYu7rMPhMxTsc0EkI0=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 6/8] rv/tlob: add tlob hybrid automaton monitor
Date: Wed,  8 Jul 2026 23:38:32 +0800
Message-Id: <09d656759685edcb0fbeead775300094e7ca5002.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

tlob (task latency over budget) is a per-task hybrid automaton RV
monitor that tracks wall-clock time across a user-delimited code
section and emits an error when elapsed time exceeds a configurable
budget.

The automaton has three states (running, waiting, sleeping) driven by
sched_switch and sched_wakeup tracepoints, with a single clock
invariant enforced by a per-task HRTIMER_MODE_REL_HARD timer.  On
budget expiry the monitor records a per-state time breakdown
(running_ns, waiting_ns, sleeping_ns) before emitting error_env_tlob.

Uprobe pairs are registered through a tracefs monitor file as
"p PATH:OFFSET_START OFFSET_STOP threshold=NS" so arbitrary code
sections can be delimited without modifying the target binary.

Per-task state is allocated from a pre-allocated llist pool so the
uprobe entry handler incurs no dynamic allocation inside the [T0, T1]
measurement window.  DA_ALLOC_POOL is used for the same reason on the
da_monitor_storage side.

tlob_start_lock is a spinlock_t because the uprobe handler runs under
rcu_read_lock_trace() (Tasks Trace SRCU), which permits sleeping on
PREEMPT_RT where spinlock_t is an rt_mutex.  da_get_target_by_id() is
wrapped in scoped_guard(rcu) because hash_for_each_possible_rcu()
requires an RCU read-side critical section independent of the lock.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 Documentation/trace/rv/index.rst           |   1 +
 Documentation/trace/rv/monitor_tlob.rst    | 177 ++++
 kernel/trace/rv/Kconfig                    |   1 +
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/tlob/Kconfig      |  12 +
 kernel/trace/rv/monitors/tlob/tlob.c       | 969 +++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h       | 151 ++++
 kernel/trace/rv/monitors/tlob/tlob_trace.h |  52 ++
 kernel/trace/rv/rv_trace.h                 |   1 +
 9 files changed, 1365 insertions(+)
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
index 000000000000..327c9832bf31
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
+(``da_mon->monitoring == 0``) - it is not an explicit DA state.
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
index 5bad1d63f411..ed0dc8241691 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -90,6 +90,7 @@ source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 # Add new deadline monitors here
 
+source "kernel/trace/rv/monitors/tlob/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
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
index 000000000000..aa43382073d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_TLOB
+	bool "tlob monitor"
+	depends on RV && UPROBES && HIGH_RES_TIMERS
+	select HA_MON_EVENTS_ID
+	select RV_UPROBE
+	help
+	  Enable the tlob (task latency over budget) hybrid-automaton RV
+	  monitor.  tlob tracks per-task elapsed wall-clock time across a
+	  user-delimited code section and emits error_env_tlob when the
+	  elapsed time exceeds a configurable per-invocation budget.
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
new file mode 100644
index 000000000000..b45e84195131
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -0,0 +1,969 @@
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
+ * that pinpoints whether the overrun occurred in the running, waiting,
+ * or sleeping state.
+ *
+ * The monitor uses RV_MON_PER_OBJ: per-task state (struct tlob_task_state)
+ * is stored as monitor_target in the framework's hash table.
+ *
+ * One HA clock invariant is enforced:
+ *   clk_elapsed < BUDGET_NS()   (active in all states)
+ *
+ * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
+ */
+#include <linux/kernel.h>
+#include <linux/llist.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/rv.h>
+#include <linux/slab.h>
+#include <kunit/visibility.h>
+#include <rv/instrumentation.h>
+#include <rv/rv_uprobe.h>
+#include <rv.h>
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
+enum tlob_acc_idx {
+	TLOB_ACC_RUNNING,
+	TLOB_ACC_WAITING,
+	TLOB_ACC_SLEEPING,
+	TLOB_ACC_MAX,
+};
+
+struct tlob_task_state {
+	struct task_struct	*task;		/* via get_task_struct */
+	u64			threshold_ns;	/* budget in nanoseconds */
+
+	/* 1 = cleanup claimed; ha_setup_invariants won't restart the timer. */
+	atomic_t		stopping;
+
+	/* Serialises accs_ns[]; held briefly (hardirq-safe). */
+	raw_spinlock_t		entry_lock;
+	u64			accs_ns[TLOB_ACC_MAX]; /* per-state elapsed ns */
+	ktime_t			last_ts;
+
+	struct rcu_head		rcu;
+	/* Free-list node; active only between call_rcu() return and next alloc. */
+	struct llist_node	free_node;
+};
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+
+typedef struct tlob_task_state *monitor_target;
+
+static inline void tlob_reset_notify(struct da_monitor *da_mon);
+#define da_monitor_reset_hook tlob_reset_notify
+
+static inline void tlob_extra_cleanup(struct da_monitor *da_mon);
+#define da_extra_cleanup tlob_extra_cleanup
+
+#define EVENT_NONE_LBL "budget_exceeded"
+
+#include "tlob.h"
+
+#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
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
+	if (!trace_detail_env_tlob_enabled())
+		return;
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
+		u64 accs[TLOB_ACC_MAX], partial_ns;
+		unsigned long flags;
+
+		/*
+		 * Snapshot accumulators; partial_ns covers curr_state time
+		 * not yet folded in (transition-out pending).
+		 */
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		partial_ns = ktime_get_ns() - ktime_to_ns(ws->last_ts);
+		accs[TLOB_ACC_RUNNING]  = ws->accs_ns[TLOB_ACC_RUNNING]  +
+					  (curr_state == running_tlob  ? partial_ns : 0);
+		accs[TLOB_ACC_WAITING]  = ws->accs_ns[TLOB_ACC_WAITING]  +
+					  (curr_state == waiting_tlob  ? partial_ns : 0);
+		accs[TLOB_ACC_SLEEPING] = ws->accs_ns[TLOB_ACC_SLEEPING] +
+					  (curr_state == sleeping_tlob ? partial_ns : 0);
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+
+		trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_ns,
+				      accs[TLOB_ACC_RUNNING],
+				      accs[TLOB_ACC_WAITING],
+				      accs[TLOB_ACC_SLEEPING]);
+	}
+}
+
+#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
+
+/* HA constraint functions (called by ha_monitor_handle_constraint) */
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env,
+		      u64 time_ns)
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
+ * Guard on stopping: a sched_switch arriving after ha_cancel_timer_sync()
+ * would re-arm the timer and trigger an ODEBUG "activate active" splat.
+ * _acquire pairs with cmpxchg_release in tlob_stop_task.
+ */
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
+		return;
+	if (next_state < state_max_tlob)
+		ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	else
+		ha_cancel_timer(ha_mon);
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
+/*
+ * Pre-allocated pool for tlob_task_state slots.  Lock-free llist so that
+ * tlob_ws_return_cb() (RCU callback) can return slots without acquiring a
+ * spinlock.  Same concurrency model as da_pool_storage (see da_monitor.h).
+ */
+static struct tlob_task_state *tlob_ws_storage;
+static LLIST_HEAD(tlob_ws_free_list);
+
+static void tlob_ws_return_cb(struct rcu_head *head)
+{
+	struct tlob_task_state *ws =
+		container_of(head, struct tlob_task_state, rcu);
+
+	llist_add(&ws->free_node, &tlob_ws_free_list);
+}
+
+/* Direct return to free list without RCU delay (ws was never published). */
+static void tlob_ws_direct_return(struct tlob_task_state *ws)
+{
+	llist_add(&ws->free_node, &tlob_ws_free_list);
+}
+
+static struct tlob_task_state *tlob_ws_alloc(void)
+{
+	struct llist_node *node = llist_del_first(&tlob_ws_free_list);
+
+	if (!node)
+		return NULL;
+
+	struct tlob_task_state *ws =
+		llist_entry(node, struct tlob_task_state, free_node);
+
+	memset(ws, 0, sizeof(*ws));
+	return ws;
+}
+
+/* Uprobe binding list; protected by tlob_uprobe_mutex. */
+static LIST_HEAD(tlob_uprobe_list);
+static DEFINE_MUTEX(tlob_uprobe_mutex);
+
+/*
+ * Serialises duplicate-check + da_handle_start_run_event() per pid.
+ * spinlock_t not raw_spinlock_t: uprobe handlers run under Tasks Trace
+ * SRCU (rcu_read_lock_trace()), which permits sleeping on PREEMPT_RT.
+ */
+static DEFINE_SPINLOCK(tlob_start_lock);
+
+/* Per-uprobe-binding state: a start + stop probe pair for one binary region. */
+struct tlob_uprobe_binding {
+	struct list_head	list;
+	u64			threshold_ns;
+	char			binpath[TLOB_MAX_PATH];
+	loff_t			offset_start;
+	loff_t			offset_stop;
+	DECLARE_RV_UPROBE(start_probe);
+	DECLARE_RV_UPROBE(stop_probe);
+};
+
+/*
+ * Per-task teardown invoked by da_monitor_destroy() for each hash entry.
+ * CAS on stopping (0->1) claims exclusive cleanup ownership.
+ *
+ * No per-entry ha_cancel_timer_sync(): da_monitor_destroy() calls
+ * da_monitor_reset_all() + synchronize_rcu() before this hook, and
+ * ha_mon_destroying prevents new timer callbacks from running.
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
+	put_task_struct(ws->task);
+	/*
+	 * da_monitor_destroy() has already called synchronize_rcu(); no
+	 * reader holds ws.  Return the slot directly without call_rcu.
+	 */
+	llist_add(&ws->free_node, &tlob_ws_free_list);
+}
+
+static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
+			       enum tlob_acc_idx idx)
+{
+	struct tlob_task_state *ws;
+	unsigned long flags;
+
+	guard(rcu)();
+	ws = da_get_target_by_id(task->pid);
+	if (!ws)
+		return false;
+	raw_spin_lock_irqsave(&ws->entry_lock, flags);
+	ws->accs_ns[idx] += ktime_to_ns(ktime_sub(now, ws->last_ts));
+	ws->last_ts = now;
+	raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+	return true;
+}
+
+/* Accumulate running_ns for prev; returns true if prev is monitored. */
+static inline bool tlob_acc_running(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, TLOB_ACC_RUNNING);
+}
+
+/* Accumulate waiting_ns for next; returns true if next is monitored. */
+static inline bool tlob_acc_waiting(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, TLOB_ACC_WAITING);
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
+	return __tlob_acc(task, now, TLOB_ACC_SLEEPING);
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
+/**
+ * tlob_start_task - begin monitoring @task with budget @threshold_ns ns.
+ * @task:         Task to monitor; may be current or another task.
+ * @threshold_ns: Latency budget in nanoseconds (wall-clock; running +
+ *                waiting + sleeping).
+ *                Must be in [1000, TLOB_MAX_THRESHOLD_NS].
+ *
+ * Returns 0, -ENODEV, -ERANGE, -EALREADY, or -ENOSPC (pool at capacity).
+ */
+int tlob_start_task(struct task_struct *task, u64 threshold_ns)
+{
+	struct tlob_task_state *ws;
+
+	if (!da_monitor_enabled())
+		return -ENODEV;
+
+	if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
+	    threshold_ns > TLOB_MAX_THRESHOLD_NS)
+		return -ERANGE;
+
+	/* Serialise duplicate-check + pool-slot claim; see tlob_start_lock. */
+	guard(spinlock)(&tlob_start_lock);
+
+	/*
+	 * __da_get_mon_storage() uses hash_for_each_possible_rcu(), which
+	 * requires an RCU read-side critical section.  On PREEMPT_RT,
+	 * spinlock_t is an rt_mutex and does not satisfy this requirement.
+	 */
+	scoped_guard(rcu) {
+		if (da_get_target_by_id(task->pid))
+			return -EALREADY;
+	}
+
+	/*
+	 * Both tlob_ws_alloc() and da_handle_start_run_event() pop from
+	 * pre-allocated pools of size TLOB_MAX_MONITORED; NULL return means
+	 * the pool is at capacity.
+	 */
+	ws = tlob_ws_alloc();
+	if (!ws)
+		return -ENOSPC;
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
+	 * Returns 0 if the da_monitor_storage pool is exhausted.
+	 */
+	if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
+		put_task_struct(task);
+		tlob_ws_direct_return(ws);
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
+		if (unlikely(WARN_ON_ONCE(!da_mon)))
+			return -ESRCH;
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
+	/*
+	 * ws and ha_mon are used below outside the RCU guard.  This is safe:
+	 * the winning CAS (stopping: 0->1) is the only path that frees ws,
+	 * and da_destroy_storage() below is the only call that returns the
+	 * pool slot.  No concurrent path can free either object.
+	 */
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
+	call_rcu(&ws->rcu, tlob_ws_return_cb);
+	return budget_exceeded ? -EOVERFLOW : 0;
+}
+EXPORT_SYMBOL_GPL(tlob_stop_task);
+
+static int tlob_uprobe_entry_handler(struct uprobe_consumer *self,
+				     struct pt_regs *regs, __u64 *data)
+{
+	struct tlob_uprobe_binding *b =
+		container_of(self, struct tlob_uprobe_binding, start_probe.uc);
+
+	tlob_start_task(current, b->threshold_ns);
+	return 0;
+}
+
+static int tlob_uprobe_stop_handler(struct uprobe_consumer *self,
+				    struct pt_regs *regs, __u64 *data)
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
+	struct tlob_uprobe_binding *tmp_b;
+	char pathbuf[TLOB_MAX_PATH];
+	struct inode *inode;
+	struct path path __free(path_put) = {};
+	char *canon;
+	int ret;
+
+	if (binpath[0] != '/')
+		return -EINVAL;
+
+	struct tlob_uprobe_binding *b __free(kfree) = kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	b->threshold_ns = threshold_ns;
+	b->offset_start = offset_start;
+	b->offset_stop  = offset_stop;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+
+	if (!d_is_reg(path.dentry))
+		return -EINVAL;
+
+	inode = d_real_inode(path.dentry);
+
+	/* Reject duplicate start offset for the same binary inode. */
+	list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
+		if (tmp_b->offset_start == offset_start &&
+		    rv_uprobe_is_registered(&tmp_b->start_probe) &&
+		    tmp_b->start_probe.inode == inode)
+			return -EEXIST;
+	}
+
+	canon = d_path(&path, pathbuf, sizeof(pathbuf));
+	if (IS_ERR(canon))
+		return PTR_ERR(canon);
+	strscpy(b->binpath, canon, sizeof(b->binpath));
+
+	b->start_probe.uc.handler = tlob_uprobe_entry_handler;
+	ret = rv_uprobe_register(b->binpath, offset_start, &b->start_probe);
+	if (ret)
+		return ret;
+
+	b->stop_probe.uc.handler = tlob_uprobe_stop_handler;
+	ret = rv_uprobe_register(b->binpath, offset_stop, &b->stop_probe);
+	if (ret) {
+		rv_uprobe_unregister(&b->start_probe);
+		return ret;
+	}
+
+	/*
+	 * Do NOT write "b = no_free_ptr(b)": the re-assignment restores b,
+	 * causing __free(kfree) to free a live list node on exit.
+	 */
+	list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);
+	return 0;
+}
+
+static int tlob_remove_uprobe_by_key(loff_t offset_start, const char *binpath)
+{
+	struct tlob_uprobe_binding *b, *tmp;
+	struct path remove_path;
+	struct inode *inode;
+	int ret;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
+	if (ret)
+		return ret;
+
+	inode = d_real_inode(remove_path.dentry);
+
+	ret = -ENOENT;
+	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
+		if (b->offset_start != offset_start)
+			continue;
+		if (b->start_probe.inode != inode)
+			continue;
+		list_del(&b->list);
+		/*
+		 * rv_uprobe_sync() may sleep, blocking tlob_monitor_read() on
+		 * tlob_uprobe_mutex.  Safe: list_del() above made the binding
+		 * invisible to new readers before we drop the mutex.
+		 */
+		rv_uprobe_unregister_nosync(&b->start_probe);
+		rv_uprobe_unregister_nosync(&b->stop_probe);
+		rv_uprobe_sync();
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
+		rv_uprobe_unregister_nosync(&b->start_probe);
+		rv_uprobe_unregister_nosync(&b->stop_probe);
+	}
+	mutex_unlock(&tlob_uprobe_mutex);
+
+	if (list_empty(&pending))
+		return;
+
+	/*
+	 * One rv_uprobe_sync() covers all probes dequeued above.
+	 * After this, no handler_chain() iteration can access any consumer.
+	 * The embedded uprobe_consumers in each binding are safe to free.
+	 */
+	rv_uprobe_sync();
+
+	list_for_each_entry_safe(b, tmp, &pending, list) {
+		list_del(&b->list);
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
+	char *buf;
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
+		pos += scnprintf(buf + pos, buf_sz - pos,
+				 "p %s:0x%llx 0x%llx threshold=%llu\n",
+				 b->binpath,
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
+			if (thr < TLOB_MIN_THRESHOLD_NS || thr > TLOB_MAX_THRESHOLD_NS)
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
+/*
+ * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).
+ */
+VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
+					    loff_t *start_out)
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
+	if (off < 0)
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
+	unsigned int i;
+	int retval;
+
+	tlob_ws_storage = kcalloc(TLOB_MAX_MONITORED, sizeof(*tlob_ws_storage),
+				  GFP_KERNEL);
+	if (!tlob_ws_storage)
+		return -ENOMEM;
+
+	for (i = 0; i < TLOB_MAX_MONITORED; i++)
+		llist_add(&tlob_ws_storage[i].free_node, &tlob_ws_free_list);
+
+	retval = ha_monitor_init();
+	if (retval) {
+		kfree(tlob_ws_storage);
+		tlob_ws_storage = NULL;
+		init_llist_head(&tlob_ws_free_list);
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
+	tlob_remove_all_uprobes();
+	ha_monitor_destroy();
+	init_llist_head(&tlob_ws_free_list);
+	kfree(tlob_ws_storage);
+	tlob_ws_storage = NULL;
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
+		if (!rv_create_file("monitor", RV_MODE_WRITE, rv_this.root_d, NULL,
+				    &tlob_monitor_fops)) {
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
index 000000000000..fceeba748c85
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RV_TLOB_H
+#define _RV_TLOB_H
+
+/*
+ * C representation of the tlob hybrid automaton.
+ *
+ * Three-state HA following sched_stat / wwnr monitor naming conventions:
+ *
+ *   running  (initial) - task on CPU           [sched_stat: runtime]
+ *   waiting             - task in runqueue     [sched_stat: wait   ]
+ *   sleeping            - task blocked         [sched_stat: sleep  ]
+ *
+ * Events (derived from sched_switch / sched_wakeup tracepoints):
+ *   start     - tlob_start_task()    running -> running (resets clock)
+ *   sleep     - sched_switch, prev_state != 0   running  -> sleeping
+ *   preempt   - sched_switch, prev_state == 0   running  -> waiting
+ *   wakeup    - sched_wakeup                    sleeping -> waiting
+ *   switch_in - sched_switch, next == task      waiting  -> running
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
+	sleeping_tlob,
+	waiting_tlob,
+	state_max_tlob,
+};
+
+#define INVALID_STATE state_max_tlob
+
+enum events_tlob {
+	preempt_tlob,
+	sleep_tlob,
+	start_tlob,
+	switch_in_tlob,
+	wakeup_tlob,
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
+		"sleeping",
+		"waiting",
+	},
+	.event_names = {
+		"preempt",
+		"sleep",
+		"start",
+		"switch_in",
+		"wakeup",
+	},
+	.env_names = {
+		"clk_elapsed",
+	},
+	.function = {
+		/* running */
+		{
+			waiting_tlob,	/* preempt   (sched_switch, prev_state == 0) */
+			sleeping_tlob,	/* sleep     (sched_switch, prev_state != 0) */
+			running_tlob,	/* start     (tlob_start_task, resets clock)  */
+			INVALID_STATE,	/* switch_in (already on CPU)                */
+			INVALID_STATE,	/* wakeup    (TASK_RUNNING can't be woken)   */
+		},
+		/* sleeping */
+		{
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* sleep     (already sleeping)              */
+			INVALID_STATE,	/* start     (not in running state)          */
+			INVALID_STATE,	/* switch_in (must go through waiting first) */
+			waiting_tlob,	/* wakeup                                    */
+		},
+		/* waiting */
+		{
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* sleep     (not on CPU)                    */
+			INVALID_STATE,	/* start     (not in running state)          */
+			running_tlob,	/* switch_in                                 */
+			INVALID_STATE,	/* wakeup    (already TASK_RUNNING)          */
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
+/* Minimum monitoring budget (1 us). */
+#define TLOB_MIN_THRESHOLD_NS	1000ULL
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
+/* Exported to uprobe layer and KUnit tests */
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
index 000000000000..7ebdfbe41b86
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_TLOB
+DEFINE_EVENT(event_da_monitor_id, event_tlob,
+	     TP_PROTO(int id, char *state, char *event,
+		      char *next_state, bool final_state),
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
+ * running_ns + waiting_ns + sleeping_ns approximately equals total
+ * elapsed time (threshold_ns exceeded).
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
+	TP_printk("pid=%d threshold_ns=%llu"
+		  " running_ns=%llu waiting_ns=%llu sleeping_ns=%llu",
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
2.25.1

