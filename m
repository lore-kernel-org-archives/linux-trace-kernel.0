Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87B38F246
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013107; cv=none; b=qXg+SxdmFStq24dOZ48B7IpiE02OwarlqdGOenz9D4vO7TVrG8Bc/99S+BMjLMtZgIgtvfkk+jlqzkpwCcWhq0q6rGYjBTajVfSDXIzIs0VfV4yFP/wNAKzqZknft7mBflqA+zx8PEXjvxxe8iKi17MiNPR6iFM2dKKa0eI1WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013107; c=relaxed/simple;
	bh=UkcqPxFrMnX8oapLVXRQvUDr/WDBAFj1V3/5CsJyAGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rc+jcJ8aI4Gm6QBMGT2LD3ZWolZAsziotgwLLeeyrmJbm4GNffJGwnT0WBnY76l0frdbHzwY/+fYqzL9HzuydqyANJqIaR4O9qa9/kXwEKMvOWMiZvbvm7oJFFzlTUWDC+ukv91s0w0H6bXUTN06HOFHT9uTZ8tJ+bxNhoChaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gff2Mdpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gff2Mdpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrLgJZRKJd9EV4di3Mma6bSs+54+0IcSmqgbVj18bK8=;
	b=Gff2MdpyduQt3I+L6U87uhD3XNDPY7Co7gGqPxBusO7FfBH57fqXacfIB6SZTcKD01qsAi
	AIp9Jj3zA8fq0ndA6fJF7Xo29n9wMUWEpvkZrZ/2OKuFyGS7dr1g3OWM7XTpTYdrgp4E0e
	9ICYv5oGjAnsBVVpcd4u6wTfuIhhlY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-oIBB4-Y_MJ-CsCi25Y2vDA-1; Wed,
 25 Feb 2026 04:51:41 -0500
X-MC-Unique: oIBB4-Y_MJ-CsCi25Y2vDA-1
X-Mimecast-MFC-AGG-ID: oIBB4-Y_MJ-CsCi25Y2vDA_1772013100
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EA7E195609F;
	Wed, 25 Feb 2026 09:51:40 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.216])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4C481800370;
	Wed, 25 Feb 2026 09:51:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v6 02/16] rv: Add Hybrid Automata monitor type
Date: Wed, 25 Feb 2026 10:51:08 +0100
Message-ID: <20260225095122.80683-3-gmonaco@redhat.com>
In-Reply-To: <20260225095122.80683-1-gmonaco@redhat.com>
References: <20260225095122.80683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: y6S4-YrfxylyhXNqAk1QTu0_Rcr2KATVm0VTnIWh2n0_1772013100
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Deterministic automata define which events are allowed in every state,
but cannot define more sophisticated constraint taking into account the
system's environment (e.g. time or other states not producing events).

Add the Hybrid Automata monitor type as an extension of Deterministic
automata where each state transition is validating a constraint on a
finite number of environment variables.
Hybrid automata can be used to implement timed automata, where the
environment variables are clocks.

Also implement the necessary functionality to handle clock constraints
(ns or jiffy granularity) on state and events.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V5:
    * Remove useless variable reset when resetting Hybrid Automata
    V4:
    * Improve ns to jiffy rounding in HA timers
    V3:
    * Improve functions naming for HA helpers

 include/linux/rv.h         |  38 +++
 include/rv/da_monitor.h    |  73 +++++-
 include/rv/ha_monitor.h    | 475 +++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig    |  13 +
 kernel/trace/rv/rv_trace.h |  63 +++++
 5 files changed, 658 insertions(+), 4 deletions(-)
 create mode 100644 include/rv/ha_monitor.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 58774eb3aecf..0aef9e3c785c 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -81,11 +81,49 @@ struct ltl_monitor {};
 
 #endif /* CONFIG_RV_LTL_MONITOR */
 
+#ifdef CONFIG_RV_HA_MONITOR
+/*
+ * In the future, hybrid automata may rely on multiple
+ * environment variables, e.g. different clocks started at
+ * different times or running at different speed.
+ * For now we support only 1 variable.
+ */
+#define MAX_HA_ENV_LEN 1
+
+/*
+ * Monitors can pick the preferred timer implementation:
+ * No timer: if monitors don't have state invariants.
+ * Timer wheel: lightweight invariants check but far less precise.
+ * Hrtimer: accurate invariants check with higher overhead.
+ */
+#define HA_TIMER_NONE 0
+#define HA_TIMER_WHEEL 1
+#define HA_TIMER_HRTIMER 2
+
+/*
+ * Hybrid automaton per-object variables.
+ */
+struct ha_monitor {
+	struct da_monitor da_mon;
+	u64 env_store[MAX_HA_ENV_LEN];
+	union {
+		struct hrtimer hrtimer;
+		struct timer_list timer;
+	};
+};
+
+#else
+
+struct ha_monitor { };
+
+#endif /* CONFIG_RV_HA_MONITOR */
+
 #define RV_PER_TASK_MONITOR_INIT	(CONFIG_RV_PER_TASK_MONITORS)
 
 union rv_task_monitor {
 	struct da_monitor	da_mon;
 	struct ltl_monitor	ltl_mon;
+	struct ha_monitor	ha_mon;
 };
 
 #ifdef CONFIG_RV_REACTORS
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 89a0b81d4b3e..ab5fe0896a46 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -3,9 +3,9 @@
  * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
  *
  * Deterministic automata (DA) monitor functions, to be used together
- * with automata models in C generated by the dot2k tool.
+ * with automata models in C generated by the rvgen tool.
  *
- * The dot2k tool is available at tools/verification/dot2k/
+ * The rvgen tool is available at tools/verification/rvgen/
  *
  * For further information, see:
  *   Documentation/trace/rv/monitor_synthesis.rst
@@ -28,6 +28,33 @@
 
 static struct rv_monitor rv_this;
 
+/*
+ * Hook to allow the implementation of hybrid automata: define it with a
+ * function that takes curr_state, event and next_state and returns true if the
+ * environment constraints (e.g. timing) are satisfied, false otherwise.
+ */
+#ifndef da_monitor_event_hook
+#define da_monitor_event_hook(...) true
+#endif
+
+/*
+ * Hook to allow the implementation of hybrid automata: define it with a
+ * function that takes the da_monitor and performs further initialisation
+ * (e.g. reset set up timers).
+ */
+#ifndef da_monitor_init_hook
+#define da_monitor_init_hook(da_mon)
+#endif
+
+/*
+ * Hook to allow the implementation of hybrid automata: define it with a
+ * function that takes the da_monitor and performs further reset (e.g. reset
+ * all clocks).
+ */
+#ifndef da_monitor_reset_hook
+#define da_monitor_reset_hook(da_mon)
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  */
@@ -49,6 +76,7 @@ static void react(enum states curr_state, enum events event)
  */
 static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
+	da_monitor_reset_hook(da_mon);
 	da_mon->monitoring = 0;
 	da_mon->curr_state = model_get_initial_state();
 }
@@ -63,6 +91,7 @@ static inline void da_monitor_start(struct da_monitor *da_mon)
 {
 	da_mon->curr_state = model_get_initial_state();
 	da_mon->monitoring = 1;
+	da_monitor_init_hook(da_mon);
 }
 
 /*
@@ -142,7 +171,10 @@ static inline int da_monitor_init(void)
 /*
  * da_monitor_destroy - destroy the monitor
  */
-static inline void da_monitor_destroy(void) { }
+static inline void da_monitor_destroy(void)
+{
+	da_monitor_reset_all();
+}
 
 #elif RV_MON_TYPE == RV_MON_PER_CPU
 /*
@@ -188,7 +220,10 @@ static inline int da_monitor_init(void)
 /*
  * da_monitor_destroy - destroy the monitor
  */
-static inline void da_monitor_destroy(void) { }
+static inline void da_monitor_destroy(void)
+{
+	da_monitor_reset_all();
+}
 
 #elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
@@ -209,6 +244,24 @@ static inline struct da_monitor *da_get_monitor(struct task_struct *tsk)
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
+/*
+ * da_get_id - return the id associated to the monitor
+ *
+ * For per-task monitors, the id is the task's PID.
+ */
+static inline da_id_type da_get_id(struct da_monitor *da_mon)
+{
+	return da_get_task(da_mon)->pid;
+}
+
 static void da_monitor_reset_all(void)
 {
 	struct task_struct *g, *p;
@@ -253,6 +306,8 @@ static inline void da_monitor_destroy(void)
 	}
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
+
+	da_monitor_reset_all();
 }
 #endif /* RV_MON_TYPE */
 
@@ -279,6 +334,14 @@ static inline void da_trace_error(struct da_monitor *da_mon,
 	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
 }
 
+/*
+ * da_get_id - unused for implicit monitors
+ */
+static inline da_id_type da_get_id(struct da_monitor *da_mon)
+{
+	return 0;
+}
+
 #elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Trace events for per_task monitors, report the PID of the task.
@@ -323,6 +386,8 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
+				return false;
 			da_trace_event(da_mon, model_get_state_name(curr_state),
 				       model_get_event_name(event),
 				       model_get_state_name(next_state),
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
new file mode 100644
index 000000000000..b6cf3b2ba989
--- /dev/null
+++ b/include/rv/ha_monitor.h
@@ -0,0 +1,475 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025-2028 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * Hybrid automata (HA) monitor functions, to be used together
+ * with automata models in C generated by the rvgen tool.
+ *
+ * This type of monitors extends the Deterministic automata (DA) class by
+ * adding a set of environment variables (e.g. clocks) that can be used to
+ * constraint the valid transitions.
+ *
+ * The rvgen tool is available at tools/verification/rvgen/
+ *
+ * For further information, see:
+ *   Documentation/trace/rv/monitor_synthesis.rst
+ */
+
+#ifndef _RV_HA_MONITOR_H
+#define _RV_HA_MONITOR_H
+
+#include <rv/automata.h>
+
+#ifndef da_id_type
+#define da_id_type int
+#endif
+
+static inline void ha_monitor_init_env(struct da_monitor *da_mon);
+static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
+static inline void ha_setup_timer(struct ha_monitor *ha_mon);
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
+static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
+					 enum states curr_state,
+					 enum events event,
+					 enum states next_state,
+					 da_id_type id);
+#define da_monitor_event_hook ha_monitor_handle_constraint
+#define da_monitor_init_hook ha_monitor_init_env
+#define da_monitor_reset_hook ha_monitor_reset_env
+
+#include <rv/da_monitor.h>
+#include <linux/seq_buf.h>
+
+/* This simplifies things since da_mon and ha_mon coexist in the same union */
+_Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
+	       "da_mon must be the first element in an ha_mon!");
+#define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
+
+#define ENV_MAX CONCATENATE(env_max_, MONITOR_NAME)
+#define ENV_MAX_STORED CONCATENATE(env_max_stored_, MONITOR_NAME)
+#define envs CONCATENATE(envs_, MONITOR_NAME)
+
+/* Environment storage before being reset */
+#define ENV_INVALID_VALUE U64_MAX
+/* Error with no event occurs only on timeouts */
+#define EVENT_NONE EVENT_MAX
+#define EVENT_NONE_LBL "none"
+#define ENV_BUFFER_SIZE 64
+
+#ifdef CONFIG_RV_REACTORS
+
+/*
+ * ha_react - trigger the reaction after a failed environment constraint
+ *
+ * The transition from curr_state with event is otherwise valid, but the
+ * environment constraint is false. This function can be called also with no
+ * event from a timer (state constraints only).
+ */
+static void ha_react(enum states curr_state, enum events event, char *env)
+{
+	rv_react(&rv_this,
+		 "rv: monitor %s does not allow event %s on state %s with env %s\n",
+		 __stringify(MONITOR_NAME),
+		 event == EVENT_NONE ? EVENT_NONE_LBL : model_get_event_name(event),
+		 model_get_state_name(curr_state), env);
+}
+
+#else /* CONFIG_RV_REACTOR */
+
+static void ha_react(enum states curr_state, enum events event, char *env) { }
+#endif
+
+/*
+ * model_get_state_name - return the (string) name of the given state
+ */
+static char *model_get_env_name(enum envs env)
+{
+	if ((env < 0) || (env >= ENV_MAX))
+		return "INVALID";
+
+	return RV_AUTOMATON_NAME.env_names[env];
+}
+
+/*
+ * Monitors requiring a timer implementation need to request it explicitly.
+ */
+#ifndef HA_TIMER_TYPE
+#define HA_TIMER_TYPE HA_TIMER_NONE
+#endif
+
+#if HA_TIMER_TYPE == HA_TIMER_WHEEL
+static void ha_monitor_timer_callback(struct timer_list *timer);
+#elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
+static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
+#endif
+
+/*
+ * ktime_get_ns is expensive, since we usually don't require precise accounting
+ * of changes within the same event, cache the current time at the beginning of
+ * the constraint handler and use the cache for subsequent calls.
+ * Monitors without ns clocks automatically skip this.
+ */
+#ifdef HA_CLK_NS
+#define ha_get_ns() ktime_get_ns()
+#else
+#define ha_get_ns() 0
+#endif /* HA_CLK_NS */
+
+/* Should be supplied by the monitor */
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state,
+				 enum events event,
+				 enum states next_state,
+				 u64 time_ns);
+
+/*
+ * ha_monitor_reset_all_stored - reset all environment variables in the monitor
+ */
+static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
+{
+	for (int i = 0; i < ENV_MAX_STORED; i++)
+		WRITE_ONCE(ha_mon->env_store[i], ENV_INVALID_VALUE);
+}
+
+/*
+ * ha_monitor_init_env - setup timer and reset all environment
+ *
+ * Called from a hook in the DA start functions, it supplies the da_mon
+ * corresponding to the current ha_mon.
+ * Not all hybrid automata require the timer, still set it for simplicity.
+ */
+static inline void ha_monitor_init_env(struct da_monitor *da_mon)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+
+	ha_monitor_reset_all_stored(ha_mon);
+	ha_setup_timer(ha_mon);
+}
+
+/*
+ * ha_monitor_reset_env - stop timer and reset all environment
+ *
+ * Called from a hook in the DA reset functions, it supplies the da_mon
+ * corresponding to the current ha_mon.
+ * Not all hybrid automata require the timer, still clear it for simplicity.
+ */
+static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+
+	/* Initialisation resets the monitor before initialising the timer */
+	if (likely(da_monitoring(da_mon)))
+		ha_cancel_timer(ha_mon);
+}
+
+/*
+ * ha_monitor_env_invalid - return true if env has not been initialised
+ */
+static inline bool ha_monitor_env_invalid(struct ha_monitor *ha_mon, enum envs env)
+{
+	return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
+}
+
+static inline void ha_get_env_string(struct seq_buf *s,
+				     struct ha_monitor *ha_mon, u64 time_ns)
+{
+	const char *format_str = "%s=%llu";
+
+	for (int i = 0; i < ENV_MAX; i++) {
+		seq_buf_printf(s, format_str, model_get_env_name(i),
+			       ha_get_env(ha_mon, i, time_ns));
+		format_str = ",%s=%llu";
+	}
+}
+
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
+				      char *curr_state, char *event, char *env,
+				      da_id_type id)
+{
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(curr_state, event, env);
+}
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
+				      char *curr_state, char *event, char *env,
+				      da_id_type id)
+{
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(id, curr_state, event, env);
+}
+#endif /* RV_MON_TYPE */
+
+/*
+ * ha_get_monitor - return the current monitor
+ */
+#define ha_get_monitor(...) to_ha_monitor(da_get_monitor(__VA_ARGS__))
+
+/*
+ * ha_monitor_handle_constraint - handle the constraint on the current transition
+ *
+ * If the monitor implementation defines a constraint in the transition from
+ * curr_state to event, react and trace appropriately as well as return false.
+ * This function is called from the hook in the DA event handle function and
+ * triggers a failure in the monitor.
+ */
+static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
+					 enum states curr_state,
+					 enum events event,
+					 enum states next_state,
+					 da_id_type id)
+{
+	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
+	u64 time_ns = ha_get_ns();
+	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
+
+	if (ha_verify_constraint(ha_mon, curr_state, event, next_state, time_ns))
+		return true;
+
+	ha_get_env_string(&env_string, ha_mon, time_ns);
+	ha_react(curr_state, event, env_string.buffer);
+	ha_trace_error_env(ha_mon,
+			   model_get_state_name(curr_state),
+			   model_get_event_name(event),
+			   env_string.buffer, id);
+	return false;
+}
+
+static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
+{
+	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
+	DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
+	u64 time_ns = ha_get_ns();
+
+	ha_get_env_string(&env_string, ha_mon, time_ns);
+	ha_react(curr_state, EVENT_NONE, env_string.buffer);
+	ha_trace_error_env(ha_mon, model_get_state_name(curr_state),
+			   EVENT_NONE_LBL, env_string.buffer,
+			   da_get_id(&ha_mon->da_mon));
+
+	da_monitor_reset(&ha_mon->da_mon);
+}
+
+/*
+ * The clock variables have 2 different representations in the env_store:
+ * - The guard representation is the timestamp of the last reset
+ * - The invariant representation is the timestamp when the invariant expires
+ * As the representations are incompatible, care must be taken when switching
+ * between them: the invariant representation can only be used when starting a
+ * timer when the previous representation was guard (e.g. no other invariant
+ * started since the last reset operation).
+ * Likewise, switching from invariant to guard representation without a reset
+ * can be done only by subtracting the exact value used to start the invariant.
+ *
+ * Reading the environment variable (ha_get_clk) also reflects this difference
+ * any reads in states that have an invariant return the (possibly negative)
+ * time since expiration, other reads return the time since last reset.
+ */
+
+/*
+ * Helper functions for env variables describing clocks with ns granularity
+ */
+static inline u64 ha_get_clk_ns(struct ha_monitor *ha_mon, enum envs env, u64 time_ns)
+{
+	return time_ns - READ_ONCE(ha_mon->env_store[env]);
+}
+static inline void ha_reset_clk_ns(struct ha_monitor *ha_mon, enum envs env, u64 time_ns)
+{
+	WRITE_ONCE(ha_mon->env_store[env], time_ns);
+}
+static inline void ha_set_invariant_ns(struct ha_monitor *ha_mon, enum envs env,
+				       u64 value, u64 time_ns)
+{
+	WRITE_ONCE(ha_mon->env_store[env], time_ns + value);
+}
+static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
+					 enum envs env, u64 time_ns)
+{
+	return READ_ONCE(ha_mon->env_store[env]) >= time_ns;
+}
+/*
+ * ha_invariant_passed_ns - prepare the invariant and return the time since reset
+ */
+static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum envs env,
+				   u64 expire, u64 time_ns)
+{
+	u64 passed = 0;
+
+	if (env < 0 || env >= ENV_MAX_STORED)
+		return 0;
+	if (ha_monitor_env_invalid(ha_mon, env))
+		return 0;
+	passed = ha_get_env(ha_mon, env, time_ns);
+	ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
+	return passed;
+}
+
+/*
+ * Helper functions for env variables describing clocks with jiffy granularity
+ */
+static inline u64 ha_get_clk_jiffy(struct ha_monitor *ha_mon, enum envs env)
+{
+	return get_jiffies_64() - READ_ONCE(ha_mon->env_store[env]);
+}
+static inline void ha_reset_clk_jiffy(struct ha_monitor *ha_mon, enum envs env)
+{
+	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64());
+}
+static inline void ha_set_invariant_jiffy(struct ha_monitor *ha_mon,
+					  enum envs env, u64 value)
+{
+	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64() + value);
+}
+static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
+					    enum envs env, u64 time_ns)
+{
+	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64());
+
+}
+/*
+ * ha_invariant_passed_jiffy - prepare the invariant and return the time since reset
+ */
+static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enum envs env,
+				      u64 expire, u64 time_ns)
+{
+	u64 passed = 0;
+
+	if (env < 0 || env >= ENV_MAX_STORED)
+		return 0;
+	if (ha_monitor_env_invalid(ha_mon, env))
+		return 0;
+	passed = ha_get_env(ha_mon, env, time_ns);
+	ha_set_invariant_jiffy(ha_mon, env, expire - passed);
+	return passed;
+}
+
+/*
+ * Retrieve the last reset time (guard representation) from the invariant
+ * representation (expiration).
+ * It the caller's responsibility to make sure the storage was actually in the
+ * invariant representation (e.g. the current state has an invariant).
+ * The provided value must be the same used when starting the invariant.
+ *
+ * This function's access to the storage is NOT atomic, due to the rarity when
+ * this is used. If a monitor allows writes concurrent to this, likely
+ * other things are broken and need rethinking the model or additional locking.
+ */
+static inline void ha_inv_to_guard(struct ha_monitor *ha_mon, enum envs env,
+				   u64 value, u64 time_ns)
+{
+	WRITE_ONCE(ha_mon->env_store[env], READ_ONCE(ha_mon->env_store[env]) - value);
+}
+
+#if HA_TIMER_TYPE == HA_TIMER_WHEEL
+/*
+ * Helper functions to handle the monitor timer.
+ * Not all monitors require a timer, in such case the timer will be set up but
+ * never armed.
+ * Timers start since the last reset of the supplied env or from now if env is
+ * not an environment variable. If env was not initialised no timer starts.
+ * Timers can expire on any CPU unless the monitor is per-cpu,
+ * where we assume every event occurs on the local CPU.
+ */
+static void ha_monitor_timer_callback(struct timer_list *timer)
+{
+	struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
+
+	__ha_monitor_timer_callback(ha_mon);
+}
+static inline void ha_setup_timer(struct ha_monitor *ha_mon)
+{
+	int mode = 0;
+
+	if (RV_MON_TYPE == RV_MON_PER_CPU)
+		mode |= TIMER_PINNED;
+	timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
+}
+static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
+					u64 expire, u64 time_ns)
+{
+	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, expire, time_ns);
+
+	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
+}
+static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
+				     u64 expire, u64 time_ns)
+{
+	u64 passed = ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
+
+	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
+			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
+}
+/*
+ * ha_cancel_timer - Cancel the timer
+ *
+ * Returns:
+ *  *  1 when the timer was active
+ *  *  0 when the timer was not active or running a callback
+ */
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
+{
+	return timer_delete(&ha_mon->timer);
+}
+#elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
+/*
+ * Helper functions to handle the monitor timer.
+ * Not all monitors require a timer, in such case the timer will be set up but
+ * never armed.
+ * Timers start since the last reset of the supplied env or from now if env is
+ * not an environment variable. If env was not initialised no timer starts.
+ * Timers can expire on any CPU unless the monitor is per-cpu,
+ * where we assume every event occurs on the local CPU.
+ */
+static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer)
+{
+	struct ha_monitor *ha_mon = container_of(hrtimer, struct ha_monitor, hrtimer);
+
+	__ha_monitor_timer_callback(ha_mon);
+	return HRTIMER_NORESTART;
+}
+static inline void ha_setup_timer(struct ha_monitor *ha_mon)
+{
+	hrtimer_setup(&ha_mon->hrtimer, ha_monitor_timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+}
+static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
+				     u64 expire, u64 time_ns)
+{
+	int mode = HRTIMER_MODE_REL_HARD;
+	u64 passed = ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
+
+	if (RV_MON_TYPE == RV_MON_PER_CPU)
+		mode |= HRTIMER_MODE_PINNED;
+	hrtimer_start(&ha_mon->hrtimer, ns_to_ktime(expire - passed), mode);
+}
+static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
+					u64 expire, u64 time_ns)
+{
+	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, expire, time_ns);
+
+	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
+			  jiffies_to_nsecs(expire - passed), time_ns);
+}
+/*
+ * ha_cancel_timer - Cancel the timer
+ *
+ * Returns:
+ *  *  1 when the timer was active
+ *  *  0 when the timer was not active or running a callback
+ */
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
+{
+	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
+}
+#else /* HA_TIMER_NONE */
+/*
+ * Start function is intentionally not defined, monitors using timers must
+ * set HA_TIMER_TYPE to either HA_TIMER_WHEEL or HA_TIMER_HRTIMER.
+ */
+static inline void ha_setup_timer(struct ha_monitor *ha_mon) { }
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
+{
+	return false;
+}
+#endif
+
+#endif
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 5b4be87ba59d..4ad392dfc57f 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -23,6 +23,19 @@ config LTL_MON_EVENTS_ID
 config RV_LTL_MONITOR
 	bool
 
+config RV_HA_MONITOR
+	bool
+
+config HA_MON_EVENTS_IMPLICIT
+	select DA_MON_EVENTS_IMPLICIT
+	select RV_HA_MONITOR
+	bool
+
+config HA_MON_EVENTS_ID
+	select DA_MON_EVENTS_ID
+	select RV_HA_MONITOR
+	bool
+
 menuconfig RV
 	bool "Runtime Verification"
 	select TRACING
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 4a6faddac614..7c598967bc0e 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -65,6 +65,36 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 #include <monitors/opid/opid_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
+#ifdef CONFIG_HA_MON_EVENTS_IMPLICIT
+/* For simplicity this class is marked as DA although relevant only for HA */
+DECLARE_EVENT_CLASS(error_env_da_monitor,
+
+	TP_PROTO(char *state, char *event, char *env),
+
+	TP_ARGS(state, event, env),
+
+	TP_STRUCT__entry(
+		__string(	state,	state	)
+		__string(	event,	event	)
+		__string(	env,	env	)
+	),
+
+	TP_fast_assign(
+		__assign_str(state);
+		__assign_str(event);
+		__assign_str(env);
+	),
+
+	TP_printk("event %s not expected in the state %s with env %s",
+		__get_str(event),
+		__get_str(state),
+		__get_str(env))
+);
+
+// Add new monitors based on CONFIG_HA_MON_EVENTS_IMPLICIT here
+
+#endif
+
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
 
 #ifdef CONFIG_DA_MON_EVENTS_ID
@@ -128,6 +158,39 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #include <monitors/sssw/sssw_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
+#ifdef CONFIG_HA_MON_EVENTS_ID
+/* For simplicity this class is marked as DA although relevant only for HA */
+DECLARE_EVENT_CLASS(error_env_da_monitor_id,
+
+	TP_PROTO(int id, char *state, char *event, char *env),
+
+	TP_ARGS(id, state, event, env),
+
+	TP_STRUCT__entry(
+		__field(	int,	id	)
+		__string(	state,	state	)
+		__string(	event,	event	)
+		__string(	env,	env	)
+	),
+
+	TP_fast_assign(
+		__assign_str(state);
+		__assign_str(event);
+		__assign_str(env);
+		__entry->id	= id;
+	),
+
+	TP_printk("%d: event %s not expected in the state %s with env %s",
+		__entry->id,
+		__get_str(event),
+		__get_str(state),
+		__get_str(env))
+);
+
+// Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
+
+#endif
+
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #ifdef CONFIG_LTL_MON_EVENTS_ID
 DECLARE_EVENT_CLASS(event_ltl_monitor_id,
-- 
2.53.0

