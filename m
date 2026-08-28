Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679E27A47F;
	Fri, 28 Aug 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787947144; cv=none; b=fc4Ob4RFSLh10BIKhNPTn7Zij51FOM1TtafTcTWYqybazp78uQTgbq4ngjMuMJfS1GVfeKCmeWjZu/CoqUpjJW9Zqg4D5CdkbHvN/gQtATIpR0xgq4qWjnn2v5s/3WeAk1Ry4PQfRXVgECHnVDRJrzw3YaEqFjD3X9uznXBIqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787947144; c=relaxed/simple;
	bh=LgMOatiy+7XEyiCvqb4M1kKcLipTyx0ODtzakxJIjiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RkV1oyWWUDC+olcr+jKgKSzMG4mWtGDyrS1fBLYEOY2y5mhY5r5O1im44DM4eI87kw/j9m/Fd48o+rjhsX61W5E3rvYz2uUhxryqDQ3BbZx+6ZAhKzExXux4VWX8APLu3p9+yUpJPllocWGi5+dG/M5mTztoBXmSLUCe1b1b4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5tzIGdy2; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5tzIGdy2"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5BC7CA056A;
	Fri, 28 Aug 2026 19:58:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8DFE72002B;
	Fri, 28 Aug 2026 19:58:52 +0000 (UTC)
Date: Fri, 28 Aug 2026 15:59:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Breno Leitao <leitao@debian.org>
Subject: [PATCH] ftrace: Take trace_array reference before accessing its
 ftrace_ops
Message-ID: <20260828155942.445f46e5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8DFE72002B
X-Stat-Signature: 1w18up9pq5e83gw6exubumdrwzsuiahp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Yb9jRXkSyPDoXLbuSUOgC5KL9Ug1cS/k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=1/oOOJl68blsipXdwWwm/N25KYqVOSFFcMXMMZnjr0g=; b=5tzIGdy285KOFGiOi29CMVK7EAiyxxk8cJFNRJjO2KQ0NjPYzHI7smRHe/u6dkLMFL+6LGdJUVoHc6l+hGqEzwDBm4D2Vytxalx7EI52yt92jq4Wpyr2zQSNxbHNt8DiByRyA1Rocl64JD/tssh7ojctiUIeaJW7kbwaLjxLFEU=
X-HE-Tag: 1787947132-504366
X-HE-Meta: U2FsdGVkX1/CQrSRG4dsWZo4R5CUyOZdH6yYH/GpYuGXqQBu22yyyb7pzXRgNs3D4jxqi/lm9ToPzzuoL3jayETzSkTqsNHVBb6u64DwF4Zgjo4Rq+28aAO9kAuHQDT2Vake3tNtxy4MgHEmOsHk3MeOnQZ2PJ3i6uI+3vxxVZ6KE+JhB8lGjYcsV5BbbNH0izXN00xfkc8Y00It5aAQylTALEqUdqaGfXJ9xmLFFd/K2E7J7vxL/fQLOedntq9+cFBqShSLbr1Z8p5+MiQnCbms9yX3TVCSTo/8prYubLuQwhW6H4kvOb8J5nITN1Is9mL524E15yhzfbyDtQXLyQgPgpJsZsc0Wgs2wyoY/H08geuVvwqFyU2M9ImV5gRCKDa7PlnwJXG2l/2a/GdZhENYb92kdl3RKnPt3Di4QGCZdCbvaOaMpW471KD36gTeOavCj1rtFl8=

From: Steven Rostedt <rostedt@goodmis.org>

The trace instance files set_ftrace_filter and set_ftrace_notrace was
updated to work with specific trace instances (trace_arrays). The issue is
that when these files are opened, there is a small race window where it
will use the ftrace_ops from the inode->private pointer to get a reference
to the trace_array and then take its reference. The problem is that the
ftrace_ops itself could be freed. If the rmdir on the instance happens at
the same time the set_ftrace_filter file is opened, the rmdir could have
also freed the ftrace_ops and referencing it will cause a use-after-free
bug and crash the kernel.

Instead, pass in the trace_array as the file private data (NULL for the
top level instance), and then pass both the trace_array and the ftrace_ops
to the ftrace_regex_open() function. If the trace_array is NULL, then it
just uses the ftrace_ops without the need to take its reference (like
normal). If the ftrace_ops is NULL, that is only the case for the top
level instance and the global_ops can be used.

This allows the trace_array to have its reference incremented before
touching the ftrace_ops that could also be freed when the instance is.

Cc: stable@vger.kernel.org
Fixes: 591dffdade9f0 ("ftrace: Allow for function tracing instance to filter functions")
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h         |  5 ++--
 kernel/trace/ftrace.c          | 52 ++++++++++++++++++++--------------
 kernel/trace/trace.h           |  5 ++--
 kernel/trace/trace_functions.c |  2 +-
 kernel/trace/trace_stack.c     |  2 +-
 5 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02bc5027523a..bd76a16a63af 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -866,8 +866,9 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
 extern ftrace_func_t ftrace_trace_function;
+struct trace_array;
 
-int ftrace_regex_open(struct ftrace_ops *ops, int flag,
+int ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file);
 ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
 			    size_t cnt, loff_t *ppos);
@@ -1077,7 +1078,7 @@ static inline unsigned long ftrace_location(unsigned long ip)
  * have them defined when ftrace is not enabled, but these
  * functions may still be called. Use a macro instead of inline.
  */
-#define ftrace_regex_open(ops, flag, inod, file) ({ -ENODEV; })
+#define ftrace_regex_open(tr, ops, flag, inode, file) ({ -ENODEV; })
 #define ftrace_set_early_filter(ops, buf, enable) do { } while (0)
 #define ftrace_set_filter_ip(ops, ip, remove, reset) ({ -ENODEV; })
 #define ftrace_set_filter_ips(ops, ips, cnt, remove, reset) ({ -ENODEV; })
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9d80c7bd9f1..4babd86c7be0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4677,7 +4677,8 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
 
 /**
  * ftrace_regex_open - initialize function tracer filter files
- * @ops: The ftrace_ops that hold the hash filters
+ * @tr: The trace_array that holds the ftrace_ops [optional]
+ * @ops: The ftrace_ops that hold the hash filters [optional]
  * @flag: The type of filter to process
  * @inode: The inode, usually passed in to your open routine
  * @file: The file, usually passed in to your open routine
@@ -4691,26 +4692,38 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
  * tracing_lseek() should be used as the lseek routine, and
  * release must call ftrace_regex_release().
  *
+ * Note, If @tr is not NULL, its reference has to be taken before
+ *       @ops may be referenced.
+ *       If @ops is NULL and @tr is not, then @tr->ops is used.
+ *       If both @tr and @ops are NULL, then the &global_ops is
+ *       to be used.
+ *
  * Returns: 0 on success or a negative errno value on failure
  */
 int
-ftrace_regex_open(struct ftrace_ops *ops, int flag,
+ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file)
 {
-	struct ftrace_iterator *iter;
+	struct ftrace_iterator *iter = NULL;
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
-	struct trace_array *tr = ops->private;
-	int ret = -ENOMEM;
-
-	ftrace_ops_init(ops);
+	int ret = -ENODEV;
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
-	if (tracing_check_open_get_tr(tr))
+	if (tr && tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
+	if (!ops)
+		ops = tr ? tr->ops : &global_ops;
+
+	if (WARN_ON_ONCE(!ops))
+		goto out;
+
+	ftrace_ops_init(ops);
+
+	ret = -ENOMEM;
 	iter = kzalloc_obj(*iter);
 	if (!iter)
 		goto out;
@@ -4788,21 +4801,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 static int
 ftrace_filter_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops,
-			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
-			inode, file);
+	return ftrace_regex_open(tr, NULL,
+				 FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
+				 inode, file);
 }
 
 static int
 ftrace_notrace_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
+	return ftrace_regex_open(tr, NULL, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
 
@@ -7492,15 +7503,15 @@ static const struct file_operations ftrace_graph_notrace_fops = {
 };
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent)
 {
 
 	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_filter_fops);
+			  tr, &ftrace_filter_fops);
 
 	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_notrace_fops);
+			  tr, &ftrace_notrace_fops);
 }
 
 /*
@@ -7525,7 +7536,6 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
-
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
@@ -7538,7 +7548,7 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("touched_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_touched_fops);
 
-	ftrace_create_filter_files(&global_ops, d_tracer);
+	ftrace_create_filter_files(NULL, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	trace_create_file("set_graph_function", TRACE_MODE_WRITE, d_tracer,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..3c111ca88e32 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1340,7 +1340,7 @@ extern void clear_ftrace_function_probes(struct trace_array *tr);
 int register_ftrace_command(struct ftrace_func_command *cmd);
 int unregister_ftrace_command(struct ftrace_func_command *cmd);
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent);
 void ftrace_destroy_filter_files(struct ftrace_ops *ops);
 
@@ -1363,11 +1363,12 @@ static inline void clear_ftrace_function_probes(struct trace_array *tr)
 {
 }
 
+static inline void ftrace_create_filter_files(struct trace_array *tr,
+					      struct dentry *parent) { }
 /*
  * The ops parameter passed in is usually undefined.
  * This must be a macro.
  */
-#define ftrace_create_filter_files(ops, parent) do { } while (0)
 #define ftrace_destroy_filter_files(ops) do { } while (0)
 #endif /* CONFIG_FUNCTION_TRACER && CONFIG_DYNAMIC_FTRACE */
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index cd37f2013758..c879d43a5fbb 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -101,7 +101,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 		return ret;
 	}
 
-	ftrace_create_filter_files(tr->ops, parent);
+	ftrace_create_filter_files(tr, parent);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 0aa2514a6593..e7f4e523587d 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -499,7 +499,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 	struct ftrace_ops *ops = inode->i_private;
 
 	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
+	return ftrace_regex_open(NULL, ops, FTRACE_ITER_FILTER,
 				 inode, file);
 }
 
-- 
2.53.0

