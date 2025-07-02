Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6859247297;
	Wed,  2 Jul 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449181; cv=none; b=uzC/2obtvAMwRmw3uhThLEJUbfICsmWiZdrQ2dWIpSj9XinmNqroX37CuxLkykiWvmTdce/AFEf/rg8xtqsdnAHL1YERUYBN7G4+LgcfS6ix+3zBOWIJbquNdqQgaa4BAAKt1xxfK9xnzehLrOkrrGSyhCT0gFLjnYUVGKbtxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449181; c=relaxed/simple;
	bh=pFfRtSm1nfVwd8I1W0M4HDCGj4ZuRd/Raq3zwaQ2dL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uPQzfEtyVqbtn78Fb1XZRH+pCFAVIFof75vAVgm9G7Ncb5xHSTmw/UA3DZHujxh3N1K53rDGulJmu/ZoIUKrpSLlc0XMw5Z9f8sYA0vT0Xgn1zRFpqJ8/WuCkZBKEVBOfT9jNzXdOrGyQ3ycz+LclpDTY5G4IGJxKODgOJHv6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DADx7Gs5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Fnw+crH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DADx7Gs5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Fnw+crH"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751449177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10CYibGvwIVYchOvUOxwjyPV91vxtw5BqVOM0fUyS28=;
	b=DADx7Gs5oChS8tz124E7PgQoyjZN6PFOt4xrJCp3IqgpGjjCcEC5wYQyUQRUMjZf40GGtd
	7+o2D0aaPfDvvMnZxlGuhwqZfMHc/MjsHF/bn3YTBPhaD9J1sP7pxpDE92CKIwJKalhrsF
	S231rF82KkiFdKdaZsK8Ubl4tM+TWB5FuWXcTdgo/XGhYO+RDMlwxoq03lZLxjgeZNdswe
	M8PcHw4GMz+LIGmpReA+V8d2XAyKB7X+LSo9IxVsQ9crJJx/uJSfevHeKTpxBGQlFCMqQ8
	dBLVOa5OlWGb+B13Xq8S+Y2YlLBKmxsBLO4QGSV34yQlzcSj6tWDMkNPHO0V3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751449177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10CYibGvwIVYchOvUOxwjyPV91vxtw5BqVOM0fUyS28=;
	b=+Fnw+crHy4xmKh/dT5Ygf/U+FvNoiyjfkNEflf8c5EM8g/kWZhBsHHPEN5bLiR0h4eM84O
	qN71oJUcjhDkrRDg==
To: Gabriele Monaco <gmonaco@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Andy
 Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix inconsistency in irq tracking on NMIs
In-Reply-To: <5097b17cc506af60ca718aba5a0a10e0fda01440.camel@redhat.com>
References: <20250625120823.60600-1-gmonaco@redhat.com>
 <20250701125459.GL1613200@noisy.programming.kicks-ass.net>
 <5097b17cc506af60ca718aba5a0a10e0fda01440.camel@redhat.com>
Date: Wed, 02 Jul 2025 11:39:37 +0200
Message-ID: <87cyajkk2u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 02 2025 at 09:18, Gabriele Monaco wrote:
> On Tue, 2025-07-01 at 14:54 +0200, Peter Zijlstra wrote:
> I could probably only fix this without even considering NMIs when
> interrupts are disabled, but I believe if that happens, the tracepoints
> would report something wrong, since using tracing_irq_cpu alone does:
>
> local_irq_disable -> trace_irq_off
>   nmi_enter -> no trace
>   nmi_exit -> trace_irq_on
>   // here interrupts are still off, aren't they?
> local_irq_enable -> no trace
>
> The idea that I described poorly, was to use tracing_irq_cpu in a way
> that the first context disabling interrupts fires the tracepoint
> (current behaviour), but when it's time to enable interrupts, an NMI
> which didn't disable interrupts shouldn't trace but let the next
> context trace.
...
> [1] - https://lore.kernel.org/lkml/87sejup1fe.ffs@tglx

As I told you before:

 "As you correctly described, the two states are asynchronous in the
  context of NMIs, so the obvious thing is to treat them as seperate
  entities so that the trace really contains the off/on events
  independent of lockdep enablement and lockdep's internal state. No?"

So I would have expected that you look at the lockdep implementation and
figure out why that one works correctly. Let's have a look at it:

nmi_entry()
   irq_state.lockdep = lockdep_hardirqs_enabled();

   lockdep_hardirqs_off(CALLER_ADDR0);
   ...
   return irq_state;

nmi_exit(irq_state)

   if (irq_state.lockdep)
	lockdep_hardirqs_on(CALLER_ADDR0);

On NMI entry the internal state of lockdep tracking is recorded and
lockdep_hardirqs_off() handles a redundant off gracefully. As I said it
might be arguable to invoke it only when irq_state.lockdep == true, but
that's a cosmetic or performance issue not a correctness problem.

On NMI exit lockdep_hardirqs_on() is only invoked when the lockdep internal
state at entry was 'enabled' so it can restore the state correctly.

If you model the tracer exactly the same way:

   irq_state.lockdep = lockdep_hardirqs_enabled();
   irq_state.tracer = tracer_hardirqs_enabled();
   ....

   You get the idea...

That will be "correct" in terms of sequencing depending on your trace side
implementation:

  trace_hardirqs_off()
        if (trace_hardirqs_enabled()) {
        	trace_irqs_enabled = false;     // A
                emit_trace(OFF);	        // B

If the NMI hits before A, everything is fine because it will record a
ON->OFF transition on NMI entry and a OFF->ON transition on NMI
exit. Then the interrupted context records a ON->OFF transition again.

If it hits between A and B, then the NMI tracing wont do anything
because enabled state is already false, but the resulting trace
sequencing is messed up:

     irqs on
     ...
     nmi_entry
     nmi_exit
     irqs off

IOW, it misses the ON->OFF OFF->ON transitions in the NMI.

So you want to do it the other way round:

  trace_hardirqs_off()
        if (trace_hardirqs_enabled()) {
                emit_trace(OFF);	        // A
        	trace_irqs_enabled = false;     // B

If the NMI hits before A, everything is fine because it will record a
ON->OFF transition on NMI entry and a OFF->ON transition on NMI
exit. Then the interrupted context records a ON->OFF transition again.

If it hits between A and B then you get a duplicate

     irqs on
     ...
     irqs off
     nmi_entry
     irqs off
     irqs on
     nmi_exit

There is nothing you can do about it, but that's easy enough to filter
out, no?

I'm pretty sure you can figure out how that should be modeled on the
on() side of affairs.

Thanks,

        tglx
