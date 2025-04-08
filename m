Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE8218845;
	Tue,  8 Apr 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125958; cv=none; b=inwO0ywAsHNyOjoRVqrUXwt5WwAVWsVe/ztNy/uuzXydIbkorYictI3ksNuNIbyWmRL5qy8m7AXM7zhzAxz5vryA2BC7VRQHb1mxGiDb1JMcIYiXIjg77IVth4pE5U/QFlxluotriYeTVimGxeLaxfuz8Y4LR++Yno4RnJXMjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125958; c=relaxed/simple;
	bh=yuI/cONYo5jk3KMIQmLPYSuRaUFLK1KbDTV531UBS4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NRFMCypYVtv/GrCJm1YFMFsso+kPjLZEc893Qo8BdZ7GLWr2tQGB7rnOvm+WOhlb1s1jPdg5YljECXou27cRCPwkhCF0uuSZw0B6Hq/jlHMxX/kEz0NcVUIdBIryooBhE4on3EdT/K6c4E83QvM6KgfndN+TqMeOEe/PA/ilR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF20C4CEE5;
	Tue,  8 Apr 2025 15:25:57 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:27:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Allow the top level trace_marker to write into
 another instance
Message-ID: <20250408112714.403a4368@gandalf.local.home>
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

There are applications that have it hard coded to write into the top level
trace_marker instance (/sys/kernel/tracing/trace_marker). This can be
annoying if a profiler is using that instance for other work, or if it
needs all writes to go into a new instance.

A new option is created called "redirect_trace_marker". By default, the
top level has this set, as that is the default buffer that writing into
the top level trace_marker file will go to. But now if an instance is
created and sets this option, all writes into the top level trace_marker
will be redirected into that instance buffer just as if an application
were to write into the instance's trace_marker file.

Only one instance can have this option set. If the option is set in
another instance, then it will clear the option from the previous
instance.

The top level instance can set this option but it can not clear it, and
it will bring the writing of the trace_marker back to its buffer.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 15 +++++++++
 kernel/trace/trace.c           | 60 +++++++++++++++++++++++++++++++---
 kernel/trace/trace.h           |  1 +
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index c9e88bf65709..6b3915139347 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1205,6 +1205,21 @@ Here are the available options:
 	default instance. The only way the top level instance has this flag
 	cleared, is by it being set in another instance.
 
+  redirect_trace_marker
+	This is similar to the trace_printk_dest option above, but it works
+	for the top level trace_marker (/sys/kernel/tracing/trace_marker).
+	If there are applications that hard code writing into the top level
+	trace_marker file, and the tooling would like it to go into an
+	instance, this option can be used. Create an instance and set this
+	option, and then all writes into the top level trace_marker file will
+	be redirected into that instance.
+
+	This flag cannot be cleared by the top level instance, as it is the
+	default instance. The only way the top level instance has this flag
+	cleared, is by it being set in another instance. By setting this flag
+	in the top level instance, it will put the writing into the
+	trace_marker file back into the top level instance buffer.
+
   annotate
 	It is sometimes confusing when the CPU buffers are full
 	and one CPU buffer had a lot of events recently, thus
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..ec7e15434759 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -493,7 +493,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
 	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
-	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK)
+	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |		\
+	 TRACE_ITER_REDIRECT_MARKER)
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
@@ -501,7 +502,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK)
+	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
+	 TRACE_ITER_REDIRECT_MARKER)
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -512,6 +514,7 @@ static struct trace_array global_trace = {
 };
 
 static struct trace_array *printk_trace = &global_trace;
+static struct trace_array *marker_trace = &global_trace;
 
 static __always_inline bool printk_binsafe(struct trace_array *tr)
 {
@@ -534,6 +537,16 @@ static void update_printk_trace(struct trace_array *tr)
 	tr->trace_flags |= TRACE_ITER_TRACE_PRINTK;
 }
 
+static void update_marker_trace(struct trace_array *tr)
+{
+	if (marker_trace == tr)
+		return;
+
+	marker_trace->trace_flags &= ~TRACE_ITER_REDIRECT_MARKER;
+	marker_trace = tr;
+	tr->trace_flags |= TRACE_ITER_REDIRECT_MARKER;
+}
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -4755,8 +4768,22 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
 
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
 	stream_open(inode, filp);
-	return tracing_open_generic_tr(inode, filp);
+
+	/* The top level marker can have it redirected to an instance */
+	if (tr == &global_trace)
+		tr = marker_trace;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = tr;
+
+	return 0;
 }
 
 static int tracing_release(struct inode *inode, struct file *file)
@@ -4799,7 +4826,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 int tracing_release_generic_tr(struct inode *inode, struct file *file)
 {
-	struct trace_array *tr = inode->i_private;
+	struct trace_array *tr = file->private_data;
 
 	trace_array_put(tr);
 	return 0;
@@ -5189,7 +5216,8 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
 	    (mask == TRACE_ITER_RECORD_CMD) ||
-	    (mask == TRACE_ITER_TRACE_PRINTK))
+	    (mask == TRACE_ITER_TRACE_PRINTK) ||
+	    (mask == TRACE_ITER_REDIRECT_MARKER))
 		lockdep_assert_held(&event_mutex);
 
 	/* do nothing if flag is already set */
@@ -5220,6 +5248,25 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		}
 	}
 
+	if (mask == TRACE_ITER_REDIRECT_MARKER) {
+		if (enabled) {
+			update_marker_trace(tr);
+		} else {
+			/*
+			 * The global_trace cannot clear this.
+			 * It's flag only gets cleared if another instance sets it.
+			 */
+			if (marker_trace == &global_trace)
+				return -EINVAL;
+			/*
+			 * An instance must always have it set.
+			 * by default, that's the global_trace instane.
+			 */
+			if (marker_trace == tr)
+				update_marker_trace(&global_trace);
+		}
+	}
+
 	if (enabled)
 		tr->trace_flags |= mask;
 	else
@@ -9897,6 +9944,9 @@ static int __remove_instance(struct trace_array *tr)
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	if (marker_trace == tr)
+		update_marker_trace(&global_trace);
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79be1995db44..602457eda8e8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1368,6 +1368,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
+		C(REDIRECT_MARKER,	"redirect_trace_marker"),\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
-- 
2.47.2

