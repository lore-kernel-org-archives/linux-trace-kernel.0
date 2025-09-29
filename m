Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7921DF271;
	Mon, 29 Sep 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185297; cv=none; b=DQQjeoN+Mn9EBgHq78TTyxJhiPoIQ1wAViA+IfNVgjFsEyjnl/mH4uD1VeXFedPGBIBwwT3DQsyZyFdZIoYNT5AzVG1RRuIkhdwUazXC3fk1lRLe38MUbk7vujhIZ0BQuaoMuI1F7EU8+gNTC8SGc+O8m+Ty8EF6NvcLPPYQuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185297; c=relaxed/simple;
	bh=zkP51sRDgb188InkeOlXGJc8oi2xFTpnUAhgoaFjXj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBEJnhlwrlJh0rM1sdCh1Pmei8t0yw4EuNXzgw0HiKvPLIaDz8e5Iy0bsNfhj9oZ+ZhkAnurnlr0VMqsSBGCDV1uEAz5EVyqvigO2tlx0EKOZmTrTVHxFRrQ/B+gFZh8i5oX/OUq35ScmG5eBF3K8229hnQy3O8r1zy6YJcXmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8G0F6ws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8G0F6ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA08C4CEF4;
	Mon, 29 Sep 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185297;
	bh=zkP51sRDgb188InkeOlXGJc8oi2xFTpnUAhgoaFjXj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8G0F6wsYKvVdcWtKJAvp+pY7WjqD6r5gwLiWJnTeLre+Gepxw33L3+q2C9yuKCDC
	 Fqf1Gx/965R5gHO615WEONgIkzMGrX1ZHNXdDnBNnlL6KzGQYvdDM/ls9o9P/4XBMd
	 OFLAhYprq/9Kvn5BPrBSmd0AAaSJRxJSuFQ6LWsWSch4EcrmYsHFQUryFfD8hqXJux
	 wLoQdqsmXJxqnOoE6pv9bZyLNodvtgapmmSfP5OuPRU/lM82UBYvfIbsVqfItoWZvV
	 0CW43kgiB4/spXkTCQzqETc+Sgnx7Jri3g2oPWX3bJaN76baDeSOCFab5CF57QQuwY
	 /bMqk/Whv4Yyg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tracing: Allow tracer to add more than 32 options
Date: Tue, 30 Sep 2025 07:34:53 +0900
Message-ID: <175918529300.65920.15856373929947126262.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175918528341.65920.10238038992631012350.stgit@devnote2>
References: <175918528341.65920.10238038992631012350.stgit@devnote2>
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

This replaces trace_iterator_flags with just a list of `static
const u64` so that we can add another 32 new options. Now all
option masks are u64 instead of u32 or unsigned int.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Make TRACE_ITER_* to global.
---
 kernel/trace/trace.c              |   24 +++++++----
 kernel/trace/trace.h              |   81 +++++++++++++++++++------------------
 kernel/trace/trace_irqsoff.c      |    2 -
 kernel/trace/trace_sched_wakeup.c |    2 -
 4 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..652b7dd34c25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -86,6 +86,11 @@ void __init disable_tracing_selftest(const char *reason)
 #define tracing_selftest_disabled	0
 #endif
 
+/* Define TRACE_ITER_* flags. */
+#undef C
+#define C(a, b) const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
+TRACE_FLAGS
+
 /* Pipe tracepoints to printk */
 static struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
@@ -1736,7 +1741,7 @@ unsigned long nsecs_to_usecs(unsigned long nsecs)
  * of strings in the order that the evals (enum) were defined.
  */
 #undef C
-#define C(a, b) b
+#define C(a, b) b,
 
 /* These must match the bit positions in trace_iterator_flags */
 static const char *trace_options[] = {
@@ -5144,7 +5149,7 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	trace_opts = tr->current_trace->flags->opts;
 
 	for (i = 0; trace_options[i]; i++) {
-		if (tr->trace_flags & (1 << i))
+		if (tr->trace_flags & (1ULL << i))
 			seq_printf(m, "%s\n", trace_options[i]);
 		else
 			seq_printf(m, "no%s\n", trace_options[i]);
@@ -5197,7 +5202,7 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 }
 
 /* Some tracers require overwrite to stay enabled */
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 {
 	if (tracer->enabled && (mask & TRACE_ITER_OVERWRITE) && !set)
 		return -1;
@@ -5205,7 +5210,7 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
 	    (mask == TRACE_ITER_RECORD_CMD) ||
@@ -5307,7 +5312,7 @@ int trace_set_options(struct trace_array *tr, char *option)
 	if (ret < 0)
 		ret = set_tracer_option(tr, cmp, neg);
 	else
-		ret = set_tracer_flag(tr, 1 << ret, !neg);
+		ret = set_tracer_flag(tr, 1ULL << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
@@ -9119,7 +9124,7 @@ trace_options_core_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	get_tr_index(tr_index, &tr, &index);
 
-	if (tr->trace_flags & (1 << index))
+	if (tr->trace_flags & (1ULL << index))
 		buf = "1\n";
 	else
 		buf = "0\n";
@@ -9148,7 +9153,7 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
-	ret = set_tracer_flag(tr, 1 << index, val);
+	ret = set_tracer_flag(tr, 1ULL << index, val);
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
@@ -9312,8 +9317,9 @@ static void create_trace_options_dir(struct trace_array *tr)
 
 	for (i = 0; trace_options[i]; i++) {
 		if (top_level ||
-		    !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
+		    !((1ULL << i) & TOP_LEVEL_TRACE_FLAGS)) {
 			create_trace_option_core_file(tr, trace_options[i], i);
+		}
 	}
 }
 
@@ -9997,7 +10003,7 @@ static int __remove_instance(struct trace_array *tr)
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
 		if ((1 << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1 << i, 0);
+			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
 	if (printk_trace == tr)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..41c613ea0b4d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -216,7 +216,7 @@ struct array_buffer {
 	int				cpu;
 };
 
-#define TRACE_FLAGS_MAX_SIZE		32
+#define TRACE_FLAGS_MAX_SIZE		64
 
 struct trace_options {
 	struct tracer			*tracer;
@@ -390,7 +390,7 @@ struct trace_array {
 	int			buffer_percent;
 	unsigned int		n_err_log_entries;
 	struct tracer		*current_trace;
-	unsigned int		trace_flags;
+	u64			trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
@@ -631,7 +631,7 @@ struct tracer {
 					    u32 old_flags, u32 bit, int set);
 	/* Return 0 if OK with change, else return non-zero */
 	int			(*flag_changed)(struct trace_array *tr,
-						u32 mask, int set);
+						u64 mask, int set);
 	struct tracer		*next;
 	struct tracer_flags	*flags;
 	int			enabled;
@@ -1323,22 +1323,22 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
  */
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 # define FGRAPH_FLAGS						\
-		C(DISPLAY_GRAPH,	"display-graph"),
+		C(DISPLAY_GRAPH,	"display-graph")
 #else
 # define FGRAPH_FLAGS
 #endif
 
 #ifdef CONFIG_BRANCH_TRACER
 # define BRANCH_FLAGS					\
-		C(BRANCH,		"branch"),
+		C(BRANCH,		"branch")
 #else
 # define BRANCH_FLAGS
 #endif
 
 #ifdef CONFIG_FUNCTION_TRACER
 # define FUNCTION_FLAGS						\
-		C(FUNCTION,		"function-trace"),	\
-		C(FUNC_FORK,		"function-fork"),
+		C(FUNCTION,		"function-trace")	\
+		C(FUNC_FORK,		"function-fork")
 # define FUNCTION_DEFAULT_FLAGS		TRACE_ITER_FUNCTION
 #else
 # define FUNCTION_FLAGS
@@ -1348,7 +1348,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 #ifdef CONFIG_STACKTRACE
 # define STACK_FLAGS				\
-		C(STACKTRACE,		"stacktrace"),
+		C(STACKTRACE,		"stacktrace")
 #else
 # define STACK_FLAGS
 #endif
@@ -1361,33 +1361,33 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
  *       trace.c (this macro guarantees it).
  */
 #define TRACE_FLAGS						\
-		C(PRINT_PARENT,		"print-parent"),	\
-		C(SYM_OFFSET,		"sym-offset"),		\
-		C(SYM_ADDR,		"sym-addr"),		\
-		C(VERBOSE,		"verbose"),		\
-		C(RAW,			"raw"),			\
-		C(HEX,			"hex"),			\
-		C(BIN,			"bin"),			\
-		C(BLOCK,		"block"),		\
-		C(FIELDS,		"fields"),		\
-		C(PRINTK,		"trace_printk"),	\
-		C(ANNOTATE,		"annotate"),		\
-		C(USERSTACKTRACE,	"userstacktrace"),	\
-		C(SYM_USEROBJ,		"sym-userobj"),		\
-		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
-		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
-		C(LATENCY_FMT,		"latency-format"),	\
-		C(RECORD_CMD,		"record-cmd"),		\
-		C(RECORD_TGID,		"record-tgid"),		\
-		C(OVERWRITE,		"overwrite"),		\
-		C(STOP_ON_FREE,		"disable_on_free"),	\
-		C(IRQ_INFO,		"irq-info"),		\
-		C(MARKERS,		"markers"),		\
-		C(EVENT_FORK,		"event-fork"),		\
-		C(TRACE_PRINTK,		"trace_printk_dest"),	\
-		C(COPY_MARKER,		"copy_trace_marker"),\
-		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
-		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(PRINT_PARENT,		"print-parent")		\
+		C(SYM_OFFSET,		"sym-offset")		\
+		C(SYM_ADDR,		"sym-addr")		\
+		C(VERBOSE,		"verbose")		\
+		C(RAW,			"raw")			\
+		C(HEX,			"hex")			\
+		C(BIN,			"bin")			\
+		C(BLOCK,		"block")		\
+		C(FIELDS,		"fields")		\
+		C(PRINTK,		"trace_printk")	\
+		C(ANNOTATE,		"annotate")		\
+		C(USERSTACKTRACE,	"userstacktrace")	\
+		C(SYM_USEROBJ,		"sym-userobj")		\
+		C(PRINTK_MSGONLY,	"printk-msg-only")	\
+		C(CONTEXT_INFO,		"context-info")   /* Print pid/cpu/time */ \
+		C(LATENCY_FMT,		"latency-format")	\
+		C(RECORD_CMD,		"record-cmd")		\
+		C(RECORD_TGID,		"record-tgid")		\
+		C(OVERWRITE,		"overwrite")		\
+		C(STOP_ON_FREE,		"disable_on_free")	\
+		C(IRQ_INFO,		"irq-info")		\
+		C(MARKERS,		"markers")		\
+		C(EVENT_FORK,		"event-fork")		\
+		C(TRACE_PRINTK,		"trace_printk_dest")	\
+		C(COPY_MARKER,		"copy_trace_marker")\
+		C(PAUSE_ON_TRACE,	"pause-on-trace")	\
+		C(HASH_PTR,		"hash-ptr")	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
@@ -1398,7 +1398,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
  * that will define the bits for the flag masks.
  */
 #undef C
-#define C(a, b) TRACE_ITER_##a##_BIT
+#define C(a, b) TRACE_ITER_##a##_BIT,
 
 enum trace_iterator_bits {
 	TRACE_FLAGS
@@ -1411,9 +1411,10 @@ enum trace_iterator_bits {
  * use the bits as defined above.
  */
 #undef C
-#define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
+#define C(a, b) extern const u64 TRACE_ITER_##a;
 
-enum trace_iterator_flags { TRACE_FLAGS };
+TRACE_FLAGS
+#undef C
 
 /*
  * TRACE_ITER_SYM_MASK masks the options in trace_flags that
@@ -2058,8 +2059,8 @@ extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
 void trace_printk_start_comm(void);
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set);
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled);
 
 /* Used from boot time tracer */
 extern int trace_set_options(struct trace_array *tr, char *option);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..1a65f9f1075c 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -539,7 +539,7 @@ static inline int irqsoff_function_set(struct trace_array *tr, u32 mask, int set
 }
 #endif /* CONFIG_FUNCTION_TRACER */
 
-static int irqsoff_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int irqsoff_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..45865b4f753f 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -328,7 +328,7 @@ __trace_function(struct trace_array *tr,
 		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
-static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int wakeup_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 

