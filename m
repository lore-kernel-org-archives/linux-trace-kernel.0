Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4A372691
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303310; cv=none; b=BL214FooVen1M99av2Wg0735olpx/Kk5AZ5gasIzd+/NS35pua3JQnFOCIYdGFpFzTbW3cKN8JwZAh1XBn77N5Pewe7Pab69NrTzwiZVIKiFyrgGm4rm+DMxsFIizuc437vatWSfq2m6zfLgaYpT2qH/CNYBjv+K+rEMLDPYScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303310; c=relaxed/simple;
	bh=RbgjxZzRci4P23jN/e+i3HVh1EqY/cn9fsrxYHva6Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TBUraU5YuuagbonrnctHRmyCE3XaUIVAFIHp9RqL6Ql6OCdldI0YIpONGPyCjxX8VtjHPIFuuKthSi2I1lDNqNFjgtUW/rNDHxiLQhItNQwpqLiEDCfDpPuPf1tqQmkWqRzoajkIdetl1QSp4oLd6/2CDsbgodESOCoFvHmNhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJw99YD/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJw99YD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dabf22GIJ/35zUYoOAx5gme/Kxwkbp4WSYaZPLwriTs=;
	b=hJw99YD/zqmLIUhVkVeLrFAsxLUue0tjwmE6xSO7g1Ax8n55ex8ApKNgX++1JNBYLzzt0q
	YC8XMot3YbqtC6w6pyWSlP351XcZZNcrpErHJnjP3ZSyNddIeAW3iyWwYyP+2G9PFv4OC9
	lmlpLH0r8ikTRRCcwVujsePg2gqYrtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-OmfReWv1OHKB6BLMEn32Ig-1; Fri,
 17 Jul 2026 11:48:24 -0400
X-MC-Unique: OmfReWv1OHKB6BLMEn32Ig-1
X-Mimecast-MFC-AGG-ID: OmfReWv1OHKB6BLMEn32Ig_1784303303
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43570195D026;
	Fri, 17 Jul 2026 15:48:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3953C30040BF;
	Fri, 17 Jul 2026 15:48:19 +0000 (UTC)
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
Subject: [PATCH v4 14/17] rv: Add KUnit tests for some LTL monitors
Date: Fri, 17 Jul 2026 17:46:35 +0200
Message-ID: <20260717154638.220789-15-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: hbM8Q9dgMXrHF7fgChGdVEo-H7TvUA03RjYApYu3t7I_1784303303
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Validate the functionality of LTL monitors by injecting events in a
controlled environment (KUnit) and expecting reactions, just like it is
done in DA monitors.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ltl_monitor.h                      |  8 +++
 .../trace/rv/monitors/pagefault/pagefault.c   | 12 ++++
 .../rv/monitors/pagefault/pagefault_kunit.c   | 34 +++++++++++
 .../rv/monitors/pagefault/pagefault_kunit.h   | 24 ++++++++
 kernel/trace/rv/monitors/sleep/sleep.c        | 19 ++++++
 kernel/trace/rv/monitors/sleep/sleep_kunit.c  | 58 +++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep_kunit.h  | 30 ++++++++++
 kernel/trace/rv/rv_monitors_test.c            |  4 ++
 8 files changed, 189 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_kunit.h

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index d7dc01db4dd9..e9fd8265a3da 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -172,3 +172,11 @@ static void __maybe_unused ltl_atom_pulse(struct task_struct *task, enum ltl_ato
 	ltl_atom_set(mon, atom, !value);
 	ltl_validate(task, mon);
 }
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#define RV_MON_OPS_INIT() {               \
+	.rv_this = &rv_this,              \
+	.is_per_task = true,              \
+	.task_slot = &ltl_monitor_slot,   \
+}
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
index e52500fd2de0..c599fc19fc88 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -86,3 +86,15 @@ module_exit(unregister_pagefault);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("pagefault: Monitor that RT tasks do not raise page faults");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "pagefault_kunit.h"
+
+const struct rv_pagefault_ops rv_pagefault_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_page_fault = handle_page_fault,
+	.handle_task_newtask = handle_task_newtask,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_pagefault_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
new file mode 100644
index 000000000000..98ac7d4ec014
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include "pagefault_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_PAGEFAULT)
+
+static void rv_test_pagefault(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_pagefault_ops.mon);
+
+	/* Initial pagefault when non-RT to start the model without failure */
+	target->policy = SCHED_NORMAL;
+	target->prio = MAX_RT_PRIO + 20;
+	rv_pagefault_ops.handle_task_newtask(NULL, target, 0);
+	rv_mock_current(ctx, target);
+	rv_pagefault_ops.handle_page_fault(NULL, 0, NULL, 0);
+
+	/* RT task has a page fault */
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 1;
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_pagefault_ops.handle_page_fault(NULL, 0, NULL, 0);
+}
+
+#else
+#define rv_test_pagefault rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_kunit.h b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.h
new file mode 100644
index 000000000000..2f9652f08b3f
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __PAGEFAULT_KUNIT_H
+#define __PAGEFAULT_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_pagefault_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_page_fault)(void *data, unsigned long address, struct pt_regs *regs,
+			      unsigned long error_code);
+	void (*handle_task_newtask)(void *data, struct task_struct *task, u64 flags);
+} rv_pagefault_ops;
+#endif
+
+#endif /* __PAGEFAULT_KUNIT_H */
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index 71d2005ce520..f84a61a21825 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -247,3 +247,22 @@ module_exit(unregister_sleep);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably sleep");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "sleep_kunit.h"
+
+const struct rv_sleep_ops rv_sleep_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_sched_waking = handle_sched_waking,
+	.handle_sched_wakeup = handle_sched_wakeup,
+	.handle_sched_set_state = handle_sched_set_state,
+	.handle_contention_begin = handle_contention_begin,
+	.handle_contention_end = handle_contention_end,
+	.handle_kthread_stop = handle_kthread_stop,
+	.handle_sys_enter = handle_sys_enter,
+	.handle_sys_exit = handle_sys_exit,
+	.handle_task_newtask = handle_task_newtask,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_sleep_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/sleep/sleep_kunit.c b/kernel/trace/rv/monitors/sleep/sleep_kunit.c
new file mode 100644
index 000000000000..9bbe3822a76d
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep_kunit.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <uapi/linux/futex.h>
+#include "sleep_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_SLEEP)
+
+static void rv_test_sleep(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long args[6] = {0};
+	struct pt_regs regs = {0};
+
+	prepare_test(test, &rv_sleep_ops.mon);
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 2;
+	other->policy = SCHED_FIFO;
+	other->prio = MAX_RT_PRIO - 1;
+	rv_sleep_ops.handle_task_newtask(NULL, target, 0);
+
+	/* RT task sleeps on a non RT-friendly nanosleep */
+	rv_mock_current(ctx, target);
+	args[0] = CLOCK_REALTIME;
+	syscall_set_arguments(target, &regs, args);
+#ifdef __NR_clock_nanosleep
+	rv_sleep_ops.handle_sys_enter(NULL, &regs, __NR_clock_nanosleep);
+#elif defined(__NR_clock_nanosleep_time64)
+	rv_sleep_ops.handle_sys_enter(NULL, &regs, __NR_clock_nanosleep_time64);
+#endif
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sleep_ops.handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_sleep_ops.handle_sys_exit(NULL, NULL, 0);
+
+	/* RT task woken up by lower priority task */
+	args[1] = FUTEX_WAIT;
+	syscall_set_arguments(target, &regs, args);
+	rv_mock_current(ctx, target);
+#ifdef __NR_futex
+	rv_sleep_ops.handle_sys_enter(NULL, &regs, __NR_futex);
+#elif defined(__NR_futex_time64)
+	rv_sleep_ops.handle_sys_enter(NULL, &regs, __NR_futex_time64);
+#endif
+	rv_sleep_ops.handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_mock_current(ctx, other);
+	rv_sleep_ops.handle_sched_waking(NULL, target);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_sleep_ops.handle_sched_wakeup(NULL, target);
+}
+
+#else
+#define rv_test_sleep rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/sleep/sleep_kunit.h b/kernel/trace/rv/monitors/sleep/sleep_kunit.h
new file mode 100644
index 000000000000..2cd61e31a6af
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep_kunit.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __SLEEP_KUNIT_H
+#define __SLEEP_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_sleep_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_sched_waking)(void *data, struct task_struct *task);
+	void (*handle_sched_wakeup)(void *data, struct task_struct *task);
+	void (*handle_sched_set_state)(void *data, struct task_struct *task, int state);
+	void (*handle_contention_begin)(void *data, void *lock, unsigned int flags);
+	void (*handle_contention_end)(void *data, void *lock, int ret);
+	void (*handle_kthread_stop)(void *data, struct task_struct *task);
+	void (*handle_sys_enter)(void *data, struct pt_regs *regs, long id);
+	void (*handle_sys_exit)(void *data, struct pt_regs *regs, long ret);
+	void (*handle_task_newtask)(void *data, struct task_struct *task, u64 flags);
+} rv_sleep_ops;
+#endif
+
+#endif /* __SLEEP_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 2108973383b2..c565bca2b4ae 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -157,6 +157,8 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
+#include "monitors/pagefault/pagefault_kunit.c"
+#include "monitors/sleep/sleep_kunit.c"
 
 static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_dummy),
@@ -165,6 +167,8 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sts),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
+	KUNIT_CASE(rv_test_pagefault),
+	KUNIT_CASE(rv_test_sleep),
 	{}
 };
 
-- 
2.55.0

