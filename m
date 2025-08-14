Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBD23BF96
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184159; cv=none; b=hlp8eEni8tdFJoo996znR3pzws/GJ/qs9fJVDOzzz9S6Z9hNuIYBJgXltgMhnxKIfstm6S/B2ONgRTAlBS/8LX8FFyxz39PDwSOihcWlooRUEnsSI4XuoXdskKGFuqIIPzCavuidShCnO2nkfkk2aY5vFfkEdSL9MuOYXXRN2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184159; c=relaxed/simple;
	bh=+dveDZ+/QQnzwjDZ/ZZc+P+avH8tswQA4hF8LIZqgG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJexv0mksTHJMxvJxsx47stCEl1PU04ryAb7REYQ7VagQG4lSVzUjRvyJQqy7fRPgzLZlKibPYS1d1E+CxX6Mb3LpR8Bxk5dXpZLtic8E256S1eAYIoF6eK7UJA4sYx0j8gmKrzsmpgCLvgp9SHEa3dUWuZdCLwD+6CiGDUAoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pwzd2iqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pwzd2iqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl6ud9f0tCPqGqOO8OxXwzKz428gGR/oiYCMShDgB5Y=;
	b=Pwzd2iqL64b7vpLIwVG1a1ZA/fD6JZtjRjtdCtXO9/imJz8ocnI6nvaZTE3+YA1MS2vv7X
	fslHMPHt4g/p9KqMcDxfGyPMBbNBNk3ligT/U9nNkAVzsU3gMl7uoVxAyR4dylFg1e8Zky
	FAPH3xVulNXE0PxlN4whNS8X5wmdEzQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-ZMo_Bs_-MKOx_j3zCWp_BA-1; Thu,
 14 Aug 2025 11:09:13 -0400
X-MC-Unique: ZMo_Bs_-MKOx_j3zCWp_BA-1
X-Mimecast-MFC-AGG-ID: ZMo_Bs_-MKOx_j3zCWp_BA_1755184151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1EBE19560A2;
	Thu, 14 Aug 2025 15:09:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13B13180029A;
	Thu, 14 Aug 2025 15:09:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Date: Thu, 14 Aug 2025 17:08:00 +0200
Message-ID: <20250814150809.140739-9-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h         |  26 +++
 include/rv/da_monitor.h    |  45 ++++-
 include/rv/ha_monitor.h    | 384 +++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig    |  13 ++
 kernel/trace/rv/rv_trace.h |  63 ++++++
 5 files changed, 526 insertions(+), 5 deletions(-)
 create mode 100644 include/rv/ha_monitor.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 3134681553b4..6a7594080db1 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -83,11 +83,37 @@ struct ltl_monitor {};
 
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
+ * Hybrid automaton per-object variables.
+ */
+struct ha_monitor {
+	struct da_monitor da_mon;
+	u64 env_store[MAX_HA_ENV_LEN];
+	struct hrtimer timer;
+};
+#define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
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
index 57a6e742d454..d95ece5b7908 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -24,6 +24,33 @@
 #define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
 static struct rv_monitor RV_MONITOR_NAME;
 
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
 #ifdef CONFIG_RV_REACTORS
 
 static void cond_react(enum states curr_state, enum events event)
@@ -51,6 +78,7 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
 	da_mon->monitoring = 0;
 	da_mon->curr_state = model_get_initial_state();
+	da_monitor_reset_hook(da_mon);
 }
 
 /*
@@ -63,6 +91,7 @@ static inline void da_monitor_start(struct da_monitor *da_mon)
 {
 	da_mon->curr_state = model_get_initial_state();
 	da_mon->monitoring = 1;
+	da_monitor_init_hook(da_mon);
 }
 
 /*
@@ -130,6 +159,9 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event)
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			if (!da_monitor_event_hook(curr_state, event, next_state))
+				return false;
+
 			CONCATENATE(trace_event_, MONITOR_NAME)(
 				    model_get_state_name(curr_state),
 				    model_get_event_name(event),
@@ -171,6 +203,9 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+			if (!da_monitor_event_hook(tsk, curr_state, event, next_state))
+				return false;
+
 			CONCATENATE(trace_event_, MONITOR_NAME)(tsk->pid,
 				    model_get_state_name(curr_state),
 				    model_get_event_name(event),
@@ -196,14 +231,14 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 /*
  * global monitor (a single variable)
  */
-static struct da_monitor RV_DA_MON_NAME;
+static union rv_task_monitor RV_DA_MON_NAME;
 
 /*
  * da_get_monitor - return the global monitor address
  */
 static struct da_monitor *da_get_monitor(void)
 {
-	return &RV_DA_MON_NAME;
+	return &(RV_DA_MON_NAME.da_mon);
 }
 
 /*
@@ -239,14 +274,14 @@ static inline void da_monitor_destroy(void)
 /*
  * per-cpu monitor variables
  */
-static DEFINE_PER_CPU(struct da_monitor, RV_DA_MON_NAME);
+static DEFINE_PER_CPU(union rv_task_monitor, RV_DA_MON_NAME);
 
 /*
  * da_get_monitor - return current CPU monitor address
  */
 static struct da_monitor *da_get_monitor(void)
 {
-	return this_cpu_ptr(&RV_DA_MON_NAME);
+	return &this_cpu_ptr(&RV_DA_MON_NAME)->da_mon;
 }
 
 /*
@@ -257,7 +292,7 @@ static void da_monitor_reset_all(void)
 	struct da_monitor *da_mon;
 	int cpu;
 	for_each_cpu(cpu, cpu_online_mask) {
-		da_mon = per_cpu_ptr(&RV_DA_MON_NAME, cpu);
+		da_mon = &per_cpu_ptr(&RV_DA_MON_NAME, cpu)->da_mon;
 		da_monitor_reset(da_mon);
 	}
 }
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
new file mode 100644
index 000000000000..a7c7297a9759
--- /dev/null
+++ b/include/rv/ha_monitor.h
@@ -0,0 +1,384 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025-2028 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ *
+ * Hybrid automata (HA) monitor functions, to be used together
+ * with automata models in C generated by the dot2k tool.
+ *
+ * This type of monitors extends the Deterministic automata (DA) class by
+ * adding a set of environment variables (e.g. clocks) that can be used to
+ * constraint the valid transitions.
+ *
+ * The dot2k tool is available at tools/verification/dot2k/
+ *
+ * For further information, see:
+ *   Documentation/trace/rv/ha_monitor_synthesis.rst
+ */
+
+#ifndef _RV_HA_MONITOR_H
+#define _RV_HA_MONITOR_H
+
+#include <rv/automata.h>
+
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+static bool ha_monitor_handle_constraint(enum states curr_state, enum events event, enum states next_state);
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+static bool ha_monitor_handle_constraint(struct task_struct *tsk, enum states curr_state, enum events event, enum states next_state);
+#endif
+static inline void ha_monitor_init_env(struct da_monitor *da_mon);
+static inline void ha_monitor_reset_env(struct da_monitor *da_mon);
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
+#define da_monitor_event_hook ha_monitor_handle_constraint
+#define da_monitor_init_hook ha_monitor_init_env
+#define da_monitor_reset_hook ha_monitor_reset_env
+
+#include <rv/da_monitor.h>
+#include <linux/seq_buf.h>
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
+
+#ifdef CONFIG_RV_REACTORS
+
+/*
+ * Trigger the reaction after a failed environment constraint (e.g. related to a
+ * clock).
+ */
+static void ha_cond_react(enum states curr_state, enum events event, char *env)
+{
+	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
+		return;
+	RV_MONITOR_NAME.react("rv: monitor %s does not allow event %s on state %s with env %s\n",
+			__stringify(MONITOR_NAME),
+			event == EVENT_NONE ? EVENT_NONE_LBL : model_get_event_name(event),
+			model_get_state_name(curr_state),
+			env);
+}
+
+#else /* CONFIG_RV_REACTOR */
+
+static void ha_cond_react(enum states curr_state, enum events event, char *env)
+{
+	return;
+}
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
+static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *timer);
+
+/* Should be supplied by the monitor */
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env);
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state,
+				 enum events event,
+				 enum states next_state);
+
+/*
+ * ha_monitor_reset_all_stored - reset all environment variables in the monitor
+ */
+static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
+{
+	for (int i = 0; i < ENV_MAX_STORED; i++)
+		smp_store_mb(ha_mon->env_store[i], ENV_INVALID_VALUE);
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
+	if (unlikely(!ha_mon->timer.base))
+		hrtimer_setup(&ha_mon->timer, ha_monitor_timer_callback,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
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
+	ha_monitor_reset_all_stored(ha_mon);
+	/* Initialisation resets the monitor before initialising the timer */
+	if (likely(ha_mon->timer.base))
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
+/*
+ * ha_monitor_all_env_is_valid - return true if all env has been initialised
+ */
+static inline bool ha_monitor_all_env_is_valid(struct ha_monitor *ha_mon)
+{
+	for (int i = 0; i < ENV_MAX_STORED; i++) {
+		if (ha_monitor_env_invalid(ha_mon, i))
+			return false;
+	}
+	return true;
+}
+
+static inline void ha_get_env_string(struct seq_buf * s, struct ha_monitor *ha_mon)
+{
+	const char *format_str = "%s=%llu";
+
+	for (int i = 0; i < ENV_MAX; i++) {
+		seq_buf_printf(s, format_str, model_get_env_name(i),
+			       ha_get_env(ha_mon, i));
+		format_str = ",%s=%llu";
+	}
+}
+
+#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
+
+/*
+ * ha_get_monitor - return the global or per-cpu monitor address
+ */
+static inline struct ha_monitor *ha_get_monitor(void)
+{
+	return to_ha_monitor(da_get_monitor());
+}
+
+/*
+ * ha_monitor_handle_constraint - handle the constraint on the current transition
+ *
+ * If the monitor implementation defines a constraint in the transition from
+ * curr_state to event, react and trace appropriately as well as return false.
+ * This function is called from the hook in the DA event handle function and
+ * triggers a failure in the monitor.
+ */
+static bool ha_monitor_handle_constraint(enum states curr_state,
+					 enum events event,
+					 enum states next_state)
+{
+	struct ha_monitor *ha_mon = ha_get_monitor();
+	DECLARE_SEQ_BUF(env_string, MAX_DA_NAME_LEN);
+	bool env_was_valid;
+
+	env_was_valid = ha_monitor_all_env_is_valid(ha_mon);
+
+	if (ha_verify_constraint(ha_mon, curr_state, event, next_state))
+		return true;
+
+	/*
+	 * If we started with an uninitialised environment, chances are the
+	 * failure is a false positive. Do not fail the monitor just this time.
+	 * Note that we need to run ha_verify_constraint first as it might
+	 * initialise the environment.
+	 */
+	if (!env_was_valid)
+		return true;
+
+	ha_get_env_string(&env_string, ha_mon);
+	ha_cond_react(curr_state, event, env_string.buffer);
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(
+			   model_get_state_name(curr_state),
+			   model_get_event_name(event),
+			   env_string.buffer);
+	return false;
+}
+
+static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *timer)
+{
+	struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
+	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
+	DECLARE_SEQ_BUF(env_string, MAX_DA_NAME_LEN);
+
+	ha_get_env_string(&env_string, ha_mon);
+	ha_cond_react(curr_state, EVENT_NONE, env_string.buffer);
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(
+		    model_get_state_name(curr_state),
+		    EVENT_NONE_LBL,
+		    env_string.buffer);
+
+	da_monitor_reset(&ha_mon->da_mon);
+
+	return HRTIMER_NORESTART;
+}
+
+#elif RV_MON_TYPE == RV_MON_PER_TASK
+
+/*
+ * ha_get_monitor - return the per-task monitor address
+ */
+static inline struct ha_monitor *ha_get_monitor(struct task_struct *tsk)
+{
+	return to_ha_monitor(da_get_monitor(tsk));
+}
+
+/*
+ * ha_monitor_handle_constraint - handle the constraint on the current transition
+ *
+ * If the monitor implementation defines a constraint in the transition from
+ * curr_state to event, react and trace appropriately as well as return false.
+ * This function is called from the hook in the DA event handle function and
+ * triggers a failure in the monitor.
+ */
+static bool ha_monitor_handle_constraint(struct task_struct *tsk,
+					 enum states curr_state,
+					 enum events event,
+					 enum states next_state)
+{
+	struct ha_monitor *ha_mon = ha_get_monitor(tsk);
+	DECLARE_SEQ_BUF(env_string, 32);
+	bool env_was_valid;
+
+	env_was_valid = ha_monitor_all_env_is_valid(ha_mon);
+
+	if (ha_verify_constraint(ha_mon, curr_state, event, next_state))
+		return true;
+
+	/*
+	 * If we started with an uninitialised environment, chances are the
+	 * failure is a false positive. Do not fail the monitor just this time.
+	 * Note that we need to run ha_verify_constraint first as it might
+	 * initialise the environment.
+	 */
+	if (!env_was_valid)
+		return true;
+
+	ha_get_env_string(&env_string, ha_mon);
+	ha_cond_react(curr_state, event, env_string.buffer);
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(tsk->pid,
+			   model_get_state_name(curr_state),
+			   model_get_event_name(event),
+			   env_string.buffer);
+	return false;
+}
+
+static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *timer)
+{
+	struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
+	enum states curr_state = READ_ONCE(ha_mon->da_mon.curr_state);
+	DECLARE_SEQ_BUF(env_string, MAX_DA_NAME_LEN);
+	struct task_struct *tsk;
+
+	tsk = container_of(ha_mon, struct task_struct, rv[task_mon_slot].ha_mon);
+	ha_get_env_string(&env_string, ha_mon);
+	ha_cond_react(curr_state, EVENT_NONE, env_string.buffer);
+	CONCATENATE(trace_error_env_, MONITOR_NAME)(tsk->pid,
+		    model_get_state_name(curr_state),
+		    EVENT_NONE_LBL,
+		    env_string.buffer);
+
+	da_monitor_reset(&ha_mon->da_mon);
+
+	return HRTIMER_NORESTART;
+}
+
+#endif /* RV_MON_TYPE */
+
+/*
+ * Helper functions for env variables describing clocks with ns granularity
+ */
+static inline u64 ha_get_clk_ns(struct ha_monitor *ha_mon, enum envs env)
+{
+	return ktime_get_ns() - READ_ONCE(ha_mon->env_store[env]);
+}
+static inline void ha_reset_clk_ns(struct ha_monitor *ha_mon, enum envs env)
+{
+	smp_store_mb(ha_mon->env_store[env], ktime_get_ns());
+}
+
+/*
+ * Helper functions for env variables describing clocks with jiffy granularity
+ */
+static inline u64 ha_get_clk_jiffy(struct ha_monitor *ha_mon, enum envs env)
+{
+	return jiffies - READ_ONCE(ha_mon->env_store[env]);
+}
+static inline void ha_reset_clk_jiffy(struct ha_monitor *ha_mon, enum envs env)
+{
+	smp_store_mb(ha_mon->env_store[env], jiffies);
+}
+
+/*
+ * Helper functions to handle the monitor timer.
+ * Not all monitors require a timer, in such case the timer will be set up but
+ * never armed.
+ * Timers start since the last reset of the supplied env or from now if env is
+ * not an environment variable. If env was not initialised no timer starts.
+ * Timers can expire on any CPU unless the monitor is per-cpu,
+ * where we assume every event occurs on the local CPU.
+ */
+static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
+				     u64 expire)
+{
+	int mode = HRTIMER_MODE_REL;
+	u64 passed = 0;
+
+	if (env >= 0 && env < ENV_MAX_STORED) {
+		if (ha_monitor_env_invalid(ha_mon, env))
+			return;
+		passed = ha_get_env(ha_mon, env);
+	}
+	if (RV_MON_TYPE == RV_MON_PER_CPU)
+		mode |= HRTIMER_MODE_PINNED;
+	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire - passed), mode);
+}
+static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon,
+					enum envs env, u64 expire)
+{
+	u64 passed = 0;
+
+	if (env >= 0 && env < ENV_MAX_STORED) {
+		if (ha_monitor_env_invalid(ha_mon, env))
+			return;
+		passed = ha_get_env(ha_mon, env);
+	}
+	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
+			jiffies_to_nsecs(expire - passed));
+}
+/*
+ * ha_cancel_timer - Cancel the timer and return whether it expired
+ *
+ * Return true if the timer was cancelled after expiration but before the
+ * callback could run.
+ */
+static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
+{
+	ktime_t remaining;
+
+	if (!hrtimer_active(&ha_mon->timer))
+		return false;
+	remaining = hrtimer_get_remaining(&ha_mon->timer);
+	if (hrtimer_try_to_cancel(&ha_mon->timer) == 1 && remaining < 0)
+		return true;
+	return false;
+}
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
index 4a6faddac614..dbb0cbbe15ca 100644
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
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__array(	char,	env,		MAX_DA_NAME_LEN	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		memcpy(__entry->env,		env,		MAX_DA_NAME_LEN);
+	),
+
+	TP_printk("event %s not expected in the state %s with env %s\n",
+		__entry->event,
+		__entry->state,
+		__entry->env)
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
+		__field(	int,	id				)
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__array(	char,	env,		MAX_DA_NAME_LEN	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		memcpy(__entry->env,		env,		MAX_DA_NAME_LEN);
+		__entry->id			= id;
+	),
+
+	TP_printk("%d: event %s not expected in the state %s with env %s\n",
+		__entry->id,
+		__entry->event,
+		__entry->state,
+		__entry->env)
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
2.50.1

