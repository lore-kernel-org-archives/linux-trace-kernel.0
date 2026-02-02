Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F222339;
	Mon,  2 Feb 2026 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035686; cv=none; b=U9hagsBMtxi6v5OUTk7f1XOGGPuuUqQSjfaYAQpUjhThsojMxbzOg6WD8zKq2LLgieQBg4garCkVkvANJJJYicbPGiGQPcQycFGteYphGoa0qeCfBg3JF2WNk3W+I0/Mn9TXzDPlQPle9vywwY42elvCojFVIRf/vMJQ5HewT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035686; c=relaxed/simple;
	bh=E23pU3vsSWjapsCWOZd/WRio2KJFZKBL0ZCvs0U6mBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KI4qPhW+JUltYLc6ZdeVuzXqXyWMpX8Vkut8Q/wVNefh561ii4guaHA1q10Hrk3oV4JVngRIUYhNKXtwJvgiN31ln4eFWYLHrINTsxBPMxRjAG/exyzzuZHA3YAfzSa0UJOqJksY+aPHJMaf8nnXUtpKpRGQIKrjwjRZC3Z21u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z9p79N2q; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z9p79N2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ec
	fu5/QuVUt+HUlbrzRAgqPUz7xhyGrm9jNTG/wE9g0=; b=Z9p79N2qo45bb0IKVF
	vGKU9pClqUDGSEqCgqjFRQQHWBVoU3t7N8F1h6K0L3GcY2luI8gepMF+YtTIeWQm
	BJjjCn4OMen9uLpbVgxrX+lKp58fTIisHN8ptHXzqT6qI62t3eE9lHkdBxuvUZwk
	bpMQcbOwxYTJZW8QupOnUFpHA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnso2nmYBphEY7Jw--.30663S2;
	Mon, 02 Feb 2026 20:33:44 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset for 32-bit ARM
Date: Mon,  2 Feb 2026 12:33:42 +0000
Message-Id: <20260202123342.2544795-1-imntjempty@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnso2nmYBphEY7Jw--.30663S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFykWry3uF48XFW8Kw1fXrb_yoWfWF47pa
	yftas5Kr4kJrW5KFyI9rs5Gr4fJryxJ347tFy7C34ayF9rtr1avry7Jr95Xa4rt34kC34a
	vayjvrW5Cr4Y9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsF4ZUUUUU=
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbC2wgLDGmAmagyjAAA3y

Commit <66611c0475709607f398e2a5d691b1fc72fe9dfc>
    (fgraph: Remove calltime and rettime from generic)
incorrectly modified the offset values for calltime and rettime fields
in the funcgraph_exit traceevent on 32-bit ARM, which are used to parse
the corresponding values fromtrace rawdata. The actual memory offset of
calltime is 20 (not 24), and rettime is 28 (not 32) for the 
funcgraph_exit event.

Before the fix,the funcgraph_exit format was:

~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format

name: funcgraph_exit
ID: 10
format:
    ...
    field:unsigned long long calltime; offset:24; size:8; signed:0;
    field:unsigned long long rettime; offset:32; size:8; signed:0;

After the fix, the correct funcgraph_exit format is:

name: funcgraph_exit
ID: 10
format:
    ...
    field:unsigned long long calltime; offset:20; size:8; signed:0;
    field:unsigned long long rettime; offset:28; size:8; signed:0;

Signed-off-by: jempty.liang <imntjempty@163.com>
---
 include/linux/ftrace.h               |  2 ++
 kernel/trace/trace.h                 |  3 +--
 kernel/trace/trace_entries.h         |  8 +++----
 kernel/trace/trace_functions_graph.c | 31 +++++++++++++---------------
 kernel/trace/trace_irqsoff.c         |  5 +++--
 kernel/trace/trace_sched_wakeup.c    |  6 ++++--
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3a8989e3268..52727a342273 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1191,6 +1191,8 @@ struct ftrace_graph_ret {
 	int depth;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned int overrun;
+	unsigned long long calltime;
+	unsigned long long rettime;
 } __packed;
 
 struct fgraph_ops;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 69e7defba6c6..18c8a0b1ecd5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -968,8 +968,7 @@ extern int __trace_graph_retaddr_entry(struct trace_array *tr,
 				struct ftrace_regs *fregs);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
-				 unsigned int trace_ctx,
-				 u64 calltime, u64 rettime);
+				 unsigned int trace_ctx);
 
 extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index f6a8d29c0d76..362a757e65a2 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -127,8 +127,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		retval	)
 		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_packed(unsigned long long,	ret,	calltime)
+		__field_packed(unsigned long long,	ret,	rettime)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
@@ -149,8 +149,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		func	)
 		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_packed(unsigned long long,	ret,	calltime)
+		__field_packed(unsigned long long,	ret,	rettime)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 1de6f1573621..0d2266ec67a4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -317,10 +317,12 @@ __trace_graph_function(struct trace_array *tr,
 	struct ftrace_graph_ret ret = {
 		.func     = ip,
 		.depth    = 0,
+		.calltime = time,
+		.rettime = time,
 	};
 
 	__trace_graph_entry(tr, &ent, trace_ctx);
-	__trace_graph_return(tr, &ret, trace_ctx, time, time);
+	__trace_graph_return(tr, &ret, trace_ctx);
 }
 
 void
@@ -333,8 +335,7 @@ trace_graph_function(struct trace_array *tr,
 
 void __trace_graph_return(struct trace_array *tr,
 			  struct ftrace_graph_ret *trace,
-			  unsigned int trace_ctx,
-			  u64 calltime, u64 rettime)
+			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -346,8 +347,6 @@ void __trace_graph_return(struct trace_array *tr,
 		return;
 	entry	= ring_buffer_event_data(event);
 	entry->ret				= *trace;
-	entry->calltime				= calltime;
-	entry->rettime				= rettime;
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
@@ -372,10 +371,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array *tr = gops->private;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
-	u64 calltime, rettime;
 	int size;
 
-	rettime = trace_clock_local();
+	trace->rettime = trace_clock_local();
 
 	ftrace_graph_addr_finish(gops, trace);
 
@@ -390,10 +388,10 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(tr, trace, ftimes, size);
 
-	calltime = ftimes->calltime;
+	trace->calltime = ftimes->calltime;
 
 	trace_ctx = tracing_gen_ctx();
-	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
+	__trace_graph_return(tr, trace, trace_ctx);
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
@@ -418,8 +416,10 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	tr = gops->private;
 	handle_nosleeptime(tr, trace, ftimes, size);
 
+	trace->calltime = ftimes->calltime;
+
 	if (tracing_thresh &&
-	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
+	    (trace->rettime - ftimes->calltime < tracing_thresh))
 		return;
 	else
 		trace_graph_return(trace, gops, fregs);
@@ -956,7 +956,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
-	duration = ret_entry->rettime - ret_entry->calltime;
+	duration = graph_ret->rettime - graph_ret->calltime;
 
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
@@ -1275,14 +1275,11 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 }
 
 static enum print_line_t
-print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
+print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 		   struct trace_entry *ent, struct trace_iterator *iter,
 		   u32 flags)
 {
-	struct ftrace_graph_ret *trace = &retentry->ret;
-	u64 calltime = retentry->calltime;
-	u64 rettime = retentry->rettime;
-	unsigned long long duration = rettime - calltime;
+	unsigned long long duration = trace->rettime - trace->calltime;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
 	unsigned long func;
@@ -1482,7 +1479,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
-		return print_graph_return(field, s, entry, iter, flags);
+		return print_graph_return(&field->ret, s, entry, iter, flags);
 	}
 	case TRACE_STACK:
 	case TRACE_FN:
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 17673905907c..946be462a211 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -229,11 +229,12 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
-	rettime = trace_clock_local();
+	trace->rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
 	if (calltime) {
+		trace->calltime = *calltime;
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+		__trace_graph_return(tr, trace, trace_ctx);
 	}
 	local_dec(&data->disabled);
 }
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 8faa73d3bba1..3bcfd1bf60ad 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -164,11 +164,13 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
 
-	rettime = trace_clock_local();
+	trace->rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (calltime)
+	if (calltime) {
+		trace->calltime = *calltime;
 		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	}
 
 	local_dec(&data->disabled);
 	preempt_enable_notrace();
-- 
2.25.1

