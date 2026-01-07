Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BC329E50;
	Wed,  7 Jan 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797162; cv=none; b=OkUPMkUzI6NG7oU0m0TR65nJZBUJXhZm+YQWscNlJ56xrlS63AiD0cINJBb/tiaYkjRhwVN18O8OHuoX3PmkMEIIQp6Ohw1UnMxnEbyOik9jcCX9zx+yoSlWVp/LdQyIS7arzmBdHpEuiimhQxnb0y+Kh3r5bKNhdigkC/ay4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797162; c=relaxed/simple;
	bh=ILQXUKNpEe3BjjH3CX4Ik/HEyu15DTzkgyeIBNzl8ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvtP36HCMAWues0gjgmJnNJaCwWb1WE/fAsIfTmiIkO6dhvo0ZpGJsMddclwCZlB0574gNe2uZFNOhCeQ8CEOwIwZ+ZuBWUXkC7u5QglESWZ1ruIHuvCC4SofIUEFn4rFZenZMEj0ZSy+Vrjl0dybveYgCs38pa0dOHpjAQiEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMG1kumJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMG1kumJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1734DC4CEF1;
	Wed,  7 Jan 2026 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767797161;
	bh=ILQXUKNpEe3BjjH3CX4Ik/HEyu15DTzkgyeIBNzl8ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMG1kumJc6yi9KXy7/1xJY4Br5gQerjaOyam1LfbWvRJ0mlTQ+7jJVxmuDpbQtN/f
	 vjlgh7IHvL8pjXCPtq9C6emliTSunzFr0T2bcDqNhszloGCNOcNCCJqQz1uJvJ88V2
	 XQ3ThtD9150Yvf0TJd502YnAO5xGblkcXM8D8XkA2HryfZPyVGzz6Eh6BSfb+JNMSw
	 v+oC1LZm4vYvQfM0zcG2JIxTcLdrSTL/XTqlkNlaTk9ijNV9ZujUgbsfMbG+JzCKZv
	 BhfL0q1F5SX3JhRXGMWmHsdERy6C+erPzKH57U5E+ptyj9oESyWffk5t7YDsEEuRzB
	 XtzVlb+d9Zeyg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Make the backup instance readonly
Date: Wed,  7 Jan 2026 23:45:59 +0900
Message-ID:  <176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To:  <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
References:  <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
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

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |   91 ++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace.h        |    6 +++
 kernel/trace/trace_events.c |   14 +++++--
 3 files changed, 84 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 38f7a7a55c23..725930f5980e 100644
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
@@ -6077,6 +6080,9 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	guard(mutex)(&trace_types_lock);
 
 	if (cpu_id != RING_BUFFER_ALL_CPUS) {
@@ -6298,6 +6304,10 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	guard(mutex)(&trace_types_lock);
 
+	/* Not allowed to set new tracer on readonly instance. */
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	update_last_data(tr);
 
 	if (!tr->ring_buffer_expanded) {
@@ -6413,6 +6423,9 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	size_t ret;
 	int err;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = cnt;
 
 	if (cnt > MAX_TRACER_SIZE)
@@ -6478,6 +6491,9 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	guard(mutex)(&trace_types_lock);
 	ret = tracing_nsecs_write(&tracing_thresh, ubuf, cnt, ppos);
 	if (ret < 0)
@@ -7047,6 +7063,9 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -7595,6 +7614,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	unsigned long ip;
 	char *buf;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (tracing_disabled)
 		return -EINVAL;
 
@@ -7675,6 +7697,9 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	ssize_t written = -ENODEV;
 	char *buf;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	if (tracing_disabled)
 		return -EINVAL;
 
@@ -7757,6 +7782,9 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 {
 	int i;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	for (i = 0; i < ARRAY_SIZE(trace_clocks); i++) {
 		if (strcmp(trace_clocks[i].name, clockstr) == 0)
 			break;
@@ -9353,12 +9381,16 @@ static void
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
@@ -9371,7 +9403,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_pipe_fops);
 
 	/* per cpu trace */
-	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
+	trace_create_cpu_file("trace", writable_mode, d_cpu,
 				tr, cpu, &tracing_fops);
 
 	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
@@ -9811,6 +9843,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 	unsigned long val;
 	int ret;
 
+	if (trace_array_is_readonly(tr))
+		return -EPERM;
+
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
@@ -10597,47 +10632,54 @@ static __init void create_trace_instances(struct dentry *d_tracer)
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
+	trace_create_file("current_tracer", writable_mode, d_tracer,
 			tr, &set_tracer_fops);
 
-	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("tracing_cpumask", writable_mode, d_tracer,
 			  tr, &tracing_cpumask_fops);
 
-	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("trace_options", writable_mode, d_tracer,
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
+	}
 
-	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
+	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
 			  &trace_clock_fops);
 
-	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("tracing_on", writable_mode, d_tracer,
 			  tr, &rb_simple_fops);
 
 	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
@@ -10645,22 +10687,23 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("buffer_percent", writable_mode, d_tracer,
 			tr, &buffer_percent_fops);
 
-	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
 			  tr, &buffer_subbuf_size_fops);
 
-	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
+	trace_create_file("syscall_user_buf_size", writable_mode, d_tracer,
 			 tr, &tracing_syscall_buf_fops);
 
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
@@ -10673,13 +10716,15 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
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
index b6d42fe06115..bc0eeb2d1d07 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -483,6 +483,12 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
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
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9b07ad9eb284..f20f717f1ea9 100644
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
@@ -4376,6 +4379,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	umode_t writable_mode = TRACE_MODE_WRITE;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4393,9 +4397,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			.callback	= events_callback,
 		},
 	};
+	if (trace_array_is_readonly(tr))
+		writable_mode = TRACE_MODE_READ;
 
-	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
-				  tr, &ftrace_set_event_fops);
+	entry = trace_create_file("set_event", writable_mode, parent,
+				tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
@@ -4410,11 +4416,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	/* There are not as crucial, just warn if they are not created */
 
-	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
+	trace_create_file("set_event_pid", writable_mode, parent,
 			  tr, &ftrace_set_event_pid_fops);
 
 	trace_create_file("set_event_notrace_pid",
-			  TRACE_MODE_WRITE, parent, tr,
+			  writable_mode, parent, tr,
 			  &ftrace_set_event_notrace_pid_fops);
 
 	tr->event_dir = e_events;

