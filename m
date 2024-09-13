Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDB1DA0E4;
	Fri, 13 Sep 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230911; cv=none; b=BQ4jvf1Z/KwYyEu7iVIMyBRq06G3aU8CXZQKUonpW3qtzzxilTb6n/umL48uYtULYC8Aqi/xh2KW/4Xq/XyWM6+DmmxhLT2dkv/3WRw5zXQ2b0jRS2qE66QU6PpHgmMwqYNUMCX/syTfaEfXQWkhCtQ3xtO7cFmT43Qy5p2QaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230911; c=relaxed/simple;
	bh=c6w70f521w/xoEluJzvl2xfFHrJJLPYfCXNSSTF0tgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRexLYULYrrk0UypbdHXozcSZNtlCLNDjZVgVWyZN5xT7LSGRkqqO5kWa3a7/SIihUP9Xaf8bHQiHWEBASo9keR+DDD7+72jE16yYQBOhSLa2aSqBVTvBsLgfEhMJ8B5PuMHf/XRb+Zjjd8Mx91nIY2Bw9KX+cZahUAZejv7XdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZg1wS4h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZg1wS4h"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1715968a12.2;
        Fri, 13 Sep 2024 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726230909; x=1726835709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yhOxtG1pzo3nqqYUWJpOgtTp4sm+WRejdol7PoXjgE=;
        b=VZg1wS4hA/t0Rk0Z8D58DGZaI9A4LKm4XOUikF42hE2NnL9WHsg6wL3e/bcCLtiqL1
         WtQ8/zwOj9BgtVSC0sd9V7Eyd7T66Gf0zIqbCJfR/2IE9xOX8fUl4eRReJYIuwSntAD6
         kv/Qjj/ligOFijWcDsOcxQwB3JFK97RVph0CcZuh0Go6J4yUG/CF0yq7Q/emEg1BqgRR
         OQEThd5+QYKomTEHXMhcEvNwuFS617g3wFG7AZZoO3sJ5eTqLbQUHA3PCUTLl8Xg+fUH
         Sbl/aCVJjXXysrUOFGKGDpN4ppjbybliereHXMUHtdEQW9TI30mogXvqKspEwJrUHSV0
         NEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230909; x=1726835709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yhOxtG1pzo3nqqYUWJpOgtTp4sm+WRejdol7PoXjgE=;
        b=OOOjU5hMuQQN2X1qVSn9BZbq1kX0aAry63jq6zmueV1sS5xozF/ehQSiW9htk4y8hy
         3JBLJuCQ6VF0F1VGY6bhiRrwCRj62YcCYTQOf96ymsH+VVYfrqzGKgfxNebA/sqCHJAZ
         A5TNnyTnHBgbMvoenHhN9HI7mcfgyywIfy/WtEojg4HVvuAG3nJH/MtTzS+N2EgQTDx6
         87tePB5PmB5/JT1ZEyBbfC84nFZR4iVhxUxh9vaXSTI0rOEHuvYkZqMjIjNLJ52SwxP6
         Vy7A0OUpAHOCZAN8neMywvGGM2I14y2u0MjfQJ8lf59EtRwH3sPpN265YGaGewEseBGZ
         fZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWUenMFCCdzlMPD89WQyLgvVnCxYNJP1QkFE5mjuz/Lj9C3LoDJxomOBmyf2jQ403luttBW+2h4On9EgtY6OR4Q+h8@vger.kernel.org, AJvYcCXSjEAAgMKz/wnkicI6L+y9WZSYf0AllTAcstbM0r7643px+D25qB9MB4DFbsTsC0C9ejYqT+EiiKzHdKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Wa+px0Y/SsVdmaQ6bXImM4hiWKkZ41q3YNbRYdK2XR4GpjX1
	S27sMbezphJccATag7vrmIA8rKr+C1lyd964TmvW9KdPPgWmB4ED
X-Google-Smtp-Source: AGHT+IHpkblSnNt3HzymkJi7ZceVY1WChpeWAtMkXaGCrwMh7RBZUkF3fD+mXZGzB0YCdsNU0K04uQ==
X-Received: by 2002:a17:90b:3616:b0:2cc:ef14:89e3 with SMTP id 98e67ed59e1d1-2db9ffcab27mr6634208a91.15.1726230908363;
        Fri, 13 Sep 2024 05:35:08 -0700 (PDT)
Received: from ubuntu.localdomain ([219.143.180.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ceeec4sm1607597a91.43.2024.09.13.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:35:07 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v1] function_graph: Support recording and printing the function return address
Date: Fri, 13 Sep 2024 05:34:56 -0700
Message-Id: <20240913123456.600950-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using function_graph tracer to analyze the flow of kernel function
execution, it is often necessary to quickly locate the exact line of code
where the call occurs. While this may be easy at times, it can be more
time-consuming when some functions are inlined or the flow is too long.

This feature aims to simplify the process by recording the return address
of traced funcions and printing it when outputing trace logs.

To enhance human readability, the prefix 'ret=' is used for the kernel return
value, while '<-' serves as the prefix for the return address in trace logs to
make it look more like the function tracer.

A new trace option named 'funcgraph-retaddr' has been introduced, and the
existing option 'sym-addr' can be used to control the format of the return
address.

See below logs with both funcgraph-retval and funcgraph-retaddr enabled.

Then, we can use the faddr2line to locate the source code, for example:

0)             | load_elf_binary() { /* <-bprm_execve+0x249/0x600 */
0)             |   load_elf_phdrs() { /* <-load_elf_binary+0x84/0x1730 */
0)             |     __kmalloc_noprof() { /* <-load_elf_phdrs+0x4a/0xb0 */
0)   3.657 us  |       __cond_resched(); /* <-__kmalloc_noprof+0x28c/0x390 ret=0x0 */
0) + 24.335 us |     } /* __kmalloc_noprof ret=0xffff8882007f3000 */
0)             |     kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */
0)             |       rw_verify_area() { /* <-kernel_read+0x2b/0x50 */
0)             |         security_file_permission() { /* <-kernel_read+0x2b/0x50 */
0)             |           selinux_file_permission() { /* <-security_file_permission+0x26/0x40 */
0)             |             __inode_security_revalidate() { /* <-selinux_file_permission+0x6d/0x140 */
0)   2.034 us  |               __cond_resched(); /* <-__inode_security_revalidate+0x5f/0x80 ret=0x0 */
0)   6.602 us  |             } /* __inode_security_revalidate ret=0x0 */
0)   2.214 us  |             avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 ret=0x0 */
0) + 16.670 us |           } /* selinux_file_permission ret=0x0 */
0) + 20.809 us |         } /* security_file_permission ret=0x0 */
0) + 25.217 us |       } /* rw_verify_area ret=0x0 */
0)             |       __kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */
0)             |         ext4_file_read_iter() { /* <-__kernel_read+0x160/0x2e0 */

$ ./scripts/faddr2line ./vmlinux load_elf_phdrs+0x6c/0xb0
load_elf_phdrs+0x6c/0xb0:
elf_read at fs/binfmt_elf.c:471
(inlined by) load_elf_phdrs at fs/binfmt_elf.c:531

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
rfc -> v1:
 - Invoke 'ftrace_graph_ret_addr' to obtain the actual return address
 - Refine the prefix preceding the return addess and the return value
 - Print the return address firstly when both funcgraph-retval and
   funcgraph-retaddr are enabled
 - Create a new event named 'fgraph_retaddr_entry' in order not to save the
   return address to the ring buffer when 'funcgraph-retaddr' is disabled,
   thereby reducing memory overhead
 - Add a kernel config named CONFIG_FUNCTION_GRAPH_RETADDR
 - Update fgraph-retval.tc
---
 include/linux/ftrace.h                        |  27 ++-
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/fgraph.c                         |  21 +-
 kernel/trace/ftrace.c                         |   3 +-
 kernel/trace/trace.h                          |  11 +-
 kernel/trace/trace_entries.h                  |  19 +-
 kernel/trace/trace_functions_graph.c          | 211 ++++++++++++++----
 kernel/trace/trace_irqsoff.c                  |   3 +-
 kernel/trace/trace_sched_wakeup.c             |   3 +-
 kernel/trace/trace_selftest.c                 |   1 +
 .../ftrace/test.d/ftrace/fgraph-retval.tc     |   2 +-
 11 files changed, 254 insertions(+), 57 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..8a0d878f6c9c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1014,6 +1014,17 @@ struct ftrace_graph_ent {
 	int depth;
 } __packed;
 
+/*
+ * Structure that defines an entry function trace with retaddr.
+ * It's already packed but the attribute "packed" is needed
+ * to remove extra padding at the end.
+ */
+struct fgraph_retaddr_ent {
+	unsigned long func; /* Current function */
+	int depth;
+	unsigned long retaddr;  /* Return address */
+} __packed;
+
 /*
  * Structure that defines a return function trace.
  * It's already packed but the attribute "packed" is needed
@@ -1031,19 +1042,29 @@ struct ftrace_graph_ret {
 	unsigned long long rettime;
 } __packed;
 
+struct fgraph_extras;
 struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 				       struct fgraph_ops *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
-				      struct fgraph_ops *); /* entry */
+				      struct fgraph_ops *,
+				      struct fgraph_extras *); /* entry */
 
-extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
+				   struct fgraph_ops *gops,
+				   struct fgraph_extras *extras);
 bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+/* Used to convey some extra datas when creating a graph entry */
+struct fgraph_extras {
+	u32 flags;
+	unsigned long retaddr;
+};
+
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
@@ -1092,6 +1113,8 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
 unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
+u32 graph_tracer_flags_get(u32 flags);
+
 /*
  * Sometimes we don't want to trace a function with the function
  * graph tracer but we want them to keep traced by the usual function
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 721c3b221048..74c2b1d43bb9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -242,6 +242,16 @@ config FUNCTION_GRAPH_RETVAL
 	  enable it via the trace option funcgraph-retval.
 	  See Documentation/trace/ftrace.rst
 
+config FUNCTION_GRAPH_RETADDR
+	bool "Kernel Function Graph Return Address"
+	depends on FUNCTION_GRAPH_TRACER
+	default n
+	help
+	  Support recording and printing the function return address when
+	  using function graph tracer. It can be helpful to locate code line that
+	  the function is called. This feature is off by default, and you can
+	  enable it via the trace option funcgraph-retaddr.
+
 config DYNAMIC_FTRACE
 	bool "enable/disable function tracing dynamically"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..e6f019ca11c2 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -290,7 +290,8 @@ static inline unsigned long make_data_type_val(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
+		     struct fgraph_extras *extras)
 {
 	return 0;
 }
@@ -484,7 +485,8 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops)
+			    struct fgraph_ops *gops,
+			    struct fgraph_extras *extras)
 {
 	return 0;
 }
@@ -616,13 +618,19 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	struct fgraph_extras extras;
 	unsigned long bitmap = 0;
 	int offset;
 	int i;
+	int idx = 0;
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
+	extras.flags = graph_tracer_flags_get(TRACE_GRAPH_PRINT_RETADDR);
+	if (extras.flags & TRACE_GRAPH_PRINT_RETADDR)
+		extras.retaddr = ftrace_graph_ret_addr(current, &idx, ret, retp);
+
 	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
 	if (offset < 0)
 		goto out;
@@ -631,7 +639,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, &extras))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -649,7 +657,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops))
+			    gops->entryfunc(&trace, gops, &extras))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -1119,7 +1127,8 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops)
+			   struct fgraph_ops *gops,
+			   struct fgraph_extras *extras)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1133,7 +1142,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			return 0;
 	}
 
-	return gops->saved_func(trace, gops);
+	return gops->saved_func(trace, gops, NULL);
 }
 
 void fgraph_update_pid_func(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4c28dd177ca6..707ae465ed62 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -821,7 +821,8 @@ void ftrace_graph_graph_time_control(bool enable)
 }
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct fgraph_extras *extras)
 {
 	struct ftrace_ret_stack *ret_stack;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd3e3069300e..eea43426e3fe 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -46,6 +46,7 @@ enum trace_type {
 	TRACE_BRANCH,
 	TRACE_GRAPH_RET,
 	TRACE_GRAPH_ENT,
+	TRACE_GRAPH_RETADDR_ENT,
 	TRACE_USER_STACK,
 	TRACE_BLK,
 	TRACE_BPUTS,
@@ -505,6 +506,8 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct trace_branch, TRACE_BRANCH); \
 		IF_ASSIGN(var, ent, struct ftrace_graph_ent_entry,	\
 			  TRACE_GRAPH_ENT);		\
+		IF_ASSIGN(var, ent, struct fgraph_retaddr_ent_entry,\
+			  TRACE_GRAPH_RETADDR_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
@@ -683,7 +686,8 @@ void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
-int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+		      struct fgraph_extras *priv);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
@@ -870,6 +874,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_GRAPH_TIME          0x400
 #define TRACE_GRAPH_PRINT_RETVAL        0x800
 #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
+#define TRACE_GRAPH_PRINT_RETADDR       0x2000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
@@ -891,6 +896,10 @@ extern void graph_trace_close(struct trace_iterator *iter);
 extern int __trace_graph_entry(struct trace_array *tr,
 			       struct ftrace_graph_ent *trace,
 			       unsigned int trace_ctx);
+extern int __trace_graph_retaddr_entry(struct trace_array *tr,
+				struct ftrace_graph_ent *trace,
+				unsigned int trace_ctx,
+				unsigned long retaddr);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index c47422b20908..fa214c1d2409 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -85,9 +85,25 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
 );
 
-/* Function return entry */
+/* Function call entry with a return address */
+FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
+
+	TRACE_GRAPH_RETADDR_ENT,
+
+	F_STRUCT(
+		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
+		__field_packed(	unsigned long,	graph_ent,	func		)
+		__field_packed(	int,		graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	retaddr		)
+	),
+
+	F_printk("--> %ps (%d) <- %ps", (void *)__entry->func, __entry->depth,
+		(void *)__entry->retaddr)
+);
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 
+/* Function return entry */
 FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
@@ -110,6 +126,7 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 #else
 
+/* Function return entry */
 FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 13d0387ac6a6..962f29b2a26c 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -31,7 +31,10 @@ struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
-	struct ftrace_graph_ent_entry	ent;
+	union {
+		struct ftrace_graph_ent_entry	ent;
+		struct fgraph_retaddr_ent_entry	rent;
+	} ent;
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -63,6 +66,10 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
 	/* Display function return value in hexadecimal format ? */
 	{ TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
+#endif
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+	/* Display function return address ? */
+	{ TRACER_OPT(funcgraph-retaddr, TRACE_GRAPH_PRINT_RETADDR) },
 #endif
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
@@ -83,6 +90,11 @@ static struct tracer_flags tracer_flags = {
 	.opts = trace_opts
 };
 
+u32 graph_tracer_flags_get(u32 flags)
+{
+	return tracer_flags.val & flags;
+}
+
 /*
  * DURATION column is being also used to display IRQ signs,
  * following values are used by print_graph_irq and others
@@ -119,6 +131,40 @@ int __trace_graph_entry(struct trace_array *tr,
 	return 1;
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+int __trace_graph_retaddr_entry(struct trace_array *tr,
+				struct ftrace_graph_ent *trace,
+				unsigned int trace_ctx,
+				unsigned long retaddr)
+{
+	struct trace_event_call *call = &event_fgraph_retaddr_entry;
+	struct ring_buffer_event *event;
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct fgraph_retaddr_ent_entry *entry;
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_ENT,
+					  sizeof(*entry), trace_ctx);
+	if (!event)
+		return 0;
+	entry	= ring_buffer_event_data(event);
+	entry->graph_ent.func = trace->func;
+	entry->graph_ent.depth = trace->depth;
+	entry->graph_ent.retaddr = retaddr;
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		trace_buffer_unlock_commit_nostack(buffer, event);
+
+	return 1;
+}
+#else
+int __trace_graph_retaddr_entry(struct trace_array *tr,
+				struct ftrace_graph_ent *trace,
+				unsigned int trace_ctx,
+				unsigned long retaddr)
+{
+	return 0;
+}
+#endif
+
 static inline int ftrace_graph_ignore_irqs(void)
 {
 	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
@@ -128,7 +174,8 @@ static inline int ftrace_graph_ignore_irqs(void)
 }
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops)
+		      struct fgraph_ops *gops,
+		      struct fgraph_extras *extras)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -180,7 +227,12 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		ret = __trace_graph_entry(tr, trace, trace_ctx);
+		if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) && extras
+				&& (extras->flags & TRACE_GRAPH_PRINT_RETADDR)))
+			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx,
+							  extras->retaddr);
+		else
+			ret = __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret = 0;
 	}
@@ -457,7 +509,7 @@ get_return_for_leaf(struct trace_iterator *iter,
 	 * then we just reuse the data from before.
 	 */
 	if (data && data->failed) {
-		curr = &data->ent;
+		curr = &data->ent.ent;
 		next = &data->ret;
 	} else {
 
@@ -487,7 +539,10 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			data->ent = *curr;
+			if (curr->ent.type == TRACE_GRAPH_RETADDR_ENT)
+				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
+			else
+				data->ent.ent = *curr;
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
@@ -649,52 +704,97 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
-
 #define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
+#else
+#define __TRACE_GRAPH_PRINT_RETVAL 0
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+#define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
+static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_entry *entry,
+				u32 trace_flags, bool comment)
+{
+	if (comment)
+		trace_seq_puts(s, " /*");
+
+	trace_seq_puts(s, " <-");
+	seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
+
+	if (comment)
+		trace_seq_puts(s, " */");
+}
+#else
+#define __TRACE_GRAPH_PRINT_RETADDR 0
+#define print_graph_retaddr(_seq, _entry, _tflags, _comment)		do { } while (0)
+#endif
 
-static void print_graph_retval(struct trace_seq *s, unsigned long retval,
-				bool leaf, void *func, bool hex_format)
+#if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
+
+static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
+				struct ftrace_graph_ret *graph_ret,
+				u32 opt_flags, u32 trace_flags)
 {
 	unsigned long err_code = 0;
+	unsigned long retval = 0;
+	bool print_retaddr = false;
+	bool print_retval = false;
+	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
+	void *func = (void *)graph_ret->func;
+
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	retval = graph_ret->retval;
+	print_retval = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL);
+#endif
 
-	if (retval == 0 || hex_format)
-		goto done;
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+	print_retaddr = !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
+#endif
 
-	/* Check if the return value matches the negative format */
-	if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
-		(((u64)retval) >> 32) == 0) {
-		/* sign extension */
-		err_code = (unsigned long)(s32)retval;
-	} else {
-		err_code = retval;
+	if (print_retval && retval && !hex_format) {
+		/* Check if the return value matches the negative format */
+		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
+			(((u64)retval) >> 32) == 0) {
+			err_code = sign_extend64(retval, 31);
+		} else {
+			err_code = retval;
+		}
+
+		if (!IS_ERR_VALUE(err_code))
+			err_code = 0;
 	}
 
-	if (!IS_ERR_VALUE(err_code))
-		err_code = 0;
+	if (entry) {
+		if (entry->ent.type != TRACE_GRAPH_RETADDR_ENT)
+			print_retaddr = false;
 
-done:
-	if (leaf) {
-		if (hex_format || (err_code == 0))
-			trace_seq_printf(s, "%ps(); /* = 0x%lx */\n",
-					func, retval);
+		trace_seq_printf(s, "%ps();", func);
+		if (print_retval || print_retaddr)
+			trace_seq_puts(s, " /*");
 		else
-			trace_seq_printf(s, "%ps(); /* = %ld */\n",
-					func, err_code);
+			trace_seq_putc(s, '\n');
 	} else {
+		print_retaddr = false;
+		trace_seq_printf(s, "} /* %ps", func);
+	}
+
+	if (print_retaddr)
+		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
+				    trace_flags, false);
+
+	if (print_retval) {
 		if (hex_format || (err_code == 0))
-			trace_seq_printf(s, "} /* %ps = 0x%lx */\n",
-					func, retval);
+			trace_seq_printf(s, " ret=0x%lx", retval);
 		else
-			trace_seq_printf(s, "} /* %ps = %ld */\n",
-					func, err_code);
+			trace_seq_printf(s, " ret=%ld", err_code);
 	}
+
+	if (!entry || print_retval || print_retaddr)
+		trace_seq_puts(s, " */\n");
 }
 
 #else
 
-#define __TRACE_GRAPH_PRINT_RETVAL 0
-
-#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} while (0)
+#define print_graph_retval(_seq, _ent, _ret, _opt_flags, _trace_flags) do {} while (0)
 
 #endif
 
@@ -743,12 +843,11 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 		trace_seq_putc(s, ' ');
 
 	/*
-	 * Write out the function return value if the option function-retval is
-	 * enabled.
+	 * Write out the function return value if the option funcgraph-retval or
+	 * funcgraph-retaddr is enabled.
 	 */
-	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
-		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
-				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
+	if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RETADDR))
+		print_graph_retval(s, entry, graph_ret, flags, tr->trace_flags);
 	else
 		trace_seq_printf(s, "%ps();\n", (void *)call->func);
 
@@ -788,7 +887,12 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
+	trace_seq_printf(s, "%ps() {", (void *)call->func);
+	if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
+		entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
+		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
+			tr->trace_flags, true);
+	trace_seq_putc(s, '\n');
 
 	if (trace_seq_has_overflowed(s))
 		return TRACE_TYPE_PARTIAL_LINE;
@@ -1030,11 +1134,10 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 
 	/*
 	 * Always write out the function name and its return value if the
-	 * function-retval option is enabled.
+	 * funcgraph-retval option is enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
-		print_graph_retval(s, trace->retval, false, (void *)trace->func,
-			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
+		print_graph_retval(s, NULL, trace, flags, tr->trace_flags);
 	} else {
 		/*
 		 * If the return function does not have a matching entry,
@@ -1149,7 +1252,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	 * to print out the missing entry which would never go out.
 	 */
 	if (data && data->failed) {
-		field = &data->ent;
+		field = &data->ent.ent;
 		iter->cpu = data->cpu;
 		ret = print_graph_entry(field, s, iter, flags);
 		if (ret == TRACE_TYPE_HANDLED && iter->cpu != cpu) {
@@ -1173,6 +1276,14 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 		saved = *field;
 		return print_graph_entry(&saved, s, iter, flags);
 	}
+	case TRACE_GRAPH_RETADDR_ENT: {
+		struct fgraph_retaddr_ent_entry saved;
+		struct fgraph_retaddr_ent_entry *rfield;
+
+		trace_assign_type(rfield, entry);
+		saved = *rfield;
+		return print_graph_entry((struct ftrace_graph_ent_entry *)&saved, s, iter, flags);
+	}
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
@@ -1367,6 +1478,13 @@ static struct trace_event graph_trace_entry_event = {
 	.funcs		= &graph_functions,
 };
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+static struct trace_event graph_trace_retaddr_entry_event = {
+	.type		= TRACE_GRAPH_RETADDR_ENT,
+	.funcs		= &graph_functions,
+};
+#endif
+
 static struct trace_event graph_trace_ret_event = {
 	.type		= TRACE_GRAPH_RET,
 	.funcs		= &graph_functions
@@ -1453,6 +1571,13 @@ static __init int init_graph_trace(void)
 		return 1;
 	}
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+	if (!register_trace_event(&graph_trace_retaddr_entry_event)) {
+		pr_warn("Warning: could not register graph trace retaddr events\n");
+		return 1;
+	}
+#endif
+
 	if (!register_trace_event(&graph_trace_ret_event)) {
 		pr_warn("Warning: could not register graph trace events\n");
 		return 1;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..eb3aa36cf10f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -176,7 +176,8 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 }
 
 static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct fgraph_extras *extras)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 130ca7e7787e..742b9de14ddb 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -113,7 +113,8 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 }
 
 static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops)
+			      struct fgraph_ops *gops,
+			      struct fgraph_extras *extras)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index c4ad7cd7e778..d3a14ae47e26 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -17,6 +17,7 @@ static inline int trace_valid_entry(struct trace_entry *entry)
 	case TRACE_PRINT:
 	case TRACE_BRANCH:
 	case TRACE_GRAPH_ENT:
+	case TRACE_GRAPH_RETADDR_ENT:
 	case TRACE_GRAPH_RET:
 		return 1;
 	}
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
index e34c0bdef3ed..e8e46378b88d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
@@ -29,7 +29,7 @@ set -e
 
 : "Test printing the error code in signed decimal format"
 echo 0 > options/funcgraph-retval-hex
-count=`cat trace | grep 'proc_reg_write' | grep '= -5' | wc -l`
+count=`cat trace | grep 'proc_reg_write' | grep '=-5' | wc -l`
 if [ $count -eq 0 ]; then
     fail "Return value can not be printed in signed decimal format"
 fi
-- 
2.25.1

