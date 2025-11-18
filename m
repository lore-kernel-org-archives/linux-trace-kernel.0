Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8921ABC1;
	Tue, 18 Nov 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426108; cv=none; b=OAHmhe7/mB0Yp0+D5VxwW+qk6O65lqB/FpPS2SlyvJuTPvrYCW/xap9caOsgYyZSjQUoSzCUzajAQ8qk5OVngR1trFZwFZnpVwB8SnzzXHf4Mga/YjwtQHib9o5zqDXPdubAlziEQeKM1z4rJo6dnKAXKrPPA1/v5tDJkaffltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426108; c=relaxed/simple;
	bh=QWpOXG3mobTX5Sv/5uXO57DFJ5NCFhZBBdeoZ3xnVkk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aOuc2gJ5w7aNP3QxcKMhmS86LEhbTSgX8CMMhCgBYZBK8RBP2IZlKVizEaZrfbWch50X3rEwO2ucqB7eceYnKxUevMU6smJV6/InGT206LpF/lotSKydCmTq79qpa4cGsPDRzAJXJKy6jYsqQeoXnV4XXSEBh/D7IxB07TR+Y4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvoCw06w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvoCw06w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8DAC2BCB1;
	Tue, 18 Nov 2025 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426106;
	bh=QWpOXG3mobTX5Sv/5uXO57DFJ5NCFhZBBdeoZ3xnVkk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XvoCw06wQXZdzRlAMsunEVxwdLg7b6x5ABzgko/4H1jwaErghOKO96NIoJA9HGcUA
	 NhGesXHpl+Yb7eMx0iZDLLn662ATSSlhSldxV1Sj3LV6jUgLwxCaPv+f2yDcTxbzSc
	 1IUahbwq5AdOhy16Mgpm8OAJF5fqLDmMy4vAz6cQnu0f5jX3RkyvN5wJ3kI3eZdhdy
	 +coFYVPP4lEOmghJ7eY3xY4FS0RlA8K6oviVt8OIA1Cg9+4+2yqYvnmETM++Z5Iooi
	 /KnEYk0xQnz6TryywA4ThbZAg0w8atykpz1XR8q4Mrue6IBGNVlWpLyfJ5AXJaHnyS
	 2M876VdqZS4FA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vL9gx-00000002zKU-3slK;
	Mon, 17 Nov 2025 19:35:31 -0500
Message-ID: <20251118003531.805883570@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 17 Nov 2025 19:29:52 -0500
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
Subject: [POC][RFC][PATCH 2/3] ftrace: Add perf counters to function tracing
References: <20251118002950.680329246@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add option to trigger perf events to function tracing.

Two new options are added: func-cpu-cycles and func-cache-misses

 # cd /sys/kernel/tracing
 # echo 1 > options/func-cache-misses
 # echo function > current_tracer
 # cat trace
[..]
    sshd-session-1014    [005] .....   327.836708: __x64_sys_read <-do_syscall_64
    sshd-session-1014    [005] .....   327.836708: cache_misses: 741719054
    sshd-session-1014    [005] .....   327.836712: ksys_read <-do_syscall_64
    sshd-session-1014    [005] .....   327.836713: cache_misses: 741720271
    sshd-session-1014    [005] .....   327.836716: fdget_pos <-ksys_read
    sshd-session-1014    [005] .....   327.836717: cache_misses: 741721483
    sshd-session-1014    [005] .....   327.836720: vfs_read <-ksys_read
    sshd-session-1014    [005] .....   327.836721: cache_misses: 741722726
    sshd-session-1014    [005] .....   327.836724: rw_verify_area <-vfs_read
    sshd-session-1014    [005] .....   327.836725: cache_misses: 741723940
    sshd-session-1014    [005] .....   327.836728: security_file_permission <-rw_verify_area
    sshd-session-1014    [005] .....   327.836729: cache_misses: 741725151

The option will cause the perf event to be triggered after every function
called.

If cpu_cycles is also enabled:

 # echo 1 > options/func-cpu-cycles
 # cat trace
[..]
    sshd-session-1014    [005] b..1.   536.844538: preempt_count_sub <-_raw_spin_unlock
    sshd-session-1014    [005] b..1.   536.844539: cpu_cycles: 1919425978 cache_misses: 3431216952
    sshd-session-1014    [005] b....   536.844545: validate_xmit_skb_list <-sch_direct_xmit
    sshd-session-1014    [005] b....   536.844545: cpu_cycles: 1919429935 cache_misses: 3431218535
    sshd-session-1014    [005] b....   536.844551: validate_xmit_skb.isra.0 <-validate_xmit_skb_list
    sshd-session-1014    [005] b....   536.844552: cpu_cycles: 1919433763 cache_misses: 3431220112
    sshd-session-1014    [005] b....   536.844557: netif_skb_features <-validate_xmit_skb.isra.0
    sshd-session-1014    [005] b....   536.844558: cpu_cycles: 1919437574 cache_misses: 3431221688

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h |   5 +-
 kernel/trace/trace.c            |  58 ++++++++++++---
 kernel/trace/trace.h            |   6 ++
 kernel/trace/trace_functions.c  | 124 ++++++++++++++++++++++++++++++--
 4 files changed, 178 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index ae04054a1be3..c42d86d81afa 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -132,9 +132,12 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		 * will think a recursion occurred, and the event will be dropped.
 		 * Let a single instance happen via the TRANSITION_BIT to
 		 * not drop those events.
+		 *
+		 * When ip is zero, the caller is purposely trying causing
+		 * recursion. Don't record it.
 		 */
 		bit = TRACE_CTX_TRANSITION + start;
-		if (val & (1 << bit)) {
+		if ((val & (1 << bit)) && ip) {
 			do_ftrace_record_recursion(ip, pip);
 			return -1;
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64d966a3ec8b..42bf1c046de1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2915,21 +2915,18 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
 #ifdef CONFIG_PERF_EVENTS
-static inline void record_perf_event(struct trace_array *tr,
-				     struct trace_buffer *buffer,
-				     unsigned int trace_ctx)
+static inline void trace_perf_event(struct trace_array *tr,
+				    struct trace_buffer *buffer,
+				    int entries, u64 flags,
+				    unsigned int trace_ctx)
 {
 	struct ring_buffer_event *event;
 	struct perf_event_entry *entry;
-	int entries = READ_ONCE(tr->perf_events);
 	struct trace_array_cpu *data;
 	u64 *value;
 	int size;
 	int cpu;
 
-	if (!entries)
-		return;
-
 	guard(preempt_notrace)();
 	cpu = smp_processor_id();
 
@@ -2949,12 +2946,12 @@ static inline void record_perf_event(struct trace_array *tr,
 	entry			= ring_buffer_event_data(event);
 	value			= entry->values;
 
-	if (tr->trace_flags & TRACE_ITER(PERF_CYCLES)) {
+	if (flags & TRACE_ITER(PERF_CYCLES)) {
 		*value++ = TRACE_PERF_VALUE(PERF_TRACE_CYCLES);
 		entries--;
 	}
 
-	if (entries && tr->trace_flags & TRACE_ITER(PERF_CACHE)) {
+	if (entries && flags & TRACE_ITER(PERF_CACHE)) {
 		*value++ = TRACE_PERF_VALUE(PERF_TRACE_CACHE);
 		entries--;
 	}
@@ -2968,6 +2965,49 @@ static inline void record_perf_event(struct trace_array *tr,
 	local_dec(&data->disabled);
 }
 
+static inline void record_perf_event(struct trace_array *tr,
+				     struct trace_buffer *buffer,
+				     unsigned int trace_ctx)
+{
+	int entries = READ_ONCE(tr->perf_events);
+
+	if (!entries)
+		return;
+
+	trace_perf_event(tr, buffer, entries, tr->trace_flags, trace_ctx);
+}
+
+#ifdef CONFIG_FUNCTION_TRACER
+void ftrace_perf_events(struct trace_array *tr, int perf_events,
+			u64 perf_mask, unsigned int trace_ctx)
+{
+	struct trace_buffer *buffer;
+	int bit;
+
+	/*
+	 * Prevent any ftrace recursion.
+	 * The ftrace_test_recursion_trylock() allows one nested loop
+	 * to handle the case where an interrupt comes in and traces
+	 * before the preempt_count is updated to the new context.
+	 * This one instance allows that function to still be traced.
+	 *
+	 * The trace_perf_cache_misses() will call functions that function
+	 * tracing will want to trace. Prevent this one loop from happening
+	 * by taking the the lock again. If an interrupt comes in now,
+	 * it may still be dropped, but there's really nothing that can
+	 * be done about that until all those locations get fixed.
+	 */
+	bit = ftrace_test_recursion_trylock(0, 0);
+
+	buffer = tr->array_buffer.buffer;
+	trace_perf_event(tr, buffer, perf_events, perf_mask, trace_ctx);
+
+	/* bit < 0 means the trylock failed and does not need to be unlocked */
+	if (bit >= 0)
+		ftrace_test_recursion_unlock(bit);
+}
+#endif
+
 static int handle_perf_event(struct trace_array *tr, u64 mask, int enabled)
 {
 	int ret = 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 094a156b0c70..bb764a2255c7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -365,6 +365,8 @@ struct trace_array {
 	int			buffer_disabled;
 
 	int			perf_events;
+	int			ftrace_perf_events;
+	u64			ftrace_perf_mask;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
@@ -1402,6 +1404,10 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 u64 do_trace_perf_event(int type);
 int trace_perf_event_enable(int type);
 void trace_perf_event_disable(int type);
+#ifdef CONFIG_FUNCTION_TRACER
+void ftrace_perf_events(struct trace_array *tr, int perf_events,
+			u64 perf_mask, unsigned int trace_ctx);
+#endif
 #else
 # define PERF_FLAGS
 static inline u64 do_trace_perf_event(int type) { return 0; }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c12795c2fb39..97f46ac7ef21 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -47,8 +47,12 @@ enum {
 	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
 	TRACE_FUNC_OPT_ARGS		= 0x4,
 
-	/* Update this to next highest bit. */
-	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8
+	/* Update this to next highest function bit. */
+	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8,
+
+	/* These are just other options */
+	TRACE_FUNC_OPT_PERF_CYCLES	= 0x10,
+	TRACE_FUNC_OPT_PERF_CACHE	= 0x20,
 };
 
 #define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
@@ -143,6 +147,105 @@ static bool handle_func_repeats(struct trace_array *tr, u32 flags_val)
 	return true;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+static inline void
+do_trace_function(struct trace_array *tr, unsigned long ip,
+		  unsigned long parent_ip, unsigned int trace_ctx,
+		  struct ftrace_regs *fregs)
+{
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
+
+	if (likely(!tr->ftrace_perf_events))
+		return;
+
+	ftrace_perf_events(tr, tr->ftrace_perf_events, tr->ftrace_perf_mask, trace_ctx);
+}
+
+static bool handle_perf_event_flag(struct trace_array *tr, int bit, int set, int *err)
+{
+	u64 mask;
+	int type;
+
+	*err = 0;
+
+	switch (bit) {
+	case TRACE_FUNC_OPT_PERF_CYCLES:
+		mask = TRACE_ITER(PERF_CYCLES);
+		type = PERF_TRACE_CYCLES;
+		break;
+
+	case TRACE_FUNC_OPT_PERF_CACHE:
+		mask = TRACE_ITER(PERF_CACHE);
+		type = PERF_TRACE_CACHE;
+		break;
+
+	default:
+		return 0;
+	}
+
+	if (set)
+		*err = trace_perf_event_enable(type);
+	else
+		trace_perf_event_disable(type);
+
+	if (*err < 0)
+		return 1;
+
+	if (set) {
+		tr->ftrace_perf_events++;
+		tr->ftrace_perf_mask |= mask;
+	} else {
+		tr->ftrace_perf_mask &= ~mask;
+		tr->ftrace_perf_events--;
+	}
+	return 1;
+}
+
+static void ftrace_perf_enable(struct trace_array *tr, int bit)
+{
+	int err;
+
+	if (!(tr->current_trace_flags->val & bit))
+		return;
+
+	handle_perf_event_flag(tr, bit, 1, &err);
+	if (err < 0)
+		tr->current_trace_flags->val &= ~bit;
+}
+
+static void ftrace_perf_disable(struct trace_array *tr, int bit)
+{
+	int err;
+
+	/* Only disable if it was enabled */
+	if (!(tr->current_trace_flags->val & bit))
+		return;
+
+	handle_perf_event_flag(tr, bit, 0, &err);
+}
+
+static void ftrace_perf_init(struct trace_array *tr)
+{
+	ftrace_perf_enable(tr, TRACE_FUNC_OPT_PERF_CYCLES);
+	ftrace_perf_enable(tr, TRACE_FUNC_OPT_PERF_CACHE);
+}
+
+static void ftrace_perf_reset(struct trace_array *tr)
+{
+	ftrace_perf_disable(tr, TRACE_FUNC_OPT_PERF_CYCLES);
+	ftrace_perf_disable(tr, TRACE_FUNC_OPT_PERF_CACHE);
+}
+#else
+#define do_trace_function trace_function
+static inline bool handle_perf_event_flag(struct trace_array *tr, int bit,
+					  int set, int *err)
+{
+	return 0;
+}
+static inline void ftrace_perf_init(struct trace_array *tr) { }
+static inline void ftrace_perf_reset(struct trace_array *tr) { }
+#endif /* CONFIG_PERF_EVENTS */
+
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -165,6 +268,8 @@ static int function_trace_init(struct trace_array *tr)
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
 
+	ftrace_perf_init(tr);
+
 	tracing_start_cmdline_record();
 	tracing_start_function_trace(tr);
 	return 0;
@@ -172,6 +277,7 @@ static int function_trace_init(struct trace_array *tr)
 
 static void function_trace_reset(struct trace_array *tr)
 {
+	ftrace_perf_reset(tr);
 	tracing_stop_function_trace(tr);
 	tracing_stop_cmdline_record();
 	ftrace_reset_array_ops(tr);
@@ -223,7 +329,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx_dec();
 
-	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+	do_trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -245,7 +351,7 @@ function_args_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx();
 
-	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
+	do_trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -372,7 +478,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
-	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+	do_trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 
 out:
 	ftrace_test_recursion_unlock(bit);
@@ -428,6 +534,10 @@ static struct tracer_opt func_opts[] = {
 	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
 #ifdef CONFIG_FUNCTION_TRACE_ARGS
 	{ TRACER_OPT(func-args, TRACE_FUNC_OPT_ARGS) },
+#endif
+#if CONFIG_PERF_EVENTS
+	{ TRACER_OPT(func-cpu-cycles, TRACE_FUNC_OPT_PERF_CYCLES) },
+	{ TRACER_OPT(func-cache-misses, TRACE_FUNC_OPT_PERF_CACHE) },
 #endif
 	{ } /* Always set a last empty entry */
 };
@@ -457,6 +567,7 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
 	ftrace_func_t func;
 	u32 new_flags;
+	int err;
 
 	/* Do nothing if already set. */
 	if (!!set == !!(tr->current_trace_flags->val & bit))
@@ -466,6 +577,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (tr->current_trace != &function_trace)
 		return 0;
 
+	if (handle_perf_event_flag(tr, bit, set, &err))
+		return err;
+
 	new_flags = (tr->current_trace_flags->val & ~bit) | (set ? bit : 0);
 	func = select_trace_function(new_flags);
 	if (!func)
-- 
2.51.0


