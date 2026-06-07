Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7A280A5A
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848872; cv=none; b=OQKOsAfuiCgfWTdifT/pPMY5LrGkqkShZiqI9lrQX7AcmA83UEsA5p4cbcw4qDE9CKef+vdbb/FcINnH0DJIzcRy+N4W6mJZ4bKQoahy4YFwPnGvXXhORz7NTIIJy+kc+Z5cWwFZEL8L69i8ecBzeXiEMQv7IuWx1E1/NEOLkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848872; c=relaxed/simple;
	bh=lFatilh+Rv5xM2kRwze5EJPL3AfvfidwMd5k9ovzLGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpQ04YB6+BGDDmfPYungUGJ1YDdQCSDqAyo7lVJgWx7v0PmC4qlMiP56popFEdiSbzuKPd7oVp9nHARecCt/6OSA8/siu5IdSbjlXKUYUOO1imXDg8ueQggJhLVFQb97ttJRjVKoj4lVHn59FoxldHvDmQTvEvE8s1h5k+gk4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jzy2jNk1; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jzy2jNk1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq8pBiUeuwmq6NX7kj9hJpOyICYs+cIF1FRis4e9N00=;
	b=jzy2jNk1qzWo/2HY+KW9/tTDl1F2ncTAvbiLlJIkOEuglQivDluFCEOqESxwdpfMlrK/kM
	cK4+/03OlxT/MSx9utAphZsqDhA6yB2f6kvIEuVrw7qRr0WsfEHjYWh1quIMmhYToq5WsU
	aiedRejDVV9b4jsXNKl1J+MDcS6/SnM=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 1/9] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
Date: Mon,  8 Jun 2026 00:13:49 +0800
Message-Id: <496394879a590b4d7bafdb2f13618d2e30be982f.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Consolidate per-object DA monitor storage allocation under a
single compile-time selector, replacing the ad-hoc
da_monitor_init_prealloc() API.

Three strategies are provided:

  DA_ALLOC_AUTO   (default) - lock-free kmalloc_nolock on the hot path;
                              unbounded capacity.  Preserves the existing
                              behaviour for all monitors that do not set
                              DA_MON_ALLOCATION_STRATEGY.

  DA_ALLOC_POOL             - pre-allocated fixed-size pool.  Requires the
                              monitor to define DA_MON_POOL_SIZE; enforced
                              with #error.  da_prepare_storage() acquires
                              spinlock_t (O(1), irqsave); must be called
                              from task context on PREEMPT_RT where
                              spinlock_t is a sleeping lock.

  DA_ALLOC_MANUAL           - caller pre-inserts storage via
                              da_create_empty_storage() before the first
                              da_handle_start_event(); the framework only
                              links the target field.  Useful for monitors
                              that allocate storage from known-safe task
                              context (e.g. a syscall path) and then hand
                              it to a tracepoint handler on the hot path.

da_handle_start_event() and da_handle_start_run_event() both call
da_prepare_storage() which resolves at compile time to the correct
allocation function, so no runtime dispatch is needed.

da_monitor_init_prealloc() is removed; da_monitor_init() selects pool
or kmalloc initialisation internally based on the strategy.

A da_extra_cleanup() hook macro is added: the default is a no-op; a
monitor may define it as a function called by da_monitor_destroy() on
each remaining entry before hash_del_rcu().

nomiss is updated to DA_ALLOC_MANUAL: it calls da_create_empty_storage()
from handle_sys_enter() (the sched_setscheduler syscall path, safe
task context), then da_fill_empty_storage() links the sched_dl_entity
target on the first da_handle_start_run_event() call in
handle_sched_switch().

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h                  | 276 +++++++++++++++++++++--
 kernel/trace/rv/monitors/nomiss/nomiss.c |   6 +-
 2 files changed, 254 insertions(+), 28 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ecd4..eb7fc02ecb8a 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,6 +14,26 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
+/*
+ * Allocation strategies for RV_MON_PER_OBJ monitors.
+ *
+ * Define DA_MON_ALLOCATION_STRATEGY before including this header.
+ * DA_ALLOC_AUTO   - lock-free kmalloc on the hot path; unbounded capacity.
+ * DA_ALLOC_POOL   - pre-allocated fixed-size pool; requires DA_MON_POOL_SIZE.
+ *                   da_prepare_storage() acquires spinlock_t (O(1), irqsave);
+ *                   must be called from task context on PREEMPT_RT where
+ *                   spinlock_t is a sleeping lock.
+ * DA_ALLOC_MANUAL - caller inserts storage before da_handle_start_event();
+ *                   the framework only links the target field.
+ */
+#define DA_ALLOC_AUTO   0
+#define DA_ALLOC_POOL   1
+#define DA_ALLOC_MANUAL 2
+
+#ifndef DA_MON_ALLOCATION_STRATEGY
+# define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
+#endif
+
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
@@ -66,6 +86,19 @@ static struct rv_monitor rv_this;
 #define da_monitor_sync_hook()
 #endif
 
+/*
+ * Hook for per-object teardown during da_monitor_destroy().
+ *
+ * Called for each entry still in the hash table when the monitor is
+ * destroyed.  Invoked before da_monitor_reset() and hash_del_rcu(), so
+ * it is safe to call ha_cancel_timer_sync() here.
+ *
+ * Define before including this header.  Default is a no-op.
+ */
+#ifndef da_extra_cleanup
+#define da_extra_cleanup(da_mon)
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  * A long type can work as hash table key (PER_OBJ) but will be downgraded to
@@ -398,6 +431,16 @@ static inline void da_monitor_destroy(void)
  * Functions to define, init and get a per-object monitor.
  */
 
+/*
+ * DA_MON_POOL_SIZE must be defined before this header is included (directly or
+ * transitively via ha_monitor.h) when DA_ALLOC_POOL is selected.  In practice
+ * this means defining it after the monitor's model header (which supplies the
+ * capacity constant) and before the ha_monitor.h include.
+ */
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL && !defined(DA_MON_POOL_SIZE)
+# error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined before including this header"
+#endif
+
 struct da_monitor_storage {
 	da_id_type id;
 	monitor_target target;
@@ -495,18 +538,6 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
 	return container_of(da_mon, struct da_monitor_storage, rv.da_mon)->id;
 }
 
-/*
- * da_create_or_get - create the per-object storage if not already there
- *
- * This needs a lookup so should be guarded by RCU, the condition is checked
- * directly in da_create_storage()
- */
-static inline void da_create_or_get(da_id_type id, monitor_target target)
-{
-	guard(rcu)();
-	da_create_storage(id, target, da_get_monitor(id, target));
-}
-
 /*
  * da_fill_empty_storage - store the target in a pre-allocated storage
  *
@@ -537,15 +568,96 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 	return mon_storage->target;
 }
 
+/*
+ * Per-object pool state.
+ *
+ * Zero-initialised by default (storage == NULL ⟹ kmalloc mode).  A monitor
+ * opts into pool mode by defining DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
+ * and DA_MON_POOL_SIZE before including this header; da_monitor_init() then
+ * pre-allocates the pool internally.
+ *
+ * Because every field is wrapped in this struct and the struct itself is a
+ * per-TU static, each monitor that includes this header gets a completely
+ * independent pool.  A kmalloc monitor (e.g. nomiss) and a pool monitor
+ * (e.g. tlob) therefore coexist without any interference.
+ *
+ * da_pool_return_cb runs from softirq (non-PREEMPT_RT) or rcuc kthread
+ * (PREEMPT_RT); spin_lock_irqsave handles both.
+ */
+struct da_per_obj_pool {
+	struct da_monitor_storage  *storage;  /* non-NULL ⟹ pool mode */
+	struct da_monitor_storage **free;     /* kmalloc'd pointer stack */
+	unsigned int                free_top;
+	unsigned int                capacity; /* total number of slots */
+	spinlock_t                  lock;
+};
+
+static struct da_per_obj_pool da_pool = {
+	.lock = __SPIN_LOCK_UNLOCKED(da_pool.lock),
+};
+
+static void da_pool_return_cb(struct rcu_head *head)
+{
+	struct da_monitor_storage *ms =
+		container_of(head, struct da_monitor_storage, rcu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&da_pool.lock, flags);
+	if (!WARN_ON_ONCE(!da_pool.free || da_pool.free_top >= da_pool.capacity))
+		da_pool.free[da_pool.free_top++] = ms;
+	spin_unlock_irqrestore(&da_pool.lock, flags);
+}
+
+/*
+ * da_create_or_get_pool - pop a slot and insert it into the hash.
+ *
+ * Returns the new da_monitor on success, NULL if the pool is exhausted, or
+ * the existing da_monitor if a concurrent caller already inserted the same id
+ * (in which case the popped slot is returned to the free stack).
+ *
+ * Must be called inside an RCU read-side critical section (guard(rcu)()).
+ */
+static inline struct da_monitor *
+da_create_or_get_pool(da_id_type id, monitor_target target)
+{
+	struct da_monitor_storage *mon_storage, *existing;
+	unsigned long flags;
+
+	spin_lock_irqsave(&da_pool.lock, flags);
+	if (!da_pool.free_top) {
+		spin_unlock_irqrestore(&da_pool.lock, flags);
+		return NULL;
+	}
+	mon_storage = da_pool.free[--da_pool.free_top];
+	spin_unlock_irqrestore(&da_pool.lock, flags);
+
+	mon_storage->id = id;
+	mon_storage->target = target;
+
+	/*
+	 * A concurrent caller may have inserted the same id between our spinlock
+	 * release and here.  Return the slot to the pool and yield to the winner.
+	 */
+	existing = __da_get_mon_storage(id);
+	if (unlikely(existing)) {
+		spin_lock_irqsave(&da_pool.lock, flags);
+		da_pool.free[da_pool.free_top++] = mon_storage;
+		spin_unlock_irqrestore(&da_pool.lock, flags);
+		return &existing->rv.da_mon;
+	}
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	return &mon_storage->rv.da_mon;
+}
+
+
 /*
  * da_destroy_storage - destroy the per-object storage
  *
- * The caller is responsible to synchronise writers, either with locks or
- * implicitly. For instance, if da_destroy_storage is called at sched_exit and
- * da_create_storage can never occur after that, it's safe to call this without
- * locks.
- * This function includes an RCU read-side critical section to synchronise
- * against da_monitor_destroy().
+ * Pool mode: removes from hash and returns the slot via call_rcu().
+ * Kmalloc mode: removes from hash and frees via kfree_rcu().
+ *
+ * Includes an RCU read-side critical section to synchronise against
+ * da_monitor_destroy().
  */
 static inline void da_destroy_storage(da_id_type id)
 {
@@ -558,7 +670,11 @@ static inline void da_destroy_storage(da_id_type id)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+	call_rcu(&mon_storage->rcu, da_pool_return_cb);
+#else
 	kfree_rcu(mon_storage, rcu);
+#endif
 }
 
 static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
@@ -581,13 +697,87 @@ static inline void da_monitor_reset_state_all(void)
 	__da_monitor_reset_all(da_monitor_reset_state);
 }
 
+/* Not part of the public API; called by da_monitor_init() for DA_ALLOC_POOL. */
+static inline int __da_monitor_init_pool(unsigned int prealloc_count)
+{
+	da_pool.storage = kcalloc(prealloc_count, sizeof(*da_pool.storage),
+				  GFP_KERNEL);
+	if (!da_pool.storage)
+		return -ENOMEM;
+
+	da_pool.free = kmalloc_array(prealloc_count, sizeof(*da_pool.free),
+				     GFP_KERNEL);
+	if (!da_pool.free) {
+		kfree(da_pool.storage);
+		da_pool.storage = NULL;
+		return -ENOMEM;
+	}
+
+	da_pool.capacity = prealloc_count;
+	da_pool.free_top = 0;
+	for (unsigned int i = 0; i < prealloc_count; i++)
+		da_pool.free[da_pool.free_top++] = &da_pool.storage[i];
+	return 0;
+}
+
+/*
+ * da_monitor_init - initialise the per-object monitor
+ *
+ * Selects the allocation path at compile time based on DA_MON_ALLOCATION_STRATEGY:
+ *   DA_ALLOC_POOL   - pre-allocates DA_MON_POOL_SIZE storage slots.
+ *   DA_ALLOC_AUTO / DA_ALLOC_MANUAL - initialises the hash table only.
+ */
 static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+	return __da_monitor_init_pool(DA_MON_POOL_SIZE);
+#else
 	return 0;
+#endif
 }
 
-static inline void da_monitor_destroy(void)
+static inline void da_monitor_destroy_pool(void)
+{
+	struct da_monitor_storage *ms;
+	struct hlist_node *tmp;
+	int bkt;
+
+	/*
+	 * Ensure all in-flight tracepoint handlers that may hold a raw pointer
+	 * to a pool slot (e.g. tlob_stop_task after its RCU guard exits) have
+	 * completed before we begin tearing down the pool.  Mirrors the same
+	 * call in da_monitor_destroy_kmalloc().
+	 */
+	tracepoint_synchronize_unregister();
+
+	/*
+	 * Drain any entries that were not stopped before destroy (e.g.
+	 * uprobe-started sessions whose stop probe never fired).  Call
+	 * da_extra_cleanup() before hash_del_rcu() so the hook may safely
+	 * call ha_cancel_timer_sync() while the monitor is still reachable.
+	 */
+	hash_for_each_safe(da_monitor_ht, bkt, tmp, ms, node) {
+		da_extra_cleanup(&ms->rv.da_mon);
+		hash_del_rcu(&ms->node);
+		call_rcu(&ms->rcu, da_pool_return_cb);
+	}
+
+	/*
+	 * rcu_barrier() drains every pending call_rcu() callback, including
+	 * both da_pool_return_cb() and any monitor-specific free callbacks
+	 * (e.g. tlob_free_rcu) enqueued by da_extra_cleanup().
+	 */
+	rcu_barrier();
+	kfree(da_pool.storage);
+	da_pool.storage = NULL;
+	kfree(da_pool.free);
+	da_pool.free = NULL;
+	da_pool.free_top = 0;
+	da_pool.capacity = 0;
+}
+
+static inline void da_monitor_destroy_kmalloc(void)
 {
 	struct da_monitor_storage *mon_storage;
 	struct hlist_node *tmp;
@@ -607,15 +797,51 @@ static inline void da_monitor_destroy(void)
 }
 
 /*
- * Allow the per-object monitors to run allocation manually, necessary if the
- * start condition is in a context problematic for allocation (e.g. scheduling).
- * In such case, if the storage was pre-allocated without a target, set it now.
+ * da_monitor_destroy - tear down the per-object monitor
+ *
+ * DA_ALLOC_POOL: calls tracepoint_synchronize_unregister() to drain any
+ * in-flight handlers, then iterates the hash draining remaining entries via
+ * da_extra_cleanup() + hash_del_rcu() + call_rcu(), then rcu_barrier() to
+ * wait for all pending da_pool_return_cb() callbacks before freeing the pool.
+ * DA_ALLOC_AUTO / DA_ALLOC_MANUAL: drains remaining entries after
+ * tracepoint_synchronize_unregister() + synchronize_rcu().
  */
-#ifdef DA_SKIP_AUTO_ALLOC
-#define da_prepare_storage da_fill_empty_storage
+static inline void da_monitor_destroy(void)
+{
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+	da_monitor_destroy_pool();
 #else
+	da_monitor_destroy_kmalloc();
+#endif
+}
+
+/*
+ * da_prepare_storage - obtain (or create) the da_monitor for (id, target)
+ *
+ * The implementation is selected at compile time by DA_MON_ALLOCATION_STRATEGY:
+ *
+ * DA_ALLOC_AUTO   - calls da_create_storage() (lock-free kmalloc_nolock).
+ * DA_ALLOC_POOL   - if an entry already exists, returns it; otherwise pops a
+ *                   slot from the pre-allocated pool and re-looks it up.
+ *                   Returns NULL if the pool is exhausted.
+ * DA_ALLOC_MANUAL - caller has already inserted storage via da_create_empty_storage();
+ *                   only fills in the target field if it was left NULL.
+ */
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+static inline struct da_monitor *da_prepare_storage(da_id_type id,
+						     monitor_target target,
+						     struct da_monitor *da_mon)
+{
+	if (da_mon)
+		return da_mon;
+	/* da_create_or_get_pool() returns the da_monitor directly; no re-lookup needed. */
+	return da_create_or_get_pool(id, target);
+}
+#elif DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_MANUAL
+#define da_prepare_storage da_fill_empty_storage
+#else /* DA_ALLOC_AUTO */
 #define da_prepare_storage da_create_storage
-#endif /* DA_SKIP_AUTO_ALLOC */
+#endif
 
 #endif /* RV_MON_TYPE */
 
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 8ead8783c29f..ac4d334e757f 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -17,8 +17,8 @@
 
 #define RV_MON_TYPE RV_MON_PER_OBJ
 #define HA_TIMER_TYPE HA_TIMER_WHEEL
-/* The start condition is on sched_switch, it's dangerous to allocate there */
-#define DA_SKIP_AUTO_ALLOC
+/* Allocate storage in sched_setscheduler; sched_switch is too hot to alloc. */
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
 typedef struct sched_dl_entity *monitor_target;
 #include "nomiss.h"
 #include <rv/ha_monitor.h>
@@ -214,7 +214,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	if (p->policy == SCHED_DEADLINE)
 		da_reset(EXPAND_ID_TASK(p));
 	else if (new_policy == SCHED_DEADLINE)
-		da_create_or_get(EXPAND_ID_TASK(p));
+		da_create_empty_storage(get_entity_id(&p->dl, task_cpu(p), DL_TASK));
 }
 
 static void handle_sched_wakeup(void *data, struct task_struct *tsk)
-- 
2.43.0

