Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60C1CEAD8;
	Thu, 10 Oct 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572138; cv=none; b=oykpiEukgLrqvQzyHLzo6hYxwJbsiMwnvSWMsqarR5GuVaSy9oNmxjJT4JkPjZYhJrJTr8WYGMka7zNoU/OrFTyfP3yeylPZtnWU20xrXgR21Mok3zuooPERp9P0U5E4/87H0EcTJIIJE8+wdL0G64++8SmhTcXarsLFoDwQvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572138; c=relaxed/simple;
	bh=VaKy3/SYsBJIOkT4AZRE2/1NOauMYryXBe8mPgSv6mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4nW3VV7vrkekZ8EYnB0+89AG8D15klDxmPSIfM2vh+IAzzHMmvtP44IejLWJRWzpoEyFpS9BQMtY1wcrV3MlxmzKN4B24tqlkJEbVhrBAHY5dRmFnqsTOhzmWbio/qvnE740AE9i6Ycmz/67lSjCtevB29XNnEND3s562VfemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1s96HPh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9xdIvwl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1s96HPh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9xdIvwl"
Date: Thu, 10 Oct 2024 16:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728572134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z62FhbIDGnDEM0JzTHpSQ5bTUtwOmOam/JPhtFyeT0U=;
	b=k1s96HPhvHH+MVDWbeM91SI3Xr1WCEAcHZcC5ktchhqSnb6v37biafjJBDTddbIwacvfsj
	DeHKa0saPnC77Il9oNFTYfJczRFIXo4X4v4URhYoRH9rYZcM2P3+s13ZOLZx/J9S16UBfl
	LjqKIV4mmi1K/kcFnGNlK1wNVfdxHBlQ8ymwuMUnu7lw7zHrYFQAmL/P/mDDK3h0zgbj7N
	dicI+HBRkjvspfgqH4N+wifdt8bjGEAr63lAik/Alw7TiIiR4vBGQzVoOtSm2EUhbhkbaY
	gD9pIn7OcYM3zooQEqxy3HO1zbTUorTP1h9kwM8fHBnuzQ7ANiX8V9cQ+I5/WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728572134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z62FhbIDGnDEM0JzTHpSQ5bTUtwOmOam/JPhtFyeT0U=;
	b=u9xdIvwlTzOl6UHMmGKrXMFwPH/POsfVxZPkmpNVffJNU8kC1pQrs49CsjzLQbdoMq42nA
	oBc3qirx0+Pd+1AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241010145533.koFksAZb@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-3-bigeasy@linutronix.de>
 <87iku1b2vf.fsf@oracle.com>
 <20241009133328.23fc671c@gandalf.local.home>
 <87bjztaz7e.fsf@oracle.com>
 <20241010105611.VArhcxcr@linutronix.de>
 <20241010105214.0b8f4375@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010105214.0b8f4375@gandalf.local.home>

On 2024-10-10 10:52:14 [-0400], Steven Rostedt wrote:
> On Thu, 10 Oct 2024 12:56:11 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > +++ b/kernel/trace/trace.c
> > @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
> >  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> >  	if (test_preempt_need_resched())
> >  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> > +	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> > +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
> >  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
> >  		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
> >  }
> 
> This is the only update you made from your previous version right?

Yes.

> If so, my reviewed-by stands.

Let me add your's and Ankur's.

> -- Steve

Sebastian
