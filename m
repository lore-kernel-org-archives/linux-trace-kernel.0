Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE426D4C2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710678; cv=none; b=pGWCtfklu7NiwPADosXKl4b5mr/YZQEZLn2Xz/rUwLl3owkaB6aTWCwOx/p5HHN2e7AiBH3t4rTNVDJVvfSxjuu5+yn7e62MVMj1jGvqAScZcL+GkCD+jkd22Wc19Umi0K2gesRes6O61hPUOOD+OIk23XG1NurH6Dih7KGilvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710678; c=relaxed/simple;
	bh=4cgXi5vF2RAYIfgs1sttb/VVvVJc3ENJyV25vFqL6Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtHDfg/Eev+5TlWK7fwu//b59ZcGGP0xjZIBrX9axr9KHNzAGY+A9UA6KnDrl0nBnTZdJM8deTH3DBI407oI6DSboxahJY1QdRVfTUz6Ca/K3M/9zvVv0LXpGqNgpauxQaMf4UK/N9Lyr6SBNuO3I3WrYONMJy+c96STEEJK9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVhHNSlM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVhHNSlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IlUE7d69t8RXx5BxMRoa9TPoYxmIPqvLtlKTQ9zDnE=;
	b=NVhHNSlMe1lTASlKOZUyD9ZSLOEGvB+l/PfqGRSHakU2euOMwOTMX93LoDEP0uxjkAXa/N
	RSojcZIAv14pIvTTJLH2bwBkpc5f22XJD7o+2vK9gRHi9x3Nbc7F9OwmorMpqjR6o1JmIZ
	2wTyJ/vsSGs9C08CEsxR+oSIWMUp8y4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-3gkc8b3zON23YeawdTA5-Q-1; Mon,
 28 Jul 2025 09:51:13 -0400
X-MC-Unique: 3gkc8b3zON23YeawdTA5-Q-1
X-Mimecast-MFC-AGG-ID: 3gkc8b3zON23YeawdTA5-Q_1753710672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1B221800263;
	Mon, 28 Jul 2025 13:51:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3199B18003FC;
	Mon, 28 Jul 2025 13:51:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 5/9] rv: Retry when da monitor detects race conditions
Date: Mon, 28 Jul 2025 15:50:17 +0200
Message-ID: <20250728135022.255578-6-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

DA monitor can be accessed from multiple cores simultaneously, this is
likely, for instance when dealing with per-task monitors reacting on
events that do not always occur on the CPU where the task is running.
This can cause race conditions where two events change the next state
and we see inconsistent values. E.g.:

  [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
  [63] event_srs: 27: sleepable x sched_set_state_sleepable -> sleepable
  [63] error_srs: 27: event sched_switch_suspend not expected in the state running

In this case the monitor fails because the event on CPU 62 wins against
the one on CPU 63, although the correct state should have been
sleepable, since the task get suspended.

Detect if the current state was modified by using try_cmpxchg while
storing the next value. If it was, try again reading the current state.
After a maximum number of failed retries, react by calling a special
tracepoint, print on the console and reset the monitor.

Remove the functions da_monitor_curr_state() and da_monitor_set_state()
as they only hide the underlying implementation in this case.

Monitors where this type of condition can occur must be able to account
for racing events in any possible order, as we cannot know the winner.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h         |   3 +-
 include/rv/da_monitor.h    | 107 +++++++++++++++++++------------------
 kernel/trace/rv/Kconfig    |   5 ++
 kernel/trace/rv/rv_trace.h |  24 +++++++++
 4 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 80731242fe60..14410a42faef 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -10,7 +10,8 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-#define MAX_DA_NAME_LEN	32
+#define MAX_DA_NAME_LEN			32
+#define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ed3c34fe18d6..17fa4f6e5ea6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -54,23 +54,6 @@ static inline void da_monitor_reset_##name(struct da_monitor *da_mon)				\
 	da_mon->curr_state = model_get_initial_state_##name();					\
 }												\
 												\
-/*												\
- * da_monitor_curr_state_##name - return the current state					\
- */												\
-static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)			\
-{												\
-	return da_mon->curr_state;								\
-}												\
-												\
-/*												\
- * da_monitor_set_state_##name - set the new current state					\
- */												\
-static inline void										\
-da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)		\
-{												\
-	da_mon->curr_state = state;								\
-}												\
-												\
 /*												\
  * da_monitor_start_##name - start monitoring							\
  *												\
@@ -127,63 +110,81 @@ static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)
  * Event handler for implicit monitors. Implicit monitor is the one which the
  * handler does not need to specify which da_monitor to manipulate. Examples
  * of implicit monitor are the per_cpu or the global ones.
+ *
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
  */
 #define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)					\
 												\
 static inline bool										\
 da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 {												\
-	type curr_state = da_monitor_curr_state_##name(da_mon);					\
-	type next_state = model_get_next_state_##name(curr_state, event);			\
-												\
-	if (next_state != INVALID_STATE) {							\
-		da_monitor_set_state_##name(da_mon, next_state);				\
-												\
-		trace_event_##name(model_get_state_name_##name(curr_state),			\
-				   model_get_event_name_##name(event),				\
-				   model_get_state_name_##name(next_state),			\
-				   model_is_final_state_##name(next_state));			\
-												\
-		return true;									\
+	enum states_##name curr_state, next_state;						\
+												\
+	curr_state = READ_ONCE(da_mon->curr_state);						\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE) {						\
+			cond_react_##name(curr_state, event);					\
+			trace_error_##name(model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event));			\
+			return false;								\
+		}										\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
+			trace_event_##name(model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event),			\
+					   model_get_state_name_##name(next_state),		\
+					   model_is_final_state_##name(next_state));		\
+			return true;								\
+		}										\
 	}											\
 												\
-	cond_react_##name(curr_state, event);							\
-												\
-	trace_error_##name(model_get_state_name_##name(curr_state),				\
-			   model_get_event_name_##name(event));					\
-												\
+	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
+		" retries reached for event %s, resetting monitor %s",				\
+		model_get_event_name_##name(event), #name);					\
 	return false;										\
 }												\
 
 /*
  * Event handler for per_task monitors.
+ *
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
  */
 #define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)					\
 												\
 static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
 				   enum events_##name event)					\
 {												\
-	type curr_state = da_monitor_curr_state_##name(da_mon);					\
-	type next_state = model_get_next_state_##name(curr_state, event);			\
-												\
-	if (next_state != INVALID_STATE) {							\
-		da_monitor_set_state_##name(da_mon, next_state);				\
-												\
-		trace_event_##name(tsk->pid,							\
-				   model_get_state_name_##name(curr_state),			\
-				   model_get_event_name_##name(event),				\
-				   model_get_state_name_##name(next_state),			\
-				   model_is_final_state_##name(next_state));			\
-												\
-		return true;									\
+	enum states_##name curr_state, next_state;						\
+												\
+	curr_state = READ_ONCE(da_mon->curr_state);						\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE) {						\
+			cond_react_##name(curr_state, event);					\
+			trace_error_##name(tsk->pid,						\
+					   model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event));			\
+			return false;								\
+		}										\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
+			trace_event_##name(tsk->pid,						\
+					   model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event),			\
+					   model_get_state_name_##name(next_state),		\
+					   model_is_final_state_##name(next_state));		\
+			return true;								\
+		}										\
 	}											\
 												\
-	cond_react_##name(curr_state, event);							\
-												\
-	trace_error_##name(tsk->pid,								\
-			   model_get_state_name_##name(curr_state),				\
-			   model_get_event_name_##name(event));					\
-												\
+	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
+		" retries reached for event %s, resetting monitor %s",				\
+		model_get_event_name_##name(event), #name);					\
 	return false;										\
 }
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 26017378f79b..34164eb4ec91 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -3,12 +3,17 @@
 config RV_MON_EVENTS
 	bool
 
+config RV_MON_MAINTENANCE_EVENTS
+	bool
+
 config DA_MON_EVENTS_IMPLICIT
 	select RV_MON_EVENTS
+	select RV_MON_MAINTENANCE_EVENTS
 	bool
 
 config DA_MON_EVENTS_ID
 	select RV_MON_EVENTS
+	select RV_MON_MAINTENANCE_EVENTS
 	bool
 
 config LTL_MON_EVENTS_ID
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index d38e0d3abdfd..3af46cd185b3 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -176,6 +176,30 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 #include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
+
+#ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
+/* Tracepoint useful for monitors development, currenly only used in DA */
+TRACE_EVENT(rv_retries_error,
+
+	TP_PROTO(char *name, char *event),
+
+	TP_ARGS(name, event),
+
+	TP_STRUCT__entry(
+		__string(	name,	name	)
+		__string(	event,	event	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__assign_str(event);
+	),
+
+	TP_printk(__stringify(MAX_DA_RETRY_RACING_EVENTS)
+		" retries reached for event %s, resetting monitor %s",
+		__get_str(event), __get_str(name))
+);
+#endif /* CONFIG_RV_MON_MAINTENANCE_EVENTS */
 #endif /* _TRACE_RV_H */
 
 /* This part must be outside protection */
-- 
2.50.1

