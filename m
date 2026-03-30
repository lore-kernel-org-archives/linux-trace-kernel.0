Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5023C65EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869092; cv=none; b=mTg2T9jyGk2g9u1tLaYZ+agzEi25yqSgq7S0lw9LM4Iah1qmyniZeijBnJsUjTjTrHexNWJmlUAEjDYY+c1zZ7zUIkkWP0l8CDgL2aoBUn2op/oFrRbtFuFhK7c36ihoa9GFVXGi0w5S3WDDXcnXfaOmUU69X54qUOOXGNk2SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869092; c=relaxed/simple;
	bh=hQ90+FM1Zq/m791vTfWiWUs5fKmYcfr5kOGHbnF2q0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Aa4Ipgz29Ml5t5bsvYL1DsxZIID6WZxo8faB7y+xz3yZuqiUtrb5Uz35SjBU/SNeP2w+NvZHblMN4TlZl6RR9lX9vJt8dyuiKxXARWUIAm6YGzR7R7Ep3DzGToyC4lgzvg1VKq2F4SeEwXCxGb2T0O17DVxTCmEeykMTLnTy7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDhjx825; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDhjx825"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BmuGhE2+f4hZY16N2T5Ew7x2eInbFrBNUdmzLiXctk=;
	b=eDhjx8252+lMU8clLcfwArmUBdWRrhdc+hf1b2xx/Ec0IrFy/0U6gLo7WnO+J/cu71wuwp
	etbM37yGa8E7vnOQCHxDTnP7OPYABiFHUmePMVPkq4XHpXpNbdgthfvewJ60MAMsQl+2B1
	0eWL+lqACZEbUMO/zrEpVI2UJHgP110=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-Qhp_81vGMsOcWOStHYnmVg-1; Mon,
 30 Mar 2026 07:11:22 -0400
X-MC-Unique: Qhp_81vGMsOcWOStHYnmVg-1
X-Mimecast-MFC-AGG-ID: Qhp_81vGMsOcWOStHYnmVg_1774869080
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64C81180058A;
	Mon, 30 Mar 2026 11:11:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B5CD30001A2;
	Mon, 30 Mar 2026 11:11:14 +0000 (UTC)
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
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v8 10/12] sched: Add deadline tracepoints
Date: Mon, 30 Mar 2026 13:10:08 +0200
Message-ID: <20260330111010.153663-11-gmonaco@redhat.com>
In-Reply-To: <20260330111010.153663-1-gmonaco@redhat.com>
References: <20260330111010.153663-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: TvcOhVsJBUu1uf8Y2YOPUIH4f71e-oa2NTDLkIG0zDg_1774869080
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
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V8:
    * Use u8 instead of uint8_t
    V7:
    * Export sched_dl_update to modules and fix style
    V6:
    * Add dl_se type to differentiate between fair and ext servers
    * Add event to track dl_update_curr not firing other events

 include/trace/events/sched.h | 26 ++++++++++++++++++++++++++
 kernel/sched/core.c          |  5 +++++
 kernel/sched/deadline.c      | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..535860581f15 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,32 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+#define DL_OTHER 0
+#define DL_TASK 1
+#define DL_SERVER_FAIR 2
+#define DL_SERVER_EXT 3
+
+DECLARE_TRACE(sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, u8 type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, u8 type),
+	TP_ARGS(dl_se, cpu, type));
+
+/* Call to update_curr_dl_se not involving throttle or replenish */
+DECLARE_TRACE(sched_dl_update,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, u8 type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_server_start,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, u8 type),
+	TP_ARGS(dl_se, cpu, type));
+
+DECLARE_TRACE(sched_dl_server_stop,
+	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, u8 type),
+	TP_ARGS(dl_se, cpu, type));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 496dff740dca..6a043f11b79d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -122,6 +122,11 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_update_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d08b00429323..e511e36916bd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -115,6 +115,19 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 }
 #endif /* !CONFIG_RT_MUTEXES */
 
+static inline u8 dl_get_type(struct sched_dl_entity *dl_se, struct rq *rq)
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
@@ -733,6 +746,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 }
 
 /*
@@ -848,6 +862,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
 
+	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
+
 	/*
 	 * If this is the replenishment of a deferred reservation,
 	 * clear the flag and return.
@@ -1345,6 +1361,7 @@ static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
 			dl_se->runtime = 0;
@@ -1508,6 +1525,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_dl_throttle_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
@@ -1532,6 +1550,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
+	} else {
+		trace_sched_dl_update_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	}
 
 	/*
@@ -1810,6 +1830,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1821,6 +1842,8 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq),
+				      dl_get_type(dl_se, dl_se->rq));
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
-- 
2.53.0

