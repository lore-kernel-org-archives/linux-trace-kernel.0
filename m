Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6231AF33
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153785; cv=none; b=hktGeY40YgVcs0ZIjsyypD/r2d+p8OC7VJHekmu1GxpI66Rol84Fg8V4gkiRymGJp8nGdiKKfB0m3/ww5bYxWeqI6IitdWIEwj1REbcQsiimJDHrzzovclg0seaCC75wLMUb4IOX8/RpVG7bQSRpxsAsCyQFXsmcd4neSiuycFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153785; c=relaxed/simple;
	bh=kjUdhIslaOP9wYogqA37CR3hirS47kh1r/qkRLNi+V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igc7wGhy3NUH4Q05aN1exvwAVNeLWeMjWz53bt7gL+aEA2v/0rzVmP7lXpeiKPKMrNQ6msVRvol/6CVn94xOsg8bqiXR0FM7t71QNupEhCo48gpFbxTlGEG7wKrNHAFnM2n6KbHPzB/oyEedJ7/8Rjbu8cMo5Q07wCEntHopXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEF+x0QK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEF+x0QK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TDFWffmjNNRKBTFeSMpNrBuTmRdG4qCgmDRDKGn9Ic=;
	b=OEF+x0QKgMrPROQq9r6LT6Dt1IRxr8h4bkquiNWVq+xjGUzu/RCWevoucrdchGbz1RIt9x
	PGOD0QmKpslb153MFSffEfztjlQ6Ayuc84BExHR8/qxZz7KvqlYq+pojDOIE9PANcK1AhB
	h5edL8iZEKo67KcC5N0EseIzjQvOzI8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-E2E1S1UZNq68eQLlt_uKHw-1; Wed,
 26 Nov 2025 05:42:59 -0500
X-MC-Unique: E2E1S1UZNq68eQLlt_uKHw-1
X-Mimecast-MFC-AGG-ID: E2E1S1UZNq68eQLlt_uKHw_1764153778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECE9D195609F;
	Wed, 26 Nov 2025 10:42:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D6311800451;
	Wed, 26 Nov 2025 10:42:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 2/8] rv: Cleanup da_monitor after refactor
Date: Wed, 26 Nov 2025 11:42:33 +0100
Message-ID: <20251126104241.291258-3-gmonaco@redhat.com>
In-Reply-To: <20251126104241.291258-1-gmonaco@redhat.com>
References: <20251126104241.291258-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Previous changes refactored the da_monitor header file to avoid using
macros, however empty macros (e.g. DECLARE_DA_FUNCTION) were left to
ease review with diff tools.
Most macros also get the argument type which doesn't really have a
purpose since states have their own enum and the storage in struct
da_monitor is fixed to unsigned int.

Remove empty and no longer required macros and substitute the type
parameter with the appropriate enum.
Additionally break long line and adjust the format overall.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/automata.h   |  24 +++------
 include/rv/da_monitor.h | 107 ++++++++++++++++------------------------
 2 files changed, 50 insertions(+), 81 deletions(-)

diff --git a/include/rv/automata.h b/include/rv/automata.h
index 5b5d2e94c034..4a4eb40cf09a 100644
--- a/include/rv/automata.h
+++ b/include/rv/automata.h
@@ -6,29 +6,19 @@
  * models in C generated by the dot2k tool.
  */
 
+#ifndef _RV_AUTOMATA_H
+#define _RV_AUTOMATA_H
+
 #ifndef MONITOR_NAME
 #error "MONITOR_NAME macro is not defined. Did you include $(MODEL_NAME).h generated by rvgen?"
 #endif
 
-#ifndef type
-#define type unsigned char
-#endif
-
 #define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
 #define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
 #define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
 #define events CONCATENATE(events_, MONITOR_NAME)
 #define states CONCATENATE(states_, MONITOR_NAME)
 
-/*
- * DECLARE_AUTOMATA_HELPERS - define a set of helper functions for automata
- *
- * Define a set of helper functions for automata. The 'name' argument is used
- * as suffix for the functions and data. These functions will handle automaton
- * with data type 'type'.
- */
-#define DECLARE_AUTOMATA_HELPERS(name, type)
-
 /*
  * model_get_state_name - return the (string) name of the given state
  */
@@ -54,7 +44,7 @@ static char *model_get_event_name(enum events event)
 /*
  * model_get_initial_state - return the automaton's initial state
  */
-static inline type model_get_initial_state(void)
+static inline enum states model_get_initial_state(void)
 {
 	return RV_AUTOMATON_NAME.initial_state;
 }
@@ -65,8 +55,8 @@ static inline type model_get_initial_state(void)
  * Given the current state (curr_state) and the event (event), returns
  * the next state, or INVALID_STATE in case of error.
  */
-static inline type model_get_next_state(enum states curr_state,
-					       enum events event)
+static inline enum states model_get_next_state(enum states curr_state,
+					enum events event)
 {
 	if ((curr_state < 0) || (curr_state >= STATE_MAX))
 		return INVALID_STATE;
@@ -87,3 +77,5 @@ static inline bool model_is_final_state(enum states state)
 
 	return RV_AUTOMATON_NAME.final_states[state];
 }
+
+#endif
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index a4555dafa8d0..7b28ef9f73bd 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -11,6 +11,9 @@
  *   Documentation/trace/rv/da_monitor_synthesis.rst
  */
 
+#ifndef _RV_DA_MONITOR_H
+#define _RV_DA_MONITOR_H
+
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/stringify.h>
@@ -19,12 +22,7 @@
 
 static struct rv_monitor rv_this;
 
-/*
- * Generic helpers for all types of deterministic automata monitors.
- */
-#define DECLARE_DA_MON_GENERIC_HELPERS(name, type)
-
-static void react(type curr_state, type event)
+static void react(enum states curr_state, enum events event)
 {
 	rv_react(&rv_this,
 		 "rv: monitor %s does not allow event %s on state %s\n",
@@ -83,7 +81,6 @@ static inline bool da_monitor_enabled(void)
  */
 static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
 {
-
 	if (!da_monitor_enabled())
 		return 0;
 
@@ -94,6 +91,7 @@ static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
 	return 1;
 }
 
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Event handler for implicit monitors. Implicit monitor is the one which the
  * handler does not need to specify which da_monitor to manipulate. Examples
@@ -103,10 +101,8 @@ static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
  * warn and reset the monitor if it runs out of retries. The monitor should be
  * able to handle various orders.
  */
-#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 
-static inline bool
-da_event(struct da_monitor *da_mon, enum events event)
+static inline bool da_event(struct da_monitor *da_mon, enum events event)
 {
 	enum states curr_state, next_state;
 
@@ -115,15 +111,17 @@ da_event(struct da_monitor *da_mon, enum events event)
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
-			CONCATENATE(trace_error_, MONITOR_NAME)(model_get_state_name(curr_state),
-					   model_get_event_name(event));
+			CONCATENATE(trace_error_, MONITOR_NAME)(
+				    model_get_state_name(curr_state),
+				    model_get_event_name(event));
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
-			CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
-					   model_get_event_name(event),
-					   model_get_state_name(next_state),
-					   model_is_final_state(next_state));
+			CONCATENATE(trace_event_, MONITOR_NAME)(
+				    model_get_state_name(curr_state),
+				    model_get_event_name(event),
+				    model_get_state_name(next_state),
+				    model_is_final_state(next_state));
 			return true;
 		}
 	}
@@ -135,6 +133,7 @@ da_event(struct da_monitor *da_mon, enum events event)
 	return false;
 }
 
+#elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Event handler for per_task monitors.
  *
@@ -142,10 +141,9 @@ da_event(struct da_monitor *da_mon, enum events event)
  * warn and reset the monitor if it runs out of retries. The monitor should be
  * able to handle various orders.
  */
-#elif RV_MON_TYPE == RV_MON_PER_TASK
 
 static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
-				   enum events event)
+			    enum events event)
 {
 	enum states curr_state, next_state;
 
@@ -155,16 +153,16 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
 			CONCATENATE(trace_error_, MONITOR_NAME)(tsk->pid,
-					   model_get_state_name(curr_state),
-					   model_get_event_name(event));
+				    model_get_state_name(curr_state),
+				    model_get_event_name(event));
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
 			CONCATENATE(trace_event_, MONITOR_NAME)(tsk->pid,
-					   model_get_state_name(curr_state),
-					   model_get_event_name(event),
-					   model_get_state_name(next_state),
-					   model_is_final_state(next_state));
+				    model_get_state_name(curr_state),
+				    model_get_event_name(event),
+				    model_get_state_name(next_state),
+				    model_is_final_state(next_state));
 			return true;
 		}
 	}
@@ -175,12 +173,12 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 		model_get_event_name(event), __stringify(MONITOR_NAME));
 	return false;
 }
-#endif
+#endif /* RV_MON_TYPE */
 
+#if RV_MON_TYPE == RV_MON_GLOBAL
 /*
  * Functions to define, init and get a global monitor.
  */
-#if RV_MON_TYPE == RV_MON_GLOBAL
 
 /*
  * global monitor (a single variable)
@@ -215,15 +213,12 @@ static inline int da_monitor_init(void)
 /*
  * da_monitor_destroy - destroy the monitor
  */
-static inline void da_monitor_destroy(void)
-{
-	return;
-}
+static inline void da_monitor_destroy(void) { }
 
+#elif RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Functions to define, init and get a per-cpu monitor.
  */
-#elif RV_MON_TYPE == RV_MON_PER_CPU
 
 /*
  * per-cpu monitor variables
@@ -245,6 +240,7 @@ static void da_monitor_reset_all(void)
 {
 	struct da_monitor *da_mon;
 	int cpu;
+
 	for_each_cpu(cpu, cpu_online_mask) {
 		da_mon = per_cpu_ptr(&da_mon_this, cpu);
 		da_monitor_reset(da_mon);
@@ -263,15 +259,12 @@ static inline int da_monitor_init(void)
 /*
  * da_monitor_destroy - destroy the monitor
  */
-static inline void da_monitor_destroy(void)
-{
-	return;
-}
+static inline void da_monitor_destroy(void) { }
 
+#elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Functions to define, init and get a per-task monitor.
  */
-#elif RV_MON_TYPE == RV_MON_PER_TASK
 
 /*
  * The per-task monitor is stored a vector in the task struct. This variable
@@ -331,18 +324,17 @@ static inline void da_monitor_destroy(void)
 	}
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
-	return;
 }
-#endif
+#endif /* RV_MON_TYPE */
 
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Handle event for implicit monitor: da_get_monitor() will figure out
  * the monitor.
  */
-#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 
 static inline void __da_handle_event(struct da_monitor *da_mon,
-					    enum events event)
+				     enum events event)
 {
 	bool retval;
 
@@ -418,14 +410,13 @@ static inline bool da_handle_start_run_event(enum events event)
 	return 1;
 }
 
+#elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Handle event for per task.
  */
-#elif RV_MON_TYPE == RV_MON_PER_TASK
 
-static inline void
-__da_handle_event(struct da_monitor *da_mon, struct task_struct *tsk,
-			 enum events event)
+static inline void __da_handle_event(struct da_monitor *da_mon,
+				     struct task_struct *tsk, enum events event)
 {
 	bool retval;
 
@@ -437,8 +428,7 @@ __da_handle_event(struct da_monitor *da_mon, struct task_struct *tsk,
 /*
  * da_handle_event - handle an event
  */
-static inline void
-da_handle_event(struct task_struct *tsk, enum events event)
+static inline void da_handle_event(struct task_struct *tsk, enum events event)
 {
 	struct da_monitor *da_mon = da_get_monitor(tsk);
 	bool retval;
@@ -460,8 +450,8 @@ da_handle_event(struct task_struct *tsk, enum events event)
  * If the monitor already started, handle the event.
  * If the monitor did not start yet, start the monitor but skip the event.
  */
-static inline bool
-da_handle_start_event(struct task_struct *tsk, enum events event)
+static inline bool da_handle_start_event(struct task_struct *tsk,
+					 enum events event)
 {
 	struct da_monitor *da_mon;
 
@@ -486,8 +476,8 @@ da_handle_start_event(struct task_struct *tsk, enum events event)
  * This function is used to notify the monitor that the system is in the
  * initial state, so the monitor can start monitoring and handling event.
  */
-static inline bool
-da_handle_start_run_event(struct task_struct *tsk, enum events event)
+static inline bool da_handle_start_run_event(struct task_struct *tsk,
+					     enum events event)
 {
 	struct da_monitor *da_mon;
 
@@ -503,19 +493,6 @@ da_handle_start_run_event(struct task_struct *tsk, enum events event)
 
 	return 1;
 }
-#endif
+#endif /* RV_MON_TYPE */
 
-/*
- * Entry point for the global monitor.
- */
-#define DECLARE_DA_MON_GLOBAL(name, type)
-
-/*
- * Entry point for the per-cpu monitor.
- */
-#define DECLARE_DA_MON_PER_CPU(name, type)
-
-/*
- * Entry point for the per-task monitor.
- */
-#define DECLARE_DA_MON_PER_TASK(name, type)
+#endif
-- 
2.51.1

