Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617A313545
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291026; cv=none; b=KxdpzZp+iu/SZZHOhUto8GpaHMM3qENMWDYJFiVm+Xf9uc7B8PRo2jYrLpmQhFHFm5x5IWBSzToPPs7wcbea7ej0iCFwwbGU+dOr+DjkhoKKFCSeRmV+vUyHMFYqbhQGPcyVj7ov9Z7hpm6TNAx5UneKKw4yghZJX0bgHZL/IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291026; c=relaxed/simple;
	bh=uXJ19UsBCCwtWr/Uu3gRU34B/NBLv3J6S8FqCWIo95k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z953jQc6jlauSbbRl10FUqH4s0rkBRQB+mttUkQlBZfzLzeqG9JvqADKn76OnVjcm0TBRdILFZrFIV9jp0NKC6jJsYtSmDwAi4ZwG4llfI6Un+UuTGRGbFLfq8zDNtBBuUL71XyWZgiZFepp6kqxCy3p66zEcgQpAQIIJ646bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/mlQLvD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/mlQLvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzirTRvak70nt9DhTAuEoq5pJMualJlcFq+O4xhjsg8=;
	b=X/mlQLvDuN4xPzzZ+JA9KkrGm/jZbQh7nS5hk5EVUOIgoLfsdZaGoHdljzUtVZpZXCtPH6
	v4/GrhE/5zh4K8SWV7NcSCD64QjBimFfu5wl+9czmGeUc+xB/5FyhrJCwmvAucCZGCZcia
	tNDvkEj26u8q/nAhSitH+duMPoo/NM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-toFIqLgHN1uRD4iKxY4Ypg-1; Fri,
 19 Sep 2025 10:10:22 -0400
X-MC-Unique: toFIqLgHN1uRD4iKxY4Ypg-1
X-Mimecast-MFC-AGG-ID: toFIqLgHN1uRD4iKxY4Ypg_1758291021
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E00E1956053;
	Fri, 19 Sep 2025 14:10:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3024119560BB;
	Fri, 19 Sep 2025 14:10:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 03/20] rv: Unify DA event handling functions across monitor types
Date: Fri, 19 Sep 2025 16:09:37 +0200
Message-ID: <20250919140954.104920-4-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The DA event handling functions are mostly duplicated because the
per-task monitors need to propagate the task to use the pid in the trace
events. This is a maintenance burden for a little advantage.
The task can be obtained with some pointer arithmetic from the da_mon,
hence only the function tracing events really need to differ.

Unify all code handling the events, create da_trace_event() and
da_trace_error() that only call the tracepoint function.
Propagate the monitor id through the calls, the do_trace_ functions use
the id (pid) in case of per-task monitors but ignore it for implicit
monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 303 +++++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 161 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 7c3540d0f64e..05b216f90f93 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -23,6 +23,13 @@
 #define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
 static struct rv_monitor rv_this;
 
+/*
+ * Type for the target id, default to int but can be overridden.
+ */
+#ifndef da_id_type
+#define da_id_type int
+#endif
+
 #ifdef CONFIG_RV_REACTORS
 
 static void cond_react(enum states curr_state, enum events event)
@@ -99,90 +106,6 @@ static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
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
-			cond_react(curr_state, event);
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
-			cond_react(curr_state, event);
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
@@ -288,6 +211,14 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
 	return &tsk->rv[task_mon_slot].da_mon;
 }
 
+/*
+ * da_get_task - return the task associated to the monitor
+ */
+static inline struct task_struct *da_get_task(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct task_struct, rv[task_mon_slot].da_mon);
+}
+
 static void da_monitor_reset_all(void)
 {
 	struct task_struct *g, *p;
@@ -337,33 +268,144 @@ static inline void da_monitor_destroy(void)
 
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
+{
+	CONCATENATE(trace_event_, MONITOR_NAME)(curr_state, event, next_state,
+						is_final);
+}
+
+static inline void da_trace_error(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  da_id_type id)
+{
+	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
+}
+
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+/*
+ * Trace events for per_task monitors, report the PID of the task.
+ */
+
+static inline void da_trace_event(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  char *next_state, bool is_final,
+				  da_id_type id)
+{
+	CONCATENATE(trace_event_, MONITOR_NAME)(id, curr_state, event,
+						next_state, is_final);
+}
+
+static inline void da_trace_error(struct da_monitor *da_mon,
+				  char *curr_state, char *event,
+				  da_id_type id)
+{
+	CONCATENATE(trace_error_, MONITOR_NAME)(id, curr_state, event);
+}
+#endif /* RV_MON_TYPE */
+
+/*
+ * da_event - handle an event for the da_mon
+ *
+ * This function is valid for both implicit and id monitors.
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
+ */
+static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_type id)
+{
+	enum states curr_state, next_state;
+
+	curr_state = READ_ONCE(da_mon->curr_state);
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		next_state = model_get_next_state(curr_state, event);
+		if (next_state == INVALID_STATE) {
+			cond_react(curr_state, event);
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
+
+static inline void __da_handle_event_common(struct da_monitor *da_mon,
+					    enum events event, da_id_type id)
 {
 	bool retval;
 
-	retval = da_event(da_mon, event);
+	retval = da_event(da_mon, event, id);
 	if (!retval)
 		da_monitor_reset(da_mon);
 }
 
-/*
- * da_handle_event - handle an event
- */
-static inline void da_handle_event(enum events event)
+static inline void __da_handle_event(struct da_monitor *da_mon,
+				     enum events event, da_id_type id)
 {
-	struct da_monitor *da_mon = da_get_monitor();
 	bool retval;
 
 	retval = da_monitor_handling_event(da_mon);
 	if (!retval)
 		return;
 
-	__da_handle_event(da_mon, event);
+	__da_handle_event_common(da_mon, event, id);
+}
+
+static inline bool __da_handle_start_event(struct da_monitor *da_mon,
+					   enum events event, da_id_type id)
+{
+	if (unlikely(!da_monitoring(da_mon))) {
+		da_monitor_start(da_mon);
+		return 0;
+	}
+
+	__da_handle_event_common(da_mon, event, id);
+
+	return 1;
+}
+
+static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
+					       enum events event, da_id_type id)
+{
+	if (unlikely(!da_monitoring(da_mon)))
+		da_monitor_start(da_mon);
+
+	__da_handle_event_common(da_mon, event, id);
+
+	return 1;
+}
+
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+/*
+ * Handle event for implicit monitor: da_get_monitor() will figure out
+ * the monitor.
+ */
+
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event(enum events event)
+{
+	__da_handle_event(da_get_monitor(), event, 0);
 }
 
 /*
@@ -378,21 +420,9 @@ static inline void da_handle_event(enum events event)
  */
 static inline bool da_handle_start_event(enum events event)
 {
-	struct da_monitor *da_mon;
-
 	if (!da_monitor_enabled())
 		return 0;
-
-	da_mon = da_get_monitor();
-
-	if (unlikely(!da_monitoring(da_mon))) {
-		da_monitor_start(da_mon);
-		return 0;
-	}
-
-	__da_handle_event(da_mon, event);
-
-	return 1;
+	return __da_handle_start_event(da_get_monitor(), event, 0);
 }
 
 /*
@@ -403,19 +433,9 @@ static inline bool da_handle_start_event(enum events event)
  */
 static inline bool da_handle_start_run_event(enum events event)
 {
-	struct da_monitor *da_mon;
-
 	if (!da_monitor_enabled())
 		return 0;
-
-	da_mon = da_get_monitor();
-
-	if (unlikely(!da_monitoring(da_mon)))
-		da_monitor_start(da_mon);
-
-	__da_handle_event(da_mon, event);
-
-	return 1;
+	return __da_handle_start_run_event(da_get_monitor(), event, 0);
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_TASK
@@ -423,29 +443,12 @@ static inline bool da_handle_start_run_event(enum events event)
  * Handle event for per task.
  */
 
-static inline void __da_handle_event(struct da_monitor *da_mon,
-				     struct task_struct *tsk, enum events event)
-{
-	bool retval;
-
-	retval = da_event(da_mon, tsk, event);
-	if (!retval)
-		da_monitor_reset(da_mon);
-}
-
 /*
  * da_handle_event - handle an event
  */
 static inline void da_handle_event(struct task_struct *tsk, enum events event)
 {
-	struct da_monitor *da_mon = da_get_monitor(tsk);
-	bool retval;
-
-	retval = da_monitor_handling_event(da_mon);
-	if (!retval)
-		return;
-
-	__da_handle_event(da_mon, tsk, event);
+	__da_handle_event(da_get_monitor(tsk), event, tsk->pid);
 }
 
 /*
@@ -461,21 +464,9 @@ static inline void da_handle_event(struct task_struct *tsk, enum events event)
 static inline bool da_handle_start_event(struct task_struct *tsk,
 					 enum events event)
 {
-	struct da_monitor *da_mon;
-
 	if (!da_monitor_enabled())
 		return 0;
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
@@ -487,19 +478,9 @@ static inline bool da_handle_start_event(struct task_struct *tsk,
 static inline bool da_handle_start_run_event(struct task_struct *tsk,
 					     enum events event)
 {
-	struct da_monitor *da_mon;
-
 	if (!da_monitor_enabled())
 		return 0;
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
2.51.0

