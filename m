Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543833B975;
	Fri,  6 Feb 2026 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407938; cv=none; b=SjaMdS7PuDLcDpJnh5pmhWaU0S/msyLFQqjOVrI+AACFhVdCTPc4CVB++ycv8fbXsvOhu/8rLHyFF9MXm0pukeGo4paXY4Y+3dcr+gGUxCUsKlpTTgwd+exVefcKWCmC0ZIw9XUeX8tR4aCJn67sWKxyIbJOUoj+QzkeNxTztpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407938; c=relaxed/simple;
	bh=75BARh5bpqgqR88rVL22CBs1IJMcdong8pMSYlVHGjY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nSgGyYJNSJfFMwpmsFdaco7L2A0fYrgz1Gs332S6qh7Sig/YE92iNxESZUDWWIGv0jYXJABE/j47tm//yyVBJP92E643wp+JAG2z4Hf4sDnm9o3DK36mWJE0m8H65ZgXN79IcB89A/hbx/Con9rljwmFD6GK1wA13QpI6yUgsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ+qcSbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ+qcSbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB7DC19424;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407938;
	bh=75BARh5bpqgqR88rVL22CBs1IJMcdong8pMSYlVHGjY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SQ+qcSbDlO7wZlYErpbBylaYvsOw/2a4hp/Yb6BlJi8rN95XD/lq/ybzAsoh/x2bh
	 cqA7NPCQ7qItEfeazFcsglo5DsKsPwim4nanTWKhl3mRzbwRo7NcdpB6okU5cioRNJ
	 ViFP3EcTyU7hOO+XlfodXYBRTmtuP5qSSLO/1hXQsrtdEqIQzAi+bNDqNgnYXloDDx
	 4lA9LOXXUd6q3fH5S/nsEWGHco/OFhHRFob6lSKDU/NplnlqyqnJTowiZS1VaMTk8q
	 J9Ni9ZHMZSL7rQSNwOsvn6pgGGFPSqpf9RquypYuRY0Nqfp4v9x/ajNghPg28Oz8lr
	 rAHxscwzfbLyA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzM-0000000A6rk-3ytK;
	Fri, 06 Feb 2026 14:59:36 -0500
Message-ID: <20260206195936.803146337@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:53 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/12] tracing: Move snapshot code out of trace.c and into trace_snapshot.c
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace.c file was a dumping ground for most tracing code. Start
organizing it better by moving various functions out into their own files.
Move all the snapshot code, including the max trace code into its own
trace_snapshot.c file.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h        |    2 +-
 kernel/trace/Makefile         |    1 +
 kernel/trace/trace.c          | 1273 ++-------------------------------
 kernel/trace/trace.h          |  107 ++-
 kernel/trace/trace_snapshot.c | 1068 +++++++++++++++++++++++++++
 5 files changed, 1233 insertions(+), 1218 deletions(-)
 create mode 100644 kernel/trace/trace_snapshot.c

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3a8989e3268..9fa999110b5e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -31,7 +31,7 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 0
 #endif
 
-#ifdef CONFIG_TRACING
+#ifdef CONFIG_TRACER_SNAPSHOT
 extern void ftrace_boot_snapshot(void);
 #else
 static inline void ftrace_boot_snapshot(void) { }
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 04096c21d06b..83aeb5c77008 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING) += trace_pid.o
+obj-$(CONFIG_TRACER_SNAPSHOT) += trace_snapshot.o
 obj-$(CONFIG_TRACING) += 	pid_list.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5bc22d966834..534ab502e5d7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -47,7 +47,6 @@
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
-#include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 #include <linux/sort.h>
@@ -219,15 +218,9 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
 static char *default_bootup_tracer;
 
-static bool allocate_snapshot;
-static bool snapshot_at_boot;
-
 static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_instance_index;
 
-static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
-static int boot_snapshot_index;
-
 static int __init set_cmdline_ftrace(char *str)
 {
 	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -276,38 +269,6 @@ static int __init stop_trace_on_warning(char *str)
 }
 __setup("traceoff_on_warning", stop_trace_on_warning);
 
-static int __init boot_alloc_snapshot(char *str)
-{
-	char *slot = boot_snapshot_info + boot_snapshot_index;
-	int left = sizeof(boot_snapshot_info) - boot_snapshot_index;
-	int ret;
-
-	if (str[0] == '=') {
-		str++;
-		if (strlen(str) >= left)
-			return -1;
-
-		ret = snprintf(slot, left, "%s\t", str);
-		boot_snapshot_index += ret;
-	} else {
-		allocate_snapshot = true;
-		/* We also need the main ring buffer expanded */
-		trace_set_ring_buffer_expanded(NULL);
-	}
-	return 1;
-}
-__setup("alloc_snapshot", boot_alloc_snapshot);
-
-
-static int __init boot_snapshot(char *str)
-{
-	snapshot_at_boot = true;
-	boot_alloc_snapshot(str);
-	return 1;
-}
-__setup("ftrace_boot_snapshot", boot_snapshot);
-
-
 static int __init boot_instance(char *str)
 {
 	char *slot = boot_instance_info + boot_instance_index;
@@ -807,48 +768,6 @@ void tracing_on(void)
 EXPORT_SYMBOL_GPL(tracing_on);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-static void tracing_snapshot_instance_cond(struct trace_array *tr,
-					   void *cond_data)
-{
-	struct tracer *tracer = tr->current_trace;
-	unsigned long flags;
-
-	if (in_nmi()) {
-		trace_array_puts(tr, "*** SNAPSHOT CALLED FROM NMI CONTEXT ***\n");
-		trace_array_puts(tr, "*** snapshot is being ignored        ***\n");
-		return;
-	}
-
-	if (!tr->allocated_snapshot) {
-		trace_array_puts(tr, "*** SNAPSHOT NOT ALLOCATED ***\n");
-		trace_array_puts(tr, "*** stopping trace here!   ***\n");
-		tracer_tracing_off(tr);
-		return;
-	}
-
-	/* Note, snapshot can not be used when the tracer uses it */
-	if (tracer->use_max_tr) {
-		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
-		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
-		return;
-	}
-
-	if (tr->mapped) {
-		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
-		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
-		return;
-	}
-
-	local_irq_save(flags);
-	update_max_tr(tr, current, smp_processor_id(), cond_data);
-	local_irq_restore(flags);
-}
-
-void tracing_snapshot_instance(struct trace_array *tr)
-{
-	tracing_snapshot_instance_cond(tr, NULL);
-}
-
 /**
  * tracing_snapshot - take a snapshot of the current buffer.
  *
@@ -871,138 +790,6 @@ void tracing_snapshot(void)
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
 
-/**
- * tracing_snapshot_cond - conditionally take a snapshot of the current buffer.
- * @tr:		The tracing instance to snapshot
- * @cond_data:	The data to be tested conditionally, and possibly saved
- *
- * This is the same as tracing_snapshot() except that the snapshot is
- * conditional - the snapshot will only happen if the
- * cond_snapshot.update() implementation receiving the cond_data
- * returns true, which means that the trace array's cond_snapshot
- * update() operation used the cond_data to determine whether the
- * snapshot should be taken, and if it was, presumably saved it along
- * with the snapshot.
- */
-void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
-{
-	tracing_snapshot_instance_cond(tr, cond_data);
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
-
-/**
- * tracing_cond_snapshot_data - get the user data associated with a snapshot
- * @tr:		The tracing instance
- *
- * When the user enables a conditional snapshot using
- * tracing_snapshot_cond_enable(), the user-defined cond_data is saved
- * with the snapshot.  This accessor is used to retrieve it.
- *
- * Should not be called from cond_snapshot.update(), since it takes
- * the tr->max_lock lock, which the code calling
- * cond_snapshot.update() has already done.
- *
- * Returns the cond_data associated with the trace array's snapshot.
- */
-void *tracing_cond_snapshot_data(struct trace_array *tr)
-{
-	void *cond_data = NULL;
-
-	local_irq_disable();
-	arch_spin_lock(&tr->max_lock);
-
-	if (tr->cond_snapshot)
-		cond_data = tr->cond_snapshot->cond_data;
-
-	arch_spin_unlock(&tr->max_lock);
-	local_irq_enable();
-
-	return cond_data;
-}
-EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
-
-static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
-					struct array_buffer *size_buf, int cpu_id);
-static void set_buffer_entries(struct array_buffer *buf, unsigned long val);
-
-int tracing_alloc_snapshot_instance(struct trace_array *tr)
-{
-	int order;
-	int ret;
-
-	if (!tr->allocated_snapshot) {
-
-		/* Make the snapshot buffer have the same order as main buffer */
-		order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
-		ret = ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, order);
-		if (ret < 0)
-			return ret;
-
-		/* allocate spare buffer */
-		ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
-				   &tr->array_buffer, RING_BUFFER_ALL_CPUS);
-		if (ret < 0)
-			return ret;
-
-		tr->allocated_snapshot = true;
-	}
-
-	return 0;
-}
-
-static void free_snapshot(struct trace_array *tr)
-{
-	/*
-	 * We don't free the ring buffer. instead, resize it because
-	 * The max_tr ring buffer has some state (e.g. ring->clock) and
-	 * we want preserve it.
-	 */
-	ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, 0);
-	ring_buffer_resize(tr->snapshot_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
-	set_buffer_entries(&tr->snapshot_buffer, 1);
-	tracing_reset_online_cpus(&tr->snapshot_buffer);
-	tr->allocated_snapshot = false;
-}
-
-static int tracing_arm_snapshot_locked(struct trace_array *tr)
-{
-	int ret;
-
-	lockdep_assert_held(&trace_types_lock);
-
-	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX || tr->mapped) {
-		spin_unlock(&tr->snapshot_trigger_lock);
-		return -EBUSY;
-	}
-
-	tr->snapshot++;
-	spin_unlock(&tr->snapshot_trigger_lock);
-
-	ret = tracing_alloc_snapshot_instance(tr);
-	if (ret) {
-		spin_lock(&tr->snapshot_trigger_lock);
-		tr->snapshot--;
-		spin_unlock(&tr->snapshot_trigger_lock);
-	}
-
-	return ret;
-}
-
-int tracing_arm_snapshot(struct trace_array *tr)
-{
-	guard(mutex)(&trace_types_lock);
-	return tracing_arm_snapshot_locked(tr);
-}
-
-void tracing_disarm_snapshot(struct trace_array *tr)
-{
-	spin_lock(&tr->snapshot_trigger_lock);
-	if (!WARN_ON(!tr->snapshot))
-		tr->snapshot--;
-	spin_unlock(&tr->snapshot_trigger_lock);
-}
-
 /**
  * tracing_alloc_snapshot - allocate snapshot buffer.
  *
@@ -1024,129 +811,12 @@ int tracing_alloc_snapshot(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
-
-/**
- * tracing_snapshot_alloc - allocate and take a snapshot of the current buffer.
- *
- * This is similar to tracing_snapshot(), but it will allocate the
- * snapshot buffer if it isn't already allocated. Use this only
- * where it is safe to sleep, as the allocation may sleep.
- *
- * This causes a swap between the snapshot buffer and the current live
- * tracing buffer. You can use this to take snapshots of the live
- * trace when some condition is triggered, but continue to trace.
- */
-void tracing_snapshot_alloc(void)
-{
-	int ret;
-
-	ret = tracing_alloc_snapshot();
-	if (ret < 0)
-		return;
-
-	tracing_snapshot();
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
-
-/**
- * tracing_snapshot_cond_enable - enable conditional snapshot for an instance
- * @tr:		The tracing instance
- * @cond_data:	User data to associate with the snapshot
- * @update:	Implementation of the cond_snapshot update function
- *
- * Check whether the conditional snapshot for the given instance has
- * already been enabled, or if the current tracer is already using a
- * snapshot; if so, return -EBUSY, else create a cond_snapshot and
- * save the cond_data and update function inside.
- *
- * Returns 0 if successful, error otherwise.
- */
-int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
-				 cond_update_fn_t update)
-{
-	struct cond_snapshot *cond_snapshot __free(kfree) =
-		kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
-	int ret;
-
-	if (!cond_snapshot)
-		return -ENOMEM;
-
-	cond_snapshot->cond_data = cond_data;
-	cond_snapshot->update = update;
-
-	guard(mutex)(&trace_types_lock);
-
-	if (tr->current_trace->use_max_tr)
-		return -EBUSY;
-
-	/*
-	 * The cond_snapshot can only change to NULL without the
-	 * trace_types_lock. We don't care if we race with it going
-	 * to NULL, but we want to make sure that it's not set to
-	 * something other than NULL when we get here, which we can
-	 * do safely with only holding the trace_types_lock and not
-	 * having to take the max_lock.
-	 */
-	if (tr->cond_snapshot)
-		return -EBUSY;
-
-	ret = tracing_arm_snapshot_locked(tr);
-	if (ret)
-		return ret;
-
-	local_irq_disable();
-	arch_spin_lock(&tr->max_lock);
-	tr->cond_snapshot = no_free_ptr(cond_snapshot);
-	arch_spin_unlock(&tr->max_lock);
-	local_irq_enable();
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
-
-/**
- * tracing_snapshot_cond_disable - disable conditional snapshot for an instance
- * @tr:		The tracing instance
- *
- * Check whether the conditional snapshot for the given instance is
- * enabled; if so, free the cond_snapshot associated with it,
- * otherwise return -EINVAL.
- *
- * Returns 0 if successful, error otherwise.
- */
-int tracing_snapshot_cond_disable(struct trace_array *tr)
-{
-	int ret = 0;
-
-	local_irq_disable();
-	arch_spin_lock(&tr->max_lock);
-
-	if (!tr->cond_snapshot)
-		ret = -EINVAL;
-	else {
-		kfree(tr->cond_snapshot);
-		tr->cond_snapshot = NULL;
-	}
-
-	arch_spin_unlock(&tr->max_lock);
-	local_irq_enable();
-
-	tracing_disarm_snapshot(tr);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
 #else
 void tracing_snapshot(void)
 {
 	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
-void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
-{
-	WARN_ONCE(1, "Snapshot feature not enabled, but internal conditional snapshot used");
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
 int tracing_alloc_snapshot(void)
 {
 	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
@@ -1159,23 +829,6 @@ void tracing_snapshot_alloc(void)
 	tracing_snapshot();
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
-void *tracing_cond_snapshot_data(struct trace_array *tr)
-{
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
-int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update)
-{
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
-int tracing_snapshot_cond_disable(struct trace_array *tr)
-{
-	return false;
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
-#define free_snapshot(tr)	do { } while (0)
-#define tracing_arm_snapshot_locked(tr) ({ -EBUSY; })
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
 void tracer_tracing_off(struct trace_array *tr)
@@ -1488,205 +1141,6 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 
 unsigned long __read_mostly	tracing_thresh;
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops;
-
-#ifdef LATENCY_FS_NOTIFY
-
-static struct workqueue_struct *fsnotify_wq;
-
-static void latency_fsnotify_workfn(struct work_struct *work)
-{
-	struct trace_array *tr = container_of(work, struct trace_array,
-					      fsnotify_work);
-	fsnotify_inode(tr->d_max_latency->d_inode, FS_MODIFY);
-}
-
-static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
-{
-	struct trace_array *tr = container_of(iwork, struct trace_array,
-					      fsnotify_irqwork);
-	queue_work(fsnotify_wq, &tr->fsnotify_work);
-}
-
-static void trace_create_maxlat_file(struct trace_array *tr,
-				     struct dentry *d_tracer)
-{
-	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
-	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
-	tr->d_max_latency = trace_create_file("tracing_max_latency",
-					      TRACE_MODE_WRITE,
-					      d_tracer, tr,
-					      &tracing_max_lat_fops);
-}
-
-__init static int latency_fsnotify_init(void)
-{
-	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
-				      WQ_UNBOUND | WQ_HIGHPRI, 0);
-	if (!fsnotify_wq) {
-		pr_err("Unable to allocate tr_max_lat_wq\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-late_initcall_sync(latency_fsnotify_init);
-
-void latency_fsnotify(struct trace_array *tr)
-{
-	if (!fsnotify_wq)
-		return;
-	/*
-	 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
-	 * possible that we are called from __schedule() or do_idle(), which
-	 * could cause a deadlock.
-	 */
-	irq_work_queue(&tr->fsnotify_irqwork);
-}
-
-#else /* !LATENCY_FS_NOTIFY */
-
-static inline void trace_create_maxlat_file(struct trace_array *tr,
-					    struct dentry *d_tracer) { }
-#endif
-
-/*
- * Copy the new maximum trace into the separate maximum-trace
- * structure. (this way the maximum trace is permanently saved,
- * for later retrieval via /sys/kernel/tracing/tracing_max_latency)
- */
-static void
-__update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
-{
-	struct array_buffer *trace_buf = &tr->array_buffer;
-	struct array_buffer *max_buf = &tr->snapshot_buffer;
-	struct trace_array_cpu *data = per_cpu_ptr(trace_buf->data, cpu);
-	struct trace_array_cpu *max_data = per_cpu_ptr(max_buf->data, cpu);
-
-	max_buf->cpu = cpu;
-	max_buf->time_start = data->preempt_timestamp;
-
-	max_data->saved_latency = tr->max_latency;
-	max_data->critical_start = data->critical_start;
-	max_data->critical_end = data->critical_end;
-
-	strscpy(max_data->comm, tsk->comm);
-	max_data->pid = tsk->pid;
-	/*
-	 * If tsk == current, then use current_uid(), as that does not use
-	 * RCU. The irq tracer can be called out of RCU scope.
-	 */
-	if (tsk == current)
-		max_data->uid = current_uid();
-	else
-		max_data->uid = task_uid(tsk);
-
-	max_data->nice = tsk->static_prio - 20 - MAX_RT_PRIO;
-	max_data->policy = tsk->policy;
-	max_data->rt_priority = tsk->rt_priority;
-
-	/* record this tasks comm */
-	tracing_record_cmdline(tsk);
-	latency_fsnotify(tr);
-}
-
-/**
- * update_max_tr - snapshot all trace buffers from global_trace to max_tr
- * @tr: tracer
- * @tsk: the task with the latency
- * @cpu: The cpu that initiated the trace.
- * @cond_data: User data associated with a conditional snapshot
- *
- * Flip the buffers between the @tr and the max_tr and record information
- * about which task was the cause of this latency.
- */
-void
-update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
-	      void *cond_data)
-{
-	if (tr->stop_count)
-		return;
-
-	WARN_ON_ONCE(!irqs_disabled());
-
-	if (!tr->allocated_snapshot) {
-		/* Only the nop tracer should hit this when disabling */
-		WARN_ON_ONCE(tr->current_trace != &nop_trace);
-		return;
-	}
-
-	arch_spin_lock(&tr->max_lock);
-
-	/* Inherit the recordable setting from array_buffer */
-	if (ring_buffer_record_is_set_on(tr->array_buffer.buffer))
-		ring_buffer_record_on(tr->snapshot_buffer.buffer);
-	else
-		ring_buffer_record_off(tr->snapshot_buffer.buffer);
-
-#ifdef CONFIG_TRACER_SNAPSHOT
-	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data)) {
-		arch_spin_unlock(&tr->max_lock);
-		return;
-	}
-#endif
-	swap(tr->array_buffer.buffer, tr->snapshot_buffer.buffer);
-
-	__update_max_tr(tr, tsk, cpu);
-
-	arch_spin_unlock(&tr->max_lock);
-
-	/* Any waiters on the old snapshot buffer need to wake up */
-	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
-}
-
-/**
- * update_max_tr_single - only copy one trace over, and reset the rest
- * @tr: tracer
- * @tsk: task with the latency
- * @cpu: the cpu of the buffer to copy.
- *
- * Flip the trace of a single CPU buffer between the @tr and the max_tr.
- */
-void
-update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
-{
-	int ret;
-
-	if (tr->stop_count)
-		return;
-
-	WARN_ON_ONCE(!irqs_disabled());
-	if (!tr->allocated_snapshot) {
-		/* Only the nop tracer should hit this when disabling */
-		WARN_ON_ONCE(tr->current_trace != &nop_trace);
-		return;
-	}
-
-	arch_spin_lock(&tr->max_lock);
-
-	ret = ring_buffer_swap_cpu(tr->snapshot_buffer.buffer, tr->array_buffer.buffer, cpu);
-
-	if (ret == -EBUSY) {
-		/*
-		 * We failed to swap the buffer due to a commit taking
-		 * place on this CPU. We fail to record, but we reset
-		 * the max trace buffer (no one writes directly to it)
-		 * and flag that it failed.
-		 * Another reason is resize is in progress.
-		 */
-		trace_array_printk_buf(tr->snapshot_buffer.buffer, _THIS_IP_,
-			"Failed to swap buffers due to commit or resize in progress\n");
-	}
-
-	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
-
-	__update_max_tr(tr, tsk, cpu);
-	arch_spin_unlock(&tr->max_lock);
-}
-
-#endif /* CONFIG_TRACER_MAX_TRACE */
-
 struct pipe_wait {
 	struct trace_iterator		*iter;
 	int				wait_index;
@@ -1995,7 +1449,7 @@ int __init register_tracer(struct tracer *type)
 	return 0;
 }
 
-static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
+void tracing_reset_cpu(struct array_buffer *buf, int cpu)
 {
 	struct trace_buffer *buffer = buf->buffer;
 
@@ -3764,50 +3218,6 @@ static void test_ftrace_alive(struct seq_file *m)
 		    "#          MAY BE MISSING FUNCTION EVENTS\n");
 }
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-static void show_snapshot_main_help(struct seq_file *m)
-{
-	seq_puts(m, "# echo 0 > snapshot : Clears and frees snapshot buffer\n"
-		    "# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.\n"
-		    "#                      Takes a snapshot of the main buffer.\n"
-		    "# echo 2 > snapshot : Clears snapshot buffer (but does not allocate or free)\n"
-		    "#                      (Doesn't have to be '2' works with any number that\n"
-		    "#                       is not a '0' or '1')\n");
-}
-
-static void show_snapshot_percpu_help(struct seq_file *m)
-{
-	seq_puts(m, "# echo 0 > snapshot : Invalid for per_cpu snapshot file.\n");
-#ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
-	seq_puts(m, "# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.\n"
-		    "#                      Takes a snapshot of the main buffer for this cpu.\n");
-#else
-	seq_puts(m, "# echo 1 > snapshot : Not supported with this kernel.\n"
-		    "#                     Must use main snapshot file to allocate.\n");
-#endif
-	seq_puts(m, "# echo 2 > snapshot : Clears this cpu's snapshot buffer (but does not allocate)\n"
-		    "#                      (Doesn't have to be '2' works with any number that\n"
-		    "#                       is not a '0' or '1')\n");
-}
-
-static void print_snapshot_help(struct seq_file *m, struct trace_iterator *iter)
-{
-	if (iter->tr->allocated_snapshot)
-		seq_puts(m, "#\n# * Snapshot is allocated *\n#\n");
-	else
-		seq_puts(m, "#\n# * Snapshot is freed *\n#\n");
-
-	seq_puts(m, "# Snapshot commands:\n");
-	if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
-		show_snapshot_main_help(m);
-	else
-		show_snapshot_percpu_help(m);
-}
-#else
-/* Should never be called */
-static inline void print_snapshot_help(struct seq_file *m, struct trace_iterator *iter) { }
-#endif
-
 static int s_show(struct seq_file *m, void *v)
 {
 	struct trace_iterator *iter = v;
@@ -3856,17 +3266,6 @@ static int s_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * Should be used after trace_array_get(), trace_types_lock
- * ensures that i_cdev was already initialized.
- */
-static inline int tracing_get_cpu(struct inode *inode)
-{
-	if (inode->i_cdev) /* See trace_create_cpu_file() */
-		return (long)inode->i_cdev - 1;
-	return RING_BUFFER_ALL_CPUS;
-}
-
 static const struct seq_operations tracer_seq_ops = {
 	.start		= s_start,
 	.next		= s_next,
@@ -3893,7 +3292,7 @@ static void free_trace_iter_content(struct trace_iterator *iter)
 	free_cpumask_var(iter->started);
 }
 
-static struct trace_iterator *
+struct trace_iterator *
 __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4076,7 +3475,7 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
 	return single_release(inode, filp);
 }
 
-static int tracing_release(struct inode *inode, struct file *file)
+int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 	struct seq_file *m = file->private_data;
@@ -5224,7 +4623,7 @@ int tracer_init(struct tracer *t, struct trace_array *tr)
 	return t->init(tr);
 }
 
-static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
+void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val)
 {
 	int cpu;
 
@@ -5235,40 +4634,12 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
 static void update_buffer_entries(struct array_buffer *buf, int cpu)
 {
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+		trace_set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
 	} else {
 		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
 	}
 }
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-/* resize @tr's buffer to the size of @size_tr's entries */
-static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
-					struct array_buffer *size_buf, int cpu_id)
-{
-	int cpu, ret = 0;
-
-	if (cpu_id == RING_BUFFER_ALL_CPUS) {
-		for_each_tracing_cpu(cpu) {
-			ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu)->entries, cpu);
-			if (ret < 0)
-				break;
-			per_cpu_ptr(trace_buf->data, cpu)->entries =
-				per_cpu_ptr(size_buf->data, cpu)->entries;
-		}
-	} else {
-		ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu_id)->entries, cpu_id);
-		if (ret == 0)
-			per_cpu_ptr(trace_buf->data, cpu_id)->entries =
-				per_cpu_ptr(size_buf->data, cpu_id)->entries;
-	}
-
-	return ret;
-}
-#endif /* CONFIG_TRACER_SNAPSHOT */
-
 static int __tracing_resize_ring_buffer(struct trace_array *tr,
 					unsigned long size, int cpu)
 {
@@ -5695,9 +5066,8 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
-static ssize_t
-tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
-		   size_t cnt, loff_t *ppos)
+ssize_t tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
+			   size_t cnt, loff_t *ppos)
 {
 	char buf[64];
 	int r;
@@ -5709,9 +5079,8 @@ tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static ssize_t
-tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
-		    size_t cnt, loff_t *ppos)
+ssize_t tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
+			    size_t cnt, loff_t *ppos)
 {
 	unsigned long val;
 	int ret;
@@ -5753,28 +5122,6 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 	return cnt;
 }
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-
-static ssize_t
-tracing_max_lat_read(struct file *filp, char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
-{
-	struct trace_array *tr = filp->private_data;
-
-	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
-}
-
-static ssize_t
-tracing_max_lat_write(struct file *filp, const char __user *ubuf,
-		      size_t cnt, loff_t *ppos)
-{
-	struct trace_array *tr = filp->private_data;
-
-	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
-}
-
-#endif
-
 static int open_pipe_on_cpu(struct trace_array *tr, int cpu)
 {
 	if (cpu == RING_BUFFER_ALL_CPUS) {
@@ -7061,266 +6408,78 @@ static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
 	const char *clockstr;
 	int ret;
 
-	if (cnt >= sizeof(buf))
-		return -EINVAL;
-
-	if (copy_from_user(buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-
-	clockstr = strstrip(buf);
-
-	ret = tracing_set_clock(tr, clockstr);
-	if (ret)
-		return ret;
-
-	*fpos += cnt;
-
-	return cnt;
-}
-
-static int tracing_clock_open(struct inode *inode, struct file *file)
-{
-	struct trace_array *tr = inode->i_private;
-	int ret;
-
-	ret = tracing_check_open_get_tr(tr);
-	if (ret)
-		return ret;
-
-	ret = single_open(file, tracing_clock_show, inode->i_private);
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
-}
-
-static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
-{
-	struct trace_array *tr = m->private;
-
-	guard(mutex)(&trace_types_lock);
-
-	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
-		seq_puts(m, "delta [absolute]\n");
-	else
-		seq_puts(m, "[delta] absolute\n");
-
-	return 0;
-}
-
-static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
-{
-	struct trace_array *tr = inode->i_private;
-	int ret;
-
-	ret = tracing_check_open_get_tr(tr);
-	if (ret)
-		return ret;
-
-	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
-}
-
-u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
-{
-	if (rbe == this_cpu_read(trace_buffered_event))
-		return ring_buffer_time_stamp(buffer);
-
-	return ring_buffer_event_time_stamp(buffer, rbe);
-}
-
-struct ftrace_buffer_info {
-	struct trace_iterator	iter;
-	void			*spare;
-	unsigned int		spare_cpu;
-	unsigned int		spare_size;
-	unsigned int		read;
-};
-
-#ifdef CONFIG_TRACER_SNAPSHOT
-static int tracing_snapshot_open(struct inode *inode, struct file *file)
-{
-	struct trace_array *tr = inode->i_private;
-	struct trace_iterator *iter;
-	struct seq_file *m;
-	int ret;
-
-	ret = tracing_check_open_get_tr(tr);
-	if (ret)
-		return ret;
-
-	if (file->f_mode & FMODE_READ) {
-		iter = __tracing_open(inode, file, true);
-		if (IS_ERR(iter))
-			ret = PTR_ERR(iter);
-	} else {
-		/* Writes still need the seq_file to hold the private data */
-		ret = -ENOMEM;
-		m = kzalloc(sizeof(*m), GFP_KERNEL);
-		if (!m)
-			goto out;
-		iter = kzalloc(sizeof(*iter), GFP_KERNEL);
-		if (!iter) {
-			kfree(m);
-			goto out;
-		}
-		ret = 0;
-
-		iter->tr = tr;
-		iter->array_buffer = &tr->snapshot_buffer;
-		iter->cpu_file = tracing_get_cpu(inode);
-		m->private = iter;
-		file->private_data = m;
-	}
-out:
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
-}
-
-static void tracing_swap_cpu_buffer(void *tr)
-{
-	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
-}
-
-static ssize_t
-tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
-		       loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct trace_iterator *iter = m->private;
-	struct trace_array *tr = iter->tr;
-	unsigned long val;
-	int ret;
-
-	ret = tracing_update_buffers(tr);
-	if (ret < 0)
-		return ret;
+	if (cnt >= sizeof(buf))
+		return -EINVAL;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
-	if (ret)
-		return ret;
+	if (copy_from_user(buf, ubuf, cnt))
+		return -EFAULT;
 
-	guard(mutex)(&trace_types_lock);
+	buf[cnt] = 0;
 
-	if (tr->current_trace->use_max_tr)
-		return -EBUSY;
+	clockstr = strstrip(buf);
 
-	local_irq_disable();
-	arch_spin_lock(&tr->max_lock);
-	if (tr->cond_snapshot)
-		ret = -EBUSY;
-	arch_spin_unlock(&tr->max_lock);
-	local_irq_enable();
+	ret = tracing_set_clock(tr, clockstr);
 	if (ret)
 		return ret;
 
-	switch (val) {
-	case 0:
-		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
-			return -EINVAL;
-		if (tr->allocated_snapshot)
-			free_snapshot(tr);
-		break;
-	case 1:
-/* Only allow per-cpu swap if the ring buffer supports it */
-#ifndef CONFIG_RING_BUFFER_ALLOW_SWAP
-		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
-			return -EINVAL;
-#endif
-		if (tr->allocated_snapshot)
-			ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
-					&tr->array_buffer, iter->cpu_file);
+	*fpos += cnt;
 
-		ret = tracing_arm_snapshot_locked(tr);
-		if (ret)
-			return ret;
+	return cnt;
+}
 
-		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
-			local_irq_disable();
-			update_max_tr(tr, current, smp_processor_id(), NULL);
-			local_irq_enable();
-		} else {
-			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
-						 (void *)tr, 1);
-		}
-		tracing_disarm_snapshot(tr);
-		break;
-	default:
-		if (tr->allocated_snapshot) {
-			if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
-				tracing_reset_online_cpus(&tr->snapshot_buffer);
-			else
-				tracing_reset_cpu(&tr->snapshot_buffer, iter->cpu_file);
-		}
-		break;
-	}
+static int tracing_clock_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+	int ret;
 
-	if (ret >= 0) {
-		*ppos += cnt;
-		ret = cnt;
-	}
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = single_open(file, tracing_clock_show, inode->i_private);
+	if (ret < 0)
+		trace_array_put(tr);
 
 	return ret;
 }
 
-static int tracing_snapshot_release(struct inode *inode, struct file *file)
+static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
 {
-	struct seq_file *m = file->private_data;
-	int ret;
-
-	ret = tracing_release(inode, file);
+	struct trace_array *tr = m->private;
 
-	if (file->f_mode & FMODE_READ)
-		return ret;
+	guard(mutex)(&trace_types_lock);
 
-	/* If write only, the seq_file is just a stub */
-	if (m)
-		kfree(m->private);
-	kfree(m);
+	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
+		seq_puts(m, "delta [absolute]\n");
+	else
+		seq_puts(m, "[delta] absolute\n");
 
 	return 0;
 }
 
-static int tracing_buffers_open(struct inode *inode, struct file *filp);
-static ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
-				    size_t count, loff_t *ppos);
-static int tracing_buffers_release(struct inode *inode, struct file *file);
-static ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
-		   struct pipe_inode_info *pipe, size_t len, unsigned int flags);
-
-static int snapshot_raw_open(struct inode *inode, struct file *filp)
+static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_buffer_info *info;
+	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	/* The following checks for tracefs lockdown */
-	ret = tracing_buffers_open(inode, filp);
-	if (ret < 0)
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
 		return ret;
 
-	info = filp->private_data;
-
-	if (info->iter.trace->use_max_tr) {
-		tracing_buffers_release(inode, filp);
-		return -EBUSY;
-	}
-
-	info->iter.snapshot = true;
-	info->iter.array_buffer = &info->iter.tr->snapshot_buffer;
+	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
+	if (ret < 0)
+		trace_array_put(tr);
 
 	return ret;
 }
 
-#endif /* CONFIG_TRACER_SNAPSHOT */
+u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
+{
+	if (rbe == this_cpu_read(trace_buffered_event))
+		return ring_buffer_time_stamp(buffer);
 
+	return ring_buffer_event_time_stamp(buffer, rbe);
+}
 
 static const struct file_operations tracing_thresh_fops = {
 	.open		= tracing_open_generic,
@@ -7329,16 +6488,6 @@ static const struct file_operations tracing_thresh_fops = {
 	.llseek		= generic_file_llseek,
 };
 
-#ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops = {
-	.open		= tracing_open_generic_tr,
-	.read		= tracing_max_lat_read,
-	.write		= tracing_max_lat_write,
-	.llseek		= generic_file_llseek,
-	.release	= tracing_release_generic_tr,
-};
-#endif
-
 static const struct file_operations set_tracer_fops = {
 	.open		= tracing_open_generic_tr,
 	.read		= tracing_set_trace_read,
@@ -7425,24 +6574,6 @@ static const struct file_operations last_boot_fops = {
 	.release	= tracing_seq_release,
 };
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-static const struct file_operations snapshot_fops = {
-	.open		= tracing_snapshot_open,
-	.read		= seq_read,
-	.write		= tracing_snapshot_write,
-	.llseek		= tracing_lseek,
-	.release	= tracing_snapshot_release,
-};
-
-static const struct file_operations snapshot_raw_fops = {
-	.open		= snapshot_raw_open,
-	.read		= tracing_buffers_read,
-	.release	= tracing_buffers_release,
-	.splice_read	= tracing_buffers_splice_read,
-};
-
-#endif /* CONFIG_TRACER_SNAPSHOT */
-
 /*
  * trace_min_max_write - Write a u64 value to a trace_min_max_param struct
  * @filp: The active open file structure
@@ -7802,7 +6933,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.release        = tracing_err_log_release,
 };
 
-static int tracing_buffers_open(struct inode *inode, struct file *filp)
+int tracing_buffers_open(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct ftrace_buffer_info *info;
@@ -7850,9 +6981,8 @@ tracing_buffers_poll(struct file *filp, poll_table *poll_table)
 	return trace_poll(iter, filp, poll_table);
 }
 
-static ssize_t
-tracing_buffers_read(struct file *filp, char __user *ubuf,
-		     size_t count, loff_t *ppos)
+ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
+			     size_t count, loff_t *ppos)
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
@@ -7955,7 +7085,7 @@ static int tracing_buffers_flush(struct file *file, fl_owner_t id)
 	return 0;
 }
 
-static int tracing_buffers_release(struct inode *inode, struct file *file)
+int tracing_buffers_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
@@ -8029,10 +7159,9 @@ static void buffer_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	spd->partial[i].private = 0;
 }
 
-static ssize_t
-tracing_buffers_splice_read(struct file *file, loff_t *ppos,
-			    struct pipe_inode_info *pipe, size_t len,
-			    unsigned int flags)
+ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
+				    struct pipe_inode_info *pipe, size_t len,
+				    unsigned int flags)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
@@ -8188,44 +7317,6 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-static int get_snapshot_map(struct trace_array *tr)
-{
-	int err = 0;
-
-	/*
-	 * Called with mmap_lock held. lockdep would be unhappy if we would now
-	 * take trace_types_lock. Instead use the specific
-	 * snapshot_trigger_lock.
-	 */
-	spin_lock(&tr->snapshot_trigger_lock);
-
-	if (tr->snapshot || tr->mapped == UINT_MAX)
-		err = -EBUSY;
-	else
-		tr->mapped++;
-
-	spin_unlock(&tr->snapshot_trigger_lock);
-
-	/* Wait for update_max_tr() to observe iter->tr->mapped */
-	if (tr->mapped == 1)
-		synchronize_rcu();
-
-	return err;
-
-}
-static void put_snapshot_map(struct trace_array *tr)
-{
-	spin_lock(&tr->snapshot_trigger_lock);
-	if (!WARN_ON(!tr->mapped))
-		tr->mapped--;
-	spin_unlock(&tr->snapshot_trigger_lock);
-}
-#else
-static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
-static inline void put_snapshot_map(struct trace_array *tr) { }
-#endif
-
 static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 {
 	struct ftrace_buffer_info *info = vma->vm_file->private_data;
@@ -8393,170 +7484,6 @@ static const struct file_operations tracing_dyn_info_fops = {
 };
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-#if defined(CONFIG_TRACER_SNAPSHOT) && defined(CONFIG_DYNAMIC_FTRACE)
-static void
-ftrace_snapshot(unsigned long ip, unsigned long parent_ip,
-		struct trace_array *tr, struct ftrace_probe_ops *ops,
-		void *data)
-{
-	tracing_snapshot_instance(tr);
-}
-
-static void
-ftrace_count_snapshot(unsigned long ip, unsigned long parent_ip,
-		      struct trace_array *tr, struct ftrace_probe_ops *ops,
-		      void *data)
-{
-	struct ftrace_func_mapper *mapper = data;
-	long *count = NULL;
-
-	if (mapper)
-		count = (long *)ftrace_func_mapper_find_ip(mapper, ip);
-
-	if (count) {
-
-		if (*count <= 0)
-			return;
-
-		(*count)--;
-	}
-
-	tracing_snapshot_instance(tr);
-}
-
-static int
-ftrace_snapshot_print(struct seq_file *m, unsigned long ip,
-		      struct ftrace_probe_ops *ops, void *data)
-{
-	struct ftrace_func_mapper *mapper = data;
-	long *count = NULL;
-
-	seq_printf(m, "%ps:", (void *)ip);
-
-	seq_puts(m, "snapshot");
-
-	if (mapper)
-		count = (long *)ftrace_func_mapper_find_ip(mapper, ip);
-
-	if (count)
-		seq_printf(m, ":count=%ld\n", *count);
-	else
-		seq_puts(m, ":unlimited\n");
-
-	return 0;
-}
-
-static int
-ftrace_snapshot_init(struct ftrace_probe_ops *ops, struct trace_array *tr,
-		     unsigned long ip, void *init_data, void **data)
-{
-	struct ftrace_func_mapper *mapper = *data;
-
-	if (!mapper) {
-		mapper = allocate_ftrace_func_mapper();
-		if (!mapper)
-			return -ENOMEM;
-		*data = mapper;
-	}
-
-	return ftrace_func_mapper_add_ip(mapper, ip, init_data);
-}
-
-static void
-ftrace_snapshot_free(struct ftrace_probe_ops *ops, struct trace_array *tr,
-		     unsigned long ip, void *data)
-{
-	struct ftrace_func_mapper *mapper = data;
-
-	if (!ip) {
-		if (!mapper)
-			return;
-		free_ftrace_func_mapper(mapper, NULL);
-		return;
-	}
-
-	ftrace_func_mapper_remove_ip(mapper, ip);
-}
-
-static struct ftrace_probe_ops snapshot_probe_ops = {
-	.func			= ftrace_snapshot,
-	.print			= ftrace_snapshot_print,
-};
-
-static struct ftrace_probe_ops snapshot_count_probe_ops = {
-	.func			= ftrace_count_snapshot,
-	.print			= ftrace_snapshot_print,
-	.init			= ftrace_snapshot_init,
-	.free			= ftrace_snapshot_free,
-};
-
-static int
-ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
-			       char *glob, char *cmd, char *param, int enable)
-{
-	struct ftrace_probe_ops *ops;
-	void *count = (void *)-1;
-	char *number;
-	int ret;
-
-	if (!tr)
-		return -ENODEV;
-
-	/* hash funcs only work with set_ftrace_filter */
-	if (!enable)
-		return -EINVAL;
-
-	ops = param ? &snapshot_count_probe_ops :  &snapshot_probe_ops;
-
-	if (glob[0] == '!') {
-		ret = unregister_ftrace_function_probe_func(glob+1, tr, ops);
-		if (!ret)
-			tracing_disarm_snapshot(tr);
-
-		return ret;
-	}
-
-	if (!param)
-		goto out_reg;
-
-	number = strsep(&param, ":");
-
-	if (!strlen(number))
-		goto out_reg;
-
-	/*
-	 * We use the callback data field (which is a pointer)
-	 * as our counter.
-	 */
-	ret = kstrtoul(number, 0, (unsigned long *)&count);
-	if (ret)
-		return ret;
-
- out_reg:
-	ret = tracing_arm_snapshot(tr);
-	if (ret < 0)
-		return ret;
-
-	ret = register_ftrace_function_probe(glob, tr, ops, count);
-	if (ret < 0)
-		tracing_disarm_snapshot(tr);
-
-	return ret < 0 ? ret : 0;
-}
-
-static struct ftrace_func_command ftrace_snapshot_cmd = {
-	.name			= "snapshot",
-	.func			= ftrace_trace_snapshot_callback,
-};
-
-static __init int register_snapshot_cmd(void)
-{
-	return register_ftrace_command(&ftrace_snapshot_cmd);
-}
-#else
-static inline __init int register_snapshot_cmd(void) { return 0; }
-#endif /* defined(CONFIG_TRACER_SNAPSHOT) && defined(CONFIG_DYNAMIC_FTRACE) */
-
 static struct dentry *tracing_get_dentry(struct trace_array *tr)
 {
 	/* Top directory uses NULL as the parent */
@@ -9349,7 +8276,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 	memset(tscratch, 0, size);
 }
 
-static int
+int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
 	enum ring_buffer_flags rb_flags;
@@ -9389,8 +8316,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	}
 
 	/* Allocate the first page for all buffers */
-	set_buffer_entries(&tr->array_buffer,
-			   ring_buffer_size(tr->array_buffer.buffer, 0));
+	trace_set_buffer_entries(&tr->array_buffer,
+				 ring_buffer_size(tr->array_buffer.buffer, 0));
 
 	return 0;
 }
@@ -9413,23 +8340,11 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-	/* Fix mapped buffer trace arrays do not have snapshot buffers */
-	if (tr->range_addr_start)
-		return 0;
-
-	ret = allocate_trace_buffer(tr, &tr->snapshot_buffer,
-				    allocate_snapshot ? size : 1);
-	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
+	ret = trace_allocate_snapshot(tr, size);
+	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n"))
 		free_trace_buffer(&tr->array_buffer);
-		return -ENOMEM;
-	}
-	tr->allocated_snapshot = allocate_snapshot;
-
-	allocate_snapshot = false;
-#endif
 
-	return 0;
+	return ret;
 }
 
 static void free_trace_buffers(struct trace_array *tr)
@@ -10536,47 +9451,6 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 	return done;
 }
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-__init static bool tr_needs_alloc_snapshot(const char *name)
-{
-	char *test;
-	int len = strlen(name);
-	bool ret;
-
-	if (!boot_snapshot_index)
-		return false;
-
-	if (strncmp(name, boot_snapshot_info, len) == 0 &&
-	    boot_snapshot_info[len] == '\t')
-		return true;
-
-	test = kmalloc(strlen(name) + 3, GFP_KERNEL);
-	if (!test)
-		return false;
-
-	sprintf(test, "\t%s\t", name);
-	ret = strstr(boot_snapshot_info, test) == NULL;
-	kfree(test);
-	return ret;
-}
-
-__init static void do_allocate_snapshot(const char *name)
-{
-	if (!tr_needs_alloc_snapshot(name))
-		return;
-
-	/*
-	 * When allocate_snapshot is set, the next call to
-	 * allocate_trace_buffers() (called by trace_array_get_by_name())
-	 * will allocate the snapshot buffer. That will also clear
-	 * this flag.
-	 */
-	allocate_snapshot = true;
-}
-#else
-static inline void do_allocate_snapshot(const char *name) { }
-#endif
-
 __init static int backup_instance_area(const char *backup,
 				       unsigned long *addr, phys_addr_t *size)
 {
@@ -10726,8 +9600,7 @@ __init static void enable_instances(void)
 			}
 		} else {
 			/* Only non mapped buffers have snapshot buffers */
-			if (IS_ENABLED(CONFIG_TRACER_SNAPSHOT))
-				do_allocate_snapshot(name);
+			do_allocate_snapshot(name);
 		}
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
@@ -10919,24 +9792,6 @@ struct trace_array *trace_get_global_array(void)
 }
 #endif
 
-void __init ftrace_boot_snapshot(void)
-{
-#ifdef CONFIG_TRACER_SNAPSHOT
-	struct trace_array *tr;
-
-	if (!snapshot_at_boot)
-		return;
-
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (!tr->allocated_snapshot)
-			continue;
-
-		tracing_snapshot_instance(tr);
-		trace_array_puts(tr, "** Boot snapshot taken **\n");
-	}
-#endif
-}
-
 void __init early_trace_init(void)
 {
 	if (tracepoint_printk) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 374b7c392f0a..7bf7fb81a360 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -261,6 +261,7 @@ static inline bool still_need_pid_events(int type, struct trace_pid_list *pid_li
 
 typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
 
+#ifdef CONFIG_TRACER_SNAPSHOT
 /**
  * struct cond_snapshot - conditional snapshot data and callback
  *
@@ -303,6 +304,7 @@ struct cond_snapshot {
 	void				*cond_data;
 	cond_update_fn_t		update;
 };
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 /*
  * struct trace_func_repeats - used to keep track of the consecutive
@@ -672,6 +674,7 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_release(struct inode *inode, struct file *file);
 int tracing_release_generic_tr(struct inode *inode, struct file *file);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
@@ -681,12 +684,48 @@ void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
 void tracer_tracing_disable(struct trace_array *tr);
 void tracer_tracing_enable(struct trace_array *tr);
+int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size);
 struct dentry *trace_create_file(const char *name,
 				 umode_t mode,
 				 struct dentry *parent,
 				 void *data,
 				 const struct file_operations *fops);
 
+struct trace_iterator *__tracing_open(struct inode *inode, struct file *file,
+				      bool snapshot);
+int tracing_buffers_open(struct inode *inode, struct file *filp);
+ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
+			     size_t count, loff_t *ppos);
+int tracing_buffers_release(struct inode *inode, struct file *file);
+ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
+		   struct pipe_inode_info *pipe, size_t len, unsigned int flags);
+
+ssize_t tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
+			   size_t cnt, loff_t *ppos);
+ssize_t tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
+			    size_t cnt, loff_t *ppos);
+
+void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val);
+
+/*
+ * Should be used after trace_array_get(), trace_types_lock
+ * ensures that i_cdev was already initialized.
+ */
+static inline int tracing_get_cpu(struct inode *inode)
+{
+	if (inode->i_cdev) /* See trace_create_cpu_file() */
+		return (long)inode->i_cdev - 1;
+	return RING_BUFFER_ALL_CPUS;
+}
+void tracing_reset_cpu(struct array_buffer *buf, int cpu);
+
+struct ftrace_buffer_info {
+	struct trace_iterator	iter;
+	void			*spare;
+	unsigned int		spare_cpu;
+	unsigned int		spare_size;
+	unsigned int		read;
+};
 
 /**
  * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
@@ -798,10 +837,15 @@ void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		   void *cond_data);
 void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
+void trace_create_maxlat_file(struct trace_array *tr,
+			      struct dentry *d_tracer);
 
 #ifdef CONFIG_FSNOTIFY
 #define LATENCY_FS_NOTIFY
 #endif
+#else /* CONFIG_TRACER_MAX_TRACE */
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 #ifdef LATENCY_FS_NOTIFY
@@ -2119,12 +2163,6 @@ static inline bool event_command_needs_rec(struct event_command *cmd_ops)
 
 extern int trace_event_enable_disable(struct trace_event_file *file,
 				      int enable, int soft_disable);
-extern int tracing_alloc_snapshot(void);
-extern void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
-extern int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
-
-extern int tracing_snapshot_cond_disable(struct trace_array *tr);
-extern void *tracing_cond_snapshot_data(struct trace_array *tr);
 
 extern const char *__start___trace_bprintk_fmt[];
 extern const char *__stop___trace_bprintk_fmt[];
@@ -2212,19 +2250,72 @@ static inline void trace_event_update_all(struct trace_eval_map **map, int len)
 #endif
 
 #ifdef CONFIG_TRACER_SNAPSHOT
+extern const struct file_operations snapshot_fops;
+extern const struct file_operations snapshot_raw_fops;
+
+/* Used when creating instances */
+int trace_allocate_snapshot(struct trace_array *tr, int size);
+
+int tracing_alloc_snapshot(void);
+void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
+int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
+int tracing_snapshot_cond_disable(struct trace_array *tr);
+void *tracing_cond_snapshot_data(struct trace_array *tr);
 void tracing_snapshot_instance(struct trace_array *tr);
 int tracing_alloc_snapshot_instance(struct trace_array *tr);
+int tracing_arm_snapshot_locked(struct trace_array *tr);
 int tracing_arm_snapshot(struct trace_array *tr);
 void tracing_disarm_snapshot(struct trace_array *tr);
-#else
+void free_snapshot(struct trace_array *tr);
+void print_snapshot_help(struct seq_file *m, struct trace_iterator *iter);
+int get_snapshot_map(struct trace_array *tr);
+void put_snapshot_map(struct trace_array *tr);
+int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
+				 struct array_buffer *size_buf, int cpu_id);
+__init void do_allocate_snapshot(const char *name);
+__init int register_snapshot_cmd(void);
+# ifdef CONFIG_DYNAMIC_FTRACE
+__init int register_snapshot_cmd(void);
+# else
+static inline int register_snapshot_cmd(void) { return 0; }
+# endif
+#else /* !CONFIG_TRACER_SNAPSHOT */
+static int trace_allocate_snapshot(struct trace_array *tr, int size) { return 0; }
 static inline void tracing_snapshot_instance(struct trace_array *tr) { }
 static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
 	return 0;
 }
+static inline int tracing_arm_snapshot_locked(struct trace_array *tr) { return -EBUSY; }
 static inline int tracing_arm_snapshot(struct trace_array *tr) { return 0; }
 static inline void tracing_disarm_snapshot(struct trace_array *tr) { }
-#endif
+static inline free_snapshot(struct trace_array *tr) {}
+static inline void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
+{
+	WARN_ONCE(1, "Snapshot feature not enabled, but internal conditional snapshot used");
+}
+static inline void *tracing_cond_snapshot_data(struct trace_array *tr)
+{
+	return NULL;
+}
+static inline int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update)
+{
+	return -ENODEV;
+}
+static inline int tracing_snapshot_cond_disable(struct trace_array *tr)
+{
+	return false;
+}
+static inline void print_snapshot_help(struct seq_file *m, struct trace_iterator *iter)
+{
+	/* Should never be called */
+	WARN_ONCE(1, "Snapshot print function called without snapshot configured");
+}
+static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
+static inline void put_snapshot_map(struct trace_array *tr) { }
+static inline void do_allocate_snapshot(const char *name) { }
+static inline int register_snapshot_cmd(void) { return 0; }
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef CONFIG_PREEMPT_TRACER
 void tracer_preempt_on(unsigned long a0, unsigned long a1);
diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
new file mode 100644
index 000000000000..bda614db5ce1
--- /dev/null
+++ b/kernel/trace/trace_snapshot.c
@@ -0,0 +1,1068 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fsnotify.h>
+
+#include <asm/setup.h> /* COMMAND_LINE_SIZE */
+
+#include "trace.h"
+
+/* Used if snapshot allocated at boot */
+static bool allocate_snapshot;
+static bool snapshot_at_boot;
+
+static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
+static int boot_snapshot_index;
+
+static int __init boot_alloc_snapshot(char *str)
+{
+	char *slot = boot_snapshot_info + boot_snapshot_index;
+	int left = sizeof(boot_snapshot_info) - boot_snapshot_index;
+	int ret;
+
+	if (str[0] == '=') {
+		str++;
+		if (strlen(str) >= left)
+			return -1;
+
+		ret = snprintf(slot, left, "%s\t", str);
+		boot_snapshot_index += ret;
+	} else {
+		allocate_snapshot = true;
+		/* We also need the main ring buffer expanded */
+		trace_set_ring_buffer_expanded(NULL);
+	}
+	return 1;
+}
+__setup("alloc_snapshot", boot_alloc_snapshot);
+
+
+static int __init boot_snapshot(char *str)
+{
+	snapshot_at_boot = true;
+	boot_alloc_snapshot(str);
+	return 1;
+}
+__setup("ftrace_boot_snapshot", boot_snapshot);
+
+static void tracing_snapshot_instance_cond(struct trace_array *tr,
+					   void *cond_data)
+{
+	struct tracer *tracer = tr->current_trace;
+	unsigned long flags;
+
+	if (in_nmi()) {
+		trace_array_puts(tr, "*** SNAPSHOT CALLED FROM NMI CONTEXT ***\n");
+		trace_array_puts(tr, "*** snapshot is being ignored        ***\n");
+		return;
+	}
+
+	if (!tr->allocated_snapshot) {
+		trace_array_puts(tr, "*** SNAPSHOT NOT ALLOCATED ***\n");
+		trace_array_puts(tr, "*** stopping trace here!   ***\n");
+		tracer_tracing_off(tr);
+		return;
+	}
+
+	/* Note, snapshot can not be used when the tracer uses it */
+	if (tracer->use_max_tr) {
+		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
+	if (tr->mapped) {
+		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
+	local_irq_save(flags);
+	update_max_tr(tr, current, smp_processor_id(), cond_data);
+	local_irq_restore(flags);
+}
+
+void tracing_snapshot_instance(struct trace_array *tr)
+{
+	tracing_snapshot_instance_cond(tr, NULL);
+}
+
+/**
+ * tracing_snapshot_cond - conditionally take a snapshot of the current buffer.
+ * @tr:		The tracing instance to snapshot
+ * @cond_data:	The data to be tested conditionally, and possibly saved
+ *
+ * This is the same as tracing_snapshot() except that the snapshot is
+ * conditional - the snapshot will only happen if the
+ * cond_snapshot.update() implementation receiving the cond_data
+ * returns true, which means that the trace array's cond_snapshot
+ * update() operation used the cond_data to determine whether the
+ * snapshot should be taken, and if it was, presumably saved it along
+ * with the snapshot.
+ */
+void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
+{
+	tracing_snapshot_instance_cond(tr, cond_data);
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
+
+/**
+ * tracing_cond_snapshot_data - get the user data associated with a snapshot
+ * @tr:		The tracing instance
+ *
+ * When the user enables a conditional snapshot using
+ * tracing_snapshot_cond_enable(), the user-defined cond_data is saved
+ * with the snapshot.  This accessor is used to retrieve it.
+ *
+ * Should not be called from cond_snapshot.update(), since it takes
+ * the tr->max_lock lock, which the code calling
+ * cond_snapshot.update() has already done.
+ *
+ * Returns the cond_data associated with the trace array's snapshot.
+ */
+void *tracing_cond_snapshot_data(struct trace_array *tr)
+{
+	void *cond_data = NULL;
+
+	local_irq_disable();
+	arch_spin_lock(&tr->max_lock);
+
+	if (tr->cond_snapshot)
+		cond_data = tr->cond_snapshot->cond_data;
+
+	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
+
+	return cond_data;
+}
+EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
+
+/* resize @tr's buffer to the size of @size_tr's entries */
+int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
+				 struct array_buffer *size_buf, int cpu_id)
+{
+	int cpu, ret = 0;
+
+	if (cpu_id == RING_BUFFER_ALL_CPUS) {
+		for_each_tracing_cpu(cpu) {
+			ret = ring_buffer_resize(trace_buf->buffer,
+				 per_cpu_ptr(size_buf->data, cpu)->entries, cpu);
+			if (ret < 0)
+				break;
+			per_cpu_ptr(trace_buf->data, cpu)->entries =
+				per_cpu_ptr(size_buf->data, cpu)->entries;
+		}
+	} else {
+		ret = ring_buffer_resize(trace_buf->buffer,
+				 per_cpu_ptr(size_buf->data, cpu_id)->entries, cpu_id);
+		if (ret == 0)
+			per_cpu_ptr(trace_buf->data, cpu_id)->entries =
+				per_cpu_ptr(size_buf->data, cpu_id)->entries;
+	}
+
+	return ret;
+}
+
+int tracing_alloc_snapshot_instance(struct trace_array *tr)
+{
+	int order;
+	int ret;
+
+	if (!tr->allocated_snapshot) {
+
+		/* Make the snapshot buffer have the same order as main buffer */
+		order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+		ret = ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, order);
+		if (ret < 0)
+			return ret;
+
+		/* allocate spare buffer */
+		ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
+				   &tr->array_buffer, RING_BUFFER_ALL_CPUS);
+		if (ret < 0)
+			return ret;
+
+		tr->allocated_snapshot = true;
+	}
+
+	return 0;
+}
+
+void free_snapshot(struct trace_array *tr)
+{
+	/*
+	 * We don't free the ring buffer. instead, resize it because
+	 * The max_tr ring buffer has some state (e.g. ring->clock) and
+	 * we want preserve it.
+	 */
+	ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, 0);
+	ring_buffer_resize(tr->snapshot_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
+	trace_set_buffer_entries(&tr->snapshot_buffer, 1);
+	tracing_reset_online_cpus(&tr->snapshot_buffer);
+	tr->allocated_snapshot = false;
+}
+
+int tracing_arm_snapshot_locked(struct trace_array *tr)
+{
+	int ret;
+
+	lockdep_assert_held(&trace_types_lock);
+
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
+		spin_unlock(&tr->snapshot_trigger_lock);
+		return -EBUSY;
+	}
+
+	tr->snapshot++;
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	ret = tracing_alloc_snapshot_instance(tr);
+	if (ret) {
+		spin_lock(&tr->snapshot_trigger_lock);
+		tr->snapshot--;
+		spin_unlock(&tr->snapshot_trigger_lock);
+	}
+
+	return ret;
+}
+
+int tracing_arm_snapshot(struct trace_array *tr)
+{
+	guard(mutex)(&trace_types_lock);
+	return tracing_arm_snapshot_locked(tr);
+}
+
+void tracing_disarm_snapshot(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->snapshot))
+		tr->snapshot--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+
+/**
+ * tracing_snapshot_alloc - allocate and take a snapshot of the current buffer.
+ *
+ * This is similar to tracing_snapshot(), but it will allocate the
+ * snapshot buffer if it isn't already allocated. Use this only
+ * where it is safe to sleep, as the allocation may sleep.
+ *
+ * This causes a swap between the snapshot buffer and the current live
+ * tracing buffer. You can use this to take snapshots of the live
+ * trace when some condition is triggered, but continue to trace.
+ */
+void tracing_snapshot_alloc(void)
+{
+	int ret;
+
+	ret = tracing_alloc_snapshot();
+	if (ret < 0)
+		return;
+
+	tracing_snapshot();
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
+
+/**
+ * tracing_snapshot_cond_enable - enable conditional snapshot for an instance
+ * @tr:		The tracing instance
+ * @cond_data:	User data to associate with the snapshot
+ * @update:	Implementation of the cond_snapshot update function
+ *
+ * Check whether the conditional snapshot for the given instance has
+ * already been enabled, or if the current tracer is already using a
+ * snapshot; if so, return -EBUSY, else create a cond_snapshot and
+ * save the cond_data and update function inside.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
+				 cond_update_fn_t update)
+{
+	struct cond_snapshot *cond_snapshot __free(kfree) =
+		kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
+	int ret;
+
+	if (!cond_snapshot)
+		return -ENOMEM;
+
+	cond_snapshot->cond_data = cond_data;
+	cond_snapshot->update = update;
+
+	guard(mutex)(&trace_types_lock);
+
+	if (tr->current_trace->use_max_tr)
+		return -EBUSY;
+
+	/*
+	 * The cond_snapshot can only change to NULL without the
+	 * trace_types_lock. We don't care if we race with it going
+	 * to NULL, but we want to make sure that it's not set to
+	 * something other than NULL when we get here, which we can
+	 * do safely with only holding the trace_types_lock and not
+	 * having to take the max_lock.
+	 */
+	if (tr->cond_snapshot)
+		return -EBUSY;
+
+	ret = tracing_arm_snapshot_locked(tr);
+	if (ret)
+		return ret;
+
+	local_irq_disable();
+	arch_spin_lock(&tr->max_lock);
+	tr->cond_snapshot = no_free_ptr(cond_snapshot);
+	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
+
+/**
+ * tracing_snapshot_cond_disable - disable conditional snapshot for an instance
+ * @tr:		The tracing instance
+ *
+ * Check whether the conditional snapshot for the given instance is
+ * enabled; if so, free the cond_snapshot associated with it,
+ * otherwise return -EINVAL.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int tracing_snapshot_cond_disable(struct trace_array *tr)
+{
+	int ret = 0;
+
+	local_irq_disable();
+	arch_spin_lock(&tr->max_lock);
+
+	if (!tr->cond_snapshot)
+		ret = -EINVAL;
+	else {
+		kfree(tr->cond_snapshot);
+		tr->cond_snapshot = NULL;
+	}
+
+	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
+
+	tracing_disarm_snapshot(tr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+static const struct file_operations tracing_max_lat_fops;
+
+#ifdef LATENCY_FS_NOTIFY
+
+static struct workqueue_struct *fsnotify_wq;
+
+static void latency_fsnotify_workfn(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array,
+					      fsnotify_work);
+	fsnotify_inode(tr->d_max_latency->d_inode, FS_MODIFY);
+}
+
+static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
+{
+	struct trace_array *tr = container_of(iwork, struct trace_array,
+					      fsnotify_irqwork);
+	queue_work(fsnotify_wq, &tr->fsnotify_work);
+}
+
+void trace_create_maxlat_file(struct trace_array *tr,
+			      struct dentry *d_tracer)
+{
+	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
+	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
+	tr->d_max_latency = trace_create_file("tracing_max_latency",
+					      TRACE_MODE_WRITE,
+					      d_tracer, tr,
+					      &tracing_max_lat_fops);
+}
+
+__init static int latency_fsnotify_init(void)
+{
+	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
+				      WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!fsnotify_wq) {
+		pr_err("Unable to allocate tr_max_lat_wq\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+late_initcall_sync(latency_fsnotify_init);
+
+void latency_fsnotify(struct trace_array *tr)
+{
+	if (!fsnotify_wq)
+		return;
+	/*
+	 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
+	 * possible that we are called from __schedule() or do_idle(), which
+	 * could cause a deadlock.
+	 */
+	irq_work_queue(&tr->fsnotify_irqwork);
+}
+
+#else /* !LATENCY_FS_NOTIFY */
+
+#endif
+
+/*
+ * Copy the new maximum trace into the separate maximum-trace
+ * structure. (this way the maximum trace is permanently saved,
+ * for later retrieval via /sys/kernel/tracing/tracing_max_latency)
+ */
+static void
+__update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
+{
+	struct array_buffer *trace_buf = &tr->array_buffer;
+	struct array_buffer *max_buf = &tr->snapshot_buffer;
+	struct trace_array_cpu *data = per_cpu_ptr(trace_buf->data, cpu);
+	struct trace_array_cpu *max_data = per_cpu_ptr(max_buf->data, cpu);
+
+	max_buf->cpu = cpu;
+	max_buf->time_start = data->preempt_timestamp;
+
+	max_data->saved_latency = tr->max_latency;
+	max_data->critical_start = data->critical_start;
+	max_data->critical_end = data->critical_end;
+
+	strscpy(max_data->comm, tsk->comm);
+	max_data->pid = tsk->pid;
+	/*
+	 * If tsk == current, then use current_uid(), as that does not use
+	 * RCU. The irq tracer can be called out of RCU scope.
+	 */
+	if (tsk == current)
+		max_data->uid = current_uid();
+	else
+		max_data->uid = task_uid(tsk);
+
+	max_data->nice = tsk->static_prio - 20 - MAX_RT_PRIO;
+	max_data->policy = tsk->policy;
+	max_data->rt_priority = tsk->rt_priority;
+
+	/* record this tasks comm */
+	tracing_record_cmdline(tsk);
+	latency_fsnotify(tr);
+}
+
+/**
+ * update_max_tr - snapshot all trace buffers from global_trace to max_tr
+ * @tr: tracer
+ * @tsk: the task with the latency
+ * @cpu: The cpu that initiated the trace.
+ * @cond_data: User data associated with a conditional snapshot
+ *
+ * Flip the buffers between the @tr and the max_tr and record information
+ * about which task was the cause of this latency.
+ */
+void
+update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
+	      void *cond_data)
+{
+	if (tr->stop_count)
+		return;
+
+	WARN_ON_ONCE(!irqs_disabled());
+
+	if (!tr->allocated_snapshot) {
+		/* Only the nop tracer should hit this when disabling */
+		WARN_ON_ONCE(tr->current_trace != &nop_trace);
+		return;
+	}
+
+	arch_spin_lock(&tr->max_lock);
+
+	/* Inherit the recordable setting from array_buffer */
+	if (ring_buffer_record_is_set_on(tr->array_buffer.buffer))
+		ring_buffer_record_on(tr->snapshot_buffer.buffer);
+	else
+		ring_buffer_record_off(tr->snapshot_buffer.buffer);
+
+	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data)) {
+		arch_spin_unlock(&tr->max_lock);
+		return;
+	}
+
+	swap(tr->array_buffer.buffer, tr->snapshot_buffer.buffer);
+
+	__update_max_tr(tr, tsk, cpu);
+
+	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
+}
+
+/**
+ * update_max_tr_single - only copy one trace over, and reset the rest
+ * @tr: tracer
+ * @tsk: task with the latency
+ * @cpu: the cpu of the buffer to copy.
+ *
+ * Flip the trace of a single CPU buffer between the @tr and the max_tr.
+ */
+void
+update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
+{
+	int ret;
+
+	if (tr->stop_count)
+		return;
+
+	WARN_ON_ONCE(!irqs_disabled());
+	if (!tr->allocated_snapshot) {
+		/* Only the nop tracer should hit this when disabling */
+		WARN_ON_ONCE(tr->current_trace != &nop_trace);
+		return;
+	}
+
+	arch_spin_lock(&tr->max_lock);
+
+	ret = ring_buffer_swap_cpu(tr->snapshot_buffer.buffer, tr->array_buffer.buffer, cpu);
+
+	if (ret == -EBUSY) {
+		/*
+		 * We failed to swap the buffer due to a commit taking
+		 * place on this CPU. We fail to record, but we reset
+		 * the max trace buffer (no one writes directly to it)
+		 * and flag that it failed.
+		 * Another reason is resize is in progress.
+		 */
+		trace_array_printk_buf(tr->snapshot_buffer.buffer, _THIS_IP_,
+			"Failed to swap buffers due to commit or resize in progress\n");
+	}
+
+	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
+
+	__update_max_tr(tr, tsk, cpu);
+	arch_spin_unlock(&tr->max_lock);
+}
+
+#endif /* CONFIG_TRACER_MAX_TRACE */
+
+static void show_snapshot_main_help(struct seq_file *m)
+{
+	seq_puts(m, "# echo 0 > snapshot : Clears and frees snapshot buffer\n"
+		    "# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.\n"
+		    "#                      Takes a snapshot of the main buffer.\n"
+		    "# echo 2 > snapshot : Clears snapshot buffer (but does not allocate or free)\n"
+		    "#                      (Doesn't have to be '2' works with any number that\n"
+		    "#                       is not a '0' or '1')\n");
+}
+
+static void show_snapshot_percpu_help(struct seq_file *m)
+{
+	seq_puts(m, "# echo 0 > snapshot : Invalid for per_cpu snapshot file.\n");
+#ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
+	seq_puts(m, "# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.\n"
+		    "#                      Takes a snapshot of the main buffer for this cpu.\n");
+#else
+	seq_puts(m, "# echo 1 > snapshot : Not supported with this kernel.\n"
+		    "#                     Must use main snapshot file to allocate.\n");
+#endif
+	seq_puts(m, "# echo 2 > snapshot : Clears this cpu's snapshot buffer (but does not allocate)\n"
+		    "#                      (Doesn't have to be '2' works with any number that\n"
+		    "#                       is not a '0' or '1')\n");
+}
+
+void print_snapshot_help(struct seq_file *m, struct trace_iterator *iter)
+{
+	if (iter->tr->allocated_snapshot)
+		seq_puts(m, "#\n# * Snapshot is allocated *\n#\n");
+	else
+		seq_puts(m, "#\n# * Snapshot is freed *\n#\n");
+
+	seq_puts(m, "# Snapshot commands:\n");
+	if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		show_snapshot_main_help(m);
+	else
+		show_snapshot_percpu_help(m);
+}
+
+static int tracing_snapshot_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+	struct trace_iterator *iter;
+	struct seq_file *m;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	if (file->f_mode & FMODE_READ) {
+		iter = __tracing_open(inode, file, true);
+		if (IS_ERR(iter))
+			ret = PTR_ERR(iter);
+	} else {
+		/* Writes still need the seq_file to hold the private data */
+		ret = -ENOMEM;
+		m = kzalloc(sizeof(*m), GFP_KERNEL);
+		if (!m)
+			goto out;
+		iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+		if (!iter) {
+			kfree(m);
+			goto out;
+		}
+		ret = 0;
+
+		iter->tr = tr;
+		iter->array_buffer = &tr->snapshot_buffer;
+		iter->cpu_file = tracing_get_cpu(inode);
+		m->private = iter;
+		file->private_data = m;
+	}
+out:
+	if (ret < 0)
+		trace_array_put(tr);
+
+	return ret;
+}
+
+static void tracing_swap_cpu_buffer(void *tr)
+{
+	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+}
+
+static ssize_t
+tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
+		       loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct trace_iterator *iter = m->private;
+	struct trace_array *tr = iter->tr;
+	unsigned long val;
+	int ret;
+
+	ret = tracing_update_buffers(tr);
+	if (ret < 0)
+		return ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&trace_types_lock);
+
+	if (tr->current_trace->use_max_tr)
+		return -EBUSY;
+
+	local_irq_disable();
+	arch_spin_lock(&tr->max_lock);
+	if (tr->cond_snapshot)
+		ret = -EBUSY;
+	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0:
+		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
+			return -EINVAL;
+		if (tr->allocated_snapshot)
+			free_snapshot(tr);
+		break;
+	case 1:
+/* Only allow per-cpu swap if the ring buffer supports it */
+#ifndef CONFIG_RING_BUFFER_ALLOW_SWAP
+		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
+			return -EINVAL;
+#endif
+		if (tr->allocated_snapshot)
+			ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
+					&tr->array_buffer, iter->cpu_file);
+
+		ret = tracing_arm_snapshot_locked(tr);
+		if (ret)
+			return ret;
+
+		/* Now, we're going to swap */
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
+			local_irq_disable();
+			update_max_tr(tr, current, smp_processor_id(), NULL);
+			local_irq_enable();
+		} else {
+			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
+						 (void *)tr, 1);
+		}
+		tracing_disarm_snapshot(tr);
+		break;
+	default:
+		if (tr->allocated_snapshot) {
+			if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+				tracing_reset_online_cpus(&tr->snapshot_buffer);
+			else
+				tracing_reset_cpu(&tr->snapshot_buffer, iter->cpu_file);
+		}
+		break;
+	}
+
+	if (ret >= 0) {
+		*ppos += cnt;
+		ret = cnt;
+	}
+
+	return ret;
+}
+
+static int tracing_snapshot_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	int ret;
+
+	ret = tracing_release(inode, file);
+
+	if (file->f_mode & FMODE_READ)
+		return ret;
+
+	/* If write only, the seq_file is just a stub */
+	if (m)
+		kfree(m->private);
+	kfree(m);
+
+	return 0;
+}
+
+static int snapshot_raw_open(struct inode *inode, struct file *filp)
+{
+	struct ftrace_buffer_info *info;
+	int ret;
+
+	/* The following checks for tracefs lockdown */
+	ret = tracing_buffers_open(inode, filp);
+	if (ret < 0)
+		return ret;
+
+	info = filp->private_data;
+
+	if (info->iter.trace->use_max_tr) {
+		tracing_buffers_release(inode, filp);
+		return -EBUSY;
+	}
+
+	info->iter.snapshot = true;
+	info->iter.array_buffer = &info->iter.tr->snapshot_buffer;
+
+	return ret;
+}
+
+const struct file_operations snapshot_fops = {
+	.open		= tracing_snapshot_open,
+	.read		= seq_read,
+	.write		= tracing_snapshot_write,
+	.llseek		= tracing_lseek,
+	.release	= tracing_snapshot_release,
+};
+
+const struct file_operations snapshot_raw_fops = {
+	.open		= snapshot_raw_open,
+	.read		= tracing_buffers_read,
+	.release	= tracing_buffers_release,
+	.splice_read	= tracing_buffers_splice_read,
+};
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+static ssize_t
+tracing_max_lat_read(struct file *filp, char __user *ubuf,
+		     size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
+}
+
+static ssize_t
+tracing_max_lat_write(struct file *filp, const char __user *ubuf,
+		      size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
+}
+
+static const struct file_operations tracing_max_lat_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_max_lat_read,
+	.write		= tracing_max_lat_write,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+#endif /* CONFIG_TRACER_MAX_TRACE */
+
+int get_snapshot_map(struct trace_array *tr)
+{
+	int err = 0;
+
+	/*
+	 * Called with mmap_lock held. lockdep would be unhappy if we would now
+	 * take trace_types_lock. Instead use the specific
+	 * snapshot_trigger_lock.
+	 */
+	spin_lock(&tr->snapshot_trigger_lock);
+
+	if (tr->snapshot || tr->mapped == UINT_MAX)
+		err = -EBUSY;
+	else
+		tr->mapped++;
+
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (tr->mapped == 1)
+		synchronize_rcu();
+
+	return err;
+
+}
+void put_snapshot_map(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->mapped))
+		tr->mapped--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+static void
+ftrace_snapshot(unsigned long ip, unsigned long parent_ip,
+		struct trace_array *tr, struct ftrace_probe_ops *ops,
+		void *data)
+{
+	tracing_snapshot_instance(tr);
+}
+
+static void
+ftrace_count_snapshot(unsigned long ip, unsigned long parent_ip,
+		      struct trace_array *tr, struct ftrace_probe_ops *ops,
+		      void *data)
+{
+	struct ftrace_func_mapper *mapper = data;
+	long *count = NULL;
+
+	if (mapper)
+		count = (long *)ftrace_func_mapper_find_ip(mapper, ip);
+
+	if (count) {
+
+		if (*count <= 0)
+			return;
+
+		(*count)--;
+	}
+
+	tracing_snapshot_instance(tr);
+}
+
+static int
+ftrace_snapshot_print(struct seq_file *m, unsigned long ip,
+		      struct ftrace_probe_ops *ops, void *data)
+{
+	struct ftrace_func_mapper *mapper = data;
+	long *count = NULL;
+
+	seq_printf(m, "%ps:", (void *)ip);
+
+	seq_puts(m, "snapshot");
+
+	if (mapper)
+		count = (long *)ftrace_func_mapper_find_ip(mapper, ip);
+
+	if (count)
+		seq_printf(m, ":count=%ld\n", *count);
+	else
+		seq_puts(m, ":unlimited\n");
+
+	return 0;
+}
+
+static int
+ftrace_snapshot_init(struct ftrace_probe_ops *ops, struct trace_array *tr,
+		     unsigned long ip, void *init_data, void **data)
+{
+	struct ftrace_func_mapper *mapper = *data;
+
+	if (!mapper) {
+		mapper = allocate_ftrace_func_mapper();
+		if (!mapper)
+			return -ENOMEM;
+		*data = mapper;
+	}
+
+	return ftrace_func_mapper_add_ip(mapper, ip, init_data);
+}
+
+static void
+ftrace_snapshot_free(struct ftrace_probe_ops *ops, struct trace_array *tr,
+		     unsigned long ip, void *data)
+{
+	struct ftrace_func_mapper *mapper = data;
+
+	if (!ip) {
+		if (!mapper)
+			return;
+		free_ftrace_func_mapper(mapper, NULL);
+		return;
+	}
+
+	ftrace_func_mapper_remove_ip(mapper, ip);
+}
+
+static struct ftrace_probe_ops snapshot_probe_ops = {
+	.func			= ftrace_snapshot,
+	.print			= ftrace_snapshot_print,
+};
+
+static struct ftrace_probe_ops snapshot_count_probe_ops = {
+	.func			= ftrace_count_snapshot,
+	.print			= ftrace_snapshot_print,
+	.init			= ftrace_snapshot_init,
+	.free			= ftrace_snapshot_free,
+};
+
+static int
+ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
+			       char *glob, char *cmd, char *param, int enable)
+{
+	struct ftrace_probe_ops *ops;
+	void *count = (void *)-1;
+	char *number;
+	int ret;
+
+	if (!tr)
+		return -ENODEV;
+
+	/* hash funcs only work with set_ftrace_filter */
+	if (!enable)
+		return -EINVAL;
+
+	ops = param ? &snapshot_count_probe_ops :  &snapshot_probe_ops;
+
+	if (glob[0] == '!') {
+		ret = unregister_ftrace_function_probe_func(glob+1, tr, ops);
+		if (!ret)
+			tracing_disarm_snapshot(tr);
+
+		return ret;
+	}
+
+	if (!param)
+		goto out_reg;
+
+	number = strsep(&param, ":");
+
+	if (!strlen(number))
+		goto out_reg;
+
+	/*
+	 * We use the callback data field (which is a pointer)
+	 * as our counter.
+	 */
+	ret = kstrtoul(number, 0, (unsigned long *)&count);
+	if (ret)
+		return ret;
+
+ out_reg:
+	ret = tracing_arm_snapshot(tr);
+	if (ret < 0)
+		return ret;
+
+	ret = register_ftrace_function_probe(glob, tr, ops, count);
+	if (ret < 0)
+		tracing_disarm_snapshot(tr);
+
+	return ret < 0 ? ret : 0;
+}
+
+static struct ftrace_func_command ftrace_snapshot_cmd = {
+	.name			= "snapshot",
+	.func			= ftrace_trace_snapshot_callback,
+};
+
+__init int register_snapshot_cmd(void)
+{
+	return register_ftrace_command(&ftrace_snapshot_cmd);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+int trace_allocate_snapshot(struct trace_array *tr, int size)
+{
+	int ret;
+
+	/* Fix mapped buffer trace arrays do not have snapshot buffers */
+	if (tr->range_addr_start)
+		return 0;
+
+	/* allocate_snapshot can only be true during system boot */
+	ret = allocate_trace_buffer(tr, &tr->snapshot_buffer,
+				    allocate_snapshot ? size : 1);
+	if (ret < 0)
+		return -ENOMEM;
+
+	tr->allocated_snapshot = allocate_snapshot;
+
+	allocate_snapshot = false;
+	return 0;
+}
+
+__init static bool tr_needs_alloc_snapshot(const char *name)
+{
+	char *test;
+	int len = strlen(name);
+	bool ret;
+
+	if (!boot_snapshot_index)
+		return false;
+
+	if (strncmp(name, boot_snapshot_info, len) == 0 &&
+	    boot_snapshot_info[len] == '\t')
+		return true;
+
+	test = kmalloc(strlen(name) + 3, GFP_KERNEL);
+	if (!test)
+		return false;
+
+	sprintf(test, "\t%s\t", name);
+	ret = strstr(boot_snapshot_info, test) == NULL;
+	kfree(test);
+	return ret;
+}
+
+__init void do_allocate_snapshot(const char *name)
+{
+	if (!tr_needs_alloc_snapshot(name))
+		return;
+
+	/*
+	 * When allocate_snapshot is set, the next call to
+	 * allocate_trace_buffers() (called by trace_array_get_by_name())
+	 * will allocate the snapshot buffer. That will also clear
+	 * this flag.
+	 */
+	allocate_snapshot = true;
+}
+
+void __init ftrace_boot_snapshot(void)
+{
+	struct trace_array *tr;
+
+	if (!snapshot_at_boot)
+		return;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (!tr->allocated_snapshot)
+			continue;
+
+		tracing_snapshot_instance(tr);
+		trace_array_puts(tr, "** Boot snapshot taken **\n");
+	}
+}
+
-- 
2.51.0


