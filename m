Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEB1DFD96;
	Wed, 30 Jul 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892946; cv=none; b=Qy8gnid6d7bLu1m9MSyOnQwJeHrXBuBSD1IWAFo8Pr2I0dJIxQ5GKBUTmjIc4+6q3DNR6a4DQ44r6xw4SM+ip+JasasRxqEqZAKCsu4cT3l6fkaPxQnElNTq1kwTbwv8qgu9kKGLxCAhmUkKGuQLY+jUFJybpGyDfx/yQDaBe6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892946; c=relaxed/simple;
	bh=jggiZaTVYbB4OEBA1i4DVSHo1/3uiB/LG8J/K0w9JWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLRNlIZHem8bQkN10YnPwptmHH+APv/U7DZ+jOipOwyUoF92cnGd7BWPdIvnjLnGyBFQUACel10zFRXKtUDcWyJEw5ndkiPkPSc9pzFmLNhjNeqVEKvx9FuXAclJnG0WBYvE7L2zdVmLUOIwzr5I3xa39M2r+OKDKi2CdESyJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ww34yMAY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=giTTeePb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ww34yMAY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="giTTeePb"
Date: Wed, 30 Jul 2025 18:28:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753892937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMls9zKlB4XZnAdVDASSbYnpYBlk93kj5Bflf/duEjk=;
	b=ww34yMAY9CrRdppEj76TRYVcQUqYM/SnWvDs91XUhROZ9U4KZQeHBLd7vwIQFim9TDreYb
	jtsFzeCO8xdpZpHeeWOZVg1BMac05XmAh7Bdd8QUotF/c1c1KxxlelmWLwFJSm5zRKPin4
	tErSO0QeBw+Ut/NES9KkTi/WL74xWJRY2kmQmSDCnt5P+KRmiQLr6tmZQgFJIfhhD4d41U
	HlwCbMFg/fFrwxlESl/smaIfbe6mTbLTH8KbGnDWUR2Ey98aPyJTJNqN6GlA0XnWuSMRXd
	/ooH3CqBmt126/opmZSmpvZmhIzti7DuMUmkgBpiusjH6haPk80cBsUU0LzcdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753892937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMls9zKlB4XZnAdVDASSbYnpYBlk93kj5Bflf/duEjk=;
	b=giTTeePbCK3CFiqn6eneIPQ0Ma5dgnBSvYmpyWYR+YPHhLstrUWjCiSJ5HhL9adIttldll
	wLMXhWmGyEKEjRDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250730162855.U6IwNmsc@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728155332.sbkepHj7@linutronix.de>

On Mon, Jul 28, 2025 at 05:53:34PM +0200, Nam Cao wrote:
> On Mon, Jul 28, 2025 at 03:50:19PM +0200, Gabriele Monaco wrote:
> > The tss monitor currently guarantees task switches can happen only while
> > scheduling, whereas the sncid monitor enforces scheduling occurs with
> > interrupt disabled.
> > 
> > Replace the monitors with a more comprehensive specification which
> > implies both but also ensures that:
> > * each scheduler call disable interrupts to switch
> > * each task switch happens with interrupts disabled
> > 
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> I gave this a try on riscv64 and observed some errors:
> 
> [  620.696055] rv: monitor sts does not allow event sched_switch on state enable_to_exit
> [  621.047705] rv: monitor sts does not allow event sched_switch on state enable_to_exit
> [  642.440209] rv: monitor sts does not allow event sched_switch on state enable_to_exit
> 
> I tested with two user programs:
> 
>     int main() { asm ("unimp"); }
>     int main() { asm ("ebreak"); }
> 
> The two programs are repeatedly executed:
> 
>     #!/bin/bash
>     ./test1 &
>     ./test2 &
>     # ... repeat lots of time

Okay, I think I know why..

It seems the monitor is in scheduling state. Then it sees a pair of
irq_disable and irq_enable, and it mistakenly thinks that this is the
is_switch==false case in __schedule. So it thinks it is at the end of
__schedule(), and does not expect a switch_switch.

However, this is wrong. The irq_disable and irq_enable pair is not from
__schedule(), it is from softirq (see below).

In short, the monitor thinks it is at the end of __schedule(), but actually
it is still at the beginning.

That's just from my limited understanding of the model, so I may be wrong.
What do you think?

Nam

             test-256     [002] dns..    63.070743: da_event_sts: scheduling x irq_disable -> disable_to_switch
             test-256     [002] dns..    63.070748: <stack trace>
  => trace_dump_stack
  => da_event_sts
  => handle_irq_disable
  => trace_hardirqs_off.part.0
  => trace_hardirqs_off
  => note_gp_changes
  => rcu_core
  => rcu_core_si
  => handle_softirqs
  => __irq_exit_rcu
  => irq_exit_rcu
  => handle_riscv_irq
  => call_on_irq_stack
             test-256     [002] dns..    63.070755: da_event_sts: disable_to_switch x irq_enable -> enable_to_exit
             test-256     [002] dns..    63.070760: <stack trace>
  => trace_dump_stack
  => da_event_sts
  => handle_irq_enable
  => trace_hardirqs_on
  => note_gp_changes
  => rcu_core
  => rcu_core_si
  => handle_softirqs
  => __irq_exit_rcu
  => irq_exit_rcu
  => handle_riscv_irq
  => call_on_irq_stack
  => call_on_irq_stack
