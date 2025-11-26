Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268631A81F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153787; cv=none; b=ONW3bx+TmxWC8zmNq491zzleXKJqlXmMTHx32uKZrhOyZ1Lvuio7nro4bsUIgAI8YsXjrvWLloNtmCKRdY2AxHu4MlvNCKois1K8ZC0d8buja/0U1tcmIF8XwMmBxdmfS3IUp1qLrFFGef2PpFRkrfjljB9ies4NZLwkYZZNwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153787; c=relaxed/simple;
	bh=gtiAr2oqn3u0rZGm4CXs8z/Aoh/Z2DgOpmxpuASm2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK0sCeEaLvgpx3n2VHptyUWqhyj/p7+16GsA5kM5thrr5utuFQWRoBiuC5AyQ/AacGoyGl6DlMoc8SB3HmVSw2Mj5ltaxUa7/H7Jhk9KlLtNodVZUEJX3bLUB/hfEj0MD7FffWiUfADIMwribX9TlT7qMDrqC8OEDruJaBSBW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiduN8Wi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiduN8Wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtKClvHVA9AZxZw2XkJFywXBv4bPAQcj4uzfXk03yq4=;
	b=iiduN8Wik88Xipk5CUbjlKokEjOd8GEU8TWz6vn1YV6ElyZoT99MNOArpqGG5e+YimHKnv
	S/gnqma4r7+i2A5CFShq3zpSKeVtC7Ua3+jvjZvHklOFsCVRAe1KHHgeYTm5hapJFojckV
	rXKk/7Hph3vIx7Km7niqkeGPUb20ink=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-B8HtYXT0OIi1WeqfeHcPpg-1; Wed,
 26 Nov 2025 05:42:55 -0500
X-MC-Unique: B8HtYXT0OIi1WeqfeHcPpg-1
X-Mimecast-MFC-AGG-ID: B8HtYXT0OIi1WeqfeHcPpg_1764153774
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CFEA1954B17;
	Wed, 26 Nov 2025 10:42:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFADA18004D8;
	Wed, 26 Nov 2025 10:42:50 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 1/8] rv: Refactor da_monitor to minimise macros
Date: Wed, 26 Nov 2025 11:42:32 +0100
Message-ID: <20251126104241.291258-2-gmonaco@redhat.com>
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

The da_monitor helper functions are generated from macros of the type:

DECLARE_DA_FUNCTION(name, type) \
static void da_func_x_##name(type arg) {} \
static void da_func_y_##name(type arg) {} \

This is good to minimise code duplication but the long macros made of
skipped end of lines is rather hard to parse. Since functions are
static, the advantage of naming them differently for each monitor is
minimal.

Refactor the da_monitor.h file to minimise macros, instead of declaring
functions from macros, we simply declare them with the same name for all
monitors (e.g. da_func_x) and for any remaining reference to the monitor
name (e.g. tracepoints, enums, global variables) we use the CONCATENATE
macro.
In this way the file is much easier to maintain while keeping the same
generality.
Functions depending on the monitor types are now conditionally compiled
according to the value of RV_MON_TYPE, which must be defined in the
monitor source.
The monitor type can be specified as in the original implementation,
although it's best to keep the default implementation (unsigned char) as
not all parts of code support larger data types, and likely there's no
need.

We keep the empty macro definitions to ease review of this change with
diff tools, but cleanup is required.

Also adapt existing monitors to keep the build working.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h                     |   4 +
 include/rv/automata.h                  | 132 ++--
 include/rv/da_monitor.h                | 898 ++++++++++++-------------
 kernel/trace/rv/monitors/nrp/nrp.c     |  30 +-
 kernel/trace/rv/monitors/nrp/nrp.h     |   2 +
 kernel/trace/rv/monitors/opid/opid.c   |  40 +-
 kernel/trace/rv/monitors/opid/opid.h   |   2 +
 kernel/trace/rv/monitors/sco/sco.c     |  26 +-
 kernel/trace/rv/monitors/sco/sco.h     |   2 +
 kernel/trace/rv/monitors/scpd/scpd.c   |  28 +-
 kernel/trace/rv/monitors/scpd/scpd.h   |   2 +
 kernel/trace/rv/monitors/snep/snep.c   |  28 +-
 kernel/trace/rv/monitors/snep/snep.h   |   2 +
 kernel/trace/rv/monitors/snroc/snroc.c |  26 +-
 kernel/trace/rv/monitors/snroc/snroc.h |   2 +
 kernel/trace/rv/monitors/sssw/sssw.c   |  38 +-
 kernel/trace/rv/monitors/sssw/sssw.h   |   2 +
 kernel/trace/rv/monitors/sts/sts.c     |  34 +-
 kernel/trace/rv/monitors/sts/sts.h     |   2 +
 kernel/trace/rv/monitors/wip/wip.c     |  26 +-
 kernel/trace/rv/monitors/wip/wip.h     |   2 +
 kernel/trace/rv/monitors/wwnr/wwnr.c   |  28 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h   |   2 +
 23 files changed, 682 insertions(+), 676 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 92fd467547e7..58774eb3aecf 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -10,6 +10,10 @@
 #define MAX_DA_NAME_LEN			32
 #define MAX_DA_RETRY_RACING_EVENTS	3
 
+#define RV_MON_GLOBAL   0
+#define RV_MON_PER_CPU  1
+#define RV_MON_PER_TASK 2
+
 #ifdef CONFIG_RV
 #include <linux/array_size.h>
 #include <linux/bitops.h>
diff --git a/include/rv/automata.h b/include/rv/automata.h
index eb9e636809a0..5b5d2e94c034 100644
--- a/include/rv/automata.h
+++ b/include/rv/automata.h
@@ -6,6 +6,20 @@
  * models in C generated by the dot2k tool.
  */
 
+#ifndef MONITOR_NAME
+#error "MONITOR_NAME macro is not defined. Did you include $(MODEL_NAME).h generated by rvgen?"
+#endif
+
+#ifndef type
+#define type unsigned char
+#endif
+
+#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
+#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
+#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
+#define events CONCATENATE(events_, MONITOR_NAME)
+#define states CONCATENATE(states_, MONITOR_NAME)
+
 /*
  * DECLARE_AUTOMATA_HELPERS - define a set of helper functions for automata
  *
@@ -13,63 +27,63 @@
  * as suffix for the functions and data. These functions will handle automaton
  * with data type 'type'.
  */
-#define DECLARE_AUTOMATA_HELPERS(name, type)					\
-										\
-/*										\
- * model_get_state_name_##name - return the (string) name of the given state	\
- */ 										\
-static char *model_get_state_name_##name(enum states_##name state)		\
-{										\
-	if ((state < 0) || (state >= state_max_##name))				\
-		return "INVALID";						\
-										\
-	return automaton_##name.state_names[state];				\
-}										\
-										\
-/*										\
- * model_get_event_name_##name - return the (string) name of the given event	\
- */										\
-static char *model_get_event_name_##name(enum events_##name event)		\
-{										\
-	if ((event < 0) || (event >= event_max_##name))				\
-		return "INVALID";						\
-										\
-	return automaton_##name.event_names[event];				\
-}										\
-										\
-/*										\
- * model_get_initial_state_##name - return the automaton's initial state		\
- */										\
-static inline type model_get_initial_state_##name(void)				\
-{										\
-	return automaton_##name.initial_state;					\
-}										\
-										\
-/*										\
- * model_get_next_state_##name - process an automaton event occurrence		\
- *										\
- * Given the current state (curr_state) and the event (event), returns		\
- * the next state, or INVALID_STATE in case of error.				\
- */										\
-static inline type model_get_next_state_##name(enum states_##name curr_state,	\
-					       enum events_##name event)	\
-{										\
-	if ((curr_state < 0) || (curr_state >= state_max_##name))		\
-		return INVALID_STATE;						\
-										\
-	if ((event < 0) || (event >= event_max_##name))				\
-		return INVALID_STATE;						\
-										\
-	return automaton_##name.function[curr_state][event];			\
-}										\
-										\
-/*										\
- * model_is_final_state_##name - check if the given state is a final state	\
- */										\
-static inline bool model_is_final_state_##name(enum states_##name state)	\
-{										\
-	if ((state < 0) || (state >= state_max_##name))				\
-		return 0;							\
-										\
-	return automaton_##name.final_states[state];				\
+#define DECLARE_AUTOMATA_HELPERS(name, type)
+
+/*
+ * model_get_state_name - return the (string) name of the given state
+ */
+static char *model_get_state_name(enum states state)
+{
+	if ((state < 0) || (state >= STATE_MAX))
+		return "INVALID";
+
+	return RV_AUTOMATON_NAME.state_names[state];
+}
+
+/*
+ * model_get_event_name - return the (string) name of the given event
+ */
+static char *model_get_event_name(enum events event)
+{
+	if ((event < 0) || (event >= EVENT_MAX))
+		return "INVALID";
+
+	return RV_AUTOMATON_NAME.event_names[event];
+}
+
+/*
+ * model_get_initial_state - return the automaton's initial state
+ */
+static inline type model_get_initial_state(void)
+{
+	return RV_AUTOMATON_NAME.initial_state;
+}
+
+/*
+ * model_get_next_state - process an automaton event occurrence
+ *
+ * Given the current state (curr_state) and the event (event), returns
+ * the next state, or INVALID_STATE in case of error.
+ */
+static inline type model_get_next_state(enum states curr_state,
+					       enum events event)
+{
+	if ((curr_state < 0) || (curr_state >= STATE_MAX))
+		return INVALID_STATE;
+
+	if ((event < 0) || (event >= EVENT_MAX))
+		return INVALID_STATE;
+
+	return RV_AUTOMATON_NAME.function[curr_state][event];
+}
+
+/*
+ * model_is_final_state - check if the given state is a final state
+ */
+static inline bool model_is_final_state(enum states state)
+{
+	if ((state < 0) || (state >= STATE_MAX))
+		return 0;
+
+	return RV_AUTOMATON_NAME.final_states[state];
 }
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 0cef64366538..a4555dafa8d0 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -13,82 +13,85 @@
 
 #include <rv/automata.h>
 #include <linux/rv.h>
+#include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
 
+static struct rv_monitor rv_this;
+
 /*
  * Generic helpers for all types of deterministic automata monitors.
  */
-#define DECLARE_DA_MON_GENERIC_HELPERS(name, type)						\
-												\
-static void react_##name(type curr_state, type event)						\
-{												\
-	rv_react(&rv_##name,									\
-		 "rv: monitor %s does not allow event %s on state %s\n",			\
-		 #name,										\
-		 model_get_event_name_##name(event),						\
-		 model_get_state_name_##name(curr_state));					\
-}												\
-												\
-/*												\
- * da_monitor_reset_##name - reset a monitor and setting it to init state			\
- */												\
-static inline void da_monitor_reset_##name(struct da_monitor *da_mon)				\
-{												\
-	da_mon->monitoring = 0;									\
-	da_mon->curr_state = model_get_initial_state_##name();					\
-}												\
-												\
-/*												\
- * da_monitor_start_##name - start monitoring							\
- *												\
- * The monitor will ignore all events until monitoring is set to true. This			\
- * function needs to be called to tell the monitor to start monitoring.				\
- */												\
-static inline void da_monitor_start_##name(struct da_monitor *da_mon)				\
-{												\
-	da_mon->curr_state = model_get_initial_state_##name();					\
-	da_mon->monitoring = 1;									\
-}												\
-												\
-/*												\
- * da_monitoring_##name - returns true if the monitor is processing events			\
- */												\
-static inline bool da_monitoring_##name(struct da_monitor *da_mon)				\
-{												\
-	return da_mon->monitoring;								\
-}												\
-												\
-/*												\
- * da_monitor_enabled_##name - checks if the monitor is enabled					\
- */												\
-static inline bool da_monitor_enabled_##name(void)						\
-{												\
-	/* global switch */									\
-	if (unlikely(!rv_monitoring_on()))							\
-		return 0;									\
-												\
-	/* monitor enabled */									\
-	if (unlikely(!rv_##name.enabled))							\
-		return 0;									\
-												\
-	return 1;										\
-}												\
-												\
-/*												\
- * da_monitor_handling_event_##name - checks if the monitor is ready to handle events		\
- */												\
-static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)			\
-{												\
-												\
-	if (!da_monitor_enabled_##name())							\
-		return 0;									\
-												\
-	/* monitor is actually monitoring */							\
-	if (unlikely(!da_monitoring_##name(da_mon)))						\
-		return 0;									\
-												\
-	return 1;										\
+#define DECLARE_DA_MON_GENERIC_HELPERS(name, type)
+
+static void react(type curr_state, type event)
+{
+	rv_react(&rv_this,
+		 "rv: monitor %s does not allow event %s on state %s\n",
+		 __stringify(MONITOR_NAME),
+		 model_get_event_name(event),
+		 model_get_state_name(curr_state));
+}
+
+/*
+ * da_monitor_reset - reset a monitor and setting it to init state
+ */
+static inline void da_monitor_reset(struct da_monitor *da_mon)
+{
+	da_mon->monitoring = 0;
+	da_mon->curr_state = model_get_initial_state();
+}
+
+/*
+ * da_monitor_start - start monitoring
+ *
+ * The monitor will ignore all events until monitoring is set to true. This
+ * function needs to be called to tell the monitor to start monitoring.
+ */
+static inline void da_monitor_start(struct da_monitor *da_mon)
+{
+	da_mon->curr_state = model_get_initial_state();
+	da_mon->monitoring = 1;
+}
+
+/*
+ * da_monitoring - returns true if the monitor is processing events
+ */
+static inline bool da_monitoring(struct da_monitor *da_mon)
+{
+	return da_mon->monitoring;
+}
+
+/*
+ * da_monitor_enabled - checks if the monitor is enabled
+ */
+static inline bool da_monitor_enabled(void)
+{
+	/* global switch */
+	if (unlikely(!rv_monitoring_on()))
+		return 0;
+
+	/* monitor enabled */
+	if (unlikely(!rv_this.enabled))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * da_monitor_handling_event - checks if the monitor is ready to handle events
+ */
+static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
+{
+
+	if (!da_monitor_enabled())
+		return 0;
+
+	/* monitor is actually monitoring */
+	if (unlikely(!da_monitoring(da_mon)))
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -100,37 +103,37 @@ static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)
  * warn and reset the monitor if it runs out of retries. The monitor should be
  * able to handle various orders.
  */
-#define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)					\
-												\
-static inline bool										\
-da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
-{												\
-	enum states_##name curr_state, next_state;						\
-												\
-	curr_state = READ_ONCE(da_mon->curr_state);						\
-	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
-		next_state = model_get_next_state_##name(curr_state, event);			\
-		if (next_state == INVALID_STATE) {						\
-			react_##name(curr_state, event);					\
-			trace_error_##name(model_get_state_name_##name(curr_state),		\
-					   model_get_event_name_##name(event));			\
-			return false;								\
-		}										\
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
-			trace_event_##name(model_get_state_name_##name(curr_state),		\
-					   model_get_event_name_##name(event),			\
-					   model_get_state_name_##name(next_state),		\
-					   model_is_final_state_##name(next_state));		\
-			return true;								\
-		}										\
-	}											\
-												\
-	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
-	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
-		" retries reached for event %s, resetting monitor %s",				\
-		model_get_event_name_##name(event), #name);					\
-	return false;										\
-}												\
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+
+static inline bool
+da_event(struct da_monitor *da_mon, enum events event)
+{
+	enum states curr_state, next_state;
+
+	curr_state = READ_ONCE(da_mon->curr_state);
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		next_state = model_get_next_state(curr_state, event);
+		if (next_state == INVALID_STATE) {
+			react(curr_state, event);
+			CONCATENATE(trace_error_, MONITOR_NAME)(model_get_state_name(curr_state),
+					   model_get_event_name(event));
+			return false;
+		}
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
+					   model_get_event_name(event),
+					   model_get_state_name(next_state),
+					   model_is_final_state(next_state));
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
 
 /*
  * Event handler for per_task monitors.
@@ -139,395 +142,380 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
  * warn and reset the monitor if it runs out of retries. The monitor should be
  * able to handle various orders.
  */
-#define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)					\
-												\
-static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
-				   enum events_##name event)					\
-{												\
-	enum states_##name curr_state, next_state;						\
-												\
-	curr_state = READ_ONCE(da_mon->curr_state);						\
-	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
-		next_state = model_get_next_state_##name(curr_state, event);			\
-		if (next_state == INVALID_STATE) {						\
-			react_##name(curr_state, event);					\
-			trace_error_##name(tsk->pid,						\
-					   model_get_state_name_##name(curr_state),		\
-					   model_get_event_name_##name(event));			\
-			return false;								\
-		}										\
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
-			trace_event_##name(tsk->pid,						\
-					   model_get_state_name_##name(curr_state),		\
-					   model_get_event_name_##name(event),			\
-					   model_get_state_name_##name(next_state),		\
-					   model_is_final_state_##name(next_state));		\
-			return true;								\
-		}										\
-	}											\
-												\
-	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
-	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
-		" retries reached for event %s, resetting monitor %s",				\
-		model_get_event_name_##name(event), #name);					\
-	return false;										\
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+
+static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
+				   enum events event)
+{
+	enum states curr_state, next_state;
+
+	curr_state = READ_ONCE(da_mon->curr_state);
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		next_state = model_get_next_state(curr_state, event);
+		if (next_state == INVALID_STATE) {
+			react(curr_state, event);
+			CONCATENATE(trace_error_, MONITOR_NAME)(tsk->pid,
+					   model_get_state_name(curr_state),
+					   model_get_event_name(event));
+			return false;
+		}
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			CONCATENATE(trace_event_, MONITOR_NAME)(tsk->pid,
+					   model_get_state_name(curr_state),
+					   model_get_event_name(event),
+					   model_get_state_name(next_state),
+					   model_is_final_state(next_state));
+			return true;
+		}
+	}
+
+	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
+		" retries reached for event %s, resetting monitor %s",
+		model_get_event_name(event), __stringify(MONITOR_NAME));
+	return false;
 }
+#endif
 
 /*
  * Functions to define, init and get a global monitor.
  */
-#define DECLARE_DA_MON_INIT_GLOBAL(name, type)							\
-												\
-/*												\
- * global monitor (a single variable)								\
- */												\
-static struct da_monitor da_mon_##name;								\
-												\
-/*												\
- * da_get_monitor_##name - return the global monitor address					\
- */												\
-static struct da_monitor *da_get_monitor_##name(void)						\
-{												\
-	return &da_mon_##name;									\
-}												\
-												\
-/*												\
- * da_monitor_reset_all_##name - reset the single monitor					\
- */												\
-static void da_monitor_reset_all_##name(void)							\
-{												\
-	da_monitor_reset_##name(da_get_monitor_##name());					\
-}												\
-												\
-/*												\
- * da_monitor_init_##name - initialize a monitor						\
- */												\
-static inline int da_monitor_init_##name(void)							\
-{												\
-	da_monitor_reset_all_##name();								\
-	return 0;										\
-}												\
-												\
-/*												\
- * da_monitor_destroy_##name - destroy the monitor						\
- */												\
-static inline void da_monitor_destroy_##name(void)						\
-{												\
-	return;											\
+#if RV_MON_TYPE == RV_MON_GLOBAL
+
+/*
+ * global monitor (a single variable)
+ */
+static struct da_monitor da_mon_this;
+
+/*
+ * da_get_monitor - return the global monitor address
+ */
+static struct da_monitor *da_get_monitor(void)
+{
+	return &da_mon_this;
+}
+
+/*
+ * da_monitor_reset_all - reset the single monitor
+ */
+static void da_monitor_reset_all(void)
+{
+	da_monitor_reset(da_get_monitor());
+}
+
+/*
+ * da_monitor_init - initialize a monitor
+ */
+static inline int da_monitor_init(void)
+{
+	da_monitor_reset_all();
+	return 0;
+}
+
+/*
+ * da_monitor_destroy - destroy the monitor
+ */
+static inline void da_monitor_destroy(void)
+{
+	return;
 }
 
 /*
  * Functions to define, init and get a per-cpu monitor.
  */
-#define DECLARE_DA_MON_INIT_PER_CPU(name, type)							\
-												\
-/*												\
- * per-cpu monitor variables									\
- */												\
-static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);					\
-												\
-/*												\
- * da_get_monitor_##name - return current CPU monitor address					\
- */												\
-static struct da_monitor *da_get_monitor_##name(void)						\
-{												\
-	return this_cpu_ptr(&da_mon_##name);							\
-}												\
-												\
-/*												\
- * da_monitor_reset_all_##name - reset all CPUs' monitor					\
- */												\
-static void da_monitor_reset_all_##name(void)							\
-{												\
-	struct da_monitor *da_mon;								\
-	int cpu;										\
-	for_each_cpu(cpu, cpu_online_mask) {							\
-		da_mon = per_cpu_ptr(&da_mon_##name, cpu);					\
-		da_monitor_reset_##name(da_mon);						\
-	}											\
-}												\
-												\
-/*												\
- * da_monitor_init_##name - initialize all CPUs' monitor					\
- */												\
-static inline int da_monitor_init_##name(void)							\
-{												\
-	da_monitor_reset_all_##name();								\
-	return 0;										\
-}												\
-												\
-/*												\
- * da_monitor_destroy_##name - destroy the monitor						\
- */												\
-static inline void da_monitor_destroy_##name(void)						\
-{												\
-	return;											\
+#elif RV_MON_TYPE == RV_MON_PER_CPU
+
+/*
+ * per-cpu monitor variables
+ */
+static DEFINE_PER_CPU(struct da_monitor, da_mon_this);
+
+/*
+ * da_get_monitor - return current CPU monitor address
+ */
+static struct da_monitor *da_get_monitor(void)
+{
+	return this_cpu_ptr(&da_mon_this);
+}
+
+/*
+ * da_monitor_reset_all - reset all CPUs' monitor
+ */
+static void da_monitor_reset_all(void)
+{
+	struct da_monitor *da_mon;
+	int cpu;
+	for_each_cpu(cpu, cpu_online_mask) {
+		da_mon = per_cpu_ptr(&da_mon_this, cpu);
+		da_monitor_reset(da_mon);
+	}
+}
+
+/*
+ * da_monitor_init - initialize all CPUs' monitor
+ */
+static inline int da_monitor_init(void)
+{
+	da_monitor_reset_all();
+	return 0;
+}
+
+/*
+ * da_monitor_destroy - destroy the monitor
+ */
+static inline void da_monitor_destroy(void)
+{
+	return;
 }
 
 /*
  * Functions to define, init and get a per-task monitor.
  */
-#define DECLARE_DA_MON_INIT_PER_TASK(name, type)						\
-												\
-/*												\
- * The per-task monitor is stored a vector in the task struct. This variable			\
- * stores the position on the vector reserved for this monitor.					\
- */												\
-static int task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;					\
-												\
-/*												\
- * da_get_monitor_##name - return the monitor in the allocated slot for tsk 			\
- */												\
-static inline struct da_monitor *da_get_monitor_##name(struct task_struct *tsk)			\
-{												\
-	return &tsk->rv[task_mon_slot_##name].da_mon;						\
-}												\
-												\
-static void da_monitor_reset_all_##name(void)							\
-{												\
-	struct task_struct *g, *p;								\
-	int cpu;										\
-												\
-	read_lock(&tasklist_lock);								\
-	for_each_process_thread(g, p)								\
-		da_monitor_reset_##name(da_get_monitor_##name(p));				\
-	for_each_present_cpu(cpu)								\
-		da_monitor_reset_##name(da_get_monitor_##name(idle_task(cpu)));			\
-	read_unlock(&tasklist_lock);								\
-}												\
-												\
-/*												\
- * da_monitor_init_##name - initialize the per-task monitor					\
- *												\
- * Try to allocate a slot in the task's vector of monitors. If there				\
- * is an available slot, use it and reset all task's monitor.					\
- */												\
-static int da_monitor_init_##name(void)								\
-{												\
-	int slot;										\
-												\
-	slot = rv_get_task_monitor_slot();							\
-	if (slot < 0 || slot >= RV_PER_TASK_MONITOR_INIT)					\
-		return slot;									\
-												\
-	task_mon_slot_##name = slot;								\
-												\
-	da_monitor_reset_all_##name();								\
-	return 0;										\
-}												\
-												\
-/*												\
- * da_monitor_destroy_##name - return the allocated slot					\
- */												\
-static inline void da_monitor_destroy_##name(void)						\
-{												\
-	if (task_mon_slot_##name == RV_PER_TASK_MONITOR_INIT) {					\
-		WARN_ONCE(1, "Disabling a disabled monitor: " #name);				\
-		return;										\
-	}											\
-	rv_put_task_monitor_slot(task_mon_slot_##name);						\
-	task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;					\
-	return;											\
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+
+/*
+ * The per-task monitor is stored a vector in the task struct. This variable
+ * stores the position on the vector reserved for this monitor.
+ */
+static int task_mon_slot = RV_PER_TASK_MONITOR_INIT;
+
+/*
+ * da_get_monitor - return the monitor in the allocated slot for tsk
+ */
+static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
+{
+	return &tsk->rv[task_mon_slot].da_mon;
+}
+
+static void da_monitor_reset_all(void)
+{
+	struct task_struct *g, *p;
+	int cpu;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, p)
+		da_monitor_reset(da_get_monitor(p));
+	for_each_present_cpu(cpu)
+		da_monitor_reset(da_get_monitor(idle_task(cpu)));
+	read_unlock(&tasklist_lock);
 }
 
 /*
- * Handle event for implicit monitor: da_get_monitor_##name() will figure out
+ * da_monitor_init - initialize the per-task monitor
+ *
+ * Try to allocate a slot in the task's vector of monitors. If there
+ * is an available slot, use it and reset all task's monitor.
+ */
+static int da_monitor_init(void)
+{
+	int slot;
+
+	slot = rv_get_task_monitor_slot();
+	if (slot < 0 || slot >= RV_PER_TASK_MONITOR_INIT)
+		return slot;
+
+	task_mon_slot = slot;
+
+	da_monitor_reset_all();
+	return 0;
+}
+
+/*
+ * da_monitor_destroy - return the allocated slot
+ */
+static inline void da_monitor_destroy(void)
+{
+	if (task_mon_slot == RV_PER_TASK_MONITOR_INIT) {
+		WARN_ONCE(1, "Disabling a disabled monitor: " __stringify(MONITOR_NAME));
+		return;
+	}
+	rv_put_task_monitor_slot(task_mon_slot);
+	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
+	return;
+}
+#endif
+
+/*
+ * Handle event for implicit monitor: da_get_monitor() will figure out
  * the monitor.
  */
-#define DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)					\
-												\
-static inline void __da_handle_event_##name(struct da_monitor *da_mon,				\
-					    enum events_##name event)				\
-{												\
-	bool retval;										\
-												\
-	retval = da_event_##name(da_mon, event);						\
-	if (!retval)										\
-		da_monitor_reset_##name(da_mon);						\
-}												\
-												\
-/*												\
- * da_handle_event_##name - handle an event							\
- */												\
-static inline void da_handle_event_##name(enum events_##name event)				\
-{												\
-	struct da_monitor *da_mon = da_get_monitor_##name();					\
-	bool retval;										\
-												\
-	retval = da_monitor_handling_event_##name(da_mon);					\
-	if (!retval)										\
-		return;										\
-												\
-	__da_handle_event_##name(da_mon, event);						\
-}												\
-												\
-/*												\
- * da_handle_start_event_##name - start monitoring or handle event				\
- *												\
- * This function is used to notify the monitor that the system is returning			\
- * to the initial state, so the monitor can start monitoring in the next event.			\
- * Thus:											\
- *												\
- * If the monitor already started, handle the event.						\
- * If the monitor did not start yet, start the monitor but skip the event.			\
- */												\
-static inline bool da_handle_start_event_##name(enum events_##name event)			\
-{												\
-	struct da_monitor *da_mon;								\
-												\
-	if (!da_monitor_enabled_##name())							\
-		return 0;									\
-												\
-	da_mon = da_get_monitor_##name();							\
-												\
-	if (unlikely(!da_monitoring_##name(da_mon))) {						\
-		da_monitor_start_##name(da_mon);						\
-		return 0;									\
-	}											\
-												\
-	__da_handle_event_##name(da_mon, event);						\
-												\
-	return 1;										\
-}												\
-												\
-/*												\
- * da_handle_start_run_event_##name - start monitoring and handle event				\
- *												\
- * This function is used to notify the monitor that the system is in the			\
- * initial state, so the monitor can start monitoring and handling event.			\
- */												\
-static inline bool da_handle_start_run_event_##name(enum events_##name event)			\
-{												\
-	struct da_monitor *da_mon;								\
-												\
-	if (!da_monitor_enabled_##name())							\
-		return 0;									\
-												\
-	da_mon = da_get_monitor_##name();							\
-												\
-	if (unlikely(!da_monitoring_##name(da_mon)))						\
-		da_monitor_start_##name(da_mon);						\
-												\
-	__da_handle_event_##name(da_mon, event);						\
-												\
-	return 1;										\
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+
+static inline void __da_handle_event(struct da_monitor *da_mon,
+					    enum events event)
+{
+	bool retval;
+
+	retval = da_event(da_mon, event);
+	if (!retval)
+		da_monitor_reset(da_mon);
+}
+
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event(enum events event)
+{
+	struct da_monitor *da_mon = da_get_monitor();
+	bool retval;
+
+	retval = da_monitor_handling_event(da_mon);
+	if (!retval)
+		return;
+
+	__da_handle_event(da_mon, event);
+}
+
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
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return 0;
+
+	da_mon = da_get_monitor();
+
+	if (unlikely(!da_monitoring(da_mon))) {
+		da_monitor_start(da_mon);
+		return 0;
+	}
+
+	__da_handle_event(da_mon, event);
+
+	return 1;
+}
+
+/*
+ * da_handle_start_run_event - start monitoring and handle event
+ *
+ * This function is used to notify the monitor that the system is in the
+ * initial state, so the monitor can start monitoring and handling event.
+ */
+static inline bool da_handle_start_run_event(enum events event)
+{
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return 0;
+
+	da_mon = da_get_monitor();
+
+	if (unlikely(!da_monitoring(da_mon)))
+		da_monitor_start(da_mon);
+
+	__da_handle_event(da_mon, event);
+
+	return 1;
 }
 
 /*
  * Handle event for per task.
  */
-#define DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type)					\
-												\
-static inline void										\
-__da_handle_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,			\
-			 enum events_##name event)						\
-{												\
-	bool retval;										\
-												\
-	retval = da_event_##name(da_mon, tsk, event);						\
-	if (!retval)										\
-		da_monitor_reset_##name(da_mon);						\
-}												\
-												\
-/*												\
- * da_handle_event_##name - handle an event							\
- */												\
-static inline void										\
-da_handle_event_##name(struct task_struct *tsk, enum events_##name event)			\
-{												\
-	struct da_monitor *da_mon = da_get_monitor_##name(tsk);					\
-	bool retval;										\
-												\
-	retval = da_monitor_handling_event_##name(da_mon);					\
-	if (!retval)										\
-		return;										\
-												\
-	__da_handle_event_##name(da_mon, tsk, event);						\
-}												\
-												\
-/*												\
- * da_handle_start_event_##name - start monitoring or handle event				\
- *												\
- * This function is used to notify the monitor that the system is returning			\
- * to the initial state, so the monitor can start monitoring in the next event.			\
- * Thus:											\
- *												\
- * If the monitor already started, handle the event.						\
- * If the monitor did not start yet, start the monitor but skip the event.			\
- */												\
-static inline bool										\
-da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)			\
-{												\
-	struct da_monitor *da_mon;								\
-												\
-	if (!da_monitor_enabled_##name())							\
-		return 0;									\
-												\
-	da_mon = da_get_monitor_##name(tsk);							\
-												\
-	if (unlikely(!da_monitoring_##name(da_mon))) {						\
-		da_monitor_start_##name(da_mon);						\
-		return 0;									\
-	}											\
-												\
-	__da_handle_event_##name(da_mon, tsk, event);						\
-												\
-	return 1;										\
-}												\
-												\
-/*												\
- * da_handle_start_run_event_##name - start monitoring and handle event				\
- *												\
- * This function is used to notify the monitor that the system is in the			\
- * initial state, so the monitor can start monitoring and handling event.			\
- */												\
-static inline bool										\
-da_handle_start_run_event_##name(struct task_struct *tsk, enum events_##name event)		\
-{												\
-	struct da_monitor *da_mon;								\
-												\
-	if (!da_monitor_enabled_##name())							\
-		return 0;									\
-												\
-	da_mon = da_get_monitor_##name(tsk);							\
-												\
-	if (unlikely(!da_monitoring_##name(da_mon)))						\
-		da_monitor_start_##name(da_mon);						\
-												\
-	__da_handle_event_##name(da_mon, tsk, event);						\
-												\
-	return 1;										\
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+
+static inline void
+__da_handle_event(struct da_monitor *da_mon, struct task_struct *tsk,
+			 enum events event)
+{
+	bool retval;
+
+	retval = da_event(da_mon, tsk, event);
+	if (!retval)
+		da_monitor_reset(da_mon);
+}
+
+/*
+ * da_handle_event - handle an event
+ */
+static inline void
+da_handle_event(struct task_struct *tsk, enum events event)
+{
+	struct da_monitor *da_mon = da_get_monitor(tsk);
+	bool retval;
+
+	retval = da_monitor_handling_event(da_mon);
+	if (!retval)
+		return;
+
+	__da_handle_event(da_mon, tsk, event);
+}
+
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
+static inline bool
+da_handle_start_event(struct task_struct *tsk, enum events event)
+{
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return 0;
+
+	da_mon = da_get_monitor(tsk);
+
+	if (unlikely(!da_monitoring(da_mon))) {
+		da_monitor_start(da_mon);
+		return 0;
+	}
+
+	__da_handle_event(da_mon, tsk, event);
+
+	return 1;
+}
+
+/*
+ * da_handle_start_run_event - start monitoring and handle event
+ *
+ * This function is used to notify the monitor that the system is in the
+ * initial state, so the monitor can start monitoring and handling event.
+ */
+static inline bool
+da_handle_start_run_event(struct task_struct *tsk, enum events event)
+{
+	struct da_monitor *da_mon;
+
+	if (!da_monitor_enabled())
+		return 0;
+
+	da_mon = da_get_monitor(tsk);
+
+	if (unlikely(!da_monitoring(da_mon)))
+		da_monitor_start(da_mon);
+
+	__da_handle_event(da_mon, tsk, event);
+
+	return 1;
 }
+#endif
 
 /*
  * Entry point for the global monitor.
  */
-#define DECLARE_DA_MON_GLOBAL(name, type)							\
-												\
-DECLARE_AUTOMATA_HELPERS(name, type)								\
-DECLARE_DA_MON_GENERIC_HELPERS(name, type)							\
-DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)						\
-DECLARE_DA_MON_INIT_GLOBAL(name, type)								\
-DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)
+#define DECLARE_DA_MON_GLOBAL(name, type)
 
 /*
  * Entry point for the per-cpu monitor.
  */
-#define DECLARE_DA_MON_PER_CPU(name, type)							\
-												\
-DECLARE_AUTOMATA_HELPERS(name, type)								\
-DECLARE_DA_MON_GENERIC_HELPERS(name, type)							\
-DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)						\
-DECLARE_DA_MON_INIT_PER_CPU(name, type)								\
-DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)
+#define DECLARE_DA_MON_PER_CPU(name, type)
 
 /*
  * Entry point for the per-task monitor.
  */
-#define DECLARE_DA_MON_PER_TASK(name, type)							\
-												\
-DECLARE_AUTOMATA_HELPERS(name, type)								\
-DECLARE_DA_MON_GENERIC_HELPERS(name, type)							\
-DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)						\
-DECLARE_DA_MON_INIT_PER_TASK(name, type)							\
-DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type)
+#define DECLARE_DA_MON_PER_TASK(name, type)
diff --git a/kernel/trace/rv/monitors/nrp/nrp.c b/kernel/trace/rv/monitors/nrp/nrp.c
index 5a83b7171432..4b5646a70094 100644
--- a/kernel/trace/rv/monitors/nrp/nrp.c
+++ b/kernel/trace/rv/monitors/nrp/nrp.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "nrp"
 
@@ -15,17 +14,16 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_TASK
 #include "nrp.h"
-
-static struct rv_monitor rv_nrp;
-DECLARE_DA_MON_PER_TASK(nrp, unsigned char);
+#include <rv/da_monitor.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/trace/irq_vectors.h>
 
 static void handle_vector_irq_entry(void *data, int vector)
 {
-	da_handle_event_nrp(current, irq_entry_nrp);
+	da_handle_event(current, irq_entry_nrp);
 }
 
 static void attach_vector_irq(void)
@@ -60,7 +58,7 @@ static void detach_vector_irq(void) { }
 
 static void handle_irq_entry(void *data, int irq, struct irqaction *action)
 {
-	da_handle_event_nrp(current, irq_entry_nrp);
+	da_handle_event(current, irq_entry_nrp);
 }
 
 static void handle_sched_need_resched(void *data, struct task_struct *tsk,
@@ -72,22 +70,22 @@ static void handle_sched_need_resched(void *data, struct task_struct *tsk,
 	 * which may not mirror the system state but makes the monitor simpler,
 	 */
 	if (tif == TIF_NEED_RESCHED)
-		da_handle_start_event_nrp(tsk, sched_need_resched_nrp);
+		da_handle_start_event(tsk, sched_need_resched_nrp);
 }
 
 static void handle_schedule_entry(void *data, bool preempt)
 {
 	if (preempt)
-		da_handle_event_nrp(current, schedule_entry_preempt_nrp);
+		da_handle_event(current, schedule_entry_preempt_nrp);
 	else
-		da_handle_event_nrp(current, schedule_entry_nrp);
+		da_handle_event(current, schedule_entry_nrp);
 }
 
 static int enable_nrp(void)
 {
 	int retval;
 
-	retval = da_monitor_init_nrp();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -101,33 +99,33 @@ static int enable_nrp(void)
 
 static void disable_nrp(void)
 {
-	rv_nrp.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("nrp", irq_handler_entry, handle_irq_entry);
 	rv_detach_trace_probe("nrp", sched_set_need_resched_tp, handle_sched_need_resched);
 	rv_detach_trace_probe("nrp", sched_entry_tp, handle_schedule_entry);
 	detach_vector_irq();
 
-	da_monitor_destroy_nrp();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_nrp = {
+static struct rv_monitor rv_this = {
 	.name = "nrp",
 	.description = "need resched preempts.",
 	.enable = enable_nrp,
 	.disable = disable_nrp,
-	.reset = da_monitor_reset_all_nrp,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_nrp(void)
 {
-	return rv_register_monitor(&rv_nrp, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_nrp(void)
 {
-	rv_unregister_monitor(&rv_nrp);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_nrp);
diff --git a/kernel/trace/rv/monitors/nrp/nrp.h b/kernel/trace/rv/monitors/nrp/nrp.h
index c9f12207cbf6..c2ec83da2124 100644
--- a/kernel/trace/rv/monitors/nrp/nrp.h
+++ b/kernel/trace/rv/monitors/nrp/nrp.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME nrp
+
 enum states_nrp {
 	preempt_irq_nrp = 0,
 	any_thread_running_nrp,
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 50d64e7fb8c4..25a40e90fa40 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "opid"
 
@@ -16,17 +15,16 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "opid.h"
-
-static struct rv_monitor rv_opid;
-DECLARE_DA_MON_PER_CPU(opid, unsigned char);
+#include <rv/da_monitor.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/trace/irq_vectors.h>
 
 static void handle_vector_irq_entry(void *data, int vector)
 {
-	da_handle_event_opid(irq_entry_opid);
+	da_handle_event(irq_entry_opid);
 }
 
 static void attach_vector_irq(void)
@@ -61,52 +59,52 @@ static void detach_vector_irq(void) { }
 
 static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_opid(irq_disable_opid);
+	da_handle_event(irq_disable_opid);
 }
 
 static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_opid(irq_enable_opid);
+	da_handle_event(irq_enable_opid);
 }
 
 static void handle_irq_entry(void *data, int irq, struct irqaction *action)
 {
-	da_handle_event_opid(irq_entry_opid);
+	da_handle_event(irq_entry_opid);
 }
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_opid(preempt_disable_opid);
+	da_handle_event(preempt_disable_opid);
 }
 
 static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_opid(preempt_enable_opid);
+	da_handle_event(preempt_enable_opid);
 }
 
 static void handle_sched_need_resched(void *data, struct task_struct *tsk, int cpu, int tif)
 {
 	/* The monitor's intitial state is not in_irq */
 	if (this_cpu_read(hardirq_context))
-		da_handle_event_opid(sched_need_resched_opid);
+		da_handle_event(sched_need_resched_opid);
 	else
-		da_handle_start_event_opid(sched_need_resched_opid);
+		da_handle_start_event(sched_need_resched_opid);
 }
 
 static void handle_sched_waking(void *data, struct task_struct *p)
 {
 	/* The monitor's intitial state is not in_irq */
 	if (this_cpu_read(hardirq_context))
-		da_handle_event_opid(sched_waking_opid);
+		da_handle_event(sched_waking_opid);
 	else
-		da_handle_start_event_opid(sched_waking_opid);
+		da_handle_start_event(sched_waking_opid);
 }
 
 static int enable_opid(void)
 {
 	int retval;
 
-	retval = da_monitor_init_opid();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -124,7 +122,7 @@ static int enable_opid(void)
 
 static void disable_opid(void)
 {
-	rv_opid.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("opid", irq_disable, handle_irq_disable);
 	rv_detach_trace_probe("opid", irq_enable, handle_irq_enable);
@@ -135,29 +133,29 @@ static void disable_opid(void)
 	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
 	detach_vector_irq();
 
-	da_monitor_destroy_opid();
+	da_monitor_destroy();
 }
 
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_opid = {
+static struct rv_monitor rv_this = {
 	.name = "opid",
 	.description = "operations with preemption and irq disabled.",
 	.enable = enable_opid,
 	.disable = disable_opid,
-	.reset = da_monitor_reset_all_opid,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_opid(void)
 {
-	return rv_register_monitor(&rv_opid, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_opid(void)
 {
-	rv_unregister_monitor(&rv_opid);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_opid);
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
index b4b8c2ff7f64..5014f1b85ecf 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME opid
+
 enum states_opid {
 	disabled_opid = 0,
 	enabled_opid,
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 04c36405e2e3..5a3bd5e16e62 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "sco"
 
@@ -14,31 +13,30 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "sco.h"
-
-static struct rv_monitor rv_sco;
-DECLARE_DA_MON_PER_CPU(sco, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
 {
-	da_handle_start_event_sco(sched_set_state_sco);
+	da_handle_start_event(sched_set_state_sco);
 }
 
 static void handle_schedule_entry(void *data, bool preempt)
 {
-	da_handle_event_sco(schedule_entry_sco);
+	da_handle_event(schedule_entry_sco);
 }
 
 static void handle_schedule_exit(void *data, bool is_switch)
 {
-	da_handle_start_event_sco(schedule_exit_sco);
+	da_handle_start_event(schedule_exit_sco);
 }
 
 static int enable_sco(void)
 {
 	int retval;
 
-	retval = da_monitor_init_sco();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -51,32 +49,32 @@ static int enable_sco(void)
 
 static void disable_sco(void)
 {
-	rv_sco.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("sco", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("sco", sched_entry_tp, handle_schedule_entry);
 	rv_detach_trace_probe("sco", sched_exit_tp, handle_schedule_exit);
 
-	da_monitor_destroy_sco();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_sco = {
+static struct rv_monitor rv_this = {
 	.name = "sco",
 	.description = "scheduling context operations.",
 	.enable = enable_sco,
 	.disable = disable_sco,
-	.reset = da_monitor_reset_all_sco,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_sco(void)
 {
-	return rv_register_monitor(&rv_sco, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_sco(void)
 {
-	rv_unregister_monitor(&rv_sco);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_sco);
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index 7a4c1f2d5ca1..06b1c420ce54 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME sco
+
 enum states_sco {
 	thread_context_sco = 0,
 	scheduling_context_sco,
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index 1e351ba52fee..83b48627dc9f 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "scpd"
 
@@ -15,36 +14,35 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "scpd.h"
-
-static struct rv_monitor rv_scpd;
-DECLARE_DA_MON_PER_CPU(scpd, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_scpd(preempt_disable_scpd);
+	da_handle_event(preempt_disable_scpd);
 }
 
 static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_start_event_scpd(preempt_enable_scpd);
+	da_handle_start_event(preempt_enable_scpd);
 }
 
 static void handle_schedule_entry(void *data, bool preempt)
 {
-	da_handle_event_scpd(schedule_entry_scpd);
+	da_handle_event(schedule_entry_scpd);
 }
 
 static void handle_schedule_exit(void *data, bool is_switch)
 {
-	da_handle_event_scpd(schedule_exit_scpd);
+	da_handle_event(schedule_exit_scpd);
 }
 
 static int enable_scpd(void)
 {
 	int retval;
 
-	retval = da_monitor_init_scpd();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -58,33 +56,33 @@ static int enable_scpd(void)
 
 static void disable_scpd(void)
 {
-	rv_scpd.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("scpd", preempt_disable, handle_preempt_disable);
 	rv_detach_trace_probe("scpd", preempt_enable, handle_preempt_enable);
 	rv_detach_trace_probe("scpd", sched_entry_tp, handle_schedule_entry);
 	rv_detach_trace_probe("scpd", sched_exit_tp, handle_schedule_exit);
 
-	da_monitor_destroy_scpd();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_scpd = {
+static struct rv_monitor rv_this = {
 	.name = "scpd",
 	.description = "schedule called with preemption disabled.",
 	.enable = enable_scpd,
 	.disable = disable_scpd,
-	.reset = da_monitor_reset_all_scpd,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_scpd(void)
 {
-	return rv_register_monitor(&rv_scpd, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_scpd(void)
 {
-	rv_unregister_monitor(&rv_scpd);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_scpd);
diff --git a/kernel/trace/rv/monitors/scpd/scpd.h b/kernel/trace/rv/monitors/scpd/scpd.h
index 295f735a5811..4a725a68085a 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.h
+++ b/kernel/trace/rv/monitors/scpd/scpd.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME scpd
+
 enum states_scpd {
 	cant_sched_scpd = 0,
 	can_sched_scpd,
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 558950f524a5..b80b73795dec 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "snep"
 
@@ -15,36 +14,35 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "snep.h"
-
-static struct rv_monitor rv_snep;
-DECLARE_DA_MON_PER_CPU(snep, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_start_event_snep(preempt_disable_snep);
+	da_handle_start_event(preempt_disable_snep);
 }
 
 static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_start_event_snep(preempt_enable_snep);
+	da_handle_start_event(preempt_enable_snep);
 }
 
 static void handle_schedule_entry(void *data, bool preempt)
 {
-	da_handle_event_snep(schedule_entry_snep);
+	da_handle_event(schedule_entry_snep);
 }
 
 static void handle_schedule_exit(void *data, bool is_switch)
 {
-	da_handle_start_event_snep(schedule_exit_snep);
+	da_handle_start_event(schedule_exit_snep);
 }
 
 static int enable_snep(void)
 {
 	int retval;
 
-	retval = da_monitor_init_snep();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -58,33 +56,33 @@ static int enable_snep(void)
 
 static void disable_snep(void)
 {
-	rv_snep.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("snep", preempt_disable, handle_preempt_disable);
 	rv_detach_trace_probe("snep", preempt_enable, handle_preempt_enable);
 	rv_detach_trace_probe("snep", sched_entry_tp, handle_schedule_entry);
 	rv_detach_trace_probe("snep", sched_exit_tp, handle_schedule_exit);
 
-	da_monitor_destroy_snep();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_snep = {
+static struct rv_monitor rv_this = {
 	.name = "snep",
 	.description = "schedule does not enable preempt.",
 	.enable = enable_snep,
 	.disable = disable_snep,
-	.reset = da_monitor_reset_all_snep,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_snep(void)
 {
-	return rv_register_monitor(&rv_snep, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_snep(void)
 {
-	rv_unregister_monitor(&rv_snep);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_snep);
diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
index 4cd9abb77b7b..753080dc5fa1 100644
--- a/kernel/trace/rv/monitors/snep/snep.h
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME snep
+
 enum states_snep {
 	non_scheduling_context_snep = 0,
 	scheduling_contex_snep,
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index 540e686e699f..f168b1a4b12c 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "snroc"
 
@@ -14,14 +13,13 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_TASK
 #include "snroc.h"
-
-static struct rv_monitor rv_snroc;
-DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
 {
-	da_handle_event_snroc(tsk, sched_set_state_snroc);
+	da_handle_event(tsk, sched_set_state_snroc);
 }
 
 static void handle_sched_switch(void *data, bool preempt,
@@ -29,15 +27,15 @@ static void handle_sched_switch(void *data, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
-	da_handle_start_event_snroc(prev, sched_switch_out_snroc);
-	da_handle_event_snroc(next, sched_switch_in_snroc);
+	da_handle_start_event(prev, sched_switch_out_snroc);
+	da_handle_event(next, sched_switch_in_snroc);
 }
 
 static int enable_snroc(void)
 {
 	int retval;
 
-	retval = da_monitor_init_snroc();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -49,31 +47,31 @@ static int enable_snroc(void)
 
 static void disable_snroc(void)
 {
-	rv_snroc.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
 
-	da_monitor_destroy_snroc();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_snroc = {
+static struct rv_monitor rv_this = {
 	.name = "snroc",
 	.description = "set non runnable on its own context.",
 	.enable = enable_snroc,
 	.disable = disable_snroc,
-	.reset = da_monitor_reset_all_snroc,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_snroc(void)
 {
-	return rv_register_monitor(&rv_snroc, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_snroc(void)
 {
-	rv_unregister_monitor(&rv_snroc);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_snroc);
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index c3650a2b1b10..ada5ee08bdab 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME snroc
+
 enum states_snroc {
 	other_context_snroc = 0,
 	own_context_snroc,
diff --git a/kernel/trace/rv/monitors/sssw/sssw.c b/kernel/trace/rv/monitors/sssw/sssw.c
index 84b8d890d9d4..a91321c890cd 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.c
+++ b/kernel/trace/rv/monitors/sssw/sssw.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "sssw"
 
@@ -15,17 +14,16 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_TASK
 #include "sssw.h"
-
-static struct rv_monitor rv_sssw;
-DECLARE_DA_MON_PER_TASK(sssw, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
 {
 	if (state == TASK_RUNNING)
-		da_handle_start_event_sssw(tsk, sched_set_state_runnable_sssw);
+		da_handle_start_event(tsk, sched_set_state_runnable_sssw);
 	else
-		da_handle_event_sssw(tsk, sched_set_state_sleepable_sssw);
+		da_handle_event(tsk, sched_set_state_sleepable_sssw);
 }
 
 static void handle_sched_switch(void *data, bool preempt,
@@ -34,15 +32,15 @@ static void handle_sched_switch(void *data, bool preempt,
 				unsigned int prev_state)
 {
 	if (preempt)
-		da_handle_event_sssw(prev, sched_switch_preempt_sssw);
+		da_handle_event(prev, sched_switch_preempt_sssw);
 	else if (prev_state == TASK_RUNNING)
-		da_handle_event_sssw(prev, sched_switch_yield_sssw);
+		da_handle_event(prev, sched_switch_yield_sssw);
 	else if (prev_state == TASK_RTLOCK_WAIT)
 		/* special case of sleeping task with racy conditions */
-		da_handle_event_sssw(prev, sched_switch_blocking_sssw);
+		da_handle_event(prev, sched_switch_blocking_sssw);
 	else
-		da_handle_event_sssw(prev, sched_switch_suspend_sssw);
-	da_handle_event_sssw(next, sched_switch_in_sssw);
+		da_handle_event(prev, sched_switch_suspend_sssw);
+	da_handle_event(next, sched_switch_in_sssw);
 }
 
 static void handle_sched_wakeup(void *data, struct task_struct *p)
@@ -51,21 +49,21 @@ static void handle_sched_wakeup(void *data, struct task_struct *p)
 	 * Wakeup can also lead to signal_wakeup although the system is
 	 * actually runnable. The monitor can safely start with this event.
 	 */
-	da_handle_start_event_sssw(p, sched_wakeup_sssw);
+	da_handle_start_event(p, sched_wakeup_sssw);
 }
 
 static void handle_signal_deliver(void *data, int sig,
 				   struct kernel_siginfo *info,
 				   struct k_sigaction *ka)
 {
-	da_handle_event_sssw(current, signal_deliver_sssw);
+	da_handle_event(current, signal_deliver_sssw);
 }
 
 static int enable_sssw(void)
 {
 	int retval;
 
-	retval = da_monitor_init_sssw();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -79,33 +77,33 @@ static int enable_sssw(void)
 
 static void disable_sssw(void)
 {
-	rv_sssw.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("sssw", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("sssw", sched_switch, handle_sched_switch);
 	rv_detach_trace_probe("sssw", sched_wakeup, handle_sched_wakeup);
 	rv_detach_trace_probe("sssw", signal_deliver, handle_signal_deliver);
 
-	da_monitor_destroy_sssw();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_sssw = {
+static struct rv_monitor rv_this = {
 	.name = "sssw",
 	.description = "set state sleep and wakeup.",
 	.enable = enable_sssw,
 	.disable = disable_sssw,
-	.reset = da_monitor_reset_all_sssw,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_sssw(void)
 {
-	return rv_register_monitor(&rv_sssw, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_sssw(void)
 {
-	rv_unregister_monitor(&rv_sssw);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_sssw);
diff --git a/kernel/trace/rv/monitors/sssw/sssw.h b/kernel/trace/rv/monitors/sssw/sssw.h
index 243d54050c94..8409eaadc7e0 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.h
+++ b/kernel/trace/rv/monitors/sssw/sssw.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME sssw
+
 enum states_sssw {
 	runnable_sssw = 0,
 	signal_wakeup_sssw,
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
index c4a9cd67c1d2..ce031cbf202a 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "sts"
 
@@ -16,17 +15,16 @@
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "sts.h"
-
-static struct rv_monitor rv_sts;
-DECLARE_DA_MON_PER_CPU(sts, unsigned char);
+#include <rv/da_monitor.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/trace/irq_vectors.h>
 
 static void handle_vector_irq_entry(void *data, int vector)
 {
-	da_handle_event_sts(irq_entry_sts);
+	da_handle_event(irq_entry_sts);
 }
 
 static void attach_vector_irq(void)
@@ -61,17 +59,17 @@ static void detach_vector_irq(void) { }
 
 static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_sts(irq_disable_sts);
+	da_handle_event(irq_disable_sts);
 }
 
 static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_sts(irq_enable_sts);
+	da_handle_event(irq_enable_sts);
 }
 
 static void handle_irq_entry(void *data, int irq, struct irqaction *action)
 {
-	da_handle_event_sts(irq_entry_sts);
+	da_handle_event(irq_entry_sts);
 }
 
 static void handle_sched_switch(void *data, bool preempt,
@@ -79,24 +77,24 @@ static void handle_sched_switch(void *data, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
-	da_handle_event_sts(sched_switch_sts);
+	da_handle_event(sched_switch_sts);
 }
 
 static void handle_schedule_entry(void *data, bool preempt)
 {
-	da_handle_event_sts(schedule_entry_sts);
+	da_handle_event(schedule_entry_sts);
 }
 
 static void handle_schedule_exit(void *data, bool is_switch)
 {
-	da_handle_start_event_sts(schedule_exit_sts);
+	da_handle_start_event(schedule_exit_sts);
 }
 
 static int enable_sts(void)
 {
 	int retval;
 
-	retval = da_monitor_init_sts();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -113,7 +111,7 @@ static int enable_sts(void)
 
 static void disable_sts(void)
 {
-	rv_sts.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("sts", irq_disable, handle_irq_disable);
 	rv_detach_trace_probe("sts", irq_enable, handle_irq_enable);
@@ -123,29 +121,29 @@ static void disable_sts(void)
 	rv_detach_trace_probe("sts", sched_exit_tp, handle_schedule_exit);
 	detach_vector_irq();
 
-	da_monitor_destroy_sts();
+	da_monitor_destroy();
 }
 
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_sts = {
+static struct rv_monitor rv_this = {
 	.name = "sts",
 	.description = "schedule implies task switch.",
 	.enable = enable_sts,
 	.disable = disable_sts,
-	.reset = da_monitor_reset_all_sts,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_sts(void)
 {
-	return rv_register_monitor(&rv_sts, &rv_sched);
+	return rv_register_monitor(&rv_this, &rv_sched);
 }
 
 static void __exit unregister_sts(void)
 {
-	rv_unregister_monitor(&rv_sts);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_sts);
diff --git a/kernel/trace/rv/monitors/sts/sts.h b/kernel/trace/rv/monitors/sts/sts.h
index 3368b6599a00..3779d7f99404 100644
--- a/kernel/trace/rv/monitors/sts/sts.h
+++ b/kernel/trace/rv/monitors/sts/sts.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME sts
+
 enum states_sts {
 	can_sched_sts = 0,
 	cant_sched_sts,
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 4b4e99615a11..22d77ec42463 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "wip"
 
@@ -14,31 +13,30 @@
 #include <trace/events/sched.h>
 #include <trace/events/preemptirq.h>
 
+#define RV_MON_TYPE RV_MON_PER_CPU
 #include "wip.h"
-
-static struct rv_monitor rv_wip;
-DECLARE_DA_MON_PER_CPU(wip, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_disable_wip);
+	da_handle_event(preempt_disable_wip);
 }
 
 static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_start_event_wip(preempt_enable_wip);
+	da_handle_start_event(preempt_enable_wip);
 }
 
 static void handle_sched_waking(void *data, struct task_struct *task)
 {
-	da_handle_event_wip(sched_waking_wip);
+	da_handle_event(sched_waking_wip);
 }
 
 static int enable_wip(void)
 {
 	int retval;
 
-	retval = da_monitor_init_wip();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -51,32 +49,32 @@ static int enable_wip(void)
 
 static void disable_wip(void)
 {
-	rv_wip.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("wip", preempt_disable, handle_preempt_disable);
 	rv_detach_trace_probe("wip", preempt_enable, handle_preempt_enable);
 	rv_detach_trace_probe("wip", sched_waking, handle_sched_waking);
 
-	da_monitor_destroy_wip();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_wip = {
+static struct rv_monitor rv_this = {
 	.name = "wip",
 	.description = "wakeup in preemptive per-cpu testing monitor.",
 	.enable = enable_wip,
 	.disable = disable_wip,
-	.reset = da_monitor_reset_all_wip,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_wip(void)
 {
-	return rv_register_monitor(&rv_wip, NULL);
+	return rv_register_monitor(&rv_this, NULL);
 }
 
 static void __exit unregister_wip(void)
 {
-	rv_unregister_monitor(&rv_wip);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_wip);
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index c7193748bf36..cfdc52975354 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME wip
+
 enum states_wip {
 	preemptive_wip = 0,
 	non_preemptive_wip,
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 4145bea2729e..579e7e217ee0 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -6,40 +6,38 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "wwnr"
 
 #include <rv_trace.h>
 #include <trace/events/sched.h>
 
+#define RV_MON_TYPE RV_MON_PER_TASK
 #include "wwnr.h"
-
-static struct rv_monitor rv_wwnr;
-DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
+#include <rv/da_monitor.h>
 
 static void handle_switch(void *data, bool preempt, struct task_struct *p,
 			  struct task_struct *n, unsigned int prev_state)
 {
 	/* start monitoring only after the first suspension */
 	if (prev_state == TASK_INTERRUPTIBLE)
-		da_handle_start_event_wwnr(p, switch_out_wwnr);
+		da_handle_start_event(p, switch_out_wwnr);
 	else
-		da_handle_event_wwnr(p, switch_out_wwnr);
+		da_handle_event(p, switch_out_wwnr);
 
-	da_handle_event_wwnr(n, switch_in_wwnr);
+	da_handle_event(n, switch_in_wwnr);
 }
 
 static void handle_wakeup(void *data, struct task_struct *p)
 {
-	da_handle_event_wwnr(p, wakeup_wwnr);
+	da_handle_event(p, wakeup_wwnr);
 }
 
 static int enable_wwnr(void)
 {
 	int retval;
 
-	retval = da_monitor_init_wwnr();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -51,31 +49,31 @@ static int enable_wwnr(void)
 
 static void disable_wwnr(void)
 {
-	rv_wwnr.enabled = 0;
+	rv_this.enabled = 0;
 
 	rv_detach_trace_probe("wwnr", sched_switch, handle_switch);
 	rv_detach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
 
-	da_monitor_destroy_wwnr();
+	da_monitor_destroy();
 }
 
-static struct rv_monitor rv_wwnr = {
+static struct rv_monitor rv_this = {
 	.name = "wwnr",
 	.description = "wakeup while not running per-task testing model.",
 	.enable = enable_wwnr,
 	.disable = disable_wwnr,
-	.reset = da_monitor_reset_all_wwnr,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_wwnr(void)
 {
-	return rv_register_monitor(&rv_wwnr, NULL);
+	return rv_register_monitor(&rv_this, NULL);
 }
 
 static void __exit unregister_wwnr(void)
 {
-	rv_unregister_monitor(&rv_wwnr);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_wwnr);
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 0a59d23edf61..85d12e42a955 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -5,6 +5,8 @@
  *   Documentation/trace/rv/deterministic_automata.rst
  */
 
+#define MONITOR_NAME wwnr
+
 enum states_wwnr {
 	not_running_wwnr = 0,
 	running_wwnr,
-- 
2.51.1

