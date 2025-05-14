Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C1221DA8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212248; cv=none; b=A58v9kfIAfyysMIeGgGcimgKXrIWHb3/YTE1zKcmC6AIfebnqPMuRR1CmcKlRquY8ezZSvnNA+MrpnkJoisj4DIAIuK2I/B+Pcjt+YNGJcvYws4dcsNrAwzaOqM+rXhFihSFMVma9bfIqUDA4X6bF+ndmsLRoHxyTepLQcHBgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212248; c=relaxed/simple;
	bh=VM5OiJN9Z257mj4pGFbU/IOKgo2qTzJwDQ+V5BjrtOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayWQJfo023+8RMyApiSPsLw9oZrNpRrPI3CS52FGWM9o/NNEPLdKXcABvFJlG3KlgdWBqP68ODWFIwA1C4k4Boijp0JCeAy8/ih2QKFb4v2NCP0N2p8SfMKFfEOgSxVcYOaoErpcYGKyvrKtO30Y+u5B/lumuQhZ3IK/hMgAw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihUjKg9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihUjKg9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxZyRZLrSNioQyNp9VBnZGfaP6hgfH1QQWD0nXaN4JQ=;
	b=ihUjKg9IXYLfUwQVQYkS5JCl2sv6eRKPRHDaKisst5O0XqWbioKfDovCSGIgIEOjM5WuFv
	aHaZmHxwfNfMMmCGdjTmMsIK4Z0tYE76gf/WEok5DL00wUN9OIxHhd5SFGbrLshicKAL8y
	noTcFq4tPkkGh3nIeXOVUWokfZOjuiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-TN7pw6I4NNeXJW1yfMlhFg-1; Wed,
 14 May 2025 04:43:59 -0400
X-MC-Unique: TN7pw6I4NNeXJW1yfMlhFg-1
X-Mimecast-MFC-AGG-ID: TN7pw6I4NNeXJW1yfMlhFg_1747212238
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 862D6180048E;
	Wed, 14 May 2025 08:43:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B03C1953B82;
	Wed, 14 May 2025 08:43:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH v2 06/12] sched: Adapt sched tracepoints for RV task model
Date: Wed, 14 May 2025 10:43:08 +0200
Message-ID: <20250514084314.57976-7-gmonaco@redhat.com>
In-Reply-To: <20250514084314.57976-1-gmonaco@redhat.com>
References: <20250514084314.57976-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the following tracepoints:
* sched_set_need_resched(tsk, cpu, tif)
    Called when a task is set the need resched [lazy] flag
* sched_switch_vain(preempt, tsk, tsk_state)
    Called when a task is selected again during __schedule
    i.e. prev == next == tsk : no real context switch

Add new parameter to sched_set_state to identify whether the state
change was due to an explicit call or a signal pending while scheduling.
We now also trace from try_to_block_task in case a signal was pending
and the task is set to runnable.

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched.h        |  7 ++++++-
 include/trace/events/sched.h | 17 +++++++++++++++--
 kernel/sched/core.c          | 10 +++++++++-
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04f808ab8888..4d9da32330bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -340,9 +340,11 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
-/* wrapper function to trace from this header file */
+/* wrapper functions to trace from this header file */
 DECLARE_TRACEPOINT(sched_set_state_tp);
 extern void __trace_set_current_state(int state_value);
+DECLARE_TRACEPOINT(sched_set_need_resched_tp);
+extern void __trace_set_need_resched(struct task_struct *curr, int tif);
 
 /**
  * struct prev_cputime - snapshot of system and user cputime
@@ -2065,6 +2067,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 2390818b139b..158b9c504fab 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -889,11 +889,24 @@ DECLARE_TRACE(sched_exit_tp,
 	TP_PROTO(bool is_switch, unsigned long ip),
 	TP_ARGS(is_switch, ip));
 
+/*
+ * Tracepoint called when setting the state of a task;
+ * this tracepoint is guaranteed to be called from the waking context of the
+ * task setting the state.
+ */
 DECLARE_TRACE_CONDITION(sched_set_state_tp,
-	TP_PROTO(struct task_struct *tsk, int state),
-	TP_ARGS(tsk, state),
+	TP_PROTO(struct task_struct *tsk, int state, bool from_signal),
+	TP_ARGS(tsk, state, from_signal),
 	TP_CONDITION(!!(tsk->__state) != !!state));
 
+DECLARE_TRACE(sched_set_need_resched_tp,
+	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
+	TP_ARGS(tsk, cpu, tif));
+
+DECLARE_TRACE(sched_switch_vain_tp,
+	TP_PROTO(bool preempt, struct task_struct *tsk, unsigned int prev_state),
+	TP_ARGS(preempt, tsk, prev_state));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f844bae1a14..89e81fc7f393 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -494,7 +494,7 @@ EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
 /* Call via the helper macro trace_set_current_state. */
 void __trace_set_current_state(int state_value)
 {
-	trace_sched_set_state_tp(current, state_value);
+	trace_sched_set_state_tp(current, state_value, false);
 }
 EXPORT_SYMBOL(__trace_set_current_state);
 
@@ -1109,6 +1109,7 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr, cpu, tif);
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -1124,6 +1125,11 @@ static void __resched_curr(struct rq *rq, int tif)
 	}
 }
 
+void __trace_set_need_resched(struct task_struct *curr, int tif)
+{
+	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
+}
+
 void resched_curr(struct rq *rq)
 {
 	__resched_curr(rq, TIF_NEED_RESCHED);
@@ -6587,6 +6593,7 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	int flags = DEQUEUE_NOCLOCK;
 
 	if (signal_pending_state(task_state, p)) {
+		trace_sched_set_state_tp(p, TASK_RUNNING, true);
 		WRITE_ONCE(p->__state, TASK_RUNNING);
 		*task_state_p = TASK_RUNNING;
 		return false;
@@ -6779,6 +6786,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq_unpin_lock(rq, &rf);
+		trace_sched_switch_vain_tp(preempt, prev, prev_state);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
-- 
2.49.0

