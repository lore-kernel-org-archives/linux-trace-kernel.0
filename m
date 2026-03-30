Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C942FBDF2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869112; cv=none; b=YxGJas/Rde5ea7pOHEsanUyK9rXZ4/o6vUVRKufpnSjETQnCPLYhGWQQ2uCgJMAbSyNDPw6Iey1EG7IoDMIgAdD+Pa2mR+8UN9FUiLfS9pcHrw1KYuGfcwCpFlaJR8kSLkOv/hsyr5jgeR7ktPgCsNygpwOV3qEkH7NBiVgL9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869112; c=relaxed/simple;
	bh=yR9Iwclef5asn3jcjJtHG0X4DH3YMb3D8G3B3A9OGy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GBLBnOocP8GCMQE3F6bRRTDphKizw95QnKs2RK3u5x/qZG1ZEZn1OydkCIRu4J4TemvZ651WOWKX+jkZ9IRG1hLDCBjYyGBA70FANLVX2JanCfC7KapRtZNkxaqWMWYbrhWK66M3b5Y8r2fASn8g8sIGuhgeqaXFaFMaE2XjLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsbAP8Yk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsbAP8Yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yE+xQ9htpa7SWh5h9FxVWqIufkY3b68pbB4rtDNEfMM=;
	b=SsbAP8YkSLdHZ35JFcjDLh/opYQBPSS/D/iCiHPaiUohNUVgX5uYK6vufX8TV0Fio6tHes
	2JquRhBMXQNUMibppFH8kHpLvkilKNqdvaZsYiostsSDuzj2QTmhI0SYbqeK7z4o1Y0idQ
	v6cpth1hrnO/KDBccaubSaj0sPhsHHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-aO_O52dyNZKmjqQpjjE9eQ-1; Mon,
 30 Mar 2026 07:11:36 -0400
X-MC-Unique: aO_O52dyNZKmjqQpjjE9eQ-1
X-Mimecast-MFC-AGG-ID: aO_O52dyNZKmjqQpjjE9eQ_1774869094
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50A251955D5B;
	Mon, 30 Mar 2026 11:11:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45D8430001A1;
	Mon, 30 Mar 2026 11:11:28 +0000 (UTC)
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
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v8 12/12] rv: Add nomiss deadline monitor
Date: Mon, 30 Mar 2026 13:10:10 +0200
Message-ID: <20260330111010.153663-13-gmonaco@redhat.com>
In-Reply-To: <20260330111010.153663-1-gmonaco@redhat.com>
References: <20260330111010.153663-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: zB7Kc2sZlkS_SF7OFG-g-JYqgCchhh7XtoET_SPAKQc_1774869094
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the deadline monitors collection to validate the deadline scheduler,
both for deadline tasks and servers.

The currently implemented monitors are:
* nomiss:
    validate dl entities run to completion before their deadiline

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V8:
    * Warn if kallsyms lookup fails
    * Use u8 instead of uint8_t
    * Drop throttle monitor, will submit separately

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_deadline.rst   |  84 +++++
 kernel/trace/rv/Kconfig                       |   4 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/deadline/Kconfig     |  10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  44 +++
 kernel/trace/rv/monitors/deadline/deadline.h  | 202 ++++++++++++
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 293 ++++++++++++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      | 123 ++++++++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  19 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/deadline/nomiss.dot |  41 +++
 13 files changed, 839 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_deadline.rst
 create mode 100644 kernel/trace/rv/monitors/deadline/Kconfig
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.c
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_trace.h
 create mode 100644 tools/verification/models/deadline/nomiss.dot

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
index 000000000000..84506ed1e293
--- /dev/null
+++ b/Documentation/trace/rv/monitor_deadline.rst
@@ -0,0 +1,84 @@
+Deadline monitors
+=================
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
+the ``HRTICK_DL`` scheduler feature is active.
+
+Servers have also an intermediate ``idle`` state, occurring as soon as no
+runnable task is available from ready or running where no timing constraint
+is applied. A server goes to sleep by stopping, there is no wakeup equivalent
+as the order of a server starting and replenishing is not defined, hence a
+server can run from sleeping without being ready::
+
+                                  |
+  sched_wakeup                    v
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
+      |  |   |              +------ |              |                      |   |
+      |  |   |     dl_server_idle   |              | dl_throttle          |   |
+      |  |   |              |       |     idle     | -----------------+   |   |
+      |  |   |              +-----> |              |                  |   |   |
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
+ |              | -- dl_server_stop        dl_server_idle +-> |               |
+ |              |    dl_server_idle     sched_switch_suspend  +---------------+
+ +--------------+ <---------+                                        ^
+        |                                                            |
+        +------ dl_throttle;is_constr_dl == 1 || is_defer == 1 ------+
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 720fbe4935f8..3884b14df375 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -79,6 +79,10 @@ source "kernel/trace/rv/monitors/sleep/Kconfig"
 # Add new rtapp monitors here
 
 source "kernel/trace/rv/monitors/stall/Kconfig"
+source "kernel/trace/rv/monitors/deadline/Kconfig"
+source "kernel/trace/rv/monitors/nomiss/Kconfig"
+# Add new deadline monitors here
+
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 51c95e2d2da6..94498da35b37 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
+obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
+obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
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
index 000000000000..d566d4542ebf
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/deadline.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <linux/kallsyms.h>
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
+/* Used by other monitors */
+struct sched_class *rv_ext_sched_class;
+
+static int __init register_deadline(void)
+{
+	if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT)) {
+		rv_ext_sched_class = (void *)kallsyms_lookup_name("ext_sched_class");
+		if (!rv_ext_sched_class)
+			pr_warn("rv: Missing ext_sched_class, monitors may not work.\n");
+	}
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
index 000000000000..0bbfd2543329
--- /dev/null
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/sched/deadline.h>
+#include <asm/syscall.h>
+#include <uapi/linux/sched/types.h>
+#include <trace/events/sched.h>
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
+extern struct rv_monitor rv_deadline;
+/* Initialised when registering the deadline container */
+extern struct sched_class *rv_ext_sched_class;
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
+ * is_supported_type - return true if @type is supported by the deadline monitors
+ */
+static inline bool is_supported_type(u8 type)
+{
+	return type == DL_TASK || type == DL_SERVER_FAIR || type == DL_SERVER_EXT;
+}
+
+/*
+ * is_server_type - return true if @type is a supported server
+ */
+static inline bool is_server_type(u8 type)
+{
+	return is_supported_type(type) && type != DL_TASK;
+}
+
+/*
+ * Use negative numbers for the server.
+ * Currently only one fair server per CPU, may change in the future.
+ */
+#define fair_server_id(cpu) (-cpu)
+#define ext_server_id(cpu) (-cpu - num_possible_cpus())
+#define NO_SERVER_ID (-2 * num_possible_cpus())
+/*
+ * Get a unique id used for dl entities
+ *
+ * The cpu is not required for tasks as the pid is used there, if this function
+ * is called on a dl_se that for sure corresponds to a task, DL_TASK can be
+ * used in place of cpu.
+ * We need the cpu for servers as it is provided in the tracepoint and we
+ * cannot easily retrieve it from the dl_se (requires the struct rq definition).
+ */
+static inline int get_entity_id(struct sched_dl_entity *dl_se, int cpu, u8 type)
+{
+	if (dl_server(dl_se) && type != DL_TASK) {
+		if (type == DL_SERVER_FAIR)
+			return fair_server_id(cpu);
+		if (type == DL_SERVER_EXT)
+			return ext_server_id(cpu);
+		return NO_SERVER_ID;
+	}
+	return dl_task_of(dl_se)->pid;
+}
+
+static inline bool task_is_scx_enabled(struct task_struct *tsk)
+{
+	return IS_ENABLED(CONFIG_SCHED_CLASS_EXT) &&
+	       tsk->sched_class == rv_ext_sched_class;
+}
+
+/* Expand id and target as arguments for da functions */
+#define EXPAND_ID(dl_se, cpu, type) get_entity_id(dl_se, cpu, type), dl_se
+#define EXPAND_ID_TASK(tsk) get_entity_id(&tsk->dl, task_cpu(tsk), DL_TASK), &tsk->dl
+
+static inline u8 get_server_type(struct task_struct *tsk)
+{
+	if (tsk->policy == SCHED_NORMAL || tsk->policy == SCHED_EXT ||
+	    tsk->policy == SCHED_BATCH || tsk->policy == SCHED_IDLE)
+		return task_is_scx_enabled(tsk) ? DL_SERVER_EXT : DL_SERVER_FAIR;
+	return DL_OTHER;
+}
+
+static inline int extract_params(struct pt_regs *regs, long id, pid_t *pid_out)
+{
+	size_t size = offsetofend(struct sched_attr, sched_flags);
+	struct sched_attr __user *uattr, attr;
+	int new_policy = -1, ret;
+	unsigned long args[6];
+
+	switch (id) {
+	case __NR_sched_setscheduler:
+		syscall_get_arguments(current, regs, args);
+		*pid_out = args[0];
+		new_policy = args[1];
+		break;
+	case __NR_sched_setattr:
+		syscall_get_arguments(current, regs, args);
+		*pid_out = args[0];
+		uattr = (struct sched_attr __user *)args[1];
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
+static inline struct sched_dl_entity *get_server(struct task_struct *tsk, u8 type)
+{
+	if (tsk->dl_server && get_server_type(tsk) == type)
+		return tsk->dl_server;
+	if (type == DL_SERVER_FAIR)
+		return da_get_target_by_id(fair_server_id(task_cpu(tsk)));
+	if (type == DL_SERVER_EXT)
+		return da_get_target_by_id(ext_server_id(task_cpu(tsk)));
+	return NULL;
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
+		if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT) &&
+		    !da_create_empty_storage(ext_server_id(cpu)))
+			goto fail;
+	}
+
+	if (skip_tasks)
+		return 0;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, p) {
+		if (p->policy == SCHED_DEADLINE) {
+			if (!da_create_storage(EXPAND_ID_TASK(p), NULL)) {
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
+		da_create_storage(EXPAND_ID_TASK(task), NULL);
+}
+
+static void __maybe_unused handle_exit(void *data, struct task_struct *p, bool group_dead)
+{
+	if (p->policy == SCHED_DEADLINE)
+		da_destroy_storage(get_entity_id(&p->dl, DL_TASK, DL_TASK));
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
index 000000000000..31f90f3638d8
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -0,0 +1,293 @@
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
+#define DEADLINE_NS(ha_mon) (ha_get_target(ha_mon)->dl_deadline + deadline_thresh)
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
+	if (curr_state == ready_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
+	else if (curr_state == ready_nomiss && event == dl_throttle_nomiss)
+		res = ha_get_env(ha_mon, is_defer_nomiss, time_ns) == 1ull;
+	else if (curr_state == idle_nomiss && event == dl_replenish_nomiss)
+		ha_reset_env(ha_mon, clk_nomiss, time_ns);
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
+static void handle_dl_replenish(void *data, struct sched_dl_entity *dl_se,
+				int cpu, u8 type)
+{
+	if (is_supported_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_replenish_nomiss);
+}
+
+static void handle_dl_throttle(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type)
+{
+	if (is_supported_type(type))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_throttle_nomiss);
+}
+
+static void handle_dl_server_stop(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type)
+{
+	/*
+	 * This isn't the standard use of da_handle_start_run_event since this
+	 * event cannot only occur from the initial state.
+	 * It is fine to use here because it always brings to a known state and
+	 * the fact we "pretend" the transition starts from the initial state
+	 * has no side effect.
+	 */
+	if (is_supported_type(type))
+		da_handle_start_run_event(EXPAND_ID(dl_se, cpu, type), dl_server_stop_nomiss);
+}
+
+static inline void handle_server_switch(struct task_struct *next, int cpu, u8 type)
+{
+	struct sched_dl_entity *dl_se = get_server(next, type);
+
+	if (dl_se && is_idle_task(next))
+		da_handle_event(EXPAND_ID(dl_se, cpu, type), dl_server_idle_nomiss);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	int cpu = task_cpu(next);
+
+	if (prev_state != TASK_RUNNING && !preempt && prev->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID_TASK(prev), sched_switch_suspend_nomiss);
+	if (next->policy == SCHED_DEADLINE)
+		da_handle_start_run_event(EXPAND_ID_TASK(next), sched_switch_in_nomiss);
+
+	/*
+	 * The server is available in next only if the next task is boosted,
+	 * otherwise we need to retrieve it.
+	 * Here the server continues in the state running/armed until actually
+	 * stopped, this works since we continue expecting a throttle.
+	 */
+	if (next->dl_server)
+		da_handle_start_event(EXPAND_ID(next->dl_server, cpu,
+						get_server_type(next)),
+				      sched_switch_in_nomiss);
+	else {
+		handle_server_switch(next, cpu, DL_SERVER_FAIR);
+		if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
+			handle_server_switch(next, cpu, DL_SERVER_EXT);
+	}
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
+static void handle_sched_wakeup(void *data, struct task_struct *tsk)
+{
+	if (tsk->policy == SCHED_DEADLINE)
+		da_handle_event(EXPAND_ID_TASK(tsk), sched_wakeup_nomiss);
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
+	rv_detach_trace_probe("nomiss", sched_dl_server_stop_tp, handle_dl_server_stop);
+	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "nomiss",
+	.description = "dl entities run to completion before their deadline.",
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
+MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadline.");
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.h b/kernel/trace/rv/monitors/nomiss/nomiss.h
new file mode 100644
index 000000000000..3d1b436194d7
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.h
@@ -0,0 +1,123 @@
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
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			ready_nomiss,
+		},
+		{
+			ready_nomiss,
+			idle_nomiss,
+			sleeping_nomiss,
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			running_nomiss,
+			idle_nomiss,
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
+			throttled_nomiss,
+			running_nomiss,
+			INVALID_STATE,
+			ready_nomiss,
+		},
+		{
+			ready_nomiss,
+			throttled_nomiss,
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
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9e8072d863a2..9622c269789c 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -188,6 +188,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 );
 
 #include <monitors/stall/stall_trace.h>
+#include <monitors/nomiss/nomiss_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/deadline/nomiss.dot b/tools/verification/models/deadline/nomiss.dot
new file mode 100644
index 000000000000..fd1ea6bf2509
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
+	"idle" -> "idle" [ label = "dl_server_idle" ];
+	"idle" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"idle" -> "running" [ label = "sched_switch_in" ];
+	"idle" -> "sleeping" [ label = "dl_server_stop" ];
+	"idle" -> "throttled" [ label = "dl_throttle" ];
+	"ready" [label = "ready\nclk < DEADLINE_NS()", color = green3];
+	"ready" -> "idle" [ label = "dl_server_idle" ];
+	"ready" -> "ready" [ label = "sched_wakeup\ndl_replenish;reset(clk)" ];
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
+	"sleeping" -> "sleeping" [ label = "dl_server_stop\ndl_server_idle" ];
+	"sleeping" -> "throttled" [ label = "dl_throttle;is_constr_dl == 1 || is_defer == 1" ];
+	"throttled" [label = "throttled"];
+	"throttled" -> "ready" [ label = "dl_replenish;reset(clk)" ];
+	"throttled" -> "throttled" [ label = "sched_switch_suspend\nsched_wakeup\ndl_server_idle\ndl_throttle" ];
+	{ rank = min ;
+		"__init_ready";
+		"ready";
+	}
+}
-- 
2.53.0

