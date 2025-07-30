Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE6A921;
	Wed, 30 Jul 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879552; cv=none; b=QMai+RClFIIErwubn7FhWNPaVarypzZp2TFg88WK4qK3FFx4JAqcTWoopL9djkS2Iaqm1mEsSQJjLG2Dd514f9CCnCMK3zk84Llz9QT6RRbQOvsWcl/5qMc2gLble0QCeG+XAmBtLdiCOh5Ql+bkBmAek5PC0X6MfH0odiUZP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879552; c=relaxed/simple;
	bh=0GlN0TUZoy/aEWhdtGatkE2Ui4T36GdSbewZa4kLyJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxY8H4m+jWngxhRX3FMup4H8BEVA8/yArSg8H8xy48aCVwUE6XxvROyR6O8pSVB7y4MhfFkO/NgEnDMlgFr56+ILpQ0MoI/m3ArMwaKG7XpOHIfpCAA62xuOreulF9C3hcCDCGB7A9A4n0sy3s7LbgNugqp/nooH3UghlLLZDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1op1n+nn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0Oi0not; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1op1n+nn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0Oi0not"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QqSbCislEFx6jLhFMONbQ68T9eOl0FVQg1Th9y8jXo=;
	b=1op1n+nnWyaJE/VUAIQam9P7ppNEFgaHBOb+0XoRkjMUW1kzbkJBYF2Gr4E0Ma1Cde9b7T
	3ubSHaChydTSbfH8DzZ4B4zBCcgpOHWazJWmDcrGYMs8NonnBvQ12TjS7D0kdSUgWzKUI1
	IykFDI9gRSqmQXOvPaA6oyk/+Bb7DWT5mBadrymTFZoRdEFG+f29MxTUlKuZK5+HYdASgu
	GE4ObYhFyddaAwYjh1lN7kYk0kzytyaqpm2Tvi4gSSRPUh6B9YXPJp4VxIrI8kgiLjxxzs
	lkMlAz/J/it2F/8I3HKATYi7jpggOHdD7UjMwTqMT4mS9Zwo3TWCWUno8Qt2dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QqSbCislEFx6jLhFMONbQ68T9eOl0FVQg1Th9y8jXo=;
	b=M0Oi0notUaVsA1xgF0ZpAACL/VfvqrjEXhzasnyfdF4CiJ2ptvxoDwPrksFRaH1RJ7BuOp
	e/jEd6fjgHFjiMCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
Date: Wed, 30 Jul 2025 14:45:42 +0200
Message-Id: <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
In-Reply-To: <cover.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add trace points into enqueue_task_rt() and dequeue_task_rt(). They are
useful to implement RV monitor which validates RT scheduling.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 include/trace/events/sched.h | 8 ++++++++
 kernel/sched/rt.c            | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c08893bde255..c38f12f7f903 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -898,6 +898,14 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
=20
+DECLARE_TRACE(enqueue_task_rt,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
+DECLARE_TRACE(dequeue_task_rt,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
 #endif /* _TRACE_SCHED_H */
=20
 /* This part must be outside protection */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c37033..f4d3f5e7fbec 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1480,6 +1480,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p,=
 int flags)
 {
 	struct sched_rt_entity *rt_se =3D &p->rt;
=20
+	trace_enqueue_task_rt_tp(rq->cpu, p);
+
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout =3D 0;
=20
@@ -1501,6 +1503,8 @@ static bool dequeue_task_rt(struct rq *rq, struct tas=
k_struct *p, int flags)
=20
 	dequeue_pushable_task(rq, p);
=20
+	trace_dequeue_task_rt_tp(rq->cpu, p);
+
 	return true;
 }
=20
--=20
2.39.5

