Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E3F12C8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525156; cv=none; b=A/x1BtnpBne7efjgfZeATJBY4WhVVLJ9DqgYoMDcryucEpAjT2FmCt1ldKf70YzHMTBHA/J1hM8JF3Kr2lXKye+pq+7yVF1W+Y+KiQedQ81W07D1w8Jk0JXL+6JpbIBtn4qD+WdFhHMMeTNj/z8S4VGufZZmddBCwLQJ4u0J3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525156; c=relaxed/simple;
	bh=vT28XGtOuxNLckjv4Iugxa7Q/eDOR6dpNoyDJ2d5mgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWGnwv3MqTXuLl+S9xbQMKLrrDXOEcqTEabsM+hD05IZj1fiFFyGMHj+92k/BuW++SyqYKo5wFJeQqGpLzFRVc8UThmdgd0/zu5AAoWF9xe+eBLXqwt/O3+/GgO+f9gPrCXcCzNdlOmG1OE6GkXAcRU3DbsHsANWCSpbDfBJBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PP4P1aVV; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PP4P1aVV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W23cILXEhbaTC3LZPNeIfbFSZCRVq791q8j4d9G1B+8=;
	b=PP4P1aVVb/GHZc4/FnsOSjRvuNISetbpQGfS9c0Vjj4w//lJMk0KJb11edXdjsrFHzffOv
	QG0uW06TcPuAaiusGjzRdJEA90gDtQbuNAClOZPlMSmaRKnOAA54+gT7CrhBfCwdJqLxvg
	4i0TOCLA69tGoRgpElyO0boD0NYKz84=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 1/8] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
Date: Wed,  8 Jul 2026 23:38:27 +0800
Message-Id: <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Per-object DA storage allocation is currently limited to kmalloc on
demand. Add a compile-time selector so monitors can choose among three
strategies:

  DA_ALLOC_AUTO   (default) - kmalloc per object on the monitor path
  DA_ALLOC_POOL             - pre-allocated fixed-size llist pool;
                              selected by defining DA_MON_POOL_SIZE
  DA_ALLOC_MANUAL           - caller pre-inserts storage; framework
                              only links the target field

The pool strategy uses a lock-free llist (cmpxchg, no spinlock) so
pool release is safe from RCU callback context without acquiring a
lock. Moving allocation before the measurement window also prevents
kmalloc latency.

nomiss is updated to DA_ALLOC_MANUAL.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h                  | 247 +++++++++++++++++++----
 include/rv/ha_monitor.h                  |   6 +
 kernel/trace/rv/monitors/nomiss/nomiss.c |   6 +-
 3 files changed, 221 insertions(+), 38 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ecd4..9c9acc123e3b 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,7 +14,56 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
+/*
+ * Allocation strategies for RV_MON_PER_OBJ monitors.
+ *
+ * Select the strategy with a single define before including this header:
+ *
+ *   #define DA_MON_POOL_SIZE N          - pool mode; N pre-allocated slots.
+ *                                         Implies DA_ALLOC_POOL automatically.
+ *   #define DA_MON_ALLOCATION_STRATEGY \
+ *           DA_ALLOC_MANUAL             - manual mode (see below).
+ *   (neither)                           - auto mode (default).
+ *
+ * Do not define both DA_MON_POOL_SIZE and DA_MON_ALLOCATION_STRATEGY.
+ *
+ * DA_ALLOC_AUTO   - lock-free kmalloc on the hot path; unbounded capacity.
+ * DA_ALLOC_POOL   - pre-allocated fixed-size pool; set by defining DA_MON_POOL_SIZE.
+ * DA_ALLOC_MANUAL - caller inserts storage before da_handle_start_event();
+ *                   the framework only links the target field.
+ */
+#define DA_ALLOC_AUTO   0
+#define DA_ALLOC_POOL   1
+#define DA_ALLOC_MANUAL 2
+
+#ifdef DA_MON_POOL_SIZE
+#ifdef DA_MON_ALLOCATION_STRATEGY
+#error "Define only one of DA_MON_POOL_SIZE or DA_MON_ALLOCATION_STRATEGY"
+#endif
+#if DA_MON_POOL_SIZE == 0
+#error "DA_MON_POOL_SIZE must be non-zero"
+#endif
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
+#endif
+
+#ifndef DA_MON_ALLOCATION_STRATEGY
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
+#endif
+
+/*
+ * Provide a zero default so da_monitor_init() can reference
+ * DA_MON_POOL_SIZE in a plain C if() without an #if guard; the
+ * compiler eliminates the dead branch.
+ */
+#ifndef DA_MON_POOL_SIZE
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined and non-zero"
+#endif
+#define DA_MON_POOL_SIZE 0
+#endif
+
 #include <rv/automata.h>
+#include <linux/llist.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
@@ -66,6 +115,16 @@ static struct rv_monitor rv_this;
 #define da_monitor_sync_hook()
 #endif
 
+/*
+ * Per-object teardown hook, called after da_monitor_reset_all() +
+ * da_monitor_sync_hook() and before hash_del_rcu() for each entry.
+ * All HA timer callbacks have completed at this point.
+ * Define before including this header.  Default: no-op.
+ */
+#ifndef da_extra_cleanup
+#define da_extra_cleanup(da_mon)
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  * A long type can work as hash table key (PER_OBJ) but will be downgraded to
@@ -404,6 +463,12 @@ struct da_monitor_storage {
 	union rv_task_monitor rv;
 	struct hlist_node node;
 	struct rcu_head rcu;
+	/*
+	 * Mutually exclusive with rcu: rcu is live during the RCU callback
+	 * flight; free_node when the slot is in da_pool_free_list.
+	 * Present in all monitors to avoid #if-gating the pool helpers.
+	 */
+	struct llist_node free_node;
 };
 
 #ifndef DA_MONITOR_HT_BITS
@@ -495,18 +560,6 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
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
@@ -537,15 +590,79 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 	return mon_storage->target;
 }
 
+/*
+ * Lock-free llist (cmpxchg) rather than kmem_cache/mempool: on
+ * PREEMPT_RT spinlock_t becomes a sleeping lock, which is forbidden
+ * in the rcuc kthread context where RCU callbacks run.
+ *
+ * Multiple producers (any context, any CPU) call llist_add; a single
+ * consumer (llist_del_first, serialised by the monitor's start lock)
+ * needs no additional synchronisation.
+ *
+ * Per-TU statics: each PER_OBJ monitor gets its own pool instance;
+ * da_pool_storage and da_pool_free_list are NULL/empty and the pool
+ * paths are dead code for non-pool monitors.
+ */
+static struct da_monitor_storage *da_pool_storage;
+static LLIST_HEAD(da_pool_free_list);
+
+static void da_pool_return_cb(struct rcu_head *head)
+{
+	struct da_monitor_storage *ms =
+		container_of(head, struct da_monitor_storage, rcu);
+
+	llist_add(&ms->free_node, &da_pool_free_list);
+}
+
+/*
+ * da_create_pool_storage - pop a free pool slot and insert it into the hash.
+ *
+ * Returns the new da_monitor, or NULL if the pool is exhausted.  Finding
+ * an existing entry for the same id fires WARN_ON_ONCE (double-start bug).
+ *
+ * Caller must hold an RCU read-side CS and the monitor's serialisation lock.
+ */
+static inline struct da_monitor *
+da_create_pool_storage(da_id_type id, monitor_target target,
+		       struct da_monitor *da_mon)
+{
+	struct da_monitor_storage *mon_storage, *existing;
+	struct llist_node *node;
+
+	if (da_mon)
+		return da_mon;
+
+	node = llist_del_first(&da_pool_free_list);
+	if (!node)
+		return NULL;
+	mon_storage = llist_entry(node, struct da_monitor_storage, free_node);
+
+	mon_storage->id = id;
+	mon_storage->target = target;
+
+	/*
+	 * The caller's serialization lock ensures llist_del_first() is
+	 * single-consumer, so no concurrent start for the same id is possible.
+	 * Reaching here indicates a programming error (double-start for the
+	 * same pid).
+	 */
+	existing = __da_get_mon_storage(id);
+	if (WARN_ON_ONCE(existing)) {
+		llist_add(&mon_storage->free_node, &da_pool_free_list);
+		return NULL;
+	}
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	return &mon_storage->rv.da_mon;
+}
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
@@ -558,7 +675,10 @@ static inline void da_destroy_storage(da_id_type id)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
-	kfree_rcu(mon_storage, rcu);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+		call_rcu(&mon_storage->rcu, da_pool_return_cb);
+	else
+		kfree_rcu(mon_storage, rcu);
 }
 
 static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
@@ -581,41 +701,98 @@ static inline void da_monitor_reset_state_all(void)
 	__da_monitor_reset_all(da_monitor_reset_state);
 }
 
+/* Not part of the public API; called only by da_monitor_init(). */
+static inline int __da_monitor_init_pool(unsigned int prealloc_count)
+{
+	unsigned int i;
+
+	da_pool_storage = kcalloc(prealloc_count, sizeof(*da_pool_storage),
+				  GFP_KERNEL);
+	if (!da_pool_storage)
+		return -ENOMEM;
+
+	for (i = 0; i < prealloc_count; i++)
+		llist_add(&da_pool_storage[i].free_node, &da_pool_free_list);
+	return 0;
+}
+
+/*
+ * da_monitor_init - initialise the per-object monitor
+ */
 static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+		return __da_monitor_init_pool(DA_MON_POOL_SIZE);
 	return 0;
 }
 
+/*
+ * da_monitor_destroy - tear down the per-object monitor
+ *
+ * tracepoint_synchronize_unregister() flushes all in-flight tracepoint
+ * handlers and performs synchronize_rcu(), so no RCU reader holds a
+ * reference to any da_monitor_storage after it returns.
+ * da_monitor_reset_all() disables monitoring; combined with
+ * da_monitor_sync_hook() (synchronize_rcu() for HA), no timer callback
+ * can fire or be re-armed after this sequence.
+ *
+ * Pool mode: remaining hash entries are returned to the free list
+ * directly (no call_rcu needed -- see above).  rcu_barrier() drains any
+ * da_pool_return_cb() callbacks queued by earlier da_destroy_storage()
+ * calls before the backing array is freed.
+ */
 static inline void da_monitor_destroy(void)
 {
-	struct da_monitor_storage *mon_storage;
+	struct da_monitor_storage *ms;
 	struct hlist_node *tmp;
 	int bkt;
 
 	tracepoint_synchronize_unregister();
 	da_monitor_reset_all();
 	da_monitor_sync_hook();
-	/*
-	 * This function is called after all probes are disabled and no longer
-	 * pending, we can safely assume no concurrent user.
-	 */
-	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
-		hash_del_rcu(&mon_storage->node);
-		kfree(mon_storage);
+
+	hash_for_each_safe(da_monitor_ht, bkt, tmp, ms, node) {
+		da_extra_cleanup(&ms->rv.da_mon);
+		hash_del_rcu(&ms->node);
+		/* No RCU readers remain; skip the grace period. */
+		if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL) {
+			llist_add(&ms->free_node, &da_pool_free_list);
+		} else {
+			kfree(ms);
+		}
+	}
+
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL) {
+		/*
+		 * Flush any da_pool_return_cb callbacks queued by
+		 * da_destroy_storage() during normal monitor operation.
+		 * After rcu_barrier(), no callback can reference pool slots;
+		 * the backing array is safe to free.
+		 */
+		rcu_barrier();
+		init_llist_head(&da_pool_free_list);
+		kfree(da_pool_storage);
+		da_pool_storage = NULL;
 	}
 }
 
 /*
- * Allow the per-object monitors to run allocation manually, necessary if the
- * start condition is in a context problematic for allocation (e.g. scheduling).
- * In such case, if the storage was pre-allocated without a target, set it now.
+ * da_prepare_storage - allocate or retrieve storage for a monitoring session
+ *
+ * Dispatches to the strategy selected by DA_MON_ALLOCATION_STRATEGY.
+ * Caller must hold an RCU read-side CS.
  */
-#ifdef DA_SKIP_AUTO_ALLOC
-#define da_prepare_storage da_fill_empty_storage
-#else
-#define da_prepare_storage da_create_storage
-#endif /* DA_SKIP_AUTO_ALLOC */
+static inline struct da_monitor *
+da_prepare_storage(da_id_type id, monitor_target target,
+		   struct da_monitor *da_mon)
+{
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+		return da_create_pool_storage(id, target, da_mon);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_MANUAL)
+		return da_fill_empty_storage(id, target, da_mon);
+	return da_create_storage(id, target, da_mon);
+}
 
 #endif /* RV_MON_TYPE */
 
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 28d3c74cabfc..83199f90afe8 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -365,6 +365,12 @@ static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
 }
 /*
  * ha_invariant_passed_ns - prepare the invariant and return the time since reset
+ *
+ * If the env has not been initialised yet (first entry into a state with an
+ * invariant), anchor the guard clock at the current time so that the full
+ * budget is available from this point.  This preserves the documented
+ * guard->invariant ordering: ha_set_invariant_ns() is always preceded by a
+ * valid guard representation in env_store.
  */
 static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum envs env,
 				   u64 expire, u64 time_ns)
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
2.25.1

