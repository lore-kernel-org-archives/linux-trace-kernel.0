Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F129B793;
	Fri,  6 Feb 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395812; cv=none; b=Pzt9I5b6AugA4zuqsU9enyvh2lMqbnRQFlm3apqY+FxTVBWlAPSyzd71dL3RvUWfKG+EvUtlkvO32kv6mqNwLfr6ZyxsCiPvrbbb7DpOVOWha8yC/rWB4cT6yOaz3H7GvG6mapBIs3IluEXbk8SYQr2xA6FNtoJ1Y+bPhc1wFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395812; c=relaxed/simple;
	bh=tK9+sU92ytzdEV93H3dl5uyVnE6TWDBl6Mid5xh9nDA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j3sJf6qlU7nw1PdKMwaDPZ39+r/QSwwtiaJ9QIjnFLcvlDTTMyPM7LUw4zCAVVKZJqp8wdFJ+JOtvPiAanbnYoGH5XmovhupSohKjlvsTCK3KAP8+j/PvQrdi0k+WqsWR0CXnFZ2rxdOw7z3h5Xy78pho6FT1Xs7DHo2q+wTKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaRaC9dN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaRaC9dN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32688C19424;
	Fri,  6 Feb 2026 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395812;
	bh=tK9+sU92ytzdEV93H3dl5uyVnE6TWDBl6Mid5xh9nDA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WaRaC9dNTnp92q3nHGXMLLXJsvD0P3KtOzWjoTKq65T6yTlxSmrQMx0rcF3iZmKQ0
	 K7xyRnIdMmWZaJVGsn5YfT+Kn0Hz2pH2GWYkstrOcrLIC/GkpnsRFWBphj+zSnyaXI
	 0/we+Iq+YFWuEyaIW/h8ZlgpON5eH1sNwMAKO5RHSsLScuUXmoBrC5D+4qcXlftAwm
	 SK8iETw1ePd+Lxz24KGlujisoyDMhaYmaCOYBRYbdcCjYYABJwl4lw/inKyy75sRvo
	 YCzuI1q9DnUmbdOABhnBaH3R4lTxrxnFXwBOkGYWAeYe5+1w6WTmwom3gQKNqs9I2E
	 u/QCkOZkJiVFg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voOpm-0000000A1ns-3K4T;
	Fri, 06 Feb 2026 11:37:30 -0500
Message-ID: <20260206163730.646608053@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 11:35:56 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] tracing: Rename trace_array field max_buffer to snapshot_buffer
References: <20260206163554.153428314@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When tracing was first added, there were latency tracers that would take a
snapshot of the current trace when a new max latency was hit. This
snapshot buffer was called "max_buffer". Since then, a snapshot feature
was added that allowed user space or event triggers to trigger a snapshot
of the current buffer using the same max_buffer of the trace_array.

As this snapshot buffer now has a more generic use case, calling it
"max_buffer" is confusing. Rename it to snapshot_buffer.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c          | 72 +++++++++++++++++------------------
 kernel/trace/trace.h          | 13 ++++---
 kernel/trace/trace_selftest.c | 10 ++---
 3 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 54851ffbabeb..dfa30711c6e2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -934,12 +934,12 @@ int tracing_alloc_snapshot_instance(struct trace_array *tr)
 
 		/* Make the snapshot buffer have the same order as main buffer */
 		order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
-		ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
+		ret = ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, order);
 		if (ret < 0)
 			return ret;
 
 		/* allocate spare buffer */
-		ret = resize_buffer_duplicate_size(&tr->max_buffer,
+		ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
 				   &tr->array_buffer, RING_BUFFER_ALL_CPUS);
 		if (ret < 0)
 			return ret;
@@ -957,10 +957,10 @@ static void free_snapshot(struct trace_array *tr)
 	 * The max_tr ring buffer has some state (e.g. ring->clock) and
 	 * we want preserve it.
 	 */
-	ring_buffer_subbuf_order_set(tr->max_buffer.buffer, 0);
-	ring_buffer_resize(tr->max_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
-	set_buffer_entries(&tr->max_buffer, 1);
-	tracing_reset_online_cpus(&tr->max_buffer);
+	ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, 0);
+	ring_buffer_resize(tr->snapshot_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
+	set_buffer_entries(&tr->snapshot_buffer, 1);
+	tracing_reset_online_cpus(&tr->snapshot_buffer);
 	tr->allocated_snapshot = false;
 }
 
@@ -1562,7 +1562,7 @@ static void
 __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 {
 	struct array_buffer *trace_buf = &tr->array_buffer;
-	struct array_buffer *max_buf = &tr->max_buffer;
+	struct array_buffer *max_buf = &tr->snapshot_buffer;
 	struct trace_array_cpu *data = per_cpu_ptr(trace_buf->data, cpu);
 	struct trace_array_cpu *max_data = per_cpu_ptr(max_buf->data, cpu);
 
@@ -1622,9 +1622,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 
 	/* Inherit the recordable setting from array_buffer */
 	if (ring_buffer_record_is_set_on(tr->array_buffer.buffer))
-		ring_buffer_record_on(tr->max_buffer.buffer);
+		ring_buffer_record_on(tr->snapshot_buffer.buffer);
 	else
-		ring_buffer_record_off(tr->max_buffer.buffer);
+		ring_buffer_record_off(tr->snapshot_buffer.buffer);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data)) {
@@ -1632,7 +1632,7 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		return;
 	}
 #endif
-	swap(tr->array_buffer.buffer, tr->max_buffer.buffer);
+	swap(tr->array_buffer.buffer, tr->snapshot_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);
 
@@ -1667,7 +1667,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	arch_spin_lock(&tr->max_lock);
 
-	ret = ring_buffer_swap_cpu(tr->max_buffer.buffer, tr->array_buffer.buffer, cpu);
+	ret = ring_buffer_swap_cpu(tr->snapshot_buffer.buffer, tr->array_buffer.buffer, cpu);
 
 	if (ret == -EBUSY) {
 		/*
@@ -1677,7 +1677,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 		 * and flag that it failed.
 		 * Another reason is resize is in progress.
 		 */
-		trace_array_printk_buf(tr->max_buffer.buffer, _THIS_IP_,
+		trace_array_printk_buf(tr->snapshot_buffer.buffer, _THIS_IP_,
 			"Failed to swap buffers due to commit or resize in progress\n");
 	}
 
@@ -1726,7 +1726,7 @@ static int wait_on_pipe(struct trace_iterator *iter, int full)
 	 * to happen, this would now be the main buffer.
 	 */
 	if (iter->snapshot)
-		iter->array_buffer = &iter->tr->max_buffer;
+		iter->array_buffer = &iter->tr->snapshot_buffer;
 #endif
 	return ret;
 }
@@ -1794,7 +1794,7 @@ static int run_tracer_selftest(struct tracer *type)
 	if (type->use_max_tr) {
 		/* If we expanded the buffers, make sure the max is expanded too */
 		if (tr->ring_buffer_expanded)
-			ring_buffer_resize(tr->max_buffer.buffer, trace_buf_size,
+			ring_buffer_resize(tr->snapshot_buffer.buffer, trace_buf_size,
 					   RING_BUFFER_ALL_CPUS);
 		tr->allocated_snapshot = true;
 	}
@@ -1821,7 +1821,7 @@ static int run_tracer_selftest(struct tracer *type)
 
 		/* Shrink the max buffer again */
 		if (tr->ring_buffer_expanded)
-			ring_buffer_resize(tr->max_buffer.buffer, 1,
+			ring_buffer_resize(tr->snapshot_buffer.buffer, 1,
 					   RING_BUFFER_ALL_CPUS);
 	}
 #endif
@@ -2064,7 +2064,7 @@ void tracing_reset_all_online_cpus_unlocked(void)
 		tr->clear_trace = false;
 		tracing_reset_online_cpus(&tr->array_buffer);
 #ifdef CONFIG_TRACER_SNAPSHOT
-		tracing_reset_online_cpus(&tr->max_buffer);
+		tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
 	}
 }
@@ -2104,7 +2104,7 @@ static void tracing_start_tr(struct trace_array *tr)
 		ring_buffer_record_enable(buffer);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	buffer = tr->max_buffer.buffer;
+	buffer = tr->snapshot_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 #endif
@@ -2140,7 +2140,7 @@ static void tracing_stop_tr(struct trace_array *tr)
 		ring_buffer_record_disable(buffer);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	buffer = tr->max_buffer.buffer;
+	buffer = tr->snapshot_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 #endif
@@ -3947,7 +3947,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 #ifdef CONFIG_TRACER_SNAPSHOT
 	/* Currently only the top directory has a snapshot */
 	if (tr->current_trace->print_max || snapshot)
-		iter->array_buffer = &tr->max_buffer;
+		iter->array_buffer = &tr->snapshot_buffer;
 	else
 #endif
 		iter->array_buffer = &tr->array_buffer;
@@ -4150,7 +4150,7 @@ static int tracing_open(struct inode *inode, struct file *file)
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 		if (tr->current_trace->print_max)
-			trace_buf = &tr->max_buffer;
+			trace_buf = &tr->snapshot_buffer;
 #endif
 
 		if (cpu == RING_BUFFER_ALL_CPUS)
@@ -4363,14 +4363,14 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_SNAPSHOT
-			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+			ring_buffer_record_disable_cpu(tr->snapshot_buffer.buffer, cpu);
 #endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_SNAPSHOT
-			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+			ring_buffer_record_enable_cpu(tr->snapshot_buffer.buffer, cpu);
 #endif
 		}
 	}
@@ -4580,7 +4580,7 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 	case TRACE_ITER(OVERWRITE):
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_SNAPSHOT
-		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
+		ring_buffer_change_overwrite(tr->snapshot_buffer.buffer, enabled);
 #endif
 		break;
 
@@ -5298,7 +5298,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->allocated_snapshot)
 		goto out;
 
-	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
+	ret = ring_buffer_resize(tr->snapshot_buffer.buffer, size, cpu);
 	if (ret < 0) {
 		int r = resize_buffer_duplicate_size(&tr->array_buffer,
 						     &tr->array_buffer, cpu);
@@ -5323,7 +5323,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 	}
 
-	update_buffer_entries(&tr->max_buffer, cpu);
+	update_buffer_entries(&tr->snapshot_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_SNAPSHOT */
@@ -7040,9 +7040,9 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	if (tr->max_buffer.buffer)
-		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
-	tracing_reset_online_cpus(&tr->max_buffer);
+	if (tr->snapshot_buffer.buffer)
+		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
+	tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
@@ -7174,7 +7174,7 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 		ret = 0;
 
 		iter->tr = tr;
-		iter->array_buffer = &tr->max_buffer;
+		iter->array_buffer = &tr->snapshot_buffer;
 		iter->cpu_file = tracing_get_cpu(inode);
 		m->private = iter;
 		file->private_data = m;
@@ -7237,7 +7237,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			return -EINVAL;
 #endif
 		if (tr->allocated_snapshot)
-			ret = resize_buffer_duplicate_size(&tr->max_buffer,
+			ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
 					&tr->array_buffer, iter->cpu_file);
 
 		ret = tracing_arm_snapshot_locked(tr);
@@ -7258,9 +7258,9 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	default:
 		if (tr->allocated_snapshot) {
 			if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
-				tracing_reset_online_cpus(&tr->max_buffer);
+				tracing_reset_online_cpus(&tr->snapshot_buffer);
 			else
-				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
+				tracing_reset_cpu(&tr->snapshot_buffer, iter->cpu_file);
 		}
 		break;
 	}
@@ -7316,7 +7316,7 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 	}
 
 	info->iter.snapshot = true;
-	info->iter.array_buffer = &info->iter.tr->max_buffer;
+	info->iter.array_buffer = &info->iter.tr->snapshot_buffer;
 
 	return ret;
 }
@@ -9199,7 +9199,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	if (!tr->allocated_snapshot)
 		goto out_max;
 
-	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
+	ret = ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, order);
 	if (ret) {
 		/* Put back the old order */
 		cnt = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, old_order);
@@ -9420,7 +9420,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	if (tr->range_addr_start)
 		return 0;
 
-	ret = allocate_trace_buffer(tr, &tr->max_buffer,
+	ret = allocate_trace_buffer(tr, &tr->snapshot_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
 		free_trace_buffer(&tr->array_buffer);
@@ -9443,7 +9443,7 @@ static void free_trace_buffers(struct trace_array *tr)
 	kfree(tr->module_delta);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	free_trace_buffer(&tr->max_buffer);
+	free_trace_buffer(&tr->snapshot_buffer);
 #endif
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e6f4e10060be..374b7c392f0a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -331,17 +331,18 @@ struct trace_array {
 	struct array_buffer	array_buffer;
 #ifdef CONFIG_TRACER_SNAPSHOT
 	/*
-	 * The max_buffer is used to snapshot the trace when a maximum
+	 * The snapshot_buffer is used to snapshot the trace when a maximum
 	 * latency is reached, or when the user initiates a snapshot.
 	 * Some tracers will use this to store a maximum trace while
 	 * it continues examining live traces.
 	 *
-	 * The buffers for the max_buffer are set up the same as the array_buffer
-	 * When a snapshot is taken, the buffer of the max_buffer is swapped
-	 * with the buffer of the array_buffer and the buffers are reset for
-	 * the array_buffer so the tracing can continue.
+	 * The buffers for the snapshot_buffer are set up the same as the
+	 * array_buffer. When a snapshot is taken, the buffer of the
+	 * snapshot_buffer is swapped with the buffer of the array_buffer
+	 * and the buffers are reset for the array_buffer so the tracing can
+	 * continue.
 	 */
-	struct array_buffer	max_buffer;
+	struct array_buffer	snapshot_buffer;
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index d88c44f1dfa5..be53fe6fee6a 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -1225,7 +1225,7 @@ trace_selftest_startup_irqsoff(struct tracer *trace, struct trace_array *tr)
 	/* check both trace buffers */
 	ret = trace_test_buffer(&tr->array_buffer, NULL);
 	if (!ret)
-		ret = trace_test_buffer(&tr->max_buffer, &count);
+		ret = trace_test_buffer(&tr->snapshot_buffer, &count);
 	trace->reset(tr);
 	tracing_start();
 
@@ -1287,7 +1287,7 @@ trace_selftest_startup_preemptoff(struct tracer *trace, struct trace_array *tr)
 	/* check both trace buffers */
 	ret = trace_test_buffer(&tr->array_buffer, NULL);
 	if (!ret)
-		ret = trace_test_buffer(&tr->max_buffer, &count);
+		ret = trace_test_buffer(&tr->snapshot_buffer, &count);
 	trace->reset(tr);
 	tracing_start();
 
@@ -1355,7 +1355,7 @@ trace_selftest_startup_preemptirqsoff(struct tracer *trace, struct trace_array *
 	if (ret)
 		goto out;
 
-	ret = trace_test_buffer(&tr->max_buffer, &count);
+	ret = trace_test_buffer(&tr->snapshot_buffer, &count);
 	if (ret)
 		goto out;
 
@@ -1385,7 +1385,7 @@ trace_selftest_startup_preemptirqsoff(struct tracer *trace, struct trace_array *
 	if (ret)
 		goto out;
 
-	ret = trace_test_buffer(&tr->max_buffer, &count);
+	ret = trace_test_buffer(&tr->snapshot_buffer, &count);
 
 	if (!ret && !count) {
 		printk(KERN_CONT ".. no entries found ..");
@@ -1513,7 +1513,7 @@ trace_selftest_startup_wakeup(struct tracer *trace, struct trace_array *tr)
 	/* check both trace buffers */
 	ret = trace_test_buffer(&tr->array_buffer, NULL);
 	if (!ret)
-		ret = trace_test_buffer(&tr->max_buffer, &count);
+		ret = trace_test_buffer(&tr->snapshot_buffer, &count);
 
 
 	trace->reset(tr);
-- 
2.51.0


