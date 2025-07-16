Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA2481CD;
	Wed, 16 Jul 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679912; cv=none; b=ojJzFlAA1RBrGdfDLUwxbvzCf7jHIRg0+lTkqF4qXOU2hQR5M1vIvyCvPuBQ87A34G8jqaIU9PwJVLQJ1hNstUt4unl4yEZuy0Avd4AisMMD+/WrwbllQ3QBTfUmFOpX5pEdWkz7RLcH9XSXcENQexVB5L2NVNYg3W4ZZCeaz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679912; c=relaxed/simple;
	bh=pA3p3h3Eu+EhXFT1woDZ8/ZQ0Aczr13mypEZwdslqWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwyO+kR0Pzkg83OZeHgU9c9v8VXi2Cfy0ByY6i2auso/HahdfJm4PG/W5ja7wxyVBlVWA0o2dUjlhM5f+7WirDVGckovuFYTgylESwMDw3LBolb5pXoAYzlPiXl+QromPdoVnXgNo7U5q2yEYTmYSBPBQhyfa50fF2shM0E2hMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PKonRId9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKonRId9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=goJrWQn7i6UiMMrTRYHYIXkfRqZXNKlxuGdA/csCdF8=; b=PKonRId9vPSG1g6hB66e6MYC6f
	sisU/xqnn91zOA2BYbkViOjGQm7+EAEQPSfWW/27GuqPdN8pjl1R/rvVgx/IkCWQZpj+zG4ZTS+Wz
	aVa8F4gD/taCsGu5ARLZoBi1Lx+VyftVoJysurS87QEw4vHQ3echNwiBv7iCctqp+dUEgyYK6Gqv7
	RQfRe6xyenN7V5re0ESfthf+ojZk6Q02D8I4C/7rz+2xJ2paSwSHfx6Rp+VwTPs3jHDIG/ZNpjmOA
	ERt9YnnQXx9Nhe6j1xHxpPMluKCtGwNuGA2ddYxtGOWQEfMnhJYKNEGb9kBfbTsNjQOl44M5uso62
	prjjOBDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc46j-0000000A7LP-3Mlr;
	Wed, 16 Jul 2025 15:31:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA288300186; Wed, 16 Jul 2025 17:31:44 +0200 (CEST)
Date: Wed, 16 Jul 2025 17:31:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task model
Message-ID: <20250716153144.GY1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-13-gmonaco@redhat.com>
 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
 <20250716141958.GC905792@noisy.programming.kicks-ass.net>
 <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>

On Wed, Jul 16, 2025 at 04:38:36PM +0200, Gabriele Monaco wrote:

> So as you said, we can still reconstruct what happened from the trace, but the
> model suddenly needs more states and more events.

So given a sequence like:

  trace_sched_enter_tp();
  { trace_irq_disable();
    **irq_entry();**
    **irq_exit();**
    trace_irq_enable(); } * Ni
  trace_irq_disable();
  { trace_sched_switch(); } * Nj
  trace_irq_enable();
  { trace_irq_disable();
    **irq_entry();**
    **irq_exit();**
    trace_irq_enable(); } * Nk
  trace_sched_exit_tp();

It becomes somewhat hard to figure out which exact IRQ disabled section
the switch did not happen in (Nj == 0).

> If we could directly tell whether interrupts were disabled manually or from an
> actual interrupt, that wouldn't be necessary, for instance (as in the original
> model by Daniel).

Hmm.. we do indeed appear to trace the IRQ state before adding
HARDIRQ_OFFSET to preempt_count(). Yes, that complicates things a
little.

So... it *might* be possible to lift lockdep_hardirq_enter() to before
we start tracing. But then you're stuck to running with lockdep
enabled -- I'm thinking that's not ideal, given those other patches you
sent.

I'm going to go on holidays soon, but I've made a note to see if we can
lift setting HARDIRQ_OFFSET before we start tracing. IIRC the current
order is because setting HARDIRQ_OFFSET is using preempt_count_add()
which can be instrumented itself.

But we could use __preempt_count_add() instead, then we loose the
tracing from setting HARDIRQ_OFFSET, but I don't think that is a
problem. We already get the latency from the IRQ tracepoints after all.

> I get your point why we don't really need the additional tracepoint, but some
> arguments giving more context come almost for free.

Right. So please always try and justify adding tracepoints.
