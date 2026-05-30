Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE737AA8C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150647; cv=none; b=hYVc+XD+DgVde+Jb62WcT8+uaqbRJ6UWSZxFt1jm8G8lOmnwZSR+vC/WMcedVArHpDzEkrnvll5ij0UnX6oLZZgtDyBjFzqCiDo9F9AjItrN2p1IfE0dfui5ScBwcuJHTJp491EeItfOl3IuMwNACW0yr+2yVsK7hnOZYCMlPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150647; c=relaxed/simple;
	bh=qi0L9LIA+fI+0b7vwfe1ljJPHVtvHgwWYrpe/8OqpLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Eyq78SC5P2iGmPnTz12yLUaW+Mz+rFNVfUJ0LcbvXDBbmnLhebNzca6DDtEaAVBcNqrLUr2RAS/SlXjDuHB/ojaX59RHghNbxH+v+O/0ts3IigydHVe1PX2GD7QUu4zDGBecon3cjVqX6iL8ur3kXW837syWTwkdAXQZ92yQ0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8JjJcb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8JjJcb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT4w/Ow74J+m2Lbf9BXQF20oc8LgcRemn11BpAcG52I=;
	b=e8JjJcb5+XxQlUhIPKdWjDTb8p947co/aLYKeuT83uqAwbAo0csNf8q/U8eZe6+xGqwPVg
	fGmnD8IN/XqTkV1lhk+wXUj9FKg495eDV9214Y1Pi/jSOoilCF1RYhM8F6vnUx4St5VRAv
	9fbjhJ9qIQi0xp/Riab6SR6TdXcWDj8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-W4XU2b56NxWmiQtTvQvq8g-1; Sat,
 30 May 2026 10:17:21 -0400
X-MC-Unique: W4XU2b56NxWmiQtTvQvq8g-1
X-Mimecast-MFC-AGG-ID: W4XU2b56NxWmiQtTvQvq8g_1780150640
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F95B195608C;
	Sat, 30 May 2026 14:17:20 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D22853002D2D;
	Sat, 30 May 2026 14:17:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 07/13] rv: Add automatic cleanup handlers for per-task HA monitors
Date: Sat, 30 May 2026 16:16:46 +0200
Message-ID: <20260530141652.58084-8-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: wAr3CAkc_0BWV63C-3LU5T9xsBt4psgwE5jtec9FKaw_1780150640
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
index ad3347af1..0aeb6bc38 100644
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
@@ -37,6 +38,26 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 #define da_monitor_init_hook ha_monitor_init_env
 #define da_monitor_reset_hook ha_monitor_reset_env
 
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
 
@@ -123,12 +144,15 @@ static int ha_monitor_init(void)
 
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
 
@@ -229,6 +253,18 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
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
@@ -441,6 +477,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -492,6 +532,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -502,6 +546,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
 #endif
-- 
2.54.0

