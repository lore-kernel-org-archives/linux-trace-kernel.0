Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071604;
	b=FPXpN2IUDqpArKZHCDswYCTQe2duSmnXdREiv90JWwrVemtnk2hukywtO04NHULEbIIV
	 X70UbkmYpEwPkOCmk1jFNFrsWJoT0rybRqqZ4s4hPSWb2I+u4wtE6QdASYUVD1uYMnaeJ
	 AdcRmlZ0vuatXFGP2lai6FYU1R2qEoka8JXvEuscDYwAcBb2gUtrHqQkNOoG2GqmJekhl
	 GFJX4wx7mdfN73VHdtmpbnPdBl4JRAQ1zddXgl5KYXtbIscae+vTKMkur0cZVWG9UmN4y
	 5UCtcxLnYw6iWXmQCpyO9EzdMXFAG0siFkMQocWvRn0G7B9v8UGR7TdwWTp1ooyZXzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=svl8cAEsihmiuHN7ScSvgNjpFO9ae1Bw7nYzNstQXB0=;
	b=DmNu+ixBcUqB2npooKqo0iqyZqzEfCA1P9gr/PNv+bs3/wGsJJbeOvYIHaqzAGoTVwum
	 fbNZgOF5BJ5rQSb4Iq8VMV2wYXWcGu5hTjCiJCtWAVIPQJr9rqPat4KaRxZpO891k2MLW
	 7BFXNc4Fuw6tnJCHcH06DyNDGvtZQS8oVzRyIgS5WKrv2A4UtCCY6XrH3Nf5wyfVtGPEv
	 zt76zprWEqs58Qdvme7Yg0rjaSNie3PYn7P+YPM/BKcyKfOz0zZo1BeurEGDez47G3x1E
	 crniHPmYvymLvEzrQzU/4vf6j8Wiiij3PTCLLO9O5gfvwjVWEX5Klj1CAjMMxN+GC4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8nB9hWq;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD48606EE8F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD48606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8nB9hWq
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso5592725e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071600; x=1794676400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svl8cAEsihmiuHN7ScSvgNjpFO9ae1Bw7nYzNstQXB0=;
        b=b8nB9hWqesn4DF/PRD1+JYKv5P3ASoRNtRGQEVjYUbjARa8hJaFixYTOV8tPK7xCXF
         77xOhMxWUYfqNzrPUi03qNGlJfjvpo1+Mn3EDQ7qKGJFGrv1xrznT2AZvzUyIARDlGCK
         Y9gRd85DvgJFZ8MAgEQWMyHjyyvXCzRlDWU8kBbyv/wMS2POnw3YwYdng3/V+rW2KqEK
         ny073y/MHcGzIEGbRSEEHcoA/gouC20CNv8Oe5s6Qvsc6LsszP4eJIW4YleY7Y0peUte
         /pXCXBOYw3yriU9FhtC6rjXk+n2Yw4YAGTFNJkKO2b0Gc3KhL04g0T2N6mo37M58btGi
         nUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071600; x=1794676400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=svl8cAEsihmiuHN7ScSvgNjpFO9ae1Bw7nYzNstQXB0=;
        b=RJU7tOjuM1MgZB8ENZ8GW3MCq+c785cB5JVf5fGwecFTZT7LejlhCniywOWy5eUikt
         PJiJsh5g8Su3noIjHT5xZKtwM7TfxNbipOENT7E+s3mzFWhNobSsDCYbnzoSglkQMoK3
         ixYxeZa89Ptgswkmh319Mc6Ux0kh0vAO8bYJph/fhtR+P0vCqox5q1uJTDbP7fkANvwV
         ee40Ny3P7sxHmseH23o8psa3tfpRcops3dDXtISgIwQo42xf6tukSidSdiYSsFzxFAC0
         izU3+nlwHtcyW1CKHVI86eFPOPd4VXkw4PjlZFGUL2f42myrWxgRBF1+CvoWeIRXjDI7
         yF7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxWP9NxL0XZWnvwUazJaqDjNzd13D2EAF6llA2H/qa4y1Fgq/nc1SL+y0cqrqo3BkD0R0XoH5fyQGFEaWtrmvTfgb4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bdw/MeOtOKld0JGdzS97KFFEihLONngPolKUxnZcXLAt1TEf1
	oJ7xrcvo4KzkrsqlH6pAI+zQiXza6EL6wi4my6FZqx8Su0wXZ3wF9Yeh
X-Gm-Gg: AYBFou35CLvhthNiM331T0aGFvA8AAWG1i83OIxzmd6VIqBU4cruZDkYnUbH7+35e8g
	i0LlX41QychcMeHbqZqRDvb94y5TWVtXqTTBnNM35HpQTyM29O/72oONG0kQDmMO7iHG54q81e5
	YY3Q8tS9ktpFiMO4zNtVfnl99rNdhiYrIIbXoVmCCM+CkO7xt/nm3c/ZxUBXBcRKJ6QJaNy4auB
	FvgESobWBgamWKraI6/DklodV+sWuerUl9ah1kcvDZQ+flwpjOFXSY41anp3D7fc34ujiY/Ixp/
	28k4SuT+VbB1YdzP7NAR6agTMbn5N0pHzI9HevsVThU5XesbU6eWls3Asszzu7Ofq6iCcJM4agV
	Nt28fhYZOTq0yScRgQjo7PJiGBUpOuDG5BbXJyUEE1JxLk1QLiMTvlWhGSaZFHNqHBwa3hMaTRS
	iFVdtZy29jpgPlqV2dqGJJym5CmKa8KW4vgVjA1FcwTP+LVeTsTszL9/nXXe68vasvlWuI6WgZ3
	iFaxs0KRd9OizebbR6CubRfGW05ICFMwLrMSMt2grlinIPUKCUaxr2lvqtq5+MAQhjN96Y4zoBB
	PYL9k3zFhkrBBhSTttYNoBnz8WsQe7uBfNuIMhPQ33gX6ZVKWf1QHHl4PWyqcF/u0Uh/eHfBPwS
	QJZ0sfeYndQrJglr5G1VUCIaanawk1juwxlTFZ+ClB+vFyjqzH1Z8s27kJ7wH5FtSdnoNohS098
	C2S7j5pQ9HVolvrTG2yryKKeazWoYIcm8=
X-Received: by 2002:a05:600c:4fc9:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4b6e017053fmr107213565e9.23.1794071599512;
        Sat, 07 Nov 2026 09:13:19 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:19 -0800 (PST)
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
Subject: [RFC PATCH v2 6/9] rv: Add KUnit coverage for IRQ context transitions
Date: Sat,  7 Nov 2026 18:12:49 +0100
Message-Id: <20261107171252.25090-7-kmehltretter@gmail.com>
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

Add KUnit coverage for the irqstate generated state table, invalid
transitions, enable-time synchronization, nested hardirqs, shared IRQ
actions, PREEMPT_RT serving intervals, and live tracepoint wiring.

Test probe attachment and detachment by synchronously emitting a
synthetic hardirq boundary while only one of the two hardirq boundary
probes is attached. Combine raw hardirq accounting with explicit boundary
events so the test does not depend on cross-CPU scheduling, affinity
changes, CPU hotplug, or wait queues.

In the non-RT hardirq-exit case, raise a second tasklet from the
softirq exit probe after inline processing has made its final pending-work
decision. Verify that ksoftirqd is already runnable and drains the tasklet.

KUnit failure reporting may allocate with GFP_KERNEL. Snapshot reaction
counts inside synthetic IRQ-disabled, bottom-half-disabled, and hardirq
intervals, then evaluate expectations after normal task context is
restored. This avoids secondary atomic-sleep or lockdep diagnostics when
a monitor check fails.

The live tests invoke generic helpers directly. They do not exercise
physical interrupt-entry assembly.

RV_MONITORS_KUNIT_TEST is a tristate. Keep the state-table and adapter
cases available when the suite is a module. Build cases that require
non-exported helpers or tracepoints only when the suite is built in, and
report them as skipped for a module build.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/rv/kunit.h                            |   34 +-
 kernel/trace/rv/monitors/irqstate/irqstate.c  |   49 +
 .../rv/monitors/irqstate/irqstate_kunit.c     | 1420 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 kernel/trace/rv/rv_monitors_test.c            |   12 +
 5 files changed, 1530 insertions(+), 10 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h

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
index bc7e9957bc750..89457c65d0441 100644
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
 	rv_attach_trace_probe("irqstate", hardirq_context_entry_tp, handle_hardirq_entry);
+	irqstate_test_lifecycle_point(true);
 	rv_attach_trace_probe("irqstate", hardirq_context_exit_tp, handle_hardirq_exit);
 	rv_attach_trace_probe("irqstate", softirq_context_entry_tp, handle_softirq_entry);
 	rv_attach_trace_probe("irqstate", softirq_context_exit_tp, handle_softirq_exit);
@@ -183,6 +214,7 @@ static void attach_irqstate(void)
 static void detach_irqstate(void)
 {
 	rv_detach_trace_probe("irqstate", hardirq_context_entry_tp, handle_hardirq_entry);
+	irqstate_test_lifecycle_point(false);
 	rv_detach_trace_probe("irqstate", hardirq_context_exit_tp, handle_hardirq_exit);
 	rv_detach_trace_probe("irqstate", softirq_context_entry_tp, handle_softirq_entry);
 	rv_detach_trace_probe("irqstate", softirq_context_exit_tp, handle_softirq_exit);
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
index 0000000000000..e61c500a954a9
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -0,0 +1,1420 @@
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
+	trace_hardirq_context_entry_tp(hardirq_count() >> HARDIRQ_SHIFT);
+	trace_hardirq_context_exit_tp(hardirq_count() >> HARDIRQ_SHIFT);
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
+	int ret;
+#endif
+	unsigned long flags;
+	int reactions[8];
+	unsigned int i;
+	bool completed;
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	/* Fatal KUnit exits do not unwind this migration guard. */
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
+	completed = exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_VALID);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	completed = exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_INTERRUPTED);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	completed = exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_DOUBLE_ENTRY);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	completed = exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_DOUBLE_EXIT);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+
+#ifndef MODULE
+	/* Exercise the actual generic tracepoint attachments as well. */
+	attach_irqstate_test_probes();
+	ret = kunit_add_action_or_reset(test, detach_irqstate_test_probes, NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		return;
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
+	trace_hardirq_context_entry_tp(0);
+	reactions[1] = READ_ONCE(ctx->reactions);
+	reactions[2] = READ_ONCE(ctx->reactions);
+	trace_hardirq_context_exit_tp(0);
+	reactions[3] = READ_ONCE(ctx->reactions);
+	reactions[4] = READ_ONCE(ctx->reactions);
+	trace_softirq_context_entry_tp(false, false);
+	reactions[5] = READ_ONCE(ctx->reactions);
+	reactions[6] = READ_ONCE(ctx->reactions);
+	trace_softirq_context_exit_tp(false, false);
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
+	completed = exercise_irqstate_softirq(IRQSTATE_SOFTIRQ_TRACEPOINT_ONLY);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
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
+	shared_ctx = kunit_kzalloc(test, sizeof(*shared_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, shared_ctx);
+	shared_ctx->actions[0].name = "rv-kunit-none";
+	shared_ctx->actions[1].name = "rv-kunit-handled";
+	shared_ctx->results[0] = IRQ_NONE;
+	shared_ctx->results[1] = IRQ_HANDLED;
+	shared_ctx->irq = 42;
+
+	ret = register_trace_irq_handler_entry(irqstate_shared_action_entry,
+					       shared_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	shared_ctx->entry_attached = true;
+	ret = kunit_add_action_or_reset(test, irqstate_shared_actions_detach,
+					shared_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = register_trace_irq_handler_exit(irqstate_shared_action_exit,
+					      shared_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	shared_ctx->exit_attached = true;
+	attach_irqstate_test_probes();
+	ret = kunit_add_action_or_reset(test, detach_irqstate_test_probes, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	scoped_guard(migrate) {
+		shared_ctx->owner = current;
+		shared_ctx->owner_cpu = raw_smp_processor_id();
+		saved_count = preempt_count();
+		saved_softirq = softirq_count();
+		WRITE_ONCE(shared_ctx->armed, true);
+		local_irq_save(flags);
+		irq_enter_rcu();
+		trace_irq_handler_entry(shared_ctx->irq,
+					&shared_ctx->actions[0]);
+		trace_irq_handler_exit(shared_ctx->irq,
+				       &shared_ctx->actions[0],
+				       shared_ctx->results[0]);
+		trace_irq_handler_entry(shared_ctx->irq,
+					&shared_ctx->actions[1]);
+		trace_irq_handler_exit(shared_ctx->irq,
+				       &shared_ctx->actions[1],
+				       shared_ctx->results[1]);
+		irq_exit_rcu();
+		WRITE_ONCE(shared_ctx->armed, false);
+		local_irq_restore(flags);
+	}
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
+	/* Use only nonfatal checks and normal returns after pinning current. */
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
+	/* Use only nonfatal checks and normal returns after pinning current. */
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
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
+	KUNIT_EXPECT_EQ(test, rx_at_sync, expected);
+	RV_KUNIT_EXPECT_REACTION(test, ctx);
+	expected = ctx->expected;
+	completed = run_irqstate_softirq_case(IRQSTATE_SOFTIRQ_SYNC_INTERRUPTED, &rx_at_sync);
+	KUNIT_EXPECT_TRUE(test, completed);
+	if (!completed)
+		return;
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
+		unregister_trace_softirq_context_entry_tp(irqstate_inline_bh_entry, inline_ctx);
+	if (inline_ctx->exit_attached)
+		unregister_trace_softirq_context_exit_tp(irqstate_inline_bh_exit, inline_ctx);
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
+	ret = register_trace_softirq_context_entry_tp(irqstate_inline_bh_entry,
+						      inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
+						  inline_ctx));
+	ret = register_trace_softirq_context_exit_tp(irqstate_inline_bh_exit,
+						     inline_ctx);
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
+	/* Use only nonfatal checks and normal returns after pinning current. */
+	guard(migrate)();
+	inline_ctx->owner = current;
+	inline_ctx->owner_cpu = raw_smp_processor_id();
+	inline_ctx->softirqd = this_cpu_ksoftirqd();
+	KUNIT_EXPECT_NOT_NULL(test, inline_ctx->softirqd);
+	if (!inline_ctx->softirqd)
+		return;
+	if (local_softirq_pending() ||
+	    !wait_task_inactive(inline_ctx->softirqd, TASK_INTERRUPTIBLE)) {
+		kunit_mark_skipped(test, "Requires an idle local ksoftirqd");
+		return;
+	}
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	local_irq_save(flags);
+	if (local_softirq_pending() || task_is_running(inline_ctx->softirqd)) {
+		local_irq_restore(flags);
+		kunit_mark_skipped(test, "Local ksoftirqd stopped being idle");
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
+		kunit_mark_skipped(test,
+				   "IRQ exit diverted pending softirq to ksoftirqd");
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
+	ret = register_trace_softirq_context_entry_tp(irqstate_inline_bh_entry, inline_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	inline_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqstate_inline_bh_detach,
+						  inline_ctx));
+	ret = register_trace_softirq_context_exit_tp(irqstate_inline_bh_exit, inline_ctx);
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
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires preemptible softirq processing");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	preempt_ctx = kunit_kzalloc(test, sizeof(*preempt_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, preempt_ctx);
+	init_completion(&preempt_ctx->tasklet_done);
+	init_completion(&preempt_ctx->worker_done);
+	worker = kthread_create(irqstate_preempt_worker, preempt_ctx,
+				"irqstate-preempt");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	preempt_ctx->worker = worker;
+	ret = kunit_add_action_or_reset(test, stop_irqstate_preempt_worker,
+					worker);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	attach_irqstate_test_probes();
+	ret = kunit_add_action_or_reset(test, detach_irqstate_test_probes, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	scoped_guard(migrate) {
+		kthread_bind(worker, smp_processor_id());
+		sched_set_fifo(worker);
+		tasklet_setup(&preempt_ctx->tasklet, irqstate_preempt_tasklet);
+		tasklet_schedule(&preempt_ctx->tasklet);
+		completed = wait_for_completion_timeout(&preempt_ctx->tasklet_done,
+							HZ);
+		tasklet_kill(&preempt_ctx->tasklet);
+		if (completed)
+			completed = wait_for_completion_timeout(&preempt_ctx->worker_done,
+								HZ);
+	}
+	KUNIT_ASSERT_NE(test, completed, 0UL);
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
+	int reactions[3];
+	int ret;
+	bool serving;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT serving-softirq accounting");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	attach_irqstate_test_probes();
+	ret = kunit_add_action_or_reset(test, detach_irqstate_test_probes, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+
+	scoped_guard(migrate) {
+		/*
+		 * Keep an outer BH-disable reference so the matching enable of the
+		 * serving reference cannot dispatch pending softirqs. Both references
+		 * use the real RT helpers; no task or per-CPU counter is fabricated.
+		 */
+		local_bh_disable();
+		local_irq_save(flags);
+		irq_enter_rcu();
+		irq_exit_rcu();
+		local_irq_restore(flags);
+
+		/* The same serving-bit transition used by ksoftirqd_run_begin(). */
+		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		serving = !!in_serving_softirq();
+		local_irq_save(flags);
+		irq_enter_rcu();
+		irq_exit_rcu();
+		local_irq_restore(flags);
+		__local_bh_enable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		local_bh_enable();
+
+		reactions[0] = READ_ONCE(ctx->reactions);
+		local_irq_save(flags);
+		__irq_enter_raw();
+		reactions[1] = READ_ONCE(ctx->reactions);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[2] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+	}
+
+	KUNIT_EXPECT_TRUE(test, serving);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	kunit_info(test, "RT preparation IRQ serving=%u restored=%u\n",
+		   serving, preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
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
+	int reactions[3];
+	int ret;
+	bool preempted, serving;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT serving-softirq accounting");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	preempt_ctx = kunit_kzalloc(test, sizeof(*preempt_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, preempt_ctx);
+	init_completion(&preempt_ctx->worker_done);
+	worker = kthread_create(irqstate_preempt_worker, preempt_ctx,
+				"irqstate-prepare");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	ret = kunit_add_action_or_reset(test, stop_irqstate_preempt_worker,
+					worker);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	attach_irqstate_test_probes();
+	ret = kunit_add_action_or_reset(test, detach_irqstate_test_probes, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+
+	scoped_guard(migrate) {
+		kthread_bind(worker, smp_processor_id());
+		sched_set_fifo(worker);
+		local_bh_disable();
+		local_irq_save(flags);
+		irq_enter_rcu();
+		irq_exit_rcu();
+		local_irq_restore(flags);
+		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		serving = !!in_serving_softirq();
+		wake_up_process(worker);
+		preempted = completion_done(&preempt_ctx->worker_done);
+		__local_bh_enable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		local_bh_enable();
+
+		completed = wait_for_completion_timeout(&preempt_ctx->worker_done,
+							HZ);
+		reactions[0] = READ_ONCE(ctx->reactions);
+		local_irq_save(flags);
+		__irq_enter_raw();
+		reactions[1] = READ_ONCE(ctx->reactions);
+		rv_irqstate_ops.handle_hardirq_exit(NULL, 1);
+		reactions[2] = READ_ONCE(ctx->reactions);
+		__irq_exit_raw();
+		local_irq_restore(flags);
+	}
+	KUNIT_EXPECT_NE(test, completed, 0);
+	KUNIT_EXPECT_TRUE(test, serving);
+	KUNIT_EXPECT_TRUE(test, preempted);
+	KUNIT_EXPECT_FALSE(test, preempt_ctx->worker_in_softirq);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	kunit_info(test, "RT preparation switch serving=%u preempted=%u worker_serving=%u restored=%u\n",
+		   serving, preempted, preempt_ctx->worker_in_softirq,
+		   preempt_count() == saved_count && softirq_count() == saved_softirq);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[0], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[1], 0);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, reactions[2], 1);
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

