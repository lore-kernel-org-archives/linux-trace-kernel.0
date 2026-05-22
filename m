Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D533D515
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446487; cv=none; b=PouJLpzluer67h03H6hLqvR0XvI8F0w5LwIcmBMmRsrtdllpTX/pg3My14WOSBLh7rFc5RJ8w5PWKm2q8ZGt2KzpAWeUcKkgMOJh8ri6sjS7zWXeZY35fcFz2OlruXeyKD7/bMQVkuo6XF8aTeCm08/dEWDZdFPVLhDy0ZBLFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446487; c=relaxed/simple;
	bh=WC71pHugNevoo7yRdUlO7NXHZw/oA8YyBK7mN7wfRsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbzki2cyPGAcR8eMDO2RaqA/sYgFMJvwDivHP/NWsIvwXy2kSHzOq5W8ald78Kk6KeajIuItKWtYrM83OIJAQk818kGrkthMfQG/rHseiuncwIzoZf4u2DxoD1jmNRsmty9qwugI8ZDgB2d7bWn36HoeklUCPJEfyh3WMQ/W1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH6TG+dw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH6TG+dw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-366139223e4so4258485a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446483; x=1780051283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykLygwenxt26NzmMqgCAh8HlNsTLLzKbEYER4Sev7EY=;
        b=lH6TG+dwfYa6jUlAvbee3jlXY3DNAPSd7wjkQ+oAIpcjvFIhw5M4A04cUUDBlDkjjg
         9KwgqNkmYw19zHROyKyb1OnDVjpPce3fNEZAXj0gO4IRexjguKNf+rEyJH8ANw+f1zuT
         loB/RWfLeD94ZPXDzgiUSffMRG4QagRs2/oOrpzQBsAwjRFZYFjhA5pZ29qaptrGX2FH
         Cmq1tAooMZPv1yJaysCFqARKhvNBiqOO7VBnw0IK3+xBJmpJ6V9mJup/Hy7BQpX04Rye
         ErtxWllk9YwgCAmvT010f4tSCxNF3U/o1ifsPbKJDRqpdhKAntGE1LyKpjNgW0dZ9eSk
         p38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446483; x=1780051283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ykLygwenxt26NzmMqgCAh8HlNsTLLzKbEYER4Sev7EY=;
        b=QFPfrIgKuzdLMBbWgkjxFaioYo+xlck0ZzRNAKRKp/fST50y7uyyuWkHgVFnjBkC7I
         k7usFGaQB/WpUuo7tnMgThbw4+yUlbde7kQxQjMWjqc1ifl8koScmrXt6ddEUcMly53l
         VFBzGy+ogPJsLmcehbrmnuJPE70rL8rwYIxvrfd5q94/W/vV65bglOnvJz8R3B7LMpMd
         g0CAWxb0ioZwUslvRqx5W54fH75/Q4zP915LWr6R5BCDzl7z4pNsi5tyFHFJGp+SFU5q
         3rMf3ka0JZSU6vCGy1VUO05CZVmLpgWbjzVBLSTxNok3FmoAqSUPNeJo3RPObiOzR1Cg
         tBbQ==
X-Gm-Message-State: AOJu0Yx5klT+7ffuYtFn2uGb7UY188CgiYb1GYrA1n4PKHKRi/JzlLST
	Wp6BURzj7fjRTmyYdu2OaZxpXRoft8yZBaKpV+WS6nDOgBdkgejUBdwDIXiQWQ==
X-Gm-Gg: Acq92OEmRgAtq/kQ0Mrg07rsuqh62+2JT2F8sf6AO82cV85n/kEnW3XtZGKWrO5JnAa
	HTcTkIeb0HDXF8l51QHzVHAv1995t94Bk/kALOVT8zWNA4TPiCbIuiHI0DFfVwK3C1VTIfmeNkz
	8ZFJY/GbBplrooySAQUReQ3OGO/6APK1uL0nlyTWC+ZvSYB6qq6pOnGdUMapq0KMOvP5CwLUzgB
	jQ/zu3kP7+SlqJnZbnGbwQ1rp+vC8HPRSx/jI8Rc0nsBO8WWnSIXmnR2HlrGAjW/DQzXcAjk9p3
	zTkAgW1u4yN0IN91lI+MyENMIanJwDVbo6XxTenm9WVfb0nbDL/39tZ5mWAmkPTtwLi8lWEl1NL
	e8gF0Q1f3rK5iGpbWzHONmRBBaEXo0NWw43ph2Xb3gFymyKPcvVFcfzmiZ+8J9SvbdB9eCxNp9y
	tmTrfKZTL9NbJUSLzZR2w6zu/OWV0XFoW1TYSljjrAwdpzEGhV
X-Received: by 2002:a17:902:e745:b0:2bd:158d:299a with SMTP id d9443c01a7336-2beb05cead8mr32987275ad.25.1779446483146;
        Fri, 22 May 2026 03:41:23 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:9a21:4fdc:c1a5:7a8e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85200c3feesm1282942a12.0.2026.05.22.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:41:22 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: [PATCH v2 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Fri, 22 May 2026 18:40:16 +0800
Message-Id: <20260522104017.1668638-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522104017.1668638-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
 <20260522104017.1668638-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add TRACE_STACK_ID event type and integrate ftrace_stackmap into
__ftrace_trace_stack(). When the 'stackmap' trace option is enabled,
the stack recording path stores a 4-byte stack_id in the ring buffer
instead of the full stack trace.

Changes:
- New TRACE_STACK_ID in trace_type enum
- New stack_id_entry in trace_entries.h
- New TRACE_ITER(STACKMAP) trace option flag; when CONFIG_FTRACE_STACKMAP
  is disabled, TRACE_ITER_STACKMAP_BIT is defined as -1 so that
  TRACE_ITER(STACKMAP) evaluates to 0 (following the existing pattern
  used by TRACE_ITER_PROF_TEXT_OFFSET)
- Modified __ftrace_trace_stack() to call ftrace_stackmap_get_id()
  when the stackmap option is active
- Stackmap pointer read with smp_load_acquire(), published with
  smp_store_release() to ensure proper initialization ordering
- NULL check on tr->stackmap prevents dereference if creation failed
  or if used on a secondary trace instance (graceful fallback)
- ftrace_stackmap_create() takes the owning trace_array so the
  stackmap can later check tracing state during reset
- Added stack_id print handler in trace_output.c

Fallback behavior: if stackmap returns an error (pool exhausted,
resetting, or NULL pointer), the full stack trace is recorded as
before — no new failure modes introduced.

Note: stackmap is currently initialized only for the global trace
instance. Secondary instances fall back to full stack recording.

Usage:
  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c         | 66 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h         | 16 +++++++++
 kernel/trace/trace_entries.h | 15 ++++++++
 kernel/trace/trace_output.c  | 23 +++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..49a675dffad5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -57,6 +57,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_stackmap.h"
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
@@ -2184,6 +2185,43 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * If stackmap dedup is enabled, try to store only the stack_id
+	 * in the ring buffer instead of the full stack trace.
+	 */
+	if (tr->trace_flags & TRACE_ITER(STACKMAP)) {
+		struct ftrace_stackmap *smap;
+		struct stack_id_entry *sid_entry;
+		int sid;
+
+		smap = smp_load_acquire(&tr->stackmap);
+		if (!smap)
+			goto full_stack;
+
+		sid = ftrace_stackmap_get_id(smap, fstack->calls, nr_entries);
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
+full_stack:
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -9222,6 +9260,34 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 			NULL, &tracing_dyn_info_fops);
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	{
+		struct ftrace_stackmap *smap;
+
+		smap = ftrace_stackmap_create(&global_trace);
+		if (!IS_ERR(smap)) {
+			/*
+			 * Use smp_store_release to ensure the stackmap
+			 * structure is fully initialized before publishing
+			 * the pointer to concurrent trace event readers.
+			 */
+			smp_store_release(&global_trace.stackmap, smap);
+			trace_create_file("stack_map", TRACE_MODE_WRITE, NULL,
+					smap, &ftrace_stackmap_fops);
+			trace_create_file("stack_map_stat", TRACE_MODE_READ, NULL,
+					smap, &ftrace_stackmap_stat_fops);
+			trace_create_file("stack_map_bin", TRACE_MODE_READ, NULL,
+					smap, &ftrace_stackmap_bin_fops);
+		} else {
+			pr_warn("ftrace stackmap init failed, dedup disabled\n");
+			/*
+			 * global_trace.stackmap is already NULL from kzalloc;
+			 * leaving it NULL ensures the load-acquire in
+			 * __ftrace_trace_stack falls back to full stack.
+			 */
+		}
+	}
+#endif
 	create_trace_instances(NULL);
 
 	update_tracer_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..7e7d5e5a35ff 100644
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
+# define TRACE_ITER_STACKMAP_BIT	-1
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

