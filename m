Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438F24BC04
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183534; cv=none; b=u8gdBX/hRgYOWbnSMNibzpcquy1S4OD02n+7qW+jqe/GMfANo7I1xMr6+uYTLdlc8ExCMdL2BCl5bjonx3WkWU7TABLZ9wJW5bCDBO5NrduVQMLBvCTAZNroldukJCpHwkWn0vTzl+WVhfG5ywsnu5/cex19wq1g7nVFipRwgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183534; c=relaxed/simple;
	bh=iyP2Et2ThSTmEMRnF8Q5S+KrQamEDzqdykjNcTzrrYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL9ivTGIpG5WMvNWb1ucphT8ncWNiREyQf35DErz9G9fKiNUgbKDUzgY3RwBj1DbvEcwq8FewVR6Bw27mcYbm0g3XAMhlqJKmt19NGFBotOz62ngQ7+/YW2Ny8AabyG1VLYDERzpK3Dm2a4iJsikaSa4pjO9f7Up67owwnT3c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvobSpBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvobSpBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741183531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeHDHQeaUelPtUn2NnMKUjdmcK35QwBedCqiW2pVWqk=;
	b=BvobSpBYEH6lSxjSWRTevRZouNSPnDi9qVbemLY9rgSMjlANC1rbL0QxbSOqTXwWFNS/Q1
	cBq59/EUcTmX5yBkA7dqdzsXLXnIvjS7MDY+dknZpJiDPNp7NeX/k/TbalIQOgoJ25PRai
	jC80Xlk6iXpe4w/UjfcyShKXQpHKNIY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-z7-m9lJkNjKsFPnsfpYugw-1; Wed,
 05 Mar 2025 09:05:28 -0500
X-MC-Unique: z7-m9lJkNjKsFPnsfpYugw-1
X-Mimecast-MFC-AGG-ID: z7-m9lJkNjKsFPnsfpYugw_1741183527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 842141868189;
	Wed,  5 Mar 2025 14:04:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26C8D3000708;
	Wed,  5 Mar 2025 14:04:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v5 1/9] sched: Add sched tracepoints for RV task model
Date: Wed,  5 Mar 2025 15:03:54 +0100
Message-ID: <20250305140406.350227-2-gmonaco@redhat.com>
In-Reply-To: <20250305140406.350227-1-gmonaco@redhat.com>
References: <20250305140406.350227-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the following tracepoints:
* sched_entry(bool preempt, ip)
    Called while entering __schedule
* sched_exit(bool is_switch, ip)
    Called while exiting __schedule
* sched_set_state(task, curr_state, state)
    Called when a task changes its state (to and from running)

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h                 |  2 +-
 include/linux/sched.h              | 16 ++++++++++++++++
 include/trace/events/sched.h       | 13 +++++++++++++
 kernel/sched/core.c                | 23 ++++++++++++++++++++++-
 tools/verification/rv/include/rv.h |  2 +-
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 8883b41d88ec4..55d458be53a4c 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,7 +7,7 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#define MAX_DA_NAME_LEN	24
+#define MAX_DA_NAME_LEN	32
 
 #ifdef CONFIG_RV
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..45a61a0b97903 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -46,6 +46,7 @@
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
+#include <linux/tracepoint-defs.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -186,6 +187,12 @@ struct user_event_mm;
 # define debug_rtlock_wait_restore_state()	do { } while (0)
 #endif
 
+#define trace_set_current_state(state_value)                     \
+	do {                                                     \
+		if (tracepoint_enabled(sched_set_state_tp))      \
+			__trace_set_current_state(state_value); \
+	} while (0)
+
 /*
  * set_current_state() includes a barrier so that the write of current->__state
  * is correctly serialised wrt the caller's subsequent test of whether to
@@ -226,12 +233,14 @@ struct user_event_mm;
 #define __set_current_state(state_value)				\
 	do {								\
 		debug_normal_state_change((state_value));		\
+		trace_set_current_state(state_value);			\
 		WRITE_ONCE(current->__state, (state_value));		\
 	} while (0)
 
 #define set_current_state(state_value)					\
 	do {								\
 		debug_normal_state_change((state_value));		\
+		trace_set_current_state(state_value);			\
 		smp_store_mb(current->__state, (state_value));		\
 	} while (0)
 
@@ -247,6 +256,7 @@ struct user_event_mm;
 									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_special_state_change((state_value));		\
+		trace_set_current_state(state_value);			\
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
@@ -282,6 +292,7 @@ struct user_event_mm;
 		raw_spin_lock(&current->pi_lock);			\
 		current->saved_state = current->__state;		\
 		debug_rtlock_wait_set_state();				\
+		trace_set_current_state(TASK_RTLOCK_WAIT);		\
 		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
 		raw_spin_unlock(&current->pi_lock);			\
 	} while (0);
@@ -291,6 +302,7 @@ struct user_event_mm;
 		lockdep_assert_irqs_disabled();				\
 		raw_spin_lock(&current->pi_lock);			\
 		debug_rtlock_wait_restore_state();			\
+		trace_set_current_state(current->saved_state);		\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
 		raw_spin_unlock(&current->pi_lock);			\
@@ -327,6 +339,10 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+/* wrapper function to trace from this header file */
+DECLARE_TRACEPOINT(sched_set_state_tp);
+extern void __trace_set_current_state(int state_value);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4ef..90545125c9031 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -824,6 +824,19 @@ DECLARE_TRACE(sched_compute_energy_tp,
 		 unsigned long max_util, unsigned long busy_time),
 	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
 
+DECLARE_TRACE(sched_entry_tp,
+	TP_PROTO(bool preempt, unsigned long ip),
+	TP_ARGS(preempt, ip));
+
+DECLARE_TRACE(sched_exit_tp,
+	TP_PROTO(bool is_switch, unsigned long ip),
+	TP_ARGS(is_switch, ip));
+
+DECLARE_TRACE_CONDITION(sched_set_state_tp,
+	TP_PROTO(struct task_struct *tsk, int state),
+	TP_ARGS(tsk, state),
+	TP_CONDITION(!!(tsk->__state) != !!state));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d3..5d36ccf565e94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -491,6 +491,16 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
+/* need a wrapper since we may need to trace from modules */
+EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
+
+/* Call via the helper macro trace_set_current_state. */
+void __trace_set_current_state(int state_value)
+{
+	trace_sched_set_state_tp(current, state_value);
+}
+EXPORT_SYMBOL(__trace_set_current_state);
+
 /*
  * Serialization rules:
  *
@@ -5307,6 +5317,12 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	finish_task_switch(prev);
+	/*
+	 * This is a special case: the newly created task has just
+	 * switched the context for the first time. It is returning from
+	 * schedule for the first time in this path.
+	 */
+	trace_sched_exit_tp(true, CALLER_ADDR0);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -6650,12 +6666,15 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
+	bool is_switch = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
 
+	trace_sched_entry_tp(preempt, CALLER_ADDR0);
+
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
@@ -6723,7 +6742,8 @@ static void __sched notrace __schedule(int sched_mode)
 	rq->last_seen_need_resched_ns = 0;
 #endif
 
-	if (likely(prev != next)) {
+	is_switch = prev != next;
+	if (likely(is_switch)) {
 		rq->nr_switches++;
 		/*
 		 * RCU users of rcu_dereference(rq->curr) may not see
@@ -6768,6 +6788,7 @@ static void __sched notrace __schedule(int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
+	trace_sched_exit_tp(is_switch, CALLER_ADDR0);
 }
 
 void __noreturn do_task_dead(void)
diff --git a/tools/verification/rv/include/rv.h b/tools/verification/rv/include/rv.h
index 770fd6da36107..0cab1037a98f7 100644
--- a/tools/verification/rv/include/rv.h
+++ b/tools/verification/rv/include/rv.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #define MAX_DESCRIPTION 1024
-#define MAX_DA_NAME_LEN	24
+#define MAX_DA_NAME_LEN	32
 
 struct monitor {
 	char name[MAX_DA_NAME_LEN];
-- 
2.48.1

