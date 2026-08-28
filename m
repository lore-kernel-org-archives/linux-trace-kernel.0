Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84035B657
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946860; cv=none; b=F403cWmYthcIevnTVs3m/ND2o3XTj+03TLnTq9bXDq5QJs/8xsNQvw3Aq1pvw5saIbB/PbjQfcbdOdbQ65rJq0+hMBUMlSJn+KQv4BtZbllkI3Nu1es1BLD4IGRslZLSjkeOd2lSM8FkxcpVmL7BhTTbgOzfZTJ0dx2eO+YTwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946860; c=relaxed/simple;
	bh=tpFcNd3+ARgr9deCsnxBsTiuRNqriI6MS5kW/9S2MBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlJVI6hSezbvOPE/ZDSDeuPWYSf19UTorS43cHpCZIuYkg92LhTqZtGymUUY0nS1g+PJHqPyAGa6iMi0cCLZjCviAHH1XcBX0PNVqqakrd0XMwGLn6xNq2RQrddY6elbvkHo+AG0O9x/O4IV3S1OgqNzJX0Fr/EkzY3OEb/X1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=gVce8Sw5; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="gVce8Sw5"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7817A1C20DF;
	Fri, 28 Aug 2026 19:54:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 9ABF02F;
	Fri, 28 Aug 2026 19:54:14 +0000 (UTC)
Date: Fri, 28 Aug 2026 15:55:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing
 instance
Message-ID: <20260828155504.529c97e4@gandalf.local.home>
In-Reply-To: <20260828140411.14108739@gandalf.local.home>
References: <apGORjltZgAiAYHT@gmail.com>
	<20260828104201.21aa9d08@gandalf.local.home>
	<apGwPEj65dcbZFxS@gmail.com>
	<20260828140411.14108739@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9efmfp97357t97czm8rmcg16a1u5ii51
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9ABF02F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191LqbQQBNhluJj5SuuE1+Hm40uP6FEdDs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=CV1ZCmldjUu3sB1IbDPmsTqt35XXT0B5c6jUqaL04us=; b=gVce8Sw5pd4kAAm5Qq79Bv83BiIFaWlY29xXWud4PawDeRbF8vu1Yfn5POhb0XxYud1bPgqQNHNRW2Ds9SVT7bo5cdXKjFgMUZbgTU3V4318ONCc6DGOFtwB23Aea3LUnV126poW6PcMX7pZ4Oi9aGCtyoyMtl7JTDEj659hA3E=
X-HE-Tag: 1787946854-127370
X-HE-Meta: U2FsdGVkX1/VbzNPVzLQ83qzHGbX0RPh7JWyBnLtIrbAmBVJvh9Tvy6YzOfZVNFtvd0INT6pTGuSqL5i8RvXdQKIBHDERkCDHrH3G57uxI4STXzSFN/tSVTopjgQ8HzU/OtaE7ZwP5taRbK46HKHVsYDTfHM4EWi6gQ636luxYvYPgQetQhr7BfPc/AAISN2Nd/BvKvdimOFndGOO3K8wBmMTyaJThBQgu8UCBW4wngQy5vYsJhtBZfDzuWRIfetwBz8oWy9Y5S0dMMuqI+EPH0zTxeLOSPaZDdcJFzPen/FnhLwtS+w24twcuXuW+/kE7L4ScvPYf7G2M2VeytOEfyP4bEJJLs6VBUCaagCHXtrOJ8Be4ELoIQuRjmNkdgx

On Fri, 28 Aug 2026 14:04:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I guess the issue is that the ops may be freed before you get access to the
> trace array. Anyway more needs to be changed. I may remove the extra
> reference. No need to do it twice. Also since trace_stack may have the
> issue too.

Something more like this:

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
index f9d80c7bd9f1..fa7c7186c02f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4677,6 +4677,7 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
 
 /**
  * ftrace_regex_open - initialize function tracer filter files
+ * @tr: The trace_array that holds the ftrace_ops [optional]
  * @ops: The ftrace_ops that hold the hash filters
  * @flag: The type of filter to process
  * @inode: The inode, usually passed in to your open routine
@@ -4694,23 +4695,29 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
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
@@ -4788,21 +4795,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
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
 
@@ -7492,15 +7497,15 @@ static const struct file_operations ftrace_graph_notrace_fops = {
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
@@ -7525,7 +7530,6 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
-
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
@@ -7538,7 +7542,7 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
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

-- Steve
