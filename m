Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327626FDA6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710686; cv=none; b=gACR8Ci8N2cCZ1gWsoRuK9b5r+lpMBAUdj31rFRxDHt/NhNV4IhNE1uVKyybmiXMI3v9unYD4pjLmmVtZwTzKx4gbOEjq/SPwxGMPD/z/uxuNm6bWg424r7M7Ao7libUypC0DKTD5A7XDLP3ewrh4UM075LTH2PX4CNmpfi4RsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710686; c=relaxed/simple;
	bh=tcYVGnTYebpVvmXlAixElDzsCTRgG95bJ+qn3o5rBa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAZScP8qLVkhIm9+ctPV/auRSjGfVjMIPG13Nv0V9XsjnQN613If8zN4XdQYPb4OOGcsOZ1AsQrUSsQZJQ+fMWAwSkwL+qTOOX9AJl8rxYhrNsSJRzyDCxDqnq0jNTmN0N/N2SfLCcMkjdzSzZb++P/98hiW5LNeIYi6ubZeuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPfbUIbQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPfbUIbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ggg1/uWpZjft1ps6zWyVGe0mNciy3CTx/9uje4r8LY=;
	b=ZPfbUIbQlEY9ZBMzOOJqmDYt7CzePlsJ7L/J5ywUVuEKlG2Aapf+7ZJTz0b3Nw9nwFZTwk
	JSuELRZdNsJpbBKLBDop8s2oOv51++awdFhjVxyYPPJiChO5H0inS/EZWawVGXyjPPViqP
	fow91EneV1s5KMxOmVUHgKdeeOeVVjc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-bz0JZUDPO_W2m1nQ2worCg-1; Mon,
 28 Jul 2025 09:51:20 -0400
X-MC-Unique: bz0JZUDPO_W2m1nQ2worCg-1
X-Mimecast-MFC-AGG-ID: bz0JZUDPO_W2m1nQ2worCg_1753710679
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15B2419560AE;
	Mon, 28 Jul 2025 13:51:19 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCFCC1800285;
	Mon, 28 Jul 2025 13:51:13 +0000 (UTC)
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
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 6/9] sched: Adapt sched tracepoints for RV task model
Date: Mon, 28 Jul 2025 15:50:18 +0200
Message-ID: <20250728135022.255578-7-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add the following tracepoint:
* sched_set_need_resched(tsk, cpu, tif)
    Called when a task is set the need resched [lazy] flag

Remove the unused ip parameter from sched_entry and sched_exit and alter
sched_entry to have a value of preempt consistent with the one used in
sched_switch.

Also adapt all monitors using sched_{entry,exit} to avoid breaking build.

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched.h                  |  7 ++++++-
 include/trace/events/sched.h           | 12 ++++++++----
 kernel/sched/core.c                    | 13 ++++++++++---
 kernel/trace/rv/monitors/sco/sco.c     |  4 ++--
 kernel/trace/rv/monitors/scpd/scpd.c   |  4 ++--
 kernel/trace/rv/monitors/sncid/sncid.c |  4 ++--
 kernel/trace/rv/monitors/snep/snep.c   |  4 ++--
 kernel/trace/rv/monitors/tss/tss.c     |  4 ++--
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fabd7fe1a07a..91d1fdbc2f56 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -339,9 +339,11 @@ extern void io_schedule_finish(int token);
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
@@ -2063,6 +2065,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..c08893bde255 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -882,18 +882,22 @@ DECLARE_TRACE(sched_compute_energy,
 	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
 
 DECLARE_TRACE(sched_entry,
-	TP_PROTO(bool preempt, unsigned long ip),
-	TP_ARGS(preempt, ip));
+	TP_PROTO(bool preempt),
+	TP_ARGS(preempt));
 
 DECLARE_TRACE(sched_exit,
-	TP_PROTO(bool is_switch, unsigned long ip),
-	TP_ARGS(is_switch, ip));
+	TP_PROTO(bool is_switch),
+	TP_ARGS(is_switch));
 
 DECLARE_TRACE_CONDITION(sched_set_state,
 	TP_PROTO(struct task_struct *tsk, int state),
 	TP_ARGS(tsk, state),
 	TP_CONDITION(!!(tsk->__state) != !!state));
 
+DECLARE_TRACE(sched_set_need_resched,
+	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
+	TP_ARGS(tsk, cpu, tif));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec68fc686bd7..b485e0639616 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1110,6 +1110,7 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr, cpu, tif);
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -1125,6 +1126,11 @@ static void __resched_curr(struct rq *rq, int tif)
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
@@ -5329,7 +5335,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * switched the context for the first time. It is returning from
 	 * schedule for the first time in this path.
 	 */
-	trace_sched_exit_tp(true, CALLER_ADDR0);
+	trace_sched_exit_tp(true);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -6678,7 +6684,8 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
-	trace_sched_entry_tp(preempt, CALLER_ADDR0);
+	/* Trace preemptions consistently with task switches */
+	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6793,7 +6800,7 @@ static void __sched notrace __schedule(int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
-	trace_sched_exit_tp(is_switch, CALLER_ADDR0);
+	trace_sched_exit_tp(is_switch);
 }
 
 void __noreturn do_task_dead(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 66f4639d46ac..04c36405e2e3 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -24,12 +24,12 @@ static void handle_sched_set_state(void *data, struct task_struct *tsk, int stat
 	da_handle_start_event_sco(sched_set_state_sco);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_sco(schedule_entry_sco);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_sco(schedule_exit_sco);
 }
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index 299703cd72b0..1e351ba52fee 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -30,12 +30,12 @@ static void handle_preempt_enable(void *data, unsigned long ip, unsigned long pa
 	da_handle_start_event_scpd(preempt_enable_scpd);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_scpd(schedule_entry_scpd);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_event_scpd(schedule_exit_scpd);
 }
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
index 3e1ee715a0fb..c8491f426365 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -30,12 +30,12 @@ static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent
 	da_handle_start_event_sncid(irq_enable_sncid);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_start_event_sncid(schedule_entry_sncid);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_sncid(schedule_exit_sncid);
 }
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 2adc3108d60c..558950f524a5 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -30,12 +30,12 @@ static void handle_preempt_enable(void *data, unsigned long ip, unsigned long pa
 	da_handle_start_event_snep(preempt_enable_snep);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_snep(schedule_entry_snep);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_snep(schedule_exit_snep);
 }
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
index 0452fcd9edcf..95ebd15131f5 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -27,12 +27,12 @@ static void handle_sched_switch(void *data, bool preempt,
 	da_handle_event_tss(sched_switch_tss);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_tss(schedule_entry_tss);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_tss(schedule_exit_tss);
 }
-- 
2.50.1

