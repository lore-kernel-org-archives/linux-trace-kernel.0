Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66C34FF62
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863058; cv=none; b=RhpTIX/uCL33oOjDAwPZdSJoopo9nY7N10jv8HW2x5zPInpjn4WKDpsv0ldVtojpmk+G4VrAymY834As4CKRwhB5pewA8EsdRaue5wW+0Do7RkIFKy0Hrbr6MnqyfWdwKpSxEIW4fxpP1kGoGvUSK7P/HQ2SkX5rOaCRRxxqwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863058; c=relaxed/simple;
	bh=KAB3uHGRFOkPEu4Za3teW3oTV4PlC3OgrbcOogXz/a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JNpPSMj3ZLQ2pesvyDr03zBzxZmSHM0odqWP6d5qczHO7dVgYv1RW7VOcfU7LGAEgqjonFpUsxkURqohCrD+LhEbxzips5gDLYtvbMB6nTiFHnKvrjVx3tjbOxA/agJYWrJE5ZnT0ESWp/7s1V4Y4siKz/kb2g+X/VSn60HSGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSrI5WmJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSrI5WmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBb8SPdmZX6C/eeUu4Za00zt1HH8qUbYwYSKQs8ksR8=;
	b=HSrI5WmJDG4L4SRBVamde6Y0AIfuUY6jauhm8C/FeoGoX7ovwv01xqEc9XEs88mXXgvl1e
	GZu0hINCrFA0KOx8lqeyhYs47qem28i6yqP560M2756LjVnctDTG89SzDTwgDqFrOgsBbe
	/j8M+AK7oI41VGvfSBwkI0yiQYheMuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-a3hBaCCLOhqvxsrOIDUsfQ-1; Wed,
 27 May 2026 02:24:09 -0400
X-MC-Unique: a3hBaCCLOhqvxsrOIDUsfQ-1
X-Mimecast-MFC-AGG-ID: a3hBaCCLOhqvxsrOIDUsfQ_1779863048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BF001956048;
	Wed, 27 May 2026 06:24:08 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FE14180034E;
	Wed, 27 May 2026 06:24:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 10/12] rv: Add automatic cleanup handlers for per-task HA monitors
Date: Wed, 27 May 2026 08:23:10 +0200
Message-ID: <20260527062313.39908-11-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: s29bw39JAUgA5_AtmJbLVIcGcoMEYkUPpI__o2Nd9bE_1779863048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hybrid automata monitors may start timers, depending on the model, these
may remain active on an exiting task and cause false positives or even
access freed memory.

Add an enable/disable hook in the HA code, currently only populated by
the per-task handler for registration and deregistration.
This hooks to the sched_process_exit event and ensures the timer is
stopped for every exiting task. The handler is enabled automatically but
may be disabled, for instance if the monitor uses the event for another
purpose (but should still manually ensure timers are stopped).

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ha_monitor.h | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 2d7187c16f55..df67d5e9d132 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -28,6 +28,7 @@ static inline void ha_monitor_init_env(struct da_monitor *da_mon);
 static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
 static inline void ha_setup_timer(struct ha_monitor *ha_mon);
 static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
 static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 enum states curr_state,
 					 enum events event,
@@ -38,6 +39,26 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_reset_hook ha_monitor_reset_env
 #define da_monitor_sync_hook() synchronize_rcu()
 
+#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
+/*
+ * Automatic cleanup handlers for per-task HA monitors, only skip if you know
+ * what you are doing (e.g. you want to implement cleanup manually in another
+ * handler doing more things).
+ */
+static void ha_handle_sched_process_exit(void *data, struct task_struct *p,
+					 bool group_dead);
+
+#define ha_monitor_enable_hook()                                             \
+	rv_attach_trace_probe(__stringify(MONITOR_NAME), sched_process_exit, \
+			      ha_handle_sched_process_exit)
+#define ha_monitor_disable_hook()                                            \
+	rv_detach_trace_probe(__stringify(MONITOR_NAME), sched_process_exit, \
+			      ha_handle_sched_process_exit)
+#else
+#define ha_monitor_enable_hook() ((void)0)
+#define ha_monitor_disable_hook() ((void)0)
+#endif
+
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
 
@@ -124,12 +145,15 @@ static int ha_monitor_init(void)
 
 	ha_mon_initializing = true;
 	ret = da_monitor_init();
+	if (ret == 0)
+		ha_monitor_enable_hook();
 	ha_mon_initializing = false;
 	return ret;
 }
 
 static void ha_monitor_destroy(void)
 {
+	ha_monitor_disable_hook();
 	da_monitor_destroy();
 }
 
@@ -230,6 +254,18 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
 {
 	CONCATENATE(trace_error_env_, MONITOR_NAME)(id, curr_state, event, env);
 }
+
+#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
+static void ha_handle_sched_process_exit(void *data, struct task_struct *p,
+					 bool group_dead)
+{
+	struct da_monitor *da_mon = da_get_monitor(p);
+
+	if (likely(!ha_monitor_uninitialized(da_mon)))
+		ha_cancel_timer_sync(to_ha_monitor(da_mon));
+}
+#endif
+
 #endif /* RV_MON_TYPE */
 
 /*
@@ -456,6 +492,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return timer_delete(&ha_mon->timer);
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
+{
+	timer_delete_sync(&ha_mon->timer);
+}
 #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
 /*
  * Helper functions to handle the monitor timer.
@@ -507,6 +547,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
+{
+	hrtimer_cancel(&ha_mon->hrtimer);
+}
 #else /* HA_TIMER_NONE */
 /*
  * Start function is intentionally not defined, monitors using timers must
@@ -517,6 +561,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
 #endif
-- 
2.54.0

