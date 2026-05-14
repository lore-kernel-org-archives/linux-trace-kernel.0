Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5974279F6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772146; cv=none; b=TJF3AJGeDdaJoxLvveZwbUKLUCBskPVAA1zXwEoibpGT0xlKef2W9EwLfAcCldsKmFZO2AJFk0bNJ3qxGNTWj/8jqz/xNDzCGAanzwtAGFp8OOZxgoZ858Xm7kZZ7FtNpYVTTR1jP8U3PRg2lmwtzHNhwLIzhecPmgCw1e6rN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772146; c=relaxed/simple;
	bh=rIR3orqeq30/B2cWeDokb1/lUwP3UL81WE4O8yn1hrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Lygx2oH5Nqaahzi8tT2+E+yS917fGsh0fkIle1t/Khy310vvi9KcXDGHlE5DJd6bJCII5R1XaAgum0RXNvjIwS48o1B6bpEO+m/tb+oCNhZSRlnNp3XPytQTvB5L2Rthl3qUtMRpi5F77TcUQyM9TJODQgM6kSJQm5jCxajJSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Shz/eazU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Shz/eazU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQ1EmTIT9OQO80HWrb/E3MPx3//XTk3Mk07UYKCdZFQ=;
	b=Shz/eazUn6ssicqOn/Hjvs2UhbixloLJJrSTcsbgwWM9KgFbE4EKy8RoWxB2dxxtRPqpGi
	rkBDynWMy/LByWU8uJCFkXG3M6aKFJJ1WpZ4ZWJYcGxmMXmvRO27zLmDX6xFmMQVLJPayF
	nF46lCD6W23A0pR6WhfWdemlTc43BoI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-JyoqaI7MNCWoP3JMxS8RDA-1; Thu,
 14 May 2026 11:22:20 -0400
X-MC-Unique: JyoqaI7MNCWoP3JMxS8RDA-1
X-Mimecast-MFC-AGG-ID: JyoqaI7MNCWoP3JMxS8RDA_1778772134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1151218002F0;
	Thu, 14 May 2026 15:22:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BB9730002DA;
	Thu, 14 May 2026 15:22:09 +0000 (UTC)
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
Subject: [PATCH v2 12/14] rv: Add KUnit stubs for current and smp_processor_id()
Date: Thu, 14 May 2026 17:20:53 +0200
Message-ID: <20260514152055.229162-13-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 3i6-Tl6yt5R2B4A_G60LkiUAcwiT626TpGtbH9smV4w_1778772134
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
 include/rv/kunit.h                            | 18 ++++++++++++-
 include/rv/ltl_monitor.h                      |  1 +
 kernel/trace/rv/Kconfig                       |  3 +++
 .../trace/rv/monitors/pagefault/pagefault.c   |  2 +-
 kernel/trace/rv/monitors/sleep/sleep.c        | 24 ++++++++---------
 kernel/trace/rv/rv_monitors_test.c            | 26 +++++++++++++++++++
 6 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/rv/kunit.h b/include/rv/kunit.h
index 67f6057bd5b1..3ef83d337880 100644
--- a/include/rv/kunit.h
+++ b/include/rv/kunit.h
@@ -2,7 +2,10 @@
 /*
  * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
  *
- * Declaration of utilities to run KUnit tests.
+ * Declaration of wrappers to allow stubbing core functionality, like current
+ * and smp_processor_id(), and other testing utilities.
+ * Necessary only when mocking may be needed. If the RV KUnit test is
+ * enabled, the wrappers incur an additional function call overhead.
  */
 
 #ifndef _RV_KUNIT_H
@@ -14,8 +17,13 @@
 #include <kunit/test-bug.h>
 #include <linux/delay.h>
 
+struct task_struct *rv_get_current(void);
+int rv_current_cpu(void);
+
 struct rv_kunit_ctx {
 	int reactions, expected;
+	int cpu;
+	struct task_struct *curr;
 };
 
 #define RV_KUNIT_EXPECT_REACTION(test, ctx)                             \
@@ -37,5 +45,13 @@ struct rv_kunit_ctx {
 	     !__done;                                                        \
 	     __done = ({ RV_KUNIT_EXPECT_REACTION(test, ctx); 1; }))
 
+#define rv_mock_current(ctx, task) (ctx->curr = task)
+#define rv_mock_cpu(ctx, cpu) (ctx->cpu = cpu)
+
+#else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
+
+#define rv_get_current() current
+#define rv_current_cpu() smp_processor_id()
+
 #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
 #endif /* _RV_KUNIT_H */
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index eff60cd61106..35bc870d808a 100644
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
index d7dba4453bd3..702349e1ddd4 100644
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
index 8dfe5ec13e19..8b44161d47d3 100644
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
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 5a12a109c1ed..3dbe562f00c1 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -31,6 +31,30 @@ static void stub_rv_put_task_monitor_slot(int slot)
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
+	return ctx->curr ?: current;
+}
+static int stub_rv_current_cpu(void)
+{
+	struct rv_kunit_ctx *ctx = kunit_get_current_test()->priv;
+
+	return ctx->cpu;
+}
+
 static int rv_mon_test_init(struct kunit *test)
 {
 	struct rv_kunit_ctx *ctx;
@@ -49,6 +73,8 @@ static int rv_mon_test_init(struct kunit *test)
 				   stub_rv_get_task_monitor_slot);
 	kunit_activate_static_stub(test, rv_put_task_monitor_slot,
 				   stub_rv_put_task_monitor_slot);
+	kunit_activate_static_stub(test, rv_get_current, stub_rv_get_current);
+	kunit_activate_static_stub(test, rv_current_cpu, stub_rv_current_cpu);
 
 	return 0;
 }
-- 
2.54.0

