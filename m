Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095A1A2642
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756390; cv=none; b=aynsYmlZlM+WC6Wsqa0YeLe+9v8VkJNg2IdPnRu41w1zg/R5nydTspeFfL0wqty4ogF/M6foekGX9wbOTuUIBPAXTpUnOQw+ru8/vi8PVxDIq6f2wQpfzMIgYG44jgWjMwPEbBFrpzCWHnIbYAFdH904mmP+FTNvbWoewcuDzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756390; c=relaxed/simple;
	bh=SZvU7egjXghoL/RnbsoU/nT/gb88ljFNL/ngEWopfKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz86+n0yl6xReG5fB6JhDQjuVEwgWksK0UleGBCX+oJar6DMFstBn5gp9W7yrqLNJzq/jGLOOyy/jxE5oa+pnHZqO6m7iGD+MdgmYYgI+1Yon8GW0Qb17q75+VNjlsQnNOCsubGpTJ4FGJD7ZomFivRHY42un0DsHQ2ICWYLzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXY9Hg3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXY9Hg3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743756387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+X+wvHGgRr0/6hdLnM/iH2SYIDCu1Kzb4GvWEHzuUBc=;
	b=PXY9Hg3r9LNWdJxhnaLDhLFV7UInanqkHvmCtpUigJokCWQa3eepB//jfPMt3lIVl7DyFY
	Z27hvcbAQPgVF1txN6TtBY8hHcwC+nI/6mC7UxO7wMLl8LlmPonISJqGwS0+P1NTLCwOtS
	e99YPrI5cGkr7MCYji+yN3WFlvHd+gg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-CUE0qfPQPRWaLOPa5xyOwg-1; Fri,
 04 Apr 2025 04:46:24 -0400
X-MC-Unique: CUE0qfPQPRWaLOPa5xyOwg-1
X-Mimecast-MFC-AGG-ID: CUE0qfPQPRWaLOPa5xyOwg_1743756383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98B3F19560BC;
	Fri,  4 Apr 2025 08:46:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2E671828A9F;
	Fri,  4 Apr 2025 08:46:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH 7/9] rv: Retry when da monitor detects race conditions
Date: Fri,  4 Apr 2025 10:45:20 +0200
Message-ID: <20250404084512.98552-18-gmonaco@redhat.com>
In-Reply-To: <20250404084512.98552-11-gmonaco@redhat.com>
References: <20250404084512.98552-11-gmonaco@redhat.com>
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
After a maximum number of failed retries, react as if it was an error
with invalid current state (we cannot determine it).

Monitors where this type of condition can occur must be able to account
for racing events in any possible order, as we cannot know the winner.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h      |  3 ++-
 include/rv/da_monitor.h | 53 +++++++++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 3452b5e4b29e7..a83a81ac6e466 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,7 +7,8 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#define MAX_DA_NAME_LEN	32
+#define MAX_DA_NAME_LEN			32
+#define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
 /*
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 215c3eb770ccc..8b714e3085a55 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -82,16 +82,19 @@ static inline void da_monitor_reset_##name(struct da_monitor *da_mon)				\
  */												\
 static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)			\
 {												\
-	return da_mon->curr_state;								\
+	return READ_ONCE(da_mon->curr_state);							\
 }												\
 												\
 /*												\
  * da_monitor_set_state_##name - set the new current state					\
+ *												\
+ * return false without the change in case the state was modified elsewhere			\
  */												\
-static inline void										\
-da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)		\
+static inline bool										\
+da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name prev_state,		\
+			    enum states_##name state)						\
 {												\
-	da_mon->curr_state = state;								\
+	return try_cmpxchg(&da_mon->curr_state, &prev_state, state);				\
 }												\
 												\
 /*												\
@@ -150,17 +153,29 @@ static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)
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
+	bool changed;										\
+	type curr_state, next_state;								\
 												\
-	if (next_state != INVALID_STATE) {							\
-		da_monitor_set_state_##name(da_mon, next_state);				\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		curr_state = da_monitor_curr_state_##name(da_mon);				\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE)						\
+			break;									\
+		changed = da_monitor_set_state_##name(da_mon, curr_state, next_state);		\
+		if (unlikely(!changed))	{							\
+			curr_state = -1;							\
+			continue;								\
+		}										\
 												\
 		trace_event_##name(model_get_state_name_##name(curr_state),			\
 				   model_get_event_name_##name(event),				\
@@ -181,17 +196,29 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 
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
+	bool changed;										\
+	type curr_state, next_state;								\
+												\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		curr_state = da_monitor_curr_state_##name(da_mon);				\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE)						\
+			break;									\
+		changed = da_monitor_set_state_##name(da_mon, curr_state, next_state);		\
+		if (unlikely(!changed))	{							\
+			curr_state = -1;							\
+			continue;								\
+		}										\
 												\
 		trace_event_##name(tsk->pid,							\
 				   model_get_state_name_##name(curr_state),			\
-- 
2.49.0

