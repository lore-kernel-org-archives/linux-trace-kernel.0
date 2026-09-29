Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A00528436
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686197; cv=none; b=YitSmfuW2R2srJ7E+xJwVLsV4SKLx2I6FO9obJq9+qoW/814f9nSfkaIsEgH90VH1Ug4yEyGvgxuZoNO0R7O7si8N11udR1i/phR10eApaH+2JGiGpCfAy7JnN+L6Q7U9VdJB0ynIKWBWNZ1rYErZhB8aX3FVEllswGLLW6LOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686197; c=relaxed/simple;
	bh=KK3lR+nEzyfeOrJgrex4gj/VThGCdvhlvkZCbC2Moyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ntwTmWlt6qJuIUKcyQRB5NilZCX/O9P+r5DzS3HQfzEucP7d1ZOYmCde70iobf8wbitrkoJh+H63FvaQFjqq4uvpP41sRmcfJ2Qj5lLDdwDGthoJ3NQKtrw9uHNhwlqjmKcSrhE25nxRoFPL+5KT6lGecyXFaQFbpuMh9fVmcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbQasLwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbQasLwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcRh3KvoTuTU5robGFFmH46A8mOpByTK/Vk4+RYAYiQ=;
	b=LbQasLwT31kUDi0SRov9aoP+L9aHIHzdMDZvT0UA6LJ7stIbTgFelZr6qRMtQgSIuy6w5l
	ZdGuLRXBXJVLy8YZExKq4/OVBZ1HGo2rajmON1ktkY3q/E7t4HaatOYlnIXo6xfJeOYFaZ
	kRRsLWk2mFiff0g95+t076tApfNr2Zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-gnSN5C7QOACjzpyVVfnluA-1; Tue,
 29 Sep 2026 08:49:49 -0400
X-MC-Unique: gnSN5C7QOACjzpyVVfnluA-1
X-Mimecast-MFC-AGG-ID: gnSN5C7QOACjzpyVVfnluA_1790686188
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FCEA180059F;
	Tue, 29 Sep 2026 12:49:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 189801956095;
	Tue, 29 Sep 2026 12:49:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-doc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 07/10] rv: Add throttle deadline monitor
Date: Tue, 29 Sep 2026 14:49:05 +0200
Message-ID: <20260929124908.177676-8-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ZCHzuDSbBQ3hkPnJya44P0A3XOdEQeZ00ttQkJNoN7Q_1790686188
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a monitor to validate the behaviour of the deadline scheduler.

* throttle:
    validate dl entities are throttled when they use up their runtime

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_deadline.rst   |  74 +++++
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/throttle/Kconfig     |  15 +
 kernel/trace/rv/monitors/throttle/throttle.c  | 285 ++++++++++++++++++
 kernel/trace/rv/monitors/throttle/throttle.h  | 116 +++++++
 .../rv/monitors/throttle/throttle_trace.h     |  19 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 .../verification/models/deadline/throttle.dot |  44 +++
 9 files changed, 556 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/throttle.dot

diff --git a/Documentation/trace/rv/monitor_deadline.rst b/Documentation/trace/rv/monitor_deadline.rst
index 84506ed1e293..e88f631d8387 100644
--- a/Documentation/trace/rv/monitor_deadline.rst
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -82,3 +82,77 @@ server can run from sleeping without being ready::
  +--------------+ <---------+                                        ^
         |                                                            |
         +------ dl_throttle;is_constr_dl == 1 || is_defer == 1 ------+
+
+Monitor throttle
+~~~~~~~~~~~~~~~~
+
+The throttle monitor ensures deadline entities are throttled when they use up
+their runtime. Deadline tasks can be only ``running``, ``preempted`` and
+``throttled``, the runtime is enforced only in ``running`` based on an internal
+clock and the runtime value in the deadline entity.
+On systems with CPU frequency scaling or turbo boost, deadline tasks can run
+longer than their runtime as this is scaled according to the frequency. In this
+scenario, the monitor allows to skip the runtime check with the module
+parameter ``throttle.skip_runtime_check``.
+
+Servers can be also in the ``armed`` state, which represents when the
+server is consuming bandwidth in background (e.g. idle or normal tasks are
+running without any boost). From this state the server can be throttled but it
+can also use more runtime than available. A server is considered ``running``
+when it's actively boosting a task, only there the runtime is enforced. The
+server is preempted if the running task is not in the server's runqueue (e.g. a
+FIFO task for the fair server).
+Events like ``dl_armed`` and ``sched_switch_in`` can occur sequentially for
+servers since they are related to the current task (e.g. a 2 fair tasks can be
+switched in sequentially, that corresponds to multiple ``dl_armed``).
+
+Any task or server in the ``throttled`` state must leave it shortly, e.g.
+become ``preempted``::
+
+                                     |
+                                     |
+      dl_replenish;reset(clk)        v
+              sched_switch_in   #=========================# sched_switch_in;
+               +--------------- H                         H   reset(clk)
+               |                H                         H <----------------+
+               +--------------> H         running         H                  |
+    dl_throttle;reset(clk)      H clk < runtime_left_ns() H                  |
+   +--------------------------- H                         H sched_switch_out |
+   |       +------------------> H                         H -------------+   |
+   | dl_replenish;reset(clk)    #=========================#              |   |
+   |       |                         |             ^                     |   |
+   v       |                  dl_defer_arm         |                     |   |
+ +-------------------------+         |             |                     |   |
+ |       throttled         |         |    sched_switch_in;reset(clk)     |   |
+ | clk < THROTTLED_TIME_NS |         v             |                     |   |
+ +-------------------------+        +----------------+                   |   |
+   |    |                           |                | sched_switch_out  |   |
+   |    |               +---------- |                | -------------+    |   |
+   |    |          dl_replenish     |     armed      |              |    |   |
+   |    |          dl_defer_arm     |                | <--------+   |    |   |
+   |    |               +---------> |                | dl_defer_arm |    |   |
+   |    |                           +----------------+          |   |    |   |
+   |    |                            |         ^                |   |    |   |
+   |    |                        dl_throttle  dl_replenish      |   |    |   |
+   |    |                            v         |                |   |    |   |
+   |    |     dl_defer_arm  +-------------------+               |   v    v   |
+   |    |       +---------- |                   |             +--------------+
+   |    |       |           |                   |             |              |
+   |    |       +---------> |  armed_throttled  |             |  preempted   |
+   |    |                   |                   |             |              |
+   |    +-----------------> |                   |             +--------------+
+   |          dl_defer_arm  +-------------------+   sched_switch_out ^   |  ^
+   |                            |              ^        dl_replenish |   |  |
+   |                  sched_switch_out    dl_defer_arm          +----+   |  |
+   |                            v              |                         |  |
+   |       sched_switch_out  +-----------------------+                   |  |
+   |         +-------------- |                       | dl_throttle;      |  |
+   |         |               |                       |  is_constr_dl==1  |  |
+   |         +-------------> |  preempted_throttled  | <-----------------+  |
+   |                         |                       |                      |
+   +-----------------------> |                       | -- dl_replenish -----+
+         sched_switch_out    +-----------------------+
+
+The value of ``runtime_left_ns()`` is directly read from the deadline entity
+and updated as the task runs. It is increased by 1 tick to account for the
+maximum delay to throttle (not valid if ``sched_feat(HRTICK_DL)`` is active).
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4..cdb851c7cceb 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -82,6 +82,7 @@ source "kernel/trace/rv/monitors/wakeup/Kconfig"
 source "kernel/trace/rv/monitors/stall/Kconfig"
 source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
+source "kernel/trace/rv/monitors/throttle/Kconfig"
 # Add new deadline monitors here
 
 # Add new monitors here
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..1387082dc490 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
+obj-$(CONFIG_RV_MON_THROTTLE) += monitors/throttle/throttle.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/throttle/Kconfig b/kernel/trace/rv/monitors/throttle/Kconfig
new file mode 100644
index 000000000000..d9bd2dc903cd
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_THROTTLE
+	depends on RV
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	depends on RV_MON_DEADLINE
+	default y
+	select HA_MON_EVENTS_ID
+	bool "throttle monitor"
+	help
+	  Monitor to ensure dl entities are throttled when they use up their runtime.
+	  This monitor is part of the deadline monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_deadline.rst
diff --git a/kernel/trace/rv/monitors/throttle/throttle.c b/kernel/trace/rv/monitors/throttle/throttle.c
new file mode 100644
index 000000000000..b22a2abe59fe
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "throttle"
+
+#include <uapi/linux/sched/types.h>
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/task.h>
+#include <rv_trace.h>
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_WHEEL
+/* The start condition is on sched_switch, it's dangerous to allocate there */
+#define DA_SKIP_AUTO_ALLOC
+typedef struct sched_dl_entity *monitor_target;
+#include "throttle.h"
+#include <rv/ha_monitor.h>
+#include <monitors/deadline/deadline.h>
+
+#define THROTTLED_TIME_NS TICK_NSEC
+/* with sched_feat(HRTICK_DL) the threshold can be lower */
+#define RUNTIME_THRESH TICK_NSEC
+/*
+ * On systems with CPU frequency scaling or turbo boost, deadline tasks can run
+ * longer than their runtime as this is scaled according to the frequency. As a
+ * result, this constraint cannot work.
+ */
+static bool skip_runtime_check;
+module_param(skip_runtime_check, bool, 0644);
+
+static inline u64 runtime_left_ns(struct ha_monitor *ha_mon)
+{
+	return ha_get_target(ha_mon)->runtime + RUNTIME_THRESH;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_throttle env, u64 time_ns)
+{
+	if (env == clk_throttle)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	else if (env == is_constr_dl_throttle)
+		return !dl_is_implicit(ha_get_target(ha_mon));
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_throttle env, u64 time_ns)
+{
+	if (env == clk_throttle)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == running_throttle && !skip_runtime_check)
+		return ha_check_invariant_ns(ha_mon, clk_throttle, time_ns);
+	else if (curr_state == throttled_throttle)
+		return ha_check_invariant_ns(ha_mon, clk_throttle, time_ns);
+	return true;
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == armed_throttle && event == sched_switch_in_throttle)
+		ha_reset_env(ha_mon, clk_throttle, time_ns);
+	else if (curr_state == preempted_throttle && event == dl_throttle_throttle)
+		res = ha_get_env(ha_mon, is_constr_dl_throttle, time_ns) == 1ull;
+	else if (curr_state == preempted_throttle && event == sched_switch_in_throttle)
+		ha_reset_env(ha_mon, clk_throttle, time_ns);
+	else if (curr_state == running_throttle && event == dl_replenish_throttle)
+		ha_reset_env(ha_mon, clk_throttle, time_ns);
+	else if (curr_state == running_throttle && event == dl_throttle_throttle)
+		ha_reset_env(ha_mon, clk_throttle, time_ns);
+	else if (curr_state == throttled_throttle && event == dl_replenish_throttle)
+		ha_reset_env(ha_mon, clk_throttle, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != dl_replenish_throttle)
+		return;
+	if (next_state == running_throttle && !skip_runtime_check)
+		ha_start_timer_ns(ha_mon, clk_throttle, runtime_left_ns(ha_mon), time_ns);
+	else if (next_state == throttled_throttle)
+		ha_start_timer_ns(ha_mon, clk_throttle, THROTTLED_TIME_NS, time_ns);
+	else if (curr_state == running_throttle)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == throttled_throttle)
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
+	if (is_supported_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_throttle);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type)
+{
+	if (is_supported_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_throttle_throttle);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type)
+{
+	if (is_supported_type(type))
+		da_handle_start_run_event(EXPAND_ID(dl_se, cpu, type), sched_switch_out_throttle);
+}
+
+static inline void handle_server_switch(struct task_struct *next, int cpu, u8 type)
+{
+	struct sched_dl_entity *dl_se = get_server(next, type);
+
+	if (!dl_se)
+		return;
+	if (get_server_type(next) == type || is_idle_task(next))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_defer_arm_throttle);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), sched_switch_out_throttle);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	int cpu = task_cpu(next);
+
+	if (prev->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID_TASK(prev), sched_switch_out_throttle);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_event(EXPAND_ID_TASK(next), sched_switch_in_throttle);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * Here the server continues in the state running/armed until actually
+	 * stopped, this works since we continue expecting a throttle.
+	 */
+	if (next->dl_server) {
+		da_handle_start_event(EXPAND_ID(next->dl_server, cpu,
+						get_server_type(next)),
+				      sched_switch_in_throttle);
+	} else {
+		handle_server_switch(next, cpu, DL_SERVER_FAIR);
+		if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
+			handle_server_switch(next, cpu, DL_SERVER_EXT);
+	}
+}
+
+static void handle_sched_enqueue(void *data, struct task_struct *tsk, int cpu)
+{
+	struct sched_dl_entity *dl_se = NULL;
+	u8 type = get_server_type(tsk);
+
+	if (is_server_type(type))
+		dl_se = get_server(tsk, type);
+	/*
+	 * An enqueue is counted as server arming only in case of a change in
+	 * scheduler where the task is moved to another scheduler's runqueue.
+	 */
+	if (dl_se && task_is_running(tsk) && sched_task_on_rq(tsk))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_defer_arm_throttle);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	struct task_struct *p;
+	int new_policy = -1;
+	pid_t pid = 0;
+
+	new_policy = extract_params(regs, id, &pid);
+	if (new_policy < 0)
+		return;
+	guard(rcu)();
+	p = pid ? find_task_by_vpid(pid) : current;
+	if (unlikely(!p) || new_policy == p->policy)
+		return;
+
+	if (p->policy == SCHED_DEADLINE)
+		da_reset(EXPAND_ID_TASK(p));
+	else if (new_policy == SCHED_DEADLINE)
+		da_create_or_get(EXPAND_ID_TASK(p));
+}
+
+static int enable_throttle(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	retval = init_storage(false);
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("throttle", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("throttle", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("throttle", sched_enqueue_tp, handle_sched_enqueue);
+	rv_attach_trace_probe("throttle", sched_switch, handle_sched_switch);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("throttle", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("throttle", task_newtask, handle_newtask);
+	rv_attach_trace_probe("throttle", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_attach_trace_probe("throttle", sched_process_exit, handle_exit);
+
+	return 0;
+}
+
+static void disable_throttle(void)
+{
+	rv_this.enabled = 0;
+
+	/* Those are RCU writers, detach earlier hoping to close a bit faster */
+	rv_detach_trace_probe("throttle", task_newtask, handle_newtask);
+	rv_detach_trace_probe("throttle", sched_process_exit, handle_exit);
+	if (!should_skip_syscall_handle())
+		rv_detach_trace_probe("throttle", sys_enter, handle_sys_enter);
+
+	rv_detach_trace_probe("throttle", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_detach_trace_probe("throttle", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("throttle", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("throttle", sched_enqueue_tp, handle_sched_enqueue);
+	rv_detach_trace_probe("throttle", sched_switch, handle_sched_switch);
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "throttle",
+	.description = "throttle dl entities when they use up their runtime.",
+	.enable = enable_throttle,
+	.disable = disable_throttle,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_throttle(void)
+{
+	return rv_register_monitor(&rv_this, &rv_deadline);
+}
+
+static void __exit unregister_throttle(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_throttle);
+module_exit(unregister_throttle);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("throttle: throttle dl entities when they use up their runtime.");
diff --git a/kernel/trace/rv/monitors/throttle/throttle.h b/kernel/trace/rv/monitors/throttle/throttle.h
new file mode 100644
index 000000000000..3ab6d73280d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of throttle automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME throttle
+
+enum states_throttle {
+	running_throttle,
+	armed_throttle,
+	armed_throttled_throttle,
+	preempted_throttle,
+	preempted_throttled_throttle,
+	throttled_throttle,
+	state_max_throttle,
+};
+
+#define INVALID_STATE state_max_throttle
+
+enum events_throttle {
+	dl_defer_arm_throttle,
+	dl_replenish_throttle,
+	dl_throttle_throttle,
+	sched_switch_in_throttle,
+	sched_switch_out_throttle,
+	event_max_throttle,
+};
+
+enum envs_throttle {
+	clk_throttle,
+	is_constr_dl_throttle,
+	env_max_throttle,
+	env_max_stored_throttle = is_constr_dl_throttle,
+};
+
+_Static_assert(env_max_stored_throttle <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_CLK_NS
+
+struct automaton_throttle {
+	char *state_names[state_max_throttle];
+	char *event_names[event_max_throttle];
+	char *env_names[env_max_throttle];
+	unsigned char function[state_max_throttle][event_max_throttle];
+	unsigned char initial_state;
+	bool final_states[state_max_throttle];
+};
+
+static const struct automaton_throttle automaton_throttle = {
+	.state_names = {
+		"running",
+		"armed",
+		"armed_throttled",
+		"preempted",
+		"preempted_throttled",
+		"throttled",
+	},
+	.event_names = {
+		"dl_defer_arm",
+		"dl_replenish",
+		"dl_throttle",
+		"sched_switch_in",
+		"sched_switch_out",
+	},
+	.env_names = {
+		"clk",
+		"is_constr_dl",
+	},
+	.function = {
+		{
+			armed_throttle,
+			running_throttle,
+			throttled_throttle,
+			running_throttle,
+			preempted_throttle,
+		},
+		{
+			armed_throttle,
+			armed_throttle,
+			armed_throttled_throttle,
+			running_throttle,
+			preempted_throttle,
+		},
+		{
+			armed_throttled_throttle,
+			armed_throttle,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempted_throttled_throttle,
+		},
+		{
+			armed_throttle,
+			preempted_throttle,
+			preempted_throttled_throttle,
+			running_throttle,
+			preempted_throttle,
+		},
+		{
+			armed_throttled_throttle,
+			preempted_throttle,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempted_throttled_throttle,
+		},
+		{
+			armed_throttled_throttle,
+			running_throttle,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempted_throttled_throttle,
+		},
+	},
+	.initial_state = running_throttle,
+	.final_states = { 1, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/throttle/throttle_trace.h b/kernel/trace/rv/monitors/throttle/throttle_trace.h
new file mode 100644
index 000000000000..7e376d3aec60
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_THROTTLE
+DEFINE_EVENT(event_da_monitor_id, event_throttle,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_throttle,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_throttle,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_THROTTLE */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 2f8a932432c9..9896beae73af 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -189,6 +189,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/throttle/throttle_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/deadline/throttle.dot b/tools/verification/models/deadline/throttle.dot
new file mode 100644
index 000000000000..c24fc3f291a9
--- /dev/null
+++ b/tools/verification/models/deadline/throttle.dot
@@ -0,0 +1,44 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "armed"};
+	{node [shape = circle] "armed_throttled"};
+	{node [shape = circle] "preempted"};
+	{node [shape = circle] "preempted_throttled"};
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = doublecircle] "running"};
+	{node [shape = circle] "running"};
+	{node [shape = circle] "throttled"};
+	"__init_running" -> "running";
+	"armed" [label = "armed"];
+	"armed" -> "armed" [ label = "dl_replenish\ndl_defer_arm" ];
+	"armed" -> "armed_throttled" [ label = "dl_throttle" ];
+	"armed" -> "preempted" [ label = "sched_switch_out" ];
+	"armed" -> "running" [ label = "sched_switch_in;reset(clk)" ];
+	"armed_throttled" [label = "armed_throttled"];
+	"armed_throttled" -> "armed" [ label = "dl_replenish" ];
+	"armed_throttled" -> "armed_throttled" [ label = "dl_defer_arm" ];
+	"armed_throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"preempted" [label = "preempted"];
+	"preempted" -> "armed" [ label = "dl_defer_arm" ];
+	"preempted" -> "preempted" [ label = "dl_replenish\nsched_switch_out" ];
+	"preempted" -> "preempted_throttled" [ label = "dl_throttle;is_constr_dl == 1" ];
+	"preempted" -> "running" [ label = "sched_switch_in;reset(clk)" ];
+	"preempted_throttled" [label = "preempted_throttled"];
+	"preempted_throttled" -> "armed_throttled" [ label = "dl_defer_arm" ];
+	"preempted_throttled" -> "preempted" [ label = "dl_replenish" ];
+	"preempted_throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"running" [label = "running\nclk < runtime_left_ns()", color = green3];
+	"running" -> "armed" [ label = "dl_defer_arm" ];
+	"running" -> "preempted" [ label = "sched_switch_out" ];
+	"running" -> "running" [ label = "dl_replenish;reset(clk)\nsched_switch_in" ];
+	"running" -> "throttled" [ label = "dl_throttle;reset(clk)" ];
+	"throttled" [label = "throttled\nclk < THROTTLED_TIME_NS"];
+	"throttled" -> "armed_throttled" [ label = "dl_defer_arm" ];
+	"throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"throttled" -> "running" [ label = "dl_replenish;reset(clk)" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
-- 
2.55.0

