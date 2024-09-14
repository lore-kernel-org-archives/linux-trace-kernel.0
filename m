Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFE12C465;
	Sat, 14 Sep 2024 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350496; cv=none; b=OhuCzSC1i0ZMRnglRmOJmGKq/otxqHMqf894iJfkXX5c0SbAxM9tS7HUWiPDGWMM76VHIA7NMKsQAeE36Rt20UOcI3V/RZMtEhDflIYXIHtbFPoU0+ebbxjM64aY1jCoTD7TA3s9+OlRHda3ZTta+NhpZf3QvodlqoUP0vke458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350496; c=relaxed/simple;
	bh=AyQ6kWzDrg2C4r5zFtuNVawjnMnZFU85WGInwOdVPj8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WyswkokvOkZFbxjGHuMo2Z6aCDrCWTC+9cxlMySidcuS5+URtnrfoDCJ3ZI5mdix6/IPPWh2TEw+msNOsqVJPU4d9hm5pByqegD6ghEODrnQCms4VlNG2rai+jHHepGiedIY0dCii+5XV1hPYt/EnODHEGfxAI+mNKLDrOIV4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE002C4CEC0;
	Sat, 14 Sep 2024 21:48:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1spad0-00000001GtJ-3qTx;
	Sat, 14 Sep 2024 17:48:26 -0400
Message-ID: <20240914214826.780323141@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 14 Sep 2024 17:48:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 1/3] fgraph: Use fgraph data to store subtime for profiler
References: <20240914214805.779822616@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having the "subtime" for the function profiler in the
infrastructure ftrace_ret_stack structure, have it use the fgraph data
reserve and retrieve functions.

This will keep the limited shadow stack from wasting 8 bytes for something
that is seldom used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  4 +--
 kernel/trace/fgraph.c  | 64 ++++++++++++++++++++++++++++++++----------
 kernel/trace/ftrace.c  | 23 +++++++--------
 3 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..6bbd78052f7a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1055,6 +1055,7 @@ struct fgraph_ops {
 
 void *fgraph_reserve_data(int idx, int size_bytes);
 void *fgraph_retrieve_data(int idx, int *size_bytes);
+void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth);
 
 /*
  * Stack of return addresses for functions
@@ -1065,9 +1066,6 @@ struct ftrace_ret_stack {
 	unsigned long ret;
 	unsigned long func;
 	unsigned long long calltime;
-#ifdef CONFIG_FUNCTION_PROFILER
-	unsigned long long subtime;
-#endif
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	unsigned long fp;
 #endif
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..095ceb752b28 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -390,21 +390,7 @@ void *fgraph_reserve_data(int idx, int size_bytes)
  */
 void *fgraph_retrieve_data(int idx, int *size_bytes)
 {
-	int offset = current->curr_ret_stack - 1;
-	unsigned long val;
-
-	val = get_fgraph_entry(current, offset);
-	while (__get_type(val) == FGRAPH_TYPE_DATA) {
-		if (__get_data_index(val) == idx)
-			goto found;
-		offset -= __get_data_size(val) + 1;
-		val = get_fgraph_entry(current, offset);
-	}
-	return NULL;
-found:
-	if (size_bytes)
-		*size_bytes = __get_data_size(val) * sizeof(long);
-	return get_data_type_data(current, offset);
+	return fgraph_retrieve_parent_data(idx, size_bytes, 0);
 }
 
 /**
@@ -460,6 +446,54 @@ get_ret_stack(struct task_struct *t, int offset, int *frame_offset)
 	return RET_STACK(t, offset);
 }
 
+/**
+ * fgraph_retrieve_parent_data - get data from a parent function
+ * @idx: The index into the fgraph_array (fgraph_ops::idx)
+ * @size_bytes: A pointer to retrieved data size
+ * @depth: The depth to find the parent (0 is the current function)
+ *
+ * This is similar to fgraph_retrieve_data() but can be used to retrieve
+ * data from a parent caller function.
+ *
+ * Return: a pointer to the specified parent data or NULL if not found
+ */
+void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth)
+{
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = current->curr_ret_stack;
+	unsigned long val;
+
+	if (offset <= 0)
+		return NULL;
+
+	for (;;) {
+		int next_offset;
+
+		ret_stack = get_ret_stack(current, offset, &next_offset);
+		if (!ret_stack || --depth < 0)
+			break;
+		offset = next_offset;
+	}
+
+	if (!ret_stack)
+		return NULL;
+
+	offset--;
+
+	val = get_fgraph_entry(current, offset);
+	while (__get_type(val) == FGRAPH_TYPE_DATA) {
+		if (__get_data_index(val) == idx)
+			goto found;
+		offset -= __get_data_size(val) + 1;
+		val = get_fgraph_entry(current, offset);
+	}
+	return NULL;
+found:
+	if (size_bytes)
+		*size_bytes = __get_data_size(val) * sizeof(long);
+	return get_data_type_data(current, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4c28dd177ca6..196647059800 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -823,7 +823,7 @@ void ftrace_graph_graph_time_control(bool enable)
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
 			       struct fgraph_ops *gops)
 {
-	struct ftrace_ret_stack *ret_stack;
+	unsigned long long *subtime;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -831,9 +831,9 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 	if (!current->ret_stack)
 		return 0;
 
-	ret_stack = ftrace_graph_get_ret_stack(current, 0);
-	if (ret_stack)
-		ret_stack->subtime = 0;
+	subtime = fgraph_reserve_data(gops->idx, sizeof(*subtime));
+	if (subtime)
+		*subtime = 0;
 
 	return 1;
 }
@@ -841,11 +841,12 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 static void profile_graph_return(struct ftrace_graph_ret *trace,
 				 struct fgraph_ops *gops)
 {
-	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
 	unsigned long long calltime;
+	unsigned long long *subtime;
 	struct ftrace_profile *rec;
 	unsigned long flags;
+	int size;
 
 	local_irq_save(flags);
 	stat = this_cpu_ptr(&ftrace_profile_stats);
@@ -861,13 +862,13 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	if (!fgraph_graph_time) {
 
 		/* Append this call time to the parent time to subtract */
-		ret_stack = ftrace_graph_get_ret_stack(current, 1);
-		if (ret_stack)
-			ret_stack->subtime += calltime;
+		subtime = fgraph_retrieve_parent_data(gops->idx, &size, 1);
+		if (subtime)
+			*subtime += calltime;
 
-		ret_stack = ftrace_graph_get_ret_stack(current, 0);
-		if (ret_stack && ret_stack->subtime < calltime)
-			calltime -= ret_stack->subtime;
+		subtime = fgraph_retrieve_data(gops->idx, &size);
+		if (subtime && *subtime && *subtime < calltime)
+			calltime -= *subtime;
 		else
 			calltime = 0;
 	}
-- 
2.45.2


