Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BD33ADBC;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407937; cv=none; b=sd4PoFgSsC/M7aC727Bu4GMH4cFZD+0vap4GDcjb5zl/bduchKZO82dVVMI3Sosto/gB2pLXculzKal2AOan6z4bDlzjY2K6NzxoecP5FnyAHyysHhX9otnpgLWf221mvS0d1E7xj+rQKEzovXMgFav/IPI9UbsjsqVdbtUwXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407937; c=relaxed/simple;
	bh=hSgbbJT6hyzYJ+D57J2CLYyG0AzYk0jawhezmkHSop4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MZ0KlOYizrtXvPD13F21f1N6gxYZ57/IpUpHEAIKdgmfyhTpLVBM6ftmsW3tOoUllv/rY2IZANWYEirjP3Ey/mPBlqgkPMXynjam4DsgJSy/kiXQlTKt1JhuqxQu57wXf0oS0rB8j7iGK6DLszGkdlvaZMo37JZF3NhJuMsqdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9ZRwR6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9ZRwR6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D062C19423;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407937;
	bh=hSgbbJT6hyzYJ+D57J2CLYyG0AzYk0jawhezmkHSop4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=g9ZRwR6+8Yky3Y3ikYJoOtmOUCExH1sxGNW3tgjSR3E4HOTThfOgn3kBXFU3zw8XM
	 mx4AGjtDLCAZHrLf49eNDSada3RgChV+rzW4LDH35y0RVlGUAM89DlD6EUso7Nj2uz
	 mTCer/5KhX3sINYqyQyQBZlxll6xvxwMR8mFjh9MBKkxToRE4u0b1NN+SrHTmA1aX8
	 5MIBNp757llf+VBjpMEYQfOMJGiWkBg44JW3HSGUxJYDbyvVGNb1EShpNS4GAEgWz4
	 OTTpdUeitcFN5y43AFoP/+h1oFbgEMm3j25PvqETrH9CVSUVHMLqxt2wS8oKWclwBR
	 l6/g987PWIaug==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzM-0000000A6qj-2VAh;
	Fri, 06 Feb 2026 14:59:36 -0500
Message-ID: <20260206195936.452815257@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:51 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 10/12] tracing: Move pid filtering into trace_pid.c
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace.c file was a dumping ground for most tracing code. Start
organizing it better by moving various functions out into their own files.
Move the PID filtering functions from trace.c into its own trace_pid.c
file.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Makefile    |   1 +
 kernel/trace/trace.c     | 242 --------------------------------------
 kernel/trace/trace_pid.c | 246 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 242 deletions(-)
 create mode 100644 kernel/trace/trace_pid.c

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index fc5dcc888e13..04096c21d06b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_TRACING) += trace_output.o
 obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
+obj-$(CONFIG_TRACING) += trace_pid.o
 obj-$(CONFIG_TRACING) += 	pid_list.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f62bbe7d093f..6a0cea7e63b0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -637,248 +637,6 @@ int tracing_check_open_get_tr(struct trace_array *tr)
 	return 0;
 }
 
-/**
- * trace_find_filtered_pid - check if a pid exists in a filtered_pid list
- * @filtered_pids: The list of pids to check
- * @search_pid: The PID to find in @filtered_pids
- *
- * Returns true if @search_pid is found in @filtered_pids, and false otherwise.
- */
-bool
-trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
-{
-	return trace_pid_list_is_set(filtered_pids, search_pid);
-}
-
-/**
- * trace_ignore_this_task - should a task be ignored for tracing
- * @filtered_pids: The list of pids to check
- * @filtered_no_pids: The list of pids not to be traced
- * @task: The task that should be ignored if not filtered
- *
- * Checks if @task should be traced or not from @filtered_pids.
- * Returns true if @task should *NOT* be traced.
- * Returns false if @task should be traced.
- */
-bool
-trace_ignore_this_task(struct trace_pid_list *filtered_pids,
-		       struct trace_pid_list *filtered_no_pids,
-		       struct task_struct *task)
-{
-	/*
-	 * If filtered_no_pids is not empty, and the task's pid is listed
-	 * in filtered_no_pids, then return true.
-	 * Otherwise, if filtered_pids is empty, that means we can
-	 * trace all tasks. If it has content, then only trace pids
-	 * within filtered_pids.
-	 */
-
-	return (filtered_pids &&
-		!trace_find_filtered_pid(filtered_pids, task->pid)) ||
-		(filtered_no_pids &&
-		 trace_find_filtered_pid(filtered_no_pids, task->pid));
-}
-
-/**
- * trace_filter_add_remove_task - Add or remove a task from a pid_list
- * @pid_list: The list to modify
- * @self: The current task for fork or NULL for exit
- * @task: The task to add or remove
- *
- * If adding a task, if @self is defined, the task is only added if @self
- * is also included in @pid_list. This happens on fork and tasks should
- * only be added when the parent is listed. If @self is NULL, then the
- * @task pid will be removed from the list, which would happen on exit
- * of a task.
- */
-void trace_filter_add_remove_task(struct trace_pid_list *pid_list,
-				  struct task_struct *self,
-				  struct task_struct *task)
-{
-	if (!pid_list)
-		return;
-
-	/* For forks, we only add if the forking task is listed */
-	if (self) {
-		if (!trace_find_filtered_pid(pid_list, self->pid))
-			return;
-	}
-
-	/* "self" is set for forks, and NULL for exits */
-	if (self)
-		trace_pid_list_set(pid_list, task->pid);
-	else
-		trace_pid_list_clear(pid_list, task->pid);
-}
-
-/**
- * trace_pid_next - Used for seq_file to get to the next pid of a pid_list
- * @pid_list: The pid list to show
- * @v: The last pid that was shown (+1 the actual pid to let zero be displayed)
- * @pos: The position of the file
- *
- * This is used by the seq_file "next" operation to iterate the pids
- * listed in a trace_pid_list structure.
- *
- * Returns the pid+1 as we want to display pid of zero, but NULL would
- * stop the iteration.
- */
-void *trace_pid_next(struct trace_pid_list *pid_list, void *v, loff_t *pos)
-{
-	long pid = (unsigned long)v;
-	unsigned int next;
-
-	(*pos)++;
-
-	/* pid already is +1 of the actual previous bit */
-	if (trace_pid_list_next(pid_list, pid, &next) < 0)
-		return NULL;
-
-	pid = next;
-
-	/* Return pid + 1 to allow zero to be represented */
-	return (void *)(pid + 1);
-}
-
-/**
- * trace_pid_start - Used for seq_file to start reading pid lists
- * @pid_list: The pid list to show
- * @pos: The position of the file
- *
- * This is used by seq_file "start" operation to start the iteration
- * of listing pids.
- *
- * Returns the pid+1 as we want to display pid of zero, but NULL would
- * stop the iteration.
- */
-void *trace_pid_start(struct trace_pid_list *pid_list, loff_t *pos)
-{
-	unsigned long pid;
-	unsigned int first;
-	loff_t l = 0;
-
-	if (trace_pid_list_first(pid_list, &first) < 0)
-		return NULL;
-
-	pid = first;
-
-	/* Return pid + 1 so that zero can be the exit value */
-	for (pid++; pid && l < *pos;
-	     pid = (unsigned long)trace_pid_next(pid_list, (void *)pid, &l))
-		;
-	return (void *)pid;
-}
-
-/**
- * trace_pid_show - show the current pid in seq_file processing
- * @m: The seq_file structure to write into
- * @v: A void pointer of the pid (+1) value to display
- *
- * Can be directly used by seq_file operations to display the current
- * pid value.
- */
-int trace_pid_show(struct seq_file *m, void *v)
-{
-	unsigned long pid = (unsigned long)v - 1;
-
-	seq_printf(m, "%lu\n", pid);
-	return 0;
-}
-
-/* 128 should be much more than enough */
-#define PID_BUF_SIZE		127
-
-int trace_pid_write(struct trace_pid_list *filtered_pids,
-		    struct trace_pid_list **new_pid_list,
-		    const char __user *ubuf, size_t cnt)
-{
-	struct trace_pid_list *pid_list;
-	struct trace_parser parser;
-	unsigned long val;
-	int nr_pids = 0;
-	ssize_t read = 0;
-	ssize_t ret;
-	loff_t pos;
-	pid_t pid;
-
-	if (trace_parser_get_init(&parser, PID_BUF_SIZE + 1))
-		return -ENOMEM;
-
-	/*
-	 * Always recreate a new array. The write is an all or nothing
-	 * operation. Always create a new array when adding new pids by
-	 * the user. If the operation fails, then the current list is
-	 * not modified.
-	 */
-	pid_list = trace_pid_list_alloc();
-	if (!pid_list) {
-		trace_parser_put(&parser);
-		return -ENOMEM;
-	}
-
-	if (filtered_pids) {
-		/* copy the current bits to the new max */
-		ret = trace_pid_list_first(filtered_pids, &pid);
-		while (!ret) {
-			ret = trace_pid_list_set(pid_list, pid);
-			if (ret < 0)
-				goto out;
-
-			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
-			nr_pids++;
-		}
-	}
-
-	ret = 0;
-	while (cnt > 0) {
-
-		pos = 0;
-
-		ret = trace_get_user(&parser, ubuf, cnt, &pos);
-		if (ret < 0)
-			break;
-
-		read += ret;
-		ubuf += ret;
-		cnt -= ret;
-
-		if (!trace_parser_loaded(&parser))
-			break;
-
-		ret = -EINVAL;
-		if (kstrtoul(parser.buffer, 0, &val))
-			break;
-
-		pid = (pid_t)val;
-
-		if (trace_pid_list_set(pid_list, pid) < 0) {
-			ret = -1;
-			break;
-		}
-		nr_pids++;
-
-		trace_parser_clear(&parser);
-		ret = 0;
-	}
- out:
-	trace_parser_put(&parser);
-
-	if (ret < 0) {
-		trace_pid_list_free(pid_list);
-		return ret;
-	}
-
-	if (!nr_pids) {
-		/* Cleared the list of pids */
-		trace_pid_list_free(pid_list);
-		pid_list = NULL;
-	}
-
-	*new_pid_list = pid_list;
-
-	return read;
-}
-
 static u64 buffer_ftrace_now(struct array_buffer *buf, int cpu)
 {
 	u64 ts;
diff --git a/kernel/trace/trace_pid.c b/kernel/trace/trace_pid.c
new file mode 100644
index 000000000000..7127c8de4174
--- /dev/null
+++ b/kernel/trace/trace_pid.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "trace.h"
+
+/**
+ * trace_find_filtered_pid - check if a pid exists in a filtered_pid list
+ * @filtered_pids: The list of pids to check
+ * @search_pid: The PID to find in @filtered_pids
+ *
+ * Returns true if @search_pid is found in @filtered_pids, and false otherwise.
+ */
+bool
+trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
+{
+	return trace_pid_list_is_set(filtered_pids, search_pid);
+}
+
+/**
+ * trace_ignore_this_task - should a task be ignored for tracing
+ * @filtered_pids: The list of pids to check
+ * @filtered_no_pids: The list of pids not to be traced
+ * @task: The task that should be ignored if not filtered
+ *
+ * Checks if @task should be traced or not from @filtered_pids.
+ * Returns true if @task should *NOT* be traced.
+ * Returns false if @task should be traced.
+ */
+bool
+trace_ignore_this_task(struct trace_pid_list *filtered_pids,
+		       struct trace_pid_list *filtered_no_pids,
+		       struct task_struct *task)
+{
+	/*
+	 * If filtered_no_pids is not empty, and the task's pid is listed
+	 * in filtered_no_pids, then return true.
+	 * Otherwise, if filtered_pids is empty, that means we can
+	 * trace all tasks. If it has content, then only trace pids
+	 * within filtered_pids.
+	 */
+
+	return (filtered_pids &&
+		!trace_find_filtered_pid(filtered_pids, task->pid)) ||
+		(filtered_no_pids &&
+		 trace_find_filtered_pid(filtered_no_pids, task->pid));
+}
+
+/**
+ * trace_filter_add_remove_task - Add or remove a task from a pid_list
+ * @pid_list: The list to modify
+ * @self: The current task for fork or NULL for exit
+ * @task: The task to add or remove
+ *
+ * If adding a task, if @self is defined, the task is only added if @self
+ * is also included in @pid_list. This happens on fork and tasks should
+ * only be added when the parent is listed. If @self is NULL, then the
+ * @task pid will be removed from the list, which would happen on exit
+ * of a task.
+ */
+void trace_filter_add_remove_task(struct trace_pid_list *pid_list,
+				  struct task_struct *self,
+				  struct task_struct *task)
+{
+	if (!pid_list)
+		return;
+
+	/* For forks, we only add if the forking task is listed */
+	if (self) {
+		if (!trace_find_filtered_pid(pid_list, self->pid))
+			return;
+	}
+
+	/* "self" is set for forks, and NULL for exits */
+	if (self)
+		trace_pid_list_set(pid_list, task->pid);
+	else
+		trace_pid_list_clear(pid_list, task->pid);
+}
+
+/**
+ * trace_pid_next - Used for seq_file to get to the next pid of a pid_list
+ * @pid_list: The pid list to show
+ * @v: The last pid that was shown (+1 the actual pid to let zero be displayed)
+ * @pos: The position of the file
+ *
+ * This is used by the seq_file "next" operation to iterate the pids
+ * listed in a trace_pid_list structure.
+ *
+ * Returns the pid+1 as we want to display pid of zero, but NULL would
+ * stop the iteration.
+ */
+void *trace_pid_next(struct trace_pid_list *pid_list, void *v, loff_t *pos)
+{
+	long pid = (unsigned long)v;
+	unsigned int next;
+
+	(*pos)++;
+
+	/* pid already is +1 of the actual previous bit */
+	if (trace_pid_list_next(pid_list, pid, &next) < 0)
+		return NULL;
+
+	pid = next;
+
+	/* Return pid + 1 to allow zero to be represented */
+	return (void *)(pid + 1);
+}
+
+/**
+ * trace_pid_start - Used for seq_file to start reading pid lists
+ * @pid_list: The pid list to show
+ * @pos: The position of the file
+ *
+ * This is used by seq_file "start" operation to start the iteration
+ * of listing pids.
+ *
+ * Returns the pid+1 as we want to display pid of zero, but NULL would
+ * stop the iteration.
+ */
+void *trace_pid_start(struct trace_pid_list *pid_list, loff_t *pos)
+{
+	unsigned long pid;
+	unsigned int first;
+	loff_t l = 0;
+
+	if (trace_pid_list_first(pid_list, &first) < 0)
+		return NULL;
+
+	pid = first;
+
+	/* Return pid + 1 so that zero can be the exit value */
+	for (pid++; pid && l < *pos;
+	     pid = (unsigned long)trace_pid_next(pid_list, (void *)pid, &l))
+		;
+	return (void *)pid;
+}
+
+/**
+ * trace_pid_show - show the current pid in seq_file processing
+ * @m: The seq_file structure to write into
+ * @v: A void pointer of the pid (+1) value to display
+ *
+ * Can be directly used by seq_file operations to display the current
+ * pid value.
+ */
+int trace_pid_show(struct seq_file *m, void *v)
+{
+	unsigned long pid = (unsigned long)v - 1;
+
+	seq_printf(m, "%lu\n", pid);
+	return 0;
+}
+
+/* 128 should be much more than enough */
+#define PID_BUF_SIZE		127
+
+int trace_pid_write(struct trace_pid_list *filtered_pids,
+		    struct trace_pid_list **new_pid_list,
+		    const char __user *ubuf, size_t cnt)
+{
+	struct trace_pid_list *pid_list;
+	struct trace_parser parser;
+	unsigned long val;
+	int nr_pids = 0;
+	ssize_t read = 0;
+	ssize_t ret;
+	loff_t pos;
+	pid_t pid;
+
+	if (trace_parser_get_init(&parser, PID_BUF_SIZE + 1))
+		return -ENOMEM;
+
+	/*
+	 * Always recreate a new array. The write is an all or nothing
+	 * operation. Always create a new array when adding new pids by
+	 * the user. If the operation fails, then the current list is
+	 * not modified.
+	 */
+	pid_list = trace_pid_list_alloc();
+	if (!pid_list) {
+		trace_parser_put(&parser);
+		return -ENOMEM;
+	}
+
+	if (filtered_pids) {
+		/* copy the current bits to the new max */
+		ret = trace_pid_list_first(filtered_pids, &pid);
+		while (!ret) {
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
+			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
+			nr_pids++;
+		}
+	}
+
+	ret = 0;
+	while (cnt > 0) {
+
+		pos = 0;
+
+		ret = trace_get_user(&parser, ubuf, cnt, &pos);
+		if (ret < 0)
+			break;
+
+		read += ret;
+		ubuf += ret;
+		cnt -= ret;
+
+		if (!trace_parser_loaded(&parser))
+			break;
+
+		ret = -EINVAL;
+		if (kstrtoul(parser.buffer, 0, &val))
+			break;
+
+		pid = (pid_t)val;
+
+		if (trace_pid_list_set(pid_list, pid) < 0) {
+			ret = -1;
+			break;
+		}
+		nr_pids++;
+
+		trace_parser_clear(&parser);
+		ret = 0;
+	}
+ out:
+	trace_parser_put(&parser);
+
+	if (ret < 0) {
+		trace_pid_list_free(pid_list);
+		return ret;
+	}
+
+	if (!nr_pids) {
+		/* Cleared the list of pids */
+		trace_pid_list_free(pid_list);
+		pid_list = NULL;
+	}
+
+	*new_pid_list = pid_list;
+
+	return read;
+}
+
-- 
2.51.0


