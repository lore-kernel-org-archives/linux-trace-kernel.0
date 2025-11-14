Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AC2F0C7F;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148181; cv=none; b=daSvVLuV+50SSWLoUzQ3HOJ6mtSr+WEDwFA8xRvS1mstKoGdOYyyHAQLpTYvowbtRTvg42RASJecLn2/ujcTlz7F2a3z+roAw9yKYchpgknHFdSFChsQk3yWVD4bmz2KeqVCcoM0e7keBSs6Bx50HX4dXtskTEZ/iQ78qGtlvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148181; c=relaxed/simple;
	bh=3S/XwAFsk6FcTU+x67JTdQ+SP7uURqCbol3zO7ZOPjw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nGC4sUiVxfSTS4GvJ4PE/Bf/TchHDyOWFQmKXlcUzS/i1A0A5Q4cuj7bHf2F83Wo+CEvdTyaTTNepU+5fvFk4O524oRDRH1TwFUHLoP4qn0r8nebr14E7zsVZeqqV9ub1NU/BezcoNJLhRB/iSXrp6HQxkymxuKoIQU8B1wY3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gliiENBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gliiENBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4D2C116D0;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148180;
	bh=3S/XwAFsk6FcTU+x67JTdQ+SP7uURqCbol3zO7ZOPjw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gliiENBWJ5EIN2wIlkM+AJOIgVNaj5UoCSBSIA/A47uxZMaJNnNeHONCROivMM4jx
	 85ri4i3ZP2+2eU80A6PHFxftF7wEmB5IxYLKhRekNkUEm9AYQ5iuJsTfWZalqO12aP
	 ECTvJxiQy3FBidi9EU9IbIYPM3RhMO2cwxbWQzm6MuQZ/Mvmpe9wVZYG2oe1P38iJt
	 3RGE6Gg+puCz0H/xyFevRIeelssRluLl59Cn+Ymy8JRaHnW11W386Ql2KIkQeZ+ysM
	 IctmPduPAAyHzJeO06FmuPlh7aQrzCLuEa68+Nb3OVEU0oZxSgNFUIjfa4PD0Zcr8u
	 3mgdjt2zsK6KA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJzOB-00000001p92-0PJu;
	Fri, 14 Nov 2025 14:23:19 -0500
Message-ID: <20251114192318.950255167@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 14 Nov 2025 14:22:32 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] tracing: Have function graph tracer option sleep-time be per instance
References: <20251114192229.829042264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the option to have function graph tracer to ignore time spent
when a task is sleeping is global when the interface is per-instance.
Changing the value in one instance will affect the results of another
instance that is also running the function graph tracer. This can lead to
confusing results.

Fixes: c132be2c4fcc1 ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c                | 10 +----
 kernel/trace/ftrace.c                |  4 +-
 kernel/trace/trace.h                 |  5 +--
 kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++++++-----
 4 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 484ad7a18463..7fb9b169d6d4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -498,9 +498,6 @@ void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth)
 	return get_data_type_data(current, offset);
 }
 
-/* Both enabled by default (can be cleared by function_graph tracer flags */
-bool fgraph_sleep_time = true;
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * archs can override this function if they must do something
@@ -1023,11 +1020,6 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 #endif
 }
 
-void ftrace_graph_sleep_time_control(bool enable)
-{
-	fgraph_sleep_time = enable;
-}
-
 /*
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
@@ -1098,7 +1090,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 * Does the user want to count the time a function was asleep.
 	 * If so, do not update the time stamps.
 	 */
-	if (fgraph_sleep_time)
+	if (!fgraph_no_sleep_time)
 		return;
 
 	timestamp = trace_clock_local();
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ab601cd9638b..7c3bbebeec7a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -862,6 +862,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 	return 1;
 }
 
+bool fprofile_no_sleep_time;
+
 static void profile_graph_return(struct ftrace_graph_ret *trace,
 				 struct fgraph_ops *gops,
 				 struct ftrace_regs *fregs)
@@ -887,7 +889,7 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 
 	calltime = rettime - profile_data->calltime;
 
-	if (!fgraph_sleep_time) {
+	if (fprofile_no_sleep_time) {
 		if (current->ftrace_sleeptime)
 			calltime -= current->ftrace_sleeptime - profile_data->sleeptime;
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 41b416a22450..58be6d741d72 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -943,8 +943,6 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
-extern void ftrace_graph_sleep_time_control(bool enable);
-
 #ifdef CONFIG_FUNCTION_PROFILER
 extern void ftrace_graph_graph_time_control(bool enable);
 #else
@@ -1115,7 +1113,8 @@ static inline void ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftra
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
-extern bool fgraph_sleep_time;
+extern unsigned int fgraph_no_sleep_time;
+extern bool fprofile_no_sleep_time;
 
 static inline bool
 ftrace_graph_ignore_func(struct fgraph_ops *gops, struct ftrace_graph_ent *trace)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 53adbe4bfedb..12315eb65925 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -19,6 +19,9 @@
 /* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
 
+/* Do not record function time when task is sleeping */
+unsigned int fgraph_no_sleep_time;
+
 struct fgraph_cpu_data {
 	pid_t		last_pid;
 	int		depth;
@@ -239,13 +242,14 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 	if (ftrace_graph_ignore_irqs(tr))
 		return 0;
 
-	if (fgraph_sleep_time) {
-		/* Only need to record the calltime */
-		ftimes = fgraph_reserve_data(gops->idx, sizeof(ftimes->calltime));
-	} else {
+	if (fgraph_no_sleep_time &&
+	    !tracer_flags_is_set(tr, TRACE_GRAPH_SLEEP_TIME)) {
 		ftimes = fgraph_reserve_data(gops->idx, sizeof(*ftimes));
 		if (ftimes)
 			ftimes->sleeptime = current->ftrace_sleeptime;
+	} else {
+		/* Only need to record the calltime */
+		ftimes = fgraph_reserve_data(gops->idx, sizeof(ftimes->calltime));
 	}
 	if (!ftimes)
 		return 0;
@@ -331,11 +335,15 @@ void __trace_graph_return(struct trace_array *tr,
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
-static void handle_nosleeptime(struct ftrace_graph_ret *trace,
+static void handle_nosleeptime(struct trace_array *tr,
+			       struct ftrace_graph_ret *trace,
 			       struct fgraph_times *ftimes,
 			       int size)
 {
-	if (fgraph_sleep_time || size < sizeof(*ftimes))
+	if (size < sizeof(*ftimes))
+		return;
+
+	if (!fgraph_no_sleep_time || tracer_flags_is_set(tr, TRACE_GRAPH_SLEEP_TIME))
 		return;
 
 	ftimes->calltime += current->ftrace_sleeptime - ftimes->sleeptime;
@@ -364,7 +372,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	if (!ftimes)
 		return;
 
-	handle_nosleeptime(trace, ftimes, size);
+	handle_nosleeptime(tr, trace, ftimes, size);
 
 	calltime = ftimes->calltime;
 
@@ -377,6 +385,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct ftrace_regs *fregs)
 {
 	struct fgraph_times *ftimes;
+	struct trace_array *tr;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -390,7 +399,8 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	if (!ftimes)
 		return;
 
-	handle_nosleeptime(trace, ftimes, size);
+	tr = gops->private;
+	handle_nosleeptime(tr, trace, ftimes, size);
 
 	if (tracing_thresh &&
 	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
@@ -452,6 +462,9 @@ static int graph_trace_init(struct trace_array *tr)
 	if (!tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))
 		ftrace_graph_skip_irqs++;
 
+	if (!tracer_flags_is_set(tr, TRACE_GRAPH_SLEEP_TIME))
+		fgraph_no_sleep_time++;
+
 	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
@@ -494,6 +507,11 @@ static void graph_trace_reset(struct trace_array *tr)
 	if (WARN_ON_ONCE(ftrace_graph_skip_irqs < 0))
 		ftrace_graph_skip_irqs = 0;
 
+	if (!tracer_flags_is_set(tr, TRACE_GRAPH_SLEEP_TIME))
+		fgraph_no_sleep_time--;
+	if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
+		fgraph_no_sleep_time = 0;
+
 	tracing_stop_cmdline_record();
 	unregister_ftrace_graph(tr->gops);
 }
@@ -1619,8 +1637,24 @@ void graph_trace_close(struct trace_iterator *iter)
 static int
 func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-	if (bit == TRACE_GRAPH_SLEEP_TIME)
-		ftrace_graph_sleep_time_control(set);
+/*
+ * The function profiler gets updated even if function graph
+ * isn't the current tracer. Handle it separately.
+ */
+#ifdef CONFIG_FUNCTION_PROFILER
+	if (bit == TRACE_GRAPH_SLEEP_TIME && (tr->flags & TRACE_ARRAY_FL_GLOBAL) &&
+	    !!set == fprofile_no_sleep_time) {
+		if (set) {
+			fgraph_no_sleep_time--;
+			if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
+				fgraph_no_sleep_time = 0;
+			fprofile_no_sleep_time = false;
+		} else {
+			fgraph_no_sleep_time++;
+			fprofile_no_sleep_time = true;
+		}
+	}
+#endif
 
 	/* Do nothing if the current tracer is not this tracer */
 	if (tr->current_trace != &graph_trace)
@@ -1630,6 +1664,16 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
+	if (bit == TRACE_GRAPH_SLEEP_TIME) {
+		if (set) {
+			fgraph_no_sleep_time--;
+			if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
+				fgraph_no_sleep_time = 0;
+		} else {
+			fgraph_no_sleep_time++;
+		}
+	}
+
 	if (bit == TRACE_GRAPH_PRINT_IRQS) {
 		if (set)
 			ftrace_graph_skip_irqs--;
-- 
2.51.0


