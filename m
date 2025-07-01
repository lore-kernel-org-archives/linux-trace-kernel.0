Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846225B1CE;
	Tue,  1 Jul 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374510; cv=none; b=rizWQeN7cHs6YrcsymorKq+xLobrVHXZu3auCidn4GLjrAIzVV0PfH9YjbGtvpY+73ewY15s74FHYttBA10vrj+aMqoNksJGwb0U1Vvfw2ppPOlUrpsyu4vjVRqpfCuRMjHCdbksP1re/dZBI3XfEdggHIeCgCI6fbUPO9p0fNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374510; c=relaxed/simple;
	bh=nzggGWx4p+gDrJfbB0Id3oN2NbnVR5ofyjmtoHxcMXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPdpq9hwc/obOo9Hqx57YQlU8HxPAzDO6t3g4wBoKkfDhJzUP/s1pDcAM87mqG0AFcDKDhH04G6uL1GzOuDDp3OQEY5yY8zvGgKj7botAzf/5QZ6w9VKDIww+IrNV1JFAECnhecQREN7ZXBfDnAhqaWu/3RldFhXoJGqD9v1oQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KoPp5MBr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KoPp5MBr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4HIb0Zr48fpHIexI58bU8KpKg1eiHR/L5Tbs/Tkn9xM=; b=KoPp5MBrWseJ+RbevAO5vx0MwF
	w62up+Ht+FyTrHV6PZO2Ub2vXUb8mjQDwF1fKYoFfY+NPel4+3EXhM8d5bK3iu2Lnl09Or56H6P2h
	Gr5V4lWHeKHdY9lGOHaHqKJ+dmE8gxt9x6s6DAAJmlMvIhCKrSIVkzpMZT/aepRUGi1Dv3sjS3/gJ
	mmmYGtNPNvobmCsYRKMH/tKZyod6u2H2fPEt+j90ZQBRuHNj0lXn1BTuscRvMuLud4+if3WErRH2y
	/LnOylwI+qGeaIUmHLIW4x7lPZMGWdfczFjv4gkmPG1JUGqqC4OHSRvO5kw+3Hdtoa9N8WqceA9Pg
	6c1Bbrmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWaVo-000000075RC-3HBK;
	Tue, 01 Jul 2025 12:55:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF88B30012D; Tue, 01 Jul 2025 14:54:59 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:54:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix inconsistency in irq tracking on NMIs
Message-ID: <20250701125459.GL1613200@noisy.programming.kicks-ass.net>
References: <20250625120823.60600-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625120823.60600-1-gmonaco@redhat.com>

On Wed, Jun 25, 2025 at 02:08:22PM +0200, Gabriele Monaco wrote:
> The irq_enable/irq_disable tracepoints fire only when there's an actual
> transition (enabled->disabled and vice versa), this needs special care
> in NMIs, as they can potentially start with interrupts already disabled.
> The current implementation takes care of this by tracking the lockdep
> state on nmi_entry as well as using the variable tracing_irq_cpu to
> synchronise with other calls (e.g. local_irq_disable/enable).
> 
> This can be racy in case of NMIs when lockdep is enabled, and can lead
> to missing events when lockdep is disabled.
> 
> Remove dependency on the lockdep status in the NMI common entry/exit
> code and adapt the tracing code to make sure that:
> 
> - The first call disabling interrupts fires the tracepoint
> - The first non-NMI call enabling interrupts fires the tracepoint
> - The last NMI call enabling interrupts fires the tracepoint unless
>   interrupts were disabled before the NMI
> - All other calls don't fire

I'm not at all convinced this is correct. Nor can I understand anything
much about what you wrote above.


>  arch/arm64/kernel/entry-common.c |  5 ++---
>  kernel/entry/common.c            |  5 ++---
>  kernel/trace/trace_preemptirq.c  | 12 +++++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 7c1970b341b8c..7f1844123642e 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -213,10 +213,9 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
>  	bool restore = regs->lockdep_hardirqs;
>  
>  	ftrace_nmi_exit();
> -	if (restore) {
> -		trace_hardirqs_on_prepare();
> +	trace_hardirqs_on_prepare();
> +	if (restore)
>  		lockdep_hardirqs_on_prepare();
> -	}
>  
>  	ct_nmi_exit();
>  	lockdep_hardirq_exit();
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index a8dd1f27417cf..e234f264fb495 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -343,10 +343,9 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
>  {
>  	instrumentation_begin();
>  	ftrace_nmi_exit();
> -	if (irq_state.lockdep) {
> -		trace_hardirqs_on_prepare();
> +	trace_hardirqs_on_prepare();
> +	if (irq_state.lockdep)
>  		lockdep_hardirqs_on_prepare();
> -	}
>  	instrumentation_end();
>  
>  	ct_nmi_exit();
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 0c42b15c38004..fa45474fc54f1 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -58,7 +58,11 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
>   */
>  void trace_hardirqs_on_prepare(void)
>  {
> -	if (this_cpu_read(tracing_irq_cpu)) {
> +	int tracing_count = this_cpu_read(tracing_irq_cpu);
> +
> +	if (in_nmi() && tracing_count > 1)
> +		this_cpu_dec(tracing_irq_cpu);
> +	else if (tracing_count) {
>  		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
>  		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>  		this_cpu_write(tracing_irq_cpu, 0);
> @@ -89,8 +93,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on);
>   */
>  void trace_hardirqs_off_finish(void)
>  {
> -	if (!this_cpu_read(tracing_irq_cpu)) {
> -		this_cpu_write(tracing_irq_cpu, 1);
> +	if (this_cpu_inc_return(tracing_irq_cpu) == 1) {
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
>  		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
>  	}
> @@ -103,8 +106,7 @@ void trace_hardirqs_off(void)
>  {
>  	lockdep_hardirqs_off(CALLER_ADDR0);
>  
> -	if (!this_cpu_read(tracing_irq_cpu)) {
> -		this_cpu_write(tracing_irq_cpu, 1);
> +	if (this_cpu_inc_return(tracing_irq_cpu) == 1) {
>  		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
>  		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
>  	}

So what about lovely things like:

trace_hardirqs_on_prepare()
  if (tracing_irq_cpu) {
    tracer_hardirqs_on();
    <NMI>
      trace_hardirqs_off_finish();
        if (this_cpu_inc_return() == 1) // will be > 1


So now we've traced IRQs are on, start an NMI, and loose the IRQs off
event. Well done.


This was all safe in that it would occasionally emit a duplicate state,
but no state was wrong. Both your attempts have broken things.

How about you fix you tool to accept duplicate state in the face of NMI
instead?
