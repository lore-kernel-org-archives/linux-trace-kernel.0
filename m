Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D5196DA2;
	Tue, 22 Oct 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590769; cv=none; b=YTcWT8vWPlC6ayRRvl8xHq4FhT4GSaRNPifOrn6hOrFxkdHPPm14Q84O9whWAjI11ISvZsWWcopKDSyRMjcjOygxQFf3ZWXxCB10riAF56j05v+79AxIbwJAMWNLD3X+dxLMW3AZFvmm0rcLP80u/ULrCCiwTG41G8dsodyQcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590769; c=relaxed/simple;
	bh=g8SqYRPpp9QS/7VfSNtj2g5eMi+MSb3EK815FIJkP78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emjTEw9iA6xty+uCTY9P+JSXBrAO5TVUZWz3fl6lP7+ZY0MqLfUSH2kYTraZnL9mUCp4t58jZ2LsJ2oiW6Dl9TJXVU6EvYINqoZG+Mag2zRN9tDTyikgMQR3pZLTKqM45ZM3RM94BtkC8OO6AmXBWp01o6bxsRQ+992lmLpNc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xUvyRuQG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLgvkWQ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xUvyRuQG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLgvkWQ0"
Date: Tue, 22 Oct 2024 11:52:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729590766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uClmIrEfw80CJ6sauv6iuELG9p3dkThn+i0/JrfpKaw=;
	b=xUvyRuQGCvvTFp5I4SLMsJgHYdgmGeoY1dLwZeO0RRkjtJfq7J94/YReUnmKqDU+Mb+n55
	wOn4mrszb4UkR8GjSFI+esuIc1SsasEQVG2glq9DzuOrJcGazjh7mCxNxURWa7ZmCBMwmh
	8H1ENRUmVFx90/1tu+fVr8YyBGh+kT0C9T0Pka1fK0/GVhroffgoX9SnyPQkAgYcUhkZiu
	fA7wJGgoXNcUOo42rbUNGclHrrrOceKOVltgA8FC3wUwFLB0nlKpa+tvk4C+OhoipxPMcB
	oFQh/vCO4vGCq7TtJxMW/jnAHUg+Ykwh/3Si9gkH0KW9aVrO+Mk7aMeubKJNAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729590766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uClmIrEfw80CJ6sauv6iuELG9p3dkThn+i0/JrfpKaw=;
	b=HLgvkWQ0361OgKtGn/+/JWTm3eSwPP7L4s9s2nFDGC2narcjMhP0ZN0r2c8oACjBoNUP9S
	eti9g6i7gOwkUMCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with
 its config option.
Message-ID: <20241022095241.RFY4Iiu_@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
 <20241021151257.102296-2-bigeasy@linutronix.de>
 <20241022031418.12154e63@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022031418.12154e63@rorschach.local.home>

On 2024-10-22 03:14:18 [-0400], Steven Rostedt wrote:
> On Mon, 21 Oct 2024 17:08:40 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The TRACE_FLAG_IRQS_NOSUPPORT flag is used by tracing_gen_ctx.*() to
> > signal that CONFIG_TRACE_IRQFLAGS_SUPPORT is not enabled and tracing IRQ
> > flags is not supported.
> > 
> > This could be replaced by using the 0 as flags and then deducting that
> > there is no IRQFLAGS_SUPPORT based on the config option. The downside is
> > that without CONFIG_TRACE_IRQFLAGS_SUPPORT we can not distinguish
> > between no-IRQ passed flags and callers which passed 0. On the upside we
> > have room for one additional flags which could be used for LAZY_PREEMPTION.
> > 
> > Remove TRACE_FLAG_IRQS_NOSUPPORT and set it flags are 0 and
> > CONFIG_TRACE_IRQFLAGS_SUPPORT is not set.
> 
> We could also add that we have:
> 
> #
> # Minimum requirements an architecture has to meet for us to
> # be able to offer generic tracing facilities:
> #
> config TRACING_SUPPORT
>         bool
>         depends on TRACE_IRQFLAGS_SUPPORT
>         depends on STACKTRACE_SUPPORT
>         default y
> 
> So this can't even be built without TRACE_IRQFLAGS_SUPPORT!

Good point. So we could TRACE_FLAG_IRQS_NOSUPPORT since it can't be
used. This is since commit 0ea5ee035133a ("tracing: Remove PPC32 wart
from config TRACING_SUPPORT").

> > +++ b/include/linux/trace_events.h
> > @@ -184,8 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(un
> >  
> >  enum trace_flag_type {
> >  	TRACE_FLAG_IRQS_OFF		= 0x01,
> > -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
> > -	TRACE_FLAG_NEED_RESCHED		= 0x04,
> > +	TRACE_FLAG_NEED_RESCHED		= 0x02,
> 
> These flags are user visible (I probably should move them into uapi).
> They are parsed by libtraceevent.
> 
> Please just remove NOSUPPORT and do not touch NEED_RESCHED.

Then I put the lazy bit where we have not NOSUPPORT.

> >  	TRACE_FLAG_HARDIRQ		= 0x08,
> >  	TRACE_FLAG_SOFTIRQ		= 0x10,
> >  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -460,7 +460,7 @@ int trace_print_lat_fmt(struct trace_seq
> >  		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
> >  		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
> >  		bh_off ? 'b' :
> > -		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
> > +		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
> 
> Probably can even remove this check.

Yes.

> -- Steve

Sebastian
