Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAC1CCB2E;
	Thu, 10 Oct 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572353; cv=none; b=R4LNx1i0+JXQz8nM2Nymm8BKNbcAXMEmP4CSdzEFCylSI/zqIBvnxQXUHqNpYCEhZa9SViEZNNPS4/BBl2JXFB5FbX61vPUHVF34eytadglVZTevukpJ1qpunCZh//ET6QJr2Da80fbdV87xlMKtsQ/JXwgJO4AgByw2nNgIoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572353; c=relaxed/simple;
	bh=YY1euoEflK2khe/PvTCrYf+BkpbiDAmFuoRcdo/Wfq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eSC7BUDDDxZ6iP6EoNgRMUZb0Vbfd4G8+Oonj4B0FyB+9DnH/HXb4XDztWp8u4gTBKiNFBSKDxhWO7By45u54108IdMc53GxrdUq9tLyZWDRkSkY35mCRITrb08iThLOxgBb3EpqhD1uzhllLx58667E+o+8YI7WSElaoNDWnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awHW3xKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awHW3xKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94316C4CEC5;
	Thu, 10 Oct 2024 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728572352;
	bh=YY1euoEflK2khe/PvTCrYf+BkpbiDAmFuoRcdo/Wfq4=;
	h=From:To:Cc:Subject:Date:From;
	b=awHW3xKaxhXucc3hcv+56+9kKuio2FzDqZP5mDNzixJWyzRkCCm+OL1Yn7HdIXJwS
	 v3EQ17OkK9Age+oBVO1/GerK/E7/6xrJRajemjR6jsN9Q7GQ+Mp8F1WtVaf7UxpEZl
	 RBDhskAjqVmObhUu7QUDr6ZOVkGnX+2RGjaA3/NWO/uLBV+2I6KCtByT+VFsm4M9zN
	 KPbrAv7LLFBo3TjXJTGCO2xvesSHZ23LGCM1GHcwqTX2m98c+vTGfdTIWcW2ICWmLW
	 jWJoakbqEbcQmxaA5qyj68Q2S95ZOiAlfI9dcUuGl/3tcmvMjBE/5sFEuC8fuAXrRt
	 kysqRMxLyjwvQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] tracing/fgraph: Simplify return address printing in function graph tracer
Date: Thu, 10 Oct 2024 23:59:09 +0900
Message-Id: <172857234900.270774.15378354017601069781.stgit@devnote2>
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
 Changes in v2:
  - Remove graph_tracer_flags_get() since it is not used.
---
 include/linux/ftrace.h               |   16 ++----------
 kernel/trace/fgraph.c                |   45 ++++++++++++++++++++++------------
 kernel/trace/ftrace.c                |    3 +-
 kernel/trace/trace.h                 |    3 +-
 kernel/trace/trace_functions_graph.c |   18 +++++++-------
 kernel/trace/trace_irqsoff.c         |    3 +-
 kernel/trace/trace_sched_wakeup.c    |    3 +-
 kernel/trace/trace_selftest.c        |    8 ++----
 8 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2ac3b3b53cd0..4c7dd5e58c9f 100644
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
@@ -1131,13 +1122,12 @@ function_graph_enter(unsigned long ret, unsigned long func,
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
+unsigned long ftrace_graph_top_ret_addr(struct task_struct *task);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
-u32 graph_tracer_flags_get(u32 flags);
-
 /*
  * Sometimes we don't want to trace a function with the function
  * graph tracer but we want them to keep traced by the usual function
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
index 3dd63ae2afe8..20d0c579d3b5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -90,9 +90,9 @@ static struct tracer_flags tracer_flags = {
 	.opts = trace_opts
 };
 
-u32 graph_tracer_flags_get(u32 flags)
+static bool tracer_flags_is_set(u32 flags)
 {
-	return tracer_flags.val & flags;
+	return (tracer_flags.val & flags) == flags;
 }
 
 /*
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
+			tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR))) {
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

