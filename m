Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263347AF60;
	Thu,  8 Jan 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882187; cv=none; b=UZ2x0uyucuMsmQ5SxCP2t7vU4TyHup6CzrPcAabONI1Ee+pPkeCp+/Vipc5KsQu9RcGCIuvv7SbymIKNw0BB+QYAoPk7Z6NMa0EWgWbMENxiv9bTwOZcN6dGikltsyl+v2WhwV9d0hfG8fxC2I2vh1yGlMBOdU3li/l9+iQYl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882187; c=relaxed/simple;
	bh=JU48qQ4ep2c1+AkSPWBP9SDUbBp2sjZBhbd4s82yNaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bwbw/64uxUF5e2KQ52Jr3IAKh/IO3UTNLKMMP4tRtFnjGfJEe+0htl2KZdZy3GoRnxnfDw2ei7hL3OGCWXqVCAjrp620j/dBWbfN2tCoiy+TfFb59sI0aVjVUDpzveDExPndDrbd15Mx1wlrr+aTesibdKek7PS7YTJR/bDhFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjSs+rlc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjSs+rlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EC7C116C6;
	Thu,  8 Jan 2026 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767882185;
	bh=JU48qQ4ep2c1+AkSPWBP9SDUbBp2sjZBhbd4s82yNaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjSs+rlcguzE92nRwUcdKcPLyi4fgLocYz8FuFL/M3sxSNJmp1k6cq0ZFHpff7jKs
	 0V4CarGf4cFz/ngKCd1xhW5ddFiskFY9x+4e1oVKhreBWfOjIVES5GXiyz7Dch4hmc
	 G8wi0TtAP5pOQ4q2DRpgnSwmHS1/kOea8Sq/mhFk2QgEZOKxfWaa/qYD+Co9y6DDFT
	 oDf5eGpuzQr6bTAD3SA3Uw2hZGMx5fw9pudDbmCjPWoCMamwygKTWO/jjGQI0BjY49
	 JG6ehUPiz/wyW/jUGewzjyrs0R2D9nCHxKiXmHQ48VHR+jWSXZmpGB9vbTv9Yos3nI
	 GHd1xyGVglZUA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Make the backup instance readonly
Date: Thu,  8 Jan 2026 23:23:03 +0900
Message-ID:  <176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To:  <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
References:  <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v2:
  - Use readonly file_operations to prohibit writing instead of
    checking flags in write() callbacks.
  - Remove writable files from eventfs.
---
 kernel/trace/trace.c        |  163 ++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace.h        |   14 +++-
 kernel/trace/trace_boot.c   |    5 +
 kernel/trace/trace_events.c |   75 ++++++++++++++------
 4 files changed, 192 insertions(+), 65 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 38f7a7a55c23..1b87595413fe 100644
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
@@ -5055,6 +5058,15 @@ static const struct file_operations tracing_fops = {
 	.release	= tracing_release,
 };
 
+static const struct file_operations tracing_ro_fops = {
+	.open		= tracing_open,
+	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= copy_splice_read,
+	.llseek		= tracing_lseek,
+	.release	= tracing_release,
+};
+
 static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
 	.read		= seq_read,
@@ -5162,6 +5174,13 @@ static const struct file_operations tracing_cpumask_fops = {
 	.llseek		= generic_file_llseek,
 };
 
+static const struct file_operations tracing_cpumask_ro_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_cpumask_read,
+	.release	= tracing_release_generic_tr,
+	.llseek		= generic_file_llseek,
+};
+
 static int tracing_trace_options_show(struct seq_file *m, void *v)
 {
 	struct tracer_opt *trace_opts;
@@ -8106,6 +8125,13 @@ static const struct file_operations set_tracer_fops = {
 	.release	= tracing_release_generic_tr,
 };
 
+static const struct file_operations set_tracer_ro_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_set_trace_read,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+
 static const struct file_operations tracing_pipe_fops = {
 	.open		= tracing_open_pipe,
 	.poll		= tracing_poll_pipe,
@@ -8122,6 +8148,13 @@ static const struct file_operations tracing_entries_fops = {
 	.release	= tracing_release_generic_tr,
 };
 
+static const struct file_operations tracing_entries_ro_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_entries_read,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+
 static const struct file_operations tracing_syscall_buf_fops = {
 	.open		= tracing_open_generic_tr,
 	.read		= tracing_syscall_buf_read,
@@ -8170,6 +8203,13 @@ static const struct file_operations trace_clock_fops = {
 	.write		= tracing_clock_write,
 };
 
+static const struct file_operations trace_clock_ro_fops = {
+	.open		= tracing_clock_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= tracing_single_release_tr,
+};
+
 static const struct file_operations trace_time_stamp_mode_fops = {
 	.open		= tracing_time_stamp_mode_open,
 	.read		= seq_read,
@@ -9353,12 +9393,16 @@ static void
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
@@ -9371,7 +9415,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_pipe_fops);
 
 	/* per cpu trace */
-	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
+	trace_create_cpu_file("trace", writable_mode, d_cpu,
 				tr, cpu, &tracing_fops);
 
 	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
@@ -9566,21 +9610,31 @@ static const struct file_operations trace_options_core_fops = {
 	.llseek = generic_file_llseek,
 };
 
-struct dentry *trace_create_file(const char *name,
-				 umode_t mode,
-				 struct dentry *parent,
-				 void *data,
-				 const struct file_operations *fops)
+struct dentry *__trace_create_file(const char *name,
+				   umode_t mode,
+				   struct dentry *parent,
+				   void *data,
+				   const struct file_operations *fops,
+				   const struct file_operations *ro_fops)
 {
+	bool readonly = !!(mode & TRACE_MODE_WRITE_MASK);
 	struct dentry *ret;
 
-	ret = tracefs_create_file(name, mode, parent, data, fops);
+	ret = tracefs_create_file(name, mode, parent, data, readonly ? ro_fops : fops);
 	if (!ret)
 		pr_warn("Could not create tracefs '%s' entry\n", name);
 
 	return ret;
 }
 
+struct dentry *trace_create_file(const char *name,
+				 umode_t mode,
+				 struct dentry *parent,
+				 void *data,
+				 const struct file_operations *fops)
+{
+	return __trace_create_file(name, mode, parent, data, fops, fops);
+}
 
 static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 {
@@ -9811,6 +9865,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -9845,6 +9902,13 @@ static const struct file_operations rb_simple_fops = {
 	.llseek		= default_llseek,
 };
 
+static const struct file_operations rb_simple_ro_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= rb_simple_read,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 static ssize_t
 buffer_percent_read(struct file *filp, char __user *ubuf,
 		    size_t cnt, loff_t *ppos)
@@ -9986,6 +10050,13 @@ static const struct file_operations buffer_subbuf_size_fops = {
 	.llseek		= default_llseek,
 };
 
+static const struct file_operations buffer_subbuf_size_ro_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_subbuf_size_read,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 static struct dentry *trace_instance_dir;
 
 static void
@@ -10597,89 +10668,101 @@ static __init void create_trace_instances(struct dentry *d_tracer)
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
 			tr, &show_traces_fops);
 
-	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
-			tr, &set_tracer_fops);
+	__trace_create_file("current_tracer", writable_mode, d_tracer,
+			    tr, &set_tracer_fops, &set_tracer_ro_fops);
 
-	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
-			  tr, &tracing_cpumask_fops);
+	__trace_create_file("tracing_cpumask", writable_mode, d_tracer,
+			    tr, &tracing_cpumask_fops, &tracing_cpumask_ro_fops);
 
+	/* Options are used for changing print-format even for readonly instance. */
 	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_iter_fops);
 
-	trace_create_file("trace", TRACE_MODE_WRITE, d_tracer,
-			  tr, &tracing_fops);
+	__trace_create_file("trace", writable_mode, d_tracer,
+			    tr, &tracing_fops, &tracing_ro_fops);
 
 	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_pipe_fops);
 
-	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
-			  tr, &tracing_entries_fops);
+	__trace_create_file("buffer_size_kb", writable_mode, d_tracer,
+			    tr, &tracing_entries_fops, &tracing_entries_ro_fops);
 
 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
 			  tr, &tracing_total_entries_fops);
 
-	trace_create_file("free_buffer", 0200, d_tracer,
-			  tr, &tracing_free_buffer_fops);
+	if (!readonly) {
+		trace_create_file("free_buffer", 0200, d_tracer,
+				tr, &tracing_free_buffer_fops);
+
+		trace_create_file("trace_marker", 0220, d_tracer,
+				tr, &tracing_mark_fops);
+
+		tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
 
-	trace_create_file("trace_marker", 0220, d_tracer,
-			  tr, &tracing_mark_fops);
+		trace_create_file("trace_marker_raw", 0220, d_tracer,
+				tr, &tracing_mark_raw_fops);
 
-	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
+		trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
+				tr, &buffer_percent_fops);
 
-	trace_create_file("trace_marker_raw", 0220, d_tracer,
-			  tr, &tracing_mark_raw_fops);
+		trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
+				tr, &tracing_syscall_buf_fops);
+	}
 
-	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
-			  &trace_clock_fops);
+	__trace_create_file("trace_clock", writable_mode, d_tracer, tr,
+			    &trace_clock_fops, &trace_clock_ro_fops);
 
-	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
-			  tr, &rb_simple_fops);
+	__trace_create_file("tracing_on", writable_mode, d_tracer,
+			    tr, &rb_simple_fops, &rb_simple_ro_fops);
 
 	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
 			  &trace_time_stamp_mode_fops);
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
-			tr, &buffer_percent_fops);
-
-	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
-			  tr, &buffer_subbuf_size_fops);
-
-	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
-			 tr, &tracing_syscall_buf_fops);
+	__trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
+			    tr, &buffer_subbuf_size_fops,
+			    &buffer_subbuf_size_ro_fops);
 
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
index b6d42fe06115..4fae5cf1182c 100644
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
@@ -680,7 +687,12 @@ struct dentry *trace_create_file(const char *name,
 				 struct dentry *parent,
 				 void *data,
 				 const struct file_operations *fops);
-
+struct dentry *__trace_create_file(const char *name,
+				   umode_t mode,
+				   struct dentry *parent,
+				   void *data,
+				   const struct file_operations *fops,
+				   const struct file_operations *ro_fops);
 
 /**
  * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
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
index 9b07ad9eb284..741b16b54d90 100644
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
@@ -2979,7 +2982,6 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	struct eventfs_inode *e_events;
 	struct eventfs_inode *ei;
 	const char *name;
-	int nr_entries;
 	int ret;
 	static struct eventfs_entry event_entries[] = {
 		{
@@ -3024,6 +3026,18 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		},
 #endif
 	};
+	static struct eventfs_entry event_ro_entries[] = {
+		{
+			.name		= "format",
+			.callback	= event_callback,
+		},
+#ifdef CONFIG_PERF_EVENTS
+		{
+			.name		= "id",
+			.callback	= event_callback,
+		},
+#endif
+	};
 
 	/*
 	 * If the trace point header did not define TRACE_SYSTEM
@@ -3037,10 +3051,14 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	if (!e_events)
 		return -ENOMEM;
 
-	nr_entries = ARRAY_SIZE(event_entries);
-
 	name = trace_event_name(call);
-	ei = eventfs_create_dir(name, e_events, event_entries, nr_entries, file);
+
+	if (trace_array_is_readonly(tr))
+		ei = eventfs_create_dir(name, e_events, event_ro_entries,
+					ARRAY_SIZE(event_ro_entries), file);
+	else
+		ei = eventfs_create_dir(name, e_events, event_entries,
+					ARRAY_SIZE(event_entries), file);
 	if (IS_ERR(ei)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
@@ -4378,7 +4396,6 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
-	int nr_entries;
 	static struct eventfs_entry events_entries[] = {
 		{
 			.name		= "enable",
@@ -4393,30 +4410,44 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			.callback	= events_callback,
 		},
 	};
+	static struct eventfs_entry events_ro_entries[] = {
+		{
+			.name		= "header_page",
+			.callback	= events_callback,
+		},
+		{
+			.name		= "header_event",
+			.callback	= events_callback,
+		},
+	};
 
-	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
-				  tr, &ftrace_set_event_fops);
-	if (!entry)
-		return -ENOMEM;
-
-	nr_entries = ARRAY_SIZE(events_entries);
-
-	e_events = eventfs_create_events_dir("events", parent, events_entries,
-					     nr_entries, tr);
+	if (trace_array_is_readonly(tr))
+		e_events = eventfs_create_events_dir("events", parent, events_ro_entries,
+						ARRAY_SIZE(events_ro_entries), tr);
+	else
+		e_events = eventfs_create_events_dir("events", parent, events_entries,
+						ARRAY_SIZE(events_entries), tr);
 	if (IS_ERR(e_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
 	}
 
-	/* There are not as crucial, just warn if they are not created */
+	if (!trace_array_is_readonly(tr)) {
+
+		entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
+					tr, &ftrace_set_event_fops);
+		if (!entry)
+			return -ENOMEM;
 
-	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
-			  tr, &ftrace_set_event_pid_fops);
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

