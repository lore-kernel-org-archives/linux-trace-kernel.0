Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FF313E37
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291116; cv=none; b=sH1t6im1gVXGIXL+JHr34ToDtDFmXTiFUUtgl/sk3iKG9GRgaEKzlK17mVfSFf5DJcdhcbfrHGqauuypU2PzosbDqIWalJL63N2vT3PjoIcDuRFej5wPF6cVUVKnwuZiLSiMdCr01e/Yfu+9l9ybh8nycVQw6AR36c4nyIwjsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291116; c=relaxed/simple;
	bh=SmGalfq6WcUvYUE7herM7mwPrxdKkgRlExZtwOysY/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVzLmXAqqXMyibiEdorSr7i7l6C2FgbC5qwlrR8czP14vmyDrVObhsPEBKPG26SYLG2mqeOhQWv9zq6U9u2RYEixB5FRZGZobSoadT+8JGMmNmO+B2cSqYum/IU6Esuds7y6ikaEaPnYYeZniWFwvYMv66ZBuZ7jDp4sDTic7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR0bU1jP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR0bU1jP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz7EZ2CsqYDGwVBpKeoUvzcrWsfX+7orrIrJB5nGHFk=;
	b=FR0bU1jPKinpJAaJMXiIgej3r/xYPR4FC6lH4z9rHsb1pufXrLlkl9Y6fT69imRh1faqV5
	ynSo7lIHLWBllc7VeB3O/K05l0AzVnTY+OMsgJBCmHLg9bDw+rh7K5aMx/+h9KOva446gP
	20xj3ePAzj3BnsPBxSWIVRyONr9UDQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-LHhYuQQFMYGRHizgog6yvQ-1; Fri,
 19 Sep 2025 10:11:49 -0400
X-MC-Unique: LHhYuQQFMYGRHizgog6yvQ-1
X-Mimecast-MFC-AGG-ID: LHhYuQQFMYGRHizgog6yvQ_1758291107
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 704A21800296;
	Fri, 19 Sep 2025 14:11:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA22E1956045;
	Fri, 19 Sep 2025 14:11:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 17/20] sched: Add deadline tracepoints
Date: Fri, 19 Sep 2025 16:09:51 +0200
Message-ID: <20250919140954.104920-18-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add the following tracepoints:

* sched_dl_throttle(dl):
    Called when a deadline entity is throttled
* sched_dl_replenish(dl):
    Called when a deadline entity's runtime is replenished
* sched_dl_server_start(dl):
    Called when a deadline server is started
* sched_dl_server_stop(dl, hard):
    Called when a deadline server is stopped (hard) or put to idle
    waiting for the next period (!hard)

Those tracepoints can be useful to validate the deadline scheduler with
RV and are not exported to tracefs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/sched.h | 16 ++++++++++++++++
 kernel/sched/core.c          |  4 ++++
 kernel/sched/deadline.c      |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..6dc5cd3e9fc4 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,22 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+DECLARE_TRACE(sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl, int cpu),
+	TP_ARGS(dl, cpu));
+
+DECLARE_TRACE(sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl, int cpu),
+	TP_ARGS(dl, cpu));
+
+DECLARE_TRACE(sched_dl_server_start,
+	TP_PROTO(struct sched_dl_entity *dl, int cpu),
+	TP_ARGS(dl, cpu));
+
+DECLARE_TRACE(sched_dl_server_stop,
+	TP_PROTO(struct sched_dl_entity *dl, int cpu, bool hard),
+	TP_ARGS(dl, cpu, hard));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 334ff5b214d7..b236fc762e73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -120,6 +120,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e47..187175607682 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -742,6 +742,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
 }
 
 /*
@@ -852,6 +853,9 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
 		replenish_dl_new_period(dl_se, rq);
+	} else {
+		/* replenish_dl_new_period is also tracing */
+		trace_sched_dl_replenish_tp(dl_se, cpu_of(rq));
 	}
 
 	if (dl_se->dl_yielded)
@@ -1349,6 +1353,7 @@ static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
 			dl_se->runtime = 0;
@@ -1482,6 +1487,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq));
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
@@ -1592,6 +1598,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1603,6 +1610,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq), true);
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
@@ -1620,6 +1628,7 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 		return true;
 	}
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq), false);
 	dl_se->dl_server_idle = 1;
 	return false;
 }
-- 
2.51.0

