Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A03A5E8B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730716; cv=none; b=KIm5TXTVn9s/SWrglgrHLj8u/ef8nBf0Y7M2mqevk66UOTeJpjL3T5G+kQ1rbjxgXrS0XFLMoWd2gzTn4ZPcmkdgi9YHf3TI5G2JGsDb26HvHUSvE2iN9QFjRWcYv1buVocXmpkuMcta65NliAbRJjosLLPWx9ZDhdkrfoWSbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730716; c=relaxed/simple;
	bh=y0s0UN6lryG4rGB2GrYsjoqHZQL8wlF28XVqWSBQTas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmmPS/0H2ApSh1sY6k3z9P5Vw3BjP2w5Rc5shXw0qNUWKefAKDgZU7fWEJZ3KlIFqe50pXmaxxR8cdK/VhsZLOihkzrex7zw604JX+19lFQe0Zpq1lTWNDomt/zQssdseZ2icYcvL+12ojn0n37GRKN5Du9SYIcptSsdAYF7fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRBAaJj+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRBAaJj+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so69113195ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730714; x=1779335514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7tCgSV8knNsj3DI/25Run/pnZ2u7KyEH4bA5BHmKpY=;
        b=oRBAaJj+XFsHcCu64SJjfzja4YVjf/GE7ItIml64JpgHqVPavNyzt68VoYe5MWXqlz
         MptwBMySapn4pqvrAon8RwNaXiD4ouUgIEcAM8htu7aFbLTs9VvARZODFi8shry8xogv
         voDtYz9kaFMZ2Sj96DQKWFM8M7IJoLhppKMdDWElmSyG4BTZrtR36d/AxZdmMY0k8SDZ
         9/pdWQ08952qFEyB10X6kTOzspihRd+eIh3LL2BhyGS1lFy6ztE0y7a6qWrqyjMbQ3tk
         GNfw2YYAPOeQctowlzp1Ewd9j2cebG0tkGL9ZXFepP70Pb+QoJZ4q6Bvz/W9psn/Pwnu
         G5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730714; x=1779335514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7tCgSV8knNsj3DI/25Run/pnZ2u7KyEH4bA5BHmKpY=;
        b=fb7RV4utMa8CzaZ/dq6FJHEfdxLKBVsv3oicJldHLlNBS0FTHVRQsK/fbGxpOphHAB
         gQKhZF+cFMwH6MPo/w6Y7a3QNZADx+IbEEZ0B5PTb64cbIfIlSBc8EFx/7jk7I4hkuAA
         MjVSwxn82YwnL3DDekQwjyLiYUq+44qh3jflVUHft63+yLL2K+dSGU664NM6dItJPkwV
         tUon2ONgcRuYeyem2idNd7UNw5aoRhKPzMgLXD+aycteaKoG5CeMs98eQNXzw38RTyTb
         Gvx6ClJGZjcaTHreGc9KiyR42u9+cfDTPq0iFFcN99Z2j6wbGU7viAMCaKXNS4SIJiBm
         0pKg==
X-Gm-Message-State: AOJu0YxpfikDmZ+wrLxpwElTVjmWetw1XjXJIo+T96cqOOK+q1f4RUOT
	FfuYRS6mNeUMG3pMqXyO0Huuumr6wYIlVhEQ3mRqme5U5VM/5Bz8NRSBWBWJtTyMF3k=
X-Gm-Gg: Acq92OHhiJQCiJGzuvyYARYZ275c0r4G29A0ulS6A5Ef5lrKMcprFmZ9uX59pC+fURM
	CtyP6C1igXCGM+qc3LzKZzS45rUvmllawNHZtSGZwEmVufjXQZ/v+Btsx/7EjW0TccVmAoHQ9xN
	giaKh1FJM9V8Ms+aNQa3d5I2QfcphPQQ0mgv7UQT1gW7xawc6Gt4sUfS9gqdLIwL7XKk5rqjooB
	RwWnnlFJfrs8v2vsXrK6QIigvbmGEr+decISI5Iy6VsOWd+XNVJzMre7WXnOLILFjlXCW36SSyY
	XxnzZdekkUQVCyI+P1orIiOYbR1QkgsOoULunHg0MqvRLoU9wVjN/dKbeORgXW8XeXMrUcZPWyf
	fotaPuzeMGXi9UVfjs+LNdBslVLTGFc6OHjIv+rNBhjVtMoW5FE0B6SJdUylX3lRBhfpj9lcbqO
	0RlMkPsuI/J+EVWYbKgIgXOMBmVv/AfGk7mA9MuQ==
X-Received: by 2002:a17:903:198c:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2bd276f899fmr68562255ad.34.1778730714300;
        Wed, 13 May 2026 20:51:54 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3771:9b3a:64a3:f42d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm8189435ad.6.2026.05.13.20.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:51:53 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Thu, 14 May 2026 11:49:15 +0800
Message-Id: <20260514034916.2162517-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add TRACE_STACK_ID event type and integrate ftrace_stackmap into
__ftrace_trace_stack(). When the 'stackmap' trace option is enabled,
the stack recording path stores a 4-byte stack_id in the ring buffer
instead of the full stack trace.

Changes:
- New TRACE_STACK_ID in trace_type enum
- New stack_id_entry in trace_entries.h (just 'int stack_id')
- New TRACE_ITER_STACKMAP trace option flag
- Modified __ftrace_trace_stack() to call ftrace_stackmap_get_id()
  when stackmap option is active
- Added stack_id print handler in trace_output.c
- Added stackmap field to struct trace_array (per-instance support)

The stack_id event is committed unconditionally (no filter check)
since it is a synthetic side-event tied to the parent event which
was already subject to filtering.

Fallback behavior: if stackmap returns an error (pool exhausted or
resetting), the full stack trace is recorded as before.

Usage:
  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c         | 46 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h         | 16 +++++++++++++
 kernel/trace/trace_entries.h | 15 ++++++++++++
 kernel/trace/trace_output.c  | 23 ++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..c72cb8491217 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -57,6 +57,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_stackmap.h"
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
@@ -2184,6 +2185,37 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * If stackmap dedup is enabled, try to store only the stack_id
+	 * in the ring buffer instead of the full stack trace.
+	 */
+	if (tr->trace_flags & TRACE_ITER_STACKMAP) {
+		struct stack_id_entry *sid_entry;
+		int sid;
+
+		sid = ftrace_stackmap_get_id(tr->stackmap, fstack->calls, nr_entries);
+		if (sid >= 0) {
+			event = __trace_buffer_lock_reserve(buffer,
+					TRACE_STACK_ID,
+					sizeof(*sid_entry), trace_ctx);
+			if (!event)
+				goto out;
+			sid_entry = ring_buffer_event_data(event);
+			sid_entry->stack_id = sid;
+			/*
+			 * stack_id is a synthetic side-event attached to a
+			 * primary trace event that was already subject to
+			 * filtering. No per-event filter is defined for
+			 * TRACE_STACK_ID, so commit unconditionally.
+			 */
+			__buffer_unlock_commit(buffer, event);
+			goto out;
+		}
+		/* Fall through to full stack on stackmap failure */
+	}
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -9222,6 +9254,20 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 			NULL, &tracing_dyn_info_fops);
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	global_trace.stackmap = ftrace_stackmap_create();
+	if (!IS_ERR(global_trace.stackmap)) {
+		trace_create_file("stack_map", TRACE_MODE_WRITE, NULL,
+				global_trace.stackmap, &ftrace_stackmap_fops);
+		trace_create_file("stack_map_stat", TRACE_MODE_READ, NULL,
+				global_trace.stackmap, &ftrace_stackmap_stat_fops);
+		trace_create_file("stack_map_bin", TRACE_MODE_READ, NULL,
+				global_trace.stackmap, &ftrace_stackmap_bin_fops);
+	} else {
+		pr_warn("ftrace stackmap init failed, dedup disabled\n");
+		global_trace.stackmap = NULL;
+	}
+#endif
 	create_trace_instances(NULL);
 
 	update_tracer_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..74f421a89347 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -57,6 +57,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_STACK_ID,
 
 	__TRACE_LAST_TYPE,
 };
@@ -453,6 +454,9 @@ struct trace_array {
 	struct cond_snapshot	*cond_snapshot;
 #endif
 	struct trace_func_repeats	__percpu *last_func_repeats;
+#ifdef CONFIG_FTRACE_STACKMAP
+	struct ftrace_stackmap		*stackmap;
+#endif
 	/*
 	 * On boot up, the ring buffer is set to the minimum size, so that
 	 * we do not waste memory on systems that are not using tracing.
@@ -579,6 +583,8 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
 			  TRACE_FUNC_REPEATS);				\
+		IF_ASSIGN(var, ent, struct stack_id_entry,		\
+			  TRACE_STACK_ID);				\
 		__ftrace_bad_type();					\
 	} while (0)
 
@@ -1449,7 +1455,16 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+# define STACKMAP_FLAGS				\
+			C(STACKMAP,		"stackmap"),
+#else
+# define STACKMAP_FLAGS
+# define TRACE_ITER_STACKMAP		0UL
+#endif
+
 #ifdef CONFIG_FUNCTION_PROFILER
+
 # define PROFILER_FLAGS					\
 		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
 # ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -1506,6 +1521,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
+		STACKMAP_FLAGS					\
 		BRANCH_FLAGS					\
 		PROFILER_FLAGS					\
 		FPROFILE_FLAGS
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 54417468fdeb..89ed14b7e5fd 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -250,6 +250,21 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
+/*
+ * Stack ID entry - stores only a stack_id referencing the stackmap.
+ * Used when CONFIG_FTRACE_STACKMAP is enabled to deduplicate stacks.
+ */
+FTRACE_ENTRY(stack_id, stack_id_entry,
+
+	TRACE_STACK_ID,
+
+	F_STRUCT(
+		__field(	int,		stack_id	)
+	),
+
+	F_printk("<stack_id %d>", __entry->stack_id)
+);
+
 /*
  * trace_printk entry:
  */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..68678ea88159 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1517,6 +1517,28 @@ static struct trace_event trace_user_stack_event = {
 	.funcs		= &trace_user_stack_funcs,
 };
 
+/* TRACE_STACK_ID */
+static enum print_line_t trace_stack_id_print(struct trace_iterator *iter,
+					      int flags, struct trace_event *event)
+{
+	struct stack_id_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+	trace_seq_printf(s, "<stack_id %d>\n", field->stack_id);
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_stack_id_funcs = {
+	.trace		= trace_stack_id_print,
+};
+
+static struct trace_event trace_stack_id_event = {
+	.type		= TRACE_STACK_ID,
+	.funcs		= &trace_stack_id_funcs,
+};
+
 /* TRACE_HWLAT */
 static enum print_line_t
 trace_hwlat_print(struct trace_iterator *iter, int flags,
@@ -1908,6 +1930,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_wake_event,
 	&trace_stack_event,
 	&trace_user_stack_event,
+	&trace_stack_id_event,
 	&trace_bputs_event,
 	&trace_bprint_event,
 	&trace_print_event,
-- 
2.34.1

