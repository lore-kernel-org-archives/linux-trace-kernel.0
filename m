Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC832E68D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302779; cv=none; b=i+MnOHjRxsSbr/YjLros8XSp3yK/bvCe1AUutKBKbzpftdfHFs2RWhqVR06Ii1tluC1pRxlYczUJFzboHmxnrwZpkrSpkjbYxbdxUiTmAHiew6eoLNJZ/FkCO9qqy3febTM7EpWn6yDhJwRGCTWZDbVDWlKbm2D10y+Rns5hi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302779; c=relaxed/simple;
	bh=0gzJVh3czryeY5vMqVpJTtLcSoUu1nLwmlRwTmMRNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UqqIetbuW/gwY1tPDUjZzlKqWhRaHcgqecBH7l0EtV4pls2Q7I1CKl0/qN8nAf5Lsa39DmDuUpY+r1+7R2V0L2rchBffEBJzFgYUT/JJ1xTxkjb3bPhsnpms6XifxtxvrN2H7wdGfwq0aFJ/Hf5v/0M4YOnFWcI9NY5jY+Hb98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaljPPid; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaljPPid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzG+hmGizFFlPYyVCLD4+Ia1+rXUxafT+3z4DUqDlMg=;
	b=FaljPPiduWX60Xfe2hY3ERJdC7X1J1pZryxbh+FVH+V+ttx+7IhM9ZOOlctExndEjKAcuE
	V3T4WkuOkzMQB1pRUzSevu6PtfZJTOVifCwP01YwU/TmChvWVBhr4/w1wiKI+1dMSSSXDM
	B7JImYIH63wu2oS46h+a2KN1k7AMZxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-yK-LVpVpOZSapDwKFlcUAg-1; Mon,
 27 Apr 2026 11:12:48 -0400
X-MC-Unique: yK-LVpVpOZSapDwKFlcUAg-1
X-Mimecast-MFC-AGG-ID: yK-LVpVpOZSapDwKFlcUAg_1777302766
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0693019560BB;
	Mon, 27 Apr 2026 15:12:46 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D070195608E;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
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
Subject: [RFC PATCH 10/12] rv: Add KUnit tests for some DA/HA monitors
Date: Mon, 27 Apr 2026 17:11:32 +0200
Message-ID: <20260427151134.192971-11-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: SpopLCtSsCsZFz01Ckg7QKtSMA4ZgRp9MEdNPrR3rnA_1777302766
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Validate the functionality of DA monitors by injecting events in a
controlled environment (KUnit) and expecting reactions.

Events handlers are called directly from the monitor source files
without using system events and with dummy arguments (e.g. no real
tasks). If the provided sequence of events incurs a violation, the test
expects the stub version of rv_react() to be called.

This testing method can validate the entire monitor implementation since
it sits between the monitor and the system (in place of the
tracepoints). All sorts of system and timing events can be emulated
without affecting the running kernel.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                  | 31 +++++++++++
 kernel/trace/rv/Kconfig                  | 11 ++++
 kernel/trace/rv/Makefile                 |  3 +
 kernel/trace/rv/monitors/nomiss/nomiss.c | 30 ++++++++++
 kernel/trace/rv/monitors/opid/opid.c     | 27 +++++++++
 kernel/trace/rv/monitors/sco/sco.c       | 23 ++++++++
 kernel/trace/rv/monitors/sssw/sssw.c     | 27 +++++++++
 kernel/trace/rv/monitors/sts/sts.c       | 35 ++++++++++++
 kernel/trace/rv/rv_monitors_test.c       | 70 ++++++++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.h       | 69 +++++++++++++++++++++++
 10 files changed, 326 insertions(+)
 create mode 100644 kernel/trace/rv/rv_monitors_test.c
 create mode 100644 kernel/trace/rv/rv_monitors_test.h

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..e85a82ad6c7b 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -817,4 +817,35 @@ static inline void da_reset(da_id_type id, monitor_target target)
 }
 #endif /* RV_MON_TYPE */
 
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include <kunit/test.h>
+
+/*
+ * rv_prepare_test - Disable the monitor for a kunit test
+ */
+static inline void da_teardown_test(void *arg)
+{
+	struct rv_monitor *rv_this = arg;
+
+	rv_this->enabled = 0;
+	da_monitor_destroy();
+}
+
+/*
+ * rv_prepare_test - Enable the monitor for a kunit test
+ *
+ * Do the bare minimum to set up the monitor, make sure it is not active and
+ * real tracepoint handlers are NOT attached.
+ */
+static inline void da_prepare_test(struct kunit *test, struct rv_monitor *rv_this)
+{
+	KUNIT_ASSERT_FALSE(test, rv_this->enabled);
+	da_monitor_init();
+	rv_this->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, da_teardown_test, rv_this));
+}
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+
 #endif
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..d7dba4453bd3 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -111,3 +111,14 @@ config RV_REACT_PANIC
 	help
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
+
+config RV_MONITORS_KUNIT_TEST
+	bool "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && RV
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the RV (Runtime Verification) monitors.
+	  These tests verify that monitors correctly detect violations by
+	  triggering fake events and validating the expected reactions.
+
+	  If unsure, say N.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..6fdf055a57c4 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -24,3 +24,6 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
+# Stubbing rv_react triggers the error
+CFLAGS_rv_monitors_test.o += -Wno-suggest-attribute=format
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 31f90f3638d8..57b8b7245552 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -291,3 +291,33 @@ module_exit(unregister_nomiss);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadline.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_nomiss(struct kunit *test)
+{
+	static struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	target->pid = 99;
+	target->policy = SCHED_DEADLINE;
+	target->dl.runtime = 10000;
+	target->dl.deadline = 20000;
+
+	handle_newtask(NULL, target, 0);
+
+	/* Task gets preempted and can't terminate before deadline */
+	handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
+	udelay(10 / 1000);
+	handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	udelay(10 + deadline_thresh / 1000);
+	handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_nomiss);
+#endif
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 4594c7c46601..cddd84deafdc 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -121,3 +121,30 @@ module_exit(unregister_opid);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("opid: operations with preemption and irq disabled.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_opid(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+
+	/*
+	 * The handlers are called with an additional level of preemption,
+	 * ensure we start from 0 but apply it here to avoid warnings.
+	 */
+	KUNIT_ASSERT_TRUE(test, preemptible());
+	guard(preempt)();
+
+	/* Wakeup with preemption and interrupts enabled */
+	handle_sched_waking(NULL, NULL);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+	/* Need resched with interrupts enabled */
+	scoped_guard(preempt)
+		handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
+}
+EXPORT_SYMBOL_GPL(rv_test_opid);
+#endif
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 5a3bd5e16e62..5f52400fa452 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -83,3 +83,26 @@ module_exit(unregister_sco);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sco: scheduling context operations.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_sco(struct kunit *test)
+{
+	static struct task_struct *target;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+
+	/* The handlers are called with preemption disabled. */
+	guard(preempt)();
+
+	/* Set state while scheduling */
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	handle_schedule_entry(NULL, false);
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_sco);
+#endif
diff --git a/kernel/trace/rv/monitors/sssw/sssw.c b/kernel/trace/rv/monitors/sssw/sssw.c
index a91321c890cd..7660adf304f7 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.c
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -112,3 +112,30 @@ module_exit(unregister_sssw);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sssw: set state sleep and wakeup.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_sssw(struct kunit *test)
+{
+	static struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+
+	/* Suspend without setting to sleepable */
+	handle_sched_set_state(NULL, target, TASK_RUNNING);
+	handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+	/* Switch in after suspension without wakeup */
+	handle_sched_wakeup(NULL, target);
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+	handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_sssw);
+#endif
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
index ce031cbf202a..0cb7ab5bc51b 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -152,3 +152,38 @@ module_exit(unregister_sts);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sts: schedule implies task switch.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_sts(struct kunit *test)
+{
+	static struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	/* Per-CPU monitor, make sure we don't change CPU mid-test */
+	guard(migrate)();
+
+	handle_schedule_exit(NULL, false);
+
+	/* Switch without disabling interrupts */
+	handle_schedule_exit(NULL, false);
+	handle_schedule_entry(NULL, false);
+	handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+	handle_schedule_exit(NULL, false);
+
+	/* Schedule from interrupt context */
+	handle_schedule_entry(NULL, false);
+	handle_irq_disable(NULL, 0, 0);
+	handle_irq_entry(NULL, 0, NULL);
+	handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	handle_irq_enable(NULL, 0, 0);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_sts);
+#endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
new file mode 100644
index 000000000000..bffb960ecba7
--- /dev/null
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2028 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * RV debug trigger kunit tests:
+ *   Tests the RV monitors by triggering fake events to verify monitor
+ *   behavior and reactions. Tests start from the first defined event and
+ *   trigger events in order to verify error detection.
+ */
+#include "rv_monitors_test.h"
+#include <kunit/static_stub.h>
+#include <kunit/test-bug.h>
+#include <linux/kernel.h>
+#include <linux/rv.h>
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
+static int rv_trigger_test_init(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	test->priv = ctx;
+
+	kunit_activate_static_stub(test, rv_react, stub_rv_react);
+	kunit_activate_static_stub(test, rv_get_task_monitor_slot,
+				   stub_rv_get_task_monitor_slot);
+	kunit_activate_static_stub(test, rv_put_task_monitor_slot,
+				   stub_rv_put_task_monitor_slot);
+
+	return 0;
+}
+
+static struct kunit_case rv_trigger_test_cases[] = {
+	KUNIT_CASE(rv_test_sco),
+	KUNIT_CASE(rv_test_sssw),
+	KUNIT_CASE(rv_test_sts),
+	KUNIT_CASE(rv_test_opid),
+	KUNIT_CASE(rv_test_nomiss),
+	{}
+};
+
+static struct kunit_suite rv_trigger_test_suite = {
+	.name = "rv_trigger",
+	.init = rv_trigger_test_init,
+	.test_cases = rv_trigger_test_cases,
+};
+
+kunit_test_suites(&rv_trigger_test_suite);
+
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("RV debug trigger kunit tests: test monitors by triggering reactions");
+MODULE_LICENSE("GPL");
diff --git a/kernel/trace/rv/rv_monitors_test.h b/kernel/trace/rv/rv_monitors_test.h
new file mode 100644
index 000000000000..968b07565a61
--- /dev/null
+++ b/kernel/trace/rv/rv_monitors_test.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <kunit/test.h>
+#include <linux/delay.h>
+
+struct rv_kunit_ctx {
+	int reactions, expected;
+	int cpu;
+	struct task_struct *curr;
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
+#ifdef CONFIG_RV_MON_SCO
+extern void rv_test_sco(struct kunit *test);
+#else
+static inline void rv_test_sco(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
+
+#ifdef CONFIG_RV_MON_SSSW
+extern void rv_test_sssw(struct kunit *test);
+#else
+static inline void rv_test_sssw(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
+
+#ifdef CONFIG_RV_MON_STS
+extern void rv_test_sts(struct kunit *test);
+#else
+static inline void rv_test_sts(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
+
+#ifdef CONFIG_RV_MON_OPID
+extern void rv_test_opid(struct kunit *test);
+#else
+static inline void rv_test_opid(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
+
+#ifdef CONFIG_RV_MON_NOMISS
+extern void rv_test_nomiss(struct kunit *test);
+#else
+static inline void rv_test_nomiss(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
-- 
2.53.0

