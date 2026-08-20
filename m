Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E448034A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244371; cv=none; b=KrKdtqHbFOeE6OgDk3mVaUWaAsCyrZVri79CkExTu0YJ9G2UbSgbSW4w4E++TLFxoVbwa/JEwMr6MqIWbFOzLmnxVFc9mX+W2tlnOhhDE6er5xT6T8RBEE7vhHOXCsjEC9MlHjgzce1ryAVZqw8iypLVQuAarhNWJhhUwPt82Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244371; c=relaxed/simple;
	bh=LsYZ+tLkHgj6JYqTMDrJzq39SNL6OsrZd+dUbxlabUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObJK6tPpo8peoPafC3n4KZgWiCv/pS78lESXv7iLJG0DeCCYWsqWdib+FgCWwrVdS/53KTrCKsAAZXhDGfbrkJZNPbU+757Nhd3KhK8u0/m+sX0X6jzZKNgBTaPAItM5s1FWsCnjm7wIZ08EvAIfxDaEyJjS/5O7tNcGBxS3hsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7OG2q3v; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7OG2q3v"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LsYZ+tLkHgj6JYqTMDrJzq39SNL6OsrZd+dUbxlabUM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244366; v=1; x=1787849166;
 b=w7OG2q3vNZVpi0X2mntSNLXgLsTOZm2VA4gycPWCTL5xjfDlobQjsxbXGxyfqm+laYu9z+dD
 c39dEecLbJ9JUfi6GuhGjUU1DZcnpHVVniAe5DFoOdmSQAjNQVt98tuCQ1+fvjLr6SSz7l3Gi1L
 NswaQYdfFljAM0ey33xH07x0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 025062fcfaf31ac4;
	Thu, 20 Aug 2026 16:46:05 +0000
X-Mizu-Trace-ID: 025062fcfaf31ac4
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 6/9] rv: Add tlob hybrid automaton monitor
Date: Fri, 21 Aug 2026 00:45:15 +0800
Message-Id: <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

tlob (task latency over budget) is a per-task hybrid automaton RV
monitor that tracks wall-clock time across a user-delimited code
section and emits an error when elapsed time exceeds a configurable
budget.

Four-state automaton (running, waiting, sleeping, stopped) driven by
sched_switch/sched_wakeup tracepoints and a user-visible start/stop
pair: "stop" only fires from running and parks the window in stopped,
where a later "start" restarts it in place (same pool slot, no
re-registration); both callers of stop run while the task is on CPU.
A single clk_elapsed < BUDGET_NS() invariant is enforced by a
per-task HRTIMER_MODE_REL_HARD timer; on expiry the monitor records a
per-state breakdown (running_ns, waiting_ns, sleeping_ns) before
emitting error_env_tlob.

Uprobe pairs are registered through a tracefs monitor file as
"p PATH:OFFSET_START OFFSET_STOP threshold=NS".  A pre-allocated
mempool hard-caps concurrently monitored tasks at TLOB_MAX_MONITORED
(past it, fresh starts return -ENOSPC) with allocation-free start/stop
on the uprobe hot path.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 Documentation/trace/rv/index.rst           |    1 +
 Documentation/trace/rv/monitor_tlob.rst    |  194 ++++
 kernel/trace/rv/Kconfig                    |    5 +
 kernel/trace/rv/Makefile                   |    2 +
 kernel/trace/rv/monitors/tlob/Kconfig      |   12 +
 kernel/trace/rv/monitors/tlob/tlob.c       | 1137 ++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h       |  149 +++
 kernel/trace/rv/monitors/tlob/tlob_trace.h |   48 +
 kernel/trace/rv/rv_trace.h                 |    1 +
 9 files changed, 1549 insertions(+)
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
index 000000000000..2e606b0e67a4
--- /dev/null
+++ b/Documentation/trace/rv/monitor_tlob.rst
@@ -0,0 +1,194 @@
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
+The monitor implements a four-state hybrid automaton with a single clock
+environment variable ``clk_elapsed``.  The clock invariant
+``clk_elapsed < BUDGET_NS()`` is active in the ``running``, ``waiting``, and
+``sleeping`` states (``stopped`` has no invariant, hence no timer); when it
+is violated the HA timer fires and the framework emits ``error_env_tlob``
+then calls ``da_monitor_reset()`` automatically::
+
+                                           | (initial)
+                                           v
+           +--------------+           +----------+
+           |   running    | --------> |  stopped |
+        |->+--------------+ <-------- +----------+
+   switch_in  preempt  sleep
+        |        |       |
+        |        |       |
+        |        v       v
+        +---------+  +---------+
+        | waiting |  | sleeping|
+        +---------+  +---------+
+             ^            v
+             |   wakeup   |
+             |            |
+             +------------+
+
+  A fourth state, ``stopped``, has no clock invariant (hence no timer).
+  ``running`` reaches it on ``stop`` (``tlob_stop_task()``, window ended,
+  per-task state parked rather than freed) and returns to ``running`` on
+  ``start`` (``tlob_start_task()`` restarting the same task's parked
+  window).
+
+  Key transitions:
+    running  --(sleep)------> sleeping   (task blocks waiting for a resource)
+    running  --(preempt)----> waiting    (task preempted, back in runqueue)
+    sleeping --(wakeup)-----> waiting    (resource available, enters runqueue)
+    waiting  --(switch_in)--> running    (scheduler picks task, back on CPU)
+    running  --(stop)-------> stopped    (tlob_stop_task(): window ended, parked)
+    stopped  --(start)------> running    (tlob_start_task(): window restarted)
+
+  ``tlob_start_task()`` calls ``da_handle_start_run_event(task->pid, ws, start_tlob)``.
+  The ``start_tlob`` edge goes ``stopped`` -> ``running`` for both a fresh
+  allocation (the initial state is ``stopped``) and a parked window's restart;
+  there is no ``start`` self-loop on ``running`` (a running task's START is
+  rejected with ``-EALREADY``).  The transition triggers ``ha_setup_invariants()``,
+  which anchors ``clk_elapsed`` and arms the budget timer automatically.
+  ``tlob_stop_task()`` cancels the HA timer synchronously
+  via ``ha_cancel_timer_sync()``, then dispatches the ``stop_tlob`` event
+  (running -> stopped) instead of resetting the monitor: the per-task state
+  is parked, not freed, so a later ``tlob_start_task()`` call for the same
+  task can restart it without reallocating.  Final teardown (task exit,
+  uprobe unbind, or monitor disable) is what actually calls
+  ``da_monitor_reset()`` and frees the state.
+
+The non-running condition (monitor not yet started, or reset after a budget
+violation or monitor disable) is handled implicitly by the RV framework
+(``da_mon->monitoring == 0``) - it is not an explicit DA state.  A
+``tlob_stop_task()`` does not reset the monitor: the window parks in the
+explicit ``stopped`` state.
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
+A given task may hit the START/STOP pair any number of times: each pair
+of hits is one independent measurement window, and the underlying
+per-task state is reused across windows rather than reallocated each
+time.  Removing a binding while one of its tasks is between windows
+(parked, having already hit STOP) frees that task's state immediately;
+a task still inside a window when its binding is removed keeps running
+unaffected and is cleaned up normally when it next exits.
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
+Design notes
+------------
+
+Limitations:
+
+- A fresh window dispatches ``start_tlob`` (initial ``stopped`` ->
+  ``running``) via ``da_handle_start_run_event(task->pid, ws, start_tlob)``,
+  so monitoring always begins in ``running``.  Monitoring a non-current
+  task that is already in waiting or sleeping state at call time
+  misclassifies the first interval as ``running_ns``.
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
index efa930f94ea4..222b3bea8079 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -84,8 +84,13 @@ source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 # Add new deadline monitors here
 
+source "kernel/trace/rv/monitors/tlob/Kconfig"
 # Add new monitors here
 
+config RV_UPROBE
+	bool
+	depends on RV && UPROBES
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..cd0ec11f0e05 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -21,7 +21,9 @@ obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
+obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
 # Add new monitors here
+obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
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
index 000000000000..08b1bee884cc
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -0,0 +1,1137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob: task latency over budget monitor
+ *
+ * Tracks the elapsed wall-clock time (CLOCK_MONOTONIC) of a marked code
+ * path and flags per-task latency-budget overruns.  The hrtimer callback
+ * emits error_env_tlob on violation plus detail_env_tlob, a per-state
+ * (running/waiting/sleeping) time breakdown.
+ *
+ * RV_MON_PER_OBJ: per-task state (struct tlob_task_state) lives as
+ * monitor_target in the framework's hash table.  One HA clock invariant:
+ * clk_elapsed < BUDGET_NS() in running/waiting/sleeping (stopped parks).
+ *
+ * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
+ */
+#include <linux/kernel.h>
+#include <linux/mempool.h>
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
+	/*
+	 * Per-window: 1 = this window ended (stop or timer expiry).  Blocks
+	 * timer re-arm in ha_setup_invariants(); cleared on restart.
+	 */
+	atomic_t		stopping;
+
+	/*
+	 * Per-task, one-shot: final teardown has claimed this slot; never
+	 * reset (a window can end and restart, the task cannot).  atomic_t
+	 * so cmpxchg is well-defined on every arch.
+	 */
+	atomic_t		destroying;
+
+	bool			budget_exceeded;
+
+	/*
+	 * Opaque owner: the binding that started this task.  Set once on
+	 * fresh allocation (NULL for callers with no binding), cleared by
+	 * tlob_unbind_reap() for an active task whose binding is removed.
+	 * Immutable elsewhere.  Protected by tlob_ws_lock.
+	 */
+	void			*binding;
+	/*
+	 * Linked into binding->started_list for the whole lifetime (not just
+	 * while parked) so unbind reaping finds parked and active tasks.
+	 * Protected by tlob_ws_lock.
+	 */
+	struct list_head	started_node;
+
+	/* Serialises accs_ns[]; held briefly (hardirq-safe). */
+	raw_spinlock_t		entry_lock;
+	u64			accs_ns[TLOB_ACC_MAX]; /* per-state elapsed ns */
+	ktime_t			last_ts;
+
+	struct rcu_head		rcu;
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
+ * da_monitor_reset_hook: runs on hrtimer expiry, final teardown, and
+ * monitor disable.  A normal stop never resets: tlob_stop_task() dispatches
+ * "stop" (running -> stopped, tlob.dot) instead.  Only timer expiry is a
+ * genuine budget violation.
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
+	 * stopping==1 means tlob_stop_task() ended this window already.
+	 * acquire pairs with the _release clear in ha_setup_invariants().
+	 */
+	if (atomic_read_acquire(&ws->stopping))
+		return;
+
+	/*
+	 * Monitor disable (ha_mon_destroying set) is not a violation: the
+	 * teardown paths free ws regardless.  Couples to an HA-layer flag
+	 * with no public contract; a framework-level equivalent would be
+	 * cleaner.
+	 */
+	if (unlikely(READ_ONCE(ha_mon_destroying)))
+		return;
+
+	/* Genuine expiry: end the window so a later start takes the restart path. */
+	atomic_set(&ws->stopping, 1);
+
+	/* Stamped regardless of the tracepoint; tlob_stop_task() reads it. */
+	WRITE_ONCE(ws->budget_exceeded, true);
+
+	if (!trace_detail_env_tlob_enabled())
+		return;
+
+	unsigned int curr_state = READ_ONCE(da_mon->curr_state);
+	u64 accs[TLOB_ACC_MAX], partial_ns;
+	unsigned long flags;
+
+	/* Snapshot accumulators; partial_ns covers curr_state time not yet folded in. */
+	raw_spin_lock_irqsave(&ws->entry_lock, flags);
+	partial_ns = ktime_get_ns() - ktime_to_ns(ws->last_ts);
+	accs[TLOB_ACC_RUNNING]  = ws->accs_ns[TLOB_ACC_RUNNING]  +
+				  (curr_state == running_tlob  ? partial_ns : 0);
+	accs[TLOB_ACC_WAITING]  = ws->accs_ns[TLOB_ACC_WAITING]  +
+				  (curr_state == waiting_tlob  ? partial_ns : 0);
+	accs[TLOB_ACC_SLEEPING] = ws->accs_ns[TLOB_ACC_SLEEPING] +
+				  (curr_state == sleeping_tlob ? partial_ns : 0);
+	raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+
+	trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_ns,
+			      accs[TLOB_ACC_RUNNING],
+			      accs[TLOB_ACC_WAITING],
+			      accs[TLOB_ACC_SLEEPING]);
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
+ * Invariant: clk_elapsed < BUDGET_NS in running/waiting/sleeping.  "stopped"
+ * is exempt: the parked period must not be measured against the old window's
+ * clock anchor (restart from "stopped" would otherwise spuriously overrun).
+ */
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == stopped_tlob)
+		return true;
+	return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns, BUDGET_NS(ha_mon));
+}
+
+/*
+ * The clock stays in guard (anchor) representation all window: env_store
+ * holds the window-start timestamp, re-anchored on start/restart.
+ * ha_invariant_passed_ns() never stores the deadline representation (the
+ * framework dropped ha_set_invariant_ns(), commit ab2900ae252b), so calling
+ * ha_inv_to_guard() here would subtract BUDGET_NS from the anchor and skew
+ * every check by one budget.  nomiss likewise never converts.
+ */
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
+ * Guard on stopping: a sched_switch after ha_cancel_timer_sync() would
+ * re-arm the timer (ODEBUG splat).  _acquire pairs with cmpxchg_release in
+ * tlob_stop_task.
+ *
+ * Entering stopped_tlob also resets env_store to the invalid sentinel, so a
+ * restart re-anchors the clock; a stale anchor would wrap the restart's
+ * timer delay to ~U64_MAX.
+ */
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == stopped_tlob) {
+		/*
+		 * Window ending: reset env_store to the invalid sentinel so
+		 * the next window gets a fresh clock anchor.  Keep stopping==1
+		 * so __tlob_acc() continues to block sched events while parked.
+		 */
+		ha_monitor_reset_all_stored(ha_mon);
+		return;
+	}
+
+	if (atomic_read_acquire(&ha_get_target(ha_mon)->stopping)) {
+		/*
+		 * Restart (stopped -> running): arm the timer, then clear
+		 * stopping so __tlob_acc() admits sched events only once the
+		 * state is already running_tlob.  _release pairs with the
+		 * acquires in __tlob_acc/tlob_reset_notify.
+		 */
+		if (next_state < state_max_tlob)
+			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+		atomic_set_release(&ha_get_target(ha_mon)->stopping, 0);
+		return;
+	}
+
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
+	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
+
+	return true;
+}
+
+/*
+ * Pre-allocated pool of TLOB_MAX_MONITORED slots.  mempool_alloc_preallocated()
+ * pops a reserve slot without touching the allocator (bounded start latency;
+ * -ENOSPC past the cap).  Slots return via destroy/cleanup; mempool_free() is
+ * safe from RCU-callback context.
+ */
+static mempool_t tlob_ws_pool;
+
+static void tlob_ws_return_cb(struct rcu_head *head)
+{
+	struct tlob_task_state *ws =
+		container_of(head, struct tlob_task_state, rcu);
+
+	mempool_free(ws, &tlob_ws_pool);
+}
+
+/* Direct return without RCU delay (ws was never published to the hash). */
+static void tlob_ws_direct_return(struct tlob_task_state *ws)
+{
+	mempool_free(ws, &tlob_ws_pool);
+}
+
+static struct tlob_task_state *tlob_ws_alloc(void)
+{
+	struct tlob_task_state *ws =
+		mempool_alloc_preallocated(&tlob_ws_pool);
+
+	if (!ws)
+		return NULL;
+
+	memset(ws, 0, sizeof(*ws));
+	INIT_LIST_HEAD(&ws->started_node);
+	return ws;
+}
+
+/*
+ * Uprobe binding list; protected by tlob_uprobe_mutex.  When both are
+ * taken, tlob_uprobe_mutex is always acquired before tlob_ws_lock:
+ * inverting the order would be a silent lock-order inversion.
+ */
+static LIST_HEAD(tlob_uprobe_list);
+static DEFINE_MUTEX(tlob_uprobe_mutex);
+
+/* Serialises tlob_task_state ownership: restart, detach, unbind reap. */
+static DEFINE_SPINLOCK(tlob_ws_lock);
+
+/* Per-uprobe-binding state: a start + stop probe pair for one binary region. */
+struct tlob_uprobe_binding {
+	struct list_head	list;
+	u64			threshold_ns;
+	char			binpath[TLOB_MAX_PATH];
+	loff_t			offset_start;
+	loff_t			offset_stop;
+	/*
+	 * All tlob_task_states this binding ever started, for each task's
+	 * lifetime.  Protected by tlob_ws_lock.
+	 */
+	struct list_head	started_list;
+	DECLARE_RV_UPROBE(start_probe);
+	DECLARE_RV_UPROBE(stop_probe);
+};
+
+/*
+ * Unlink ws from its binding's started_list before returning it to the pool.
+ * ws->binding is left stale: the next tlob_ws_alloc() memsets it, and the
+ * restart path checks destroying first.  Idempotent (list_del_init no-op).
+ */
+static inline void tlob_detach_from_binding(struct tlob_task_state *ws)
+{
+	if (!ws->binding)
+		return;
+	guard(spinlock)(&tlob_ws_lock);
+	list_del_init(&ws->started_node);
+}
+
+/*
+ * Per-entry teardown during monitor disable.  cmpxchg on destroying
+ * (0->1) claims ownership -- not stopping, which can be long-lived (a
+ * parked task).
+ *
+ * No timer cancel or locking needed: disable_tlob() already synced every
+ * uprobe/tracepoint, da_monitor_destroy() ran da_monitor_reset_all() +
+ * synchronize_rcu(), and ha_mon_destroying blocks new timer callbacks.
+ */
+static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+	struct tlob_task_state *ws = ha_get_target(ha_mon);
+
+	if (!ws)
+		return;
+
+	if (atomic_cmpxchg_release(&ws->destroying, 0, 1) != 0)
+		return;
+
+	tlob_detach_from_binding(ws);
+	put_task_struct(ws->task);
+	/*
+	 * da_monitor_destroy() has already called synchronize_rcu(); no
+	 * reader holds ws.  Return the slot directly without call_rcu.
+	 */
+	mempool_free(ws, &tlob_ws_pool);
+}
+
+/*
+ * Accumulate elapsed ns into accs_ns[idx] since last_ts and advance it.
+ * Returns true if monitored with an active window.  The stopping gate is
+ * what keeps scheduler events from reaching a parked task (no "stopped"
+ * self-loops, see tlob.h) and keeps accs_ns[] from growing while parked.
+ */
+static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
+			       enum tlob_acc_idx idx)
+{
+	struct tlob_task_state *ws;
+	unsigned long flags;
+
+	guard(rcu)();
+	ws = da_get_target_by_id(task->pid);
+	/* acquire pairs with the _release clear in ha_setup_invariants(). */
+	if (!ws || atomic_read_acquire(&ws->stopping))
+		return false;
+	raw_spin_lock_irqsave(&ws->entry_lock, flags);
+	ws->accs_ns[idx] += ktime_to_ns(ktime_sub(now, ws->last_ts));
+	ws->last_ts = now;
+	raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+	return true;
+}
+
+static inline bool tlob_acc_running(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, TLOB_ACC_RUNNING);
+}
+
+static inline bool tlob_acc_waiting(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, TLOB_ACC_WAITING);
+}
+
+/*
+ * handle_sched_switch - advance the DA on every context switch.
+ *
+ * Emits sleep (running -> sleeping), preempt (running -> waiting) for prev,
+ * and switch_in (waiting -> running) for next.  One ktime_get() shared by
+ * both acc calls keeps prev/next on the same context-switch timestamp.
+ *
+ * No waiting->sleeping edge: a task blocks (calls schedule()) only on CPU
+ * (running); waiting means TASK_RUNNING on the runqueue.
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
+static inline bool tlob_acc_sleeping(struct task_struct *task, ktime_t now)
+{
+	return __tlob_acc(task, now, TLOB_ACC_SLEEPING);
+}
+
+/*
+ * handle_sched_wakeup - sleeping -> waiting transition.  try_to_wake_up()
+ * skips TASK_RUNNING tasks, so this never fires for running/waiting.
+ */
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	ktime_t now = ktime_get();
+
+	if (tlob_acc_sleeping(p, now))
+		da_handle_event(p->pid, NULL, wakeup_tlob);
+}
+
+/* Forward decl: used by handle_sched_process_exit() and tlob_unbind_reap(). */
+static int tlob_stop_task(struct task_struct *task, void *binding);
+static void tlob_destroy_task(struct task_struct *task);
+
+/*
+ * handle_sched_process_exit - clean up a task that exits without hitting its
+ * STOP uprobe (killed, unmapped mid-region, ...).  The task is always in
+ * running_tlob here: do_exit() runs in the task's own context, which
+ * required passing through switch_in_tlob (running).  tlob_stop_task() ends
+ * the window (or is a harmless -EAGAIN/-ESRCH); tlob_destroy_task() then
+ * frees the slot, as no restart can follow exit.
+ */
+static void handle_sched_process_exit(void *data, struct task_struct *p,
+				       bool group_dead)
+{
+	tlob_stop_task(p, NULL);
+	tlob_destroy_task(p);
+}
+
+/**
+ * tlob_start_task - begin monitoring @task with budget @threshold_ns ns.
+ * @task:         Task to monitor; may be current or another task.
+ * @threshold_ns: Budget in ns, in [1000, TLOB_MAX_THRESHOLD_NS].
+ * @binding:      Opaque owner, recorded on fresh allocation and checked for
+ *                an exact match on restart; NULL for callers that never
+ *                restart a parked window.
+ *
+ * Allocates a fresh entry if @task has none, or restarts a parked entry in
+ * place when @binding matches (see tlob.dot: "start" fires from both
+ * running and stopped).
+ *
+ * Returns 0, -ENODEV, -ERANGE, -EALREADY, -ESRCH, or -ENOSPC (fresh start
+ * past pool capacity).
+ */
+static int tlob_start_task(struct task_struct *task, u64 threshold_ns, void *binding)
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
+	/* Serialise duplicate-check + pool-slot claim; see tlob_ws_lock. */
+	guard(spinlock)(&tlob_ws_lock);
+
+	/*
+	 * da_get_target_by_id() uses hash_for_each_possible_rcu(), which
+	 * requires an RCU read-side critical section.
+	 */
+	scoped_guard(rcu) {
+		ws = da_get_target_by_id(task->pid);
+		if (ws) {
+			if (!atomic_read(&ws->stopping))
+				return -EALREADY;
+			if (atomic_read(&ws->destroying))
+				return -ESRCH;
+			/*
+			 * Exact match only.  An orphaned parked ws (binding
+			 * cleared while active, then parked) is not adopted:
+			 * that would need re-linking into the new binding's
+			 * started_list.  Accepted gap; the slot is reclaimed
+			 * at task exit.
+			 */
+			if (ws->binding != binding)
+				return -EALREADY;
+
+			/* Restart in place: same slot, hash entry, task ref, list node. */
+			ws->threshold_ns = threshold_ns;
+			WRITE_ONCE(ws->budget_exceeded, false);
+			memset(ws->accs_ns, 0, sizeof(ws->accs_ns));
+			ws->last_ts = ktime_get();
+
+			/*
+			 * Keep stopping set: __tlob_acc() gates out sched
+			 * events until ha_setup_invariants() clears it after
+			 * the state is running_tlob.  Clearing here would let
+			 * events hit stopped_tlob (INVALID transitions).
+			 */
+
+			/* Only failure here: monitor disabled since the check above. */
+			if (!da_handle_start_run_event(task->pid, ws, start_tlob))
+				return -ENODEV;
+			return 0;
+		}
+	}
+
+	ws = tlob_ws_alloc();
+	if (!ws)
+		return -ENOSPC;
+
+	ws->task = task;
+	get_task_struct(task);
+	ws->threshold_ns = threshold_ns;
+	ws->last_ts = ktime_get();
+	raw_spin_lock_init(&ws->entry_lock);
+	ws->binding = binding;
+	if (binding)
+		list_add_tail(&ws->started_node,
+			      &((struct tlob_uprobe_binding *)binding)->started_list);
+
+	/* Dispatch failed (pool exhausted or monitor disabled): unwind the slot. */
+	if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
+		if (binding)
+			list_del_init(&ws->started_node);
+		/* stopping=1 short-circuits the reset hook; destroy before freeing ws. */
+		atomic_set(&ws->stopping, 1);
+		da_destroy_storage(task->pid);
+		put_task_struct(task);
+		tlob_ws_direct_return(ws);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+/**
+ * tlob_stop_task - end the current monitoring window for @task.
+ * @task: Task to stop.
+ * @binding: Opaque owner; must match ws->binding to end a normal (uprobe)
+ *           window.  NULL (task exit) skips the check.
+ *
+ * Ends the window (dispatches "stop") but does NOT free the entry: it stays
+ * parked so a later tlob_start_task() can restart it.  Call
+ * tlob_destroy_task() once @task will never restart.
+ *
+ * cmpxchg on stopping (0->1) under RCU claims ownership; the winner cancels
+ * the timer synchronously.
+ *
+ * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
+ * -EAGAIN (window already ended), or -EALREADY (owned by another binding).
+ */
+static int tlob_stop_task(struct task_struct *task, void *binding)
+{
+	struct ha_monitor *ha_mon;
+	struct tlob_task_state *ws;
+	bool budget_exceeded;
+
+	scoped_guard(rcu) {
+		ha_mon = ha_get_monitor(task->pid, NULL);
+		if (!ha_mon)
+			return -ESRCH;
+
+		ws = ha_get_target(ha_mon);
+		if (WARN_ON_ONCE(!ws))
+			return -ESRCH;
+
+		/* Only the binding that opened the window may end it; NULL
+		 * (task exit) skips the check.  Symmetric with the restart
+		 * check in tlob_start_task(). */
+		if (binding && ws->binding != binding)
+			return -EALREADY;
+
+		/* cmpxchg (0->1) claims the window under RCU; _release pairs
+		 * with the acquire in ha_setup_invariants(). */
+		if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0)
+			return -EAGAIN;
+
+		/*
+		 * ws may be destroyed concurrently (unbind -> call_rcu), so
+		 * keep its access under RCU; dispatch re-looks-up under RCU.
+		 */
+		ha_cancel_timer_sync(ha_mon);
+		budget_exceeded = READ_ONCE(ws->budget_exceeded);
+	}
+
+	/* running -> stopped: no reset or destroy, the entry stays parked. */
+	da_handle_event(task->pid, NULL, stop_tlob);
+
+	return budget_exceeded ? -EOVERFLOW : 0;
+}
+
+/*
+ * tlob_destroy_task - final teardown for @task's entry: frees the pool slot,
+ * drops the task_struct ref, removes the hash entry, whether active or parked.
+ * Idempotent via the destroying cmpxchg (same pattern as tlob_extra_cleanup()).
+ * Callers must end the window first (see handle_sched_process_exit()).
+ */
+static void tlob_destroy_task(struct task_struct *task)
+{
+	struct ha_monitor *ha_mon;
+	struct tlob_task_state *ws;
+
+	scoped_guard(rcu) {
+		ha_mon = ha_get_monitor(task->pid, NULL);
+		if (!ha_mon)
+			return;
+		ws = ha_get_target(ha_mon);
+		if (WARN_ON_ONCE(!ws))
+			return;
+		if (atomic_cmpxchg_release(&ws->destroying, 0, 1) != 0)
+			return;
+	}
+
+	tlob_detach_from_binding(ws);
+
+	/* Force the window ended: @task may never have reached STOP or a timer. */
+	atomic_set(&ws->stopping, 1);
+	ha_cancel_timer_sync(ha_mon);
+
+	scoped_guard(rcu) {
+		da_monitor_reset(&ha_mon->da_mon);
+	}
+	da_destroy_storage(task->pid);
+
+	put_task_struct(ws->task);
+	call_rcu(&ws->rcu, tlob_ws_return_cb);
+}
+
+static int tlob_uprobe_entry_handler(struct uprobe_consumer *self,
+				     struct pt_regs *regs, __u64 *data)
+{
+	struct tlob_uprobe_binding *b =
+		container_of(self, struct tlob_uprobe_binding, start_probe.uc);
+
+	tlob_start_task(current, b->threshold_ns, b);
+	return 0;
+}
+
+static int tlob_uprobe_stop_handler(struct uprobe_consumer *self,
+				    struct pt_regs *regs, __u64 *data)
+{
+	struct tlob_uprobe_binding *b =
+		container_of(self, struct tlob_uprobe_binding, stop_probe.uc);
+
+	tlob_stop_task(current, b);
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
+	INIT_LIST_HEAD(&b->started_list);
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
+		    d_real_inode(tmp_b->start_probe.path.dentry) == inode)
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
+	/* NOT "b = no_free_ptr(b)": the re-assignment would free the live node. */
+	list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);
+	return 0;
+}
+
+/*
+ * tlob_unbind_reap - detach every task @b started, destroy the parked ones.
+ *
+ * Caller must have unregistered @b's uprobes and called rv_uprobe_sync():
+ * no start/stop can then be in flight for @b, so started_list is safe to
+ * walk.  Active tasks are detached (binding cleared) and left running,
+ * matching unbind behaviour today; parked tasks are destroyed, or their
+ * pool slot leaks until the task next exits.
+ */
+static void tlob_unbind_reap(struct tlob_uprobe_binding *b)
+{
+	struct tlob_task_state *ws, *tmp;
+	LIST_HEAD(to_destroy);
+
+	scoped_guard(spinlock, &tlob_ws_lock) {
+		list_for_each_entry_safe(ws, tmp, &b->started_list, started_node) {
+			list_del_init(&ws->started_node);
+			ws->binding = NULL;
+			if (atomic_read(&ws->stopping))
+				list_add_tail(&ws->started_node, &to_destroy);
+		}
+	}
+
+	list_for_each_entry_safe(ws, tmp, &to_destroy, started_node) {
+		list_del_init(&ws->started_node);
+		tlob_destroy_task(ws->task);
+	}
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
+		if (d_real_inode(b->start_probe.path.dentry) != inode)
+			continue;
+		list_del(&b->list);
+		/*
+		 * rv_uprobe_sync() may sleep; list_del() already made the
+		 * binding invisible to new readers.
+		 */
+		rv_uprobe_unregister_nosync(&b->start_probe);
+		rv_uprobe_unregister_nosync(&b->stop_probe);
+		rv_uprobe_sync();
+		tlob_unbind_reap(b);
+		path_put(&b->start_probe.path);
+		path_put(&b->stop_probe.path);
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
+	/* One sync covers all dequeued probes: consumers are then safe to free. */
+	rv_uprobe_sync();
+
+	list_for_each_entry_safe(b, tmp, &pending, list) {
+		list_del(&b->list);
+		tlob_unbind_reap(b);
+		path_put(&b->start_probe.path);
+		path_put(&b->stop_probe.path);
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
+VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
+					    char **path_out,
+					    loff_t *start_out, loff_t *stop_out)
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
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
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
+EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
+
+static int tlob_create_or_delete_uprobe(char *buf)
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
+	retval = mempool_init_kmalloc_pool(&tlob_ws_pool, TLOB_MAX_MONITORED,
+					   sizeof(struct tlob_task_state));
+	if (retval)
+		return retval;
+
+	retval = ha_monitor_init();
+	if (retval) {
+		mempool_exit(&tlob_ws_pool);
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
+	/*
+	 * A grace period only makes the call_rcu()'d tlob_ws_return_cb()
+	 * callbacks eligible to run; rcu_barrier() waits until they have all
+	 * returned their slots before the pool is destroyed.
+	 */
+	ha_monitor_destroy();
+	rcu_barrier();
+	mempool_exit(&tlob_ws_pool);
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
index 000000000000..0a80a66d94bc
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RV_TLOB_H
+#define _RV_TLOB_H
+
+/*
+ * C representation of the tlob hybrid automaton (see tlob.dot).
+ *
+ * States: stopped (initial; parked), running (on CPU), waiting (runqueue),
+ * sleeping (blocked).  Events: start/stop (tlob_start_task/tlob_stop_task),
+ * sleep/preempt/wakeup/switch_in (sched tracepoints).
+ *
+ * "stop" fires only from running (both callers run on CPU); "stopped"
+ * leaves only via "start" (fresh start or in-place restart).  running[start]
+ * is INVALID: a stray re-start must not silently reset the budget clock.
+ *
+ * Invariant: clk_elapsed < BUDGET_NS() in running/waiting/sleeping; stopped
+ * parks the window, no clock while parked.  start re-inits the monitor
+ * (da_handle_start_run_event()); stop dispatches after ha_cancel_timer_sync();
+ * final teardown uses ha_cancel_timer_sync() + da_monitor_reset() +
+ * da_destroy_storage().
+ *
+ * Format: Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#include <linux/rv.h>
+#include <linux/sched.h>
+
+#define MONITOR_NAME tlob
+
+enum states_tlob {
+	stopped_tlob,
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
+	stop_tlob,
+	switch_in_tlob,
+	wakeup_tlob,
+	event_max_tlob,
+};
+
+/*
+ * HA clock env: clk_elapsed, wall-clock since the window start; anchored in
+ * running/waiting/sleeping, cleared on stop.
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
+		"stopped",
+		"running",
+		"sleeping",
+		"waiting",
+	},
+	.event_names = {
+		"preempt",
+		"sleep",
+		"start",
+		"stop",
+		"switch_in",
+		"wakeup",
+	},
+	.env_names = {
+		"clk_elapsed",
+	},
+	.function = {
+		/* stopped (initial; window parked, sched events not routed) */
+		{
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* sleep     (not on CPU)                    */
+			running_tlob,	/* start     (tlob_start_task, fresh or restart) */
+			INVALID_STATE,	/* stop      (already stopped)                */
+			INVALID_STATE,	/* switch_in (not on CPU)                    */
+			INVALID_STATE,	/* wakeup    (not on CPU)                    */
+		},
+		/* running */
+		{
+			waiting_tlob,	/* preempt   (sched_switch, prev_state == 0) */
+			sleeping_tlob,	/* sleep     (sched_switch, prev_state != 0) */
+			INVALID_STATE,	/* start     (running task's START is -EALREADY) */
+			stopped_tlob,	/* stop      (tlob_stop_task)                */
+			INVALID_STATE,	/* switch_in (already on CPU)                */
+			INVALID_STATE,	/* wakeup    (TASK_RUNNING can't be woken)   */
+		},
+		/* sleeping */
+		{
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* sleep     (already sleeping)              */
+			INVALID_STATE,	/* start     (not in running state)          */
+			INVALID_STATE,	/* stop      (not in running state)          */
+			INVALID_STATE,	/* switch_in (must go through waiting first) */
+			waiting_tlob,	/* wakeup                                    */
+		},
+		/* waiting */
+		{
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* sleep     (not on CPU)                    */
+			INVALID_STATE,	/* start     (not in running state)          */
+			INVALID_STATE,	/* stop      (not in running state)          */
+			running_tlob,	/* switch_in                                 */
+			INVALID_STATE,	/* wakeup    (already TASK_RUNNING)          */
+		},
+	},
+	.initial_state = stopped_tlob,
+	.final_states = { 1, 0, 0, 0 },
+};
+
+/*
+ * Hard cap on concurrently monitored tasks.  tlob_ws_pool pre-allocates
+ * this many slots; a fresh start past the cap returns -ENOSPC with bounded
+ * latency (mempool_alloc_preallocated() never touches the allocator).
+ * Restarts reuse the same slot.
+ */
+#define TLOB_MAX_MONITORED	64U
+
+/* Maximum binary path length for uprobe binding. */
+#define TLOB_MAX_PATH		256
+
+/* Minimum monitoring budget (1 us). */
+#define TLOB_MIN_THRESHOLD_NS	1000ULL
+
+/* Upper budget bound (1 hour): keeps the u64 ns accumulators far from overflow. */
+#define TLOB_MAX_THRESHOLD_NS	3600000000000ULL
+
+#endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h b/kernel/trace/rv/monitors/tlob/tlob_trace.h
new file mode 100644
index 000000000000..b3a7cf4ad3ea
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
@@ -0,0 +1,48 @@
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
+ * detail_env_tlob - per-state latency breakdown on budget violation.
+ * Emitted right after error_env_tlob from the hrtimer callback.
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
index 2f8a932432c9..4bfa39717cef 100644
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

