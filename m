Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812A331236
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940701; cv=none; b=piix4DMz/csaqCcjo+XhH/WmzEEJPtpRm73TJ0E/Hh9MgebGiPpidNNq8VgjrfVIQLrd83JvrGrGAzu53yUWSAE5AHGkWpj3TJO//IQNOicL6BAvT37HFbfFM90VfUuZy4SbNa+GcP7xpJEv0xkaBf2JclQw25ddglA3mlj6I7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940701; c=relaxed/simple;
	bh=vRoiUkHhty69DmiZzizswQMZUC6qUgKmStlrCcfA3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKa3aWdgk4lNii3J4pwuHDO5QTAGFP5zb4k40I+NWzwhuuGtI2KyBrCYQns6qog6KZN7IV0GsLbMmGvtOY0ZbZtuulHk1jzZBZAtxSu3EUSweTb8dbAtYl7N5rg8Dy03lLydB29qqC75pRS3WOIFNdf+kwh+Ik9GRxfpQFj6IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCKFJ50Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCKFJ50Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICOmQ7fc5SQrnAuXkV7VaT/+VP+aLo06mkMalK5kUN8=;
	b=fCKFJ50YL0FcDQwhm5lmIBVO+9hOSpGItHOURUCLOH13gLFErIuYs7/5Wgne0xfTkyzks+
	ow9mMH0+YDfvqEWz+pExj83rEmBlBBE2wL2BVrRnTy3FLbEa3oofuf+pyhLdGaySbmihq8
	L1v8Om2Q4qUi7lWQfl1KaCCWdgxsWWY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-zAaaEvUWPuOwqa8iv2sfCw-1; Fri,
 05 Dec 2025 08:18:02 -0500
X-MC-Unique: zAaaEvUWPuOwqa8iv2sfCw-1
X-Mimecast-MFC-AGG-ID: zAaaEvUWPuOwqa8iv2sfCw_1764940681
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0106C18002C1;
	Fri,  5 Dec 2025 13:18:01 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CB6B180044F;
	Fri,  5 Dec 2025 13:17:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 13/13] rv: Add dl_server specific monitors
Date: Fri,  5 Dec 2025 14:16:21 +0100
Message-ID: <20251205131621.135513-14-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add monitors to validate the behaviour of the deadline server.

The currently implemented monitors are:
* boost
    fair tasks run either independently or boosted
* laxity
    deferrable servers wait for zero-laxity and run

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_deadline.rst   | 115 ++++++++
 kernel/trace/rv/Kconfig                       |   2 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/boost/Kconfig        |  15 +
 kernel/trace/rv/monitors/boost/boost.c        | 279 ++++++++++++++++++
 kernel/trace/rv/monitors/boost/boost.h        | 159 ++++++++++
 kernel/trace/rv/monitors/boost/boost_trace.h  |  19 ++
 kernel/trace/rv/monitors/laxity/Kconfig       |  14 +
 kernel/trace/rv/monitors/laxity/laxity.c      | 226 ++++++++++++++
 kernel/trace/rv/monitors/laxity/laxity.h      | 126 ++++++++
 .../trace/rv/monitors/laxity/laxity_trace.h   |  19 ++
 kernel/trace/rv/rv_trace.h                    |   2 +
 tools/verification/models/deadline/boost.dot  |  51 ++++
 tools/verification/models/deadline/laxity.dot |  34 +++
 14 files changed, 1063 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/boost/Kconfig
 create mode 100644 kernel/trace/rv/monitors/boost/boost.c
 create mode 100644 kernel/trace/rv/monitors/boost/boost.h
 create mode 100644 kernel/trace/rv/monitors/boost/boost_trace.h
 create mode 100644 kernel/trace/rv/monitors/laxity/Kconfig
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.c
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.h
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity_trace.h
 create mode 100644 tools/verification/models/deadline/boost.dot
 create mode 100644 tools/verification/models/deadline/laxity.dot

diff --git a/Documentation/trace/rv/monitor_deadline.rst b/Documentation/trace/rv/monitor_deadline.rst
index 481748adaac3..e5cf5db91650 100644
--- a/Documentation/trace/rv/monitor_deadline.rst
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -149,3 +149,118 @@ replenish on an idle CPU, meaningful only for servers::
  +---------------+ <-+                                                ^
          |                                                            |
          +---------------- dl_throttle;is_constr_dl == 1 -------------+
+
+Monitor boost
+~~~~~~~~~~~~~
+
+The boost monitor ensures tasks associated to a server (e.g. fair tasks) run
+either independently or boosted in a timely manner.
+Unlike other models, the ``running`` state (and the ``switch_in/out`` events)
+indicates that any fair task is running, this needs to happen within a
+threshold that depends on server deadline and remaining runtime, whenever a
+task is ready.
+
+The following chart is simplified to avoid confusion, several less important
+self-loops on states have been removed and event names have been simplified:
+
+* ``idle`` (``dl_server_idle``) occurs when the CPU runs the idle task.
+* ``start/stop`` (``dl_server_start/stop``) start and stop the server.
+* ``switch`` (``sched_switch_in/out``) represented as a double arrow to
+  indicate both events are present: ``ready/throttled -- switch_in ->
+  running/throttled_running`` and vice versa with ``switch_out``. As stated
+  above this fires when any fair task starting or stopping to run.
+* ``resume/resume_throttle``: a fair task woke up, potentially when the server
+  is throttled (no runtime left), this event is especially frequent on self
+  loops (no state change during a wakeup) but is removed here for clarity.
+* arrows merges with an ``x`` sign to indicate they are the same event going to
+  the same state (but with different origins). The ``+`` sign indicates normal
+  crossings or corners.
+
+Refer to the dot file for the full specification::
+
+		|
+		v
+      #=========#           idle          +----------+
+      H         H <----- switch_out ----- |          |
+  +-->H stopped H                         | stopping |
+  |   H         H --+                     |          |
+  |   #=========#   |                     +----------+
+  |     ^           |                          ^
+  |     |           |          stop;reset(clk) |           replenish;reset(clk)
+  |   stop          |                          |                       +--+
+  |     |      start;reset(clk)                +--------------------+  |  |
+  |     |           v                                               |  |  v
+  |     +--------- +---------------+ <---------- switch --------> +---------+
+  |                |     ready     |                              |         |
+  |   +- resume -> |               | -replenish;reset(clk)        | running |
+  |   |            | clk < thesh() |   |                          |         |
+  |   |  +- idle - +---------------+ <-+        +---------------- +---------+
+  |   |  |         |  ^                         |                   ^    |
+  |   |  |         |  |                       throttle              |    |
+  |   |  |         |  |replenish;reset(clk)     |                   |    |
+  |   |  |  throttle  |                         |   replenish;reset(clk) |
+  |   |  |         |  |                         |                   |    |
+  |   |  |         v  |                         v                   |    |
+  |   |  |   +---------+    switch    +-------------------+         |    |
+  x---+--+-- |         | <----------> | throttled_running | --------+    |
+  |   |  |   |throttled|              +-------------------+              |
+  |   |  |   |         | -----+            |                             |
+  |   |  |   +---------+      |            |                             |
+  |   |  |      ^             |            |                             |
+  |   |  | resume_throttle    |            |                             |
+ stop |  |      |             |            |                             |
+  |   |  v      |             |            |                             |
+  |   +---------+ <-----------x--- idle ---x-----------------------------+
+  |   |         |
+  +-- |  idle   | <--+
+      |         |    | replenish;reset(clk)
+      +---------+ ---+
+
+Monitor laxity
+~~~~~~~~~~~~~~
+
+The laxity monitor ensure deferrable servers go to a zero-laxity wait unless
+already running and run in starvation cases. The model can stay in the
+zero-laxity wait only for a limited time depending on deadline and runtime,
+then the server either prepares to stop (after ``idle_wait``) or prepares to
+boost a task (``running``). Boosting (``sched_switch_in``) is only allowed in
+the ``running`` state::
+
+                                                    |
+  +----- dl_server_stop -----+                      |
+  |                          v                      v
+  |             #=======================================#
+  |    +------- H                stopped                H
+  |    |        #=======================================#
+  |    |          |                             ^
+  |    |  dl_server_start_running;        dl_server_stop
+  |    |        reset(clk)                      |
+  |    |          v                             |     dl_replenish_running;
+  |    |     +-------------------------------------+     clk < REPLENISH_NS
+  |    |     |                                     | -------------+
+  |    |     |                running              |              |
+  |    |     |                                     | <------------+
+  |    |     +-------------------------------------+
+  |    |       |                  ^              ^
+  |    |  dl_throttle    dl_replenish_running    |
+  |    |       v                  |              |
+  |    |     +-----------------+  |              |
+  |    |     | replenish_wait  | -+              |
+  |    |     +-----------------+                 |
+  |    |                   |                     |
+  |    |         dl_replenish;reset(clk)         | dl_replenish_running
+  |    |         dl_replenish_idle;reset(clk)    |
+  |    |                   v                     |
+  | dl_server_start;     +--------------------------+   dl_replenish;reset(clk)
+  |    reset(clk)        |     zero_laxity_wait     | -------------+
+  |    |                 |     clk < laxity_ns()    |              |
+  |    +---------------> |                          | <------------+
+  |                      +--------------------------+
+  |                              |                 ^
+  | dl_replenish_idle;reset(clk) |      dl_replenish;reset(clk)
+  |                              v                 |
+  |                   +-------------------------+  |
+  +------------------ |        idle_wait        | -+
+                      +-------------------------+
+                                ^     dl_replenish_idle;reset(clk)
+                                +-------------+
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 719cdcfb6d41..139443e0e51c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -82,6 +82,8 @@ source "kernel/trace/rv/monitors/stall/Kconfig"
 source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 source "kernel/trace/rv/monitors/throttle/Kconfig"
+source "kernel/trace/rv/monitors/boost/Kconfig"
+source "kernel/trace/rv/monitors/laxity/Kconfig"
 # Add new deadline monitors here
 
 # Add new monitors here
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 15a1edc8bd0f..4cf15c189a96 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_THROTTLE) += monitors/throttle/throttle.o
+obj-$(CONFIG_RV_MON_BOOST) += monitors/boost/boost.o
+obj-$(CONFIG_RV_MON_LAXITY) += monitors/laxity/laxity.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/boost/Kconfig b/kernel/trace/rv/monitors/boost/Kconfig
new file mode 100644
index 000000000000..3fa121f77729
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_BOOST
+	depends on RV
+	depends on RV_MON_DEADLINE
+	default y
+	select HA_MON_EVENTS_ID
+	bool "boost monitor"
+	help
+	  Monitor to ensure tasks associated to a server (e.g. fair tasks) run
+	  either independently or boosted in a timely manner.
+	  This monitor is part of the deadline monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_deadline.rst
diff --git a/kernel/trace/rv/monitors/boost/boost.c b/kernel/trace/rv/monitors/boost/boost.c
new file mode 100644
index 000000000000..1f940dc7a9c5
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/boost.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "boost"
+
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define DA_SKIP_AUTO_ALLOC
+#define HA_TIMER_TYPE HA_TIMER_WHEEL
+typedef struct sched_dl_entity *monitor_target;
+#include "boost.h"
+#include <rv/ha_monitor.h>
+#include <monitors/deadline/deadline.h>
+
+#define STOPPING_NS TICK_NSEC
+
+static inline u64 server_threshold_ns(struct ha_monitor *ha_mon)
+{
+	struct sched_dl_entity *dl_se = ha_get_target(ha_mon);
+
+	return dl_se->dl_deadline + TICK_NSEC - dl_se->runtime;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_boost env, u64 time_ns)
+{
+	if (env == clk_boost)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_boost env, u64 time_ns)
+{
+	if (env == clk_boost)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == ready_boost)
+		return ha_check_invariant_ns(ha_mon, clk_boost, time_ns);
+	else if (curr_state == stopping_boost)
+		return ha_check_invariant_ns(ha_mon, clk_boost, time_ns);
+	return true;
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == ready_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == running_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == running_boost && event == dl_server_stop_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == stopped_boost && event == dl_server_start_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == throttled_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == throttled_running_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != dl_replenish_boost)
+		return;
+	if (next_state == ready_boost)
+		ha_start_timer_ns(ha_mon, clk_boost, server_threshold_ns(ha_mon), time_ns);
+	else if (next_state == stopping_boost)
+		ha_start_timer_ns(ha_mon, clk_boost, STOPPING_NS, time_ns);
+	else if (curr_state == ready_boost)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == stopping_boost)
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
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_boost);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	struct sched_dl_entity *dl_se = get_fair_server(next);
+	int cpu = task_cpu(next);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * This monitor considers switch in/out whenever a task related to the
+	 * server (i.e. fair) is scheduled in or out, boosted or not.
+	 * Any switch to the same policy is ignored.
+	 * Note: idle may race with concurrent wakeup/migration events.
+	 */
+	if (!dl_se || (next->policy == prev->policy && !is_idle_task(next) &&
+		    !is_idle_task(prev)))
+		return;
+	if (is_idle_task(next))
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_server_idle_boost);
+	else if (next->policy == SCHED_NORMAL)
+		da_handle_event(EXPAND_ID(dl_se, cpu), sched_switch_in_boost);
+	else if (prev->policy == SCHED_NORMAL && !is_idle_task(prev))
+		da_handle_event(EXPAND_ID(dl_se, cpu), sched_switch_out_boost);
+}
+
+static void handle_syscall(void *data, struct pt_regs *regs, long id)
+{
+	struct sched_dl_entity *dl_se;
+	struct task_struct *p;
+	int new_policy = -1;
+
+	new_policy = extract_params(regs, id, &p);
+	if (new_policy < 0 || new_policy == p->policy)
+		return;
+	dl_se = get_fair_server(p);
+	if (!dl_se || !p->on_rq)
+		return;
+	/*
+	 * Note: this attaches to the syscall entry and is unstable:
+	 * - the syscall may fail
+	 * - the task may be preempted before changing the policy
+	 * A more robust solution can be written using enqueue/dequeue events.
+	 */
+	if (p->policy == SCHED_NORMAL)
+		da_handle_event(EXPAND_ID(dl_se, task_cpu(p)), sched_switch_out_boost);
+	else if (new_policy == SCHED_NORMAL)
+		da_handle_event(EXPAND_ID(dl_se, task_cpu(p)), dl_server_resume_boost);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *tsk)
+{
+	struct sched_dl_entity *dl_se = get_fair_server(tsk);
+
+	if (dl_se && tsk->policy == SCHED_NORMAL) {
+		da_handle_event(EXPAND_ID(dl_se, task_cpu(tsk)),
+				dl_se->runtime > 0 ?
+					dl_server_resume_boost :
+					dl_server_resume_throttled_boost);
+	}
+}
+
+static void handle_sched_migrate(void *data, struct task_struct *p, int dest_cpu)
+{
+	struct sched_dl_entity *orig_dl_se, *dest_dl_se;
+
+	if (p->policy != SCHED_NORMAL)
+		return;
+	orig_dl_se = get_fair_server(p);
+	dest_dl_se = da_get_target_by_id(fair_server_id(dest_cpu));
+	if (orig_dl_se && idle_cpu(task_cpu(p)))
+		da_handle_event(EXPAND_ID(orig_dl_se, task_cpu(p)), dl_server_idle_boost);
+	if (dest_dl_se) {
+		da_handle_event(EXPAND_ID(dest_dl_se, dest_cpu),
+				dest_dl_se->runtime > 0 ?
+					dl_server_resume_boost :
+					dl_server_resume_throttled_boost);
+	}
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_server_start_boost);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_start_event(EXPAND_ID(dl_se, cpu), dl_server_stop_boost);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_throttle_boost);
+}
+
+static int enable_boost(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	retval = init_storage(true);
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("boost", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("boost", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_attach_trace_probe("boost", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_attach_trace_probe("boost", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("boost", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("boost", sched_wakeup_new, handle_sched_wakeup);
+	rv_attach_trace_probe("boost", sched_migrate_task, handle_sched_migrate);
+	rv_attach_trace_probe("boost", sched_switch, handle_sched_switch);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("boost", sys_enter, handle_syscall);
+
+	return 0;
+}
+
+static void disable_boost(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("boost", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_detach_trace_probe("boost", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_detach_trace_probe("boost", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("boost", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("boost", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("boost", sched_wakeup_new, handle_sched_wakeup);
+	rv_detach_trace_probe("boost", sched_migrate_task, handle_sched_migrate);
+	rv_detach_trace_probe("boost", sched_switch, handle_sched_switch);
+	if (!should_skip_syscall_handle())
+		rv_detach_trace_probe("boost", sys_enter, handle_syscall);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "boost",
+	.description = "fair tasks run either independently or boosted.",
+	.enable = enable_boost,
+	.disable = disable_boost,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_boost(void)
+{
+	return rv_register_monitor(&rv_this, &rv_deadline);
+}
+
+static void __exit unregister_boost(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_boost);
+module_exit(unregister_boost);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("boost: fair tasks run either independently or boosted.");
diff --git a/kernel/trace/rv/monitors/boost/boost.h b/kernel/trace/rv/monitors/boost/boost.h
new file mode 100644
index 000000000000..2d7b6116b1d0
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/boost.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of boost automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME boost
+
+enum states_boost {
+	stopped_boost,
+	idle_boost,
+	ready_boost,
+	running_boost,
+	stopping_boost,
+	throttled_boost,
+	throttled_running_boost,
+	state_max_boost,
+};
+
+#define INVALID_STATE state_max_boost
+
+enum events_boost {
+	dl_replenish_boost,
+	dl_server_idle_boost,
+	dl_server_resume_boost,
+	dl_server_resume_throttled_boost,
+	dl_server_start_boost,
+	dl_server_stop_boost,
+	dl_throttle_boost,
+	sched_switch_in_boost,
+	sched_switch_out_boost,
+	event_max_boost,
+};
+
+enum envs_boost {
+	clk_boost,
+	env_max_boost,
+	env_max_stored_boost = env_max_boost,
+};
+
+_Static_assert(env_max_stored_boost <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_CLK_NS
+
+struct automaton_boost {
+	char *state_names[state_max_boost];
+	char *event_names[event_max_boost];
+	char *env_names[env_max_boost];
+	unsigned char function[state_max_boost][event_max_boost];
+	unsigned char initial_state;
+	bool final_states[state_max_boost];
+};
+
+static const struct automaton_boost automaton_boost = {
+	.state_names = {
+		"stopped",
+		"idle",
+		"ready",
+		"running",
+		"stopping",
+		"throttled",
+		"throttled_running",
+	},
+	.event_names = {
+		"dl_replenish",
+		"dl_server_idle",
+		"dl_server_resume",
+		"dl_server_resume_throttled",
+		"dl_server_start",
+		"dl_server_stop",
+		"dl_throttle",
+		"sched_switch_in",
+		"sched_switch_out",
+	},
+	.env_names = {
+		"clk",
+	},
+	.function = {
+		{
+			INVALID_STATE,
+			stopped_boost,
+			stopped_boost,
+			stopped_boost,
+			ready_boost,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			stopped_boost,
+		},
+		{
+			idle_boost,
+			idle_boost,
+			ready_boost,
+			throttled_boost,
+			INVALID_STATE,
+			stopped_boost,
+			idle_boost,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			ready_boost,
+			idle_boost,
+			ready_boost,
+			ready_boost,
+			INVALID_STATE,
+			stopped_boost,
+			throttled_boost,
+			running_boost,
+			ready_boost,
+		},
+		{
+			running_boost,
+			idle_boost,
+			running_boost,
+			running_boost,
+			INVALID_STATE,
+			stopping_boost,
+			throttled_running_boost,
+			INVALID_STATE,
+			ready_boost,
+		},
+		{
+			INVALID_STATE,
+			stopped_boost,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			stopped_boost,
+		},
+		{
+			ready_boost,
+			idle_boost,
+			INVALID_STATE,
+			throttled_boost,
+			INVALID_STATE,
+			stopped_boost,
+			throttled_boost,
+			throttled_running_boost,
+			INVALID_STATE,
+		},
+		{
+			running_boost,
+			idle_boost,
+			INVALID_STATE,
+			throttled_running_boost,
+			INVALID_STATE,
+			INVALID_STATE,
+			throttled_running_boost,
+			INVALID_STATE,
+			throttled_boost,
+		},
+	},
+	.initial_state = stopped_boost,
+	.final_states = { 1, 0, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/boost/boost_trace.h b/kernel/trace/rv/monitors/boost/boost_trace.h
new file mode 100644
index 000000000000..7e422b0e586d
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/boost_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_BOOST
+DEFINE_EVENT(event_da_monitor_id, event_boost,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_boost,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_boost,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_BOOST */
diff --git a/kernel/trace/rv/monitors/laxity/Kconfig b/kernel/trace/rv/monitors/laxity/Kconfig
new file mode 100644
index 000000000000..7ba69405d09b
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_LAXITY
+	depends on RV
+	depends on RV_MON_DEADLINE
+	default y
+	select HA_MON_EVENTS_ID
+	bool "laxity monitor"
+	help
+	  Monitor to ensure deferrable servers go to a zero-laxity wait unless
+	  already running and run in starvation cases.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_deadline.rst
diff --git a/kernel/trace/rv/monitors/laxity/laxity.c b/kernel/trace/rv/monitors/laxity/laxity.c
new file mode 100644
index 000000000000..5a2ef4a4ec9b
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/laxity.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "laxity"
+
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_WHEEL
+/* The start condition is on server_stop, allocation likely fails on PREEMPT_RT */
+#define DA_SKIP_AUTO_ALLOC
+typedef struct sched_dl_entity *monitor_target;
+#include "laxity.h"
+#include <rv/ha_monitor.h>
+#include <monitors/deadline/deadline.h>
+
+/* with sched_feat(HRTICK_DL) the threshold can be lower */
+#define RUNTIME_THRESH TICK_NSEC
+
+/* allow replenish when running only right after server start */
+#define REPLENISH_NS TICK_NSEC
+
+static inline u64 laxity_ns(struct ha_monitor *ha_mon)
+{
+	struct sched_dl_entity *dl_se = pi_of(ha_get_target(ha_mon));
+
+	return dl_se->dl_deadline - dl_se->runtime + RUNTIME_THRESH;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_laxity env, u64 time_ns)
+{
+	if (env == clk_laxity)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_laxity env, u64 time_ns)
+{
+	if (env == clk_laxity)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == zero_laxity_wait_laxity)
+		return ha_check_invariant_ns(ha_mon, clk_laxity, time_ns);
+	return true;
+}
+
+static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == next_state)
+		return;
+	if (curr_state == zero_laxity_wait_laxity)
+		ha_inv_to_guard(ha_mon, clk_laxity, laxity_ns(ha_mon), time_ns);
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == idle_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == running_laxity && event == dl_replenish_running_laxity)
+		res = ha_monitor_env_invalid(ha_mon, clk_laxity) ||
+		      ha_get_env(ha_mon, clk_laxity, time_ns) < REPLENISH_NS;
+	else if (curr_state == stopped_laxity && event == dl_server_start_running_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == stopped_laxity && event == dl_server_start_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != dl_replenish_idle_laxity &&
+	    event != dl_replenish_laxity)
+		return;
+	if (next_state == zero_laxity_wait_laxity)
+		ha_start_timer_ns(ha_mon, clk_laxity, laxity_ns(ha_mon), time_ns);
+	else if (curr_state == zero_laxity_wait_laxity)
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
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	/* Special replenish happening after throttle, ignore it */
+	if (dl_se->dl_defer_running && dl_se->dl_throttled)
+		return;
+	if (dl_se->dl_defer_running)
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_running_laxity);
+	else if (idle_cpu(cpu) || (smp_processor_id() == cpu && is_idle_task(current)))
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_idle_laxity);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_laxity);
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	if (dl_se->dl_defer_running)
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_server_start_running_laxity);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_server_start_laxity);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_start_event(EXPAND_ID(dl_se, cpu), dl_server_stop_laxity);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_throttle_laxity);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (next->dl_server)
+		da_handle_start_event(EXPAND_ID(next->dl_server, task_cpu(next)),
+				      sched_switch_in_laxity);
+}
+
+static int enable_laxity(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	retval = init_storage(true);
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("laxity", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("laxity", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_attach_trace_probe("laxity", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_attach_trace_probe("laxity", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("laxity", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_laxity(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("laxity", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_detach_trace_probe("laxity", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_detach_trace_probe("laxity", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("laxity", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("laxity", sched_switch, handle_sched_switch);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "laxity",
+	.description = "deferrable servers wait for zero-laxity and run.",
+	.enable = enable_laxity,
+	.disable = disable_laxity,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_laxity(void)
+{
+	return rv_register_monitor(&rv_this, &rv_deadline);
+}
+
+static void __exit unregister_laxity(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_laxity);
+module_exit(unregister_laxity);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("laxity: deferrable servers wait for zero-laxity and run.");
diff --git a/kernel/trace/rv/monitors/laxity/laxity.h b/kernel/trace/rv/monitors/laxity/laxity.h
new file mode 100644
index 000000000000..3fdab88be535
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/laxity.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of laxity automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME laxity
+
+enum states_laxity {
+	stopped_laxity,
+	idle_wait_laxity,
+	replenish_wait_laxity,
+	running_laxity,
+	zero_laxity_wait_laxity,
+	state_max_laxity,
+};
+
+#define INVALID_STATE state_max_laxity
+
+enum events_laxity {
+	dl_replenish_laxity,
+	dl_replenish_idle_laxity,
+	dl_replenish_running_laxity,
+	dl_server_start_laxity,
+	dl_server_start_running_laxity,
+	dl_server_stop_laxity,
+	dl_throttle_laxity,
+	sched_switch_in_laxity,
+	event_max_laxity,
+};
+
+enum envs_laxity {
+	clk_laxity,
+	env_max_laxity,
+	env_max_stored_laxity = env_max_laxity,
+};
+
+_Static_assert(env_max_stored_laxity <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_CLK_NS
+
+struct automaton_laxity {
+	char *state_names[state_max_laxity];
+	char *event_names[event_max_laxity];
+	char *env_names[env_max_laxity];
+	unsigned char function[state_max_laxity][event_max_laxity];
+	unsigned char initial_state;
+	bool final_states[state_max_laxity];
+};
+
+static const struct automaton_laxity automaton_laxity = {
+	.state_names = {
+		"stopped",
+		"idle_wait",
+		"replenish_wait",
+		"running",
+		"zero_laxity_wait",
+	},
+	.event_names = {
+		"dl_replenish",
+		"dl_replenish_idle",
+		"dl_replenish_running",
+		"dl_server_start",
+		"dl_server_start_running",
+		"dl_server_stop",
+		"dl_throttle",
+		"sched_switch_in",
+	},
+	.env_names = {
+		"clk",
+	},
+	.function = {
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			zero_laxity_wait_laxity,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			zero_laxity_wait_laxity,
+			idle_wait_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			stopped_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			zero_laxity_wait_laxity,
+			zero_laxity_wait_laxity,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			stopped_laxity,
+			replenish_wait_laxity,
+			running_laxity,
+		},
+		{
+			zero_laxity_wait_laxity,
+			idle_wait_laxity,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = stopped_laxity,
+	.final_states = { 1, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/laxity/laxity_trace.h b/kernel/trace/rv/monitors/laxity/laxity_trace.h
new file mode 100644
index 000000000000..32580dba8f42
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/laxity_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_LAXITY
+DEFINE_EVENT(event_da_monitor_id, event_laxity,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_laxity,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_laxity,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_LAXITY */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 1bf0f3666ee4..f1d55c39dc48 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -190,6 +190,8 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
 #include <monitors/throttle/throttle_trace.h>
+#include <monitors/boost/boost_trace.h>
+#include <monitors/laxity/laxity_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/deadline/boost.dot b/tools/verification/models/deadline/boost.dot
new file mode 100644
index 000000000000..ee7bae1e8feb
--- /dev/null
+++ b/tools/verification/models/deadline/boost.dot
@@ -0,0 +1,51 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "idle"};
+	{node [shape = circle] "ready"};
+	{node [shape = circle] "running"};
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = doublecircle] "stopped"};
+	{node [shape = circle] "stopped"};
+	{node [shape = circle] "stopping"};
+	{node [shape = circle] "throttled"};
+	{node [shape = circle] "throttled_running"};
+	"__init_stopped" -> "stopped";
+	"idle" [label = "idle"];
+	"idle" -> "idle" [ label = "dl_server_idle\ndl_replenish;reset(clk)\ndl_throttle" ];
+	"idle" -> "ready" [ label = "dl_server_resume" ];
+	"idle" -> "stopped" [ label = "dl_server_stop" ];
+	"idle" -> "throttled" [ label = "dl_server_resume_throttled" ];
+	"ready" [label = "ready\nclk < server_threshold_ns()"];
+	"ready" -> "idle" [ label = "dl_server_idle" ];
+	"ready" -> "ready" [ label = "sched_switch_out\ndl_server_resume_throttled\ndl_server_resume\ndl_replenish;reset(clk)" ];
+	"ready" -> "running" [ label = "sched_switch_in" ];
+	"ready" -> "stopped" [ label = "dl_server_stop" ];
+	"ready" -> "throttled" [ label = "dl_throttle" ];
+	"running" [label = "running"];
+	"running" -> "idle" [ label = "dl_server_idle" ];
+	"running" -> "ready" [ label = "sched_switch_out" ];
+	"running" -> "running" [ label = "dl_server_resume_throttled\ndl_server_resume\ndl_replenish;reset(clk)" ];
+	"running" -> "stopping" [ label = "dl_server_stop;reset(clk)" ];
+	"running" -> "throttled_running" [ label = "dl_throttle" ];
+	"stopped" [label = "stopped", color = green3];
+	"stopped" -> "ready" [ label = "dl_server_start;reset(clk)" ];
+	"stopped" -> "stopped" [ label = "dl_server_idle\nsched_switch_out\ndl_server_resume\ndl_server_resume_throttled" ];
+	"stopping" [label = "stopping\nclk < STOPPING_NS"];
+	"stopping" -> "stopped" [ label = "dl_server_idle\nsched_switch_out" ];
+	"throttled" [label = "throttled"];
+	"throttled" -> "idle" [ label = "dl_server_idle" ];
+	"throttled" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"throttled" -> "stopped" [ label = "dl_server_stop" ];
+	"throttled" -> "throttled" [ label = "dl_throttle\ndl_server_resume_throttled" ];
+	"throttled" -> "throttled_running" [ label = "sched_switch_in" ];
+	"throttled_running" [label = "throttled_running"];
+	"throttled_running" -> "idle" [ label = "dl_server_idle" ];
+	"throttled_running" -> "running" [ label = "dl_replenish;reset(clk)" ];
+	"throttled_running" -> "throttled" [ label = "sched_switch_out" ];
+	"throttled_running" -> "throttled_running" [ label = "dl_throttle\ndl_server_resume_throttled" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
diff --git a/tools/verification/models/deadline/laxity.dot b/tools/verification/models/deadline/laxity.dot
new file mode 100644
index 000000000000..e423a9de573c
--- /dev/null
+++ b/tools/verification/models/deadline/laxity.dot
@@ -0,0 +1,34 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "idle_wait"};
+	{node [shape = circle] "replenish_wait"};
+	{node [shape = circle] "running"};
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = doublecircle] "stopped"};
+	{node [shape = circle] "stopped"};
+	{node [shape = circle] "zero_laxity_wait"};
+	"__init_stopped" -> "stopped";
+	"idle_wait" [label = "idle_wait"];
+	"idle_wait" -> "idle_wait" [ label = "dl_replenish_idle;reset(clk)" ];
+	"idle_wait" -> "stopped" [ label = "dl_server_stop" ];
+	"idle_wait" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)" ];
+	"replenish_wait" [label = "replenish_wait"];
+	"replenish_wait" -> "running" [ label = "dl_replenish_running" ];
+	"replenish_wait" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)\ndl_replenish_idle;reset(clk)" ];
+	"running" [label = "running"];
+	"running" -> "replenish_wait" [ label = "dl_throttle" ];
+	"running" -> "running" [ label = "dl_replenish_running;clk < REPLENISH_NS" ];
+	"running" -> "stopped" [ label = "dl_server_stop" ];
+	"stopped" [label = "stopped", color = green3];
+	"stopped" -> "running" [ label = "dl_server_start_running;reset(clk)" ];
+	"stopped" -> "zero_laxity_wait" [ label = "dl_server_start;reset(clk)" ];
+	"zero_laxity_wait" [label = "zero_laxity_wait\nclk < laxity_ns()"];
+	"zero_laxity_wait" -> "idle_wait" [ label = "dl_replenish_idle;reset(clk)" ];
+	"zero_laxity_wait" -> "running" [ label = "dl_replenish_running" ];
+	"zero_laxity_wait" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
-- 
2.52.0

