Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C763D6683
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302786; cv=none; b=dWx/cCvuCVjW2nDBx3nZw87nYIISDztcqcnBHFS1FpcSN1BPLm95QGSVH631L6mbhrWYyvlPBUSYvPHiVq8CFIKQZTrNqUr2Qb3VKojLOf8dgPuBgyIizt6MOxJqpwd437QNffZqcR5vf+p7nPR5/wqpiCRKH9xt4O6FtRMr63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302786; c=relaxed/simple;
	bh=rN3qRNw9cOspQwr/4vIiuMsbZhlrlkaNLivb13A+NKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Us/wcMYIsTlhu5CGsndLpQ8sVCrguQ+BIiB5q6wTKa5Qy0XNMOHcA8iYeO+PXhXh1NLSc/QFXwKzz3SWdSFmH5SyP1z4CnR04IACFTfU95jLNurfz7V/DJ6b7Z7sHSwuvtSZhOXsd6Rx5td2ah64KJnQRyGUqzlBkRxRQMXucwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHygoTx1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHygoTx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MGT5bt/FyhygSpKbLK2htxM7S+wZ3TuN0nSI7tYEyE=;
	b=EHygoTx1CMbBqahrFIOzm0qvWd5QnXOgzhO50H7uA3GCaZCfZ9inWt+HUAh+aOp9i1Io91
	7bXHZOXE7/UiBFanomlFfE/XIkhHQiDjsHhHUK2VKKdLs/RPvMbA5OagjXzXAiRE/85g4Y
	XJhOlP6AZ3EzP+cTdtTNodCj0g5rXJg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-3l_wa5DgOHyx_zqpD-3eUQ-1; Mon,
 27 Apr 2026 11:12:58 -0400
X-MC-Unique: 3l_wa5DgOHyx_zqpD-3eUQ-1
X-Mimecast-MFC-AGG-ID: 3l_wa5DgOHyx_zqpD-3eUQ_1777302777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1424E18005AA;
	Mon, 27 Apr 2026 15:12:57 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD6FF195608E;
	Mon, 27 Apr 2026 15:12:53 +0000 (UTC)
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
Subject: [RFC PATCH 12/12] rv: Add KUnit tests for some LTL monitors
Date: Mon, 27 Apr 2026 17:11:34 +0200
Message-ID: <20260427151134.192971-13-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: X3go5k5YkvkwloxQmyLeEi7rnXzxdww9kCYEYw9Vyn8_1777302777
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Validate the functionality of LTL monitors by injecting events in a
controlled environment (KUnit) and expecting reactions, just like it is
done in DA monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ltl_monitor.h                      | 31 ++++++++++++++
 .../trace/rv/monitors/pagefault/pagefault.c   | 24 +++++++++++
 kernel/trace/rv/monitors/sleep/sleep.c        | 42 +++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |  2 +
 kernel/trace/rv/rv_monitors_test.h            | 18 ++++++++
 5 files changed, 117 insertions(+)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 0f2c3820b9b8..49e680b769f6 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -172,3 +172,34 @@ static void __maybe_unused ltl_atom_pulse(struct task_struct *task, enum ltl_ato
 	ltl_atom_set(mon, atom, !value);
 	ltl_validate(task, mon);
 }
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include <kunit/test.h>
+
+/*
+ * rv_prepare_test - Disable the monitor for a kunit test
+ */
+static inline void ltl_teardown_test(void *arg)
+{
+	struct rv_monitor *rv_this = arg;
+
+	rv_this->enabled = 0;
+	ltl_monitor_destroy();
+}
+
+/*
+ * rv_prepare_test - Enable the monitor for a kunit test
+ *
+ * Do the bare minimum to set up the monitor, make sure it is not active and
+ * real tracepoint handlers are NOT attached.
+ */
+static inline void ltl_prepare_test(struct kunit *test, struct rv_monitor *rv_this)
+{
+	KUNIT_ASSERT_FALSE(test, rv_this->enabled);
+	ltl_monitor_init();
+	rv_this->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, ltl_teardown_test, rv_this));
+}
+#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
index 56abe5079676..1849d7b81545 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -86,3 +86,27 @@ module_exit(unregister_pagefault);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("pagefault: Monitor that RT tasks do not raise page faults");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_pagefault(struct kunit *test)
+{
+	static struct task_struct *target;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	ltl_prepare_test(test, &rv_pagefault);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 1;
+	handle_task_newtask(NULL, target, 0);
+
+	ltl_attempt_start(target, ltl_get_monitor(target));
+
+	/* RT task has a page fault */
+	rv_mock_current(ctx, target);
+	handle_page_fault(NULL, 0, NULL, 0);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_pagefault);
+#endif
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index 7c16967add70..9388ffb55aa9 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -247,3 +247,45 @@ module_exit(unregister_sleep);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably sleep");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+#include "rv_monitors_test.h"
+
+void rv_test_sleep(struct kunit *test)
+{
+	static struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long args[6];
+	struct pt_regs regs;
+
+	ltl_prepare_test(test, &rv_sleep);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 2;
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	other->policy = SCHED_FIFO;
+	other->prio = MAX_RT_PRIO - 1;
+	handle_task_newtask(NULL, target, 0);
+
+	/* RT task sleeps on a non RT-friendly nanosleep */
+	rv_mock_current(ctx, target);
+	args[0] = CLOCK_REALTIME;
+	syscall_set_arguments(target, &regs, args);
+	handle_sys_enter(NULL, &regs, __NR_clock_nanosleep);
+	handle_sys_exit(NULL, NULL, 0);
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+	/* RT task woken up by lower priority task */
+	args[1] = FUTEX_WAIT;
+	syscall_set_arguments(target, &regs, args);
+	rv_mock_current(ctx, target);
+	handle_sys_enter(NULL, &regs, __NR_futex);
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_mock_current(ctx, other);
+	handle_sched_waking(NULL, target);
+	handle_sched_wakeup(NULL, target);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+}
+EXPORT_SYMBOL_GPL(rv_test_sleep);
+#endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index a57a40932d34..78af77310d56 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -81,6 +81,8 @@ static struct kunit_case rv_trigger_test_cases[] = {
 	KUNIT_CASE(rv_test_sts),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
+	KUNIT_CASE(rv_test_pagefault),
+	KUNIT_CASE(rv_test_sleep),
 	{}
 };
 
diff --git a/kernel/trace/rv/rv_monitors_test.h b/kernel/trace/rv/rv_monitors_test.h
index 3015943c5dda..c745edc85991 100644
--- a/kernel/trace/rv/rv_monitors_test.h
+++ b/kernel/trace/rv/rv_monitors_test.h
@@ -70,3 +70,21 @@ static inline void rv_test_nomiss(struct kunit *test)
 	kunit_skip(test, "Monitor not enabled\n");
 }
 #endif
+
+#ifdef CONFIG_RV_MON_PAGEFAULT
+extern void rv_test_pagefault(struct kunit *test);
+#else
+static inline void rv_test_pagefault(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
+
+#ifdef CONFIG_RV_MON_SLEEP
+extern void rv_test_sleep(struct kunit *test);
+#else
+static inline void rv_test_sleep(struct kunit *test)
+{
+	kunit_skip(test, "Monitor not enabled\n");
+}
+#endif
-- 
2.53.0

