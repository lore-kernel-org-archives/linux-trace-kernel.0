Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901001;
	b=JAyIQVarnSaiKJ+gLhAhJNxohuGRgDBmiQJjJy+tVj/YQfWAT0+OSU9MinLegc9OEg6o
	 kaO9/WVUNj02bfFFtw0HyokrQt40NGdZ5aDKNk7PKFAp53ViA61lyN/g5Jmi2efJYwJGw
	 Qqk6VwDQ+quEMjKfxjBSoV9SDxH9+niQt5QR6WPR9x3/AcDLGwMDCBXZXy3ZC71kGtcs0
	 /7cCCQpibJdfDU7BeX7Fv3vjS/ojMf+i0v+J9SVEk7w65RMlOL+EF56mMpPqkHamorP2F
	 uMDBwjn2RT/HExUEVOJJvXQ4z2JV1TdDAjCBVOuDVol9pBeoD/mKubujvSHUeljad/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901001;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hTGJoq3955CxspIe6be6rkqAwYAo3cb96PShD43Nfd8=;
	b=dqbzaY6/rqRtps4HN2oxfkzPsTnNV2kCFGUTVoZMpPHCacTCYj5kIZV3fdE9zhBegKDb
	 C44QpLCm6gDo4aq2TT4imH/gU7Rsya7fbDIRsqBWzahTzxFS3IivYody7hfYtlC+nUZTA
	 1H037pfdnp8BX/o3yRFKKVUsL2Ca1GOGd1H5ncbiV6Bx/Kmce6S2qcLQrYBgCNqvf5a16
	 Vc4kArVmgIHBhZsrnVt/yZNbe4EKs0mLiUdXNJwZjvs6RneQ2oeShLFuF3x8943aVTw0s
	 MKO/4CUFFDT6Oo5AdTvveTqNGZc+sw62qIJvtgKDBcYaEcJBqCMkNXUSvomBn/z03bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PjZXVsay;
	arc=none smtp.remote-ip=95.215.58.204
Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D643606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D643606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PjZXVsay
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aHnXes3wPnd6DmmE3tkpKV0ocYU8WouThoXA7mMhHLA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793900998; v=1; x=1794505798;
 b=PjZXVsaydGUIcy40e+fYWjOz+boJ3tSPpp+bMQQN39MOMYYyU2ImfDYzGIyWhgM8zTQH3oOH
 Ps/m58dhThuv7/MsLo2nUoRye/F13EhGWS4vSDhoJyjF2vmD5lUkcLdWheUQ7HuKL7JCvW87fmd
 onfUhxrnpJSTpb2zAFwpT/YE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id cc8a511b2a2bff4e;
	Thu, 05 Nov 2026 17:49:58 +0000
X-Mizu-Trace-ID: cc8a511b2a2bff4e
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 04/14] rv: Disarm HA timers on the storage free path
Date: Fri,  6 Nov 2026 01:49:04 +0800
Message-Id: <0ab3632933008e028855e158b4b978881a2715dc.1793900349.git.wen.yang@linux.dev>
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
implement it by calling ha_cancel_timer_sync() if da_monitoring() is true.
Replace kfree_rcu() with call_rcu() so there is a callback to hook.

Cancelling synchronously from the RCU callback is safe: HA hrtimers are
always armed in HARD mode, so hrtimer_cancel() only spins, and on
PREEMPT_RT, where timer_delete_sync() may sleep, RCU callbacks run in
the rcuc kthread.

Storages whose monitor never started are skipped via da_monitoring().

Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 27 ++++++++++++++++++++++++++-
 include/rv/ha_monitor.h |  8 ++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index e3cf85c9ce55..c7f9733fb8a4 100644
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
@@ -564,7 +584,11 @@ static inline void da_destroy_storage(da_id_type id)
 		return;
 	da_monitor_reset_hook(&mon_storage->rv.da_mon);
 	hash_del_rcu(&mon_storage->node);
-	kfree_rcu(mon_storage, rcu);
+	/*
+	 * A reader from before hash_del_rcu() may still arm; the free
+	 * callback runs past it, so the hook disarms there.
+	 */
+	call_rcu(&mon_storage->rcu, da_kfree_cb);
 }
 
 static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
@@ -607,6 +631,7 @@ static inline void da_monitor_destroy(void)
 	 * pending, we can safely assume no concurrent user.
 	 */
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
+		da_monitor_free_hook(&mon_storage->rv.da_mon);
 		hash_del_rcu(&mon_storage->node);
 		kfree(mon_storage);
 	}
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index ebb7f91e3447..3bf1dd15544c 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -29,6 +29,7 @@ static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
 static inline void ha_setup_timer(struct ha_monitor *ha_mon);
 static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
+static inline void ha_monitor_free_env(struct da_monitor *da_mon);
 static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 enum states curr_state,
 					 enum events event,
@@ -38,6 +39,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
 #define da_monitor_sync_hook() synchronize_rcu()
+#define da_monitor_free_hook ha_monitor_free_env
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
 /*
@@ -551,6 +553,12 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
+static inline void ha_monitor_free_env(struct da_monitor *da_mon)
+{
+	if (da_monitoring(da_mon))
+		ha_cancel_timer_sync(to_ha_monitor(da_mon));
+}
+
 #if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
 #ifdef RV_MON_OPS_INIT
 #undef RV_MON_OPS_INIT
-- 
2.25.1

