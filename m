Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B543F58EB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796437; cv=none; b=Us7HA4fLg2oGC75OFGFpiGz7euBPA8gsHuxYO0VkZXxiohg7UhXc2la9RF6pw+VM6doufpN1MzaAdB9vugmLZDzMjJxpGa9alFoL6vWtS1RUzp3SD6uodnL8d55MSr9DxWOMAmsXPd9Dp0gQOgCFdSVSCJ4I6aAn27hPE0om0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796437; c=relaxed/simple;
	bh=8y7HjdQmwsKjTt7BHCTO/8I5NXq//AbhuupGTMhwI9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YilwqXKt4uGqnD1jnt+S0OdrMzA+BGY4tBVxdQ2eugdz4n53UKyE/f14e+X/owrRDUF6zEdOaHOD8ZOQpY5ji6x3F2zg9Zqc/LrIZ7Ennpnz5vSJsRQ/+h+ZfFHqgZw4sgLI3b4IIHCeGhSzgySk7Yb1knxA/mRF9I37p7C1rNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZrRKmLG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZrRKmLG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so109397515ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796426; x=1780401226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhFgkq2FLjXpBbD2dwJx+p+guFA7grjMcJu9sUU6rg0=;
        b=iZrRKmLGATrS3eHMHVKbACen6qJHuXOts/T07kzlphH2t5jn8t/emzfyqcx7LU7hMH
         yrTTOOtn72lKoOG/n1E8+8sHV8whLJDyBBidJ3nMpIWw6a9BZrI2nzyN7broiCM7QspN
         v/nM9x7mcSsIX4Ae9Wzcpzy+v+i61SRpnhAsnBOeNe0R9V857JnzUwukvL2MH344/1xW
         nQbJMzv2SKWdah2PdL+kiZPYU2vkrx+I81mGB85KS4o5MHKTh1OVkGiQpVd9JJiBuVtE
         3f1/4LBJll3NS+mXhFCEo1QswLhqHhI9GFYFsyd2n/afiYV8XrdpmeytSQSspH4WPPUg
         ZVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796426; x=1780401226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhFgkq2FLjXpBbD2dwJx+p+guFA7grjMcJu9sUU6rg0=;
        b=OpsCtOr1NW+ovEWfR8iD55gXsIFCr9POgBCSSpCyNaeFr1elIG9Uqy0121E+ysTWHj
         zOnD8yQJJNpr6IwNXJ4g7EQPFyFTnLgwdlks49L/CplLCEs5qb7UZoFyNljgyOi9r58o
         uyX/ikdfHerbmAICABBj9fQh2Bmgq9nn479vJziG0PK3CPA2mUxJJ9MWPj5YBraYfx0o
         3woeLMi73HNip1KBOaxW9RmuZturaSc6D6Ux71f0CkxzD5fwSrog7RNwkgSHU8yD91Ts
         aCVSoiMtvuAVk7q7flxAF8m+at94FqS3034faj4HS+3zHOh9eedBoBzbLGE/du+dfBak
         Up0A==
X-Gm-Message-State: AOJu0YwLwEnRDgXmfs9Q/YUwLHW9iMmMvVczG7JEXoya6AwVZmJRlRvu
	E6J0U1Gm2KETLuLrCUdZFZhd+xcEJOEDIjNRmd8tGgOGSmX55yglxMZnVoN7jA==
X-Gm-Gg: Acq92OHJ3Sn0eHwtqVQ6/fWBklErSIsEDvi+CnRUK5Mnx6f1ogW6prajf8qqagH4FAL
	hq8cY+4i9SgODyPIRIqdbt2XLSq8mmg7pOEW8TFYTd0xUMxXL4ciw3UsQ+Ok+14Oaa9p76Z4kw+
	mJ9wkK4DjolaaGIbqWVTWeR7a6dPjrgClJUdmHajj4l+NVFyCZszsM5gU3DvGHpuOlttDoYdBhF
	Nkbj9e+8r9eWy5FWagMiYUNYR2R+ZRSLCGwIffFshGWhAUM7WR2UQMwdCUBZowhXV6/DQwSTGbZ
	SEmV7x0ofoEiwHZegiKWDGbEuR0UcGTnQTe2l7KcoN4mxOj6eruwOnKYdPtE49M4hyG0H0Ipl26
	KtS9uZM7rF3J/HKcD6zgIDUweBqD7fJ+5v6Jf3ClIuTQFQ6DDBa9/IX6IquEsOS6j4ovN6Id4Jp
	jdPpjxCV8FaI4i7JGdVOWfgCc9EoNlAVEzsfxWsw==
X-Received: by 2002:a17:903:350d:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2beb065aa18mr205771055ad.34.1779796426181;
        Tue, 26 May 2026 04:53:46 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d6ff:7a7e:f223:7f2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dd75bsm163399345ad.69.2026.05.26.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:53:45 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	Pengfei Li <lipengfei28@xiaomi.com>
Subject: [RFC PATCH v3 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Tue, 26 May 2026 19:52:44 +0800
Message-Id: <bb1f3a0761f4d240020aceac3f96390947bbda89.1779769138.git.lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779769138.git.lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com> <cover.1779769138.git.lipengfei28@xiaomi.com>
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
- New stack_id_entry in trace_entries.h
- New TRACE_ITER(STACKMAP) trace option flag; when CONFIG_FTRACE_STACKMAP
  is disabled, TRACE_ITER_STACKMAP_BIT is defined as -1 so that
  TRACE_ITER(STACKMAP) evaluates to 0 (following the existing pattern
  used by TRACE_ITER_PROF_TEXT_OFFSET)
- 'stackmap' is added to TOP_LEVEL_TRACE_FLAGS and ZEROED_TRACE_FLAGS
  so it is only exposed under the top-level trace instance, matching
  the convention already used for global-only options such as 'printk'
  and 'record-cmd'. Secondary instances under tracing/instances/*/
  do not see the option at all, avoiding a confusing no-op.
- Modified __ftrace_trace_stack() to call ftrace_stackmap_get_id()
  when the stackmap option is active. If reserving a TRACE_STACK_ID
  ring-buffer slot fails after a successful get_id(), the path falls
  through to the full-stack recording so the event still gets a stack
  trace recorded.
- Stackmap pointer read with smp_load_acquire(), published with
  smp_store_release() to ensure proper initialization ordering
- NULL check on tr->stackmap is retained as defense-in-depth: events
  that fire before fs_initcall (when the map is created) or after a
  failed ftrace_stackmap_create() observe a NULL pointer and fall back
  to full stack recording without dereferencing it
- ftrace_stackmap_create() takes the owning trace_array so the
  stackmap can later check tracing state during reset
- Added stack_id print handler in trace_output.c
- Added TRACE_STACK_ID to trace_valid_entry() in trace_selftest.c
  so ftrace startup selftests don't reject the new entry type when
  the stackmap option is enabled

Fallback behavior: if stackmap returns an error (pool exhausted,
resetting, or NULL pointer), the full stack trace is recorded as
before -- no new failure modes introduced.

Per-instance stackmap support is left as a follow-up; gating the
option via TOP_LEVEL_TRACE_FLAGS makes the global-only scope
explicit at the tracefs interface rather than relying on a silent
runtime fallback.

Usage:
  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c          | 78 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h          | 16 +++++++
 kernel/trace/trace_entries.h  | 15 +++++++
 kernel/trace/trace_output.c   | 23 +++++++++++
 kernel/trace/trace_selftest.c |  1 +
 5 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..36120355e549 100644
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
@@ -2184,6 +2186,49 @@ void __ftrace_trace_stack(struct trace_array *tr,
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
+			if (!event) {
+				/*
+				 * Could not reserve a TRACE_STACK_ID slot;
+				 * fall back to the full-stack path so the
+				 * event still gets a stack trace recorded.
+				 */
+				goto full_stack;
+			}
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
+		/* On stackmap failure, record the full stack instead. */
+	}
+full_stack:
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -9222,6 +9267,35 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
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
+			 * global_trace is statically defined; its stackmap
+			 * field is zero-initialized via BSS, so leaving it
+			 * NULL ensures the smp_load_acquire() in
+			 * __ftrace_trace_stack() falls back to full stack.
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
-- 
2.34.1

