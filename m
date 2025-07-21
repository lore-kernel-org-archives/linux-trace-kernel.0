Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E928A1F2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086295; cv=none; b=m9hD8aPExnQjt0uFMZ0mheVpQVtQAgKaSYCdgQ8n4kq50sIvobkAJ1KIgqFXlM/LmvIxYG3LwZ7ZDjzCn9qFT1LTvJetdMRFRW4kX0dWsq8p4Nj4kLoOSjQAtx4aesazhtgk6Arp08XS+psKowUoGmNJmtrQu8q2vOYMAsoeYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086295; c=relaxed/simple;
	bh=dHLbKD+8meh2u38w/YkErCUaMGaQVgja7fDe1SmWlv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl8gUJi2MwvAjol2zLhBmjnkPgUdZXeQSq7hoFFgzPUxV8s0avK3Fwnpvkbq31v5orQLx9D2wcoz/OIucY1EhGrMz41PSLk7w/iDoU0EPlmJmv3Vyx7JtWtVrl+dB5YjgB++ZnLDsaWygrKxDQsjfcm5Os22iRNq8cr1cOoXmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz4cYFHJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz4cYFHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZLBduP+vsoU/rX57De/2fx+EXCFbxbH1HDNxVnABOg=;
	b=Lz4cYFHJukjp0tHLPEwPFPMSYoeUVXFbQq3e46EKcDgTOGn1XrFUNtepSYW4CVO9gdWEbv
	JfUPumI4tuWb60rrtcgWWBc59G6d97N02Fm3h8pwMlMnz8NdISbVft4eZMeQdDEQOsV7xw
	ZKtVhXW6Ek19canN7E2cBLqfdKMSQrw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-j2zOUvKJPtKt5gGxxOjYmQ-1; Mon,
 21 Jul 2025 04:24:48 -0400
X-MC-Unique: j2zOUvKJPtKt5gGxxOjYmQ-1
X-Mimecast-MFC-AGG-ID: j2zOUvKJPtKt5gGxxOjYmQ_1753086286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0DBA19560A5;
	Mon, 21 Jul 2025 08:24:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48287195608D;
	Mon, 21 Jul 2025 08:24:41 +0000 (UTC)
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
Subject: [PATCH v4 11/14] sched: Adapt sched tracepoints for RV task model
Date: Mon, 21 Jul 2025 10:23:21 +0200
Message-ID: <20250721082325.71554-12-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index ba82d865df203..4dcde69996579 100644
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
@@ -2026,6 +2028,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3f..c08893bde255d 100644
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
index 2343f5691c54e..63bcaade2569d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1113,6 +1113,7 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr, cpu, tif);
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -1128,6 +1129,11 @@ static void __resched_curr(struct rq *rq, int tif)
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
@@ -5279,7 +5285,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * switched the context for the first time. It is returning from
 	 * schedule for the first time in this path.
 	 */
-	trace_sched_exit_tp(true, CALLER_ADDR0);
+	trace_sched_exit_tp(true);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -6822,7 +6828,8 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
-	trace_sched_entry_tp(preempt, CALLER_ADDR0);
+	/* Trace preemptions consistently with task switches */
+	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6961,7 +6968,7 @@ static void __sched notrace __schedule(int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
-	trace_sched_exit_tp(is_switch, CALLER_ADDR0);
+	trace_sched_exit_tp(is_switch);
 }
 
 void __noreturn do_task_dead(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 66f4639d46ac4..04c36405e2e3d 100644
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
index 299703cd72b06..1e351ba52fee9 100644
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
index 3e1ee715a0fbf..c8491f4263650 100644
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
index 2adc3108d60c9..558950f524a52 100644
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
index 0452fcd9edcfe..95ebd15131f52 100644
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

