Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91861EF1D;
	Thu,  3 Oct 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993736; cv=none; b=WRTgj1sWySXEBxbMvMJHZJK20l3wtNl3W5xujDe7PLDAR0Tj1WYkEU6MXStafg0we74ymikanZuPLW1z5VbBIYpbH1lqOuDJ+pvrtj98wxWuINWrB4qYrwrdhsFcGSjmAFkt84Jjz3bHLBofTQ31MxBBY57MmbSlrlQHzI2+yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993736; c=relaxed/simple;
	bh=bva50mX1RohmOgdkHVY9OIZ0d5em0RBGq2oGCuB0zNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V+9mkUjbYHePoPTYUQPXuuhbG8bXdsmDASsdTv5xMlvFM6INWnr88QhFMHnQ2EyYe4waR0kP9OHQk/tYIzhal0PgXbTQPO16FHF8u7aet2KjdjDssTGcamkhWBVL5mO5BFtkQO+lC0bci0ffgRGG0LXKO7D2Zik4pS2APdl5i2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E8DC4CEC5;
	Thu,  3 Oct 2024 22:15:35 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:16:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
 <joel@joelfernandes.org>
Subject: [PATCH v2] tracing: Remove definition of trace_*_rcuidle()
Message-ID: <20241003181629.36209057@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The trace_*_rcuidle() variant of a tracepoint was to handle places where a
tracepoint was located but RCU was not "watching". All those locations
have been removed, and RCU should be watching where all tracepoints are
located. We can now remove the trace_*_rcuidle() variant.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20241003173051.6b178bb3@gandalf.local.home

- Silly me didn't remove the rcuidle logic from __DO_TRACE()

 include/linux/tracepoint.h        | 50 ++-----------------------------
 include/trace/events/preemptirq.h |  8 -----
 kernel/trace/trace_preemptirq.c   | 26 ++++------------
 scripts/tags.sh                   |  2 --
 4 files changed, 8 insertions(+), 78 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 93a9f3070b48..9b85a02b8575 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -196,67 +196,25 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DO_TRACE_CALL(name, args)	__traceiter_##name(NULL, args)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-/*
- * ARCH_WANTS_NO_INSTR archs are expected to have sanitized entry and idle
- * code that disallow any/all tracing/instrumentation when RCU isn't watching.
- */
-#ifdef CONFIG_ARCH_WANTS_NO_INSTR
-#define RCUIDLE_COND(rcuidle)	(rcuidle)
-#else
-/* srcu can't be used from NMI */
-#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
-#endif
-
 /*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
-#define __DO_TRACE(name, args, cond, rcuidle)				\
+#define __DO_TRACE(name, args, cond)					\
 	do {								\
 		int __maybe_unused __idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
 									\
-		if (WARN_ONCE(RCUIDLE_COND(rcuidle),			\
-			      "Bad RCU usage for tracepoint"))		\
-			return;						\
-									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
-		/*							\
-		 * For rcuidle callers, use srcu since sched-rcu	\
-		 * doesn't work from the idle path.			\
-		 */							\
-		if (rcuidle) {						\
-			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			ct_irq_enter_irqson();				\
-		}							\
-									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
-		if (rcuidle) {						\
-			ct_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
-									\
 		preempt_enable_notrace();				\
 	} while (0)
 
-#ifndef MODULE
-#define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
-	static inline void trace_##name##_rcuidle(proto)		\
-	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
-	}
-#else
-#define __DECLARE_TRACE_RCU(name, proto, args, cond)
-#endif
-
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -277,14 +235,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+				TP_CONDITION(cond));			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
 	}								\
-	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-			    PARAMS(cond))				\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -375,8 +331,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
-	static inline void trace_##name##_rcuidle(proto)		\
-	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 3f249e150c0c..f99562d2b496 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -43,8 +43,6 @@ DEFINE_EVENT(preemptirq_template, irq_enable,
 #else
 #define trace_irq_enable(...)
 #define trace_irq_disable(...)
-#define trace_irq_enable_rcuidle(...)
-#define trace_irq_disable_rcuidle(...)
 #endif
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
@@ -58,8 +56,6 @@ DEFINE_EVENT(preemptirq_template, preempt_enable,
 #else
 #define trace_preempt_enable(...)
 #define trace_preempt_disable(...)
-#define trace_preempt_enable_rcuidle(...)
-#define trace_preempt_disable_rcuidle(...)
 #endif
 
 #endif /* _TRACE_PREEMPTIRQ_H */
@@ -69,10 +65,6 @@ DEFINE_EVENT(preemptirq_template, preempt_enable,
 #else /* !CONFIG_PREEMPTIRQ_TRACEPOINTS */
 #define trace_irq_enable(...)
 #define trace_irq_disable(...)
-#define trace_irq_enable_rcuidle(...)
-#define trace_irq_disable_rcuidle(...)
 #define trace_preempt_enable(...)
 #define trace_preempt_disable(...)
-#define trace_preempt_enable_rcuidle(...)
-#define trace_preempt_disable_rcuidle(...)
 #endif
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index e37446f7916e..5c03633316a6 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -15,20 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
-/*
- * Use regular trace points on architectures that implement noinstr
- * tooling: these calls will only happen with RCU enabled, which can
- * use a regular tracepoint.
- *
- * On older architectures, use the rcuidle tracing methods (which
- * aren't NMI-safe - so exclude NMI contexts):
- */
-#ifdef CONFIG_ARCH_WANTS_NO_INSTR
-#define trace(point)	trace_##point
-#else
-#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
-#endif
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
@@ -42,7 +28,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
+		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -53,7 +39,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
+		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -75,7 +61,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
+		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 }
@@ -89,7 +75,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
+		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
@@ -100,13 +86,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	trace(preempt_enable)(a0, a1);
+	trace_preempt_enable(a0, a1);
 	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	trace(preempt_disable)(a0, a1);
+	trace_preempt_disable(a0, a1);
 	tracer_preempt_off(a0, a1);
 }
 #endif
diff --git a/scripts/tags.sh b/scripts/tags.sh
index 191e0461d6d5..0d01c1cafb70 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -152,9 +152,7 @@ regex_c=(
 	'/^BPF_CALL_[0-9]([[:space:]]*\([[:alnum:]_]*\).*/\1/'
 	'/^COMPAT_SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/compat_sys_\1/'
 	'/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
-	'/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
 	'/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
-	'/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
 	'/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/get_\1_slot/'
 	'/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/free_\1_slot/'
 	'/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
-- 
2.45.2

