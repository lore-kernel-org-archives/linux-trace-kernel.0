Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C63590A9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331415; cv=none; b=rC9hC1rMiEVOubBjxkUaJfyzG+7JHNDG6WUJF8bgFPRgVM/C5/nGBj6KpNiu40j9hmLFaiCa4hWMDoFKunYtev8qeuYowS80SmnWN+tbjg2RyxesUgUPcFfgySdx5qdW6nMWM1rwlfInJsTL9em2iezFqyOgx5UFlYckfgtpni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331415; c=relaxed/simple;
	bh=n2WVKFxYAZYbCe8BNgUWeWI+G5NLK84Hf2TY2jTkKU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InVpi4+/TW6W/2ljccMCgwuojOTMM8vDY7glyrAl7uaI0i40rOJwPt2m4r7gEqQt7T0L7qERrcnU+i1zU9joV15jiKaY1GF6QpEw3lA2Ozekc4SMbb6D8I55G82cRghk2rpxGjt9Tcb9SSzWJhyyqtxe3OA9GCTvzM8Z+GBhXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS8E2x+d; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS8E2x+d"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso538605a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331411; x=1788936211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHT/C67sIBnim2wtYHYw7fqMx+afZEO/5+sKF3Fe54M=;
        b=nS8E2x+d369Z/xfTytDaQmnYAd0g7qqXfGEdQp3UG4/VEIfhoVfffnZQLLRxw0fTO/
         sSH7FHP+AfhFVG/1h+vHS8N5kdROpjBQCqHvQRNLRwT/tMOzohilfTgUSjIRTXZjfpXT
         /Q+hrzojix92Lf4t165tdH1tXHgjAay1DduivgcTYIlqqL6VneHQj0RWacMBnHu0Im/9
         c+TAavIohuRVY10m9qN/ATm24hyO40aTa42LbSFIhAI/eY5S3smn9/WNiLj540bPmfoU
         SSsV73dnbsXiWZZhligk5ph1tbF7nUtnB46OlezYoNs23N62L21+TrQk09Yl3nVrC2d0
         xP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331411; x=1788936211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHT/C67sIBnim2wtYHYw7fqMx+afZEO/5+sKF3Fe54M=;
        b=dyQWA2prYOEA+h79A6GLHf9kfKVDX0Y4K1JN6G+ZezMOHobtR4aWDbmEKjQ5/TPnq3
         NZUnH7a7W94jTxepvaJ3BlHoh0b7OlW9xPhpoqCK8Pg9xoEhXOK7sM1GH8sc7V+igmrK
         glGrjdYyWIOnjc5TVlD654FQYqXhGv9W+CXOSLZur3HCPAdoMHBzMxsBlKn7mKuFmbhY
         WwgXOFkZ6DPIMd+eGgfnJ3ltAmOWE3UY2bBjjtM8ZkdmdjHsv84wgNM6M03zwur+rp1s
         CLkSh2u51hJF7RnWZysMuGgfXEb6CBNAWqXAQIyS3OM5k0M+vJZMalA+It5xUzVDYEyK
         d2mw==
X-Forwarded-Encrypted: i=1; AKwUvByM7g4pWuQdEBj0RpEemp/z13Yo7iAVQT8ZWGK7EbS1ri8FpfvIOswYWgU97TH4zxTFnepDlFdL6IKHu4j2YSm+DRA=@vger.kernel.org
X-Gm-Message-State: AFuF++kF/6VMGmpaYEYGSvWJ6+BJuPo9ZgbVr/pJ125Df/toM74M0+zw
	kQrf3BapDAmSKCMr9hQzm3DJaIeg5ThzHVUQK7rlqKb8FgX7mogxvD5K
X-Gm-Gg: AYBFou3o+76Xy6IAtoOFcFCB/ATVH3RTO/E8GNiWOi4LwGVrXQgSSjAATIVObPKCNKw
	DhBGyYQLBW/edHCPc0jmZ4K8R8tpMEK5x761VsBmeeasCS84N6CeWMHf4pix6jITxUjVz6sDAuy
	+pfiOm0l+zpYo6ySHPhWUYbQE9Yeh+NaaidGZResp4Nqfoa4K60XwVU/Uqh2uaqZ6/7UDuZy/gm
	+K6GSQdeid+RnTqtnhAEk7RgZpS6OmNeRCdnafw2A5Segd2MjNwdBSe6LqOwDNqiWsug4DOJILr
	3R9CD8XszYaO7Rw2Ixz8ujfZaGibEmfU5A8S1/Nsu6TDknQbHe8sMCqceKEhlCbccMAB5qmAONR
	qr94Vj3uvTQYXyOjAhyylHPQVtrR2qnyre27kKXCYiu6HsJ/hruLEjpmV+Af4arwMg+Aprg2ul5
	pm6MFwIQu5f+kLcA6cPt8oWMrwzMpQllO8A07ufNTHekNXMaYV9jRnM01ZTmFyxK5WI7wkyFsZu
	poyEgGar+ClQ8jTd03Bt9jc96Rm8Q==
X-Received: by 2002:a17:90b:3ec5:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39aee1afb77mr3584762a91.24.1788331411220;
        Tue, 01 Sep 2026 23:43:31 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:2c95:4917:f0fe:b444])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d80433dsm9373143a91.17.2026.09.01.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:43:30 -0700 (PDT)
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
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v5 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Wed,  2 Sep 2026 14:42:41 +0800
Message-Id: <20260902064242.28606-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902064242.28606-1-lipengfei28@xiaomi.com>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com>
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

- New TRACE_STACK_ID in trace_type enum and stack_id_entry in
  trace_entries.h.

- New TRACE_ITER(STACKMAP) trace option flag; when CONFIG_FTRACE_STACKMAP
  is disabled, TRACE_ITER_STACKMAP_BIT is defined as -1 so that
  TRACE_ITER(STACKMAP) evaluates to 0 (following the existing pattern
  used by TRACE_ITER_PROF_TEXT_OFFSET).

- 'stackmap' is added to TOP_LEVEL_TRACE_FLAGS and ZEROED_TRACE_FLAGS
  so it is only exposed under the top-level trace instance, matching
  the convention already used for global-only options such as 'printk'
  and 'record-cmd'. Secondary instances under tracing/instances/*/
  do not see the option in their options/ directory.

- set_tracer_flag() additionally rejects enabling STACKMAP on a
  secondary instance. The per-option file is hidden on secondary
  instances, but a write to the aggregate trace_options file still
  reaches set_tracer_flag(); without this check the bit could be
  accepted and then become a silent no-op in the hot path (where
  tr->stackmap is NULL). This closes the global-instance-only gate
  at the write path, not just in the tracefs layout.

- __ftrace_trace_stack() reserves the TRACE_STACK_ID ring-buffer slot
  BEFORE calling ftrace_stackmap_get_id(), so the map (and its
  ref_count / success counters) is only mutated when a ring-buffer
  event will actually reference the entry. If the reservation fails
  it falls back to a full stack; if get_id() fails it discards the
  reserved slot and falls back. A stack deeper than
  FTRACE_STACKMAP_MAX_DEPTH skips the map entirely (get_id() would
  return -E2BIG) and records a full stack, so deep traces are never
  truncated or merged.

- Stackmap pointer read with smp_load_acquire(), published with
  smp_store_release() to ensure proper initialization ordering. The
  hot path falls back to a full stack whenever tr->stackmap is NULL.

- ftrace_stackmap_create() takes the owning trace_array so the
  stackmap can later clear that trace_array's buffers during reset.

- Added stack_id print handler in trace_output.c and TRACE_STACK_ID
  to trace_valid_entry() in trace_selftest.c so ftrace startup
  selftests accept the new entry type when the stackmap option is
  enabled.

Failure-atomic init and boot-time activation:

- The global stackmap and its tracefs files are created during
  tracer_init_tracefs(). stack_map is the single required file (it is
  both the resolver and the reset interface); it is created BEFORE the
  map pointer is published with smp_store_release(), so an observed
  non-NULL tr->stackmap implies the resolver/reset file exists. If
  stack_map cannot be created the map is destroyed and never published.

- A small init-state (PENDING / DONE / FAILED) lets set_tracer_flag()
  distinguish "not initialized yet" from "init failed". Boot-time
  options (trace_options=stackmap,stacktrace) are applied before the
  tracefs init work runs; the flag is allowed to be set while init is
  PENDING (the hot path falls back until the map is published, then the
  boot-set option takes effect), and is only rejected once init has
  permanently FAILED. On failure the STACKMAP flag is also cleared from
  the global instance so options/stackmap never reports an enabled
  no-op.

Fallback behavior: if stackmap returns an error (pool exhausted,
resetting, NULL pointer, or a too-deep stack), the full stack trace is
recorded as before -- no new failure modes introduced.

Per-instance stackmap support is left as a follow-up; gating the
option to the global instance (both in the tracefs layout and at the
set_tracer_flag() write path) makes the global-only scope explicit.

Usage:
  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c                 | 228 ++++++++++++++++++++++++++-
 kernel/trace/trace.h                 |  17 ++
 kernel/trace/trace_entries.h         |  15 ++
 kernel/trace/trace_functions_graph.c |   1 +
 kernel/trace/trace_output.c          |  23 +++
 kernel/trace/trace_selftest.c        |   1 +
 6 files changed, 282 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..0210dc597f77 100644
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
@@ -1562,7 +1564,7 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 	ring_buffer_record_enable(buffer);
 }
 
-static void tracing_reset_all_cpus(struct array_buffer *buf)
+void tracing_reset_all_cpus(struct array_buffer *buf)
 {
 	struct trace_buffer *buffer = buf->buffer;
 
@@ -2184,6 +2186,75 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * If stackmap dedup is enabled, try to store only the stack_id
+	 * in the ring buffer instead of the full stack trace.
+	 *
+	 * Reserve the TRACE_STACK_ID ring-buffer slot BEFORE inserting
+	 * into the stackmap. This guarantees the map is only mutated
+	 * (and its ref_count / success counters bumped) when a
+	 * ring-buffer event will actually reference the entry:
+	 *   - reservation fails  -> fall back to full stack, map untouched
+	 *   - get_id() fails      -> discard the reserved slot, fall back
+	 * so stack_map_stat counters stay consistent with what the ring
+	 * buffer holds, and a failed reservation never consumes a map
+	 * slot for an event that records a full stack anyway.
+	 */
+	if (tr->trace_flags & TRACE_ITER(STACKMAP)) {
+		struct ftrace_stackmap *smap;
+		struct stack_id_entry *sid_entry;
+		int sid;
+
+		/*
+		 * Pairs with the smp_store_release() that publishes the
+		 * fully initialized global stackmap at tracefs init.
+		 */
+		smap = smp_load_acquire(&tr->stackmap);
+		if (!smap)
+			goto full_stack;
+
+		/*
+		 * The stackmap stores at most FTRACE_STACKMAP_MAX_DEPTH
+		 * frames per entry. A deeper trace would be truncated, and
+		 * two distinct stacks that share the first MAX_DEPTH frames
+		 * would hash and compare equal, silently merging into one
+		 * stack_id. Keep the conservative full-stack path for deep
+		 * traces so no information is lost or misattributed.
+		 */
+		if (nr_entries > FTRACE_STACKMAP_MAX_DEPTH)
+			goto full_stack;
+
+		event = __trace_buffer_lock_reserve(buffer, TRACE_STACK_ID,
+						    sizeof(*sid_entry), trace_ctx);
+		if (!event)
+			goto full_stack;
+
+		sid = ftrace_stackmap_get_id(smap, fstack->calls, nr_entries);
+		if (sid < 0) {
+			/*
+			 * Pool exhausted or a reset is in progress. Discard
+			 * the reserved stack_id slot and record the full
+			 * stack instead, so the event still gets a trace.
+			 */
+			__trace_event_discard_commit(buffer, event);
+			goto full_stack;
+		}
+
+		sid_entry = ring_buffer_event_data(event);
+		sid_entry->stack_id = sid;
+		/*
+		 * stack_id is a synthetic side-event attached to a
+		 * primary trace event that was already subject to
+		 * filtering. No per-event filter is defined for
+		 * TRACE_STACK_ID, so commit unconditionally.
+		 */
+		__buffer_unlock_commit(buffer, event);
+		goto out;
+	}
+full_stack:
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -3976,6 +4047,50 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 	return 0;
 }
 
+#ifdef CONFIG_FTRACE_STACKMAP
+/*
+ * Tracks tracefs-time initialization of the global stackmap so that
+ * set_tracer_flag() can distinguish "not initialized yet" from
+ * "initialization permanently failed".
+ *
+ * Boot-time options (trace_options=stackmap,stacktrace) are applied
+ * very early, before tracer_init_tracefs() creates and publishes the
+ * map. We must allow the STACKMAP flag to be set during that window
+ * (the hot path falls back to a full stack while tr->stackmap is NULL,
+ * then starts using the map once it is published). We must, however,
+ * reject the enable once init has *failed*, so options/stackmap never
+ * reports an enabled no-op.
+ *
+ * Written once from the tracefs init work before any concurrent
+ * userspace writer to trace_options can run, then only read; a plain
+ * int is therefore sufficient.
+ */
+enum {
+	STACKMAP_INIT_PENDING,	/* tracer_init_tracefs() not run yet */
+	STACKMAP_INIT_DONE,	/* map published, stack_map file created */
+	STACKMAP_INIT_FAILED,	/* permanent failure, never available */
+};
+
+static int stackmap_init_state = STACKMAP_INIT_PENDING;
+
+/*
+ * Mark the global stackmap init as permanently failed.
+ *
+ * Clears any boot-time STACKMAP flag (trace_options=stackmap applied before
+ * the map was created) so options/stackmap does not report an enabled no-op
+ * and later userspace enables return -EINVAL. The flag is cleared under
+ * trace_types_lock because set_tracer_flag() updates trace_flags under that
+ * lock; the tracefs init runs in an unlocked workqueue context that can race
+ * with a concurrent trace_options write.
+ */
+static void __init stackmap_mark_init_failed(void)
+{
+	guard(mutex)(&trace_types_lock);
+	WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_FAILED);
+	global_trace.trace_flags &= ~TRACE_ITER(STACKMAP);
+}
+#endif
+
 int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
 	switch (mask) {
@@ -3990,6 +4105,33 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 	if (!!(tr->trace_flags & mask) == !!enabled)
 		return 0;
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * STACKMAP is intentionally global-instance-only: the dedup map,
+	 * its tracefs files (stack_map / stack_map_stat / stack_map_bin)
+	 * and the lifetime/reset semantics are tied to the global trace
+	 * array. options/stackmap is hidden on secondary instances via
+	 * TOP_LEVEL_TRACE_FLAGS, but writes still reach set_tracer_flag()
+	 * through the aggregate trace_options file. Reject the enable on
+	 * a secondary instance so it cannot be silently accepted and then
+	 * become a no-op in the hot path (where tr->stackmap is NULL and
+	 * the code falls back to a full stack trace).
+	 *
+	 * On the global instance, allow the enable while init is still
+	 * pending (boot-time trace_options=stackmap is applied before the
+	 * tracefs init work creates the map; the hot path falls back
+	 * until the map is published). Only reject once init has
+	 * permanently failed, so options/stackmap never reports an
+	 * enabled no-op. READ_ONCE() suffices: this only inspects the
+	 * init state, it does not dereference the map (the hot path uses
+	 * smp_load_acquire(&tr->stackmap) for that).
+	 */
+	if (mask == TRACE_ITER(STACKMAP) && enabled &&
+	    (tr != &global_trace ||
+	     READ_ONCE(stackmap_init_state) == STACKMAP_INIT_FAILED))
+		return -EINVAL;
+#endif
+
 	/* Give the tracer a chance to approve the change */
 	if (tr->current_trace->flag_changed)
 		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
@@ -9222,6 +9364,86 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 			NULL, &tracing_dyn_info_fops);
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	{
+		struct ftrace_stackmap *smap;
+		struct dentry *map_file;
+
+		smap = ftrace_stackmap_create(&global_trace);
+		if (!IS_ERR(smap)) {
+			/*
+			 * Failure-atomic init: stack_map is the single
+			 * required tracefs file (it doubles as the reset
+			 * interface and the human-readable resolver). If
+			 * we cannot create it, the hot path must not be
+			 * able to emit <stack_id N> events that no one can
+			 * resolve or clear, so refuse to publish the map
+			 * and tear it down.
+			 *
+			 * Create stack_map BEFORE smp_store_release() so an
+			 * observed non-NULL global_trace.stackmap implies
+			 * its resolver/reset file exists.
+			 */
+			map_file = trace_create_file("stack_map",
+						     TRACE_MODE_WRITE, NULL,
+						     smap,
+						     &ftrace_stackmap_fops);
+			if (!map_file) {
+				pr_warn("ftrace stackmap init: stack_map create failed, dedup disabled\n");
+				ftrace_stackmap_destroy(smap);
+				/*
+				 * Permanent failure. Record it and clear a
+				 * boot-time STACKMAP flag (under
+				 * trace_types_lock) so options/stackmap does
+				 * not report an enabled no-op and later
+				 * userspace enables return -EINVAL.
+				 */
+				stackmap_mark_init_failed();
+			} else {
+				/*
+				 * smp_store_release pairs with the
+				 * smp_load_acquire() in
+				 * __ftrace_trace_stack(). Publishing only
+				 * after the required file exists keeps
+				 * "smap visible" => "resolver/reset
+				 * available".
+				 */
+				smp_store_release(&global_trace.stackmap, smap);
+				WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_DONE);
+				/*
+				 * stat and bin are auxiliary observability
+				 * surfaces. If they fail to be created we
+				 * keep dedup enabled (the kernel side still
+				 * works, and stack_map alone is enough to
+				 * resolve and reset); trace_create_file()
+				 * already pr_warn()s on failure.
+				 */
+				trace_create_file("stack_map_stat",
+						  TRACE_MODE_READ, NULL,
+						  smap,
+						  &ftrace_stackmap_stat_fops);
+				trace_create_file("stack_map_bin",
+						  TRACE_MODE_READ, NULL,
+						  smap,
+						  &ftrace_stackmap_bin_fops);
+			}
+		} else {
+			pr_warn("ftrace stackmap init failed, dedup disabled\n");
+			/*
+			 * global_trace is statically defined; its stackmap
+			 * field is zero-initialized via BSS, so leaving it
+			 * NULL ensures the smp_load_acquire() in
+			 * __ftrace_trace_stack() falls back to full stack.
+			 * Mark init failed and clear any boot-time STACKMAP
+			 * flag so userspace enables are rejected rather than
+			 * becoming silent no-ops. Use the helper so the flag
+			 * clear happens under trace_types_lock, matching the
+			 * stack_map-create failure path above.
+			 */
+			stackmap_mark_init_failed();
+		}
+	}
+#endif
 	create_trace_instances(NULL);
 
 	update_tracer_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..95db43bfc747 100644
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
 
@@ -689,6 +695,7 @@ extern int tracing_disabled;
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
+void tracing_reset_all_cpus(struct array_buffer *buf);
 void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
@@ -1449,7 +1456,16 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
@@ -1506,6 +1522,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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

