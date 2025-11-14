Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3B2D595D;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148180; cv=none; b=MTJrS8kZ3WTfECbQqC/bOOzIHFgVXoS/rtExZd9jphAJ30Ja1a4em677j+IIKvGEILZpqGyj+/5grY8GTwKJ2jhM0VoBlNNPFLUlONhHq1z2uwvUiO7X8NuC3VVZ/4vWjzdDH6sRIuvV+nb/wDqvrwcDaQ2a8hezHgVxjKC+xbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148180; c=relaxed/simple;
	bh=+Zkc7CFdjwsh53Uw+ky0k7Ftc5rFO3cpR5Z83cqWyNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sz4gyItPD18NPw9hps5vbv/417HaMd/8VYt+UANGMOevWz/9LxDClZbkUb4BoE3eSW4BcNeC3B/uZHJqg1JseOoRFFcVvDjdSxtfqjFn+p7HUyYTaTpxONhCydBgOFFGAS8RaE/Cd5jYAL/Mjh8N+cZCMX63zXlMFyK28D3T6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYl6ESo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYl6ESo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9B6C4CEF8;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148180;
	bh=+Zkc7CFdjwsh53Uw+ky0k7Ftc5rFO3cpR5Z83cqWyNk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lYl6ESo+Kd/fwDaLRhAxZa96KBnrGy5vYM2Hfnt4BwRJTctX3kx5C/jJDOwtFYLaS
	 22lf+1J7ZPxoPBUQrSS2lL3cbyat3yGy7tOL8m+ezCANHspGgjE1rrFduIS+u8/PaN
	 QVK7hk6dygFhaK5qeBqT1yuKN7nhEr3LS7LXbavF5ziP8SGX+FOLOhhkUrezXvaSid
	 N0IJMLd+s4NBUUwZnpuqQ7bBSm7x3DI204XsfIZ0nP8CCThUwckTPb7FrSPUH6AFsm
	 vdzMEw4xmQZc8FKqNab8I8TSYQCkKDgI4CmMIbtziz8QPATj9senW8FGzLwic7fDq1
	 kPVcQ4GQkXl+w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJzOA-00000001p84-3Bxv;
	Fri, 14 Nov 2025 14:23:18 -0500
Message-ID: <20251114192318.613867934@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 14 Nov 2025 14:22:30 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] tracing: Have function graph tracer option funcgraph-irqs be per
 instance
References: <20251114192229.829042264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the option to trace interrupts in the function graph tracer is
global when the interface is per-instance. Changing the value in one
instance will affect the results of another instance that is also running
the function graph tracer. This can lead to confusing results.

Fixes: c132be2c4fcc1 ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 41 +++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4e86adf6dd4d..3f55b49cf64e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 #include "trace_output.h"
 
-/* When set, irq functions will be ignored */
+/* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
 
 struct fgraph_cpu_data {
@@ -190,11 +190,14 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 }
 #endif
 
-static inline int ftrace_graph_ignore_irqs(void)
+static inline int ftrace_graph_ignore_irqs(struct trace_array *tr)
 {
 	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
 		return 0;
 
+	if (tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))
+		return 0;
+
 	return in_hardirq();
 }
 
@@ -238,7 +241,7 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
 
-	if (ftrace_graph_ignore_irqs())
+	if (ftrace_graph_ignore_irqs(tr))
 		return 0;
 
 	if (fgraph_sleep_time) {
@@ -451,6 +454,9 @@ static int graph_trace_init(struct trace_array *tr)
 	else
 		tr->gops->retfunc = trace_graph_return;
 
+	if (!tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))
+		ftrace_graph_skip_irqs++;
+
 	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
@@ -468,10 +474,6 @@ static int ftrace_graph_trace_args(struct trace_array *tr, int set)
 {
 	trace_func_graph_ent_t entry;
 
-	/* Do nothing if the current tracer is not this tracer */
-	if (tr->current_trace != &graph_trace)
-		return 0;
-
 	if (set)
 		entry = trace_graph_entry_args;
 	else
@@ -492,6 +494,11 @@ static int ftrace_graph_trace_args(struct trace_array *tr, int set)
 
 static void graph_trace_reset(struct trace_array *tr)
 {
+	if (!tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))
+		ftrace_graph_skip_irqs--;
+	if (WARN_ON_ONCE(ftrace_graph_skip_irqs < 0))
+		ftrace_graph_skip_irqs = 0;
+
 	tracing_stop_cmdline_record();
 	unregister_ftrace_graph(tr->gops);
 }
@@ -1617,15 +1624,29 @@ void graph_trace_close(struct trace_iterator *iter)
 static int
 func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-	if (bit == TRACE_GRAPH_PRINT_IRQS)
-		ftrace_graph_skip_irqs = !set;
-
 	if (bit == TRACE_GRAPH_SLEEP_TIME)
 		ftrace_graph_sleep_time_control(set);
 
 	if (bit == TRACE_GRAPH_GRAPH_TIME)
 		ftrace_graph_graph_time_control(set);
 
+	/* Do nothing if the current tracer is not this tracer */
+	if (tr->current_trace != &graph_trace)
+		return 0;
+
+	/* Do nothing if already set. */
+	if (!!set == !!(tr->current_trace_flags->val & bit))
+		return 0;
+
+	if (bit == TRACE_GRAPH_PRINT_IRQS) {
+		if (set)
+			ftrace_graph_skip_irqs--;
+		else
+			ftrace_graph_skip_irqs++;
+		if (WARN_ON_ONCE(ftrace_graph_skip_irqs < 0))
+			ftrace_graph_skip_irqs = 0;
+	}
+
 	if (bit == TRACE_GRAPH_ARGS)
 		return ftrace_graph_trace_args(tr, set);
 
-- 
2.51.0


