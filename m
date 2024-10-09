Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D115445B;
	Wed,  9 Oct 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495206; cv=none; b=C5BQ65jL2MJfEkp6D38rZqEGakgbOzrXpLpaSZ18OeV9NnBGjKRHV8itfnRaUjdgnTW1+xhqudtpmOTQpRiTpcyshuGiV4TjWs/R9+fkuQLuLXYQlf3Fpf8bPDT1TEtt7losenMJ4Gg0AJvAyCHSt/OSQu1NalPwk3tGicOGZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495206; c=relaxed/simple;
	bh=OvBFAvwuSrd3btesvxrU3kqpU0fHXzwLbr4PseAgL0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4Mz4RLamiGw5m6S58D5JTs7XviQ+VK7WA1PXE8mkUn+T/WGYZpKARYVg7P1pg5Z0wYmLXgLHpE4a8vfB4rhMQpI+K5dguGC1c6cTW9aRF6qdLAyEMocVi4Fd0HhZNVSUkgW94lc9kCUwwgI8CTQi2gsLcYgCdoqc8fsI0cwtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B6EC4CEC3;
	Wed,  9 Oct 2024 17:33:23 +0000 (UTC)
Date: Wed, 9 Oct 2024 13:33:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, efault@gmx.de, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241009133328.23fc671c@gandalf.local.home>
In-Reply-To: <87iku1b2vf.fsf@oracle.com>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
	<20241009105709.887510-3-bigeasy@linutronix.de>
	<87iku1b2vf.fsf@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Oct 2024 10:30:28 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> > +++ b/kernel/trace/trace.c
> > @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
> >  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> >  	if (test_preempt_need_resched())
> >  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> > +	if (tif_test_bit(TIF_NEED_RESCHED_LAZY))  
> 
> TIF_NEED_RESCHED_LAZY falls back to TIF_NEED_RESCHED without
> CONFIG_ARCH_HAS_PREEMPT_LAZY. So, you might need to add an explicit
> check for that as well.
> 
> With that,
>  Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> Ankur
> 

So this should be:

	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) &&
	    tif_test_bit(TIF_NEED_RESCHED_LAZY))

?

-- Steve


> > +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
> >  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
> >  		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
> >  }
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index 829daa0764dd9..23ca2155306b1 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
> >  		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
> >  		'.';
> >
> > -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
> > +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
> >  				TRACE_FLAG_PREEMPT_RESCHED)) {
> > +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> > +		need_resched = 'B';
> > +		break;
> >  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
> >  		need_resched = 'N';
> >  		break;
> > +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> > +		need_resched = 'L';
> > +		break;
> > +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
> > +		need_resched = 'b';
> > +		break;
> >  	case TRACE_FLAG_NEED_RESCHED:
> >  		need_resched = 'n';
> >  		break;
> >  	case TRACE_FLAG_PREEMPT_RESCHED:
> >  		need_resched = 'p';
> >  		break;
> > +	case TRACE_FLAG_NEED_RESCHED_LAZY:
> > +		need_resched = 'l';
> > +		break;
> >  	default:
> >  		need_resched = '.';
> >  		break;  
