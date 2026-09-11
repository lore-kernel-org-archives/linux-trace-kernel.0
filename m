Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103D377545;
	Fri, 11 Sep 2026 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090823; cv=none; b=WB7m2UCXulPGwJnkSNkK63X2XGF6Xph6BO5wX2QzG6Yinu7i13wHvlf5pmIUuUyiRVStlnEWIVw8u5c9PTFMdtII9j6M+0vEWfZYH75mJJ5rK+m3+Z2zz05FIRyri9fmu29EvvUSPVBcMc951Ant6iPyHE6uuUP5HAZUssywy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090823; c=relaxed/simple;
	bh=XK8o20HZnPScsYW5HFw5cL31L2wiAxcOiwQrzVg1O9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UEZlH+w9/NWfbVBwpR7ndJ3VXFbuBeG7z3RCnaaKNLcwUq71xrCB41ywXQaA1UboKc2r3pRn1QXN4nVtnzJWpF8ZeagSfSzDdVmFx/iqEUI1OxKlNFS6caPd8aD7t/JLzcVMS/F2O7ZA73J0vLYiyPySOhVG9E5dbVB5S3ZLHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jbUELQaz; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jbUELQaz"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F1884406A9;
	Fri, 11 Sep 2026 01:40:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 523CC2002E;
	Fri, 11 Sep 2026 01:40:10 +0000 (UTC)
Date: Thu, 10 Sep 2026 21:40:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: PATCH] tracing: Revert commit 5ad289336148 ("tracing: Use a single
 array to represent tracer options files")
Message-ID: <20260910214008.4c63211f@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fnr7jh8751wzd6qw3d8b6p1dro8qqbam
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 523CC2002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0hPn96pu2YsJPqGxr36epwrytgW5YBAc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=flv0aR1DpAUroExzJg/rIJqCB31rRphOiine/n+epiM=; b=jbUELQaz6YWx/2dankIahrDI/gFkUX2+2QJGFo/EyLjHARD+gRc3ri0HimHHlFfE3ak2eg4FQSZhzPPghDsQ4uQIVYTjQmE7oX3a4moRJf8BNQqs9PEHUgCQQwin2UCiw860ai6xAJfqOydwpo6ICx1/3dejtatrMdQ+Cmgq0UU=
X-HE-Tag: 1789090810-111999
X-HE-Meta: U2FsdGVkX18WabXQiU8+sY3/mo8urGFDvQ1MuePrlNKv1HVEPF8zc/uNb+thkyPwGtloS+0Xfe7qGoWFFKgOjUSMNBw3uVot/9PtlurSZiD1OCsFjg5GvCdm0sKvzFCcyUnalFTCsInoN8RyD5PQvqdso58xyMsjx9LZsQJK9ACHWZt9JTPyCqJ1bON/XzgImmJKSlhda0cLf0K6j9Ecj6Ux4piAx4WHoqx2EJVOijD1LanSM6UlJQFzd/54d2HtIdNaBPOgP7/nq1IChHNNHFL3VE+mptY6Y+Se/lFl5mYce5vg5AYZx/a/moLPQthb7ouqvJKl8oKtAlZ8x25YTVfcbJjmSZRoFQ9nm1kSzHxX2w6Bm5FFDLPvp2gRou+Z8TMTD6eQzxilNFfl4NnSGkZCz2+Uv46a

From: Steven Rostedt <rostedt@goodmis.org>

The commit 5ad289336148 ("tracing: Use a single array to represent tracer
options files") simplified the array that stores the individual tracer
options within the trace_array from being a multi array where each tracer
had its own array for its options to a single array where all the tracers
options were in a single array of the trace_array.

Testing has shown why it was done with multiple arrays in the first place.
The single array use krealloc() to increase the size of the array when new
tracers are added. A krealloc can change the location of the array if it
needs more memory than the current location can provide. The files
associated with the arrays passed in the address of these elements, and
when the array changed, the elements became stale and no longer pointed to
the element that represented the option.

Luckily, the reason this was done was also to check on open if the element
still existed or if it was removed when an instance directory was removed.
On opening a file with a stale element due to the array moving from a
krealloc(), it would not find a corresponding trace_array and the open
would return -ENODEV.

Revert the code back to multi-array where only the outer array gets
resized and its elements point to the allocated arrays for each tracer.

Update the trace_array_trace_options_get() function to search each tracer
array of the main array of the trace_array using a new helper function
tr_option_match(). This preserves the logic to find an existing
trace_array corresponding to the trace options descriptor and doesn't
suffer from krealloc() moving the elements around.

Fixes: e8ea6a874574 ("tracing: Take trace_array reference when opening a tracer options file")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 63 +++++++++++++++++++++++++++++---------------
 kernel/trace/trace.h | 22 ++++++++++------
 2 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7cc3fac70216..e4a490d3d08c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7678,7 +7678,7 @@ static ssize_t
 trace_options_read(struct file *filp, char __user *ubuf, size_t cnt,
 			loff_t *ppos)
 {
-	struct trace_options *topt = filp->private_data;
+	struct trace_option_dentry *topt = filp->private_data;
 	char *buf;
 
 	if (topt->flags->val & topt->opt->bit)
@@ -7693,7 +7693,7 @@ static ssize_t
 trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			 loff_t *ppos)
 {
-	struct trace_options *topt = filp->private_data;
+	struct trace_option_dentry *topt = filp->private_data;
 	unsigned long val;
 	int ret;
 
@@ -7717,6 +7717,18 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static bool tr_option_match(struct trace_array *tr, void *topt)
+{
+	for (int i = 0; i < tr->nr_topts; i++) {
+		struct trace_options *tr_topts = &tr->topts[i];
+
+		if (topt >= (void *)&tr_topts->topts[0] &&
+		    topt < (void *)&tr_topts->topts[tr_topts->nr_topts])
+			return true;
+	}
+	return false;
+}
+
 /*
  * The topt is the address of a trace_array->topts[] element that holds the
  * the tracer options descriptor. But since the trace_array reference has not
@@ -7742,8 +7754,7 @@ static int trace_array_tracer_options_get(void *topt)
 
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (topt >= (void *)&tr->topts[0] &&
-		    topt < (void *)&tr->topts[tr->nr_topts])
+		if (tr_option_match(tr, topt))
 			return __trace_array_get(tr);
 	}
 	return -ENODEV;
@@ -7751,7 +7762,7 @@ static int trace_array_tracer_options_get(void *topt)
 
 static int tracing_open_options(struct inode *inode, struct file *filp)
 {
-	struct trace_options *topt = inode->i_private;
+	struct trace_option_dentry *topt = inode->i_private;
 	int ret;
 
 	ret = trace_array_tracer_options_get(topt);
@@ -7764,7 +7775,7 @@ static int tracing_open_options(struct inode *inode, struct file *filp)
 
 static int tracing_release_options(struct inode *inode, struct file *file)
 {
-	struct trace_options *topt = file->private_data;
+	struct trace_option_dentry *topt = file->private_data;
 
 	trace_array_put(topt->tr);
 	return 0;
@@ -7967,9 +7978,8 @@ static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 
 static void
 create_trace_option_file(struct trace_array *tr,
-			 struct trace_options *topt,
+			 struct trace_option_dentry *topt,
 			 struct tracer_flags *flags,
-			 struct tracer *tracer,
 			 struct tracer_opt *opt)
 {
 	struct dentry *t_options;
@@ -7981,7 +7991,6 @@ create_trace_option_file(struct trace_array *tr,
 	topt->flags = flags;
 	topt->opt = opt;
 	topt->tr = tr;
-	topt->tracer = tracer;
 
 	topt->entry = trace_create_file(opt->name, TRACE_MODE_WRITE,
 					t_options, topt, &trace_options_fops);
@@ -7991,9 +8000,10 @@ static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 			  struct tracer_flags *flags)
 {
-	struct trace_options *topts;
+	struct trace_option_dentry *topts;
+	struct trace_options *tr_topts;
 	struct tracer_opt *opts;
-	int i, cnt;
+	int cnt;
 
 	if (!flags || !flags->opts)
 		return 0;
@@ -8003,22 +8013,30 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 	for (cnt = 0; opts[cnt].name; cnt++)
 		;
 
-	topts = krealloc_array(tr->topts, tr->nr_topts + cnt, sizeof(*tr->topts),
-				  GFP_KERNEL);
+	topts = kzalloc_objs(*topts, cnt + 1);
 	if (!topts)
+		return 0;
+
+	tr_topts = krealloc_array(tr->topts, tr->nr_topts + 1, sizeof(*tr->topts),
+				  GFP_KERNEL);
+	if (!tr_topts) {
+		kfree(topts);
 		return -ENOMEM;
+	}
 
-	tr->topts = topts;
+	tr->topts = tr_topts;
+	tr->topts[tr->nr_topts].tracer = tracer;
+	tr->topts[tr->nr_topts].topts = topts;
+	tr->topts[tr->nr_topts].nr_topts = cnt;
+	tr->nr_topts++;
 
-	for (topts += tr->nr_topts, i = 0; i < cnt; topts++, i++) {
-		create_trace_option_file(tr, topts, flags, tracer,
-					 &opts[i]);
-		MEM_FAIL(topts->entry == NULL,
+	for (cnt = 0; opts[cnt].name; cnt++) {
+		create_trace_option_file(tr, &topts[cnt], flags,
+					 &opts[cnt]);
+		MEM_FAIL(topts[cnt].entry == NULL,
 			  "Failed to create trace option: %s",
-			  opts[i].name);
+			  opts[cnt].name);
 	}
-
-	tr->nr_topts += cnt;
 	return 0;
 }
 
@@ -8880,6 +8898,9 @@ static int __remove_instance(struct trace_array *tr)
 	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
 		vfree((void *)tr->range_addr_start);
 
+	for (i = 0; i < tr->nr_topts; i++) {
+		kfree(tr->topts[i].topts);
+	}
 	kfree(tr->topts);
 
 	free_cpumask_var(tr->pipe_cpumask);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fd0919a2c375..bd3c8f80300f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -224,6 +224,12 @@ struct array_buffer {
 
 #define TRACE_FLAGS_MAX_SIZE		64
 
+struct trace_options {
+	struct tracer			*tracer;
+	struct trace_option_dentry	*topts;
+	int				nr_topts;
+};
+
 struct trace_pid_list *trace_pid_list_alloc(void);
 void trace_pid_list_free(struct trace_pid_list *pid_list);
 bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid);
@@ -320,14 +326,6 @@ struct trace_module_delta {
 	long		delta[];
 };
 
-struct trace_options {
-	struct tracer_opt		*opt;
-	struct tracer_flags		*flags;
-	struct trace_array		*tr;
-	struct tracer			*tracer;
-	struct dentry			*entry;
-};
-
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -608,6 +606,14 @@ struct tracer_flags {
 /* Makes more easy to define a tracer opt */
 #define TRACER_OPT(s, b)	.name = #s, .bit = b
 
+
+struct trace_option_dentry {
+	struct tracer_opt		*opt;
+	struct tracer_flags		*flags;
+	struct trace_array		*tr;
+	struct dentry			*entry;
+};
+
 /**
  * struct tracer - a specific tracer and its callbacks to interact with tracefs
  * @name: the name chosen to select it on the available_tracers file
-- 
2.53.0

