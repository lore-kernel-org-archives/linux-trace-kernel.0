Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758693EEAFE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592139; cv=none; b=gLLT6oHPcy/LsiQiHZj5LI5gnifYV87dICZJuqta+SIUH4ySW9iqmP226B0kfmyuv44HaKXg9ZDD5PwtnAOjJV3giS0TpGzrSKma+7FR/2GAk5/0n+wNQHo7XiWuA8FKu9FLPC+yFEw0IlM4Wco++lrvHnNHlIYbkptfuajXztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592139; c=relaxed/simple;
	bh=2SL4rWEWhhQPO1eRBQZkqFbpdV4LnrJiEf+oavUvleQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmbE5ftIAQQXVBCnREnYKPlvd4Smg6ZZXJAOpOuMssIYjeY2ZeT0wtutkeGfML7iHT45AdnuUMW6vhkqiBpPGx7qUrIawXbZtBjtXqK65MFIOjyal/lsTZhi7wouz2zLpHWbxZAfNW5VxWZDkfO6H8HHd0HoceRTQnEa5WixuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib9Rf42q; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib9Rf42q"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1384ebe7a10so6619110c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592137; x=1782196937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjY/DZRC1d+FjG45aKF5yfv4kuV1+Jd8YmStqyJDnUE=;
        b=ib9Rf42qr0EylnWYIgR/MmdkL3N4QoDRAPxIA0IaYiHg47ZmUoOvDHGKwx2yydMY07
         oHp30+dLDD4HpTj+CHGTRRIw/NueE+prX2Ck4KqxSckqMjWS8L+d9e9V60dMpOiW47SY
         JdD+RKBdnuVWJIImun12Sr4IkaIJpADhF8mttG52lkF++QR1BfNBUqitV9dyEzu28i0Y
         Xr4FZXchnzh9FnmWOFX+LWvWpJQ6WN6SpSp1wASkJiIuUo7kc0lAKbWLsFxswy41PxaE
         EWIHOr+vRoshJrcK7ivtRTw/Fui+Smz49txNlITGQcyxN10iBDcAIuEL0MBBbELjICgZ
         9X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592137; x=1782196937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjY/DZRC1d+FjG45aKF5yfv4kuV1+Jd8YmStqyJDnUE=;
        b=L2V1q9ThFiTccAeq5kVkLIgoNl0qWJeSfdMTOkwes770sn83tqpCreLyX4p0TphYNz
         BELEk0QQw+Vn7PgXBvwTbJgN7uvryGhdOEaXApUSuxt3pzuwbZLAA1bQKANMWKDAfqRM
         v1M5UY6YH0pqiKy6ga3IpmnBhZFDfo/hwOo39H/yclebEpgMQZ2Zs1W2j+nwA2FmqRlc
         9ynke6QC0HgR7qOsg/dsC2HctnKG/mzbYGPXQxvbJLrIwJKj+1g+98yLbUltyyXo5esg
         kLELsE86JlnRTt9D6RwtSbyNdpHGKVW1kAdanPOSj3UczrpHaQ9jeX183Cz4Q8HkkdQr
         6raA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vq61P3D07wOFQNffYAvES6VrbYh26MULlxaiBuebmCZPyJvKCrv4ImlC7AdJyqd8ZBxBpYFWcivyzcsUEldAsNdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nZGrmWAQzAVu1dYcqokazV7NIIEjEBVcmd6Mjjz3meCo6pXQ
	eHj5oGM2K4eRFvOPTPa8wmSlu+EWDQo/BXzWec4leSa2YTrJFAYIqlqq
X-Gm-Gg: Acq92OHsGwHz0y/oA7uQYlvAOwU/2VHy0k4visOI0CPvUXzcKA7CQb/5cvXjvLkIkG/
	7ZvbQGEs93TCwZ9etyLA3bGdWYbLWDZI8YgPp56jEkKmwnQP8gKwHy5TSeYEElRSZUFzZ7vCjFT
	NpjJI81jg4LILt4MuBu/retZ7nrbq6loSb32eUVr272031gjaTcKmHYWM96y4tVedKIs2zEph3g
	OpubTHLM1UxzBXSJfvKZSxWDM2cWlPjA2ZYYUOIlLe2M+Q+4kJHTDEUvVRZJUIAy2dxZeiW7pOi
	gczQMh9j4WJxB2YiltL1BWu0q3hwcmqo8CYtHsLUmMnPCGEOq1/l0PtNzUBbyuXb8n/BCqbyQbY
	tAam4FeUh3OECoZ4922+I4lXew5mtHmiqcT6V1D6wXcO9lZN08Wn/2S9Xdigph7PUrvAFWAgTDp
	xuVuYwJW/8CvS/IYSyMN42f10uP7kydXkDqQh7UQ==
X-Received: by 2002:a05:701b:4558:20b0:12d:b7e5:a691 with SMTP id a92af1059eb24-1384bb1c4bcmr5608349c88.7.1781592136446;
        Mon, 15 Jun 2026 23:42:16 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:55be:2dbe:9cd4:7306])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm12499158c88.4.2026.06.15.23.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:42:15 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lipengfei28@xiaomi.com,
	zhangbo56@xiaomi.com
Subject: [RFC PATCH v4 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Tue, 16 Jun 2026 14:41:18 +0800
Message-Id: <20260616064119.438063-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616064119.438063-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
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
 kernel/trace/trace.c          | 216 +++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h          |  17 +++
 kernel/trace/trace_entries.h  |  15 +++
 kernel/trace/trace_output.c   |  23 ++++
 kernel/trace/trace_selftest.c |   1 +
 5 files changed, 269 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..e00bee5d0e01 100644
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
@@ -3979,6 +4050,33 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
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
+#endif
+
 int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
 	switch (mask) {
@@ -3993,6 +4091,33 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
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
@@ -9222,6 +9347,91 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
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
+				 * STACKMAP flag that a boot-time
+				 * trace_options=stackmap may have set, so
+				 * options/stackmap does not report an
+				 * enabled no-op and later userspace enables
+				 * return -EINVAL.
+				 */
+				WRITE_ONCE(stackmap_init_state,
+					   STACKMAP_INIT_FAILED);
+				global_trace.trace_flags &=
+					~TRACE_ITER(STACKMAP);
+			} else {
+				/*
+				 * smp_store_release pairs with the
+				 * smp_load_acquire() in
+				 * __ftrace_trace_stack(). Publishing only
+				 * after the required file exists keeps
+				 * "smap visible" => "resolver/reset
+				 * available".
+				 */
+				smp_store_release(&global_trace.stackmap,
+						  smap);
+				WRITE_ONCE(stackmap_init_state,
+					   STACKMAP_INIT_DONE);
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
+			 * becoming silent no-ops.
+			 */
+			WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_FAILED);
+			global_trace.trace_flags &= ~TRACE_ITER(STACKMAP);
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

