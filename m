Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69F1E86E;
	Thu, 30 Oct 2025 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793323; cv=none; b=dNX2pi5I/ihZteNsH5BwNNPAj398je+h3KiwjrSJvC9ndifFJHW3y7htmMtKVJ706XZ5717abx458APn7fdrdvcqInX0poTiZBfwN9+jdYQJTxuVzHj8b10+ldUK3cY94yNYE8tGEOkvFvBNyaRe/qlwu4V01u4kRSVwpRXpidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793323; c=relaxed/simple;
	bh=7z+KPJHcb3snUj3/qZ1u0b1WZub3RMGbzF36uKB0Fjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMIAH/4igsCo/2DMRjM589OxsMO30UoTBLGIl2QfyVLKhkY1Q95O2hthlpB5Us1zvG56A/lj7x+0yBt1JT3d256+zNfMgUGEGBK9NQC7w53M8rPFFnXdIRwrVaVlLh5OK+2kQtTU0H5JMAWr90NPUQH0ia4uzc3t0eI6gFS9k5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfi8JTTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfi8JTTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD82C4CEF7;
	Thu, 30 Oct 2025 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761793322;
	bh=7z+KPJHcb3snUj3/qZ1u0b1WZub3RMGbzF36uKB0Fjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nfi8JTTkMbyLMgCG/W3psLbFuA45pCgSMcs+5ukBZiMzmvDdlZccL7+QzMRL9KCIZ
	 c1h9AmqyrOoouO1Zpq5cqPZmV8YLsvLbe89qhlhMiEXTyuAi0RhcHo9Rwhct6CYMD6
	 uD3FLLO5zURWer2pViK2MpG5HCKL8e+NKM3TXfyt8dDqlZxf6u0013/LwFAM497va7
	 O4J7QNV92S1wO3ezVDwXit4Rzr9Sv6e62pzQpayHIUzKyiVi/OprqLcaWQciJsTQxd
	 p+/a89n3orQWL8SQaWuAk/QGR5cMT4mTogF58gOYYA8D74HA5tXWcOM2uV5BRT0UaP
	 R5WqHE9Wqt4jA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] tracing: Allow tracer to add more than 32 options
Date: Thu, 30 Oct 2025 12:01:58 +0900
Message-ID: <176179331866.957820.6297044228818064748.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176179330871.957820.2367690308433599462.stgit@devnote2>
References: <176179330871.957820.2367690308433599462.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since enum trace_iterator_flags is 32bit, the max number of the
option flags is limited to 32 and it is fully used now. To add
a new option, we need to expand it.

So replace the TRACE_ITER_##flag with TRACE_ITER(flag) macro which
is 64bit bitmask.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Rebased on the latest for-next.
 Changes in v5:
  - Use TRACE_ITER() macro.
 Changes in v4:
  - Use enum ... : type {} instead of const variables.
 Changes in v3:
  - Make TRACE_ITER_* to global.
---
 kernel/trace/blktrace.c              |    6 +
 kernel/trace/trace.c                 |  151 +++++++++++++++++-----------------
 kernel/trace/trace.h                 |   29 +++----
 kernel/trace/trace_events.c          |    4 -
 kernel/trace/trace_events_synth.c    |    2 
 kernel/trace/trace_fprobe.c          |    6 +
 kernel/trace/trace_functions_graph.c |   18 ++--
 kernel/trace/trace_irqsoff.c         |   30 +++----
 kernel/trace/trace_kdb.c             |    2 
 kernel/trace/trace_kprobe.c          |    6 +
 kernel/trace/trace_output.c          |   18 ++--
 kernel/trace/trace_sched_wakeup.c    |   24 +++--
 kernel/trace/trace_syscalls.c        |    4 -
 kernel/trace/trace_wprobe.c          |    2 
 14 files changed, 150 insertions(+), 152 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6941145b5058..e21176f396d5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1452,7 +1452,7 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 
 	t	   = te_blk_io_trace(iter->ent);
 	what	   = (t->action & ((1 << BLK_TC_SHIFT) - 1)) & ~__BLK_TA_CGROUP;
-	long_act   = !!(tr->trace_flags & TRACE_ITER_VERBOSE);
+	long_act   = !!(tr->trace_flags & TRACE_ITER(VERBOSE));
 	log_action = classic ? &blk_log_action_classic : &blk_log_action;
 	has_cg	   = t->action & __BLK_TA_CGROUP;
 
@@ -1517,9 +1517,9 @@ blk_tracer_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	/* don't output context-info for blk_classic output */
 	if (bit == TRACE_BLK_OPT_CLASSIC) {
 		if (set)
-			tr->trace_flags &= ~TRACE_ITER_CONTEXT_INFO;
+			tr->trace_flags &= ~TRACE_ITER(CONTEXT_INFO);
 		else
-			tr->trace_flags |= TRACE_ITER_CONTEXT_INFO;
+			tr->trace_flags |= TRACE_ITER(CONTEXT_INFO);
 	}
 	return 0;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47aaba562b25..70e30d615f72 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -514,21 +514,21 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 /* trace_flags holds trace_options default values */
 #define TRACE_DEFAULT_FLAGS						\
 	(FUNCTION_DEFAULT_FLAGS |					\
-	 TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |			\
-	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
-	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
-	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
-	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |		\
-	 TRACE_ITER_COPY_MARKER)
+	 TRACE_ITER(PRINT_PARENT) | TRACE_ITER(PRINTK) |			\
+	 TRACE_ITER(ANNOTATE) | TRACE_ITER(CONTEXT_INFO) |		\
+	 TRACE_ITER(RECORD_CMD) | TRACE_ITER(OVERWRITE) |			\
+	 TRACE_ITER(IRQ_INFO) | TRACE_ITER(MARKERS) |			\
+	 TRACE_ITER(HASH_PTR) | TRACE_ITER(TRACE_PRINTK) |		\
+	 TRACE_ITER(COPY_MARKER))
 
 /* trace_options that are only supported by global_trace */
-#define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
-	       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD)
+#define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER(PRINTK) |			\
+	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD))
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
-	 TRACE_ITER_COPY_MARKER)
+	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK) | \
+	 TRACE_ITER(COPY_MARKER))
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -559,9 +559,9 @@ static void update_printk_trace(struct trace_array *tr)
 	if (printk_trace == tr)
 		return;
 
-	printk_trace->trace_flags &= ~TRACE_ITER_TRACE_PRINTK;
+	printk_trace->trace_flags &= ~TRACE_ITER(TRACE_PRINTK);
 	printk_trace = tr;
-	tr->trace_flags |= TRACE_ITER_TRACE_PRINTK;
+	tr->trace_flags |= TRACE_ITER(TRACE_PRINTK);
 }
 
 /* Returns true if the status of tr changed */
@@ -574,7 +574,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
-		tr->trace_flags |= TRACE_ITER_COPY_MARKER;
+		tr->trace_flags |= TRACE_ITER(COPY_MARKER);
 		return true;
 	}
 
@@ -582,7 +582,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return false;
 
 	list_del_init(&tr->marker_list);
-	tr->trace_flags &= ~TRACE_ITER_COPY_MARKER;
+	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
 	return true;
 }
 
@@ -1140,7 +1140,7 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 	unsigned int trace_ctx;
 	int alloc;
 
-	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
 
 	if (unlikely(tracing_selftest_running && tr == &global_trace))
@@ -1206,7 +1206,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	if (!printk_binsafe(tr))
 		return __trace_puts(ip, str, strlen(str));
 
-	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
 
 	if (unlikely(tracing_selftest_running || tracing_disabled))
@@ -3079,7 +3079,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 				      unsigned int trace_ctx,
 				      int skip, struct pt_regs *regs)
 {
-	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
+	if (!(tr->trace_flags & TRACE_ITER(STACKTRACE)))
 		return;
 
 	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
@@ -3140,7 +3140,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 	struct ring_buffer_event *event;
 	struct userstack_entry *entry;
 
-	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE))
+	if (!(tr->trace_flags & TRACE_ITER(USERSTACKTRACE)))
 		return;
 
 	/*
@@ -3485,7 +3485,7 @@ int trace_array_printk(struct trace_array *tr,
 	if (tr == &global_trace)
 		return 0;
 
-	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
 
 	va_start(ap, fmt);
@@ -3522,7 +3522,7 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	int ret;
 	va_list ap;
 
-	if (!(printk_trace->trace_flags & TRACE_ITER_PRINTK))
+	if (!(printk_trace->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
 
 	va_start(ap, fmt);
@@ -3792,7 +3792,7 @@ const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
 	if (WARN_ON_ONCE(!fmt))
 		return fmt;
 
-	if (!iter->tr || iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
+	if (!iter->tr || iter->tr->trace_flags & TRACE_ITER(HASH_PTR))
 		return fmt;
 
 	p = fmt;
@@ -4114,7 +4114,7 @@ static void print_event_info(struct array_buffer *buf, struct seq_file *m)
 static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 				   unsigned int flags)
 {
-	bool tgid = flags & TRACE_ITER_RECORD_TGID;
+	bool tgid = flags & TRACE_ITER(RECORD_TGID);
 
 	print_event_info(buf, m);
 
@@ -4125,7 +4125,7 @@ static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file *m,
 				       unsigned int flags)
 {
-	bool tgid = flags & TRACE_ITER_RECORD_TGID;
+	bool tgid = flags & TRACE_ITER(RECORD_TGID);
 	static const char space[] = "            ";
 	int prec = tgid ? 12 : 2;
 
@@ -4198,7 +4198,7 @@ static void test_cpu_buff_start(struct trace_iterator *iter)
 	struct trace_seq *s = &iter->seq;
 	struct trace_array *tr = iter->tr;
 
-	if (!(tr->trace_flags & TRACE_ITER_ANNOTATE))
+	if (!(tr->trace_flags & TRACE_ITER(ANNOTATE)))
 		return;
 
 	if (!(iter->iter_flags & TRACE_FILE_ANNOTATE))
@@ -4250,7 +4250,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 
 	event = ftrace_find_event(entry->type);
 
-	if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
+	if (tr->trace_flags & TRACE_ITER(CONTEXT_INFO)) {
 		if (iter->iter_flags & TRACE_FILE_LAT_FMT)
 			trace_print_lat_context(iter);
 		else
@@ -4261,7 +4261,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 		return TRACE_TYPE_PARTIAL_LINE;
 
 	if (event) {
-		if (tr->trace_flags & TRACE_ITER_FIELDS)
+		if (tr->trace_flags & TRACE_ITER(FIELDS))
 			return print_event_fields(iter, event);
 		/*
 		 * For TRACE_EVENT() events, the print_fmt is not
@@ -4291,7 +4291,7 @@ static enum print_line_t print_raw_fmt(struct trace_iterator *iter)
 
 	entry = iter->ent;
 
-	if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO)
+	if (tr->trace_flags & TRACE_ITER(CONTEXT_INFO))
 		trace_seq_printf(s, "%d %d %llu ",
 				 entry->pid, iter->cpu, iter->ts);
 
@@ -4317,7 +4317,7 @@ static enum print_line_t print_hex_fmt(struct trace_iterator *iter)
 
 	entry = iter->ent;
 
-	if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
+	if (tr->trace_flags & TRACE_ITER(CONTEXT_INFO)) {
 		SEQ_PUT_HEX_FIELD(s, entry->pid);
 		SEQ_PUT_HEX_FIELD(s, iter->cpu);
 		SEQ_PUT_HEX_FIELD(s, iter->ts);
@@ -4346,7 +4346,7 @@ static enum print_line_t print_bin_fmt(struct trace_iterator *iter)
 
 	entry = iter->ent;
 
-	if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
+	if (tr->trace_flags & TRACE_ITER(CONTEXT_INFO)) {
 		SEQ_PUT_FIELD(s, entry->pid);
 		SEQ_PUT_FIELD(s, iter->cpu);
 		SEQ_PUT_FIELD(s, iter->ts);
@@ -4417,27 +4417,27 @@ enum print_line_t print_trace_line(struct trace_iterator *iter)
 	}
 
 	if (iter->ent->type == TRACE_BPUTS &&
-			trace_flags & TRACE_ITER_PRINTK &&
-			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
+			trace_flags & TRACE_ITER(PRINTK) &&
+			trace_flags & TRACE_ITER(PRINTK_MSGONLY))
 		return trace_print_bputs_msg_only(iter);
 
 	if (iter->ent->type == TRACE_BPRINT &&
-			trace_flags & TRACE_ITER_PRINTK &&
-			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
+			trace_flags & TRACE_ITER(PRINTK) &&
+			trace_flags & TRACE_ITER(PRINTK_MSGONLY))
 		return trace_print_bprintk_msg_only(iter);
 
 	if (iter->ent->type == TRACE_PRINT &&
-			trace_flags & TRACE_ITER_PRINTK &&
-			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
+			trace_flags & TRACE_ITER(PRINTK) &&
+			trace_flags & TRACE_ITER(PRINTK_MSGONLY))
 		return trace_print_printk_msg_only(iter);
 
-	if (trace_flags & TRACE_ITER_BIN)
+	if (trace_flags & TRACE_ITER(BIN))
 		return print_bin_fmt(iter);
 
-	if (trace_flags & TRACE_ITER_HEX)
+	if (trace_flags & TRACE_ITER(HEX))
 		return print_hex_fmt(iter);
 
-	if (trace_flags & TRACE_ITER_RAW)
+	if (trace_flags & TRACE_ITER(RAW))
 		return print_raw_fmt(iter);
 
 	return print_trace_fmt(iter);
@@ -4455,7 +4455,7 @@ void trace_latency_header(struct seq_file *m)
 	if (iter->iter_flags & TRACE_FILE_LAT_FMT)
 		print_trace_header(m, iter);
 
-	if (!(tr->trace_flags & TRACE_ITER_VERBOSE))
+	if (!(tr->trace_flags & TRACE_ITER(VERBOSE)))
 		print_lat_help_header(m);
 }
 
@@ -4465,7 +4465,7 @@ void trace_default_header(struct seq_file *m)
 	struct trace_array *tr = iter->tr;
 	unsigned long trace_flags = tr->trace_flags;
 
-	if (!(trace_flags & TRACE_ITER_CONTEXT_INFO))
+	if (!(trace_flags & TRACE_ITER(CONTEXT_INFO)))
 		return;
 
 	if (iter->iter_flags & TRACE_FILE_LAT_FMT) {
@@ -4473,11 +4473,11 @@ void trace_default_header(struct seq_file *m)
 		if (trace_empty(iter))
 			return;
 		print_trace_header(m, iter);
-		if (!(trace_flags & TRACE_ITER_VERBOSE))
+		if (!(trace_flags & TRACE_ITER(VERBOSE)))
 			print_lat_help_header(m);
 	} else {
-		if (!(trace_flags & TRACE_ITER_VERBOSE)) {
-			if (trace_flags & TRACE_ITER_IRQ_INFO)
+		if (!(trace_flags & TRACE_ITER(VERBOSE))) {
+			if (trace_flags & TRACE_ITER(IRQ_INFO))
 				print_func_help_header_irq(iter->array_buffer,
 							   m, trace_flags);
 			else
@@ -4701,7 +4701,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	 * If pause-on-trace is enabled, then stop the trace while
 	 * dumping, unless this is the "snapshot" file
 	 */
-	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE))
+	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER(PAUSE_ON_TRACE)))
 		tracing_stop_tr(tr);
 
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
@@ -4895,7 +4895,7 @@ static int tracing_open(struct inode *inode, struct file *file)
 		iter = __tracing_open(inode, file, false);
 		if (IS_ERR(iter))
 			ret = PTR_ERR(iter);
-		else if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+		else if (tr->trace_flags & TRACE_ITER(LATENCY_FMT))
 			iter->iter_flags |= TRACE_FILE_LAT_FMT;
 	}
 
@@ -5167,7 +5167,7 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	trace_opts = tr->current_trace->flags->opts;
 
 	for (i = 0; trace_options[i]; i++) {
-		if (tr->trace_flags & (1 << i))
+		if (tr->trace_flags & (1ULL << i))
 			seq_printf(m, "%s\n", trace_options[i]);
 		else
 			seq_printf(m, "no%s\n", trace_options[i]);
@@ -5220,20 +5220,20 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 }
 
 /* Some tracers require overwrite to stay enabled */
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 {
-	if (tracer->enabled && (mask & TRACE_ITER_OVERWRITE) && !set)
+	if (tracer->enabled && (mask & TRACE_ITER(OVERWRITE)) && !set)
 		return -1;
 
 	return 0;
 }
 
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
-	if ((mask == TRACE_ITER_RECORD_TGID) ||
-	    (mask == TRACE_ITER_RECORD_CMD) ||
-	    (mask == TRACE_ITER_TRACE_PRINTK) ||
-	    (mask == TRACE_ITER_COPY_MARKER))
+	if ((mask == TRACE_ITER(RECORD_TGID)) ||
+	    (mask == TRACE_ITER(RECORD_CMD)) ||
+	    (mask == TRACE_ITER(TRACE_PRINTK)) ||
+	    (mask == TRACE_ITER(COPY_MARKER)))
 		lockdep_assert_held(&event_mutex);
 
 	/* do nothing if flag is already set */
@@ -5245,7 +5245,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
 			return -EINVAL;
 
-	if (mask == TRACE_ITER_TRACE_PRINTK) {
+	if (mask == TRACE_ITER(TRACE_PRINTK)) {
 		if (enabled) {
 			update_printk_trace(tr);
 		} else {
@@ -5264,7 +5264,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		}
 	}
 
-	if (mask == TRACE_ITER_COPY_MARKER)
+	if (mask == TRACE_ITER(COPY_MARKER))
 		update_marker_trace(tr, enabled);
 
 	if (enabled)
@@ -5272,33 +5272,33 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	else
 		tr->trace_flags &= ~mask;
 
-	if (mask == TRACE_ITER_RECORD_CMD)
+	if (mask == TRACE_ITER(RECORD_CMD))
 		trace_event_enable_cmd_record(enabled);
 
-	if (mask == TRACE_ITER_RECORD_TGID) {
+	if (mask == TRACE_ITER(RECORD_TGID)) {
 
 		if (trace_alloc_tgid_map() < 0) {
-			tr->trace_flags &= ~TRACE_ITER_RECORD_TGID;
+			tr->trace_flags &= ~TRACE_ITER(RECORD_TGID);
 			return -ENOMEM;
 		}
 
 		trace_event_enable_tgid_record(enabled);
 	}
 
-	if (mask == TRACE_ITER_EVENT_FORK)
+	if (mask == TRACE_ITER(EVENT_FORK))
 		trace_event_follow_fork(tr, enabled);
 
-	if (mask == TRACE_ITER_FUNC_FORK)
+	if (mask == TRACE_ITER(FUNC_FORK))
 		ftrace_pid_follow_fork(tr, enabled);
 
-	if (mask == TRACE_ITER_OVERWRITE) {
+	if (mask == TRACE_ITER(OVERWRITE)) {
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
 		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
 #endif
 	}
 
-	if (mask == TRACE_ITER_PRINTK) {
+	if (mask == TRACE_ITER(PRINTK)) {
 		trace_printk_start_stop_comm(enabled);
 		trace_printk_control(enabled);
 	}
@@ -5330,7 +5330,7 @@ int trace_set_options(struct trace_array *tr, char *option)
 	if (ret < 0)
 		ret = set_tracer_option(tr, cmp, neg);
 	else
-		ret = set_tracer_flag(tr, 1 << ret, !neg);
+		ret = set_tracer_flag(tr, 1ULL << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
@@ -6558,7 +6558,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	/* trace pipe does not show start of buffer */
 	cpumask_setall(iter->started);
 
-	if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+	if (tr->trace_flags & TRACE_ITER(LATENCY_FMT))
 		iter->iter_flags |= TRACE_FILE_LAT_FMT;
 
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
@@ -6619,7 +6619,7 @@ trace_poll(struct trace_iterator *iter, struct file *filp, poll_table *poll_tabl
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return EPOLLIN | EPOLLRDNORM;
 
-	if (tr->trace_flags & TRACE_ITER_BLOCK)
+	if (tr->trace_flags & TRACE_ITER(BLOCK))
 		/*
 		 * Always select as readable when in blocking mode
 		 */
@@ -7208,7 +7208,7 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 	struct trace_array *tr = inode->i_private;
 
 	/* disable tracing ? */
-	if (tr->trace_flags & TRACE_ITER_STOP_ON_FREE)
+	if (tr->trace_flags & TRACE_ITER(STOP_ON_FREE))
 		tracer_tracing_off(tr);
 	/* resize the ring buffer to 0 */
 	tracing_resize_ring_buffer(tr, 0, RING_BUFFER_ALL_CPUS);
@@ -7582,7 +7582,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tracing_disabled)
 		return -EINVAL;
 
-	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
+	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
 		return -EINVAL;
 
 	if ((ssize_t)cnt < 0)
@@ -7662,7 +7662,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (tracing_disabled)
 		return -EINVAL;
 
-	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
+	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
 		return -EINVAL;
 
 	/* The marker must at least have a tag id */
@@ -9502,7 +9502,7 @@ trace_options_core_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	get_tr_index(tr_index, &tr, &index);
 
-	if (tr->trace_flags & (1 << index))
+	if (tr->trace_flags & (1ULL << index))
 		buf = "1\n";
 	else
 		buf = "0\n";
@@ -9531,7 +9531,7 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
-	ret = set_tracer_flag(tr, 1 << index, val);
+	ret = set_tracer_flag(tr, 1ULL << index, val);
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
@@ -9695,8 +9695,9 @@ static void create_trace_options_dir(struct trace_array *tr)
 
 	for (i = 0; trace_options[i]; i++) {
 		if (top_level ||
-		    !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
+		    !((1ULL << i) & TOP_LEVEL_TRACE_FLAGS)) {
 			create_trace_option_core_file(tr, trace_options[i], i);
+		}
 	}
 }
 
@@ -10017,7 +10018,7 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	struct trace_scratch *tscratch;
 	unsigned int scratch_size = 0;
 
-	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
+	rb_flags = tr->trace_flags & TRACE_ITER(OVERWRITE) ? RB_FL_OVERWRITE : 0;
 
 	buf->tr = tr;
 
@@ -10382,7 +10383,7 @@ static int __remove_instance(struct trace_array *tr)
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
 		if ((1 << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1 << i, 0);
+			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
 	if (printk_trace == tr)
@@ -10975,10 +10976,10 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	/* While dumping, do not allow the buffer to be enable */
 	tracer_tracing_disable(tr);
 
-	old_userobj = tr->trace_flags & TRACE_ITER_SYM_USEROBJ;
+	old_userobj = tr->trace_flags & TRACE_ITER(SYM_USEROBJ);
 
 	/* don't look at user memory in panic mode */
-	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
+	tr->trace_flags &= ~TRACE_ITER(SYM_USEROBJ);
 
 	if (dump_mode == DUMP_ORIG)
 		iter.cpu_file = raw_smp_processor_id();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 44e000c7be0c..12716fe227bf 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -223,7 +223,7 @@ struct array_buffer {
 	int				cpu;
 };
 
-#define TRACE_FLAGS_MAX_SIZE		32
+#define TRACE_FLAGS_MAX_SIZE		64
 
 struct trace_options {
 	struct tracer			*tracer;
@@ -397,7 +397,7 @@ struct trace_array {
 	int			buffer_percent;
 	unsigned int		n_err_log_entries;
 	struct tracer		*current_trace;
-	unsigned int		trace_flags;
+	u64			trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
@@ -639,7 +639,7 @@ struct tracer {
 					    u32 old_flags, u32 bit, int set);
 	/* Return 0 if OK with change, else return non-zero */
 	int			(*flag_changed)(struct trace_array *tr,
-						u32 mask, int set);
+						u64 mask, int set);
 	struct tracer		*next;
 	struct tracer_flags	*flags;
 	int			enabled;
@@ -1353,11 +1353,11 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define FUNCTION_FLAGS						\
 		C(FUNCTION,		"function-trace"),	\
 		C(FUNC_FORK,		"function-fork"),
-# define FUNCTION_DEFAULT_FLAGS		TRACE_ITER_FUNCTION
+# define FUNCTION_DEFAULT_FLAGS		TRACE_ITER(FUNCTION)
 #else
 # define FUNCTION_FLAGS
 # define FUNCTION_DEFAULT_FLAGS		0UL
-# define TRACE_ITER_FUNC_FORK		0UL
+# define TRACE_ITER_FUNC_FORK_BIT	-1
 #endif
 
 #ifdef CONFIG_STACKTRACE
@@ -1399,7 +1399,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
-		C(COPY_MARKER,		"copy_trace_marker"),\
+		C(COPY_MARKER,		"copy_trace_marker"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
@@ -1421,20 +1421,17 @@ enum trace_iterator_bits {
 };
 
 /*
- * By redefining C, we can make TRACE_FLAGS a list of masks that
- * use the bits as defined above.
+ * And use TRACE_ITER(flag) to define the bit masks.
  */
-#undef C
-#define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
-
-enum trace_iterator_flags { TRACE_FLAGS };
+#define TRACE_ITER(flag)		\
+	(TRACE_ITER_##flag##_BIT < 0 ? 0 : 1ULL << (TRACE_ITER_##flag##_BIT))
 
 /*
  * TRACE_ITER_SYM_MASK masks the options in trace_flags that
  * control the output of kernel symbols.
  */
 #define TRACE_ITER_SYM_MASK \
-	(TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
+	(TRACE_ITER(PRINT_PARENT)|TRACE_ITER(SYM_OFFSET)|TRACE_ITER(SYM_ADDR))
 
 extern struct tracer nop_trace;
 
@@ -1443,7 +1440,7 @@ extern int enable_branch_tracing(struct trace_array *tr);
 extern void disable_branch_tracing(void);
 static inline int trace_branch_enable(struct trace_array *tr)
 {
-	if (tr->trace_flags & TRACE_ITER_BRANCH)
+	if (tr->trace_flags & TRACE_ITER(BRANCH))
 		return enable_branch_tracing(tr);
 	return 0;
 }
@@ -2089,8 +2086,8 @@ extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
 void trace_printk_start_comm(void);
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set);
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled);
 
 /* Used from boot time tracer */
 extern int trace_set_options(struct trace_array *tr, char *option);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e00da4182deb..9b07ad9eb284 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -845,13 +845,13 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (soft_disable)
 				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 
-			if (tr->trace_flags & TRACE_ITER_RECORD_CMD) {
+			if (tr->trace_flags & TRACE_ITER(RECORD_CMD)) {
 				cmd = true;
 				tracing_start_cmdline_record();
 				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 			}
 
-			if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
+			if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
 				tgid = true;
 				tracing_start_tgid_record();
 				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index f24ee61f8884..2f19bbe73d27 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -359,7 +359,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		fmt = synth_field_fmt(se->fields[i]->type);
 
 		/* parameter types */
-		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER(VERBOSE))
 			trace_seq_printf(s, "%s ", fmt);
 
 		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index ad9d6347b5fa..1c917c528329 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -631,7 +631,7 @@ print_fentry_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_putc(s, ')');
@@ -661,12 +661,12 @@ print_fexit_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_puts(s, " <- ");
 
-	if (!seq_print_ip_sym(s, field->func, flags & ~TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->func, flags & ~TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_putc(s, ')');
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7f4b9a47a71..8cb1df2570c6 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -703,7 +703,7 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		addr >= (unsigned long)__irqentry_text_end)
 		return;
 
-	if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
+	if (tr->trace_flags & TRACE_ITER(CONTEXT_INFO)) {
 		/* Absolute time */
 		if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 			print_graph_abs_time(iter->ts, s);
@@ -723,7 +723,7 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		}
 
 		/* Latency format */
-		if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+		if (tr->trace_flags & TRACE_ITER(LATENCY_FMT))
 			print_graph_lat_fmt(s, ent);
 	}
 
@@ -777,7 +777,7 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags)
 {
 	if (!(flags & TRACE_GRAPH_PRINT_DURATION) ||
-	    !(tr->trace_flags & TRACE_ITER_CONTEXT_INFO))
+	    !(tr->trace_flags & TRACE_ITER(CONTEXT_INFO)))
 		return;
 
 	/* No real adata, just filling the column with spaces */
@@ -818,7 +818,7 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
 		trace_seq_puts(s, " /*");
 
 	trace_seq_puts(s, " <-");
-	seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
+	seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE_ITER(SYM_OFFSET));
 
 	if (comment)
 		trace_seq_puts(s, " */");
@@ -1054,7 +1054,7 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
 		/* Interrupt */
 		print_graph_irq(iter, addr, type, cpu, ent->pid, flags);
 
-	if (!(tr->trace_flags & TRACE_ITER_CONTEXT_INFO))
+	if (!(tr->trace_flags & TRACE_ITER(CONTEXT_INFO)))
 		return;
 
 	/* Absolute time */
@@ -1076,7 +1076,7 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
 	}
 
 	/* Latency format */
-	if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+	if (tr->trace_flags & TRACE_ITER(LATENCY_FMT))
 		print_graph_lat_fmt(s, ent);
 
 	return;
@@ -1495,7 +1495,7 @@ static void print_lat_header(struct seq_file *s, u32 flags)
 static void __print_graph_headers_flags(struct trace_array *tr,
 					struct seq_file *s, u32 flags)
 {
-	int lat = tr->trace_flags & TRACE_ITER_LATENCY_FMT;
+	int lat = tr->trace_flags & TRACE_ITER(LATENCY_FMT);
 
 	if (lat)
 		print_lat_header(s, flags);
@@ -1543,10 +1543,10 @@ void print_graph_headers_flags(struct seq_file *s, u32 flags)
 	struct trace_iterator *iter = s->private;
 	struct trace_array *tr = iter->tr;
 
-	if (!(tr->trace_flags & TRACE_ITER_CONTEXT_INFO))
+	if (!(tr->trace_flags & TRACE_ITER(CONTEXT_INFO)))
 		return;
 
-	if (tr->trace_flags & TRACE_ITER_LATENCY_FMT) {
+	if (tr->trace_flags & TRACE_ITER(LATENCY_FMT)) {
 		/* print nothing if the buffers are empty */
 		if (trace_empty(iter))
 			return;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 4c45c49b06c8..17673905907c 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -63,7 +63,7 @@ irq_trace(void)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int irqsoff_display_graph(struct trace_array *tr, int set);
-# define is_graph(tr) ((tr)->trace_flags & TRACE_ITER_DISPLAY_GRAPH)
+# define is_graph(tr) ((tr)->trace_flags & TRACE_ITER(DISPLAY_GRAPH))
 #else
 static inline int irqsoff_display_graph(struct trace_array *tr, int set)
 {
@@ -485,8 +485,8 @@ static int register_irqsoff_function(struct trace_array *tr, int graph, int set)
 {
 	int ret;
 
-	/* 'set' is set if TRACE_ITER_FUNCTION is about to be set */
-	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER_FUNCTION)))
+	/* 'set' is set if TRACE_ITER(FUNCTION) is about to be set */
+	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER(FUNCTION))))
 		return 0;
 
 	if (graph)
@@ -515,7 +515,7 @@ static void unregister_irqsoff_function(struct trace_array *tr, int graph)
 
 static int irqsoff_function_set(struct trace_array *tr, u32 mask, int set)
 {
-	if (!(mask & TRACE_ITER_FUNCTION))
+	if (!(mask & TRACE_ITER(FUNCTION)))
 		return 0;
 
 	if (set)
@@ -536,7 +536,7 @@ static inline int irqsoff_function_set(struct trace_array *tr, u32 mask, int set
 }
 #endif /* CONFIG_FUNCTION_TRACER */
 
-static int irqsoff_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int irqsoff_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 
@@ -544,7 +544,7 @@ static int irqsoff_flag_changed(struct trace_array *tr, u32 mask, int set)
 		return 0;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (mask & TRACE_ITER_DISPLAY_GRAPH)
+	if (mask & TRACE_ITER(DISPLAY_GRAPH))
 		return irqsoff_display_graph(tr, set);
 #endif
 
@@ -582,10 +582,10 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	save_flags = tr->trace_flags;
 
 	/* non overwrite screws up the latency tracers */
-	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
-	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	set_tracer_flag(tr, TRACE_ITER(OVERWRITE), 1);
+	set_tracer_flag(tr, TRACE_ITER(LATENCY_FMT), 1);
 	/* without pause, we will produce garbage if another latency occurs */
-	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, 1);
+	set_tracer_flag(tr, TRACE_ITER(PAUSE_ON_TRACE), 1);
 
 	tr->max_latency = 0;
 	irqsoff_trace = tr;
@@ -605,15 +605,15 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 
 static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
-	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
-	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
-	int pause_flag = save_flags & TRACE_ITER_PAUSE_ON_TRACE;
+	int lat_flag = save_flags & TRACE_ITER(LATENCY_FMT);
+	int overwrite_flag = save_flags & TRACE_ITER(OVERWRITE);
+	int pause_flag = save_flags & TRACE_ITER(PAUSE_ON_TRACE);
 
 	stop_irqsoff_tracer(tr, is_graph(tr));
 
-	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
-	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
-	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, pause_flag);
+	set_tracer_flag(tr, TRACE_ITER(LATENCY_FMT), lat_flag);
+	set_tracer_flag(tr, TRACE_ITER(OVERWRITE), overwrite_flag);
+	set_tracer_flag(tr, TRACE_ITER(PAUSE_ON_TRACE), pause_flag);
 	ftrace_reset_array_ops(tr);
 
 	irqsoff_busy = false;
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 896ff78b8349..b30795f34079 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -31,7 +31,7 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	old_userobj = tr->trace_flags;
 
 	/* don't look at user memory in panic mode */
-	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
+	tr->trace_flags &= ~TRACE_ITER(SYM_USEROBJ);
 
 	kdb_printf("Dumping ftrace buffer:\n");
 	if (skip_entries)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ee8171b19bee..72cdf7da6337 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1584,7 +1584,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_putc(s, ')');
@@ -1614,12 +1614,12 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_puts(s, " <- ");
 
-	if (!seq_print_ip_sym(s, field->func, flags & ~TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->func, flags & ~TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_putc(s, ')');
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 718b255b6fd8..ebbab3e9622b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -420,7 +420,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 		}
 		mmap_read_unlock(mm);
 	}
-	if (ret && ((sym_flags & TRACE_ITER_SYM_ADDR) || !file))
+	if (ret && ((sym_flags & TRACE_ITER(SYM_ADDR)) || !file))
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
 	return !trace_seq_has_overflowed(s);
 }
@@ -433,9 +433,9 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	trace_seq_print_sym(s, ip, sym_flags & TRACE_ITER_SYM_OFFSET);
+	trace_seq_print_sym(s, ip, sym_flags & TRACE_ITER(SYM_OFFSET));
 
-	if (sym_flags & TRACE_ITER_SYM_ADDR)
+	if (sym_flags & TRACE_ITER(SYM_ADDR))
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
 
  out:
@@ -569,7 +569,7 @@ static int
 lat_print_timestamp(struct trace_iterator *iter, u64 next_ts)
 {
 	struct trace_array *tr = iter->tr;
-	unsigned long verbose = tr->trace_flags & TRACE_ITER_VERBOSE;
+	unsigned long verbose = tr->trace_flags & TRACE_ITER(VERBOSE);
 	unsigned long in_ns = iter->iter_flags & TRACE_FILE_TIME_IN_NS;
 	unsigned long long abs_ts = iter->ts - iter->array_buffer->time_start;
 	unsigned long long rel_ts = next_ts - iter->ts;
@@ -636,7 +636,7 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
-	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
+	if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
 
 		if (!tgid)
@@ -647,7 +647,7 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_seq_printf(s, "[%03d] ", iter->cpu);
 
-	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
+	if (tr->trace_flags & TRACE_ITER(IRQ_INFO))
 		trace_print_lat_fmt(s, entry);
 
 	trace_print_time(s, iter, iter->ts);
@@ -661,7 +661,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	struct trace_entry *entry, *next_entry;
 	struct trace_array *tr = iter->tr;
 	struct trace_seq *s = &iter->seq;
-	unsigned long verbose = (tr->trace_flags & TRACE_ITER_VERBOSE);
+	unsigned long verbose = (tr->trace_flags & TRACE_ITER(VERBOSE));
 	u64 next_ts;
 
 	next_entry = trace_find_next_entry(iter, NULL, &next_ts);
@@ -1150,7 +1150,7 @@ static void print_fn_trace(struct trace_seq *s, unsigned long ip,
 	if (args)
 		print_function_args(s, args, ip);
 
-	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
+	if ((flags & TRACE_ITER(PRINT_PARENT)) && parent_ip) {
 		trace_seq_puts(s, " <-");
 		seq_print_ip_sym(s, parent_ip, flags);
 	}
@@ -1440,7 +1440,7 @@ static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 
 	trace_seq_puts(s, "<user stack trace>\n");
 
-	if (tr->trace_flags & TRACE_ITER_SYM_USEROBJ) {
+	if (tr->trace_flags & TRACE_ITER(SYM_USEROBJ)) {
 		struct task_struct *task;
 		/*
 		 * we do the lookup on the thread group leader,
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index e3f2e4f56faa..8faa73d3bba1 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -41,7 +41,7 @@ static void stop_func_tracer(struct trace_array *tr, int graph);
 static int save_flags;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-# define is_graph(tr) ((tr)->trace_flags & TRACE_ITER_DISPLAY_GRAPH)
+# define is_graph(tr) ((tr)->trace_flags & TRACE_ITER(DISPLAY_GRAPH))
 #else
 # define is_graph(tr) false
 #endif
@@ -247,8 +247,8 @@ static int register_wakeup_function(struct trace_array *tr, int graph, int set)
 {
 	int ret;
 
-	/* 'set' is set if TRACE_ITER_FUNCTION is about to be set */
-	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER_FUNCTION)))
+	/* 'set' is set if TRACE_ITER(FUNCTION) is about to be set */
+	if (function_enabled || (!set && !(tr->trace_flags & TRACE_ITER(FUNCTION))))
 		return 0;
 
 	if (graph)
@@ -277,7 +277,7 @@ static void unregister_wakeup_function(struct trace_array *tr, int graph)
 
 static int wakeup_function_set(struct trace_array *tr, u32 mask, int set)
 {
-	if (!(mask & TRACE_ITER_FUNCTION))
+	if (!(mask & TRACE_ITER(FUNCTION)))
 		return 0;
 
 	if (set)
@@ -324,7 +324,7 @@ __trace_function(struct trace_array *tr,
 		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
-static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int wakeup_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 
@@ -332,7 +332,7 @@ static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
 		return 0;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (mask & TRACE_ITER_DISPLAY_GRAPH)
+	if (mask & TRACE_ITER(DISPLAY_GRAPH))
 		return wakeup_display_graph(tr, set);
 #endif
 
@@ -681,8 +681,8 @@ static int __wakeup_tracer_init(struct trace_array *tr)
 	save_flags = tr->trace_flags;
 
 	/* non overwrite screws up the latency tracers */
-	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
-	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	set_tracer_flag(tr, TRACE_ITER(OVERWRITE), 1);
+	set_tracer_flag(tr, TRACE_ITER(LATENCY_FMT), 1);
 
 	tr->max_latency = 0;
 	wakeup_trace = tr;
@@ -725,15 +725,15 @@ static int wakeup_dl_tracer_init(struct trace_array *tr)
 
 static void wakeup_tracer_reset(struct trace_array *tr)
 {
-	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
-	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
+	int lat_flag = save_flags & TRACE_ITER(LATENCY_FMT);
+	int overwrite_flag = save_flags & TRACE_ITER(OVERWRITE);
 
 	stop_wakeup_tracer(tr);
 	/* make sure we put back any tasks we are tracing */
 	wakeup_reset(tr);
 
-	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
-	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
+	set_tracer_flag(tr, TRACE_ITER(LATENCY_FMT), lat_flag);
+	set_tracer_flag(tr, TRACE_ITER(OVERWRITE), overwrite_flag);
 	ftrace_reset_array_ops(tr);
 	wakeup_busy = false;
 }
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 47d9771e8f7c..e07c5a3cc7ab 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -264,7 +264,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 
 	switch (entry->syscall_nr) {
 	case __NR_openat:
-		if (!tr || !(tr->trace_flags & TRACE_ITER_VERBOSE))
+		if (!tr || !(tr->trace_flags & TRACE_ITER(VERBOSE)))
 			return sys_enter_openat_print(trace, entry, s, event);
 		break;
 	default:
@@ -284,7 +284,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			trace_seq_puts(s, ", ");
 
 		/* parameter types */
-		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER(VERBOSE))
 			trace_seq_printf(s, "%s ", entry->types[i]);
 
 		/* parameter values */
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 98605b207f43..35fc4c35e218 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -260,7 +260,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
 		goto out;
 
 	trace_seq_putc(s, ')');

