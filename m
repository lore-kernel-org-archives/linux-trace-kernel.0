Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E63ABD8C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594607; cv=none; b=MN8LKsymXSAJgYLGHnt1jhREb9MJPMkw1YJjb7ZZxClsbXJwiEcN1LufcFRBo8UMA9dZCCUJLpiilAjbreO3Hxspc78x+oMzwh8rgC7yIy4prxb5bteFd3kJOWYed9lXGgijKUWEJ/5GIRcxE43j0w+Jjt6nb/ZnBgPxVpawHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594607; c=relaxed/simple;
	bh=CMvDRt0DeiW6fF3ZAWGefoLNZkapLo3tVmsf4T9vfH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pxL9gyMOme7hgxsEK8frwetjGu/t32dnSEXUDnx6B5vwNTEivc++R3QsO1amSRyYwDhq1sJUC5SgcbCS85b8OtXMtgVpmMZRXrWZ78MIWgMq4gO/hbw21pSCwm2FPFy3XLwGaLK+ba2isBpclbrC0lnR5iSmEbDr5cCaAJA5qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K58lBvHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K58lBvHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DGmMMzpxQnJTgG2CrsqckzfULPpTAcPaW5CCkRQL0s=;
	b=K58lBvHufwSDqGWDlf2k6G0JyUuM/JrilHoEgZMa+tSyKsn4URXWDPZJbf2ciMkUMybnk5
	9Ve2DJqeAO71ZcRHBGSle7CI91YLLC/KjDvoqTCoFNysCDHY5mXjRO9ezI1o620BRw/d6O
	IWoyqlbs/YY7877vu0NftsHwxhg3Mbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-c3BNwK4KN8WRg7Eu6Q9q4g-1; Tue,
 12 May 2026 10:03:19 -0400
X-MC-Unique: c3BNwK4KN8WRg7Eu6Q9q4g-1
X-Mimecast-MFC-AGG-ID: c3BNwK4KN8WRg7Eu6Q9q4g_1778594597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D4E718005B5;
	Tue, 12 May 2026 14:03:17 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC0C21800465;
	Tue, 12 May 2026 14:03:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
Date: Tue, 12 May 2026 16:02:47 +0200
Message-ID: <20260512140250.262190-7-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: iujl3Tswhf3rd7eigLTYUyNiIJ2bqeuJqlxRgisjlVY_1778594597
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

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 23 +++++++++++++++++++----
 include/rv/ha_monitor.h | 18 ++++++++++++++++--
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index a4a13b62d1a4..402d3b935c08 100644
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
@@ -179,6 +188,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #ifndef da_implicit_guard
@@ -232,6 +242,7 @@ static inline int da_monitor_init(void)
 static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 }
 
 #ifndef da_implicit_guard
@@ -319,6 +330,7 @@ static inline void da_monitor_destroy(void)
 	}
 
 	da_monitor_reset_all();
+	da_monitor_sync_hook();
 
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
@@ -497,10 +509,9 @@ static void da_monitor_reset_all(void)
 	struct da_monitor_storage *mon_storage;
 	int bkt;
 
-	rcu_read_lock();
+	guard(rcu)();
 	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
 		da_monitor_reset(&mon_storage->rv.da_mon);
-	rcu_read_unlock();
 }
 
 static inline int da_monitor_init(void)
@@ -516,13 +527,17 @@ static inline void da_monitor_destroy(void)
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
index d59507e8cb30..47ff1a41febe 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
+#define da_monitor_sync_hook() synchronize_rcu()
 
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
@@ -237,12 +238,25 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
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
+	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
+		return;
 
+	guard(rcu)();
+	curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
+	time_ns = ha_get_ns();
 	ha_get_env_string(&env_string, ha_mon, time_ns);
 	ha_react(curr_state, EVENT_NONE, env_string.buffer);
 	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
-- 
2.54.0

