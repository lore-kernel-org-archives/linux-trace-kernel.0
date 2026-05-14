Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B0426D0B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772151; cv=none; b=PiwpRmu9G2QZ711B2v03jQ0J6SEZyTHIt2XKJ6TdOQbjk9CscopcSLUxp4yTN3XbkxWJzbeToPPODR4o68lLhd7O4H1Kjc5ZKvD9XXWXsvvf0FMb0albIUdbCcE+ZNCEWGE9mv9Zu/2KiYhm59kvELQzx6JBhjZua+GtmOFB7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772151; c=relaxed/simple;
	bh=GZpCkzriGvjreliX2NExP+KurHWU6689xE4PmTd9NXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I+2yg39EZ1TTma3hDNoMWmkqCGPJdIPWI3f0X3dWsGRmGZSHdPIR+JGrwwV01+ICTxWntvV102l+nNW/ZalprriEWCmQksWotJ4x9SB//AX7Wfz8PT20m+dtVWbtyC8AbERM1eU481t0dKl9CnyCUMc/3kNEpaRQcwuZVV0QQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z++Uw0zU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z++Uw0zU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cChOR4WDN1ePG+G6GSE+5i1NpzN8hqKtv2EbJv0L3Rc=;
	b=Z++Uw0zUWNxmd8XPgAkRiMpmudIRufvOTQBMIeNON1hDmPNfYoNZei3vGZpiNzlUF8hwgC
	MG3qdBH4fJF7PrVz5J7VUeiWau8kT71bDJGptxJ9EWTLEUbasvxvUZwVJCAnxmVPuisgTp
	wf/UvbtvLENPPoqcwGk+DdrLrLrrB6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-_n2Jyx-rPz2LkDdsCx9dvw-1; Thu,
 14 May 2026 11:22:25 -0400
X-MC-Unique: _n2Jyx-rPz2LkDdsCx9dvw-1
X-Mimecast-MFC-AGG-ID: _n2Jyx-rPz2LkDdsCx9dvw_1778772143
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 977B41956089;
	Thu, 14 May 2026 15:22:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C7D230002DA;
	Thu, 14 May 2026 15:22:19 +0000 (UTC)
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
Subject: [PATCH v2 14/14] rv: Add KUnit tests for some LTL monitors
Date: Thu, 14 May 2026 17:20:55 +0200
Message-ID: <20260514152055.229162-15-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: G_-K-3Z8lQpuM9MJYPHtZ5_KGs13sA3EZ0OmIMKvkY8_1778772143
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Validate the functionality of LTL monitors by injecting events in a
controlled environment (KUnit) and expecting reactions, just like it is
done in DA monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ltl_monitor.h                      | 37 +++++++++++++
 .../trace/rv/monitors/pagefault/pagefault.c   | 25 +++++++++
 kernel/trace/rv/monitors/sleep/sleep.c        | 52 +++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |  4 ++
 4 files changed, 118 insertions(+)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 35bc870d808a..75c9c6230dae 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -172,3 +172,40 @@ static void __maybe_unused ltl_atom_pulse(struct task_struct *task, enum ltl_ato
 	ltl_atom_set(mon, atom, !value);
 	ltl_validate(task, mon);
 }
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+
+/*
+ * ltl_teardown_test - Disable the monitor for a kunit test
+ */
+static inline void ltl_teardown_test(void *arg)
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
+	ltl_monitor_destroy();
+}
+
+/*
+ * ltl_prepare_test - Enable the monitor for a kunit test
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
index 56abe5079676..28c3382eabb0 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -86,3 +86,28 @@ module_exit(unregister_pagefault);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("pagefault: Monitor that RT tasks do not raise page faults");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_pagefault(struct kunit *test);
+
+void rv_test_pagefault(struct kunit *test)
+{
+	struct task_struct *target;
+	struct rv_kunit_ctx *ctx = test->priv;
+
+	ltl_prepare_test(test, &rv_pagefault);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 1;
+	handle_task_newtask(NULL, target, 0);
+
+	ltl_attempt_start(target, ltl_get_monitor(target));
+
+	/* RT task has a page fault */
+	rv_mock_current(ctx, target);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_page_fault(NULL, 0, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(rv_test_pagefault);
+#endif
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index 8b44161d47d3..76e70e2db992 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -247,3 +247,55 @@ module_exit(unregister_sleep);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
 MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably sleep");
+
+#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
+void rv_test_sleep(struct kunit *test);
+
+void rv_test_sleep(struct kunit *test)
+{
+	struct task_struct *target, *other;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long args[6] = {0};
+	struct pt_regs regs;
+
+	ltl_prepare_test(test, &rv_sleep);
+	target = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	target->policy = SCHED_FIFO;
+	target->prio = MAX_RT_PRIO - 2;
+	other = kunit_kzalloc(test, sizeof(struct task_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+	other->policy = SCHED_FIFO;
+	other->prio = MAX_RT_PRIO - 1;
+	handle_task_newtask(NULL, target, 0);
+
+	/* RT task sleeps on a non RT-friendly nanosleep */
+	rv_mock_current(ctx, target);
+	args[0] = CLOCK_REALTIME;
+	syscall_set_arguments(target, &regs, args);
+#ifdef __NR_clock_nanosleep
+	handle_sys_enter(NULL, &regs, __NR_clock_nanosleep);
+#elif defined(__NR_clock_nanosleep_time64)
+	handle_sys_enter(NULL, &regs, __NR_clock_nanosleep_time64);
+#endif
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	handle_sys_exit(NULL, NULL, 0);
+
+	/* RT task woken up by lower priority task */
+	args[1] = FUTEX_WAIT;
+	syscall_set_arguments(target, &regs, args);
+	rv_mock_current(ctx, target);
+#ifdef __NR_futex
+	handle_sys_enter(NULL, &regs, __NR_futex);
+#elif defined(__NR_futex_time64)
+	handle_sys_enter(NULL, &regs, __NR_futex_time64);
+#endif
+	handle_sched_set_state(NULL, target, TASK_INTERRUPTIBLE);
+	rv_mock_current(ctx, other);
+	handle_sched_waking(NULL, target);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		handle_sched_wakeup(NULL, target);
+}
+EXPORT_SYMBOL_GPL(rv_test_sleep);
+#endif
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 01cbee9ac6c0..d3e3aa1ac4ec 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -137,6 +137,8 @@ DECLARE_RV_TEST(rv_test_sssw);
 DECLARE_RV_TEST(rv_test_sts);
 DECLARE_RV_TEST(rv_test_opid);
 DECLARE_RV_TEST(rv_test_nomiss);
+DECLARE_RV_TEST(rv_test_pagefault);
+DECLARE_RV_TEST(rv_test_sleep);
 
 static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sco),
@@ -144,6 +146,8 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sts),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
+	KUNIT_CASE(rv_test_pagefault),
+	KUNIT_CASE(rv_test_sleep),
 	{}
 };
 
-- 
2.54.0

