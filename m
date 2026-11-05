Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901033;
	b=FfDPM+sBOt/821xY9MnXI2uCYB12wALdpTLkK+WnKngOu38VjetHTrTVSRU6m6nSSWJp
	 7kumSXH5PnMgxzM0qE+V6bmVHa8jzGiptPqimhfnZlQhUKlmdsIz0F2MCuSA4x3p8O0XX
	 U/l9l4o8vTl1YeEsTxxwHgmHy8ihFjW59axYWSz1ClUcPPYyM8TV6aHDfcA3fgEYI/ccb
	 aTG07HhE0wCTfFCpu7aT1PJZeEgvsbFxFtfYg3pYyhBgrTuhrcI7iJIJmTco39UkehT7F
	 gSnGMUUY5yHVb4m6pnLjzS2eGj9tx2BuMd6mIUwS47lQcplN5zTL7cvfyqe4VaC3OZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901033;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XMVQF02q4X+VGcpwNkyoGjUCuuNYWvMCV42ZNpFJ900=;
	b=SuXgK2sdCqOW/27jUBMuXAAjUTuYL0ZE6jeYFIsX21AtAOPAfxVVu4CLGx3crihv1rxf
	 Xa5BWZSxMilJtmtiSZrjT4/l/Dw47aOYsj/O5NI4tKsRdz3zAKEKm1A3DIreCiYTGczQw
	 aUdvBdNpYNjULOOCkdGgfMty3NlA/Paf6l6gFeXNpdysjBoXHQJIW8hIk0SNBuuQ2vAeA
	 GfpolIsRiVu5RzGI+fqlR4haPK1BeDxpwP1ttWVNps4jqtwpauxpkyAGut9c1oBBOYt4n
	 jH8oomrhghzLbA/rM2BESXjuQbsBqYc7+OKhT1ua2tH+s3pVEwECoEbHeCgKalnW64Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="wAf/ecML";
	arc=none smtp.remote-ip=91.218.175.98
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD38606A328
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD38606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wAf/ecML
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2nYVH//TJP55/HDJ3Utcdp/AqqWGGVKXaZDBxK5lqJk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901030; v=1; x=1794505830;
 b=wAf/ecMLlRh2yp8xN/xjSH9H7QAX2r940SXFZQMhJSedQHdxf/gfqqS344QGjFbVDj8x1aP/
 oBCmhfBIpVeQbldMRSiRtCztY+zYKLdtH9U6Gtzf2Si9ngYdmHUp63uRkiiY37AJca5fq+RWtMM
 OpYBWjMB/eHWzyaO+/qz40vA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d36ba3360128034a;
	Thu, 05 Nov 2026 17:50:25 +0000
X-Mizu-Trace-ID: d36ba3360128034a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 08/14] rv: Support embedded target types in per-object DA storage
Date: Fri,  6 Nov 2026 01:49:08 +0800
Message-Id: <49fd8e0482d2cf1f9c690031ab0cf9cc1eb1c5ad.1793900349.git.wen.yang@linux.dev>
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

A PER_OBJ monitor usually typedefs monitor_target itself, as a pointer to
the monitored object (borrowed: the object exists independently of the
monitor and outlives the storage).

A monitor whose target is monitor-owned data can instead define
DA_OBJ_EMBEDDED_TYPE with a complete struct type: the framework then
derives monitor_target as a pointer to it, embeds one instance in each
per-object storage, and allocates and frees it together with the storage.
On storage creation the caller-supplied target is shallow-copied into
the storage before it is published, so it may be a fully initialised
stack object.

This allows per-object monitors to manage custom per-instance data without
maintaining private mempools, complex multi-stage reference counting, or
out-of-band teardown state machines.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 82 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 76169e41d4e5..ed9e7e740d80 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -61,6 +61,10 @@
 #include <linux/slab.h>
 #include <linux/hashtable.h>
 
+#if defined(DA_OBJ_EMBEDDED_TYPE) && RV_MON_TYPE != RV_MON_PER_OBJ
+#error "DA_OBJ_EMBEDDED_TYPE is only supported by RV_MON_PER_OBJ monitors"
+#endif
+
 /*
  * Per-cpu variables require a unique name although static in some
  * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules).
@@ -453,9 +457,24 @@ static inline void da_monitor_destroy(void)
  * Functions to define, init and get a per-object monitor.
  */
 
+#ifdef DA_OBJ_EMBEDDED_TYPE
+/*
+ * Framework-owned target: one instance is embedded in each storage and
+ * allocated/freed with it.  monitor_target keeps pointer semantics, but
+ * da_get_target() points into the storage rather than to a borrowed object.
+ * The header derives the typedef: do not define monitor_target by hand.
+ */
+typedef DA_OBJ_EMBEDDED_TYPE * monitor_target;
+#endif
+
 struct da_monitor_storage {
 	da_id_type id;
+#ifdef DA_OBJ_EMBEDDED_TYPE
+	DA_OBJ_EMBEDDED_TYPE target;
+	bool filled;
+#else
 	monitor_target target;
+#endif
 	union rv_task_monitor rv;
 	struct hlist_node node;
 	struct rcu_head rcu;
@@ -466,6 +485,40 @@ struct da_monitor_storage {
 #endif
 static DEFINE_HASHTABLE(da_monitor_ht, DA_MONITOR_HT_BITS);
 
+#ifdef DA_OBJ_EMBEDDED_TYPE
+
+#define TARGET_PTR(storage) (&(storage)->target)
+
+static inline bool da_storage_is_empty(struct da_monitor_storage *mon_storage)
+{
+	/* Pairs with smp_store_release in da_storage_set_target(). */
+	return !smp_load_acquire(&mon_storage->filled);
+}
+static inline void da_storage_set_target(struct da_monitor_storage *mon_storage,
+					 monitor_target target)
+{
+	if (WARN_ON_ONCE(!target))
+		return;
+
+	memcpy(&mon_storage->target, target, sizeof(mon_storage->target));
+	/* Pairs with smp_load_acquire in da_storage_is_empty(). */
+	smp_store_release(&mon_storage->filled, true);
+}
+#else
+
+#define TARGET_PTR(storage) storage->target
+
+static inline bool da_storage_is_empty(struct da_monitor_storage *mon_storage)
+{
+	return !TARGET_PTR(mon_storage);
+}
+static inline void da_storage_set_target(struct da_monitor_storage *mon_storage,
+					 monitor_target target)
+{
+	mon_storage->target = target;
+}
+#endif
+
 /*
  * da_create_empty_storage - pre-allocate an empty storage
  */
@@ -503,7 +556,7 @@ static inline struct da_monitor *da_create_storage(da_id_type id,
 	if (!mon_storage)
 		return NULL;
 
-	mon_storage->target = target;
+	da_storage_set_target(mon_storage, target);
 	return &mon_storage->rv.da_mon;
 }
 
@@ -536,10 +589,20 @@ static struct da_monitor *da_get_monitor(da_id_type id, monitor_target target)
 
 /*
  * da_get_target - return the object associated to the monitor
+ *
+ * NULL for an embedded target whose storage was pre-allocated but not filled
+ * yet: a manual-allocation monitor publishes its storage before it has one.
  */
 static inline monitor_target da_get_target(struct da_monitor *da_mon)
 {
-	return container_of(da_mon, struct da_monitor_storage, rv.da_mon)->target;
+	struct da_monitor_storage *mon_storage =
+		container_of(da_mon, struct da_monitor_storage, rv.da_mon);
+
+#ifdef DA_OBJ_EMBEDDED_TYPE
+	if (unlikely(da_storage_is_empty(mon_storage)))
+		return NULL;
+#endif
+	return TARGET_PTR(mon_storage);
 }
 
 /*
@@ -572,8 +635,11 @@ static inline struct da_monitor *da_fill_empty_storage(da_id_type id,
 						       monitor_target target,
 						       struct da_monitor *da_mon)
 {
-	if (unlikely(da_mon && !da_get_target(da_mon)))
-		container_of(da_mon, struct da_monitor_storage, rv.da_mon)->target = target;
+	struct da_monitor_storage *mon_storage =
+		container_of(da_mon, struct da_monitor_storage, rv.da_mon);
+
+	if (unlikely(da_mon && da_storage_is_empty(mon_storage)))
+		da_storage_set_target(mon_storage, target);
 	return da_mon;
 }
 
@@ -589,7 +655,11 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 
 	if (unlikely(!mon_storage))
 		return NULL;
-	return mon_storage->target;
+#ifdef DA_OBJ_EMBEDDED_TYPE
+	if (unlikely(da_storage_is_empty(mon_storage)))
+		return NULL;
+#endif
+	return TARGET_PTR(mon_storage);
 }
 
 static void da_kfree_cb(struct rcu_head *head)
@@ -635,7 +705,7 @@ da_create_pool_storage(da_id_type id, monitor_target target,
 	memset(mon_storage, 0, sizeof(*mon_storage));
 
 	mon_storage->id = id;
-	mon_storage->target = target;
+	da_storage_set_target(mon_storage, target);
 
 	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
 	return &mon_storage->rv.da_mon;
-- 
2.25.1

