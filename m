Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A441A9B58
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756381; cv=none; b=fFvbYypfbjHY5uBMovtM2QlJfjmvNeTKHWnmfNg1ULfbjKZy5AaG1WogjcOV5BICVsPaxKuJfZB3Y20B2rTIGsgFfo/qSt6FWW7p44oAde6do+5SRDhODr2pQrX7ID4FpOfncqcT/hw2IdGOBdzB/xXUE05YLlIGExyNkNy0r1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756381; c=relaxed/simple;
	bh=wFfzs2yz6m4G+u1pOhU0+RQw8E1fFOBql4bI6XTMHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBBsrifsLl896sddkAQNEh8VYhrIgHlIZtgPh8PwemlPrJDauVxSohQRLb2/+/3HGwx1pbapWTBXw5oeJvvtSzt4W3aO51RM+CvIdgCykf6smelvR4ZrYEIN2i3WLW6CmPsAhvf6NB0gXdxe0XselWgDsWhOLQVObT+CuzBzlWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hn2Q0JpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn2Q0JpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743756378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5M4AS5XQF4x0P7R9xaeq2+nOQNy0WXpZT4o++PKUQQ=;
	b=Hn2Q0JpVGEhl38+DDVI4Pwy6BmlLmeOXZskg0Nsz4owaOP+poNWGHLEwmTUhWggsnwT/PJ
	r4hphupUn/r0ZohugSFsrzqi5L+d4w+Uhy/TzspQxJBordBQ4aprRul2CBSURZwI2Yhtbo
	kCxexjbU4Hs14HSLUI0UrCjSN6Jdbmg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498--qczUiBfML605vV7WJiKIw-1; Fri,
 04 Apr 2025 04:46:15 -0400
X-MC-Unique: -qczUiBfML605vV7WJiKIw-1
X-Mimecast-MFC-AGG-ID: -qczUiBfML605vV7WJiKIw_1743756374
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 177FA1955DCD;
	Fri,  4 Apr 2025 08:46:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88109180B487;
	Fri,  4 Apr 2025 08:46:10 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH 5/9] sched: Add sched tracepoints for RV task model
Date: Fri,  4 Apr 2025 10:45:18 +0200
Message-ID: <20250404084512.98552-16-gmonaco@redhat.com>
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

Add the following tracepoints:
* sched_set_need_resched(tsk, cpu, tif)
    Called when a task is set the need resched [lazy] flag
* sched_switch_vain(preempt, tsk, tsk_state)
    Called when a task is selected again during __schedule
    i.e. prev == next == tsk : no real context switch

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched.h        | 7 ++++++-
 include/trace/events/sched.h | 8 ++++++++
 kernel/sched/core.c          | 9 +++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac19828934..7bcd37493ab07 100644
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
@@ -2064,6 +2066,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c13..77bbcce407cb4 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -835,6 +835,14 @@ DECLARE_TRACE_CONDITION(sched_set_state_tp,
 	TP_ARGS(tsk, state),
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
index cfaca3040b2f8..f2f79236d5811 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1109,6 +1109,7 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr, cpu, tif);
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -1124,6 +1125,13 @@ static void __resched_curr(struct rq *rq, int tif)
 	}
 }
 
+#ifdef CONFIG_SMP
+void __trace_set_need_resched(struct task_struct *curr, int tif)
+{
+	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
+}
+#endif
+
 void resched_curr(struct rq *rq)
 {
 	__resched_curr(rq, TIF_NEED_RESCHED);
@@ -6767,6 +6775,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq_unpin_lock(rq, &rf);
+		trace_sched_switch_vain_tp(preempt, prev, prev_state);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
-- 
2.49.0

