Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08E26F445
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563767; cv=none; b=t57zDnL9ezN6oJ7c2Wd1vM5E7U/orxj2d1o7BV4IQcVPpbMR8EK8sZluZxf6X6u/dn5HxPlctTNc0ufXXfc8VqUgQolwAxCwZtv0PljF8mTKulGtcCZnhgI/BOC1C+QNybA9KK/nWOolv55/W8SOW3azThAUbP2+B2Rj70A9aTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563767; c=relaxed/simple;
	bh=6eddJIGIkG6kl5t+zqjessEAIkSV8kX9BHdAZxTmHhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRH6JTt4jZlr/ZaOToiUaqNAH3R3Of1XHFK/RZLbgm0+PSy6cBw1HB/OUBysy+bt8XcjvpNvt+N5oIX9VVQ0opIOjWfsTkPXXg3mkppZMlmb5GfhTi+YehAUkcISjdA2xE6spZDqPW9uH0iB1/mS28CRZ5Q+HSpBr1Q7YdvVR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eW47MQVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW47MQVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxqbBNZ2eYKhjzALg6IaZYJYVYpWBPtCmkBv3LREctI=;
	b=eW47MQVDYKoIoE4kwdjwbKl6u1G61/1FNsGohres5RFFo7I/Qc73egtBooa4MDY4qNB81j
	aDN+FcHbCvINgX68GvIqDPQdQ2ozHq9aNnT4mMOroSzORg0VjDnKSxzAGHdWDDDmQrtPml
	JOiNt12hR2LSTln6kSuis7TtUBnysSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-0ppDQvq9O8-iQTIu4Kjbuw-1; Tue,
 15 Jul 2025 03:16:01 -0400
X-MC-Unique: 0ppDQvq9O8-iQTIu4Kjbuw-1
X-Mimecast-MFC-AGG-ID: 0ppDQvq9O8-iQTIu4Kjbuw_1752563760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCDB418089B5;
	Tue, 15 Jul 2025 07:15:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C763180035E;
	Tue, 15 Jul 2025 07:15:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 11/17] rv: Retry when da monitor detects race conditions
Date: Tue, 15 Jul 2025 09:14:28 +0200
Message-ID: <20250715071434.22508-12-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
After a maximum number of failed retries, react as if it was an error
with invalid current state (we cannot determine it).

Remove the functions da_monitor_curr_state() and da_monitor_set_state()
as they only hide the underlying implementation in this case.

Monitors where this type of condition can occur must be able to account
for racing events in any possible order, as we cannot know the winner.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h      |  3 +-
 include/rv/da_monitor.h | 91 ++++++++++++++++++++++-------------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 97baf58d88b28..0250a04f4524c 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,7 +7,8 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#define MAX_DA_NAME_LEN	32
+#define MAX_DA_NAME_LEN			32
+#define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ed3c34fe18d61..bd3096a3181f8 100644
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
@@ -127,57 +110,72 @@ static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)
  * Event handler for implicit monitors. Implicit monitor is the one which the
  * handler does not need to specify which da_monitor to manipulate. Examples
  * of implicit monitor are the per_cpu or the global ones.
+ *
+ * Retry, in case there is a race while getting and setting the next state
+ * return an invalid current state if we run out of retries. The monitor should
+ * be able to handle various orders.
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
+		if (next_state == INVALID_STATE)						\
+			goto out_react;								\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state)))		\
+			goto out_success;							\
 	}											\
+	/* Special invalid transition if we run out of retries. */				\
+	curr_state = INVALID_STATE;								\
 												\
+out_react:											\
 	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(model_get_state_name_##name(curr_state),				\
 			   model_get_event_name_##name(event));					\
 												\
 	return false;										\
+												\
+out_success:											\
+	trace_event_##name(model_get_state_name_##name(curr_state),				\
+			   model_get_event_name_##name(event),					\
+			   model_get_state_name_##name(next_state),				\
+			   model_is_final_state_##name(next_state));				\
+												\
+	return true;										\
 }												\
 
 /*
  * Event handler for per_task monitors.
+ *
+ * Retry, in case there is a race while getting and setting the next state
+ * return an invalid current state if we run out of retries. The monitor should
+ * be able to handle various orders.
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
+		if (next_state == INVALID_STATE)						\
+			goto out_react;								\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state)))		\
+			goto out_success;							\
 	}											\
+	/* Special invalid transition if we run out of retries. */				\
+	curr_state = INVALID_STATE;								\
 												\
+out_react:											\
 	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(tsk->pid,								\
@@ -185,6 +183,15 @@ static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct
 			   model_get_event_name_##name(event));					\
 												\
 	return false;										\
+												\
+out_success:											\
+	trace_event_##name(tsk->pid,								\
+			   model_get_state_name_##name(curr_state),				\
+			   model_get_event_name_##name(event),					\
+			   model_get_state_name_##name(next_state),				\
+			   model_is_final_state_##name(next_state));				\
+												\
+	return true;										\
 }
 
 /*
-- 
2.50.1

