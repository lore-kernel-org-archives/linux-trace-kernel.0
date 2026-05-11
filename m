Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708147D921
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523929; cv=none; b=ZuENfuO7tnvKHzN/YPwpRFTllnKj00cVWFLR3+PuyY60xgWg21nUDQM3QN9mcG3oDoH9htw1k/7Lh/L9Yxzbz0yzSvfSwmg/fCoksXDIGxmWblsaJsga7qR99mpHj2x8eOwVl9Eyvl8eUjd+AGZ8hZXFh9rPlkfPhfRPv5xDt0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523929; c=relaxed/simple;
	bh=v9qQ+smEFVXRv9Ckmq8lKzhougf8HNPeZpMZ9y1mzBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCu/srtizbZ/4myW+3oqOJG8dgZiNzOVr2SlQ0/RSJyWXjASPmsuS7wCQMkLG6DPXz5yDkoHQiyjjcb+1GM4SAcy5I1pUDJ/z134RbMU6GjFqz38kCDDU9yZrhWNF6SH74FJaOHVVr/8zsk7cb6ELl1rwByHAOWVRLvJQHObrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5lt11u9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5lt11u9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGSMUK6c+xA+ZoX0w0HHk4pXxa4vBX3tXNiW0TECRoE=;
	b=Z5lt11u9mdTA05Nr9sh5ybGIVkrI51+lGzzQJMYHNLuplG1TRIMM0KqEzkD97KHdOBMxbR
	hCyrn0VLA78ze2lvGIQf6OmrvDE84w5hImQ6UihrNp8DZJAbC/hruhM46M84MNO3GV4y4u
	Uzvfw1wK/i/KTPmdlWzoVzIT518DoMw=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 04/10] rv/da: add pre-allocated storage pool for per-object monitors
Date: Tue, 12 May 2026 02:24:50 +0800
Message-Id: <2774332570ee823be60cfe84ba85e9573b4df478.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
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

da_create_empty_storage() uses kmalloc_nolock(), which requires
CONFIG_HAVE_ALIGNED_STRUCT_PAGE; on UML and some PREEMPT_RT
configurations it always returns NULL.  Calling kmalloc from scheduler
tracepoint handlers also adds unwanted latency and can fail under
memory pressure.

Add da_monitor_init_prealloc(N) as an opt-in alternative to
da_monitor_init().  It allocates N da_monitor_storage slots with
GFP_KERNEL up-front and manages them on a LIFO free-stack protected
by a spinlock, so da_create_or_get() never calls kmalloc on the hot
path.

Monitors that do not call da_monitor_init_prealloc() are unaffected.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 208 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 186 insertions(+), 22 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index d04bb3229c75..7d6f62766251 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -433,18 +433,6 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
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
@@ -475,15 +463,121 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 	return mon_storage->target;
 }
 
+/*
+ * Per-object pool state.
+ *
+ * Zero-initialised by default (storage == NULL ⟹ kmalloc mode).  A monitor
+ * opts into pool mode by calling da_monitor_init_prealloc(N) instead of
+ * da_monitor_init(), which sets storage to a non-NULL kcalloc'd array.
+ *
+ * Because every field is wrapped in this struct and the struct itself is a
+ * per-TU static, each monitor that includes this header gets a completely
+ * independent pool.  A kmalloc monitor (e.g. nomiss) and a pool monitor
+ * (e.g. tlob) therefore coexist without any interference.
+ *
+ * da_pool_return_cb runs from softirq on non-PREEMPT_RT, so irqsave is
+ * required to prevent deadlock with task-context callers.  On PREEMPT_RT
+ * it runs from an rcuc kthread where spinlock_t is a sleeping lock.
+ */
+struct da_per_obj_pool {
+	struct da_monitor_storage  *storage;  /* non-NULL ⟹ pool mode */
+	struct da_monitor_storage **free;     /* kmalloc'd pointer stack */
+	unsigned int                free_top;
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
+	da_pool.free[da_pool.free_top++] = ms;
+	spin_unlock_irqrestore(&da_pool.lock, flags);
+}
+
+/* Pops a slot from the pre-allocated pool; returns -ENOSPC if exhausted. */
+static inline int da_create_or_get_pool(da_id_type id, monitor_target target)
+{
+	struct da_monitor_storage *mon_storage;
+	unsigned long flags;
+
+	spin_lock_irqsave(&da_pool.lock, flags);
+	if (!da_pool.free_top) {
+		spin_unlock_irqrestore(&da_pool.lock, flags);
+		return -ENOSPC;
+	}
+	mon_storage = da_pool.free[--da_pool.free_top];
+	spin_unlock_irqrestore(&da_pool.lock, flags);
+
+	mon_storage->id = id;
+	mon_storage->target = target;
+	guard(rcu)();
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	return 0;
+}
+
+/*
+ * Tries da_create_storage() first (lock-free via kmalloc_nolock); falls back
+ * to kmalloc(GFP_KERNEL).  Must be called from task context.
+ */
+static inline int da_create_or_get_kmalloc(da_id_type id, monitor_target target)
+{
+	struct da_monitor_storage *mon_storage;
+
+	scoped_guard(rcu) {
+		if (da_create_storage(id, target, da_get_monitor(id, target)))
+			return 0;
+	}
+
+	/*
+	 * da_create_storage() failed because kmalloc_nolock() returned NULL.
+	 * Allocate with GFP_KERNEL outside the RCU read section: GFP_KERNEL
+	 * may sleep for memory reclaim, which is illegal while the RCU read
+	 * lock is held (preemption disabled on !PREEMPT_RT).
+	 */
+	mon_storage = kmalloc_obj(*mon_storage, GFP_KERNEL | __GFP_ZERO);
+	if (!mon_storage)
+		return -ENOMEM;
+	mon_storage->id = id;
+	mon_storage->target = target;
+
+	/*
+	 * Re-check for a concurrent insertion before linking: another
+	 * caller may have succeeded while we slept in kmalloc().
+	 * Discard our allocation and let the winner's entry stand.
+	 */
+	scoped_guard(rcu) {
+		if (da_get_monitor(id, target)) {
+			kfree(mon_storage);
+			return 0;
+		}
+		hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	}
+	return 0;
+}
+
+/* Create the per-object storage if not already there. */
+static inline int da_create_or_get(da_id_type id, monitor_target target)
+{
+	if (da_pool.storage)
+		return da_create_or_get_pool(id, target);
+	return da_create_or_get_kmalloc(id, target);
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
@@ -491,15 +585,17 @@ static inline void da_destroy_storage(da_id_type id)
 
 	guard(rcu)();
 	mon_storage = __da_get_mon_storage(id);
-
 	if (!mon_storage)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
-	kfree_rcu(mon_storage, rcu);
+	if (da_pool.storage)
+		call_rcu(&mon_storage->rcu, da_pool_return_cb);
+	else
+		kfree_rcu(mon_storage, rcu);
 }
 
-static void da_monitor_reset_all(void)
+static __maybe_unused void da_monitor_reset_all(void)
 {
 	struct da_monitor_storage *mon_storage;
 	int bkt;
@@ -510,13 +606,65 @@ static void da_monitor_reset_all(void)
 	rcu_read_unlock();
 }
 
+/*
+ * da_monitor_init_prealloc - initialise with a pre-allocated storage pool
+ *
+ * Allocates @prealloc_count storage slots up-front so that da_create_or_get()
+ * and da_destroy_storage() never call kmalloc/kfree.  Must be called instead
+ * of da_monitor_init() for monitors that require pool mode.
+ */
+static inline int da_monitor_init_prealloc(unsigned int prealloc_count)
+{
+	hash_init(da_monitor_ht);
+
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
+	da_pool.free_top = 0;
+	for (unsigned int i = 0; i < prealloc_count; i++)
+		da_pool.free[da_pool.free_top++] = &da_pool.storage[i];
+	return 0;
+}
+
+/*
+ * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
+ */
 static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
 	return 0;
 }
 
-static inline void da_monitor_destroy(void)
+static inline void da_monitor_destroy_pool(void)
+{
+	WARN_ON_ONCE(!hash_empty(da_monitor_ht));
+	/*
+	 * Wait for all in-flight da_pool_return_cb() callbacks to
+	 * complete before freeing da_pool.free.  synchronize_rcu() is
+	 * not sufficient: it only waits for callbacks registered before
+	 * it was called, but call_rcu() from concurrent da_destroy_storage()
+	 * calls may have been enqueued later.  rcu_barrier() drains every
+	 * pending callback.
+	 */
+	rcu_barrier();
+	kfree(da_pool.storage);
+	da_pool.storage = NULL;
+	kfree(da_pool.free);
+	da_pool.free = NULL;
+	da_pool.free_top = 0;
+}
+
+static inline void da_monitor_destroy_kmalloc(void)
 {
 	struct da_monitor_storage *mon_storage;
 	struct hlist_node *tmp;
@@ -534,6 +682,22 @@ static inline void da_monitor_destroy(void)
 	}
 }
 
+/*
+ * da_monitor_destroy - tear down the per-object monitor
+ *
+ * Pool mode: the hash must already be empty (caller must have drained all
+ * tasks first); calls rcu_barrier() to drain all pending da_pool_return_cb()
+ * callbacks before freeing pool arrays.
+ * Kmalloc mode: drains any remaining entries after synchronize_rcu().
+ */
+static inline void da_monitor_destroy(void)
+{
+	if (da_pool.storage)
+		da_monitor_destroy_pool();
+	else
+		da_monitor_destroy_kmalloc();
+}
+
 /*
  * Allow the per-object monitors to run allocation manually, necessary if the
  * start condition is in a context problematic for allocation (e.g. scheduling).
-- 
2.25.1

