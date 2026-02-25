Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635538E5FD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013154; cv=none; b=hVTbK6zW6lSAGlmWj9876l8fWB9ZCwCqxxYBIExvT9DXj7hXOxLkKtuq3w5737RfNTbQ5icwqJvCAG0jx7M28s+5y5hkSOMgVDhIO4RAzbh8Rjp1sN72Q6Tl5HX2zp82c6yUsoSxEgaozCc8KuG4vtJqYRV56F3UZgGbHDZejU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013154; c=relaxed/simple;
	bh=kI+0TKw4vwy5AaTAJNhA34lJRTiOhAHcv7+n82YeHcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rNZF3Lw4HtsGCrEc9lIyP9wzNZlr0EkJ2ez7JHK/fKLfKbMfhuFNiLI8HdeGWauxxrQc43QpdUY1K+Jc6orJxyi/Vesxq7IQaeUYd782x4Aeqt/KtYgs9oR7JJ8uVRAdpjOfiqHSN9r/YN4zH5xFhb9hLIlR1Ede03vxCMH8nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZrQwalO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZrQwalO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdXd1CUkYwBk++H/UonQ85dVHuxyOjOtwbs0fDrPOuI=;
	b=BZrQwalOCJ4DKvgG2ASMDcQbFwdkPZBZqim80VPnUt6Fj9XDnzQ79CrnCZSyd8WLtdEPLy
	fBLLg2Eha3mjX4PhgVHIa96L7w9oLvFWnf3zAmOkO9XXXHEZP9AmPtgh402ZDMuDexIEEy
	cBlZut5keGL3LU4gvLhS2LB5gHAXUx4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-v0JQ_hOSMjaVx4vzfjPvlQ-1; Wed,
 25 Feb 2026 04:52:27 -0500
X-MC-Unique: v0JQ_hOSMjaVx4vzfjPvlQ-1
X-Mimecast-MFC-AGG-ID: v0JQ_hOSMjaVx4vzfjPvlQ_1772013146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE8C19560A1;
	Wed, 25 Feb 2026 09:52:26 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.216])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC8B3180066B;
	Wed, 25 Feb 2026 09:52:22 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v6 10/16] rv: Add support for per-object monitors in DA/HA
Date: Wed, 25 Feb 2026 10:51:16 +0100
Message-ID: <20260225095122.80683-11-gmonaco@redhat.com>
In-Reply-To: <20260225095122.80683-1-gmonaco@redhat.com>
References: <20260225095122.80683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Sn5UlQjr5PVVZtPDUCCHWW0r7TlebjFocGkNxbulBLk_1772013146
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RV deterministic and hybrid automata currently only support global,
per-cpu and per-task monitors. It isn't possible to write a model that
would follow some different type of object, like a deadline entity or a
lock.

Define the generic per-object monitor implementation which shares part
of the implementation with the per-task monitors.
The user needs to provide an id for the object (e.g. pid for tasks) and
define the data type for the monitor_target (e.g. struct task_struct *
for tasks). Both are supplied to the event handlers, as the id may not
be easily available in the target.

The monitor storage (e.g. the rv monitor, pointer to the target, etc.)
is stored in a hash table indexed by id. Monitor storage objects are
automatically allocated unless specified otherwise (e.g. if the creation
context is unsafe for allocation).

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V3:
    * Use kmalloc_nolock for per-obj storage allocation
    * Improve function name consistency

 include/linux/rv.h      |   1 +
 include/rv/da_monitor.h | 300 +++++++++++++++++++++++++++++++++++++++-
 include/rv/ha_monitor.h |   5 +-
 3 files changed, 300 insertions(+), 6 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 0aef9e3c785c..541ba404926a 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -13,6 +13,7 @@
 #define RV_MON_GLOBAL   0
 #define RV_MON_PER_CPU  1
 #define RV_MON_PER_TASK 2
+#define RV_MON_PER_OBJ  3
 
 #ifdef CONFIG_RV
 #include <linux/array_size.h>
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ab5fe0896a46..39765ff6f098 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,6 +19,8 @@
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/hashtable.h>
 
 /*
  * Per-cpu variables require a unique name although static in some
@@ -57,6 +59,9 @@ static struct rv_monitor rv_this;
 
 /*
  * Type for the target id, default to int but can be overridden.
+ * A long type can work as hash table key (PER_OBJ) but will be downgraded to
+ * int in the event tracepoint.
+ * Unused for implicit monitors.
  */
 #ifndef da_id_type
 #define da_id_type int
@@ -245,9 +250,9 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
 }
 
 /*
- * da_get_task - return the task associated to the monitor
+ * da_get_target - return the task associated to the monitor
  */
-static inline struct task_struct *da_get_task(struct da_monitor *da_mon)
+static inline struct task_struct *da_get_target(struct da_monitor *da_mon)
 {
 	return container_of(da_mon, struct task_struct, rv[task_mon_slot].da_mon);
 }
@@ -259,7 +264,7 @@ static inline struct task_struct *da_get_task(struct da_monitor *da_mon)
  */
 static inline da_id_type da_get_id(struct da_monitor *da_mon)
 {
-	return da_get_task(da_mon)->pid;
+	return da_get_target(da_mon)->pid;
 }
 
 static void da_monitor_reset_all(void)
@@ -309,6 +314,221 @@ static inline void da_monitor_destroy(void)
 
 	da_monitor_reset_all();
 }
+
+#elif RV_MON_TYPE == RV_MON_PER_OBJ
+/*
+ * Functions to define, init and get a per-object monitor.
+ */
+
+struct da_monitor_storage {
+	da_id_type id;
+	monitor_target target;
+	union rv_task_monitor rv;
+	struct hlist_node node;
+	struct rcu_head rcu;
+};
+
+#ifndef DA_MONITOR_HT_BITS
+#define DA_MONITOR_HT_BITS 10
+#endif
+static DEFINE_HASHTABLE(da_monitor_ht, DA_MONITOR_HT_BITS);
+
+/*
+ * da_create_empty_storage - pre-allocate an empty storage
+ */
+static inline struct da_monitor_storage *da_create_empty_storage(da_id_type id)
+{
+	struct da_monitor_storage *mon_storage;
+
+	mon_storage = kmalloc_nolock(sizeof(struct da_monitor_storage),
+				     __GFP_ZERO, NUMA_NO_NODE);
+	if (!mon_storage)
+		return NULL;
+
+	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
+	mon_storage->id = id;
+	return mon_storage;
+}
+
+/*
+ * da_create_storage - create the per-object storage
+ *
+ * The caller is responsible to synchronise writers, either with locks or
+ * implicitly. For instance, if da_create_storage is only called from a single
+ * event for target (e.g. sched_switch), it's safe to call this without locks.
+ */
+static inline struct da_monitor *da_create_storage(da_id_type id,
+						   monitor_target target,
+						   struct da_monitor *da_mon)
+{
+	struct da_monitor_storage *mon_storage;
+
+	if (da_mon)
+		return da_mon;
+
+	mon_storage = da_create_empty_storage(id);
+	if (!mon_storage)
+		return NULL;
+
+	mon_storage->target = target;
+	return &mon_storage->rv.da_mon;
+}
+
+/*
+ * __da_get_mon_storage - get the monitor storage from the hash table
+ */
+static inline struct da_monitor_storage *__da_get_mon_storage(da_id_type id)
+{
+	struct da_monitor_storage *mon_storage;
+
+	lockdep_assert_in_rcu_read_lock();
+	hash_for_each_possible_rcu(da_monitor_ht, mon_storage, node, id) {
+		if (mon_storage->id == id)
+			return mon_storage;
+	}
+
+	return NULL;
+}
+
+/*
+ * da_get_monitor - return the monitor for target
+ */
+static struct da_monitor *da_get_monitor(da_id_type id, monitor_target target)
+{
+	struct da_monitor_storage *mon_storage;
+
+	mon_storage = __da_get_mon_storage(id);
+	return mon_storage ? &mon_storage->rv.da_mon : NULL;
+}
+
+/*
+ * da_get_target - return the object associated to the monitor
+ */
+static inline monitor_target da_get_target(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct da_monitor_storage, rv.da_mon)->target;
+}
+
+/*
+ * da_get_id - return the id associated to the monitor
+ */
+static inline da_id_type da_get_id(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct da_monitor_storage, rv.da_mon)->id;
+}
+
+/*
+ * da_create_or_get - create the per-object storage if not already there
+ *
+ * This needs a lookup so should be guarded by RCU, the condition is checked
+ * directly in da_create_storage()
+ */
+static inline void da_create_or_get(da_id_type id, monitor_target target)
+{
+	guard(rcu)();
+	da_create_storage(id, target, da_get_monitor(id, target));
+}
+
+/*
+ * da_fill_empty_storage - store the target in a pre-allocated storage
+ *
+ * Can be used as a substitute of da_create_storage when starting a monitor in
+ * an environment where allocation is unsafe.
+ */
+static inline struct da_monitor *da_fill_empty_storage(da_id_type id,
+						       monitor_target target,
+						       struct da_monitor *da_mon)
+{
+	if (unlikely(da_mon && !da_get_target(da_mon)))
+		container_of(da_mon, struct da_monitor_storage, rv.da_mon)->target = target;
+	return da_mon;
+}
+
+/*
+ * da_get_target_by_id - return the object associated to the id
+ */
+static inline monitor_target da_get_target_by_id(da_id_type id)
+{
+	struct da_monitor_storage *mon_storage;
+
+	guard(rcu)();
+	mon_storage = __da_get_mon_storage(id);
+
+	if (unlikely(!mon_storage))
+		return NULL;
+	return mon_storage->target;
+}
+
+/*
+ * da_destroy_storage - destroy the per-object storage
+ *
+ * The caller is responsible to synchronise writers, either with locks or
+ * implicitly. For instance, if da_destroy_storage is called at sched_exit and
+ * da_create_storage can never occur after that, it's safe to call this without
+ * locks.
+ * This function includes an RCU read-side critical section to synchronise
+ * against da_monitor_destroy().
+ */
+static inline void da_destroy_storage(da_id_type id)
+{
+	struct da_monitor_storage *mon_storage;
+
+	guard(rcu)();
+	mon_storage = __da_get_mon_storage(id);
+
+	if (!mon_storage)
+		return;
+	da_monitor_reset_hook(&mon_storage->rv.da_mon);
+	hash_del_rcu(&mon_storage->node);
+	kfree_rcu(mon_storage, rcu);
+}
+
+static void da_monitor_reset_all(void)
+{
+	struct da_monitor_storage *mon_storage;
+	int bkt;
+
+	rcu_read_lock();
+	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
+		da_monitor_reset(&mon_storage->rv.da_mon);
+	rcu_read_unlock();
+}
+
+static inline int da_monitor_init(void)
+{
+	hash_init(da_monitor_ht);
+	return 0;
+}
+
+static inline void da_monitor_destroy(void)
+{
+	struct da_monitor_storage *mon_storage;
+	struct hlist_node *tmp;
+	int bkt;
+
+	/*
+	 * This function is called after all probes are disabled, we need only
+	 * worry about concurrency against old events.
+	 */
+	synchronize_rcu();
+	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
+		da_monitor_reset_hook(&mon_storage->rv.da_mon);
+		hash_del_rcu(&mon_storage->node);
+		kfree(mon_storage);
+	}
+}
+
+/*
+ * Allow the per-object monitors to run allocation manually, necessary if the
+ * start condition is in a context problematic for allocation (e.g. scheduling).
+ * In such case, if the storage was pre-allocated without a target, set it now.
+ */
+#ifdef DA_SKIP_AUTO_ALLOC
+#define da_prepare_storage da_fill_empty_storage
+#else
+#define da_prepare_storage da_create_storage
+#endif /* DA_SKIP_AUTO_ALLOC */
+
 #endif /* RV_MON_TYPE */
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
@@ -342,9 +562,9 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
 	return 0;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
 /*
- * Trace events for per_task monitors, report the PID of the task.
+ * Trace events for per_task/per_object monitors, report the target id.
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
@@ -525,6 +745,76 @@ static inline bool da_handle_start_run_event(struct task_struct *tsk,
 {
 	return __da_handle_start_run_event(da_get_monitor(tsk), event, tsk->pid);
 }
+
+#elif RV_MON_TYPE == RV_MON_PER_OBJ
+/*
+ * Handle event for per object.
+ */
+
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event(da_id_type id, monitor_target target, enum events event)
+{
+	struct da_monitor *da_mon;
+
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	if (likely(da_mon))
+		__da_handle_event(da_mon, event, id);
+}
+
+/*
+ * da_handle_start_event - start monitoring or handle event
+ *
+ * This function is used to notify the monitor that the system is returning
+ * to the initial state, so the monitor can start monitoring in the next event.
+ * Thus:
+ *
+ * If the monitor already started, handle the event.
+ * If the monitor did not start yet, start the monitor but skip the event.
+ */
+static inline bool da_handle_start_event(da_id_type id, monitor_target target,
+					 enum events event)
+{
+	struct da_monitor *da_mon;
+
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	da_mon = da_prepare_storage(id, target, da_mon);
+	if (unlikely(!da_mon))
+		return 0;
+	return __da_handle_start_event(da_mon, event, id);
+}
+
+/*
+ * da_handle_start_run_event - start monitoring and handle event
+ *
+ * This function is used to notify the monitor that the system is in the
+ * initial state, so the monitor can start monitoring and handling event.
+ */
+static inline bool da_handle_start_run_event(da_id_type id, monitor_target target,
+					     enum events event)
+{
+	struct da_monitor *da_mon;
+
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	da_mon = da_prepare_storage(id, target, da_mon);
+	if (unlikely(!da_mon))
+		return 0;
+	return __da_handle_start_run_event(da_mon, event, id);
+}
+
+static inline void da_reset(da_id_type id, monitor_target target)
+{
+	struct da_monitor *da_mon;
+
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	if (likely(da_mon))
+		da_monitor_reset(da_mon);
+}
 #endif /* RV_MON_TYPE */
 
 #endif
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index b6cf3b2ba989..d59507e8cb30 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -190,7 +190,10 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
 {
 	CONCATENATE(trace_error_env_, MONITOR_NAME)(curr_state, event, env);
 }
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
+
+#define ha_get_target(ha_mon) da_get_target(&ha_mon->da_mon)
+
 static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
 				      char *curr_state, char *event, char *env,
 				      da_id_type id)
-- 
2.53.0

