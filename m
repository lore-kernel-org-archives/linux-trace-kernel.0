Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD3346FBC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863052; cv=none; b=IDbTZc/eDLsfmNkBqtPPW7QyvjQxO1l4Z7eVWnFMTEm6UlPsFSyz6aGN3RuIDUzbGslncrNe6R09xT3qIW+N9i3YNTSl1VPpn2rIL8c2PYky+Q3TdSxrSRXEry2ojQDT6/TGM6yWEnYmOBkXherdxG6rbGPwo8V1rbiG+DK41qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863052; c=relaxed/simple;
	bh=/x40mWTn6nztNyI+oLewjk2qt6XhtAUTtlMdIIP4R9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=flHRvJhwamfF3zpAO4wVP2tWUMv3M5QzkLsHSgqE+VzGEayXvB3lGJALb57/yIDfedlCyO00KS0UTkDwj5GoPG0WxL0j6mXjvcwQB3H/4c+NFy4hfOrHTX9ld5CfatJMcqfxHV1cTpEZnObkcMkk4fyO1EK5CqFOqzApFMMmumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2UgZhtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2UgZhtf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bhkp474uVy2O7GAwccoJEEMfZ0nFtAPtJP8pbK3dLS4=;
	b=S2UgZhtfBBq0Gd6CXfEuwZE0c9t3DizSXeM4E/jJ/grFJxAhYYoleMfDoM0BwavIjHTi32
	O89uqrffAgasWeFaNJtqYhMVPUM9MBUorvivmR3VR3gxheVP9WLsTlpEXanINRs+4oJKtD
	M73mtmM06RPMjM21IA36JaGzmRo4iUY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-Gjr14VVDOou_0f8bXM37cw-1; Wed,
 27 May 2026 02:24:02 -0400
X-MC-Unique: Gjr14VVDOou_0f8bXM37cw-1
X-Mimecast-MFC-AGG-ID: Gjr14VVDOou_0f8bXM37cw_1779863041
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD6831956095;
	Wed, 27 May 2026 06:24:00 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69400180034E;
	Wed, 27 May 2026 06:23:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 08/12] rv: Ensure synchronous cleanup for HA monitors
Date: Wed, 27 May 2026 08:23:08 +0200
Message-ID: <20260527062313.39908-9-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BarjejRpQY9gZ14SmUw7h3jU2xxdW1MRpDDOsKO9fmM_1779863041
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
code if the monitor is marked as disabled.
Use memory barriers to serialise with racing resets.

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 26 +++++++++++++++++++++-----
 include/rv/ha_monitor.h | 19 +++++++++++++++++--
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index c1e347f9deaf..268f22933663 100644
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
@@ -83,7 +92,8 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
 	da_monitor_reset_hook(da_mon);
 	WRITE_ONCE(da_mon->monitoring, 0);
-	da_mon->curr_state = model_get_initial_state();
+	/* Pair with load in __ha_monitor_timer_callback */
+	smp_store_release(&da_mon->curr_state, model_get_initial_state());
 }
 
 /*
@@ -181,6 +191,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #ifndef da_implicit_guard
@@ -234,6 +245,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #ifndef da_implicit_guard
@@ -324,6 +336,7 @@ static inline void da_monitor_destroy(void)
 	}
 
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 
 	tracepoint_synchronize_unregister();
 	rv_put_task_monitor_slot(task_mon_slot);
@@ -503,10 +516,9 @@ static void da_monitor_reset_all(void)
 	struct da_monitor_storage *mon_storage;
 	int bkt;
 
-	rcu_read_lock();
+	guard(rcu)();
 	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
 		da_monitor_reset(&mon_storage->rv.da_mon);
-	rcu_read_unlock();
 }
 
 static inline int da_monitor_init(void)
@@ -522,13 +534,17 @@ static inline void da_monitor_destroy(void)
 	int bkt;
 
 	tracepoint_synchronize_unregister();
+	scoped_guard(rcu) {
+		hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
+			da_monitor_reset_hook(&mon_storage->rv.da_mon);
+		}
+	}
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
index d59507e8cb30..661631bc933a 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
+#define da_monitor_sync_hook() synchronize_rcu()
 
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
@@ -237,12 +238,26 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 	return false;
 }
 
+/*
+ * __ha_monitor_timer_callback - generic callback representation
+ *
+ * This callback runs in an RCU read-side critical section to allow the
+ * destruction sequence to easily synchronize_rcu() with all pending timer
+ * after asynchronously disabling them.
+ */
 static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
 {
-	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
 	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
-	u64 time_ns = ha_get_ns();
+	enum states curr_state;
+	u64 time_ns;
+
+	guard(rcu)();
+	/* Ensure consistent curr_state if we race with da_monitor_reset */
+	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
+	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
+		return;
 
+	time_ns = ha_get_ns();
 	ha_get_env_string(&env_string, ha_mon, time_ns);
 	ha_react(curr_state, EVENT_NONE, env_string.buffer);
 	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
-- 
2.54.0

