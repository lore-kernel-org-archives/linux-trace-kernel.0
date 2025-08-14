Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F621B9CF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184219; cv=none; b=nUDvZVsaHHX0ajALmvemRahl7ruRPG4H8YE15T/Cs09a9+lEa8AS6Z55l6BktjwTDqIrcsyUz0hBP9tnXzGKIAytOOnLNzw3mYvA/mNUQego0ky8IvLjvtV+muqagek2E8MtJYBTtOaL3M6otqwVJeOVEY/Z5UP5kULQx1prsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184219; c=relaxed/simple;
	bh=vbNUuQ+LEC8jHEYcLR4c+coDZ+fgEIVwo79nvcHDkCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvmaMJBEScHg1M9zJ7i5gXmTYMG0mlDPj63HkF0+Xa5/0n3kvwpY4l8S1vxOIdJxcXx23IUDXGl8nraaSe3ZcZbZkAESwmCk2BTr/zzKLdwEIqHP5+fimxtKAMHLFX5AKkWt8oPYDt0/T7+AGuhdFeBsuoZWpJP7y+41ElQlBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOzvENu+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOzvENu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khBqRM5AjZJd10ToKw1jOg1G418nf/ZBqYYXNkLs71k=;
	b=FOzvENu+SjWxWj0k749vn0lu0jhhu42SeVCTaaAX8DgH6iCl6C93rVrJdBJU1yyoblmA3g
	TEe0bZTlzALfAfee5s+Mv6qP6jSvAdir6AXc9vq0GTXPr5xv3EtxyDDOwfJOZ1pBYI3yHe
	z0p+J0e8wfsW9E+5QUW0Vs+jPGbH+AI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-PpfKwIFyOOWQVGm5kGsYkw-1; Thu,
 14 Aug 2025 11:10:13 -0400
X-MC-Unique: PpfKwIFyOOWQVGm5kGsYkw-1
X-Mimecast-MFC-AGG-ID: PpfKwIFyOOWQVGm5kGsYkw_1755184211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEE68195F166;
	Thu, 14 Aug 2025 15:10:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FD74180047F;
	Thu, 14 Aug 2025 15:10:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 17/17] rv: Add deadline monitors
Date: Thu, 14 Aug 2025 17:08:09 +0200
Message-ID: <20250814150809.140739-18-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the deadline monitors collection to validate the deadline scheduler,
both for deadline tasks and servers.

The currently implemented monitors are:
* throttle:
    validate dl entities are throttled when they use up their runtime
* nomiss:
    validate dl entities run to completion before their deadiline

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_deadline.rst   | 111 ++++++++
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/deadline/Kconfig     |   5 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  35 +++
 kernel/trace/rv/monitors/deadline/deadline.h  |  82 ++++++
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 234 ++++++++++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      |  81 ++++++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  19 ++
 kernel/trace/rv/monitors/throttle/Kconfig     |  15 +
 kernel/trace/rv/monitors/throttle/throttle.c  | 259 ++++++++++++++++++
 kernel/trace/rv/monitors/throttle/throttle.h  | 115 ++++++++
 .../rv/monitors/throttle/throttle_trace.h     |  19 ++
 kernel/trace/rv/rv_trace.h                    |   2 +
 tools/verification/models/deadline/nomiss.dot |  23 ++
 .../verification/models/deadline/throttle.dot |  43 +++
 17 files changed, 1066 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_deadline.rst
 create mode 100644 kernel/trace/rv/monitors/deadline/Kconfig
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.c
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_trace.h
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/nomiss.dot
 create mode 100644 tools/verification/models/deadline/throttle.dot

diff --git a/Documentation/trace/rv/monitor_deadline.rst b/Documentation/trace/rv/monitor_deadline.rst
new file mode 100644
index 000000000000..af144605bbb0
--- /dev/null
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -0,0 +1,111 @@
+Scheduler monitors
+==================
+
+- Name: deadline
+- Type: container for multiple monitors
+- Author: Gabriele Monaco <gmonaco@redhat.com>
+
+Description
+-----------
+
+The deadline monitor is a set of specifications to describe the deadline
+scheduler behaviour. It includes monitors per scheduling entity (deadline tasks
+and servers) that work independently to verify different specifications the
+deadline scheduler should follow.
+
+Specifications
+--------------
+
+Monitor throttle
+~~~~~~~~~~~~~~~~
+
+The throttle monitor ensures deadline entities are throttled when they use up
+their runtime. Deadline tasks can be only ``running``, ``preempted`` and
+``throttled``, the runtime is enforced only in ``running`` based on an internal
+clock and the runtime value in the deadline entity.
+
+Servers can be also in the ``armed`` state, which corresponds to when the
+server is consuming bandwidth in background (e.g. idle or normal tasks are
+running without any boost). From this state the server can be throttled but it
+can also use more runtime than available. A server is considered ``running``
+when it's actively boosting a task, only there the runtime is enforced::
+
+                                     |
+                                     |
+      dl_replenish;reset(clk)        v
+              sched_switch_in   #=========================# sched_switch_in;
+               +--------------- H                         H   reset(clk)
+               |                H                         H <----------------+
+               +--------------> H         running         H                  |
+    dl_throttle                 H clk < runtime_left_ns() H                  |
+  +---------------------------- H                         H sched_switch_out |
+  |      +--------------------> H                         H -------------+   |
+  |     dl_replenish;           #=========================#              |   |
+  |      reset(clk)                  |             ^                     |   |
+  |      |                    dl_defer_arm   sched_switch_in;            |   |
+  |      |                           |         reset(clk)                |   |
+  v      |                           v             |                     |   |
+ +------------+       dl_replenish  +----------------+                   |   |
+ |            |       dl_defer_arm  |                | sched_switch_out  |   |
+ | throttled  |         +---------- |     armed      | -------------+    |   |
+ |            |         |           |                | <--------+   |    |   |
+ +------------+         +---------> |                | dl_defer_arm |    |   |
+   |      |                         +----------------+          |   |    |   |
+   |      |                             |         ^             |   |    |   |
+   |      |                         dl_throttle  dl_replenish   |   |    |   |
+   |      | dl_throttle;yielded==1      v         |             |   |    |   |
+   |      |   dl_defer_arm         +--------------------+       |   v    v   |
+   |      |            +---------- |                    |     +--------------+
+   |      |            |           |                    |     |              |
+   |      |            +---------> |  armed_throttled   |     |  preempted   |
+   |      |                        |                    |     |              |
+   |      +----------------------> |                    |     +--------------+
+   |        dl_defer_arm           +--------------------+              ^
+   |                                 |                ^                |
+   |                         sched_switch_out         | dl_defer_arm   |
+   |                                 v                |                |
+   |             sched_switch_out  +-------------------------+         |
+   |               +-------------- |                         |   dl_replenish
+   |               |               |                         |         |
+   |               +-------------> |   preempted_throttled   | --------+
+   |                               |                         |
+   +-----------------------------> |                         |
+         sched_switch_out          +-------------------------+
+
+
+Monitor nomiss
+~~~~~~~~~~~~~~
+
+The nomiss monitor ensures dl entities run to completion before their
+deadiline. An entity is considered done if throttled, either because it yielded
+or used up its runtime, or when it goes to sleep.
+The monitor includes a user configurable deadline threshold. If the total
+utilisation of deadline tasks is larger than 1, they are only guaranteed
+bounded tardiness. See Documentation/scheduler/sched-deadline.rst for more
+details. The threshold (module parameter ``nomiss.deadline_thresh``) can be
+configured to avoid the monitor to fail based on the acceptable tardiness in
+the system::
+
+                             sched_switch_in
+                             sched_wakeup
+                           +----------------------+
+                           v                      |
+                         #==========================#  sched_switch_suspend
+               --------> H                          H ----------------+
+                         H                          H                 v
+                         H                          H           +----------+
+                         H                          H           | sleeping |
+                         H         running          H           +----------+
+                         H clk < DEADLINE_LEFT_NS() H  sched_wakeup;  |
+                         H                          H  reset(clk)     |
+                         H                          H <---------------+
+     +-----------------> H                          H -+
+     |                   #==========================#  |
+     |                                                 |
+     |                       sched_switch_suspend      |
+ sched_switch_in             dl_throttle               |
+ sched_wakeup;reset(clk)   +----------------------+    | dl_throttle
+     |                     v                      |    |
+     |                   +--------------------------+  |
+     +------------------ |        throttled         | <+
+                         +--------------------------+
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 720fbe4935f8..719cdcfb6d41 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -79,6 +79,11 @@ source "kernel/trace/rv/monitors/sleep/Kconfig"
 # Add new rtapp monitors here
 
 source "kernel/trace/rv/monitors/stall/Kconfig"
+source "kernel/trace/rv/monitors/deadline/Kconfig"
+source "kernel/trace/rv/monitors/nomiss/Kconfig"
+source "kernel/trace/rv/monitors/throttle/Kconfig"
+# Add new deadline monitors here
+
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 51c95e2d2da6..15a1edc8bd0f 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -18,6 +18,9 @@ obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
+obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
+obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
+obj-$(CONFIG_RV_MON_THROTTLE) += monitors/throttle/throttle.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/deadline/Kconfig b/kernel/trace/rv/monitors/deadline/Kconfig
new file mode 100644
index 000000000000..652876730a39
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/Kconfig
@@ -0,0 +1,5 @@
+config RV_MON_DEADLINE
+	depends on RV
+	bool "deadline monitor"
+	help
+	  auto-generated
diff --git a/kernel/trace/rv/monitors/deadline/deadline.c b/kernel/trace/rv/monitors/deadline/deadline.c
new file mode 100644
index 000000000000..61564fbbe333
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/deadline.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "deadline"
+
+#include "deadline.h"
+
+struct rv_monitor rv_deadline = {
+	.name = "deadline",
+	.description = "auto-generated",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_deadline(void)
+{
+	return rv_register_monitor(&rv_deadline, NULL);
+}
+
+static void __exit unregister_deadline(void)
+{
+	rv_unregister_monitor(&rv_deadline);
+}
+
+module_init(register_deadline);
+module_exit(unregister_deadline);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("deadline: auto-generated");
diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
new file mode 100644
index 000000000000..20f51e1de866
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/kernel.h>
+#include <asm/syscall.h>
+#include <uapi/linux/sched/types.h>
+
+/*
+ * Dummy values if not available
+ */
+#ifndef __NR_sched_setscheduler
+#define __NR_sched_setscheduler -1
+#endif
+#ifndef __NR_sched_setattr
+#define __NR_sched_setattr -2
+#endif
+
+extern struct rv_monitor rv_deadline;
+
+/*
+ * If both have dummy values, the syscalls are not supported and we don't even
+ * need to register the handler.
+ */
+static inline bool should_skip_syscall_handle(void)
+{
+	return __NR_sched_setattr < 0 && __NR_sched_setscheduler < 0;
+}
+
+static inline int get_server_id(void)
+{
+	/*
+	 * Use negative numbers for the server.
+	 * Currently only one fair server per CPU, may change in the future.
+	 */
+	return -__smp_processor_id();
+}
+
+static inline int extract_params(struct pt_regs *regs, long id, struct task_struct **p)
+{
+	size_t size = offsetof(struct sched_attr, sched_nice);
+	struct sched_attr __user *uattr, attr;
+	int new_policy = -1, ret;
+	unsigned long args[6];
+	pid_t pid;
+
+	switch (id) {
+		case __NR_sched_setscheduler:
+			syscall_get_arguments(current, regs, args);
+			pid = args[0];
+			new_policy = args[1];
+			break;
+		case __NR_sched_setattr:
+			syscall_get_arguments(current, regs, args);
+			pid = args[0];
+			uattr = (void *)args[1];
+			/*
+			 * Just copy up to sched_flags, we are not interested after that
+			 */
+			ret = copy_struct_from_user(&attr, size, uattr, size);
+			if (ret)
+				return ret;
+			if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+				return -EINVAL;
+			new_policy = attr.sched_policy;
+			break;
+		default:
+			return -EINVAL;
+	}
+	if (!pid)
+		*p = current;
+	else {
+		/*
+		 * Required for find_task_by_vpid, make sure the caller doesn't
+		 * need to get_task_struct().
+		 */
+		guard(rcu)();
+		*p = find_task_by_vpid(pid);
+		if (unlikely(!p))
+			return -EINVAL;
+	}
+
+	return new_policy;
+}
diff --git a/kernel/trace/rv/monitors/nomiss/Kconfig b/kernel/trace/rv/monitors/nomiss/Kconfig
new file mode 100644
index 000000000000..e1886c3a0dd9
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_NOMISS
+	depends on RV
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	depends on RV_MON_DEADLINE
+	default y
+	select HA_MON_EVENTS_ID
+	bool "nomiss monitor"
+	help
+	  Monitor to ensure dl entities run to completion before their deadiline.
+	  This monitor is part of the deadline monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_deadline.rst
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
new file mode 100644
index 000000000000..4b61a861a62c
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "nomiss"
+
+#include <uapi/linux/sched/types.h>
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/task.h>
+#include <rv_trace.h>
+#include <monitors/deadline/deadline.h>
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+/* The start condition is on sched_switch, it's dangerous to allocate there */
+#define DA_SKIP_AUTO_ALLOC
+typedef struct sched_dl_entity *monitor_target;
+#include "nomiss.h"
+#include <rv/ha_monitor.h>
+
+/*
+ * da_get_id - Get the id from a dl server
+ *
+ * Deadline tasks use the task's PID, while fair servers use the negated cpu.
+ */
+static inline da_id_type da_get_id(monitor_target target)
+{
+	if (target->dl_server)
+		return get_server_id();
+	return container_of(target, struct task_struct, dl)->pid;
+}
+
+/*
+ * User configurable deadline threshold. If the total utilisation of deadline
+ * tasks is larger than 1, they are only guaranteed bounded tardiness. See
+ * Documentation/scheduler/sched-deadline.rst for more details.
+ */
+static u64 deadline_thresh = 0;
+module_param(deadline_thresh, ullong, 0644);
+#define DEADLINE_LEFT_NS(ha_mon) (ha_get_target(ha_mon)->deadline + deadline_thresh)
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_nomiss env)
+{
+	if (env == clk_nomiss)
+		return ha_get_clk_ns(ha_mon, env);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_nomiss env)
+{
+	if (env == clk_nomiss)
+		ha_reset_clk_ns(ha_mon, env);
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state)
+{
+	bool res = true;
+
+	if (curr_state == sleeping_nomiss && event == sched_switch_in_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss);
+	else if (curr_state == throttled_nomiss && event == sched_switch_in_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss);
+
+	if (next_state == curr_state || !res)
+		return res;
+	if (next_state == running_nomiss)
+		ha_start_timer_ns(ha_mon, clk_nomiss, DEADLINE_LEFT_NS(ha_mon));
+	else if (curr_state == running_nomiss)
+		res = !ha_cancel_timer(ha_mon);
+	return res;
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl)
+{
+	da_handle_event(dl, dl_throttle_nomiss);
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl)
+{
+	da_handle_start_event(dl, sched_switch_in_nomiss);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl, bool hard)
+{
+	if (hard)
+		da_handle_event(dl, sched_switch_suspend_nomiss);
+}
+
+static void handle_sched_switch(void *data, bool preempt, struct task_struct *prev, struct task_struct *next, unsigned int prev_state)
+{
+	if (prev_state != TASK_RUNNING && prev->policy == SCHED_DEADLINE)
+		da_handle_event(&prev->dl, sched_switch_suspend_nomiss);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_event(&next->dl, sched_switch_in_nomiss);
+}
+
+static void handle_syscall(void *data, struct pt_regs *regs, long id)
+{
+	struct task_struct *p;
+	int new_policy = -1;
+
+	new_policy = extract_params(regs, id, &p);
+	if (new_policy < 0 || new_policy == p->policy)
+		return;
+	if (p->policy == SCHED_DEADLINE)
+		da_reset(&p->dl);
+	else if (new_policy == SCHED_DEADLINE)
+		da_create_conditional(&p->dl);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *tsk)
+{
+	if (tsk->policy == SCHED_DEADLINE)
+		da_handle_start_event(&tsk->dl, sched_wakeup_nomiss);
+}
+
+static void handle_newtask(void *data, struct task_struct *task, unsigned long flags)
+{
+	/* Might be superfluous as tasks are not started with this policy.. */
+	if (task->policy == SCHED_DEADLINE)
+		da_create_storage(&task->dl, NULL);
+}
+
+static void handle_exit(void *data, struct task_struct *p, bool group_dead)
+{
+	if (p->policy == SCHED_DEADLINE)
+		da_destroy_storage(&p->dl);
+}
+
+/*
+ * Initialise monitors for all tasks and pre-allocate the storage for servers.
+ * This is necessary since we don't have access to the servers here and
+ * allocation can cause deadlocks from their tracepoints. We can only fill
+ * pre-initialised storage from there.
+ */
+static inline int init_storage(void)
+{
+	struct task_struct *g, *p;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		/* The servers' ids are determined according to da_get_id */
+		if (!da_create_empty_storage(-cpu))
+			goto fail;
+	}
+
+	for_each_process_thread(g, p) {
+		if (p->policy == SCHED_DEADLINE) {
+			if (!da_create_storage(&p->dl, NULL))
+				goto fail;
+		}
+	}
+	return 0;
+
+fail:
+	da_monitor_destroy();
+	return -ENOMEM;
+}
+
+static int enable_nomiss(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	retval = init_storage();
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("nomiss", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("nomiss", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_attach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_attach_trace_probe("nomiss", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("nomiss", sys_enter, handle_syscall);
+	rv_attach_trace_probe("nomiss", task_newtask, handle_newtask);
+	rv_attach_trace_probe("nomiss", sched_process_exit, handle_exit);
+
+	return 0;
+}
+
+static void disable_nomiss(void)
+{
+	rv_nomiss.enabled = 0;
+
+	/* Those are RCU writers, detach earlier hoping to close a bit faster */
+	rv_detach_trace_probe("nomiss", task_newtask, handle_newtask);
+	rv_detach_trace_probe("nomiss", sched_process_exit, handle_exit);
+	if (!should_skip_syscall_handle())
+		rv_detach_trace_probe("nomiss", sys_enter, handle_syscall);
+
+	rv_detach_trace_probe("nomiss", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("nomiss", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_detach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_nomiss = {
+	.name = "nomiss",
+	.description = "dl entities run to completion before their deadiline.",
+	.enable = enable_nomiss,
+	.disable = disable_nomiss,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_nomiss(void)
+{
+	return rv_register_monitor(&rv_nomiss, &rv_deadline);
+}
+
+static void __exit unregister_nomiss(void)
+{
+	rv_unregister_monitor(&rv_nomiss);
+}
+
+module_init(register_nomiss);
+module_exit(unregister_nomiss);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadiline.");
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.h b/kernel/trace/rv/monitors/nomiss/nomiss.h
new file mode 100644
index 000000000000..a4059b34c60d
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of nomiss automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME nomiss
+
+enum states_nomiss {
+	running_nomiss = 0,
+	sleeping_nomiss,
+	throttled_nomiss,
+	state_max_nomiss
+};
+
+#define INVALID_STATE state_max_nomiss
+
+enum events_nomiss {
+	dl_throttle_nomiss = 0,
+	sched_switch_in_nomiss,
+	sched_switch_suspend_nomiss,
+	sched_wakeup_nomiss,
+	event_max_nomiss
+};
+
+enum envs_nomiss {
+	clk_nomiss = 0,
+	env_max_nomiss,
+	env_max_stored_nomiss = env_max_nomiss
+};
+
+_Static_assert(env_max_stored_nomiss <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_nomiss {
+	char *state_names[state_max_nomiss];
+	char *event_names[event_max_nomiss];
+	char *env_names[env_max_nomiss];
+	unsigned char function[state_max_nomiss][event_max_nomiss];
+	unsigned char initial_state;
+	bool final_states[state_max_nomiss];
+};
+
+static const struct automaton_nomiss automaton_nomiss = {
+	.state_names = {
+		"running",
+		"sleeping",
+		"throttled"
+	},
+	.event_names = {
+		"dl_throttle",
+		"sched_switch_in",
+		"sched_switch_suspend",
+		"sched_wakeup"
+	},
+	.env_names = {
+		"clk"
+	},
+	.function = {
+		{
+			throttled_nomiss,
+			running_nomiss,
+			sleeping_nomiss,
+			running_nomiss
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			running_nomiss
+		},
+		{
+			throttled_nomiss,
+			running_nomiss,
+			throttled_nomiss,
+			running_nomiss
+		},
+	},
+	.initial_state = running_nomiss,
+	.final_states = { 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_trace.h b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
new file mode 100644
index 000000000000..42e7efaca4e7
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_NOMISS
+DEFINE_EVENT(event_da_monitor_id, event_nomiss,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_nomiss,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_nomiss,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_NOMISS */
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
index 000000000000..412b53b268f5
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle.c
@@ -0,0 +1,259 @@
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
+#include <monitors/deadline/deadline.h>
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+/* The start condition is on sched_switch, it's dangerous to allocate there */
+#define DA_SKIP_AUTO_ALLOC
+typedef struct sched_dl_entity *monitor_target;
+#include "throttle.h"
+#include <rv/ha_monitor.h>
+
+/*
+ * da_get_id - Get the id from a dl server
+ *
+ * Deadline tasks use the task's PID, while fair servers use the negated cpu.
+ */
+static inline da_id_type da_get_id(monitor_target target)
+{
+	if (target->dl_server)
+		return get_server_id();
+	return container_of(target, struct task_struct, dl)->pid;
+}
+
+/* with sched_feat(HRTICK_DL) the threshold should be lower */
+#define RUNTIME_THRESH jiffies_to_nsecs(1)
+
+static inline u64 runtime_left_ns(struct ha_monitor *ha_mon)
+{
+	return ha_get_target(ha_mon)->runtime + RUNTIME_THRESH;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_throttle env)
+{
+	if (env == clk_throttle)
+		return ha_get_clk_ns(ha_mon, env);
+	else if (env == yielded_throttle)
+		return ha_get_target(ha_mon)->dl_yielded;
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_throttle env)
+{
+	if (env == clk_throttle)
+		ha_reset_clk_ns(ha_mon, env);
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state)
+{
+	bool res = true;
+
+	if (curr_state == armed_throttle && event == sched_switch_in_throttle)
+		ha_reset_env(ha_mon, clk_throttle);
+	else if (curr_state == armed_throttled_throttle && event == dl_throttle_throttle)
+		res = ha_get_env(ha_mon, yielded_throttle) == 1ull;
+	else if (curr_state == preempted_throttle && event == sched_switch_in_throttle)
+		ha_reset_env(ha_mon, clk_throttle);
+	else if (curr_state == running_throttle && event == dl_replenish_throttle)
+		ha_reset_env(ha_mon, clk_throttle);
+	else if (curr_state == throttled_throttle && event == dl_replenish_throttle)
+		ha_reset_env(ha_mon, clk_throttle);
+
+	if ((next_state == curr_state && event != dl_replenish_throttle) || !res)
+		return res;
+	if (next_state == running_throttle)
+		ha_start_timer_ns(ha_mon, clk_throttle, runtime_left_ns(ha_mon));
+	else if (curr_state == running_throttle)
+		res = !ha_cancel_timer(ha_mon);
+	return res;
+}
+
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl)
+{
+	da_handle_event(dl, dl_replenish_throttle);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl)
+{
+	da_handle_event(dl, dl_throttle_throttle);
+}
+
+static inline struct sched_dl_entity *get_fair_server(struct task_struct *tsk)
+{
+	if (tsk->dl_server)
+		return tsk->dl_server;
+	return da_get_target_by_id(get_server_id());
+}
+
+static void handle_sched_switch(void *data, bool preempt, struct task_struct *prev, struct task_struct *next, unsigned int prev_state)
+{
+	struct sched_dl_entity *dl;
+
+	if (prev->policy == SCHED_DEADLINE)
+		da_handle_event(&prev->dl, sched_switch_out_throttle);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_event(&next->dl, sched_switch_in_throttle);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 */
+	dl = get_fair_server(next);
+	if (!dl)
+		return;
+	if (next->dl_server)
+		da_handle_start_event(next->dl_server, sched_switch_in_throttle);
+	else if (is_idle_task(next) || next->policy == SCHED_NORMAL)
+		da_handle_event(dl, dl_defer_arm_throttle);
+	else
+		da_handle_event(dl, sched_switch_out_throttle);
+}
+
+static void handle_syscall(void *data, struct pt_regs *regs, long id)
+{
+	struct task_struct *p;
+	int new_policy = -1;
+
+	new_policy = extract_params(regs, id, &p);
+	if (new_policy < 0 || new_policy == p->policy)
+		return;
+	if (p->policy == SCHED_DEADLINE) {
+		da_reset(&p->dl);
+		/*
+		 * When a task changes from SCHED_DEADLINE to SCHED_NORMAL, the
+		 * runtime after the change is counted in the fair server.
+		 */
+		if (new_policy == SCHED_NORMAL) {
+			struct sched_dl_entity *dl = get_fair_server(p);
+			if (!dl)
+				return;
+			da_handle_event(dl, dl_defer_arm_throttle);
+		}
+	} else if (new_policy == SCHED_DEADLINE) {
+		da_create_conditional(&p->dl);
+	}
+}
+
+static void handle_newtask(void *data, struct task_struct *task, unsigned long flags)
+{
+	/* Might be superfluous as tasks are not started with this policy.. */
+	if (task->policy == SCHED_DEADLINE)
+		da_create_storage(&task->dl, NULL);
+}
+
+static void handle_exit(void *data, struct task_struct *p, bool group_dead)
+{
+	if (p->policy == SCHED_DEADLINE)
+		da_destroy_storage(&p->dl);
+}
+
+/*
+ * Initialise monitors for all tasks and pre-allocate the storage for servers.
+ * This is necessary since we don't have access to the servers here and
+ * allocation can cause deadlocks from their tracepoints. We can only fill
+ * pre-initialised storage from there.
+ */
+static inline int init_storage(void)
+{
+	struct task_struct *g, *p;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		/* The servers' ids are determined according to da_get_id */
+		if (!da_create_empty_storage(-cpu))
+			goto fail;
+	}
+
+	for_each_process_thread(g, p) {
+		if (p->policy == SCHED_DEADLINE) {
+			if (!da_create_storage(&p->dl, NULL))
+				goto fail;
+		}
+	}
+	return 0;
+
+fail:
+	da_monitor_destroy();
+	return -ENOMEM;
+}
+
+static int enable_throttle(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	retval = init_storage();
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("throttle", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("throttle", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("throttle", sched_switch, handle_sched_switch);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("throttle", sys_enter, handle_syscall);
+	rv_attach_trace_probe("throttle", task_newtask, handle_newtask);
+	rv_attach_trace_probe("throttle", sched_process_exit, handle_exit);
+
+	return 0;
+}
+
+static void disable_throttle(void)
+{
+	rv_throttle.enabled = 0;
+
+	/* Those are RCU writers, detach earlier hoping to close a bit faster */
+	rv_detach_trace_probe("throttle", task_newtask, handle_newtask);
+	rv_detach_trace_probe("throttle", sched_process_exit, handle_exit);
+	if (!should_skip_syscall_handle())
+		rv_detach_trace_probe("throttle", sys_enter, handle_syscall);
+
+	rv_detach_trace_probe("throttle", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_detach_trace_probe("throttle", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("throttle", sched_switch, handle_sched_switch);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_throttle = {
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
+	return rv_register_monitor(&rv_throttle, &rv_deadline);
+}
+
+static void __exit unregister_throttle(void)
+{
+	rv_unregister_monitor(&rv_throttle);
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
index 000000000000..084221556bae
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle.h
@@ -0,0 +1,115 @@
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
+	running_throttle = 0,
+	armed_throttle,
+	armed_throttled_throttle,
+	preempted_throttle,
+	preempted_throttled_throttle,
+	throttled_throttle,
+	state_max_throttle
+};
+
+#define INVALID_STATE state_max_throttle
+
+enum events_throttle {
+	dl_defer_arm_throttle = 0,
+	dl_replenish_throttle,
+	dl_throttle_throttle,
+	sched_switch_in_throttle,
+	sched_switch_out_throttle,
+	event_max_throttle
+};
+
+enum envs_throttle {
+	clk_throttle = 0,
+	yielded_throttle,
+	env_max_throttle,
+	env_max_stored_throttle = yielded_throttle
+};
+
+_Static_assert(env_max_stored_throttle <= MAX_HA_ENV_LEN, "Not enough slots");
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
+		"throttled"
+	},
+	.event_names = {
+		"dl_defer_arm",
+		"dl_replenish",
+		"dl_throttle",
+		"sched_switch_in",
+		"sched_switch_out"
+	},
+	.env_names = {
+		"clk",
+		"yielded"
+	},
+	.function = {
+		{
+			armed_throttle,
+			running_throttle,
+			throttled_throttle,
+			running_throttle,
+			preempted_throttle
+		},
+		{
+			armed_throttle,
+			armed_throttle,
+			armed_throttled_throttle,
+			running_throttle,
+			preempted_throttle
+		},
+		{
+			armed_throttled_throttle,
+			armed_throttle,
+			armed_throttled_throttle,
+			INVALID_STATE,
+			preempted_throttled_throttle
+		},
+		{
+			armed_throttle,
+			preempted_throttle,
+			INVALID_STATE,
+			running_throttle,
+			preempted_throttle
+		},
+		{
+			armed_throttled_throttle,
+			preempted_throttle,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempted_throttled_throttle
+		},
+		{
+			armed_throttled_throttle,
+			running_throttle,
+			INVALID_STATE,
+			INVALID_STATE,
+			preempted_throttled_throttle
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
index 601b03179328..40b19e2aa69c 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -188,6 +188,8 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 );
 
 #include <monitors/stall/stall_trace.h>
+#include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/throttle/throttle_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/deadline/nomiss.dot b/tools/verification/models/deadline/nomiss.dot
new file mode 100644
index 000000000000..81d7028cfc3b
--- /dev/null
+++ b/tools/verification/models/deadline/nomiss.dot
@@ -0,0 +1,23 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = doublecircle] "running"};
+	{node [shape = circle] "running"};
+	{node [shape = circle] "sleeping"};
+	{node [shape = circle] "throttled"};
+	"__init_running" -> "running";
+	"running" [label = "running\nclk < DEADLINE_LEFT_NS()", color = green3];
+	"running" -> "running" [ label = "sched_switch_in\nsched_wakeup" ];
+	"running" -> "sleeping" [ label = "sched_switch_suspend" ];
+	"running" -> "throttled" [ label = "dl_throttle" ];
+	"sleeping" [label = "sleeping"];
+	"sleeping" -> "running" [ label = "sched_wakeup;reset(clk)" ];
+	"throttled" [label = "throttled"];
+	"throttled" -> "running" [ label = "sched_switch_in\nsched_wakeup;reset(clk)" ];
+	"throttled" -> "throttled" [ label = "sched_switch_suspend\ndl_throttle" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
diff --git a/tools/verification/models/deadline/throttle.dot b/tools/verification/models/deadline/throttle.dot
new file mode 100644
index 000000000000..2477115aa286
--- /dev/null
+++ b/tools/verification/models/deadline/throttle.dot
@@ -0,0 +1,43 @@
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
+	"armed_throttled" -> "armed_throttled" [ label = "dl_defer_arm\ndl_throttle;yielded==1" ];
+	"armed_throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"preempted" [label = "preempted"];
+	"preempted" -> "armed" [ label = "dl_defer_arm" ];
+	"preempted" -> "preempted" [ label = "dl_replenish\nsched_switch_out" ];
+	"preempted" -> "running" [ label = "sched_switch_in;reset(clk)" ];
+	"preempted_throttled" [label = "preempted_throttled"];
+	"preempted_throttled" -> "armed_throttled" [ label = "dl_defer_arm" ];
+	"preempted_throttled" -> "preempted" [ label = "dl_replenish" ];
+	"preempted_throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"running" [label = "running\nclk < runtime_left_ns()", color = green3];
+	"running" -> "armed" [ label = "dl_defer_arm" ];
+	"running" -> "preempted" [ label = "sched_switch_out" ];
+	"running" -> "running" [ label = "dl_replenish;reset(clk)\nsched_switch_in" ];
+	"running" -> "throttled" [ label = "dl_throttle" ];
+	"throttled" [label = "throttled"];
+	"throttled" -> "armed_throttled" [ label = "dl_defer_arm" ];
+	"throttled" -> "preempted_throttled" [ label = "sched_switch_out" ];
+	"throttled" -> "running" [ label = "dl_replenish;reset(clk)" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
-- 
2.50.1

