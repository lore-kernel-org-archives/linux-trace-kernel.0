Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371E13DDAA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234149; cv=none; b=l3CVGMiksfR7LFP8wf1im1shlqW5I4dmok67Fh6L+W6qG64m0uElst2hn8Q2NkAmpqAz1JZU+ipep7dfMEUauxV2Ti7O54cLzo369CIHLgDGgGDfk4MVBmhi93444NUEuKiA7yrd1LEKGer9c0Md4X3nvmR9AQs5gUtffqguxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234149; c=relaxed/simple;
	bh=alxhS5zNt5yhZDlpWUot0Dy3jmoiPvwWrfIvY63/tcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IfUH51GWtDYPa1EZHhwbIb71PFYthXNmhCsi/2evkf4T/tg6+6QXw9UiVn4NVVvwyAYnTalFZ3Q9+3s5+zpaPKPaIMKHnhyq17T0/BY9VHU2QbYg7hwxXb7Lt32KVRdCP2D2/EEpLyQDENfcSoivSc7m3QuW6T1yO+1O2f2NUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jgy74awE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jgy74awE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773234146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDwbdAOWQrkyyH+jPzV483o27gJ9IQVrrz9O2kAMCZY=;
	b=Jgy74awEHX3c5ZXzGgOIaB9c/oSzRBZDP2FwEVP3PysbYYO0BAvnADroL86WfnAA2XK9Sb
	WF3KYaMrFf0I7wC928d47BC/TAhx1vzowuSnipd3gsumOyS0en8rta3KADWg47Yq2yCXk0
	MoQAkUf5xBA/yZu7wDjX9RpVYOfAkd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-pe716fNZPJqrBdtiFVtqJQ-1; Wed,
 11 Mar 2026 09:02:23 -0400
X-MC-Unique: pe716fNZPJqrBdtiFVtqJQ-1
X-Mimecast-MFC-AGG-ID: pe716fNZPJqrBdtiFVtqJQ_1773234140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F26DA19560B5;
	Wed, 11 Mar 2026 13:02:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.206])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63EFE3000223;
	Wed, 11 Mar 2026 13:02:12 +0000 (UTC)
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: acme@kernel.org,
	williams@redhat.com,
	gmonaco@redhat.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 1/4] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
Date: Wed, 11 Mar 2026 09:50:15 -0300
Message-ID: <20260311125021.197638-2-wander@redhat.com>
In-Reply-To: <20260311125021.197638-1-wander@redhat.com>
References: <20260311125021.197638-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: u3u5PiB5Mnof6J0Etk9h1UrKrspUezW4R1FUoMxVLTI_1773234140
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When CONFIG_TRACE_PREEMPT_TOGGLE is enabled, preempt_count_add() and
preempt_count_sub() become external function calls (defined in
kernel/sched/core.c) rather than inlined operations. These functions
also perform preempt_count() checks and call trace_preempt_on/off()
unconditionally, even when no tracing consumer is active.

Reduce this overhead by splitting the #if logic in preempt.h into
three cases. When CONFIG_DEBUG_PREEMPT or CONFIG_PREEMPT_TRACER is
set, keep external function calls because DEBUG_PREEMPT needs runtime
validation checks, and PREEMPT_TRACER needs the preemptoff latency
tracer hooks (tracer_preempt_on/off, called via trace_preempt_on/off).
When CONFIG_TRACE_PREEMPT_TOGGLE alone is set, provide new inline
versions of preempt_count_add/sub() that check the tracepoint static
key via the __preempt_trace_enabled() macro before calling into the
tracing path. The macro evaluates to true when the preempt_enable or
preempt_disable tracepoint has subscribers AND the preempt count
equals val (indicating the first preempt disable or last preempt
enable), preserving the original preempt_latency_start/stop semantics.
When none of the above are set, use pure inline macros with no tracing
overhead.

The preempt_count_dec_and_test() macro is refactored out of the
three-way #if into a separate block shared by the first two cases,
since both need it to call the (potentially inline)
preempt_count_sub() before checking should_resched().

The inline path calls thin __trace_preempt_on/off() wrappers (added
in trace_preemptirq.c) that invoke trace_preempt_on/off(), keeping
the full tracepoint machinery out of the inline code.

The #include <linux/tracepoint-defs.h> is placed inside the
CONFIG_TRACE_PREEMPT_TOGGLE block rather than at the top of the file
to avoid a circular include dependency on architectures where
asm/irqflags.h includes linux/preempt.h (e.g. m68k):

  preempt.h -> tracepoint-defs.h -> static_key.h -> jump_label.h ->
  atomic.h -> irqflags.h -> asm/irqflags.h -> preempt.h (guarded)

If the include were at the top, this chain would be traversed before
hardirq_count() is defined (at line 110), causing a build failure on
m68k. Placing it inside the #elif block ensures it is only pulled in
when CONFIG_TRACE_PREEMPT_TOGGLE is enabled and avoids the cycle for
configurations that do not select it.

In core.c, narrow the compilation guard for the external
preempt_count_add/sub() from CONFIG_DEBUG_PREEMPT ||
CONFIG_TRACE_PREEMPT_TOGGLE to CONFIG_DEBUG_PREEMPT ||
CONFIG_PREEMPT_TRACER, since CONFIG_TRACE_PREEMPT_TOGGLE is now
handled inline.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/preempt.h         | 49 +++++++++++++++++++++++++++++++--
 kernel/sched/core.c             |  2 +-
 kernel/trace/trace_preemptirq.c | 19 +++++++++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d964f965c8ffc..f59a92f930d81 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -189,17 +189,60 @@ static __always_inline unsigned char interrupt_context_level(void)
  */
 #define in_atomic_preempt_off() (preempt_count() != PREEMPT_DISABLE_OFFSET)
 
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
-#define preempt_count_dec_and_test() \
-	({ preempt_count_sub(1); should_resched(0); })
+#elif defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+/*
+ * Avoid the circular dependency on architectures where asm/irqflags.h
+ * includes linux/preempt.h (e.g. m68k):
+ *
+ * preempt.h <--------------------+
+ *  tracepoint-defs.h             |
+ *   static_key.h                 |
+ *    jump_label.h                |
+ *     atomic.h                   |
+ *      irqflags.h                |
+ *       asm/irqflags.h           |
+ *        preempt.h --------------+
+ */
+#include <linux/tracepoint-defs.h>
+
+extern void __trace_preempt_on(void);
+extern void __trace_preempt_off(void);
+
+DECLARE_TRACEPOINT(preempt_enable);
+DECLARE_TRACEPOINT(preempt_disable);
+
+#define __preempt_trace_enabled(type, val) \
+	(tracepoint_enabled(preempt_##type) && preempt_count() == (val))
+
+static __always_inline void preempt_count_add(int val)
+{
+	__preempt_count_add(val);
+
+	if (__preempt_trace_enabled(disable, val))
+		__trace_preempt_off();
+}
+
+static __always_inline void preempt_count_sub(int val)
+{
+	if (__preempt_trace_enabled(enable, val))
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
index b7f77c165a6e0..125e5d71d1bd3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5733,7 +5733,7 @@ static inline void sched_tick_stop(int cpu) { }
 #endif /* !CONFIG_NO_HZ_FULL */
 
 #if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
+				   defined(CONFIG_PREEMPT_TRACER))
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 0c42b15c38004..9f098fcb28012 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -115,6 +115,25 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
 
+#if !defined(CONFIG_DEBUG_PREEMPT) && !defined(CONFIG_PREEMPT_TRACER)
+EXPORT_TRACEPOINT_SYMBOL(preempt_disable);
+EXPORT_TRACEPOINT_SYMBOL(preempt_enable);
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
2.53.0

