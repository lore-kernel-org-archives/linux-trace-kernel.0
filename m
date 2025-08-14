Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89D25B692
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184206; cv=none; b=IgJFOwkMqTeBz2+ii37roG4SpBLDr05CVGixnt0CMD2Z+b5AH896p9m951KTETECl/0hLRrp2uvp/GzfpYutakBIKHUPJcojVgbgPxeAXbdZjck2Ve1jpFw07+DuY1hGDG4LRuW1psk8RBsaMYnwO7+33hc0+UcwcPOXYUIMep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184206; c=relaxed/simple;
	bh=bud/1gruZ9iKND/veVSmVqKHAQZnl0XC8A1Lj6PTrig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7yoNF/hZNa++B0yp0LukXLYc5bK3j+V3THQ2nIUvLGswoBK7mxwgNGVhyjVreJ898UA6t0lMTXnubbRGQzJc/eyIuGMA2htC1OFniWCDS4GL0QNC9l+zpH8QPZeIBYZdLLagD5OdSJE4nTxxyGbYLp7JKosGy1dUMFC4QxTNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsIJlgiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsIJlgiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFaY0/yysxY5stqXu/Bmvf5pW5QIS/j1dztanLkj1Ng=;
	b=DsIJlgiLXz1RoweOnK6HYGHo0wbMcAc1yqhv3rdPa4ayweLrWU/vCFr7kSsEfozLvTnOb5
	Eue+GIVwP/e6amwCmWxwjc037kyQX61K/iBJKlowCVuidxQBfKRdEICzmrPVn9lhnZKrVS
	kJPaL7MJgK752CKl9bvpONboF9RAAqA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Op84w7lnPp2mRF27uvncPA-1; Thu,
 14 Aug 2025 11:09:58 -0400
X-MC-Unique: Op84w7lnPp2mRF27uvncPA-1
X-Mimecast-MFC-AGG-ID: Op84w7lnPp2mRF27uvncPA_1755184197
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAF9F180048E;
	Thu, 14 Aug 2025 15:09:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B7821800280;
	Thu, 14 Aug 2025 15:09:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 15/17] rv: Add support for per-object monitors in DA/HA
Date: Thu, 14 Aug 2025 17:08:07 +0200
Message-ID: <20250814150809.140739-16-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

RV deterministic and hybrid automata currently only support global,
per-cpu and per-task monitors. It isn't possible to write a model that
would follow some different type of object, like a deadline entity or a
lock.

Define the generic per-object monitor implementation which shares most
of the implementation with the per-task monitors. Specifically, the user
needs to define how to get an id for the object (e.g. pid for tasks) and
the data type for the monitor_target (e.g. struct task_struct * for
tasks).

The monitor storage (e.g. the rv monitor, pointer to the target, etc.)
is stored in a hash table indexed by id. Monitor storage objects are
automatically allocated unless specified otherwise (e.g. if the creation
context is unsafe for allocation).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h      |   2 +-
 include/rv/da_common.h  |  21 +++
 include/rv/da_monitor.h | 325 +++++++++++++++++++++++++++++++++++++---
 include/rv/ha_monitor.h |  36 +++--
 4 files changed, 352 insertions(+), 32 deletions(-)
 create mode 100644 include/rv/da_common.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 6a7594080db1..6c49db8d4d07 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -16,6 +16,7 @@
 #define RV_MON_GLOBAL   0
 #define RV_MON_PER_CPU  1
 #define RV_MON_PER_TASK 2
+#define RV_MON_PER_OBJ  3
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
@@ -100,7 +101,6 @@ struct ha_monitor {
 	u64 env_store[MAX_HA_ENV_LEN];
 	struct hrtimer timer;
 };
-#define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
 
 #else
 
diff --git a/include/rv/da_common.h b/include/rv/da_common.h
new file mode 100644
index 000000000000..67d817aee18e
--- /dev/null
+++ b/include/rv/da_common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Red Hat, Inc.
+ *
+ * Common definitions for DA and HA monitors.
+ */
+#ifndef _RV_DA_COMMON_H
+#define _RV_DA_COMMON_H
+
+#include <linux/sched.h>
+
+/*
+ * ID monitor types (per-task and per-object) have an opaque type, this is
+ * defined by default for the per-task case but must be defined by the monitor
+ * in case of per-object monitors.
+ */
+#if RV_MON_TYPE == RV_MON_PER_TASK
+typedef struct task_struct *monitor_target;
+#endif
+
+#endif /* _RV_DA_COMMON_H */
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index d95ece5b7908..737bfeb2b48f 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,11 +14,13 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
+#include <rv/da_common.h>
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
-#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/hashtable.h>
 
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
 #define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
@@ -51,6 +53,38 @@ static struct rv_monitor RV_MONITOR_NAME;
 #define da_monitor_reset_hook(da_mon)
 #endif
 
+/*
+ * Hook to allow the implementation of per-obj monitors: define it with a
+ * function that takes the object and a da_mon (can be NULL) and returns the
+ * (newly created) da_monitor for the objects.
+ * The monitor can run allocation manually if the start condition is in a
+ * context potentially problematic for allocation (e.g. while scheduling).
+ * In such case, if the storage was pre-allocated without a target, set it now.
+ */
+#if !defined(da_monitor_start_hook) && RV_MON_TYPE == RV_MON_PER_OBJ
+#ifdef DA_SKIP_AUTO_ALLOC
+static inline struct da_monitor *
+da_fill_empty_storage(monitor_target target, struct da_monitor *da_mon);
+#define da_monitor_start_hook da_fill_empty_storage
+#else
+#define da_monitor_start_hook da_create_storage
+static struct da_monitor *da_create_storage(monitor_target target, struct da_monitor *da_mon);
+#endif /* DA_SKIP_AUTO_ALLOC */
+#else
+#define da_monitor_start_hook(target,da_mon) (da_mon)
+#endif
+
+/*
+ * Define a guard (e.g. lock/RCU) for access to the da_monitor.
+ * This is used to synchronise readers (e.g. da_get_monitor) but also writers
+ * (da_create_storage and da_destroy_storage) against da_monitor_destroy.
+ */
+#if !defined(da_guard_monitor) && RV_MON_TYPE == RV_MON_PER_OBJ
+#define da_guard_monitor() guard(rcu)()
+#else
+#define da_guard_monitor()
+#endif
+
 #ifdef CONFIG_RV_REACTORS
 
 static void cond_react(enum states curr_state, enum events event)
@@ -178,16 +212,21 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event)
 	return false;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
 /*
- * Event handler for per_task monitors.
+ * Event handler for per_task/per_object monitors.
  *
  * Retry in case there is a race between getting and setting the next state,
  * warn and reset the monitor if it runs out of retries. The monitor should be
  * able to handle various orders.
  */
 
-static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
+#ifndef da_id_type
+#define da_id_type int
+#endif
+static inline da_id_type da_get_id(monitor_target target);
+
+static inline bool da_event(struct da_monitor *da_mon, monitor_target target,
 			    enum events event)
 {
 	enum states curr_state, next_state;
@@ -197,16 +236,16 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			cond_react(curr_state, event);
-			CONCATENATE(trace_error_, MONITOR_NAME)(tsk->pid,
+			CONCATENATE(trace_error_, MONITOR_NAME)(da_get_id(target),
 				    model_get_state_name(curr_state),
 				    model_get_event_name(event));
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
-			if (!da_monitor_event_hook(tsk, curr_state, event, next_state))
+			if (!da_monitor_event_hook(target, curr_state, event, next_state))
 				return false;
 
-			CONCATENATE(trace_event_, MONITOR_NAME)(tsk->pid,
+			CONCATENATE(trace_event_, MONITOR_NAME)(da_get_id(target),
 				    model_get_state_name(curr_state),
 				    model_get_event_name(event),
 				    model_get_state_name(next_state),
@@ -333,6 +372,24 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
 	return &tsk->rv[task_mon_slot].da_mon;
 }
 
+/*
+ * da_get_target - return the object associated to the monitor
+ */
+static inline monitor_target da_get_target(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct task_struct, rv[task_mon_slot].da_mon);
+}
+
+/*
+ * da_get_id - return the id associated to the target
+ *
+ * For per-task monitors, the id is the task's PID.
+ */
+static inline da_id_type da_get_id(monitor_target target)
+{
+	return target->pid;
+}
+
 static void da_monitor_reset_all(void)
 {
 	struct task_struct *g, *p;
@@ -379,6 +436,208 @@ static inline void da_monitor_destroy(void)
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 	return;
 }
+
+#elif RV_MON_TYPE == RV_MON_PER_OBJ
+/*
+ * Functions to define, init and get a per-object monitor.
+ */
+
+static struct kmem_cache *da_monitor_cache;
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
+	// TODO perhaps no need for the NOWAIT if not auto allocating
+	// NOT from tracepoints! Perhaps get it as an argument..
+	mon_storage = kmem_cache_zalloc(da_monitor_cache, GFP_NOWAIT);
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
+static inline struct da_monitor *da_create_storage(monitor_target target, struct da_monitor *da_mon)
+{
+	struct da_monitor_storage *mon_storage;
+	da_id_type id = da_get_id(target);
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
+static struct da_monitor *da_get_monitor(monitor_target target)
+{
+	struct da_monitor_storage *mon_storage;
+
+	mon_storage = __da_get_mon_storage(da_get_id(target));
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
+ * da_create_conditional - create the per-object storage if not already there
+ *
+ * This needs a lookup so should be guarded by RCU, the condition is checked
+ * directly in da_create_storage()
+ */
+static inline void da_create_conditional(monitor_target target)
+{
+	da_guard_monitor();
+	da_create_storage(target, da_get_monitor(target));
+}
+
+/*
+ * da_fill_empty_storage - store the target in a pre-allocated storage
+ *
+ * Can be used as a substitute of da_create_storage when starting a monitor in
+ * an environment where allocation is unsafe.
+ */
+static inline struct da_monitor *
+da_fill_empty_storage(monitor_target target, struct da_monitor *da_mon)
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
+	da_guard_monitor();
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
+static inline void da_destroy_storage(monitor_target target)
+{
+	struct da_monitor_storage *mon_storage;
+
+	da_guard_monitor();
+	mon_storage = __da_get_mon_storage(da_get_id(target));
+
+	if (!mon_storage)
+		return;
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
+	da_monitor_cache = kmem_cache_create(__stringify(MONITOR_NAME) "-cache",
+					     sizeof(struct da_monitor_storage),
+					     NULL, 0);
+	if (!da_monitor_cache)
+		return -ENOMEM;
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
+		hash_del_rcu(&mon_storage->node);
+		kfree(mon_storage);
+	}
+	rcu_barrier();
+	kmem_cache_destroy(da_monitor_cache);
+}
+
 #endif /* RV_MON_TYPE */
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
@@ -464,17 +723,17 @@ static inline bool da_handle_start_run_event(enum events event)
 	return 1;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
 /*
- * Handle event for per task.
+ * Handle event for per task/object.
  */
 
 static inline void __da_handle_event(struct da_monitor *da_mon,
-				     struct task_struct *tsk, enum events event)
+				     monitor_target target, enum events event)
 {
 	bool retval;
 
-	retval = da_event(da_mon, tsk, event);
+	retval = da_event(da_mon, target, event);
 	if (!retval)
 		da_monitor_reset(da_mon);
 }
@@ -482,16 +741,22 @@ static inline void __da_handle_event(struct da_monitor *da_mon,
 /*
  * da_handle_event - handle an event
  */
-static inline void da_handle_event(struct task_struct *tsk, enum events event)
+static inline void da_handle_event(monitor_target target, enum events event)
 {
-	struct da_monitor *da_mon = da_get_monitor(tsk);
+	struct da_monitor *da_mon;
 	bool retval;
 
+	da_guard_monitor();
+	da_mon = da_get_monitor(target);
+
+	if (unlikely(!da_mon))
+		return;
+
 	retval = da_monitor_handling_event(da_mon);
 	if (!retval)
 		return;
 
-	__da_handle_event(da_mon, tsk, event);
+	__da_handle_event(da_mon, target, event);
 }
 
 /*
@@ -504,7 +769,7 @@ static inline void da_handle_event(struct task_struct *tsk, enum events event)
  * If the monitor already started, handle the event.
  * If the monitor did not start yet, start the monitor but skip the event.
  */
-static inline bool da_handle_start_event(struct task_struct *tsk,
+static inline bool da_handle_start_event(monitor_target target,
 					 enum events event)
 {
 	struct da_monitor *da_mon;
@@ -512,14 +777,19 @@ static inline bool da_handle_start_event(struct task_struct *tsk,
 	if (!da_monitor_enabled())
 		return 0;
 
-	da_mon = da_get_monitor(tsk);
+	da_guard_monitor();
+	da_mon = da_get_monitor(target);
+	da_mon = da_monitor_start_hook(target, da_mon);
+
+	if (unlikely(!da_mon))
+		return 0;
 
 	if (unlikely(!da_monitoring(da_mon))) {
 		da_monitor_start(da_mon);
 		return 0;
 	}
 
-	__da_handle_event(da_mon, tsk, event);
+	__da_handle_event(da_mon, target, event);
 
 	return 1;
 }
@@ -530,7 +800,7 @@ static inline bool da_handle_start_event(struct task_struct *tsk,
  * This function is used to notify the monitor that the system is in the
  * initial state, so the monitor can start monitoring and handling event.
  */
-static inline bool da_handle_start_run_event(struct task_struct *tsk,
+static inline bool da_handle_start_run_event(monitor_target target,
 					     enum events event)
 {
 	struct da_monitor *da_mon;
@@ -538,15 +808,30 @@ static inline bool da_handle_start_run_event(struct task_struct *tsk,
 	if (!da_monitor_enabled())
 		return 0;
 
-	da_mon = da_get_monitor(tsk);
+	da_guard_monitor();
+	da_mon = da_get_monitor(target);
+	da_mon = da_monitor_start_hook(target, da_mon);
+
+	if (unlikely(!da_mon))
+		return 0;
 
 	if (unlikely(!da_monitoring(da_mon)))
 		da_monitor_start(da_mon);
 
-	__da_handle_event(da_mon, tsk, event);
+	__da_handle_event(da_mon, target, event);
 
 	return 1;
 }
+
+static inline void da_reset(monitor_target target)
+{
+	struct da_monitor *da_mon;
+
+	da_guard_monitor();
+	da_mon = da_get_monitor(target);
+	if (likely(da_mon))
+		da_monitor_reset(da_mon);
+}
 #endif /* RV_MON_TYPE */
 
 #endif
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index a7c7297a9759..0c7ab52214c0 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -19,11 +19,12 @@
 #define _RV_HA_MONITOR_H
 
 #include <rv/automata.h>
+#include <rv/da_common.h>
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 static bool ha_monitor_handle_constraint(enum states curr_state, enum events event, enum states next_state);
-#elif RV_MON_TYPE == RV_MON_PER_TASK
-static bool ha_monitor_handle_constraint(struct task_struct *tsk, enum states curr_state, enum events event, enum states next_state);
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
+static bool ha_monitor_handle_constraint(monitor_target target, enum states curr_state, enum events event, enum states next_state);
 #endif
 static inline void ha_monitor_init_env(struct da_monitor *da_mon);
 static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
@@ -35,6 +36,11 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
 
+/* This simplifies things since da_mon and ha_mon coexist in the same union */
+_Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
+	       "da_mon must be the first element in an ha_mon!");
+#define to_ha_monitor(da) ((struct ha_monitor *)da)
+
 #define ENV_MAX CONCATENATE(env_max_, MONITOR_NAME)
 #define ENV_MAX_STORED CONCATENATE(env_max_stored_, MONITOR_NAME)
 #define envs CONCATENATE(envs_, MONITOR_NAME)
@@ -230,14 +236,23 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
 
 /*
  * ha_get_monitor - return the per-task monitor address
  */
-static inline struct ha_monitor *ha_get_monitor(struct task_struct *tsk)
+static inline struct ha_monitor *ha_get_monitor(monitor_target target)
+{
+	return to_ha_monitor(da_get_monitor(target));
+}
+
+/*
+ * ha_get_target - return the object associated to the monitor
+ */
+static inline monitor_target ha_get_target(struct ha_monitor *ha_mon)
 {
-	return to_ha_monitor(da_get_monitor(tsk));
+	/* tasks have a union, the offset of da_mon and ha_mon are the same */
+	return da_get_target((struct da_monitor *)ha_mon);
 }
 
 /*
@@ -248,12 +263,12 @@ static inline struct ha_monitor *ha_get_monitor(struct task_struct *tsk)
  * This function is called from the hook in the DA event handle function and
  * triggers a failure in the monitor.
  */
-static bool ha_monitor_handle_constraint(struct task_struct *tsk,
+static bool ha_monitor_handle_constraint(monitor_target target,
 					 enum states curr_state,
 					 enum events event,
 					 enum states next_state)
 {
-	struct ha_monitor *ha_mon = ha_get_monitor(tsk);
+	struct ha_monitor *ha_mon = ha_get_monitor(target);
 	DECLARE_SEQ_BUF(env_string, 32);
 	bool env_was_valid;
 
@@ -273,7 +288,7 @@ static bool ha_monitor_handle_constraint(struct task_struct *tsk,
 
 	ha_get_env_string(&env_string, ha_mon);
 	ha_cond_react(curr_state, event, env_string.buffer);
-	CONCATENATE(trace_error_env_, MONITOR_NAME)(tsk->pid,
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(da_get_id(target),
 			   model_get_state_name(curr_state),
 			   model_get_event_name(event),
 			   env_string.buffer);
@@ -285,12 +300,11 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *timer)
 	struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
 	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
 	DECLARE_SEQ_BUF(env_string, MAX_DA_NAME_LEN);
-	struct task_struct *tsk;
+	monitor_target target = ha_get_target(ha_mon);
 
-	tsk = container_of(ha_mon, struct task_struct, rv[task_mon_slot].ha_mon);
 	ha_get_env_string(&env_string, ha_mon);
 	ha_cond_react(curr_state, EVENT_NONE, env_string.buffer);
-	CONCATENATE(trace_error_env_, MONITOR_NAME)(tsk->pid,
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(da_get_id(target),
 		    model_get_state_name(curr_state),
 		    EVENT_NONE_LBL,
 		    env_string.buffer);
-- 
2.50.1

