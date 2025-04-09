Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899361C5D63;
	Wed,  9 Apr 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224836; cv=none; b=htavV7GsfDe1KYDMXPRVl7tqUFrDpmcrc1lOSmGJhLF7dAdYl7UlC6sGNAMgYshfwqMTPwQVxwQC0oN4z3bgWaoh7wzufMR5wd8Y62Vmbdl/NsOoqUXAt+StNxFF3o0HA25e9wXWYQeVbqjOAYmzWmISZN5DZBKSuXFDI7WZnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224836; c=relaxed/simple;
	bh=6puIFq1VK1N8Qa37vGYhhsmTypoOuNsqquMTn7zYA4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pCG3OcIQak29KBaNUDJK4TteAsLfZbOVZZlnmF8YK1XnSw+h3bWne3xEHpgqq+5gbo7U+CtWHspZLss4evi8CJSBWxJFRojus07cYI0waWUBBQAlcMgCBbzYBoY2/Vnp02PZHJZS+Il8zZwfhxF4SloxXhzTV99+yHM2Qx4iFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B8AC4CEEA;
	Wed,  9 Apr 2025 18:53:55 +0000 (UTC)
Date: Wed, 9 Apr 2025 14:55:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Allow the top level trace_marker to write into
 another instances
Message-ID: <20250409145515.1cf1835e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

There are applications that have it hard coded to write into the top level
trace_marker instance (/sys/kernel/tracing/trace_marker). This can be
annoying if a profiler is using that instance for other work, or if it
needs all writes to go into a new instance.

A new option is created called "copy_trace_marker". By default, the top
level has this set, as that is the default buffer that writing into the
top level trace_marker file will go to. But now if an instance is created
and sets this option, all writes into the top level trace_marker will also
be written into that instance buffer just as if an application were to
write into the instance's trace_marker file.

If the top level instance disables this option, then writes to its own
trace_marker and trace_marker_raw files will not go into its buffer.

If no instance has this option set, then the write will return an error
and errno will contain ENODEV.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250408112714.403a4368@gandalf.local.home

- Instead of having a single destination for writing into the top level
  trace marker with a "redirect_trace_marker" option, have a
  "copy_trace_marker" option that will have writes into the top level
  trace_marker file go into other instances (more than one).
  (Mathieu Desnoyers)

 Documentation/trace/ftrace.rst |  13 ++++
 kernel/trace/trace.c           | 138 ++++++++++++++++++++++++++-------
 kernel/trace/trace.h           |   2 +
 3 files changed, 123 insertions(+), 30 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index c9e88bf65709..af66a05e18cc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1205,6 +1205,19 @@ Here are the available options:
 	default instance. The only way the top level instance has this flag
 	cleared, is by it being set in another instance.
 
+  copy_trace_marker
+	If there are applications that hard code writing into the top level
+	trace_marker file (/sys/kernel/tracing/trace_marker or trace_marker_raw),
+	and the tooling would like it to go into an instance, this option can
+	be used. Create an instance and set this option, and then all writes
+	into the top level trace_marker file will also be redirected into this
+	instance.
+
+	Note, by default this option is set for the top level instance. If it
+	is disabled, then writes to the trace_marker or trace_marker_raw files
+	will not be written into the top level file. If no instance has this
+	option set, then a write will error with the errno of ENODEV.
+
   annotate
 	It is sometimes confusing when the CPU buffers are full
 	and one CPU buffer had a lot of events recently, thus
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..e864a08ca18d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -493,7 +493,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
 	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
-	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK)
+	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |		\
+	 TRACE_ITER_COPY_MARKER)
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
@@ -501,7 +502,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK)
+	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
+	 TRACE_ITER_COPY_MARKER)
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -513,6 +515,9 @@ static struct trace_array global_trace = {
 
 static struct trace_array *printk_trace = &global_trace;
 
+/* List of trace_arrays interested in the top level trace_marker */
+static LIST_HEAD(marker_copies);
+
 static __always_inline bool printk_binsafe(struct trace_array *tr)
 {
 	/*
@@ -534,6 +539,28 @@ static void update_printk_trace(struct trace_array *tr)
 	tr->trace_flags |= TRACE_ITER_TRACE_PRINTK;
 }
 
+/* Returns true if the status of tr changed */
+static bool update_marker_trace(struct trace_array *tr, int enabled)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (enabled) {
+		if (!list_empty(&tr->marker_list))
+			return false;
+
+		list_add_rcu(&tr->marker_list, &marker_copies);
+		tr->trace_flags |= TRACE_ITER_COPY_MARKER;
+		return true;
+	}
+
+	if (list_empty(&tr->marker_list))
+		return false;
+
+	list_del_init(&tr->marker_list);
+	tr->trace_flags &= ~TRACE_ITER_COPY_MARKER;
+	return true;
+}
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -5189,7 +5216,8 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
 	    (mask == TRACE_ITER_RECORD_CMD) ||
-	    (mask == TRACE_ITER_TRACE_PRINTK))
+	    (mask == TRACE_ITER_TRACE_PRINTK) ||
+	    (mask == TRACE_ITER_COPY_MARKER))
 		lockdep_assert_held(&event_mutex);
 
 	/* do nothing if flag is already set */
@@ -5220,6 +5248,9 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		}
 	}
 
+	if (mask == TRACE_ITER_COPY_MARKER)
+		update_marker_trace(tr, enabled);
+
 	if (enabled)
 		tr->trace_flags |= mask;
 	else
@@ -7097,11 +7128,9 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 
 #define TRACE_MARKER_MAX_SIZE		4096
 
-static ssize_t
-tracing_mark_write(struct file *filp, const char __user *ubuf,
-					size_t cnt, loff_t *fpos)
+static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user *ubuf,
+				      size_t cnt)
 {
-	struct trace_array *tr = filp->private_data;
 	struct ring_buffer_event *event;
 	enum event_trigger_type tt = ETT_NONE;
 	struct trace_buffer *buffer;
@@ -7115,18 +7144,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 #define FAULTED_STR "<faulted>"
 #define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
-	if (tracing_disabled)
-		return -EINVAL;
-
-	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
-		return -EINVAL;
-
-	if ((ssize_t)cnt < 0)
-		return -EINVAL;
-
-	if (cnt > TRACE_MARKER_MAX_SIZE)
-		cnt = TRACE_MARKER_MAX_SIZE;
-
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
@@ -7192,18 +7209,11 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 }
 
 static ssize_t
-tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
+tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
 {
 	struct trace_array *tr = filp->private_data;
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	struct raw_data_entry *entry;
-	ssize_t written;
-	int size;
-	int len;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	ssize_t written = -ENODEV;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7211,10 +7221,39 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
 		return -EINVAL;
 
-	/* The marker must at least have a tag id */
-	if (cnt < sizeof(unsigned int))
+	if ((ssize_t)cnt < 0)
 		return -EINVAL;
 
+	if (cnt > TRACE_MARKER_MAX_SIZE)
+		cnt = TRACE_MARKER_MAX_SIZE;
+
+	/* The global trace_marker can go to multiple instances */
+	if (tr == &global_trace) {
+		guard(rcu)();
+		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
+			written = write_marker_to_buffer(tr, ubuf, cnt);
+			if (written < 0)
+				break;
+		}
+	} else {
+		written = write_marker_to_buffer(tr, ubuf, cnt);
+	}
+
+	return written;
+}
+
+static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
+					  const char __user *ubuf, size_t cnt)
+{
+	struct ring_buffer_event *event;
+	struct trace_buffer *buffer;
+	struct raw_data_entry *entry;
+	ssize_t written;
+	int size;
+	int len;
+
+#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+
 	size = sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size += FAULT_SIZE_ID - cnt;
@@ -7245,6 +7284,40 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
+static ssize_t
+tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
+					size_t cnt, loff_t *fpos)
+{
+	struct trace_array *tr = filp->private_data;
+	ssize_t written = -ENODEV;
+
+#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+
+	if (tracing_disabled)
+		return -EINVAL;
+
+	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
+		return -EINVAL;
+
+	/* The marker must at least have a tag id */
+	if (cnt < sizeof(unsigned int))
+		return -EINVAL;
+
+	/* The global trace_marker_raw can go to multiple instances */
+	if (tr == &global_trace) {
+		guard(rcu)();
+		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
+			written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+			if (written < 0)
+				break;
+		}
+	} else {
+		written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+	}
+
+	return written;
+}
+
 static int tracing_clock_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
@@ -9738,6 +9811,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	INIT_LIST_HEAD(&tr->events);
 	INIT_LIST_HEAD(&tr->hist_vars);
 	INIT_LIST_HEAD(&tr->err_log);
+	INIT_LIST_HEAD(&tr->marker_list);
 
 #ifdef CONFIG_MODULES
 	INIT_LIST_HEAD(&tr->mod_events);
@@ -9897,6 +9971,9 @@ static int __remove_instance(struct trace_array *tr)
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	if (update_marker_trace(tr, 0))
+		synchronize_rcu();
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
@@ -10965,6 +11042,7 @@ __init static int tracer_alloc_buffers(void)
 	INIT_LIST_HEAD(&global_trace.events);
 	INIT_LIST_HEAD(&global_trace.hist_vars);
 	INIT_LIST_HEAD(&global_trace.err_log);
+	list_add(&global_trace.marker_list, &marker_copies);
 	list_add(&global_trace.list, &ftrace_trace_arrays);
 
 	apply_trace_boot_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79be1995db44..a2639daea47b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -404,6 +404,7 @@ struct trace_array {
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
+	struct list_head	marker_list;
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	/* one per_cpu trace_pipe can be opened by only one user */
@@ -1368,6 +1369,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
+		C(COPY_MARKER,		"copy_trace_marker"),\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
-- 
2.47.2

