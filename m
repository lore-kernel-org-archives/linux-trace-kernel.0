Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2B288515;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523299; cv=none; b=UFGF2YyWikQv/z9Sa3dG3uV3JVIFIylUF+FqFpJtKTAhtkbSs7LRjXQ9GrtF4RaC3APq1b4VWDc/zin6T1tknPW83yPZyc5JwdpitWzsCdaZoWGqcX8gUl1WVEhsIC2Ek3fzqFli7GdHR7pTnlU73LQFE1rR1S1dTLcCVXo+6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523299; c=relaxed/simple;
	bh=Ul02+782QirWIXwYb/5iiAQRH2/EyWS+PXIYcseE1R4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IvB7HZ5ssQmTbaNTuzvVM/Z3OVIhhhoJqA/awpKwNwtD10RofRGAtBYMMjSGDVIjLmiMyATGrZwxd93kYvGzMzyvpCUAoeAwHs2JKhBlQ/K1fh8D5CMPv32oRc7asZanYoaFC4Sy8T3XQxcRKHeQGvTMQZyOTy7ESdxFEebABQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwyqc905; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwyqc905"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B001CC2BC87;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770523298;
	bh=Ul02+782QirWIXwYb/5iiAQRH2/EyWS+PXIYcseE1R4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Gwyqc905h5hupRAjgsanpHyzNaTSlXFDF9nXRaZW5bvwA/Iho7YctdKkKMj7T1bNi
	 PPb2DGiKvtvzXtZgi1L2jH2+QiER8MOfcMQ/TMMbRKghdUoxsfsHgNBxtyuACTR78C
	 SGdTXy+zH9CjrfX42BcC65/nfQvfRfEuGQ4KpuDIZX3FvPiqdaVD2T1HF+WW9mXDfl
	 dTkLkadtJPvjlJu4AcJ2Y2TGqjpqEmSK4X7ro7nDdzykUl8CqSgodZpaIXBklPEz5n
	 Mr8XgoEBxilJlLdJ30FViPWjmB+NhSlWYxtHBgbVPNce7RqwhcQb85G1lqHZMSCTbB
	 MrrYKnbdracZQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vow06-0000000AOyW-0r3k;
	Sat, 07 Feb 2026 23:02:22 -0500
Message-ID: <20260208040222.068849312@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 23:01:59 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/3] tracing: Better separate SNAPSHOT and MAX_TRACE options
References: <20260208040156.005531619@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The latency tracers (scheduler, irqsoff, etc) were created when tracing
was first added. These tracers required a "snapshot" buffer that was the
same size as the ring buffer being written to. When a new max latency was
hit, the main ring buffer would swap with the snapshot buffer so that the
trace leading up to the latency would be saved in the snapshot buffer (The
snapshot buffer is never written to directly and the data within it can be
viewed without fear of being overwritten).

Later, a new feature was added to allow snapshots to be taken by user
space or even event triggers. This created a "snapshot" file that allowed
users to trigger a snapshot from user space to save the current trace.

The config for this new feature (CONFIG_TRACER_SNAPSHOT) would select the
latency tracer config (CONFIG_TRACER_MAX_LATENCY) as it would need all the
functionality from it as it already existed. But this was incorrect. As
the snapshot feature is really what the latency tracers need and not the
other way around.

Have CONFIG_TRACER_MAX_TRACE select CONFIG_TRACER_SNAPSHOT where the
tracers that needs the max latency buffer selects the TRACE_MAX_TRACE
which will then select TRACER_SNAPSHOT.

Also, go through trace.c and trace.h and make the code that only needs the
TRACER_MAX_TRACE protected by that and the code that always requires the
snapshot to be protected by TRACER_SNAPSHOT.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig |  8 ++---
 kernel/trace/trace.c | 70 +++++++++++++++++++++++---------------------
 kernel/trace/trace.h | 19 +++++++-----
 3 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index bfa2ec46e075..bedb2f982823 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -133,6 +133,7 @@ config BUILDTIME_MCOUNT_SORT
 
 config TRACER_MAX_TRACE
 	bool
+	select TRACER_SNAPSHOT
 
 config TRACE_CLOCK
 	bool
@@ -422,7 +423,6 @@ config IRQSOFF_TRACER
 	select GENERIC_TRACER
 	select TRACER_MAX_TRACE
 	select RING_BUFFER_ALLOW_SWAP
-	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
 	help
 	  This option measures the time spent in irqs-off critical
@@ -445,7 +445,6 @@ config PREEMPT_TRACER
 	select GENERIC_TRACER
 	select TRACER_MAX_TRACE
 	select RING_BUFFER_ALLOW_SWAP
-	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
 	select TRACE_PREEMPT_TOGGLE
 	help
@@ -467,7 +466,6 @@ config SCHED_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select TRACER_MAX_TRACE
-	select TRACER_SNAPSHOT
 	help
 	  This tracer tracks the latency of the highest priority task
 	  to be scheduled in, starting from the point it has woken up.
@@ -617,7 +615,6 @@ config TRACE_SYSCALL_BUF_SIZE_DEFAULT
 
 config TRACER_SNAPSHOT
 	bool "Create a snapshot trace buffer"
-	select TRACER_MAX_TRACE
 	help
 	  Allow tracing users to take snapshot of the current buffer using the
 	  ftrace interface, e.g.:
@@ -625,6 +622,9 @@ config TRACER_SNAPSHOT
 	      echo 1 > /sys/kernel/tracing/snapshot
 	      cat snapshot
 
+	  Note, the latency tracers select this option. To disable it,
+	  all the latency tracers need to be disabled.
+
 config TRACER_SNAPSHOT_PER_CPU_SWAP
 	bool "Allow snapshot to swap per CPU"
 	depends on TRACER_SNAPSHOT
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9fbb124e87dc..fdd47da0dff1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -825,15 +825,15 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 		return;
 	}
 
-	/* Note, snapshot can not be used when the tracer uses it */
-	if (tracer_uses_snapshot(tr->current_trace)) {
-		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
+	if (tr->mapped) {
+		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
 		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
 		return;
 	}
 
-	if (tr->mapped) {
-		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
+	/* Note, snapshot can not be used when the tracer uses it */
+	if (tracer_uses_snapshot(tr->current_trace)) {
+		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
 		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
 		return;
 	}
@@ -1555,8 +1555,8 @@ static void
 __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 {
 	struct array_buffer *trace_buf = &tr->array_buffer;
-	struct array_buffer *max_buf = &tr->snapshot_buffer;
 	struct trace_array_cpu *data = per_cpu_ptr(trace_buf->data, cpu);
+	struct array_buffer *max_buf = &tr->snapshot_buffer;
 	struct trace_array_cpu *max_data = per_cpu_ptr(max_buf->data, cpu);
 
 	max_buf->cpu = cpu;
@@ -1585,7 +1585,14 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	tracing_record_cmdline(tsk);
 	latency_fsnotify(tr);
 }
+#else
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
+static inline void __update_max_tr(struct trace_array *tr,
+				   struct task_struct *tsk, int cpu) { }
+#endif /* CONFIG_TRACER_MAX_TRACE */
 
+#ifdef CONFIG_TRACER_SNAPSHOT
 /**
  * update_max_tr - snapshot all trace buffers from global_trace to max_tr
  * @tr: tracer
@@ -1619,12 +1626,11 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	else
 		ring_buffer_record_off(tr->snapshot_buffer.buffer);
 
-#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data)) {
 		arch_spin_unlock(&tr->max_lock);
 		return;
 	}
-#endif
+
 	swap(tr->array_buffer.buffer, tr->snapshot_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);
@@ -1715,7 +1721,7 @@ static int wait_on_pipe(struct trace_iterator *iter, int full)
 	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full,
 			       wait_pipe_cond, &pwait);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/*
 	 * Make sure this is still the snapshot buffer, as if a snapshot were
 	 * to happen, this would now be the main buffer.
@@ -2058,7 +2064,7 @@ void tracing_reset_all_online_cpus_unlocked(void)
 			continue;
 		tr->clear_trace = false;
 		tracing_reset_online_cpus(&tr->array_buffer);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 		tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
 	}
@@ -2098,7 +2104,7 @@ static void tracing_start_tr(struct trace_array *tr)
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	buffer = tr->snapshot_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
@@ -2134,7 +2140,7 @@ static void tracing_stop_tr(struct trace_array *tr)
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	buffer = tr->snapshot_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
@@ -3757,7 +3763,7 @@ static void test_ftrace_alive(struct seq_file *m)
 		    "#          MAY BE MISSING FUNCTION EVENTS\n");
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 static void show_snapshot_main_help(struct seq_file *m)
 {
 	seq_puts(m, "# echo 0 > snapshot : Clears and frees snapshot buffer\n"
@@ -3935,7 +3941,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 	iter->tr = tr;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/* Currently only the top directory has a snapshot */
 	if (tr->current_trace->print_max || snapshot)
 		iter->array_buffer = &tr->snapshot_buffer;
@@ -4351,14 +4357,14 @@ int tracing_set_cpumask(struct trace_array *tr,
 		if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 			ring_buffer_record_disable_cpu(tr->snapshot_buffer.buffer, cpu);
 #endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 			ring_buffer_record_enable_cpu(tr->snapshot_buffer.buffer, cpu);
 #endif
 		}
@@ -4568,7 +4574,7 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 
 	case TRACE_ITER(OVERWRITE):
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 		ring_buffer_change_overwrite(tr->snapshot_buffer.buffer, enabled);
 #endif
 		break;
@@ -5232,7 +5238,7 @@ static void update_buffer_entries(struct array_buffer *buf, int cpu)
 	}
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
 					struct array_buffer *size_buf, int cpu_id)
@@ -5258,7 +5264,7 @@ static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
 
 	return ret;
 }
-#endif /* CONFIG_TRACER_MAX_TRACE */
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 static int __tracing_resize_ring_buffer(struct trace_array *tr,
 					unsigned long size, int cpu)
@@ -5283,7 +5289,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (ret < 0)
 		goto out_start;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	if (!tr->allocated_snapshot)
 		goto out;
 
@@ -5315,7 +5321,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	update_buffer_entries(&tr->snapshot_buffer, cpu);
 
  out:
-#endif /* CONFIG_TRACER_MAX_TRACE */
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 	update_buffer_entries(&tr->array_buffer, cpu);
  out_start:
@@ -5543,9 +5549,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
 	struct tracer *trace = NULL;
 	struct tracers *t;
-#ifdef CONFIG_TRACER_MAX_TRACE
 	bool had_max_tr;
-#endif
 	int ret;
 
 	guard(mutex)(&trace_types_lock);
@@ -7021,7 +7025,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	 */
 	tracing_reset_online_cpus(&tr->array_buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->snapshot_buffer.buffer)
 		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
@@ -8168,7 +8172,7 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 static int get_snapshot_map(struct trace_array *tr)
 {
 	int err = 0;
@@ -9172,7 +9176,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 
 	if (!tr->allocated_snapshot)
 		goto out_max;
@@ -9393,7 +9397,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/* Fix mapped buffer trace arrays do not have snapshot buffers */
 	if (tr->range_addr_start)
 		return 0;
@@ -9420,7 +9424,7 @@ static void free_trace_buffers(struct trace_array *tr)
 	free_trace_buffer(&tr->array_buffer);
 	kfree(tr->module_delta);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	free_trace_buffer(&tr->snapshot_buffer);
 #endif
 }
@@ -9562,7 +9566,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	tr->syscall_buf_sz = global_trace.syscall_buf_sz;
 
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	spin_lock_init(&tr->snapshot_trigger_lock);
 #endif
 	tr->current_trace = &nop_trace;
@@ -10516,7 +10520,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 	return done;
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 __init static bool tr_needs_alloc_snapshot(const char *name)
 {
 	char *test;
@@ -10706,7 +10710,7 @@ __init static void enable_instances(void)
 			}
 		} else {
 			/* Only non mapped buffers have snapshot buffers */
-			if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
+			if (IS_ENABLED(CONFIG_TRACER_SNAPSHOT))
 				do_allocate_snapshot(name);
 		}
 
@@ -10833,7 +10837,7 @@ __init static int tracer_alloc_buffers(void)
 	global_trace.current_trace_flags = nop_trace.flags;
 
 	global_trace.max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	spin_lock_init(&global_trace.snapshot_trigger_lock);
 #endif
 	ftrace_init_global_array_ops(&global_trace);
@@ -10901,7 +10905,7 @@ struct trace_array *trace_get_global_array(void)
 
 void __init ftrace_boot_snapshot(void)
 {
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	struct trace_array *tr;
 
 	if (!snapshot_at_boot)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ebb47abc0ee7..649fdd20fc91 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -329,7 +329,7 @@ struct trace_array {
 	struct list_head	list;
 	char			*name;
 	struct array_buffer	array_buffer;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/*
 	 * The snapshot_buffer is used to snapshot the trace when a maximum
 	 * latency is reached, or when the user initiates a snapshot.
@@ -346,13 +346,16 @@ struct trace_array {
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
+#ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
 	struct work_struct	fsnotify_work;
 	struct irq_work		fsnotify_irqwork;
-#endif
-#endif
+#endif /* CONFIG_FSNOTIFY */
+#endif /* CONFIG_TRACER_MAX_TRACE */
+#endif /* CONFIG_TRACER_SNAPSHOT */
+
 	/* The below is for memory mapped ring buffer */
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
@@ -378,7 +381,7 @@ struct trace_array {
 	 *
 	 * It is also used in other places outside the update_max_tr
 	 * so it needs to be defined outside of the
-	 * CONFIG_TRACER_MAX_TRACE.
+	 * CONFIG_TRACER_SNAPSHOT.
 	 */
 	arch_spinlock_t		max_lock;
 #ifdef CONFIG_FTRACE_SYSCALLS
@@ -791,22 +794,22 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		    struct trace_pid_list **new_pid_list,
 		    const char __user *ubuf, size_t cnt);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		   void *cond_data);
 void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 
-#ifdef CONFIG_FSNOTIFY
-#define LATENCY_FS_NOTIFY
+#if defined(CONFIG_TRACER_MAX_TRACE) && defined(CONFIG_FSNOTIFY)
+# define LATENCY_FS_NOTIFY
 #endif
-#endif /* CONFIG_TRACER_MAX_TRACE */
 
 #ifdef LATENCY_FS_NOTIFY
 void latency_fsnotify(struct trace_array *tr);
 #else
 static inline void latency_fsnotify(struct trace_array *tr) { }
 #endif
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef CONFIG_STACKTRACE
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx, int skip);
-- 
2.51.0


