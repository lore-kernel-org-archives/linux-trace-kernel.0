Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120221FF30
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939634; cv=none; b=JbEukxT4x7fak/sOp8wt8N05hwSPnFoVIK7zf4oK27RzDKlaUHp8SHCYMSiaVi7R+KENRQT7QwDiBasAh2fPBPLoBb0Ow7lST/2RkXU0FgypzJ9X4kvPOCovL5iNHs3biJuTf36Jo5LV943UwT1j0f1yR/psA44AOGXLl79+g7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939634; c=relaxed/simple;
	bh=HqNPMcGO41VMVWfbXlY485k9jz8TxTTHPVr26oTdcfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6DIi6g6yDKtkuuit+bpQU5jZyM5hc0KUvyagGRQWkQ9fYiCbKD6FmQAgmXVI1L5Go2aFFBBqgx7c/uGsIekkBdFimINlwWeHIXm2GRDRXLgWCcaM1D40oVbGti+hBLel9HkX2MipWJUoDxhPUGrSoDFmYrnuTQNiMDT1Wq5B7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKuEhHGz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKuEhHGz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so42499b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762939632; x=1763544432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWAF+DcIzKVsqUgqpqYnDQaKPe3mFgq/8tqp38w38N0=;
        b=BKuEhHGzeO5/R22NtFdmHPXKwdGhwhGkr8+BebMg7UMMP+yn+mt9NHQyBqnj3Spgsf
         xw2jwF+PuvxkBa85/EHDR4jewW21oX/oChXHW1o1ZmU8sqHiFmYzLys7qxytDGkaucoU
         Nzqoq4AXsPaznYfo5P7nYNK8sDDIjY0O9oWWfYqhpXQyWChMcMvkyD+OfUY7p26BlzeW
         Jqe+VhcxYUUcyqpobRGhjeC+h6dXXIqMAyQq5vUgcCz0H4S88vB/pelzF2QVWPAsxZ7E
         Vhwiy83G79oWb8ReNCzYKuRgQ/JKVbLDdeO4Oyj7i115mMeQWyf01VTcfBJdpTw4c9Ls
         t5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939632; x=1763544432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWAF+DcIzKVsqUgqpqYnDQaKPe3mFgq/8tqp38w38N0=;
        b=XKteehYBxOBnLHBDX0wEggzf4LgowofRiUIP6878KuDT53xfs7Ee2oBFxg4/MH4bBw
         BQRXtN6iHAURacLe+ZJlX2EmpFR0cEG0tMCSoF8OlPfFOdzLj5fTRABO9EQW+RasypxX
         cKt3f82vT8cFNEJ51z7m9hjiEbwVk7ZFth6k1+GXLbxNP+0+PlswRIcsZNI0v81kMRS7
         JIPwpu3OsqB1oqEwtYsBbZUDNAXiFdUSnlBFezhfsXs0qicfaHSeN4eeocZFAsqVwXYW
         ce7AOdy8btn3zZw1is01nZZ//brlJt2af23XLE6VZuyJgSsKySaB1f4T/dvXf1S+qzxK
         L70g==
X-Gm-Message-State: AOJu0Yx1Ib7wLQ70nJ0O+uRwgg646eYaSUlQjC1S+yP6iMKpgn7Z4eSH
	M1/BH66i43hDWpAxSODGw4vz6rbNSXV3pjGc+WDaA9LQNIgXB4urq286
X-Gm-Gg: ASbGncs2eLGApIB7f0wvZr0Hg5ZPZcWI2Xx3DCOim5Rarft9uCfVF17mCvvbCus1jfi
	Y2Eqtt2z2xtLv2cO/zoqEaQBCkzOEWA3vtzg0oIUlBH2Qbkf4lHEEeuizkGUcOG8VQs4NrA3phF
	VqScnVhZc3bNkpeKnG22YqIbcNgBJpCyZi4n3azyHmAy7iCXrkHVAGEsTeus6ZeESqXJImdfl1e
	l9MDO2reVeVaJLJ9WzpiLKwhrD5/4ZzKV+fD2SGi6m4Uc093A2YCyYM+zzsGxkybTN9x778xBdn
	qf6xySFKAJ41jzkOLB2tNPoQximVbsHbnKwlu3NdhArtkOul06/wZwTNoY0p/rtfa3w1WqyI1o2
	HymM+YR/A4pYEGFxzBCmewqM/n4BVd29CsDqa1nFVNcY8eblmEmWDY2wBbsR/XB6nXawyTefLiT
	MDn+xb4Td7xVZdnPyw
X-Google-Smtp-Source: AGHT+IFxcPyPy6rxGmvjgfbLQgrlYXX5a5VU+olbz9t9p7JEyYDvqx2roqdHDsi2nX9SXHbsAZVq3A==
X-Received: by 2002:a17:90b:53cf:b0:340:d1a1:af8e with SMTP id 98e67ed59e1d1-343ddef4c14mr3077208a91.37.1762939631861;
        Wed, 12 Nov 2025 01:27:11 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e1ab45e4sm780286a91.0.2025.11.12.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:27:10 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4] function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously
Date: Wed, 12 Nov 2025 17:27:01 +0800
Message-Id: <20251112092701.3335601-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Currently, the funcgraph-args and funcgraph-retaddr features are
mutually exclusive. This patch resolves this limitation by modifying
funcgraph-retaddr to adopt the same implementation approach as
funcgraph-args, specifically by storing the return address in the
first entry of the args array.

As a result, both features now coexist seamlessly and function as
intended.

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
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
v4:
- Remove redundant TRACE_GRAPH_ARGS flag check
- Eliminate unnecessary retaddr initialization

v3:
- Replace min() with min_t() to improve type safety and maintainability
- Keep only one Signed-off-by for cleaner attribution
- Code refactoring for improved readability

v2:
- Preserve retaddr event functionality (suggested by Steven)
- Store the retaddr in args[0] (suggested by Steven)
- Refactor implementation logic and commit message clarity
---
 include/linux/ftrace.h               |  11 ---
 kernel/trace/trace.h                 |   4 -
 kernel/trace/trace_entries.h         |   6 +-
 kernel/trace/trace_functions_graph.c | 141 ++++++++++++---------------
 4 files changed, 65 insertions(+), 97 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..88cb54d73bdb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
 	int depth;
 } __packed;
 
-/*
- * Structure that defines an entry function trace with retaddr.
- * It's already packed but the attribute "packed" is needed
- * to remove extra padding at the end.
- */
-struct fgraph_retaddr_ent {
-	unsigned long func; /* Current function */
-	int depth;
-	unsigned long retaddr;  /* Return address */
-} __packed;
-
 /*
  * Structure that defines a return function trace.
  * It's already packed but the attribute "packed" is needed
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 85eabb454bee..9fac291b913a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -955,10 +955,6 @@ extern void graph_trace_close(struct trace_iterator *iter);
 extern int __trace_graph_entry(struct trace_array *tr,
 			       struct ftrace_graph_ent *trace,
 			       unsigned int trace_ctx);
-extern int __trace_graph_retaddr_entry(struct trace_array *tr,
-				struct ftrace_graph_ent *trace,
-				unsigned int trace_ctx,
-				unsigned long retaddr);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx,
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index de294ae2c5c5..593a74663c65 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 	TRACE_GRAPH_RETADDR_ENT,
 
 	F_STRUCT(
-		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
+		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
 		__field_packed(	unsigned int,	graph_ent,	depth		)
-		__field_packed(	unsigned long,	graph_ent,	retaddr		)
+		__dynamic_array(unsigned long,	args				)
 	),
 
 	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
-		(void *)__entry->retaddr)
+		(void *)__entry->args[0])
 );
 
 #else
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7f4b9a47a71..8c018886d4d2 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -16,6 +16,15 @@
 #include "trace.h"
 #include "trace_output.h"
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+#define HAVE_RETADDR	1
+#define ARGS_OFFS(args_size) \
+	((args_size) > FTRACE_REGS_MAX_ARGS * sizeof(long) ? 1 : 0)
+#else
+#define HAVE_RETADDR	0
+#define ARGS_OFFS(args_size)	0
+#endif
+
 /* When set, irq functions will be ignored */
 static int ftrace_graph_skip_irqs;
 
@@ -27,21 +36,25 @@ struct fgraph_cpu_data {
 	unsigned long	enter_funcs[FTRACE_RETFUNC_DEPTH];
 };
 
+/*
+ * fgraph_retaddr_ent_entry and ftrace_graph_ent_entry share layout, ent
+ * member repurposed for storage
+ */
 struct fgraph_ent_args {
 	struct ftrace_graph_ent_entry	ent;
-	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
-	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+	/*
+	 * Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR)
+	 * entries with the first entry storing the return address for
+	 * TRACE_GRAPH_RETADDR_ENT.
+	 */
+	unsigned long		args[FTRACE_REGS_MAX_ARGS + HAVE_RETADDR];
 };
 
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
-	union {
-		struct fgraph_ent_args		ent;
-		/* TODO allow retaddr to have args */
-		struct fgraph_retaddr_ent_entry	rent;
-	};
+	struct fgraph_ent_args		ent;
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -127,22 +140,39 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ent_entry *entry;
-	int size;
+	unsigned long retaddr;
+	int size = sizeof(*entry);
+	int type = TRACE_GRAPH_ENT;
+	int nr_args = 0, args_offs = 0;
+
+	if (tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
+		retaddr = ftrace_graph_top_ret_addr(current);
+		type = TRACE_GRAPH_RETADDR_ENT;
+		nr_args += 1;
+	}
 
 	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
-	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
+	if (!!fregs)
+		nr_args += FTRACE_REGS_MAX_ARGS;
 
-	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
+	size += nr_args * sizeof(long);
+	event = trace_buffer_lock_reserve(buffer, type, size, trace_ctx);
 	if (!event)
 		return 0;
 
 	entry = ring_buffer_event_data(event);
 	entry->graph_ent = *trace;
 
+	/* Store the retaddr in args[0] */
+	if (type == TRACE_GRAPH_RETADDR_ENT) {
+		entry->args[0] = retaddr;
+		args_offs += 1;
+	}
+
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	if (fregs) {
+	if (nr_args >= FTRACE_REGS_MAX_ARGS) {
 		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
-			entry->args[i] = ftrace_regs_get_argument(fregs, i);
+			entry->args[i + args_offs] = ftrace_regs_get_argument(fregs, i);
 	}
 #endif
 
@@ -158,38 +188,6 @@ int __trace_graph_entry(struct trace_array *tr,
 	return __graph_entry(tr, trace, trace_ctx, NULL);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-int __trace_graph_retaddr_entry(struct trace_array *tr,
-				struct ftrace_graph_ent *trace,
-				unsigned int trace_ctx,
-				unsigned long retaddr)
-{
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
-	struct fgraph_retaddr_ent_entry *entry;
-
-	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_ENT,
-					  sizeof(*entry), trace_ctx);
-	if (!event)
-		return 0;
-	entry	= ring_buffer_event_data(event);
-	entry->graph_ent.func = trace->func;
-	entry->graph_ent.depth = trace->depth;
-	entry->graph_ent.retaddr = retaddr;
-	trace_buffer_unlock_commit_nostack(buffer, event);
-
-	return 1;
-}
-#else
-int __trace_graph_retaddr_entry(struct trace_array *tr,
-				struct ftrace_graph_ent *trace,
-				unsigned int trace_ctx,
-				unsigned long retaddr)
-{
-	return 1;
-}
-#endif
-
 static inline int ftrace_graph_ignore_irqs(void)
 {
 	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
@@ -211,7 +209,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 	struct trace_array *tr = gops->private;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
-	int ret = 0;
 
 	if (*task_var & TRACE_GRAPH_NOTRACE)
 		return 0;
@@ -262,15 +259,7 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 		return 1;
 
 	trace_ctx = tracing_gen_ctx();
-	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
-	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
-		unsigned long retaddr = ftrace_graph_top_ret_addr(current);
-		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
-	} else {
-		ret = __graph_entry(tr, trace, trace_ctx, fregs);
-	}
-
-	return ret;
+	return __graph_entry(tr, trace, trace_ctx, fregs);
 }
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
@@ -634,13 +623,9 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
-				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			} else {
-				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+			int size = min_t(int, sizeof(data->ent), iter->ent_size);
 
-				memcpy(&data->ent, curr, size);
-			}
+			memcpy(&data->ent, curr, size);
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
@@ -811,21 +796,21 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 #define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
-static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_entry *entry,
-				u32 trace_flags, bool comment)
+static void print_graph_retaddr(struct trace_seq *s, unsigned long retaddr, u32 trace_flags,
+				bool comment)
 {
 	if (comment)
 		trace_seq_puts(s, " /*");
 
 	trace_seq_puts(s, " <-");
-	seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
+	seq_print_ip_sym(s, retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
 
 	if (comment)
 		trace_seq_puts(s, " */");
 }
 #else
 #define __TRACE_GRAPH_PRINT_RETADDR 0
-#define print_graph_retaddr(_seq, _entry, _tflags, _comment)		do { } while (0)
+#define print_graph_retaddr(_seq, _retaddr, _tflags, _comment)		do { } while (0)
 #endif
 
 #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
@@ -869,10 +854,12 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 		trace_seq_printf(s, "%ps", func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
-			print_function_args(s, entry->args, (unsigned long)func);
+			print_function_args(s, entry->args + ARGS_OFFS(args_size),
+					    (unsigned long)func);
 			trace_seq_putc(s, ';');
-		} else
+		} else {
 			trace_seq_puts(s, "();");
+		}
 
 		if (print_retval || print_retaddr)
 			trace_seq_puts(s, " /*");
@@ -882,8 +869,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	}
 
 	if (print_retaddr)
-		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
-				    trace_flags, false);
+		print_graph_retaddr(s, entry->args[0], trace_flags, false);
 
 	if (print_retval) {
 		if (hex_format || (err_code == 0))
@@ -964,10 +950,12 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 		trace_seq_printf(s, "%ps", (void *)ret_func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
-			print_function_args(s, entry->args, ret_func);
+			print_function_args(s, entry->args + ARGS_OFFS(args_size),
+					    ret_func);
 			trace_seq_putc(s, ';');
-		} else
+		} else {
 			trace_seq_puts(s, "();");
+		}
 	}
 	trace_seq_putc(s, '\n');
 
@@ -1016,7 +1004,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
 
 	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
-		print_function_args(s, entry->args, func);
+		print_function_args(s, entry->args + ARGS_OFFS(args_size), func);
 	else
 		trace_seq_puts(s, "()");
 
@@ -1024,8 +1012,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 
 	if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
 		entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
-		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
-			tr->trace_flags, true);
+		print_graph_retaddr(s, entry->args[0], tr->trace_flags, true);
 	trace_seq_putc(s, '\n');
 
 	if (trace_seq_has_overflowed(s))
@@ -1202,7 +1189,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 	 * it can be safely saved at the stack.
 	 */
 	struct ftrace_graph_ent_entry *entry;
-	u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
+	u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR) * sizeof(long)];
 
 	/* The ent_size is expected to be as big as the entry */
 	if (iter->ent_size > sizeof(save_buf))
@@ -1429,16 +1416,12 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 		trace_assign_type(field, entry);
 		return print_graph_entry(field, s, iter, flags);
 	}
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 	case TRACE_GRAPH_RETADDR_ENT: {
-		struct fgraph_retaddr_ent_entry saved;
 		struct fgraph_retaddr_ent_entry *rfield;
 
 		trace_assign_type(rfield, entry);
-		saved = *rfield;
-		return print_graph_entry((struct ftrace_graph_ent_entry *)&saved, s, iter, flags);
+		return print_graph_entry((typeof(field))rfield, s, iter, flags);
 	}
-#endif
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
-- 
2.34.1

