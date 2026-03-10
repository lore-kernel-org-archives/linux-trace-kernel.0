Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AA3876A3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140284; cv=none; b=BjhTPm4lvkg/pYe4ETRaSNRIs2+8ccs4lbvSAC9pHKfaApCqk1iTAXBZ84C4ryZlXW4j33u+KTn+LoSqAVI8w5+1JvFvGGAsFe5O+MufgDqXYD88Iq3nCeOyCi/hEg0N1NuzBYBwwszDquHNKVv/rFZEbrpnZ5+7wip7yokHHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140284; c=relaxed/simple;
	bh=SUOqZPjbHzorxGokORc3++g7mxmdzSOeBtnDWCwvJbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lMOuTsAaLVe+q9V7w0+TwzQSSlVitIJYwnpyHgGd0JO3euFu/Eqei7ZqCWFnTSiJ4WHw9N5oFVkAHbiEePgiqFIZBCGgXHEAOwQKull0iwvx4bkJazrUNBFQ5fyd+J1+IzWF5KhEP6/+s7lYTLpvvDOuQT4ByNSsdUCMWac/5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTLqCaIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTLqCaIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpnLRP65UDD0WsX6xe9844dqjNMDybV8+1extAcrsVo=;
	b=UTLqCaIGwxxYn24hU1GKk3FNdctODcxinBcUzbbp9828KedEigGqN9osxnXa55N/TR/Z6b
	wOovd9R5/jWMpMd+nBXQjb63DIwF2l3Ps3B41gAeBAOrFfp0R5nm6dY+6JVXGe3coaN4lj
	EEhSXS1v5TmqB+5rC2iR9Xz5IzKosyg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-trv8cT17NBi0TArJvQHjIA-1; Tue,
 10 Mar 2026 06:57:58 -0400
X-MC-Unique: trv8cT17NBi0TArJvQHjIA-1
X-Mimecast-MFC-AGG-ID: trv8cT17NBi0TArJvQHjIA_1773140276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC5151956054;
	Tue, 10 Mar 2026 10:57:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.35.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B66C21800759;
	Tue, 10 Mar 2026 10:57:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v7 08/15] sched: Add task enqueue/dequeue trace points
Date: Tue, 10 Mar 2026 11:56:20 +0100
Message-ID: <20260310105627.332044-9-gmonaco@redhat.com>
In-Reply-To: <20260310105627.332044-1-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: FbzY1ESL52gfqk8skhYJ_BqPCKTdnad6Hu3LTMfsYOc_1773140276
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Nam Cao <namcao@linutronix.de>

Add trace points into enqueue_task() and dequeue_task().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V7:
    * Use cpu_of(rq) helper in tracepoint calls
    V5:
    * Do not fire enqueue tracepoint for delayed enqueues

 include/trace/events/sched.h |  8 ++++++++
 kernel/sched/core.c          | 12 +++++++++++-
 kernel/sched/sched.h         |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..5844147ec5fd 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,14 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+DECLARE_TRACE(sched_enqueue,
+	TP_PROTO(struct task_struct *tsk, int cpu),
+	TP_ARGS(tsk, cpu));
+
+DECLARE_TRACE(sched_dequeue,
+	TP_PROTO(struct task_struct *tsk, int cpu),
+	TP_ARGS(tsk, cpu));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e..c9ca1e048612 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -122,6 +122,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
@@ -2094,6 +2096,9 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
+		trace_sched_enqueue_tp(p, cpu_of(rq));
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2120,6 +2125,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  */
 inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	bool ret;
+
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
 
@@ -2136,7 +2143,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	return p->sched_class->dequeue_task(rq, p, flags);
+	ret = p->sched_class->dequeue_task(rq, p, flags);
+	if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
+		trace_sched_dequeue_tp(p, cpu_of(rq));
+	return ret;
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 43bbf0693cca..d7ab0aa58a70 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2955,6 +2955,8 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
+	trace_sched_dequeue_tp(p, cpu_of(rq));
+
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
-- 
2.53.0

