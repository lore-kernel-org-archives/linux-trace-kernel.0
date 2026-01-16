Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFB21D590
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567231; cv=none; b=YL5PLvpiJeKdVM5yUI2B/XmeMxeoAI7482U60WQRuWFWQPGCWN1zntoAsC+xUMkfP2xgKCmlw+RGyjmAzdDn+Tu2dUCCwhzCwXRcoWiyVD16aSjL58p1ak8CjQsxB3a8JWl8iOhbX+wkW2kslqyMSSq7N+sl9Om1+h3VUKVXVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567231; c=relaxed/simple;
	bh=YOh+WmjF31wq+7/wt12u5OvU27Q8rBeiXQ9dC6AT3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHyukymD4UxVcOv8bFOPvV1SJ7NQ4UiwZr3B621AyFCIMZSg5RoZjDU42w/Sq6o+CNSNgv3KH6Q+wzjSXb1+uXCHuSiBtj+acaIDT9x2w4qJ8DoKsy+aL9bfA28KB8cSE/md2hr16IpEUYscvGYyv4pZJYPhzcLRnmsl+fJslco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hK9OwRsQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK9OwRsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsinfdR1Sheg5tPjDYElGsfZJDd1jewwP9udfKybc04=;
	b=hK9OwRsQ8VeQuWEp49vkiSGvfeLpuzHCellyLAH78ZCEHL0rP/FkaVKSE5XzawMO/hlNvn
	4Nasz4YIvF2OWqI8DTiTK0GSsqIWXHO7hbVSDkpfNyYYx2tPGBxriGSqBomrKpPm53ZKtw
	QrNqubYxltafkRWRcL5nIg9T3YcmCto=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611--tsmu2GmMmewfCrJlqbCoA-1; Fri,
 16 Jan 2026 07:40:25 -0500
X-MC-Unique: -tsmu2GmMmewfCrJlqbCoA-1
X-Mimecast-MFC-AGG-ID: -tsmu2GmMmewfCrJlqbCoA_1768567224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45BDF18005AE;
	Fri, 16 Jan 2026 12:40:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E99C0195419D;
	Fri, 16 Jan 2026 12:40:19 +0000 (UTC)
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
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 10/15] sched: Add task enqueue/dequeue trace points
Date: Fri, 16 Jan 2026 13:39:06 +0100
Message-ID: <20260116123911.130300-11-gmonaco@redhat.com>
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

From: Nam Cao <namcao@linutronix.de>

Add trace points into enqueue_task() and dequeue_task().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/sched.h | 13 +++++++++++++
 kernel/sched/core.c          |  9 ++++++++-
 kernel/sched/sched.h         |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 366b2e8ec40c..f4e1d3554e3e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -912,6 +912,19 @@ DECLARE_TRACE(sched_dl_server_stop,
 	TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
 	TP_ARGS(dl_se, cpu));
 
+/*
+ * The two trace points below may not work as expected for fair tasks due
+ * to delayed dequeue. See:
+ * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com/
+ */
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
index f6293fa02fb7..8958c013fb2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2087,6 +2087,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_sched_enqueue_tp(p, rq->cpu);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2114,6 +2116,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  */
 inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	int ret;
+
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
 
@@ -2131,7 +2135,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_dec(rq, p);
 	rq->queue_mask |= p->sched_class->queue_mask;
-	return p->sched_class->dequeue_task(rq, p, flags);
+	ret = p->sched_class->dequeue_task(rq, p, flags);
+	if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
+		trace_sched_dequeue_tp(p, rq->cpu);
+	return ret;
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e885a935b716..8465472b40fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2918,6 +2918,8 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
+	trace_sched_dequeue_tp(p, rq->cpu);
+
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
-- 
2.52.0

