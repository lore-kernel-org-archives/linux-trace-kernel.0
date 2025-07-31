Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE691F237E;
	Thu, 31 Jul 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947330; cv=none; b=C+561+347ccRuGwpEFrsFxQUFnDVoR3oCAqHyRjvs3KVwd+BACrE4DuE4YEmDqoFybFXYHacIxaDn5RtUZ4shsCAnEfUflEZGyZOZcezfIUtmFnR6Y4b2PTJA+HKyq930CxvmfmfzB7knfQZbWmXXeKYjdNrHWI4TvTqR4u3TJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947330; c=relaxed/simple;
	bh=egjVpxzyZf9/qQZT2bq7CnbroLFs/5/e6ZC98hqAs6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkFOfg2U0QAC7hag4noGeDLBHqNfs358DvCtfqA1OHTrp32XlM9QrmQSll8XRnD7fYLmZSk5RACVqLuOo11UMdT9GSGp9R3DPEi/4sxIzk6+KDdcgwJC1g6Ju2FXTWCXbry3YVIAKFw8fUiP3um86zteVLy6yb4dwvVuqZMy6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdFEwpmo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFbqv+ap; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdFEwpmo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFbqv+ap"
Date: Thu, 31 Jul 2025 09:35:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753947326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oBLh7JzoSgAPyFXAZF73AkNp1FaIvaguMqZ2FKVIHI=;
	b=YdFEwpmogknv7+Onzwb+yvimUvOIlqoSxGqGTMA6avIHfWTV1gN4Rvs3wrXRaVEFXa3aMt
	W4rlCUtmvsHOhltW4mj3SkREySpPQNfWvKYqG3inCUmtpTBzT4Hq9bfhzJgbCYzt5s2lZu
	Ap3BKAVqXX+RzW4w7RUhXmq1lOBVnPvW9yhdWSk5kC05GSPb2AjSoQZmBPJOtMPZDfdyw4
	twE790+YFRyPg1GWRy8VUyT6p7UeD6LEwnNyxERHAgE7as6IUPWm3PFvgQQlJFJCaVYANN
	n3LPHZss3WLV5HcHNfLlEFitZVJ+SMrJcaXOcd9AzzBUNevI5xMSyk0XzCpacg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753947326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oBLh7JzoSgAPyFXAZF73AkNp1FaIvaguMqZ2FKVIHI=;
	b=sFbqv+apz8Qrz9r1sp/DvvyXiZLd5kxiuCyc9Zv+Ns5rryU8YhY62RuE9oMF96z2ogUWqb
	nAZ90b7ImT4q+rAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
Message-ID: <20250731073520.ktIOaGts@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
 <20250730151818.7RemAREO@linutronix.de>
 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>

On Wed, Jul 30, 2025 at 06:18:45PM +0200, Gabriele Monaco wrote:
> Well, thinking about it again, these tracepoints might simplify things
> considerably when tasks change policy..
> 
> Syscalls may fail, for that you could register to sys_exit and check
> the return value, but at that point the policy changed already, so you
> cannot tell if it's a relevant event or not (e.g. same policy).
> Also sched_setscheduler_nocheck would be out of the picture here, not
> sure how recurrent that is though (and might not matter if you only
> focus on userspace tasks).
> 
> If you go down the route of adding tracepoints, why not have other
> classes benefit too? I believe calling them from the enqueue_task /
> dequeue_task in sched/core.c would allow you to easily filter out by
> policy anyway (haven't tested).

Something like the untested patch below?

Will you have a use case for it too? Then I will try to accommodate your
use case, otherwise I will do just enough for my case.

Nam

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c38f12f7f903..b50668052f99 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -906,6 +906,14 @@ DECLARE_TRACE(dequeue_task_rt,
 	TP_PROTO(int cpu, struct task_struct *task),
 	TP_ARGS(cpu, task));
 
+DECLARE_TRACE(enqueue_task,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
+DECLARE_TRACE(dequeue_task,
+	TP_PROTO(int cpu, struct task_struct *task),
+	TP_ARGS(cpu, task));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b485e0639616..2af90532982a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_enqueue_task_tp(rq->cpu, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2103,6 +2105,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  */
 inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_dequeue_task_tp(rq->cpu, p);
+
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
 
