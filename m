Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B735C68B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939334; cv=none; b=Zalf9/ZCoOv82H4tddksBjp5i2WLUlKXsbeTZxLa4ZEukw9r9Rtnvec94/KwL4rmYdXZgwfwjqMyXWDjo22E5HNvUNOna0olqyua9kyKaV3qhCqn4PQjOyv0hKJYsZIVgl+rBk0rQMd7o5SSC6gCrYlV4XdvlyNwYqLlpafWCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939334; c=relaxed/simple;
	bh=aLkabJqgZ7sedDtk/fVfc6fwzp8mf9Hb8VpBmwZ2sAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvZ9YxSQi92j3/nOaHlnTDg8mJgL4VUwZ3nIJF3V84M1kL08FGkOgL/QA9zX9ZXctjZE3mvCLpkwK1xB2tQT0mBztS/J+qoCdhUegi8CkXNe5qfOjwah2jGeO+hM5q/bXFuQOMeYIRXEk9VxSPyIn/3bDG1bo5+ULG7eZqQr0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MSqE6fIW; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MSqE6fIW"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CFDCE80521;
	Fri, 28 Aug 2026 17:48:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 21D0A6000C;
	Fri, 28 Aug 2026 17:48:49 +0000 (UTC)
Date: Fri, 28 Aug 2026 13:49:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing
 instance
Message-ID: <20260828134938.1a6f8c4f@gandalf.local.home>
In-Reply-To: <20260828123430.22d43b44@gandalf.local.home>
References: <apGORjltZgAiAYHT@gmail.com>
	<20260828104201.21aa9d08@gandalf.local.home>
	<apGwPEj65dcbZFxS@gmail.com>
	<20260828123430.22d43b44@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ca9ubcsizyfew1qsokh9k4phfp5e8fhk
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 21D0A6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UINrTRcI26prbVJTbj2Nr3x1oUMUsz9M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mrPkrNQ3/o1waqcSm8wt1bhuzanyHzue5dSeCpgqc2A=; b=MSqE6fIWzNJqQw1ZbqlYAZoGOf6Mb/bkJYa6hpRm342XdHEWoCgJYQZTYYdp7mPy/vWU5nUggRE+5asOzw98lgsoVjHa714fDwQ4CTbdz3fiRjlNBsJPmvDuc7kfRV1xwPoNFiDW2HBZQvawQWFxSOSSxCIKB/Qqxwmj9vonmbM=
X-HE-Tag: 1787939329-327006
X-HE-Meta: U2FsdGVkX1/qLlavYHPCdSXHjUDhVZse5VPs4cIwbIu9800bfBOA0XS1OoVB85gzswfApL38EyX/D9gL2Hvy4FHlU9q1fBvW4258dBcXio67Lw10QE7klngPmY0PNslALRpZJ5rKbXFjGDTskQRZWzIsslAcmAjc38JHDJFrOTAU8V+/XJAIYZlr11I2ibIHRlQz3/tWBBA/WHXmaqo0QHibn6kz58WyTeCtdT5onKrYROsMBuGdmUXR+/nPtJxMGLdLlkKmiZ8lna5J3q7BZzbBRFD4QoJXysDtCz3HO36lg84XlSm64vBkD687c7mETI1NZ7DvlQ2iI+4wVODZn02OF98sl1llUDUenMvBtqvY+jxN5XfIoiIj9JqljFN6

On Fri, 28 Aug 2026 12:34:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
> > -			  ops, &ftrace_filter_fops);
> > +			  ops->private, &ftrace_filter_fops);  
> 
> But this also assumes that ops->private is always a trace_array. Which may
> someday change and we will get a hidden bug if it does.
> 
> This is the exact reason I want to look deeper at it.

Something like this is more robust:

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9d80c7bd9f1..a417ad0f3f24 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4786,24 +4786,48 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 }
 
 static int
-ftrace_filter_open(struct inode *inode, struct file *file)
+__ftrace_regex_open(struct trace_array *tr, int flag,
+		    struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct ftrace_ops *ops;
+	int ret;
+
+	if (trace_array_get(tr) < 0)
+		return -ENODEV;
+
+	ret = -EINVAL;
+	ops = tr->ops;
+	if (!ops)
+		goto fail;
 
 	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops,
-			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
-			inode, file);
+	ret = ftrace_regex_open(ops, flag, inode, file);
+	if (ret < 0)
+		goto fail;
+
+	return ret;
+ fail:
+	trace_array_put(tr);
+	return ret;
+}
+
+static int
+ftrace_filter_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	return __ftrace_regex_open(tr,
+				   FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
+				   inode, file);
 }
 
 static int
 ftrace_notrace_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
-				 inode, file);
+	return __ftrace_regex_open(tr, FTRACE_ITER_NOTRACE,
+				  inode, file);
 }
 
 /* Type for quick search ftrace basic regexes (globs) from filter_parse_regex */
@@ -7492,15 +7516,15 @@ static const struct file_operations ftrace_graph_notrace_fops = {
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
@@ -7525,6 +7549,7 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
+	struct trace_array *tr;
 
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
@@ -7538,7 +7563,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("touched_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_touched_fops);
 
-	ftrace_create_filter_files(&global_ops, d_tracer);
+	tr = global_ops.private;
+	if (!WARN_ON(tr == NULL))
+		ftrace_create_filter_files(tr, d_tracer);
 
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


-- Steve
