Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF070825;
	Fri, 20 Jun 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453642; cv=none; b=PiGokBIUXAr9waN/BLkE+HVN15jNceWAT/Z8R562P6KnpXy/NtflzlY6TY+cnvGky1biBQ+zaoyhd+TlytG9za0sMU+b905ynkk4mV1ArGSJhd/Hw4Fz+KBAHSOPv5hfL/OZDsltPr3eUiubH3AmcvYIi1cjGK/cyDvQmOghvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453642; c=relaxed/simple;
	bh=gOYFevN0LEy2D/8b7xY3NrYDJBWaFqN/Mep6tXyQcRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWReDl/A4lGVaogMvKLYhhLpg2xk1nV/5dtC1+jSusqIF8zZcrOTdmAR8p70xHB3SRpB2FscA0Ji+4s7+aOPlZHqy8sjblsAO8YhPZ1+xV000aB4IOJ9DqQQkagZijrKKiE6Ns8AFMmtRGQH4mf1Mvb4tb/LiXXVgbxo5bArrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSoCKK7z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPhJarEJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSoCKK7z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPhJarEJ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750453638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egwWRVIQ5L1+Q/QWzj2riLFWuuq+G6oubEW3WKFA2KQ=;
	b=oSoCKK7z3FOvgltzawlbz6fzYOZIuHhCeJmBk/AKvW6VFki2x06qYX/0CZzxI4K7wl7Ilr
	/3UcPJc54lLuRRAqyhhKt+iYNqVCzUK59nRwDN/xNNm63D4mx7FgGKRCeTITMEKW0Z7Ezd
	qHJz6DRZrGlmtsO+QDj7KF2fXm4FZvwpjK97HaLm2d8w0FIXkYwm541ZZ9TQkUG0hmhn+s
	QmYY2zQZY3Ga+POwavDd/uEh6BtUIYYNZYngmarDhgAjwuorKqDInfK+Xwr7RNeUvZESTP
	pVK6ExGc8wTlWrttIJUiYU+vZSjCrNrWIAwW8YICdu4qkRHpTfmdSLkp9v6NzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750453638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egwWRVIQ5L1+Q/QWzj2riLFWuuq+G6oubEW3WKFA2KQ=;
	b=JPhJarEJhV3zJnci9PuoGV4FkGAbYIniNeiV39H+6W6znyiNAtYjcywSP7WtT75aegPmzb
	9KFYYFazha4sszBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Fix inconsistency in irq tracking on NMIs
In-Reply-To: <20250620125112.33978-2-gmonaco@redhat.com>
References: <20250620125112.33978-2-gmonaco@redhat.com>
Date: Fri, 20 Jun 2025 23:07:17 +0200
Message-ID: <87sejup1fe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 20 2025 at 14:51, Gabriele Monaco wrote:

The subject prefix is misleading. The problem is not in lockdep, the
problem is in the generic entry NMI code, no?

> The irq_enable/irq_disable tracepoints fire only when there's an actual

Now it gets truly confusing. Above you say lockdep, now it's trace
points...

> transition (enabled->disabled and vice versa), this needs special care
> in NMIs, as they could potentially start with IRQs already disabled.

s/IRQs/interrupts/ please. This is not twatter.

> The current implementation takes care of this by tracking the lockdep
> state before the NMI (on nmi_entry) and not tracing on nmi_exit in case
> IRQs were already disabled, we don't trace on nmi_entry following the
> tracing_irq_cpu variable, which can be racy:

This sentence does not parse, especially the subordinate clause starting
with 'we' does not make sense.

> The error is visible with the sncid RV monitor and particularly likely
> on machines with the following setup:
> - x86 bare-metal with 40+ CPUs
> - tuned throughput-performance (activating regular perf NMIs)
> - workload: stress-ng --cpu-sched 21 --timer 11 --signal 11
>
> The presence of the RV monitor is useful to see the error but it is not
> necessary to trigger it.

Not sure whether this information is useful in the change log itself. It
can go into the notes section after the '---' seperator.

> @@ -326,13 +326,15 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
>  	irq_state.lockdep = lockdep_hardirqs_enabled();
>  
>  	__nmi_enter();
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> +	if (irq_state.lockdep)
> +		lockdep_hardirqs_off(CALLER_ADDR0);

This avoids the lockdep call, which has nothing to do with your tracing
problem. lockdep already handles that case. So making this conditional
is a cosmetic noop, nothing else. It's actually questionable whether
this conditional makes sense performance wise. It only makes sense when
the amount of lockdep state == disabled instances is significant.
Otherwise it introduces an extra conditional into the hot path.

>  	lockdep_hardirq_enter();
>  	ct_nmi_enter();
>  
>  	instrumentation_begin();
>  	kmsan_unpoison_entry_regs(regs);
> -	trace_hardirqs_off_finish();
> +	if (irq_state.lockdep)
> +		trace_hardirqs_off_finish();

Now this is the real thing you are interested in, because otherwise you
end up with a trace_irqsoff() event without the corresponding
trace_irqson() event, right?

So in short what you are trying to explain in the change log is:

irqentry_nmi_enter() tracks the lockdep interrupt state on entry to
prevent a lockdep_hardirqs_on() invocation in the NMI exit path, when
lockdep was interrupted by the NMI before it could mark interrupts
enabled in the lockdep tracking. This works correctly, but a similar
problem exists for the local_irq_* tracepoints.

local_irq_enable() invokes trace_hardirqs_on(), which invokes
lockdep_hardirqs_on() after establishing the tracer state.

If the NMI hits before lockdep_hardirqs_on() has established the lockdep
enabled state, then unconditional trace_hardirqs_off_finish() invocation
in irqentry_nmi_enter() flips the tracer state to disabled.

In irqentry_nmi_exit() the counterpart trace_hardirqs_on_prepare() is
only invoked when the lockdep interrupt state on entry was 'enabled',
which means the trace lacks the corresponding interrupt enable entry.

Fix this by making the invocation of trace_hardirqs_off_finish() in
irqentry_nmi_enter() conditional on the lockdep state.

Right?

But you missed something completely here. This problem exists also when
lockdep is disabled and then it is way simpler to trigger. Why?

If lockdep is off, then lockdep_hardirqs_enabled() always returns
false. So any entry where the tracer state is 'enabled' will record a
off, but the exit will not record the on.

As you correctly described, the two states are asynchronous in the
context of NMIs, so the obvious thing is to treat them as seperate
entities so that the trace really contains the off/on events independent
of lockdep enablement and lockdep's internal state. No?

The only other sensible option is to remove the trace points from the
NMI code all together because with the lockdep conditional they are
inconsistent no matter what.

Aside of that you missed to fix the corresponding problem in the arm64
entry code, which still has it's own version of the generic entry code.

Thanks,

        tglx
