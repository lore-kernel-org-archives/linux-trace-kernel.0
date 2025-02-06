Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAF1F1537
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Feb 2025 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829419; cv=none; b=hZN2fbcQXtP5KVG1fJB2M/rWN9KnK/WDiPjYwsYD3y+UOJtVutbr97jTJ2lSPq6CV6pJrjQKZjg2GqD+8WY3Lcb94ozbdoeBBTz/LTc7iTrM7S2XkEiFLurTScVB0XWwTFQg5zGSnm63My8iGFs/1k3ecM9XeDm1uuXcXUmFJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829419; c=relaxed/simple;
	bh=gTs7Azh5rtnfqF33SYy9NJSgxO4Dd3wxBeGdFqt7NMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKWQzSqbnW3oHZfGNqR9zzc4YiMogKZ9LspeBgER0qfyojfXlg/tGsf6Hvk1XMH7NKtXs89wLEjGPVe6c3YBt72Pfau3MFf6ElnPE2dLMkelC9EfLiQZ/A8LPy/ZhoRB0wbGoO83QIWNMgP4Hr1MfXtdXRKozYDBApeRoszsRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgUKH2/N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgUKH2/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738829417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2lzlBLHmij9XUwBpUKwGlZMMwoAk9Ed93u0eUo6f0k=;
	b=SgUKH2/Nx1Myz+pA17TPaNx1aKvoNoLWx9FIbiNjPiwu0w97ULIsgdkUoULNbr6HiGRfXI
	vvGF7gNyuggkR3AYKG6vDpNvBJmJ5gO2Rnq/qw5BNtt9fx3X6gRpysuA95yFksMpDbMqMH
	P9qs2y3n0JUwWU15vYgYlMIPTBZs2FM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-85MED3O2OJ6_MZI12DAHDQ-1; Thu,
 06 Feb 2025 03:10:14 -0500
X-MC-Unique: 85MED3O2OJ6_MZI12DAHDQ-1
X-Mimecast-MFC-AGG-ID: 85MED3O2OJ6_MZI12DAHDQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1156C195604F;
	Thu,  6 Feb 2025 08:10:13 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.82])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3399919560AE;
	Thu,  6 Feb 2025 08:10:09 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task model
Date: Thu,  6 Feb 2025 09:09:39 +0100
Message-ID: <20250206080952.98478-4-gmonaco@redhat.com>
In-Reply-To: <20250206080952.98478-1-gmonaco@redhat.com>
References: <20250206080952.98478-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the following tracepoints:
* sched_entry(bool preempt, ip)
    Called while entering __schedule
* sched_exit(bool is_switch, ip)
    Called while exiting __schedule
* sched_set_need_resched(task)
    Called when we set the need for reschedule
* sched_set_state(task, curr_state, state)
    Called when a task changes its state (to and from running)

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h                 |  2 +-
 include/linux/sched.h              |  7 +++++++
 include/trace/events/sched.h       | 17 +++++++++++++++++
 kernel/sched/core.c                | 21 ++++++++++++++++++++-
 tools/verification/rv/include/rv.h |  2 +-
 5 files changed, 46 insertions(+), 3 deletions(-)

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
index 9632e3318e0d6..af9fa18035c71 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -226,12 +226,14 @@ struct user_event_mm;
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
 
@@ -247,6 +249,7 @@ struct user_event_mm;
 									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_special_state_change((state_value));		\
+		trace_set_current_state(state_value);			\
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
@@ -282,6 +285,7 @@ struct user_event_mm;
 		raw_spin_lock(&current->pi_lock);			\
 		current->saved_state = current->__state;		\
 		debug_rtlock_wait_set_state();				\
+		trace_set_current_state(TASK_RTLOCK_WAIT);		\
 		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
 		raw_spin_unlock(&current->pi_lock);			\
 	} while (0);
@@ -291,6 +295,7 @@ struct user_event_mm;
 		lockdep_assert_irqs_disabled();				\
 		raw_spin_lock(&current->pi_lock);			\
 		debug_rtlock_wait_restore_state();			\
+		trace_set_current_state(TASK_RUNNING);			\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
 		raw_spin_unlock(&current->pi_lock);			\
@@ -327,6 +332,8 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+extern void trace_set_current_state(int state_value);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4ef..1ac0e23b0733d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -824,6 +824,23 @@ DECLARE_TRACE(sched_compute_energy_tp,
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
+DECLARE_TRACE(sched_set_need_resched_tp,
+	TP_PROTO(struct task_struct *tsk),
+	TP_ARGS(tsk));
+
+DECLARE_TRACE_CONDITION(sched_set_state_tp,
+	TP_PROTO(struct task_struct *tsk, int curr_state, int state),
+	TP_ARGS(tsk, curr_state, state),
+	TP_CONDITION(!!curr_state != !!state));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea9..fb5f8aa61ef5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -491,6 +491,12 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
+void trace_set_current_state(int state_value)
+{
+	trace_sched_set_state_tp(current, current->__state, state_value);
+}
+EXPORT_SYMBOL(trace_set_current_state);
+
 /*
  * Serialization rules:
  *
@@ -1103,6 +1109,8 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr);
+
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -5306,6 +5314,12 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	finish_task_switch(prev);
+	/*
+	 * This is a special case: the newly created task has just
+	 * switched the context for the fist time. It is returning from
+	 * schedule for the first time in this path.
+	 */
+	trace_sched_exit_tp(true, CALLER_ADDR0);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -6649,12 +6663,15 @@ static void __sched notrace __schedule(int sched_mode)
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
@@ -6722,7 +6739,8 @@ static void __sched notrace __schedule(int sched_mode)
 	rq->last_seen_need_resched_ns = 0;
 #endif
 
-	if (likely(prev != next)) {
+	is_switch = prev != next;
+	if (likely(is_switch)) {
 		rq->nr_switches++;
 		/*
 		 * RCU users of rcu_dereference(rq->curr) may not see
@@ -6767,6 +6785,7 @@ static void __sched notrace __schedule(int sched_mode)
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

