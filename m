Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99632F741
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940668; cv=none; b=h8+Al4rIshPpy3vd2wLXcPyJXQqB1ffk+XMNMlP185F691pd2byb7UBRlTsc5BOf/M3d0KOEf7BCxpqbkJvnbujW0YgjZnYUeeT0NsaNSMFta3FpMICjinO7iO4U4dxfyR6hHO3U/3j7rJQZwGpbtUsx57FLwSA9IGkKhywnDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940668; c=relaxed/simple;
	bh=qyVVzKDuMAKpPvfsvjIAbJrM0jyXjXukEt2k97VSu34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCPnO/tYH5jhDXO/CasSQG8K1k11D+pFXPvxI7SfCeNma5hmy+AyKmR+LyEZSejtQipOeKOx1TGcWUMebAvBb8sZRbjZ4o2YQFGoIQHF0tQ6b+vw2gRQqmK+P9qb/8PEyJPHThi5HV+sEWO3A0ihLXGWy8uiELPaJaJ8guO3Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JirGj1Uv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JirGj1Uv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlhulN7DQPy6mdgynlshgNmSXZVBLh8VXkAgCCcFeJA=;
	b=JirGj1Uvzc/SHLKBi9YmnnM4yXTvb2MdbnT2CqV2arJ/uBend0dPiHhwULP6t9zQTt5cmn
	8QE2t8sLFNckAh5RMuJ8WUaE45j5ySkl7n5ncprF/4ACvBzx7f9QxsIoHaauRlviD6Ly8w
	4nUkrrL6V9roFGHRfheUfzKly6Qu/lA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-p-Dk8quHO3uqm0PNPWExmg-1; Fri,
 05 Dec 2025 08:17:34 -0500
X-MC-Unique: p-Dk8quHO3uqm0PNPWExmg-1
X-Mimecast-MFC-AGG-ID: p-Dk8quHO3uqm0PNPWExmg_1764940652
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E8D5195608D;
	Fri,  5 Dec 2025 13:17:32 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE966180044F;
	Fri,  5 Dec 2025 13:17:26 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 09/13] sched: Add deadline tracepoints
Date: Fri,  5 Dec 2025 14:16:17 +0100
Message-ID: <20251205131621.135513-10-gmonaco@redhat.com>
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

Add the following tracepoints:

* sched_dl_throttle(dl_se, cpu):
    Called when a deadline entity is throttled
* sched_dl_replenish(dl_se, cpu):
    Called when a deadline entity's runtime is replenished
* sched_dl_server_start(dl_se, cpu):
    Called when a deadline server is started
* sched_dl_server_stop(dl_se, cpu):
    Called when a deadline server is stopped

Those tracepoints can be useful to validate the deadline scheduler with
RV and are not exported to tracefs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V3:
    * Rename dl argument to dl_se in tracepoints

 include/trace/events/sched.h | 16 ++++++++++++++++
 kernel/sched/core.c          |  4 ++++
 kernel/sched/deadline.c      |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..366b2e8ec40c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,22 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+DECLARE_TRACE(sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
+	TP_ARGS(dl_se, cpu));
+
+DECLARE_TRACE(sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
+	TP_ARGS(dl_se, cpu));
+
+DECLARE_TRACE(sched_dl_server_start,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
+	TP_ARGS(dl_se, cpu));
+
+DECLARE_TRACE(sched_dl_server_stop,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
+	TP_ARGS(dl_se, cpu));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5516778c19eb..3aed0ed6f2e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -122,6 +122,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 319439fe1870..2192e9f42e02 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -733,6 +733,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
 }
 
 /*
@@ -850,6 +851,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
 
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
+
 	/*
 	 * If this is the replenishment of a deferred reservation,
 	 * clear the flag and return.
@@ -1341,6 +1344,7 @@ static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
 			dl_se->runtime = 0;
@@ -1504,6 +1508,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
@@ -1795,6 +1800,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1806,6 +1812,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq));
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
-- 
2.52.0

