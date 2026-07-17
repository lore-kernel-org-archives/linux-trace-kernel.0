Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8E36D4F1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303300; cv=none; b=LtEMbwkRrGbH9zwCrwCAM8gfuFS/pdPywStmDiDujJ12ClQOsUHhdMB+KEbD2+MAeF4gJL2ybAyYCiDpayAVGuL6XfvXbZdXuGhiWmfCH9ME9uhurYDn8p4PfvU38I5PpVPsLd6e9XaEyKthCAzpA69keQL+x/KgeeKlAstgxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303300; c=relaxed/simple;
	bh=vzlEIoKdlRoXL7Rbq8nWhsxR586qEJIWt5RmqFU9IAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ufa+a5R2bRxsoSb8uDcHF36qptSA7sGz5nIXvE8AS2WpxYoSXgc4K7gSkRGORFvfkXGD8Y3pD3ppQ54/BTSxdIzhJ7Vs75G4+PYaS2VGbwRC7iXvd0Lybq3EUbmKuizHK59lJ0NG2lq05q+Z2zpszvJdCNmRMgZviJw+0+Yqt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCtPLHSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCtPLHSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKgMpT3Nr5v2668RBZnZlc7cD37Wb3ChSnv0i4aBlBw=;
	b=SCtPLHSJnAlgOjUqP01oRtL2Kxp2ZphL0qJTlYnC58uagThUuW87ES11jAS3e/h2Rc7byf
	N1YiU/7IyvbGBolxUaAkoBk24DX/m6iR194Os6nQ4lBXkiiHG6NolBx3lE/BTsZIB9PPqo
	yhR6GZ8bsztWauVlQiaS8wsYd/fGK6Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-hfSJAmVEPL21Dsx8z91ScQ-1; Fri,
 17 Jul 2026 11:48:12 -0400
X-MC-Unique: hfSJAmVEPL21Dsx8z91ScQ-1
X-Mimecast-MFC-AGG-ID: hfSJAmVEPL21Dsx8z91ScQ_1784303290
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDCED1945102;
	Fri, 17 Jul 2026 15:48:10 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E14C30040BF;
	Fri, 17 Jul 2026 15:48:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 12/17] rv: Add KUnit tests for some DA/HA monitors
Date: Fri, 17 Jul 2026 17:46:33 +0200
Message-ID: <20260717154638.220789-13-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: IFkqq18JPjMFvWvhltoO91asNz71k59hXLtV-8Yvo5Q_1784303290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Validate the functionality of DA monitors by injecting events in a
controlled environment (KUnit) and expecting reactions.

Events handlers are exported directly from the monitor source files
without using system events and with dummy arguments (e.g. no real
tasks). If the provided sequence of events incurs a violation, the test
expects the stub version of rv_react() to be called.

This testing method can validate the entire monitor implementation since
it sits between the monitor and the system (in place of the
tracepoints). All sorts of system and timing events can be emulated
without affecting the running kernel.

Handlers and monitor functions are exported as part of a struct to
simplify the process of running KUnit tests from kernel modules.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Use deadline_thresh in nomiss KUnit test
    * Special init/destroy for per-task monitors to avoid touching real
      tasks and starting tracepoints
    * Add dummy test to check reactions work as expected
    * Use actual reactor instead of stub to support timer reactions

 include/rv/da_monitor.h                       |  22 +++
 include/rv/ha_monitor.h                       |  21 +++
 include/rv/kunit.h                            |  61 ++++++
 kernel/trace/rv/Kconfig                       |  11 ++
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  18 ++
 .../trace/rv/monitors/nomiss/nomiss_kunit.c   |  38 ++++
 .../trace/rv/monitors/nomiss/nomiss_kunit.h   |  35 ++++
 kernel/trace/rv/monitors/opid/opid.c          |  12 ++
 kernel/trace/rv/monitors/opid/opid_kunit.c    |  33 ++++
 kernel/trace/rv/monitors/opid/opid_kunit.h    |  23 +++
 kernel/trace/rv/monitors/sco/sco.c            |  13 ++
 kernel/trace/rv/monitors/sco/sco_kunit.c      |  29 +++
 kernel/trace/rv/monitors/sco/sco_kunit.h      |  24 +++
 kernel/trace/rv/monitors/sssw/sssw.c          |  14 ++
 kernel/trace/rv/monitors/sssw/sssw_kunit.c    |  33 ++++
 kernel/trace/rv/monitors/sssw/sssw_kunit.h    |  30 +++
 kernel/trace/rv/monitors/sts/sts.c            |  19 ++
 kernel/trace/rv/monitors/sts/sts_kunit.c      |  39 ++++
 kernel/trace/rv/monitors/sts/sts_kunit.h      |  33 ++++
 kernel/trace/rv/rv.c                          |  40 ++++
 kernel/trace/rv/rv_monitors_test.c            | 175 ++++++++++++++++++
 .../rvgen/rvgen/templates/kunit.c             |   4 +
 23 files changed, 728 insertions(+)
 create mode 100644 include/rv/kunit.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
 create mode 100644 kernel/trace/rv/monitors/opid/opid_kunit.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sts/sts_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts_kunit.h
 create mode 100644 kernel/trace/rv/rv_monitors_test.c

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ecd4..773564720ba1 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -311,6 +311,11 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
 	return &tsk->rv[task_mon_slot].da_mon;
 }
 
+static inline void da_reset(struct task_struct *tsk)
+{
+	da_monitor_reset(da_get_monitor(tsk));
+}
+
 /*
  * da_get_target - return the task associated to the monitor
  */
@@ -908,4 +913,21 @@ static inline void da_reset(da_id_type id, monitor_target target)
 }
 #endif /* RV_MON_TYPE */
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#if RV_MON_TYPE == RV_MON_PER_TASK
+#define RV_MON_OPS_INIT() {             \
+	.rv_this = &rv_this,            \
+	.is_per_task = true,            \
+	.task_slot = &task_mon_slot,    \
+	.task_reset = da_reset,         \
+}
+#else
+#define RV_MON_OPS_INIT() {                     \
+	.rv_this = &rv_this,                    \
+	.monitor_init = da_monitor_init,        \
+	.monitor_destroy = da_monitor_destroy,  \
+}
+#endif /* RV_MON_TYPE */
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+
 #endif
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 28d3c74cabfc..d4a490bf2726 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -558,4 +558,25 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#ifdef RV_MON_OPS_INIT
+#undef RV_MON_OPS_INIT
+#endif
+
+#if RV_MON_TYPE == RV_MON_PER_TASK
+#define RV_MON_OPS_INIT() {             \
+	.rv_this = &rv_this,            \
+	.is_per_task = true,            \
+	.task_slot = &task_mon_slot,    \
+	.task_reset = da_reset,         \
+}
+#else
+#define RV_MON_OPS_INIT() {                     \
+	.rv_this = &rv_this,                    \
+	.monitor_init = ha_monitor_init,        \
+	.monitor_destroy = ha_monitor_destroy,  \
+}
+#endif /* RV_MON_TYPE */
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+
 #endif
diff --git a/include/rv/kunit.h b/include/rv/kunit.h
new file mode 100644
index 000000000000..ff98b5137285
--- /dev/null
+++ b/include/rv/kunit.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * Declaration of utilities to run KUnit tests.
+ */
+
+#ifndef _RV_KUNIT_H
+#define _RV_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/delay.h>
+
+int rv_set_testing(struct kunit_suite *suite);
+void rv_clear_testing(struct kunit_suite *suite);
+
+#define RV_KUNIT_MAX_MOCK_TASKS 8
+
+struct rv_kunit_ctx {
+	int reactions, expected;
+	int mock_task_count;
+	struct task_struct *mock_tasks[RV_KUNIT_MAX_MOCK_TASKS];
+};
+
+#define RV_KUNIT_EXPECT_REACTION(test, ctx)                             \
+	do {                                                            \
+		KUNIT_EXPECT_EQ(test, ctx->reactions, ++ctx->expected); \
+		if (ctx->reactions != ctx->expected)                    \
+			ctx->expected = ctx->reactions;                 \
+	} while (0)
+
+#define RV_KUNIT_EXPECT_NO_REACTION(test, ctx)                        \
+	do {                                                          \
+		KUNIT_EXPECT_EQ(test, ctx->reactions, ctx->expected); \
+		if (ctx->reactions != ctx->expected)                  \
+			ctx->expected = ctx->reactions;               \
+	} while (0)
+
+#define RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)                             \
+	for (int __done = ({ RV_KUNIT_EXPECT_NO_REACTION(test, ctx); 0; });  \
+	     !__done;                                                        \
+	     __done = ({ RV_KUNIT_EXPECT_REACTION(test, ctx); 1; }))
+
+struct rv_kunit_mon {
+	struct rv_monitor *rv_this;
+	int (*monitor_init)(void);
+	void (*monitor_destroy)(void);
+	bool is_per_task;
+	int *task_slot;
+	void (*task_reset)(struct task_struct *task);
+};
+
+void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon);
+void teardown_test(void *arg);
+struct task_struct *rv_kunit_alloc_mock_task(struct kunit *test);
+
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+#endif /* _RV_KUNIT_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..34c1feb35a9b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -111,3 +111,14 @@ config RV_REACT_PANIC
 	help
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
+
+config RV_MONITORS_KUNIT_TEST
+	tristate "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
+	depends on KUNIT && RV && RV_REACTORS
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the RV (Runtime Verification) monitors.
+	  These tests verify that monitors correctly detect violations by
+	  triggering fake events and validating the expected reactions.
+
+	  If unsure, say N.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..a3502b7fe7f2 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 8ead8783c29f..beb75965dc8d 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -291,3 +291,21 @@ module_exit(unregister_nomiss);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadline.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "nomiss_kunit.h"
+
+const struct rv_nomiss_ops rv_nomiss_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.deadline_thresh = &deadline_thresh,
+	.handle_dl_replenish = handle_dl_replenish,
+	.handle_dl_throttle = handle_dl_throttle,
+	.handle_dl_server_stop = handle_dl_server_stop,
+	.handle_sched_switch = handle_sched_switch,
+	.handle_sched_wakeup = handle_sched_wakeup,
+	.handle_sys_enter = handle_sys_enter,
+	.handle_newtask = handle_newtask,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_nomiss_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
new file mode 100644
index 000000000000..2b85bbf179c4
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "nomiss_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_NOMISS)
+
+static void rv_test_nomiss(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_nomiss_ops.mon);
+
+	target->pid = 99;
+	target->policy = SCHED_DEADLINE;
+	target->dl.runtime = 10000;
+	target->dl.dl_deadline = 20000;
+
+	rv_nomiss_ops.handle_newtask(NULL, target, 0);
+
+	/* Task gets preempted and can't terminate before deadline */
+	rv_nomiss_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	rv_nomiss_ops.handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
+	udelay(10);
+	rv_nomiss_ops.handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx) {
+		udelay(10 + *rv_nomiss_ops.deadline_thresh / 1000);
+		rv_nomiss_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	}
+}
+
+#else
+#define rv_test_nomiss rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
new file mode 100644
index 000000000000..2be779c5dbaa
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __NOMISS_KUNIT_H
+#define __NOMISS_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_nomiss_ops {
+	struct rv_kunit_mon mon;
+	const u64 *deadline_thresh;
+	void (*handle_dl_replenish)(void *data, struct sched_dl_entity *dl_se,
+				int cpu, u8 type);
+	void (*handle_dl_throttle)(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type);
+	void (*handle_dl_server_stop)(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state);
+	void (*handle_sched_wakeup)(void *data, struct task_struct *tsk);
+	void (*handle_sys_enter)(void *data, struct pt_regs *regs, long id);
+	void (*handle_newtask)(void *data, struct task_struct *task, u64 flags);
+} rv_nomiss_ops;
+#endif
+
+#endif /* __NOMISS_KUNIT_H */
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 3b6a85e815b8..9ae619f176fa 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -115,3 +115,15 @@ module_exit(unregister_opid);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("opid: operations with preemption and irq disabled.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "opid_kunit.h"
+
+const struct rv_opid_ops rv_opid_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_sched_need_resched = handle_sched_need_resched,
+	.handle_sched_waking = handle_sched_waking,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_opid_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/opid/opid_kunit.c b/kernel/trace/rv/monitors/opid/opid_kunit.c
new file mode 100644
index 000000000000..3cb087a74241
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/opid_kunit.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "opid_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_OPID)
+
+static void rv_test_opid(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_opid_ops.mon);
+
+	/* Ensure we keep the same per-cpu monitor */
+	guard(migrate)();
+	KUNIT_EXPECT_TRUE(test, preemptible());
+
+	/* Wakeup with preemption and interrupts enabled */
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_opid_ops.handle_sched_waking(NULL, NULL);
+
+	/* Need resched with interrupts enabled */
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx) {
+		scoped_guard(preempt)
+			rv_opid_ops.handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
+	}
+}
+
+#else
+#define rv_test_opid rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/opid/opid_kunit.h b/kernel/trace/rv/monitors/opid/opid_kunit.h
new file mode 100644
index 000000000000..4969c6175957
--- /dev/null
+++ b/kernel/trace/rv/monitors/opid/opid_kunit.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __OPID_KUNIT_H
+#define __OPID_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_opid_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_sched_need_resched)(void *data, struct task_struct *tsk, int cpu, int tif);
+	void (*handle_sched_waking)(void *data, struct task_struct *p);
+} rv_opid_ops;
+#endif
+
+#endif /* __OPID_KUNIT_H */
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 5a3bd5e16e62..1ef1b96e859d 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -83,3 +83,16 @@ module_exit(unregister_sco);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sco: scheduling context operations.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sco_kunit.h"
+
+const struct rv_sco_ops rv_sco_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_sched_set_state = handle_sched_set_state,
+	.handle_schedule_entry = handle_schedule_entry,
+	.handle_schedule_exit = handle_schedule_exit,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sco_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sco/sco_kunit.c b/kernel/trace/rv/monitors/sco/sco_kunit.c
new file mode 100644
index 000000000000..5e59bcbfcf0b
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco_kunit.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "sco_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_SCO)
+
+static void rv_test_sco(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sco_ops.mon);
+
+	/* Ensure we keep the same per-cpu monitor */
+	guard(migrate)();
+
+	/* Set state while scheduling */
+	rv_sco_ops.handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_sco_ops.handle_schedule_entry(NULL, false);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sco_ops.handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+}
+
+#else
+#define rv_test_sco rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/sco/sco_kunit.h b/kernel/trace/rv/monitors/sco/sco_kunit.h
new file mode 100644
index 000000000000..567757df6b1d
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco_kunit.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __SCO_KUNIT_H
+#define __SCO_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_sco_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_sched_set_state)(void *data, struct task_struct *tsk, int state);
+	void (*handle_schedule_entry)(void *data, bool preempt);
+	void (*handle_schedule_exit)(void *data, bool is_switch);
+} rv_sco_ops;
+#endif
+
+#endif /* __SCO_KUNIT_H */
diff --git a/kernel/trace/rv/monitors/sssw/sssw.c b/kernel/trace/rv/monitors/sssw/sssw.c
index a91321c890cd..fbfde32dc136 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.c
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -112,3 +112,17 @@ module_exit(unregister_sssw);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sssw: set state sleep and wakeup.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sssw_kunit.h"
+
+const struct rv_sssw_ops rv_sssw_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_sched_set_state = handle_sched_set_state,
+	.handle_sched_switch = handle_sched_switch,
+	.handle_sched_wakeup = handle_sched_wakeup,
+	.handle_signal_deliver = handle_signal_deliver,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sssw_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sssw/sssw_kunit.c b/kernel/trace/rv/monitors/sssw/sssw_kunit.c
new file mode 100644
index 000000000000..a95faf859c60
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw_kunit.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "sssw_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_SSSW)
+
+static void rv_test_sssw(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sssw_ops.mon);
+
+	/* Suspend without setting to sleepable */
+	rv_sssw_ops.handle_sched_set_state(NULL, target, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sssw_ops.handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+
+	/* Switch in after suspension without wakeup */
+	rv_sssw_ops.handle_sched_wakeup(NULL, target);
+	rv_sssw_ops.handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_sssw_ops.handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sssw_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+}
+
+#else
+#define rv_test_sssw rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/sssw/sssw_kunit.h b/kernel/trace/rv/monitors/sssw/sssw_kunit.h
new file mode 100644
index 000000000000..6513daa7afba
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw_kunit.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __SSSW_KUNIT_H
+#define __SSSW_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_sssw_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_sched_set_state)(void *data, struct task_struct *tsk, int state);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state);
+	void (*handle_sched_wakeup)(void *data, struct task_struct *p);
+	void (*handle_signal_deliver)(void *data, int sig,
+				   struct kernel_siginfo *info,
+				   struct k_sigaction *ka);
+} rv_sssw_ops;
+#endif
+
+#endif /* __SSSW_KUNIT_H */
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
index ce031cbf202a..2a044cf925b1 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -152,3 +152,22 @@ module_exit(unregister_sts);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sts: schedule implies task switch.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sts_kunit.h"
+
+const struct rv_sts_ops rv_sts_ops = {
+	.mon = RV_MON_OPS_INIT(),
+#ifdef CONFIG_X86_LOCAL_APIC
+	.handle_vector_irq_entry = handle_vector_irq_entry,
+#endif
+	.handle_irq_disable = handle_irq_disable,
+	.handle_irq_enable = handle_irq_enable,
+	.handle_irq_entry = handle_irq_entry,
+	.handle_sched_switch = handle_sched_switch,
+	.handle_schedule_entry = handle_schedule_entry,
+	.handle_schedule_exit = handle_schedule_exit,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sts_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sts/sts_kunit.c b/kernel/trace/rv/monitors/sts/sts_kunit.c
new file mode 100644
index 000000000000..a07316fff091
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/sts_kunit.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "sts_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_STS)
+
+static void rv_test_sts(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sts_ops.mon);
+	/* Per-CPU monitor, make sure we don't change CPU mid-test */
+	guard(migrate)();
+
+	/* Switch without disabling interrupts */
+	rv_sts_ops.handle_schedule_exit(NULL, false);
+	rv_sts_ops.handle_schedule_entry(NULL, false);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sts_ops.handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+
+	rv_sts_ops.handle_schedule_exit(NULL, false);
+
+	/* Schedule from interrupt context */
+	rv_sts_ops.handle_schedule_entry(NULL, false);
+	rv_sts_ops.handle_irq_disable(NULL, 0, 0);
+	rv_sts_ops.handle_irq_entry(NULL, 0, NULL);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sts_ops.handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	rv_sts_ops.handle_irq_enable(NULL, 0, 0);
+}
+
+#else
+#define rv_test_sts rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/sts/sts_kunit.h b/kernel/trace/rv/monitors/sts/sts_kunit.h
new file mode 100644
index 000000000000..dede4e098c1f
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/sts_kunit.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __STS_KUNIT_H
+#define __STS_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_sts_ops {
+	struct rv_kunit_mon mon;
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (*handle_vector_irq_entry)(void *data, int vector);
+#endif
+	void (*handle_irq_disable)(void *data, unsigned long ip, unsigned long parent_ip);
+	void (*handle_irq_enable)(void *data, unsigned long ip, unsigned long parent_ip);
+	void (*handle_irq_entry)(void *data, int irq, struct irqaction *action);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state);
+	void (*handle_schedule_entry)(void *data, bool preempt);
+	void (*handle_schedule_exit)(void *data, bool is_switch);
+} rv_sts_ops;
+#endif
+
+#endif /* __STS_KUNIT_H */
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 9d58c730821d..cfe950fef3b4 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -854,3 +854,43 @@ int __init rv_init_interface(void)
 
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <rv/kunit.h>
+#include <kunit/visibility.h>
+
+/*
+ * rv_set_testing - ensure mutual exclusion between KUnit tests and real monitors
+ *
+ * KUnit tests for RV monitors rely on stubs that are incompatible with
+ * the execution of real monitors. Ensure mutual exclusion by acquiring
+ * the rv_interface_lock for the duration of the suite.
+ *
+ * Returns 0 on success, -EBUSY if any real monitor is already enabled.
+ */
+int rv_set_testing(struct kunit_suite *suite)
+{
+	struct rv_monitor *mon;
+
+	mutex_lock(&rv_interface_lock);
+
+	list_for_each_entry(mon, &rv_monitors_list, list) {
+		if (mon->enabled) {
+			mutex_unlock(&rv_interface_lock);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(rv_set_testing);
+
+/*
+ * rv_clear_testing - allow real monitors to run again after KUnit tests
+ */
+void rv_clear_testing(struct kunit_suite *suite)
+{
+	mutex_unlock(&rv_interface_lock);
+}
+EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
+#endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
new file mode 100644
index 000000000000..2145c85d4c9a
--- /dev/null
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * RV monitor kunit tests:
+ *   Tests the RV monitors by triggering fake events to verify monitor
+ *   behavior and reactions. Tests start from the first defined event and
+ *   trigger events in order to verify error detection.
+ */
+#include <rv/kunit.h>
+#include <kunit/static_stub.h>
+#include <kunit/test-bug.h>
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include "rv.h"
+
+/*
+ * An easy way to pass the context is to use kunit_get_current_test()->priv,
+ * but this doesn't always work (e.g. a reactor running from another context
+ * like softirq). Store the current value here whenever a test is running.
+ */
+static struct rv_kunit_ctx *active_ctx;
+
+__printf(1, 0)
+static void rv_kunit_mock_react(const char *msg, va_list args)
+{
+	if (active_ctx)
+		++active_ctx->reactions;
+}
+
+/*
+ * teardown_test - Disable the monitor for a kunit test
+ *
+ * Since per-task monitors are special, make sure we reset all the ones we
+ * started manually here, if required.
+ */
+void teardown_test(void *arg)
+{
+	const struct rv_kunit_mon *mon = arg;
+	struct kunit *test = kunit_get_current_test();
+
+	if (test) {
+		struct rv_kunit_ctx *ctx = test->priv;
+
+		RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+
+		if (mon->is_per_task && mon->task_reset) {
+			for (int i = 0; i < ctx->mock_task_count; i++)
+				mon->task_reset(ctx->mock_tasks[i]);
+			synchronize_rcu();
+		}
+	}
+
+	mon->rv_this->enabled = 0;
+
+	mon->rv_this->react = NULL;
+	active_ctx = NULL;
+
+	if (mon->is_per_task)
+		*mon->task_slot = RV_PER_TASK_MONITOR_INIT;
+	else
+		mon->monitor_destroy();
+}
+
+/*
+ * prepare_test - Enable the monitor for a kunit test
+ *
+ * Do the bare minimum to set up the monitor, per-task monitors are special as
+ * "real" initialisation/destruction iterates over real tasks, and may register
+ * handlers. All we need is to select the right slot in the task_struct.
+ */
+void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon)
+{
+	KUNIT_ASSERT_FALSE(test, mon->rv_this->enabled);
+
+	active_ctx = test->priv;
+	mon->rv_this->react = rv_kunit_mock_react;
+
+	if (mon->is_per_task)
+		*mon->task_slot = 0;
+	else
+		KUNIT_ASSERT_EQ(test, mon->monitor_init(), 0);
+
+	mon->rv_this->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, teardown_test, (void *)mon));
+}
+
+struct task_struct *rv_kunit_alloc_mock_task(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct task_struct *tsk;
+
+	KUNIT_ASSERT_LT(test, ctx->mock_task_count, RV_KUNIT_MAX_MOCK_TASKS);
+
+	tsk = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tsk);
+
+	if (!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK)) {
+		tsk->stack = kunit_kzalloc(test, sizeof(struct thread_info), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, tsk->stack);
+	}
+
+	ctx->mock_tasks[ctx->mock_task_count++] = tsk;
+	return tsk;
+}
+
+static int rv_mon_test_init(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static void __maybe_unused rv_test_stub(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+
+/*
+ * rv_test_dummy - test reactions work as expected
+ */
+static void rv_test_dummy(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	static struct rv_monitor dummy_monitor = {
+		.name = "dummy",
+		.react = rv_kunit_mock_react,
+	};
+
+	active_ctx = ctx;
+
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_react(&dummy_monitor, "dummy");
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+
+	active_ctx = NULL;
+}
+
+#include "monitors/sco/sco_kunit.c"
+#include "monitors/sssw/sssw_kunit.c"
+#include "monitors/sts/sts_kunit.c"
+#include "monitors/opid/opid_kunit.c"
+#include "monitors/nomiss/nomiss_kunit.c"
+
+static struct kunit_case rv_mon_test_cases[] = {
+	KUNIT_CASE(rv_test_dummy),
+	KUNIT_CASE(rv_test_sco),
+	KUNIT_CASE(rv_test_sssw),
+	KUNIT_CASE(rv_test_sts),
+	KUNIT_CASE(rv_test_opid),
+	KUNIT_CASE(rv_test_nomiss),
+	{}
+};
+
+static struct kunit_suite rv_mon_test_suite = {
+	.name = "rv_mon",
+	.suite_init = rv_set_testing,
+	.suite_exit = rv_clear_testing,
+	.init = rv_mon_test_init,
+	.test_cases = rv_mon_test_cases,
+};
+
+kunit_test_suites(&rv_mon_test_suite);
+
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("RV monitor kunit tests: test monitors by triggering reactions");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/tools/verification/rvgen/rvgen/templates/kunit.c b/tools/verification/rvgen/rvgen/templates/kunit.c
index 402b5c8575cf..62092b5cc6d4 100644
--- a/tools/verification/rvgen/rvgen/templates/kunit.c
+++ b/tools/verification/rvgen/rvgen/templates/kunit.c
@@ -13,6 +13,10 @@
 static void rv_test_%%MODEL_NAME%%(struct kunit *test)
 {
 	struct rv_kunit_ctx *ctx = test->priv;
+	/*
+	 * If you need to create task_structs with rv_kunit_alloc_mock_task()
+	 * do it BEFORE preparing the test.
+	 */
 
 	prepare_test(test, &%%STRUCT_NAME%%.mon);
 
-- 
2.55.0

