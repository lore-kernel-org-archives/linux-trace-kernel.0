Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C827467B;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480149; cv=none; b=QbnXm2rowJBVVX/UIdCvA9YVF5FX/AHLLFT2Z15Xh49BWVxoBKTJyKXXzvfNxI+jLGR9mqunQwUtJeg6YojHFIP2cvqVE74/jlMbtdy7toyGYbw/3NyYPCoZago1trMT26gwarYNf2axfEuAEot+/1BxDrp8GHIyHIFVqGehHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480149; c=relaxed/simple;
	bh=PD0PEZGjhOGV9Ehhf7jbkf7/uE2maQPnTBmxaJdraT4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eteq1++QNWFFBiKg3P44GYTGxjCZU3+s0Ig5+pFY++G1WHXgswKD4hMKTbHrA/WXtDjqcj9X+ilKEnK3WYhs6Sw4Iru09LCA7MPj32uwwhUiwWUOXOX2QJF/ESaycX/i9Jl3UaTzOKJ+We8rdmID6ea0TPBTqILX5fuFmYtW0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4A0C4AF09;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gl-00000000yEE-3cXe;
	Mon, 05 May 2025 17:22:35 -0400
Message-ID: <20250505212235.715752008@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 07/13] ftrace: Do not disabled function graph based on "disabled" field
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The per CPU "disabled" value was the original way to disable tracing when
the tracing subsystem was first created. Today, the ring buffer
infrastructure has its own way to disable tracing. In fact, things have
changed so much since 2008 that many things ignore the disable flag.

Do not bother disabling the function graph tracer if the per CPU disabled
field is set. Just record as normal. If tracing is disabled in the ring
buffer it will not be recorded.

Also, when tracing is enabled again, it will not drop the return call of
the function.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 38 +++++++---------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 0c357a89c58e..9234e2c39abf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -202,12 +202,9 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
-	struct trace_array_cpu *data;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
-	long disabled;
 	int ret = 0;
-	int cpu;
 
 	if (*task_var & TRACE_GRAPH_NOTRACE)
 		return 0;
@@ -257,21 +254,14 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 	if (tracing_thresh)
 		return 1;
 
-	preempt_disable_notrace();
-	cpu = raw_smp_processor_id();
-	data = per_cpu_ptr(tr->array_buffer.data, cpu);
-	disabled = atomic_read(&data->disabled);
-	if (likely(!disabled)) {
-		trace_ctx = tracing_gen_ctx();
-		if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
-		    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
-			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
-			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
-		} else {
-			ret = __graph_entry(tr, trace, trace_ctx, fregs);
-		}
+	trace_ctx = tracing_gen_ctx();
+	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
+	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
+		unsigned long retaddr = ftrace_graph_top_ret_addr(current);
+		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
+	} else {
+		ret = __graph_entry(tr, trace, trace_ctx, fregs);
 	}
-	preempt_enable_notrace();
 
 	return ret;
 }
@@ -351,13 +341,10 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
-	struct trace_array_cpu *data;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
 	u64 calltime, rettime;
-	long disabled;
 	int size;
-	int cpu;
 
 	rettime = trace_clock_local();
 
@@ -376,15 +363,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	calltime = ftimes->calltime;
 
-	preempt_disable_notrace();
-	cpu = raw_smp_processor_id();
-	data = per_cpu_ptr(tr->array_buffer.data, cpu);
-	disabled = atomic_read(&data->disabled);
-	if (likely(!disabled)) {
-		trace_ctx = tracing_gen_ctx();
-		__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
-	}
-	preempt_enable_notrace();
+	trace_ctx = tracing_gen_ctx();
+	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
-- 
2.47.2


