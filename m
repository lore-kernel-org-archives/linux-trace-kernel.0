Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BB30C364;
	Tue, 19 Aug 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598373; cv=none; b=eUzohl61vHWBowyFFkKZFfWNzWNtVFZnyieErZs+DdcHADQWOA6jxI2OxsWv7fiWmRQvaqv2obqfBYfGuJY8THoUqSxr+6vn/jjBmqDMNaH1pKd+Qn+F5AKDBLC1HiRWPNU6V6F8J08mR+IOrIdz6WW9kEdEc78l30ul0B+C4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598373; c=relaxed/simple;
	bh=06YjaFiVWIBNJ4VTlKSdNpw3rxJE23Tez/vCW/rl5ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsVo6WJ9rbq2BqYuaLXaKUjgbWN5xArw2Np6WxZuDRF3UMUSb3H4/6B4Oucs2Xh1gAd4x78gF2X0j0YYgvPstuTdjjdMNHmr8msMA9cN1mOX1hzO94ZTeuPMAqoy9YPTOpRicT/XgiF/gxUaEJr18sUWGJ69K94iYTE/ETnYkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jTbTrtq5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTbTrtq5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y6AdS4t483z6V8s6dmuGqZLrWjK0RaXhxrZAlpgOabI=; b=jTbTrtq5kwarMCjDgQCWkRb9jR
	J0O0SGmlqf62o+uL/nc5iyvUwyLnLZQwWKNAgKEgM3igHql259RSvYTdT4QYcNG47Qijz3C8txf6y
	jBg6B88nGmQ5pASuceHNP3QnUtUbG5OojYOt7tEoe+gpNJ5S4cDhhKvNT2LYkmLDjrlfIqZKKlokW
	134WuV/D07/UogJv9v4aSYMhV89RrcVKNUUPygJAgzLHq42tJ+Vi16Eshb9nXgj8uTJuuuChS1Vrr
	Wc59wVR6KPNjTF8FnLzFtauWVhV6spvDFUHyE0KU/mbgiuOEgG3+FGJsGMoEjrp8yBPWEDg8g4qSk
	7ex1WLcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoJKe-00000003Emf-3N4t;
	Tue, 19 Aug 2025 10:12:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82D0E30036F; Tue, 19 Aug 2025 12:12:44 +0200 (CEST)
Date: Tue, 19 Aug 2025 12:12:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> Hi!
> 
> On 14/08/25 17:08, Gabriele Monaco wrote:
> > Add the following tracepoints:
> > 
> > * sched_dl_throttle(dl):
> >     Called when a deadline entity is throttled
> > * sched_dl_replenish(dl):
> >     Called when a deadline entity's runtime is replenished
> > * sched_dl_server_start(dl):
> >     Called when a deadline server is started
> > * sched_dl_server_stop(dl, hard):
> >     Called when a deadline server is stopped (hard) or put to idle
> >     waiting for the next period (!hard)
> > 
> > Those tracepoints can be useful to validate the deadline scheduler with
> > RV and are not exported to tracefs.
> > 
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> >  include/trace/events/sched.h | 55 ++++++++++++++++++++++++++++++++++++
> >  kernel/sched/deadline.c      |  8 ++++++
> >  2 files changed, 63 insertions(+)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 7b2645b50e78..f34cc1dc4a13 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
> >  			__entry->oldprio, __entry->newprio)
> >  );
> >  
> > +/*
> > +DECLARE_EVENT_CLASS(sched_dl_template,
> > +
> > +	TP_PROTO(struct sched_dl_entity *dl),
> > +
> > +	TP_ARGS(dl),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(  struct task_struct *,	tsk		)
> > +		__string( comm,		dl->dl_server ? "server" : container_of(dl, struct task_struct, dl)->comm	)
> > +		__field(  pid_t,	pid		)
> > +		__field(  s64,		runtime		)
> > +		__field(  u64,		deadline	)
> > +		__field(  int,		dl_yielded	)
> 
> I wonder if, while we are at it, we want to print all the other fields
> as well (they might turn out to be useful). That would be
> 
>  .:: static (easier to retrieve with just a trace)
>  - dl_runtime
>  - dl_deadline
>  - dl_period
> 
>  .:: behaviour (RECLAIM)
>  - flags
> 
>  .:: state
>  - dl_ bool flags in addition to dl_yielded

All these things are used as _tp(). That means they don't have trace
buffer entries ever, why fill out fields?


> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(comm);
> > +		__entry->pid		= dl->dl_server ? -1 : container_of(dl, struct task_struct, dl)->pid;
> > +		__entry->runtime	= dl->runtime;
> > +		__entry->deadline	= dl->deadline;
> > +		__entry->dl_yielded	= dl->dl_yielded;
> > +	),
> > +
> > +	TP_printk("comm=%s pid=%d runtime=%lld deadline=%lld yielded=%d",
>                                                         ^^^
> 							llu ?
> 
> > +			__get_str(comm), __entry->pid,
> > +			__entry->runtime, __entry->deadline,
> > +			__entry->dl_yielded)
> > +);
> 
> ...
> 
> > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >  
> >  throttle:
> >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > +		trace_sched_dl_throttle_tp(dl_se);
> >  		dl_se->dl_throttled = 1;
> 
> I believe we also need to trace the dl_check_constrained_dl() throttle,
> please take a look.
> 
> Also - we discussed this point a little already offline - but I still
> wonder if we have to do anything special for dl-server defer. Those
> entities are started as throttled until 0-lag, so maybe we should still
> trace them explicitly as so?
> 
> In addition, since it's related, maybe we should do something about
> sched_switch event, that is currently not aware of deadlines, runtimes,
> etc.

As per the whole _tp() thing, you can attach to the actual
sched_switch tracepoint with a module and read whatever you want.
