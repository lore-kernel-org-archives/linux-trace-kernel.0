Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCB205E01;
	Thu,  9 Jan 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462706; cv=none; b=dj+oydjkoex7G5ePVW9Ml+YfzhgRwelRUG8l2DQwG8O95JUV5Mo6m6EURsbXFF14anTQPzImQRGz+SRZsC5iy5wbyaOApWUMaTFL8RjGlc0R92VhQp/I2yKGc7oGktMVxsyXhJUMVl7PdHr3jAoBbR0jj3z8s+a5W9BeKKJApZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462706; c=relaxed/simple;
	bh=oY0L2X7kpoHNhmMwdl6T3RGBaQGssS/wKbmeWvkU05A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EOgvpCBC/PVAPz+wK0KCjvyF+2nQ/FO066kkSsOcga7h54xpgCkNdPtOWftmgCci1W4nYyCy5sjkem489GicwtKGt+B9lvhqbOiQWuab+P0yIvd2FUXyd2DIJEJ3p61FZ4vBGRpCiA0dvhKBMoEBT6Sb5+Au65WJVuJD9YUSqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87347C4CED2;
	Thu,  9 Jan 2025 22:45:05 +0000 (UTC)
Date: Thu, 9 Jan 2025 17:46:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 jochensp@jochen.sprickerhof.de
Subject: [PATCH] ftrace: Implement :mod: cache filtering on kernel command
 line
Message-ID: <20250109174639.32e6f43a@gandalf.local.home>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 67 +++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c  |  6 ++++
 kernel/trace/trace.h  |  2 ++
 3 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2e113f8b13a2..5f6b169e3358 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4982,10 +4982,6 @@ static int cache_mod(struct trace_array *tr,
 	return ftrace_add_mod(tr, func, module, enable);
 }
 
-static int
-ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
-		 int reset, int enable);
-
 #ifdef CONFIG_MODULES
 static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 			     char *mod, bool enable)
@@ -5788,7 +5784,7 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long *ips,
 static int
 ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 		unsigned long *ips, unsigned int cnt,
-		int remove, int reset, int enable)
+		int remove, int reset, int enable, char *mod)
 {
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *hash;
@@ -5814,7 +5810,15 @@ ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
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
@@ -5839,7 +5843,7 @@ static int
 ftrace_set_addr(struct ftrace_ops *ops, unsigned long *ips, unsigned int cnt,
 		int remove, int reset, int enable)
 {
-	return ftrace_set_hash(ops, NULL, 0, ips, cnt, remove, reset, enable);
+	return ftrace_set_hash(ops, NULL, 0, ips, cnt, remove, reset, enable, NULL);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
@@ -6217,7 +6221,38 @@ static int
 ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 		 int reset, int enable)
 {
-	return ftrace_set_hash(ops, buf, len, NULL, 0, 0, reset, enable);
+	char *mod, *func, *command, *next = buf;
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
@@ -6381,6 +6416,14 @@ ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable)
 
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
@@ -7814,9 +7857,14 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 
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
 
@@ -7845,7 +7893,8 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
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
index f8aebcb01e62..5451f3e2e17b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10660,6 +10660,12 @@ __init static int tracer_alloc_buffers(void)
 	return ret;
 }
 
+/* Used to set module cached ftrace filtering at boot up */
+__init struct trace_array *trace_get_global_array(void)
+{
+	return &global_trace;
+}
+
 void __init ftrace_boot_snapshot(void)
 {
 #ifdef CONFIG_TRACER_MAX_TRACE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9691b47b5f3d..b6e60013ce0f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -432,6 +432,7 @@ struct trace_array {
 enum {
 	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
 	TRACE_ARRAY_FL_BOOT	= BIT(1),
+	TRACE_ARRAY_FL_MOD_INIT	= BIT(2),
 };
 
 extern struct list_head ftrace_trace_arrays;
@@ -1114,6 +1115,7 @@ void ftrace_destroy_function_files(struct trace_array *tr);
 int ftrace_allocate_ftrace_ops(struct trace_array *tr);
 void ftrace_free_ftrace_ops(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
+struct trace_array *trace_get_global_array(void);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
-- 
2.45.2

