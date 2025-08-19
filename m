Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4218223DC6;
	Tue, 19 Aug 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589765; cv=none; b=YAlqD2Z6r/OUtfFkOozRNAbyqpK3HP10pmKQY8sxA56lCyRfBqbGtCGZFw/dKPyoZj3TtrFfb7Nfv+CS4YJ4hSdZakwv2vHmvHXvK6Gxc6tv9oLLAd1aQpZbYiZnjhPCPwEknCEqka4i93uu6LTlF6riJUqkfQc5uWjN19oHfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589765; c=relaxed/simple;
	bh=oSk7TKopUdSKNm4Hr6ww42nyn0hD1UZqyOd5epbBfho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGHBnlNheZdX8A7VjdNeD19OBjAAIMbhrzqwyd3U8jzxDO4RSU/3jWtMiuTIIiCekOXYySvDVNrHz+AFYjLYJXDxPDdfbgws1qXuK48yfKyrfqwNrhttepICjX5hjDcjPO0EfhLTKjXklT77tRjqzsnCNdJScQGme6v9EPdnRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVy6I5QG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5LQDnxO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVy6I5QG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5LQDnxO"
Date: Tue, 19 Aug 2025 09:49:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755589762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cacz723NW9GMMkc+VBRbEYVcSLyKF1BjrZVkCQqgGTE=;
	b=GVy6I5QGMBdr3dUYFcs8kf6rNFAw1OPf6dcVfQR4bgj+FeIAdKZDCJdaBnLcko6m7XZN7o
	QNGLtxhWoVRpIMYM8XnVnJ1do11p90Y70Ujof005kFutmGcXzbas5pFZhucuiVoFHaTIeZ
	uPVUO3WVBLRUIjGbzehI4KRJW0XqmJl8xVSYhlP1vhtBjNfQWEzakEf9oF/E3gliX40xOu
	7PPrZBfGuNyzkS80DP1ILbtSZ+2fmpXWJDoYzeI2RMnl4bl3W0EKWIyANyrXXV4AlFMfFx
	4qmjvsbFSTpmcCsv7XcIs+WnAm+deaZ4OKm2gtsfzAPyROTYywoua5rRzJjQQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755589762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cacz723NW9GMMkc+VBRbEYVcSLyKF1BjrZVkCQqgGTE=;
	b=z5LQDnxOhwKGaek0+LNOxk0F5+dJcgwqUWOv4mo0y5oHHhKFssvaWh6g7VdTW7XvzJgKht
	aWt0MfQwk58cAKBg==
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
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 4/5] sched: Add task enqueue/dequeue trace points
Message-ID: <20250819074920.AmgmzxqO@linutronix.de>
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

On Fri, Aug 15, 2025 at 03:40:16PM +0200, Peter Zijlstra wrote:
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

Thanks for the suggestion, this makes sense.

From my understanding, it makes the tracepoints work correctly for fair
tasks too, so I will get rid of the comment.

Nam
