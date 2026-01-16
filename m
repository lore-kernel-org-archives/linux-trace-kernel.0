Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B721FF55
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567256; cv=none; b=M+v01wiOnCi2EdRd9A45g2bQaqQ7iLm71eecwOG4SF+2DTZsIADq2J0sfLwuMn69BAIESHxIhWcQMfob5P/PLwRanlYDYnO4YdRaCw3eyIAVp4ub1BnYvS5BJG8a2wHoPSD4DAgIbZMEf1DBD16NZ1wVQIyUjCYau1ZO63MJPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567256; c=relaxed/simple;
	bh=iHIw0h2YWIlm5GF/dpDpJFafmeT5f9qmLJiYQodo2I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0NlzGSM+aEchCFf8+8vy5eqnQ6XMewIwkwuEUhXa/79rK3Wb7m/UmPWXRQ9t4mbutgKtkN6yrHr/HI0bVKhSNkkbmxMrexnz1VTUkcOzqplCMuxZsgAxJDs9VBiHKYyevoE6e3XCSL2HQ+tkATHIO9eePzYOCrQKtQogwLb/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Be3Ji1s8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be3Ji1s8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeLmas/1ktXITN7+z8eoyvOyK93FR/+eoE97boWCrwQ=;
	b=Be3Ji1s8AQOlgqUlOuctr+jjQtubPmVuScYkH1RcxAUALmjKYTuf7NBYQio0Qr8/qq/RD0
	OwWwQsrbD8voSLKs9fXW83Wpjgahyvz97QR2UfVwjfqNatcZT7ANIIFfcJ/JkazwSF59uN
	PEdBVka+KZNbkYi/GGJvv7lxQQIhmfk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-a7zhhaNWOQ-pSl65IW5wBw-1; Fri,
 16 Jan 2026 07:40:49 -0500
X-MC-Unique: a7zhhaNWOQ-pSl65IW5wBw-1
X-Mimecast-MFC-AGG-ID: a7zhhaNWOQ-pSl65IW5wBw_1768567248
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EC9D1956052;
	Fri, 16 Jan 2026 12:40:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 929AC1955F22;
	Fri, 16 Jan 2026 12:40:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 14/15] rv: Add deadline monitors
Date: Fri, 16 Jan 2026 13:39:10 +0100
Message-ID: <20260116123911.130300-15-gmonaco@redhat.com>
In-Reply-To: <20260116123911.130300-1-gmonaco@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the deadline monitors collection to validate the deadline scheduler,
both for deadline tasks and servers.

The currently implemented monitors are:
* throttle:
    validate dl entities are throttled when they use up their runtime
* nomiss:
    validate dl entities run to completion before their deadiline

Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Rename handle_syscall as it collides with some UM function
    * Simplify idle handling on nomiss and throttle from sleeping
    * Improve switch_out for servers in throttle
    V3:
    * Adapt models to new dl server behaviour
    * Rename dl argument to dl_se in tracepoints
    * Use __COUNTER__ in dl monitor syscall helpers

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_deadline.rst   | 152 ++++++++++
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/deadline/Kconfig     |  10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  35 +++
 kernel/trace/rv/monitors/deadline/deadline.h  | 168 +++++++++++
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 279 ++++++++++++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      | 130 ++++++++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  19 ++
 kernel/trace/rv/monitors/throttle/Kconfig     |  15 +
 kernel/trace/rv/monitors/throttle/throttle.c  | 250 ++++++++++++++++
 kernel/trace/rv/monitors/throttle/throttle.h  | 116 ++++++++
 .../rv/monitors/throttle/throttle_trace.h     |  19 ++
 kernel/trace/rv/rv_trace.h                    |   2 +
 tools/verification/models/deadline/nomiss.dot |  41 +++
 .../verification/models/deadline/throttle.dot |  44 +++
 18 files changed, 1304 insertions(+)
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

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index bf9962f49959..29769f06bb0f 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -17,3 +17,4 @@ Runtime Verification
    monitor_sched.rst
    monitor_rtapp.rst
    monitor_stall.rst
+   monitor_deadline.rst
diff --git a/Documentation/trace/rv/monitor_deadline.rst b/Documentation/trace/rv/monitor_deadline.rst
new file mode 100644
index 000000000000..a5492c77ea9e
--- /dev/null
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -0,0 +1,152 @@
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
+
+Monitor nomiss
+~~~~~~~~~~~~~~
+
+The nomiss monitor ensures dl entities get to run *and* run to completion
+before their deadline, although deferrable servers may not run. An entity is
+considered done if ``throttled``, either because it yielded or used up its
+runtime, or when it voluntarily starts ``sleeping``.
+The monitor includes a user configurable deadline threshold. If the total
+utilisation of deadline tasks is larger than 1, they are only guaranteed
+bounded tardiness. See Documentation/scheduler/sched-deadline.rst for more
+details. The threshold (module parameter ``nomiss.deadline_thresh``) can be
+configured to avoid the monitor to fail based on the acceptable tardiness in
+the system. Since ``dl_throttle`` is a valid outcome for the entity to be done,
+the minimum tardiness needs be 1 tick to consider the throttle delay, unless
+the ``HRTICK_DL`` scheduler featuer is active.
+
+Servers have also an intermediate ``idle`` state, occurring as soon as no
+runnable task is available from ready or running where no timing constraint
+is applied::
+
+  sched_wakeup                    |
+  dl_server_start                 v
+  dl_replenish;reset(clk) -- #=========================#
+               |             H                         H dl_replenish;reset(clk)
+               +-----------> H                         H <--------------------+
+                             H                         H                      |
+      +- dl_server_stop ---- H          ready          H                      |
+      |  +-----------------> H   clk < DEADLINE_NS()   H   dl_throttle;       |
+      |  |                   H                         H     is_defer == 1    |
+      |  | sched_switch_in - H                         H -----------------+   |
+      |  |   |               #=========================#                  |   |
+      |  |   |                       |            ^                       |   |
+      |  |   |             dl_server_idle    dl_replenish;reset(clk)      |   |
+      |  |   |                       v            |                       |   |
+      |  |   |                      +--------------+                      |   |
+      |  |   |  dl_server_idle ---- |              |                      |   |
+      |  |   |  dl_server_start     |              | dl_throttle          |   |
+      |  |   |           |          |     idle     | -----------------+   |   |
+      |  |   |           +--------> |              |                  |   |   |
+      |  |   |                      |              |                  |   |   |
+      |  |   |                      |              |                  |   |   |
+   +--+--+---+--- dl_server_stop -- +--------------+                  |   |   |
+   |  |  |   |                       |           ^                    |   |   |
+   |  |  |   |            sched_switch_in    dl_server_idle           |   |   |
+   |  |  |   |                       v           |                    |   |   |
+   |  |  |   |      +---------- +---------------------+               |   |   |
+   |  |  |   | sched_switch_in  |                     |               |   |   |
+   |  |  |   | sched_wakeup     |                     |               |   |   |
+   |  |  |   | dl_replenish;    |      running        | -------+      |   |   |
+   |  |  |   |      reset(clk)  | clk < DEADLINE_NS() |        |      |   |   |
+   |  |  |   |      +---------> |                     | dl_throttle   |   |   |
+   |  |  |   +----------------> |                     |        |      |   |   |
+   |  |  |                      +---------------------+        |      |   |   |
+   |  | sched_wakeup                ^   sched_switch_suspend   |      |   |   |
+   v  v dl_replenish;reset(clk)     |   dl_server_stop         |      |   |   |
+ +--------------+                   |   |                      v      v   v   |
+ |              | - sched_switch_in +   |                     +---------------+
+ |              | <---------------------+     dl_throttle +-- |               |
+ |   sleeping   |                            sched_wakeup |   |   throttled   |
+ |              | -- dl_server_stop       dl_server_start +-> |               |
+ |              |    dl_server_start       dl_server_idle     +---------------+
+ +--------------+ <- dl_server_idle     sched_switch_suspend         ^
+        |                                                            |
+        +------ dl_throttle;is_constr_dl == 1 || is_defer == 1 ------+
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
index 000000000000..38804a6ad91d
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/Kconfig
@@ -0,0 +1,10 @@
+config RV_MON_DEADLINE
+	depends on RV
+	bool "deadline monitor"
+	help
+	  Collection of monitors to check the deadline scheduler and server
+	  behave according to specifications. Enable this to enable all
+	  scheduler specification supported by the current kernel.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_deadline.rst
diff --git a/kernel/trace/rv/monitors/deadline/deadline.c b/kernel/trace/rv/monitors/deadline/deadline.c
new file mode 100644
index 000000000000..45aed62c1371
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
+	.description = "container for several deadline scheduler specifications.",
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
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("deadline: container for several deadline scheduler specifications.");
diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
new file mode 100644
index 000000000000..b4cb8820f8fe
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/sched/deadline.h>
+#include <asm/syscall.h>
+#include <uapi/linux/sched/types.h>
+
+/*
+ * Dummy values if not available
+ */
+#ifndef __NR_sched_setscheduler
+#define __NR_sched_setscheduler -__COUNTER__
+#endif
+#ifndef __NR_sched_setattr
+#define __NR_sched_setattr -__COUNTER__
+#endif
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
+/*
+ * Use negative numbers for the server.
+ * Currently only one fair server per CPU, may change in the future.
+ */
+#define fair_server_id(cpu) (-cpu)
+/*
+ * Get a unique id used for dl entities
+ *
+ * The cpu is not required for tasks as the pid is used there, if this function
+ * is called on a dl_se that for sure corresponds to a task, DL_TASK can be
+ * used in place of cpu.
+ * We need the cpu for servers as it is provided in the tracepoint and we
+ * cannot easily retrieve it from the dl_se (requires the struct rq definition).
+ */
+static inline int get_entity_id(struct sched_dl_entity *dl_se, int cpu)
+{
+	if (dl_se->dl_server)
+		return fair_server_id(cpu);
+	return dl_task_of(dl_se)->pid;
+}
+
+/* Expand id and target as arguments for da functions */
+#define EXPAND_ID(dl_se, cpu) get_entity_id(dl_se, cpu), dl_se
+
+/* Use this as the cpu in EXPAND_ID in case the dl_se is surely from a task */
+#define DL_TASK -1
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
+	case __NR_sched_setscheduler:
+		syscall_get_arguments(current, regs, args);
+		pid = args[0];
+		new_policy = args[1];
+		break;
+	case __NR_sched_setattr:
+		syscall_get_arguments(current, regs, args);
+		pid = args[0];
+		uattr = (void *)args[1];
+		/*
+		 * Just copy up to sched_flags, we are not interested after that
+		 */
+		ret = copy_struct_from_user(&attr, size, uattr, size);
+		if (ret)
+			return ret;
+		if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+			return -EINVAL;
+		new_policy = attr.sched_policy;
+		break;
+	default:
+		return -EINVAL;
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
+		if (unlikely(!*p))
+			return -EINVAL;
+	}
+
+	return new_policy & ~SCHED_RESET_ON_FORK;
+}
+
+/* Helper functions requiring DA/HA utilities */
+#ifdef RV_MON_TYPE
+
+/*
+ * get_fair_server - get the fair server associated to a task
+ *
+ * If the task is a boosted task, the server is available in the task_struct,
+ * otherwise grab the dl entity saved for the CPU where the task is enqueued.
+ * This function assumes the task is enqueued somewhere.
+ */
+static inline struct sched_dl_entity *get_fair_server(struct task_struct *tsk)
+{
+	if (tsk->dl_server)
+		return tsk->dl_server;
+	return da_get_target_by_id(fair_server_id(task_cpu(tsk)));
+}
+
+/*
+ * Initialise monitors for all tasks and pre-allocate the storage for servers.
+ * This is necessary since we don't have access to the servers here and
+ * allocation can cause deadlocks from their tracepoints. We can only fill
+ * pre-initialised storage from there.
+ */
+static inline int init_storage(bool skip_tasks)
+{
+	struct task_struct *g, *p;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (!da_create_empty_storage(fair_server_id(cpu)))
+			goto fail;
+	}
+
+	if (skip_tasks)
+		return 0;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, p) {
+		if (p->policy == SCHED_DEADLINE) {
+			if (!da_create_storage(EXPAND_ID(&p->dl, DL_TASK), NULL)) {
+				read_unlock(&tasklist_lock);
+				goto fail;
+			}
+		}
+	}
+	read_unlock(&tasklist_lock);
+	return 0;
+
+fail:
+	da_monitor_destroy();
+	return -ENOMEM;
+}
+
+static void __maybe_unused handle_newtask(void *data, struct task_struct *task, u64 flags)
+{
+	/* Might be superfluous as tasks are not started with this policy.. */
+	if (task->policy == SCHED_DEADLINE)
+		da_create_storage(EXPAND_ID(&task->dl, DL_TASK), NULL);
+}
+
+static void __maybe_unused handle_exit(void *data, struct task_struct *p, bool group_dead)
+{
+	if (p->policy == SCHED_DEADLINE)
+		da_destroy_storage(get_entity_id(&p->dl, DL_TASK));
+}
+
+#endif
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
index 000000000000..d1edbddb29ef
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
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
+#define MODULE_NAME "nomiss"
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
+#include "nomiss.h"
+#include <rv/ha_monitor.h>
+#include <monitors/deadline/deadline.h>
+
+/*
+ * User configurable deadline threshold. If the total utilisation of deadline
+ * tasks is larger than 1, they are only guaranteed bounded tardiness. See
+ * Documentation/scheduler/sched-deadline.rst for more details.
+ * The minimum tardiness without sched_feat(HRTICK_DL) is 1 tick to accommodate
+ * for throttle enforced on the next tick.
+ */
+static u64 deadline_thresh = TICK_NSEC;
+module_param(deadline_thresh, ullong, 0644);
+#define DEADLINE_NS(ha_mon) (pi_of(ha_get_target(ha_mon))->dl_deadline + deadline_thresh)
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_nomiss env, u64 time_ns)
+{
+	if (env == clk_nomiss)
+		return ha_get_clk_ns(ha_mon, env, time_ns);
+	else if (env == is_constr_dl_nomiss)
+		return !dl_is_implicit(ha_get_target(ha_mon));
+	else if (env == is_defer_nomiss)
+		return ha_get_target(ha_mon)->dl_defer;
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_nomiss env, u64 time_ns)
+{
+	if (env == clk_nomiss)
+		ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == ready_nomiss)
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == running_nomiss)
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
+	return true;
+}
+
+static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
+					enum states curr_state, enum events event,
+					enum states next_state, u64 time_ns)
+{
+	if (curr_state == next_state)
+		return;
+	if (curr_state == ready_nomiss)
+		ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
+	else if (curr_state == running_nomiss)
+		ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == ready_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == ready_nomiss && event == dl_throttle_nomiss)
+		res = ha_get_env(ha_mon, is_defer_nomiss, time_ns) == 1ull;
+	else if (curr_state == running_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == sleeping_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == sleeping_nomiss && event == dl_throttle_nomiss)
+		res = ha_get_env(ha_mon, is_constr_dl_nomiss, time_ns) == 1ull ||
+		      ha_get_env(ha_mon, is_defer_nomiss, time_ns) == 1ull;
+	else if (curr_state == throttled_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	return res;
+}
+
+static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+				       enum states curr_state, enum events event,
+				       enum states next_state, u64 time_ns)
+{
+	if (next_state == curr_state && event != dl_replenish_nomiss)
+		return;
+	if (next_state == ready_nomiss)
+		ha_start_timer_ns(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
+	else if (next_state == running_nomiss)
+		ha_start_timer_ns(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
+	else if (curr_state == ready_nomiss)
+		ha_cancel_timer(ha_mon);
+	else if (curr_state == running_nomiss)
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
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_nomiss);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_throttle_nomiss);
+}
+
+static void handle_dl_server_start(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_server_start_nomiss);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	/*
+	 * This isn't the standard use of da_handle_start_run_event since this
+	 * event cannot only occur from the initial state.
+	 * It is fine to use here because it always brings to a known state and
+	 * the fact we "pretend" the transition starts from the initial state
+	 * has no side effect.
+	 */
+	da_handle_start_run_event(EXPAND_ID(dl_se, cpu), dl_server_stop_nomiss);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	struct sched_dl_entity *dl_se;
+	int cpu = task_cpu(next);
+
+	if (prev_state != TASK_RUNNING && !preempt && prev->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID(&prev->dl, cpu), sched_switch_suspend_nomiss);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_run_event(EXPAND_ID(&next->dl, cpu), sched_switch_in_nomiss);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * Here the server continues in the state running/armed until actually
+	 * stopped, this works since we continue expecting a throttle.
+	 */
+	dl_se = get_fair_server(next);
+	if (!dl_se)
+		return;
+	if (next->dl_server)
+		da_handle_start_run_event(EXPAND_ID(next->dl_server, cpu), sched_switch_in_nomiss);
+	else if (is_idle_task(next))
+		da_handle_start_run_event(EXPAND_ID(dl_se, cpu), dl_server_idle_nomiss);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	struct task_struct *p;
+	int new_policy = -1;
+
+	new_policy = extract_params(regs, id, &p);
+	if (new_policy < 0 || new_policy == p->policy)
+		return;
+	if (p->policy == SCHED_DEADLINE)
+		da_reset(EXPAND_ID(&p->dl, DL_TASK));
+	else if (new_policy == SCHED_DEADLINE)
+		da_create_or_get(EXPAND_ID(&p->dl, DL_TASK));
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *tsk)
+{
+	if (tsk->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID(&tsk->dl, task_cpu(tsk)), sched_wakeup_nomiss);
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
+	retval = init_storage(false);
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("nomiss", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("nomiss", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_attach_trace_probe("nomiss", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_attach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_attach_trace_probe("nomiss", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
+	if (!should_skip_syscall_handle())
+		rv_attach_trace_probe("nomiss", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("nomiss", task_newtask, handle_newtask);
+	rv_attach_trace_probe("nomiss", sched_process_exit, handle_exit);
+
+	return 0;
+}
+
+static void disable_nomiss(void)
+{
+	rv_this.enabled = 0;
+
+	/* Those are RCU writers, detach earlier hoping to close a bit faster */
+	rv_detach_trace_probe("nomiss", task_newtask, handle_newtask);
+	rv_detach_trace_probe("nomiss", sched_process_exit, handle_exit);
+	if (!should_skip_syscall_handle())
+		rv_detach_trace_probe("nomiss", sys_enter, handle_sys_enter);
+
+	rv_detach_trace_probe("nomiss", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_detach_trace_probe("nomiss", sched_dl_throttle_tp, handle_dl_throttle);
+	rv_detach_trace_probe("nomiss", sched_dl_server_start_tp, handle_dl_server_start);
+	rv_detach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
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
+	return rv_register_monitor(&rv_this, &rv_deadline);
+}
+
+static void __exit unregister_nomiss(void)
+{
+	rv_unregister_monitor(&rv_this);
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
index 000000000000..87cf80e1f291
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.h
@@ -0,0 +1,130 @@
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
+	ready_nomiss,
+	idle_nomiss,
+	running_nomiss,
+	sleeping_nomiss,
+	throttled_nomiss,
+	state_max_nomiss,
+};
+
+#define INVALID_STATE state_max_nomiss
+
+enum events_nomiss {
+	dl_replenish_nomiss,
+	dl_server_idle_nomiss,
+	dl_server_start_nomiss,
+	dl_server_stop_nomiss,
+	dl_throttle_nomiss,
+	sched_switch_in_nomiss,
+	sched_switch_suspend_nomiss,
+	sched_wakeup_nomiss,
+	event_max_nomiss,
+};
+
+enum envs_nomiss {
+	clk_nomiss,
+	is_constr_dl_nomiss,
+	is_defer_nomiss,
+	env_max_nomiss,
+	env_max_stored_nomiss = is_constr_dl_nomiss,
+};
+
+_Static_assert(env_max_stored_nomiss <= MAX_HA_ENV_LEN, "Not enough slots");
+#define HA_CLK_NS
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
+		"ready",
+		"idle",
+		"running",
+		"sleeping",
+		"throttled",
+	},
+	.event_names = {
+		"dl_replenish",
+		"dl_server_idle",
+		"dl_server_start",
+		"dl_server_stop",
+		"dl_throttle",
+		"sched_switch_in",
+		"sched_switch_suspend",
+		"sched_wakeup",
+	},
+	.env_names = {
+		"clk",
+		"is_constr_dl",
+		"is_defer",
+	},
+	.function = {
+		{
+			ready_nomiss,
+			idle_nomiss,
+			INVALID_STATE,
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			ready_nomiss,
+		},
+		{
+			ready_nomiss,
+			idle_nomiss,
+			INVALID_STATE,
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			running_nomiss,
+			idle_nomiss,
+			INVALID_STATE,
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			sleeping_nomiss,
+			running_nomiss,
+		},
+		{
+			ready_nomiss,
+			sleeping_nomiss,
+			sleeping_nomiss,
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			ready_nomiss,
+		},
+		{
+			ready_nomiss,
+			throttled_nomiss,
+			INVALID_STATE,
+			INVALID_STATE,
+			throttled_nomiss,
+			INVALID_STATE,
+			throttled_nomiss,
+			throttled_nomiss,
+		},
+	},
+	.initial_state = ready_nomiss,
+	.final_states = { 1, 0, 0, 0, 0 },
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
index 000000000000..6d9129008795
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle.c
@@ -0,0 +1,250 @@
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
+
+static inline u64 runtime_left_ns(struct ha_monitor *ha_mon)
+{
+	return pi_of(ha_get_target(ha_mon))->runtime + RUNTIME_THRESH;
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
+	if (curr_state == running_throttle)
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
+	if (next_state == running_throttle)
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
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_replenish_throttle);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_event(EXPAND_ID(dl_se, cpu), dl_throttle_throttle);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se, int cpu)
+{
+	da_handle_start_run_event(EXPAND_ID(dl_se, cpu), sched_switch_out_throttle);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	struct sched_dl_entity *dl_se;
+	int cpu = task_cpu(next);
+
+	if (prev->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID(&prev->dl, cpu), sched_switch_out_throttle);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_event(EXPAND_ID(&next->dl, cpu), sched_switch_in_throttle);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * Here the server continues in the state running/armed until actually
+	 * stopped, this works since we continue expecting a throttle.
+	 */
+	dl_se = get_fair_server(next);
+	if (!dl_se)
+		return;
+	if (next->dl_server)
+		da_handle_start_event(EXPAND_ID(next->dl_server, cpu), sched_switch_in_throttle);
+	else if (is_idle_task(next) || next->policy == SCHED_NORMAL)
+		da_handle_event(EXPAND_ID(dl_se, cpu), dl_defer_arm_throttle);
+	else
+		da_handle_event(EXPAND_ID(dl_se, cpu), sched_switch_out_throttle);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	struct task_struct *p;
+	int new_policy = -1;
+
+	new_policy = extract_params(regs, id, &p);
+	if (new_policy < 0 || new_policy == p->policy)
+		return;
+	if (p->policy == SCHED_DEADLINE) {
+		da_reset(EXPAND_ID(&p->dl, DL_TASK));
+		/*
+		 * When a task changes from SCHED_DEADLINE to SCHED_NORMAL, the
+		 * runtime after the change is counted in the fair server.
+		 */
+		if (new_policy == SCHED_NORMAL) {
+			struct sched_dl_entity *dl_se = get_fair_server(p);
+
+			if (!dl_se || !p->on_cpu)
+				return;
+			da_handle_event(EXPAND_ID(dl_se, task_cpu(p)), dl_defer_arm_throttle);
+		}
+	} else if (new_policy == SCHED_DEADLINE) {
+		da_create_or_get(EXPAND_ID(&p->dl, DL_TASK));
+	}
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
+	retval = init_storage(false);
+	if (retval)
+		return retval;
+	rv_attach_trace_probe("throttle", sched_dl_replenish_tp, handle_dl_replenish);
+	rv_attach_trace_probe("throttle", sched_dl_throttle_tp, handle_dl_throttle);
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
+	rv_detach_trace_probe("throttle", sched_switch, handle_sched_switch);
+
+	da_monitor_destroy();
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
index 9e8072d863a2..1bf0f3666ee4 100644
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
index 000000000000..ef150e0afb97
--- /dev/null
+++ b/tools/verification/models/deadline/nomiss.dot
@@ -0,0 +1,41 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = circle] "idle"};
+	{node [shape = plaintext, style=invis, label=""] "__init_ready"};
+	{node [shape = doublecircle] "ready"};
+	{node [shape = circle] "ready"};
+	{node [shape = circle] "running"};
+	{node [shape = circle] "sleeping"};
+	{node [shape = circle] "throttled"};
+	"__init_ready" -> "ready";
+	"idle" [label = "idle"];
+	"idle" -> "idle" [ label = "dl_server_idle\ndl_server_start" ];
+	"idle" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"idle" -> "running" [ label = "sched_switch_in" ];
+	"idle" -> "sleeping" [ label = "dl_server_stop" ];
+	"idle" -> "throttled" [ label = "dl_throttle" ];
+	"ready" [label = "ready\nclk < DEADLINE_NS()", color = green3];
+	"ready" -> "idle" [ label = "dl_server_idle" ];
+	"ready" -> "ready" [ label = "sched_wakeup\ndl_server_start\ndl_replenish;reset(clk)" ];
+	"ready" -> "running" [ label = "sched_switch_in" ];
+	"ready" -> "sleeping" [ label = "dl_server_stop" ];
+	"ready" -> "throttled" [ label = "dl_throttle;is_defer == 1" ];
+	"running" [label = "running\nclk < DEADLINE_NS()"];
+	"running" -> "idle" [ label = "dl_server_idle" ];
+	"running" -> "running" [ label = "dl_replenish;reset(clk)\nsched_switch_in\nsched_wakeup" ];
+	"running" -> "sleeping" [ label = "sched_switch_suspend\ndl_server_stop" ];
+	"running" -> "throttled" [ label = "dl_throttle" ];
+	"sleeping" [label = "sleeping"];
+	"sleeping" -> "ready" [ label = "sched_wakeup\ndl_replenish;reset(clk)" ];
+	"sleeping" -> "running" [ label = "sched_switch_in" ];
+	"sleeping" -> "sleeping" [ label = "dl_server_start\ndl_server_stop\ndl_server_idle" ];
+	"sleeping" -> "throttled" [ label = "dl_throttle;is_constr_dl == 1 || is_defer == 1" ];
+	"throttled" [label = "throttled"];
+	"throttled" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"throttled" -> "throttled" [ label = "sched_switch_suspend\nsched_wakeup\ndl_server_start\ndl_server_idle\ndl_throttle" ];
+	{ rank = min ;
+		"__init_ready";
+		"ready";
+	}
+}
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
2.52.0

