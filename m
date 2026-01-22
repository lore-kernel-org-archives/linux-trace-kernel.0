Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A64DBD8A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097339; cv=none; b=GXSjuPpCoiyoKB+64T1Ah1Rh6mtEpQsxpeIOK1JLLBNCv7WmegzBqVRHxGbGi13gag3U6BtHy3EEmN1vJX8na/M6RFrp/6kMGId+5ordIqfjJKmR0rq8v2mQgvGHFgeZn1gGuUyQrLINaI10p1TUHLdaL9njqDhcT/lNWLM7dGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097339; c=relaxed/simple;
	bh=s3ADJtY0+yGWnX7tpu+Kt1x8FPfpJO5oWp5MsYQGCG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERexDwM8dZsAaMfKikStG0Hx5ERoe1e91KBzQEyt5N+o6Dar4yLMV2YXHM/hRMdZnaz4AwdFl5L2Sbi8tF8yHTU9MkeTTlQoxvA+G/6zrYWvYRs9VxejXPVov9+MTM8oiVeG2cPJAsixe1l8N03dLmySBfA3059mhsQDeKMetnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkyQISmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkyQISmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769097324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+LjyiQb9hCJJQqNBdbvANbfbGtWkhWvx0xT/kBtlCM=;
	b=JkyQISmEbLra0niVy2PLTAR5wSsYBPBUXYOnnmZmea5ClN2kZdlS0DpIglaKNbiMhxsusZ
	4Mt5TbdEV2WN5wtRpldm/9jL3ECp1P4RvzXkdmzNjh9sxnPQxNOQTjjs8P/WEy7Oeoqpz6
	2Z7otKOkWZ0Fu+ZCa/7cdDVyOVBQtiA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-wEZYh3VcPXGVdtnMVKRuTw-1; Thu,
 22 Jan 2026 10:55:16 -0500
X-MC-Unique: wEZYh3VcPXGVdtnMVKRuTw-1
X-Mimecast-MFC-AGG-ID: wEZYh3VcPXGVdtnMVKRuTw_1769097316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C66FC1955D9D;
	Thu, 22 Jan 2026 15:55:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57D3A180049F;
	Thu, 22 Jan 2026 15:55:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 01/15] rv: Unify DA event handling functions across monitor types
Date: Thu, 22 Jan 2026 16:54:46 +0100
Message-ID: <20260122155500.362683-2-gmonaco@redhat.com>
In-Reply-To: <20260122155500.362683-1-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The DA event handling functions are mostly duplicated because the
per-task monitors need to propagate the task struct while others do not.

Unify the functions, handle the difference by always passing an
identifier which is the task's pid for per-task monitors but is ignored
for the other types. Only keep the actual tracepoint calling separated.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V3:
    * Rearrange start/handle helpers to share more code

 include/rv/da_monitor.h | 303 +++++++++++++++++-----------------------
 1 file changed, 132 insertions(+), 171 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 7b28ef9f73bd..6b564fad8c4d 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -22,6 +22,13 @@
 
 static struct rv_monitor rv_this;
 
+/*
+ * Type for the target id, default to int but can be overridden.
+ */
+#ifndef da_id_type
+#define da_id_type int
+#endif
+
 static void react(enum states curr_state, enum events event)
 {
 	rv_react(&rv_this,
@@ -91,90 +98,6 @@ static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
 	return 1;
 }
 
-#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
-/*
- * Event handler for implicit monitors. Implicit monitor is the one which the
- * handler does not need to specify which da_monitor to manipulate. Examples
- * of implicit monitor are the per_cpu or the global ones.
- *
- * Retry in case there is a race between getting and setting the next state,
- * warn and reset the monitor if it runs out of retries. The monitor should be
- * able to handle various orders.
- */
-
-static inline bool da_event(struct da_monitor *da_mon, enum events event)
-{
-	enum states curr_state, next_state;
-
-	curr_state = READ_ONCE(da_mon->curr_state);
-	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
-		next_state = model_get_next_state(curr_state, event);
-		if (next_state == INVALID_STATE) {
-			react(curr_state, event);
-			CONCATENATE(trace_error_, MONITOR_NAME)(
-				    model_get_state_name(curr_state),
-				    model_get_event_name(event));
-			return false;
-		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
-			CONCATENATE(trace_event_, MONITOR_NAME)(
-				    model_get_state_name(curr_state),
-				    model_get_event_name(event),
-				    model_get_state_name(next_state),
-				    model_is_final_state(next_state));
-			return true;
-		}
-	}
-
-	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
-	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
-		" retries reached for event %s, resetting monitor %s",
-		model_get_event_name(event), __stringify(MONITOR_NAME));
-	return false;
-}
-
-#elif RV_MON_TYPE == RV_MON_PER_TASK
-/*
- * Event handler for per_task monitors.
- *
- * Retry in case there is a race between getting and setting the next state,
- * warn and reset the monitor if it runs out of retries. The monitor should be
- * able to handle various orders.
- */
-
-static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
-			    enum events event)
-{
-	enum states curr_state, next_state;
-
-	curr_state = READ_ONCE(da_mon->curr_state);
-	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
-		next_state = model_get_next_state(curr_state, event);
-		if (next_state == INVALID_STATE) {
-			react(curr_state, event);
-			CONCATENATE(trace_error_, MONITOR_NAME)(tsk->pid,
-				    model_get_state_name(curr_state),
-				    model_get_event_name(event));
-			return false;
-		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
-			CONCATENATE(trace_event_, MONITOR_NAME)(tsk->pid,
-				    model_get_state_name(curr_state),
-				    model_get_event_name(event),
-				    model_get_state_name(next_state),
-				    model_is_final_state(next_state));
-			return true;
-		}
-	}
-
-	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
-	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
-		" retries reached for event %s, resetting monitor %s",
-		model_get_event_name(event), __stringify(MONITOR_NAME));
-	return false;
-}
-#endif /* RV_MON_TYPE */
-
 #if RV_MON_TYPE == RV_MON_GLOBAL
 /*
  * Functions to define, init and get a global monitor.
@@ -329,115 +252,179 @@ static inline void da_monitor_destroy(void)
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 /*
- * Handle event for implicit monitor: da_get_monitor() will figure out
- * the monitor.
+ * Trace events for implicit monitors. Implicit monitor is the one which the
+ * handler does not need to specify which da_monitor to manipulate. Examples
+ * of implicit monitor are the per_cpu or the global ones.
  */
 
-static inline void __da_handle_event(struct da_monitor *da_mon,
-				     enum events event)
+static inline void da_trace_event(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  char *next_state, bool is_final,
+				  da_id_type id)
 {
-	bool retval;
+	CONCATENATE(trace_event_, MONITOR_NAME)(curr_state, event, next_state,
+						is_final);
+}
 
-	retval = da_event(da_mon, event);
-	if (!retval)
-		da_monitor_reset(da_mon);
+static inline void da_trace_error(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  da_id_type id)
+{
+	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
 }
 
+#elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
- * da_handle_event - handle an event
+ * Trace events for per_task monitors, report the PID of the task.
  */
-static inline void da_handle_event(enum events event)
-{
-	struct da_monitor *da_mon = da_get_monitor();
-	bool retval;
 
-	retval = da_monitor_handling_event(da_mon);
-	if (!retval)
-		return;
+static inline void da_trace_event(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  char *next_state, bool is_final,
+				  da_id_type id)
+{
+	CONCATENATE(trace_event_, MONITOR_NAME)(id, curr_state, event,
+						next_state, is_final);
+}
 
-	__da_handle_event(da_mon, event);
+static inline void da_trace_error(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  da_id_type id)
+{
+	CONCATENATE(trace_error_, MONITOR_NAME)(id, curr_state, event);
 }
+#endif /* RV_MON_TYPE */
 
 /*
- * da_handle_start_event - start monitoring or handle event
- *
- * This function is used to notify the monitor that the system is returning
- * to the initial state, so the monitor can start monitoring in the next event.
- * Thus:
+ * da_event - handle an event for the da_mon
  *
- * If the monitor already started, handle the event.
- * If the monitor did not start yet, start the monitor but skip the event.
+ * This function is valid for both implicit and id monitors.
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
  */
-static inline bool da_handle_start_event(enum events event)
+static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_type id)
 {
-	struct da_monitor *da_mon;
+	enum states curr_state, next_state;
 
-	if (!da_monitor_enabled())
-		return 0;
+	curr_state = READ_ONCE(da_mon->curr_state);
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		next_state = model_get_next_state(curr_state, event);
+		if (next_state == INVALID_STATE) {
+			react(curr_state, event);
+			da_trace_error(da_mon, model_get_state_name(curr_state),
+				       model_get_event_name(event), id);
+			return false;
+		}
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			da_trace_event(da_mon, model_get_state_name(curr_state),
+				       model_get_event_name(event),
+				       model_get_state_name(next_state),
+				       model_is_final_state(next_state), id);
+			return true;
+		}
+	}
+
+	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
+		" retries reached for event %s, resetting monitor %s",
+		model_get_event_name(event), __stringify(MONITOR_NAME));
+	return false;
+}
 
-	da_mon = da_get_monitor();
+static inline void __da_handle_event_common(struct da_monitor *da_mon,
+					    enum events event, da_id_type id)
+{
+	if (!da_event(da_mon, event, id))
+		da_monitor_reset(da_mon);
+}
 
+static inline void __da_handle_event(struct da_monitor *da_mon,
+				     enum events event, da_id_type id)
+{
+	if (da_monitor_handling_event(da_mon))
+		__da_handle_event_common(da_mon, event, id);
+}
+
+static inline bool __da_handle_start_event(struct da_monitor *da_mon,
+					   enum events event, da_id_type id)
+{
+	if (!da_monitor_enabled())
+		return 0;
 	if (unlikely(!da_monitoring(da_mon))) {
 		da_monitor_start(da_mon);
 		return 0;
 	}
 
-	__da_handle_event(da_mon, event);
+	__da_handle_event_common(da_mon, event, id);
 
 	return 1;
 }
 
-/*
- * da_handle_start_run_event - start monitoring and handle event
- *
- * This function is used to notify the monitor that the system is in the
- * initial state, so the monitor can start monitoring and handling event.
- */
-static inline bool da_handle_start_run_event(enum events event)
+static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
+					       enum events event, da_id_type id)
 {
-	struct da_monitor *da_mon;
-
 	if (!da_monitor_enabled())
 		return 0;
-
-	da_mon = da_get_monitor();
-
 	if (unlikely(!da_monitoring(da_mon)))
 		da_monitor_start(da_mon);
 
-	__da_handle_event(da_mon, event);
+	__da_handle_event_common(da_mon, event, id);
 
 	return 1;
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 /*
- * Handle event for per task.
+ * Handle event for implicit monitor: da_get_monitor() will figure out
+ * the monitor.
  */
 
-static inline void __da_handle_event(struct da_monitor *da_mon,
-				     struct task_struct *tsk, enum events event)
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event(enum events event)
 {
-	bool retval;
+	__da_handle_event(da_get_monitor(), event, 0);
+}
 
-	retval = da_event(da_mon, tsk, event);
-	if (!retval)
-		da_monitor_reset(da_mon);
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
+static inline bool da_handle_start_event(enum events event)
+{
+	return __da_handle_start_event(da_get_monitor(), event, 0);
 }
 
 /*
- * da_handle_event - handle an event
+ * da_handle_start_run_event - start monitoring and handle event
+ *
+ * This function is used to notify the monitor that the system is in the
+ * initial state, so the monitor can start monitoring and handling event.
  */
-static inline void da_handle_event(struct task_struct *tsk, enum events event)
+static inline bool da_handle_start_run_event(enum events event)
 {
-	struct da_monitor *da_mon = da_get_monitor(tsk);
-	bool retval;
+	return __da_handle_start_run_event(da_get_monitor(), event, 0);
+}
 
-	retval = da_monitor_handling_event(da_mon);
-	if (!retval)
-		return;
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+/*
+ * Handle event for per task.
+ */
 
-	__da_handle_event(da_mon, tsk, event);
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event(struct task_struct *tsk, enum events event)
+{
+	__da_handle_event(da_get_monitor(tsk), event, tsk->pid);
 }
 
 /*
@@ -453,21 +440,7 @@ static inline void da_handle_event(struct task_struct *tsk, enum events event)
 static inline bool da_handle_start_event(struct task_struct *tsk,
 					 enum events event)
 {
-	struct da_monitor *da_mon;
-
-	if (!da_monitor_enabled())
-		return 0;
-
-	da_mon = da_get_monitor(tsk);
-
-	if (unlikely(!da_monitoring(da_mon))) {
-		da_monitor_start(da_mon);
-		return 0;
-	}
-
-	__da_handle_event(da_mon, tsk, event);
-
-	return 1;
+	return __da_handle_start_event(da_get_monitor(tsk), event, tsk->pid);
 }
 
 /*
@@ -479,19 +452,7 @@ static inline bool da_handle_start_event(struct task_struct *tsk,
 static inline bool da_handle_start_run_event(struct task_struct *tsk,
 					     enum events event)
 {
-	struct da_monitor *da_mon;
-
-	if (!da_monitor_enabled())
-		return 0;
-
-	da_mon = da_get_monitor(tsk);
-
-	if (unlikely(!da_monitoring(da_mon)))
-		da_monitor_start(da_mon);
-
-	__da_handle_event(da_mon, tsk, event);
-
-	return 1;
+	return __da_handle_start_run_event(da_get_monitor(tsk), event, tsk->pid);
 }
 #endif /* RV_MON_TYPE */
 
-- 
2.52.0

