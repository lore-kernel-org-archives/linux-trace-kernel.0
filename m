Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645675;
	b=yA5QozOGjkNMUwJJGOLhHPFNIM7ynHxfy6gJ+FwnoQOB378oSA6p0wvP5Hk09XUCPDQS
	 bMcYhctHhFPWhh8qO2GF9BZGJ6w3VJ5usoUZgBV1HcsLEU91jJYFeFfceW/WDBgGlzc9M
	 bPJsyB7gjNy/OjTRULS7lL1o6w8DViKBuMQDDkym+ACQmM45UHxpeeMQiJC2XaY64mcCY
	 tw5o9PqNvv7kjyPAVl32q1Rs/ZUVm1uU2jfSDa5YBhgCRAxN3n9umlSVLK3kaPEtEr/8H
	 2tLTTalxm4fjpkqo54ZMfpSOLW4BSfAzN8EakIl7qDMqn92LuS4o2Zd1rr99DkKK9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EF/h0rMXJUnxDWL5NWwUz+wdD6IPIXWWrt9mBxieEP8=;
	b=Lh5rskkLztJaiK7G3q1UbwXydvL5ZjD7aVPOjUWWc74xEVI4S5/0v8qpqE/h7Jt0sURS
	 woY/+ipIrIjCp57qgXd8rwLPxPGb1B71GiArrLisRqOhDwfaH4N9f4+zX+7I5ulyfDNIb
	 pJ+QyAVc1vZ1AocetNAsZItxuQjZ1YSuio9A2+pRpdZLsDMEiPosMjiIXn8IT0Ikb6eVa
	 q1Y0BwCfWOu9I2cZLvpufECdqfTIr/VNgVR8gIm/yI89/035ImesfEvANLWzpPdM0OArS
	 rjEGjNw/zBmg4OLXcpFFBnwehXWbm656xkaA7mXVpdbH91zUxO2mOg2o2wE1CP2KWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fUf5/yVB";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66C606A31F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A66C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fUf5/yVB
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso12671145e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645673; x=1793250473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF/h0rMXJUnxDWL5NWwUz+wdD6IPIXWWrt9mBxieEP8=;
        b=fUf5/yVBlRJV//nxi0A7ZHTJS3JTdp72+gsNK6vGmlbHe5grZS2eqSXfB04KFqLc/1
         WTqWw7IhwB+3RnHY2sFhr8YOrKA/8phHHoCPfv/j5HVCuA/6dhtrLomG3/HaHv05p2qU
         8ti/vX0ICIc6Cm9lx/vUArRUWL9DyNp/vUEFQxIpmNbzh43w/WhSiiEhDkXeFwvSN1kh
         ErphMk3pH2ruUzhNh4wC5wdJ4o9SAWUJyIszzOpQYwUfGKsD8+r+OTtnLtDRdE8m9IlA
         QNSvSvezqUi9O5jWKMUIKM/MQQQyqlhlj/1jZfOYY0k714nnRZNvlf8sb9rIbZ8c5BU3
         ej6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645673; x=1793250473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF/h0rMXJUnxDWL5NWwUz+wdD6IPIXWWrt9mBxieEP8=;
        b=nWQLcrGX7Fzc3DZysQOrMbS5sHK+RHEOcjgMwWIsujzF6xHBSntApYoB3cX4tY2ZjM
         TDtaYxg4Eu4jDDopdkmuDCkM/XgZkEjU3qZxWpHlO4yd/rXaK/EuCnQ6myEljfEgAne/
         CBXslHCyMGjk0LhN33iZrdhTk/GMMj37dst58zUr098gzuQuRy0pstG4n5EDRR2Rowv3
         ALH0s8cSFFG2JQ9ymcpQkbNqQbNgSTVQo0PnW1J9Uk9gbfKS8ztfvsYgTFdC5Bkr2noR
         0OTsFW1afU7Es7XR0scuyHyLX+tNXYRg2xvP7j9JSmnYq89w5Rs8wMWo5sSnfXb5h7yX
         R+AA==
X-Forwarded-Encrypted: i=1; AKwUvByq5jQOaxrCmWPigSYEduLIpsIDiJGHYGSYDzQ3yYrO7CrOUZ096aFGsC5TIG3GmQ2rA3KBp2dBs+5G60lqTCCiWuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBQyINZ8sdFgNalQA+IlZR8KS6AoBPmSFsVVwWWW0M5UJdd7Ef
	1BjTx391f/Plm0O4SQBbvOj500yntHqS5ehe46fNQK3T6vB67YdxG6bo
X-Gm-Gg: AYBFou1xcgkad+J8m1EDLWGM6iAcAGHBfM4rvv+Piz4dxdlXgVSbDxl5FBdDiq4CEmc
	4Vth0KZqX3Cdft3cooSinTLobPhPfMWOu603MkjBCqNGBVaNjbrcLH1RWXqWywMpIHIiKzvrf+W
	WYOy47x8qHPpsfq9pEvN8qUg+9OE99P4oYOYpqHOe1RfzOW0zoR/ERgmv7h/V0e95ZYdphFqCaq
	ujYuiMpiqZ+W8ELAdTds0SHkfBJDPR+rU4EVbYAmbv7S2QdojSJIi+p5yz4os9jScBsK+069H/I
	0TLklVrRIXLV2Q9tr9zaTl4Z7H1p7XGAlsojSsRbs4a5Rj0NheireA18a/D0MHb9j3D2nOqGlc4
	j85MHqVPUw/yelUiHSiSJ3uyeaxtG8JiPfFCdSk/0PWRspXI0gG7nlLjmRzugAouaN1mPfIcZJz
	hlNUw2bjm5T0QLk54YdZCGE304d489Be0vJIOHXJX7D4sf8anStaCbl9wqQqsJIa9/mBMfZMFgn
	tZENDvBXNVV6rrJR5g1+TQYG9zsbRFrL7cTd/nzHc4+xq+9k3BaM/oYiVoMlRxZbB1Fx4mVI283
	r8cCFJGpllKIi9oX2wAeFGL20KUQDRdDty3pQ+mwhMSq5ngnd680UFqZOPyv1n48V6WpJ27tpdP
	IqhwREkq2ieaFX6ZbVU09gi/K8Ggg1q/uT15ldGfbq8SoaJXHmdG0sIdiCxpA
X-Received: by 2002:a05:600d:19:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4a1fdd40492mr63435395e9.33.1792645672547;
        Wed, 21 Oct 2026 22:07:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:51 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/9] rv: Add KUnit coverage for IRQ-exit scheduling
Date: Thu, 22 Oct 2026 07:07:10 +0200
Message-Id: <20261022050712.75035-8-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit coverage for the irqexit generated state table, invalid
transitions, and enable-time synchronization. Test live
preempt_schedule_irq() invocations without switching, across a task switch,
and across CPU migration. The migration case runs when another CPU is
available. The live cases require the built-in suite because they invoke a
non-exported helper.

KUnit failure reporting may allocate with GFP_KERNEL. Record reaction
counts inside synthetic IRQ-disabled and hardirq intervals. Evaluate the
expectations after restoring normal task context to avoid secondary
atomic-sleep or lockdep diagnostics.

The live tests invoke the generic helper directly. They do not exercise
an architecture-specific physical interrupt-return path.

Assisted-by: LLM
---
 Documentation/trace/rv/monitor_irqentry.rst   |  21 +
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  13 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c | 537 ++++++++++++++++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |  21 +
 kernel/trace/rv/rv_monitors_test.c            |  13 +
 5 files changed, 605 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h

diff --git a/Documentation/trace/rv/monitor_irqentry.rst b/Documentation/trace/rv/monitor_irqentry.rst
index ba9e78e7c4a08..f4cd34c1b6bf1 100644
--- a/Documentation/trace/rv/monitor_irqentry.rst
+++ b/Documentation/trace/rv/monitor_irqentry.rst
@@ -292,6 +292,27 @@ boundary probes require exactly one entry before the callback and one exit
 afterward, both with local interrupts disabled and live serving state set;
 the monitor must accept the pair and the original counts must be restored.
 
+With built-in RV KUnit tests, ``rv_test_irqexit_live`` enters the real
+``preempt_schedule_irq()`` helper with and without a task switch on one CPU.
+``rv_test_irqexit_migrate`` instead wakes a same-CPU FIFO worker which moves
+the switched-out owner to a different allowed online CPU. The test requires
+accepted entry and suspension on the source CPU and resumption and return
+on the destination. It also samples the CPU on which the helper actually
+returned, independently of the RV observer, and checks restoration of the
+owner's original affinity before the tested task exits.
+
+The two live helper cases use single-element parameter fixtures. Monitor
+slot allocation and destruction, and CPU-hotplug read locking, run in the
+suite runner, which owns the RV interface mutex. The case body and its
+cleanup can run in different KUnit threads. The tests retain a task
+reference until the observer and worker are stopped; the migration case
+checks restoration of the tested task's affinity before that task exits.
+
+The migration case skips when fewer than two allowed CPUs are online, or
+when the tests are modules: the helper is not exported. These tests exercise
+the real helper and scheduler, but invoke the helper directly. They are not
+evidence of an architecture's physical interrupt-return assembly path.
+
 Coverage limits
 ---------------
 
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
index a088b28b62b17..baee718dbe83c 100644
--- a/kernel/trace/rv/monitors/irqexit/irqexit.c
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.c
@@ -157,3 +157,16 @@ module_exit(unregister_irqexit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
 MODULE_DESCRIPTION("irqexit: verify IRQ-exit scheduling ownership");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "irqexit_kunit.h"
+
+const struct rv_irqexit_ops rv_irqexit_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_resched_entry = handle_resched_entry,
+	.handle_resched_exit = handle_resched_exit,
+	.handle_sched_switch = handle_sched_switch,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_irqexit_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
new file mode 100644
index 0000000000000..56a9442e2f704
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/hardirq.h>
+#include <linux/irqflags.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/rv.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <rv/kunit.h>
+#include <rv_trace.h>
+#include <trace/events/sched.h>
+
+#include "irqexit_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_IRQEXIT)
+
+static void irqexit_test_switch(struct task_struct *prev, struct task_struct *next)
+{
+	rv_mock_current(prev);
+	rv_irqexit_ops.handle_sched_switch(NULL, true, prev, next, TASK_RUNNING);
+	rv_mock_current(next);
+}
+
+static void rv_test_irqexit(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	local_irq_save(flags);
+	/* The scheduling loop may return without an actual task switch. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+
+	/* A different task's IRQ-exit loop cannot complete owner's loop. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	__irq_enter_raw();
+	__irq_exit_raw();
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	irqexit_test_switch(other, owner);
+
+	/* Both tasks can have suspended invocations at the same time. */
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	observed = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed, 0);
+}
+
+static void rv_test_irqexit_invalid(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed[14];
+	unsigned int i = 0;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	KUNIT_ASSERT_FALSE(test, irqs_disabled());
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_entry(NULL, owner);
+
+	local_irq_save(flags);
+	/* Scheduling must not start before the hardirq count is removed. */
+	__irq_enter_raw();
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+
+	/* A return with hardirq state still active is invalid as well. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	__irq_enter_raw();
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* The first exit synchronizes; the second unmatched exit must fail. */
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* The state permits exit, but its task identity must still agree. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_mock_current(other);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* Matching current is insufficient if the invocation is suspended. */
+	rv_mock_current(owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_mock_current(owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	local_irq_restore(flags);
+	for (i = 0; i < ARRAY_SIZE(observed); i += 2) {
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed[i], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed[i + 1], 1);
+	}
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_exit(NULL, owner);
+
+	/* Even an unsynchronized bad return must not be silently skipped. */
+	rv_mock_current(other);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_exit(NULL, owner);
+}
+
+static void rv_test_irqexit_sync(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	local_irq_save(flags);
+	/* Switch events alone do not synchronize an already active loop. */
+	irqexit_test_switch(owner, other);
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+
+	/* Model disable/reset/re-enable while that invocation is suspended. */
+	rv_irqexit_ops.mon.rv_this->enabled = 0;
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	rv_irqexit_ops.mon.task_reset(owner);
+	rv_irqexit_ops.mon.task_reset(other);
+	rv_irqexit_ops.mon.rv_this->enabled = 1;
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed, 0);
+}
+
+#ifndef MODULE
+struct irqexit_live_ctx {
+	struct task_struct *owner;
+	struct task_struct *worker;
+	const char *skip_reason;
+	struct completion worker_done;
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int switches_out;
+	unsigned int switches_in;
+	unsigned int entry_cpu;
+	unsigned int exit_cpu;
+	unsigned int switch_out_cpu;
+	unsigned int switch_in_cpu;
+	unsigned int target_cpu;
+	unsigned int raw_entries;
+	unsigned int raw_exits;
+	unsigned int bad_raw_context;
+	int affinity_result;
+	cpumask_t saved_mask;
+	cpumask_t test_mask;
+	bool migrate;
+	bool affinity_changed;
+	bool observer_attached;
+	bool raw_entry_attached;
+	bool raw_exit_attached;
+	bool hotplug_disabled;
+};
+
+/* Parent fixtures run in the suite runner, which owns rv_interface_lock. */
+static int irqexit_live_fixture_init(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct irqexit_live_ctx *live;
+	int ret;
+
+	if (mon->enabled)
+		return -EBUSY;
+	live = kunit_kzalloc(test, sizeof(*live), GFP_KERNEL);
+	if (!live)
+		return -ENOMEM;
+
+	/* Keep the online mask stable without nesting tracepoint registration. */
+	cpu_hotplug_disable();
+	live->hotplug_disabled = true;
+	ret = mon->enable();
+	if (ret) {
+		cpu_hotplug_enable();
+		live->hotplug_disabled = false;
+		kunit_kfree(test, live);
+		return ret;
+	}
+	kunit_register_params_array(test, live, 1, NULL);
+	return 0;
+}
+
+static void irqexit_live_fixture_exit(struct kunit *test)
+{
+	struct irqexit_live_ctx *live = (void *)test->params_array.params;
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+
+	mon->enabled = 0;
+	mon->disable();
+	if (live->hotplug_disabled) {
+		cpu_hotplug_enable();
+		live->hotplug_disabled = false;
+	}
+	/* Retain the child's explicit skip reason on the parent case. */
+	if (live->skip_reason)
+		kunit_mark_skipped(test, "%s", live->skip_reason);
+}
+
+static int irqexit_live_worker(void *data)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (live->migrate)
+		live->affinity_result =
+			set_cpus_allowed_ptr(live->owner, cpumask_of(live->target_cpu));
+	complete(&live->worker_done);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!kthread_should_stop())
+			schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void irqexit_observe_event(void *data, int id, char *state,
+				  char *event, char *next_state, bool final_state)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (id != live->owner->pid)
+		return;
+	if (!strcmp(event, "resched_entry")) {
+		live->entry_cpu = raw_smp_processor_id();
+		live->entries++;
+	} else if (!strcmp(event, "resched_exit")) {
+		live->exit_cpu = raw_smp_processor_id();
+		live->exits++;
+	} else if (!strcmp(event, "switch_out") && !strcmp(state, "rescheduling")) {
+		if (!live->switches_out)
+			live->switch_out_cpu = raw_smp_processor_id();
+		live->switches_out++;
+	} else if (!strcmp(event, "switch_in") && !strcmp(state, "suspended")) {
+		if (!live->switches_in)
+			live->switch_in_cpu = raw_smp_processor_id();
+		live->switches_in++;
+	}
+}
+
+static void irqexit_observe_entry(void *data, struct task_struct *owner,
+				  unsigned long pc, bool irq_off)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (owner != live->owner)
+		return;
+	live->raw_entries++;
+	if (pc || !irq_off)
+		live->bad_raw_context++;
+}
+
+static void irqexit_observe_exit(void *data, struct task_struct *owner,
+				 unsigned long pc, bool irq_off)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (owner != live->owner)
+		return;
+	live->raw_exits++;
+	if (pc || !irq_off)
+		live->bad_raw_context++;
+}
+
+static int irqexit_observe_boundaries(struct irqexit_live_ctx *live)
+{
+	int ret;
+
+	ret = register_trace_sched_irq_preempt_entry(irqexit_observe_entry, live);
+	if (ret)
+		return ret;
+	live->raw_entry_attached = true;
+	ret = register_trace_sched_irq_preempt_exit(irqexit_observe_exit, live);
+	if (!ret)
+		live->raw_exit_attached = true;
+	return ret;
+}
+
+static void irqexit_live_cleanup(void *data)
+{
+	struct irqexit_live_ctx *live = data;
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+
+	mon->enabled = 0;
+	if (live->observer_attached)
+		unregister_trace_event_irqexit(irqexit_observe_event, live);
+	if (live->raw_entry_attached)
+		unregister_trace_sched_irq_preempt_entry(irqexit_observe_entry, live);
+	if (live->raw_exit_attached)
+		unregister_trace_sched_irq_preempt_exit(irqexit_observe_exit, live);
+	tracepoint_synchronize_unregister();
+	if (live->worker)
+		kthread_stop(live->worker);
+	if (live->affinity_changed && !(READ_ONCE(live->owner->flags) & PF_EXITING))
+		KUNIT_EXPECT_EQ(kunit_get_current_test(),
+				set_cpus_allowed_ptr(live->owner, &live->saved_mask), 0);
+	put_task_struct(live->owner);
+	live->owner = NULL;
+
+	RV_KUNIT_EXPECT_NO_REACTION(kunit_get_current_test(), active_ctx);
+	mon->react = mon->reactor ? mon->reactor->react : NULL;
+	active_ctx = NULL;
+	rv_mock_current(NULL);
+}
+
+static void rv_test_irqexit_live(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqexit_live_ctx *live = (void *)test->param_value;
+	struct task_struct *worker;
+	unsigned int entries, exits, switches_out, switches_in;
+	unsigned int first_entries, first_switches;
+	unsigned long flags;
+	bool worker_done;
+
+	KUNIT_ASSERT_FALSE(test, mon->enabled);
+	live->owner = current;
+	get_task_struct(live->owner);
+	init_completion(&live->worker_done);
+
+	active_ctx = ctx;
+	mon->react = rv_kunit_mock_react;
+	rv_mock_current(NULL);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqexit_live_cleanup, live));
+	/* The worker must run on this CPU inside the explicit scheduling loop. */
+	guard(migrate)();
+	worker = kthread_create(irqexit_live_worker, live, "rv-irqexit-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	live->worker = worker;
+	kthread_bind(worker, smp_processor_id());
+	sched_set_fifo(worker);
+	KUNIT_ASSERT_EQ(test, 0,
+			register_trace_event_irqexit(irqexit_observe_event, live));
+	live->observer_attached = true;
+	KUNIT_ASSERT_EQ(test, irqexit_observe_boundaries(live), 0);
+
+	mon->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, preempt_count(), 0);
+	local_irq_save(flags);
+	preempt_schedule_irq();
+	first_entries = live->entries;
+	first_switches = live->switches_out;
+	wake_up_process(worker);
+	preempt_schedule_irq();
+	entries = live->entries;
+	exits = live->exits;
+	switches_out = live->switches_out;
+	switches_in = live->switches_in;
+	worker_done = completion_done(&live->worker_done);
+	local_irq_restore(flags);
+
+	/* Accepted model events prove that the real boundary probes ran. */
+	KUNIT_EXPECT_GT(test, entries, 0);
+	KUNIT_EXPECT_GT(test, first_entries, 0);
+	KUNIT_EXPECT_GT(test, entries, first_entries);
+	KUNIT_EXPECT_EQ(test, entries, exits);
+	KUNIT_EXPECT_EQ(test, switches_out, switches_in);
+	KUNIT_EXPECT_GT(test, switches_out, first_switches);
+	KUNIT_EXPECT_TRUE(test, worker_done);
+	KUNIT_EXPECT_GE(test, live->raw_entries, 2U);
+	KUNIT_EXPECT_GE(test, live->raw_exits, 2U);
+	KUNIT_EXPECT_EQ(test, live->bad_raw_context, 0U);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test, "live IRQ-exit entries=%u exits=%u switches=%u\n",
+		   entries, exits, switches_out);
+	mon->enabled = 0;
+}
+
+static void rv_test_irqexit_migrate(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqexit_live_ctx *live = (void *)test->param_value;
+	struct task_struct *worker;
+	unsigned int source_cpu, resumed_cpu;
+	unsigned long flags;
+	bool affinity_restored;
+	int restore_result;
+
+	KUNIT_ASSERT_FALSE(test, mon->enabled);
+	live->owner = current;
+	get_task_struct(live->owner);
+	init_completion(&live->worker_done);
+	active_ctx = ctx;
+	mon->react = rv_kunit_mock_react;
+	rv_mock_current(NULL);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqexit_live_cleanup, live));
+	if (num_online_cpus() < 2) {
+		live->skip_reason = "Requires two online CPUs";
+		kunit_skip(test, "%s", live->skip_reason);
+		return;
+	}
+	cpumask_copy(&live->saved_mask, current->cpus_ptr);
+	cpumask_and(&live->test_mask, &live->saved_mask, cpu_online_mask);
+	if (cpumask_weight(&live->test_mask) < 2) {
+		live->skip_reason = "Requires two allowed online CPUs";
+		kunit_skip(test, "%s", live->skip_reason);
+		return;
+	}
+	source_cpu = cpumask_first(&live->test_mask);
+	live->target_cpu = cpumask_any_but(&live->test_mask, source_cpu);
+	KUNIT_ASSERT_EQ(test, set_cpus_allowed_ptr(current, cpumask_of(source_cpu)), 0);
+	live->affinity_changed = true;
+	live->migrate = true;
+	worker = kthread_create(irqexit_live_worker, live, "rv-irqexit-mig");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	live->worker = worker;
+	kthread_bind(worker, source_cpu);
+	sched_set_fifo(worker);
+	KUNIT_ASSERT_EQ(test, 0,
+			register_trace_event_irqexit(irqexit_observe_event, live));
+	live->observer_attached = true;
+	KUNIT_ASSERT_EQ(test, irqexit_observe_boundaries(live), 0);
+	mon->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, preempt_count(), 0);
+	local_irq_save(flags);
+	live->entries = 0;
+	live->exits = 0;
+	live->switches_out = 0;
+	live->switches_in = 0;
+	/*
+	 * The FIFO worker runs only after this task switches out inside the
+	 * real helper. It moves the queued, non-running owner to another CPU.
+	 * Do not migration-disable the owner: migration is the property tested.
+	 */
+	wake_up_process(worker);
+	preempt_schedule_irq();
+	resumed_cpu = raw_smp_processor_id();
+	mon->enabled = 0;
+	local_irq_restore(flags);
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&live->worker_done, 5 * HZ), 0UL);
+	KUNIT_EXPECT_EQ(test, live->affinity_result, 0);
+	KUNIT_EXPECT_EQ(test, live->entries, 1U);
+	KUNIT_EXPECT_EQ(test, live->exits, 1U);
+	KUNIT_EXPECT_GT(test, live->switches_out, 0U);
+	KUNIT_EXPECT_EQ(test, live->switches_out, live->switches_in);
+	KUNIT_EXPECT_EQ(test, live->entry_cpu, source_cpu);
+	KUNIT_EXPECT_EQ(test, live->switch_out_cpu, source_cpu);
+	KUNIT_EXPECT_EQ(test, live->switch_in_cpu, live->target_cpu);
+	KUNIT_EXPECT_EQ(test, live->exit_cpu, live->target_cpu);
+	/* Check actual resumed execution independently of the RV observer. */
+	KUNIT_EXPECT_EQ(test, resumed_cpu, live->target_cpu);
+	KUNIT_EXPECT_GT(test, live->raw_entries, 0U);
+	KUNIT_EXPECT_GT(test, live->raw_exits, 0U);
+	KUNIT_EXPECT_EQ(test, live->bad_raw_context, 0U);
+	restore_result = set_cpus_allowed_ptr(current, &live->saved_mask);
+	KUNIT_EXPECT_EQ(test, restore_result, 0);
+	affinity_restored = !restore_result &&
+		cpumask_equal(current->cpus_ptr, &live->saved_mask);
+	KUNIT_EXPECT_TRUE(test, affinity_restored);
+	if (affinity_restored)
+		live->affinity_changed = false;
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test, "live IRQ-exit migration cpu=%u->%u actual=%u entries=%u exits=%u switches=%u\n",
+		   live->entry_cpu, live->exit_cpu, resumed_cpu, live->entries, live->exits,
+		   live->switches_out);
+	kunit_info(test, "live IRQ-exit affinity restored=%u\n", affinity_restored);
+}
+#else
+static void rv_test_irqexit_live(struct kunit *test)
+{
+	/* preempt_schedule_irq() is deliberately not exported to modules. */
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqexit_migrate(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+#endif
+
+#else
+#define rv_test_irqexit rv_test_stub
+#define rv_test_irqexit_invalid rv_test_stub
+#define rv_test_irqexit_sync rv_test_stub
+#define rv_test_irqexit_live rv_test_stub
+#define rv_test_irqexit_migrate rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
new file mode 100644
index 0000000000000..b475388455c2a
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __IRQEXIT_KUNIT_H
+#define __IRQEXIT_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_irqexit_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_resched_entry)(void *data, struct task_struct *owner);
+	void (*handle_resched_exit)(void *data, struct task_struct *owner);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				    struct task_struct *prev,
+				    struct task_struct *next,
+				    unsigned int prev_state);
+} rv_irqexit_ops;
+#endif
+
+#endif /* __IRQEXIT_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 4fb611a9f8b85..9eb37cbd2de22 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -150,6 +150,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sssw/sssw_kunit.c"
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/irqstate/irqstate_kunit.c"
+#include "monitors/irqexit/irqexit_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
@@ -171,6 +172,18 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_preempt),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_irq),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_switch),
+	KUNIT_CASE(rv_test_irqexit),
+	KUNIT_CASE(rv_test_irqexit_invalid),
+	KUNIT_CASE(rv_test_irqexit_sync),
+#if IS_REACHABLE(CONFIG_RV_MON_IRQEXIT) && !defined(MODULE)
+	KUNIT_CASE_PARAM_WITH_INIT(rv_test_irqexit_live, kunit_array_gen_params,
+				   irqexit_live_fixture_init, irqexit_live_fixture_exit),
+	KUNIT_CASE_PARAM_WITH_INIT(rv_test_irqexit_migrate, kunit_array_gen_params,
+				   irqexit_live_fixture_init, irqexit_live_fixture_exit),
+#else
+	KUNIT_CASE(rv_test_irqexit_live),
+	KUNIT_CASE(rv_test_irqexit_migrate),
+#endif
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
 	KUNIT_CASE(rv_test_pagefault),
-- 
2.39.5 (Apple Git-154)

