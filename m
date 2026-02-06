Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541911C84C0;
	Fri,  6 Feb 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395812; cv=none; b=PNmwkg0ETXPYQGNxIRdGbggCC2ql83uwudDF/kUzSMOUud1f/WspT/Y8gVz+5ZGHiXLkAf+5nnygTWAzYnapzgebw1QHuWZ7GuWR8QtekQhiUc3uHvdCYcH4LcMDWUGKQGdNY0QLsuIlKmXI2Sq7aR9eiOs4WGi6d62VpL4LIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395812; c=relaxed/simple;
	bh=xabnm7PNoEGiPTMjwsnWPERF+KMsquNYJqx5NVKNDJE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MN9c+QZKGUCq3kkhDWYyuqtxaNUYJ5fygn6jingezxUVuRXkZb7Ff5bTMEweHjpm9MsDUmOMWQQGwL9vzFrDxHI7WT9NVM204snAhxDQaVTGBTavJZLrZXrSnL21sCZ8PyzM0Hnqo3tmB5bytLuZPUjK0mBAPL5AKPs9vlgbr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGn5xZrm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGn5xZrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7FCC19422;
	Fri,  6 Feb 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395812;
	bh=xabnm7PNoEGiPTMjwsnWPERF+KMsquNYJqx5NVKNDJE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ZGn5xZrmsQluRwW0Pzd4roJ2tax6IVvbMz0HZvOJBa6jPq/WB6hawqGc05d1ZyoY3
	 99XsMkuDuEr6KJA+YTMt+HV0YeU9zFIG2IlHkwA21Vrm3Nb6NnEtEThnJkzXCcm/R2
	 pdAxewRQYUaP/nHK5tGb9B7BnGAjRDj+tv/JpLxXmojeWG+2H8ChYqQ44hOX7NDqyR
	 BcfxBCdTkCF5DuUNqCWTFR509WSqsolTUGDD3EgYgfUfEZaR1ueIVAFOtMTNV+RjeX
	 cjC2H4Hzba3lEgPEQfVc48HnhTiBEAq7dL9Edd9+mpvYmxu0KYOoBUaKBWkRNLa0Lg
	 mDy9oKCxmz72g==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voOpm-0000000A1nO-2d47;
	Fri, 06 Feb 2026 11:37:30 -0500
Message-ID: <20260206163730.481044282@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 11:35:55 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tracing: Better separate SNAPSHOT and MAX_TRACE options
References: <20260206163554.153428314@kernel.org>
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
 kernel/trace/Kconfig |  8 +++----
 kernel/trace/trace.c | 50 ++++++++++++++++++++++----------------------
 kernel/trace/trace.h | 11 ++++++----
 3 files changed, 36 insertions(+), 33 deletions(-)

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
index abf28f92b678..54851ffbabeb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1720,7 +1720,7 @@ static int wait_on_pipe(struct trace_iterator *iter, int full)
 	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full,
 			       wait_pipe_cond, &pwait);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/*
 	 * Make sure this is still the snapshot buffer, as if a snapshot were
 	 * to happen, this would now be the main buffer.
@@ -2063,7 +2063,7 @@ void tracing_reset_all_online_cpus_unlocked(void)
 			continue;
 		tr->clear_trace = false;
 		tracing_reset_online_cpus(&tr->array_buffer);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 		tracing_reset_online_cpus(&tr->max_buffer);
 #endif
 	}
@@ -2103,7 +2103,7 @@ static void tracing_start_tr(struct trace_array *tr)
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
@@ -2139,7 +2139,7 @@ static void tracing_stop_tr(struct trace_array *tr)
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
@@ -3766,7 +3766,7 @@ static void test_ftrace_alive(struct seq_file *m)
 		    "#          MAY BE MISSING FUNCTION EVENTS\n");
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 static void show_snapshot_main_help(struct seq_file *m)
 {
 	seq_puts(m, "# echo 0 > snapshot : Clears and frees snapshot buffer\n"
@@ -3944,7 +3944,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 	iter->tr = tr;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/* Currently only the top directory has a snapshot */
 	if (tr->current_trace->print_max || snapshot)
 		iter->array_buffer = &tr->max_buffer;
@@ -4181,7 +4181,7 @@ static int tracing_open(struct inode *inode, struct file *file)
 static bool
 trace_ok_for_array(struct tracer *t, struct trace_array *tr)
 {
-#ifdef CONFIG_TRACER_SNAPSHOT
+#ifdef CONFIG_TRACER_MAX_TRACE
 	/* arrays with mapped buffer range do not have snapshots */
 	if (tr->range_addr_start && t->use_max_tr)
 		return false;
@@ -4362,14 +4362,14 @@ int tracing_set_cpumask(struct trace_array *tr,
 		if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
 #endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
 #endif
 		}
@@ -4579,7 +4579,7 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 
 	case TRACE_ITER(OVERWRITE):
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 		ring_buffer_change_overwrite(tr->max_buffer.buffer, enabled);
 #endif
 		break;
@@ -5243,7 +5243,7 @@ static void update_buffer_entries(struct array_buffer *buf, int cpu)
 	}
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
 					struct array_buffer *size_buf, int cpu_id)
@@ -5269,7 +5269,7 @@ static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
 
 	return ret;
 }
-#endif /* CONFIG_TRACER_MAX_TRACE */
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 static int __tracing_resize_ring_buffer(struct trace_array *tr,
 					unsigned long size, int cpu)
@@ -5294,7 +5294,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (ret < 0)
 		goto out_start;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	if (!tr->allocated_snapshot)
 		goto out;
 
@@ -5326,7 +5326,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	update_buffer_entries(&tr->max_buffer, cpu);
 
  out:
-#endif /* CONFIG_TRACER_MAX_TRACE */
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 	update_buffer_entries(&tr->array_buffer, cpu);
  out_start:
@@ -5583,7 +5583,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (trace == tr->current_trace)
 		return 0;
 
-#ifdef CONFIG_TRACER_SNAPSHOT
+#ifdef CONFIG_TRACER_MAX_TRACE
 	if (trace->use_max_tr) {
 		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
@@ -7039,7 +7039,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	 */
 	tracing_reset_online_cpus(&tr->array_buffer);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->max_buffer.buffer)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
@@ -8190,7 +8190,7 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 static int get_snapshot_map(struct trace_array *tr)
 {
 	int err = 0;
@@ -9194,7 +9194,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 
 	if (!tr->allocated_snapshot)
 		goto out_max;
@@ -9415,7 +9415,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/* Fix mapped buffer trace arrays do not have snapshot buffers */
 	if (tr->range_addr_start)
 		return 0;
@@ -9442,7 +9442,7 @@ static void free_trace_buffers(struct trace_array *tr)
 	free_trace_buffer(&tr->array_buffer);
 	kfree(tr->module_delta);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	free_trace_buffer(&tr->max_buffer);
 #endif
 }
@@ -9584,7 +9584,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	tr->syscall_buf_sz = global_trace.syscall_buf_sz;
 
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	spin_lock_init(&tr->snapshot_trigger_lock);
 #endif
 	tr->current_trace = &nop_trace;
@@ -10540,7 +10540,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 	return done;
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 __init static bool tr_needs_alloc_snapshot(const char *name)
 {
 	char *test;
@@ -10730,7 +10730,7 @@ __init static void enable_instances(void)
 			}
 		} else {
 			/* Only non mapped buffers have snapshot buffers */
-			if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
+			if (IS_ENABLED(CONFIG_TRACER_SNAPSHOT))
 				do_allocate_snapshot(name);
 		}
 
@@ -10857,7 +10857,7 @@ __init static int tracer_alloc_buffers(void)
 	global_trace.current_trace_flags = nop_trace.flags;
 
 	global_trace.max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	spin_lock_init(&global_trace.snapshot_trigger_lock);
 #endif
 	ftrace_init_global_array_ops(&global_trace);
@@ -10925,7 +10925,7 @@ struct trace_array *trace_get_global_array(void)
 
 void __init ftrace_boot_snapshot(void)
 {
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	struct trace_array *tr;
 
 	if (!snapshot_at_boot)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6bd5f4a87909..e6f4e10060be 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -329,7 +329,7 @@ struct trace_array {
 	struct list_head	list;
 	char			*name;
 	struct array_buffer	array_buffer;
-#ifdef CONFIG_TRACER_MAX_TRACE
+#ifdef CONFIG_TRACER_SNAPSHOT
 	/*
 	 * The max_buffer is used to snapshot the trace when a maximum
 	 * latency is reached, or when the user initiates a snapshot.
@@ -345,13 +345,16 @@ struct trace_array {
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
@@ -377,7 +380,7 @@ struct trace_array {
 	 *
 	 * It is also used in other places outside the update_max_tr
 	 * so it needs to be defined outside of the
-	 * CONFIG_TRACER_MAX_TRACE.
+	 * CONFIG_TRACER_SNAPSHOT.
 	 */
 	arch_spinlock_t		max_lock;
 #ifdef CONFIG_FTRACE_SYSCALLS
-- 
2.51.0


