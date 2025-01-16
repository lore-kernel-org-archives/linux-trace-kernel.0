Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852F22F3B4;
	Thu, 16 Jan 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068307; cv=none; b=KbJMJWjVrmLlWyLbRGqtsHkyiMbz0x0r3rZRP9RnmwaVP9/QicrSAfoffNQuMJFlKQSQyiobOeFKBhPWVVbQIuhkGeL3ZyVGMb7Py3PsUFNyUf5Dyxg4DEBh1V1IcIBHvXrDUrHwFMP7dp/e20HTkUyK5ICKPLwd+paU3EdmVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068307; c=relaxed/simple;
	bh=UsGnN1xx1BCAA7Wl8N0zPey32Atb1Hor7uDXdvQXlqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oJJyWf17pC7fZuTjpocNWxJeti7wTCLpP1tzPw0PI9ZbOmjCB8PiODYWmLibFAwzFayil+ZKjvivn8+eAgvxpi/tkohcL1A6TMF7ZM7Mq7gIZnfOUhHeqCywjH5E0jCCCrE4aEhb3O1Eua43hcXA/i3NwN1aOZ5QFcJZ0ZyTj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65653C4CED6;
	Thu, 16 Jan 2025 22:58:26 +0000 (UTC)
Date: Thu, 16 Jan 2025 17:58:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 jochensp@jochen.sprickerhof.de, peter.griffin@linaro.org
Subject: [PATCH v2] ftrace: Implement :mod: cache filtering on kernel
 command line
Message-ID: <20250116175832.34e39779@gandalf.local.home>
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

Module functions can be set to set_ftrace_filter before the module is
loaded.

  # echo :mod:snd_hda_intel > set_ftrace_filter

This will enable all the functions for the module snd_hda_intel. If that
module is not loaded, it is "cached" in the trace array for when the
module is loaded, its functions will be traced.

But this is not implemented in the kernel command line. That's because the
kernel command line filtering is added very early in boot up as it is
needed to be done before boot time function tracing can start, which is
also available very early in boot up. The code used by the
"set_ftrace_filter" file can not be used that early as it depends on some
other initialization to occur first. But some of the functions can.

Implement the ":mod:" feature of "set_ftrace_filter" in the kernel command
line parsing. Now function tracing on just a single module that is loaded
at boot up can be done.

Adding:

 ftrace=function ftrace_filter=:mod:sna_hda_intel

To the kernel command line will only enable the sna_hda_intel module
functions when the module is loaded, and it will start tracing.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250109174639.32e6f43a@gandalf.local.home

- Fixed a few minor bugs reported by the kernel test robot.

 kernel/trace/ftrace.c | 67 +++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c  |  8 ++++++
 kernel/trace/trace.h  |  2 ++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f054343be026..9387e2865ca8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4968,10 +4968,6 @@ static int cache_mod(struct trace_array *tr,
 	return ftrace_add_mod(tr, func, module, enable);
 }
 
-static int
-ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
-		 int reset, int enable);
-
 #ifdef CONFIG_MODULES
 static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 			     char *mod, bool enable)
@@ -5761,7 +5757,7 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long *ips,
 static int
 ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 		unsigned long *ips, unsigned int cnt,
-		int remove, int reset, int enable)
+		int remove, int reset, int enable, char *mod)
 {
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *hash;
@@ -5787,7 +5783,15 @@ ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 		goto out_regex_unlock;
 	}
 
-	if (buf && !ftrace_match_records(hash, buf, len)) {
+	if (buf && !match_records(hash, buf, len, mod)) {
+		/* If this was for a module and nothing was enabled, flag it */
+		if (mod)
+			(*orig_hash)->flags |= FTRACE_HASH_FL_MOD;
+
+		/*
+		 * Even if it is a mod, return error to let caller know
+		 * nothing was added
+		 */
 		ret = -EINVAL;
 		goto out_regex_unlock;
 	}
@@ -5812,7 +5816,7 @@ static int
 ftrace_set_addr(struct ftrace_ops *ops, unsigned long *ips, unsigned int cnt,
 		int remove, int reset, int enable)
 {
-	return ftrace_set_hash(ops, NULL, 0, ips, cnt, remove, reset, enable);
+	return ftrace_set_hash(ops, NULL, 0, ips, cnt, remove, reset, enable, NULL);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
@@ -6190,7 +6194,38 @@ static int
 ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 		 int reset, int enable)
 {
-	return ftrace_set_hash(ops, buf, len, NULL, 0, 0, reset, enable);
+	char *mod = NULL, *func, *command, *next = buf;
+	char *tmp __free(kfree) = NULL;
+	struct trace_array *tr = ops->private;
+	int ret;
+
+	func = strsep(&next, ":");
+
+	/* This can also handle :mod: parsing */
+	if (next) {
+		if (!tr)
+			return -EINVAL;
+
+		command = strsep(&next, ":");
+		if (strcmp(command, "mod") != 0)
+			return -EINVAL;
+
+		mod = next;
+		len = command - func;
+		/* Save the original func as ftrace_set_hash() can modify it */
+		tmp = kstrdup(func, GFP_KERNEL);
+	}
+
+	ret = ftrace_set_hash(ops, func, len, NULL, 0, 0, reset, enable, mod);
+
+	if (tr && mod && ret < 0) {
+		/* Did tmp fail to allocate? */
+		if (!tmp)
+			return -ENOMEM;
+		ret = cache_mod(tr, tmp, mod, enable);
+	}
+
+	return ret;
 }
 
 /**
@@ -6354,6 +6389,14 @@ ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable)
 
 	ftrace_ops_init(ops);
 
+	/* The trace_array is needed for caching module function filters */
+	if (!ops->private) {
+		struct trace_array *tr = trace_get_global_array();
+
+		ops->private = tr;
+		ftrace_init_trace_array(tr);
+	}
+
 	while (buf) {
 		func = strsep(&buf, ",");
 		ftrace_set_regex(ops, func, strlen(func), 0, enable);
@@ -7787,9 +7830,14 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 
 void ftrace_init_trace_array(struct trace_array *tr)
 {
+	if (tr->flags & TRACE_ARRAY_FL_MOD_INIT)
+		return;
+
 	INIT_LIST_HEAD(&tr->func_probes);
 	INIT_LIST_HEAD(&tr->mod_trace);
 	INIT_LIST_HEAD(&tr->mod_notrace);
+
+	tr->flags |= TRACE_ARRAY_FL_MOD_INIT;
 }
 #else
 
@@ -7818,7 +7866,8 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 __init void ftrace_init_global_array_ops(struct trace_array *tr)
 {
 	tr->ops = &global_ops;
-	tr->ops->private = tr;
+	if (!global_ops.private)
+		global_ops.private = tr;
 	ftrace_init_trace_array(tr);
 	init_array_fgraph_ops(tr, tr->ops);
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 957f941a08e7..a553f1e7a057 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10657,6 +10657,14 @@ __init static int tracer_alloc_buffers(void)
 	return ret;
 }
 
+#ifdef CONFIG_FUNCTION_TRACER
+/* Used to set module cached ftrace filtering at boot up */
+__init struct trace_array *trace_get_global_array(void)
+{
+	return &global_trace;
+}
+#endif
+
 void __init ftrace_boot_snapshot(void)
 {
 #ifdef CONFIG_TRACER_MAX_TRACE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f3e68a8d8a0..ba68a5a54092 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -432,6 +432,7 @@ struct trace_array {
 enum {
 	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
 	TRACE_ARRAY_FL_BOOT	= BIT(1),
+	TRACE_ARRAY_FL_MOD_INIT	= BIT(2),
 };
 
 extern struct list_head ftrace_trace_arrays;
@@ -1116,6 +1117,7 @@ void ftrace_destroy_function_files(struct trace_array *tr);
 int ftrace_allocate_ftrace_ops(struct trace_array *tr);
 void ftrace_free_ftrace_ops(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
+struct trace_array *trace_get_global_array(void);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
-- 
2.45.2

