Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071604;
	b=XCp4qKaxwIHBkF50Ff58lEfM8+wFOjp5zDd1VNeqQ90R+iocxS6xk4TZLKA4JHZQdMsl
	 tLwxeUxouKb+uYFktn7I6MwOT79xThC7a7a6G7npPSzShBebXcTjKKEAhoeqGxzgucD/I
	 Wc63d1Mw3MXdjE5hJmIWRG7lmnHKp8WFZ8P5L2xDVvKvCXsco8LyD0rD2T2NJiagVtdAy
	 nxmbo9QrPTnxqjw9jy9zeaAwShImmb/WMNljbRUe9FTNXYbEK0CfMFsrsKXyaCqpbLDW+
	 OcTmbYLwMkFZTckAiqsntah+uqU8ludiHxT5ELFCiBSK6qmXO129ULFfEa4kFcdCiWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
	b=KX4lCAjZ1T7Cw/O5QdYxylSnUQ9jvDyT7zTNunvi8Uk9xDOuXs+DgdPwNl9XOLDzu3zr
	 AyCJbzbsGEU+/hOhOFHnzBcrCiZdaNBageAE5VOTHfsE0ZQRLXTYFcpqs5TUvuWCHWYx1
	 kCoihHQfEFai8UqbNldHa5S6rbr0pSoqjc8TLoJO26+Oupysd/BsbIeQbLwiEQtU2Z/zc
	 POocnptJ+XwsEt37RXdirAgOiG1FIbK7QkDWwnThCUCXQhASqdP/hy5G2gvrC5AFmzzuJ
	 HxAYm6ON9XmXgDihRjEscq22v4xwTuTBbzTdNWgP6Wksmbu8eQnPJCkUL2aEPItHbNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzGzDOl3;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D26082BFC
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399D26082BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzGzDOl3
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so11235625e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071602; x=1794676402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
        b=EzGzDOl3dlSFoPmiY21q4Mjp4OYJVPSVKNluTFI2oJFPX5AQDbBJjvcb94S8lwkNJj
         k7x+A/VDfKKoLUqWGJ2WVhTRT/uNTO51NmcxalHk2e/s9XcZwZDOHNjJUl6+gyQ3FLKL
         mAmghqm6w+fZo2WY2Izqwht5lFNisPUGInwr6L5u+fTub0EM1VE+6+wdF1lSbKDKFWjK
         lBpd0CPZnD5FK4iOVT+Vemw3+B+UP/W6g1or6k91z0tDuWA5FkupDUoJgBIIkm4HKXqk
         qVNQHxYIu/DsE/Bbd0VF4bQIjOLtWuRKDls2wplhh1ewKi689/42D+ZjDP/GqlBK7h2O
         CBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071602; x=1794676402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
        b=sfbweM2xqyFOcy3jygnvok0alAA4Wdfe0olssbc74DJqAd+WnZuD4STn3iTh2rhI9z
         +dcicUZomJYGxMZppbU+6h9wI1QLVBPg7Csk4QVF5PgI3W8Y7OvDVSc2KgcOqJC1KDbL
         DqYvoPdAvaw7AJ1g3AEekbkx/gDyH/XDrVXAgNjkeFgOSZiyECijITb8lxOCoxmkLE4J
         JjYJaxV/fkSUSbpzh/x9rXjwf1TE3m9+MouQrDjlcz7dYypIXUciqOKRIS+o+lGc5RI8
         FLLdFSaZINdvfgK4686SRKwh3qnC+0mZ9LorF+OrtzfBHITlHXMRkLPgY8Sptv2PDCVH
         1wZA==
X-Forwarded-Encrypted: i=1; AKwUvBy483rTKEfrGjl488pew6R59NU25BfYqLSYivE65sz49YTsXKuzAIon6rpPurjdgqdTmdQuhgGcBe/ReZJMXPjb1RM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6TSfq4mfmpfDBpxOC55VWZTAXxDoIrXrqs2ym/T3vjIE57OzX
	j6LzQjz2OesPIH2xx2hE9vq34KljkLOXax7+1KbbfQ2fdJZyDNglycZM
X-Gm-Gg: AYBFou3YWDUJYXFHfiz2DkUSd2hc1dMgS80zL5IN/rX4V+KM+QI1egimaGLWrXIvfHz
	CPxrhh+IOKdWL2XRdpNF9WzyZD9ZediTy7OAgKDAKRJmnP41qDyjjf06VGX0Wfe3qw2dQWnpE9d
	WPufmdzLhiuTFgJC9YU9P+TMHJ6oemHHJ/9HXgSSwjzFHasWr143UAxnwiOn0tDk2TDk5+HLXyT
	mhe4vEvTVeLcVP1JlGrHnQ1yBCXa/v13Gncz29gMqP6YR4aJtsEOd7pGebqt/p1r75yh3/Xt7Zb
	ricJnHr+O3fLQmHdVz45om5OQpu/gCuICSOqS59zJl6/tuUOTQbGkcO0Rq+SO9p8yUCuaau2N/l
	sRa7mSA0BVT7Uh+4+2oWE6Vormo8vYCAE/s2DIlb/dgbdSoBbkihNwLP0U4YoM4qgJn3VWjQeQq
	CgHdVKPgw25dvY8d0MQs5akFeRBoZZTQWDoUwjt2NTnrw0OJykhmpRL2NAsy6xF37fxnNT5KL0K
	vjlflBFz47T+YlOHjQiiZO1CcuXxcqERKVpsC4J9EsQ5vHtsqbAok1i+SAk5m1BMEdmZBQH9eJT
	uFPJ+cn/Ud3rC0RlAzTBzbGIaDKY+kFDnc3zHwnf7AW5co1SG0Wdku5Fpil2w3+YhNvdDVDjUEI
	9Jipj2z+H8F7iJX/mAxyMd1RBpFRYURjBStSDEC5tZvSwZz/Zijjv/CA3HRTpiR2E9zQkfYnAb4
	ukGbJvNkhLynzegpC5NmD+CFjVIuT5BXY=
X-Received: by 2002:a05:600c:4e8e:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4b6db4a5dc5mr105404535e9.1.1794071601430;
        Sat, 07 Nov 2026 09:13:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:20 -0800 (PST)
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
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/9] rv: Add KUnit coverage for IRQ-exit scheduling
Date: Sat,  7 Nov 2026 18:12:50 +0100
Message-Id: <20261107171252.25090-8-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
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
preempt_schedule_irq() invocations without a switch, across a task switch,
and across CPU migration when another CPU is available. The live cases
require the built-in suite because they invoke a non-exported helper.

KUnit failure reporting may allocate with GFP_KERNEL. Snapshot reaction
counts inside synthetic IRQ-disabled and hardirq intervals, then evaluate
expectations after normal task context is restored. This avoids secondary
atomic-sleep or lockdep diagnostics when a monitor check fails.

The live tests invoke the generic helper directly. They do not exercise
an architecture-specific physical interrupt-return path.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  13 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c | 540 ++++++++++++++++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |  21 +
 kernel/trace/rv/rv_monitors_test.c            |  13 +
 4 files changed, 587 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h

diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
index f09a6ce5c463a..ff85504e9cead 100644
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
index 0000000000000..d5d6b8eefbbf6
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
@@ -0,0 +1,540 @@
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
+	ret = register_trace_sched_irq_preempt_entry_tp(irqexit_observe_entry, live);
+	if (ret)
+		return ret;
+	live->raw_entry_attached = true;
+	ret = register_trace_sched_irq_preempt_exit_tp(irqexit_observe_exit, live);
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
+		unregister_trace_sched_irq_preempt_entry_tp(irqexit_observe_entry, live);
+	if (live->raw_exit_attached)
+		unregister_trace_sched_irq_preempt_exit_tp(irqexit_observe_exit, live);
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
+	int ret;
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
+	worker = kthread_create(irqexit_live_worker, live, "rv-irqexit-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	live->worker = worker;
+	ret = register_trace_event_irqexit(irqexit_observe_event, live);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	live->observer_attached = true;
+	ret = irqexit_observe_boundaries(live);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mon->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, preempt_count(), 0);
+	/* The worker must run on this CPU inside the explicit scheduling loop. */
+	scoped_guard(migrate) {
+		kthread_bind(worker, smp_processor_id());
+		sched_set_fifo(worker);
+		local_irq_save(flags);
+		preempt_schedule_irq();
+		first_entries = live->entries;
+		first_switches = live->switches_out;
+		wake_up_process(worker);
+		preempt_schedule_irq();
+		entries = live->entries;
+		exits = live->exits;
+		switches_out = live->switches_out;
+		switches_in = live->switches_in;
+		worker_done = completion_done(&live->worker_done);
+		local_irq_restore(flags);
+	}
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

