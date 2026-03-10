Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221F38757B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140304; cv=none; b=VRxDXCUNyGExwZ2ib0gpm8groJw5ZbrIlbhmuFIbmyoR9BlvLjjmW8qOISfCP4dPjJECkQgoqrOXk92UZPLeE17PsQsNi6gAUrrLFiDVhJUw8kr+AK6Fn9LwU04vBt9UQRMcpk0WFVMBXRxXFHmgjYUOpRllOzFqu82b+AajJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140304; c=relaxed/simple;
	bh=4Ectz9ev4shhgu6id+Mz1sBbcXKlDqzt/7QXEAeFc5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bGy4OjbxSw8bw0xvt7hEkmUZs7ZQ3wRoofKBuG6JBc1GlphziBcc8ZedUlQGxs5tJP/xbYfHQocFy4yD313rkGvco5ooaE2NrGw5lchrgksSzl6pWCs+5s/OzTtBi+OBsgNC8VqJeoxHTElZwWmSK9WBfTFNjH5Q9nskiU1bfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0JCAjpr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0JCAjpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fG+flafuYTwXXlmNGfeUvIk/qzbxBbN1uAHmzt2JAY8=;
	b=H0JCAjprVqzNx6wlS9TSnX4FN8aAoJzJcT03ap3ubC43liPntBQwS6vLUv120l4yDfAJK1
	Rszkgdt83ctwvu3PKLMjFQYJ4FAiKJSOnbbKXMTWk2BL0z96EvbB7I6bQ3ZPnsgnfFxFgA
	ecuKbAqz2HUKZd7hGBtKsNVFIEWHQjg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-_v2N47BkOaWpBHkPCV-ULQ-1; Tue,
 10 Mar 2026 06:58:18 -0400
X-MC-Unique: _v2N47BkOaWpBHkPCV-ULQ-1
X-Mimecast-MFC-AGG-ID: _v2N47BkOaWpBHkPCV-ULQ_1773140297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A807D1956063;
	Tue, 10 Mar 2026 10:58:17 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.35.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AD631800759;
	Tue, 10 Mar 2026 10:58:12 +0000 (UTC)
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
Subject: [PATCH v7 12/15] sched: Add deadline tracepoints
Date: Tue, 10 Mar 2026 11:56:24 +0100
Message-ID: <20260310105627.332044-13-gmonaco@redhat.com>
In-Reply-To: <20260310105627.332044-1-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: kd-AXQoXE4U31QkzObZd7jm_bfVl3NP3em42lXx2aiw_1773140297
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the following tracepoints:

* sched_dl_throttle(dl_se, cpu, type):
    Called when a deadline entity is throttled
* sched_dl_replenish(dl_se, cpu, type):
    Called when a deadline entity's runtime is replenished
* sched_dl_update(dl_se, cpu, type):
    Called when a deadline entity updates without throttle or replenish
* sched_dl_server_start(dl_se, cpu, type):
    Called when a deadline server is started
* sched_dl_server_stop(dl_se, cpu, type):
    Called when a deadline server is stopped

Those tracepoints can be useful to validate the deadline scheduler with
RV and are not exported to tracefs.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V7:
    * Export sched_dl_update to modules and fix style
    V6:
    * Add dl_se type to differentiate between fair and ext servers
    * Add event to track dl_update_curr not firing other events
    V3:
    * Rename dl argument to dl_se in tracepoints

 include/trace/events/sched.h | 26 ++++++++++++++++++++++++++
 kernel/sched/core.c          |  5 +++++
 kernel/sched/deadline.c      | 24 ++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 5844147ec5fd..944d65750a64 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -904,6 +904,32 @@ DECLARE_TRACE(sched_dequeue,
 	TP_PROTO(struct task_struct *tsk, int cpu),
 	TP_ARGS(tsk, cpu));
 
+#define DL_OTHER 0
+#define DL_TASK 1
+#define DL_SERVER_FAIR 2
+#define DL_SERVER_EXT 3
+
+DECLARE_TRACE(sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
+	TP_ARGS(dl_se, cpu, type));
+
+/* Call to update_curr_dl_se not involving throttle or replenish */
+DECLARE_TRACE(sched_dl_update,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_server_start,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_server_stop,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
+	TP_ARGS(dl_se, cpu, type));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c9ca1e048612..b9fbe7e4d8ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -124,6 +124,11 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_update_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d08b00429323..d69b3e44971e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -115,6 +115,20 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 }
 #endif /* !CONFIG_RT_MUTEXES */
 
+static inline uint8_t dl_get_type(struct sched_dl_entity *dl_se,
+				       struct rq *rq)
+{
+	if (!dl_server(dl_se))
+		return DL_TASK;
+	if (dl_se == &rq->fair_server)
+		return DL_SERVER_FAIR;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (dl_se == &rq->ext_server)
+		return DL_SERVER_EXT;
+#endif
+	return DL_OTHER;
+}
+
 static inline struct dl_bw *dl_bw_of(int i)
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
@@ -733,6 +747,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 }
 
 /*
@@ -848,6 +863,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
 
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
+
 	/*
 	 * If this is the replenishment of a deferred reservation,
 	 * clear the flag and return.
@@ -1345,6 +1362,7 @@ static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
 			dl_se->runtime = 0;
@@ -1508,6 +1526,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
@@ -1532,6 +1551,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
+	} else {
+		trace_sched_dl_update_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	}
 
 	/*
@@ -1810,6 +1831,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1821,6 +1843,8 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq),
+				      dl_get_type(dl_se, dl_se->rq));
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
-- 
2.53.0

