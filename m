Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FF2DC33D;
	Mon, 11 Aug 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901664; cv=none; b=Hk+t/Z6BwoS91MbJ6c5emoKfZTJp2/w2kVyO/qVCZcQNiGGNYPZslFQO7cGBfXTgx4N5Rca1Cf2qch4yuDT+ZVTgSGOkbrC1dS309ABlIseZ40U2JftzbiYaPBUOYdhb7X6UrBiXhJoMxETPSc/tbJBniBz8yKxe410S4xq5Cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901664; c=relaxed/simple;
	bh=9YsG06WtB9/zUOgaTgppqAwdfXZoFjPNkZ6vFpzOkHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOu/ACjsM3C7rOPLvqUdg9oSTTEf4SofJAdCkBoq4Lqx5GarWY4vV8asXo+ACzkVPEa5EgPs5ugg1TkvUVlP3cZ6vZeUxqE5l6THYtOXElF1SwplS7NXpfxFz7r+DrTihoilxgUMTWCQO5EzNFxkmO8+9iB5uv9fpW8yozAVitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OukrhY09; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hnyGRGTk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OukrhY09";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnyGRGTk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754901661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Miprh6lutDZczVUr8OdDe4LY5knk2xmnfHBwc1ZmSzQ=;
	b=OukrhY09UYSeVdjYlnkQK4tMEcuxsTjqCe4eGSGEm6aZLcFulwJuydpmcaX7n0HjrLoiDp
	84JesybPgouSeitUVFqHpd7b/33hEts1Mm5xTrFZsDuHHGx+6VHs0VKZPhTEIeitHNBk9N
	LbIYBJNS41awBgx7JbLjHaUnfkAq/q+j2sVkegFKbCWmrpXSa43gaJoDukgw/iricv+34i
	0FP3W+t/9WxPadng54VdgXTiraFjpUOVBC3UmT3kD+ZDwDmaIFvxAIazw+Vf48l4tDrAG4
	oGaVc1FYBFRPhPwQPcis/WE68zLwhNPI0ujOuJOMj9hygFRkKQGuJcUkyVI1nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754901661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Miprh6lutDZczVUr8OdDe4LY5knk2xmnfHBwc1ZmSzQ=;
	b=hnyGRGTkvGJBfAbmtGNTsmCR6rhkiB0ptn4XyoH+DKZDpWTrK7v5eTM88lhJvW8zhbPl8W
	QyDaxLZdFiJL2lDA==
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
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
Date: Mon, 11 Aug 2025 10:40:52 +0200
Message-Id: <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
In-Reply-To: <cover.1754900299.git.namcao@linutronix.de>
References: <cover.1754900299.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add trace points into enqueue_task() and dequeue_task(). They are useful to
implement RV monitor which validates RT scheduling.

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
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
---
v3: fix up build issue on !SMP
v2: Move the tracepoints to cover all task enqueue/dequeue, not just RT
---
 include/trace/events/sched.h | 13 +++++++++++++
 kernel/sched/core.c          |  8 +++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..696d22af5a98 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,19 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
=20
+/*
+ * The two trace points below may not work as expected for fair tasks due
+ * to delayed dequeue. See:
+ * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.c=
om/
+ */
+DECLARE_TRACE(enqueue_task,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
+DECLARE_TRACE(dequeue_task,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
 #endif /* _TRACE_SCHED_H */
=20
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..6367799aa023 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
=20
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_enqueue_task_tp(cpu_of(rq), p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
=20
@@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_=
struct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	return p->sched_class->dequeue_task(rq, p, flags);
+	if (p->sched_class->dequeue_task(rq, p, flags)) {
+		trace_dequeue_task_tp(cpu_of(rq), p);
+		return true;
+	}
+	return false;
 }
=20
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
--=20
2.39.5

