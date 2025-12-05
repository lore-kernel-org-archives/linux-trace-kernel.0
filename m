Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DD329C66
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940650; cv=none; b=fD79DF/6Y6Q2tRuncjgAPV0cZ94BnOJ5IpxdmEgJvMFDjLJ3znGCYkwwUNKYocv9xD4rf+0ryjSBBZcTKK3PxlkoX0flrXrR/zV6hJBRpQlb81eR2F/i9YQgHTt6qaicL2c0GPPeumBmG12IvxZS+yyDTpMjOaj3E+xHzWNB3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940650; c=relaxed/simple;
	bh=z4YARXkl3mRwNdBVaSkgq2IN/yNX76nuFd5sQgXyqr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKwPmNBJP4SfRxh9y0eqXm8J86wJurrUEIg2Z6oXTlqxjfiq6a9B7WFnqfaOudKQ0zxlOh+qCUUxIAGw37IXnATdNpC1FHwqZHG9mclUv1wFGH/983gGpPOl9qVGJE8MBrwScSusYizfRtoj5H1wE/cG3oaR/KY7f9kM16K5FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzMKnE/Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzMKnE/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC/ums3rFV36I669OltZJV4c+DkcOkRBk2xfHvu3rAo=;
	b=dzMKnE/Z+4zKJXueC1TpwXZAIwagL73wQnS+rD836Mc7O/8VVOtH2JZFcDB2qjVCVKlhzy
	3Nz//+9mLzsNNZGlErkuTgHdLO6Lzv5/Z8ACUQXAT33ydXy3wakBMLzFtxKc7uDJa/JwRF
	S7urI73+IaOp3yGjUjy/BOBpJynQnEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-3UVTRNFnNYSY7liwKJ-zeQ-1; Fri,
 05 Dec 2025 08:17:19 -0500
X-MC-Unique: 3UVTRNFnNYSY7liwKJ-zeQ-1
X-Mimecast-MFC-AGG-ID: 3UVTRNFnNYSY7liwKJ-zeQ_1764940638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63D9A1956055;
	Fri,  5 Dec 2025 13:17:18 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E890180029A;
	Fri,  5 Dec 2025 13:17:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 07/13] rv: Convert the opid monitor to a hybrid automaton
Date: Fri,  5 Dec 2025 14:16:15 +0100
Message-ID: <20251205131621.135513-8-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The opid monitor validates that wakeup and need_resched events only
occur with interrupts and preemption disabled by following the
preemptirq tracepoints.
As reported in [1], those tracepoints might be inaccurate in some
situations (e.g. NMIs).

Since the monitor doesn't validate other ordering properties, remove the
dependency on preemptirq tracepoints and convert the monitor to a hybrid
automaton to validate the constraint during event handling.
This makes the monitor more robust by also removing the workaround for
interrupts missing the preemption tracepoints, which was working on
PREEMPT_RT only and allows the monitor to be built on kernels without
the preemptirqs tracepoints.

[1] - https://lore.kernel.org/lkml/20250625120823.60600-1-gmonaco@redhat.com

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst   |  62 +++---------
 kernel/trace/rv/monitors/opid/Kconfig      |  11 +-
 kernel/trace/rv/monitors/opid/opid.c       | 111 +++++++--------------
 kernel/trace/rv/monitors/opid/opid.h       |  86 ++++------------
 kernel/trace/rv/monitors/opid/opid_trace.h |   4 +
 kernel/trace/rv/rv_trace.h                 |   2 +-
 tools/verification/models/sched/opid.dot   |  36 ++-----
 7 files changed, 82 insertions(+), 230 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 3f8381ad9ec7..0b96d6e147c6 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -346,55 +346,21 @@ Monitor opid
 
 The operations with preemption and irq disabled (opid) monitor ensures
 operations like ``wakeup`` and ``need_resched`` occur with interrupts and
-preemption disabled or during interrupt context, in such case preemption may
-not be disabled explicitly.
+preemption disabled.
 ``need_resched`` can be set by some RCU internals functions, in which case it
-doesn't match a task wakeup and might occur with only interrupts disabled::
-
-                 |                     sched_need_resched
-                 |                     sched_waking
-                 |                     irq_entry
-                 |                   +--------------------+
-                 v                   v                    |
-               +------------------------------------------------------+
-  +----------- |                     disabled                         | <+
-  |            +------------------------------------------------------+  |
-  |              |                 ^                                     |
-  |              |          preempt_disable      sched_need_resched      |
-  |       preempt_enable           |           +--------------------+    |
-  |              v                 |           v                    |    |
-  |            +------------------------------------------------------+  |
-  |            |                   irq_disabled                       |  |
-  |            +------------------------------------------------------+  |
-  |                              |             |        ^                |
-  |     irq_entry            irq_entry         |        |                |
-  |     sched_need_resched       v             |   irq_disable           |
-  |     sched_waking +--------------+          |        |                |
-  |           +----- |              |     irq_enable    |                |
-  |           |      |    in_irq    |          |        |                |
-  |           +----> |              |          |        |                |
-  |                  +--------------+          |        |          irq_disable
-  |                     |                      |        |                |
-  | irq_enable          | irq_enable           |        |                |
-  |                     v                      v        |                |
-  |            #======================================================#  |
-  |            H                     enabled                          H  |
-  |            #======================================================#  |
-  |              |                   ^         ^ preempt_enable     |    |
-  |       preempt_disable     preempt_enable   +--------------------+    |
-  |              v                   |                                   |
-  |            +------------------+  |                                   |
-  +----------> | preempt_disabled | -+                                   |
-               +------------------+                                      |
-                 |                                                       |
-                 +-------------------------------------------------------+
-
-This monitor is designed to work on ``PREEMPT_RT`` kernels, the special case of
-events occurring in interrupt context is a shortcut to identify valid scenarios
-where the preemption tracepoints might not be visible, during interrupts
-preemption is always disabled. On non- ``PREEMPT_RT`` kernels, the interrupts
-might invoke a softirq to set ``need_resched`` and wake up a task. This is
-another special case that is currently not supported by the monitor.
+doesn't match a task wakeup and might occur with only interrupts disabled.
+The interrupt and preemption status are validated by the hybrid automaton
+constraints when processing the events::
+
+   |
+   |
+   v
+ #=========#   sched_need_resched;irq_off == 1
+ H         H   sched_waking;irq_off == 1 && preempt_off == 1
+ H   any   H ------------------------------------------------+
+ H         H                                                 |
+ H         H <-----------------------------------------------+
+ #=========#
 
 References
 ----------
diff --git a/kernel/trace/rv/monitors/opid/Kconfig b/kernel/trace/rv/monitors/opid/Kconfig
index 561d32da572b..6d02e239b684 100644
--- a/kernel/trace/rv/monitors/opid/Kconfig
+++ b/kernel/trace/rv/monitors/opid/Kconfig
@@ -2,18 +2,13 @@
 #
 config RV_MON_OPID
 	depends on RV
-	depends on TRACE_IRQFLAGS
-	depends on TRACE_PREEMPT_TOGGLE
 	depends on RV_MON_SCHED
-	default y if PREEMPT_RT
-	select DA_MON_EVENTS_IMPLICIT
+	default y
+	select HA_MON_EVENTS_IMPLICIT
 	bool "opid monitor"
 	help
 	  Monitor to ensure operations like wakeup and need resched occur with
-	  interrupts and preemption disabled or during IRQs, where preemption
-	  may not be disabled explicitly.
-
-	  This monitor is unstable on !PREEMPT_RT, say N unless you are testing it.
+	  interrupts and preemption disabled.
 
 	  For further information, see:
 	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 25a40e90fa40..160a518ce1cb 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -10,94 +10,63 @@
 #define MODULE_NAME "opid"
 
 #include <trace/events/sched.h>
-#include <trace/events/irq.h>
-#include <trace/events/preemptirq.h>
 #include <rv_trace.h>
 #include <monitors/sched/sched.h>
 
 #define RV_MON_TYPE RV_MON_PER_CPU
 #include "opid.h"
-#include <rv/da_monitor.h>
+#include <rv/ha_monitor.h>
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/trace/irq_vectors.h>
-
-static void handle_vector_irq_entry(void *data, int vector)
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_opid env, u64 time_ns)
 {
-	da_handle_event(irq_entry_opid);
-}
-
-static void attach_vector_irq(void)
-{
-	rv_attach_trace_probe("opid", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_attach_trace_probe("opid", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_attach_trace_probe("opid", reschedule_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("opid", call_function_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("opid", call_function_single_entry, handle_vector_irq_entry);
+	if (env == irq_off_opid)
+		return irqs_disabled();
+	else if (env == preempt_off_opid) {
+		/*
+		 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
+		 * preemption (adding one to the preempt_count). Since we are
+		 * interested in the preempt_count at the time the tracepoint was
+		 * hit, we consider 1 as still enabled.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			return (preempt_count() & PREEMPT_MASK) > 1;
+		return true;
 	}
+	return ENV_INVALID_VALUE;
 }
 
-static void detach_vector_irq(void)
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
 {
-	rv_detach_trace_probe("opid", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_detach_trace_probe("opid", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_detach_trace_probe("opid", reschedule_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("opid", call_function_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("opid", call_function_single_entry, handle_vector_irq_entry);
-	}
+	bool res = true;
+
+	if (curr_state == any_opid && event == sched_need_resched_opid)
+		res = ha_get_env(ha_mon, irq_off_opid, time_ns) == 1ull;
+	else if (curr_state == any_opid && event == sched_waking_opid)
+		res = ha_get_env(ha_mon, irq_off_opid, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, preempt_off_opid, time_ns) == 1ull;
+	return res;
 }
 
-#else
-/* We assume irq_entry tracepoints are sufficient on other architectures */
-static void attach_vector_irq(void) { }
-static void detach_vector_irq(void) { }
-#endif
-
-static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
 {
-	da_handle_event(irq_disable_opid);
-}
+	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
+		return false;
 
-static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
-{
-	da_handle_event(irq_enable_opid);
-}
-
-static void handle_irq_entry(void *data, int irq, struct irqaction *action)
-{
-	da_handle_event(irq_entry_opid);
-}
-
-static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
-{
-	da_handle_event(preempt_disable_opid);
-}
-
-static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
-{
-	da_handle_event(preempt_enable_opid);
+	return true;
 }
 
 static void handle_sched_need_resched(void *data, struct task_struct *tsk, int cpu, int tif)
 {
-	/* The monitor's intitial state is not in_irq */
-	if (this_cpu_read(hardirq_context))
-		da_handle_event(sched_need_resched_opid);
-	else
-		da_handle_start_event(sched_need_resched_opid);
+	da_handle_start_event(sched_need_resched_opid);
 }
 
 static void handle_sched_waking(void *data, struct task_struct *p)
 {
-	/* The monitor's intitial state is not in_irq */
-	if (this_cpu_read(hardirq_context))
-		da_handle_event(sched_waking_opid);
-	else
-		da_handle_start_event(sched_waking_opid);
+	da_handle_start_event(sched_waking_opid);
 }
 
 static int enable_opid(void)
@@ -108,14 +77,8 @@ static int enable_opid(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("opid", irq_disable, handle_irq_disable);
-	rv_attach_trace_probe("opid", irq_enable, handle_irq_enable);
-	rv_attach_trace_probe("opid", irq_handler_entry, handle_irq_entry);
-	rv_attach_trace_probe("opid", preempt_disable, handle_preempt_disable);
-	rv_attach_trace_probe("opid", preempt_enable, handle_preempt_enable);
 	rv_attach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
 	rv_attach_trace_probe("opid", sched_waking, handle_sched_waking);
-	attach_vector_irq();
 
 	return 0;
 }
@@ -124,14 +87,8 @@ static void disable_opid(void)
 {
 	rv_this.enabled = 0;
 
-	rv_detach_trace_probe("opid", irq_disable, handle_irq_disable);
-	rv_detach_trace_probe("opid", irq_enable, handle_irq_enable);
-	rv_detach_trace_probe("opid", irq_handler_entry, handle_irq_entry);
-	rv_detach_trace_probe("opid", preempt_disable, handle_preempt_disable);
-	rv_detach_trace_probe("opid", preempt_enable, handle_preempt_enable);
 	rv_detach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
 	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
-	detach_vector_irq();
 
 	da_monitor_destroy();
 }
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
index 092992514970..fb0aa4c28aa6 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -8,30 +8,31 @@
 #define MONITOR_NAME opid
 
 enum states_opid {
-	disabled_opid,
-	enabled_opid,
-	in_irq_opid,
-	irq_disabled_opid,
-	preempt_disabled_opid,
+	any_opid,
 	state_max_opid,
 };
 
 #define INVALID_STATE state_max_opid
 
 enum events_opid {
-	irq_disable_opid,
-	irq_enable_opid,
-	irq_entry_opid,
-	preempt_disable_opid,
-	preempt_enable_opid,
 	sched_need_resched_opid,
 	sched_waking_opid,
 	event_max_opid,
 };
 
+enum envs_opid {
+	irq_off_opid,
+	preempt_off_opid,
+	env_max_opid,
+	env_max_stored_opid = irq_off_opid,
+};
+
+_Static_assert(env_max_stored_opid <= MAX_HA_ENV_LEN, "Not enough slots");
+
 struct automaton_opid {
 	char *state_names[state_max_opid];
 	char *event_names[event_max_opid];
+	char *env_names[env_max_opid];
 	unsigned char function[state_max_opid][event_max_opid];
 	unsigned char initial_state;
 	bool final_states[state_max_opid];
@@ -39,68 +40,19 @@ struct automaton_opid {
 
 static const struct automaton_opid automaton_opid = {
 	.state_names = {
-		"disabled",
-		"enabled",
-		"in_irq",
-		"irq_disabled",
-		"preempt_disabled",
+		"any",
 	},
 	.event_names = {
-		"irq_disable",
-		"irq_enable",
-		"irq_entry",
-		"preempt_disable",
-		"preempt_enable",
 		"sched_need_resched",
 		"sched_waking",
 	},
+	.env_names = {
+		"irq_off",
+		"preempt_off",
+	},
 	.function = {
-		{
-			INVALID_STATE,
-			preempt_disabled_opid,
-			disabled_opid,
-			INVALID_STATE,
-			irq_disabled_opid,
-			disabled_opid,
-			disabled_opid,
-		},
-		{
-			irq_disabled_opid,
-			INVALID_STATE,
-			INVALID_STATE,
-			preempt_disabled_opid,
-			enabled_opid,
-			INVALID_STATE,
-			INVALID_STATE,
-		},
-		{
-			INVALID_STATE,
-			enabled_opid,
-			in_irq_opid,
-			INVALID_STATE,
-			INVALID_STATE,
-			in_irq_opid,
-			in_irq_opid,
-		},
-		{
-			INVALID_STATE,
-			enabled_opid,
-			in_irq_opid,
-			disabled_opid,
-			INVALID_STATE,
-			irq_disabled_opid,
-			INVALID_STATE,
-		},
-		{
-			disabled_opid,
-			INVALID_STATE,
-			INVALID_STATE,
-			INVALID_STATE,
-			enabled_opid,
-			INVALID_STATE,
-			INVALID_STATE,
-		},
+		{           any_opid,           any_opid },
 	},
-	.initial_state = disabled_opid,
-	.final_states = { 0, 1, 0, 0, 0 },
+	.initial_state = any_opid,
+	.final_states = { 1 },
 };
diff --git a/kernel/trace/rv/monitors/opid/opid_trace.h b/kernel/trace/rv/monitors/opid/opid_trace.h
index 3df6ff955c30..b04005b64208 100644
--- a/kernel/trace/rv/monitors/opid/opid_trace.h
+++ b/kernel/trace/rv/monitors/opid/opid_trace.h
@@ -12,4 +12,8 @@ DEFINE_EVENT(event_da_monitor, event_opid,
 DEFINE_EVENT(error_da_monitor, error_opid,
 	     TP_PROTO(char *state, char *event),
 	     TP_ARGS(state, event));
+
+DEFINE_EVENT(error_env_da_monitor, error_env_opid,
+	     TP_PROTO(char *state, char *event, char *env),
+	     TP_ARGS(state, event, env));
 #endif /* CONFIG_RV_MON_OPID */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 1661f8fe4a88..9e8072d863a2 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -62,7 +62,6 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 #include <monitors/scpd/scpd_trace.h>
 #include <monitors/snep/snep_trace.h>
 #include <monitors/sts/sts_trace.h>
-#include <monitors/opid/opid_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #ifdef CONFIG_HA_MON_EVENTS_IMPLICIT
@@ -91,6 +90,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 		__get_str(env))
 );
 
+#include <monitors/opid/opid_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_IMPLICIT here
 
 #endif
diff --git a/tools/verification/models/sched/opid.dot b/tools/verification/models/sched/opid.dot
index 840052f6952b..511051fce430 100644
--- a/tools/verification/models/sched/opid.dot
+++ b/tools/verification/models/sched/opid.dot
@@ -1,35 +1,13 @@
 digraph state_automaton {
 	center = true;
 	size = "7,11";
-	{node [shape = plaintext, style=invis, label=""] "__init_disabled"};
-	{node [shape = circle] "disabled"};
-	{node [shape = doublecircle] "enabled"};
-	{node [shape = circle] "enabled"};
-	{node [shape = circle] "in_irq"};
-	{node [shape = circle] "irq_disabled"};
-	{node [shape = circle] "preempt_disabled"};
-	"__init_disabled" -> "disabled";
-	"disabled" [label = "disabled"];
-	"disabled" -> "disabled" [ label = "sched_need_resched\nsched_waking\nirq_entry" ];
-	"disabled" -> "irq_disabled" [ label = "preempt_enable" ];
-	"disabled" -> "preempt_disabled" [ label = "irq_enable" ];
-	"enabled" [label = "enabled", color = green3];
-	"enabled" -> "enabled" [ label = "preempt_enable" ];
-	"enabled" -> "irq_disabled" [ label = "irq_disable" ];
-	"enabled" -> "preempt_disabled" [ label = "preempt_disable" ];
-	"in_irq" [label = "in_irq"];
-	"in_irq" -> "enabled" [ label = "irq_enable" ];
-	"in_irq" -> "in_irq" [ label = "sched_need_resched\nsched_waking\nirq_entry" ];
-	"irq_disabled" [label = "irq_disabled"];
-	"irq_disabled" -> "disabled" [ label = "preempt_disable" ];
-	"irq_disabled" -> "enabled" [ label = "irq_enable" ];
-	"irq_disabled" -> "in_irq" [ label = "irq_entry" ];
-	"irq_disabled" -> "irq_disabled" [ label = "sched_need_resched" ];
-	"preempt_disabled" [label = "preempt_disabled"];
-	"preempt_disabled" -> "disabled" [ label = "irq_disable" ];
-	"preempt_disabled" -> "enabled" [ label = "preempt_enable" ];
+	{node [shape = plaintext, style=invis, label=""] "__init_any"};
+	{node [shape = doublecircle] "any"};
+	"__init_any" -> "any";
+	"any" [label = "any", color = green3];
+	"any" -> "any" [ label = "sched_need_resched;irq_off == 1\nsched_waking;irq_off == 1 && preempt_off == 1" ];
 	{ rank = min ;
-		"__init_disabled";
-		"disabled";
+		"__init_any";
+		"any";
 	}
 }
-- 
2.52.0

