Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001119E971;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979730; cv=none; b=Opo2r+YAnD3yxMOhJD0NpWQufn34geVl+IzT4IutjDjwu20V4m0bOoYuMu6ylVyMbi54I7kIq12/lertKpdTn9vItM8fayznLWd2wQ55NuMeERlQ3p6T1ino7Byri0D+HbFTU+eO4503i8YdWQvxWq0fqUQCVY0pgvFI6K0+nYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979730; c=relaxed/simple;
	bh=GZ6J+SNXpCNzqhn5JXvxc+BghHdqXLuJyQRyunbnTbk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EAFYnDPDRuYyRtVWjtV1jReIXZ9tyMUpYXT6VAMiYV9Xw9VM1MRi0k7QubUezf5PBHYPjvMudLm2NVY4MNSSVROB+wOQvYMNTr7HlsrkMb0NhtwleXSaXt/wwMBa9HMaMVXmBJIDkN2k/f7yD9/SotOtvSMDh5dhdYQQA2yTnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF905C4CED3;
	Mon, 23 Dec 2024 18:48:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPnUr-0000000DcmH-1Trz;
	Mon, 23 Dec 2024 13:49:41 -0500
Message-ID: <20241223184941.204074053@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 13:46:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] fgraph: Remove unnecessary disabling of interrupts and recursion
References: <20241223184618.176607694@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function graph tracer disables interrupts as well as prevents
recursion via NMIs when recording the graph tracer code. There's no reason
to do this today. That disabling goes back to 2008 when the function graph
tracer was first introduced and recursion protection wasn't part of the
code.

Today, there's no reason to disable interrupts or prevent the code from
recursing as the infrastructure can easily handle it.

Before this change:

~# echo function_graph > /sys/kernel/tracing/current_tracer
~# perf stat -r 10 ./hackbench 10
Time: 4.240
Time: 4.236
Time: 4.106
Time: 4.014
Time: 4.314
Time: 3.830
Time: 4.063
Time: 4.323
Time: 3.763
Time: 3.727

 Performance counter stats for '/work/c/hackbench 10' (10 runs):

         33,937.20 msec task-clock                       #    7.008 CPUs utilized               ( +-  1.85% )
            18,220      context-switches                 #  536.874 /sec                        ( +-  6.41% )
               624      cpu-migrations                   #   18.387 /sec                        ( +-  9.07% )
            11,319      page-faults                      #  333.528 /sec                        ( +-  1.97% )
    76,657,643,617      cycles                           #    2.259 GHz                         ( +-  0.40% )
   141,403,302,768      instructions                     #    1.84  insn per cycle              ( +-  0.37% )
    25,518,463,888      branches                         #  751.932 M/sec                       ( +-  0.35% )
       156,151,050      branch-misses                    #    0.61% of all branches             ( +-  0.63% )

            4.8423 +- 0.0892 seconds time elapsed  ( +-  1.84% )

After this change:

~# echo function_graph > /sys/kernel/tracing/current_tracer
~# perf stat -r 10 ./hackbench 10
Time: 3.340
Time: 3.192
Time: 3.129
Time: 2.579
Time: 2.589
Time: 2.798
Time: 2.791
Time: 2.955
Time: 3.044
Time: 3.065

 Performance counter stats for './hackbench 10' (10 runs):

         24,416.30 msec task-clock                       #    6.996 CPUs utilized               ( +-  2.74% )
            16,764      context-switches                 #  686.590 /sec                        ( +-  5.85% )
               469      cpu-migrations                   #   19.208 /sec                        ( +-  6.14% )
            11,519      page-faults                      #  471.775 /sec                        ( +-  1.92% )
    53,895,628,450      cycles                           #    2.207 GHz                         ( +-  0.52% )
   105,552,664,638      instructions                     #    1.96  insn per cycle              ( +-  0.47% )
    17,808,672,667      branches                         #  729.376 M/sec                       ( +-  0.48% )
       133,075,435      branch-misses                    #    0.75% of all branches             ( +-  0.59% )

             3.490 +- 0.112 seconds time elapsed  ( +-  3.22% )

Also removed unneeded "unlikely()" around the retaddr code.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 37 +++++++++++-----------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 5504b5e4e7b4..f513603d7df9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -181,10 +181,9 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	struct fgraph_times *ftimes;
-	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
-	int ret;
+	int ret = 0;
 	int cpu;
 
 	if (*task_var & TRACE_GRAPH_NOTRACE)
@@ -235,25 +234,21 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	if (tracing_thresh)
 		return 1;
 
-	local_irq_save(flags);
+	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
-	disabled = atomic_inc_return(&data->disabled);
-	if (likely(disabled == 1)) {
-		trace_ctx = tracing_gen_ctx_flags(flags);
-		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
-			tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR))) {
+	disabled = atomic_read(&data->disabled);
+	if (likely(!disabled)) {
+		trace_ctx = tracing_gen_ctx();
+		if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
+		    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
 			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
-
 			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
-		} else
+		} else {
 			ret = __trace_graph_entry(tr, trace, trace_ctx);
-	} else {
-		ret = 0;
+		}
 	}
-
-	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	preempt_enable_notrace();
 
 	return ret;
 }
@@ -320,7 +315,6 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	struct fgraph_times *ftimes;
-	unsigned long flags;
 	unsigned int trace_ctx;
 	long disabled;
 	int size;
@@ -341,16 +335,15 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	trace->calltime = ftimes->calltime;
 
-	local_irq_save(flags);
+	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
-	disabled = atomic_inc_return(&data->disabled);
-	if (likely(disabled == 1)) {
-		trace_ctx = tracing_gen_ctx_flags(flags);
+	disabled = atomic_read(&data->disabled);
+	if (likely(!disabled)) {
+		trace_ctx = tracing_gen_ctx();
 		__trace_graph_return(tr, trace, trace_ctx);
 	}
-	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	preempt_enable_notrace();
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
-- 
2.45.2


