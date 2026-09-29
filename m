Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4E51DAF6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686203; cv=none; b=t1/z1XVFdEON9Naz51z0KT/akigGODsqvAPMD42uYTfDwlsZxhSNByDEsyEQ62BWKV+uq1E1mZ867vZwwApxXay4Qew+Sq83yF+nPvA8DV1/hEzwecFlacg4JV08XjZ6+9j0i8b0YMo3LyUR4zQt0KvszmcB8q/DNX0ft7rnWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686203; c=relaxed/simple;
	bh=ykk8sH3ukd6Z7bFSnuZP8VJ+Fz3abIIFUeFNvxXA/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=C4+njwjE86sbeu2yDtSy+X3CZ/YmwrbAi+uHyAR7lllCZD8/j0+ei6b73CakEkEsvKjczIR4Kl0w5OwOYdH622f+54yAS27FQcP2T4SAWjkM/bIdEc4WJ23fSw9qzV8nDKjZTC3LbhgOWGIeApBYZ3g0lIHfQee6tIUNXNSjPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCqJE0Xp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCqJE0Xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DS1z2lijtWJGWbw95P1/LLexnLrfzUhsbzoXVHr/Xo=;
	b=hCqJE0Xp01pWiANHQFyvNFUPQogbiT5Q9K06ZQbDPbWAlXWHtwSi2/Mij5xzwsxO/OF8uh
	mk6V5kGY9HV1ErjQcyRKcZLgvOrG+CC1kObsWd30wjS+9xMaBsPs3RkdPZ49dirwSffK+d
	NXbVckNDXUv854CKqF8C20JpLS1rngk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-L4e0nCgIOeOo75jjFMwxVg-1; Tue,
 29 Sep 2026 08:49:55 -0400
X-MC-Unique: L4e0nCgIOeOo75jjFMwxVg-1
X-Mimecast-MFC-AGG-ID: L4e0nCgIOeOo75jjFMwxVg_1790686194
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 294DF1955DC7;
	Tue, 29 Sep 2026 12:49:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 013861956095;
	Tue, 29 Sep 2026 12:49:50 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-doc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 08/10] rv: Add dl_server specific monitors
Date: Tue, 29 Sep 2026 14:49:06 +0200
Message-ID: <20260929124908.177676-9-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: fiVIttsi-cgQ2tzi2_vjJe4oGFtgO3ixOrJpuxpOWUw_1790686194
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add monitors to validate the behaviour of the deadline server.

The currently implemented monitors are:
* boost
    fair tasks run either independently or boosted
* laxity
    deferrable servers wait for zero-laxity and run

Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_deadline.rst   | 127 ++++++++
 kernel/trace/rv/Kconfig                       |   2 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/boost/Kconfig        |  15 +
 kernel/trace/rv/monitors/boost/boost.c        | 276 ++++++++++++++++++
 kernel/trace/rv/monitors/boost/boost.h        | 146 +++++++++
 kernel/trace/rv/monitors/boost/boost_trace.h  |  19 ++
 kernel/trace/rv/monitors/laxity/Kconfig       |  14 +
 kernel/trace/rv/monitors/laxity/laxity.c      | 253 ++++++++++++++++
 kernel/trace/rv/monitors/laxity/laxity.h      | 133 +++++++++
 .../trace/rv/monitors/laxity/laxity_trace.h   |  19 ++
 kernel/trace/rv/rv_trace.h                    |   2 +
 tools/verification/models/deadline/boost.dot  |  48 +++
 tools/verification/models/deadline/laxity.dot |  36 +++
 14 files changed, 1092 insertions(+)
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
index e88f631d8387..ce714bf6f9d9 100644
--- a/Documentation/trace/rv/monitor_deadline.rst
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -156,3 +156,130 @@ become ``preempted``::
 The value of ``runtime_left_ns()`` is directly read from the deadline entity
 and updated as the task runs. It is increased by 1 tick to account for the
 maximum delay to throttle (not valid if ``sched_feat(HRTICK_DL)`` is active).
+
+Monitor boost
+~~~~~~~~~~~~~
+
+The boost monitor ensures tasks associated to a server (e.g. fair tasks) run
+either independently or boosted in a timely manner.
+Unlike other models, the ``running`` state (and the ``switch_in/out`` events)
+indicates that any fair task is running, this needs to happen within a
+threshold (the server period ``T()``), whenever a task is ready.
+
+The following chart is simplified to avoid confusion, several less important
+self-loops on states have been removed and event names have been simplified:
+
+* ``idle`` (``dl_server_idle``) occurs when the CPU runs the idle task.
+* ``start/stop`` (``dl_server_start/stop``) start and stop the server.
+* ``switch`` (``sched_switch_in/out``) represented as a double arrow to
+  indicate both edges are present: ``ready -- switch_in -> running`` and
+  ``running -- switch_out -> ready``. As stated above this fires when any fair
+  task starts or stops to running.
+* ``resume``: a fair task woke up, this event is especially frequent on self
+  loops (no state change during a wakeup) but is removed here for clarity.
+  It's main purpose it's to capture the transition ``idle -> ready``.
+* ``resume_throttle``: a fair task woke up, potentially when the server
+  is going to be throttled (no runtime left). This is equivalent to ``resume``,
+  but it's going to be followed by throttle and the invariant in ``idle`` is
+  likely already invalid. It triggers also erroneously when the CPU is fully
+  idle, in that case the runtime is likely stale as it's still consumed by
+  idle, the event may not be followed by a throttle but the task is very likely
+  to run and the state machine is going to be fixed on the next replenish
+  (forced to happen within a period ``T()``).
+* arrows merge with an ``x`` sign to indicate they are the same event going to
+  the same state (but with different origins, e.g. ``{idle/throttled} -- stop
+  -> stopped``). The ``+`` sign indicates standard crossings or corners.
+
+Refer to the dot file for the full specification::
+
+                      |
+                      v
+                #===============#        stop;reset(clk)
+                H               H <---------------+
+  +------------>H    stopped    H                 |
+  |             H               H                 |
+  |             #===============#                 |
+  |                 ^          |                  |
+  |                 |          |                  |      replenish;reset(clk)
+  |               stop         |                  |                    +--+
+  |                 |     start;reset(clk)        +-----------------+  |  |
+  |                 |          v                                    |  |  v
+  |                +---------------+ <---------- switch --------> +---------+
+  |   +- resume -> |     ready     |                              |         |
+  |   |            |               | -replenish;reset(clk)        | running |
+  |   |  +- idle - |   clk < T()   |   |                          |         |
+  |   |  |         +---------------+ <-+        +---------------- +---------+
+  |   |  |         |  ^                         |                   ^    |
+  |   |  |         |  |                       throttle;reset(clk)   |    |
+  |   |  |         |  |replenish;reset(clk)     |                   |    |
+  |   |  |  throttle; |                         |   replenish;reset(clk) |
+  |   |  |   reset()  |                         |                   |    |
+  |   |  |         v  |                         v                   |    |
+  |   |  |   +---------+    switch    +-------------------+         |    |
+  x---+--+-- |throttled| <----------> | throttled_running | --------+    |
+  |   |  |   |         |              |     clk < T()     |              |
+  |   |  |   |clk < T()| -----+       +-------------------+              |
+  |   |  |   +---------+      |            |                             |
+  |   |  |      ^             |            |                             |
+  |   |  | resume_throttle;   |            |                             |
+ stop |  |     reset(clk)     |            |                             |
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
+zero-laxity wait only for up to a period, then the server either prepares to
+stop (after ``idle_wait``) or prepares to boost a task (``running``). Boosting
+(``sched_switch_in``) is only allowed in the ``running`` state.
+``dl_replenish_running`` should not be allowed in ``running``, but can happen
+as soon as the server started, the model allows this only within a short
+threshold::
+
+                                                  |
+ +---- dl_server_stop -----+                      |
+ |                         v                      v
+ |            #=======================================#
+ |   +------- H                stopped                H
+ |   |        #=======================================#
+ |   |          |                             ^
+ |   |  dl_server_start_running;        dl_server_stop
+ |   |        reset(clk)                      |
+ |   |          v                             |            dl_replenish_running;
+ |   |     +-------------------------------------+ -----------clk < REPLENISH_NS
+ |   |     |                                     |              |
+ |   |     |              running                | <------------+
+ |   |     |                                     |
+ |   |     +-------------------------------------+ ------------------+
+ |   |       |            ^                    ^                     |
+ |   |  dl_throttle    dl_replenish_running    |               dl_update
+ |   |       v            |                    |        dl_replenish;reset(clk)
+ |   |   +-------------------+                 |   dl_replenish_idle;reset(clk)
+ |   |   |  replenish_wait   |                 |                     |
+ |   |   | clk < period_ns() | ----------------+---------------------+--------+
+ |   |   +-------------------+                 |                     |        |
+ |   |                   |                     |                     |        |
+ |   |               dl_update                 |                     |        |
+ |   |         dl_replenish;reset(clk)     dl_replenish_running      |        |
+ |   |                   v                     |                     |        |
+ |   |                 +--------------------------+                  |        |
+ | dl_server_start;    |                          | <----------------+        |
+ |   reset(clk)        |     zero_laxity_wait     |                           |
+ |   |                 |     clk < period_ns()    | ------+ dl_replenish;     |
+ |   +---------------> |                          |       |    reset(clk)     |
+ |                     +--------------------------+ <-----+ dl_update         |
+ |                               |              ^                             |
+ |  dl_replenish_idle;reset(clk) |      dl_replenish;reset(clk)               |
+ |                               v            dl_update                       |
+ |                  +------------------------+  |                             |
+ +----------------- |        idle_wait       | -+                             |
+                    |   clk < period_ns()    |                                |
+                    +------------------------+ <-- dl_replenish_idle;reset(clk)
+                         ^             |
+                         +------dl_replenish_idle;reset(clk)
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index cdb851c7cceb..2f2d25bc972b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -83,6 +83,8 @@ source "kernel/trace/rv/monitors/stall/Kconfig"
 source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 source "kernel/trace/rv/monitors/throttle/Kconfig"
+source "kernel/trace/rv/monitors/boost/Kconfig"
+source "kernel/trace/rv/monitors/laxity/Kconfig"
 # Add new deadline monitors here
 
 # Add new monitors here
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 1387082dc490..81c557b26334 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -22,6 +22,8 @@ obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
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
index 000000000000..3533d23279ee
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/boost.c
@@ -0,0 +1,276 @@
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
+static inline u64 period_ns(struct ha_monitor *ha_mon)
+{
+	struct sched_dl_entity *dl_se = ha_get_target(ha_mon);
+
+	return dl_se->dl_period + TICK_NSEC;
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
+	else if (curr_state == throttled_boost)
+		return ha_check_invariant_ns(ha_mon, clk_boost, time_ns);
+	else if (curr_state == throttled_running_boost)
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
+	else if (curr_state == idle_boost && event == dl_server_resume_throttled_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == ready_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == ready_boost && event == dl_throttle_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == running_boost && event == dl_replenish_boost)
+		ha_reset_env(ha_mon, clk_boost, time_ns);
+	else if (curr_state == running_boost && event == dl_throttle_boost)
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
+		ha_start_timer_ns(ha_mon, clk_boost, period_ns(ha_mon), time_ns);
+	else if (next_state == throttled_boost)
+		ha_start_timer_ns(ha_mon, clk_boost, period_ns(ha_mon), time_ns);
+	else if (next_state == throttled_running_boost)
+		ha_start_timer_ns(ha_mon, clk_boost, period_ns(ha_mon), time_ns);
+	else if (curr_state == ready_boost)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == throttled_boost)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == throttled_running_boost)
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
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se,
+				int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_boost);
+}
+
+static inline void handle_server_switch(struct task_struct *next,
+					struct task_struct *prev, int cpu,
+					u8 type)
+{
+	struct sched_dl_entity *dl_se = get_server(next, type);
+
+	if (!dl_se)
+		return;
+	if (is_idle_task(next))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_server_idle_boost);
+	else if (get_server_type(next) == type && !rt_or_dl_task(next))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), sched_switch_in_boost);
+	else if (get_server_type(prev) == type && !is_idle_task(prev))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), sched_switch_out_boost);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	int cpu = task_cpu(next);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * This monitor considers switch in/out whenever a task related to the
+	 * server (i.e. fair) is scheduled in or out, boosted or not.
+	 * Any switch to the same policy is ignored.
+	 * PI boosted tasks are not considered fair.
+	 */
+	if (get_server_type(next) == get_server_type(prev) &&
+	    !is_idle_task(next) && !is_idle_task(prev))
+		return;
+	handle_server_switch(next, prev, cpu, DL_SERVER_FAIR);
+	if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
+		handle_server_switch(next, prev, cpu, DL_SERVER_EXT);
+}
+
+static void handle_sched_enqueue(void *data, struct task_struct *tsk, int cpu)
+{
+	struct sched_dl_entity *dl_se = NULL;
+	u8 type = get_server_type(tsk);
+
+	if (is_server_type(type))
+		dl_se = get_server(tsk, type);
+	if (dl_se) {
+		da_handle_event(EXPAND_ID(dl_se, cpu, type),
+				dl_se->runtime > 0 && !idle_cpu(cpu) ?
+					dl_server_resume_boost :
+					dl_server_resume_throttled_boost);
+	}
+}
+
+static void handle_sched_dequeue(void *data, struct task_struct *tsk, int cpu)
+{
+	struct sched_dl_entity *dl_se = NULL;
+	u8 type = get_server_type(tsk);
+
+	if (is_server_type(type))
+		dl_se = get_server(tsk, type);
+	/*
+	 * A dequeue is counted as switching out only in case of a change in
+	 * scheduler where the task is moved to another scheduler's runqueue.
+	 */
+	if (dl_se && task_is_running(tsk) && sched_task_on_rq(tsk))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), sched_switch_out_boost);
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl_se,
+				   int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_server_start_boost);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_start_event(EXPAND_ID(dl_se, cpu, type), dl_server_stop_boost);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_throttle_boost);
+}
+
+static int enable_boost(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
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
+	rv_attach_trace_probe("boost", sched_enqueue_tp, handle_sched_enqueue);
+	rv_attach_trace_probe("boost", sched_dequeue_tp, handle_sched_dequeue);
+	rv_attach_trace_probe("boost", sched_switch, handle_sched_switch);
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
+	rv_detach_trace_probe("boost", sched_enqueue_tp, handle_sched_enqueue);
+	rv_detach_trace_probe("boost", sched_dequeue_tp, handle_sched_dequeue);
+	rv_detach_trace_probe("boost", sched_switch, handle_sched_switch);
+
+	ha_monitor_destroy();
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
index 000000000000..e5ca85cc6620
--- /dev/null
+++ b/kernel/trace/rv/monitors/boost/boost.h
@@ -0,0 +1,146 @@
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
+			stopped_boost,
+			throttled_running_boost,
+			INVALID_STATE,
+			ready_boost,
+		},
+		{
+			ready_boost,
+			idle_boost,
+			throttled_boost,
+			throttled_boost,
+			INVALID_STATE,
+			stopped_boost,
+			throttled_boost,
+			throttled_running_boost,
+			throttled_boost,
+		},
+		{
+			running_boost,
+			idle_boost,
+			throttled_running_boost,
+			throttled_running_boost,
+			INVALID_STATE,
+			INVALID_STATE,
+			throttled_running_boost,
+			INVALID_STATE,
+			throttled_boost,
+		},
+	},
+	.initial_state = stopped_boost,
+	.final_states = { 1, 0, 0, 0, 0, 0 },
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
index 000000000000..751d31822436
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/laxity.c
@@ -0,0 +1,253 @@
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
+/* allow replenish when running only right after server start */
+#define REPLENISH_NS TICK_NSEC
+
+static inline u64 period_ns(struct ha_monitor *ha_mon)
+{
+	return ha_get_target(ha_mon)->dl_period + TICK_NSEC;
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
+	if (curr_state == idle_wait_laxity)
+		return ha_check_invariant_ns(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity)
+		return ha_check_invariant_ns(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity)
+		return ha_check_invariant_ns(ha_mon, clk_laxity, time_ns);
+	return true;
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == idle_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == replenish_wait_laxity && event == dl_replenish_running_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == running_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == running_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == running_laxity && event == dl_replenish_running_laxity)
+		res = ha_get_env(ha_mon, clk_laxity, time_ns) < REPLENISH_NS;
+	else if (curr_state == running_laxity && event == dl_throttle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == stopped_laxity && event == dl_server_start_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == stopped_laxity && event == dl_server_start_running_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity && event == dl_replenish_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity && event == dl_replenish_idle_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	else if (curr_state == zero_laxity_wait_laxity && event == dl_replenish_running_laxity)
+		ha_reset_env(ha_mon, clk_laxity, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != dl_replenish_laxity &&
+	    event != dl_replenish_idle_laxity)
+		return;
+	if (next_state == idle_wait_laxity)
+		ha_start_timer_ns(ha_mon, clk_laxity, period_ns(ha_mon), time_ns);
+	else if (next_state == replenish_wait_laxity)
+		ha_start_timer_ns(ha_mon, clk_laxity, period_ns(ha_mon), time_ns);
+	else if (next_state == zero_laxity_wait_laxity)
+		ha_start_timer_ns(ha_mon, clk_laxity, period_ns(ha_mon), time_ns);
+	else if (curr_state == idle_wait_laxity)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == replenish_wait_laxity)
+		ha_cancel_timer(ha_mon);
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
+	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
+
+	ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
+
+	return true;
+}
+
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se,
+				int cpu, u8 type)
+{
+	if (!is_server_type(type))
+		return;
+	/* Special replenish happening after throttle, ignore it */
+	if (dl_se->dl_defer_running && dl_se->dl_throttled)
+		return;
+	if (dl_se->dl_defer_running)
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_running_laxity);
+	else if (idle_cpu(cpu))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_idle_laxity);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_laxity);
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl_se,
+				   int cpu, u8 type)
+{
+	if (!is_server_type(type))
+		return;
+	if (dl_se->dl_defer_running)
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_server_start_running_laxity);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_server_start_laxity);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_start_event(EXPAND_ID(dl_se, cpu, type), dl_server_stop_laxity);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type)
+{
+	if (is_server_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_throttle_laxity);
+}
+
+static void handle_dl_update(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type)
+{
+	if (!is_server_type(type) || idle_cpu(cpu) || dl_se->dl_defer_running)
+		return;
+	/* The idle flag can be cleared without passing from an actual replenish */
+	da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_update_laxity);
+}
+
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (!next->dl_server)
+		return;
+	da_handle_event(EXPAND_ID(next->dl_server, task_cpu(next),
+				  get_server_type(next)),
+			sched_switch_in_laxity);
+}
+
+static int enable_laxity(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
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
+	rv_attach_trace_probe("laxity", sched_dl_update_tp, handle_dl_update);
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
+	rv_detach_trace_probe("laxity", sched_dl_update_tp, handle_dl_update);
+	rv_detach_trace_probe("laxity", sched_switch, handle_sched_switch);
+
+	ha_monitor_destroy();
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
index 000000000000..69a818c0f6cf
--- /dev/null
+++ b/kernel/trace/rv/monitors/laxity/laxity.h
@@ -0,0 +1,133 @@
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
+	dl_update_laxity,
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
+		"dl_update",
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
+			zero_laxity_wait_laxity,
+			INVALID_STATE,
+		},
+		{
+			zero_laxity_wait_laxity,
+			idle_wait_laxity,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			zero_laxity_wait_laxity,
+			INVALID_STATE,
+		},
+		{
+			zero_laxity_wait_laxity,
+			zero_laxity_wait_laxity,
+			running_laxity,
+			INVALID_STATE,
+			INVALID_STATE,
+			stopped_laxity,
+			replenish_wait_laxity,
+			zero_laxity_wait_laxity,
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
+			zero_laxity_wait_laxity,
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
index 9896beae73af..ad4df55eb727 100644
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
index 000000000000..05a927b034d9
--- /dev/null
+++ b/tools/verification/models/deadline/boost.dot
@@ -0,0 +1,48 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "idle"};
+	{node [shape = circle] "ready"};
+	{node [shape = circle] "running"};
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = doublecircle] "stopped"};
+	{node [shape = circle] "stopped"};
+	{node [shape = circle] "throttled"};
+	{node [shape = circle] "throttled_running"};
+	"__init_stopped" -> "stopped";
+	"idle" [label = "idle"];
+	"idle" -> "idle" [ label = "dl_server_idle\ndl_replenish;reset(clk)\ndl_throttle" ];
+	"idle" -> "ready" [ label = "dl_server_resume" ];
+	"idle" -> "stopped" [ label = "dl_server_stop" ];
+	"idle" -> "throttled" [ label = "dl_server_resume_throttled;reset(clk)" ];
+	"ready" [label = "ready\nclk < period_ns()"];
+	"ready" -> "idle" [ label = "dl_server_idle" ];
+	"ready" -> "ready" [ label = "sched_switch_out\ndl_server_resume_throttled\ndl_server_resume\ndl_replenish;reset(clk)" ];
+	"ready" -> "running" [ label = "sched_switch_in" ];
+	"ready" -> "stopped" [ label = "dl_server_stop" ];
+	"ready" -> "throttled" [ label = "dl_throttle;reset(clk)" ];
+	"running" [label = "running"];
+	"running" -> "idle" [ label = "dl_server_idle" ];
+	"running" -> "ready" [ label = "sched_switch_out" ];
+	"running" -> "running" [ label = "dl_server_resume_throttled\ndl_server_resume\ndl_replenish;reset(clk)" ];
+	"running" -> "stopped" [ label = "dl_server_stop" ];
+	"running" -> "throttled_running" [ label = "dl_throttle;reset(clk)" ];
+	"stopped" [label = "stopped", color = green3];
+	"stopped" -> "ready" [ label = "dl_server_start;reset(clk)" ];
+	"stopped" -> "stopped" [ label = "dl_server_idle\nsched_switch_out\ndl_server_resume\ndl_server_resume_throttled" ];
+	"throttled" [label = "throttled\nclk < period_ns()"];
+	"throttled" -> "idle" [ label = "dl_server_idle" ];
+	"throttled" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"throttled" -> "stopped" [ label = "dl_server_stop" ];
+	"throttled" -> "throttled" [ label = "dl_throttle\nsched_switch_out\ndl_server_resume_throttled\ndl_server_resume" ];
+	"throttled" -> "throttled_running" [ label = "sched_switch_in" ];
+	"throttled_running" [label = "throttled_running\nclk < period_ns()"];
+	"throttled_running" -> "idle" [ label = "dl_server_idle" ];
+	"throttled_running" -> "running" [ label = "dl_replenish;reset(clk)" ];
+	"throttled_running" -> "throttled" [ label = "sched_switch_out" ];
+	"throttled_running" -> "throttled_running" [ label = "dl_throttle\ndl_server_resume_throttled\ndl_server_resume" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
diff --git a/tools/verification/models/deadline/laxity.dot b/tools/verification/models/deadline/laxity.dot
new file mode 100644
index 000000000000..e4fdabfe1743
--- /dev/null
+++ b/tools/verification/models/deadline/laxity.dot
@@ -0,0 +1,36 @@
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
+	"idle_wait" [label = "idle_wait\nclk < period_ns()"];
+	"idle_wait" -> "idle_wait" [ label = "dl_replenish_idle;reset(clk)" ];
+	"idle_wait" -> "stopped" [ label = "dl_server_stop" ];
+	"idle_wait" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)\ndl_update" ];
+	"replenish_wait" [label = "replenish_wait\nclk < period_ns()"];
+	"replenish_wait" -> "idle_wait" [ label = "dl_replenish_idle;reset(clk)" ];
+	"replenish_wait" -> "running" [ label = "dl_replenish_running;reset(clk)" ];
+	"replenish_wait" -> "zero_laxity_wait" [ label = "dl_update\ndl_replenish;reset(clk)" ];
+	"running" [label = "running"];
+	"running" -> "replenish_wait" [ label = "dl_throttle;reset(clk)" ];
+	"running" -> "running" [ label = "sched_switch_in\ndl_replenish_running;clk < REPLENISH_NS" ];
+	"running" -> "stopped" [ label = "dl_server_stop" ];
+	"running" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)\ndl_replenish_idle;reset(clk)\ndl_update" ];
+	"stopped" [label = "stopped", color = green3];
+	"stopped" -> "running" [ label = "dl_server_start_running;reset(clk)" ];
+	"stopped" -> "zero_laxity_wait" [ label = "dl_server_start;reset(clk)" ];
+	"zero_laxity_wait" [label = "zero_laxity_wait\nclk < period_ns()"];
+	"zero_laxity_wait" -> "idle_wait" [ label = "dl_replenish_idle;reset(clk)" ];
+	"zero_laxity_wait" -> "running" [ label = "dl_replenish_running;reset(clk)" ];
+	"zero_laxity_wait" -> "zero_laxity_wait" [ label = "dl_replenish;reset(clk)\ndl_update" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
-- 
2.55.0

