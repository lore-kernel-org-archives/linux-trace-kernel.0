Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEF253B7A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184197; cv=none; b=X3B2i6Y/tUiSNTzvrg4p7ZPBkCzchvWp/apAUqVRx9EjfRAhUXhJKd2TC9Poqvpy+wwMcRtpcIyqCSOFIwo36X1i6prBJvXqkZQ2jRVBBEk0ODKvP7FPi8qrsvBrPLvAWeWa8DCdtN3RwVaNXbSdwLets9QXOMcQhS9g7v0FJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184197; c=relaxed/simple;
	bh=QRDBhWFnNSTSVkcgvzU4Y7LqOYfyE5TCUTroeOjHI7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kobb/6Srl8GKAhLpggEwt9U+Mkqq3lr4teaHs2mSe4qomNcWx1LGBHxsKddtUUeGXm6Y485QhI2kaEaY6w+Y1w8y7yAyaWVWODuev/eoYCuCiLBfIJ4W/VnJ8dKMv5S59rHnKTToQjb/U+roOjAmSQeX28ngfyDbGADjqA/cEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5iNtoPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5iNtoPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRA31LDqBAXKj36TOsIql+9CJrq3iDC+cmEwC64LKIE=;
	b=T5iNtoPqYIlj5cYctQ1uX21x+vK2TWMbpL82tV8ZaWXfOkDHMTiQ+RV1BvcIHTYCSqdvGo
	S4aTDbO5fdRN94hBv/4lmon5tmmZKXHaZ6XEIxTfTYHmexQ4qUOWYk8sR0UkAs7TamZJLv
	yPtmdtD8Qt/Em/Z88Sl6rerjgRXY83E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-Tq68DzZBOQaJ0N6rBLusnQ-1; Thu,
 14 Aug 2025 11:09:53 -0400
X-MC-Unique: Tq68DzZBOQaJ0N6rBLusnQ-1
X-Mimecast-MFC-AGG-ID: Tq68DzZBOQaJ0N6rBLusnQ_1755184192
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2C218003FD;
	Thu, 14 Aug 2025 15:09:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B29FC180047F;
	Thu, 14 Aug 2025 15:09:45 +0000 (UTC)
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
Subject: [RFC PATCH 14/17] sched: Add deadline tracepoints
Date: Thu, 14 Aug 2025 17:08:06 +0200
Message-ID: <20250814150809.140739-15-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 include/trace/events/sched.h | 55 ++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c      |  8 ++++++
 2 files changed, 63 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..f34cc1dc4a13 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
 			__entry->oldprio, __entry->newprio)
 );
 
+/*
+DECLARE_EVENT_CLASS(sched_dl_template,
+
+	TP_PROTO(struct sched_dl_entity *dl),
+
+	TP_ARGS(dl),
+
+	TP_STRUCT__entry(
+		__field(  struct task_struct *,	tsk		)
+		__string( comm,		dl->dl_server ? "server" : container_of(dl, struct task_struct, dl)->comm	)
+		__field(  pid_t,	pid		)
+		__field(  s64,		runtime		)
+		__field(  u64,		deadline	)
+		__field(  int,		dl_yielded	)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->pid		= dl->dl_server ? -1 : container_of(dl, struct task_struct, dl)->pid;
+		__entry->runtime	= dl->runtime;
+		__entry->deadline	= dl->deadline;
+		__entry->dl_yielded	= dl->dl_yielded;
+	),
+
+	TP_printk("comm=%s pid=%d runtime=%lld deadline=%lld yielded=%d",
+			__get_str(comm), __entry->pid,
+			__entry->runtime, __entry->deadline,
+			__entry->dl_yielded)
+);
+
+DEFINE_EVENT(sched_dl_template, sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl),
+	TP_ARGS(dl));
+
+DEFINE_EVENT(sched_dl_template, sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl),
+	TP_ARGS(dl));
+*/
+
 #ifdef CONFIG_DETECT_HUNG_TASK
 TRACE_EVENT(sched_process_hang,
 	TP_PROTO(struct task_struct *tsk),
@@ -896,6 +935,22 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+DECLARE_TRACE(sched_dl_throttle,
+	TP_PROTO(struct sched_dl_entity *dl),
+	TP_ARGS(dl));
+
+DECLARE_TRACE(sched_dl_replenish,
+	TP_PROTO(struct sched_dl_entity *dl),
+	TP_ARGS(dl));
+
+DECLARE_TRACE(sched_dl_server_start,
+	TP_PROTO(struct sched_dl_entity *dl),
+	TP_ARGS(dl));
+
+DECLARE_TRACE(sched_dl_server_stop,
+	TP_PROTO(struct sched_dl_entity *dl, bool hard),
+	TP_ARGS(dl, hard));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..f8284accb6b4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -742,6 +742,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
+	trace_sched_dl_replenish_tp(dl_se);
 }
 
 /*
@@ -852,6 +853,9 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
 		replenish_dl_new_period(dl_se, rq);
+	} else {
+		/* replenish_dl_new_period is also tracing */
+		trace_sched_dl_replenish_tp(dl_se);
 	}
 
 	if (dl_se->dl_yielded)
@@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 throttle:
 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
+		trace_sched_dl_throttle_tp(dl_se);
 		dl_se->dl_throttled = 1;
 
 		/* If requested, inform the user about runtime overruns. */
@@ -1590,6 +1595,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
+	trace_sched_dl_server_start_tp(dl_se);
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
@@ -1601,6 +1607,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
+	trace_sched_dl_server_stop_tp(dl_se, true);
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
@@ -1618,6 +1625,7 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 		return true;
 	}
 
+	trace_sched_dl_server_stop_tp(dl_se, false);
 	dl_se->dl_server_idle = 1;
 	return false;
 }
-- 
2.50.1

