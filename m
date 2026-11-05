Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901046;
	b=F3AfiDARoww4UXjSTtFjqlFr0NA2bqos/R3pauqzfO1CiLPWBrDB1m/TQ5kSTGa0tA+B
	 oVLhg2+U/xqG+lQw4696TuBRhwZxcTsqKf8W10VO4BzUpikB+mO/b5WtzYqomAp5WdAse
	 dHjswimZTBetDT4KSyHNPz6YCOyIQhr1/P9XaMFEL/BrTpOfc4i7xQ/CMHxBWL6t1DQHb
	 xbvG3n/3oIU+k2mcEjOwjJyk6tBpn3tccqvqP6OMpGsK+ESqzBt70pBz1s9ibT3kwyI+B
	 agqkdepOAiiKRV4c1iyplZxtxcyY2iigTpBDrOhPICAiWr05ELqscytOAYxucQ7dITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901046;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vL3fCf3x0Npft/XX19i4MfqfDFYZRdVWqAhvaY2r/60=;
	b=jgyLrcwsL1dp7EzF0AhHvTq+UAuvLtlye4zLK87ZKYWl/Hk7K4AR93wAfw0OLtJcAle0
	 31IWNi62Rd8JJ8SVIlH7on52vwgWa2EeBo+BzTaIu0TOP5gzMmi/wv3x1TY7Q0yj6iRUO
	 ypVZjSYpsixRO/6BYJBCZUBkEo0F6XayPUfsnM27K0h/VorogLKESCkTrDB2A1OEWbJ9G
	 mUyOC2TZArEVAcnisDV/StMBPiLQ3eUg8Wq9/kKxajk84Ya+YPqV4iCWAvtK9aF5Pa6Gg
	 euawlUP4yiWJBJT49x4bpd7spDWHnoKYBwug7QT6bUSXbnhsgRgJF6nbXetKqGRv7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UE0PEjZh;
	arc=none smtp.remote-ip=95.215.58.245
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066F606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1066F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UE0PEjZh
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ma8G2wF1f1YY7iy2mQ8RS1pQN+DkGoPBZuT2jhb1M04=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901043; v=1; x=1794505843;
 b=UE0PEjZhClLbjPS57qJgZ1kdHccMDMZhZRRsaj0JSCOYq8X/RW+ta1HgFIHghRXt4LzYmYjD
 V3l9RcVRtJ7Aai9sLoZMEbD8tarMBX99WxAcvf8dTCj8aTp0J6dOY2NHhGfnxugbhmDISlOuMJG
 1dpm3u+6Su+PsrBpFvCsf0NA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e1ab382a23fba1aa;
	Thu, 05 Nov 2026 17:50:43 +0000
X-Mizu-Trace-ID: e1ab382a23fba1aa
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 11/14] rv: Add tlob hybrid automaton monitor
Date: Fri,  6 Nov 2026 01:49:11 +0800
Message-Id: <3471283eefd839c47fdd0fd2cfd6ac4e28a342dc.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

tlob (task latency over budget) is a per-task hybrid automaton RV
monitor that tracks wall-clock time across a user-delimited code
section and emits an error when the elapsed time exceeds a configurable
budget.

The monitor tracks four states (running, waiting, sleeping, stopped)
driven by sched_switch and sched_wakeup tracepoints.  A single clock
invariant, clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
(HRTIMER_MODE_REL_HARD).  On expiry error_env_tlob is emitted; which
phase consumed the budget (running, waiting or sleeping) is recovered
from event_tlob in user space.

Tasks are registered for monitoring by writing to the tracefs monitor
file using the ftrace uprobe_events convention:
  echo "p:myregion /path/to/binary:OFFSET_START OFFSET_STOP threshold=NS" \
       >> /sys/kernel/tracing/rv/monitors/tlob/monitor

The per-task monitoring record is embedded directly into struct
da_monitor_storage via DA_OBJ_EMBEDDED_TYPE, eliminating the need for a
private mempool, separate RCU reclamation, or parallel OPEN/CLOSED/RETIRED
states. Window transitions and reentrancy are managed directly by the
automaton model and framework storage lifecycle.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 Documentation/trace/rv/index.rst           |   1 +
 Documentation/trace/rv/monitor_tlob.rst    | 162 +++++
 kernel/trace/rv/Kconfig                    |   1 +
 kernel/trace/rv/Makefile                   |   1 +
 kernel/trace/rv/monitors/tlob/Kconfig      |  12 +
 kernel/trace/rv/monitors/tlob/tlob.c       | 732 +++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h       | 143 ++++
 kernel/trace/rv/monitors/tlob/tlob_trace.h |  20 +
 kernel/trace/rv/rv_trace.h                 |   1 +
 9 files changed, 1073 insertions(+)
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
index 000000000000..bf87b90405cd
--- /dev/null
+++ b/Documentation/trace/rv/monitor_tlob.rst
@@ -0,0 +1,162 @@
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
+The tlob (task latency over budget) monitor is a per-object hybrid
+automaton that checks a task's elapsed time (CLOCK_MONOTONIC) against a
+budget: from an instrumented entry point to its matching return, the
+task must not spend more than the budget in any combination of running,
+waiting and sleeping.  The clock ``clk_elapsed`` must satisfy
+``clk_elapsed <= BUDGET_NS()`` in the ``running``, ``waiting`` and
+``sleeping`` states; when it does not, the HA timer fires, the framework
+emits ``error_env_tlob`` and resets the monitor::
+
+                                           | (initial)
+                                           v
+        +--------------+   stop    +----------+
+     +->|   running    | --------> |  stopped |
+     |  +--------------+ <-start-- +----------+
+   switch_in  preempt  sleep
+     |        |       |
+     |        |       |
+     |        v       v
+     +---------+  +---------+
+     | waiting |  | sleeping|
+     +---------+  +---------+
+          ^            v
+          |   wakeup   |
+          |            |
+          +------------+
+
+Not drawn above, ``running`` and ``waiting`` each take ``wakeup`` as a
+self-loop: a task woken between ``set_current_state()`` and ``schedule()``
+is still on CPU, and a wakeup never ends the budget window.  ``stopped``
+takes every scheduler event (``preempt``, ``sleep``, ``switch_in``,
+``wakeup``) as a self-loop, so a task keeps going through the scheduler
+between windows without disturbing the model.  See
+``tools/verification/models/tlob.dot`` for the full model.
+
+``stopped`` has no invariant and hence no timer.  A ``stop``
+(``tlob_stop_task()``, window ended) does not reset the monitor: a later
+``start`` (``tlob_start_task()``) begins a new window from ``stopped``.
+Task exit and monitor disable are the paths that free the per-task
+state; removing a binding only resets the windows it opened and leaves
+the state in place.  A START while a window is still open (a nested
+window) is a model violation, reported through ``error_tlob``.
+
+The non-running condition (monitor not yet started, or reset after a
+violation or monitor disable) is handled implicitly by the RV framework;
+it is not an explicit DA state.
+
+Usage
+-----
+
+tracefs interface (uprobe-based external monitoring)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``monitor`` tracefs file instruments an unmodified binary via
+uprobes, following the ftrace ``uprobe_events`` convention.  Each
+binding has a NAME::
+
+  p:NAME PATH:OFFSET_START OFFSET_STOP threshold=NS
+
+The probes at ``OFFSET_START`` and ``OFFSET_STOP`` (ELF file offsets of
+entry points in ``PATH``) call ``tlob_start_task()`` and
+``tlob_stop_task()``.  ``PATH`` may contain ``:``; the last ``:`` in
+``PATH:OFFSET_START`` is the separator.  ``threshold`` is in
+nanoseconds and must be between 1 us and 1 hour.  ``NAME`` follows the
+ftrace event-name rule (``[A-Za-z_][A-Za-z0-9_]*``, 31 characters at
+most) and must be unique among the registered bindings
+(``-EEXIST``); overlapping ranges on the same binary are rejected
+too, since a task runs one window at a time and a second range would
+shadow the first::
+
+  echo 1 > /sys/kernel/tracing/rv/monitors/tlob/enable
+
+  echo "p:myregion /usr/bin/myapp:0x12a0 0x12f0 threshold=5000000" \
+      >> /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+  # List registered bindings
+  cat /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+  # Remove the binding NAME
+  echo "-:myregion" >> /sys/kernel/tracing/rv/monitors/tlob/monitor
+
+As with the ftrace dynamic-event files, opening ``monitor`` for write
+with ``>`` truncates: ``echo > monitor`` removes all bindings.  Use
+``>>`` for every individual command, removals included.
+
+A task may hit the START/STOP pair any number of times: each pair of
+hits is one window, and the per-task record is kept between windows,
+until the task exits.  A window ends at whichever comes first, the STOP
+probe or the timer; if the timer won, the STOP is a no-op and the next
+START opens the following window.  Removing a binding also ends the
+windows it opened, without reporting them, so a task still running an
+instrumented section is not reported once its binding is gone; a later
+START, from that or another binding, reuses the record.
+
+A task reaching a range bound to a different binding is reported
+through ``error_tlob``: windows do not overlap, and the second would
+shadow the first.
+
+Up to 64 tasks can be monitored at once; the per-object storage comes
+from a pre-allocated pool.  A task that starts past that cap is not
+monitored (the kernel log carries a one-time warning), and reuses its
+slot on a later START.
+
+Violation tracepoints
+~~~~~~~~~~~~~~~~~~~~~
+
+A budget violation emits the framework tracepoint ``error_env_tlob``:
+``id`` (task pid), ``state``, ``event`` (``"budget_exceeded"``) and
+``env`` (``clk_elapsed``).
+
+Deriving the per-state breakdown
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Which phase consumed the budget (``running``: compute, ``waiting``:
+scheduler pressure, ``sleeping``: I/O) is recovered from ``event_tlob``,
+the standard state-transition tracepoint.  Each window is a run of
+``event_tlob`` lines for one pid: ``start`` opens it, ``stop`` closes it,
+and a violation closes it with ``error_env_tlob``.  Attribute the time
+between consecutive lines to the ``next_state`` of the earlier one::
+
+  echo mono > /sys/kernel/tracing/trace_clock
+  echo 1 > /sys/kernel/tracing/events/rv/event_tlob/enable
+  echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+  trace-cmd record -e rv:event_tlob -e rv:error_env_tlob
+  # ... run workload ...
+  trace-cmd report
+
+The ``mono`` clock is required: ``event_tlob`` timestamps are compared
+across CPUs because a task migrates during a window.  The three buckets
+sum to ``clk_elapsed`` up to the tracepoint overhead.
+
+Design notes
+------------
+
+- A fresh window always starts in ``running``: monitoring a task that
+  is already waiting or sleeping at START misattributes the first
+  interval to ``running``.
+- ``TASK_STOPPED`` and ``TASK_TRACED`` carry ``prev_state != 0`` and
+  count as ``sleeping``, indistinguishable from I/O-blocked time.
+- A task preempted between ``set_current_state()`` and ``schedule()``
+  carries ``prev_state != 0`` and counts as ``sleeping`` although it
+  stays runnable.
+- ``sched_wakeup_new`` is not hooked: a task is attached by a START
+  probe in its own context, after the initial wakeup.
+
+Specification
+-------------
+
+- Graphviz Dot file: tools/verification/models/tlob.dot
+- KUnit tests: kernel/trace/rv/monitors/tlob/tlob_kunit.c
+- User-space tests: tools/testing/selftests/verification/
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 2bc412304293..68f0b9bc2dc3 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -82,6 +82,7 @@ source "kernel/trace/rv/monitors/wakeup/Kconfig"
 source "kernel/trace/rv/monitors/stall/Kconfig"
 source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
+source "kernel/trace/rv/monitors/tlob/Kconfig"
 # Add new deadline monitors here
 
 # Add new monitors here
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8dc14a1819b8..99a8dceb829f 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
+obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
 # Add new monitors here
 obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
new file mode 100644
index 000000000000..4f072a9a4da2
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
+	  monitor.  tlob tracks per-task elapsed time across a
+	  user-delimited code section and emits a violation when the
+	  elapsed time exceeds a configurable per-invocation budget.
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
new file mode 100644
index 000000000000..fe7d88df62f1
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -0,0 +1,732 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob (task latency over budget) RV monitor.
+ *
+ * A per-task hybrid automaton that checks a task's elapsed time against
+ * a configurable budget across a user-delimited code section.
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/ctype.h>
+#include <linux/seq_file.h>
+#include <rv/instrumentation.h>
+#include <rv/rv_uprobe.h>
+#include <rv.h>
+
+#define MODULE_NAME "tlob"
+
+#include <rv_trace.h>
+#include <trace/events/sched.h>
+
+struct tlob_uprobe_binding;
+
+/*
+ * Per-task monitoring record, embedded directly in struct da_monitor_storage
+ * via DA_OBJ_EMBEDDED_TYPE. Allocated and freed with the storage.
+ */
+struct tlob_record {
+	u64				threshold_ns;
+	struct tlob_uprobe_binding	*binding;
+};
+
+#define DA_OBJ_EMBEDDED_TYPE struct tlob_record
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
+#define EVENT_NONE_LBL "budget_exceeded"
+
+#include "tlob.h"
+#include <rv/ha_monitor.h>
+
+#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env,
+		      u64 time_ns)
+{
+	if (env == clk_elapsed_tlob)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_tlob env,
+			 u64 time_ns)
+{
+	if (env == clk_elapsed_tlob)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+/*
+ * clk_elapsed <= BUDGET_NS in running/waiting/sleeping; stopped exempt.
+ */
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state,
+					enum events event,
+					enum states next_state,
+					u64 time_ns)
+{
+	if (curr_state == stopped_tlob)
+		return true;
+	return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns,
+				     BUDGET_NS(ha_mon));
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum events event,
+				       enum states next_state,
+				       u64 time_ns)
+{
+	if (next_state == stopped_tlob) {
+		ha_cancel_timer(ha_mon);
+		return;
+	}
+
+	/*
+	 * Only a start re-anchors the clock.  Every other transition keeps
+	 * the anchor, so the timer already points at the right expiry and
+	 * re-arming it would just take the hrtimer base lock on every
+	 * scheduler event of a monitored task.
+	 */
+	if (event != start_tlob)
+		return;
+
+	ha_reset_clk_ns(ha_mon, clk_elapsed_tlob, time_ns);
+	ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
+			  time_ns);
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	if (ha_verify_invariants(ha_mon, curr_state, event,
+				 next_state, time_ns)) {
+		ha_setup_invariants(ha_mon, event, next_state, time_ns);
+		return true;
+	}
+
+	/*
+	 * The event itself found the budget exceeded, so it reports the
+	 * overrun and closes the window.  Without the reset the transition
+	 * would still be taken with the timer left armed, and the expiry
+	 * would report the same overrun a second time.
+	 */
+	da_monitor_reset(&ha_mon->da_mon);
+	return false;
+}
+
+/*
+ * One registered uprobe pair. Multiple bindings can be active simultaneously
+ * on different binaries or on disjoint ranges of the same binary.
+ */
+struct tlob_uprobe_binding {
+	struct list_head		list;
+	char				name[TLOB_MAX_NAME];
+	char				binpath[TLOB_MAX_PATH];
+	loff_t				offset_start;
+	loff_t				offset_stop;
+	u64				threshold_ns;
+	struct path			path;
+	struct rv_uprobe		start_probe;
+	struct rv_uprobe		stop_probe;
+};
+
+static LIST_HEAD(tlob_uprobe_list);
+static DEFINE_MUTEX(tlob_uprobe_mutex);
+
+static int tlob_start_task(struct task_struct *task, u64 threshold_ns,
+			   struct tlob_uprobe_binding *binding)
+{
+	struct tlob_record *rec;
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return -ENODEV;
+
+	if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
+	    threshold_ns > TLOB_MAX_THRESHOLD_NS)
+		return -ERANGE;
+
+	scoped_guard(rcu) {
+		da_mon = da_get_monitor(task->pid, NULL);
+		if (da_mon) {
+			rec = da_get_target(da_mon);
+			if (WARN_ON_ONCE(!rec))
+				return -ENODEV;
+			/*
+			 * A record left by a removed binding is adopted: the
+			 * task is between windows and nothing owns it.
+			 * Anything else starting it while it still belongs to
+			 * another binding would silently shadow that window.
+			 */
+			if (rec->binding && rec->binding != binding) {
+				trace_error_tlob(task->pid,
+						 model_get_state_name(da_mon->curr_state),
+						 model_get_event_name(start_tlob));
+				return -EALREADY;
+			}
+			/*
+			 * A START while the window is still open is a model
+			 * violation (running/waiting/sleeping x start). Hand it
+			 * to the model for reporting, but leave the record
+			 * untouched: adopting the new budget here would change
+			 * the window that is already running.
+			 */
+			if (da_monitoring(da_mon) &&
+			    READ_ONCE(da_mon->curr_state) != stopped_tlob) {
+				da_handle_event(task->pid, NULL, start_tlob);
+				return -EALREADY;
+			}
+			rec->binding = binding;
+			rec->threshold_ns = threshold_ns;
+			/*
+			 * Not da_handle_event(): a violation reset the
+			 * monitor, and a plain event is dropped while
+			 * !da_monitoring(). This restarts it and runs start.
+			 */
+			return da_handle_start_run_event(task->pid, NULL,
+							 start_tlob) ? 0 :
+								      -ENODEV;
+		}
+	}
+
+	struct tlob_record init_rec = {
+		.threshold_ns = threshold_ns,
+		.binding = binding,
+	};
+
+	if (da_handle_start_run_event(task->pid, &init_rec, start_tlob))
+		return 0;
+
+	/*
+	 * The framework reports a disabled monitor and an exhausted pool the
+	 * same way.  Storage is published only once a pool slot was claimed,
+	 * so its absence means the pool is what ran out.
+	 */
+	scoped_guard(rcu)
+		da_mon = da_get_monitor(task->pid, NULL);
+	if (da_mon)
+		return -ENODEV;
+
+	pr_warn_once("%s: no free record, task %d stays unmonitored\n",
+		     __stringify(MODULE_NAME), task->pid);
+	return -ENOSPC;
+}
+
+static int tlob_stop_task(struct task_struct *task,
+			  struct tlob_uprobe_binding *binding)
+{
+	struct tlob_record *rec;
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return -ENODEV;
+
+	scoped_guard(rcu) {
+		da_mon = da_get_monitor(task->pid, NULL);
+		if (!da_mon)
+			return -ESRCH;
+
+		rec = da_get_target(da_mon);
+		if (WARN_ON_ONCE(!rec))
+			return -ENODEV;
+		if (binding && rec->binding && rec->binding != binding)
+			return -EINVAL;
+
+		/*
+		 * A budget overrun already closed the window and reset the
+		 * monitor; the STOP that follows must not report again.
+		 */
+		if (!da_monitoring(da_mon))
+			return 0;
+
+		da_handle_event(task->pid, NULL, stop_tlob);
+	}
+	return 0;
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (!preempt && prev_state != TASK_RUNNING)
+		da_handle_event(prev->pid, NULL, sleep_tlob);
+	else
+		da_handle_event(prev->pid, NULL, preempt_tlob);
+
+	da_handle_event(next->pid, NULL, switch_in_tlob);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *p)
+{
+	da_handle_event(p->pid, NULL, wakeup_tlob);
+}
+
+static void handle_sched_process_exit(void *data, struct task_struct *p,
+				      bool group_dead)
+{
+	da_destroy_storage(p->pid);
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
+ * tlob_release_binding - stop tracking the windows opened by @binding
+ *
+ * A binding may be removed while tasks are still inside its windows.  Their
+ * timers are armed and would report an overrun against a binding that no
+ * longer exists, so reset those monitors once no handler can run anymore.
+ * The record is left in place and its owner cleared: a later START, possibly
+ * from another binding, adopts and restarts it.
+ *
+ * Runs after rv_uprobe_unregister_sync(), which is what makes the walk free
+ * of concurrent writers to rec->binding.
+ */
+static void tlob_release_binding(struct tlob_uprobe_binding *binding)
+{
+	struct da_monitor_storage *mon_storage;
+	int bkt;
+
+	guard(rcu)();
+	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
+		struct tlob_record *rec = da_get_target(&mon_storage->rv.da_mon);
+
+		if (rec && rec->binding == binding) {
+			rec->binding = NULL;
+			da_monitor_reset(&mon_storage->rv.da_mon);
+		}
+	}
+}
+
+static void tlob_unbind(struct tlob_uprobe_binding *b)
+{
+	rv_uprobe_unregister_nosync(&b->start_probe);
+	rv_uprobe_unregister_nosync(&b->stop_probe);
+	rv_uprobe_unregister_sync();
+
+	tlob_release_binding(b);
+
+	iput(b->start_probe.inode);
+	iput(b->stop_probe.inode);
+	path_put(&b->path);
+}
+
+static int tlob_remove_uprobe_by_name(const char *name)
+{
+	struct tlob_uprobe_binding *b, *tmp;
+
+	guard(mutex)(&tlob_uprobe_mutex);
+
+	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
+		if (strcmp(b->name, name))
+			continue;
+		list_del(&b->list);
+		tlob_unbind(b);
+		kfree(b);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static void tlob_remove_all_uprobes(void)
+{
+	struct tlob_uprobe_binding *b, *tmp;
+	LIST_HEAD(pending);
+
+	guard(mutex)(&tlob_uprobe_mutex);
+
+	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
+		list_move(&b->list, &pending);
+		rv_uprobe_unregister_nosync(&b->start_probe);
+		rv_uprobe_unregister_nosync(&b->stop_probe);
+	}
+
+	if (list_empty(&pending))
+		return;
+
+	rv_uprobe_unregister_sync();
+
+	list_for_each_entry_safe(b, tmp, &pending, list) {
+		list_del(&b->list);
+		tlob_release_binding(b);
+		iput(b->start_probe.inode);
+		iput(b->stop_probe.inode);
+		path_put(&b->path);
+		kfree(b);
+	}
+}
+
+static int tlob_add_uprobe(const char *name, const char *binpath,
+			   loff_t offset_start, loff_t offset_stop,
+			   u64 threshold_ns)
+{
+	struct tlob_uprobe_binding *tmp_b;
+	char pathbuf[TLOB_MAX_PATH];
+	struct inode *inode;
+	struct path path __free(path_put) = {};
+	char *canon;
+	int ret;
+
+	guard(mutex)(&tlob_uprobe_mutex);
+
+	if (binpath[0] != '/')
+		return -EINVAL;
+
+	struct tlob_uprobe_binding *b __free(kfree) =
+		kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	strscpy(b->name, name, sizeof(b->name));
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
+	/*
+	 * Names are unique, and so are ranges on the same binary: a task
+	 * runs one window at a time, the second would silently shadow the
+	 * first. Direction normalised so a reversed start/stop still matches.
+	 */
+	list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
+		loff_t s1, e1, s2, e2;
+
+		if (strcmp(tmp_b->name, name) == 0)
+			return -EEXIST;
+		if (!rv_uprobe_is_registered(&tmp_b->start_probe))
+			continue;
+		if (tmp_b->start_probe.inode != inode)
+			continue;
+
+		s1 = min(offset_start, offset_stop);
+		e1 = max(offset_start, offset_stop);
+		s2 = min(tmp_b->offset_start, tmp_b->offset_stop);
+		e2 = max(tmp_b->offset_start, tmp_b->offset_stop);
+		if (s1 <= e2 && s2 <= e1)
+			return -EEXIST;
+	}
+
+	canon = d_path(&path, pathbuf, sizeof(pathbuf));
+	if (IS_ERR(canon))
+		return PTR_ERR(canon);
+	strscpy(b->binpath, canon, sizeof(b->binpath));
+
+	b->start_probe.uc.handler = tlob_uprobe_entry_handler;
+	ret = rv_uprobe_register(inode, offset_start, &b->start_probe);
+	if (ret)
+		return ret;
+
+	b->stop_probe.uc.handler = tlob_uprobe_stop_handler;
+	ret = rv_uprobe_register(inode, offset_stop, &b->stop_probe);
+	if (ret) {
+		tlob_unbind(b);
+		return ret;
+	}
+
+	b->path = path;
+	path_get(&b->path);
+
+	list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);
+	return 0;
+}
+
+static void *tlob_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&tlob_uprobe_mutex);
+	return seq_list_start(&tlob_uprobe_list, *pos);
+}
+
+static void *tlob_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &tlob_uprobe_list, pos);
+}
+
+static void tlob_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&tlob_uprobe_mutex);
+}
+
+static int tlob_seq_show(struct seq_file *m, void *v)
+{
+	struct tlob_uprobe_binding *b =
+		list_entry(v, struct tlob_uprobe_binding, list);
+
+	seq_printf(m, "p:%s %s:0x%llx 0x%llx threshold=%llu\n",
+		   b->name, b->binpath,
+		   (unsigned long long)b->offset_start,
+		   (unsigned long long)b->offset_stop,
+		   b->threshold_ns);
+	return 0;
+}
+
+static const struct seq_operations tlob_monitor_seq_ops = {
+	.start	= tlob_seq_start,
+	.next	= tlob_seq_next,
+	.stop	= tlob_seq_stop,
+	.show	= tlob_seq_show,
+};
+
+static int tlob_parse_uprobe_line(char *buf, char **name_out, char **path_out,
+				  loff_t *start_out, loff_t *stop_out,
+				  u64 *thr_out)
+{
+	unsigned long long thr = 0, stop_val = 0;
+	long long start_val;
+	char *p, *name, *path_token, *token, *colon;
+	bool got_stop = false, got_thr = false;
+
+	if (buf[0] != 'p' || buf[1] != ':')
+		return -EINVAL;
+
+	p = buf + 2;
+	while (*p == ' ' || *p == '\t')
+		p++;
+
+	name = strsep(&p, " \t");
+	if (strlen(name) >= TLOB_MAX_NAME || !is_good_name(name))
+		return -EINVAL;
+
+	if (!p)
+		return -EINVAL;
+	while (*p == ' ' || *p == '\t')
+		p++;
+	path_token = strsep(&p, " \t");
+	if (!path_token || !*path_token)
+		return -EINVAL;
+
+	colon = strrchr(path_token, ':');
+	if (!colon || colon - path_token < 2)
+		return -EINVAL;
+	*colon = '\0';
+
+	if (path_token[0] != '/')
+		return -EINVAL;
+
+	if (kstrtoll(colon + 1, 0, &start_val))
+		return -EINVAL;
+	if (start_val < 0)
+		return -EINVAL;
+
+	while (p && (token = strsep(&p, " \t")) != NULL) {
+		if (!*token)
+			continue;
+		if (strncmp(token, "threshold=", 10) == 0) {
+			if (got_thr)
+				return -EINVAL;
+			if (kstrtoull(token + 10, 0, &thr))
+				return -EINVAL;
+			if (thr < TLOB_MIN_THRESHOLD_NS ||
+			    thr > TLOB_MAX_THRESHOLD_NS)
+				return -ERANGE;
+			got_thr = true;
+		} else if (!got_stop) {
+			long long sv;
+
+			if (kstrtoll(token, 0, &sv))
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
+	*name_out  = name;
+	*thr_out   = thr;
+	*path_out  = path_token;
+	*start_out = (loff_t)start_val;
+	*stop_out  = (loff_t)stop_val;
+	return 0;
+}
+
+static int tlob_parse_remove_line(char *buf, char **name_out)
+{
+	char *name = buf + 2;
+
+	if (buf[0] != '-' || buf[1] != ':')
+		return -EINVAL;
+	if (strlen(name) >= TLOB_MAX_NAME || !is_good_name(name))
+		return -EINVAL;
+
+	*name_out = name;
+	return 0;
+}
+
+static int tlob_create_or_delete_uprobe(char *buf)
+{
+	loff_t offset_start, offset_stop;
+	u64 threshold_ns;
+	char *name, *binpath;
+	int ret;
+
+	if (buf[0] == '-' && buf[1] == ':') {
+		ret = tlob_parse_remove_line(buf, &name);
+		if (ret)
+			return ret;
+		return tlob_remove_uprobe_by_name(name);
+	}
+	ret = tlob_parse_uprobe_line(buf, &name, &binpath, &offset_start,
+				     &offset_stop, &threshold_ns);
+	if (ret)
+		return ret;
+	return tlob_add_uprobe(name, binpath, offset_start, offset_stop,
+			       threshold_ns);
+}
+
+static ssize_t tlob_monitor_write(struct file *file,
+				  const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	char buf[TLOB_MAX_PATH + TLOB_MAX_NAME + 128];
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+	if (count > 0 && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	if (!buf[0])
+		return count;
+	return tlob_create_or_delete_uprobe(buf) ?: (ssize_t)count;
+}
+
+static int tlob_monitor_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
+		tlob_remove_all_uprobes();
+
+	return seq_open(file, &tlob_monitor_seq_ops);
+}
+
+static const struct file_operations tlob_monitor_fops = {
+	.open		= tlob_monitor_open,
+	.read		= seq_read,
+	.write		= tlob_monitor_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int tlob_enable_hooks(void)
+{
+	rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("tlob", sched_process_exit,
+			      handle_sched_process_exit);
+	return 0;
+}
+
+static void tlob_disable_hooks(void)
+{
+	rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("tlob", sched_process_exit,
+			      handle_sched_process_exit);
+}
+
+static int enable_tlob(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	return tlob_enable_hooks();
+}
+
+static void disable_tlob(void)
+{
+	tlob_disable_hooks();
+	rv_this.enabled = 0;
+	tlob_remove_all_uprobes();
+	ha_monitor_destroy();
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
+		if (!rv_create_file("monitor", RV_MODE_WRITE,
+				    rv_this.root_d, NULL,
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
index 000000000000..0a9e150436f4
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RV_TLOB_H
+#define _RV_TLOB_H
+
+/*
+ * C representation of the tlob hybrid automaton (see tlob.dot).
+ * "stop" fires only from running (both callers run on CPU); running x
+ * start is INVALID: a stray re-start must not reset the budget clock.
+ * Invariant: clk_elapsed <= BUDGET_NS() in running/waiting/sleeping;
+ * stopped is exempt.
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
+ * HA clock env: clk_elapsed, elapsed time since the window start; anchored in
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
+		/* stopped: sched events self-loop */
+		{
+			stopped_tlob,	/* preempt   */
+			stopped_tlob,	/* sleep     */
+			running_tlob,	/* start     */
+			INVALID_STATE,	/* stop      */
+			stopped_tlob,	/* switch_in */
+			stopped_tlob,	/* wakeup    */
+		},
+		/* running */
+		{
+			waiting_tlob,	/* preempt (prev_state == 0)  */
+			sleeping_tlob,	/* sleep (prev_state != 0)    */
+			INVALID_STATE,	/* start (is -EALREADY)       */
+			stopped_tlob,	/* stop                       */
+			INVALID_STATE,	/* switch_in                  */
+			running_tlob,	/* wakeup                     */
+		},
+		/* sleeping */
+		{
+			INVALID_STATE,	/* preempt   */
+			INVALID_STATE,	/* sleep     */
+			INVALID_STATE,	/* start     */
+			INVALID_STATE,	/* stop      */
+			INVALID_STATE,	/* switch_in (via waiting) */
+			waiting_tlob,	/* wakeup    */
+		},
+		/* waiting */
+		{
+			INVALID_STATE,	/* preempt   */
+			INVALID_STATE,	/* sleep     */
+			INVALID_STATE,	/* start     */
+			INVALID_STATE,	/* stop      */
+			running_tlob,	/* switch_in */
+			waiting_tlob,	/* wakeup    */
+		},
+	},
+	.initial_state = stopped_tlob,
+	.final_states = { 1, 0, 0, 0 },
+};
+
+/*
+ * Hard cap on concurrently monitored tasks: the framework pre-allocates
+ * this many per-object storage slots (DA_MON_POOL_SIZE).  A task keeps its
+ * slot from its first START until it exits, so a fresh start past the cap
+ * returns -ENOSPC without touching the allocator, and the monitor is not
+ * applied to that task.  Restarts reuse the task's slot.
+ */
+#define TLOB_MAX_MONITORED	64U
+
+/* Maximum binary path length for uprobe binding. */
+#define TLOB_MAX_PATH		256
+
+/* Maximum binding name length (excluding NUL). */
+#define TLOB_MAX_NAME		32
+
+/* Minimum monitoring budget (1 us). */
+#define TLOB_MIN_THRESHOLD_NS	1000ULL
+
+/* Upper budget bound (1 hour). */
+#define TLOB_MAX_THRESHOLD_NS	3600000000000ULL
+
+#endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h b/kernel/trace/rv/monitors/tlob/tlob_trace.h
new file mode 100644
index 000000000000..cda3f39fc110
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
@@ -0,0 +1,20 @@
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

