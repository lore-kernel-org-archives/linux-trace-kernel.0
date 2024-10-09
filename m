Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852371311AC;
	Wed,  9 Oct 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491548; cv=none; b=Ab9sYlIg1rJspSUEwXQA1ob+RMrpVXjFzbzxKBohfOEvEf0sStOgrMgtgAOf/hYhaq+N+fhQMGu1n5zGOFHRdZAX/7CKWMzE+XuhP/fS2wfOOId45f4jeVx4xc2xmMY7DKv+HnQMzzoT4b67cMHeavJcO9rvMTn87ME03GWHmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491548; c=relaxed/simple;
	bh=H8kMD+ZLPbOuplsVxJVxDttLpii+7PcM5K3w8mLdXKE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mgsRgSuVWP1KmyckEQdSiF1qRXSRJkqP6oQWjBL1geWgRU7HT2Ykwa+iODmW9N6EMuE9nbQKUxLixqq8cWI074jnQlpKD/1siVkWxz9bCAL9HUO/y407Y4+CTRVa1TGZbYLV+dhxkCtroD5b5sRgPNiMApEbPaEcc4AmSZpPupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhkWnZKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhkWnZKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539CBC4CEC3;
	Wed,  9 Oct 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491546;
	bh=H8kMD+ZLPbOuplsVxJVxDttLpii+7PcM5K3w8mLdXKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhkWnZKzaaNFJkEcCbrLP5OBfqHgK0h5oIp/9e/1NheldWTND29S8MEIawx2LEp0L
	 y8xmLnRwimc0JTLIHRI4cBRsLhn8piQtps/HajACJW+V8vIPW0Ut9/MVhh5fCNVmYh
	 DQU4zFTmMolB6LsKXqM4lUf/9YlPazGpnOCf9k2RIgwdp+M3iukxBQMLZR/USORsnT
	 DOpGD9EpdCoZ9DhnLFy5bXRz7fm+/l/9kj66Dr5TQotIkIMvPH8o9hJbvt1MqAzhYr
	 nwop7gVoKhdD9MtjeS94miOt/onaTB4d12cfb0j/e67TBTub1pJpRaY6ISJQZwjDPI
	 fbA4y4O6f1vHg==
Date: Thu, 10 Oct 2024 01:32:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and
 printing the function return address
Message-Id: <20241010013222.3748287f165e9f874eda0f84@kernel.org>
In-Reply-To: <20241009030340.16400-1-dolinux.peng@gmail.com>
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 11:03:40 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> When using function_graph tracer to analyze the flow of kernel function
> execution, it is often necessary to quickly locate the exact line of code
> where the call occurs. While this may be easy at times, it can be more
> time-consuming when some functions are inlined or the flow is too long.
> 
> This feature aims to simplify the process by recording the return address
> of traced funcions and printing it when outputing trace logs.
> 
> To enhance human readability, the prefix 'ret=' is used for the kernel return
> value, while '<-' serves as the prefix for the return address in trace logs to
> make it look more like the function tracer.
> 
> A new trace option named 'funcgraph-retaddr' has been introduced, and the
> existing option 'sym-addr' can be used to control the format of the return
> address.
> 
> See below logs with both funcgraph-retval and funcgraph-retaddr enabled.
> 
> 0)             | load_elf_binary() { /* <-bprm_execve+0x249/0x600 */
> 0)             |   load_elf_phdrs() { /* <-load_elf_binary+0x84/0x1730 */
> 0)             |     __kmalloc_noprof() { /* <-load_elf_phdrs+0x4a/0xb0 */
> 0)   3.657 us  |       __cond_resched(); /* <-__kmalloc_noprof+0x28c/0x390 ret=0x0 */
> 0) + 24.335 us |     } /* __kmalloc_noprof ret=0xffff8882007f3000 */
> 0)             |     kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */
> 0)             |       rw_verify_area() { /* <-kernel_read+0x2b/0x50 */
> 0)             |         security_file_permission() { /* <-kernel_read+0x2b/0x50 */
> 0)             |           selinux_file_permission() { /* <-security_file_permission+0x26/0x40 */
> 0)             |             __inode_security_revalidate() { /* <-selinux_file_permission+0x6d/0x140 */
> 0)   2.034 us  |               __cond_resched(); /* <-__inode_security_revalidate+0x5f/0x80 ret=0x0 */
> 0)   6.602 us  |             } /* __inode_security_revalidate ret=0x0 */
> 0)   2.214 us  |             avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 ret=0x0 */
> 0) + 16.670 us |           } /* selinux_file_permission ret=0x0 */
> 0) + 20.809 us |         } /* security_file_permission ret=0x0 */
> 0) + 25.217 us |       } /* rw_verify_area ret=0x0 */
> 0)             |       __kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */
> 0)             |         ext4_file_read_iter() { /* <-__kernel_read+0x160/0x2e0 */
> 
> Then, we can use the faddr2line to locate the source code, for example:
> 
> $ ./scripts/faddr2line ./vmlinux load_elf_phdrs+0x6c/0xb0
> load_elf_phdrs+0x6c/0xb0:
> elf_read at fs/binfmt_elf.c:471
> (inlined by) load_elf_phdrs at fs/binfmt_elf.c:531

Hi, I found this introduced "extras" to the fgraph callback interface
but it is only used in function_graph tracer. Can we move this in the
function_graph tracer, like below?

Thank you,


From 8c2851452dd11a3a20ab22bd6bf8dd663c3c4b9c Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Thu, 10 Oct 2024 00:58:12 +0900
Subject: [PATCH] tracing/fgraph: Simplify return address printing in function
 graph tracer

Simplify return address printing in the function graph tracer by removing
fgraph_extras. Since this feature is only used by the function graph
tracer and we can check the flag directly in the function graph tracer,
we can remove the fgraph_extras from the fgraph callback.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h               | 16 ++++------
 kernel/trace/fgraph.c                | 45 ++++++++++++++++++----------
 kernel/trace/ftrace.c                |  3 +-
 kernel/trace/trace.h                 |  3 +-
 kernel/trace/trace_functions_graph.c | 14 ++++-----
 kernel/trace/trace_irqsoff.c         |  3 +-
 kernel/trace/trace_sched_wakeup.c    |  3 +-
 kernel/trace/trace_selftest.c        |  8 ++---
 8 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2ac3b3b53cd0..997e1f0335b6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1068,29 +1068,20 @@ struct ftrace_graph_ret {
 	unsigned long long rettime;
 } __packed;
 
-struct fgraph_extras;
 struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 				       struct fgraph_ops *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
-				      struct fgraph_ops *,
-				      struct fgraph_extras *); /* entry */
+				      struct fgraph_ops *); /* entry */
 
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-				   struct fgraph_ops *gops,
-				   struct fgraph_extras *extras);
+				   struct fgraph_ops *gops);
 bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-/* Used to convey some extra datas when creating a graph entry */
-struct fgraph_extras {
-	u32 flags;
-	unsigned long retaddr;
-};
-
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
@@ -1131,12 +1122,15 @@ function_graph_enter(unsigned long ret, unsigned long func,
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
+unsigned long ftrace_graph_top_ret_addr(struct task_struct *task);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 u32 graph_tracer_flags_get(u32 flags);
+#define graph_tracer_flags_is_set(flags)	\
+	(graph_tracer_flags_get(flags) == (flags))
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 27e523f01ed2..ee829d65f301 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -290,8 +290,7 @@ static inline unsigned long make_data_type_val(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
-		     struct fgraph_extras *extras)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
 	return 0;
 }
@@ -519,8 +518,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops,
-			    struct fgraph_extras *extras)
+			    struct fgraph_ops *gops)
 {
 	return 0;
 }
@@ -648,20 +646,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
-	struct fgraph_extras extras;
 	unsigned long bitmap = 0;
 	int offset;
 	int i;
-	int idx = 0;
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	extras.flags = graph_tracer_flags_get(TRACE_GRAPH_PRINT_RETADDR);
-	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR)
-		&& extras.flags & TRACE_GRAPH_PRINT_RETADDR)
-		extras.retaddr = ftrace_graph_ret_addr(current, &idx, ret, retp);
-
 	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
 	if (offset < 0)
 		goto out;
@@ -670,7 +661,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, &extras))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -688,7 +679,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops, &extras))
+			    gops->entryfunc(&trace, gops))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -905,6 +896,29 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 	return ret_stack;
 }
 
+/**
+ * ftrace_graph_top_ret_addr - return the top return address in the shadow stack
+ * @task: The task to read the shadow stack from.
+ *
+ * Return the first return address on the shadow stack of the @task, which is
+ * not the fgraph's return_to_handler.
+ */
+unsigned long ftrace_graph_top_ret_addr(struct task_struct *task)
+{
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = task->curr_ret_stack;
+
+	if (offset < 0)
+		return 0;
+
+	do {
+		ret_stack = get_ret_stack(task, offset, &offset);
+	} while (ret_stack && ret_stack->ret == return_handler);
+
+	return ret_stack ? ret_stack->ret : 0;
+}
+
 /**
  * ftrace_graph_ret_addr - return the original value of the return address
  * @task: The task the unwinder is being executed on
@@ -1145,8 +1159,7 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops,
-			   struct fgraph_extras *extras)
+			   struct fgraph_ops *gops)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1160,7 +1173,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			return 0;
 	}
 
-	return gops->saved_func(trace, gops, NULL);
+	return gops->saved_func(trace, gops);
 }
 
 void fgraph_update_pid_func(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5d87dac83b80..cae388122ca8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -827,8 +827,7 @@ struct profile_fgraph_data {
 };
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops,
-			       struct fgraph_extras *extras)
+			       struct fgraph_ops *gops)
 {
 	struct profile_fgraph_data *profile_data;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 13f08f257c0b..6adf48ef4312 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -695,8 +695,7 @@ void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
-int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-		      struct fgraph_extras *extras);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3dd63ae2afe8..e3cda79653ee 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -179,8 +179,7 @@ struct fgraph_times {
 };
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops,
-		      struct fgraph_extras *extras)
+		      struct fgraph_ops *gops)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -246,11 +245,12 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) && extras
-				&& (extras->flags & TRACE_GRAPH_PRINT_RETADDR)))
-			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx,
-							  extras->retaddr);
-		else
+		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
+			graph_tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR))) {
+			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
+
+			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
+		} else
 			ret = __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret = 0;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index eb3aa36cf10f..fce064e20570 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -176,8 +176,7 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 }
 
 static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops,
-			       struct fgraph_extras *extras)
+			       struct fgraph_ops *gops)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 155de2551507..ae2ace5e515a 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -113,8 +113,7 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 }
 
 static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops,
-			      struct fgraph_extras *extras)
+			      struct fgraph_ops *gops)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index fbb99f8c8062..d3a14ae47e26 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -774,8 +774,7 @@ struct fgraph_fixture {
 };
 
 static __init int store_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops,
-			      struct fgraph_extras *extras)
+			      struct fgraph_ops *gops)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;
@@ -1026,8 +1025,7 @@ static unsigned int graph_hang_thresh;
 
 /* Wrap the real function entry probe to avoid possible hanging */
 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
-				      struct fgraph_ops *gops,
-				      struct fgraph_extras *extras)
+				      struct fgraph_ops *gops)
 {
 	/* This is harmlessly racy, we want to approximately detect a hang */
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
@@ -1041,7 +1039,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
 		return 0;
 	}
 
-	return trace_graph_entry(trace, gops, NULL);
+	return trace_graph_entry(trace, gops);
 }
 
 static struct fgraph_ops fgraph_ops __initdata  = {
-- 
2.34.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
