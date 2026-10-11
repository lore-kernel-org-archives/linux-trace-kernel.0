Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8943F8C8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747603; cv=none; b=G/aXgRwRhvvB2ZkJCkJufpZ0YB4MhjHwpj3nm5ykf8u8UkoAI3+v4SYd/lygizvFIuvCK4F8FylYH9RDaJZvIT7mCPldGnqu3nD2xK1Wpaz9kdf6Yj234zAnsapxavNoncWv8PFbG9SyrLiCfEdE4vA+Csk4lvJDhAlPqd1h55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747603; c=relaxed/simple;
	bh=xJa1S78kgLd5iI418n5+Jw8qHQXhEiD9EZOWTmqXZtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYDdX/jEPTrzSMiDkUK+VOXht5U8s/c+7/c51Sns2CYP3lGRtIfqL2jXaeDhTPEcDjRPetsEUDqyVu5JPoBDhLGvYdVlx7Cu15IpGhL23EPvoFuzdk5M1GFeRQu0GeaK/PXHZn/XN/5kp+EA78N3Gd8Y9Rq9UAN4BvLjQ771jpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ewDIwFpb; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ewDIwFpb"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xJa1S78kgLd5iI418n5+Jw8qHQXhEiD9EZOWTmqXZtQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747599; v=1; x=1792352399;
 b=ewDIwFpbfwNHx5MNxfm/EQ6kAM1myArOa5c/jaDE1X8rUs9fwVvRKQksQBkGMOQ5TopcYUmk
 SQ30UQbquee6BldFNxf5/1gpuU0bnD/eT/flYmDybGUQWoswmug2fFR5wt8xH5zcP402WDrxlKL
 h4e+gpeO5g5aPp+0G7cuP3lA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9812df779db0045a;
	Sun, 11 Oct 2026 19:39:59 +0000
X-Mizu-Trace-ID: 9812df779db0045a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 04/14] rv: Disarm HA timers on the storage free path
Date: Mon, 12 Oct 2026 03:39:10 +0800
Message-Id: <3d5a8a567f1c1921f725c31a780845ff23e5abb9.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

da_destroy_storage() cancels the HA timer through da_monitor_reset_hook()
and only then unlinks the storage with hash_del_rcu().  A handler on
another CPU that looked the storage up before the unlink can still call
ha_start_timer_*() after the cancel.  The timer then stays queued on a
storage that kfree_rcu() frees a grace period later, and fires on freed
memory, reporting a violation for an object that no longer exists.

A monitor cannot close this from its own handlers: any cancel it issues
precedes the unlink.  The first point no reader can race with is the
RCU callback that frees the storage.

Add da_monitor_free_hook(), called right before a per-object storage is
freed, from the RCU callback and from da_monitor_destroy().  HA monitors
implement it with ha_cancel_timer_sync().  Replace kfree_rcu() with
call_rcu() so there is a callback to hook.

A storage whose monitor never started has a zeroed timer, and
hrtimer_cancel() dereferences timer->base.  nomiss pre-creates one such
storage per possible CPU.  Skip them with the new ha_timer_ready().

Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 23 ++++++++++++++++++++++-
 include/rv/ha_monitor.h | 26 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index e3cf85c9ce55..2cd260208bc1 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -67,6 +67,17 @@ static struct rv_monitor rv_this;
 #define da_monitor_sync_hook()
 #endif
 
+/*
+ * Called on the last reference to a storage, right before it is freed.
+ * Monitors embedding a timer disarm it here: an earlier point races with a
+ * reader that resolved the storage before hash_del_rcu(), and
+ * tracepoint_synchronize_unregister() only covers tracepoint probes.
+ * Default: no-op.
+ */
+#ifndef da_monitor_free_hook
+#define da_monitor_free_hook(da_mon)
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  * A long type can work as hash table key (PER_OBJ) but will be downgraded to
@@ -543,6 +554,15 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
 	return mon_storage->target;
 }
 
+static void da_kfree_cb(struct rcu_head *head)
+{
+	struct da_monitor_storage *ms =
+		container_of(head, struct da_monitor_storage, rcu);
+
+	da_monitor_free_hook(&ms->rv.da_mon);
+	kfree(ms);
+}
+
 /*
  * da_destroy_storage - destroy the per-object storage
  *
@@ -564,7 +584,7 @@ static inline void da_destroy_storage(da_id_type id)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
-	kfree_rcu(mon_storage, rcu);
+	call_rcu(&mon_storage->rcu, da_kfree_cb);
 }
 
 static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
@@ -607,6 +627,7 @@ static inline void da_monitor_destroy(void)
 	 * pending, we can safely assume no concurrent user.
 	 */
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
+		da_monitor_free_hook(&mon_storage->rv.da_mon);
 		hash_del_rcu(&mon_storage->node);
 		kfree(mon_storage);
 	}
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 499ce60779f9..99b60d0d26b6 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -29,6 +29,8 @@ static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
 static inline void ha_setup_timer(struct ha_monitor *ha_mon);
 static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
+static inline bool ha_timer_ready(struct ha_monitor *ha_mon);
+static inline void ha_monitor_free_env(struct da_monitor *da_mon);
 static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 enum states curr_state,
 					 enum events event,
@@ -38,6 +40,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
 #define da_monitor_sync_hook() synchronize_rcu()
+#define da_monitor_free_hook ha_monitor_free_env
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
 /*
@@ -467,8 +470,15 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return timer_delete(&ha_mon->timer);
 }
+/* timer_setup() sets it; the cancel paths here never clear it. */
+static inline bool ha_timer_ready(struct ha_monitor *ha_mon)
+{
+	return READ_ONCE(ha_mon->timer.function);
+}
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
 {
+	if (!ha_timer_ready(ha_mon))
+		return;
 	timer_delete_sync(&ha_mon->timer);
 }
 #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
@@ -524,8 +534,18 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
 }
+/*
+ * hrtimer_cancel() reads timer->base before anything else; a zeroed timer
+ * has it NULL and would fault.
+ */
+static inline bool ha_timer_ready(struct ha_monitor *ha_mon)
+{
+	return READ_ONCE(ha_mon->hrtimer.base);
+}
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
 {
+	if (!ha_timer_ready(ha_mon))
+		return;
 	hrtimer_cancel(&ha_mon->hrtimer);
 }
 #else /* HA_TIMER_NONE */
@@ -538,9 +558,15 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline bool ha_timer_ready(struct ha_monitor *ha_mon) { return false; }
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
+static inline void ha_monitor_free_env(struct da_monitor *da_mon)
+{
+	ha_cancel_timer_sync(to_ha_monitor(da_mon));
+}
+
 #if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
 #ifdef RV_MON_OPS_INIT
 #undef RV_MON_OPS_INIT
-- 
2.25.1

