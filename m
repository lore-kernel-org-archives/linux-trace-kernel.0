Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030739;
	b=N1WuOwNpCmLZIvRS5Tjj5w4mxfZXg21LJv3vUH1CnUf/GGOFu5qYjjjNmc6aW3SmiEsn
	 NlQqoLJdeqzmXGWwMlN10C1z7BJwC2/8oOUVglL92mYEoq+JdwiY9sNkfk5c9autfHHPN
	 wA2+99jqr7sWSv+RcxNNpTBwoHxXniyKFN0ZE1S5GMi3mrv+4v1EDk5+nJ2ZVidrfx8vp
	 PM7FHuyywWyNWUF/mKsabQTzqmyCetyqGDx30EE1lT9waknGFOVOwX/9pL6T1DMizyaFo
	 Ac2YuCYj/UDZoxBV9oj3aHyzcvPfUIiNDzjF5o04bexwMPk5l6PtwlvOV1IOjJsLBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AhvCspk/wTL6kWPoqD/AH2RUlthQHlXMubf/0mcXMwU=;
	b=B+oLu2X7/cb5VW0FYcWlOWGuO8wteyW12DWzhjkhXpdLM5PGK+HRE0pXWQsFXJ98Mhfr
	 cTT261eyla2N8GBdsk0qCN2MrUyD79cNpFdx2vOUyjfO+I90ISCrOBoFjz+OTzvgFGdk7
	 y0Bx+hdwX2nuc8UeTmH5WFH0UQKpjYNR0PExDqno1ITTz+ckay1VnuTyz8S4oM3G0QJyv
	 4uDBIc9itKNz7GrvqMmxcw159tfc5IjI6VftRKs1EpmGowIYLp0gwGPNFsE5x/fq5AIpT
	 3NzpRDikEiZX/Okw3TsLoCfCXAeD9pXUk+FTOUOfUrbUqq6VncSTi17FrQcyGvrOuPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDW95aG9;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E2606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 363E2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDW95aG9
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e946155442so10780895ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030738; x=1794635538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhvCspk/wTL6kWPoqD/AH2RUlthQHlXMubf/0mcXMwU=;
        b=MDW95aG9kwaI53xM+a2f62bw3TBQ2/aPVB5YOu4nu66T/XIknxYtJM5o9cqxQtWyoi
         fLnXg9TDoIU3HloM5tUtBN19s6q3zavqCLd6psUT5ZKXYVCwc1my/n9zqmdYlHOCH2NM
         xF1I3HBH/LSac523dmYhFGvNg+rQot/rLEeHs7e6WxOsjpnNd9vZ1qaxp/xHBbIPD10Z
         +a5NOAji4BLcR1tUMmDRMwfalXNQxci2ixnWfJHwL3HUOfBLFFzmo5+Fwa20zugsS3oH
         9n85qDUXzZgOylhhnL4AUnLDx3LwJNkCHLDL60oD6l5BKHl2WqoU3hzNvdWV7sL8Pz4V
         5bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030738; x=1794635538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhvCspk/wTL6kWPoqD/AH2RUlthQHlXMubf/0mcXMwU=;
        b=qZtBATq59Nd/gnaIbhPx8lXSfUAONV/5vVXUM0LAEz+Zl4sw5ZMacFXKQyRAYyQ/7K
         EJzmDzlvA0EKrj1ojgxwWETUEoA0sD8HV5nH41zUBooztn4r8LhqJWvXInyxXM/bGyuI
         sSjN/hQaeVgmf9bb914YFE//M2VgW8YHTRBxQCIviBqm/aRdTac2XitXsfo2veKpZX/W
         /EQCR4snkLEciMeyUs+Zkp1y040vZ5gxtReI7X6AgoFo0xqiXhItCMavZcXmdnB+EKqZ
         clcsebI9AYaRV4neYzBYGeo96dRRVoH5lxqJzfCWKmrhdbLpHHrtz7bvUDPi9K4JHm6H
         0qFQ==
X-Forwarded-Encrypted: i=1; AL+hErH0L9VEsaUveqNcVQM+564RXmhd3YQd3jNg9H+H4VoYss3Tq+Hnc974KBNAYnQW7D34F3b7e0W0E5fMEmqolzpIFPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z97RQFr/hj3OMpFqDndJubWCeAQqZbnZFDsFGf9exTSF17K4dXY
	70einBRjJx5VVNY1DHd+Xm5EqpzDD73J4QKSb6QYxHlGK/0czW4Hvbzy
X-Gm-Gg: AYBFou1kOI9HkQRYCIEr4dLL0P2xImFI9ZBz/VvvQYks7w4c06kp4T22K8iJNrruwG6
	AFerry8s3BKRmm9PR7BEtEN6he19Cbb6EX8uQIVuAV/j+p8D/DSsYEqh3KeBxFtGrvDFaxlbFv7
	ISYZ55jbJjB2phZdjlbHrXjux1mWFgu2+CJ0Ua+9Q8+G/yqDVK29oO+nMU14T0lDDZnyipromKF
	ILLwoLOgUypzxeOBP/+IsO/9dwfcFdEbxXq5N8WxW8gZ9LDE/xsssoLCu0M2uqFy0JT1+OmYpJc
	PHyibvv5gvcw6r9nc4ccOudsnWekzc3zzIfROZyxtgo70hJjU1pf+FZ7vsFFUDByjm2BVS7QbzJ
	7nOnaBVWbBcyJaLbuFs01YR8UlCVxHGgz8uB+e8Zu7N7k0MqhM9511C9mZb0arUDRQJW0gmJBvv
	FdeLSwACYvUY/5LqgMjK4K0uRCMa5wKc8bDQ8s72M+9heHRNjdski0z+Wi3aKLHDxcsoDNr1iBj
	hwA0Uzn66xx59QYSh9JNZwG4ep/khyhQkpD7bCXcFw1+CltqBMaWVbhbzPDVV1UMeMReXN/pBRl
	Tuj6gpfvY38hnY1ZCK9u5PTVi/TnxYtCRKeYDy3NkJLQX7Hk1Paellb93Ev+5T8SoObXlw==
X-Received: by 2002:a17:902:eccc:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ed416abcf8mr56822375ad.17.1794030737462;
        Fri, 06 Nov 2026 21:52:17 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d8949fsm11189465ad.62.2026.11.06.21.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:52:16 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: [PATCH v8 2/5] tracing: Use the stackmap from the ftrace stack recording path
Date: Sat,  7 Nov 2026 13:51:36 +0800
Message-Id: <20261107055139.3138633-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

With the new stackmap option set, __ftrace_trace_stack() records a
TRACE_STACK_ID event holding the cookie instead of the full stack, and
records the full stack when the map cannot store it. A stack recorded
while RCU is not watching is discarded, as reset and free rely on
synchronize_rcu(). Only the top level trace array supports the option.

The map is allocated when the option is first enabled and kept when it
is disabled, so the trace stays resolvable. Writing "free" to stack_map
releases it once the files that opened it are closed.

Assisted-by: LLM
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c                 | 128 ++++++++++++++++++++++++++-
 kernel/trace/trace.h                 |  12 +++
 kernel/trace/trace_entries.h         |  16 ++++
 kernel/trace/trace_functions_graph.c |   1 +
 kernel/trace/trace_output.c          |  24 +++++
 kernel/trace/trace_selftest.c        |   1 +
 kernel/trace/trace_stackmap.c        |  35 ++++++++
 7 files changed, 214 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..cdae2976d224 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -57,6 +57,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_stackmap.h"
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
@@ -509,12 +510,13 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER(PRINTK) |			\
 	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD) |	\
-	       TRACE_ITER(PROF_TEXT_OFFSET) | FPROFILE_DEFAULT_FLAGS)
+	       TRACE_ITER(PROF_TEXT_OFFSET) | TRACE_ITER(STACKMAP) |	\
+	       FPROFILE_DEFAULT_FLAGS)
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
 	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK) | \
-	 TRACE_ITER(COPY_MARKER))
+	 TRACE_ITER(COPY_MARKER) | TRACE_ITER(STACKMAP))
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -2118,6 +2120,106 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
+#ifdef CONFIG_FTRACE_STACKMAP
+enum stackmap_init_state {
+	STACKMAP_INIT_PENDING,	/* tracer_init_tracefs() not run yet */
+	STACKMAP_INIT_READY,	/* stack_map file created; map allocated on enable */
+	STACKMAP_INIT_FAILED,	/* permanent failure, never available */
+};
+
+/* Written and read under trace_types_lock. */
+static enum stackmap_init_state stackmap_state = STACKMAP_INIT_PENDING;
+
+/* Returns true if the stack was handled through the stack map. */
+static inline bool
+record_stackmap(struct trace_array *tr, struct trace_buffer *buffer,
+		struct ftrace_stack *fstack, unsigned int nr_entries,
+		unsigned int trace_ctx)
+{
+	struct ring_buffer_event *event;
+	struct ftrace_stackmap *smap;
+	struct stack_id_entry *entry;
+	u64 cookie;
+
+	if (!(tr->trace_flags & TRACE_ITER(STACKMAP)))
+		return false;
+
+	/* Reset and free use synchronize_rcu(), which does not wait for this. */
+	if (unlikely(!rcu_is_watching()))
+		return true;
+
+	if (!nr_entries || nr_entries > FTRACE_STACKMAP_MAX_DEPTH)
+		return false;
+
+	smap = rcu_dereference_sched(tr->stackmap);
+	if (!smap)
+		return false;
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK_ID,
+					    sizeof(*entry), trace_ctx);
+	if (!event)
+		return false;
+
+	if (!ftrace_stackmap_get_cookie(smap, fstack->calls, nr_entries, &cookie)) {
+		__trace_event_discard_commit(buffer, event);
+		return false;
+	}
+
+	entry = ring_buffer_event_data(event);
+	entry->stack_cookie = cookie;
+	__buffer_unlock_commit(buffer, event);
+	return true;
+}
+
+static void __init stackmap_mark_init_failed(void)
+{
+	guard(mutex)(&trace_types_lock);
+	stackmap_state = STACKMAP_INIT_FAILED;
+	global_trace.trace_flags &= ~TRACE_ITER(STACKMAP);
+}
+
+static int stackmap_set_flag(struct trace_array *tr)
+{
+	/* The stack map is only for the top level trace array. */
+	if (tr != &global_trace || stackmap_state == STACKMAP_INIT_FAILED)
+		return -EINVAL;
+	/* stackmap_init_tracefs() allocates the map for trace_options=stackmap. */
+	if (stackmap_state != STACKMAP_INIT_READY)
+		return 0;
+	return ftrace_stackmap_alloc(tr);
+}
+
+static __init void stackmap_init_tracefs(void)
+{
+	if (!trace_create_file("stack_map", TRACE_MODE_WRITE, NULL,
+			       &global_trace, &ftrace_stackmap_fops)) {
+		stackmap_mark_init_failed();
+		return;
+	}
+
+	guard(mutex)(&trace_types_lock);
+	stackmap_state = STACKMAP_INIT_READY;
+	/* trace_options=stackmap on the command line */
+	if ((global_trace.trace_flags & TRACE_ITER(STACKMAP)) &&
+	    ftrace_stackmap_alloc(&global_trace)) {
+		pr_warn("ftrace stackmap: allocation failed, stackmap disabled\n");
+		global_trace.trace_flags &= ~TRACE_ITER(STACKMAP);
+	}
+}
+#else
+static inline bool
+record_stackmap(struct trace_array *tr, struct trace_buffer *buffer,
+		struct ftrace_stack *fstack, unsigned int nr_entries,
+		unsigned int trace_ctx)
+{
+	return false;
+}
+
+static inline void stackmap_mark_init_failed(void) { }
+static inline int stackmap_set_flag(struct trace_array *tr) { return 0; }
+static inline void stackmap_init_tracefs(void) { }
+#endif /* CONFIG_FTRACE_STACKMAP */
+
 void __ftrace_trace_stack(struct trace_array *tr,
 			  struct trace_buffer *buffer,
 			  unsigned int trace_ctx,
@@ -2184,6 +2286,9 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
+	if (record_stackmap(tr, buffer, fstack, nr_entries, trace_ctx))
+		goto out;
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -3996,6 +4101,15 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 			return -EINVAL;
 
 	switch (mask) {
+	case TRACE_ITER(STACKMAP):
+		if (enabled) {
+			int ret = stackmap_set_flag(tr);
+
+			if (ret)
+				return ret;
+		}
+		break;
+
 	case TRACE_ITER(TRACE_PRINTK):
 		if (enabled) {
 			update_printk_trace(tr);
@@ -4282,6 +4396,10 @@ static const char readme_msg[] =
 	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
+#ifdef CONFIG_FTRACE_STACKMAP
+	"  stack_map\t\t- Stacks recorded as cookies with options/stackmap\n"
+	"\t\t\t  Write '0' to reset it, 'free' to release it\n"
+#endif
 #ifdef CONFIG_DYNAMIC_EVENTS
 	"  dynamic_events\t\t- Create/append/remove/show the generic dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
@@ -9222,6 +9340,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 			NULL, &tracing_dyn_info_fops);
 #endif
 
+	stackmap_init_tracefs();
+
 	create_trace_instances(NULL);
 
 	update_tracer_options();
@@ -9234,8 +9354,10 @@ static __init int tracer_init_tracefs(void)
 	trace_access_lock_init();
 
 	ret = tracing_init_dentry();
-	if (ret)
+	if (ret) {
+		stackmap_mark_init_failed();
 		return 0;
+	}
 
 	if (trace_init_wq) {
 		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7b2cdc0dc253..70b36d45b855 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -57,6 +57,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_STACK_ID,
 
 	__TRACE_LAST_TYPE,
 };
@@ -582,6 +583,8 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
 			  TRACE_FUNC_REPEATS);				\
+		IF_ASSIGN(var, ent, struct stack_id_entry,		\
+			  TRACE_STACK_ID);				\
 		__ftrace_bad_type();					\
 	} while (0)
 
@@ -1452,6 +1455,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+# define STACKMAP_FLAGS				\
+		C(STACKMAP,		"stackmap"),
+#else
+# define STACKMAP_FLAGS
+# define TRACE_ITER_STACKMAP_BIT	-1
+#endif
+
 #ifdef CONFIG_FUNCTION_PROFILER
 # define PROFILER_FLAGS					\
 		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
@@ -1509,6 +1520,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
+		STACKMAP_FLAGS					\
 		BRANCH_FLAGS					\
 		PROFILER_FLAGS					\
 		FPROFILE_FLAGS
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 54417468fdeb..2b3dd23ef5a9 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -250,6 +250,22 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
+#define STACK_COOKIE_GET_GEN(entry)	((u32)((entry)->stack_cookie >> 32))
+#define STACK_COOKIE_GET_ID(entry)	((u32)((entry)->stack_cookie))
+
+FTRACE_ENTRY(stack_id, stack_id_entry,
+
+	TRACE_STACK_ID,
+
+	F_STRUCT(
+		__field(	u64,		stack_cookie	)
+	),
+
+	F_printk("<stack_id %u gen %u>",
+		 STACK_COOKIE_GET_ID(__entry),
+		 STACK_COOKIE_GET_GEN(__entry))
+);
+
 /*
  * trace_printk entry:
  */
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 0d2d3a2ea7dd..0e1a390a6130 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1492,6 +1492,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 		return print_graph_return(field, s, entry, iter, flags);
 	}
 	case TRACE_STACK:
+	case TRACE_STACK_ID:
 	case TRACE_FN:
 		/* dont trace stack and functions as comments */
 		return TRACE_TYPE_UNHANDLED;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..0a45bb5e00ec 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1517,6 +1517,29 @@ static struct trace_event trace_user_stack_event = {
 	.funcs		= &trace_user_stack_funcs,
 };
 
+static enum print_line_t trace_stack_id_print(struct trace_iterator *iter,
+					      int flags, struct trace_event *event)
+{
+	struct stack_id_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+	trace_seq_printf(s, "<stack_id %u gen %u>\n",
+			 STACK_COOKIE_GET_ID(field),
+			 STACK_COOKIE_GET_GEN(field));
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
@@ -1908,6 +1931,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_wake_event,
 	&trace_stack_event,
 	&trace_user_stack_event,
+	&trace_stack_id_event,
 	&trace_bputs_event,
 	&trace_bprint_event,
 	&trace_print_event,
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 929c84075315..0c97065b0d68 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -14,6 +14,7 @@ static inline int trace_valid_entry(struct trace_entry *entry)
 	case TRACE_CTX:
 	case TRACE_WAKE:
 	case TRACE_STACK:
+	case TRACE_STACK_ID:
 	case TRACE_PRINT:
 	case TRACE_BRANCH:
 	case TRACE_GRAPH_ENT:
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
index e5ffd1850ebf..b02eb22c76a9 100644
--- a/kernel/trace/trace_stackmap.c
+++ b/kernel/trace/trace_stackmap.c
@@ -47,6 +47,8 @@ struct ftrace_stackmap {
 /* Serializes tracefs readers against reset. */
 static DEFINE_MUTEX(stackmap_lock);
 
+static DECLARE_WAIT_QUEUE_HEAD(stackmap_free_wq);
+
 static u32 stackmap_next_gen = 1;
 
 static struct ftrace_stackmap *stackmap_locked(struct trace_array *tr)
@@ -140,6 +142,8 @@ static void stackmap_put(struct ftrace_stackmap *smap)
 		return;
 	if (refcount_dec_and_test(&smap->ref))
 		ftrace_stackmap_destroy(smap);
+	else
+		wake_up(&stackmap_free_wq);
 }
 
 static void stackmap_reset(struct trace_array *tr)
@@ -164,6 +168,32 @@ static void stackmap_reset(struct trace_array *tr)
 	atomic_set_release(&smap->resetting, 0);
 }
 
+/* @self is the map pinned by the writing file, which is not waited for. */
+static int stackmap_free(struct trace_array *tr, struct ftrace_stackmap *self)
+{
+	struct ftrace_stackmap *smap;
+	int ret;
+
+	scoped_guard(mutex, &trace_types_lock) {
+		if (tr->trace_flags & TRACE_ITER(STACKMAP))
+			return -EBUSY;
+		smap = stackmap_locked(tr);
+		if (!smap)
+			return 0;
+
+		RCU_INIT_POINTER(tr->stackmap, NULL);
+		synchronize_rcu();
+		/* Old cookies must not match the next map. */
+		stackmap_next_gen = smap->generation + 1;
+	}
+
+	/* Closing a file takes trace_types_lock, so wait without it. */
+	ret = wait_event_killable(stackmap_free_wq,
+				  refcount_read(&smap->ref) == 1 + (self == smap));
+	stackmap_put(smap);
+	return ret;
+}
+
 bool ftrace_stackmap_get_cookie(struct ftrace_stackmap *smap,
 				unsigned long *ips, unsigned int nr_entries,
 				u64 *cookie)
@@ -358,6 +388,7 @@ static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
 	struct seq_file *m = file->private_data;
 	struct stackmap_seq_private *priv = m->private;
 	char buf[8];
+	int ret;
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
@@ -370,6 +401,10 @@ static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
 		stackmap_reset(priv->tr);
 		return count;
 	}
+	if (sysfs_streq(buf, "free")) {
+		ret = stackmap_free(priv->tr, priv->smap);
+		return ret ? ret : count;
+	}
 	return -EINVAL;
 }
 
-- 
2.34.1

