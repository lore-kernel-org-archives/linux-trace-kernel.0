Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E13E1CE1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389749; cv=none; b=TCFy/pNkZdYZUxUCL4TitAPAWILvDbQogvp4BZKyED4nElFnB2RMWmUr+iGahlRP5mJn7BdByG0PYTrYJAOy0DQxi4Yf2lBGeEUibsk5CwrfR/bpbw/nieMO3A8BjpEEqf7ONmAF5fNP08ws4bBcTJixmTItCyXN3Wats4TMvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389749; c=relaxed/simple;
	bh=8sN9SUZoZqMSuH5dn+ohIlQIywagHn1CiBRLQZGZYtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wi+V598yPbPeu6kK0ToD+5sSO1UTSo+HOTFItm8GVFqwLAhIIr2tJ6ahDtBeR3/A83s8WH/VXKFhw90imWVtPcHbQLR2lNPCM2rfjgJqAkkgAkkG3Cnzhkf+ady0p7/6+ll1EReQ4IyXqDzTP+6nmZDnkbrB+bpk3CjNFuHScxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKB9Hgbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKB9Hgbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TApNB46LkSR/22AhRREzbSbaAj4xNZ8b9AR2xe+Psh0=;
	b=MKB9HgbpdriYy1e3ZE36XcvhX1tcMZ9U/UbCby+bNIlUfbzuMQ7LZatS3TPVbNl4ei/MSp
	B5da0pmzNt7WKedK50/jr1ttY8AN1/i74RES6ihL6W9DxKQcnY1Df7UpTcd1QsMmPiip1f
	HHdwARrgzx//fzm9HZJbJPYB7iXcmXs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-m-v7DQY9NoWfsdHcFrLJ6g-1; Thu,
 25 Jun 2026 08:15:42 -0400
X-MC-Unique: m-v7DQY9NoWfsdHcFrLJ6g-1
X-Mimecast-MFC-AGG-ID: m-v7DQY9NoWfsdHcFrLJ6g_1782389741
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0426F193F045;
	Thu, 25 Jun 2026 12:15:41 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54E2530002E0;
	Thu, 25 Jun 2026 12:15:38 +0000 (UTC)
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
Subject: [PATCH v3 10/17] rv: Add KUnit stub for current
Date: Thu, 25 Jun 2026 14:14:32 +0200
Message-ID: <20260625121440.116317-11-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: GBWC25OxL7yd6P_VaiQr88EOI3WlV1nJGjwBf-zzT1Q_1782389741
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some monitors do not only rely on tracepoint arguments but also on the
currently executing task.
This makes it more challenging to mock events in KUnit.

Define wrapper functions around current, the functionality is stubbed
only during KUnit, however the additional function call is necessary
whenever the KUnit tests are built in.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                       |  1 +
 include/rv/kunit.h                            | 13 +++++++++-
 include/rv/ltl_monitor.h                      |  1 +
 kernel/trace/rv/Kconfig                       |  3 +++
 .../trace/rv/monitors/pagefault/pagefault.c   |  2 +-
 kernel/trace/rv/monitors/sleep/sleep.c        | 24 +++++++++----------
 kernel/trace/rv/rv.c                          |  7 ++++++
 kernel/trace/rv/rv_monitors_test.c            |  8 +++++++
 8 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ec..86948f67d5 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,6 +16,7 @@
 
 #include <rv/automata.h>
 #include <linux/rv.h>
+#include <rv/kunit.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
diff --git a/include/rv/kunit.h b/include/rv/kunit.h
index 93c25c6fc2..5e8c604cf7 100644
--- a/include/rv/kunit.h
+++ b/include/rv/kunit.h
@@ -2,7 +2,10 @@
 /*
  * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
  *
- * Declaration of utilities to run KUnit tests.
+ * Declaration of wrappers to allow stubbing core functionality, like current,
+ * and other testing utilities.
+ * Necessary only when mocking may be needed. If the RV KUnit test is
+ * enabled, the wrappers incur an additional function call overhead.
  */
 
 #ifndef _RV_KUNIT_H
@@ -16,9 +19,11 @@
 
 int rv_set_testing(struct kunit_suite *suite);
 void rv_clear_testing(struct kunit_suite *suite);
+struct task_struct *rv_get_current(void);
 
 struct rv_kunit_ctx {
 	int reactions, expected;
+	struct task_struct *curr;
 };
 
 #define RV_KUNIT_EXPECT_REACTION(test, ctx)                             \
@@ -49,5 +54,11 @@ struct rv_kunit_mon {
 void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon);
 void teardown_test(void *arg);
 
+#define rv_mock_current(ctx, task) (ctx->curr = task)
+
+#else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
+
+#define rv_get_current() current
+
 #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
 #endif /* _RV_KUNIT_H */
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 56e83edcf0..d7dc01db4d 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -9,6 +9,7 @@
 #include <linux/stringify.h>
 #include <linux/seq_buf.h>
 #include <rv/instrumentation.h>
+#include <rv/kunit.h>
 #include <trace/events/task.h>
 #include <trace/events/sched.h>
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 0d83f65199..9450c9520b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -121,4 +121,7 @@ config RV_MONITORS_KUNIT_TEST
 	  These tests verify that monitors correctly detect violations by
 	  triggering fake events and validating the expected reactions.
 
+	  Enabling this may slightly increase overhead of some monitors even
+	  when the KUnit test is not running.
+
 	  If unsure, say N.
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
index 5e1a2a6067..e52500fd2d 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -38,7 +38,7 @@ static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bo
 static void handle_page_fault(void *data, unsigned long address, struct pt_regs *regs,
 			      unsigned long error_code)
 {
-	ltl_atom_pulse(current, LTL_PAGEFAULT, true);
+	ltl_atom_pulse(rv_get_current(), LTL_PAGEFAULT, true);
 }
 
 static int enable_pagefault(void)
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index 12328ce663..71d2005ce5 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -102,7 +102,7 @@ static void handle_sched_waking(void *data, struct task_struct *task)
 	if (this_cpu_read(hardirq_context)) {
 		ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
 	} else if (in_task()) {
-		if (current->prio <= task->prio)
+		if (rv_get_current()->prio <= task->prio)
 			ltl_atom_pulse(task, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
 	} else if (in_nmi()) {
 		ltl_atom_pulse(task, LTL_WOKEN_BY_NMI, true);
@@ -112,12 +112,12 @@ static void handle_sched_waking(void *data, struct task_struct *task)
 static void handle_contention_begin(void *data, void *lock, unsigned int flags)
 {
 	if (flags & LCB_F_RT)
-		ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
+		ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX, true);
 }
 
 static void handle_contention_end(void *data, void *lock, int ret)
 {
-	ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
+	ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX, false);
 }
 
 static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
@@ -126,7 +126,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	unsigned long args[6];
 	int op, cmd;
 
-	mon = ltl_get_monitor(current);
+	mon = ltl_get_monitor(rv_get_current());
 
 	switch (id) {
 #ifdef __NR_clock_nanosleep
@@ -135,11 +135,11 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 #ifdef __NR_clock_nanosleep_time64
 	case __NR_clock_nanosleep_time64:
 #endif
-		syscall_get_arguments(current, regs, args);
+		syscall_get_arguments(rv_get_current(), regs, args);
 		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] == CLOCK_MONOTONIC);
 		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] == CLOCK_TAI);
 		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] == TIMER_ABSTIME);
-		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
+		ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, true);
 		break;
 
 #ifdef __NR_futex
@@ -148,25 +148,25 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 #ifdef __NR_futex_time64
 	case __NR_futex_time64:
 #endif
-		syscall_get_arguments(current, regs, args);
+		syscall_get_arguments(rv_get_current(), regs, args);
 		op = args[1];
 		cmd = op & FUTEX_CMD_MASK;
 
 		switch (cmd) {
 		case FUTEX_LOCK_PI:
 		case FUTEX_LOCK_PI2:
-			ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
+			ltl_atom_update(rv_get_current(), LTL_FUTEX_LOCK_PI, true);
 			break;
 		case FUTEX_WAIT:
 		case FUTEX_WAIT_BITSET:
 		case FUTEX_WAIT_REQUEUE_PI:
-			ltl_atom_update(current, LTL_FUTEX_WAIT, true);
+			ltl_atom_update(rv_get_current(), LTL_FUTEX_WAIT, true);
 			break;
 		}
 		break;
 #ifdef __NR_epoll_wait
 	case __NR_epoll_wait:
-		ltl_atom_update(current, LTL_EPOLL_WAIT, true);
+		ltl_atom_update(rv_get_current(), LTL_EPOLL_WAIT, true);
 		break;
 #endif
 	}
@@ -174,7 +174,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 
 static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
 {
-	struct ltl_monitor *mon = ltl_get_monitor(current);
+	struct ltl_monitor *mon = ltl_get_monitor(rv_get_current());
 
 	ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
 	ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
@@ -182,7 +182,7 @@ static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
 	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
 	ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
 	ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
-	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
+	ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, false);
 }
 
 static void handle_kthread_stop(void *data, struct task_struct *task)
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 5c295e2a49..61d4f13960 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -898,4 +898,11 @@ void rv_clear_testing(struct kunit_suite *suite)
 	mutex_unlock(&rv_interface_lock);
 }
 EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
+
+struct task_struct *rv_get_current(void)
+{
+	KUNIT_STATIC_STUB_REDIRECT(rv_get_current);
+	return current;
+}
+EXPORT_SYMBOL_GPL(rv_get_current);
 #endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index b2f96b71e7..97d3e0358f 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -65,6 +65,13 @@ static void stub_rv_put_task_monitor_slot(int slot)
 {
 }
 
+static struct task_struct *stub_rv_get_current(void)
+{
+	struct rv_kunit_ctx *ctx = kunit_get_current_test()->priv;
+
+	return ctx->curr ?: current;
+}
+
 static int rv_mon_test_init(struct kunit *test)
 {
 	struct rv_kunit_ctx *ctx;
@@ -83,6 +90,7 @@ static int rv_mon_test_init(struct kunit *test)
 				   stub_rv_get_task_monitor_slot);
 	kunit_activate_static_stub(test, rv_put_task_monitor_slot,
 				   stub_rv_put_task_monitor_slot);
+	kunit_activate_static_stub(test, rv_get_current, stub_rv_get_current);
 
 	return 0;
 }
-- 
2.54.0

