Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046262F0C7C;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148181; cv=none; b=DYexwoacJGCWG4yt5u1GfMGLf0smOeqHgoU5qFFmNvbok9Q2zKKvKMC2rf+MX38Kzcxyz/w3yy9OVh/RTZ4IuWjdkDMY2jLrTGo0s0x4gCaClR6DO/QTLUplw1yc2wr+8evgBMU1r2JYwNyjK/G/RAq2gaA0jhF8TbBVLzI0j9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148181; c=relaxed/simple;
	bh=PVgrYQ5KGD7dADyqvB1WQz0bU0jVkV7FpTxE3x/icRQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ef5xT41a/sVDj8ssYGoGe3zz3DGsqggGaF6xbxXYHKADsBQ7O/VSxQOMKM8k4HN71y5oJecsj+bwHYzwbdzhbxRUGb1oCwcoevBEtNXHezUyU74rLAn6VEGNF+CzHUdlMIt11WapqlwFKFzi4q8YK8dA+n/eU9ku/zP5Dv/7LMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiGmyEAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiGmyEAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690E9C113D0;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148180;
	bh=PVgrYQ5KGD7dADyqvB1WQz0bU0jVkV7FpTxE3x/icRQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=JiGmyEAz9jZwEZ+gUwonQsmUTo/MwUgk+3i9rCAFNZRxCqqt9xyCZ2SJMZWlHbcYm
	 Oboytc/fanAlAsfiwRELwidXQVdPgHf3cjtAA+roaiCAph5XyDpVUmVY4MqZhmHBTq
	 EH/H4UVjR6KbWfzPJxOg8XAP90Im7sbv9IluHuvI1I0qpJ+Zrv18B/R0y/q+RkklZ5
	 3eFW5p+2SxsRwS0Pdi2pjMjkxM+GqWnUnR08ok6hg1XKBRUJxhdTOoHVZ+w9Co3tsT
	 Kt6c0GXR4QJWAI9cB17kxNtnIhxvrNEF4UKIKOhHUsm27o8Se0OvSRGXkKwsBOB4L6
	 c1ZLwO+BZyjQA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJzOA-00000001p8Y-3tfg;
	Fri, 14 Nov 2025 14:23:18 -0500
Message-ID: <20251114192318.781711154@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 14 Nov 2025 14:22:31 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] tracing: Move graph-time out of function graph options
References: <20251114192229.829042264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The option "graph-time" affects the function profiler when it is using the
function graph infrastructure. It has nothing to do with the function
graph tracer itself. The option only affects the global function profiler
and does nothing to the function graph tracer.

Move it out of the function graph tracer options and make it a global
option that is only available at the top level instance.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c                 | 14 ++++++++++----
 kernel/trace/trace.h                 | 13 ++++++++++++-
 kernel/trace/trace_functions_graph.c | 10 +---------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9268489d2ce8..8ae95800592d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -509,10 +509,10 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_flags holds trace_options default values */
 #define TRACE_DEFAULT_FLAGS						\
-	(FUNCTION_DEFAULT_FLAGS |					\
-	 TRACE_ITER(PRINT_PARENT) | TRACE_ITER(PRINTK) |			\
+	(FUNCTION_DEFAULT_FLAGS | FPROFILE_DEFAULT_FLAGS |		\
+	 TRACE_ITER(PRINT_PARENT) | TRACE_ITER(PRINTK) |		\
 	 TRACE_ITER(ANNOTATE) | TRACE_ITER(CONTEXT_INFO) |		\
-	 TRACE_ITER(RECORD_CMD) | TRACE_ITER(OVERWRITE) |			\
+	 TRACE_ITER(RECORD_CMD) | TRACE_ITER(OVERWRITE) |		\
 	 TRACE_ITER(IRQ_INFO) | TRACE_ITER(MARKERS) |			\
 	 TRACE_ITER(HASH_PTR) | TRACE_ITER(TRACE_PRINTK) |		\
 	 TRACE_ITER(COPY_MARKER))
@@ -520,7 +520,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER(PRINTK) |			\
 	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD) |	\
-	       TRACE_ITER(PROF_TEXT_OFFSET))
+	       TRACE_ITER(PROF_TEXT_OFFSET) | FPROFILE_DEFAULT_FLAGS)
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
@@ -5331,6 +5331,12 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		trace_printk_start_stop_comm(enabled);
 		trace_printk_control(enabled);
 		break;
+
+#if defined(CONFIG_FUNCTION_PROFILER) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	case TRACE_GRAPH_GRAPH_TIME:
+		ftrace_graph_graph_time_control(enabled);
+		break;
+#endif
 	}
 
 	return 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 299862aad66c..41b416a22450 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1368,8 +1368,18 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 #ifdef CONFIG_FUNCTION_PROFILER
 # define PROFILER_FLAGS					\
 		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
+# ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#  define FPROFILE_FLAGS				\
+		C(GRAPH_TIME,		"graph-time"),
+#  define FPROFILE_DEFAULT_FLAGS	TRACE_ITER(GRAPH_TIME)
+# else
+#  define FPROFILE_FLAGS
+#  define FPROFILE_DEFAULT_FLAGS	0UL
+# endif
 #else
 # define PROFILER_FLAGS
+# define FPROFILE_FLAGS
+# define FPROFILE_DEFAULT_FLAGS			0UL
 # define TRACE_ITER_PROF_TEXT_OFFSET_BIT	-1
 #endif
 
@@ -1412,7 +1422,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
 		BRANCH_FLAGS					\
-		PROFILER_FLAGS
+		PROFILER_FLAGS					\
+		FPROFILE_FLAGS
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3f55b49cf64e..53adbe4bfedb 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -85,11 +85,6 @@ static struct tracer_opt trace_opts[] = {
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
 
-#ifdef CONFIG_FUNCTION_PROFILER
-	/* Include time within nested functions */
-	{ TRACER_OPT(graph-time, TRACE_GRAPH_GRAPH_TIME) },
-#endif
-
 	{ } /* Empty entry */
 };
 
@@ -97,7 +92,7 @@ static struct tracer_flags tracer_flags = {
 	/* Don't display overruns, proc, or tail by default */
 	.val = TRACE_GRAPH_PRINT_CPU | TRACE_GRAPH_PRINT_OVERHEAD |
 	       TRACE_GRAPH_PRINT_DURATION | TRACE_GRAPH_PRINT_IRQS |
-	       TRACE_GRAPH_SLEEP_TIME | TRACE_GRAPH_GRAPH_TIME,
+	       TRACE_GRAPH_SLEEP_TIME,
 	.opts = trace_opts
 };
 
@@ -1627,9 +1622,6 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (bit == TRACE_GRAPH_SLEEP_TIME)
 		ftrace_graph_sleep_time_control(set);
 
-	if (bit == TRACE_GRAPH_GRAPH_TIME)
-		ftrace_graph_graph_time_control(set);
-
 	/* Do nothing if the current tracer is not this tracer */
 	if (tr->current_trace != &graph_trace)
 		return 0;
-- 
2.51.0


