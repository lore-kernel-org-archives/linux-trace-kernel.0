Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE3129A78;
	Sat, 14 Sep 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350496; cv=none; b=Aewe+uVt2VihcbtqtxCAhaR97s3X0JOpv3VfuGkACcbroXajnSFNHIfthk+GL4qwHJ0CywLdhwvdT9xopbalTMJ/7ciWp/YWNvoE0DSHQ53niGDlok2vgm0wOhw8Pi5jWrwa4v1FGCahtZ4GwU8mMCr/+41FWxlwzG2hHtjq2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350496; c=relaxed/simple;
	bh=mqsPsipmMzX5aQKrZsKwwaooDmHvTfVKasp5nWvAj/Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WC9CFI1R/fscdh9Pq2tAOR4/0oJ+BkQOqdtIshy1cqcHM/fDld44YQkiV7+tCr/TVs3wmRfgK/qQBbDa1hB0pl/xC20E8YMZs+LvbkFUsCM6+VapGPRQPBRqzQQiuPQ3ymdeRg5uM6pxBmDpdvWGfWIfQcAmZJMEd7YmmvGC1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3706C4CECD;
	Sat, 14 Sep 2024 21:48:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1spad1-00000001GuI-1084;
	Sat, 14 Sep 2024 17:48:27 -0400
Message-ID: <20240914214827.096968730@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 14 Sep 2024 17:48:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 3/3] ftrace: Have calltime be saved in the fgraph storage
References: <20240914214805.779822616@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The calltime field in the shadow stack frame is only used by the function
graph tracer and profiler. But now that there's other users of the function
graph infrastructure, this adds overhead and wastes space on the shadow
stack. Move the calltime to the fgraph data storage, where the function
graph and profiler entry functions will save it in its own graph storage and
retrieve it in its exit functions.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 -
 kernel/trace/fgraph.c                |  5 ---
 kernel/trace/ftrace.c                | 19 ++++-----
 kernel/trace/trace_functions_graph.c | 60 +++++++++++++++++++---------
 4 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6bbd78052f7a..eafe43a5fa0d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1065,7 +1065,6 @@ void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth);
 struct ftrace_ret_stack {
 	unsigned long ret;
 	unsigned long func;
-	unsigned long long calltime;
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	unsigned long fp;
 #endif
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b2e95bf82211..58a28ec35dab 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -558,7 +558,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 int fgraph_idx)
 {
 	struct ftrace_ret_stack *ret_stack;
-	unsigned long long calltime;
 	unsigned long val;
 	int offset;
 
@@ -588,8 +587,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 		return -EBUSY;
 	}
 
-	calltime = trace_clock_local();
-
 	offset = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, offset);
 	offset += FGRAPH_FRAME_OFFSET;
@@ -623,7 +620,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 
 	ret_stack->ret = ret;
 	ret_stack->func = func;
-	ret_stack->calltime = calltime;
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	ret_stack->fp = frame_pointer;
 #endif
@@ -757,7 +753,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	*offset += FGRAPH_FRAME_OFFSET;
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
-	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth;
 	/*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f3d1702a7d8d..5dccb02b6525 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -821,6 +821,7 @@ void ftrace_graph_graph_time_control(bool enable)
 }
 
 struct profile_fgraph_data {
+	unsigned long long		calltime;
 	unsigned long long		subtime;
 	unsigned long long		sleeptime;
 };
@@ -842,6 +843,7 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 
 	profile_data->subtime = 0;
 	profile_data->sleeptime = current->ftrace_sleeptime;
+	profile_data->calltime = trace_clock_local();
 
 	return 1;
 }
@@ -850,9 +852,9 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 				 struct fgraph_ops *gops)
 {
 	struct profile_fgraph_data *profile_data;
-	struct profile_fgraph_data *parent_data;
 	struct ftrace_profile_stat *stat;
 	unsigned long long calltime;
+	unsigned long long rettime = trace_clock_local();
 	struct ftrace_profile *rec;
 	unsigned long flags;
 	int size;
@@ -862,29 +864,28 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	if (!stat->hash || !ftrace_profile_enabled)
 		goto out;
 
+	profile_data = fgraph_retrieve_data(gops->idx, &size);
+
 	/* If the calltime was zero'd ignore it */
-	if (!trace->calltime)
+	if (!profile_data || !profile_data->calltime)
 		goto out;
 
-	calltime = trace->rettime - trace->calltime;
+	calltime = rettime - profile_data->calltime;
 
 	if (!fgraph_sleep_time) {
-		profile_data = fgraph_retrieve_data(gops->idx, &size);
-		if (profile_data && current->ftrace_sleeptime)
+		if (current->ftrace_sleeptime)
 			calltime -= current->ftrace_sleeptime - profile_data->sleeptime;
 	}
 
 	if (!fgraph_graph_time) {
+		struct profile_fgraph_data *parent_data;
 
 		/* Append this call time to the parent time to subtract */
 		parent_data = fgraph_retrieve_parent_data(gops->idx, &size, 1);
 		if (parent_data)
 			parent_data->subtime += calltime;
 
-		if (!profile_data)
-			profile_data = fgraph_retrieve_data(gops->idx, &size);
-
-		if (profile_data && profile_data->subtime && profile_data->subtime < calltime)
+		if (profile_data->subtime && profile_data->subtime < calltime)
 			calltime -= profile_data->subtime;
 		else
 			calltime = 0;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 14b82fb7082c..ff0871a9425a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -127,13 +127,18 @@ static inline int ftrace_graph_ignore_irqs(void)
 	return in_hardirq();
 }
 
+struct fgraph_times {
+	unsigned long long		calltime;
+	unsigned long long		sleeptime; /* may be optional! */
+};
+
 int trace_graph_entry(struct ftrace_graph_ent *trace,
 		      struct fgraph_ops *gops)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
-	unsigned long *sleeptime;
+	struct fgraph_times *ftimes;
 	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
@@ -168,12 +173,18 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	if (ftrace_graph_ignore_irqs())
 		return 0;
 
-	/* save the current sleep time if we are to ignore it */
-	if (!fgraph_sleep_time) {
-		sleeptime = fgraph_reserve_data(gops->idx, sizeof(*sleeptime));
-		if (sleeptime)
-			*sleeptime = current->ftrace_sleeptime;
+	if (fgraph_sleep_time) {
+		/* Only need to record the calltime */
+		ftimes = fgraph_reserve_data(gops->idx, sizeof(ftimes->calltime));
+	} else {
+		ftimes = fgraph_reserve_data(gops->idx, sizeof(*ftimes));
+		if (ftimes)
+			ftimes->sleeptime = current->ftrace_sleeptime;
 	}
+	if (!ftimes)
+		return 0;
+
+	ftimes->calltime = trace_clock_local();
 
 	/*
 	 * Stop here if tracing_threshold is set. We only write function return
@@ -247,19 +258,13 @@ void __trace_graph_return(struct trace_array *tr,
 }
 
 static void handle_nosleeptime(struct ftrace_graph_ret *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_times *ftimes,
+			       int size)
 {
-	unsigned long long *sleeptime;
-	int size;
-
-	if (fgraph_sleep_time)
-		return;
-
-	sleeptime = fgraph_retrieve_data(gops->idx, &size);
-	if (!sleeptime)
+	if (fgraph_sleep_time || size < sizeof(*ftimes))
 		return;
 
-	trace->calltime += current->ftrace_sleeptime - *sleeptime;
+	ftimes->calltime += current->ftrace_sleeptime - ftimes->sleeptime;
 }
 
 void trace_graph_return(struct ftrace_graph_ret *trace,
@@ -268,9 +273,11 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
+	struct fgraph_times *ftimes;
 	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
+	int size;
 	int cpu;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -280,7 +287,13 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 		return;
 	}
 
-	handle_nosleeptime(trace, gops);
+	ftimes = fgraph_retrieve_data(gops->idx, &size);
+	if (!ftimes)
+		return;
+
+	handle_nosleeptime(trace, ftimes, size);
+
+	trace->calltime = ftimes->calltime;
 
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
@@ -297,6 +310,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops)
 {
+	struct fgraph_times *ftimes;
+	int size;
+
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
@@ -304,10 +320,16 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 		return;
 	}
 
-	handle_nosleeptime(trace, gops);
+	ftimes = fgraph_retrieve_data(gops->idx, &size);
+	if (!ftimes)
+		return;
+
+	handle_nosleeptime(trace, ftimes, size);
+
+	trace->calltime = ftimes->calltime;
 
 	if (tracing_thresh &&
-	    (trace->rettime - trace->calltime < tracing_thresh))
+	    (trace->rettime - ftimes->calltime < tracing_thresh))
 		return;
 	else
 		trace_graph_return(trace, gops);
-- 
2.45.2


