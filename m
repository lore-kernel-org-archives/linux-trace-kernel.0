Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B83E025E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389742; cv=none; b=FmNLbI/J7Lk4BcJMbqm60Ix/9HqILk4r0wD30wSQV598+i953iBDljoBbAwP498iRGAsYA/o+qxNMFE74B7bQZc7M+/jskuwyJhnJRMSOXxQyiKZLfmZmEqBVq1NT6hNxM9QB91MpMEg1lNVX9EDhHJg7hUoqxNmzLcAtNTlRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389742; c=relaxed/simple;
	bh=K9Jc/79R7qVWsZYHOsRskg7uDlLmB6i9+cpiyvd81WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Rco3PkACq21czzX0/uH0phLwODNJPIcGf59BykUE/KtehpCz5PYtL34XoNLmuIzNwXRroAz1z5y8ZvdI82YG+C9jDagNLrvx7w/39kUyfTDvtljoxmgH3BDZMT/J0ZEXzYUEZ1fjvO71e6L5vFx9rrqvTDTFNTsblZp7ZffWoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iA6Hv3sC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA6Hv3sC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9dFUPkNwqFTSJ06HZTBVkdClPq1Jmz3LRvOHJU7hZM=;
	b=iA6Hv3sCay6kw14otFFPyyQm8nc1xalHvqM2RgTyKAXeYbUnHwpPE6ZFwCbzTOaoTrqa80
	e6vZBhOGyMF3yGnasgbTWifdtZHs3A7vAj/ET5gaK9qpRGqaUcpvoyegig5D1BV0bGa24U
	S7N0DIsd65MEGmZKMDw+fwVJ5R0JbDc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-jjpd9ED-Ozi18hDTPE-mWg-1; Thu,
 25 Jun 2026 08:15:37 -0400
X-MC-Unique: jjpd9ED-Ozi18hDTPE-mWg-1
X-Mimecast-MFC-AGG-ID: jjpd9ED-Ozi18hDTPE-mWg_1782389735
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D07D6180AD43;
	Thu, 25 Jun 2026 12:15:35 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2347B30002E0;
	Thu, 25 Jun 2026 12:15:32 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 09/17] rv: Add KUnit tests for some DA/HA monitors
Date: Thu, 25 Jun 2026 14:14:31 +0200
Message-ID: <20260625121440.116317-10-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 04enzdVRPINPCPDUGwBRq0fh8qHNBzDMIIEpn15seyY_1782389735
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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/kunit.h                            |  53 ++++++++
 kernel/trace/rv/Kconfig                       |  11 ++
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  21 +++
 .../trace/rv/monitors/nomiss/nomiss_kunit.c   |  52 ++++++++
 .../trace/rv/monitors/nomiss/nomiss_kunit.h   |  34 +++++
 kernel/trace/rv/monitors/opid/opid.c          |  16 +++
 kernel/trace/rv/monitors/opid/opid_kunit.c    |  33 +++++
 kernel/trace/rv/monitors/opid/opid_kunit.h    |  23 ++++
 kernel/trace/rv/monitors/sco/sco.c            |  17 +++
 kernel/trace/rv/monitors/sco/sco_kunit.c      |  31 +++++
 kernel/trace/rv/monitors/sco/sco_kunit.h      |  24 ++++
 kernel/trace/rv/monitors/sssw/sssw.c          |  18 +++
 kernel/trace/rv/monitors/sssw/sssw_kunit.c    |  36 +++++
 kernel/trace/rv/monitors/sssw/sssw_kunit.h    |  30 +++++
 kernel/trace/rv/monitors/sts/sts.c            |  23 ++++
 kernel/trace/rv/monitors/sts/sts_kunit.c      |  42 ++++++
 kernel/trace/rv/monitors/sts/sts_kunit.h      |  33 +++++
 kernel/trace/rv/rv.c                          |  40 ++++++
 kernel/trace/rv/rv_monitors_test.c            | 123 ++++++++++++++++++
 20 files changed, 661 insertions(+)
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

diff --git a/include/rv/kunit.h b/include/rv/kunit.h
new file mode 100644
index 0000000000..93c25c6fc2
--- /dev/null
+++ b/include/rv/kunit.h
@@ -0,0 +1,53 @@
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
+struct rv_kunit_ctx {
+	int reactions, expected;
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
+};
+
+void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon);
+void teardown_test(void *arg);
+
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+#endif /* _RV_KUNIT_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df3..0d83f65199 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -111,3 +111,14 @@ config RV_REACT_PANIC
 	help
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
+
+config RV_MONITORS_KUNIT_TEST
+	tristate "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
+	depends on KUNIT && RV
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the RV (Runtime Verification) monitors.
+	  These tests verify that monitors correctly detect violations by
+	  triggering fake events and validating the expected reactions.
+
+	  If unsure, say N.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b..a3502b7fe7 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 8ead8783c2..33ec9c7412 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -291,3 +291,24 @@ module_exit(unregister_nomiss);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadline.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "nomiss_kunit.h"
+
+const struct rv_nomiss_ops rv_nomiss_ops = {
+	.mon = {
+		.rv_this = &rv_this,
+		.monitor_init = ha_monitor_init,
+		.monitor_destroy = ha_monitor_destroy,
+	},
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
index 0000000000..cf86212cb4
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
@@ -0,0 +1,52 @@
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
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_nomiss_ops.mon);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+
+#ifdef CONFIG_SMP
+	if (!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK)) {
+		target->stack = kunit_kzalloc(test, sizeof(struct thread_info), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, target->stack);
+		other->stack = kunit_kzalloc(test, sizeof(struct thread_info), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, other->stack);
+	}
+	task_thread_info(target)->cpu = 0;
+	task_thread_info(other)->cpu = 0;
+#endif
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
+	//udelay(10 + deadline_thresh / 1000);
+	udelay(10 + TICK_NSEC / 1000);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_nomiss_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+}
+
+#else
+#define rv_test_nomiss rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
new file mode 100644
index 0000000000..5cc72e10d8
--- /dev/null
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
@@ -0,0 +1,34 @@
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
index 3b6a85e815..01edc762b7 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -115,3 +115,19 @@ module_exit(unregister_opid);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("opid: operations with preemption and irq disabled.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "opid_kunit.h"
+
+const struct rv_opid_ops rv_opid_ops = {
+	.mon = {
+		.rv_this = &rv_this,
+		.monitor_init = da_monitor_init,
+		.monitor_destroy = da_monitor_destroy,
+	},
+	.handle_sched_need_resched = handle_sched_need_resched,
+	.handle_sched_waking = handle_sched_waking,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_opid_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/opid/opid_kunit.c b/kernel/trace/rv/monitors/opid/opid_kunit.c
new file mode 100644
index 0000000000..3cb087a742
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
index 0000000000..4969c61759
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
index 5a3bd5e16e..9690282d8c 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -83,3 +83,20 @@ module_exit(unregister_sco);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sco: scheduling context operations.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sco_kunit.h"
+
+const struct rv_sco_ops rv_sco_ops = {
+	.mon = {
+		.rv_this = &rv_this,
+		.monitor_init = da_monitor_init,
+		.monitor_destroy = da_monitor_destroy,
+	},
+	.handle_sched_set_state = handle_sched_set_state,
+	.handle_schedule_entry = handle_schedule_entry,
+	.handle_schedule_exit = handle_schedule_exit,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sco_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sco/sco_kunit.c b/kernel/trace/rv/monitors/sco/sco_kunit.c
new file mode 100644
index 0000000000..b37b6e13c0
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco_kunit.c
@@ -0,0 +1,31 @@
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
+	struct task_struct *target;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sco_ops.mon);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
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
index 0000000000..567757df6b
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
index a91321c890..3665511d94 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.c
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -112,3 +112,21 @@ module_exit(unregister_sssw);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sssw: set state sleep and wakeup.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sssw_kunit.h"
+
+const struct rv_sssw_ops rv_sssw_ops = {
+	.mon = {
+		.rv_this = &rv_this,
+		.monitor_init = da_monitor_init,
+		.monitor_destroy = da_monitor_destroy,
+	},
+	.handle_sched_set_state = handle_sched_set_state,
+	.handle_sched_switch = handle_sched_switch,
+	.handle_sched_wakeup = handle_sched_wakeup,
+	.handle_signal_deliver = handle_signal_deliver,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sssw_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sssw/sssw_kunit.c b/kernel/trace/rv/monitors/sssw/sssw_kunit.c
new file mode 100644
index 0000000000..849acd3a62
--- /dev/null
+++ b/kernel/trace/rv/monitors/sssw/sssw_kunit.c
@@ -0,0 +1,36 @@
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
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sssw_ops.mon);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
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
index 0000000000..6513daa7af
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
index ce031cbf20..c313fde09a 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -152,3 +152,26 @@ module_exit(unregister_sts);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sts: schedule implies task switch.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sts_kunit.h"
+
+const struct rv_sts_ops rv_sts_ops = {
+	.mon = {
+		.rv_this = &rv_this,
+		.monitor_init = da_monitor_init,
+		.monitor_destroy = da_monitor_destroy,
+	},
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
index 0000000000..0eea91db7b
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/sts_kunit.c
@@ -0,0 +1,42 @@
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
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_sts_ops.mon);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
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
index 0000000000..dede4e098c
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
index bb893bf4a2..5c295e2a49 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -859,3 +859,43 @@ int __init rv_init_interface(void)
 
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
index 0000000000..b2f96b71e7
--- /dev/null
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -0,0 +1,123 @@
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
+ * teardown_test - Disable the monitor for a kunit test
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
+	}
+
+	mon->rv_this->enabled = 0;
+	mon->monitor_destroy();
+}
+
+/*
+ * prepare_test - Enable the monitor for a kunit test
+ *
+ * Do the bare minimum to set up the monitor, make sure it is not active and
+ * real tracepoint handlers are NOT attached.
+ */
+void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon)
+{
+	KUNIT_ASSERT_FALSE(test, mon->rv_this->enabled);
+	KUNIT_ASSERT_EQ(test, mon->monitor_init(), 0);
+	mon->rv_this->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, teardown_test, (void *)mon));
+}
+
+__printf(2, 3)
+static void stub_rv_react(struct rv_monitor *monitor, const char *msg, ...)
+{
+	struct rv_kunit_ctx *ctx = kunit_get_current_test()->priv;
+
+	++ctx->reactions;
+}
+
+static int stub_rv_get_task_monitor_slot(void)
+{
+	return 0;
+}
+
+static void stub_rv_put_task_monitor_slot(int slot)
+{
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
+	__diag_push();
+	__diag_ignore(GCC, all, "-Wsuggest-attribute=format",
+		      "Not a valid __printf() conversion candidate.");
+	kunit_activate_static_stub(test, rv_react, stub_rv_react);
+	__diag_pop();
+	kunit_activate_static_stub(test, rv_get_task_monitor_slot,
+				   stub_rv_get_task_monitor_slot);
+	kunit_activate_static_stub(test, rv_put_task_monitor_slot,
+				   stub_rv_put_task_monitor_slot);
+
+	return 0;
+}
+
+static void __maybe_unused rv_test_stub(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+
+#include "monitors/sco/sco_kunit.c"
+#include "monitors/sssw/sssw_kunit.c"
+#include "monitors/sts/sts_kunit.c"
+#include "monitors/opid/opid_kunit.c"
+#include "monitors/nomiss/nomiss_kunit.c"
+
+static struct kunit_case rv_mon_test_cases[] = {
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
-- 
2.54.0

