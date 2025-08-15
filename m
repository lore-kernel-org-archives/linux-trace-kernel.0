Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51351275B09;
	Fri, 15 Aug 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265230; cv=none; b=u1k3l9u8bBulnKlOllm4UZQ4jUwCtHwLHlQ+P6Y4Q8Nsgf1U0KmbocPVHgPGQ6fnUDaHo9UyoFx423dqSoA9TwZ5apBzss3QJOHg8C79aGcoodF6Q9tTP0Zfojxqyqkd3XJaZYB6DGSLV5/mmCahMcqrgECXH6jzrHdyfeVM9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265230; c=relaxed/simple;
	bh=gibDruno3cT8KxyiXeLHtpfzSPuVxzPl/juG+Mw5S+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuZWsQkl1V2ovDa1a+WQxSXryetyY5LRWLOuB+5e6GZVy2Sop8UxqwpeV6zrpklsbziqiSCPtW4ddyJJlE2OwLtEUlkzH5uO/SS+5NAuKuboq+gjyFs5bjnFH0TgRz3gmpHbK5oxwemlKmhUzJ6iSraSbNtYoKyvH9ydb7+Vtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=esq0fxJa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="esq0fxJa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jlHpGTlWl2uGCBF9xcdQEbpKyePld6IeFFDeJRmdPFc=; b=esq0fxJav8I6TLEn43LU/p3ebu
	tIcIUXXcY+qOrSl+Kv9RibAy6XewgZeKP3aGl3bjQE29US+t+Nye13r2zkaK0kn2Q2OjX9UkhbErE
	DaoAUIAMfEXlW/ILn5Ot1qyhvEFdxw+bNfS8DjCcZfJJxkPPw9SSjbChOWI9UM0wadczBuihtRvFT
	d1Cwlu0YwrilqOZc8pPpHqjpozoX5ywQLgswi6fQXEAUMNg4GRkE5HtYoQET81LV5cTb1XvR/3ENI
	5YCfTj5XQagOz1NHVji//2Ajo8VPbv1RoV4kqF2ZEGxs8QiqdkdsrE870kTTYhr1dzzpepIe16erI
	viPF7X0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umufK-0000000GjBa-1rio;
	Fri, 15 Aug 2025 13:40:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3551E3002ED; Fri, 15 Aug 2025 15:40:17 +0200 (CEST)
Date: Fri, 15 Aug 2025 15:40:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 4/5] sched: Add task enqueue/dequeue trace points
Message-ID: <20250815134016.GB3289052@noisy.programming.kicks-ass.net>
References: <cover.1754466623.git.namcao@linutronix.de>
 <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>

On Wed, Aug 06, 2025 at 10:01:20AM +0200, Nam Cao wrote:

> +/*
> + * The two trace points below may not work as expected for fair tasks due
> + * to delayed dequeue. See:
> + * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com/
> + */

> +DECLARE_TRACE(dequeue_task,
> +	TP_PROTO(int cpu, struct task_struct *task),
> +	TP_ARGS(cpu, task));
> +

> @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	 * and mark the task ->sched_delayed.
>  	 */
>  	uclamp_rq_dec(rq, p);
> -	return p->sched_class->dequeue_task(rq, p, flags);
> +	if (p->sched_class->dequeue_task(rq, p, flags)) {
> +		trace_dequeue_task_tp(rq->cpu, p);
> +		return true;
> +	}
> +	return false;
>  }

Hurmpff.. that's not very nice.

How about something like:

dequeue_task():
	...
	ret = p->sched_class->dequeue_task(rq, p, flags);
	if (trace_dequeue_task_p_enabled() && !(flags & DEQUEUE_SLEEP))
		__trace_dequeue_task_tp(rq->cpu, p);
	return ret;


__block_task():
	trace_dequeue_task_tp(rq->cpu, p);
	...


Specifically, only DEQUEUE_SLEEP is allowed to fail, and DEQUEUE_SLEEP
will eventually cause __block_task() to be called, either directly, or
delayed.
