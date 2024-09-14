Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA786AE3;
	Sat, 14 Sep 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350496; cv=none; b=SUjRGS2NJDFguCZw00tKkwX/TR5ijYi6soAGyVEiRwKum1X4mZ+EYmyAnFv3EVLInPIVhEMzPFt8yYrw/iMtEH1LanypIxg4ZE1ZaTT5AmxhJxyUH43GBMun/LZEo5z11zWsl7qaYhNrwuVYGuawMncHQ0yVAEJFSIFPFZKqYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350496; c=relaxed/simple;
	bh=WEhXzNAlc2GALTHuFjFbb7n/PfwfnnUghYjGJshIMzA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hkq2uCvm6vWXQGeWFbK9otVNpIX7HzhOaWDAf1eSUS+P+q0AMu4QxaAUF+Oj10s5213Z/K41mXPehvVJif4RATqJpX566H8752/6YDZapqHLEEYUQdTU2yQ1iPKBXsYG5Wqb6D4nCTcO6sRR+hYGlOG8ur17foleG/UcwV7cJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD2C4CECC;
	Sat, 14 Sep 2024 21:48:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1spad1-00000001Gtm-0Jes;
	Sat, 14 Sep 2024 17:48:27 -0400
Message-ID: <20240914214826.938908568@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 14 Sep 2024 17:48:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 2/3] ftrace: Use a running sleeptime instead of saving on shadow stack
References: <20240914214805.779822616@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The fgraph "sleep-time" option tells the function graph tracer and the
profiler whether to include the time a function "sleeps" (is scheduled off
the CPU) in its duration for the function. By default it is true, which
means the duration of a function is calculated by the timestamp of when the
function was entered to the timestamp of when it exits.

If the "sleep-time" option is disabled, it needs to remove the time that the
task was not running on the CPU during the function. Currently it is done in
a sched_switch tracepoint probe where it moves the "calltime" (time of entry
of the function) forward by the sleep time calculated. It updates all the
calltime in the shadow stack.

This is time consuming for those users of the function graph tracer that
does not care about the sleep time. Instead, add a "ftrace_sleeptime" to the
task_struct that gets the sleep time added each time the task wakes up. Then
have the function entry save the current "ftrace_sleeptime" and on function
exit, move the calltime forward by the difference of the current
"ftrace_sleeptime" from the saved sleeptime.

This removes one dependency of "calltime" needed to be on the shadow stack.
It also simplifies the code that removes the sleep time of functions.

TODO: Only enable the sched_switch tracepoint when this is needed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h                |  1 +
 kernel/trace/fgraph.c                | 16 ++----------
 kernel/trace/ftrace.c                | 39 ++++++++++++++++++++--------
 kernel/trace/trace.h                 |  1 +
 kernel/trace/trace_functions_graph.c | 28 ++++++++++++++++++++
 5 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..46ddda3697f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1417,6 +1417,7 @@ struct task_struct {
 
 	/* Timestamp for last schedule: */
 	unsigned long long		ftrace_timestamp;
+	unsigned long long		ftrace_sleeptime;
 
 	/*
 	 * Number of functions that haven't been traced
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 095ceb752b28..b2e95bf82211 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -495,7 +495,7 @@ void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth)
 }
 
 /* Both enabled by default (can be cleared by function_graph tracer flags */
-static bool fgraph_sleep_time = true;
+bool fgraph_sleep_time = true;
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
@@ -1046,9 +1046,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
-	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
-	int offset;
 
 	/*
 	 * Does the user want to count the time a function was asleep.
@@ -1065,17 +1063,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	if (!next->ftrace_timestamp)
 		return;
 
-	/*
-	 * Update all the counters in next to make up for the
-	 * time next was sleeping.
-	 */
-	timestamp -= next->ftrace_timestamp;
-
-	for (offset = next->curr_ret_stack; offset > 0; ) {
-		ret_stack = get_ret_stack(next, offset, &offset);
-		if (ret_stack)
-			ret_stack->calltime += timestamp;
-	}
+	next->ftrace_sleeptime += timestamp - next->ftrace_timestamp;
 }
 
 static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 196647059800..f3d1702a7d8d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -820,10 +820,15 @@ void ftrace_graph_graph_time_control(bool enable)
 	fgraph_graph_time = enable;
 }
 
+struct profile_fgraph_data {
+	unsigned long long		subtime;
+	unsigned long long		sleeptime;
+};
+
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
 			       struct fgraph_ops *gops)
 {
-	unsigned long long *subtime;
+	struct profile_fgraph_data *profile_data;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -831,9 +836,12 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 	if (!current->ret_stack)
 		return 0;
 
-	subtime = fgraph_reserve_data(gops->idx, sizeof(*subtime));
-	if (subtime)
-		*subtime = 0;
+	profile_data = fgraph_reserve_data(gops->idx, sizeof(*profile_data));
+	if (!profile_data)
+		return 0;
+
+	profile_data->subtime = 0;
+	profile_data->sleeptime = current->ftrace_sleeptime;
 
 	return 1;
 }
@@ -841,9 +849,10 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 static void profile_graph_return(struct ftrace_graph_ret *trace,
 				 struct fgraph_ops *gops)
 {
+	struct profile_fgraph_data *profile_data;
+	struct profile_fgraph_data *parent_data;
 	struct ftrace_profile_stat *stat;
 	unsigned long long calltime;
-	unsigned long long *subtime;
 	struct ftrace_profile *rec;
 	unsigned long flags;
 	int size;
@@ -859,16 +868,24 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 
 	calltime = trace->rettime - trace->calltime;
 
+	if (!fgraph_sleep_time) {
+		profile_data = fgraph_retrieve_data(gops->idx, &size);
+		if (profile_data && current->ftrace_sleeptime)
+			calltime -= current->ftrace_sleeptime - profile_data->sleeptime;
+	}
+
 	if (!fgraph_graph_time) {
 
 		/* Append this call time to the parent time to subtract */
-		subtime = fgraph_retrieve_parent_data(gops->idx, &size, 1);
-		if (subtime)
-			*subtime += calltime;
+		parent_data = fgraph_retrieve_parent_data(gops->idx, &size, 1);
+		if (parent_data)
+			parent_data->subtime += calltime;
+
+		if (!profile_data)
+			profile_data = fgraph_retrieve_data(gops->idx, &size);
 
-		subtime = fgraph_retrieve_data(gops->idx, &size);
-		if (subtime && *subtime && *subtime < calltime)
-			calltime -= *subtime;
+		if (profile_data && profile_data->subtime && profile_data->subtime < calltime)
+			calltime -= profile_data->subtime;
 		else
 			calltime = 0;
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd3e3069300e..8a3cfe67a76c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1039,6 +1039,7 @@ static inline void ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftra
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
+extern bool fgraph_sleep_time;
 
 static inline bool
 ftrace_graph_ignore_func(struct fgraph_ops *gops, struct ftrace_graph_ent *trace)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 13d0387ac6a6..14b82fb7082c 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -133,6 +133,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
+	unsigned long *sleeptime;
 	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
@@ -167,6 +168,13 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	if (ftrace_graph_ignore_irqs())
 		return 0;
 
+	/* save the current sleep time if we are to ignore it */
+	if (!fgraph_sleep_time) {
+		sleeptime = fgraph_reserve_data(gops->idx, sizeof(*sleeptime));
+		if (sleeptime)
+			*sleeptime = current->ftrace_sleeptime;
+	}
+
 	/*
 	 * Stop here if tracing_threshold is set. We only write function return
 	 * events to the ring buffer.
@@ -238,6 +246,22 @@ void __trace_graph_return(struct trace_array *tr,
 		trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
+static void handle_nosleeptime(struct ftrace_graph_ret *trace,
+			       struct fgraph_ops *gops)
+{
+	unsigned long long *sleeptime;
+	int size;
+
+	if (fgraph_sleep_time)
+		return;
+
+	sleeptime = fgraph_retrieve_data(gops->idx, &size);
+	if (!sleeptime)
+		return;
+
+	trace->calltime += current->ftrace_sleeptime - *sleeptime;
+}
+
 void trace_graph_return(struct ftrace_graph_ret *trace,
 			struct fgraph_ops *gops)
 {
@@ -256,6 +280,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 		return;
 	}
 
+	handle_nosleeptime(trace, gops);
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
@@ -278,6 +304,8 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 		return;
 	}
 
+	handle_nosleeptime(trace, gops);
+
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
-- 
2.45.2


