Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88252D5957;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521047; cv=none; b=qEAwGEOv7Ljc5ixHFFK98TtLe7H5e3gwpp/7CzmaeWPcAcfKk0zwTxs8xnpA+wq1hGoUWZzJB/Wq0ubdvjlj7bfqvaWjA7K+P/nPcD9EBli3kQv1G94VW7Hx+xwq2vXQz69qU1mGhj5Y49wmU4+l/aKJN1mUJ+RZ+JE/PQtXaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521047; c=relaxed/simple;
	bh=XDF2El33lw0RRIstOCa+Rte3svvG1kIhOVxkHOJNvSU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IDurEDTOouGNqMZTPGBukpK0Q1vjbIkSIoS00rP4uh4SdAAK21OGKiR8fSAjgk3SGB5i7yuLz8AsY7XDQKatNBSOc8N7/DkCvp8MfzFWWFHwTp7OnUW7Bk5SkG0HrMYrO5xyEmTM4enxZYZD5nYHXqh7znRMSQqBGeyZUEpbsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1y1UKxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1y1UKxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B49C116C6;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521047;
	bh=XDF2El33lw0RRIstOCa+Rte3svvG1kIhOVxkHOJNvSU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=j1y1UKxfPAoNbs0zP1dctlBC6C7tVvkrwMx8ga9FM5cgNoRqQkVcle0BWrBCJkjf8
	 5wqE6pJ2pa4xcHRAm9svpkyoISxXcOCAYuT+tGgCYu2QjC0H5Ztz9e7zf1DCZwT8XN
	 n3H3GCivuHAHykkX4g/20HC0O/MXHuTcZJOlcpD3gIiaCts3tBRWhTpNuWrqeOcnZX
	 GnTOjtCtpRy3CY8BNiM40Cz3aBQP2aWAL9oWeOkVdDq5HucED5uxExLjDFWZVDh4ip
	 n/ZX0/hGW/rKLWUVb/aXZbMbT7U/KyDdM+2zt0o8LQFwTfSvIbPl6JTzDibhhPotRh
	 ahcU2V32mYwqQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOfB-46Ns;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032450.828744197@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:26 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 09/10] tracing: Move trace_printk functions out of trace.c and into
 trace_printk.c
References: <20260208032417.262341179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The file trace.c has become a catchall for most things tracing. Start
making it smaller by breaking out various aspects into their own files.

Move the functions associated to the trace_printk operations out of trace.c and
into trace_printk.c.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 431 ------------------------------------
 kernel/trace/trace.h        |   1 +
 kernel/trace/trace_printk.c | 431 ++++++++++++++++++++++++++++++++++++
 3 files changed, 432 insertions(+), 431 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4066c33674e7..5812b830c1fa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -539,17 +539,6 @@ struct trace_array *printk_trace = &global_trace;
 /* List of trace_arrays interested in the top level trace_marker */
 static LIST_HEAD(marker_copies);
 
-static __always_inline bool printk_binsafe(struct trace_array *tr)
-{
-	/*
-	 * The binary format of traceprintk can cause a crash if used
-	 * by a buffer from another boot. Force the use of the
-	 * non binary version of trace_printk if the trace_printk
-	 * buffer is a boot mapped ring buffer.
-	 */
-	return !(tr->flags & TRACE_ARRAY_FL_BOOT);
-}
-
 static void update_printk_trace(struct trace_array *tr)
 {
 	if (printk_trace == tr)
@@ -1059,108 +1048,6 @@ void tracing_on(void)
 }
 EXPORT_SYMBOL_GPL(tracing_on);
 
-int __trace_array_puts(struct trace_array *tr, unsigned long ip,
-		       const char *str, int size)
-{
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	struct print_entry *entry;
-	unsigned int trace_ctx;
-	int alloc;
-
-	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
-		return 0;
-
-	if (unlikely(tracing_selftest_running &&
-		     (tr->flags & TRACE_ARRAY_FL_GLOBAL)))
-		return 0;
-
-	if (unlikely(tracing_disabled))
-		return 0;
-
-	alloc = sizeof(*entry) + size + 2; /* possible \n added */
-
-	trace_ctx = tracing_gen_ctx();
-	buffer = tr->array_buffer.buffer;
-	guard(ring_buffer_nest)(buffer);
-	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
-					    trace_ctx);
-	if (!event)
-		return 0;
-
-	entry = ring_buffer_event_data(event);
-	entry->ip = ip;
-
-	memcpy(&entry->buf, str, size);
-
-	/* Add a newline if necessary */
-	if (entry->buf[size - 1] != '\n') {
-		entry->buf[size] = '\n';
-		entry->buf[size + 1] = '\0';
-	} else
-		entry->buf[size] = '\0';
-
-	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
-	return size;
-}
-EXPORT_SYMBOL_GPL(__trace_array_puts);
-
-/**
- * __trace_puts - write a constant string into the trace buffer.
- * @ip:	   The address of the caller
- * @str:   The constant string to write
- * @size:  The size of the string.
- */
-int __trace_puts(unsigned long ip, const char *str, int size)
-{
-	return __trace_array_puts(printk_trace, ip, str, size);
-}
-EXPORT_SYMBOL_GPL(__trace_puts);
-
-/**
- * __trace_bputs - write the pointer to a constant string into trace buffer
- * @ip:	   The address of the caller
- * @str:   The constant string to write to the buffer to
- */
-int __trace_bputs(unsigned long ip, const char *str)
-{
-	struct trace_array *tr = READ_ONCE(printk_trace);
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	struct bputs_entry *entry;
-	unsigned int trace_ctx;
-	int size = sizeof(struct bputs_entry);
-
-	if (!printk_binsafe(tr))
-		return __trace_puts(ip, str, strlen(str));
-
-	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
-		return 0;
-
-	if (unlikely(tracing_selftest_running || tracing_disabled))
-		return 0;
-
-	trace_ctx = tracing_gen_ctx();
-	buffer = tr->array_buffer.buffer;
-
-	guard(ring_buffer_nest)(buffer);
-	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
-					    trace_ctx);
-	if (!event)
-		return 0;
-
-	entry = ring_buffer_event_data(event);
-	entry->ip			= ip;
-	entry->str			= str;
-
-	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(__trace_bputs);
-
 #ifdef CONFIG_TRACER_SNAPSHOT
 static void tracing_snapshot_instance_cond(struct trace_array *tr,
 					   void *cond_data)
@@ -3159,324 +3046,6 @@ void trace_last_func_repeats(struct trace_array *tr,
 	__buffer_unlock_commit(buffer, event);
 }
 
-/* created for use with alloc_percpu */
-struct trace_buffer_struct {
-	int nesting;
-	char buffer[4][TRACE_BUF_SIZE];
-};
-
-static struct trace_buffer_struct __percpu *trace_percpu_buffer;
-
-/*
- * This allows for lockless recording.  If we're nested too deeply, then
- * this returns NULL.
- */
-static char *get_trace_buf(void)
-{
-	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
-
-	if (!trace_percpu_buffer || buffer->nesting >= 4)
-		return NULL;
-
-	buffer->nesting++;
-
-	/* Interrupts must see nesting incremented before we use the buffer */
-	barrier();
-	return &buffer->buffer[buffer->nesting - 1][0];
-}
-
-static void put_trace_buf(void)
-{
-	/* Don't let the decrement of nesting leak before this */
-	barrier();
-	this_cpu_dec(trace_percpu_buffer->nesting);
-}
-
-static int alloc_percpu_trace_buffer(void)
-{
-	struct trace_buffer_struct __percpu *buffers;
-
-	if (trace_percpu_buffer)
-		return 0;
-
-	buffers = alloc_percpu(struct trace_buffer_struct);
-	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
-		return -ENOMEM;
-
-	trace_percpu_buffer = buffers;
-	return 0;
-}
-
-static int buffers_allocated;
-
-void trace_printk_init_buffers(void)
-{
-	if (buffers_allocated)
-		return;
-
-	if (alloc_percpu_trace_buffer())
-		return;
-
-	/* trace_printk() is for debug use only. Don't use it in production. */
-
-	pr_warn("\n");
-	pr_warn("**********************************************************\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** trace_printk() being used. Allocating extra memory.  **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** This means that this is a DEBUG kernel and it is     **\n");
-	pr_warn("** unsafe for production use.                           **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** If you see this message and you are not debugging    **\n");
-	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**********************************************************\n");
-
-	/* Expand the buffers to set size */
-	if (tracing_update_buffers(NULL) < 0)
-		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
-	else
-		buffers_allocated = 1;
-
-	/*
-	 * trace_printk_init_buffers() can be called by modules.
-	 * If that happens, then we need to start cmdline recording
-	 * directly here.
-	 */
-	if (system_state == SYSTEM_RUNNING)
-		tracing_start_cmdline_record();
-}
-EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
-
-void trace_printk_start_comm(void)
-{
-	/* Start tracing comms if trace printk is set */
-	if (!buffers_allocated)
-		return;
-	tracing_start_cmdline_record();
-}
-
-static void trace_printk_start_stop_comm(int enabled)
-{
-	if (!buffers_allocated)
-		return;
-
-	if (enabled)
-		tracing_start_cmdline_record();
-	else
-		tracing_stop_cmdline_record();
-}
-
-/**
- * trace_vbprintk - write binary msg to tracing buffer
- * @ip:    The address of the caller
- * @fmt:   The string format to write to the buffer
- * @args:  Arguments for @fmt
- */
-int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
-{
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	struct trace_array *tr = READ_ONCE(printk_trace);
-	struct bprint_entry *entry;
-	unsigned int trace_ctx;
-	char *tbuffer;
-	int len = 0, size;
-
-	if (!printk_binsafe(tr))
-		return trace_vprintk(ip, fmt, args);
-
-	if (unlikely(tracing_selftest_running || tracing_disabled))
-		return 0;
-
-	/* Don't pollute graph traces with trace_vprintk internals */
-	pause_graph_tracing();
-
-	trace_ctx = tracing_gen_ctx();
-	guard(preempt_notrace)();
-
-	tbuffer = get_trace_buf();
-	if (!tbuffer) {
-		len = 0;
-		goto out_nobuffer;
-	}
-
-	len = vbin_printf((u32 *)tbuffer, TRACE_BUF_SIZE/sizeof(int), fmt, args);
-
-	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
-		goto out_put;
-
-	size = sizeof(*entry) + sizeof(u32) * len;
-	buffer = tr->array_buffer.buffer;
-	scoped_guard(ring_buffer_nest, buffer) {
-		event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
-						    trace_ctx);
-		if (!event)
-			goto out_put;
-		entry = ring_buffer_event_data(event);
-		entry->ip			= ip;
-		entry->fmt			= fmt;
-
-		memcpy(entry->buf, tbuffer, sizeof(u32) * len);
-		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
-	}
-out_put:
-	put_trace_buf();
-
-out_nobuffer:
-	unpause_graph_tracing();
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(trace_vbprintk);
-
-static __printf(3, 0)
-int __trace_array_vprintk(struct trace_buffer *buffer,
-			  unsigned long ip, const char *fmt, va_list args)
-{
-	struct ring_buffer_event *event;
-	int len = 0, size;
-	struct print_entry *entry;
-	unsigned int trace_ctx;
-	char *tbuffer;
-
-	if (unlikely(tracing_disabled))
-		return 0;
-
-	/* Don't pollute graph traces with trace_vprintk internals */
-	pause_graph_tracing();
-
-	trace_ctx = tracing_gen_ctx();
-	guard(preempt_notrace)();
-
-
-	tbuffer = get_trace_buf();
-	if (!tbuffer) {
-		len = 0;
-		goto out_nobuffer;
-	}
-
-	len = vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
-
-	size = sizeof(*entry) + len + 1;
-	scoped_guard(ring_buffer_nest, buffer) {
-		event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-						    trace_ctx);
-		if (!event)
-			goto out;
-		entry = ring_buffer_event_data(event);
-		entry->ip = ip;
-
-		memcpy(&entry->buf, tbuffer, len + 1);
-		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
-	}
-out:
-	put_trace_buf();
-
-out_nobuffer:
-	unpause_graph_tracing();
-
-	return len;
-}
-
-int trace_array_vprintk(struct trace_array *tr,
-			unsigned long ip, const char *fmt, va_list args)
-{
-	if (tracing_selftest_running && (tr->flags & TRACE_ARRAY_FL_GLOBAL))
-		return 0;
-
-	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
-}
-
-/**
- * trace_array_printk - Print a message to a specific instance
- * @tr: The instance trace_array descriptor
- * @ip: The instruction pointer that this is called from.
- * @fmt: The format to print (printf format)
- *
- * If a subsystem sets up its own instance, they have the right to
- * printk strings into their tracing instance buffer using this
- * function. Note, this function will not write into the top level
- * buffer (use trace_printk() for that), as writing into the top level
- * buffer should only have events that can be individually disabled.
- * trace_printk() is only used for debugging a kernel, and should not
- * be ever incorporated in normal use.
- *
- * trace_array_printk() can be used, as it will not add noise to the
- * top level tracing buffer.
- *
- * Note, trace_array_init_printk() must be called on @tr before this
- * can be used.
- */
-int trace_array_printk(struct trace_array *tr,
-		       unsigned long ip, const char *fmt, ...)
-{
-	int ret;
-	va_list ap;
-
-	if (!tr)
-		return -ENOENT;
-
-	/* This is only allowed for created instances */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return 0;
-
-	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
-		return 0;
-
-	va_start(ap, fmt);
-	ret = trace_array_vprintk(tr, ip, fmt, ap);
-	va_end(ap);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(trace_array_printk);
-
-/**
- * trace_array_init_printk - Initialize buffers for trace_array_printk()
- * @tr: The trace array to initialize the buffers for
- *
- * As trace_array_printk() only writes into instances, they are OK to
- * have in the kernel (unlike trace_printk()). This needs to be called
- * before trace_array_printk() can be used on a trace_array.
- */
-int trace_array_init_printk(struct trace_array *tr)
-{
-	if (!tr)
-		return -ENOENT;
-
-	/* This is only allowed for created instances */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return -EINVAL;
-
-	return alloc_percpu_trace_buffer();
-}
-EXPORT_SYMBOL_GPL(trace_array_init_printk);
-
-int trace_array_printk_buf(struct trace_buffer *buffer,
-			   unsigned long ip, const char *fmt, ...)
-{
-	int ret;
-	va_list ap;
-
-	if (!(printk_trace->trace_flags & TRACE_ITER(PRINTK)))
-		return 0;
-
-	va_start(ap, fmt);
-	ret = __trace_array_vprintk(buffer, ip, fmt, ap);
-	va_end(ap);
-	return ret;
-}
-
-int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
-{
-	return trace_array_vprintk(printk_trace, ip, fmt, args);
-}
-EXPORT_SYMBOL_GPL(trace_vprintk);
-
 static void trace_iterator_increment(struct trace_iterator *iter)
 {
 	struct ring_buffer_iter *buf_iter = trace_buffer_iter(iter, iter->cpu);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 921e4daa2825..6b0fedf2f532 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2131,6 +2131,7 @@ extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
 void trace_printk_start_comm(void);
+void trace_printk_start_stop_comm(int enabled);
 int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set);
 int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled);
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..c9cb74a33b3c 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -376,6 +376,437 @@ static const struct file_operations ftrace_formats_fops = {
 	.release = seq_release,
 };
 
+static __always_inline bool printk_binsafe(struct trace_array *tr)
+{
+	/*
+	 * The binary format of traceprintk can cause a crash if used
+	 * by a buffer from another boot. Force the use of the
+	 * non binary version of trace_printk if the trace_printk
+	 * buffer is a boot mapped ring buffer.
+	 */
+	return !(tr->flags & TRACE_ARRAY_FL_BOOT);
+}
+
+int __trace_array_puts(struct trace_array *tr, unsigned long ip,
+		       const char *str, int size)
+{
+	struct ring_buffer_event *event;
+	struct trace_buffer *buffer;
+	struct print_entry *entry;
+	unsigned int trace_ctx;
+	int alloc;
+
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
+		return 0;
+
+	if (unlikely(tracing_selftest_running &&
+		     (tr->flags & TRACE_ARRAY_FL_GLOBAL)))
+		return 0;
+
+	if (unlikely(tracing_disabled))
+		return 0;
+
+	alloc = sizeof(*entry) + size + 2; /* possible \n added */
+
+	trace_ctx = tracing_gen_ctx();
+	buffer = tr->array_buffer.buffer;
+	guard(ring_buffer_nest)(buffer);
+	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
+					    trace_ctx);
+	if (!event)
+		return 0;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip = ip;
+
+	memcpy(&entry->buf, str, size);
+
+	/* Add a newline if necessary */
+	if (entry->buf[size - 1] != '\n') {
+		entry->buf[size] = '\n';
+		entry->buf[size + 1] = '\0';
+	} else
+		entry->buf[size] = '\0';
+
+	__buffer_unlock_commit(buffer, event);
+	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
+	return size;
+}
+EXPORT_SYMBOL_GPL(__trace_array_puts);
+
+/**
+ * __trace_puts - write a constant string into the trace buffer.
+ * @ip:	   The address of the caller
+ * @str:   The constant string to write
+ * @size:  The size of the string.
+ */
+int __trace_puts(unsigned long ip, const char *str, int size)
+{
+	return __trace_array_puts(printk_trace, ip, str, size);
+}
+EXPORT_SYMBOL_GPL(__trace_puts);
+
+/**
+ * __trace_bputs - write the pointer to a constant string into trace buffer
+ * @ip:	   The address of the caller
+ * @str:   The constant string to write to the buffer to
+ */
+int __trace_bputs(unsigned long ip, const char *str)
+{
+	struct trace_array *tr = READ_ONCE(printk_trace);
+	struct ring_buffer_event *event;
+	struct trace_buffer *buffer;
+	struct bputs_entry *entry;
+	unsigned int trace_ctx;
+	int size = sizeof(struct bputs_entry);
+
+	if (!printk_binsafe(tr))
+		return __trace_puts(ip, str, strlen(str));
+
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
+		return 0;
+
+	if (unlikely(tracing_selftest_running || tracing_disabled))
+		return 0;
+
+	trace_ctx = tracing_gen_ctx();
+	buffer = tr->array_buffer.buffer;
+
+	guard(ring_buffer_nest)(buffer);
+	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
+					    trace_ctx);
+	if (!event)
+		return 0;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip			= ip;
+	entry->str			= str;
+
+	__buffer_unlock_commit(buffer, event);
+	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(__trace_bputs);
+
+/* created for use with alloc_percpu */
+struct trace_buffer_struct {
+	int nesting;
+	char buffer[4][TRACE_BUF_SIZE];
+};
+
+static struct trace_buffer_struct __percpu *trace_percpu_buffer;
+
+/*
+ * This allows for lockless recording.  If we're nested too deeply, then
+ * this returns NULL.
+ */
+static char *get_trace_buf(void)
+{
+	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
+
+	if (!trace_percpu_buffer || buffer->nesting >= 4)
+		return NULL;
+
+	buffer->nesting++;
+
+	/* Interrupts must see nesting incremented before we use the buffer */
+	barrier();
+	return &buffer->buffer[buffer->nesting - 1][0];
+}
+
+static void put_trace_buf(void)
+{
+	/* Don't let the decrement of nesting leak before this */
+	barrier();
+	this_cpu_dec(trace_percpu_buffer->nesting);
+}
+
+static int alloc_percpu_trace_buffer(void)
+{
+	struct trace_buffer_struct __percpu *buffers;
+
+	if (trace_percpu_buffer)
+		return 0;
+
+	buffers = alloc_percpu(struct trace_buffer_struct);
+	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
+		return -ENOMEM;
+
+	trace_percpu_buffer = buffers;
+	return 0;
+}
+
+static int buffers_allocated;
+
+void trace_printk_init_buffers(void)
+{
+	if (buffers_allocated)
+		return;
+
+	if (alloc_percpu_trace_buffer())
+		return;
+
+	/* trace_printk() is for debug use only. Don't use it in production. */
+
+	pr_warn("\n");
+	pr_warn("**********************************************************\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** trace_printk() being used. Allocating extra memory.  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** This means that this is a DEBUG kernel and it is     **\n");
+	pr_warn("** unsafe for production use.                           **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** If you see this message and you are not debugging    **\n");
+	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**********************************************************\n");
+
+	/* Expand the buffers to set size */
+	if (tracing_update_buffers(NULL) < 0)
+		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
+	else
+		buffers_allocated = 1;
+
+	/*
+	 * trace_printk_init_buffers() can be called by modules.
+	 * If that happens, then we need to start cmdline recording
+	 * directly here.
+	 */
+	if (system_state == SYSTEM_RUNNING)
+		tracing_start_cmdline_record();
+}
+EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
+
+void trace_printk_start_comm(void)
+{
+	/* Start tracing comms if trace printk is set */
+	if (!buffers_allocated)
+		return;
+	tracing_start_cmdline_record();
+}
+
+void trace_printk_start_stop_comm(int enabled)
+{
+	if (!buffers_allocated)
+		return;
+
+	if (enabled)
+		tracing_start_cmdline_record();
+	else
+		tracing_stop_cmdline_record();
+}
+
+/**
+ * trace_vbprintk - write binary msg to tracing buffer
+ * @ip:    The address of the caller
+ * @fmt:   The string format to write to the buffer
+ * @args:  Arguments for @fmt
+ */
+int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
+{
+	struct ring_buffer_event *event;
+	struct trace_buffer *buffer;
+	struct trace_array *tr = READ_ONCE(printk_trace);
+	struct bprint_entry *entry;
+	unsigned int trace_ctx;
+	char *tbuffer;
+	int len = 0, size;
+
+	if (!printk_binsafe(tr))
+		return trace_vprintk(ip, fmt, args);
+
+	if (unlikely(tracing_selftest_running || tracing_disabled))
+		return 0;
+
+	/* Don't pollute graph traces with trace_vprintk internals */
+	pause_graph_tracing();
+
+	trace_ctx = tracing_gen_ctx();
+	guard(preempt_notrace)();
+
+	tbuffer = get_trace_buf();
+	if (!tbuffer) {
+		len = 0;
+		goto out_nobuffer;
+	}
+
+	len = vbin_printf((u32 *)tbuffer, TRACE_BUF_SIZE/sizeof(int), fmt, args);
+
+	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
+		goto out_put;
+
+	size = sizeof(*entry) + sizeof(u32) * len;
+	buffer = tr->array_buffer.buffer;
+	scoped_guard(ring_buffer_nest, buffer) {
+		event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
+						    trace_ctx);
+		if (!event)
+			goto out_put;
+		entry = ring_buffer_event_data(event);
+		entry->ip			= ip;
+		entry->fmt			= fmt;
+
+		memcpy(entry->buf, tbuffer, sizeof(u32) * len);
+		__buffer_unlock_commit(buffer, event);
+		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
+	}
+out_put:
+	put_trace_buf();
+
+out_nobuffer:
+	unpause_graph_tracing();
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(trace_vbprintk);
+
+static __printf(3, 0)
+int __trace_array_vprintk(struct trace_buffer *buffer,
+			  unsigned long ip, const char *fmt, va_list args)
+{
+	struct ring_buffer_event *event;
+	int len = 0, size;
+	struct print_entry *entry;
+	unsigned int trace_ctx;
+	char *tbuffer;
+
+	if (unlikely(tracing_disabled))
+		return 0;
+
+	/* Don't pollute graph traces with trace_vprintk internals */
+	pause_graph_tracing();
+
+	trace_ctx = tracing_gen_ctx();
+	guard(preempt_notrace)();
+
+
+	tbuffer = get_trace_buf();
+	if (!tbuffer) {
+		len = 0;
+		goto out_nobuffer;
+	}
+
+	len = vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
+
+	size = sizeof(*entry) + len + 1;
+	scoped_guard(ring_buffer_nest, buffer) {
+		event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
+						    trace_ctx);
+		if (!event)
+			goto out;
+		entry = ring_buffer_event_data(event);
+		entry->ip = ip;
+
+		memcpy(&entry->buf, tbuffer, len + 1);
+		__buffer_unlock_commit(buffer, event);
+		ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
+	}
+out:
+	put_trace_buf();
+
+out_nobuffer:
+	unpause_graph_tracing();
+
+	return len;
+}
+
+int trace_array_vprintk(struct trace_array *tr,
+			unsigned long ip, const char *fmt, va_list args)
+{
+	if (tracing_selftest_running && (tr->flags & TRACE_ARRAY_FL_GLOBAL))
+		return 0;
+
+	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
+}
+
+/**
+ * trace_array_printk - Print a message to a specific instance
+ * @tr: The instance trace_array descriptor
+ * @ip: The instruction pointer that this is called from.
+ * @fmt: The format to print (printf format)
+ *
+ * If a subsystem sets up its own instance, they have the right to
+ * printk strings into their tracing instance buffer using this
+ * function. Note, this function will not write into the top level
+ * buffer (use trace_printk() for that), as writing into the top level
+ * buffer should only have events that can be individually disabled.
+ * trace_printk() is only used for debugging a kernel, and should not
+ * be ever incorporated in normal use.
+ *
+ * trace_array_printk() can be used, as it will not add noise to the
+ * top level tracing buffer.
+ *
+ * Note, trace_array_init_printk() must be called on @tr before this
+ * can be used.
+ */
+int trace_array_printk(struct trace_array *tr,
+		       unsigned long ip, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	if (!tr)
+		return -ENOENT;
+
+	/* This is only allowed for created instances */
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
+		return 0;
+
+	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
+		return 0;
+
+	va_start(ap, fmt);
+	ret = trace_array_vprintk(tr, ip, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(trace_array_printk);
+
+/**
+ * trace_array_init_printk - Initialize buffers for trace_array_printk()
+ * @tr: The trace array to initialize the buffers for
+ *
+ * As trace_array_printk() only writes into instances, they are OK to
+ * have in the kernel (unlike trace_printk()). This needs to be called
+ * before trace_array_printk() can be used on a trace_array.
+ */
+int trace_array_init_printk(struct trace_array *tr)
+{
+	if (!tr)
+		return -ENOENT;
+
+	/* This is only allowed for created instances */
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
+		return -EINVAL;
+
+	return alloc_percpu_trace_buffer();
+}
+EXPORT_SYMBOL_GPL(trace_array_init_printk);
+
+int trace_array_printk_buf(struct trace_buffer *buffer,
+			   unsigned long ip, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	if (!(printk_trace->trace_flags & TRACE_ITER(PRINTK)))
+		return 0;
+
+	va_start(ap, fmt);
+	ret = __trace_array_vprintk(buffer, ip, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
+int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
+{
+	return trace_array_vprintk(printk_trace, ip, fmt, args);
+}
+EXPORT_SYMBOL_GPL(trace_vprintk);
+
 static __init int init_trace_printk_function_export(void)
 {
 	int ret;
-- 
2.51.0


