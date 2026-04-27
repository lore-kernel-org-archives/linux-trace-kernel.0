Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD473CEB9D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302783; cv=none; b=KS8N0vGEX8clLcEvK3Q+6Wotv10ahQpS11Rnl/SSsE9CU+cXLY+gQ7//Hg+JQsTrQD8jlXjE+MNX7kTKNf8RI8S3ltxwejHl1fPlApdohveffz3Z04ZKq3m0+h+1AwFB+c2L0/PPJPJIgSiku1YFVWMqxOamFVZkIEicduMVgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302783; c=relaxed/simple;
	bh=AomreWSbXYf9vNdf0Q4XY5PD84NzYlMtoWaLJS7/hV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WIX6Kj32QTAEaN+n7zSb6TIQy/p0yGx49S/sMUER1zHbyY5Nep6/QYRi5fUtt+bOfJFbgY0XvLFhWeFOSLt3Mc1tHJV2wmmO1CBGKA9r2w7QCRNoUYwwgW4NS2PlI+bIB6nWcE/+fUI/awwlCEok4fIrBWtx8wGxs0HMjtB3Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHk8ZYxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHk8ZYxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhysTtM8tcX7StTvUH4XEYwa/yO5ca/AdRwPcNf1hUw=;
	b=JHk8ZYxedGyLl3AQ5EWpLS6X6CPCG5n5A700pLaTq3OdhbbyiUueCV+BRdCmbVOCrpr7XJ
	iKag91Lhf/xcp5rD2gXkA7o61ssj3fiQRxkHigc9q9z27OODOtVxab5PE+jYyTFdHDwtGb
	NU16UldtAq/bGNr/4Vsqim8uEhw6jU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-EgUDegOVOu6EXp7PCJIMtA-1; Mon,
 27 Apr 2026 11:12:56 -0400
X-MC-Unique: EgUDegOVOu6EXp7PCJIMtA-1
X-Mimecast-MFC-AGG-ID: EgUDegOVOu6EXp7PCJIMtA_1777302771
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D41A61800370;
	Mon, 27 Apr 2026 15:12:51 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFD2A196B8FA;
	Mon, 27 Apr 2026 15:12:48 +0000 (UTC)
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
Subject: [RFC PATCH 11/12] rv: Add KUnit stubs for current and smp_processor_id()
Date: Mon, 27 Apr 2026 17:11:33 +0200
Message-ID: <20260427151134.192971-12-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: zCBviPp-P0jDtRiM4aaNaF40zRd1Q7a_52UUf0jik_A_1777302771
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some monitors do not only rely on tracepoint arguments but also on the
currently executing task and current processor.
This makes it more challenging to mock events in KUnit.

Define wrapper functions around current and smp_processor_id(), the
functionality is stubbed only during KUnit, however the additional
function call is necessary whenever the KUnit tests are built in.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                       |  1 +
 include/rv/kunit_stubs.h                      | 17 ++++++++++++
 include/rv/ltl_monitor.h                      |  1 +
 kernel/trace/rv/Kconfig                       |  3 +++
 .../trace/rv/monitors/pagefault/pagefault.c   |  2 +-
 kernel/trace/rv/monitors/sleep/sleep.c        | 22 +++++++--------
 kernel/trace/rv/rv_monitors_test.c            | 27 +++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.h            |  3 +++
 8 files changed, 64 insertions(+), 12 deletions(-)
 create mode 100644 include/rv/kunit_stubs.h

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index e85a82ad6c7b..9c2a051608ff 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -15,6 +15,7 @@
 #define _RV_DA_MONITOR_H
 
 #include <rv/automata.h>
+#include <rv/kunit_stubs.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
diff --git a/include/rv/kunit_stubs.h b/include/rv/kunit_stubs.h
new file mode 100644
index 000000000000..ed04c56b440f
--- /dev/null
+++ b/include/rv/kunit_stubs.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * Declaration of wrappers to allow stubbing core functionality like current
+ * and smp_processor_id().
+ * Necessary only when mocking may be needed. If the RV KUnit test is
+ * enabled, these wrapper incur an additional function call overhead.
+ */
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+struct task_struct *rv_get_current(void);
+int rv_current_cpu(void);
+#else
+#define rv_get_current() current
+#define rv_current_cpu() smp_processor_id()
+#endif
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index eff60cd61106..0f2c3820b9b8 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -9,6 +9,7 @@
 #include <linux/stringify.h>
 #include <linux/seq_buf.h>
 #include <rv/instrumentation.h>
+#include <rv/kunit_stubs.h>
 #include <trace/events/task.h>
 #include <trace/events/sched.h>
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index d7dba4453bd3..e76841a6ed35 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -121,4 +121,7 @@ config RV_MONITORS_KUNIT_TEST
 	  These tests verify that monitors correctly detect violations by
 	  triggering fake events and validating the expected reactions.
 
+	  Enabling this may slighly increase overhead of some monitors even
+	  when the KUnit test is not running.
+
 	  If unsure, say N.
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
index 9fe6123b2200..56abe5079676 100644
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
index 8dfe5ec13e19..7c16967add70 100644
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
@@ -148,19 +148,19 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
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
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index bffb960ecba7..a57a40932d34 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -8,6 +8,7 @@
  *   trigger events in order to verify error detection.
  */
 #include "rv_monitors_test.h"
+#include <rv/kunit_stubs.h>
 #include <kunit/static_stub.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
@@ -30,6 +31,30 @@ static void stub_rv_put_task_monitor_slot(int slot)
 {
 }
 
+struct task_struct *rv_get_current(void)
+{
+	KUNIT_STATIC_STUB_REDIRECT(rv_get_current);
+	return current;
+}
+int rv_current_cpu(void)
+{
+	KUNIT_STATIC_STUB_REDIRECT(rv_current_cpu);
+	return smp_processor_id();
+}
+
+static struct task_struct *stub_rv_get_current(void)
+{
+	struct rv_kunit_ctx *ctx = kunit_get_current_test()->priv;
+
+	return ctx->curr;
+}
+static int stub_rv_current_cpu(void)
+{
+	struct rv_kunit_ctx *ctx = kunit_get_current_test()->priv;
+
+	return ctx->cpu;
+}
+
 static int rv_trigger_test_init(struct kunit *test)
 {
 	struct rv_kunit_ctx *ctx;
@@ -44,6 +69,8 @@ static int rv_trigger_test_init(struct kunit *test)
 				   stub_rv_get_task_monitor_slot);
 	kunit_activate_static_stub(test, rv_put_task_monitor_slot,
 				   stub_rv_put_task_monitor_slot);
+	kunit_activate_static_stub(test, rv_get_current, stub_rv_get_current);
+	kunit_activate_static_stub(test, rv_current_cpu, stub_rv_current_cpu);
 
 	return 0;
 }
diff --git a/kernel/trace/rv/rv_monitors_test.h b/kernel/trace/rv/rv_monitors_test.h
index 968b07565a61..3015943c5dda 100644
--- a/kernel/trace/rv/rv_monitors_test.h
+++ b/kernel/trace/rv/rv_monitors_test.h
@@ -23,6 +23,9 @@ struct rv_kunit_ctx {
 			ctx->expected = ctx->reactions;               \
 	} while (0)
 
+#define rv_mock_current(ctx, task) (ctx->curr = task)
+#define rv_mock_cpu(ctx, cpu) (ctx->cpu = cpu)
+
 #ifdef CONFIG_RV_MON_SCO
 extern void rv_test_sco(struct kunit *test);
 #else
-- 
2.53.0

