Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF240DB45;
	Wed,  2 Sep 2026 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384341; cv=none; b=CbKwKghap0Yy/FXky1NP9Dp79tRQyhkhTHUpqd19jyc6wDKRqPT8Wpf8LJPj3HG7i6XA2bKcWHl9Eoe7gvlUhYEQ9LDIQMjo0ARTw+NWZ3avg2aSgmpUpApxn4W2vOXTvNYGDvNpJFFdJL7Zv9rWF9NegZxXtioK+9lLsM09BMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384341; c=relaxed/simple;
	bh=nASpRVZNQfybcknvo2KZJ092zpupeGE1xqHWWG2ZuLE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WVnJ+rv7xSk2fOsNQifV4ex5BCOf28KJKwxTtTW1AFiPRK9tkTEocJGbQAWxZrk9a83FiCewdy+iEw6HU+vMqtyGYJ6bdsIRL6kg3ke8eZC6n7MsBcN0kLz95Z9HIYB0p4osHbAwtuSMGemJNoSiql52iKuBI5xhP2KulQxxkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPeh9yn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPeh9yn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2C91F00A3A;
	Wed,  2 Sep 2026 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384336;
	bh=WdcIkIc+E7fO4R7iGBi1jsLtuH0TPPijixHoyZ+hEag=;
	h=Date:From:To:Cc:Subject:References;
	b=CPeh9yn9h1UacsUlrjfGNDhMpPvRvr8LG8Tu4eAJVJrQHTKnGn+/tvRWMR/hcMA4Q
	 5bWzn8yW39EPteeZh9/hzjRjN4PKEb94gigzEdVq3H+7aUDvhihzXEu4lZtbYVrQvL
	 donYJL8Nyj4KmybmHuB0UwB1SfCU+98oouL1ljlfhqtTQ9KhEXVd7Q5hNZXES61YcV
	 lRaUVDO1eI3ooqUaBGkH8ug7mHRCXdfbubDN2Wdko+/GrfQlUSWGEWH84vSVb5OC55
	 gxkWapyNXRuW1fpv73HIga2ILNbUWQXujgeUykZSP74jsRA6I7RheCnLvYbi/Brn7a
	 TUZ+I+UVSflVQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x1sTe-0000000ECdp-0CUQ;
	Wed, 02 Sep 2026 17:26:38 -0400
Message-ID: <20260902212637.906950608@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 02 Sep 2026 17:26:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tracing: Use a single array to represent tracer options files
References: <20260902212609.542937225@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

An instance is represented by a trace_array descriptor that has an array
for options of each tracer. That array is a pointer to another array that
represents every option for a specific tracer. Instead of having two
arrays use just a single array for every tracer option within a
trace_array.

This not only simplifies the logic for representing the tracer option in
the callbacks, but also can be used to simplify a way to find the
trace_array descriptor from this one single array when needing to find
which trace_array the option is attached to in order to take its
reference.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 47 ++++++++++++++++++--------------------------
 kernel/trace/trace.h | 21 ++++++++------------
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 722d0ba2d233..f26244253a8b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7689,7 +7689,7 @@ static ssize_t
 trace_options_read(struct file *filp, char __user *ubuf, size_t cnt,
 			loff_t *ppos)
 {
-	struct trace_option_dentry *topt = filp->private_data;
+	struct trace_options *topt = filp->private_data;
 	char *buf;
 
 	if (topt->flags->val & topt->opt->bit)
@@ -7704,7 +7704,7 @@ static ssize_t
 trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			 loff_t *ppos)
 {
-	struct trace_option_dentry *topt = filp->private_data;
+	struct trace_options *topt = filp->private_data;
 	unsigned long val;
 	int ret;
 
@@ -7730,7 +7730,7 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 static int tracing_open_options(struct inode *inode, struct file *filp)
 {
-	struct trace_option_dentry *topt = inode->i_private;
+	struct trace_options *topt = inode->i_private;
 	int ret;
 
 	ret = tracing_check_open_get_tr(topt->tr);
@@ -7743,7 +7743,7 @@ static int tracing_open_options(struct inode *inode, struct file *filp)
 
 static int tracing_release_options(struct inode *inode, struct file *file)
 {
-	struct trace_option_dentry *topt = file->private_data;
+	struct trace_options *topt = file->private_data;
 
 	trace_array_put(topt->tr);
 	return 0;
@@ -7946,8 +7946,9 @@ static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 
 static void
 create_trace_option_file(struct trace_array *tr,
-			 struct trace_option_dentry *topt,
+			 struct trace_options *topt,
 			 struct tracer_flags *flags,
+			 struct tracer *tracer,
 			 struct tracer_opt *opt)
 {
 	struct dentry *t_options;
@@ -7959,6 +7960,7 @@ create_trace_option_file(struct trace_array *tr,
 	topt->flags = flags;
 	topt->opt = opt;
 	topt->tr = tr;
+	topt->tracer = tracer;
 
 	topt->entry = trace_create_file(opt->name, TRACE_MODE_WRITE,
 					t_options, topt, &trace_options_fops);
@@ -7968,10 +7970,9 @@ static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 			  struct tracer_flags *flags)
 {
-	struct trace_option_dentry *topts;
-	struct trace_options *tr_topts;
+	struct trace_options *topts;
 	struct tracer_opt *opts;
-	int cnt;
+	int i, cnt;
 
 	if (!flags || !flags->opts)
 		return 0;
@@ -7981,29 +7982,22 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 	for (cnt = 0; opts[cnt].name; cnt++)
 		;
 
-	topts = kzalloc_objs(*topts, cnt + 1);
-	if (!topts)
-		return 0;
-
-	tr_topts = krealloc_array(tr->topts, tr->nr_topts + 1, sizeof(*tr->topts),
+	topts = krealloc_array(tr->topts, tr->nr_topts + cnt, sizeof(*tr->topts),
 				  GFP_KERNEL);
-	if (!tr_topts) {
-		kfree(topts);
+	if (!topts)
 		return -ENOMEM;
-	}
 
-	tr->topts = tr_topts;
-	tr->topts[tr->nr_topts].tracer = tracer;
-	tr->topts[tr->nr_topts].topts = topts;
-	tr->nr_topts++;
+	tr->topts = topts;
 
-	for (cnt = 0; opts[cnt].name; cnt++) {
-		create_trace_option_file(tr, &topts[cnt], flags,
-					 &opts[cnt]);
-		MEM_FAIL(topts[cnt].entry == NULL,
+	for (topts += tr->nr_topts, i = 0; i < cnt; topts++, i++) {
+		create_trace_option_file(tr, topts, flags, tracer,
+					 &opts[i]);
+		MEM_FAIL(topts->entry == NULL,
 			  "Failed to create trace option: %s",
-			  opts[cnt].name);
+			  opts[i].name);
 	}
+
+	tr->nr_topts += cnt;
 	return 0;
 }
 
@@ -8865,9 +8859,6 @@ static int __remove_instance(struct trace_array *tr)
 	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
 		vfree((void *)tr->range_addr_start);
 
-	for (i = 0; i < tr->nr_topts; i++) {
-		kfree(tr->topts[i].topts);
-	}
 	kfree(tr->topts);
 
 	free_cpumask_var(tr->pipe_cpumask);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3c111ca88e32..a07802be5673 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -224,11 +224,6 @@ struct array_buffer {
 
 #define TRACE_FLAGS_MAX_SIZE		64
 
-struct trace_options {
-	struct tracer			*tracer;
-	struct trace_option_dentry	*topts;
-};
-
 struct trace_pid_list *trace_pid_list_alloc(void);
 void trace_pid_list_free(struct trace_pid_list *pid_list);
 bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid);
@@ -325,6 +320,14 @@ struct trace_module_delta {
 	long		delta[];
 };
 
+struct trace_options {
+	struct tracer_opt		*opt;
+	struct tracer_flags		*flags;
+	struct trace_array		*tr;
+	struct tracer			*tracer;
+	struct dentry			*entry;
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -605,14 +608,6 @@ struct tracer_flags {
 /* Makes more easy to define a tracer opt */
 #define TRACER_OPT(s, b)	.name = #s, .bit = b
 
-
-struct trace_option_dentry {
-	struct tracer_opt		*opt;
-	struct tracer_flags		*flags;
-	struct trace_array		*tr;
-	struct dentry			*entry;
-};
-
 /**
  * struct tracer - a specific tracer and its callbacks to interact with tracefs
  * @name: the name chosen to select it on the available_tracers file
-- 
2.53.0


