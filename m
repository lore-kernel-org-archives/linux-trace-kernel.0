Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA572E613A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062840; cv=none; b=elmPsl/CMIuMFwFaJa7yDJHFgnJ6sWngT3ROiAtsEn6JY4jklwz6xCshFGTGy6dCR5sB9Rrpevz+c4Nru+FNZYzpeYL1YrfIyONoBQ8ix1CJ3mN/8C7yx4f5ti74KLZzqPcvsPt88Tn402O4aXnJ1X+U5c36pQNoZsVbf7rGZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062840; c=relaxed/simple;
	bh=KzayFlwK7ulaSY5h4Nfq1PA3v2PPRbmVn9FA7wpUjjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hnXA3UWxUYx7nK21uUIxOBQn0jNpGkBDU0u1F8gxZPg1tuiX8a0IKuhbteUA84b+eK1h01iBpef9Z8MIJ5YX1xF330TbmEUoWbPDpGLhzStUD58VzLm99MUP0MHZKvEC4FvkMbRD10UBQ33EgHXTA6LKl/sgEXy6E08v8u8NV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+deZVnW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+deZVnW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba49f92362so3061793b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764062837; x=1764667637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2juxySKyn1fmrQg9Vi4fMT6rQH7rPO6NwRqpHFTUY6Q=;
        b=S+deZVnWpioJCZnmBys/HrGo8XlUy284s09MaX0UMIJcxGUa5qqIiS7k3ZhfgaV9ls
         i+4cjl6bB2hH1xhtVawCvNrQX9ZCtu7hpu5U1PSks61d0rGQ51WMpYw7JTLwGO2doDT2
         yvXYG+lhsZaqNNgmIM1UT1N10OKmGU4bOUv6af8Qx9EWelbN2pn1WFKKJ3Lrm6M34kQr
         sdMp6c/0BxTn8fDJfHHHxljNeOaKzLVjT9c5ObyYfcBaNc58f3NfSk5V7NmS+0QwgYfE
         JodzWn78ElED7mpIZNZD9n9KGK2COmkXoA5F40iQLDQMCSba4JYs1t6803tgyYqjCa7D
         k5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764062837; x=1764667637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2juxySKyn1fmrQg9Vi4fMT6rQH7rPO6NwRqpHFTUY6Q=;
        b=X++E/lz7xvh5yUwvmZ+MyCCeyv2SvCXMPNLhvWR6YCc1Sfwy32Fl89v4x9TBi5sptE
         zHuB9D/Iu1/w+g56JBCMPILzNbAiK1lH9n97m/oUHuHi+5ABBGD15ShkWF5uxVpluw5O
         mpaxuwFGsJeV9yteCKJsmzAd/T50d1JuNxqYSnkvVXnbkaiJGsqXOoEYm54m/gpxZg0E
         jPty0zHUDeiWguAZMcHtR5L+Mq5oMIiedTF8dtgfNJoF0Pyk5AlwMAhAthOqwzhQkRud
         gVqjMDpdnv+wmkcX/7y9oaNRBBccVRxUW7lF6T2rLzw2MIKnRFjDbHursNxSL9B/Sy2W
         ZGmA==
X-Gm-Message-State: AOJu0Yy0ZgAQpq/W7h8MrTZE7ZxFKH4pUOFGFYCMDeO9xCWdsPD0o44K
	dz8RxdTJ+70eglMWBZSBUik4GFJgpmoymRetqxji+WQyZBOyTjRJE8xNDs5j5ULmpoA=
X-Gm-Gg: ASbGnctHiTKM8yi4sF/AgMcIZi5z04/3uW95VUC6s0r5CfxHFD1eb+iTpXUiBtFCjVE
	ElhBBLoiFZmnaF8FwXWM3gKhjDhO3+skVDQcJucWLhhMeJgiqrdWgavKsoCHLbazNhDXR2xJiSG
	fsLmV0hs5pVzuhf2su9IePtM1NF41FD7MRh+gauPIGnEahnMVAUtEVSNhdHpofAuRXOk6AMqu3i
	M2pJ+hSyQ9AHhbY55dKLXGQOFKzXHo28eQeoQMmMugkVEiifd+9a4NEHkLS8TU15mYJnt6szPhg
	gsjTPCYn9fUjRwPpgkfbHNPUEVHMhvF8a0CcdhxRNoO5dLmFrQ2uqjeMe5akn8YsIlozFR2xSdC
	xxYf+BTT7LNbPbPnmUk1zR2wtStrcu4SG6FhV7eG4jxTHoZFjRGHBet91L+uGKQ9kS6RWeuW+PQ
	caHEBboNt+SLcxSMGy5Qf0jGkJHECdriu3oJDBqg==
X-Google-Smtp-Source: AGHT+IGq7FWTiSRpMjplb+Jhvuq6nmL8VaYuYWNGf3oFTepm+y1j90mkrBdwEDgYK/4Wu9JRK8jQ+g==
X-Received: by 2002:a05:6a20:939f:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-3614f4affeamr16210301637.16.1764062837202;
        Tue, 25 Nov 2025 01:27:17 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf80f4csm17296252b3a.8.2025.11.25.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 01:27:16 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH for-next v8] function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously
Date: Tue, 25 Nov 2025 17:27:11 +0800
Message-Id: <20251125092711.2558787-1-dolinux.peng@gmail.com>
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
index 44d5dc5031e2..b04dcbdb236f 100644
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
+		 * is that the latter once has an extra retaddr member, so
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

