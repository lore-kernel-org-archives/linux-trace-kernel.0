Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F714A8B;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523298; cv=none; b=hbPbk3JCdd9PQsgCVgapChw840ixRE2ZxEGhZtpQNQk7THtvv+YrrG6iO9L41ugIhK7ZZ+AnK+qwehYLnzfhNMDrVcpOsp3vg9kTBQtgxfFxVjeO7WSBYh6pm2R47x3/utZkpdOtmhEf2AjqyJmI9+P+7oXmBZobHG5HfClesMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523298; c=relaxed/simple;
	bh=ql2zJ7yH3Gkyvmwm8Jiyo5Y6GG/xDqRKqc5E/FpVFqE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HRA4QGSvYua825WuMBpU1XE5bFk2XDp19DHB9R/93fxqtkzEnQt0K6NGV/lpkKbXlDLK1HHCbIHbPe0chHITifD+DI94UJKkKv7hf7PydGTcMq9ap6g7Q37B8EmAlFhYWzngW9YNHeiXHwDXyQPfT2qV3meBSuwJtquLGoWZmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2mCf0ME; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2mCf0ME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8912AC2BC86;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770523298;
	bh=ql2zJ7yH3Gkyvmwm8Jiyo5Y6GG/xDqRKqc5E/FpVFqE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=r2mCf0MEdfc4Yi8rVCEl2PyoZvv1E+C6fprjXl//H1DOqRmKBEl+W0drRhmHDA+Um
	 GIAeheOK9TasexKRuraNeUasDACRO0DH9ZokwP2jjTSeisGYNooIgfoU443lTZlmPm
	 rhjgGlW+/VPGz8B/7NlPSVgW2XM0NMRzcyLRLKxLmLtP4WQtHDQ/4ozQjc9SJ537JV
	 UBTN3Jj9P+XVYc5y+S5wS8mU8DJ7C+Ar6Z6IumagGOX0Bju0ze5KzS1t/O6LB3EKL+
	 HKwgfNtdiBk+8bV/+2yqrTP1XdvI6ikyR3mPLG3HembBTlEsthPReyIfZ53z/FoWdL
	 FkL9PoZfzbIzQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vow06-0000000AOy2-0CdK;
	Sat, 07 Feb 2026 23:02:22 -0500
Message-ID: <20260208040221.900653834@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 23:01:58 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/3] tracing: Add tracer_uses_snapshot() helper to remove #ifdefs
References: <20260208040156.005531619@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having #ifdef CONFIG_TRACER_MAX_TRACE around every access to
the struct tracer's use_max_tr field, add a helper function for that
access and if CONFIG_TRACER_MAX_TRACE is not configured it just returns
false.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 52 +++++++++++++++-----------------------------
 kernel/trace/trace.h | 12 ++++++++++
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 98524d0656bf..9fbb124e87dc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -810,7 +810,6 @@ EXPORT_SYMBOL_GPL(tracing_on);
 static void tracing_snapshot_instance_cond(struct trace_array *tr,
 					   void *cond_data)
 {
-	struct tracer *tracer = tr->current_trace;
 	unsigned long flags;
 
 	if (in_nmi()) {
@@ -827,7 +826,7 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 	}
 
 	/* Note, snapshot can not be used when the tracer uses it */
-	if (tracer->use_max_tr) {
+	if (tracer_uses_snapshot(tr->current_trace)) {
 		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
 		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
 		return;
@@ -1076,7 +1075,7 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 
 	guard(mutex)(&trace_types_lock);
 
-	if (tr->current_trace->use_max_tr)
+	if (tracer_uses_snapshot(tr->current_trace))
 		return -EBUSY;
 
 	/*
@@ -1787,7 +1786,7 @@ static int run_tracer_selftest(struct tracer *type)
 	tr->current_trace_flags = type->flags ? : type->default_flags;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (type->use_max_tr) {
+	if (tracer_uses_snapshot(type)) {
 		/* If we expanded the buffers, make sure the max is expanded too */
 		if (tr->ring_buffer_expanded)
 			ring_buffer_resize(tr->snapshot_buffer.buffer, trace_buf_size,
@@ -1812,7 +1811,7 @@ static int run_tracer_selftest(struct tracer *type)
 	tracing_reset_online_cpus(&tr->array_buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (type->use_max_tr) {
+	if (tracer_uses_snapshot(type)) {
 		tr->allocated_snapshot = false;
 
 		/* Shrink the max buffer again */
@@ -3240,10 +3239,8 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	}
 	mutex_unlock(&trace_types_lock);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-	if (iter->snapshot && iter->trace->use_max_tr)
+	if (iter->snapshot && tracer_uses_snapshot(iter->trace))
 		return ERR_PTR(-EBUSY);
-#endif
 
 	if (*pos != iter->pos) {
 		iter->ent = NULL;
@@ -3282,10 +3279,8 @@ static void s_stop(struct seq_file *m, void *p)
 {
 	struct trace_iterator *iter = m->private;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-	if (iter->snapshot && iter->trace->use_max_tr)
+	if (iter->snapshot && tracer_uses_snapshot(iter->trace))
 		return;
-#endif
 
 	trace_access_unlock(iter->cpu_file);
 	trace_event_read_unlock();
@@ -4177,11 +4172,9 @@ static int tracing_open(struct inode *inode, struct file *file)
 static bool
 trace_ok_for_array(struct tracer *t, struct trace_array *tr)
 {
-#ifdef CONFIG_TRACER_SNAPSHOT
 	/* arrays with mapped buffer range do not have snapshots */
-	if (tr->range_addr_start && t->use_max_tr)
+	if (tr->range_addr_start && tracer_uses_snapshot(t))
 		return false;
-#endif
 	return (tr->flags & TRACE_ARRAY_FL_GLOBAL) || t->allow_instances;
 }
 
@@ -5579,8 +5572,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (trace == tr->current_trace)
 		return 0;
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-	if (trace->use_max_tr) {
+	if (tracer_uses_snapshot(trace)) {
 		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
 		ret = tr->cond_snapshot ? -EBUSY : 0;
@@ -5589,7 +5581,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		if (ret)
 			return ret;
 	}
-#endif
+
 	/* Some tracers won't work on kernel command line */
 	if (system_state < SYSTEM_RUNNING && trace->noboot) {
 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
@@ -5612,14 +5604,13 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (tr->current_trace->reset)
 		tr->current_trace->reset(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-	had_max_tr = tr->current_trace->use_max_tr;
+	had_max_tr = tracer_uses_snapshot(tr->current_trace);
 
 	/* Current trace needs to be nop_trace before synchronize_rcu */
 	tr->current_trace = &nop_trace;
 	tr->current_trace_flags = nop_trace.flags;
 
-	if (had_max_tr && !trace->use_max_tr) {
+	if (had_max_tr && !tracer_uses_snapshot(trace)) {
 		/*
 		 * We need to make sure that the update_max_tr sees that
 		 * current_trace changed to nop_trace to keep it from
@@ -5632,24 +5623,19 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		tracing_disarm_snapshot(tr);
 	}
 
-	if (!had_max_tr && trace->use_max_tr) {
+	if (!had_max_tr && tracer_uses_snapshot(trace)) {
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
 			return ret;
 	}
-#else
-	tr->current_trace = &nop_trace;
-#endif
 
 	tr->current_trace_flags = t->flags ? : t->tracer->flags;
 
 	if (trace->init) {
 		ret = tracer_init(trace, tr);
 		if (ret) {
-#ifdef CONFIG_TRACER_MAX_TRACE
-			if (trace->use_max_tr)
+			if (tracer_uses_snapshot(trace))
 				tracing_disarm_snapshot(tr);
-#endif
 			tr->current_trace_flags = nop_trace.flags;
 			return ret;
 		}
@@ -7207,7 +7193,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	guard(mutex)(&trace_types_lock);
 
-	if (tr->current_trace->use_max_tr)
+	if (tracer_uses_snapshot(tr->current_trace))
 		return -EBUSY;
 
 	local_irq_disable();
@@ -7306,7 +7292,7 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 
 	info = filp->private_data;
 
-	if (info->iter.trace->use_max_tr) {
+	if (tracer_uses_snapshot(info->iter.trace)) {
 		tracing_buffers_release(inode, filp);
 		return -EBUSY;
 	}
@@ -7862,10 +7848,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (!count)
 		return 0;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-	if (iter->snapshot && iter->tr->current_trace->use_max_tr)
+	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
-#endif
 
 	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
 
@@ -8049,10 +8033,8 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	int entries, i;
 	ssize_t ret = 0;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-	if (iter->snapshot && iter->tr->current_trace->use_max_tr)
+	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
-#endif
 
 	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
 	if (*ppos & (page_size - 1))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b50383aa8e50..ebb47abc0ee7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -817,6 +817,18 @@ static inline void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 }
 #endif /* CONFIG_STACKTRACE */
 
+#ifdef CONFIG_TRACER_MAX_TRACE
+static inline bool tracer_uses_snapshot(struct tracer *tracer)
+{
+	return tracer->use_max_tr;
+}
+#else
+static inline bool tracer_uses_snapshot(struct tracer *tracer)
+{
+	return false;
+}
+#endif
+
 void trace_last_func_repeats(struct trace_array *tr,
 			     struct trace_func_repeats *last_info,
 			     unsigned int trace_ctx);
-- 
2.51.0


