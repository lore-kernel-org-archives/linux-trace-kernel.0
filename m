Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C743148A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291117; cv=none; b=hr2LI4A8B5tEYbX+6lYFJcY5QIoY00Ngi82CH4qcEgP0SU3Mdk/n2oK+TVyBvYWLsaqK8BlBI9C/5i+aW9UEJ7/52fcfCTPCiQsqXb72UtV8SX3RDIZYAAbdCY7DTMagRAyVDls1wY6+YaJdSaO07we/3uy+w+wj0kHUZZKNZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291117; c=relaxed/simple;
	bh=eONtddQQnbqYvGQ/e7DXinSw1SDyu5xqRnZ71idAMHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt1JDn7SGtkylrIBUW0Ki09Ja0U0PCdXDCu+xpqPMlJnSidQvXxKfPvlwr/fhrb9JyvaH0/60u3EwkDl5hqzKVkfRuTaF+Asa7cJQT9V6rnY4hz2tKmHcRQis/sL8X2RpEMKXNyhcuW5agPOcLEZET5viwaCBUjf6gbOGzPmfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHJyalmE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHJyalmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XecfpbbdW4OE96vMJ/b92ZmJvscUODQiqLFfBLLupG0=;
	b=VHJyalmEINatspf32p8+x7yODPAEUhXMR/F0YYeVG/FTJrGUi9WWLoLRGg8f4KOXpSuUyN
	O/nDfhBGs1bktktZ6CG96mqA5fiQvEBCRp3El1+LBQWvhArl2e4dRmcdGTyM856VnANnSO
	BQwBr0zHwJwTbKYOVkbqHTpcfjjAiXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-VqgXiSkjO6KSJhSidLveGg-1; Fri,
 19 Sep 2025 10:11:53 -0400
X-MC-Unique: VqgXiSkjO6KSJhSidLveGg-1
X-Mimecast-MFC-AGG-ID: VqgXiSkjO6KSJhSidLveGg_1758291112
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C87C180034C;
	Fri, 19 Sep 2025 14:11:52 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E47B019560BB;
	Fri, 19 Sep 2025 14:11:48 +0000 (UTC)
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
Subject: [PATCH v2 18/20] rv: Add support for per-object monitors in DA/HA
Date: Fri, 19 Sep 2025 16:09:52 +0200
Message-ID: <20250919140954.104920-19-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h      |   1 +
 include/rv/da_monitor.h | 323 +++++++++++++++++++++++++++++++++++++++-
 include/rv/ha_monitor.h |   5 +-
 3 files changed, 323 insertions(+), 6 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 90d51e00e99c..c30a78026764 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -16,6 +16,7 @@
 #define RV_MON_GLOBAL   0
 #define RV_MON_PER_CPU  1
 #define RV_MON_PER_TASK 2
+#define RV_MON_PER_OBJ  3
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index afbe0807ed11..ead24394d146 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,6 +19,8 @@
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/hashtable.h>
 
 #define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
 static struct rv_monitor rv_this;
@@ -52,11 +54,34 @@ static struct rv_monitor rv_this;
 
 /*
  * Type for the target id, default to int but can be overridden.
+ * A long type can work as hash table key (PER_OBJ) but will be downgraded to
+ * int in the event tracepoint.
+ * Unused for implicit monitors.
  */
 #ifndef da_id_type
 #define da_id_type int
 #endif
 
+/*
+ * Allow the per-object monitors to run allocation manually, necessary if the
+ * start condition is in a context problematic for allocation (e.g. scheduling).
+ * In such case, if the storage was pre-allocated without a target, set it now.
+ */
+#if RV_MON_TYPE == RV_MON_PER_OBJ
+#ifdef DA_SKIP_AUTO_ALLOC
+static inline struct da_monitor *da_fill_empty_storage(da_id_type id,
+						       monitor_target target,
+						       struct da_monitor *da_mon);
+#define da_monitor_start_hook da_fill_empty_storage
+#else
+#define da_monitor_start_hook(...) da_create_storage(__VA_ARGS__, GFP_NOWAIT)
+static inline struct da_monitor *da_create_storage(da_id_type id,
+						   monitor_target target,
+						   struct da_monitor *da_mon,
+						   gfp_t flags);
+#endif /* DA_SKIP_AUTO_ALLOC */
+#endif
+
 #ifdef CONFIG_RV_REACTORS
 
 static void cond_react(enum states curr_state, enum events event)
@@ -241,9 +266,9 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
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
@@ -255,7 +280,7 @@ static inline struct task_struct *da_get_task(struct da_monitor *da_mon)
  */
 static inline da_id_type da_get_id(struct da_monitor *da_mon)
 {
-	return da_get_task(da_mon)->pid;
+	return da_get_target(da_mon)->pid;
 }
 
 static void da_monitor_reset_all(void)
@@ -303,6 +328,220 @@ static inline void da_monitor_destroy(void)
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
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
+static inline struct da_monitor_storage *da_create_empty_storage(da_id_type id,
+								 gfp_t flags)
+{
+	struct da_monitor_storage *mon_storage;
+
+	mon_storage = kmem_cache_zalloc(da_monitor_cache, flags);
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
+						   struct da_monitor *da_mon,
+						   gfp_t flags)
+{
+	struct da_monitor_storage *mon_storage;
+
+	if (da_mon)
+		return da_mon;
+
+	mon_storage = da_create_empty_storage(id, flags);
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
+ * da_create_conditional - create the per-object storage if not already there
+ *
+ * This needs a lookup so should be guarded by RCU, the condition is checked
+ * directly in da_create_storage()
+ */
+static inline void da_create_conditional(da_id_type id, monitor_target target,
+					 gfp_t flags)
+{
+	guard(rcu)();
+	da_create_storage(id, target, da_get_monitor(id, target), flags);
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
+	da_monitor_reset(&mon_storage->rv.da_mon);
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
@@ -336,9 +575,9 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
 	return 0;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
 /*
- * Trace events for per_task monitors, report the PID of the task.
+ * Trace events for per_task/per_object monitors, report the target id.
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
@@ -531,6 +770,80 @@ static inline bool da_handle_start_run_event(struct task_struct *tsk,
 		return 0;
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
+	if (!da_monitor_enabled())
+		return 0;
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	da_mon = da_monitor_start_hook(id, target, da_mon);
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
+	if (!da_monitor_enabled())
+		return 0;
+	guard(rcu)();
+	da_mon = da_get_monitor(id, target);
+	da_mon = da_monitor_start_hook(id, target, da_mon);
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
index fb885709b727..dcc2a4d4af65 100644
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
2.51.0

