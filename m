Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33814130A73;
	Fri, 15 Aug 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265945; cv=none; b=GOD4fWaSWmJ1a5sxlI3CewSGobL0NJrrcwpDe5gdWuBX3AYNWyzpRPij37RW/LvWB0Ipa1cDMZvns5tuCxyAWzPrzUkqLLEhlPWr6l+IsO78kQTA2iDy5S+jja5jqoyZ8colF6tVRepJbakZw+vK+SoB/ib4+R0ouvfoRI9J6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265945; c=relaxed/simple;
	bh=TL347Pnkwac8e08soycFU/rXmtgcm1iOvDEtV+FnrxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaQIf+E6EIESP4Zfts10U6oFowiQhZdcCDCkokmSgfKhrY9kfNgEUnsSb36Lvr29M/TxeSFVEU0x1ij3RNFV3uf2S2HalpkFf75YaHcr+kIKxHm9Y0ZexY70gHNxaWV+rxQUFB6AeOLO1chOebiyp5z7SEVpNFrw8x3FVlDgWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L6hHQhSa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6hHQhSa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tf5ybTKdHBXeTwP/4vkptiHrucyOqHtoLbiAjT6hisU=; b=L6hHQhSatRhc7IV0KCKv7CFqJo
	S0k728rMRdKDYLvAMj62hOXjcR53NRUscmGLXFnYC6DYO8Pi4capx9m9nUaRVYA3Q8EYBcD7PRMhh
	B4tclLN5Y4VXLYK2EDiZnkfW6bkTqxHI63YyRZRd2vS5IhGCsO/rexFP7JZMqRQkSf5lvk4dPSzXg
	a2ddgy1OXBhh5diha2sxuJeTMHd453JnXqycEV60I/+QvlHXJW6U2M2ZhmLo0ZsAAujrC45zZrawx
	yRWlrlD8QZpv9UcZ5PyaiVVJNga071/ceav+35vpRaHd99QbV+/Q5clb1M+dqitfN3wy0QTtsRAlT
	+Np8N5MA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umuqr-0000000DVDO-0ZbQ;
	Fri, 15 Aug 2025 13:52:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D16DD300310; Fri, 15 Aug 2025 15:52:12 +0200 (CEST)
Date: Fri, 15 Aug 2025 15:52:12 +0200
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
Message-ID: <20250815135212.GA1386988@noisy.programming.kicks-ass.net>
References: <cover.1754466623.git.namcao@linutronix.de>
 <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
 <20250815134016.GB3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815134016.GB3289052@noisy.programming.kicks-ass.net>

On Fri, Aug 15, 2025 at 03:40:17PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 06, 2025 at 10:01:20AM +0200, Nam Cao wrote:
> 
> > +/*
> > + * The two trace points below may not work as expected for fair tasks due
> > + * to delayed dequeue. See:
> > + * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com/
> > + */
> 
> > +DECLARE_TRACE(dequeue_task,
> > +	TP_PROTO(int cpu, struct task_struct *task),
> > +	TP_ARGS(cpu, task));
> > +
> 
> > @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >  	 * and mark the task ->sched_delayed.
> >  	 */
> >  	uclamp_rq_dec(rq, p);
> > -	return p->sched_class->dequeue_task(rq, p, flags);
> > +	if (p->sched_class->dequeue_task(rq, p, flags)) {
> > +		trace_dequeue_task_tp(rq->cpu, p);
> > +		return true;
> > +	}
> > +	return false;
> >  }
> 
> Hurmpff.. that's not very nice.
> 
> How about something like:
> 
> dequeue_task():
> 	...
> 	ret = p->sched_class->dequeue_task(rq, p, flags);
> 	if (trace_dequeue_task_p_enabled() && !(flags & DEQUEUE_SLEEP))
> 		__trace_dequeue_task_tp(rq->cpu, p);
> 	return ret;
> 
> 
> __block_task():
> 	trace_dequeue_task_tp(rq->cpu, p);
> 	...
> 
> 
> Specifically, only DEQUEUE_SLEEP is allowed to fail, and DEQUEUE_SLEEP
> will eventually cause __block_task() to be called, either directly, or
> delayed.

If you extend the tracepoint with the sleep state, you can probably
remove the nr_running tracepoints. Esp. once we get this new throttle
stuff sorted.
