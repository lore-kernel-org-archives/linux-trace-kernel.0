Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011424336D;
	Thu, 21 Aug 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759910; cv=none; b=iFf1UJ/6ic8qXUTr+DdER09T0JdendQZ93MQTyBsqBIykzZqSkb6OvaAw5TEec7iJ5ls8pnaJV8zGms1yLVWNdAYa67CXSR2bdyMtubjbvCkRHL1+lT0RaA0GAc7pXRhmTas42oZnJtPVKuyB85+mPUx5a23QbxKx0e5tGRBiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759910; c=relaxed/simple;
	bh=AMtmt9QZ1r4SViuDMdeKyVp19CTkjdyfk7ZlZMaN0bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKktsPeGnm+TOqN/7rvfYsXcTZQY8ND5ZydBSi9VVTP3xA/9g7AXOl6oU6b7hDpXy9OKUnM6xDnHe5Vb+AB+EtzCwczDDq7Pe1ptBEdHvUxF5kEtreMA4sq9hd99j0EyuxmGzHmO7bsTnUIVkbf5wHEnTBEFtKO+iuTu0cm3fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dg/1AKfJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IiZ9cmE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dg/1AKfJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IiZ9cmE"
Date: Thu, 21 Aug 2025 09:05:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755759905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ6f+ZOYPIJjUyuvWWZybw8pCAISrbIIQPg4829zj+I=;
	b=Dg/1AKfJ67dV2ppYQXDP0P/iKkQTRoBS62HKxEpnzROZcgKNuZBw6DUvsW+oq0NapFKBKq
	MnBKhPsNHZCNfj4ajoKvL/r3/uev1keDcM8S9zTyXPnYGU6LwdyDd8/TrM8ot7Kid4cbTp
	gtYi6PiDTAybPy156cjdCkvpdDLyk38al3x86o58SL67xkDY6vyoF16yQO8KAaasWFuHhz
	w7WytR88n53sREV5KHk4SFCMsvWU2JnrShHTDrqykDOQHF/kwkVS+H8ZPaEpC1LKaC6tr+
	ppAna9EIGRCoBZxiT5uPZ+JiT5a7Qb3BUeNjF8+5VKObB/2v+61i+03jdmr8bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755759905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ6f+ZOYPIJjUyuvWWZybw8pCAISrbIIQPg4829zj+I=;
	b=4IiZ9cmESPv9HO9eKP3bzlhp847tqtpwjnehsx5Xth1JxFastFOBW5TyIwrDuKpygF2nU1
	PDZSqvEysNTUDFCQ==
From: Nam Cao <namcao@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 4/5] sched: Add task enqueue/dequeue trace points
Message-ID: <20250821070504.-ZhqdfHs@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
 <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
 <20250815134016.GB3289052@noisy.programming.kicks-ass.net>
 <20250815135212.GA1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135212.GA1386988@noisy.programming.kicks-ass.net>

On Fri, Aug 15, 2025 at 03:52:12PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 03:40:17PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 06, 2025 at 10:01:20AM +0200, Nam Cao wrote:
> > 
> > > +/*
> > > + * The two trace points below may not work as expected for fair tasks due
> > > + * to delayed dequeue. See:
> > > + * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com/
> > > + */
> > 
> > > +DECLARE_TRACE(dequeue_task,
> > > +	TP_PROTO(int cpu, struct task_struct *task),
> > > +	TP_ARGS(cpu, task));
> > > +
> > 
> > > @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > >  	 * and mark the task ->sched_delayed.
> > >  	 */
> > >  	uclamp_rq_dec(rq, p);
> > > -	return p->sched_class->dequeue_task(rq, p, flags);
> > > +	if (p->sched_class->dequeue_task(rq, p, flags)) {
> > > +		trace_dequeue_task_tp(rq->cpu, p);
> > > +		return true;
> > > +	}
> > > +	return false;
> > >  }
> > 
> > Hurmpff.. that's not very nice.
> > 
> > How about something like:
> > 
> > dequeue_task():
> > 	...
> > 	ret = p->sched_class->dequeue_task(rq, p, flags);
> > 	if (trace_dequeue_task_p_enabled() && !(flags & DEQUEUE_SLEEP))
> > 		__trace_dequeue_task_tp(rq->cpu, p);
> > 	return ret;
> > 
> > 
> > __block_task():
> > 	trace_dequeue_task_tp(rq->cpu, p);
> > 	...
> > 
> > 
> > Specifically, only DEQUEUE_SLEEP is allowed to fail, and DEQUEUE_SLEEP
> > will eventually cause __block_task() to be called, either directly, or
> > delayed.
> 
> If you extend the tracepoint with the sleep state, you can probably
> remove the nr_running tracepoints. Esp. once we get this new throttle
> stuff sorted.

Sorry, I'm a bit out of depth here. Can you elaborate?

By "sleep state" do you mean (flags & DEQUEUE_SLEEP)? The nr_running
tracepoints are not hit if the task is throttled, while these new
tracepoints are hit. How does the sleep state help with this difference?

Also +Cc Phil Auld <pauld@redhat.com>, who seems to care about the
nr_running tracepoints.

Nam
