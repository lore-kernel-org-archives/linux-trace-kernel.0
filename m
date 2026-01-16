Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238821DF258
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567226; cv=none; b=WQJk2frtqMtrPywkYV/EARM4TCb4l5b0Emtc2zK69BVCZy/GirrUqB0cvHXqo3CEzlRWBKPIhO+yrb0vWTH1yHWpRgimVGB3MiD/sXboI6l5dx16guTFkbaguTyPhiXUWTDbH/pPr3lYTuToqAMbOfRBFPwHuckz2yUy2ULjHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567226; c=relaxed/simple;
	bh=3pb4tvoMPRbwjRConuA18iVLmMx3CNKMb4t86AoYTfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imAjk2Baq9f2CaA85ZGiojrFBrESGv5bG9fp/rWrIz+No6JLCQnp+91nNWE7/dzN9uAEtzCblDWyzSzgWSTjKPQtHNe8RuEBgc2hOSnACMtA3UH5+CQuP7ELPhwfh0qLmakPBF3RT4onEzj6Wrv8CjZYvfHki7V6leNLzQuEfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R787IJnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R787IJnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUAldtIVXccPkmZj84jsujvjZRg6n9/+aaEPOLMw72s=;
	b=R787IJnWCfIUno6V5QI/wObZWEycwEseBYQ8ZZ29/7TzZalYStRB+76Q9kUDmSCisdTiLc
	XSbQI5QUgL6xtvo5Y5Yw2KZrpgwEq2ShRAqDUp+5ejsgztfuQLBVPMOXIsPVpAIy71rQEj
	AKx+novRAwqO34Yg91lDonG+FFK7aUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-e4bbCxElMpmph7HcajHwGQ-1; Fri,
 16 Jan 2026 07:40:19 -0500
X-MC-Unique: e4bbCxElMpmph7HcajHwGQ-1
X-Mimecast-MFC-AGG-ID: e4bbCxElMpmph7HcajHwGQ_1768567218
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99F0319560AF;
	Fri, 16 Jan 2026 12:40:18 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF4B11955F22;
	Fri, 16 Jan 2026 12:40:13 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 09/15] sched: Add deadline tracepoints
Date: Fri, 16 Jan 2026 13:39:05 +0100
Message-ID: <20260116123911.130300-10-gmonaco@redhat.com>
In-Reply-To: <20260116123911.130300-1-gmonaco@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Reviewed-by: Phil Auld <pauld@redhat.com>
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
index 6380afe3de63..f6293fa02fb7 100644
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
index 7441b7e52cd9..a69d2f073916 100644
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
@@ -1800,6 +1805,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1811,6 +1817,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq));
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
-- 
2.52.0

