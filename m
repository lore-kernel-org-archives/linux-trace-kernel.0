Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C401D531;
	Sun, 30 Aug 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088176; cv=none; b=mj3zHEu56c8mdP85qRLkWf4LN5LOSAsB8aK/lNHUHbMYHtkVqkA26HBZ4VRnGIizcI8Ea9hN6V8urv5o5wjEuwbtbRWiGrhcsQcj4gnJRfjp1RXAKSwX0moOs1QhNHRGnDdOzAFGEEWLZ/IePrWNeQFdEBwrhkW5DA9gpSQVesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088176; c=relaxed/simple;
	bh=a9HDYKF6H431hTq4k//XSrlZT7D4ZTFr5sPWqzM5Pw0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HrVpnVqpJKULsgL2wBAfKtVHUOSoxCbtLoVKEC8M8e5bdgI5Vgge3BBtEHS8b3WbxdGIEwdv8Ze/OS2qvcx3MWVWsuW4/T2LXGl4ADGUKuo27Pg+Rtucq31PhvInvBiNR02XwASuXhlNT8YBHnmVRdRT8D2K9lbdyZmyI9dXLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hXqBs6lPFz8Xrnw;
	Sun, 30 Aug 2026 19:09:25 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 67UB9JnC002988;
	Sun, 30 Aug 2026 19:09:19 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 30 Aug 2026 19:09:20 +0800 (CST)
X-Zmail-TransId: 2afb6a940f60e92-d1f1a
X-Mailer: Zmail v1.0
Message-ID: <20260830190920408Ed74Uras1Q1qGxnPQ8qzZ@zte.com.cn>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn
Date: Sun, 30 Aug 2026 19:09:20 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBQQVRDSCAxLzRdIGZ0cmFjZTogR2VuZXJhbGl6ZSBmdW5jdGlvbiB0YXNrIGZpbHRlciBuYW1lcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67UB9JnC002988
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 30 Aug 2026 19:09:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A940F65.001/4hXqBs6lPFz8Xrnw

From: Shengming Hu <hu.shengming@zte.com.cn>

Function tracing decides whether to trace a task when it is scheduled
in and caches the result per CPU. This mechanism currently handles PID
filters, but it will also be used by other task filters.

Rename the shared enable check and sched_switch callback to use more
general task-filter names. Rename trace_ignore_this_task() to
trace_ignore_pid_task(), since that helper specifically checks PID
filters.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 include/linux/ftrace.h         |  4 ++--
 kernel/trace/fgraph.c          |  4 ++--
 kernel/trace/ftrace.c          | 16 ++++++++--------
 kernel/trace/trace.h           |  2 +-
 kernel/trace/trace_events.c    | 16 ++++++++--------
 kernel/trace/trace_functions.c |  2 +-
 kernel/trace/trace_pid.c       |  8 ++++----
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02bc5027523a..60e1dede1e68 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -331,7 +331,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  *            SAVE_REGS. If another ops with this flag set is already registered
  *            for any of the functions that this ops will be registered for, then
  *            this ops will fail to register or set_filter_ip.
- * PID     - Is affected by set_ftrace_pid (allows filtering on those pids)
+ * PID     - Is affected by function task filters
  * RCU     - Set when the ops can only be called when RCU is watching.
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
  * PERMANENT - Set when the ops is permanent and should not be affected by
@@ -1251,7 +1251,7 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
 				   struct fgraph_ops *gops,
 				   struct ftrace_regs *fregs);
-bool ftrace_pids_enabled(struct ftrace_ops *ops);
+bool ftrace_task_filters_enabled(struct ftrace_ops *ops);

 #ifdef CONFIG_FUNCTION_GRAPH_TRACER

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 40d373d65f9b..c8bbba4eecf0 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1223,7 +1223,7 @@ void fgraph_update_pid_func(void)
 	list_for_each_entry(op, &graph_ops.subop_list, list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			gops = container_of(op, struct fgraph_ops, ops);
-			gops->entryfunc = ftrace_pids_enabled(op) ?
+			gops->entryfunc = ftrace_task_filters_enabled(op) ?
 				fgraph_pid_func : gops->saved_func;
 			if (ftrace_graph_active == 1)
 				static_call_update(fgraph_func, gops->entryfunc);
@@ -1382,7 +1382,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	/* Always save the function, and reset at unregistering */
 	gops->saved_func = gops->entryfunc;
 #ifdef CONFIG_DYNAMIC_FTRACE
-	if (ftrace_pids_enabled(&gops->ops))
+	if (ftrace_task_filters_enabled(&gops->ops))
 		gops->entryfunc = fgraph_pid_func;
 #endif

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9d80c7bd9f1..479ea004adc3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -99,7 +99,7 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
 /* What to set function_trace_op to */
 static struct ftrace_ops *set_function_trace_op;

-bool ftrace_pids_enabled(struct ftrace_ops *ops)
+bool ftrace_task_filters_enabled(struct ftrace_ops *ops)
 {
 	struct trace_array *tr;

@@ -359,7 +359,7 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	/* Always save the function, and reset at unregistering */
 	ops->saved_func = ops->func;

-	if (ftrace_pids_enabled(ops))
+	if (ftrace_task_filters_enabled(ops))
 		ops->func = ftrace_pid_func;

 	ftrace_update_trampoline(ops);
@@ -400,7 +400,7 @@ static void ftrace_update_pid_func(void)

 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
-			op->func = ftrace_pids_enabled(op) ?
+			op->func = ftrace_task_filters_enabled(op) ?
 				ftrace_pid_func : op->saved_func;
 			ftrace_update_trampoline(op);
 		}
@@ -8638,7 +8638,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 }

 static void
-ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
+ftrace_filter_task_sched_switch_probe(void *data, bool preempt,
 				     struct task_struct *prev,
 				     struct task_struct *next,
 				     unsigned int prev_state)
@@ -8650,7 +8650,7 @@ ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
 	pid_list = rcu_dereference_sched(tr->function_pids);
 	no_pid_list = rcu_dereference_sched(tr->function_no_pids);

-	if (trace_ignore_this_task(pid_list, no_pid_list, next))
+	if (trace_ignore_pid_task(pid_list, no_pid_list, next))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -8720,7 +8720,7 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)

 	/* See if the pids still need to be checked after this */
 	if (!still_need_pid_events(type, pid_list, no_pid_list)) {
-		unregister_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
+		unregister_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
 		for_each_possible_cpu(cpu)
 			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid = FTRACE_PID_TRACE;
 	}
@@ -8920,7 +8920,7 @@ static void ignore_task_cpu(void *data)
 	no_pid_list = rcu_dereference_protected(tr->function_no_pids,
 						mutex_is_locked(&ftrace_lock));

-	if (trace_ignore_this_task(pid_list, no_pid_list, current))
+	if (trace_ignore_pid_task(pid_list, no_pid_list, current))
 		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
 			       FTRACE_PID_IGNORE);
 	else
@@ -8981,7 +8981,7 @@ pid_write(struct file *filp, const char __user *ubuf,
 		trace_pid_list_free(filtered_pids);
 	} else if (pid_list && !other_pids) {
 		/* Register a probe to set whether to ignore the tracing of a task */
-		register_trace_sched_switch(ftrace_filter_pid_sched_switch_probe, tr);
+		register_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
 	}

 	/*
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..f73913eed307 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -845,7 +845,7 @@ extern struct workqueue_struct *trace_init_wq __initdata;

 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
-bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
+bool trace_ignore_pid_task(struct trace_pid_list *filtered_pids,
 			    struct trace_pid_list *filtered_no_pids,
 			    struct task_struct *task);
 void trace_filter_add_remove_task(struct trace_pid_list *pid_list,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f8f2d02276c..3fb0d2af5740 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1123,12 +1123,12 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
 	 * Sched switch is funny, as we only want to ignore it
 	 * in the notrace case if both prev and next should be ignored.
 	 */
-	ret = trace_ignore_this_task(NULL, no_pid_list, prev) &&
-		trace_ignore_this_task(NULL, no_pid_list, next);
+	ret = trace_ignore_pid_task(NULL, no_pid_list, prev) &&
+		trace_ignore_pid_task(NULL, no_pid_list, next);

 	this_cpu_write(tr->array_buffer.data->ignore_pid, ret ||
-		       (trace_ignore_this_task(pid_list, NULL, prev) &&
-			trace_ignore_this_task(pid_list, NULL, next)));
+		       (trace_ignore_pid_task(pid_list, NULL, prev) &&
+			trace_ignore_pid_task(pid_list, NULL, next)));
 }

 static void
@@ -1145,7 +1145,7 @@ event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
 	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);

 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, no_pid_list, next));
+		       trace_ignore_pid_task(pid_list, no_pid_list, next));
 }

 static void
@@ -1163,7 +1163,7 @@ event_filter_pid_sched_wakeup_probe_pre(void *data, struct task_struct *task)
 	no_pid_list = rcu_dereference_sched(tr->filtered_no_pids);

 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, no_pid_list, task));
+		       trace_ignore_pid_task(pid_list, no_pid_list, task));
 }

 static void
@@ -1182,7 +1182,7 @@ event_filter_pid_sched_wakeup_probe_post(void *data, struct task_struct *task)

 	/* Set tracing if current is enabled */
 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, no_pid_list, current));
+		       trace_ignore_pid_task(pid_list, no_pid_list, current));
 }

 static void unregister_pid_events(struct trace_array *tr)
@@ -2556,7 +2556,7 @@ static void ignore_task_cpu(void *data)
 					     mutex_is_locked(&event_mutex));

 	this_cpu_write(tr->array_buffer.data->ignore_pid,
-		       trace_ignore_this_task(pid_list, no_pid_list, current));
+		       trace_ignore_pid_task(pid_list, no_pid_list, current));
 }

 static void register_pid_events(struct trace_array *tr)
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index cd37f2013758..d569233df7c9 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -297,7 +297,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 		trace_ctx = tracing_gen_ctx_flags(flags);
 		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 #ifdef CONFIG_UNWINDER_FRAME_POINTER
-		if (ftrace_pids_enabled(op))
+		if (ftrace_task_filters_enabled(op))
 			skip++;
 #endif
 		__trace_stack(tr, trace_ctx, skip);
diff --git a/kernel/trace/trace_pid.c b/kernel/trace/trace_pid.c
index 7127c8de4174..ec9d3558b543 100644
--- a/kernel/trace/trace_pid.c
+++ b/kernel/trace/trace_pid.c
@@ -16,17 +16,17 @@ trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
 }

 /**
- * trace_ignore_this_task - should a task be ignored for tracing
+ * trace_ignore_pid_task - should a task be ignored by PID filters
  * @filtered_pids: The list of pids to check
  * @filtered_no_pids: The list of pids not to be traced
- * @task: The task that should be ignored if not filtered
+ * @task: The task to test against the PID filters
  *
- * Checks if @task should be traced or not from @filtered_pids.
+ * Checks whether @task should be ignored by the PID include/exclude filters.
  * Returns true if @task should *NOT* be traced.
  * Returns false if @task should be traced.
  */
 bool
-trace_ignore_this_task(struct trace_pid_list *filtered_pids,
+trace_ignore_pid_task(struct trace_pid_list *filtered_pids,
 		       struct trace_pid_list *filtered_no_pids,
 		       struct task_struct *task)
 {
-- 
2.25.1
