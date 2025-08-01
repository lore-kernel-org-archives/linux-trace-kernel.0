Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CA2AE72;
	Fri,  1 Aug 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033397; cv=none; b=prliazdCnSu6tS80jzKuOnESdx3rOyXfPUPg49usjsAgTtObSteb5ZIcY8dCZrwnMzDlnyOD74DE/LOYjqHx/8pV2+ut3BiAhLLPKp1eBlkTkh/6jOGudH5qZgKCoCTJgvAemYg/EsAOCIxv7t81hNQF+eY2jxwHthaJQYrAH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033397; c=relaxed/simple;
	bh=0YomaFC2FvUXwYpRwMmlIAPoXaq81r3Bx4ZUGJLAkoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY8D9Z9p6McQmMBapgnoUth4hOtQ+F7NvXuO2cJxhijLSR17qMDaklfFtJkfGjSwv870jKndZ79I1lEJHkabXlyfurwL65vaT1dMdvSp+4GgDn7djwoDLEU0aVlB7G9I+HGAQeKbQV/XwclAGWivjcFJyKaFqdDu/6OS2tHnZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOWNr48y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAIJenWH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOWNr48y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAIJenWH"
Date: Fri, 1 Aug 2025 09:29:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754033393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+N/HsYV92rLdHJz9cz9fjxxlAkQ7qlLubi8Qu1qZ+eU=;
	b=jOWNr48y6JN/jHoghK8Va0V5dkcgKtHkr6y/0pDWnnVHyoc4gcu7tQQann01OxdrShpX7/
	NmAfA+LibK1MhuRgYn2oz0rPZ5D5OAn6Uplc2kWE9URFyQ64jtbABfn2ESBYNKjqWYB60i
	bPZKr2aLJ49DtfqyKI+hcBLkOnj1AZphmeHvHB6hprAJyhy+fA5cSgZBWFqUk+lK7VxD/q
	r/MKCpD4Xdev+lGsQYSXpaVaS2ZAj89C4zH9xj02Cqie3NA1YnD7vhdaq0kyL91lodSfB7
	0d5vqnr7JTBDHrV6tcdBHhTIQXwhSwQXZN2vhJ9VIwOg9cVprH2RiXDcL+4YXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754033393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+N/HsYV92rLdHJz9cz9fjxxlAkQ7qlLubi8Qu1qZ+eU=;
	b=UAIJenWH8tDWsq5UTsSfouqyZIIkO8j5C/yva+7HU9uP3UeBF+pyjZgTbsN0t6J9/gBW5N
	Kvhe9fVfPObNapDA==
From: Nam Cao <namcao@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20250801072946.nTiUlMwS@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
 <20250730151818.7RemAREO@linutronix.de>
 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
 <20250731073520.ktIOaGts@linutronix.de>
 <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>

On Fri, Aug 01, 2025 at 09:12:08AM +0530, K Prateek Nayak wrote:
> Just thinking out loud, putting this tracepoint here can lead to a
> "dequeued -> dequeued" transition for fair task when they are in delayed
> dequeue state.
> 
>     dequeue_task(p)
>       trace_dequeue_task_tp(p) # First time
>       dequeue_task_fair(p)
>         p->se.delayed = 1
>     ...
>     <sched_switch> # p is still delayed
>     ...
>     sched_setscheduler(p)
>       if (prev_class != next_class && p->se.sched_delayed)
>         dequeue_task(p, DEQUEUE_DELAYED);
>           trace_dequeue_task_tp(p) # Second time
> 
> It is not an issue as such but it might come as a surprise if users are
> expecting a behavior like below which would be the case for !fair task
> currently (and for all tasks before v6.12):
> 
>     digraph state_automaton {
>         center = true;
>         size = "7,11";
>         {node [shape = plaintext, style=invis, label=""] "__init_enqueue_dequeue_cycle"};
>         {node [shape = ellipse] "enqueued"};
>         {node [shape = ellipse] "dequeued"};
>         "__init_enqueue_dequeue_cycle" -> "enqueued";
>         "__init_enqueue_dequeue_cycle" -> "dequeued";
>         "enqueued" [label = "enqueued", color = green3];
>         "enqueued" -> "dequeued" [ label = "dequeue_task" ];
>         "dequeued" [label = "dequeued", color = red];
>         "dequeued" -> "enqueued" [ label = "enqueue_task" ];
>         { rank = min ;
>             "__init_enqueue_dequeue_cycle";
>             "dequeued";
>             "enqueued";
>         }
>     }
> 
> 
> Another:
> 
>    "dequeued" -> "dequeued" [ label = "dequeue_task" ];
> 
> edge would be needed in that case for >= v6.12. It is probably nothing
> and can be easily handled by the users if they run into it but just
> putting it out there for the record in case you only want to consider a
> complete dequeue as "dequeued". Feel free to ignore since I'm completely
> out of my depth when it comes to the usage of RV in the field :)

Ah, thanks for pointing this out. I do want to only consider complete
dequeue as "dequeued".

These tracepoints are not visible from userspace, and RV does not care
about enqueue/dequeue of fair tasks at the moment, so it is not a problem
for now. But as a precaution, I trust the below patch will do.

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
index b485e0639616..553c08a63395 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_enqueue_task_tp(rq->cpu, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
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
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
