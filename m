Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075516DC28;
	Tue,  4 Mar 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051496; cv=none; b=nm7xulX+88H8AN4qDhGwlNv1OpQnQ62L+wLzYwLQQIOHAejTKE0HlYfUWYhVOQMT98AFMSvjkpQz7lRSuXkw3Mz+U9ZHLJQzNXJGg4UNakx1JMbBQ7BoENCgqlP3geHNmkt6xJiCJOwhRm6MPvMcRPLMHlExU51poKAk6HtSc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051496; c=relaxed/simple;
	bh=Q5sqZs7BJbSppMioYZ/1GK0rqmDLGX/vMRd80U2ET2k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iMdTWyIWv4+3G9OmEoiANZPLPGAct/LSk7+1eRViGi8t78khFc3opD5nQjyowduZZCu4pwlWHafBoRbNmo3zuCihaW2/27q3au9iFDNR8ExKzKbt0mLhIa/uvpVpGuPHlQIzBuyhpSc6wB5qjwwVEAAMnj7s63bYFzTLkBgJE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA2DC4CEEA;
	Tue,  4 Mar 2025 01:24:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpH2b-0000000CC8M-0N6l;
	Mon, 03 Mar 2025 20:25:49 -0500
Message-ID: <20250304012548.937340181@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Mar 2025 20:25:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 8/8] tracing: Update modules to persistent instances when loaded
References: <20250304012516.282694507@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a module is loaded and a persistent buffer is actively tracing, add
it to the list of modules in the persistent memory.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250215034405.414999988@goodmis.org

- Take the mutex outside of save_mod() to prevent deadlocks

 kernel/trace/trace.c        | 27 +++++++++++++++++++++++++
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c | 40 ++++++++++++++++++++++++++-----------
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e1f053ffe887..177a7d921ff6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10083,6 +10083,32 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
+static bool trace_array_active(struct trace_array *tr)
+{
+	if (tr->current_trace != &nop_trace)
+		return true;
+
+	/* 0 is no events, 1 is all disabled */
+	return trace_events_enabled(tr, NULL) > 1;
+}
+
+static void trace_module_record(struct module *mod)
+{
+	struct trace_array *tr;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		/* Update any persistent trace array that has already been started */
+		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
+		    TRACE_ARRAY_FL_BOOT) {
+			/* Only update if the trace array is active */
+			if (trace_array_active(tr)) {
+				guard(mutex)(&scratch_mutex);
+				save_mod(mod, tr);
+			}
+		}
+	}
+}
+
 static int trace_module_notify(struct notifier_block *self,
 			       unsigned long val, void *data)
 {
@@ -10091,6 +10117,7 @@ static int trace_module_notify(struct notifier_block *self,
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_evals(mod);
+		trace_module_record(mod);
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3a020fb82a34..90493220c362 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -786,6 +786,8 @@ extern void trace_find_cmdline(int pid, char comm[]);
 extern int trace_find_tgid(int pid);
 extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
+extern int trace_events_enabled(struct trace_array *tr, const char *system);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_update_tot_cnt;
 extern unsigned long ftrace_number_of_pages;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 513de9ceb80e..7b3ef1d26167 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1818,28 +1818,28 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
-static ssize_t
-system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
-		   loff_t *ppos)
+/*
+ * Returns:
+ *   0 : no events exist?
+ *   1 : all events are disabled
+ *   2 : all events are enabled
+ *   3 : some events are enabled and some are enabled
+ */
+int trace_events_enabled(struct trace_array *tr, const char *system)
 {
-	const char set_to_char[4] = { '?', '0', '1', 'X' };
-	struct trace_subsystem_dir *dir = filp->private_data;
-	struct event_subsystem *system = dir->subsystem;
 	struct trace_event_call *call;
 	struct trace_event_file *file;
-	struct trace_array *tr = dir->tr;
-	char buf[2];
 	int set = 0;
-	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
+
 	list_for_each_entry(file, &tr->events, list) {
 		call = file->event_call;
 		if ((call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
 		    !trace_event_name(call) || !call->class || !call->class->reg)
 			continue;
 
-		if (system && strcmp(call->class->system, system->name) != 0)
+		if (system && strcmp(call->class->system, system) != 0)
 			continue;
 
 		/*
@@ -1855,7 +1855,23 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		if (set == 3)
 			break;
 	}
-	mutex_unlock(&event_mutex);
+
+	return set;
+}
+
+static ssize_t
+system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
+		   loff_t *ppos)
+{
+	const char set_to_char[4] = { '?', '0', '1', 'X' };
+	struct trace_subsystem_dir *dir = filp->private_data;
+	struct event_subsystem *system = dir->subsystem;
+	struct trace_array *tr = dir->tr;
+	char buf[2];
+	int set;
+	int ret;
+
+	set = trace_events_enabled(tr, system ? system->name : NULL);
 
 	buf[0] = set_to_char[set];
 	buf[1] = '\n';
-- 
2.47.2


