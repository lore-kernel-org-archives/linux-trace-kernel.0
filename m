Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527D3DB31F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328358; cv=none; b=Vz6wT8F8HEXWN2OVpL/z23yuFkWODMgkTAC71zB0BNfkCjhBIhFpXq6Lc+kwBNGU6fqAyaId7r+IElfvjVzDGrWgPYOzVc7CEAwaRI8voVA9k0wYTvfS3FSp64y6GUpgGfLSA/3HCWB2QGKAuXxCPMh9vQ3WjS3mvXSjC8RheJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328358; c=relaxed/simple;
	bh=XFVpsirXpCVBHRwNRxyYJEu2HnWVHve4mygjh5Big6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sfCj44Xrko9PS4vaLmoitAyRRO0KWozfH8N776HIED41CMMxCb/HGVnWOjrhfyqidBtOI/lzQEGg/JHbxpyqUw3htTWqXLdKN7deMrpZMcLNtnIdWRe/Xu45YVcbrI2ljEVUiR2wAEbImbk3wjddGLkv35nj7dmd2pkW3RnsDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g73VafnK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g73VafnK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyplG6HhVT1kgDw8Zq49+VYiEBBmCwKrGqUoIr49MPc=;
	b=g73VafnK3CPhRlZHIDHJazu6tHjaE8OGt9wgzKdhuElrtPQh5T1CQU6yH6iPrHx80ebXkz
	uBQq9j1nmSB8KEOFmr6Ns0/ge1deC3TeTydsO9UsUn+5JsA4a7LU90M5oT/0tICnbc9unk
	9QTcXVOMvrVBfhsMy8SKaEYz8Ivbrp0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-GT4jrPNANVOaX6iWxUzzGg-1; Mon,
 01 Jun 2026 11:39:12 -0400
X-MC-Unique: GT4jrPNANVOaX6iWxUzzGg-1
X-Mimecast-MFC-AGG-ID: GT4jrPNANVOaX6iWxUzzGg_1780328351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3273319560BB;
	Mon,  1 Jun 2026 15:39:11 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02623180075B;
	Mon,  1 Jun 2026 15:39:08 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 07/13] rv: Add automatic cleanup handlers for per-task HA monitors
Date: Mon,  1 Jun 2026 17:38:34 +0200
Message-ID: <20260601153840.124372-8-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sJ9Zjr52k1VI5P1U2K-UKtZaGuGRkWvWhEMyc_lv36s_1780328351
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
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ha_monitor.h                       | 60 +++++++++++++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +-
 kernel/trace/rv/monitors/opid/opid.c          |  4 +-
 kernel/trace/rv/monitors/stall/stall.c        |  4 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |  4 +-
 5 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index bd8705556..4002b5247 100644
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
 
@@ -115,6 +136,22 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
 #define ha_get_ns() 0
 #endif /* HA_CLK_NS */
 
+static int ha_monitor_init(void)
+{
+	int ret;
+
+	ret = da_monitor_init();
+	if (ret == 0)
+		ha_monitor_enable_hook();
+	return ret;
+}
+
+static void ha_monitor_destroy(void)
+{
+	ha_monitor_disable_hook();
+	da_monitor_destroy();
+}
+
 /* Should be supplied by the monitor */
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
 static bool ha_verify_constraint(struct ha_monitor *ha_mon,
@@ -200,6 +237,20 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
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
+	if (likely(da_monitoring(da_mon))) {
+		da_monitor_reset(da_mon);
+		ha_cancel_timer_sync(to_ha_monitor(da_mon));
+	}
+}
+#endif
+
 #endif /* RV_MON_TYPE */
 
 /*
@@ -412,6 +463,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -463,6 +518,10 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
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
@@ -473,6 +532,7 @@ static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
 {
 	return false;
 }
+static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
 #endif
 
 #endif
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 31f90f363..8ead8783c 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -227,7 +227,7 @@ static int enable_nomiss(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -263,7 +263,7 @@ static void disable_nomiss(void)
 	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
 	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 static struct rv_monitor rv_this = {
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 4594c7c46..2922318c6 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -73,7 +73,7 @@ static int enable_opid(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -90,7 +90,7 @@ static void disable_opid(void)
 	rv_detach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
 	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 /*
diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monitors/stall/stall.c
index 9ccfda6b0..3c38fb1a0 100644
--- a/kernel/trace/rv/monitors/stall/stall.c
+++ b/kernel/trace/rv/monitors/stall/stall.c
@@ -103,7 +103,7 @@ static int enable_stall(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -120,7 +120,7 @@ static void disable_stall(void)
 	rv_detach_trace_probe("stall", sched_switch, handle_sched_switch);
 	rv_detach_trace_probe("stall", sched_wakeup, handle_sched_wakeup);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 static struct rv_monitor rv_this = {
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index bf0999f66..889446760 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -35,7 +35,7 @@ static int enable_%%MODEL_NAME%%(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = %%MONITOR_CLASS%%_monitor_init();
 	if (retval)
 		return retval;
 
@@ -50,7 +50,7 @@ static void disable_%%MODEL_NAME%%(void)
 
 %%TRACEPOINT_DETACH%%
 
-	da_monitor_destroy();
+	%%MONITOR_CLASS%%_monitor_destroy();
 }
 
 /*
-- 
2.54.0

