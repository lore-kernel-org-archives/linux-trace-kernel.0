Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF713DDAA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234172; cv=none; b=JphfhheM3SbA5GuZsP2yfvUvj4eMtWah3YF01x/W9DTrMzfkAXCketbgqqE8ZznLfQmqPjibLHQb+VEj/54KlErWrxltdUBELahkUbdmJpU8rc40o5ciu0JhuFgNh+eLTsFQsZdq4pdah36pdhFeO6lPG5uqdO7bHws1qOubkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234172; c=relaxed/simple;
	bh=teOn68X+rakWXclwQ/xGoKsS+finLnzl7W/8Tq2j3iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sJgN6cqa5Ts7uYjtcjQr1+Z+NbZLDJTLM3vqXG4yvmedUhuSynyVUr3BgonnFTXA3cG+Ow9wF8galrP21C+jdBCYm0iheFyTg3z0oiMJN/kTset/hTEYcC32Mdx1Sh69KAZ8+YBRGxHX5k8+d3BgdQRApmyHHwwFvjdnwswxlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWgFThcn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWgFThcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773234169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG7jO0eAaiDEl9f2zxR5XHew37Lwbqb6vu7OXKvAPhs=;
	b=gWgFThcnzaVVoIiEzToo3Q1jQK79bWBGZ0OnfQeApNSy/sJwuLu7nO6dnhcN2TjzKazog8
	rT/fWvtxbczvndUvOP29fA5GCKEEBTQVysL9ys74sJQdbjceottnZI9CyHjgkm9LaX4ZII
	hqKSHTIRi3neo3VXW9lnvda96Vz+UcQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-6iQr92ouPRuJFhOaAojBHg-1; Wed,
 11 Mar 2026 09:02:45 -0400
X-MC-Unique: 6iQr92ouPRuJFhOaAojBHg-1
X-Mimecast-MFC-AGG-ID: 6iQr92ouPRuJFhOaAojBHg_1773234162
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57930180035C;
	Wed, 11 Mar 2026 13:02:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.206])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 286E83000223;
	Wed, 11 Mar 2026 13:02:35 +0000 (UTC)
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
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: acme@kernel.org,
	williams@redhat.com,
	gmonaco@redhat.com
Subject: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Date: Wed, 11 Mar 2026 09:50:18 -0300
Message-ID: <20260311125021.197638-5-wander@redhat.com>
In-Reply-To: <20260311125021.197638-1-wander@redhat.com>
References: <20260311125021.197638-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: aTkX3vkgLH6ov__x-oBoZxF5J0Sz5WdpKSYgbSUv7o4_1773234162
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The previous commit introduced the CONFIG_TRACE_IRQFLAGS_TOGGLE symbol.
This patch implements the actual infrastructure to allow tracing
irq_disable and irq_enable events without pulling in the heavy
CONFIG_TRACE_IRQFLAGS dependencies like lockdep or the irqsoff tracer.

The implementation hooks into the local_irq_* macros in irqflags.h.
Instead of using the heavy trace_hardirqs_on/off calls, it uses
lightweight tracepoint_enabled() checks. If the tracepoint is enabled,
it calls into specific wrapper functions in trace_preemptirq.c.

These wrappers check the raw hardware state via raw_irqs_disabled() to
filter out redundant events, such as disabling interrupts when they
are already disabled. This approach is simpler than the full
TRACE_IRQFLAGS method which requires maintaining a per-cpu software
state variable.

To support this, the tracepoint definitions are exposed under the new
configuration. Additionally, a circular header dependency involving
irqflags.h, tracepoint-defs.h, and atomic.h is resolved by moving the
atomic.h inclusion to tracepoint.h, allowing irqflags.h to include
tracepoint-defs.h safely.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 include/linux/irqflags.h          | 62 ++++++++++++++++++++++++++++++-
 include/linux/tracepoint-defs.h   |  1 -
 include/linux/tracepoint.h        |  1 +
 include/trace/events/preemptirq.h |  2 +-
 kernel/trace/trace_preemptirq.c   | 49 ++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbbb..f40557bebd325 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -18,6 +18,19 @@
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
+/*
+ * Avoid the circular dependency
+ * irqflags.h <-----------------+
+ *   tracepoint_defs.h          |
+ *     static_key.h             |
+ *       jump_label.h           |
+ *         atomic.h             |
+ *           cmpxchg.h ---------+
+ */
+#ifdef CONFIG_TRACE_IRQFLAGS_TOGGLE
+#include <linux/tracepoint-defs.h>
+#endif
+
 struct task_struct;
 
 /* Currently lockdep_softirqs_on/off is used only by lockdep */
@@ -232,7 +245,54 @@ extern void warn_bogus_irq_restore(void);
 	} while (0)
 
 
-#else /* !CONFIG_TRACE_IRQFLAGS */
+#elif defined(CONFIG_TRACE_IRQFLAGS_TOGGLE) /* !CONFIG_TRACE_IRQFLAGS */
+
+DECLARE_TRACEPOINT(irq_enable);
+DECLARE_TRACEPOINT(irq_disable);
+
+void trace_local_irq_enable(void);
+void trace_local_irq_disable(void);
+void trace_local_irq_save(unsigned long flags);
+void trace_local_irq_restore(unsigned long flags);
+void trace_safe_halt(void);
+
+#define local_irq_enable()				\
+	do {						\
+		if (tracepoint_enabled(irq_enable))	\
+			trace_local_irq_enable();	\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		if (tracepoint_enabled(irq_disable))	\
+			trace_local_irq_disable();	\
+		else					\
+			raw_local_irq_disable();	\
+	} while (0)
+
+#define local_irq_save(flags)				\
+	do {						\
+		raw_local_irq_save(flags);		\
+		if (tracepoint_enabled(irq_disable))	\
+			trace_local_irq_save(flags);	\
+	} while (0)
+
+#define local_irq_restore(flags)			\
+	do {						\
+		if (tracepoint_enabled(irq_enable))	\
+			trace_local_irq_restore(flags); \
+		raw_local_irq_restore(flags);		\
+	} while (0)
+
+#define safe_halt()					\
+	do {						\
+		if (tracepoint_enabled(irq_enable))	\
+			trace_safe_halt();		\
+		raw_safe_halt();			\
+	} while (0)
+
+#else /* !CONFIG_TRACE_IRQFLAGS_TOGGLE */
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index aebf0571c736e..cb1f15a4e43f0 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -8,7 +8,6 @@
  * trace_print_flags{_u64}. Otherwise linux/tracepoint.h should be used.
  */
 
-#include <linux/atomic.h>
 #include <linux/static_key.h>
 
 struct static_call_key;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f32..e7d8c5ca00c79 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <linux/atomic.h>
 
 struct module;
 struct tracepoint;
diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index f99562d2b496b..a607a6f4e29ca 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -32,7 +32,7 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
 );
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_TRACE_IRQFLAGS_TOGGLE)
 DEFINE_EVENT(preemptirq_template, irq_disable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 9f098fcb28012..0f32da96d2f01 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -111,8 +111,57 @@ void trace_hardirqs_off(void)
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
+
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
+#ifdef CONFIG_TRACE_IRQFLAGS_TOGGLE
+EXPORT_TRACEPOINT_SYMBOL(irq_disable);
+EXPORT_TRACEPOINT_SYMBOL(irq_enable);
+
+void trace_local_irq_enable(void)
+{
+	if (raw_irqs_disabled())
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
+}
+EXPORT_SYMBOL(trace_local_irq_enable);
+NOKPROBE_SYMBOL(trace_local_irq_enable);
+
+void trace_local_irq_disable(void)
+{
+	const bool was_disabled = raw_irqs_disabled();
+
+	raw_local_irq_disable();
+	if (!was_disabled)
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
+}
+EXPORT_SYMBOL(trace_local_irq_disable);
+NOKPROBE_SYMBOL(trace_local_irq_disable);
+
+void trace_local_irq_save(unsigned long flags)
+{
+	if (!raw_irqs_disabled_flags(flags))
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
+}
+EXPORT_SYMBOL(trace_local_irq_save);
+NOKPROBE_SYMBOL(trace_local_irq_save);
+
+void trace_local_irq_restore(unsigned long flags)
+{
+	if (!raw_irqs_disabled_flags(flags) && raw_irqs_disabled())
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
+}
+EXPORT_SYMBOL(trace_local_irq_restore);
+NOKPROBE_SYMBOL(trace_local_irq_restore);
+
+void trace_safe_halt(void)
+{
+	if (raw_irqs_disabled())
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
+}
+EXPORT_SYMBOL(trace_safe_halt);
+NOKPROBE_SYMBOL(trace_safe_halt);
+#endif /* CONFIG_TRACE_IRQFLAGS_TOGGLE */
+
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
 
 #if !defined(CONFIG_DEBUG_PREEMPT) && !defined(CONFIG_PREEMPT_TRACER)
-- 
2.53.0

