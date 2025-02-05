Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E521D59F;
	Wed,  5 Feb 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795824; cv=none; b=gdcFOBEwElrq4MR/vo91ZRuRfq2oi+rzDnfl5W2FOrvxWn+OFNvpP4n5cxgYwae3yZLS4UjEzrlWYIsAbVDRqqcqKYWjDou1VZ6MRm5F3+Cq0fwucjKlzXAsEN/OC/xyzAep3pvsazXALrytF1MwsNGvvc/cKUGj+6BUg95YBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795824; c=relaxed/simple;
	bh=Lsu5iZQzFu+2B0eBrtELwZKqmytJ22BtyklPdTBJ0Z0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tmQGCItNxWMcyI1vyZm/JXzCsy6ow/NU6zKHCXcEnYUmdtyui7CwaE/7q8EMTwJ1SH5dvxfMMOwDgz2Kxs2el/HMd4JcJTHwM4mw9/gmvULormssPeoh3OYlQOjYtNbi9M8cULvNxQELbvAWctSSgTaLcFvWqK932ZFu4eD1lqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7503C4CED1;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEa-00000007gX5-1j5K;
	Wed, 05 Feb 2025 17:51:04 -0500
Message-ID: <20250205225104.264333506@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/8] tracing: Update modules to persistent instances when loaded
References: <20250205225031.799739376@goodmis.org>
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
 kernel/trace/trace.c        | 25 +++++++++++++++++++++++
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c | 40 ++++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7b4027804cd4..443f2bc5b856 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10088,6 +10088,30 @@ static void trace_module_remove_evals(struct module *mod)
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
+			if (trace_array_active(tr))
+				save_mod(mod, tr);
+		}
+	}
+}
+
 static int trace_module_notify(struct notifier_block *self,
 			       unsigned long val, void *data)
 {
@@ -10096,6 +10120,7 @@ static int trace_module_notify(struct notifier_block *self,
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
index 4cb275316e51..107767afe0ab 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1811,28 +1811,28 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -1848,7 +1848,23 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
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
2.45.2


