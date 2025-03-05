Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8732250C02;
	Wed,  5 Mar 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193171; cv=none; b=CC1g5x8XGbFZPSrJgTidFpG9doma/sEjHNMxeCj5rmY8LaErUXQl3TUlLs7dCAmJC4AKQfIwooj4hVaHrnH+cGIBUu6zNFEZ099LD+y7qDxOrrSZMF3rWOTi9iIaHbMfEu6NJkWEHx5gMmCYy1zGB4NDvFoLproUgLibZZs/jcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193171; c=relaxed/simple;
	bh=Cd5zdLCEQaa9/bZgFAliaUWRZrFJE32R0v2LGL4vKvc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i1V1qGnAi/4mHxXUCsbB6uCDfsj45jbmKrWimYZSYGeqVGbKL8EFdKenn0VV4uRiFJaXItCv8z3F6thGWuHu26wEJnBLBsFIY/wL5unT/yVvZE5reBf86hLtoNRg6b0nifWJAVpmXyRmR6P2GRqZnoIJ4xHhKzm0TtgLrHHjyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CCC4CEEE;
	Wed,  5 Mar 2025 16:46:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tprsn-0000000D0yR-2bsT;
	Wed, 05 Mar 2025 11:46:09 -0500
Message-ID: <20250305164609.469844721@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Mar 2025 11:45:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 8/8] tracing: Update modules to persistent instances when loaded
References: <20250305164539.379008535@goodmis.org>
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


