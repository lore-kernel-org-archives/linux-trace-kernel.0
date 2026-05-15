Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEB402B83
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833831; cv=none; b=Lud42bIP+12MOnfTzozNR+MYYNXSwDX90M4SwISNCRsQbFVNZgf+lUCeCu5HEI5Zm+2tYaA2IxXW8a4DT0SUrM6XlmrZE/aUDQSnnAIyjx+u/txbl+dpC88mlFRVzlRlsSVMTbQ2ohcUzBg4vVZ8UReHxdG3IUWzQe8Qy09b2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833831; c=relaxed/simple;
	bh=df22niSE+THCCoY+rlUyp8pVhOJnfRPZq0XyJUJjvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ/M8rXlRrH/mrlwu13IqecM95EPshZ+DqxmJB7e5elQQUUOizRDy+Ifb1NlZA15W7DB7Ufh8ek14/pKnba1cDEtxus/9Pc+xPyquf/wCvl725ThXlcyMsZlzK/8fIvRttxPklJ7wruUbDJQ4Sk4FUuIItUVwtq6ADFq9vt159k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfEJEle9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfEJEle9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uWXiaG5p91f6+eow4XXrY6+ykRe+MZboUhmhyTi6Og=;
	b=CfEJEle94dlZIxMmLa+IHVESIW2DXuuwDLtPkWb1NRvm3UmzD6KeNQWQbQBw02T0gVE6EX
	8XbUlqNAOmOti5iASjXIMKASJOJ0bECu3glAYdMx9FndiJ4xOdU9Y+mBqy5cqBW4pWUXU5
	/7tvXNmkKIzLjNJ1oswOEdDArRp9TZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-SPFTuY-xPhiq97_FlMbpgw-1; Fri,
 15 May 2026 04:30:26 -0400
X-MC-Unique: SPFTuY-xPhiq97_FlMbpgw-1
X-Mimecast-MFC-AGG-ID: SPFTuY-xPhiq97_FlMbpgw_1778833825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FFB81800359;
	Fri, 15 May 2026 08:30:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E50BF1956053;
	Fri, 15 May 2026 08:30:22 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] Re: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated storage pool for per-object monitors
Date: Fri, 15 May 2026 10:30:01 +0200
Message-ID: <20260515083002.106512-1-gmonaco@redhat.com>
In-Reply-To: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
References: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Jw3ILJkiNMCpJ_7Xh-PVI0yn9SrOWR0IWyc4H_QAYQ8_1778833825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

So this is what I meant. It's quick and dirty but seems to work as far
as I could test it.

I didn't change too much around to avoid confusing more, but it probably
needs a refactor for the functions positions and names. Some AI can do
that later after we agree on how it should look.

The main idea is (using current function names):

da_handle_start_[run_]_event() calls da_prepare_storage(), this
makes sure the storage is there and usable based on the strategy:
1. da_create_storage() plain allocation with kmalloc_nolock
2. da_create_or_get_pool() get a slot from the pool
3. da_fill_empty_storage() only set the target in a storage manually
   allocated before

The reason why you'd need 3. is that since da_handle_start_event() is
called from a tracepoint, you may in no way be able to allocate from
there, then you use manually somewhere else with
da_create_empty_storage() if you don't have the target and
da_create_or_get() if you do (this one is misleading, we should probably
simplify further).

The newly created 2. might be useful if you aren't on preempt-rt and
cannot sleep but also don't want a manual allocation (beware of lock
dependencies, it doesn't always work).

Now, I left your da_create_or_get_kmalloc() unwired because I don't
really see the use case (you use kmalloc_nolock because you cannot lock,
so if it fails you don't try a kmalloc). But if we really want to offer
a possibility to allocate with GFP_KERNEL, we can make 1. more
configurable.

Does this make sense to you?

Thanks,
Gabriele

---
 include/rv/da_monitor.h                  | 160 ++++++++++-------------
 kernel/trace/rv/monitors/nomiss/nomiss.c |   2 +-
 kernel/trace/rv/monitors/tlob/tlob.c     |  15 +--
 3 files changed, 74 insertions(+), 103 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 74aa95d9a284..3b4a36245531 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
+#include <linux/mempool.h>
 
 /*
  * Per-cpu variables require a unique name although static in some
@@ -67,6 +68,35 @@ static struct rv_monitor rv_this;
 #define da_id_type int
 #endif
 
+#define DA_ALLOC_AUTO 0
+#define DA_ALLOC_POOL 1
+#define DA_ALLOC_MANUAL 2
+
+/*
+ * Allow the per-object monitors to run allocation manually, necessary if the
+ * start condition is in a context problematic for allocation (e.g. scheduling).
+ * In such case, if the storage was pre-allocated without a target, set it now.
+ */
+#ifndef DA_MON_ALLOCATION_STRATEGY
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
+#endif
+#ifndef DA_MON_POOL_SIZE
+#define DA_MON_POOL_SIZE 0
+#endif
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_MANUAL
+#define da_prepare_storage da_fill_empty_storage
+
+#elif DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+#define da_prepare_storage da_create_or_get_pool
+#if DA_MON_POOL_SIZE == 0
+#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be non-zero"
+#endif
+
+#else
+#define da_prepare_storage da_create_storage
+#endif /* DA_MON_ALLOCATION_STRATEGY */
+
+
 static void react(enum states curr_state, enum events event)
 {
 	rv_react(&rv_this,
@@ -448,62 +478,38 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 }
 
 /*
- * Per-object pool state.
- *
- * Zero-initialised by default (storage == NULL ⟹ kmalloc mode).  A monitor
- * opts into pool mode by calling da_monitor_init_prealloc(N) instead of
- * da_monitor_init(), which sets storage to a non-NULL kcalloc'd array.
- *
- * Because every field is wrapped in this struct and the struct itself is a
- * per-TU static, each monitor that includes this header gets a completely
- * independent pool.  A kmalloc monitor (e.g. nomiss) and a pool monitor
- * (e.g. tlob) therefore coexist without any interference.
- *
- * da_pool_return_cb runs from softirq on non-PREEMPT_RT, so irqsave is
- * required to prevent deadlock with task-context callers.  On PREEMPT_RT
- * it runs from an rcuc kthread where spinlock_t is a sleeping lock.
- */
-struct da_per_obj_pool {
-	struct da_monitor_storage  *storage;  /* non-NULL ⟹ pool mode */
-	struct da_monitor_storage **free;     /* kmalloc'd pointer stack */
-	unsigned int                free_top;
-	spinlock_t                  lock;
-};
-
-static struct da_per_obj_pool da_pool = {
-	.lock = __SPIN_LOCK_UNLOCKED(da_pool.lock),
-};
+ * Per-object pool state using kmem_cache and mempool.
+ */
+static struct kmem_cache *da_mon_cache;
+static mempool_t *da_mon_pool;
 
 static void da_pool_return_cb(struct rcu_head *head)
 {
 	struct da_monitor_storage *ms =
 		container_of(head, struct da_monitor_storage, rcu);
-	unsigned long flags;
-
-	spin_lock_irqsave(&da_pool.lock, flags);
-	da_pool.free[da_pool.free_top++] = ms;
-	spin_unlock_irqrestore(&da_pool.lock, flags);
+	mempool_free(ms, da_mon_pool);
 }
 
-/* Pops a slot from the pre-allocated pool; returns -ENOSPC if exhausted. */
-static inline int da_create_or_get_pool(da_id_type id, monitor_target target)
+/* Pops a slot from the pre-allocated pool; returns NULL if exhausted. */
+static inline struct da_monitor *da_create_or_get_pool(da_id_type id,
+						       monitor_target target,
+						       struct da_monitor *da_mon)
 {
 	struct da_monitor_storage *mon_storage;
-	unsigned long flags;
 
-	spin_lock_irqsave(&da_pool.lock, flags);
-	if (!da_pool.free_top) {
-		spin_unlock_irqrestore(&da_pool.lock, flags);
-		return -ENOSPC;
-	}
-	mon_storage = da_pool.free[--da_pool.free_top];
-	spin_unlock_irqrestore(&da_pool.lock, flags);
+	if (da_mon)
+		return da_mon;
 
+	mon_storage = mempool_alloc_preallocated(da_mon_pool);
+	if (!mon_storage)
+		return NULL;
+
+	memset(mon_storage, 0, sizeof(*mon_storage));
 	mon_storage->id = id;
 	mon_storage->target = target;
 	guard(rcu)();
 	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
-	return 0;
+	return &mon_storage->rv.da_mon;
 }
 
 /*
@@ -547,11 +553,12 @@ static inline int da_create_or_get_kmalloc(da_id_type id, monitor_target target)
 }
 
 /* Create the per-object storage if not already there. */
-static inline int da_create_or_get(da_id_type id, monitor_target target)
+// NOTE: this is only needed for manual allocation!
+// we can refactor to have it only defined there, leaving it for now
+static inline void da_create_or_get(da_id_type id, monitor_target target)
 {
-	if (da_pool.storage)
-		return da_create_or_get_pool(id, target);
-	return da_create_or_get_kmalloc(id, target);
+	guard(rcu)();
+	da_create_storage(id, target, da_get_monitor(id, target));
 }
 
 /*
@@ -573,7 +580,7 @@ static inline void da_destroy_storage(da_id_type id)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
-	if (da_pool.storage)
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
 		call_rcu(&mon_storage->rcu, da_pool_return_cb);
 	else
 		kfree_rcu(mon_storage, rcu);
@@ -591,41 +598,26 @@ static __maybe_unused void da_monitor_reset_all(void)
 }
 
 /*
- * da_monitor_init_prealloc - initialise with a pre-allocated storage pool
- *
- * Allocates @prealloc_count storage slots up-front so that da_create_or_get()
- * and da_destroy_storage() never call kmalloc/kfree.  Must be called instead
- * of da_monitor_init() for monitors that require pool mode.
+ * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
  */
-static inline int da_monitor_init_prealloc(unsigned int prealloc_count)
+static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
+	if (DA_MON_ALLOCATION_STRATEGY != DA_ALLOC_POOL)
+		return 0;
 
-	da_pool.storage = kcalloc(prealloc_count, sizeof(*da_pool.storage),
-				  GFP_KERNEL);
-	if (!da_pool.storage)
+	da_mon_cache = kmem_cache_create(__stringify(DA_MON_NAME) "_cache",
+					 sizeof(struct da_monitor_storage),
+					 0, 0, NULL);
+	if (!da_mon_cache)
 		return -ENOMEM;
 
-	da_pool.free = kmalloc_array(prealloc_count, sizeof(*da_pool.free),
-				     GFP_KERNEL);
-	if (!da_pool.free) {
-		kfree(da_pool.storage);
-		da_pool.storage = NULL;
+	da_mon_pool = mempool_create_slab_pool(DA_MON_POOL_SIZE, da_mon_cache);
+	if (!da_mon_pool) {
+		kmem_cache_destroy(da_mon_cache);
+		da_mon_cache = NULL;
 		return -ENOMEM;
 	}
-
-	da_pool.free_top = 0;
-	for (unsigned int i = 0; i < prealloc_count; i++)
-		da_pool.free[da_pool.free_top++] = &da_pool.storage[i];
-	return 0;
-}
-
-/*
- * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
- */
-static inline int da_monitor_init(void)
-{
-	hash_init(da_monitor_ht);
 	return 0;
 }
 
@@ -641,11 +633,10 @@ static inline void da_monitor_destroy_pool(void)
 	 * pending callback.
 	 */
 	rcu_barrier();
-	kfree(da_pool.storage);
-	da_pool.storage = NULL;
-	kfree(da_pool.free);
-	da_pool.free = NULL;
-	da_pool.free_top = 0;
+	mempool_destroy(da_mon_pool);
+	da_mon_pool = NULL;
+	kmem_cache_destroy(da_mon_cache);
+	da_mon_cache = NULL;
 }
 
 static inline void da_monitor_destroy_kmalloc(void)
@@ -676,23 +667,12 @@ static inline void da_monitor_destroy_kmalloc(void)
  */
 static inline void da_monitor_destroy(void)
 {
-	if (da_pool.storage)
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
 		da_monitor_destroy_pool();
 	else
 		da_monitor_destroy_kmalloc();
 }
 
-/*
- * Allow the per-object monitors to run allocation manually, necessary if the
- * start condition is in a context problematic for allocation (e.g. scheduling).
- * In such case, if the storage was pre-allocated without a target, set it now.
- */
-#ifdef DA_SKIP_AUTO_ALLOC
-#define da_prepare_storage da_fill_empty_storage
-#else
-#define da_prepare_storage da_create_storage
-#endif /* DA_SKIP_AUTO_ALLOC */
-
 #endif /* RV_MON_TYPE */
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 31f90f3638d8..f089cc0e2f10 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -18,7 +18,7 @@
 #define RV_MON_TYPE RV_MON_PER_OBJ
 #define HA_TIMER_TYPE HA_TIMER_WHEEL
 /* The start condition is on sched_switch, it's dangerous to allocate there */
-#define DA_SKIP_AUTO_ALLOC
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
 typedef struct sched_dl_entity *monitor_target;
 #include "nomiss.h"
 #include <rv/ha_monitor.h>
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
index 90e7035a0b55..486a6bac5cf9 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -88,8 +88,8 @@ struct tlob_task_state {
 
 #define RV_MON_TYPE RV_MON_PER_OBJ
 #define HA_TIMER_TYPE HA_TIMER_HRTIMER
-/* Pool mode: da_handle_start_event uses da_fill_empty_storage, not kmalloc. */
-#define DA_SKIP_AUTO_ALLOC
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
+#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
 
 /* Type for da_monitor_storage.target; must be defined before the includes. */
 typedef struct tlob_task_state *monitor_target;
@@ -428,7 +428,6 @@ int tlob_start_task(struct task_struct *task, u64 threshold_us)
 	struct da_monitor *da_mon;
 	struct ha_monitor *ha_mon;
 	u64 now_ns;
-	int ret;
 
 	if (!da_monitor_enabled())
 		return -ENODEV;
@@ -457,14 +456,6 @@ int tlob_start_task(struct task_struct *task, u64 threshold_us)
 	ws->last_ts = ktime_get();
 	raw_spin_lock_init(&ws->entry_lock);
 
-	/* Claim a pool slot (no kmalloc; DA_SKIP_AUTO_ALLOC + prealloc). */
-	ret = da_create_or_get(task->pid, ws);
-	if (ret) {
-		put_task_struct(task);
-		kmem_cache_free(tlob_state_cache, ws);
-		return ret;
-	}
-
 	atomic_inc(&tlob_num_monitored);
 
 	/* Hold RCU across handle + timer setup to keep da_mon valid. */
@@ -955,7 +946,7 @@ static int __tlob_init_monitor(void)
 
 	atomic_set(&tlob_num_monitored, 0);
 
-	retval = da_monitor_init_prealloc(TLOB_MAX_MONITORED);
+	retval = da_monitor_init();
 	if (retval) {
 		kmem_cache_destroy(tlob_state_cache);
 		tlob_state_cache = NULL;

-- 
2.54.0

