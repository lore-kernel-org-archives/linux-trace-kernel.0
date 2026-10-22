Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645674;
	b=EFMPXoc1MkjUGCX6ZR9hkFC0asMWQSUurfy7DVTK9av1iHSwwzM9mBtyosaOkyBOZSDt
	 y9mlY8LcJoFia8wA419QoRX+EvXgJVfdjvDrHXaQjFLeZXG9q0rZv9zofWWRHljVJ+uJs
	 KSXCV1wzZ7MffSb0JgJ/t+5EQixN8ZheUn+eInt+Wa51s1/NycA9kP0d57iYjtsSzd8mz
	 bMVYN+4tq32VNfqCYSdbziZ7bnBtEb+B/7isHs60PmWWidJbubNh025kSw+Udk2N+lDoA
	 NdJ/y79XXqr2JQruru3z9chlpIjWn3MFeHI639NFed4tP7MXFmyWhew4Bw3E9fp2EMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2jLX7Vxf+Jf5H+ELJcEuvVHeoh9IZgqEyJZZexa5wHA=;
	b=rMVaa4rSyGwVRTeYRMH98qSK/Ib9F7cTVBtFFkFS5Jb4dAcZ2s0EAzm8lErGiQQDR2PG
	 D6H2kj3cIAqmGLC69mInZ0DTzrPmESLJVBqCG5mRfudwW4LjgL4oqD47N0GIagMe5FlUh
	 P5mKZP1GiH3YLndjaWeg6IKD54/DoPOp00hh61aGkxz8zcllK41UhECEOQnY2tmfh7ozT
	 I8hfmv5fHAZD4JcdqSMi9fg1PW+E2ky1wAqS2j8LH7EFxK/4to6IaZaAyvdt4xQ6dNNwD
	 ofOYiNCPeBESEWZRJsycko7OvfR2RUvdypQmxRmXM9TsWpQfO06BolKgznWQcwt2cJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyMAhd5D;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D251606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D251606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyMAhd5D
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1185610f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645670; x=1793250470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jLX7Vxf+Jf5H+ELJcEuvVHeoh9IZgqEyJZZexa5wHA=;
        b=AyMAhd5DmMVUyUnT0TVrP7Hmhb91mozMMFNyu1wxzGBsB+e4LpWyPmxEkwxbdtO/2a
         7X7Rj6X5As5a0Y+W2QblMTC4LSghhqjGLvyvwIVgy9d3qbMZgKHeKC6Sou2W75dAZLeo
         GzYVgpant0apRZbVW/vEAU0MDE6VB4gizNn8unULS0v1ahC4kHMln4UrPD/s+afVzvW0
         H8kW3ZrMDtLS7miNhjGGLVgj5wGkXjB015V5IfEVFblXLZZ6wCGcR53u7IyqOaFezWHz
         KzQ3lTZ/guiB3yEiiQ+t2nsOkg59YOgtdbjGDN8DY6/2sGVeO2FKcLbrh+jJNby/keiJ
         aBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645670; x=1793250470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2jLX7Vxf+Jf5H+ELJcEuvVHeoh9IZgqEyJZZexa5wHA=;
        b=P+nrKv5vKXVXtWrzTVa3ct/RhLrZJlnuI8Pp2U7EupLhtxrsI5/v2z4MZejuY7sVZc
         NoNSb7/a0h38VliuJBoBkmIEuhxeMwes9/STxafvNToVzz8grZbozhLffILIO1w/6NFS
         hzKOANHq0/HTi3ocMTFTh+yzKi5+/VzPmK4CZySszKNyddPfiami+KQmxzimjc7HotUP
         O4NNzn4khlKf79b92mY367GYLeDWhMaF9wGH3YlnQdgiE84WRGNtAgY17gpvydUa8hV8
         f4dLIcrLqs859tEDYOZ5xt7hwTH4yfLDTZ0kJ9eHOCS//rEKg/OkY6QZokyf2ZDLAWmT
         Z6Cw==
X-Forwarded-Encrypted: i=1; AKwUvBz3nxdxcdKUct9imFqcS9THWgphjsjX5rJDWx4QcdQ70eMyhfeoJfkk8nn0TD3lO5rr5RmQQoCHoq68JPDo7N0RieU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5I2qLvjKm823JtiR4sP/Hh9dFPE9pJ5sfW/xxXKJEQn+Mq7RF
	hepPyPGRPTs7ETTLaQq766lngFOcg+iVyf7IlvAenWMiiU5ITvLkMcB8
X-Gm-Gg: AYBFou1imyCjdGwG5UJV5lS+4crOOZycEgHVLB8tbzhL0+tQ8ec/XL0wWqmyYiQHNlD
	8m0aG3AvNDLnf4l2wq465XxVgfvJh4ATwCPc9jbLmeM+K4Eys3ETTb7zACNVtIrbVgksvnYRc5J
	dc3Hw4oKnMuqpqKPG+exYXoCTrDmj+EYOAZwg/TeoKAlb6DEE2W8Zposc5Tq/RN6ATFWSf91TUw
	62ywC5QvLm4melsKL47S4a0P10doWdXq91MXB/c9eg/ka7VnfZo6o0516/vx/XojyJLkVDryyfR
	zjCf6hCyCSs8CVHVCtMIeaYJe9vQuXyuv0NaYdrCln3w2FgKl0UDTIUmgv0oE+pIs1JTYECkJnJ
	xsXXm6E/kRF1qcuZijYzs39jtTHEp56zwZxqT0RH3ipoTrdULiu3dbsEmCErtjhxg47IcXtUr0C
	y4fJpYzGqXPTN/b15p3VVHy/pCIyqrJfaTtbhRqCWQasvOrKhkpPvEzH2/q+i7V1IKbUvrIS55Y
	kRRhP+rrTp4yXHCx6s57J4sIpy9yeBDQi3W6oJKW7QCREY+BrWokbJCwDKfKUEVsWLLiBF34oi7
	A/DUAh9fBRV4Yjuvyc0L+6TeZCXikMHD984BBU2KmjFwXBCalL8S3nZ21J/yOAmdlsphc6UfAIk
	prKAyqz9Cksx/+iLGS1E2E7K2reBjkfHzNuz+HZ2Rm8Khtan1PZ3DSkgeaTo=
X-Received: by 2002:a05:6000:41d2:b0:48b:4c8:7b07 with SMTP id ffacd0b85a97d-48e264e28b3mr8506929f8f.52.1792645669949;
        Wed, 21 Oct 2026 22:07:49 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:49 -0700 (PDT)
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
Subject: [RFC PATCH 6/9] rv: Add KUnit coverage for IRQ context transitions
Date: Thu, 22 Oct 2026 07:07:09 +0200
Message-Id: <20261022050712.75035-7-kmehltretter@gmail.com>
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

Add KUnit coverage for the irqstate generated state table, invalid
transitions, enable-time synchronization, nested hardirqs, shared IRQ
actions, PREEMPT_RT serving intervals, and live tracepoint wiring.

Test probe attachment and detachment by emitting a synthetic hardirq
boundary while only one boundary probe is attached. Combine raw hardirq
accounting with explicit boundary events so the test does not depend on
cross-CPU scheduling, affinity changes, CPU hotplug, or wait queues.

In the non-RT hardirq-exit case, raise a second tasklet from the softirq
exit probe after inline processing has made its final pending-work check.
Verify that ksoftirqd is already runnable and drains the tasklet.

KUnit failure reporting may allocate with GFP_KERNEL. Record reaction
counts inside synthetic IRQ-disabled, bottom-half-disabled, and hardirq
intervals. Evaluate the expectations after restoring normal task context
to avoid secondary atomic-sleep or lockdep diagnostics.

The live tests invoke generic helpers directly. They do not exercise
physical interrupt-entry assembly.

RV_MONITORS_KUNIT_TEST is a tristate. Keep the state-table and adapter
cases available when the suite is a module. Build cases that need
non-exported helpers or tracepoints only when the suite is built in, and
report them as skipped for a module build.

Assisted-by: LLM
---
 Documentation/trace/rv/monitor_irqentry.rst   |   61 +
 include/rv/kunit.h                            |   34 +-
 kernel/trace/rv/monitors/irqstate/irqstate.c  |   49 +
 .../rv/monitors/irqstate/irqstate_kunit.c     | 1384 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 kernel/trace/rv/rv_monitors_test.c            |   12 +
 6 files changed, 1555 insertions(+), 10 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h

diff --git a/Documentation/trace/rv/monitor_irqentry.rst b/Documentation/trace/rv/monitor_irqentry.rst
index f2bb9ed2c0029..ba9e78e7c4a08 100644
--- a/Documentation/trace/rv/monitor_irqentry.rst
+++ b/Documentation/trace/rv/monitor_irqentry.rst
@@ -231,6 +231,67 @@ entry/exit events used by ``sts``.
      - no
      - yes
 
+KUnit scheduling coverage
+-------------------------
+
+``RV_MONITORS_KUNIT_TEST`` can be built in or as a module. The generated
+state-table and adapter cases run in either form. Tests which invoke
+non-exported generic IRQ entry/exit helpers or attach to non-exported boundary
+tracepoints require the built-in suite. A module build reports the standalone
+cases as skipped.
+
+``rv_test_irqstate_shared_actions`` emits two distinct IRQ action pairs for
+one IRQ number inside a single real ``irq_enter_rcu()``/``irq_exit_rcu()``
+boundary. Independent probes, filtered by the exact action pointers, require
+the first action to return ``IRQ_NONE`` and the second ``IRQ_HANDLED`` in the
+same order used by generic shared-IRQ dispatch. They also check hardirq and
+interrupt state, task and CPU identity, event counts, and count restoration.
+The monitor must accept the surrounding context without treating either
+action as another hardirq boundary. The test emits the action tracepoints
+directly; it does not construct an IRQ descriptor or invoke action handlers.
+
+``rv_test_irqstate_depth`` constructs every representable hardirq nesting
+level with the raw accounting helpers, then unwinds the complete stack. It
+checks the actual deepest component and restoration of the original count.
+An unmatched exit after the valid cycle must fail, so ignoring every event
+cannot satisfy the test. This is maximum valid nesting, not live counter
+overflow or physical interrupt-stack recursion.
+
+``rv_test_irqstate_depth_overflow`` fills the hardirq component to its maximum
+and then supplies the adapter with the depth value that another increment
+would wrap to. It requires exactly one reaction, no additional reaction while
+the valid stack is unwound, an unchanged NMI component, and exact restoration
+of the original preempt count. The test deliberately does not execute the
+overflowing raw increment, because that would carry into the adjacent NMI
+component. It tests rejection of wrapped boundary metadata, not live counter
+overflow.
+
+``rv_test_irqstate_sync`` resets and enables the bare adapter inside single
+and nested hardirq contexts, inside a real serving-softirq callback, and
+inside a hardirq interrupting that callback. Valid unwinding must establish
+idle without a reaction. A separate unmatched exit must then react exactly
+once. The softirq cases snapshot reactions before the invalid control, so
+an error on the valid sequence cannot replace the expected later error.
+These are adapter synchronization tests, not concurrent tracefs writes.
+
+``rv_test_irqstate_irq_exit_inline`` schedules a tasklet inside a real generic
+hardirq boundary and requires non-RT ``irq_exit_rcu()`` to process it before
+returning. Independent boundary probes require exactly one softirq entry
+before the tasklet and one exit afterward. The callback must run in the same
+task and on the same CPU with interrupts enabled and serving-softirq state set,
+but outside hardirq context; the monitor must accept both context pairs and
+the original counts must be restored. If the kernel diverts the tasklet to
+ksoftirqd, for example under forced IRQ threading, the test drains it and
+skips because that configuration does not provide the inline path.
+
+``rv_test_irqstate_rt_inline_bh`` forces a pending tasklet through the
+PREEMPT_RT ``local_bh_enable()`` inline-processing path. It requires the
+tasklet to finish synchronously in the enabling task, on the same CPU, while
+serving-softirq state is set and local interrupts are enabled. Independent
+boundary probes require exactly one entry before the callback and one exit
+afterward, both with local interrupts disabled and live serving state set;
+the monitor must accept the pair and the original counts must be restored.
+
 Coverage limits
 ---------------
 
diff --git a/include/rv/kunit.h b/include/rv/kunit.h
index 31e0b93c40ea8..c77f0c92d9105 100644
--- a/include/rv/kunit.h
+++ b/include/rv/kunit.h
@@ -15,6 +15,7 @@
 
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
 
 int rv_set_testing(struct kunit_suite *suite);
@@ -28,18 +29,31 @@ struct rv_kunit_ctx {
 	struct task_struct *mock_tasks[RV_KUNIT_MAX_MOCK_TASKS];
 };
 
-#define RV_KUNIT_EXPECT_REACTION(test, ctx)                             \
-	do {                                                            \
-		KUNIT_EXPECT_EQ(test, ctx->reactions, ++ctx->expected); \
-		if (ctx->reactions != ctx->expected)                    \
-			ctx->expected = ctx->reactions;                 \
+#define RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed, delta) \
+	do {                                                    \
+		struct rv_kunit_ctx *__rv_observed_ctx = (ctx); \
+		int __rv_observed = (observed);                 \
+		int __rv_expected =                            \
+			__rv_observed_ctx->expected + (delta);    \
+		KUNIT_EXPECT_EQ(test, __rv_observed,           \
+				__rv_expected);                     \
+		__rv_observed_ctx->expected = __rv_observed;   \
 	} while (0)
 
-#define RV_KUNIT_EXPECT_NO_REACTION(test, ctx)                        \
-	do {                                                          \
-		KUNIT_EXPECT_EQ(test, ctx->reactions, ctx->expected); \
-		if (ctx->reactions != ctx->expected)                  \
-			ctx->expected = ctx->reactions;               \
+#define RV_KUNIT_EXPECT_REACTION(test, ctx)                       \
+	do {                                                       \
+		struct rv_kunit_ctx *__rv_reaction_ctx = (ctx);     \
+		RV_KUNIT_EXPECT_OBSERVED(                            \
+			test, __rv_reaction_ctx,                      \
+			READ_ONCE(__rv_reaction_ctx->reactions), 1);  \
+	} while (0)
+
+#define RV_KUNIT_EXPECT_NO_REACTION(test, ctx)                    \
+	do {                                                       \
+		struct rv_kunit_ctx *__rv_reaction_ctx = (ctx);     \
+		RV_KUNIT_EXPECT_OBSERVED(                            \
+			test, __rv_reaction_ctx,                      \
+			READ_ONCE(__rv_reaction_ctx->reactions), 0);  \
 	} while (0)
 
 #define RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)                             \
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate.c b/kernel/trace/rv/monitors/irqstate/irqstate.c
index 2d8c824a4870a..4bbcbfcfedadc 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate.c
@@ -20,6 +20,36 @@
 #include "irqstate.h"
 #include <rv/ha_monitor.h>
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+static void (*irqstate_lifecycle_hook)(void *data, bool enabling);
+static void *irqstate_lifecycle_hook_data;
+
+/*
+ * Let KUnit force an IRQ pair while the boundary probes are deliberately
+ * only half attached or detached. The disabled monitor must reject that
+ * otherwise inconsistent instrumentation window.
+ */
+static void irqstate_test_lifecycle_point(bool enabling)
+{
+	void (*hook)(void *data, bool enabling);
+
+	hook = READ_ONCE(irqstate_lifecycle_hook);
+	if (hook)
+		hook(READ_ONCE(irqstate_lifecycle_hook_data), enabling);
+}
+
+static void irqstate_set_lifecycle_hook(void (*hook)(void *data, bool enabling),
+					void *data)
+{
+	WRITE_ONCE(irqstate_lifecycle_hook_data, data);
+	WRITE_ONCE(irqstate_lifecycle_hook, hook);
+}
+#else
+static inline void irqstate_test_lifecycle_point(bool enabling)
+{
+}
+#endif
+
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_irqstate env,
 		      u64 time_ns)
 {
@@ -165,6 +195,7 @@ static void handle_sched_switch(void *data, bool preempt,
 static void attach_irqstate(void)
 {
 	rv_attach_trace_probe("irqstate", hardirq_context_entry, handle_hardirq_entry);
+	irqstate_test_lifecycle_point(true);
 	rv_attach_trace_probe("irqstate", hardirq_context_exit, handle_hardirq_exit);
 	rv_attach_trace_probe("irqstate", softirq_context_entry, handle_softirq_entry);
 	rv_attach_trace_probe("irqstate", softirq_context_exit, handle_softirq_exit);
@@ -183,6 +214,7 @@ static void attach_irqstate(void)
 static void detach_irqstate(void)
 {
 	rv_detach_trace_probe("irqstate", hardirq_context_entry, handle_hardirq_entry);
+	irqstate_test_lifecycle_point(false);
 	rv_detach_trace_probe("irqstate", hardirq_context_exit, handle_hardirq_exit);
 	rv_detach_trace_probe("irqstate", softirq_context_entry, handle_softirq_entry);
 	rv_detach_trace_probe("irqstate", softirq_context_exit, handle_softirq_exit);
@@ -238,3 +270,20 @@ module_exit(unregister_irqstate);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
 MODULE_DESCRIPTION("irqstate: verify IRQ event and execution context agreement");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "irqstate_kunit.h"
+
+const struct rv_irqstate_ops rv_irqstate_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.attach = attach_irqstate,
+	.detach = detach_irqstate,
+	.handle_hardirq_entry = handle_hardirq_entry,
+	.handle_hardirq_exit = handle_hardirq_exit,
+	.handle_softirq_entry = handle_softirq_entry,
+	.handle_softirq_exit = handle_softirq_exit,
+	.set_lifecycle_hook = irqstate_set_lifecycle_hook,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_irqstate_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
new file mode 100644
index 0000000000000..c5b8834fea3d9
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -0,0 +1,1384 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/hardirq.h>
+#include <linux/interrupt.h>
+#include <linux/irqflags.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/rv.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <rv/kunit.h>
+#include <rv_trace.h>
+#include <trace/events/irq.h>
+
+#include "irqstate_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_IRQSTATE)
+
+enum irqstate_softirq_test {
+	IRQSTATE_SOFTIRQ_VALID,
+	IRQSTATE_SOFTIRQ_INTERRUPTED,
+	IRQSTATE_SOFTIRQ_DOUBLE_ENTRY,
+	IRQSTATE_SOFTIRQ_DOUBLE_EXIT,
+	IRQSTATE_SOFTIRQ_TRACEPOINT_ONLY,
+	IRQSTATE_SOFTIRQ_SYNC,
+	IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED,
+};
+
+struct irqstate_softirq_ctx {
+	struct tasklet_struct tasklet;
+	struct completion done;
+	enum irqstate_softirq_test test;
+	int reactions_after_sync;
+};
+
+static void run_irqstate_softirq(struct tasklet_struct *tasklet)
+{
+	struct irqstate_softirq_ctx *softirq_ctx;
+	unsigned long flags;
+
+	softirq_ctx = from_tasklet(softirq_ctx, tasklet, tasklet);
+
+	if (softirq_ctx->test == IRQSTATE_SOFTIRQ_SYNC ||
+	    softirq_ctx->test == IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED) {
+		local_irq_save(flags);
+		rv_irqstate_ops.mon.rv_this->enabled = 0;
+		rv_irqstate_ops.handle_softirq_entry(NULL, true, false);
+		rv_irqstate_ops.mon.rv_this->reset();
+		rv_irqstate_ops.mon.rv_this->enabled = 1;
+		if (softirq_ctx->test == IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED) {
+			__irq_enter_raw();
+			rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+			rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+			__irq_exit_raw();
+		}
+		/* The enclosing softirq exit establishes idle without an entry. */
+		rv_irqstate_ops.handle_softirq_exit(NULL, true, false);
+		softirq_ctx->reactions_after_sync = active_ctx->reactions;
+		/* Once synchronized, an unmatched hardirq exit must be rejected. */
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		goto out;
+	}
+
+	if (softirq_ctx->test == IRQSTATE_SOFTIRQ_TRACEPOINT_ONLY)
+		goto out;
+
+	rv_irqstate_ops.handle_softirq_entry(NULL, true, false);
+
+	switch (softirq_ctx->test) {
+	case IRQSTATE_SOFTIRQ_INTERRUPTED:
+		local_irq_save(flags);
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		break;
+	case IRQSTATE_SOFTIRQ_DOUBLE_ENTRY:
+		rv_irqstate_ops.handle_softirq_entry(NULL, true, false);
+		goto out;
+	case IRQSTATE_SOFTIRQ_DOUBLE_EXIT:
+		rv_irqstate_ops.handle_softirq_exit(NULL, true, false);
+		break;
+	case IRQSTATE_SOFTIRQ_VALID:
+		break;
+	case IRQSTATE_SOFTIRQ_TRACEPOINT_ONLY:
+	case IRQSTATE_SOFTIRQ_SYNC:
+	case IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	rv_irqstate_ops.handle_softirq_exit(NULL, true, false);
+out:
+	complete(&softirq_ctx->done);
+}
+
+static bool run_irqstate_softirq_case(enum irqstate_softirq_test test, int *sync_rx)
+{
+	struct irqstate_softirq_ctx softirq_ctx = {
+		.test = test,
+		.reactions_after_sync = -1,
+	};
+	unsigned long completed;
+
+	init_completion(&softirq_ctx.done);
+	tasklet_setup(&softirq_ctx.tasklet, run_irqstate_softirq);
+	tasklet_schedule(&softirq_ctx.tasklet);
+	completed = wait_for_completion_timeout(&softirq_ctx.done, HZ);
+	tasklet_kill(&softirq_ctx.tasklet);
+	if (sync_rx)
+		*sync_rx = softirq_ctx.reactions_after_sync;
+
+	return completed != 0;
+}
+
+static bool exercise_irqstate_softirq(enum irqstate_softirq_test test)
+{
+	return run_irqstate_softirq_case(test, NULL);
+}
+
+#ifndef MODULE
+static void attach_irqstate_test_probes(void)
+{
+	/* Match RV core: do not process an incomplete set of probes. */
+	rv_irqstate_ops.mon.rv_this->enabled = 0;
+	rv_irqstate_ops.attach();
+	rv_irqstate_ops.mon.rv_this->reset();
+	rv_irqstate_ops.mon.rv_this->enabled = 1;
+}
+
+static void detach_irqstate_test_probes(void *unused)
+{
+	rv_irqstate_ops.mon.rv_this->enabled = 0;
+	rv_irqstate_ops.detach();
+	tracepoint_synchronize_unregister();
+}
+
+#define IRQSTATE_LIVE_CYCLES	2
+#define IRQSTATE_LIVE_BATCH	2
+
+struct irqstate_live_toggle_ctx {
+	struct task_struct *owner;
+	int pairs;
+	int model_entries;
+	int model_exits;
+	int enable_overlaps;
+	int disable_overlaps;
+	int pair_state_errors;
+	bool monitor_initialized;
+	bool observer_attached;
+	bool hook_installed;
+	bool pair_active;
+};
+
+static void irqstate_live_emit_pair(struct irqstate_live_toggle_ctx *live)
+{
+	unsigned int preempt_count_before;
+	int lockdep_context_before;
+	bool irqs_disabled_before;
+	unsigned long flags;
+
+	irqs_disabled_before = irqs_disabled();
+	preempt_count_before = preempt_count();
+	if (irqs_disabled_before || in_interrupt())
+		live->pair_state_errors++;
+
+	/* Emit only the state and events whose probe lifetime is under test. */
+	local_irq_save(flags);
+	lockdep_context_before = lockdep_hardirq_context();
+	WRITE_ONCE(live->pair_active, true);
+	__irq_enter_raw();
+	if (hardirq_count() != HARDIRQ_OFFSET || !irqs_disabled() ||
+	    (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && !lockdep_hardirq_context()))
+		live->pair_state_errors++;
+	trace_hardirq_context_entry(hardirq_count() >> HARDIRQ_SHIFT);
+	trace_hardirq_context_exit(hardirq_count() >> HARDIRQ_SHIFT);
+	__irq_exit_raw();
+	WRITE_ONCE(live->pair_active, false);
+
+	if (preempt_count() != preempt_count_before || !irqs_disabled() ||
+	    lockdep_hardirq_context() != lockdep_context_before)
+		live->pair_state_errors++;
+	local_irq_restore(flags);
+	if (irqs_disabled() != irqs_disabled_before)
+		live->pair_state_errors++;
+	live->pairs++;
+}
+
+static void irqstate_live_emit_pairs(struct irqstate_live_toggle_ctx *live,
+				     unsigned int nr)
+{
+	while (nr--)
+		irqstate_live_emit_pair(live);
+}
+
+static void irqstate_live_lifecycle_hook(void *data, bool enabling)
+{
+	struct irqstate_live_toggle_ctx *live = data;
+
+	irqstate_live_emit_pair(live);
+	if (enabling)
+		live->enable_overlaps++;
+	else
+		live->disable_overlaps++;
+}
+
+static void irqstate_live_toggle_observe(void *data, char *state,
+					 char *event, char *next_state,
+					 bool final_state)
+{
+	struct irqstate_live_toggle_ctx *live = data;
+
+	if (current != READ_ONCE(live->owner) ||
+	    !READ_ONCE(live->pair_active))
+		return;
+	/*
+	 * Count only the synthetic boundary pair emitted while the lifecycle
+	 * hook has stopped probe attachment or detachment at its midpoint.
+	 */
+	if (!strcmp(state, "idle") &&
+	    !strcmp(event, "hardirq_entry") &&
+	    !strcmp(next_state, "in_hardirq"))
+		live->model_entries++;
+	else if (!strcmp(state, "in_hardirq") &&
+		 !strcmp(event, "hardirq_exit") &&
+		 !strcmp(next_state, "idle"))
+		live->model_exits++;
+}
+
+static void irqstate_live_toggle_cleanup(void *data)
+{
+	struct irqstate_live_toggle_ctx *live = data;
+	struct rv_monitor *mon = rv_irqstate_ops.mon.rv_this;
+
+	if (live->hook_installed) {
+		rv_irqstate_ops.set_lifecycle_hook(NULL, NULL);
+		live->hook_installed = false;
+	}
+	mon->enabled = 0;
+	if (live->monitor_initialized) {
+		mon->disable();
+		live->monitor_initialized = false;
+	}
+	if (live->observer_attached) {
+		unregister_trace_event_irqstate(irqstate_live_toggle_observe, live);
+		live->observer_attached = false;
+	}
+	tracepoint_synchronize_unregister();
+
+	RV_KUNIT_EXPECT_NO_REACTION(kunit_get_current_test(), active_ctx);
+	mon->react = mon->reactor ? mon->reactor->react : NULL;
+	active_ctx = NULL;
+	rv_mock_current(NULL);
+}
+
+static void rv_test_irqstate_live_toggle(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqstate_ops.mon.rv_this;
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqstate_live_toggle_ctx *live;
+	int disabled_entries, disabled_exits, cycle;
+	int ret;
+
+	KUNIT_ASSERT_FALSE(test, mon->enabled);
+	live = kunit_kzalloc(test, sizeof(*live), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, live);
+	live->owner = current;
+	active_ctx = ctx;
+	mon->react = rv_kunit_mock_react;
+	rv_mock_current(NULL);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_live_toggle_cleanup,
+						  live));
+
+	ret = register_trace_event_irqstate(irqstate_live_toggle_observe, live);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	live->observer_attached = true;
+
+	rv_irqstate_ops.set_lifecycle_hook(irqstate_live_lifecycle_hook, live);
+	live->hook_installed = true;
+	irqstate_live_emit_pairs(live, IRQSTATE_LIVE_BATCH);
+	KUNIT_EXPECT_EQ(test, live->model_entries, 0);
+	KUNIT_EXPECT_EQ(test, live->model_exits, 0);
+
+	for (cycle = 0; cycle < IRQSTATE_LIVE_CYCLES; cycle++) {
+		disabled_entries = live->model_entries;
+		disabled_exits = live->model_exits;
+		ret = mon->enable();
+		if (!ret) {
+			live->monitor_initialized = true;
+			mon->enabled = 1;
+		}
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		KUNIT_EXPECT_EQ(test, live->model_entries,
+				disabled_entries);
+		KUNIT_EXPECT_EQ(test, live->model_exits,
+				disabled_exits);
+
+		irqstate_live_emit_pairs(live, IRQSTATE_LIVE_BATCH);
+		KUNIT_EXPECT_EQ(test, live->model_entries,
+				disabled_entries + IRQSTATE_LIVE_BATCH);
+		KUNIT_EXPECT_EQ(test, live->model_exits,
+				disabled_exits + IRQSTATE_LIVE_BATCH);
+
+		disabled_entries = live->model_entries;
+		disabled_exits = live->model_exits;
+		mon->enabled = 0;
+		mon->disable();
+		live->monitor_initialized = false;
+		tracepoint_synchronize_unregister();
+		KUNIT_EXPECT_EQ(test, live->model_entries,
+				disabled_entries);
+		KUNIT_EXPECT_EQ(test, live->model_exits,
+				disabled_exits);
+		irqstate_live_emit_pairs(live, IRQSTATE_LIVE_BATCH);
+		KUNIT_EXPECT_EQ(test, live->model_entries,
+				disabled_entries);
+		KUNIT_EXPECT_EQ(test, live->model_exits,
+				disabled_exits);
+	}
+
+	KUNIT_EXPECT_EQ(test, live->pairs,
+			IRQSTATE_LIVE_BATCH + IRQSTATE_LIVE_CYCLES *
+			(2 + 2 * IRQSTATE_LIVE_BATCH));
+	KUNIT_EXPECT_GT(test, live->model_entries, 0);
+	KUNIT_EXPECT_GT(test, live->model_exits, 0);
+	KUNIT_EXPECT_EQ(test, live->enable_overlaps,
+			IRQSTATE_LIVE_CYCLES);
+	KUNIT_EXPECT_EQ(test, live->disable_overlaps,
+			IRQSTATE_LIVE_CYCLES);
+	KUNIT_EXPECT_EQ(test, live->pair_state_errors, 0);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test, "live toggle cycles=%d pairs=%d model=%d/%d overlap=%d/%d state_errors=%d\n",
+		   cycle,
+		   live->pairs,
+		   live->model_entries,
+		   live->model_exits,
+		   live->enable_overlaps,
+		   live->disable_overlaps,
+		   live->pair_state_errors);
+}
+#else
+static void rv_test_irqstate_live_toggle(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+#endif
+
+#ifndef MODULE
+struct irqstate_shared_actions_ctx {
+	struct irqaction actions[2];
+	struct task_struct *owner;
+	int owner_cpu;
+	int irq;
+	int results[2];
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int entry_mask;
+	unsigned int exit_mask;
+	unsigned int event_index;
+	bool armed;
+	bool bad_order;
+	bool bad_context;
+	bool bad_owner;
+	bool bad_cpu;
+	bool bad_irq;
+	bool bad_result;
+	bool entry_attached;
+	bool exit_attached;
+};
+
+static int irqstate_shared_action_index(struct irqstate_shared_actions_ctx *shared_ctx,
+					struct irqaction *action)
+{
+	if (action == &shared_ctx->actions[0])
+		return 0;
+	if (action == &shared_ctx->actions[1])
+		return 1;
+
+	return -1;
+}
+
+static void irqstate_shared_action_entry(void *data, int irq,
+					 struct irqaction *action)
+{
+	struct irqstate_shared_actions_ctx *shared_ctx = data;
+	int index;
+
+	/* Filter globally registered callbacks by exact action identity first. */
+	index = irqstate_shared_action_index(shared_ctx, action);
+	if (index < 0 || !READ_ONCE(shared_ctx->armed))
+		return;
+
+	shared_ctx->entries++;
+	shared_ctx->entry_mask |= BIT(index);
+	if (shared_ctx->event_index != index * 2)
+		shared_ctx->bad_order = true;
+	shared_ctx->event_index++;
+	if (!in_hardirq() || hardirq_count() != HARDIRQ_OFFSET ||
+	    !irqs_disabled())
+		shared_ctx->bad_context = true;
+	if (current != shared_ctx->owner)
+		shared_ctx->bad_owner = true;
+	if (raw_smp_processor_id() != shared_ctx->owner_cpu)
+		shared_ctx->bad_cpu = true;
+	if (irq != shared_ctx->irq)
+		shared_ctx->bad_irq = true;
+}
+
+static void irqstate_shared_action_exit(void *data, int irq,
+					struct irqaction *action, int ret)
+{
+	struct irqstate_shared_actions_ctx *shared_ctx = data;
+	int index;
+
+	/* Filter globally registered callbacks by exact action identity first. */
+	index = irqstate_shared_action_index(shared_ctx, action);
+	if (index < 0 || !READ_ONCE(shared_ctx->armed))
+		return;
+
+	shared_ctx->exits++;
+	shared_ctx->exit_mask |= BIT(index);
+	if (shared_ctx->event_index != index * 2 + 1)
+		shared_ctx->bad_order = true;
+	shared_ctx->event_index++;
+	if (!in_hardirq() || hardirq_count() != HARDIRQ_OFFSET ||
+	    !irqs_disabled())
+		shared_ctx->bad_context = true;
+	if (current != shared_ctx->owner)
+		shared_ctx->bad_owner = true;
+	if (raw_smp_processor_id() != shared_ctx->owner_cpu)
+		shared_ctx->bad_cpu = true;
+	if (irq != shared_ctx->irq)
+		shared_ctx->bad_irq = true;
+	if (ret != shared_ctx->results[index])
+		shared_ctx->bad_result = true;
+}
+
+static void irqstate_shared_actions_detach(void *data)
+{
+	struct irqstate_shared_actions_ctx *shared_ctx = data;
+
+	WRITE_ONCE(shared_ctx->armed, false);
+	if (shared_ctx->exit_attached)
+		unregister_trace_irq_handler_exit(irqstate_shared_action_exit,
+						  shared_ctx);
+	if (shared_ctx->entry_attached)
+		unregister_trace_irq_handler_entry(irqstate_shared_action_entry,
+						   shared_ctx);
+	tracepoint_synchronize_unregister();
+}
+#endif
+
+static void rv_test_irqstate(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+#ifndef MODULE
+	struct irqaction action = {
+		.name = "rv-kunit",
+	};
+#endif
+	unsigned long flags;
+	int reactions[8];
+	unsigned int i;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	/* Per-CPU monitor, make sure we do not change CPU mid-test. */
+	guard(migrate)();
+
+	/* Context-boundary events must agree with the live context state. */
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqstate_ops.handle_hardirq_entry(NULL, 0);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 0);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqstate_ops.handle_softirq_entry(NULL, false, false);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqstate_ops.handle_softirq_exit(NULL, false, false);
+
+	/* Disabling BH does not mean that a softirq is being served. */
+	local_bh_disable();
+	reactions[0] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_softirq_entry(NULL, false, false);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	reactions[2] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_softirq_exit(NULL, false, false);
+	reactions[3] = READ_ONCE(ctx->reactions);
+	local_bh_enable();
+	for (i = 0; i < 4; i++)
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[i], i & 1);
+
+	/* Nested hardirqs leave the outer hardirq automaton state unchanged. */
+	local_irq_save(flags);
+	__irq_enter_raw();
+	rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+	__irq_enter_raw();
+	rv_irqstate_ops.handle_hardirq_entry(NULL, 2);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 2);
+	__irq_exit_raw();
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[0] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+
+	/* A second outer entry is not a nested interrupt. */
+	local_irq_save(flags);
+	__irq_enter_raw();
+	rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+	reactions[0] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_entry(NULL, 1);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[2] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 1);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 0);
+
+	/* An exit without its corresponding entry is invalid after sync. */
+	local_irq_save(flags);
+	__irq_enter_raw();
+	reactions[0] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 1);
+
+	/* Exercise valid and deliberately invalid serving-softirq sequences. */
+	KUNIT_ASSERT_TRUE(test, exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_VALID));
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	KUNIT_ASSERT_TRUE(test,
+			  exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_INTERRUPTED));
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	KUNIT_ASSERT_TRUE(test,
+			  exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_DOUBLE_ENTRY));
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	KUNIT_ASSERT_TRUE(test,
+			  exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_DOUBLE_EXIT));
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+#ifndef MODULE
+	/* Exercise the actual generic tracepoint attachments as well. */
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	/* IRQ action events no longer drive the context-boundary monitor. */
+	trace_irq_handler_entry(0, &action);
+	trace_irq_handler_exit(0, &action, IRQ_HANDLED);
+	trace_softirq_entry(0);
+	trace_softirq_exit(0);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+
+	/* Manually invalid boundary events prove that all probes are attached. */
+	local_irq_save(flags);
+	reactions[0] = READ_ONCE(ctx->reactions);
+	trace_hardirq_context_entry(0);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	reactions[2] = READ_ONCE(ctx->reactions);
+	trace_hardirq_context_exit(0);
+	reactions[3] = READ_ONCE(ctx->reactions);
+	reactions[4] = READ_ONCE(ctx->reactions);
+	trace_softirq_context_entry(false, false);
+	reactions[5] = READ_ONCE(ctx->reactions);
+	reactions[6] = READ_ONCE(ctx->reactions);
+	trace_softirq_context_exit(false, false);
+	reactions[7] = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	for (i = 0; i < ARRAY_SIZE(reactions); i++)
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[i], i & 1);
+
+	/* These helpers emit valid hardirq context-boundary tracepoints. */
+	local_irq_save(flags);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	reactions[0] = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+
+	/* This tasklet relies only on the live softirq context tracepoints. */
+	KUNIT_ASSERT_TRUE(test,
+			  exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_TRACEPOINT_ONLY));
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+#endif
+}
+
+#ifndef MODULE
+static void rv_test_irqstate_shared_actions(struct kunit *test)
+{
+	struct irqstate_shared_actions_ctx *shared_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	unsigned long flags;
+	int ret;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	shared_ctx = kunit_kzalloc(test, sizeof(*shared_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, shared_ctx);
+	shared_ctx->actions[0].name = "rv-kunit-none";
+	shared_ctx->actions[1].name = "rv-kunit-handled";
+	shared_ctx->results[0] = IRQ_NONE;
+	shared_ctx->results[1] = IRQ_HANDLED;
+	shared_ctx->irq = 42;
+	shared_ctx->owner = current;
+	shared_ctx->owner_cpu = raw_smp_processor_id();
+
+	ret = register_trace_irq_handler_entry(irqstate_shared_action_entry,
+					       shared_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	shared_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_shared_actions_detach,
+						  shared_ctx));
+	ret = register_trace_irq_handler_exit(irqstate_shared_action_exit,
+					      shared_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	shared_ctx->exit_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	WRITE_ONCE(shared_ctx->armed, true);
+	local_irq_save(flags);
+	irq_enter_rcu();
+	trace_irq_handler_entry(shared_ctx->irq, &shared_ctx->actions[0]);
+	trace_irq_handler_exit(shared_ctx->irq, &shared_ctx->actions[0],
+			       shared_ctx->results[0]);
+	trace_irq_handler_entry(shared_ctx->irq, &shared_ctx->actions[1]);
+	trace_irq_handler_exit(shared_ctx->irq, &shared_ctx->actions[1],
+			       shared_ctx->results[1]);
+	irq_exit_rcu();
+	WRITE_ONCE(shared_ctx->armed, false);
+	local_irq_restore(flags);
+
+	KUNIT_EXPECT_EQ(test, shared_ctx->entries, 2U);
+	KUNIT_EXPECT_EQ(test, shared_ctx->exits, 2U);
+	KUNIT_EXPECT_EQ(test, shared_ctx->entry_mask, 3U);
+	KUNIT_EXPECT_EQ(test, shared_ctx->exit_mask, 3U);
+	KUNIT_EXPECT_EQ(test, shared_ctx->event_index, 4U);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_order);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_context);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_owner);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_cpu);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_irq);
+	KUNIT_EXPECT_FALSE(test, shared_ctx->bad_result);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test,
+		   "shared actions events=%u/%u order=%u context=%u same_task=%u same_cpu=%u restored=%u\n",
+		   shared_ctx->entries, shared_ctx->exits,
+		   !shared_ctx->bad_order, !shared_ctx->bad_context,
+		   !shared_ctx->bad_owner, !shared_ctx->bad_cpu,
+		   preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq);
+}
+#else
+static void rv_test_irqstate_shared_actions(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+#endif
+
+static void rv_test_irqstate_depth(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int max_depth = HARDIRQ_MASK >> HARDIRQ_SHIFT;
+	unsigned int observed_depth, saved_count;
+	unsigned long flags;
+	int reactions[3];
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	saved_count = preempt_count();
+	local_irq_save(flags);
+	for (unsigned int depth = 1; depth <= max_depth; depth++) {
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, depth);
+	}
+	observed_depth = hardirq_count() >> HARDIRQ_SHIFT;
+	for (unsigned int depth = max_depth; depth; depth--) {
+		rv_irqstate_ops.handle_hardirq_exit(NULL, depth);
+		__irq_exit_raw();
+	}
+	reactions[0] = READ_ONCE(ctx->reactions);
+	/* A silent adapter cannot pass: the completed outer pair armed idle. */
+	__irq_enter_raw();
+	reactions[1] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[2] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
+	KUNIT_EXPECT_EQ(test, observed_depth, max_depth);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	kunit_info(test, "hardirq max_depth=%u observed=%u restored=%u\n",
+		   max_depth, observed_depth, preempt_count() == saved_count);
+}
+
+static void rv_test_irqstate_depth_overflow(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int max_depth = HARDIRQ_MASK >> HARDIRQ_SHIFT;
+	unsigned int observed_depth, saved_count, saved_nmi;
+	unsigned int nmi_at_max, nmi_at_overflow;
+	int reactions_before, reactions_before_overflow;
+	int reactions_at_overflow, reactions_after_unwind;
+	unsigned long flags;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	saved_count = preempt_count();
+	saved_nmi = nmi_count();
+	reactions_before = ctx->reactions;
+
+	local_irq_save(flags);
+	for (unsigned int depth = 1; depth <= max_depth; depth++) {
+		__irq_enter_raw();
+		rv_irqstate_ops.handle_hardirq_entry(NULL, depth);
+	}
+	observed_depth = hardirq_count() >> HARDIRQ_SHIFT;
+	nmi_at_max = nmi_count();
+	reactions_before_overflow = ctx->reactions;
+
+	/*
+	 * A real increment here would carry into NMI_MASK. Feed the resulting
+	 * wrapped depth directly to the adapter without corrupting preempt_count.
+	 */
+	rv_irqstate_ops.handle_hardirq_entry(NULL, 0);
+	nmi_at_overflow = nmi_count();
+	reactions_at_overflow = ctx->reactions;
+	for (unsigned int depth = max_depth; depth; depth--) {
+		rv_irqstate_ops.handle_hardirq_exit(NULL, depth);
+		__irq_exit_raw();
+	}
+	reactions_after_unwind = ctx->reactions;
+	local_irq_restore(flags);
+
+	KUNIT_EXPECT_EQ(test, observed_depth, max_depth);
+	KUNIT_EXPECT_EQ(test, reactions_before_overflow, reactions_before);
+	KUNIT_EXPECT_EQ(test, reactions_at_overflow,
+			reactions_before_overflow + 1);
+	KUNIT_EXPECT_EQ(test, reactions_after_unwind, reactions_at_overflow);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	KUNIT_EXPECT_EQ(test, nmi_at_max, saved_nmi);
+	KUNIT_EXPECT_EQ(test, nmi_at_overflow, saved_nmi);
+	KUNIT_EXPECT_EQ(test, nmi_count(), saved_nmi);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	kunit_info(test,
+		   "hardirq overflow max_depth=%u observed=%u reactions=%d restored=%u\n",
+		   max_depth, observed_depth,
+		   reactions_after_unwind - reactions_before,
+		   preempt_count() == saved_count && nmi_count() == saved_nmi);
+}
+
+static void rv_test_irqstate_sync(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct rv_monitor *mon = rv_irqstate_ops.mon.rv_this;
+	unsigned int saved_count;
+	unsigned long flags;
+	int expected, rx_at_sync;
+	int reactions[3];
+	bool completed;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	saved_count = preempt_count();
+	for (unsigned int depth = 1; depth <= 2; depth++) {
+		local_irq_save(flags);
+		mon->enabled = 0;
+		for (unsigned int level = 1; level <= depth; level++) {
+			__irq_enter_raw();
+			rv_irqstate_ops.handle_hardirq_entry(NULL, level);
+		}
+		mon->reset();
+		mon->enabled = 1;
+		for (unsigned int level = depth; level; level--) {
+			rv_irqstate_ops.handle_hardirq_exit(NULL, level);
+			__irq_exit_raw();
+		}
+		reactions[0] = READ_ONCE(ctx->reactions);
+		/* The first unmatched exit after synchronization must now fail. */
+		__irq_enter_raw();
+		reactions[1] = READ_ONCE(ctx->reactions);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[2] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
+	}
+
+	expected = ctx->expected;
+	completed = run_irqstate_softirq_case(IRQSTATE_SOFTIRQ_SYNC, &rx_at_sync);
+	KUNIT_ASSERT_TRUE(test, completed);
+	KUNIT_EXPECT_EQ(test, rx_at_sync, expected);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	expected = ctx->expected;
+	completed = run_irqstate_softirq_case(IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED, &rx_at_sync);
+	KUNIT_ASSERT_TRUE(test, completed);
+	KUNIT_EXPECT_EQ(test, rx_at_sync, expected);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	kunit_info(test, "sync hardirq=1 nested=2 softirq=1 interrupted_softirq=1 restored=%u\n",
+		   preempt_count() == saved_count);
+}
+
+#ifndef MODULE
+struct irqstate_preempt_ctx {
+	struct tasklet_struct tasklet;
+	struct task_struct *worker;
+	struct completion tasklet_done;
+	struct completion worker_done;
+	bool preempted;
+	bool worker_in_softirq;
+};
+
+struct irqstate_inline_bh_ctx {
+	struct tasklet_struct tasklet;
+	struct tasklet_struct exit_tasklet;
+	struct task_struct *owner;
+	struct task_struct *softirqd;
+	int owner_cpu;
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int tasklet_runs;
+	unsigned int exit_tasklet_runs;
+	bool armed;
+	bool raise_on_exit;
+	bool exit_tasklet_pending;
+	bool softirqd_already_runnable;
+	bool bad_boundary_context;
+	bool bad_boundary_cpu;
+	bool tasklet_serving;
+	bool tasklet_same_task;
+	bool tasklet_same_cpu;
+	bool tasklet_irqs_enabled;
+	bool tasklet_in_hardirq;
+	bool tasklet_bracketed;
+	bool entry_attached;
+	bool exit_attached;
+};
+
+static void irqstate_inline_bh_entry(void *data, bool serving,
+				     bool from_hardirq)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner)
+		return;
+	inline_ctx->entries++;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		inline_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != inline_ctx->owner_cpu)
+		inline_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_inline_bh_exit(void *data, bool serving,
+				    bool from_hardirq)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	if (!READ_ONCE(inline_ctx->armed) || current != inline_ctx->owner)
+		return;
+	inline_ctx->exits++;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		inline_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != inline_ctx->owner_cpu)
+		inline_ctx->bad_boundary_cpu = true;
+	if (READ_ONCE(inline_ctx->raise_on_exit)) {
+		WRITE_ONCE(inline_ctx->raise_on_exit, false);
+		tasklet_schedule(&inline_ctx->exit_tasklet);
+	}
+}
+
+static void irqstate_inline_bh_tasklet(struct tasklet_struct *tasklet)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx;
+
+	inline_ctx = from_tasklet(inline_ctx, tasklet, tasklet);
+	inline_ctx->tasklet_runs++;
+	inline_ctx->tasklet_serving = !!in_serving_softirq();
+	inline_ctx->tasklet_same_task = current == inline_ctx->owner;
+	inline_ctx->tasklet_same_cpu = raw_smp_processor_id() ==
+					inline_ctx->owner_cpu;
+	inline_ctx->tasklet_irqs_enabled = !irqs_disabled();
+	inline_ctx->tasklet_in_hardirq = !!in_hardirq();
+	inline_ctx->tasklet_bracketed = inline_ctx->entries == 1 &&
+					 inline_ctx->exits == 0;
+}
+
+static void irqstate_inline_bh_exit_tasklet(struct tasklet_struct *tasklet)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx;
+
+	inline_ctx = from_tasklet(inline_ctx, tasklet, exit_tasklet);
+	inline_ctx->exit_tasklet_runs++;
+}
+
+static void irqstate_inline_bh_kill(void *data)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	tasklet_kill(&inline_ctx->tasklet);
+}
+
+static void irqstate_inline_bh_kill_all(void *data)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	tasklet_kill(&inline_ctx->tasklet);
+	tasklet_kill(&inline_ctx->exit_tasklet);
+}
+
+static void irqstate_inline_bh_detach(void *data)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx = data;
+
+	WRITE_ONCE(inline_ctx->armed, false);
+	if (inline_ctx->entry_attached)
+		unregister_trace_softirq_context_entry(irqstate_inline_bh_entry, inline_ctx);
+	if (inline_ctx->exit_attached)
+		unregister_trace_softirq_context_exit(irqstate_inline_bh_exit, inline_ctx);
+	tracepoint_synchronize_unregister();
+}
+
+/* Exercise non-RT inline softirq processing from a real hardirq exit. */
+static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	unsigned long flags;
+	bool ran_inline;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires non-RT IRQ-exit softirq processing");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
+	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
+	tasklet_setup(&inline_ctx->exit_tasklet,
+		      irqstate_inline_bh_exit_tasklet);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_kill_all,
+						  inline_ctx));
+
+	ret = register_trace_softirq_context_entry(irqstate_inline_bh_entry,
+						   inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
+						  inline_ctx));
+	ret = register_trace_softirq_context_exit(irqstate_inline_bh_exit,
+						  inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->exit_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	KUNIT_ASSERT_FALSE(test, in_interrupt());
+	KUNIT_ASSERT_FALSE(test, irqs_disabled());
+	KUNIT_ASSERT_EQ(test, softirq_count(), 0U);
+	guard(migrate)();
+	inline_ctx->owner = current;
+	inline_ctx->owner_cpu = raw_smp_processor_id();
+	inline_ctx->softirqd = this_cpu_ksoftirqd();
+	KUNIT_ASSERT_NOT_NULL(test, inline_ctx->softirqd);
+	if (local_softirq_pending() ||
+	    !wait_task_inactive(inline_ctx->softirqd, TASK_INTERRUPTIBLE)) {
+		kunit_skip(test, "Requires an idle local ksoftirqd");
+		return;
+	}
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	local_irq_save(flags);
+	if (local_softirq_pending() || task_is_running(inline_ctx->softirqd)) {
+		local_irq_restore(flags);
+		kunit_skip(test, "Local ksoftirqd stopped being idle");
+		return;
+	}
+	WRITE_ONCE(inline_ctx->armed, true);
+	WRITE_ONCE(inline_ctx->raise_on_exit, true);
+	irq_enter_rcu();
+	tasklet_schedule(&inline_ctx->tasklet);
+	irq_exit_rcu();
+	ran_inline = inline_ctx->tasklet_runs != 0;
+	inline_ctx->exit_tasklet_pending =
+		!!(local_softirq_pending() & BIT(TASKLET_SOFTIRQ));
+	/*
+	 * A zero return means the exit handoff already made ksoftirqd runnable.
+	 * A one return also makes the failure path safe to drain.
+	 */
+	inline_ctx->softirqd_already_runnable =
+		!wake_up_process(inline_ctx->softirqd);
+	WRITE_ONCE(inline_ctx->armed, false);
+	local_irq_restore(flags);
+
+	/* Drain a tasklet diverted to ksoftirqd before inspecting or skipping. */
+	kunit_release_action(test, irqstate_inline_bh_kill_all, inline_ctx);
+	if (!ran_inline) {
+		kunit_skip(test, "IRQ exit diverted pending softirq to ksoftirqd");
+		return;
+	}
+
+	KUNIT_EXPECT_EQ(test, inline_ctx->tasklet_runs, 1U);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_serving);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_task);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_cpu);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_irqs_enabled);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->tasklet_in_hardirq);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_bracketed);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->exit_tasklet_pending);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->softirqd_already_runnable);
+	KUNIT_EXPECT_EQ(test, inline_ctx->exit_tasklet_runs, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->entries, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->exits, 1U);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_context);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test,
+		   "IRQ-exit inline tasklets=%u/%u handoff=%u events=%u/%u restored=%u\n",
+		   inline_ctx->tasklet_runs, inline_ctx->exit_tasklet_runs,
+		   inline_ctx->softirqd_already_runnable,
+		   inline_ctx->entries, inline_ctx->exits,
+		   preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq);
+}
+
+/* Force the RT BH-disabled to inline-serving transition. */
+static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
+{
+	struct irqstate_inline_bh_ctx *inline_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT inline softirq processing");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	inline_ctx = kunit_kzalloc(test, sizeof(*inline_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, inline_ctx);
+	inline_ctx->owner = current;
+	tasklet_setup(&inline_ctx->tasklet, irqstate_inline_bh_tasklet);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_kill,
+						  inline_ctx));
+
+	ret = register_trace_softirq_context_entry(irqstate_inline_bh_entry, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
+						  inline_ctx));
+	ret = register_trace_softirq_context_exit(irqstate_inline_bh_exit, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->exit_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	KUNIT_ASSERT_TRUE(test, preemptible());
+	KUNIT_ASSERT_EQ(test, softirq_count(), 0U);
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	local_bh_disable();
+	inline_ctx->owner_cpu = raw_smp_processor_id();
+	WRITE_ONCE(inline_ctx->armed, true);
+	tasklet_schedule(&inline_ctx->tasklet);
+	local_bh_enable();
+	WRITE_ONCE(inline_ctx->armed, false);
+	kunit_release_action(test, irqstate_inline_bh_kill, inline_ctx);
+
+	KUNIT_EXPECT_EQ(test, inline_ctx->tasklet_runs, 1U);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_serving);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_task);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_same_cpu);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_irqs_enabled);
+	KUNIT_EXPECT_TRUE(test, inline_ctx->tasklet_bracketed);
+	KUNIT_EXPECT_EQ(test, inline_ctx->entries, 1U);
+	KUNIT_EXPECT_EQ(test, inline_ctx->exits, 1U);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_context);
+	KUNIT_EXPECT_FALSE(test, inline_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test,
+		   "RT inline BH tasklet=%u same_task=%u same_cpu=%u serving=%u events=%u/%u restored=%u\n",
+		   inline_ctx->tasklet_runs, inline_ctx->tasklet_same_task,
+		   inline_ctx->tasklet_same_cpu, inline_ctx->tasklet_serving,
+		   inline_ctx->entries, inline_ctx->exits,
+		   preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq);
+}
+
+static int irqstate_preempt_worker(void *arg)
+{
+	struct irqstate_preempt_ctx *preempt_ctx = arg;
+	unsigned long flags;
+
+	preempt_ctx->worker_in_softirq = !!in_serving_softirq();
+	local_irq_save(flags);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	local_irq_restore(flags);
+	complete(&preempt_ctx->worker_done);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void irqstate_preempt_tasklet(struct tasklet_struct *tasklet)
+{
+	struct irqstate_preempt_ctx *preempt_ctx;
+
+	preempt_ctx = from_tasklet(preempt_ctx, tasklet, tasklet);
+	wake_up_process(preempt_ctx->worker);
+	preempt_ctx->preempted = completion_done(&preempt_ctx->worker_done);
+	complete(&preempt_ctx->tasklet_done);
+}
+
+static void stop_irqstate_preempt_worker(void *worker)
+{
+	kthread_stop(worker);
+}
+
+/* A hardirq in another task must not inherit a suspended RT softirq. */
+static void rv_test_irqstate_preempt(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqstate_preempt_ctx *preempt_ctx;
+	struct task_struct *worker;
+	unsigned long completed;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires preemptible softirq processing");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+
+	preempt_ctx = kunit_kzalloc(test, sizeof(*preempt_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, preempt_ctx);
+	init_completion(&preempt_ctx->tasklet_done);
+	init_completion(&preempt_ctx->worker_done);
+	worker = kthread_create(irqstate_preempt_worker, preempt_ctx,
+				"irqstate-preempt");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(worker));
+	preempt_ctx->worker = worker;
+	kthread_bind(worker, smp_processor_id());
+	sched_set_fifo(worker);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, stop_irqstate_preempt_worker,
+						  worker));
+
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+	tasklet_setup(&preempt_ctx->tasklet, irqstate_preempt_tasklet);
+	tasklet_schedule(&preempt_ctx->tasklet);
+	completed = wait_for_completion_timeout(&preempt_ctx->tasklet_done, HZ);
+	tasklet_kill(&preempt_ctx->tasklet);
+	KUNIT_ASSERT_NE(test, completed, 0);
+	KUNIT_ASSERT_NE(test,
+			wait_for_completion_timeout(&preempt_ctx->worker_done, HZ), 0);
+	KUNIT_EXPECT_TRUE(test, preempt_ctx->preempted);
+	KUNIT_EXPECT_FALSE(test, preempt_ctx->worker_in_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
+
+/* An RT serving interval starts before handle_softirqs() is entered. */
+static void rv_test_irqstate_rt_prepare_irq(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	unsigned long flags;
+	int reactions[2];
+	bool serving;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT serving-softirq accounting");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+
+	/*
+	 * Keep an outer BH-disable reference so the matching enable of the
+	 * serving reference cannot dispatch pending softirqs. Both references
+	 * use the real RT helpers; no task or per-CPU counter is fabricated.
+	 */
+	local_bh_disable();
+	local_irq_save(flags);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	local_irq_restore(flags);
+
+	/* The same serving-bit transition used by ksoftirqd_run_begin(). */
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	serving = !!in_serving_softirq();
+	local_irq_save(flags);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	local_irq_restore(flags);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_bh_enable();
+
+	KUNIT_EXPECT_TRUE(test, serving);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	kunit_info(test, "RT preparation IRQ serving=%u restored=%u\n",
+		   serving, preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	local_irq_save(flags);
+	__irq_enter_raw();
+	reactions[0] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 1);
+}
+
+/* A real task switch is legal before handle_softirqs(), too. */
+static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqstate_preempt_ctx *preempt_ctx;
+	struct task_struct *worker;
+	unsigned int saved_count, saved_softirq;
+	unsigned long completed, flags;
+	int reactions[2];
+	bool preempted, serving;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT serving-softirq accounting");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	guard(migrate)();
+	preempt_ctx = kunit_kzalloc(test, sizeof(*preempt_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, preempt_ctx);
+	init_completion(&preempt_ctx->worker_done);
+	worker = kthread_create(irqstate_preempt_worker, preempt_ctx,
+				"irqstate-prepare");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(worker));
+	kthread_bind(worker, smp_processor_id());
+	sched_set_fifo(worker);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, stop_irqstate_preempt_worker,
+						  worker));
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+
+	local_bh_disable();
+	local_irq_save(flags);
+	irq_enter_rcu();
+	irq_exit_rcu();
+	local_irq_restore(flags);
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	serving = !!in_serving_softirq();
+	wake_up_process(worker);
+	preempted = completion_done(&preempt_ctx->worker_done);
+	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_bh_enable();
+
+	completed = wait_for_completion_timeout(&preempt_ctx->worker_done, HZ);
+	KUNIT_EXPECT_NE(test, completed, 0);
+	KUNIT_EXPECT_TRUE(test, serving);
+	KUNIT_EXPECT_TRUE(test, preempted);
+	KUNIT_EXPECT_FALSE(test, preempt_ctx->worker_in_softirq);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	kunit_info(test, "RT preparation switch serving=%u preempted=%u worker_serving=%u restored=%u\n",
+		   serving, preempted, preempt_ctx->worker_in_softirq,
+		   preempt_count() == saved_count && softirq_count() == saved_softirq);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	local_irq_save(flags);
+	__irq_enter_raw();
+	reactions[0] = READ_ONCE(ctx->reactions);
+	rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 1);
+}
+
+#else
+static void rv_test_irqstate_irq_exit_inline(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_preempt(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_rt_prepare_irq(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+#endif
+
+#else
+#define rv_test_irqstate rv_test_stub
+#define rv_test_irqstate_shared_actions rv_test_stub
+#define rv_test_irqstate_depth rv_test_stub
+#define rv_test_irqstate_depth_overflow rv_test_stub
+#define rv_test_irqstate_sync rv_test_stub
+#define rv_test_irqstate_live_toggle rv_test_stub
+#define rv_test_irqstate_irq_exit_inline rv_test_stub
+#define rv_test_irqstate_rt_inline_bh rv_test_stub
+#define rv_test_irqstate_preempt rv_test_stub
+#define rv_test_irqstate_rt_prepare_irq rv_test_stub
+#define rv_test_irqstate_rt_prepare_switch rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.h b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
new file mode 100644
index 0000000000000..4a0cba58eb662
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __IRQSTATE_KUNIT_H
+#define __IRQSTATE_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+struct irqaction;
+
+extern const struct rv_irqstate_ops {
+	struct rv_kunit_mon mon;
+	void (*attach)(void);
+	void (*detach)(void);
+	void (*handle_hardirq_entry)(void *data, unsigned int depth);
+	void (*handle_hardirq_exit)(void *data, unsigned int depth);
+	void (*handle_softirq_entry)(void *data, bool serving, bool from_hardirq);
+	void (*handle_softirq_exit)(void *data, bool serving, bool from_hardirq);
+	void (*set_lifecycle_hook)(void (*hook)(void *data, bool enabling),
+				   void *data);
+} rv_irqstate_ops;
+#endif
+
+#endif /* __IRQSTATE_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3ad11195e664a..4fb611a9f8b85 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -149,6 +149,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sco/sco_kunit.c"
 #include "monitors/sssw/sssw_kunit.c"
 #include "monitors/sts/sts_kunit.c"
+#include "monitors/irqstate/irqstate_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
@@ -159,6 +160,17 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_sco),
 	KUNIT_CASE(rv_test_sssw),
 	KUNIT_CASE(rv_test_sts),
+	KUNIT_CASE(rv_test_irqstate),
+	KUNIT_CASE(rv_test_irqstate_shared_actions),
+	KUNIT_CASE(rv_test_irqstate_depth),
+	KUNIT_CASE(rv_test_irqstate_depth_overflow),
+	KUNIT_CASE(rv_test_irqstate_sync),
+	KUNIT_CASE(rv_test_irqstate_live_toggle),
+	KUNIT_CASE(rv_test_irqstate_irq_exit_inline),
+	KUNIT_CASE(rv_test_irqstate_rt_inline_bh),
+	KUNIT_CASE(rv_test_irqstate_preempt),
+	KUNIT_CASE(rv_test_irqstate_rt_prepare_irq),
+	KUNIT_CASE(rv_test_irqstate_rt_prepare_switch),
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
 	KUNIT_CASE(rv_test_pagefault),
-- 
2.39.5 (Apple Git-154)

