Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A91F936;
	Sun,  1 Feb 2026 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916557; cv=none; b=FkKv+kHNXmKLYRAAWlU7uu7Mo2k9LnCWWLRwJzjLLpBwButntLA0PhQ8lJrk905b4rPdLZcAoLE9LMwSTLcKWL13yaQKLDGJhoCZnoioqtF9tAge/F2BJL9vdD8QIabCxN9v6JEj6Ojg+dwpeir6rTDmK7Qaa4HUrSdGJFl8iAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916557; c=relaxed/simple;
	bh=xvSFkVSSG0jW5eAJjXX09hvhPUJmHkArft8HRfGHAj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQYkwKpIA2KCph+3HfxKA2QZwnYUFsjzIGGj9+y5OuEReUZw5zslSAVW0H028lStLfprwZ4QI5H1BwyC1Sfh+HPWiwCPZemrSjOo9ypK957Nva2ZQmTOL1KU5xXs0PGzPdQm3aAe7pEoRSNHY/Unbf8uWi3v2GsO9xBKifNNC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzgOlb1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzgOlb1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765BBC4CEF7;
	Sun,  1 Feb 2026 03:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769916557;
	bh=xvSFkVSSG0jW5eAJjXX09hvhPUJmHkArft8HRfGHAj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzgOlb1PoptsDAgmTCXDnLD/cKBtPsw52ZOYBBv/l6Ry1VoEhcYz2HPEbCcDhE0dd
	 47Be1XRw4IXn+bjFZbhZ1TfbJCfUXzsJ/PYn+7EkcjQsx3FEBU9N0oF3Pz1UnNPbui
	 9E177pXKZEZb9fGWS9h5FXBgKEU4MYnqVdXRTK4A7wGoogm60oOE7hyUpOo3S8WFL1
	 OeyMmSjCslzFFifaXOrlaGMieP/Qsqf/LQa3CVUR+xOXCFyw8i042A97d1E8RgKfUa
	 7t125ubOPOoopKqrB4mlS2VHaGfAeP9nuQwAf8HVE8ESztWW7yY7h4uohkn64J0wOS
	 R40cFBmD3Of1g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Date: Sun,  1 Feb 2026 12:29:15 +0900
Message-ID:  <176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
References:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
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
readonly (but erasable).
Note that only backup instances are readonly, because
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
 Changes in v6:
   - Remove tracing_on file from readonly instances.
   - Remove unused writable_mode from tracing_init_tracefs_percpu().
   - Cleanup init_tracer_tracefs() and create_event_toplevel_files().
   - Remove TRACE_MODE_WRITE_MASK.
   - Add TRACE_ARRAY_FL_RDONLY.
 Changes in v5:
   - Rebased on the latest for-next (and hide show_event_filters/triggers
     if the instance is readonly.
 Changes in v4:
  - Make trace data erasable. (not reusable)
 Changes in v3:
  - Resuse the beginning part of event_entries for readonly files.
  - Remove readonly file_operations and checking readonly flag in
    each write operation.
 Changes in v2:
  - Use readonly file_operations to prohibit writing instead of
    checking flags in write() callbacks.
  - Remove writable files from eventfs.
---
 kernel/trace/trace.c        |   94 +++++++++++++++++++++++++++++--------------
 kernel/trace/trace.h        |    7 +++
 kernel/trace/trace_boot.c   |    5 +-
 kernel/trace/trace_events.c |   76 ++++++++++++++++++++---------------
 4 files changed, 117 insertions(+), 65 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5c3e4a554143..b0efcf1e0809 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5052,6 +5052,11 @@ static ssize_t
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
 
@@ -5152,6 +5157,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (count == 0 || count > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 
@@ -6436,6 +6444,9 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	size_t ret;
 	int err;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = cnt;
 
 	if (cnt > MAX_TRACER_SIZE)
@@ -7070,6 +7081,9 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -7824,6 +7838,9 @@ static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
 	const char *clockstr;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
@@ -9846,6 +9863,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -9952,6 +9972,9 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	int pages;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -10632,17 +10655,22 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
+	umode_t writable_mode = TRACE_MODE_WRITE;
 	int cpu;
 
+	if (trace_array_is_readonly(tr))
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
 
@@ -10652,12 +10680,36 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_pipe_fops);
 
-	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("buffer_size_kb", writable_mode, d_tracer,
 			  tr, &tracing_entries_fops);
 
 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_total_entries_fops);
 
+	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
+			  &trace_clock_fops);
+
+	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
+			  &trace_time_stamp_mode_fops);
+
+	tr->buffer_percent = 50;
+
+	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
+			  tr, &buffer_subbuf_size_fops);
+
+	create_trace_options_dir(tr);
+
+	if (tr->range_addr_start)
+		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
+				  tr, &last_boot_fops);
+
+	for_each_tracing_cpu(cpu)
+		tracing_init_tracefs_percpu(tr, cpu);
+
+	/* Read-only instance has above files only. */
+	if (trace_array_is_readonly(tr))
+		return;
+
 	trace_create_file("free_buffer", 0200, d_tracer,
 			  tr, &tracing_free_buffer_fops);
 
@@ -10669,27 +10721,14 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_marker_raw", 0220, d_tracer,
 			  tr, &tracing_mark_raw_fops);
 
-	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
-			  &trace_clock_fops);
-
-	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
-			  tr, &rb_simple_fops);
-
-	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
-			  &trace_time_stamp_mode_fops);
-
-	tr->buffer_percent = 50;
-
 	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
-			tr, &buffer_percent_fops);
-
-	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
-			  tr, &buffer_subbuf_size_fops);
+			  tr, &buffer_percent_fops);
 
 	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
-			 tr, &tracing_syscall_buf_fops);
+			  tr, &tracing_syscall_buf_fops);
 
-	create_trace_options_dir(tr);
+	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
+			  tr, &rb_simple_fops);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
@@ -10698,22 +10737,15 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
-	if (tr->range_addr_start) {
-		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
-				  tr, &last_boot_fops);
 #ifdef CONFIG_TRACER_SNAPSHOT
-	} else {
+	if (!tr->range_addr_start)
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
 #endif
-	}
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_err_log_fops);
 
-	for_each_tracing_cpu(cpu)
-		tracing_init_tracefs_percpu(tr, cpu);
-
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
@@ -11540,7 +11572,7 @@ __init static void enable_instances(void)
 		 * Backup buffers can be freed but need vfree().
 		 */
 		if (backup)
-			tr->flags |= TRACE_ARRAY_FL_VMALLOC;
+			tr->flags |= TRACE_ARRAY_FL_VMALLOC | TRACE_ARRAY_FL_RDONLY;
 
 		if (start || backup) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 69e7defba6c6..4ff7ebd8a32b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -455,6 +455,7 @@ enum {
 	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
 	TRACE_ARRAY_FL_MEMMAP		= BIT(4),
 	TRACE_ARRAY_FL_VMALLOC		= BIT(5),
+	TRACE_ARRAY_FL_RDONLY		= BIT(6),
 };
 
 #ifdef CONFIG_MODULES
@@ -483,6 +484,12 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
 extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
 
+static inline bool trace_array_is_readonly(struct trace_array *tr)
+{
+	/* backup instance is read only. */
+	return tr->flags & TRACE_ARRAY_FL_RDONLY;
+}
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
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
index 4972e1a2b5f3..16b9f222407c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1380,6 +1380,9 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 {
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	mutex_lock(&event_mutex);
 	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
 	mutex_unlock(&event_mutex);
@@ -2952,8 +2955,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	/* ftrace only has directories no files */
-	if (strcmp(name, "ftrace") == 0)
+	/* ftrace only has directories no files, readonly instance too. */
+	if (strcmp(name, "ftrace") == 0 || trace_array_is_readonly(tr))
 		nr_entries = 0;
 	else
 		nr_entries = ARRAY_SIZE(system_entries);
@@ -3118,28 +3121,30 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
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
@@ -3172,7 +3177,10 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	if (!e_events)
 		return -ENOMEM;
 
-	nr_entries = ARRAY_SIZE(event_entries);
+	if (trace_array_is_readonly(tr))
+		nr_entries = NR_RO_EVENT_ENTRIES;
+	else
+		nr_entries = ARRAY_SIZE(event_entries);
 
 	name = trace_event_name(call);
 	ei = eventfs_create_dir(name, e_events, event_entries, nr_entries, file);
@@ -4511,31 +4519,44 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
+	if (!trace_array_is_readonly(tr)) {
+		entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
+					tr, &ftrace_set_event_fops);
+		if (!entry)
+			return -ENOMEM;
 
-	trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
-			  &ftrace_show_event_filters_fops);
+		/* There are not as crucial, just warn if they are not created */
+		trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
+				&ftrace_show_event_filters_fops);
 
-	trace_create_file("show_event_triggers", TRACE_MODE_READ, parent, tr,
-			  &ftrace_show_event_triggers_fops);
+		trace_create_file("show_event_triggers", TRACE_MODE_READ, parent, tr,
+				&ftrace_show_event_triggers_fops);
 
-	nr_entries = ARRAY_SIZE(events_entries);
+		trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
+				tr, &ftrace_set_event_pid_fops);
+
+		trace_create_file("set_event_notrace_pid",
+				TRACE_MODE_WRITE, parent, tr,
+				&ftrace_set_event_notrace_pid_fops);
+		nr_entries = ARRAY_SIZE(events_entries);
+	} else {
+		nr_entries = NR_RO_TOP_ENTRIES;
+	}
 
 	e_events = eventfs_create_events_dir("events", parent, events_entries,
 					     nr_entries, tr);
@@ -4544,15 +4565,6 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		return -ENOMEM;
 	}
 
-	/* There are not as crucial, just warn if they are not created */
-
-	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
-			  tr, &ftrace_set_event_pid_fops);
-
-	trace_create_file("set_event_notrace_pid",
-			  TRACE_MODE_WRITE, parent, tr,
-			  &ftrace_set_event_notrace_pid_fops);
-
 	tr->event_dir = e_events;
 
 	return 0;

