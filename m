Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2820B7E0;
	Wed,  4 Dec 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324653; cv=none; b=HjXRgV0QH3xZ5pr0Rl38XNdtyswbOm0qKKRnsegtQ7MTZ+t4vkCH85osVahInQa69aFuuYZZCLEqWmzg2O6NjBwj99/CxGLhFlGsj1pk8rJN84I9KZ6RZ8NfD83aYEVWFubHwToktsJ7ehQRD4+7zTSwBFRbWKjCygx7UT7GPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324653; c=relaxed/simple;
	bh=L1/USE0+lkG3io4fQUeuoZjFcccCvhDD/C55n8bbZcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tJ1cmrdhDE6MOqJGLWeH6OxwDRlAIC99lSXr1WaZBJmfucRTMmwvm0BJSTbGwAhobAYro2+vKqY78TzykystOQ8rC4+6K3PY9cpvpazgT+SZyglAf0eFYxdafxDcZAbPpws7sjywsZkihakWdfBPNXlFKNnQblLu9VMyEL4wZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476C9C4CECD;
	Wed,  4 Dec 2024 15:04:12 +0000 (UTC)
Date: Wed, 4 Dec 2024 10:04:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tracing: Fix archs that still call tracepoints without RCU
 watching
Message-ID: <20241204100414.4d3e06d0@gandalf.local.home>
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

Tracepoints require having RCU "watching" as it uses RCU to do updates to
the tracepoints. There are some cases that would call a tracepoint when
RCU was not "watching". This was usually in the idle path where RCU has
"shutdown". For the few locations that had tracepoints without RCU
watching, there was an trace_*_rcuidle() variant that could be used. This
used SRCU for protection.

There are tracepoints that trace when interrupts and preemption are
enabled and disabled. In some architectures, these tracepoints are called
in a path where RCU is not watching. When x86 and arm64 removed these
locations, it was incorrectly assumed that it would be safe to remove the
trace_*_rcuidle() variant and also remove the SRCU logic, as it made the
code more complex and harder to implement new tracepoint features (like
faultable tracepoints and tracepoints in rust).

Instead of bringing back the trace_*_rcuidle(), as it will not be trivial
to do as new code has already been added depending on its removal, add a
workaround to the one file that still requires it (trace_preemptirq.c). If
the architecture does not define CONFIG_ARCH_WANTS_NO_INSTR, then check if
the code is in the idle path, and if so, call ct_irq_enter/exit() which
will enable RCU around the tracepoint.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")
Closes: https://lore.kernel.org/all/bddb02de-957a-4df5-8e77-829f55728ea2@roeck-us.net/
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_preemptirq.c | 43 ++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 5c03633316a6..0c42b15c3800 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -10,11 +10,42 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/hardirq.h>
 #include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
+/*
+ * Use regular trace points on architectures that implement noinstr
+ * tooling: these calls will only happen with RCU enabled, which can
+ * use a regular tracepoint.
+ *
+ * On older architectures, RCU may not be watching in idle. In that
+ * case, wake up RCU to watch while calling the tracepoint. These
+ * aren't NMI-safe - so exclude NMI contexts:
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point, args)	trace_##point(args)
+#else
+#define trace(point, args)					\
+	do {							\
+		if (trace_##point##_enabled()) {		\
+			bool exit_rcu = false;			\
+			if (in_nmi())				\
+				break;				\
+			if (!IS_ENABLED(CONFIG_TINY_RCU) &&	\
+			    is_idle_task(current)) {		\
+				ct_irq_enter();			\
+				exit_rcu = true;		\
+			}					\
+			trace_##point(args);			\
+			if (exit_rcu)				\
+				ct_irq_exit();			\
+		}						\
+	} while (0)
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
@@ -28,7 +59,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -39,7 +70,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -61,7 +92,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}
 
 }
@@ -75,7 +106,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
@@ -86,13 +117,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_enable(a0, a1);
+	trace(preempt_enable, TP_ARGS(a0, a1));
 	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_disable(a0, a1);
+	trace(preempt_disable, TP_ARGS(a0, a1));
 	tracer_preempt_off(a0, a1);
 }
 #endif
-- 
2.45.2

