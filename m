Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084E3A7D65
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594614; cv=none; b=qyujbLVgkr6sX3VViRxpj4/0LoMLruoZjxl60VLlhjx746l6qooFFLolmRuMCRPl8YAC58b4sdUQfG3ErwCRMNsvF7JRJ3rHvv6yZG3mT3pzA/y5ymMY37s3Xl38KHS8ryXHsxePh4FppjR9QfpMZyEgmwh23Xcgp4e21pME5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594614; c=relaxed/simple;
	bh=GAomGDFN+V8Bk7b2EiA0gaFkeifiLuHq+9BUu3PJp2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AX1c+ykXOcGCSyvExoEKqaomHXXPoyL77IdZiVi1eZqJDAx17lr0kQkQqb2i+W5i9J24mUZhJrkmJrXGwJhDD7VZ40Z9BkHmpIas3VGeNafej9UedYEdNAv9Re0o3oMqK917QFFkURd2Fl7QZKK3jsN/B5CBQMElz6PzYTAmOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwa4bX1X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwa4bX1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUIyfZL4degM0iStc9eEuLhlJ1lbfvR/WbnZNVjPTkY=;
	b=Bwa4bX1XFiYaZYkOLKPE9drfzAqZg+Alpe8pgMrB8JFMMpdhX3RXv1imdtJXnj6Z1NGpFr
	ATP48hCsjVs2PukVARK7eyxwePVlnPTL9w/72VdWguuUBHx96tBelgtHNZrycnZiUldT17
	0b5KdodNlW9UysTjsXnwoX3FiFT4J3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-T5Hf88CuOiGy_6ngOOv5FA-1; Tue,
 12 May 2026 10:03:26 -0400
X-MC-Unique: T5Hf88CuOiGy_6ngOOv5FA-1
X-Mimecast-MFC-AGG-ID: T5Hf88CuOiGy_6ngOOv5FA_1778594604
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B9B19560A5;
	Tue, 12 May 2026 14:03:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E1A91800465;
	Tue, 12 May 2026 14:03:22 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 8/9] rv: Add automatic cleanup handlers for per-task HA monitors
Date: Tue, 12 May 2026 16:02:49 +0200
Message-ID: <20260512140250.262190-9-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: thdv3Ls5LTVKUBmsZMR3x3JmOLGe0DwUCymVDNk9O08_1778594604
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
 include/rv/ha_monitor.h | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 11ae85bad492..1bdf866e9c63 100644
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
+#define ha_monitor_enable_hook()
+#define ha_monitor_disable_hook()
+#endif
+
 #include <rv/da_monitor.h>
 #include <linux/seq_buf.h>
 
@@ -124,12 +145,14 @@ static int ha_monitor_init(void)
 
 	ha_mon_initializing = true;
 	ret = da_monitor_init();
+	ha_monitor_enable_hook();
 	ha_mon_initializing = false;
 	return ret;
 }
 
 static void ha_monitor_destroy(void)
 {
+	ha_monitor_disable_hook();
 	da_monitor_destroy();
 }
 
@@ -230,6 +253,18 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
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
@@ -455,6 +490,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -506,6 +545,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -516,6 +559,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
 #endif
-- 
2.54.0

