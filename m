Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0414600D;
	Wed,  4 Sep 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433175; cv=none; b=pg3A/cEWuVfyV7hd8qNp0uP11mwCNtQ4dj4mSXNXH1YOYcDAE81IOSCWEOX2oXP8mvvQb1YqfY0WTXAU/3Idqv90TZ2akGpMCykVch0n3S8PoAZf+2lg4C/FW1dOp1HX+hpvJP+GJos3K4kTYNlcBghgUSBPWhPh6JrL3J6VWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433175; c=relaxed/simple;
	bh=8KArWYxDYUDJ4scCS2qRzkTqEjcZPhCddUDfLvip7hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDjGXoCJQN3FxC+uFq3946naS5An5ps7N9l1N4XIoI848g/Swf4iKn6EdQd8OCZvXNznEiXjXPlO/nzuFK2eARcfRz5ML5LC4VlvS2BSpG5s44rvCeKkKlX+4RnwqqRU+v2WR79SZ7412jeYTTNhbq1za6bS2LV3ZTmNi/gxHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoykKDGX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoykKDGX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843La36025328;
	Wed, 4 Sep 2024 06:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=EHXEqHdLSqeJ3
	iFQang+Q8/lNpfAThetnfJ7+gLtcks=; b=HoykKDGX+J8Q2s1uTMWJJSqCkie46
	ki/v/NhDzytPM+qY83fh/VWgI6fFIuWyPu/srpP57TJ7Lt6HwTkm1F6SCPMiEXQ1
	m2G2gOWfb4IXSIY4JN1DXsnMukBu+pGMYgnUyjMbQrKhxBx5a3bFceoK6lf7e1V6
	EftS/BpXCVjPwNIil9DpHhAAOXeV+faUuqbXdXUNzBPa3g+vWJWmDhQcXlufnjam
	vHyMY9rQOYK/bbva5C0dvijhKcs1+aMHrrb62yD+slqdE/uT+QaDKuS3+MWxYDE+
	tW1lKQTwrmbt3oIIIbaPw3kc+PCWZIAKBcnv5SMUW35aHZVgfnMNnHLnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhmd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4844Klx0018726;
	Wed, 4 Sep 2024 06:59:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw16kpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xMui54133180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC0B22004D;
	Wed,  4 Sep 2024 06:59:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBEA92004B;
	Wed,  4 Sep 2024 06:59:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7CA82E0297; Wed,  4 Sep 2024 08:59:21 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 7/7] tracing: add arguments to function tracer
Date: Wed,  4 Sep 2024 08:59:01 +0200
Message-ID: <20240904065908.1009086-8-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SpzfxvEkpsCFHkUWVBjuRX8ZF1AHDWdq
X-Proofpoint-ORIG-GUID: SpzfxvEkpsCFHkUWVBjuRX8ZF1AHDWdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040049

Wire up the code to print function arguments in the function tracer.
This functionality can be enabled/disabled during compile time by
setting CONFIG_FUNCTION_TRACE_ARGS and during runtime with
options/func-args.

        ping-689     [004] b....    77.170220: dummy_xmit(skb = 0x82904800, dev = 0x882d0000) <-dev_hard_start_xmit

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace.c              |  8 +++++-
 kernel/trace/trace.h              |  4 ++-
 kernel/trace/trace_entries.h      |  7 +++--
 kernel/trace/trace_functions.c    | 46 +++++++++++++++++++++++++++----
 kernel/trace/trace_irqsoff.c      |  4 +--
 kernel/trace/trace_output.c       | 14 ++++++++--
 kernel/trace/trace_sched_wakeup.c |  4 +--
 7 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..8118e4c8c649 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2864,7 +2864,7 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 
 void
 trace_function(struct trace_array *tr, unsigned long ip, unsigned long
-	       parent_ip, unsigned int trace_ctx)
+	       parent_ip, unsigned int trace_ctx, struct ftrace_regs *regs)
 {
 	struct trace_event_call *call = &event_function;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -2878,6 +2878,12 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 	entry	= ring_buffer_event_data(event);
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+	if (regs)
+		entry->regs		= *regs;
+	else
+		memset(&entry->regs, 0, sizeof(struct ftrace_regs));
+#endif
 
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		if (static_branch_unlikely(&trace_function_exports_enabled))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd3e3069300e..13cf6f97f7e0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -673,7 +673,8 @@ unsigned long trace_total_entries(struct trace_array *tr);
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned int trace_ctx);
+		    unsigned int trace_ctx,
+		    struct ftrace_regs *regs);
 void trace_graph_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
@@ -870,6 +871,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_GRAPH_TIME          0x400
 #define TRACE_GRAPH_PRINT_RETVAL        0x800
 #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
+#define TRACE_GRAPH_ARGS		0x2000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index c47422b20908..f2021ab52da2 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -61,8 +61,11 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 	TRACE_FN,
 
 	F_STRUCT(
-		__field_fn(	unsigned long,	ip		)
-		__field_fn(	unsigned long,	parent_ip	)
+		__field_fn(	unsigned long,		ip		)
+		__field_fn(	unsigned long,		parent_ip	)
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+		__field_struct( struct ftrace_regs,	regs		)
+#endif
 	),
 
 	F_printk(" %ps <-- %ps",
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..7ff651a0b45a 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -25,6 +25,9 @@ static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct ftrace_regs *fregs);
 static void
+function_args_trace_call(unsigned long ip, unsigned long parent_ip,
+			 struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *fregs);
 static void
@@ -42,9 +45,10 @@ enum {
 	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
 	TRACE_FUNC_OPT_STACK		= 0x1,
 	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
+	TRACE_FUNC_OPT_ARGS		= 0x4,
 
 	/* Update this to next highest bit. */
-	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
+	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8
 };
 
 #define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
@@ -114,6 +118,8 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 	switch (flags_val & TRACE_FUNC_OPT_MASK) {
 	case TRACE_FUNC_NO_OPTS:
 		return function_trace_call;
+	case TRACE_FUNC_OPT_ARGS:
+		return function_args_trace_call;
 	case TRACE_FUNC_OPT_STACK:
 		return function_stack_trace_call;
 	case TRACE_FUNC_OPT_NO_REPEATS:
@@ -198,7 +204,34 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	if (!atomic_read(&data->disabled))
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+
+	ftrace_test_recursion_unlock(bit);
+}
+
+static void
+function_args_trace_call(unsigned long ip, unsigned long parent_ip,
+			 struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned int trace_ctx;
+	int bit;
+	int cpu;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	trace_ctx = tracing_gen_ctx();
+
+	cpu = smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	if (!atomic_read(&data->disabled))
+		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -247,7 +280,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 #ifdef CONFIG_UNWINDER_FRAME_POINTER
 		if (ftrace_pids_enabled(op))
 			skip++;
@@ -329,7 +362,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	trace_ctx = tracing_gen_ctx_flags(flags);
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 
 out:
 	ftrace_test_recursion_unlock(bit);
@@ -368,7 +401,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 		trace_ctx = tracing_gen_ctx_flags(flags);
 		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
 
@@ -382,6 +415,9 @@ static struct tracer_opt func_opts[] = {
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
 	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+	{ TRACER_OPT(func-args, TRACE_FUNC_OPT_ARGS) },
+#endif
 	{ } /* Always set a last empty entry */
 };
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..096002c99d70 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -150,7 +150,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
 
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	atomic_dec(&data->disabled);
 }
@@ -278,7 +278,7 @@ __trace_function(struct trace_array *tr,
 	if (is_graph(tr))
 		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
 #else
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 70405c4cceb6..8fdee7b9cdba 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1058,9 +1058,13 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, int flags)
+			   unsigned long parent_ip,
+			   struct ftrace_regs *fregs,
+			   int flags)
 {
 	seq_print_ip_sym(s, ip, flags);
+	if (fregs)
+		print_function_args(s, fregs, ip);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
 		trace_seq_puts(s, " <-");
@@ -1074,10 +1078,14 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 {
 	struct ftrace_entry *field;
 	struct trace_seq *s = &iter->seq;
+	struct ftrace_regs *fregs = NULL;
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+#if IS_ENABLED(CONFIG_FUNCTION_TRACE_ARGS)
+	fregs = &field->regs;
+#endif
+	print_fn_trace(s, field->ip, field->parent_ip, fregs, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1742,7 +1750,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, NULL, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 130ca7e7787e..39043c955761 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -224,7 +224,7 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	local_irq_save(flags);
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 	local_irq_restore(flags);
 
 	atomic_dec(&data->disabled);
@@ -309,7 +309,7 @@ __trace_function(struct trace_array *tr,
 	if (is_graph(tr))
 		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
 static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
-- 
2.43.0

