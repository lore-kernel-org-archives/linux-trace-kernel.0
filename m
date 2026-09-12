Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84725417BDE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202337; cv=none; b=rFlfWqHjiLhCuAwSdyNMQHtbBg+AuCa+qiHKgYQGe9DoASEwqKviCj26ZCs933UIAx2FOJRBqGP6zNxh6xevYxLlWMgS+CRQLqQ3iDkWaNgxZjGT42v5I/EMtbl2jHFrEM3jDdFR1v+OPYHxI0B/FQqCRlB2RPV5xxTOPG7lTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202337; c=relaxed/simple;
	bh=RMZ5Ojt7tRoxpXeJqlOVmExYpI5ftfStyo6eyH9EPXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uF/1XwBlcpHEctx7T0V66CYRaOmO0DX5CtrvZOXTCg4HhH2A0t3PO7ieQJPjjgZq8neZeIUct2c9ufCXfQCfkbpma/KjGWgi1VaTqmM9CYdIHilcS7+1l8BIVgqEjcT3x/LiP1W5df4MwWcsQXG3VC3c0H/TITufy2ofmYh/c9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3FK2nzs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3FK2nzs"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1841864a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202334; x=1789807134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyuF0yFCrhdiykpjO34vI8hr0DzKjbLjL0w/H1QMS8c=;
        b=e3FK2nzsz6UJzxlSEIFy2H9KWZukFt+qwZ5TwfQnr+sCXrIdBFSx6NJeUD9xSlta93
         l6SHZHuugeszrgcHk3cv7RQBc1xE2MTVrRcf93dZsUsln53x3g6/hx7Qn17gSpkYYhCn
         7dk8VUCP3lq1vg3jVx8+woQsQffcqnl2fqKKrmQv4OJ70wgLODNbnpwU9sLfEA3FieNM
         vmf4D+EqIp8g+D9s8ExhbC5LXj385lRxW/KWUsULRIqGxTCY42oydFLYODWfMIKjZzUl
         4Js2tdtyGiY7bnPkXzuB56Wz9Kv7FPZVrFIB8puVGvmagFUO7ueVb0oI6CVk9VuOiakH
         iCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202334; x=1789807134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fyuF0yFCrhdiykpjO34vI8hr0DzKjbLjL0w/H1QMS8c=;
        b=IBR9YOvLIhQZx93oudIsMw4wmoamoee+8RuH5ZIzAwpDi3HEP4kNqM3BZE96KqVHgR
         LsknMZYY6tkZ9po3xCKCKYSfr4j470eZs98NtUaqlHUGreOSXlteoEbeVc+Qyd7425jQ
         scdXbBineiIpsx4U8U0Ip7D+FlZxKJaO+FREvoCc5gE/Jr4kjVkv1Aey56EFd0xOMfsu
         U/d1+fxYryAz+4hvlpRoq21nTGummtn3MrooJXwO/UPvxxM03n+66CcrgE5GfMXzoR62
         Ox8pJz2KfvFed1ISLe5IfULobTDbeYEy7f13tw+lEGaSfs1FNYN89CV3oHpuH79QD+0o
         +hkA==
X-Forwarded-Encrypted: i=1; AKwUvBwDH4UZqcABLqOxcaB7O8Vv5L9Wo0fe7M652X+zBRI0KA7F1PWBQ20owPdN4UCd2J8aBGpW8FQ0krrN18E6WZZMu+U=@vger.kernel.org
X-Gm-Message-State: AFuF++kLz0FbvWr7nIcP8Zo6sFl9y40HcN7extkpPcIZeXM3G5Ynn3Pk
	jwHI23R4i3VHKTFR3k3Xikl4IziIoxMaaE1tvZkJDHnsNDC4kHn16gO55p2gzw==
X-Gm-Gg: AYBFou0+166Dh52KZjcXylWJiEgXKGthKxt+csCfOH3mzVKRIpMZdtFSd2Qw53kqXOr
	rTqQ3haYflCnKMBzSW+OMxGHlfs+NfV8SXhdFeIwjSXoITrJe2Dp0GHBldW1Ek0uiRDl+0Sd93t
	S11GhTnv2iS+uq93U6oML5pQ4P2VFHZb1+6bBXoaYx6OT7zjYXRcWZf8P1k/L1K2Rv5tWB3oVfi
	3EOG7WWzT+elQe5uJAA3T29agSVlse4CsBon9wopjkqC4rbdcRIlavUefTkQdFl048Ex8nESCRQ
	dIUNddzsBB1RHbKRjS8M8y6RwcUbseZtYloT9v8dIGeZyP5OHeGj6+bs+owGG7LP3M9yu5G8Go4
	6QhdOc9BJ1gGhUCzo09gQitRj3syjNfHfZvkOz3s8dffmZBz0re9A+cLo+8LidVb2CZmTU9PftM
	hUZeG6zq0lRZU3JdXLeKjXGvcr/CpTVhUdZyLJW54AgV3+PdrJqaVBMpFpDA0lmHWUn4o9AbB/T
	liKnA7JTMF0++XPj73tECQyUyL5b/3GbZbeux3J
X-Received: by 2002:a17:90b:1650:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39d9c34266emr4425177a91.23.1789202334437;
        Sat, 12 Sep 2026 01:38:54 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:38:53 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 02/10] trace: use the stackmap from the ftrace stack recording path
Date: Sat, 12 Sep 2026 16:37:45 +0800
Message-Id: <20260912083753.3426176-3-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Wire ftrace_stackmap into __ftrace_trace_stack(). With 'stackmap' and
'stacktrace' enabled, the recording path tries to place a 4-byte
stack_id in the ring buffer and stack_map resolves the id.

Reserve the stack-id ring-buffer slot before consulting the map. This
keeps map records and counters untouched when that reservation fails.
If get_id() then fails, discard the reserved slot. Both paths try the
existing full-stack fallback, whose own ring-buffer reservation can
still fail under normal ring-buffer semantics.

Stacks deeper than FTRACE_STACKMAP_MAX_DEPTH bypass the map so a
recorded stack is never silently truncated or merged with another stack
sharing the same prefix. Other map failures, including capacity,
reset, and an unpublished map, also try the full-stack path.

Confine the option to the global trace instance through
TOP_LEVEL_TRACE_FLAGS, ZEROED_TRACE_FLAGS and a set_tracer_flag()
check. This also rejects writes through a secondary instance's
aggregate trace_options file.

Create stack_map before publishing global_trace.stackmap. Boot-time
options may be set while initialization is pending; the recording path
uses full-stack fallback until publication. A permanent initialization
failure clears and rejects the option.

Also add TRACE_STACK_ID, its output handler, and validation needed by
ftrace startup selftests.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig                 |   9 ++
 kernel/trace/trace.c                 | 218 ++++++++++++++++++++++++++-
 kernel/trace/trace.h                 |  16 ++
 kernel/trace/trace_entries.h         |  15 ++
 kernel/trace/trace_functions_graph.c |   1 +
 kernel/trace/trace_output.c          |  23 +++
 kernel/trace/trace_selftest.c        |   1 +
 7 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 6c40535a46e1..7001453bbfd3 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -426,6 +426,15 @@ config FTRACE_STACKMAP
 	  significantly reducing trace buffer usage when the same call stacks
 	  appear repeatedly.
 
+	  Automatic per-event stack capture requires the stacktrace option:
+
+	    echo 1 > /sys/kernel/debug/tracing/options/stacktrace
+	    echo 1 > /sys/kernel/debug/tracing/options/stackmap
+
+	  Explicit stack records requested through tracing APIs are also
+	  deduplicated when stackmap is enabled for their trace array. Stackmap
+	  is currently available only for the global trace array.
+
 	  The deduplicated stacks are exported via:
 	    /sys/kernel/debug/tracing/stack_map
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..06ae8ed11475 100644
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
@@ -2184,6 +2186,76 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * If stackmap dedup is enabled, try to store only the stack_id
+	 * in the ring buffer instead of the full stack trace.
+	 *
+	 * Reserve the TRACE_STACK_ID ring-buffer slot BEFORE calling
+	 * get_id(). This guarantees get_id(), and therefore any map mutation
+	 * or counter update it performs, is attempted only after the stack-id
+	 * reservation succeeds:
+	 *   - reservation fails  -> try full-stack fallback, map untouched
+	 *   - get_id() fails      -> discard the reserved slot, then try
+	 *                            full-stack fallback
+	 * A failed stack-id reservation therefore never consumes a map slot
+	 * or updates the map counters.
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
+		 * stack_id. Use the conservative full-stack path for deep
+		 * traces to avoid truncating or misattributing a recorded stack.
+		 * The ring-buffer reservation can still fail.
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
+			 * If get_id() cannot return an ID, discard the reserved
+			 * stack_id slot, then try the full-stack fallback. Its
+			 * ring-buffer reservation can still fail.
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
@@ -3976,6 +4048,50 @@ int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
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
@@ -3990,6 +4106,33 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 	if (!!(tr->trace_flags & mask) == !!enabled)
 		return 0;
 
+#ifdef CONFIG_FTRACE_STACKMAP
+	/*
+	 * STACKMAP is intentionally global-instance-only: the dedup map,
+	 * its tracefs files and the lifetime/reset semantics are tied
+	 * to the global trace
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
@@ -9222,6 +9365,70 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
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
@@ -9234,8 +9441,13 @@ static __init int tracer_init_tracefs(void)
 	trace_access_lock_init();
 
 	ret = tracing_init_dentry();
-	if (ret)
+	if (ret) {
+#ifdef CONFIG_FTRACE_STACKMAP
+		/* No later path can create or publish the global stackmap. */
+		stackmap_mark_init_failed();
+#endif
 		return 0;
+	}
 
 	if (trace_init_wq) {
 		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
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

