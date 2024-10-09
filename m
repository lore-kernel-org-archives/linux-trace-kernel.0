Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AB18FDAB;
	Wed,  9 Oct 2024 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516951; cv=none; b=Jgm7WD1O/6RUBdMAQXzKHdV/OrhIuJteR+jlNy3eOoWI1sgFp+cd792TOAgSFH9rjjcAyekN+na0w0+Ana+r/HKxGSeuOVN27FtAi66dExUTOWDDdHDpzruSM4BmI4i5C5NUbvcJUuE3mf8PnyiZrP8X9jR34ZQxMHM7dU1wB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516951; c=relaxed/simple;
	bh=Ygx6atokoIquL6MrDQiVk8ydtKJfWsJoP5GR3vNIo00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UkInlO9CB+04crpCePbSPH1DSgLKf71c0h3hRQOy0Ai4+zomttIBjQ8Odq5iRsHbUi0Mx0JhJT7vOpW/In0rgUWy0b0vrRhxYDM2za/5hOqnj5AJbQpUGrnIvQ8ewFPKyE0BHSjTCe9mB0xazfVQ+C0Itz707/reh4YFo6okcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuf/K7dM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuf/K7dM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BEC4CECF;
	Wed,  9 Oct 2024 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728516950;
	bh=Ygx6atokoIquL6MrDQiVk8ydtKJfWsJoP5GR3vNIo00=;
	h=From:To:Cc:Subject:Date:From;
	b=iuf/K7dM5hCej7vqbtoVT1UFmScQ+hniQkEi3BxKl/qXnDX9rSg6Ah78sIB0hfKZg
	 O2XBZWQiarcqKVjjs6DDaCp20ztCBpxeTO/I06oKT9CNInwv5OsE39wVEn5HHEzTYV
	 Jjks/pj/HZZ930VyBXH+YaalIy2+rer9anpQI22aFrapM9a/oD2Z4ygaeju0LjH23L
	 tPC5rEiOoQVezoz7+fLx77iRbw54HFASiwjQiP8GOWxFfk8S7yjC4TvYF4uf2ywwmq
	 ABr974xZOdo80daayYPxXd+40V89S8AIsXsnYJho2lWwQb6otIeG7uwyN72jkSt/Et
	 7gtGzNfT6IXTQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/fgraph: Simplify return address printing in function graph tracer
Date: Thu, 10 Oct 2024 08:35:46 +0900
Message-Id: <172851694646.226680.6609563595100451829.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Simplify return address printing in the function graph tracer by removing
fgraph_extras. Since this feature is only used by the function graph
tracer and the feature flags can directly accessible from the function
graph tracer, fgraph_extras can be removed from the fgraph callback.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h               |   16 ++++--------
 kernel/trace/fgraph.c                |   45 ++++++++++++++++++++++------------
 kernel/trace/ftrace.c                |    3 +-
 kernel/trace/trace.h                 |    3 +-
 kernel/trace/trace_functions_graph.c |   14 +++++------
 kernel/trace/trace_irqsoff.c         |    3 +-
 kernel/trace/trace_sched_wakeup.c    |    3 +-
 kernel/trace/trace_selftest.c        |    8 ++----
 8 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2ac3b3b53cd0..997e1f0335b6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1068,29 +1068,20 @@ struct ftrace_graph_ret {
 	unsigned long long rettime;
 } __packed;
 
-struct fgraph_extras;
 struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 				       struct fgraph_ops *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
-				      struct fgraph_ops *,
-				      struct fgraph_extras *); /* entry */
+				      struct fgraph_ops *); /* entry */
 
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-				   struct fgraph_ops *gops,
-				   struct fgraph_extras *extras);
+				   struct fgraph_ops *gops);
 bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-/* Used to convey some extra datas when creating a graph entry */
-struct fgraph_extras {
-	u32 flags;
-	unsigned long retaddr;
-};
-
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
@@ -1131,12 +1122,15 @@ function_graph_enter(unsigned long ret, unsigned long func,
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
+unsigned long ftrace_graph_top_ret_addr(struct task_struct *task);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 u32 graph_tracer_flags_get(u32 flags);
+#define graph_tracer_flags_is_set(flags)	\
+	(graph_tracer_flags_get(flags) == (flags))
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 27e523f01ed2..ee829d65f301 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -290,8 +290,7 @@ static inline unsigned long make_data_type_val(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
-		     struct fgraph_extras *extras)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
 	return 0;
 }
@@ -519,8 +518,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops,
-			    struct fgraph_extras *extras)
+			    struct fgraph_ops *gops)
 {
 	return 0;
 }
@@ -648,20 +646,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
-	struct fgraph_extras extras;
 	unsigned long bitmap = 0;
 	int offset;
 	int i;
-	int idx = 0;
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	extras.flags = graph_tracer_flags_get(TRACE_GRAPH_PRINT_RETADDR);
-	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR)
-		&& extras.flags & TRACE_GRAPH_PRINT_RETADDR)
-		extras.retaddr = ftrace_graph_ret_addr(current, &idx, ret, retp);
-
 	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
 	if (offset < 0)
 		goto out;
@@ -670,7 +661,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, &extras))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -688,7 +679,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops, &extras))
+			    gops->entryfunc(&trace, gops))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -905,6 +896,29 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 	return ret_stack;
 }
 
+/**
+ * ftrace_graph_top_ret_addr - return the top return address in the shadow stack
+ * @task: The task to read the shadow stack from.
+ *
+ * Return the first return address on the shadow stack of the @task, which is
+ * not the fgraph's return_to_handler.
+ */
+unsigned long ftrace_graph_top_ret_addr(struct task_struct *task)
+{
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = task->curr_ret_stack;
+
+	if (offset < 0)
+		return 0;
+
+	do {
+		ret_stack = get_ret_stack(task, offset, &offset);
+	} while (ret_stack && ret_stack->ret == return_handler);
+
+	return ret_stack ? ret_stack->ret : 0;
+}
+
 /**
  * ftrace_graph_ret_addr - return the original value of the return address
  * @task: The task the unwinder is being executed on
@@ -1145,8 +1159,7 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops,
-			   struct fgraph_extras *extras)
+			   struct fgraph_ops *gops)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1160,7 +1173,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			return 0;
 	}
 
-	return gops->saved_func(trace, gops, NULL);
+	return gops->saved_func(trace, gops);
 }
 
 void fgraph_update_pid_func(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5d87dac83b80..cae388122ca8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -827,8 +827,7 @@ struct profile_fgraph_data {
 };
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops,
-			       struct fgraph_extras *extras)
+			       struct fgraph_ops *gops)
 {
 	struct profile_fgraph_data *profile_data;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 13f08f257c0b..6adf48ef4312 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -695,8 +695,7 @@ void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
-int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-		      struct fgraph_extras *extras);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3dd63ae2afe8..e3cda79653ee 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -179,8 +179,7 @@ struct fgraph_times {
 };
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops,
-		      struct fgraph_extras *extras)
+		      struct fgraph_ops *gops)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -246,11 +245,12 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) && extras
-				&& (extras->flags & TRACE_GRAPH_PRINT_RETADDR)))
-			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx,
-							  extras->retaddr);
-		else
+		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
+			graph_tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR))) {
+			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
+
+			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
+		} else
 			ret = __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret = 0;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index eb3aa36cf10f..fce064e20570 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -176,8 +176,7 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 }
 
 static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops,
-			       struct fgraph_extras *extras)
+			       struct fgraph_ops *gops)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 155de2551507..ae2ace5e515a 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -113,8 +113,7 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 }
 
 static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops,
-			      struct fgraph_extras *extras)
+			      struct fgraph_ops *gops)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index fbb99f8c8062..d3a14ae47e26 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -774,8 +774,7 @@ struct fgraph_fixture {
 };
 
 static __init int store_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops,
-			      struct fgraph_extras *extras)
+			      struct fgraph_ops *gops)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;
@@ -1026,8 +1025,7 @@ static unsigned int graph_hang_thresh;
 
 /* Wrap the real function entry probe to avoid possible hanging */
 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
-				      struct fgraph_ops *gops,
-				      struct fgraph_extras *extras)
+				      struct fgraph_ops *gops)
 {
 	/* This is harmlessly racy, we want to approximately detect a hang */
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
@@ -1041,7 +1039,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
 		return 0;
 	}
 
-	return trace_graph_entry(trace, gops, NULL);
+	return trace_graph_entry(trace, gops);
 }
 
 static struct fgraph_ops fgraph_ops __initdata  = {

