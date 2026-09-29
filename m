Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E4525A81
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686203; cv=none; b=HcDYm8vZnMbFlg2IRKPWZuxxMAP9UfsIRpsYvfxWXkTfMi5YWZWhzddMJVtAo6iFC33BMAWmnr3DyIif1bk0fdXhT9iLKLxmw/9IqF6v15MYnGHCtqdRlWaTi15bk6JVr/vy5/ir1s7NRgb0TkNZuroRwYMFUMaPBLn9HskIi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686203; c=relaxed/simple;
	bh=o94K6DQvj6NjP8OhOEUL4QnBD/VJPAgVpU1g5ikRzo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I3SRyf8T6ME5T0qO+n+zAjYFh0JEIERjwiMxqXML670vqLWKTkbJ8c8Qp7n0h1K6oBCumTNP7sQNhi2/thIF6gFreGiCV59+rGnJ/5XG6CAho4xHMMjdwLb18vR1GYkUGue4El5tDaawzwTMxss6aXDQJpP8uJ5KpSmbCqp+tkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHu35sbC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHu35sbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkk6DXsgsu3D8h6mSegN20FwJrC6ly34xOM3NBQTQH8=;
	b=UHu35sbCL/MHPtc0ACO59sCuR4zjxHVFBQTccRvWVz2GOm03pfFUxhNCKFUVzaMatmYs5O
	IDKh75R3P3Rxlufzy97vtDeUv8d6Gu2WIJHATWccuNca61VD2N/HC28mp7dPX7sU8i3K5r
	EscHMLG9+HFqa3R7uSDt+YH6QtKlBbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-l25gQQgSNAeWJdIiqgBMqw-1; Tue,
 29 Sep 2026 08:49:59 -0400
X-MC-Unique: l25gQQgSNAeWJdIiqgBMqw-1
X-Mimecast-MFC-AGG-ID: l25gQQgSNAeWJdIiqgBMqw_1790686197
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7E7E195423E;
	Tue, 29 Sep 2026 12:49:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B6A11956095;
	Tue, 29 Sep 2026 12:49:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 09/10] rv: Add KUnit test for throttle monitor
Date: Tue, 29 Sep 2026 14:49:07 +0200
Message-ID: <20260929124908.177676-10-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: U0N3KxH8ZUtCMxMsm37vZ7yaHxiwUt4rPXCsFAQL9fo_1790686197
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a test case for the throttle monitor to validate reactions occur
when a task:
 * gets throttled on time but switched back in without replenish
 * runs longer than its runtime

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/throttle/throttle.c  | 17 +++++++
 .../rv/monitors/throttle/throttle_kunit.c     | 44 +++++++++++++++++++
 .../rv/monitors/throttle/throttle_kunit.h     | 34 ++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |  2 +
 4 files changed, 97 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_kunit.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_kunit.h

diff --git a/kernel/trace/rv/monitors/throttle/throttle.c b/kernel/trace/rv/monitors/throttle/throttle.c
index b22a2abe59fe..2b181c46b7b6 100644
--- a/kernel/trace/rv/monitors/throttle/throttle.c
+++ b/kernel/trace/rv/monitors/throttle/throttle.c
@@ -283,3 +283,20 @@ module_exit(unregister_throttle);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
 MODULE_DESCRIPTION("throttle: throttle dl entities when they use up their runtime.");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "throttle_kunit.h"
+
+const struct rv_throttle_ops rv_throttle_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_dl_replenish = handle_dl_replenish,
+	.handle_dl_throttle = handle_dl_throttle,
+	.handle_sched_enqueue = handle_sched_enqueue,
+	.handle_sched_switch = handle_sched_switch,
+	.handle_sys_enter = handle_sys_enter,
+	.handle_newtask = handle_newtask,
+	.handle_dl_server_stop = handle_dl_server_stop,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_throttle_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/throttle/throttle_kunit.c b/kernel/trace/rv/monitors/throttle/throttle_kunit.c
new file mode 100644
index 000000000000..8194095dbab8
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle_kunit.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/rv.h>
+#include <rv/kunit.h>
+#include <trace/events/sched.h>
+#include "throttle_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_THROTTLE)
+
+static void rv_test_throttle(struct kunit *test)
+{
+	struct task_struct *target = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	prepare_test(test, &rv_throttle_ops.mon);
+
+	target->pid = 99;
+	target->policy = SCHED_DEADLINE;
+	target->dl.runtime = 10000;
+	target->dl.deadline = 20000;
+
+	rv_throttle_ops.handle_newtask(NULL, target, 0);
+
+	/* Task gets throttled on time but switched back in without replenish */
+	rv_throttle_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	rv_throttle_ops.handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
+	udelay(9);
+	rv_throttle_ops.handle_dl_throttle(NULL, &target->dl, 0, DL_TASK);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	rv_throttle_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+	/* Task runs longer than runtime */
+	rv_throttle_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
+	rv_throttle_ops.handle_dl_replenish(NULL, &target->dl, 0, DL_TASK);
+	udelay(10 + TICK_USEC);
+	rv_throttle_ops.handle_dl_throttle(NULL, &target->dl, 0, DL_TASK);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+
+#else
+#define rv_test_throttle rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/throttle/throttle_kunit.h b/kernel/trace/rv/monitors/throttle/throttle_kunit.h
new file mode 100644
index 000000000000..d730497deca4
--- /dev/null
+++ b/kernel/trace/rv/monitors/throttle/throttle_kunit.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Automatically generated by rvgen kunit.
+ * May need manual intervention for function prototypes that couldn't be
+ * found (e.g. are in another file) or variables to be exported.
+ */
+
+#ifndef __THROTTLE_KUNIT_H
+#define __THROTTLE_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_throttle_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_dl_replenish)(void *data, struct sched_dl_entity *dl_se,
+				int cpu, u8 type);
+	void (*handle_dl_throttle)(void *data, struct sched_dl_entity *dl_se,
+			       int cpu, u8 type);
+	void (*handle_sched_enqueue)(void *data, struct task_struct *tsk, int cpu);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state);
+	void (*handle_sys_enter)(void *data, struct pt_regs *regs, long id);
+	void (*handle_newtask)(void *data, struct task_struct *task, u64 flags);
+	void (*handle_dl_server_stop)(void *data, struct sched_dl_entity *dl_se,
+				  int cpu, u8 type);
+} rv_throttle_ops;
+#endif
+
+#endif /* __THROTTLE_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3ad11195e664..13af7e26205c 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -151,6 +151,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
+#include "monitors/throttle/throttle_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
 #include "monitors/sleep/sleep_kunit.c"
 
@@ -161,6 +162,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sts),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
+	KUNIT_CASE(rv_test_throttle),
 	KUNIT_CASE(rv_test_pagefault),
 	KUNIT_CASE(rv_test_sleep),
 	{}
-- 
2.55.0

