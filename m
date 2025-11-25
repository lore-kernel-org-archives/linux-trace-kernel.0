Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14472D9EC9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063274; cv=none; b=jWvGvVAUTZrh2WOlc9cDV9w+cDY7/n9Ee4HEGct0IDbPuBVG5icn8ilRRKOQCvkK8cq+CpOwa7T4bOPmDun0tNsfiYEvVMRHFy8hk8XkmJFqOeXHHiokRZy/nKZYGrinyKpp9J6B6TWCbbNSHuFVbHaR1OrypX/9q9SLLS8aMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063274; c=relaxed/simple;
	bh=W73rOX2XYbbKouvTe5iX6MDg3FQAjnQooaLN1B81Us4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUSIT2Hz3WpHIx8BjAgVM4HaYudF4D7km97VKZ9G34JuC/XNd7mamXpj60uewpbkPbBNr9nKOk5L2vfxM1PNPasD+GqUzX48gO0yLesutRbQz8mk6RMzC+JzOyc9xX1jb06P6gpzyDng+X9MCywJYu3SKIREss6ToAx50K5C/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZfWHJUP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZfWHJUP"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so6485968b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 01:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764063272; x=1764668072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1UVE57yy+vynht5D8BDeI8rC3nw3MmeJeiJkEQPL2w=;
        b=LZfWHJUP/NO11rZoXLSW9+pSuskCHTL9rQ/ERbAj4qyRykYAK1DFs9YiNIYmymD9nP
         7TvnbsEwMSshE8And6HY/da2pIGIS0UshS4dO8ENIDEOFMo3TauZfx03/myJr6oBfnDo
         dzVGqntQ4P7352Evf8j5fnsXWFQJRxrQNtQzDjj/fFjGQa+tnXn2u3qZMqC6c9rtRajH
         Q+HJo9YwL2CVH+K+NVUtksYMe/LI61zi+TPVktxA2EE6J/forFViQ+tB3Cj/1oFVDmot
         Qz4s6uV5PdgAqs21qSL1i0wALz5B1keQSnsEb930Dtv7bNiYwRBu/zD4BjZZc1v93qAp
         5ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764063272; x=1764668072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1UVE57yy+vynht5D8BDeI8rC3nw3MmeJeiJkEQPL2w=;
        b=p9aAVFlxVAzs5J1fWTDKVXDSwO2XyFn5vhPJpUdVN6noDg09b35IOXD+WyaROTUQr9
         dnS+Ala04aWyxA8cXfUB/8TzhnkxEkiah7XkOUMz+kUB8p12iJjcG7AiGg7iUPJGv1pb
         sQny9nhXb3sCKVovmvsImFYVdK6Gpa4fPRHgJIkR5MqmRxJxXi/jBRykSJ+mYTo9j4DE
         MgpdGh3MVfxoaJFG1X5TxGN1HnGBb7MTjbN28boHIxUwXc6JyL72SCKpwiS6ilppiT/Z
         QenDoAG2YDLleXajeK6/3iyz/kyyxGG9EV0nG1Ju8baQIkb/PHBr0nW80y82thKea0Mb
         oQ3w==
X-Gm-Message-State: AOJu0YyV5dnSD/K7vi2EwzfxcnC86VKkUu+Pc0Cl+oxKNvK6kNz2Cz2k
	+Ied0J2nua5c2QGy1O6qtUKKFbe9MveTOf1TVWlTtTTKhNgu2PVg6R95
X-Gm-Gg: ASbGncv1Tug2vL7IDe1tEpEQIGE0z0bzxPGN1bvKH/EbBuk3g2DYPDhBffsZMQ7xTl2
	vIKtZg/7HtGE9pUQlEI9qMNuKiMqcTgT0PMBmJbBGODDfZ5u4lZ4O+0k6CJvO/czlF679+RPjnP
	4EYp0W+W7nOEtISwOp+V8WHOlGpzVBqfBIgtQi5pGpZNCBamVl9HSfJxNeaT9r7ZDhxDLD7fdP+
	DzlH/slc4ZD+bZnlbFrVOQGKQNwFe2+BROo1Q/XEYao6IY+kMpeBlqp53OYeF6Via+GJiGANVf9
	6p9J1iK+H6a6kcQ51MVpaK3Qf2yFc6OHdKMTnDb93+pI7VF2nLtKKxpVpfF4+0gQUdIgwn+DaSN
	jjpPAobEMFbHyHfdYm5VCrM2N0cWofPZ6yFv03B0kMPKRwNf2YRsLoAJI3OyUSb/ObHc/rqVhkw
	jGizO/teWHGNnm
X-Google-Smtp-Source: AGHT+IHeWZbgLw0zBrpQCOorNB/jK+D2AG8H1C0Zw0s74yByY9RqOCiy+DoJMSu3SsC4xy14z1WnQQ==
X-Received: by 2002:a05:6a20:3c90:b0:35d:8881:e6ce with SMTP id adf61e73a8af0-3614eccadc8mr18049549637.26.1764063272010;
        Tue, 25 Nov 2025 01:34:32 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174d2c0sm17361155b3a.66.2025.11.25.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 01:34:31 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v9] function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously
Date: Tue, 25 Nov 2025 17:34:25 +0800
Message-Id: <20251125093425.2563849-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, the funcgraph-args and funcgraph-retaddr features are
mutually exclusive. This patch resolves this limitation by allowing
funcgraph-retaddr to have an args array.

To verify the change, use perf to trace vfs_write with both options
enabled:

Before:
 # perf ftrace -G vfs_write --graph-opts args,retaddr
   ......
   down_read() { /* <-n_tty_write+0xa3/0x540 */
     __cond_resched(); /* <-down_read+0x12/0x160 */
     preempt_count_add(); /* <-down_read+0x3b/0x160 */
     preempt_count_sub(); /* <-down_read+0x8b/0x160 */
   }

After:
 # perf ftrace -G vfs_write --graph-opts args,retaddr
   ......
   down_read(sem=0xffff8880100bea78) { /* <-n_tty_write+0xa3/0x540 */
     __cond_resched(); /* <-down_read+0x12/0x160 */
     preempt_count_add(val=1); /* <-down_read+0x3b/0x160 */
     preempt_count_sub(val=1); /* <-down_read+0x8b/0x160 */
   }

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
v9:
- Fix typo
- Link to v8: https://lore.kernel.org/linux-trace-kernel/20251125092711.2558787-1-dolinux.peng@gmail.com/

v8:
- Add the retaddr member back and reconstruct the patch
- Rebase on the trace/for-next branch
- Link to v7: https://lore.kernel.org/linux-trace-kernel/20251114025522.2115359-1-dolinux.peng@gmail.com/

v7:
- Remove nr_args to eliminate a multiplication instruction
- Link to v6: https://lore.kernel.org/all/20251114023453.2061590-1-dolinux.peng@gmail.com/

v6:
- Initialize retaddr to NULL to silence uninitialized variable warning.
- Use ARGS_OFFS(size) macro instead of args_offs variable to eliminate
  "set but not used" warning
- Link to v5: https://lore.kernel.org/all/20251113072938.333657-1-dolinux.peng@gmail.com/

v5:
- Avoid unnecessary branch overhead by first verifying
  CONFIG_FUNCTION_GRAPH_RETADDR is enabled prior to testing
  the TRACE_GRAPH_PRINT_RETADDR flag
- Link to v4: https://lore.kernel.org/all/20251112093650.3345108-1-dolinux.peng@gmail.com/

v4:
- Remove redundant TRACE_GRAPH_ARGS flag check
- Eliminate unnecessary retaddr initialization
- Resend to add missing add Acked-by tags
- Link to v3: https://lore.kernel.org/all/20251112034333.2901601-1-dolinux.peng@gmail.com/

v3:
- Replace min() with min_t() to improve type safety and maintainability
- Keep only one Signed-off-by for cleaner attribution
- Code refactoring for improved readability
- Link to v2: https://lore.kernel.org/all/20251111135432.2143993-1-dolinux.peng@gmail.com/

v2:
- Preserve retaddr event functionality (suggested by Steven)
- Store the retaddr in args[0] (suggested by Steven)
- Refactor implementation logic and commit message clarity
- Link to v1: https://lore.kernel.org/all/20251011164156.3678012-1-dolinux.peng@gmail.com/
---
 include/linux/ftrace.h               |  7 +--
 kernel/trace/trace.h                 | 24 +++++++++-
 kernel/trace/trace_entries.h         | 15 +++---
 kernel/trace/trace_functions_graph.c | 71 ++++++++++++++++++----------
 4 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..6ca9c6229d93 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1126,17 +1126,14 @@ static inline void ftrace_init(void) { }
  */
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
-	int depth;
+	unsigned long depth;
 } __packed;
 
 /*
  * Structure that defines an entry function trace with retaddr.
- * It's already packed but the attribute "packed" is needed
- * to remove extra padding at the end.
  */
 struct fgraph_retaddr_ent {
-	unsigned long func; /* Current function */
-	int depth;
+	struct ftrace_graph_ent ent;
 	unsigned long retaddr;  /* Return address */
 } __packed;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 58be6d741d72..a06d836b7d92 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -962,7 +962,8 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern int __trace_graph_retaddr_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
 				unsigned int trace_ctx,
-				unsigned long retaddr);
+				unsigned long retaddr,
+				struct ftrace_regs *fregs);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx,
@@ -2287,4 +2288,25 @@ static inline int rv_init_interface(void)
  */
 #define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
 
+/*
+ * This is used to get the address of the args array based on
+ * the type of the entry.
+ */
+#define FGRAPH_ENTRY_ARGS(e)						\
+	({								\
+		unsigned long *_args;					\
+		struct ftrace_graph_ent_entry *_e = e;			\
+									\
+		if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&	\
+			e->ent.type == TRACE_GRAPH_RETADDR_ENT) {	\
+			struct fgraph_retaddr_ent_entry *_re;		\
+									\
+			_re = (typeof(_re))_e;				\
+			_args = _re->args;				\
+		} else {						\
+			_args = _e->args;				\
+		}							\
+		_args;							\
+	})
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index de294ae2c5c5..f6a8d29c0d76 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -80,11 +80,11 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned int,	graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	depth		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
+	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
 );
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
@@ -95,13 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 	TRACE_GRAPH_RETADDR_ENT,
 
 	F_STRUCT(
-		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned int,	graph_ent,	depth		)
-		__field_packed(	unsigned long,	graph_ent,	retaddr		)
+		__field_struct(	struct fgraph_retaddr_ent,	graph_rent	)
+		__field_packed(	unsigned long,	graph_rent.ent,	func		)
+		__field_packed(	unsigned long,	graph_rent.ent,	depth		)
+		__field_packed(	unsigned long,	graph_rent,	retaddr		)
+		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
+	F_printk("--> %ps (%lu) <- %ps", (void *)__entry->func, __entry->depth,
 		(void *)__entry->retaddr)
 );
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 44d5dc5031e2..8a075d3c4563 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -36,14 +36,19 @@ struct fgraph_ent_args {
 	unsigned long			args[FTRACE_REGS_MAX_ARGS];
 };
 
+struct fgraph_retaddr_ent_args {
+	struct fgraph_retaddr_ent_entry	ent;
+	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+};
+
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
 	union {
 		struct fgraph_ent_args		ent;
-		/* TODO allow retaddr to have args */
-		struct fgraph_retaddr_ent_entry	rent;
+		struct fgraph_retaddr_ent_args	rent;
 	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
@@ -160,20 +165,32 @@ int __trace_graph_entry(struct trace_array *tr,
 int __trace_graph_retaddr_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
 				unsigned int trace_ctx,
-				unsigned long retaddr)
+				unsigned long retaddr,
+				struct ftrace_regs *fregs)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct fgraph_retaddr_ent_entry *entry;
+	int size;
+
+	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
+	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
 
 	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_ENT,
-					  sizeof(*entry), trace_ctx);
+					  size, trace_ctx);
 	if (!event)
 		return 0;
 	entry	= ring_buffer_event_data(event);
-	entry->graph_ent.func = trace->func;
-	entry->graph_ent.depth = trace->depth;
-	entry->graph_ent.retaddr = retaddr;
+	entry->graph_rent.ent = *trace;
+	entry->graph_rent.retaddr = retaddr;
+
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	if (fregs) {
+		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
+			entry->args[i] = ftrace_regs_get_argument(fregs, i);
+	}
+#endif
+
 	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
@@ -182,7 +199,8 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 int __trace_graph_retaddr_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
 				unsigned int trace_ctx,
-				unsigned long retaddr)
+				unsigned long retaddr,
+				struct ftrace_regs *fregs)
 {
 	return 1;
 }
@@ -267,7 +285,8 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
 	    tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_RETADDR)) {
 		unsigned long retaddr = ftrace_graph_top_ret_addr(current);
-		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
+		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx,
+						  retaddr, fregs);
 	} else {
 		ret = __graph_entry(tr, trace, trace_ctx, fregs);
 	}
@@ -654,13 +673,9 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
-				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			} else {
-				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+			int size = min_t(int, sizeof(data->rent), iter->ent_size);
 
-				memcpy(&data->ent, curr, size);
-			}
+			memcpy(&data->rent, curr, size);
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
@@ -838,7 +853,7 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
 		trace_seq_puts(s, " /*");
 
 	trace_seq_puts(s, " <-");
-	seq_print_ip_sym_offset(s, entry->graph_ent.retaddr, trace_flags);
+	seq_print_ip_sym_offset(s, entry->graph_rent.retaddr, trace_flags);
 
 	if (comment)
 		trace_seq_puts(s, " */");
@@ -984,7 +999,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 		trace_seq_printf(s, "%ps", (void *)ret_func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
-			print_function_args(s, entry->args, ret_func);
+			print_function_args(s, FGRAPH_ENTRY_ARGS(entry), ret_func);
 			trace_seq_putc(s, ';');
 		} else
 			trace_seq_puts(s, "();");
@@ -1036,7 +1051,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
 
 	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
-		print_function_args(s, entry->args, func);
+		print_function_args(s, FGRAPH_ENTRY_ARGS(entry), func);
 	else
 		trace_seq_puts(s, "()");
 
@@ -1218,11 +1233,14 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 	/*
 	 * print_graph_entry() may consume the current event,
 	 * thus @field may become invalid, so we need to save it.
-	 * sizeof(struct ftrace_graph_ent_entry) is very small,
-	 * it can be safely saved at the stack.
+	 * This function is shared by ftrace_graph_ent_entry and
+	 * fgraph_retaddr_ent_entry, the size of the latter one
+	 * is larger, but it is very small and can be safely saved
+	 * at the stack.
 	 */
 	struct ftrace_graph_ent_entry *entry;
-	u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
+	struct fgraph_retaddr_ent_entry *rentry;
+	u8 save_buf[sizeof(*rentry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
 
 	/* The ent_size is expected to be as big as the entry */
 	if (iter->ent_size > sizeof(save_buf))
@@ -1451,12 +1469,17 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 	case TRACE_GRAPH_RETADDR_ENT: {
-		struct fgraph_retaddr_ent_entry saved;
+		/*
+		 * ftrace_graph_ent_entry and fgraph_retaddr_ent_entry have
+		 * similar functions and memory layouts. The only difference
+		 * is that the latter one has an extra retaddr member, so
+		 * they can share most of the logic.
+		 */
 		struct fgraph_retaddr_ent_entry *rfield;
 
 		trace_assign_type(rfield, entry);
-		saved = *rfield;
-		return print_graph_entry((struct ftrace_graph_ent_entry *)&saved, s, iter, flags);
+		return print_graph_entry((struct ftrace_graph_ent_entry *)rfield,
+					  s, iter, flags);
 	}
 #endif
 	case TRACE_GRAPH_RET: {
-- 
2.34.1

