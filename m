Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599E171A7;
	Wed, 22 Jan 2025 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506673; cv=none; b=BtGltM2F6XRQcfCGo76QMag2MPfWseSPEeUJxsDSaG6RM67OV7rm+ZwogjsKHpzKf0yom8NeM8xoYD8qmeTbsVlBuAbyvUzorJr4y0k0GgAmoABq6OwIcJK0TtOqpyeJgkuQOhAtp56rK7T59VE/iSEQ2acjXAWazPKlkeQzOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506673; c=relaxed/simple;
	bh=dVmxEtvxJPWF1knoLgj2ttI1buvR5TTMG9dM5I8RTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ETwxpjhDRvMinZCWaNp44y0Nj3aU0d7AL0LDwC/vXeOVbbyQE4pMjy/sU8FDsR+hzZf5k7aK1gxWO+qb9yvWg4ky834jd7NayYttpgvafHYgRhJQXD93iS5/k29LgopUOckFGOIgEN+PmRpxQsRUtAsVtoXle5nv64TWnWEpZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86387C4CEE2;
	Wed, 22 Jan 2025 00:44:32 +0000 (UTC)
Date: Tue, 21 Jan 2025 19:44:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v2] fgraph: Remove calltime and rettime from generic
 operations
Message-ID: <20250121194436.15bdf71a@gandalf.local.home>
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

The function graph infrastructure is now generic so that kretprobes,
fprobes and BPF can use it. But there is still some leftover logic that
only the function graph tracer itself uses. This is the calculation of the
calltime and return time of the functions. The calculation of the calltime
has been moved into the function graph tracer and those users that need it
so that it doesn't cause overhead to the other users. But the return
function timestamp was still called.

Instead of just moving the taking of the timestamp into the function graph
trace remove the calltime and rettime completely from the ftrace_graph_ret
structure. Instead, move it into the function graph return entry event
structure and this also moves all the calltime and rettime logic out of
the generic fgraph.c code and into the tracing code that uses it.

This has been reported to decrease the overhead by ~27%.

Link: https://lore.kernel.org/all/Z3aSuql3fnXMVMoM@krava/
Link: https://lore.kernel.org/all/173665959558.1629214.16724136597211810729.stgit@devnote2/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250114111158.74865a4e@gandalf.local.home
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250114111158.74865a4e@gandalf.local.home

- Rebased on top of the pull request of ftrace-v6.14, as it has dependencies
  to both that branch as well as to what was already upstream.
  Nothing else changed.

 include/linux/ftrace.h               |  2 --
 kernel/trace/fgraph.c                |  1 -
 kernel/trace/trace.h                 |  4 +++-
 kernel/trace/trace_entries.h         |  8 +++----
 kernel/trace/trace_functions_graph.c | 33 ++++++++++++++++------------
 kernel/trace/trace_irqsoff.c         |  5 +++--
 kernel/trace/trace_sched_wakeup.c    |  6 +++--
 7 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 07092dfb21a4..fbabc3d848b3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1151,8 +1151,6 @@ struct ftrace_graph_ret {
 	int depth;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned int overrun;
-	unsigned long long calltime;
-	unsigned long long rettime;
 } __packed;
 
 struct fgraph_ops;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 9e6b5a71555b..5dddfc2149f6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -826,7 +826,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 04058a9889b7..2742d14df383 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -912,7 +912,9 @@ extern int __trace_graph_retaddr_entry(struct trace_array *tr,
 				unsigned long retaddr);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
-				 unsigned int trace_ctx);
+				 unsigned int trace_ctx,
+				 u64 calltime, u64 rettime);
+
 extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 82fd174ebbe0..fbfb396905a6 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -124,8 +124,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		retval	)
 		__field_packed(	int,		ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field(unsigned long long,	calltime		)
+		__field(unsigned long long,	rettime			)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
@@ -146,8 +146,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		func	)
 		__field_packed(	int,		ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field(unsigned long long,	calltime		)
+		__field(unsigned long long,	rettime			)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index dc62eb93837a..54d850997c0a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -266,12 +266,10 @@ __trace_graph_function(struct trace_array *tr,
 	struct ftrace_graph_ret ret = {
 		.func     = ip,
 		.depth    = 0,
-		.calltime = time,
-		.rettime  = time,
 	};
 
 	__trace_graph_entry(tr, &ent, trace_ctx);
-	__trace_graph_return(tr, &ret, trace_ctx);
+	__trace_graph_return(tr, &ret, trace_ctx, time, time);
 }
 
 void
@@ -283,8 +281,9 @@ trace_graph_function(struct trace_array *tr,
 }
 
 void __trace_graph_return(struct trace_array *tr,
-				struct ftrace_graph_ret *trace,
-				unsigned int trace_ctx)
+			  struct ftrace_graph_ret *trace,
+			  unsigned int trace_ctx,
+			  u64 calltime, u64 rettime)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -296,6 +295,8 @@ void __trace_graph_return(struct trace_array *tr,
 		return;
 	entry	= ring_buffer_event_data(event);
 	entry->ret				= *trace;
+	entry->calltime				= calltime;
+	entry->rettime				= rettime;
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
@@ -317,10 +318,13 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array_cpu *data;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
+	u64 calltime, rettime;
 	long disabled;
 	int size;
 	int cpu;
 
+	rettime = trace_clock_local();
+
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (*task_var & TRACE_GRAPH_NOTRACE) {
@@ -334,7 +338,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(trace, ftimes, size);
 
-	trace->calltime = ftimes->calltime;
+	calltime = ftimes->calltime;
 
 	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
@@ -342,7 +346,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	disabled = atomic_read(&data->disabled);
 	if (likely(!disabled)) {
 		trace_ctx = tracing_gen_ctx();
-		__trace_graph_return(tr, trace, trace_ctx);
+		__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
 	}
 	preempt_enable_notrace();
 }
@@ -367,10 +371,8 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(trace, ftimes, size);
 
-	trace->calltime = ftimes->calltime;
-
 	if (tracing_thresh &&
-	    (trace->rettime - ftimes->calltime < tracing_thresh))
+	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
 		return;
 	else
 		trace_graph_return(trace, gops, fregs);
@@ -856,7 +858,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
-	duration = graph_ret->rettime - graph_ret->calltime;
+	duration = ret_entry->rettime - ret_entry->calltime;
 
 	func = call->func + iter->tr->text_delta;
 
@@ -1137,11 +1139,14 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 }
 
 static enum print_line_t
-print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
+print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 		   struct trace_entry *ent, struct trace_iterator *iter,
 		   u32 flags)
 {
-	unsigned long long duration = trace->rettime - trace->calltime;
+	struct ftrace_graph_ret *trace = &retentry->ret;
+	u64 calltime = retentry->calltime;
+	u64 rettime = retentry->rettime;
+	unsigned long long duration = rettime - calltime;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
 	unsigned long func;
@@ -1342,7 +1347,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
-		return print_graph_return(&field->ret, s, entry, iter, flags);
+		return print_graph_return(field, s, entry, iter, flags);
 	}
 	case TRACE_STACK:
 	case TRACE_FN:
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 08786c59d397..7294ad676379 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -223,6 +223,7 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
+	u64 rettime;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -230,13 +231,13 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
+	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
 	if (!calltime)
 		return;
-	trace->calltime = *calltime;
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx);
+	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	atomic_dec(&data->disabled);
 }
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index f372252dc8bb..af30586f1aea 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -158,6 +158,7 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	u64 *calltime;
+	u64 rettime;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -165,12 +166,13 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
 
+	rettime = trace_clock_local();
+
 	calltime = fgraph_retrieve_data(gops->idx, &size);
 	if (!calltime)
 		return;
-	trace->calltime = *calltime;
 
-	__trace_graph_return(tr, trace, trace_ctx);
+	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	atomic_dec(&data->disabled);
 
 	preempt_enable_notrace();
-- 
2.45.2

