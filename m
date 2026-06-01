Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E43DC84C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328363; cv=none; b=KtRcgPexaV7tiLRx27vWXY31lkT3oNQlljKW7w3Movf/4Mr5Rle+LwARwarPTlKol7x4nEOzVg4GNedQgkmS/7YXNXyfpvxrTf2UgMknoe3bRwh3Q+1qXa/CO21j+YKmwam/GnAPohQzv49myUs5nTZ8O97jQxNbt5rTj8GQOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328363; c=relaxed/simple;
	bh=PMlgRCYhyNtdh+bETPsY60G3qbAEez425Ow7MttAeCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NyidXk31FAlE/6zBveQ/3hU1gGGZUDtMIdH31mA9TNwbNSscVcPNTPrZAq8xnDrSKo8P8K1GbaaydXEz4ViBpYAdTVJjR5Yq2Gdaa+lZ1l7VOpgA7b2QE2r7+N4XrZWSeNEInOT/BjYCTqZgnYM4fLN5Uit2/z82afRuEP+eBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLDUhj6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLDUhj6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksjWZwFOwjAtg9cSIKj8AwnZ/7m3CqPw5YL+YlR1pw4=;
	b=VLDUhj6CeSFILfJaWx1+/RFpQl8mH58l55vVI+/PzY6mvIE6WNYxILli2BMyMS96eJACdB
	u8uzS4nSmlHeR+BSf5WLA8ZGLF5Vliiq5PkatbsgtQnriMMgeNkHSuOPKEV5/q+2+EUZCr
	3mWEY23JFlSCumUdTJ7KfBgAjcapisg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-e4Hxa7AAMuiMiHitquvvcQ-1; Mon,
 01 Jun 2026 11:39:15 -0400
X-MC-Unique: e4Hxa7AAMuiMiHitquvvcQ-1
X-Mimecast-MFC-AGG-ID: e4Hxa7AAMuiMiHitquvvcQ_1780328354
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27ED419560BA;
	Mon,  1 Jun 2026 15:39:14 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B1501800577;
	Mon,  1 Jun 2026 15:39:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 08/13] rv: Ensure synchronous cleanup for HA monitors
Date: Mon,  1 Jun 2026 17:38:35 +0200
Message-ID: <20260601153840.124372-9-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0lHqkZaTun2jI1F5QLIrc0WjTCo3-XwMm0WiUhXvxTY_1780328354
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

HA monitors may start timers, all cleanup functions currently stop the
timers asynchronously to avoid sleeping in the wrong context.
Nothing makes sure running callbacks terminate on cleanup.

Run the entire HA timer callback in an RCU read-side critical section,
this way we can simply synchronize_rcu() with any pending timer and are
sure any cleanup using kfree_rcu() runs after callbacks terminated.
Additionally make sure any unlikely callback running late won't run any
code if the monitor is marked as disabled or if destruction started.
Use memory barriers to serialise with racing resets.

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 19 ++++++++++++++++---
 include/rv/ha_monitor.h | 29 ++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ec9bc88bd..1f440c781 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -57,6 +57,15 @@ static struct rv_monitor rv_this;
 #define da_monitor_reset_hook(da_mon)
 #endif
 
+/*
+ * Hook to allow the implementation of hybrid automata: define it with a
+ * function that waits for the termination of all monitors background
+ * activities (e.g. all timers). This hook can sleep.
+ */
+#ifndef da_monitor_sync_hook
+#define da_monitor_sync_hook()
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  * A long type can work as hash table key (PER_OBJ) but will be downgraded to
@@ -82,7 +91,8 @@ static void react(enum states curr_state, enum events event)
 static inline void da_monitor_reset_state(struct da_monitor *da_mon)
 {
 	WRITE_ONCE(da_mon->monitoring, 0);
-	da_mon->curr_state = model_get_initial_state();
+	/* Pair with load in __ha_monitor_timer_callback */
+	smp_store_release(&da_mon->curr_state, model_get_initial_state());
 }
 
 /*
@@ -205,6 +215,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_CPU
@@ -270,6 +281,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_TASK
@@ -367,6 +379,7 @@ static inline void da_monitor_destroy(void)
 
 	tracepoint_synchronize_unregister();
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
@@ -573,13 +586,13 @@ static inline void da_monitor_destroy(void)
 	int bkt;
 
 	tracepoint_synchronize_unregister();
+	da_monitor_reset_all();
+	da_monitor_sync_hook();
 	/*
 	 * This function is called after all probes are disabled and no longer
 	 * pending, we can safely assume no concurrent user.
 	 */
-	synchronize_rcu();
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
-		da_monitor_reset_hook(&mon_storage->rv.da_mon);
 		hash_del_rcu(&mon_storage->node);
 		kfree(mon_storage);
 	}
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 4002b5247..28d3c74ca 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -37,6 +37,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
+#define da_monitor_sync_hook() synchronize_rcu()
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
 /*
@@ -136,10 +137,13 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
 #define ha_get_ns() 0
 #endif /* HA_CLK_NS */
 
+static bool ha_mon_destroying;
+
 static int ha_monitor_init(void)
 {
 	int ret;
 
+	WRITE_ONCE(ha_mon_destroying, false);
 	ret = da_monitor_init();
 	if (ret == 0)
 		ha_monitor_enable_hook();
@@ -148,6 +152,7 @@ static int ha_monitor_init(void)
 
 static void ha_monitor_destroy(void)
 {
+	WRITE_ONCE(ha_mon_destroying, true);
 	ha_monitor_disable_hook();
 	da_monitor_destroy();
 }
@@ -288,12 +293,30 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 	return false;
 }
 
+/*
+ * __ha_monitor_timer_callback - generic callback representation
+ *
+ * This callback runs in an RCU read-side critical section to allow the
+ * destruction sequence to easily synchronize_rcu() with all pending timers
+ * after asynchronously disabling them. The ha_mon_destroying check ensures
+ * any callback entering the RCU section after synchronize_rcu() completes
+ * will see the flag and bail out immediately.
+ */
 static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
 {
-	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
 	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
-	u64 time_ns = ha_get_ns();
-
+	enum states curr_state;
+	u64 time_ns;
+
+	guard(rcu)();
+	if (unlikely(READ_ONCE(ha_mon_destroying)))
+		return;
+	/* Ensure consistent curr_state if we race with da_monitor_reset */
+	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
+	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
+		return;
+
+	time_ns = ha_get_ns();
 	ha_get_env_string(&env_string, ha_mon, time_ns);
 	ha_react(curr_state, EVENT_NONE, env_string.buffer);
 	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
-- 
2.54.0

