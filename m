Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FB2E7BB5;
	Tue, 18 Nov 2025 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426108; cv=none; b=b1hCOMws4dj3Q5kYk/bYbEnzHHkcO3pD9AmBaF3CAjdTpvkI9hLJz2Ee1N5Iq/fpfcClDTQpNTLrb/1mRzZmm7PhBwtm/ljFnM26OD3XqTvqg7mMm09MnRbNkzgCcpjZiqXtDErPbDt6hnrl12Wezdl097CIULp1sCAmnedCeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426108; c=relaxed/simple;
	bh=tdCAgiBfFbLdnu9LTX04d6mRD0R2Wcol8CgqeSTQTb0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=u4mHZ9kWi0+JzMuZFwt3BuOsRupBpqzi55N2KmPs2iJNAqOAtf1DEj5zPncbFjyGVuGB2TIblEOqGkDasbAPt6aNMDRIdkTkJIqIV83dZreih4wVfojMej3+jNtPTANU2kle/aPtlFxeHeKwunxPb4Xvk8ltvK1ZDXWAx8PxmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb4HH3C9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb4HH3C9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D8C2BCB8;
	Tue, 18 Nov 2025 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426107;
	bh=tdCAgiBfFbLdnu9LTX04d6mRD0R2Wcol8CgqeSTQTb0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Mb4HH3C9l00ruA5SBJMNyTaeWLa6vQo3lTaMF66ecOnlLchTGxe80rp6sEnMFRuw5
	 GzaS458KHJ9RjWwUfggLRBn+L8Bw8bpAnFazIXSOTDn1xs4WA7HZhYs35qIVVhSa3s
	 cxSk7U3B9zCmTCNmpN+4FvqQ76c0nt+i1X4YyjZ3d2i5+b/GhMiek6brGbNBydfukV
	 4WAiGWkC5QHZolPQFePI1LlVdLw71Igf325ov5Dpjya9mKWHMBuzUYe9i+RJj9cKbW
	 WO1h/mX7pJw61SnCBJ2LCssk1glloTrbH2t04fy7eYn4D2aApGXDloywe6e4qLuwy8
	 lzihCP9+xuG7g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vL9gy-00000002zKy-0MTb;
	Mon, 17 Nov 2025 19:35:32 -0500
Message-ID: <20251118003531.944170593@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 17 Nov 2025 19:29:53 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [POC][RFC][PATCH 3/3] fgraph: Add perf counters to function graph tracer
References: <20251118002950.680329246@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add option to trigger perf events to function graph tracing.

Two new options are added: funcgraph-cpu-cycles and funcgraph-cache-misses

This adds the perf event right after the start of a function and again
just before the end of a function.

 # cd /sys/kernel/tracing
 # echo 1 > options/funcgraph-cache-misses
 # echo vfs_read > set_graph_function
 # echo function_graph > current_tracer
 # cat trace
[..]
 5)               |  vfs_read() {
 5)               |  /* cache_misses: 822565 */
 5)               |    rw_verify_area() {
 5)               |      /* cache_misses: 824003 */
 5)               |      security_file_permission() {
 5)               |        /* cache_misses: 825440 */
 5)               |        apparmor_file_permission() {
 5)               |          /* cache_misses: 826875 */
 5)               |          aa_file_perm() {
 5)               |            /* cache_misses: 828326 */
 5)               |            __rcu_read_lock() {
 5)               |              /* cache_misses: 829766 */
 5)               |              /* cache_misses: 830785 */
 5)   5.116 us    |            }
 5)               |            __rcu_read_unlock() {
 5)               |              /* cache_misses: 832611 */
 5)               |              /* cache_misses: 833632 */
 5)   5.223 us    |            }
 5)               |            /* cache_misses: 835043 */
 5) + 25.462 us   |          }
 5)               |          /* cache_misses: 836454 */
 5) + 35.518 us   |        }
 5)               |        bpf_lsm_file_permission() {
 5)               |          /* cache_misses: 838276 */
 5)               |          /* cache_misses: 839292 */
 5)   4.613 us    |        }
 5)               |        /* cache_misses: 840697 */
 5) + 54.684 us   |      }
 5)               |      /* cache_misses: 842107 */
 5) + 64.449 us   |    }

The option will cause the perf event to be triggered after every function
called.

If cpu_cycles is also enabled:

 # echo 1 > options/funcgraph-cpu-cycles
 # cat trace
[..]
 3)               |  vfs_read() {
 3)               |  /* cpu_cycles: 2947481793 cache_misses: 2002984031 */
 3)               |    rw_verify_area() {
 3)               |      /* cpu_cycles: 2947488061 cache_misses: 2002985922 */
 3)               |      security_file_permission() {
 3)               |        /* cpu_cycles: 2947492867 cache_misses: 2002987812 */
 3)               |        apparmor_file_permission() {
 3)               |          /* cpu_cycles: 2947497713 cache_misses: 2002989700 */
 3)               |          aa_file_perm() {
 3)               |            /* cpu_cycles: 2947502560 cache_misses: 2002991604 */
 3)               |            __rcu_read_lock() {
 3)               |              /* cpu_cycles: 2947507398 cache_misses: 2002993497 */
 3)               |              /* cpu_cycles: 2947512435 cache_misses: 2002994969 */
 3)   7.586 us    |            }
 3)               |            __rcu_read_unlock() {
 3)               |              /* cpu_cycles: 2947518226 cache_misses: 2002997248 */
 3)               |              /* cpu_cycles: 2947522328 cache_misses: 2002998722 */
 3)   7.211 us    |            }
 3)               |            /* cpu_cycles: 2947527067 cache_misses: 2003000586 */
 3) + 37.581 us   |          }
 3)               |          /* cpu_cycles: 2947531727 cache_misses: 2003002450 */
 3) + 52.061 us   |        }
 3)               |        bpf_lsm_file_permission() {
 3)               |          /* cpu_cycles: 2947537274 cache_misses: 2003004725 */
 3)               |          /* cpu_cycles: 2947541104 cache_misses: 2003006194 */
 3)   7.029 us    |        }
 3)               |        /* cpu_cycles: 2947545762 cache_misses: 2003008052 */
 3) + 80.971 us   |      }
 3)               |      /* cpu_cycles: 2947550459 cache_misses: 2003009915 */
 3) + 95.515 us   |    }

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                 |   4 +
 kernel/trace/trace_functions_graph.c | 117 +++++++++++++++++++++++++--
 2 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bb764a2255c7..64cdb6fda3fb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -366,7 +366,9 @@ struct trace_array {
 
 	int			perf_events;
 	int			ftrace_perf_events;
+	int			fgraph_perf_events;
 	u64			ftrace_perf_mask;
+	u64			fgraph_perf_mask;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
@@ -946,6 +948,8 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
 #define TRACE_GRAPH_PRINT_RETADDR       0x2000
 #define TRACE_GRAPH_ARGS		0x4000
+#define TRACE_GRAPH_PERF_CACHE		0x8000
+#define TRACE_GRAPH_PERF_CYCLES		0x10000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 44d5dc5031e2..e618dd12ca0c 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -22,6 +22,8 @@ static int ftrace_graph_skip_irqs;
 /* Do not record function time when task is sleeping */
 unsigned int fgraph_no_sleep_time;
 
+static struct tracer graph_trace;
+
 struct fgraph_cpu_data {
 	pid_t		last_pid;
 	int		depth;
@@ -88,6 +90,11 @@ static struct tracer_opt trace_opts[] = {
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
 
+#ifdef CONFIG_PERF_EVENTS
+	{ TRACER_OPT(funcgraph-cache-misses, TRACE_GRAPH_PERF_CACHE) },
+	{ TRACER_OPT(funcgraph-cpu-cycles, TRACE_GRAPH_PERF_CYCLES) },
+#endif
+
 	{ } /* Empty entry */
 };
 
@@ -104,6 +111,97 @@ static bool tracer_flags_is_set(struct trace_array *tr, u32 flags)
 	return (tr->current_trace_flags->val & flags) == flags;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+static inline void handle_perf_event(struct trace_array *tr, unsigned int trace_ctx)
+{
+	if (!tr->fgraph_perf_events)
+		return;
+	ftrace_perf_events(tr, tr->fgraph_perf_events, tr->fgraph_perf_mask, trace_ctx);
+}
+
+static int ftrace_graph_perf_event(struct trace_array *tr, int set, int bit)
+{
+	u64 mask;
+	int type;
+	int ret = 0;
+
+	/* Do nothing if the current tracer is not this tracer */
+	if (tr->current_trace != &graph_trace)
+		return 0;
+
+	switch (bit) {
+	case TRACE_GRAPH_PERF_CACHE:
+		mask = TRACE_ITER(PERF_CACHE);
+		type = PERF_TRACE_CACHE;
+		break;
+	case TRACE_GRAPH_PERF_CYCLES:
+		mask = TRACE_ITER(PERF_CYCLES);
+		type = PERF_TRACE_CYCLES;
+		break;
+	}
+
+	if (set)
+		ret = trace_perf_event_enable(type);
+	else
+		trace_perf_event_disable(type);
+
+	if (ret < 0)
+		return ret;
+
+	if (set) {
+		tr->fgraph_perf_events++;
+		tr->fgraph_perf_mask |= mask;
+	} else {
+		tr->fgraph_perf_mask &= ~mask;
+		tr->fgraph_perf_events--;
+	}
+	return 0;
+}
+
+static void ftrace_graph_perf_enable(struct trace_array *tr, int bit)
+{
+	int err;
+
+	if (!(tr->current_trace_flags->val & bit))
+		return;
+
+	err = ftrace_graph_perf_event(tr, 1, bit);
+	if (err < 0)
+		tr->current_trace_flags->val &= ~bit;
+}
+
+static void ftrace_graph_perf_disable(struct trace_array *tr, int bit)
+{
+	/* Only disable if it was enabled */
+	if (!(tr->current_trace_flags->val & bit))
+		return;
+
+	ftrace_graph_perf_event(tr, 0, bit);
+}
+
+static void fgraph_perf_init(struct trace_array *tr)
+{
+	ftrace_graph_perf_enable(tr, TRACE_GRAPH_PERF_CYCLES);
+	ftrace_graph_perf_enable(tr, TRACE_GRAPH_PERF_CACHE);
+}
+
+static void fgraph_perf_reset(struct trace_array *tr)
+{
+	ftrace_graph_perf_disable(tr, TRACE_GRAPH_PERF_CYCLES);
+	ftrace_graph_perf_disable(tr, TRACE_GRAPH_PERF_CACHE);
+}
+#else
+static inline void handle_perf_event(struct trace_array *tr, unsigned int trace_ctx)
+{
+}
+static inline void fgraph_perf_init(struct trace_array *tr)
+{
+}
+static inline void fgraph_perf_reset(struct trace_array *tr)
+{
+}
+#endif
+
 /*
  * DURATION column is being also used to display IRQ signs,
  * following values are used by print_graph_irq and others
@@ -272,6 +370,9 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 		ret = __graph_entry(tr, trace, trace_ctx, fregs);
 	}
 
+	if (ret)
+		handle_perf_event(tr, trace_ctx);
+
 	return ret;
 }
 
@@ -324,6 +425,8 @@ void __trace_graph_return(struct trace_array *tr,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ret_entry *entry;
 
+	handle_perf_event(tr, trace_ctx);
+
 	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RET,
 					  sizeof(*entry), trace_ctx);
 	if (!event)
@@ -465,6 +568,8 @@ static int graph_trace_init(struct trace_array *tr)
 	if (!tracer_flags_is_set(tr, TRACE_GRAPH_SLEEP_TIME))
 		fgraph_no_sleep_time++;
 
+	fgraph_perf_init(tr);
+
 	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
@@ -476,8 +581,6 @@ static int graph_trace_init(struct trace_array *tr)
 	return 0;
 }
 
-static struct tracer graph_trace;
-
 static int ftrace_graph_trace_args(struct trace_array *tr, int set)
 {
 	trace_func_graph_ent_t entry;
@@ -512,6 +615,7 @@ static void graph_trace_reset(struct trace_array *tr)
 	if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
 		fgraph_no_sleep_time = 0;
 
+	fgraph_perf_reset(tr);
 	tracing_stop_cmdline_record();
 	unregister_ftrace_graph(tr->gops);
 }
@@ -1684,9 +1788,12 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 			ftrace_graph_skip_irqs = 0;
 		break;
 
-	case TRACE_GRAPH_ARGS:
-		return ftrace_graph_trace_args(tr, set);
-	}
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_GRAPH_PERF_CACHE:
+	case TRACE_GRAPH_PERF_CYCLES:
+		return ftrace_graph_perf_event(tr, set, bit);
+#endif
+	};
 
 	return 0;
 }
-- 
2.51.0


