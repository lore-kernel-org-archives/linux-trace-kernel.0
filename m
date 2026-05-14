Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9377428487
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772142; cv=none; b=ZzGkArXLtt5DHdcnouQCZCJSbNbY6wrs1EDVIf/vzPZnJQSypiIgrUp0BwGnwPWVJe8eguf3a8o+0qGEAHdFqlrNPX3V/Gbwbm5ucO5qw4FWl50l6UTTtdBVMNwoNbMwDlfy4ocFOpCk3UwTG+VKUUW3gDPQxyxPa8Ln/O/GItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772142; c=relaxed/simple;
	bh=yED5GptCBeJvjyG7GR3JJ+4/syeDt8ge3n2csFZNFq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gpR9V5Hg5gjxoZQEEhHKwkqzOE03ORkzql3S+WvegmK8rq1c4Je/8CNd2UBx7M6aYsc82rFyvZBZhpVdDTGd4XO/zES0+Rcn1BkizlAvWEPfuDz1pOzg65hZRIoWMEixyQqsfmG78zD9O5DRCnxwOS03mDVt4YehG8/hEkqaxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvUrX3/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvUrX3/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kv4F8za0V9Kpcwtw3XsSLhuVZ6m6LjaQMH64pRuS7dM=;
	b=HvUrX3/+YT66rPhKAsFc1TDfcdJmqIwl7M3cVd4vcONRpoivzcOOypbAsRGy02vzqvEq+R
	HAFtku1sOQY4dDaSPQsewsu7LzjwX+cbaVhXpiUVUzqk9TaTk/EfeTMj5/bENXbxci1c3h
	uRDA/VaoRKW3WJLDZ+88e2UjbHDrj4U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-nwVYFCz1NJOVsbuKHJbeyg-1; Thu,
 14 May 2026 11:22:12 -0400
X-MC-Unique: nwVYFCz1NJOVsbuKHJbeyg-1
X-Mimecast-MFC-AGG-ID: nwVYFCz1NJOVsbuKHJbeyg_1778772128
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54C2E19560A7;
	Thu, 14 May 2026 15:22:08 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0795230001A2;
	Thu, 14 May 2026 15:22:04 +0000 (UTC)
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
Subject: [PATCH v2 11/14] rv: Add KUnit tests for some DA/HA monitors
Date: Thu, 14 May 2026 17:20:52 +0200
Message-ID: <20260514152055.229162-12-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 6hdwjrt_kGTBK1accjiunTvFpmAp0WabXduERheHj8o_1778772128
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
 include/rv/da_monitor.h                  |  38 +++++++
 include/rv/kunit.h                       |  41 ++++++++
 kernel/trace/rv/Kconfig                  |  11 ++
 kernel/trace/rv/Makefile                 |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.c |  44 ++++++++
 kernel/trace/rv/monitors/opid/opid.c     |  26 +++++
 kernel/trace/rv/monitors/sco/sco.c       |  24 +++++
 kernel/trace/rv/monitors/sssw/sssw.c     |  29 ++++++
 kernel/trace/rv/monitors/sts/sts.c       |  35 +++++++
 kernel/trace/rv/rv_monitors_test.c       | 126 +++++++++++++++++++++++
 10 files changed, 375 insertions(+)
 create mode 100644 include/rv/kunit.h
 create mode 100644 kernel/trace/rv/rv_monitors_test.c

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..d16a55292f3f 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -15,6 +15,7 @@
 #define _RV_DA_MONITOR_H
 
 #include <rv/automata.h>
+#include <rv/kunit.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
@@ -817,4 +818,41 @@ static inline void da_reset(da_id_type id, monitor_target target)
 }
 #endif /* RV_MON_TYPE */
 
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+
+/*
+ * da_teardown_test - Disable the monitor for a kunit test
+ */
+static inline void da_teardown_test(void *arg)
+{
+	struct rv_monitor *rv_this = arg;
+	struct kunit *test = kunit_get_current_test();
+
+	if (test) {
+		struct rv_kunit_ctx *ctx = test->priv;
+
+		RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	}
+
+	rv_this->enabled = 0;
+	da_monitor_destroy();
+}
+
+/*
+ * da_prepare_test - Enable the monitor for a kunit test
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
diff --git a/include/rv/kunit.h b/include/rv/kunit.h
new file mode 100644
index 000000000000..67f6057bd5b1
--- /dev/null
+++ b/include/rv/kunit.h
@@ -0,0 +1,41 @@
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
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/delay.h>
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
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
+#endif /* _RV_KUNIT_H */
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
index 94498da35b37..a3502b7fe7f2 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 31f90f3638d8..a0b5641a1858 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -291,3 +291,47 @@ module_exit(unregister_nomiss);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("nomiss: dl entities run to completion before their deadline.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_nomiss(struct kunit *test);
+
+void rv_test_nomiss(struct kunit *test)
+{
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+
+	if (IS_ENABLED(CONFIG_SMP)) {
+		if (!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK)) {
+			target->stack = kunit_kzalloc(test, sizeof(struct thread_info), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, target->stack);
+			other->stack = kunit_kzalloc(test, sizeof(struct thread_info), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, other->stack);
+		}
+		task_thread_info(target)->cpu = 0;
+		task_thread_info(other)->cpu = 0;
+	}
+
+	target->pid = 99;
+	target->policy = SCHED_DEADLINE;
+	target->dl.runtime = 10000;
+	target->dl.dl_deadline = 20000;
+
+	handle_newtask(NULL, target, 0);
+
+	/* Task gets preempted and can't terminate before deadline */
+	handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
+	udelay(10);
+	handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	udelay(10 + deadline_thresh / 1000);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(rv_test_nomiss);
+#endif
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 4594c7c46601..124dd043999f 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -121,3 +121,29 @@ module_exit(unregister_opid);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("opid: operations with preemption and irq disabled.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_opid(struct kunit *test);
+
+void rv_test_opid(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+
+	/* Ensure we keep the same per-cpu monitor */
+	guard(migrate)();
+	KUNIT_EXPECT_TRUE(test, preemptible());
+
+	/* Wakeup with preemption and interrupts enabled */
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_waking(NULL, NULL);
+
+	/* Need resched with interrupts enabled */
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx) {
+		scoped_guard(preempt)
+			handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
+	}
+}
+EXPORT_SYMBOL_GPL(rv_test_opid);
+#endif
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 5a3bd5e16e62..40eab946574b 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -83,3 +83,27 @@ module_exit(unregister_sco);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sco: scheduling context operations.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_sco(struct kunit *test);
+
+void rv_test_sco(struct kunit *test)
+{
+	struct task_struct *target;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+
+	/* Ensure we keep the same per-cpu monitor */
+	guard(migrate)();
+
+	/* Set state while scheduling */
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	handle_schedule_entry(NULL, false);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+}
+EXPORT_SYMBOL_GPL(rv_test_sco);
+#endif
diff --git a/kernel/trace/rv/monitors/sssw/sssw.c b/kernel/trace/rv/monitors/sssw/sssw.c
index a91321c890cd..6d33b740474c 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.c
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -112,3 +112,32 @@ module_exit(unregister_sssw);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sssw: set state sleep and wakeup.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_sssw(struct kunit *test);
+
+void rv_test_sssw(struct kunit *test)
+{
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+
+	/* Suspend without setting to sleepable */
+	handle_sched_set_state(NULL, target, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+
+	/* Switch in after suspension without wakeup */
+	handle_sched_wakeup(NULL, target);
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	handle_sched_switch(NULL, 0, target, other, TASK_INTERRUPTIBLE);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(rv_test_sssw);
+#endif
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
index ce031cbf202a..587ec44fb509 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -152,3 +152,38 @@ module_exit(unregister_sts);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("sts: schedule implies task switch.");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_sts(struct kunit *test);
+
+void rv_test_sts(struct kunit *test)
+{
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	da_prepare_test(test, &rv_this);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+	/* Per-CPU monitor, make sure we don't change CPU mid-test */
+	guard(migrate)();
+
+	/* Switch without disabling interrupts */
+	handle_schedule_exit(NULL, false);
+	handle_schedule_entry(NULL, false);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+
+	handle_schedule_exit(NULL, false);
+
+	/* Schedule from interrupt context */
+	handle_schedule_entry(NULL, false);
+	handle_irq_disable(NULL, 0, 0);
+	handle_irq_entry(NULL, 0, NULL);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
+	handle_irq_enable(NULL, 0, 0);
+}
+EXPORT_SYMBOL_GPL(rv_test_sts);
+#endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
new file mode 100644
index 000000000000..5a12a109c1ed
--- /dev/null
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -0,0 +1,126 @@
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
+/*
+ * rv_set_testing - ensure mutual exclusion between KUnit tests and real monitors
+ *
+ * KUnit tests for RV monitors rely on stubs that are incompatible with
+ * the execution of real monitors. Ensure mutual exclusion by acquiring
+ * the rv_interface_lock for the duration of the suite.
+ *
+ * Returns 0 on success, -EBUSY if any real monitor is already enabled.
+ */
+static int rv_set_testing(struct kunit_suite *suite)
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
+	rv_mon_test_running = true;
+
+	return 0;
+}
+
+/*
+ * rv_clear_testing - allow real monitors to run again after KUnit tests
+ */
+static void rv_clear_testing(struct kunit_suite *suite)
+{
+	mutex_unlock(&rv_interface_lock);
+}
+
+static void rv_test_stub(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+
+#define DECLARE_RV_TEST(name) \
+	void name(struct kunit *test) __weak __alias(rv_test_stub)
+
+DECLARE_RV_TEST(rv_test_sco);
+DECLARE_RV_TEST(rv_test_sssw);
+DECLARE_RV_TEST(rv_test_sts);
+DECLARE_RV_TEST(rv_test_opid);
+DECLARE_RV_TEST(rv_test_nomiss);
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
-- 
2.54.0

