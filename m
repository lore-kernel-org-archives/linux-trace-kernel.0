Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CD1B87F0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313222; cv=none; b=kl4jOvsvsSHH0HxQUYbjn+3pQ67fzBx2X2r9LvQr5rBOB6odIYlrUr6tA/VkMGKSAqEbcwkhkIHz0ZrsCDWiFwO70qaVzxYUSz3cedGSM1L/1uxuT0aYOoRi0lRUCFU8DrmAKYUQyEoGKl86tzWPjGDhKR3EICcrdOk6wEwCgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313222; c=relaxed/simple;
	bh=pb209bXaugEvQjg2MuIrZK2EF+7xdDuFhOeXfAta4ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7lF/16rLrZn0j04nvpsLtYAp65UqbkYflkcNbgAPsPUpPjwbeSvmqFk2Bf0u2CeLTKntOEzpImep7ZyQAswO18xRfhDCqOtFGpLNigWj2GCUqYhED7x4e/I7v+KY8Y2zQn9sw+En7o0QnCUITk3mlyaGF45UNS0xPwT6WrBuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKlekG/6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKlekG/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751313219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fb7vbgp9yWJFAfr2LZ2H/YK07/bv8dqvyUraYZjnSI=;
	b=GKlekG/6s7tJTyT5k2SAp0cP3Oxj9f7U96iPkJQgLVrjnKbz+msbI5pkiALmpxwt/c5/0+
	sMLkIgkvdePu6EP95faDGQsMTVE30/9mucWOEw5Wdzp16VHil87r7vvV/UvWZ+1T68GXJY
	kE8aimnmVOL4PtlGD8kBgRxobiSvMlg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-vfYpM8YzPHGCdd--bkl8OQ-1; Mon,
 30 Jun 2025 15:53:36 -0400
X-MC-Unique: vfYpM8YzPHGCdd--bkl8OQ-1
X-Mimecast-MFC-AGG-ID: vfYpM8YzPHGCdd--bkl8OQ_1751313214
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03B6A180029F;
	Mon, 30 Jun 2025 19:53:34 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.65.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF03719560A7;
	Mon, 30 Jun 2025 19:53:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 2/2] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
Date: Mon, 30 Jun 2025 16:52:39 -0300
Message-ID: <20250630195243.701516-3-wander@redhat.com>
In-Reply-To: <20250630195243.701516-1-wander@redhat.com>
References: <20250630195243.701516-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Similar to the IRQ tracepoint, the preempt tracepoints are typically
disabled in production systems due to the significant overhead they
introduce even when not in use.

The overhead primarily comes from two sources: First, when tracepoints
are compiled into the kernel, preempt_count_add() and preempt_count_sub()
become external function calls rather than inlined operations. Second,
these functions perform unnecessary preempt_count() checks even when the
tracepoint itself is disabled.

This optimization introduces an early check of the tracepoint static key,
which allows us to skip both the function call overhead and the redundant
preempt_count() checks when tracing is disabled. The change maintains all
existing functionality when tracing is active while significantly
reducing overhead for the common case where tracing is inactive.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/preempt.h         | 35 ++++++++++++++++++++++++++++++---
 kernel/sched/core.c             | 12 +----------
 kernel/trace/trace_preemptirq.c | 19 ++++++++++++++++++
 3 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b0af8d4ef6e6..d13c755cd934 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 #include <linux/cleanup.h>
 #include <linux/types.h>
+#include <linux/tracepoint-defs.h>
 
 /*
  * We put the hardirq and softirq counter into the preemption
@@ -191,17 +192,45 @@ static __always_inline unsigned char interrupt_context_level(void)
  */
 #define in_atomic_preempt_off() (preempt_count() != PREEMPT_DISABLE_OFFSET)
 
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+#if defined(CONFIG_DEBUG_PREEMPT)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
-#define preempt_count_dec_and_test() \
-	({ preempt_count_sub(1); should_resched(0); })
+#elif defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+extern void __trace_preempt_on(void);
+extern void __trace_preempt_off(void);
+
+DECLARE_TRACEPOINT(preempt_enable);
+DECLARE_TRACEPOINT(preempt_disable);
+
+#define __preempt_trace_enabled(type) \
+	(tracepoint_enabled(preempt_##type) && preempt_count() == val)
+
+static inline void preempt_count_add(int val)
+{
+	__preempt_count_add(val);
+
+	if (__preempt_trace_enabled(disable))
+		__trace_preempt_off();
+}
+
+static inline void preempt_count_sub(int val)
+{
+	if (__preempt_trace_enabled(enable))
+		__trace_preempt_on();
+
+	__preempt_count_sub(val);
+}
 #else
 #define preempt_count_add(val)	__preempt_count_add(val)
 #define preempt_count_sub(val)	__preempt_count_sub(val)
 #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
 #endif
 
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+#define preempt_count_dec_and_test() \
+	({ preempt_count_sub(1); should_resched(0); })
+#endif
+
 #define __preempt_count_inc() __preempt_count_add(1)
 #define __preempt_count_dec() __preempt_count_sub(1)
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8988d38d46a3..4feba4738d79 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5840,8 +5840,7 @@ static inline void sched_tick_start(int cpu) { }
 static inline void sched_tick_stop(int cpu) { }
 #endif
 
-#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
+#if defined(CONFIG_PREEMPTION) && defined(CONFIG_DEBUG_PREEMPT)
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
@@ -5850,30 +5849,24 @@ static inline void preempt_latency_start(int val)
 {
 	if (preempt_count() == val) {
 		unsigned long ip = get_lock_parent_ip();
-#ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
-#endif
 		trace_preempt_off(CALLER_ADDR0, ip);
 	}
 }
 
 void preempt_count_add(int val)
 {
-#ifdef CONFIG_DEBUG_PREEMPT
 	/*
 	 * Underflow?
 	 */
 	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
 		return;
-#endif
 	__preempt_count_add(val);
-#ifdef CONFIG_DEBUG_PREEMPT
 	/*
 	 * Spinlock count overflowing soon?
 	 */
 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
 				PREEMPT_MASK - 10);
-#endif
 	preempt_latency_start(val);
 }
 EXPORT_SYMBOL(preempt_count_add);
@@ -5891,7 +5884,6 @@ static inline void preempt_latency_stop(int val)
 
 void preempt_count_sub(int val)
 {
-#ifdef CONFIG_DEBUG_PREEMPT
 	/*
 	 * Underflow?
 	 */
@@ -5903,14 +5895,12 @@ void preempt_count_sub(int val)
 	if (DEBUG_LOCKS_WARN_ON((val < PREEMPT_MASK) &&
 			!(preempt_count() & PREEMPT_MASK)))
 		return;
-#endif
 
 	preempt_latency_stop(val);
 	__preempt_count_sub(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
 NOKPROBE_SYMBOL(preempt_count_sub);
-
 #else
 static inline void preempt_latency_start(int val) { }
 static inline void preempt_latency_stop(int val) { }
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 90ee65db4516..deb2428b34a2 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -118,6 +118,25 @@ EXPORT_TRACEPOINT_SYMBOL(irq_enable);
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
 
+#if !defined(CONFIG_DEBUG_PREEMPT)
+EXPORT_SYMBOL(__tracepoint_preempt_disable);
+EXPORT_SYMBOL(__tracepoint_preempt_enable);
+
+void __trace_preempt_on(void)
+{
+	trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+}
+EXPORT_SYMBOL(__trace_preempt_on);
+NOKPROBE_SYMBOL(__trace_preempt_on);
+
+void __trace_preempt_off(void)
+{
+	trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
+}
+EXPORT_SYMBOL(__trace_preempt_off);
+NOKPROBE_SYMBOL(__trace_preempt_off);
+#endif /* !CONFIG_DEBUG_PREEMPT */
+
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
 	trace(preempt_enable, TP_ARGS(a0, a1));
-- 
2.50.0

