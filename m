Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7928368293;
	Tue, 13 Jan 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287147; cv=none; b=hVi4DrrdEq9PVwMtUs1Cw4H8aBr33Gcpu1XAMsRM9gGCp/OGPy7PRuFe3nXA+AphB9dBvG8r2dor4kF3B75rxXFYUVXloI3E/lw1bd7wZkpEORDrOCRoA8doja9VUud2227WFgvvljV18qw/WLsaOKjpPV14QA09V0qE16bJWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287147; c=relaxed/simple;
	bh=bncNK7Qltck8QcsSoETmoz07dSIDF8+F5C3b/qE2ff0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ0EhAvWMFMGg695JvunXtTWsnT/XZ+TsBphrdY0BHbxGgq8ASq8NHaquKQgtEve1BWupX+zIvTs9qnUhkKk+MOpuCMc7+Y8eRD3D9es0RjxuvGlm17DFf/Yj/5f21DfNXC+slr/gk8VjKGzS4JmdisRdOG/VIhQuxZQJqVOmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5nDtWAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5nDtWAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E6C116C6;
	Tue, 13 Jan 2026 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768287147;
	bh=bncNK7Qltck8QcsSoETmoz07dSIDF8+F5C3b/qE2ff0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5nDtWAZAkFfXl77wItNk9gvD+Jj64d11ROQ/0X8p4Pgr1hu4mX4xj6OgAmC6XbMs
	 vMMMmFqKA1ZR8VVMw8y4ebXmdgxZyDNMpLnotugX8sHkwCqBu8+CeS6z3reCcpy6+p
	 iahJPc1h4MBSZvNcXFbKxDwu/tYTQDJwgtRDYAL0rYdM865TbjqgWYNyNuPjxXue2P
	 t0zirXPDF/U0EJNgU8dHWlayew6a96AFJ92cxHF7Hctw1YF3Tz6G9e0/a8pIGXbIoF
	 H9J2ccvz8jCvL73Kj7GDFBSN1WXntfe8NR/naVdMAbNeMuPIHAp3TrIrU4QSwf3Aqx
	 HBlSm21NO7Ujg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tracing: Make the backup instance readonly
Date: Tue, 13 Jan 2026 15:52:25 +0900
Message-ID:  <176828714479.2161268.8478865465803155432.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com>
References:  <176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com>
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

Since there is no reason to reuse the backup instance, make it
readonly. Note that only backup instances are readonly, because
other trace instances will be empty unless it is writable.
Only backup instances have copy entries from the original.

With this change, most of the trace control files are removed
from the backup instance, including eventfs enable/filter etc.

 # find /sys/kernel/tracing/instances/backup/events/ | wc -l
 4093
 # find /sys/kernel/tracing/instances/boot_map/events/ | wc -l
 9573

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Resuse the beginning part of event_entries for readonly files.
  - Remove readonly file_operations and checking readonly flag in
    each write operation.
 Changes in v2:
  - Use readonly file_operations to prohibit writing instead of
    checking flags in write() callbacks.
  - Remove writable files from eventfs.
---
 kernel/trace/trace.c        |  100 ++++++++++++++++++++++++++++++-------------
 kernel/trace/trace.h        |    8 +++
 kernel/trace/trace_boot.c   |    5 +-
 kernel/trace/trace_events.c |   68 ++++++++++++++++++-----------
 4 files changed, 122 insertions(+), 59 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 38f7a7a55c23..2589dac77519 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4888,6 +4888,9 @@ static int tracing_open(struct inode *inode, struct file *file)
 		int cpu = tracing_get_cpu(inode);
 		struct array_buffer *trace_buf = &tr->array_buffer;
 
+		if (trace_array_is_readonly(tr))
+			return -EPERM;
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 		if (tr->current_trace->print_max)
 			trace_buf = &tr->max_buffer;
@@ -5030,6 +5033,11 @@ static ssize_t
 tracing_write_stub(struct file *filp, const char __user *ubuf,
 		   size_t count, loff_t *ppos)
 {
+	struct trace_array *tr = file_inode(filp)->i_private;
+
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	return count;
 }
 
@@ -5130,6 +5138,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (count == 0 || count > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 
@@ -6413,6 +6424,9 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	size_t ret;
 	int err;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = cnt;
 
 	if (cnt > MAX_TRACER_SIZE)
@@ -7047,6 +7061,9 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -7800,6 +7817,9 @@ static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
 	const char *clockstr;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
@@ -9353,12 +9373,16 @@ static void
 tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 {
 	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
+	umode_t writable_mode = TRACE_MODE_WRITE;
 	struct dentry *d_cpu;
 	char cpu_dir[30]; /* 30 characters should be more than enough */
 
 	if (!d_percpu)
 		return;
 
+	if (trace_array_is_readonly(tr))
+		writable_mode = TRACE_MODE_READ;
+
 	snprintf(cpu_dir, 30, "cpu%ld", cpu);
 	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
 	if (!d_cpu) {
@@ -9371,7 +9395,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_pipe_fops);
 
 	/* per cpu trace */
-	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
+	trace_create_cpu_file("trace", writable_mode, d_cpu,
 				tr, cpu, &tracing_fops);
 
 	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
@@ -9581,7 +9605,6 @@ struct dentry *trace_create_file(const char *name,
 	return ret;
 }
 
-
 static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 {
 	struct dentry *d_tracer;
@@ -9811,6 +9834,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -9917,6 +9943,9 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	int pages;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -10597,47 +10626,61 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
+	umode_t writable_mode = TRACE_MODE_WRITE;
+	bool readonly = trace_array_is_readonly(tr);
 	int cpu;
 
+	if (readonly)
+		writable_mode = TRACE_MODE_READ;
+
 	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
-			tr, &show_traces_fops);
+			  tr, &show_traces_fops);
 
-	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
-			tr, &set_tracer_fops);
+	trace_create_file("current_tracer", writable_mode, d_tracer,
+			  tr, &set_tracer_fops);
 
-	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("tracing_cpumask", writable_mode, d_tracer,
 			  tr, &tracing_cpumask_fops);
 
+	/* Options are used for changing print-format even for readonly instance. */
 	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("trace", writable_mode, d_tracer,
 			  tr, &tracing_fops);
 
 	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_pipe_fops);
 
-	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("buffer_size_kb", writable_mode, d_tracer,
 			  tr, &tracing_entries_fops);
 
 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_total_entries_fops);
 
-	trace_create_file("free_buffer", 0200, d_tracer,
-			  tr, &tracing_free_buffer_fops);
+	if (!readonly) {
+		trace_create_file("free_buffer", 0200, d_tracer,
+				tr, &tracing_free_buffer_fops);
 
-	trace_create_file("trace_marker", 0220, d_tracer,
-			  tr, &tracing_mark_fops);
+		trace_create_file("trace_marker", 0220, d_tracer,
+				tr, &tracing_mark_fops);
 
-	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
+		tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
 
-	trace_create_file("trace_marker_raw", 0220, d_tracer,
-			  tr, &tracing_mark_raw_fops);
+		trace_create_file("trace_marker_raw", 0220, d_tracer,
+				tr, &tracing_mark_raw_fops);
 
-	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
+		trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
+				tr, &buffer_percent_fops);
+
+		trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
+				tr, &tracing_syscall_buf_fops);
+	}
+
+	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
 			  &trace_clock_fops);
 
-	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("tracing_on", writable_mode, d_tracer,
 			  tr, &rb_simple_fops);
 
 	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
@@ -10645,41 +10688,38 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
-			tr, &buffer_percent_fops);
-
-	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
 			  tr, &buffer_subbuf_size_fops);
 
-	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
-			 tr, &tracing_syscall_buf_fops);
-
 	create_trace_options_dir(tr);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	trace_create_maxlat_file(tr, d_tracer);
+	if (!readonly)
+		trace_create_maxlat_file(tr, d_tracer);
 #endif
 
-	if (ftrace_create_function_files(tr, d_tracer))
+	if (!readonly && ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
 	if (tr->range_addr_start) {
 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
 				  tr, &last_boot_fops);
 #ifdef CONFIG_TRACER_SNAPSHOT
-	} else {
+	} else if (!readonly) {
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
 #endif
 	}
 
-	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
-			  tr, &tracing_err_log_fops);
+	if (!readonly)
+		trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
+				  tr, &tracing_err_log_fops);
 
 	for_each_tracing_cpu(cpu)
 		tracing_init_tracefs_percpu(tr, cpu);
 
-	ftrace_init_tracefs(tr, d_tracer);
+	if (!readonly)
+		ftrace_init_tracefs(tr, d_tracer);
 }
 
 #ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..a098011951cc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -33,6 +33,7 @@
 
 #define TRACE_MODE_WRITE	0640
 #define TRACE_MODE_READ		0440
+#define TRACE_MODE_WRITE_MASK	(TRACE_MODE_WRITE & ~TRACE_MODE_READ)
 
 enum trace_type {
 	__TRACE_FIRST_TYPE = 0,
@@ -483,6 +484,12 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
 extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
 
+static inline bool trace_array_is_readonly(struct trace_array *tr)
+{
+	/* backup instance is read only. */
+	return tr->flags & TRACE_ARRAY_FL_VMALLOC;
+}
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
@@ -681,7 +688,6 @@ struct dentry *trace_create_file(const char *name,
 				 void *data,
 				 const struct file_operations *fops);
 
-
 /**
  * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
  * @tr : the trace array to know if ring buffer is enabled
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index dbe29b4c6a7a..2ca2541c8a58 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -61,7 +61,8 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 		v = memparse(p, NULL);
 		if (v < PAGE_SIZE)
 			pr_err("Buffer size is too small: %s\n", p);
-		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
+		if (trace_array_is_readonly(tr) ||
+		    tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
 			pr_err("Failed to resize trace buffer to %s\n", p);
 	}
 
@@ -597,7 +598,7 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 
 	p = xbc_node_find_value(node, "tracer", NULL);
 	if (p && *p != '\0') {
-		if (tracing_set_tracer(tr, p) < 0)
+		if (trace_array_is_readonly(tr) || tracing_set_tracer(tr, p) < 0)
 			pr_err("Failed to set given tracer: %s\n", p);
 	}
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9b07ad9eb284..5a9e03470b03 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1379,6 +1379,9 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 {
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	mutex_lock(&event_mutex);
 	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
 	mutex_unlock(&event_mutex);
@@ -2817,8 +2820,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	/* ftrace only has directories no files */
-	if (strcmp(name, "ftrace") == 0)
+	/* ftrace only has directories no files, readonly instance too. */
+	if (strcmp(name, "ftrace") == 0 || trace_array_is_readonly(tr))
 		nr_entries = 0;
 	else
 		nr_entries = ARRAY_SIZE(system_entries);
@@ -2983,28 +2986,30 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	int ret;
 	static struct eventfs_entry event_entries[] = {
 		{
-			.name		= "enable",
+			.name		= "format",
 			.callback	= event_callback,
-			.release	= event_release,
 		},
+#ifdef CONFIG_PERF_EVENTS
 		{
-			.name		= "filter",
+			.name		= "id",
 			.callback	= event_callback,
 		},
+#endif
+#define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS))
+/* Readonly files must be above this line and counted by NR_RO_EVENT_ENTRIES. */
 		{
-			.name		= "trigger",
+			.name		= "enable",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 		{
-			.name		= "format",
+			.name		= "filter",
 			.callback	= event_callback,
 		},
-#ifdef CONFIG_PERF_EVENTS
 		{
-			.name		= "id",
+			.name		= "trigger",
 			.callback	= event_callback,
 		},
-#endif
 #ifdef CONFIG_HIST_TRIGGERS
 		{
 			.name		= "hist",
@@ -3037,9 +3042,13 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	if (!e_events)
 		return -ENOMEM;
 
-	nr_entries = ARRAY_SIZE(event_entries);
+	if (trace_array_is_readonly(tr))
+		nr_entries = NR_RO_EVENT_ENTRIES;
+	else
+		nr_entries = ARRAY_SIZE(event_entries);
 
 	name = trace_event_name(call);
+
 	ei = eventfs_create_dir(name, e_events, event_entries, nr_entries, file);
 	if (IS_ERR(ei)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
@@ -4381,25 +4390,25 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	int nr_entries;
 	static struct eventfs_entry events_entries[] = {
 		{
-			.name		= "enable",
+			.name		= "header_page",
 			.callback	= events_callback,
 		},
 		{
-			.name		= "header_page",
+			.name		= "header_event",
 			.callback	= events_callback,
 		},
+#define NR_RO_TOP_ENTRIES	2
+/* Readonly files must be above this line and counted by NR_RO_TOP_ENTRIES. */
 		{
-			.name		= "header_event",
+			.name		= "enable",
 			.callback	= events_callback,
 		},
 	};
 
-	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
-				  tr, &ftrace_set_event_fops);
-	if (!entry)
-		return -ENOMEM;
-
-	nr_entries = ARRAY_SIZE(events_entries);
+	if (trace_array_is_readonly(tr))
+		nr_entries = NR_RO_TOP_ENTRIES;
+	else
+		nr_entries = ARRAY_SIZE(events_entries);
 
 	e_events = eventfs_create_events_dir("events", parent, events_entries,
 					     nr_entries, tr);
@@ -4408,15 +4417,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		return -ENOMEM;
 	}
 
-	/* There are not as crucial, just warn if they are not created */
+	if (!trace_array_is_readonly(tr)) {
 
-	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
-			  tr, &ftrace_set_event_pid_fops);
+		entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
+					tr, &ftrace_set_event_fops);
+		if (!entry)
+			return -ENOMEM;
+
+		/* There are not as crucial, just warn if they are not created */
 
-	trace_create_file("set_event_notrace_pid",
-			  TRACE_MODE_WRITE, parent, tr,
-			  &ftrace_set_event_notrace_pid_fops);
+		trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
+				tr, &ftrace_set_event_pid_fops);
 
+		trace_create_file("set_event_notrace_pid",
+				TRACE_MODE_WRITE, parent, tr,
+				&ftrace_set_event_notrace_pid_fops);
+	}
 	tr->event_dir = e_events;
 
 	return 0;

