Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36921442B2E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244344; cv=none; b=QnY5+ylHmhwMXale5M0IpYm6CxxLy/wQLU2vhnisdvrAMa7fv35d+IqIsMeBbY58ecKsfYacvyxX6y0udu/X4bfDlPQglYmKipMrgGy2ZnSXpMy8Ew7JfkdE5YsUdiG2w3Vfu2exeOO+ou6+PuaNvqK0+S/ReDw/xzJ4J1oAM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244344; c=relaxed/simple;
	bh=6P9I1aZhDUELupD+I2V0VefODFPX+knAPfI2Y6dKtXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYhy0IOQLYJTOr7hSkHfSF66S2F6oz9pQXivMtEr8qZwjcdOlSJXCwP05Ghu7Kfa97ITzGiP/ZQnzC+nBnAC7ULfo8qc5x2RbQQH+TWajcM720Hc98itezpFzf2ObDXArqGfds9bdeGIfzcbHHt3tdi3IMVC3zOCenShiIjPTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SwgSBo7k; arc=none smtp.client-ip=91.218.175.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SwgSBo7k"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6P9I1aZhDUELupD+I2V0VefODFPX+knAPfI2Y6dKtXA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244339; v=1; x=1787849139;
 b=SwgSBo7kHV9zmJPMMndiqmeXRrXu2qOKdBEaPAj07Mxd+89xt3wvsj5Yc9IITwirLm1CQ3Gk
 paG8eYlySaZaWUzlm5Vcz50nXmfWLunLpj3W9XfxxKFqEwLvCn7L7CKLDiX6QuRX6QIHvdlOuG9
 AnZN8zcaq8+/JrbWsTyJjNu0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 9b34e09240fbd18a;
	Thu, 20 Aug 2026 16:45:38 +0000
X-Mizu-Trace-ID: 9b34e09240fbd18a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 1/9] rv: Introduce DA_MON_ALLOCATION_STRATEGY
Date: Fri, 21 Aug 2026 00:45:10 +0800
Message-Id: <30a9acb1cd8a634aed04b28701ff29837ec2f124.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Per-object DA storage allocation is currently limited to kmalloc on
demand. Add a compile-time selector so monitors can choose among three
strategies:

  DA_ALLOC_AUTO   (default) - kmalloc per object on the monitor path
  DA_ALLOC_POOL             - pre-allocated fixed-size mempool;
                              selected by defining DA_MON_POOL_SIZE
  DA_ALLOC_MANUAL           - caller pre-inserts storage; framework
                              only links the target field

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 152 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 10 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index e3cf85c9ce55..9e84f53b81cb 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,7 +14,54 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
+/*
+ * Allocation strategies for RV_MON_PER_OBJ monitors, selected by defining
+ * one of the following before including this header (never both):
+ *
+ *   DA_MON_POOL_SIZE N           - pool mode, N pre-allocated slots
+ *   DA_MON_ALLOCATION_STRATEGY   - explicit strategy (see below)
+ *   (neither)                    - auto mode (default)
+ *
+ * DA_ALLOC_AUTO   - kmalloc on demand; unbounded.
+ * DA_ALLOC_POOL   - pre-allocated fixed-size pool; capped at DA_MON_POOL_SIZE
+ *                   entries.  Uses mempool_alloc_preallocated() (spinlock_t);
+ *                   the start-event handler must run in task context.
+ *                   Other event handlers may run in any context as they use
+ *                   da_handle_event() and never allocate new storage.
+ * DA_ALLOC_MANUAL - caller pre-inserts storage; framework links the target.
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
+#endif /* DA_MON_POOL_SIZE */
+
+#ifndef DA_MON_ALLOCATION_STRATEGY
+#ifdef DA_SKIP_AUTO_ALLOC
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
+#else
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
+#endif
+#endif /* DA_MON_ALLOCATION_STRATEGY */
+
+/* Zero default keeps pool-mode conditionals compile-time constant. */
+#ifndef DA_MON_POOL_SIZE
+#if DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL
+#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined and non-zero"
+#endif
+#define DA_MON_POOL_SIZE 0
+#endif /* DA_MON_POOL_SIZE */
+
 #include <rv/automata.h>
+#include <linux/mempool.h>
 #include <linux/rv.h>
 #include <rv/kunit.h>
 #include <linux/stringify.h>
@@ -67,6 +114,16 @@ static struct rv_monitor rv_this;
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
@@ -543,6 +600,59 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 	return mon_storage->target;
 }
 
+/*
+ * Pre-allocated mempool for DA_ALLOC_POOL monitors: DA_MON_POOL_SIZE
+ * slots, eager-allocated at init.  mempool_alloc_preallocated() pops a
+ * slot without touching the allocator (bounded start latency; NULL when
+ * exhausted).  mempool_free() is safe from RCU-callback context.
+ * Non-pool monitors get a zero-initialised mempool_t; pool paths compile
+ * away.
+ */
+static mempool_t da_monitor_pool;
+
+static void da_pool_return_cb(struct rcu_head *head)
+{
+	struct da_monitor_storage *ms =
+		container_of(head, struct da_monitor_storage, rcu);
+
+	mempool_free(ms, &da_monitor_pool);
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
+
+	if (da_mon)
+		return da_mon;
+
+	mon_storage = mempool_alloc_preallocated(&da_monitor_pool);
+	if (!mon_storage)
+		return NULL;
+	memset(mon_storage, 0, sizeof(*mon_storage));
+
+	mon_storage->id = id;
+	mon_storage->target = target;
+
+	/* Single consumer under the caller's lock; duplicate is a double-start bug. */
+	existing = __da_get_mon_storage(id);
+	if (WARN_ON_ONCE(existing)) {
+		mempool_free(mon_storage, &da_monitor_pool);
+		return NULL;
+	}
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	return &mon_storage->rv.da_mon;
+}
+
 /*
  * da_destroy_storage - destroy the per-object storage
  *
@@ -564,7 +674,10 @@ static inline void da_destroy_storage(da_id_type id)
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
@@ -590,6 +703,9 @@ static inline void da_monitor_reset_state_all(void)
 static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+		return mempool_init_kmalloc_pool(&da_monitor_pool, DA_MON_POOL_SIZE,
+						 sizeof(struct da_monitor_storage));
 	return 0;
 }
 
@@ -607,21 +723,37 @@ static inline void da_monitor_destroy(void)
 	 * pending, we can safely assume no concurrent user.
 	 */
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
+		da_extra_cleanup(&mon_storage->rv.da_mon);
 		hash_del_rcu(&mon_storage->node);
-		kfree(mon_storage);
+		if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+			mempool_free(mon_storage, &da_monitor_pool);
+		else
+			kfree(mon_storage);
+	}
+
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL) {
+		rcu_barrier();
+		mempool_exit(&da_monitor_pool);
 	}
 }
 
 /*
- * Allow the per-object monitors to run allocation manually, necessary if the
- * start condition is in a context problematic for allocation (e.g. scheduling).
- * In such case, if the storage was pre-allocated without a target, set it now.
+ * da_prepare_storage - allocate or link per-object monitor storage.
+ *
+ * Called only from da_handle_start_run_event(); must run in task context
+ * for DA_ALLOC_AUTO and DA_ALLOC_POOL (both take a spinlock_t internally).
+ * Subsequent event handlers use da_handle_event() and never allocate.
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
 
-- 
2.25.1

