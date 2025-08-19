Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2E311587;
	Tue, 19 Aug 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591893; cv=none; b=ORO0sa2rrZ0jl0TYPDyFYVc1Mw6v9dqLToJcN1FrCVaDpw1R7aQlp974AsKT6Vd+n5vbum6W1EyH8DLFUPEzReiMne83BvxJVzM2yu7Uk7f6gvhJRi6hoWIymU0wYR5jWhrOZ96WyYJSmj9kY5dreP76K/lVf/UaQIuxYSEAgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591893; c=relaxed/simple;
	bh=6lxlM7LpjHXHqVyqnKze1giIBDi8DqrF7vJ6SSTuwSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omTMQNyueAa7xQ2d5toEWG1OxtSxbPFWL8I4VspxPc9mpovf175XAanytrw+WYLu4p2rf0KzqzjwokwUmoHzm03VelBJhxtNsfSFuMSgA/Aq9VC8skrvDL8IuJW/WquiYFa5Gi/1A/ZeG0agAWDk0QDj/uuz9+I0yqQJV3pAUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LR2jY6Nn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LR2jY6Nn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FW2tk6/ZiHeL9nk685MmFvRBMYBY64SELa2iXvjfFIc=; b=LR2jY6Nnpkzf7IpsZybzS7NmYS
	aqXkF5frcWGF6H5xPTx3I0IR+LR1aTWojepBGg0mKIQU9BU0D+Essuuy4UQma3Gzl93zJUTiiMmip
	QxBscljKNHoqsIjB0m+PtOtAcJUsy1LnckdWxddKksBNJUdzFNVUKmUdtxTL8Oa90xBVRW5WJ2Zwu
	h+t9La0b8LFXhRWt382R7pkQOvrBfOO7QcwcmbSAX5Gdks2akegV9bSwNVQKgax7SWrpoVL64nW6B
	zutZph/mAatK+OW0naqtsqh0PFhAlj9W2RoGRGMp1lKEAXd2pXOlFnLRsVIk08g9MTvPC7aDdXs8o
	Raj4jIAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHe8-0000000HayM-033z;
	Tue, 19 Aug 2025 08:24:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9087C30036F; Tue, 19 Aug 2025 10:24:43 +0200 (CEST)
Date: Tue, 19 Aug 2025 10:24:43 +0200
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
Message-ID: <20250819082443.GF3245006@noisy.programming.kicks-ass.net>
References: <cover.1754466623.git.namcao@linutronix.de>
 <f87ce0cb979daa3e8221c496de16883ca53f3950.1754466623.git.namcao@linutronix.de>
 <20250815134016.GB3289052@noisy.programming.kicks-ass.net>
 <20250819074920.AmgmzxqO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819074920.AmgmzxqO@linutronix.de>

On Tue, Aug 19, 2025 at 09:49:20AM +0200, Nam Cao wrote:
> On Fri, Aug 15, 2025 at 03:40:16PM +0200, Peter Zijlstra wrote:
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
> Thanks for the suggestion, this makes sense.
> 
> From my understanding, it makes the tracepoints work correctly for fair
> tasks too, so I will get rid of the comment.

Just so indeed :-)
