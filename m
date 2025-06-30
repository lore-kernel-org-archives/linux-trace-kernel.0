Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943528DB7E;
	Mon, 30 Jun 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300646; cv=none; b=pyaGTHwC7hgrWCLwXrUNKw2N+uTu5j0nv8EUBEVqMQ5EIA5No9Cbgd7DVk51jblbHrWqWNCFX3LYhpHBscVrA9UWiPckla6S3W2jlQh2uWaZYnMvFYs8jxhHFnnihU86dFHfRP1LI4T6pgPiD0uJYXfoKZY2i25hjmfqBNmW2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300646; c=relaxed/simple;
	bh=dpCVtlENo5W9k9lJpKTyBfsyoAgADkuZW3XhDzpqLNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhExCF7xSBSi2qb3ZJrKzvw5AD4d5g8MIA4DfJ/BqL0qH2RUi0/jiyC6TIxLPtQXdOYrx5AT5PxTJF3WmQb7l1mRuxRPaB3PGwptcxVWm/L50CsbzffYDmQeUcliQOaB6OlG0duybl1EW6JS17mrsM8RVcVIo0ZJVlU8ExhXbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxdQex7A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vlBJ+6vP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxdQex7A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vlBJ+6vP"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751300642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXonc0KksfgcMOKjNgh+rkn7Fuh0D7ZEpOfg1sBxbSc=;
	b=DxdQex7A4h47bp/vTs/wSvi+EJoKciQsC/faneSoI9IaundjT1ihjXVfwkiAk0y7ZpO4DV
	aSClAYkqJx9gf2ej8TaBhBioaU3OXEHApWREQ/9CF1Fu+HrTJh426wRyAbcGdbe/NciNJN
	zUxRfPZ2xDx94lA6OJQht/J5oU0+4L+MeRo9W5Os5KQNGEJ8r0NY/MUbImFbYyEp8KSFI6
	szLMkOomImbugHzwroBwo10PzF1aMwb54sTNbKLp+h9Ydx4R7Dn8Fc03BjfIsxS4X4zpeV
	Fjz973bJxJjtkoiF4VuWoQ+Xmg2eGrCBCGOFQ+JF8cL1JboXfN67YkBjnqTObQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751300642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXonc0KksfgcMOKjNgh+rkn7Fuh0D7ZEpOfg1sBxbSc=;
	b=vlBJ+6vPAw7wT/FS5SFaJJbVEQlbqZk2uRm+Q78sgJXzy5aipZiStMNgLNeSbJbI3ODqtU
	gLhVGsirUyEzViAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v2] tracing: Fix inconsistency in irq tracking on NMIs
In-Reply-To: <20250625120823.60600-1-gmonaco@redhat.com>
References: <20250625120823.60600-1-gmonaco@redhat.com>
Date: Mon, 30 Jun 2025 18:24:02 +0200
Message-ID: <87tt3xmc4d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 25 2025 at 14:08, Gabriele Monaco wrote:
> The irq_enable/irq_disable tracepoints fire only when there's an actual
> transition (enabled->disabled and vice versa), this needs special care

vice versa). This needs ...

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

Please mention, that you fix the same problem in the ARM64 specific variant.

> Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
> Fixes: f0cd5ac1e4c5 ("arm64: entry: fix NMI {user, kernel}->kernel transitions")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>
> The inconsistency is visible with the sncid RV monitor and particularly
> likely on machines with the following setup:
> - x86 bare-metal with 40+ CPUs
> - tuned throughput-performance (activating regular perf NMIs)
> - workload: stress-ng --cpu-sched 21 --timer 11 --signal 11
>
> The presence of the RV monitor is useful to see the error but it is not
> necessary to trigger it.
>
> Changes since V1:
> * Reworded confusing changelog
> * Remove dependency on lockdep counters for tracepoints
> * Ensure we don't drop valid tracepoints
> * Extend change to arm64 code
>
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

This if clause wants curly brackets and please add a comment explaining
this in_nmi() magic. Two month down the road everyone forgot including
you :)

Thanks,

        tglx
