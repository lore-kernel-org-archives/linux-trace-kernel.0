Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EA202F87;
	Wed,  6 Aug 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467300; cv=none; b=iIGBSaCxkdDYswDPAN37EjHYTymirmxl/w+0zZ4PJtAT/B3aapsASuroU8NeFL7N0omojcKCkCatB1tHSbFLtBhPhLc+4LFbniVjcmRGndVuZm7Hfz+x41WSJtQEKauk1iyMqeRAP4FxOCxVkC0U3zQ1hwyBzYKm92EMe397+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467300; c=relaxed/simple;
	bh=e1GY5vP2bNmEyxjinI6NGV5JEY4vvanAT/Q+7Kr9JzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ybm3yNaTMaF0NUCvnAFPDZ55NyHWCF7S+GQVc+fNXzjhP1Ccr6KaxYrHRq586dtTxbc2CLKEcap2crAcUILXQLYEgdDRCFFUnO0vhTlt3K4ob6zkpSSQ0/kQ4tCnRw++lhVtEbSxdoWYk4gtDMyEjbs8Yx5PzPwSh/tCHLqFl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJO+Z6HY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7pY9NSpm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJO+Z6HY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7pY9NSpm"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754467290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TG2oABEAGBSkyTcy0x4wV10S9w0c3hQgYmDbKB7zh8=;
	b=BJO+Z6HYp1NNFmnvkJBM/hOq/oK3qFXsWgB0dFU89oYtEEY/HQZVrIGLAB3MVnf7vH2KeZ
	kVcQtCuSPl3K7BFLPswrrd4EfT/wIGFJgMzZoRKaZHj8plg1krifQKhkwxhnPnGJl1ByQD
	ny59/x4t72Cg+O7yu1Zm5tekq7/fTWKj88S159zOcoAXZ9j7nXVZvehmxTvdEtefa85OBe
	2MC89Yh8nskBJrq+eAeHQxpcGNl99OFXAOf7jl1xkdS1tgQTYi4g0blxSmVXiLciTCKfwV
	56fYv+9OlxkKURng/Jb7E6yrMz8zmMh0r4y9zuybCyUhMDYAdp5sblYU5aXGOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754467290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TG2oABEAGBSkyTcy0x4wV10S9w0c3hQgYmDbKB7zh8=;
	b=7pY9NSpmXsuqhqJlheAoXPcnN0wF8Tr74oez3fLekjJUVJiGwetMqZT7UDeOznONvWo89v
	B5fBOsGCNyHyI6Cg==
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
Subject: [PATCH v2 4/5] sched: Add task enqueue/dequeue trace points
Date: Wed,  6 Aug 2025 10:01:20 +0200
Message-Id: <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
In-Reply-To: <cover.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
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
v2: Move the tracepoints to cover all task enqueue/dequeue, not just RT
---
 include/trace/events/sched.h | 13 +++++++++++++
 kernel/sched/core.c          |  8 +++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c08893bde255..ec38928e61e7 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -898,6 +898,19 @@ DECLARE_TRACE(sched_set_need_resched,
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
index b485e0639616..553c08a63395 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
=20
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_enqueue_task_tp(rq->cpu, p);
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
+		trace_dequeue_task_tp(rq->cpu, p);
+		return true;
+	}
+	return false;
 }
=20
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
--=20
2.39.5

