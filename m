Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDC26CE0D;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058306; cv=none; b=EXyvZlpmnIiwqjC52OuDLNNtZViG85WzjaqllDJrPx15+vFfL0eNMhrmL3dFYtQLNPKiw31dUQj7RQd9g4LjModq9jvEz+4SOPlBvr8UCssAwvrIYi7x5FxMH4SWGiYypSTClGp2RFpdXJb1Pzne4d6tZ0DkW5rMbGFrwsxcQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058306; c=relaxed/simple;
	bh=oIMcGAVQpLgcLGrTsqVTlsystwRd+WESeX076OkDZsE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bqTixpU7zUbsaZvXzJNrLgWwT2X1N2KcQModNiCL7SPadtez2g/71no2B3BZHPtJsuRzgz0e9ZWwnJKZzArlgF/jU9wvd5dXgWtn7KtdVDnM0GMpALxzNHlSNeOSDX0/jmiv75dsjBtrNt+PIX4XHYe7pdVcOpOO6H5mEU63VvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVxQ3bPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVxQ3bPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29CEC4CEFC;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058305;
	bh=oIMcGAVQpLgcLGrTsqVTlsystwRd+WESeX076OkDZsE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gVxQ3bPihJvPcZBphMV9typPpmzmCOkARaMjLS1j3kPwn0qryKY0wqc2mIqDErOz/
	 qeJu08VGC1ALyH/jFkh5mTGpPZAqLYS3/xeMAG9QROgY5FFfL427cpHBKN9bS7o5Ug
	 gWnxPD4c07FB6nxOpwyESj43cxtFrMhDAqyk2DMafFC1kLUHCvXq3qISzq1d9GH3bV
	 naYau2pSHMEjXYPXgK6oVUjaudix3YdijpI06yS8t7tTdv2/mZ2m9he5PpmIedr6TS
	 /lm3sJkI1mJRtF/XuWzoLWiEM7RdhkWfH19GDOB8OZQ8YCNp/44sLx4A65Dp1p4zMB
	 /3F4yMrsPAKRw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhqhK-00000007Uv6-3L2x;
	Fri, 01 Aug 2025 10:25:26 -0400
Message-ID: <20250801142526.649674199@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 10:25:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] tracing: Add guard() around locks and mutexes in trace.c
References: <20250801142506.431659758@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's several locations in trace.c that can be simplified by using
guards around raw_spin_lock_irqsave, mutexes and preempt disabling.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 147 ++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 100 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 332487179e1d..a781c8145ea6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -432,15 +432,13 @@ static void ftrace_exports(struct ring_buffer_event *event, int flag)
 {
 	struct trace_export *export;
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
 		trace_process_export(export, event, flag);
 		export = rcu_dereference_raw_check(export->next);
 	}
-
-	preempt_enable_notrace();
 }
 
 static inline void
@@ -497,27 +495,18 @@ int register_ftrace_export(struct trace_export *export)
 	if (WARN_ON_ONCE(!export->write))
 		return -1;
 
-	mutex_lock(&ftrace_export_lock);
+	guard(mutex)(&ftrace_export_lock);
 
 	add_ftrace_export(&ftrace_exports_list, export);
 
-	mutex_unlock(&ftrace_export_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_export);
 
 int unregister_ftrace_export(struct trace_export *export)
 {
-	int ret;
-
-	mutex_lock(&ftrace_export_lock);
-
-	ret = rm_ftrace_export(&ftrace_exports_list, export);
-
-	mutex_unlock(&ftrace_export_lock);
-
-	return ret;
+	guard(mutex)(&ftrace_export_lock);
+	return rm_ftrace_export(&ftrace_exports_list, export);
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
@@ -640,9 +629,8 @@ void trace_array_put(struct trace_array *this_tr)
 	if (!this_tr)
 		return;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	__trace_array_put(this_tr);
-	mutex_unlock(&trace_types_lock);
 }
 EXPORT_SYMBOL_GPL(trace_array_put);
 
@@ -1424,13 +1412,8 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 
 int tracing_arm_snapshot(struct trace_array *tr)
 {
-	int ret;
-
-	mutex_lock(&trace_types_lock);
-	ret = tracing_arm_snapshot_locked(tr);
-	mutex_unlock(&trace_types_lock);
-
-	return ret;
+	guard(mutex)(&trace_types_lock);
+	return tracing_arm_snapshot_locked(tr);
 }
 
 void tracing_disarm_snapshot(struct trace_array *tr)
@@ -2483,9 +2466,8 @@ void tracing_reset_all_online_cpus_unlocked(void)
 
 void tracing_reset_all_online_cpus(void)
 {
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tracing_reset_all_online_cpus_unlocked();
-	mutex_unlock(&trace_types_lock);
 }
 
 int is_tracing_stopped(void)
@@ -2496,18 +2478,17 @@ int is_tracing_stopped(void)
 static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
-	unsigned long flags;
 
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	guard(raw_spinlock_irqsave)(&tr->start_lock);
 	if (--tr->stop_count) {
 		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
 			tr->stop_count = 0;
 		}
-		goto out;
+		return;
 	}
 
 	/* Prevent the buffers from switching */
@@ -2524,9 +2505,6 @@ static void tracing_start_tr(struct trace_array *tr)
 #endif
 
 	arch_spin_unlock(&tr->max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
@@ -2544,11 +2522,10 @@ void tracing_start(void)
 static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	guard(raw_spinlock_irqsave)(&tr->start_lock);
 	if (tr->stop_count++)
-		goto out;
+		return;
 
 	/* Prevent the buffers from switching */
 	arch_spin_lock(&tr->max_lock);
@@ -2564,9 +2541,6 @@ static void tracing_stop_tr(struct trace_array *tr)
 #endif
 
 	arch_spin_unlock(&tr->max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
@@ -2679,12 +2653,12 @@ void trace_buffered_event_enable(void)
 
 		per_cpu(trace_buffered_event, cpu) = event;
 
-		preempt_disable();
-		if (cpu == smp_processor_id() &&
-		    __this_cpu_read(trace_buffered_event) !=
-		    per_cpu(trace_buffered_event, cpu))
-			WARN_ON_ONCE(1);
-		preempt_enable();
+		scoped_guard(preempt,) {
+			if (cpu == smp_processor_id() &&
+			    __this_cpu_read(trace_buffered_event) !=
+			    per_cpu(trace_buffered_event, cpu))
+				WARN_ON_ONCE(1);
+		}
 	}
 }
 
@@ -2760,7 +2734,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 
 	if (!tr->no_filter_buffering_ref &&
 	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
-		preempt_disable_notrace();
+		guard(preempt_notrace)();
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
 		 * This buffer will simulate a ring_buffer_event,
@@ -2809,7 +2783,6 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 			this_cpu_dec(trace_buffered_event_cnt);
 		}
 		/* __trace_buffer_lock_reserve() disables preemption */
-		preempt_enable_notrace();
 	}
 
 	entry = __trace_buffer_lock_reserve(*current_rb, type, len,
@@ -3029,7 +3002,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 		skip++;
 #endif
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
@@ -3087,8 +3060,6 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	/* Again, don't let gcc optimize things here */
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
-	preempt_enable_notrace();
-
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -3171,9 +3142,9 @@ ftrace_trace_userstack(struct trace_array *tr,
 	 * prevent recursion, since the user stack tracing may
 	 * trigger other kernel events.
 	 */
-	preempt_disable();
+	guard(preempt)();
 	if (__this_cpu_read(user_stack_count))
-		goto out;
+		return;
 
 	__this_cpu_inc(user_stack_count);
 
@@ -3191,8 +3162,6 @@ ftrace_trace_userstack(struct trace_array *tr,
 
  out_drop_count:
 	__this_cpu_dec(user_stack_count);
- out:
-	preempt_enable();
 }
 #else /* CONFIG_USER_STACKTRACE_SUPPORT */
 static void ftrace_trace_userstack(struct trace_array *tr,
@@ -3374,7 +3343,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	pause_graph_tracing();
 
 	trace_ctx = tracing_gen_ctx();
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	tbuffer = get_trace_buf();
 	if (!tbuffer) {
@@ -3406,7 +3375,6 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	put_trace_buf();
 
 out_nobuffer:
-	preempt_enable_notrace();
 	unpause_graph_tracing();
 
 	return len;
@@ -3430,7 +3398,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	pause_graph_tracing();
 
 	trace_ctx = tracing_gen_ctx();
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 
 	tbuffer = get_trace_buf();
@@ -3458,7 +3426,6 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	put_trace_buf();
 
 out_nobuffer:
-	preempt_enable_notrace();
 	unpause_graph_tracing();
 
 	return len;
@@ -4788,20 +4755,16 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	/* Fail if the file is marked for removal */
 	if (file->flags & EVENT_FILE_FL_FREED) {
 		trace_array_put(file->tr);
-		ret = -ENODEV;
+		return -ENODEV;
 	} else {
 		event_file_get(file);
 	}
 
-	mutex_unlock(&event_mutex);
-	if (ret)
-		return ret;
-
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -5945,9 +5908,9 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 	char buf[MAX_TRACER_SIZE+2];
 	int r;
 
-	mutex_lock(&trace_types_lock);
-	r = sprintf(buf, "%s\n", tr->current_trace->name);
-	mutex_unlock(&trace_types_lock);
+	scoped_guard(mutex, &trace_types_lock) {
+		r = sprintf(buf, "%s\n", tr->current_trace->name);
+	}
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
@@ -6249,15 +6212,13 @@ int tracing_update_buffers(struct trace_array *tr)
 {
 	int ret = 0;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	update_last_data(tr);
 
 	if (!tr->ring_buffer_expanded)
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
-	mutex_unlock(&trace_types_lock);
-
 	return ret;
 }
 
@@ -6554,7 +6515,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	cpu = tracing_get_cpu(inode);
 	ret = open_pipe_on_cpu(tr, cpu);
 	if (ret)
@@ -6598,7 +6559,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	tr->trace_ref++;
 
-	mutex_unlock(&trace_types_lock);
 	return ret;
 
 fail:
@@ -6607,7 +6567,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	close_pipe_on_cpu(tr, cpu);
 fail_pipe_on_cpu:
 	__trace_array_put(tr);
-	mutex_unlock(&trace_types_lock);
 	return ret;
 }
 
@@ -6616,14 +6575,13 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 	struct trace_iterator *iter = file->private_data;
 	struct trace_array *tr = inode->i_private;
 
-	mutex_lock(&trace_types_lock);
+	scoped_guard(mutex, &trace_types_lock) {
+		tr->trace_ref--;
 
-	tr->trace_ref--;
-
-	if (iter->trace->pipe_close)
-		iter->trace->pipe_close(iter);
-	close_pipe_on_cpu(tr, iter->cpu_file);
-	mutex_unlock(&trace_types_lock);
+		if (iter->trace->pipe_close)
+			iter->trace->pipe_close(iter);
+		close_pipe_on_cpu(tr, iter->cpu_file);
+	}
 
 	free_trace_iter_content(iter);
 	kfree(iter);
@@ -7426,7 +7384,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	if (i == ARRAY_SIZE(trace_clocks))
 		return -EINVAL;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	tr->clock_id = i;
 
@@ -7450,8 +7408,6 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		tscratch->clock_id = i;
 	}
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -7503,15 +7459,13 @@ static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
 		seq_puts(m, "delta [absolute]\n");
 	else
 		seq_puts(m, "[delta] absolute\n");
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -8099,14 +8053,14 @@ static void clear_tracing_err_log(struct trace_array *tr)
 {
 	struct tracing_log_err *err, *next;
 
-	mutex_lock(&tracing_err_log_lock);
+	guard(mutex)(&tracing_err_log_lock);
+
 	list_for_each_entry_safe(err, next, &tr->err_log, list) {
 		list_del(&err->list);
 		free_tracing_log_err(err);
 	}
 
 	tr->n_err_log_entries = 0;
-	mutex_unlock(&tracing_err_log_lock);
 }
 
 static void *tracing_err_log_seq_start(struct seq_file *m, loff_t *pos)
@@ -8377,7 +8331,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	iter->tr->trace_ref--;
 
@@ -8388,8 +8342,6 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 					   info->spare_cpu, info->spare);
 	kvfree(info);
 
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 
@@ -8597,14 +8549,13 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
 	 * waiters
 	 */
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	/* Make sure the waiters see the new wait_index */
 	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
-	mutex_unlock(&trace_types_lock);
 	return 0;
 }
 
@@ -9094,10 +9045,9 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return -EINVAL;
 
 	if (!!(topt->flags->val & topt->opt->bit) != val) {
-		mutex_lock(&trace_types_lock);
+		guard(mutex)(&trace_types_lock);
 		ret = __set_tracer_option(topt->tr, topt->flags,
 					  topt->opt, !val);
-		mutex_unlock(&trace_types_lock);
 		if (ret)
 			return ret;
 	}
@@ -9406,7 +9356,7 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 		return ret;
 
 	if (buffer) {
-		mutex_lock(&trace_types_lock);
+		guard(mutex)(&trace_types_lock);
 		if (!!val == tracer_tracing_is_on(tr)) {
 			val = 0; /* do nothing */
 		} else if (val) {
@@ -9420,7 +9370,6 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 			/* Wake up any waiters */
 			ring_buffer_wake_waiters(buffer, RING_BUFFER_ALL_CPUS);
 		}
-		mutex_unlock(&trace_types_lock);
 	}
 
 	(*ppos)++;
@@ -9804,10 +9753,9 @@ static void __update_tracer_options(struct trace_array *tr)
 
 static void update_tracer_options(struct trace_array *tr)
 {
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tracer_options_updated = true;
 	__update_tracer_options(tr);
-	mutex_unlock(&trace_types_lock);
 }
 
 /* Must have trace_types_lock held */
@@ -9829,11 +9777,10 @@ struct trace_array *trace_array_find_get(const char *instance)
 {
 	struct trace_array *tr;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	tr = trace_array_find(instance);
 	if (tr)
 		tr->ref++;
-	mutex_unlock(&trace_types_lock);
 
 	return tr;
 }
-- 
2.47.2


