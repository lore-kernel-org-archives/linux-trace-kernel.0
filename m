Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A4155C97
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760200941; cv=none; b=pI8qJAa/4DLnWH2vEuGrJt1MjfPTAZUcOPep0nbwnlPoatt+FQOrUwzSN6BSRwxWxgwuYzP0TwZ+FovuRrRZERGBZ+wvRNVHv+GmvQ7QY3SvpiVw++CMk6jUDnHLtpn/IiejNQs6WKW+I6/hYMQdtTYruFxdpaCho7TW9VNFryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760200941; c=relaxed/simple;
	bh=ValV68N24lJvxwn2Uigjf6cHMhsSXjQEu8jXDj2z4+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcpOCdzwjq2NKY9jKIK+o9OEmf600X5gQMeJ1oElQWLNG7uLcVvc5pCk1MUSADxFitVhhglFBjUcjuFx5cXdS6UF8c7244O7MP2WCAdzha4M29GP/lPsTeu6q6ivxC64JrMcQpAvaYVM9plx/vRJAf6G+y4wtrUDGFlsfpGqDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrIAU0qo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrIAU0qo"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3306d93e562so3098740a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760200939; x=1760805739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZaSMS9dHEJmP4YXkgNdEhyB06pDwSQI5gFQYksg1gs=;
        b=LrIAU0qo+JChpJ6cbA3/uty0zz9ZGyWJUJt3dWUhDKB1oVKzMrq89qReuCz0JQXNPw
         BMP1ESZiHxMn29sy+WalBWZfNFgcuIsXop22ZmBECqSgGxwmxgGJuUkKPY0RGJ7Qv1yz
         Ib+LHztHd62sMsiVIhWhf6jZdp7gOd13oBTwUki54JwZWUPeb0sT4p6Ssjar78952NSa
         q/PEHmx/dBwSUGQdZ9ReAmvGTh06GueUC/slUd3a/opEYX1w7t5H9fHGe4UP/xqb60wH
         zrr+i0C9V7xhQAYt0v/6ORQl4oYEF0nf4OOhn4uzaRYE2rSYV7W2tEaVLLq4PkQl5whF
         1sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760200939; x=1760805739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZaSMS9dHEJmP4YXkgNdEhyB06pDwSQI5gFQYksg1gs=;
        b=V/qFZmHNUjABUXNO2JqwbVTjiVs5/uldaYo5r/EC9gDxvemILB/sgPy9Oq0pZJ6My6
         9YjLC2o9QzwdvQsRYNb3o3QlCpgPe4OEdyXHlaK6lWZ31DPdpLFkv5rahNzU1OlN2Nhm
         iji8F+xgz2uhIHltnOdmmxh42n466Ppo0RDu6HUmLBe1SQgGEwoyxt4l9KwggYecK8M7
         4XMZh+nlKBINBDfJkaGu7/U4vuvaGOoOcUMQD6SfHVJliidi8hrcAZezn1E/YXuTZchG
         EMwa5MP5eSVgxBbxRtbieAabSok0+zrK+wa3wiRDBhcOGYIJmST8vRhuuuKeg9ucQvw0
         CpJA==
X-Forwarded-Encrypted: i=1; AJvYcCXx90jkzGRYRHXBbC9AEESSwL5mCy9o5VInBf1ZBRmRsKsyKhSSgbi5Gab41LOgrDQFWk5BC2+4zlu26kely1gyeGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHSA8yoa6P6kqTRwzudyGXgzdpy0Tp2y3S/vrUCue7L21+Mex
	KmJaDDxwNQYKICZvgi43gAyAxVzYvcWiyhG615TRuHc67w3qeCg6ObVC
X-Gm-Gg: ASbGnctFTFT8Sm0rGco7NYHE3Ze/1DaIiDTHzNqC2V5A7/X60iXLf7+9SVJyCXSbcy6
	NhckbsKQ4+WueyRihweMhtivlHgryjRokeYIINI879s/4XWdfT9YnRKElH6bqoOdTzDsm76n0iQ
	HDt1qNDwQzj73JLDlukzim6gqo9+PaQzoS+3Bxpn5bEQvwqfnsBoLLp4QUMan1T1MHoEFjIL10q
	RaJQPBg+YT3HmHmR/azC7HcuYLmziEfYrQbufAeir4Z/rS4EwzJWT4Tm5lEAWlTrXDNOPoOQHhM
	2MgScGj9YqhGOJS4CoPp6L8HmfmLNY9hgHRN044v4qPWYmFbVvGCw8pYMmFFHvYDgRQ+EbZC+rb
	niXIHWZUX9AcurD8IPjK4IeiK60yttCf+lPuKQdxCT++KdWtfl7ays6SLOXw/ComDtImc
X-Google-Smtp-Source: AGHT+IFAmQ7ApfpcTMT2Vxkq7RSSuv/Dn5T76DunC9fuvDWecP1mNugDuMSZGDzo6X0bObLD4870Jw==
X-Received: by 2002:a17:90b:350e:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-33b513ebc36mr20891831a91.37.1760200938916;
        Sat, 11 Oct 2025 09:42:18 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d15e2sm6607454a91.21.2025.10.11.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 09:42:18 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH] function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously
Date: Sun, 12 Oct 2025 00:41:56 +0800
Message-Id: <20251011164156.3678012-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, funcgraph-args and funcgraph-retaddr cannot be used together. This patch
resolves the conflict by having funcgraph-retaddr reuse the implementation of
funcgraph-args -- specifically, storing the return address in the last entry of the
args array.

As a result, both features now coexist seamlessly and function as intended.

To verify the change, use perf to trace vfs_write with both options enabled:

 # perf_6_17 ftrace -G vfs_write --graph-opts args,retaddr
 ......
 0)               |  down_read(sem=0xffff8880100bea78) { /* <-n_tty_write+0xa3/0x540 */
 0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
 0)   0.079 us    |    preempt_count_add(val=1); /* <-down_read+0x3b/0x160 */
 0)   0.077 us    |    preempt_count_sub(val=1); /* <-down_read+0x8b/0x160 */
 0)   0.754 us    |  }

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 include/linux/ftrace.h               |  11 --
 kernel/trace/trace.h                 |   7 --
 kernel/trace/trace_entries.h         |  29 +-----
 kernel/trace/trace_functions_graph.c | 148 +++++++++++----------------
 kernel/trace/trace_selftest.c        |   1 -
 5 files changed, 58 insertions(+), 138 deletions(-)

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
index 85eabb454bee..956cdbe36995 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -47,7 +47,6 @@ enum trace_type {
 	TRACE_BRANCH,
 	TRACE_GRAPH_RET,
 	TRACE_GRAPH_ENT,
-	TRACE_GRAPH_RETADDR_ENT,
 	TRACE_USER_STACK,
 	TRACE_BLK,
 	TRACE_BPUTS,
@@ -540,8 +539,6 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct trace_branch, TRACE_BRANCH); \
 		IF_ASSIGN(var, ent, struct ftrace_graph_ent_entry,	\
 			  TRACE_GRAPH_ENT);		\
-		IF_ASSIGN(var, ent, struct fgraph_retaddr_ent_entry,\
-			  TRACE_GRAPH_RETADDR_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
@@ -955,10 +952,6 @@ extern void graph_trace_close(struct trace_iterator *iter);
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
index de294ae2c5c5..4e9d6779ccba 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -87,35 +87,9 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
 );
 
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-
-/* Function call entry with a return address */
-FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
-
-	TRACE_GRAPH_RETADDR_ENT,
-
-	F_STRUCT(
-		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned int,	graph_ent,	depth		)
-		__field_packed(	unsigned long,	graph_ent,	retaddr		)
-	),
-
-	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
-		(void *)__entry->retaddr)
-);
-
-#else
-
-#ifndef fgraph_retaddr_ent_entry
-#define fgraph_retaddr_ent_entry ftrace_graph_ent_entry
-#endif
-
-#endif
-
+/* Function return entry */
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 
-/* Function return entry */
 FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
@@ -138,7 +112,6 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 #else
 
-/* Function return entry */
 FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7f4b9a47a71..b618b6a673b7 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -16,6 +16,12 @@
 #include "trace.h"
 #include "trace_output.h"
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
+#define  STORE_RETADDR  1
+#else
+#define  STORE_RETADDR  0
+#endif
+
 /* When set, irq functions will be ignored */
 static int ftrace_graph_skip_irqs;
 
@@ -29,19 +35,17 @@ struct fgraph_cpu_data {
 
 struct fgraph_ent_args {
 	struct ftrace_graph_ent_entry	ent;
-	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
-	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+	/* Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS+STORE_RETADDR) entries,
+	 * and the last entry is used to store the retaddr
+	 */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS + STORE_RETADDR];
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
@@ -127,11 +131,19 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ent_entry *entry;
+	unsigned long retaddr = 0;
 	int size;
+	int i = 0;
 
 	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
 	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
 
+	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
+	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
+		retaddr = ftrace_graph_top_ret_addr(current);
+		size += sizeof(long);
+	}
+
 	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
 	if (!event)
 		return 0;
@@ -141,11 +153,17 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	if (fregs) {
-		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
+		for (; i < FTRACE_REGS_MAX_ARGS; i++)
 			entry->args[i] = ftrace_regs_get_argument(fregs, i);
 	}
 #endif
 
+	/*
+	 * Store retaddr to [0] if fregs is NULL, else to [FTRACE_REGS_MAX_ARGS]
+	 */
+	if (retaddr)
+		entry->args[i] = retaddr;
+
 	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
@@ -158,38 +176,6 @@ int __trace_graph_entry(struct trace_array *tr,
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
@@ -262,13 +248,7 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 		return 1;
 
 	trace_ctx = tracing_gen_ctx();
-	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
-	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
-		unsigned long retaddr = ftrace_graph_top_ret_addr(current);
-		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
-	} else {
-		ret = __graph_entry(tr, trace, trace_ctx, fregs);
-	}
+	ret = __graph_entry(tr, trace, trace_ctx, fregs);
 
 	return ret;
 }
@@ -634,13 +614,9 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
-				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			} else {
-				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+			int size = min((int)sizeof(data->ent), (int)iter->ent_size);
 
-				memcpy(&data->ent, curr, size);
-			}
+			memcpy(&data->ent, curr, size);
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
@@ -811,21 +787,21 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 
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
@@ -836,6 +812,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 {
 	unsigned long err_code = 0;
 	unsigned long retval = 0;
+	unsigned long retaddr = 0;
 	bool print_retaddr = false;
 	bool print_retval = false;
 	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
@@ -863,9 +840,6 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	}
 
 	if (entry) {
-		if (entry->ent.type != TRACE_GRAPH_RETADDR_ENT)
-			print_retaddr = false;
-
 		trace_seq_printf(s, "%ps", func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
@@ -874,6 +848,16 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 		} else
 			trace_seq_puts(s, "();");
 
+		if (print_retaddr) {
+			if (args_size > FTRACE_REGS_MAX_ARGS * sizeof(long))
+				retaddr = entry->args[FTRACE_REGS_MAX_ARGS];
+			else if (args_size == sizeof(long))
+				retaddr = entry->args[0];
+
+			if (!retaddr)
+				print_retaddr = false;
+		}
+
 		if (print_retval || print_retaddr)
 			trace_seq_puts(s, " /*");
 	} else {
@@ -882,8 +866,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	}
 
 	if (print_retaddr)
-		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
-				    trace_flags, false);
+		print_graph_retaddr(s, retaddr, trace_flags, false);
 
 	if (print_retval) {
 		if (hex_format || (err_code == 0))
@@ -1022,10 +1005,17 @@ print_graph_entry_nested(struct trace_iterator *iter,
 
 	trace_seq_puts(s, " {");
 
-	if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
-		entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
-		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
-			tr->trace_flags, true);
+	if (flags & __TRACE_GRAPH_PRINT_RETADDR) {
+		unsigned long retaddr = 0;
+
+		if (args_size > FTRACE_REGS_MAX_ARGS * sizeof(long))
+			retaddr = entry->args[FTRACE_REGS_MAX_ARGS];
+		else if (args_size == sizeof(long))
+			retaddr = entry->args[0];
+
+		if (retaddr)
+			print_graph_retaddr(s, retaddr, tr->trace_flags, true);
+	}
 	trace_seq_putc(s, '\n');
 
 	if (trace_seq_has_overflowed(s))
@@ -1202,7 +1192,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 	 * it can be safely saved at the stack.
 	 */
 	struct ftrace_graph_ent_entry *entry;
-	u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
+	u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + STORE_RETADDR) * sizeof(long)];
 
 	/* The ent_size is expected to be as big as the entry */
 	if (iter->ent_size > sizeof(save_buf))
@@ -1429,16 +1419,6 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 		trace_assign_type(field, entry);
 		return print_graph_entry(field, s, iter, flags);
 	}
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-	case TRACE_GRAPH_RETADDR_ENT: {
-		struct fgraph_retaddr_ent_entry saved;
-		struct fgraph_retaddr_ent_entry *rfield;
-
-		trace_assign_type(rfield, entry);
-		saved = *rfield;
-		return print_graph_entry((struct ftrace_graph_ent_entry *)&saved, s, iter, flags);
-	}
-#endif
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
@@ -1637,13 +1617,6 @@ static struct trace_event graph_trace_entry_event = {
 	.funcs		= &graph_functions,
 };
 
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-static struct trace_event graph_trace_retaddr_entry_event = {
-	.type		= TRACE_GRAPH_RETADDR_ENT,
-	.funcs		= &graph_functions,
-};
-#endif
-
 static struct trace_event graph_trace_ret_event = {
 	.type		= TRACE_GRAPH_RET,
 	.funcs		= &graph_functions
@@ -1730,13 +1703,6 @@ static __init int init_graph_trace(void)
 		return 1;
 	}
 
-#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-	if (!register_trace_event(&graph_trace_retaddr_entry_event)) {
-		pr_warn("Warning: could not register graph trace retaddr events\n");
-		return 1;
-	}
-#endif
-
 	if (!register_trace_event(&graph_trace_ret_event)) {
 		pr_warn("Warning: could not register graph trace events\n");
 		return 1;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index d88c44f1dfa5..c56f6f1bbac3 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -17,7 +17,6 @@ static inline int trace_valid_entry(struct trace_entry *entry)
 	case TRACE_PRINT:
 	case TRACE_BRANCH:
 	case TRACE_GRAPH_ENT:
-	case TRACE_GRAPH_RETADDR_ENT:
 	case TRACE_GRAPH_RET:
 		return 1;
 	}
-- 
2.34.1

