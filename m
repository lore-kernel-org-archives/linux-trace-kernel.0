Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDA305E00;
	Wed, 24 Sep 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717681; cv=none; b=skQGfBvSObBzWJgGyAfVD2/im17UVdETtnpd1O5lpqjOmv05ysdDgMOCmK40Kvx/GB3tc7JLnEk1TOa8iwevSpTyOlrRsRo1goJZmFAbJC4FedCyR29m1a6b2TfBDmfF0GVUEdZ0WU14ofX9d9DFzJwLjfIO52ely2igsFAlYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717681; c=relaxed/simple;
	bh=1TSFF/t03+mo3lI9t688Ky27M1IpdTRlH9C4J5A/8uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USKG9D0E+tkjCIucKvFYy/I7r1ldxYgKtxagf/0ePF77TAkFdSn8VK0LkppS8dKlpLQHw75mk9ZDnQsm1fgX+pSWIc6ayDrAB7umz86YeYyO+EvjDzpCQxaI1d/Yuf5e1W5mKZMc0OfrPxDiK35Gq0kSx5qTobuqzZlE2eD01v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9XS8u6N; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9XS8u6N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=75arEQaQmlwH+QtZOC67dtQpEq7DI3CYJT7DYuP84Y0=; b=R9XS8u6NQDTlySxAj4oJUbz1iq
	CUyqbcPuY+EOI8rFpt1mlc3T+IcSukamU3hsOYRkz7yoMB9HPuazEBrVV+PCeQZRn2mjrHMoFmk7h
	ofsTQUKWlXqow0cOQltecwD+g47284sBlUgTM+Mlkq0apR6/xja4TSB4mIUEHc3i15K0GlMwLiq07
	3/Pb5nuu3tofUVBwnFWcbuIhX/9sLE2CxMoN1WkJWODwgSg9aQk6dMbUnw0YLNiBR+s6CV8Ekl1qg
	lTrfD/+230OB7QltR3SqVZciRBeEnblAIJUm/dglIwZY6XuDkyTQY72ugJcZIrfyfxlPtZ8rsJpqE
	NOhib5iw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Oo0-00000008jT1-0u6J;
	Wed, 24 Sep 2025 12:41:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C039B30050D; Wed, 24 Sep 2025 14:41:07 +0200 (CEST)
Date: Wed, 24 Sep 2025 14:41:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, mhiramat@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	mathieu.desnoyers@efficios.com, andrii@kernel.org, mingo@kernel.org,
	oleg@redhat.com, akpm@linux-foundation.org, gmonaco@redhat.com,
	ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v2 1/1] tracing/sched: add 'next_policy' to
 trace_sched_switch
Message-ID: <20250924124107.GJ3419281@noisy.programming.kicks-ass.net>
References: <cover.1756212396.git.gaoxiang17@xiaomi.com>
 <c2894f9b0c5116eeffdc19947529aef5c5d1db4c.1756212396.git.gaoxiang17@xiaomi.com>
 <20250912103050.5bf82967@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912103050.5bf82967@gandalf.local.home>

On Fri, Sep 12, 2025 at 10:30:50AM -0400, Steven Rostedt wrote:
> On Tue, 26 Aug 2025 20:48:54 +0800
> Xiang Gao <gxxa03070307@gmail.com> wrote:
> 
> > From: gaoxiang17 <gaoxiang17@xiaomi.com>
> > 
> > Sometimes, when analyzing some real-time process issues, it is necessary to know the sched policy.
> > 
> > Show up in the trace as:
> > 
> > 	 72.267374: sched_switch: prev_comm=grep prev_pid=67 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=66 next_prio=120 next_policy=normal
> > 	 72.267594: sched_switch: prev_comm=cat prev_pid=66 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=67 next_prio=19 next_policy=RR
> > 	562.192567: sched_switch: prev_comm=grep prev_pid=85 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=84 next_prio=120 next_policy=normal
> > 	562.192944: sched_switch: prev_comm=cat prev_pid=84 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=85 next_prio=19 next_policy=FIFO
> > 
> 
> Peter,
> 
> Are you OK with extending the sched switch tracepoint?

I'm not convinced; this is a bit like whitespace patches, people will
want their favourite field added and before you know it the thing will
be fat as never before.

OTOH changing it will be yet another opportunity to find people that are
not following the recommended practise. Someone will come forward and go
complain we broke their shit or something.

Anyway, if we go touch it, you might as well go do it right and move
prev_prio, next_prio and the polcy things into a u8 [*].

Also, I don't know why we have prev_prio, but if that is useful,
shouldn't we also have prev_policy for consistenty sake?

That said, you can mostly guess the policy from the prio, I mean the
distinction between fair/batch and rr/fifo gets lots, but you can
readily tell the difference between the fair and rt and deadline tasks.

[*] I mean, we do use -1 for dl, and that'll map to 255 in u8, but we
can't really use s8 since MAX_PRIO is 140. u8 is bits plenty, but just a
bit weird *shurg*.

this way the event shrinks by 4 bytes, which is at least somewhat of a
reason to do this.

> > Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> > ---
> >  include/trace/events/sched.h | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 7b2645b50e78..00336211aca6 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -234,6 +234,7 @@ TRACE_EVENT(sched_switch,
> >  		__array(	char,	next_comm,	TASK_COMM_LEN	)
> >  		__field(	pid_t,	next_pid			)
> >  		__field(	int,	next_prio			)
> > +		__field(	unsigned int,	next_policy	)
> >  	),
> >  
> >  	TP_fast_assign(
> > @@ -244,10 +245,11 @@ TRACE_EVENT(sched_switch,
> >  		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> >  		__entry->next_pid	= next->pid;
> >  		__entry->next_prio	= next->prio;
> > +		__entry->next_policy	= next->policy;
> >  		/* XXX SCHED_DEADLINE */
> >  	),
> >  
> > -	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
> > +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%s",
> >  		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
> >  
> >  		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> > @@ -263,7 +265,16 @@ TRACE_EVENT(sched_switch,
> >  		  "R",
> >  
> >  		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> > -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> > +		__entry->next_comm, __entry->next_pid, __entry->next_prio,
> > +		__print_symbolic(__entry->next_policy,
> > +				{ SCHED_NORMAL,         "normal" },
> > +				{ SCHED_FIFO,           "FIFO" },
> > +				{ SCHED_RR,             "RR" },
> > +				{ SCHED_BATCH,          "batch" },
> > +				{ SCHED_IDLE,           "idle" },
> > +				{ SCHED_DEADLINE,       "deadline" },
> > +				{ SCHED_EXT,            "sched_ext"})
> > +	)
> >  );
> >  
> >  /*
> 
