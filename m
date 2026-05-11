Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F5480321;
	Mon, 11 May 2026 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523943; cv=none; b=OUya/3bZGhoFnRSRQIgdEOIZzz9Ndcrc6kqKPaP68dHNWc4rO1gSQ0f+WAdRBBTbAj0syYfwfxcbCGSXdT8OGhLf+n7iurxy+IIs0fucIBftwLlUB9A8r7CYfpX99bTj7MkBta2h7Kp8A71TBqFxfrVs8KDraETKxktx2zSt0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523943; c=relaxed/simple;
	bh=LmXUHbU6cbDA6Eed+Umo2RqH8Cuh8Rvdqjvdo3OPYR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsDUhSZ96KKyY7A1J2xkSDyetMUHsu0EfzdSURsfUdTn8McXngpP+QotB2orP9N8657r4NHOTzFgZ6CBy7zONyCLaBL1EIAhn11haJ48wNdefNy7QAzvsmGRvgwTuyEDsBF9uk2MJw5EsEXzQkhg09gHJZ09Os8LigqoxG/b2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A84Sc0D2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A84Sc0D2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbXPDLSKtqFOaaJYQqNvzeH7KyO9chy4JcjNbljuZk4=;
	b=A84Sc0D2iQc090nXAtyOOQbYB1Iz/RNn/X0Yip6zYWIiJlEYf5U6l8Hd+cYAfPiZOSILw8
	3RIf0A56MRpWfpQ+EjQwuilLIhxnKL854qB/Jw8Olr97lsR5oV9dZh9kn8WTKJnd8KIU2g
	kBssbZh7/I6vUGCIP/A9K53H1KuWNxM=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 08/10] rv/tlob: add tlob hybrid automaton monitor
Date: Tue, 12 May 2026 02:24:54 +0800
Message-Id: <fe5ed6a9a0a911e6ec74dc06c453786a2c4fb6d1.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
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

Introduce tlob (task latency over budget), a per-task hybrid-automaton
RV monitor that measures elapsed time (CLOCK_MONOTONIC) across
a user-delimited code section and fires an error_env_tlob tracepoint
when the elapsed time exceeds a configurable per-invocation budget.

The monitor is built on RV_MON_PER_OBJ with HA_TIMER_HRTIMER.  Three
states track the scheduler status of the monitored task:

  running  --(sleep)-------> sleeping
  running  --(preempt)-----> waiting
  sleeping --(wakeup)------> waiting
  waiting  --(switch_in)--> running

A single clock invariant clk_elapsed < BUDGET_NS() is active in all
three states.  The budget hrtimer is rearmed on each DA transition for
the remaining budget, keeping the absolute deadline fixed at
start_time + BUDGET_NS.

Per-task state is stored in the DA framework's hash table keyed by
task->pid.  Storage is pre-allocated by tlob_start_task() with
GFP_KERNEL via da_create_or_get() before the scheduler tracepoints
can fire, using DA_SKIP_AUTO_ALLOC so that no kmalloc occurs on the
tracepoint hot path.  This avoids both the kmalloc_nolock() restriction
(requires HAVE_ALIGNED_STRUCT_PAGE) and latency issues under PREEMPT_RT.

Nested monitoring is handled by nest_depth: tlob_start_task() on an
already-monitored pid returns -EEXIST and increments nest_depth without
disturbing the outer window; only the outermost tlob_stop_task()
performs real cleanup.

Two userspace interfaces are provided.  The ioctl interface exposes
in-process self-instrumentation via /dev/rv with TLOB_IOCTL_TRACE_START
and TLOB_IOCTL_TRACE_STOP.  The uprobe interface enables external
monitoring of unmodified binaries via tracefs:

  echo "p PATH:OFFSET_START OFFSET_STOP threshold=NS" \
      > /sys/kernel/tracing/rv/monitors/tlob/monitor

Violations are reported via error_env_tlob (HA clock-invariant)
regardless of which interface triggered them.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com> 
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 Documentation/trace/rv/index.rst           |    1 +
 Documentation/trace/rv/monitor_tlob.rst    |  213 ++++
 include/linux/rv.h                         |   45 +
 include/rv/automata.h                      |   15 +
 include/rv/ha_monitor.h                    |   33 +-
 include/rv/rv_uprobe.h                     |   32 +
 include/uapi/linux/rv.h                    |   86 ++
 kernel/trace/rv/Kconfig                    |    2 +
 kernel/trace/rv/Makefile                   |    4 +-
 kernel/trace/rv/monitors/tlob/Kconfig      |   69 ++
 kernel/trace/rv/monitors/tlob/tlob.c       | 1307 ++++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h       |  171 +++
 kernel/trace/rv/monitors/tlob/tlob_trace.h |   58 +
 kernel/trace/rv/rv.c                       |   38 +
 kernel/trace/rv/rv.h                       |    2 +
 kernel/trace/rv/rv_chardev.c               |  201 +++
 kernel/trace/rv/rv_trace.h                 |    1 +
 kernel/trace/rv/rv_uprobe.c                |   46 +-
 tools/include/uapi/linux/rv.h              |   86 ++
 19 files changed, 2400 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/uapi/linux/rv.h
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_chardev.c
 create mode 100644 tools/include/uapi/linux/rv.h

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
index 000000000000..91b592630b3f
--- /dev/null
+++ b/Documentation/trace/rv/monitor_tlob.rst
@@ -0,0 +1,213 @@
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
+  ``task_start`` calls ``da_handle_start_event()`` with the synthetic event
+  ``switch_in_tlob`` to force the initial DA state to ``running`` (since
+  ``switch_in`` transitions waiting→running), then resets ``clk_elapsed`` and
+  arms the budget timer directly via ``ha_reset_clk_ns()`` + ``ha_start_timer_ns()``.
+  ``task_stop`` cancels the HA timer synchronously via
+  ``ha_cancel_timer_sync()`` then calls ``da_monitor_reset()`` directly.
+
+The non-running condition (monitor not yet started or reset after a
+stop/violation) is handled implicitly by the RV framework
+(``da_mon->monitoring == 0``) — it is not an explicit DA state.
+
+Per-task state lives in ``struct tlob_task_state`` which is stored as
+``monitor_target`` in the framework's ``da_monitor_storage``, indexed by
+pid.  The per-invocation ``threshold_us`` is read via
+``ha_get_target(ha_mon)->threshold_us`` inside the HA constraint functions,
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
+  p PATH:OFFSET_START OFFSET_STOP threshold=US
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
+  echo "p /usr/bin/myapp:0x12a0 0x12f0 threshold=5000" \
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
+ioctl self-instrumentation (/dev/rv)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``/dev/rv`` is a shared RV character device.  Before using any monitor-specific
+ioctl, the fd must be bound to a monitor via ``RV_IOCTL_BIND_MONITOR``.  Each
+open fd has independent per-fd monitoring state::
+
+  int fd = open("/dev/rv", O_RDWR);
+
+  /* Bind this fd to the tlob monitor. */
+  struct rv_bind_args bind = { .monitor_name = "tlob" };
+  ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind);
+
+  struct tlob_start_args args = {
+      .threshold_us = 50000,   /* 50 ms in microseconds */
+  };
+  ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
+
+  /* ... code path under observation ... */
+
+  int ret = ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
+  /* ret == 0:          within budget  */
+  /* ret == -EOVERFLOW: budget exceeded */
+
+  close(fd);
+
+``TRACE_STOP`` returns ``-EOVERFLOW`` whenever the budget was exceeded.
+The HA timer calls ``da_monitor_reset()`` (storage remains); the
+synchronous ``ha_cancel_timer_sync()`` in ``tlob_stop_task()`` ensures the
+callback has completed before checking ``da_monitoring()``.
+
+Violation events
+~~~~~~~~~~~~~~~~
+
+Budget violations are always reported via the ``error_env_tlob`` RV
+tracepoint (HA clock-invariant violation), regardless of which interface
+triggered them::
+
+  cat /sys/kernel/tracing/trace
+
+To capture violations in a file::
+
+  trace-cmd record -e error_env_tlob &
+  # ... run workload ...
+  trace-cmd report
+
+tracefs files
+-------------
+
+The following files are created under
+``/sys/kernel/tracing/rv/monitors/tlob/``:
+
+``enable`` (rw)
+  Write ``1`` to enable the monitor; write ``0`` to disable it.
+
+``desc`` (ro)
+  Human-readable description of the monitor.
+
+``monitor`` (rw)
+  Write ``p PATH:OFFSET_START OFFSET_STOP threshold=US``
+  to bind two entry uprobes.  Write ``-PATH:OFFSET_START`` to remove a
+  binding.  Read to list registered bindings in the same format.
+
+Kernel API
+----------
+
+.. kernel-doc:: kernel/trace/rv/monitors/tlob/tlob.c
+   :functions: tlob_start_task tlob_stop_task
+
+``tlob_start_task(task, threshold_us)``
+  Begin monitoring *task* with a total latency budget of *threshold_us*
+  microseconds.  Allocates per-task state, sets initial DA state to
+  ``running``, resets ``clk_elapsed``, and arms the HA budget timer.
+  Returns 0, -ENODEV (monitor disabled), -ERANGE (zero threshold),
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
+State transitions are driven by two tracepoints:
+
+- ``sched_switch``: ``prev_state == 0`` (``TASK_RUNNING``, preempted,
+  stays on runqueue) → running→waiting; ``prev_state != 0`` (voluntarily
+  blocked, leaves runqueue) → running→sleeping; ``next`` pointer →
+  waiting→running.
+- ``sched_wakeup``: task moves back onto the runqueue → sleeping→waiting.
+
+No ``waiting → sleeping`` edge exists because a task can only block
+itself while executing on CPU.  ``try_to_wake_up()`` is also a no-op
+when ``__state == TASK_RUNNING``, so ``sched_wakeup`` never fires while
+the task is in ``waiting`` state.
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
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..1ea91bb3f1c2 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -21,6 +21,13 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/* Forward declaration: poll_table is only needed by rv_chardev_ops::poll.
+ * Avoid pulling in <linux/poll.h> from rv.h — that header is included by
+ * sched.h, and poll.h → fs.h → rcupdate.h creates a header-ordering cycle
+ * with migrate_disable() on UML/non-SMP targets.
+ */
+struct poll_table_struct;
+
 /*
  * Deterministic automaton per-object variables.
  */
@@ -158,6 +165,44 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent);
 int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
+/**
+ * struct rv_chardev_ops - per-monitor callbacks for the /dev/rv chardev
+ *
+ * Monitors that want to expose an ioctl self-instrumentation interface
+ * register an instance of this struct with rv_chardev_register_monitor().
+ *
+ * @owner:   Module that owns this ops struct.  Set to THIS_MODULE.
+ *           The chardev holds a module reference for every bound fd so
+ *           the module cannot be unloaded while any fd remains open.
+ * @bind:    Called when userspace issues RV_IOCTL_BIND_MONITOR.  Should
+ *           allocate and return per-fd private data (opaque pointer), or
+ *           ERR_PTR(errno) on failure.
+ * @ioctl:   Called for every monitor-specific ioctl after binding.  @priv
+ *           is the pointer returned by @bind.
+ * @poll:    Optional.  Called from the fd's poll() / epoll_wait() path.
+ *           Should call poll_wait(@file, wq, @wait) on the monitor's internal
+ *           wait queue and return the current event mask (EPOLLIN | EPOLLRDNORM
+ *           when an event is pending, 0 otherwise).  If NULL, poll() always
+ *           returns 0 (no events).
+ * @release: Called when the fd is closed.  Must free @priv.
+ */
+struct rv_chardev_ops {
+	struct module *owner;
+	void *(*bind)(void);
+	long  (*ioctl)(void *priv, unsigned int cmd, unsigned long arg);
+	__poll_t (*poll)(void *priv, struct file *file, struct poll_table_struct *wait);
+	void  (*release)(void *priv);
+};
+
+int  rv_chardev_register_monitor(const char *name,
+				 const struct rv_chardev_ops *ops);
+void rv_chardev_unregister_monitor(const char *name);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+void rv_kunit_monitoring_on(void);
+void rv_kunit_monitoring_off(void);
+#endif
+
 #ifdef CONFIG_RV_REACTORS
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
diff --git a/include/rv/automata.h b/include/rv/automata.h
index 4a4eb40cf09a..ae819638d85a 100644
--- a/include/rv/automata.h
+++ b/include/rv/automata.h
@@ -41,6 +41,21 @@ static char *model_get_event_name(enum events event)
 	return RV_AUTOMATON_NAME.event_names[event];
 }
 
+/*
+ * model_get_timer_event_name - label used when the HA timer fires (no event).
+ *
+ * Monitors may define MONITOR_TIMER_EVENT_NAME before including the model
+ * header to give the timer-fired violation a semantically meaningful label
+ * (e.g. "budget_exceeded" for tlob).  Defaults to "none".
+ */
+#ifndef MONITOR_TIMER_EVENT_NAME
+#define MONITOR_TIMER_EVENT_NAME "none"
+#endif
+static inline char *model_get_timer_event_name(void)
+{
+	return MONITOR_TIMER_EVENT_NAME;
+}
+
 /*
  * model_get_initial_state - return the automaton's initial state
  */
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index d59507e8cb30..dfc993774089 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -28,6 +28,7 @@ static inline void ha_monitor_init_env(struct da_monitor *da_mon);
 static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
 static inline void ha_setup_timer(struct ha_monitor *ha_mon);
 static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
 static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 enum states curr_state,
 					 enum events event,
@@ -35,7 +36,10 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 da_id_type id);
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
+/* Allow monitors to override da_monitor_reset_hook before including this header. */
+#ifndef da_monitor_reset_hook
 #define da_monitor_reset_hook ha_monitor_reset_env
+#endif
 
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
@@ -70,7 +74,7 @@ static void ha_react(enum states curr_state, enum events event, char *env)
 	rv_react(&rv_this,
 		 "rv: monitor %s does not allow event %s on state %s with env %s\n",
 		 __stringify(MONITOR_NAME),
-		 event == EVENT_NONE ? EVENT_NONE_LBL : model_get_event_name(event),
+		 event == EVENT_NONE ? model_get_timer_event_name() : model_get_event_name(event),
 		 model_get_state_name(curr_state), env);
 }
 
@@ -246,7 +250,7 @@ static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
 	ha_get_env_string(&env_string, ha_mon, time_ns);
 	ha_react(curr_state, EVENT_NONE, env_string.buffer);
 	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
-			   EVENT_NONE_LBL, env_string.buffer,
+			   model_get_timer_event_name(), env_string.buffer,
 			   da_get_id(&ha_mon->da_mon));
 
 	da_monitor_reset(&ha_mon->da_mon);
@@ -412,6 +416,14 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return timer_delete(&ha_mon->timer);
 }
+/*
+ * ha_cancel_timer_sync - Cancel the timer, blocking until any running
+ * callback has completed.
+ */
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
+{
+	timer_delete_sync(&ha_mon->timer);
+}
 #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
 /*
  * Helper functions to handle the monitor timer.
@@ -432,12 +444,12 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer)
 static inline void ha_setup_timer(struct ha_monitor *ha_mon)
 {
 	hrtimer_setup(&ha_mon->hrtimer, ha_monitor_timer_callback,
-		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 }
 static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
 				     u64 expire, u64 time_ns)
 {
-	int mode = HRTIMER_MODE_REL_HARD;
+	int mode = HRTIMER_MODE_REL_SOFT;
 	u64 passed = ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
 
 	if (RV_MON_TYPE == RV_MON_PER_CPU)
@@ -463,6 +475,18 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
 }
+/*
+ * ha_cancel_timer_sync - Cancel the timer, blocking until any running
+ * callback has completed.
+ *
+ * Use in teardown paths (e.g. stop_task) where the caller must know the
+ * callback has finished before inspecting or freeing monitor state.
+ * Must not be called from atomic context or within the timer callback.
+ */
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
+{
+	hrtimer_cancel(&ha_mon->hrtimer);
+}
 #else /* HA_TIMER_NONE */
 /*
  * Start function is intentionally not defined, monitors using timers must
@@ -473,6 +497,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
 #endif
diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
index 084cdb36a2ff..9106c5c9275e 100644
--- a/include/rv/rv_uprobe.h
+++ b/include/rv/rv_uprobe.h
@@ -79,9 +79,41 @@ struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
  * for any in-progress handler to finish, then releases the path reference
  * and frees the rv_uprobe struct.  The caller's priv data is NOT freed.
  *
+ * When removing a single probe, prefer this over the three-phase API.
  * Safe to call from process context only (uprobe_unregister_sync() may
  * schedule).
  */
 void rv_uprobe_detach(struct rv_uprobe *p);
 
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ * @p:  probe to dequeue; may be NULL (no-op)
+ *
+ * Removes the uprobe from the uprobe subsystem but does NOT wait for
+ * in-flight handlers to complete.  The caller must call rv_uprobe_sync()
+ * before calling rv_uprobe_free() on the same probe.
+ *
+ * Use this to batch multiple deregistrations before a single rv_uprobe_sync().
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ *
+ * Global barrier: waits for every in-flight uprobe handler across the system
+ * to finish.  Call once after a batch of rv_uprobe_unregister_nosync() calls
+ * and before any rv_uprobe_free() call.
+ */
+void rv_uprobe_sync(void);
+
+/**
+ * rv_uprobe_free - release resources of a previously deregistered probe
+ * @p:  probe to free; may be NULL (no-op)
+ *
+ * Releases the path reference and frees the rv_uprobe struct.  Must only
+ * be called after rv_uprobe_sync() has returned.  The caller's priv data
+ * is NOT freed.
+ */
+void rv_uprobe_free(struct rv_uprobe *p);
+
 #endif /* _RV_UPROBE_H */
diff --git a/include/uapi/linux/rv.h b/include/uapi/linux/rv.h
new file mode 100644
index 000000000000..a34e5426393b
--- /dev/null
+++ b/include/uapi/linux/rv.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * UAPI definitions for Runtime Verification (RV) monitors.
+ *
+ * All RV monitors that expose an ioctl self-instrumentation interface
+ * share the magic byte RV_IOC_MAGIC ('r').
+ *
+ * Usage examples and design rationale are in:
+ *   Documentation/trace/rv/monitor_tlob.rst
+ */
+
+#ifndef _UAPI_LINUX_RV_H
+#define _UAPI_LINUX_RV_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Magic byte shared by all RV monitor ioctls. */
+#define RV_IOC_MAGIC		'r'
+
+/* Maximum monitor name length (including NUL terminator). */
+#define RV_MONITOR_NAME_MAX	32
+
+/* Generic /dev/rv ioctls (ioctl numbers 0–15 are reserved for the core) */
+
+/**
+ * struct rv_bind_args - arguments for RV_IOCTL_BIND_MONITOR
+ * @monitor_name: NUL-terminated name of the monitor to bind (e.g. "tlob").
+ */
+struct rv_bind_args {
+	char monitor_name[RV_MONITOR_NAME_MAX];
+};
+
+/*
+ * RV_IOCTL_BIND_MONITOR - associate this fd with a specific RV monitor.
+ *
+ * Must be called once after open() and before any monitor-specific ioctl.
+ *
+ * Returns 0 on success.
+ * Returns -EBUSY  if this fd is already bound to a monitor.
+ * Returns -ENOENT if the requested monitor is not registered.
+ * Returns -ENOMEM on allocation failure.
+ */
+#define RV_IOCTL_BIND_MONITOR	_IOW(RV_IOC_MAGIC, 0, struct rv_bind_args)
+
+/* tlob: task latency over budget monitor (ioctl numbers 1–15) */
+
+/**
+ * struct tlob_start_args - arguments for TLOB_IOCTL_TRACE_START
+ * @threshold_us: Total latency budget for this window, in microseconds.
+ *               Must be greater than zero.  Both on-CPU and off-CPU time
+ *               (including runqueue wait) count toward this budget.
+ */
+struct tlob_start_args {
+	__u64 threshold_us;
+};
+
+/*
+ * TLOB_IOCTL_TRACE_START - begin monitoring the calling task.
+ *
+ * Arms a per-task hrtimer for threshold_us microseconds (CLOCK_MONOTONIC,
+ * so both on-CPU and off-CPU time count toward the budget).
+ *
+ * Returns 0 on success.
+ * Returns -EEXIST if TRACE_START was already called on this fd.
+ * Returns -ENOSPC if TLOB_MAX_MONITORED tasks are already being tracked.
+ * Returns -ENOMEM on allocation failure.
+ * Returns -ENODEV if the tlob monitor is not enabled.
+ * Returns -ERANGE if threshold_us is 0.
+ */
+#define TLOB_IOCTL_TRACE_START	_IOW(RV_IOC_MAGIC, 1, struct tlob_start_args)
+
+/*
+ * TLOB_IOCTL_TRACE_STOP - end monitoring the calling task.
+ *
+ * Returns 0 if within budget.
+ * Returns -EOVERFLOW if the latency budget was exceeded.
+ * Returns -EINVAL if TLOB_IOCTL_TRACE_START was not called on this fd.
+ *
+ * poll/epoll: after TRACE_START the fd becomes readable (EPOLLIN) when the
+ * budget is exceeded.  The caller may then issue TRACE_STOP to retrieve the
+ * result, or simply close the fd to clean up.
+ */
+#define TLOB_IOCTL_TRACE_STOP	_IO(RV_IOC_MAGIC, 2)
+
+#endif /* _UAPI_LINUX_RV_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e2e0033a00b9..1c36939db8e5 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -87,6 +87,8 @@ source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 # Add new deadline monitors here
 
+source "kernel/trace/rv/monitors/tlob/Kconfig"
+
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f139b904bea3..8a5b5c84aff9 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,7 +2,7 @@
 
 ccflags-y += -I $(src)		# needed for trace events
 
-obj-$(CONFIG_RV) += rv.o
+obj-$(CONFIG_RV) += rv.o rv_chardev.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
@@ -17,6 +17,8 @@ obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
+obj-$(CONFIG_RV_MON_TLOB) += monitors/tlob/tlob.o
+obj-$(CONFIG_TLOB_KUNIT_TEST) += monitors/tlob/tlob_kunit.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/tlob/Kconfig b/kernel/trace/rv/monitors/tlob/Kconfig
new file mode 100644
index 000000000000..82e521891496
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/Kconfig
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_TLOB
+	depends on RV
+	select RV_UPROBE
+	select HA_MON_EVENTS_ID
+	bool "tlob monitor"
+	help
+	  Enable the tlob (task latency over budget) monitor.  This monitor
+	  tracks the elapsed time (CLOCK_MONOTONIC) of a marked code path
+	  within a task (including both on-CPU and off-CPU time) and reports
+	  a violation when the elapsed time exceeds a configurable budget.
+
+	  The monitor uses a three-state hybrid automaton (running, waiting,
+	  sleeping) stored per object using RV_MON_PER_OBJ.  A single HA
+	  clock invariant (clk_elapsed < BUDGET_NS) is enforced in all three
+	  states via a per-task hrtimer.
+
+	  States: running (initial, on-CPU), waiting (in runqueue, off-CPU),
+	          sleeping (blocked on resource, off-CPU).
+	  Key transitions:
+	    running  --(sleep)------> sleeping
+	    running  --(preempt)----> waiting
+	    sleeping --(wakeup)-----> waiting
+	    waiting  --(switch_in)--> running
+	  task_start calls da_handle_start_event() to set the initial state,
+	  then arms the budget timer directly via ha_reset_clk_ns() +
+	  ha_start_timer_ns().  task_stop cancels the timer synchronously via
+	  ha_cancel_timer_sync() then calls da_monitor_reset().
+
+	  Two userspace interfaces are provided:
+
+	  tracefs uprobe binding (external, unmodified binaries):
+	    echo "p PATH:OFFSET_START OFFSET_STOP threshold=NS" \
+	        > /sys/kernel/tracing/rv/monitors/tlob/monitor
+	  The uprobe at offset_start fires tlob_start_task(); the uprobe at
+	  offset_stop fires tlob_stop_task().  Both are plain entry uprobes
+	  so a mistyped offset cannot corrupt the call stack.
+
+	  /dev/rv ioctl (in-process self-instrumentation):
+	    ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
+	    do_critical_work();
+	    ret = ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	    /* ret == -EOVERFLOW when budget exceeded */
+	  Allows conditional monitoring, sub-function granularity, and
+	  inline reaction to violations without polling the trace buffer.
+
+	  Up to TLOB_MAX_MONITORED tasks may be monitored simultaneously.
+
+	  Violations are always reported via the standard error_env_tlob RV
+	  tracepoint regardless of which interface triggered them.  The
+	  tracefs interface requires only tracefs write permissions, avoiding
+	  the CAP_BPF privilege needed for equivalent eBPF-based approaches.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_tlob.rst
+
+config TLOB_KUNIT_TEST
+	tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS
+	depends on RV_MON_TLOB && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit in-kernel unit tests for the tlob RV monitor.
+
+	  Tests cover automaton state transitions, the start/stop task
+	  interface, scheduler context-switch accounting, and the uprobe
+	  format string parser.
+
+	  Say Y or M here to run the tlob KUnit test suite; otherwise say N.
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
new file mode 100644
index 000000000000..475e972ae9aa
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -0,0 +1,1307 @@
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
+ * task_start uses da_handle_start_event() to set the initial state, then
+ * calls ha_reset_clk_ns() + ha_start_timer_ns() directly to initialise the
+ * clock and arm the budget timer.  No synthetic event is needed.
+ * The HA timer is cancelled synchronously by ha_cancel_timer_sync() in
+ * tlob_stop_task().
+ *
+ * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
+ */
+#include <linux/completion.h>
+#include <linux/hrtimer.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/refcount.h>
+#include <linux/rv.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/tracefs.h>
+#include <linux/uaccess.h>
+#include <kunit/visibility.h>
+#include <rv/instrumentation.h>
+#include <rv/rv_uprobe.h>
+#include <uapi/linux/rv.h>
+#include "../../rv.h"
+
+#define MODULE_NAME "tlob"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+
+/*
+ * Per-fd private data; one instance per open /dev/rv fd.
+ * monitoring: set while TRACE_START is active; cleared at TRACE_STOP.
+ * budget_exceeded: set by hrtimer callback; read at TRACE_STOP to report
+ * -EOVERFLOW even when cleanup was claimed by a concurrent stop_all or
+ * a task-exit handler.
+ */
+struct tlob_fpriv {
+	struct task_struct	*task;
+	bool			monitoring;
+	bool			budget_exceeded;
+};
+
+/*
+ * Per-task latency monitoring state.  One instance per monitoring window.
+ * Stored as monitor_target in da_monitor_storage; freed via call_rcu.
+ */
+struct tlob_task_state {
+	struct task_struct	*task;		/* via get_task_struct */
+	u64			threshold_us;	/* budget in microseconds */
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
+	/* store-release in TRACE_START ioctl, load-acquire in reset_notify. */
+	struct tlob_fpriv	*fpriv;
+
+	struct rcu_head		rcu;		/* for call_rcu() teardown */
+};
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+/* Pool mode: da_handle_start_event uses da_fill_empty_storage, not kmalloc. */
+#define DA_SKIP_AUTO_ALLOC
+
+/* Type for da_monitor_storage.target; must be defined before the includes. */
+typedef struct tlob_task_state *monitor_target;
+
+/* Forward-declared so da_monitor_reset_hook works before ha_monitor.h. */
+static inline void tlob_reset_notify(struct da_monitor *da_mon);
+#define da_monitor_reset_hook tlob_reset_notify
+
+/*
+ * When the hrtimer fires (budget elapsed), the HA framework emits
+ * error_env_tlob with this label instead of the generic "none".
+ */
+#define MONITOR_TIMER_EVENT_NAME "budget_exceeded"
+
+#include "tlob.h"
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
+		struct tlob_fpriv *fp;
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
+		trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_us,
+				      running_ns, waiting_ns, sleeping_ns);
+
+		/*
+		 * Latch violation in the fd so TRACE_STOP can return -EOVERFLOW
+		 * even if a concurrent stop_all or task-exit handler claims
+		 * cleanup first.  Pairs with smp_store_release in TRACE_START.
+		 */
+		fp = smp_load_acquire(&ws->fpriv);
+		if (fp)
+			WRITE_ONCE(fp->budget_exceeded, true);
+	}
+}
+
+#define BUDGET_US(ha_mon) (ha_get_target(ha_mon)->threshold_us)
+#define BUDGET_NS(ha_mon) (BUDGET_US(ha_mon) * 1000ULL)
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
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_tlob env, u64 time_ns)
+{
+	if (env == clk_elapsed_tlob)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+/*
+ * ha_verify_invariants - clk_elapsed < BUDGET_NS must hold in all states.
+ */
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == running_tlob)
+		return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns);
+	else if (curr_state == sleeping_tlob)
+		return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns);
+	else if (curr_state == waiting_tlob)
+		return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns);
+	return true;
+}
+
+/*
+ * Convert invariant (deadline) to guard (reset anchor) on state transitions.
+ * Skip if uninitialised (ENV_INVALID_VALUE): the race between
+ * da_handle_start_event() and ha_reset_clk_ns() would give U64_MAX - BUDGET_NS.
+ */
+static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == next_state)
+		return;
+	if (curr_state == running_tlob &&
+	    !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
+		ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	else if (curr_state == sleeping_tlob &&
+		 !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
+		ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	else if (curr_state == waiting_tlob &&
+		 !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
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
+ * Guard on stopping: sched_switch events can arrive after ha_cancel_timer_sync,
+ * restarting the timer and triggering an ODEBUG "activate active" splat.
+ */
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state)
+		return;
+	if (next_state == running_tlob) {
+		if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
+			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	} else if (next_state == sleeping_tlob) {
+		if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
+			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	} else if (next_state == waiting_tlob) {
+		if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
+			ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_ns);
+	} else if (curr_state == running_tlob)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == waiting_tlob)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == sleeping_tlob)
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
+static struct kmem_cache *tlob_state_cache;
+
+static atomic_t tlob_num_monitored = ATOMIC_INIT(0);
+
+/* Uprobe binding list; protected by tlob_uprobe_mutex. */
+static LIST_HEAD(tlob_uprobe_list);
+static DEFINE_MUTEX(tlob_uprobe_mutex);
+
+/*
+ * Serialises duplicate-check + da_create_or_get() to prevent two concurrent
+ * callers for the same pid from both inserting into the hash table.
+ */
+static DEFINE_MUTEX(tlob_start_mutex);
+
+/*
+ * Counts open /dev/rv fds plus one synthetic ref held while enabled.
+ * __tlob_destroy_monitor() drops the synthetic ref and waits for zero
+ * before teardown, preventing kmem_cache_zalloc() on a destroyed cache.
+ */
+static refcount_t tlob_fd_refcount = REFCOUNT_INIT(0);
+static DECLARE_COMPLETION(tlob_fd_released);
+
+/* Per-uprobe-binding state: a start + stop probe pair for one binary region. */
+struct tlob_uprobe_binding {
+	struct list_head	list;
+	u64			threshold_us;
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
+ * handle_sched_switch - advance the DA on every context switch.
+ *
+ * Generates three DA events:
+ *   prev, prev_state != 0  -> sleep_tlob    (running -> sleeping)
+ *   prev, prev_state == 0  -> preempt_tlob  (running -> waiting)
+ *   next                   -> switch_in_tlob (waiting -> running)
+ */
+static void handle_sched_switch(void *data, bool preempt_unused,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	struct tlob_task_state *ws;
+	unsigned long flags;
+	bool do_prev = false, do_next = false;
+	bool prev_preempted;
+	ktime_t now;
+
+	rcu_read_lock();
+
+	ws = da_get_target_by_id(prev->pid);
+	if (ws) {
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		now = ktime_get();
+		ws->running_ns += ktime_to_ns(ktime_sub(now, ws->last_ts));
+		ws->last_ts = now;
+		/* prev_state == 0: TASK_RUNNING (preempted); != 0: sleeping. */
+		prev_preempted = (prev_state == 0);
+		do_prev = true;
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+	}
+
+	ws = da_get_target_by_id(next->pid);
+	if (ws) {
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		now = ktime_get();
+		ws->waiting_ns += ktime_to_ns(ktime_sub(now, ws->last_ts));
+		ws->last_ts = now;
+		do_next = true;
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+	}
+
+	rcu_read_unlock();
+
+	if (do_prev)
+		da_handle_event(prev->pid, NULL,
+				prev_preempted ? preempt_tlob : sleep_tlob);
+	if (do_next)
+		da_handle_event(next->pid, NULL, switch_in_tlob);
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
+	struct tlob_task_state *ws;
+	unsigned long flags;
+	bool found = false;
+
+	rcu_read_lock();
+	ws = da_get_target_by_id(p->pid);
+	if (ws) {
+		ktime_t now = ktime_get();
+
+		raw_spin_lock_irqsave(&ws->entry_lock, flags);
+		ws->sleeping_ns += ktime_to_ns(ktime_sub(now, ws->last_ts));
+		ws->last_ts = now;
+		raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
+		found = true;
+	}
+	rcu_read_unlock();
+
+	if (found)
+		da_handle_event(p->pid, NULL, wakeup_tlob);
+}
+
+/*
+ * handle_sched_process_exit - clean up if a task exits without TRACE_STOP.
+ *
+ * Called in do_exit() context; the task still has a valid pid here.
+ */
+static void handle_sched_process_exit(void *data, struct task_struct *p,
+				       bool group_dead)
+{
+	struct tlob_task_state *ws;
+	bool found = false;
+
+	rcu_read_lock();
+	ws = da_get_target_by_id(p->pid);
+	found = !!ws;
+	rcu_read_unlock();
+
+	if (found)
+		tlob_stop_task(p);
+}
+
+
+
+/**
+ * tlob_start_task - begin monitoring @task with budget @threshold_us us.
+ * @task:         Task to monitor; may be current or another task.
+ * @threshold_us: Latency budget in microseconds (wall-clock; running + waiting + sleeping). > 0.
+ *
+ * Returns 0, -ENODEV, -EALREADY, -ENOSPC, or -ENOMEM.
+ */
+int tlob_start_task(struct task_struct *task, u64 threshold_us)
+{
+	struct tlob_task_state *ws_existing;
+	struct tlob_task_state *ws;
+	struct da_monitor *da_mon;
+	struct ha_monitor *ha_mon;
+	u64 now_ns;
+	int ret;
+
+	if (!da_monitor_enabled())
+		return -ENODEV;
+
+	if (threshold_us == 0)
+		return -ERANGE;
+
+	/* Serialise duplicate-check + da_create_or_get for the same pid. */
+	guard(mutex)(&tlob_start_mutex);
+
+	rcu_read_lock();
+	ws_existing = da_get_target_by_id(task->pid);
+	if (ws_existing) {
+		rcu_read_unlock();
+		return -EALREADY;
+	}
+	rcu_read_unlock();
+
+	ws = kmem_cache_zalloc(tlob_state_cache, GFP_KERNEL);
+	if (!ws)
+		return -ENOMEM;
+
+	ws->task = task;
+	get_task_struct(task);
+	ws->threshold_us = threshold_us;
+	ws->last_ts = ktime_get();
+	raw_spin_lock_init(&ws->entry_lock);
+
+	/* Claim a pool slot (no kmalloc; DA_SKIP_AUTO_ALLOC + prealloc). */
+	ret = da_create_or_get(task->pid, ws);
+	if (ret) {
+		put_task_struct(task);
+		kmem_cache_free(tlob_state_cache, ws);
+		return ret;
+	}
+
+	atomic_inc(&tlob_num_monitored);
+
+	/* Hold RCU across handle + timer setup to keep da_mon valid. */
+	rcu_read_lock();
+	da_handle_start_event(task->pid, ws, switch_in_tlob);
+	da_mon = da_get_monitor(task->pid, NULL);
+	if (unlikely(!da_mon)) {
+		/* Slot registered; missing da_mon means concurrent destroy. */
+		rcu_read_unlock();
+		da_destroy_storage(task->pid);
+		atomic_dec(&tlob_num_monitored);
+		put_task_struct(task);
+		kmem_cache_free(tlob_state_cache, ws);
+		return -ENOMEM;
+	}
+	ha_mon = to_ha_monitor(da_mon);
+	now_ns = ktime_get_ns();
+	ha_reset_env(ha_mon, clk_elapsed_tlob, now_ns);
+	ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), now_ns);
+	rcu_read_unlock();
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
+	rcu_read_lock();
+	ws = da_get_target_by_id(task->pid);
+	if (!ws) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	da_mon = da_get_monitor(task->pid, NULL);
+	if (unlikely(!da_mon)) {
+		/* ws in hash but da_mon gone; internal inconsistency. */
+		rcu_read_unlock();
+		WARN_ON_ONCE(1);
+		return -ESRCH;
+	}
+
+	ha_mon = to_ha_monitor(da_mon);
+
+	/*
+	 * CAS (0->1) claims cleanup ownership under RCU (ws guaranteed valid).
+	 * _release pairs with atomic_read_acquire in ha_setup_invariants.
+	 */
+	if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0) {
+		rcu_read_unlock();
+		return -EAGAIN;
+	}
+
+	rcu_read_unlock();
+
+	/* Wait for in-flight timer callback before reading da_monitoring. */
+	ha_cancel_timer_sync(ha_mon);
+
+	/* Timer fired first -> budget exceeded; otherwise reset normally. */
+	rcu_read_lock();
+	budget_exceeded = !da_monitoring(da_mon);
+	if (!budget_exceeded)
+		da_monitor_reset(da_mon);
+	rcu_read_unlock();
+	da_destroy_storage(task->pid);
+	atomic_dec(&tlob_num_monitored);
+
+	put_task_struct(ws->task);
+	call_rcu(&ws->rcu, tlob_free_rcu);
+	return budget_exceeded ? -EOVERFLOW : 0;
+}
+EXPORT_SYMBOL_GPL(tlob_stop_task);
+
+static void tlob_stop_all(void)
+{
+	struct da_monitor_storage *ms;
+	pid_t pids[TLOB_MAX_MONITORED];
+	int bkt, n = 0;
+
+	/* Snapshot pids under RCU; re-derive ws under a fresh lock below. */
+	rcu_read_lock();
+	hash_for_each_rcu(da_monitor_ht, bkt, ms, node) {
+		if (ms->target && n < TLOB_MAX_MONITORED)
+			pids[n++] = ms->id;
+	}
+	rcu_read_unlock();
+
+	for (int i = 0; i < n; i++) {
+		pid_t pid = pids[i];
+		struct da_monitor *da_mon;
+		struct ha_monitor *ha_mon;
+		struct tlob_task_state *ws;
+
+		rcu_read_lock();
+		da_mon = da_get_monitor(pid, NULL);
+		if (!da_mon) {
+			/* Cleaned up by tlob_stop_task or exit handler. */
+			rcu_read_unlock();
+			continue;
+		}
+
+		ws = da_get_target(da_mon);
+		ha_mon = to_ha_monitor(da_mon);
+
+		/* CAS (0->1) claims ownership; skip if another caller won. */
+		if (atomic_cmpxchg_release(&ws->stopping, 0, 1) != 0) {
+			rcu_read_unlock();
+			continue;
+		}
+		rcu_read_unlock();
+
+		ha_cancel_timer_sync(ha_mon);
+
+		scoped_guard(rcu) {
+			da_monitor_reset(da_mon);
+		}
+		da_destroy_storage(pid);
+		atomic_dec(&tlob_num_monitored);
+		put_task_struct(ws->task);
+		call_rcu(&ws->rcu, tlob_free_rcu);
+	}
+}
+
+static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_regs *regs,
+				     __u64 *data)
+{
+	struct tlob_uprobe_binding *b = p->priv;
+
+	tlob_start_task(current, b->threshold_us);
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
+static int tlob_add_uprobe(u64 threshold_us, const char *binpath,
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
+	b->threshold_us = threshold_us;
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
+				 b->threshold_us);
+	}
+	mutex_unlock(&tlob_uprobe_mutex);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * Parse "p PATH:OFFSET_START OFFSET_STOP threshold=US".
+ * PATH may contain ':'; the last ':' separates path from offset.
+ * Returns 0 or -EINVAL.
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
+	/* Remaining tokens: OFFSET_STOP threshold=US */
+	while (p && (token = strsep(&p, " \t")) != NULL) {
+		if (!*token)
+			continue;
+		if (strncmp(token, "threshold=", 10) == 0) {
+			if (kstrtoull(token + 10, 0, &thr))
+				return -EINVAL;
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
+	if (!got_stop || !got_thr || thr == 0)
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
+	u64 threshold_us;
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
+	ret = tlob_parse_uprobe_line(buf, &threshold_us, &binpath,
+				     &offset_start, &offset_stop);
+	if (ret)
+		return ret;
+	mutex_lock(&tlob_uprobe_mutex);
+	ret = tlob_add_uprobe(threshold_us, binpath, offset_start, offset_stop);
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
+	atomic_set(&tlob_num_monitored, 0);
+
+	retval = da_monitor_init_prealloc(TLOB_MAX_MONITORED);
+	if (retval) {
+		kmem_cache_destroy(tlob_state_cache);
+		tlob_state_cache = NULL;
+		return retval;
+	}
+
+	/* Synthetic reference: held while the monitor is enabled. */
+	reinit_completion(&tlob_fd_released);
+	refcount_set(&tlob_fd_refcount, 1);
+
+	rv_this.enabled = 1;
+	return 0;
+}
+
+static void __tlob_destroy_monitor(void)
+{
+	rv_this.enabled = 0;
+	/*
+	 * Remove uprobes first so stop_task can't race with tlob_stop_all().
+	 * rv_uprobe_sync() inside ensures all in-flight handlers have finished.
+	 */
+	tlob_remove_all_uprobes();
+	tlob_stop_all();
+	/* Wait for tlob_free_rcu and da_pool_return_cb before pool teardown. */
+	synchronize_rcu();
+
+	/*
+	 * Drop the synthetic ref and wait for all open fds to close before
+	 * teardown; prevents kmem_cache_zalloc() on the destroyed cache.
+	 */
+	if (!refcount_dec_and_test(&tlob_fd_refcount))
+		wait_for_completion(&tlob_fd_released);
+
+	da_monitor_destroy();
+	kmem_cache_destroy(tlob_state_cache);
+	tlob_state_cache = NULL;
+}
+
+/* KUnit wrappers that acquire rv_interface_lock around monitor init/destroy. */
+#if IS_ENABLED(CONFIG_KUNIT)
+int tlob_init_monitor(void)
+{
+	int ret;
+
+	mutex_lock(&rv_interface_lock);
+	ret = __tlob_init_monitor();
+	mutex_unlock(&rv_interface_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tlob_init_monitor);
+
+void tlob_destroy_monitor(void)
+{
+	mutex_lock(&rv_interface_lock);
+	__tlob_destroy_monitor();
+	mutex_unlock(&rv_interface_lock);
+}
+EXPORT_SYMBOL_GPL(tlob_destroy_monitor);
+
+int tlob_num_monitored_read(void)
+{
+	return atomic_read(&tlob_num_monitored);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_num_monitored_read);
+
+/* Tracepoint probes for KUnit; rv_trace.h is only included here. */
+static struct tlob_captured_event     tlob_kunit_last_event;
+static struct tlob_captured_error_env tlob_kunit_last_error_env;
+static atomic_t tlob_kunit_event_cnt    = ATOMIC_INIT(0);
+static atomic_t tlob_kunit_error_env_cnt = ATOMIC_INIT(0);
+
+static void tlob_kunit_event_probe(void *data, int id, char *state, char *event,
+				   char *next_state, bool final_state)
+{
+	tlob_kunit_last_event.id = id;
+	strscpy(tlob_kunit_last_event.state, state,
+		sizeof(tlob_kunit_last_event.state));
+	strscpy(tlob_kunit_last_event.event, event,
+		sizeof(tlob_kunit_last_event.event));
+	strscpy(tlob_kunit_last_event.next_state, next_state,
+		sizeof(tlob_kunit_last_event.next_state));
+	tlob_kunit_last_event.final_state = final_state;
+	atomic_inc(&tlob_kunit_event_cnt);
+}
+
+static void tlob_kunit_error_env_probe(void *data, int id, char *state,
+				       char *event, char *env)
+{
+	tlob_kunit_last_error_env.id = id;
+	strscpy(tlob_kunit_last_error_env.state, state,
+		sizeof(tlob_kunit_last_error_env.state));
+	strscpy(tlob_kunit_last_error_env.event, event,
+		sizeof(tlob_kunit_last_error_env.event));
+	strscpy(tlob_kunit_last_error_env.env, env,
+		sizeof(tlob_kunit_last_error_env.env));
+	atomic_inc(&tlob_kunit_error_env_cnt);
+}
+
+int tlob_register_kunit_probes(void)
+{
+	int ret;
+
+	atomic_set(&tlob_kunit_event_cnt, 0);
+	atomic_set(&tlob_kunit_error_env_cnt, 0);
+
+	ret = register_trace_event_tlob(tlob_kunit_event_probe, NULL);
+	if (ret)
+		return ret;
+	ret = register_trace_error_env_tlob(tlob_kunit_error_env_probe, NULL);
+	if (ret) {
+		unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_register_kunit_probes);
+
+void tlob_unregister_kunit_probes(void)
+{
+	unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
+	unregister_trace_error_env_tlob(tlob_kunit_error_env_probe, NULL);
+	tracepoint_synchronize_unregister();
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_unregister_kunit_probes);
+
+int tlob_event_count_read(void)
+{
+	return atomic_read(&tlob_kunit_event_cnt);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_event_count_read);
+
+void tlob_event_count_reset(void)
+{
+	atomic_set(&tlob_kunit_event_cnt, 0);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_event_count_reset);
+
+int tlob_error_env_count_read(void)
+{
+	return atomic_read(&tlob_kunit_error_env_cnt);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_error_env_count_read);
+
+void tlob_error_env_count_reset(void)
+{
+	atomic_set(&tlob_kunit_error_env_cnt, 0);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_error_env_count_reset);
+
+const struct tlob_captured_event *tlob_last_event_read(void)
+{
+	return &tlob_kunit_last_event;
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_last_event_read);
+
+const struct tlob_captured_error_env *tlob_last_error_env_read(void)
+{
+	return &tlob_kunit_last_error_env;
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_last_error_env_read);
+
+#endif /* CONFIG_KUNIT */
+
+VISIBLE_IF_KUNIT int tlob_enable_hooks(void)
+{
+	rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("tlob", sched_process_exit, handle_sched_process_exit);
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_enable_hooks);
+
+VISIBLE_IF_KUNIT void tlob_disable_hooks(void)
+{
+	rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("tlob", sched_process_exit, handle_sched_process_exit);
+}
+EXPORT_SYMBOL_IF_KUNIT(tlob_disable_hooks);
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
+static void *tlob_chardev_bind(void)
+{
+	struct tlob_fpriv *fp;
+
+	fp = kzalloc_obj(*fp, GFP_KERNEL);
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	/* Pin cache/pool for fd lifetime; balanced in tlob_chardev_release.
+	 * If the synthetic ref has already been dropped (__tlob_destroy_monitor
+	 * ran to completion), reject the bind so the caller gets ENODEV instead
+	 * of corrupting a zero refcount.
+	 */
+	if (!refcount_inc_not_zero(&tlob_fd_refcount)) {
+		kfree(fp);
+		return ERR_PTR(-ENODEV);
+	}
+	return fp;
+}
+
+static void tlob_chardev_release(void *priv)
+{
+	struct tlob_fpriv *fp = priv;
+
+	if (fp->monitoring) {
+		/* All return values are safe on close. */
+		(void)tlob_stop_task(fp->task);
+		put_task_struct(fp->task);
+	}
+
+	kfree(fp);
+
+	/* Release fd's pin; if last, wake __tlob_destroy_monitor. */
+	if (refcount_dec_and_test(&tlob_fd_refcount))
+		complete(&tlob_fd_released);
+}
+
+static long tlob_chardev_ioctl(void *priv, unsigned int cmd, unsigned long arg)
+{
+	struct tlob_fpriv *fp = priv;
+	struct tlob_start_args args;
+	struct task_struct *task;
+	int ret;
+
+	switch (cmd) {
+	case TLOB_IOCTL_TRACE_START:
+		if (fp->monitoring)
+			return -EALREADY;
+
+		if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
+			return -EFAULT;
+
+		ret = tlob_start_task(current, args.threshold_us);
+		if (ret)
+			return ret;
+
+		fp->task = current;
+		get_task_struct(current);
+		fp->budget_exceeded = false;
+
+		/* Link fd so hrtimer callback can latch budget_exceeded. */
+		scoped_guard(rcu) {
+			struct tlob_task_state *ws = da_get_target_by_id(current->pid);
+
+			if (ws)
+				smp_store_release(&ws->fpriv, fp);
+		}
+
+		fp->monitoring = true;
+		return 0;
+
+	case TLOB_IOCTL_TRACE_STOP:
+		if (!fp->monitoring)
+			return -EINVAL;
+
+		task = fp->task;
+		fp->monitoring = false;
+		fp->task = NULL;
+
+		ret = tlob_stop_task(task);
+		put_task_struct(task);
+
+		/*
+		 * -EOVERFLOW: budget exceeded; propagate to caller.
+		 * -EAGAIN: concurrent stop_all claimed cleanup; fall through to
+		 *   budget_exceeded latch set by the hrtimer callback.
+		 * -ESRCH: task exited before TRACE_STOP (process-exit handler
+		 *   claimed cleanup); same latch applies.  Not an internal error.
+		 */
+		if (ret == -EAGAIN || ret == -ESRCH)
+			return READ_ONCE(fp->budget_exceeded) ? -EOVERFLOW : 0;
+		return ret;
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct rv_chardev_ops tlob_chardev_ops = {
+	.owner   = THIS_MODULE,
+	.bind    = tlob_chardev_bind,
+	.ioctl   = tlob_chardev_ioctl,
+	.release = tlob_chardev_release,
+};
+
+static int __init register_tlob(void)
+{
+	int ret;
+
+	ret = rv_chardev_register_monitor("tlob", &tlob_chardev_ops);
+	if (ret)
+		return ret;
+
+	ret = rv_register_monitor(&rv_this, NULL);
+	if (ret) {
+		rv_chardev_unregister_monitor("tlob");
+		return ret;
+	}
+
+	if (rv_this.root_d) {
+		if (!tracefs_create_file("monitor", 0644, rv_this.root_d, NULL,
+					 &tlob_monitor_fops)) {
+			rv_unregister_monitor(&rv_this);
+			rv_chardev_unregister_monitor("tlob");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void __exit unregister_tlob(void)
+{
+	rv_chardev_unregister_monitor("tlob");
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
index 000000000000..71c1735d27d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob.h
@@ -0,0 +1,171 @@
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
+ *   sleep     - sched_switch, prev_state != 0   running  → sleeping
+ *   preempt   - sched_switch, prev_state == 0   running  → waiting
+ *   wakeup    - sched_wakeup                    sleeping → waiting
+ *   switch_in - sched_switch, next == task      waiting  → running
+ *
+ * One HA clock invariant:
+ *   clk_elapsed < BUDGET_NS()  active in all states  (total latency budget)
+ *
+ * task_start and task_stop are NOT DA events:
+ *   task_start calls da_handle_start_event() to set initial state, then
+ *   ha_reset_clk_ns() + ha_start_timer_ns() to initialise the clock and arm
+ *   the timer directly.
+ *   task_stop calls hrtimer_cancel() + da_monitor_reset() directly.
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
+			sleeping_tlob,	/* sleep     (sched_switch, prev_state != 0) */
+			waiting_tlob,	/* preempt   (sched_switch, prev_state == 0) */
+			INVALID_STATE,	/* wakeup    (TASK_RUNNING can't be woken)   */
+			INVALID_STATE,	/* switch_in (already on CPU)                */
+		},
+		/* waiting */
+		{
+			INVALID_STATE,	/* sleep     (not on CPU)                    */
+			INVALID_STATE,	/* preempt   (not on CPU)                    */
+			INVALID_STATE,	/* wakeup    (already TASK_RUNNING)          */
+			running_tlob,	/* switch_in                                 */
+		},
+		/* sleeping */
+		{
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
+/* Exported to ioctl/uprobe layers and KUnit */
+int tlob_start_task(struct task_struct *task, u64 threshold_us);
+int tlob_stop_task(struct task_struct *task);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int tlob_init_monitor(void);
+void tlob_destroy_monitor(void);
+int tlob_enable_hooks(void);
+void tlob_disable_hooks(void);
+int tlob_create_or_delete_uprobe(char *buf);
+int tlob_num_monitored_read(void);
+
+struct tlob_captured_event {
+	int  id;
+	char state[16];
+	char event[16];
+	char next_state[16];
+	bool final_state;
+};
+
+struct tlob_captured_error_env {
+	int  id;
+	char state[16];
+	char event[16];
+	char env[64];
+};
+
+struct tlob_captured_detail {
+	int  pid;
+	u64  threshold_us;
+	u64  running_ns;
+	u64  waiting_ns;
+	u64  sleeping_ns;
+};
+
+int  tlob_register_kunit_probes(void);
+void tlob_unregister_kunit_probes(void);
+int  tlob_event_count_read(void);
+void tlob_event_count_reset(void);
+int  tlob_error_env_count_read(void);
+void tlob_error_env_count_reset(void);
+const struct tlob_captured_event     *tlob_last_event_read(void);
+const struct tlob_captured_error_env *tlob_last_error_env_read(void);
+const struct tlob_captured_detail    *tlob_last_detail_read(void);
+#endif /* CONFIG_KUNIT */
+
+#endif /* _RV_TLOB_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h b/kernel/trace/rv/monitors/tlob/tlob_trace.h
new file mode 100644
index 000000000000..08d34e1b0ab8
--- /dev/null
+++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h for tlob tracepoints.
+ *
+ * event_tlob and error_tlob are defined on the event_da_monitor_id and
+ * error_da_monitor_id classes, following the same pattern as nomiss.
+ * error_env_tlob carries the environment variable name that caused the
+ * clock-invariant violation (budget exceeded).
+ * The id field carries the pid of the monitored task.
+ */
+
+#ifdef CONFIG_RV_MON_TLOB
+/* id is the pid of the monitored task */
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
+ * detail_env_tlob - per-state time breakdown emitted alongside error_env_tlob.
+ *
+ * Fired once per budget violation, immediately after error_env_tlob, from
+ * the hrtimer callback (hardirq context).  The three _ns fields sum to
+ * approximately threshold_us * 1000; any rounding comes from the partial
+ * time accumulated in the current state since the last transition.
+ */
+TRACE_EVENT(detail_env_tlob,
+	TP_PROTO(int pid, u64 threshold_us,
+		 u64 running_ns, u64 waiting_ns, u64 sleeping_ns),
+	TP_ARGS(pid, threshold_us, running_ns, waiting_ns, sleeping_ns),
+	TP_STRUCT__entry(
+		__field(int,	pid)
+		__field(u64,	threshold_us)
+		__field(u64,	running_ns)
+		__field(u64,	waiting_ns)
+		__field(u64,	sleeping_ns)
+	),
+	TP_fast_assign(
+		__entry->pid		= pid;
+		__entry->threshold_us	= threshold_us;
+		__entry->running_ns	= running_ns;
+		__entry->waiting_ns	= waiting_ns;
+		__entry->sleeping_ns	= sleeping_ns;
+	),
+	TP_printk("pid=%d threshold_us=%llu running_ns=%llu waiting_ns=%llu sleeping_ns=%llu",
+		  __entry->pid, __entry->threshold_us,
+		  __entry->running_ns, __entry->waiting_ns,
+		  __entry->sleeping_ns)
+);
+#endif /* CONFIG_RV_MON_TLOB */
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..a45c4763dbe5 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -142,10 +142,17 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <kunit/visibility.h>
 
 #ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
 #include <rv_trace.h>
+
+#ifdef CONFIG_RV_MON_TLOB
+EXPORT_TRACEPOINT_SYMBOL_GPL(error_tlob);
+EXPORT_TRACEPOINT_SYMBOL_GPL(event_tlob);
+EXPORT_TRACEPOINT_SYMBOL_GPL(error_env_tlob);
+#endif
 #endif
 
 #include "rv.h"
@@ -696,6 +703,33 @@ static void turn_monitoring_on(void)
 	WRITE_ONCE(monitoring_on, true);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/**
+ * rv_kunit_monitoring_on - enable the global monitoring_on flag for KUnit tests.
+ *
+ * KUnit test suite_init functions must call this before initialising any
+ * monitor, mirroring the turn_monitoring_on() call in rv_init_interface().
+ * The matching rv_kunit_monitoring_off() must be called in suite_exit to
+ * restore the flag so that test suites do not interfere with each other.
+ */
+void rv_kunit_monitoring_on(void)
+{
+	turn_monitoring_on();
+}
+EXPORT_SYMBOL_IF_KUNIT(rv_kunit_monitoring_on);
+
+/**
+ * rv_kunit_monitoring_off - disable the global monitoring_on flag for KUnit tests.
+ *
+ * Must be called in suite_exit to restore global state after rv_kunit_monitoring_on().
+ */
+void rv_kunit_monitoring_off(void)
+{
+	turn_monitoring_off();
+}
+EXPORT_SYMBOL_IF_KUNIT(rv_kunit_monitoring_off);
+#endif /* CONFIG_KUNIT */
+
 static void turn_monitoring_on_with_reset(void)
 {
 	lockdep_assert_held(&rv_interface_lock);
@@ -846,6 +880,10 @@ int __init rv_init_interface(void)
 	if (retval)
 		return 1;
 
+	retval = rv_chardev_init();
+	if (retval)
+		return 1;
+
 	turn_monitoring_on();
 
 	rv_root.root_dir = no_free_ptr(root_dir);
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 2c0f51ff9d5c..82c9a2b57596 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -31,6 +31,8 @@ int rv_enable_monitor(struct rv_monitor *mon);
 bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
 
+int rv_chardev_init(void);
+
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root);
 int init_rv_reactors(struct dentry *root_dir);
diff --git a/kernel/trace/rv/rv_chardev.c b/kernel/trace/rv/rv_chardev.c
new file mode 100644
index 000000000000..1fba1642ebc1
--- /dev/null
+++ b/kernel/trace/rv/rv_chardev.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/rv.h>
+#include <uapi/linux/rv.h>
+
+#include "rv.h"
+
+static_assert(MAX_RV_MONITOR_NAME_SIZE == RV_MONITOR_NAME_MAX,
+	      "RV internal and UAPI monitor name size constants must match");
+
+struct rv_fd_priv {
+	const struct rv_chardev_ops	*ops;
+	void				*monitor_priv;
+};
+
+struct rv_chardev_entry {
+	char			name[MAX_RV_MONITOR_NAME_SIZE];
+	const struct rv_chardev_ops *ops;
+	struct list_head	list;
+};
+
+/* Protected by rv_interface_lock (from rv.h / rv.c). */
+static LIST_HEAD(rv_chardev_list);
+
+/**
+ * rv_chardev_register_monitor - expose a monitor via /dev/rv
+ * @name: Monitor name, must match the rv_monitor .name field.
+ * @ops:  Callbacks providing bind / ioctl / release.
+ *
+ * Returns 0 on success, -EINVAL if @name is too long, -EEXIST if @name is
+ * already registered, -ENOMEM on OOM.
+ */
+int rv_chardev_register_monitor(const char *name,
+				const struct rv_chardev_ops *ops)
+{
+	struct rv_chardev_entry *e, *existing;
+
+	if (strlen(name) >= MAX_RV_MONITOR_NAME_SIZE)
+		return -EINVAL;
+
+	e = kmalloc_obj(*e, GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	strscpy(e->name, name, sizeof(e->name));
+	e->ops = ops;
+
+	guard(mutex)(&rv_interface_lock);
+	list_for_each_entry(existing, &rv_chardev_list, list) {
+		if (strcmp(existing->name, name) == 0) {
+			kfree(e);
+			return -EEXIST;
+		}
+	}
+	list_add_tail(&e->list, &rv_chardev_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rv_chardev_register_monitor);
+
+/**
+ * rv_chardev_unregister_monitor - remove a monitor from the /dev/rv registry
+ * @name: Monitor name previously passed to rv_chardev_register_monitor().
+ *
+ * Existing bound fds remain valid; their ops pointer is stable until the
+ * fd is closed.  The caller must ensure no new binds to this monitor can
+ * succeed after unregistration — typically by unregistering before unloading
+ * the module that provides the ops.
+ */
+void rv_chardev_unregister_monitor(const char *name)
+{
+	struct rv_chardev_entry *e, *tmp;
+
+	guard(mutex)(&rv_interface_lock);
+	list_for_each_entry_safe(e, tmp, &rv_chardev_list, list) {
+		if (strcmp(e->name, name) == 0) {
+			list_del(&e->list);
+			kfree(e);
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(rv_chardev_unregister_monitor);
+
+static int rv_dev_open(struct inode *inode, struct file *file)
+{
+	struct rv_fd_priv *fp;
+
+	fp = kzalloc_obj(*fp, GFP_KERNEL);
+	if (!fp)
+		return -ENOMEM;
+
+	file->private_data = fp;
+	return 0;
+}
+
+static int rv_dev_release(struct inode *inode, struct file *file)
+{
+	struct rv_fd_priv *fp = file->private_data;
+
+	if (fp->ops) {
+		fp->ops->release(fp->monitor_priv);
+		module_put(fp->ops->owner);
+	}
+	kfree(fp);
+	return 0;
+}
+
+static int rv_bind_monitor(struct rv_fd_priv *fp, const char __user *uarg)
+{
+	const struct rv_chardev_ops *ops = NULL;
+	struct rv_bind_args args;
+	void *priv;
+
+	if (fp->ops)
+		return -EBUSY;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	args.monitor_name[RV_MONITOR_NAME_MAX - 1] = '\0';
+
+	/*
+	 * Pin the owning module while the list entry is still valid under
+	 * rv_interface_lock, preventing a concurrent rmmod from completing
+	 * between lookup and reference acquisition.  bind() may sleep
+	 * (GFP_KERNEL inside), so it runs after the lock is dropped.
+	 */
+	scoped_guard(mutex, &rv_interface_lock) {
+		struct rv_chardev_entry *e;
+
+		list_for_each_entry(e, &rv_chardev_list, list) {
+			if (strcmp(e->name, args.monitor_name) != 0)
+				continue;
+			if (!try_module_get(e->ops->owner))
+				return -ENODEV;
+			ops = e->ops;
+			break;
+		}
+	}
+
+	if (!ops)
+		return -ENOENT;
+
+	priv = ops->bind();
+	if (IS_ERR(priv)) {
+		module_put(ops->owner);
+		return PTR_ERR(priv);
+	}
+
+	fp->ops = ops;
+	fp->monitor_priv = priv;
+	return 0;
+}
+
+static long rv_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct rv_fd_priv *fp = file->private_data;
+
+	if (cmd == RV_IOCTL_BIND_MONITOR)
+		return rv_bind_monitor(fp, (const char __user *)arg);
+
+	if (!fp->ops)
+		return -ENXIO;
+
+	return fp->ops->ioctl(fp->monitor_priv, cmd, arg);
+}
+
+static __poll_t rv_dev_poll(struct file *file, poll_table *wait)
+{
+	struct rv_fd_priv *fp = file->private_data;
+
+	if (!fp->ops || !fp->ops->poll)
+		return 0;
+
+	return fp->ops->poll(fp->monitor_priv, file, wait);
+}
+
+static const struct file_operations rv_dev_fops = {
+	.owner		= THIS_MODULE,
+	.open		= rv_dev_open,
+	.release	= rv_dev_release,
+	.unlocked_ioctl	= rv_dev_ioctl,
+	.compat_ioctl	= rv_dev_ioctl,
+	.poll		= rv_dev_poll,
+};
+
+static struct miscdevice rv_miscdev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "rv",
+	.fops	= &rv_dev_fops,
+};
+
+int __init rv_chardev_init(void)
+{
+	return misc_register(&rv_miscdev);
+}
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
diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
index bc28399cfd4b..1ba7b80c1d87 100644
--- a/kernel/trace/rv/rv_uprobe.c
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -132,13 +132,10 @@ EXPORT_SYMBOL_GPL(rv_uprobe_attach);
  */
 void rv_uprobe_detach(struct rv_uprobe *p)
 {
-	struct rv_uprobe_impl *impl;
-
 	if (!p)
 		return;
 
-	impl = container_of(p, struct rv_uprobe_impl, pub);
-	uprobe_unregister_nosync(impl->uprobe, &impl->uc);
+	rv_uprobe_unregister_nosync(p);
 	/*
 	 * uprobe_unregister_sync() is a global barrier: it waits for all
 	 * in-flight uprobe handlers across the entire system to complete,
@@ -146,8 +143,47 @@ void rv_uprobe_detach(struct rv_uprobe *p)
 	 * guarantees that no handler touching impl->pub.priv is running by
 	 * the time we return, even if the caller immediately frees priv.
 	 */
+	rv_uprobe_sync();
+	rv_uprobe_free(p);
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_detach);
+
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
+{
+	struct rv_uprobe_impl *impl;
+
+	if (!p)
+		return;
+
+	impl = container_of(p, struct rv_uprobe_impl, pub);
+	uprobe_unregister_nosync(impl->uprobe, &impl->uc);
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ */
+void rv_uprobe_sync(void)
+{
 	uprobe_unregister_sync();
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_sync);
+
+/**
+ * rv_uprobe_free - release resources of a previously deregistered probe
+ */
+void rv_uprobe_free(struct rv_uprobe *p)
+{
+	struct rv_uprobe_impl *impl;
+
+	if (!p)
+		return;
+
+	impl = container_of(p, struct rv_uprobe_impl, pub);
 	path_put(&p->path);
 	kfree(impl);
 }
-EXPORT_SYMBOL_GPL(rv_uprobe_detach);
+EXPORT_SYMBOL_GPL(rv_uprobe_free);
diff --git a/tools/include/uapi/linux/rv.h b/tools/include/uapi/linux/rv.h
new file mode 100644
index 000000000000..a34e5426393b
--- /dev/null
+++ b/tools/include/uapi/linux/rv.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * UAPI definitions for Runtime Verification (RV) monitors.
+ *
+ * All RV monitors that expose an ioctl self-instrumentation interface
+ * share the magic byte RV_IOC_MAGIC ('r').
+ *
+ * Usage examples and design rationale are in:
+ *   Documentation/trace/rv/monitor_tlob.rst
+ */
+
+#ifndef _UAPI_LINUX_RV_H
+#define _UAPI_LINUX_RV_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Magic byte shared by all RV monitor ioctls. */
+#define RV_IOC_MAGIC		'r'
+
+/* Maximum monitor name length (including NUL terminator). */
+#define RV_MONITOR_NAME_MAX	32
+
+/* Generic /dev/rv ioctls (ioctl numbers 0–15 are reserved for the core) */
+
+/**
+ * struct rv_bind_args - arguments for RV_IOCTL_BIND_MONITOR
+ * @monitor_name: NUL-terminated name of the monitor to bind (e.g. "tlob").
+ */
+struct rv_bind_args {
+	char monitor_name[RV_MONITOR_NAME_MAX];
+};
+
+/*
+ * RV_IOCTL_BIND_MONITOR - associate this fd with a specific RV monitor.
+ *
+ * Must be called once after open() and before any monitor-specific ioctl.
+ *
+ * Returns 0 on success.
+ * Returns -EBUSY  if this fd is already bound to a monitor.
+ * Returns -ENOENT if the requested monitor is not registered.
+ * Returns -ENOMEM on allocation failure.
+ */
+#define RV_IOCTL_BIND_MONITOR	_IOW(RV_IOC_MAGIC, 0, struct rv_bind_args)
+
+/* tlob: task latency over budget monitor (ioctl numbers 1–15) */
+
+/**
+ * struct tlob_start_args - arguments for TLOB_IOCTL_TRACE_START
+ * @threshold_us: Total latency budget for this window, in microseconds.
+ *               Must be greater than zero.  Both on-CPU and off-CPU time
+ *               (including runqueue wait) count toward this budget.
+ */
+struct tlob_start_args {
+	__u64 threshold_us;
+};
+
+/*
+ * TLOB_IOCTL_TRACE_START - begin monitoring the calling task.
+ *
+ * Arms a per-task hrtimer for threshold_us microseconds (CLOCK_MONOTONIC,
+ * so both on-CPU and off-CPU time count toward the budget).
+ *
+ * Returns 0 on success.
+ * Returns -EEXIST if TRACE_START was already called on this fd.
+ * Returns -ENOSPC if TLOB_MAX_MONITORED tasks are already being tracked.
+ * Returns -ENOMEM on allocation failure.
+ * Returns -ENODEV if the tlob monitor is not enabled.
+ * Returns -ERANGE if threshold_us is 0.
+ */
+#define TLOB_IOCTL_TRACE_START	_IOW(RV_IOC_MAGIC, 1, struct tlob_start_args)
+
+/*
+ * TLOB_IOCTL_TRACE_STOP - end monitoring the calling task.
+ *
+ * Returns 0 if within budget.
+ * Returns -EOVERFLOW if the latency budget was exceeded.
+ * Returns -EINVAL if TLOB_IOCTL_TRACE_START was not called on this fd.
+ *
+ * poll/epoll: after TRACE_START the fd becomes readable (EPOLLIN) when the
+ * budget is exceeded.  The caller may then issue TRACE_STOP to retrieve the
+ * result, or simply close the fd to clean up.
+ */
+#define TLOB_IOCTL_TRACE_STOP	_IO(RV_IOC_MAGIC, 2)
+
+#endif /* _UAPI_LINUX_RV_H */
-- 
2.25.1

