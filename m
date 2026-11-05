Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901019;
	b=QKV2dYmXPpRTOTfXCgdPHmTd+FfBBClXi6hetEe3PJIMJ9KSwz8+zNQi95qchsaY1yeE
	 vXlVTuo+QwIoLtAQ2kyAB2zfc9Y9LqdOQMxwHQnEnHPERiRrIJqT3iWU4J+02TQZdWA73
	 8igobIVy9d07I1e++aqFSdoeyMu8RtsT6r63NtVLydbb1w/it9HjV4P6z077XQb/xV9Je
	 J/F/rvv8Rrk4eTwlvVOVBV9Rxolb8frhRxtnD0tVinq7bXdBmQ6ABsekedkZaQP8c17gR
	 l1GzaKi0rTa96J83rci7IhD2L2EFu8ThySNkMmWySsakNsmlUs8b5ttfEoFvgnN90cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901019;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=82qwBr50W/qO5etC4d9RNtnzdj3BiIQHx4SEKe7SXsM=;
	b=Gmjb5jOUutoZwhHKJw9wVygy0KvLfnqEqviHNZhNYvgK7IL7gaBQkkqKXJ06sKvC8Rhi
	 e1D4AQ90W+K0YEMWneAU4d4U988PBcFkCzGy6pO4YWDfcDCiLMxGrA3mX9JtfnxzOlzl9
	 fdOay6A0Ghmg+vhaRom+OCucaEgVECnhzPMgmDi/ZgdoTkgARg758oKq0U1GRVYJgGDOw
	 W7eLFNl/UzxapMH+J6DizudhGcvUE5taHniklT2rTI8VEaAEBp+KelbkrxKcagrPfXmyP
	 qW6HyNr0KJNAjdHGMf8D2/oIlGD3l7l3mRaQoWw28yzRUFqgp5NPOG/nd6avQU9WULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OAPRL2Hu;
	arc=none smtp.remote-ip=91.218.175.94
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB32606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB32606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OAPRL2Hu
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EfdKYXft/Got+YC/18pvThL4WWsgxbwvlWO8iRA97JQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901016; v=1; x=1794505816;
 b=OAPRL2HuzV1t/TWHKLUcs6U+fsUbco4TNJdDorimCWfFB8QKTvEvhbNz+9GNNMX6UDJcqQP2
 Oa5j/tRwpq97xo5cK77+z5dohRNQroRrEZt1fPwnmmHBpZSO0qAlkCVFEY6BRNhA4RHZgow27xJ
 njh9/wZ7SYG25lNbsoDReJLM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c8adc97c972600d4;
	Thu, 05 Nov 2026 17:50:15 +0000
X-Mizu-Trace-ID: c8adc97c972600d4
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 07/14] rv: Introduce DA_MON_ALLOCATION_STRATEGY
Date: Fri,  6 Nov 2026 01:49:07 +0800
Message-Id: <9eb3cf597afb19a1e1374d14f34a344cea7d054a.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
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

nomiss switches from the implicit DA_SKIP_AUTO_ALLOC override to an
explicit DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL; the behaviours are
equivalent (pre-allocated storage, no allocation on the sched_switch
start path).

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h                  | 121 +++++++++++++++++++++--
 kernel/trace/rv/monitors/nomiss/nomiss.c |   2 +-
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index c7f9733fb8a4..76169e41d4e5 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,7 +14,45 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
+/*
+ * Allocation strategy for RV_MON_PER_OBJ monitors, selected before including
+ * this header.  Defining DA_MON_POOL_SIZE N implies DA_ALLOC_POOL.
+ *
+ * DA_ALLOC_AUTO   - kmalloc on demand; unbounded (default).
+ * DA_ALLOC_POOL   - DA_MON_POOL_SIZE pre-allocated slots.  The start handler
+ *                   must run in task context; other handlers only call
+ *                   da_handle_event() and never allocate.
+ * DA_ALLOC_MANUAL - caller pre-inserts storage; framework links the target.
+ */
+#define DA_ALLOC_AUTO   0
+#define DA_ALLOC_POOL   1
+#define DA_ALLOC_MANUAL 2
+
+#ifdef DA_MON_POOL_SIZE
+#if defined(DA_MON_ALLOCATION_STRATEGY) && \
+	DA_MON_ALLOCATION_STRATEGY != DA_ALLOC_POOL
+#error "DA_MON_POOL_SIZE implies DA_ALLOC_POOL"
+#endif
+#if DA_MON_POOL_SIZE == 0
+#error "DA_MON_POOL_SIZE must be non-zero"
+#endif
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
+#endif /* DA_MON_POOL_SIZE */
+
+#ifndef DA_MON_ALLOCATION_STRATEGY
+#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
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
@@ -563,6 +601,46 @@ static void da_kfree_cb(struct rcu_head *head)
 	kfree(ms);
 }
 
+/*
+ * Zero-initialised for non-pool monitors, whose pool paths compile away.
+ */
+static mempool_t da_monitor_pool;
+
+static void da_pool_return_cb(struct rcu_head *head)
+{
+	struct da_monitor_storage *ms =
+		container_of(head, struct da_monitor_storage, rcu);
+
+	da_monitor_free_hook(&ms->rv.da_mon);
+	mempool_free(ms, &da_monitor_pool);
+}
+
+/*
+ * da_create_pool_storage - pop a free pool slot and insert it into the hash.
+ * Returns NULL if the pool is exhausted.  Caller holds an RCU read-side CS
+ * and the monitor's serialisation lock.
+ */
+static inline struct da_monitor *
+da_create_pool_storage(da_id_type id, monitor_target target,
+		       struct da_monitor *da_mon)
+{
+	struct da_monitor_storage *mon_storage;
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
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	return &mon_storage->rv.da_mon;
+}
+
 /*
  * da_destroy_storage - destroy the per-object storage
  *
@@ -588,7 +666,10 @@ static inline void da_destroy_storage(da_id_type id)
 	 * A reader from before hash_del_rcu() may still arm; the free
 	 * callback runs past it, so the hook disarms there.
 	 */
-	call_rcu(&mon_storage->rcu, da_kfree_cb);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
+		call_rcu(&mon_storage->rcu, da_pool_return_cb);
+	else
+		call_rcu(&mon_storage->rcu, da_kfree_cb);
 }
 
 static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
@@ -614,6 +695,13 @@ static inline void da_monitor_reset_state_all(void)
 static inline int da_monitor_init(void)
 {
 	hash_init(da_monitor_ht);
+	if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL) {
+		size_t storage_size = sizeof(struct da_monitor_storage);
+
+		return mempool_init_kmalloc_pool(&da_monitor_pool,
+						 DA_MON_POOL_SIZE,
+						 storage_size);
+	}
 	return 0;
 }
 
@@ -633,20 +721,33 @@ static inline void da_monitor_destroy(void)
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
 		da_monitor_free_hook(&mon_storage->rv.da_mon);
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
+ * Only the first start allocates; later starts reuse the existing da_mon.
+ * Must run in task context (see the allocation strategies above).
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
 
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 6e47d379f777..c80a2c51c514 100644
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
-- 
2.25.1

