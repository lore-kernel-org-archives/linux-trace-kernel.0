Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48181E9B04;
	Wed, 16 Jul 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680840; cv=none; b=E1oxTJ2py98tD2lxRNDkxRfCdJuH8WXecp5+b+dGBOA4cd5sXXxLlqsOtA5QXJcvI2PRw3P079q1Tlyi+b7Pa5Jsi3jaAjGFRSN/iFJBN3nEW3IWEzTZw87wjmCJulnbS8u4/con+VjRdvYjRBMmJ5I36vIeLjihEDNtrLGk4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680840; c=relaxed/simple;
	bh=+ej0Li+ybEpVi6WOJdWC/IeM2Ed57TAaTMEZeBQuxR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVAdqQGbjmthHV8iKJQKcn4xDlUEpQC1tfC4kfdDB3MV/C+MRQYoCCybU76qSqXuz4WN9L/h2xe3VX1Z5I8+kk781Q1wWlTKiny6FHaXw80d5e0yGAgYpnhX0P93LDo1MU6PTyX7vlDRAaDCyNWr/BquubB4NHWCt8Bc2ORGNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSiLDVk+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSiLDVk+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kQp9niGFdxjjTm3CxvjlNv+zsOKxSnjexpdcO8s6UCA=; b=lSiLDVk+A2rodzgAJSBwZkDIax
	cpTA189O619kuvIcPIMNDKYurkFYTgEMtRkk1wVJWSnI0Mxdyj5kYPPRn4m90DaCFh74mL0qb+x+d
	ZyGOarXkiCtRIQrFsZro4gGNjbfuywjGOCen7MKmkdaqj8mRBqZf+mRnCJUceth16NbTt4n/MdAYx
	BH4I0x6yPLtHnj/O+v3aoEUKnvOhnGb45HOjttSzrIe0aWXqKMH2d34RJS8ozscfTO8cx0KJKeyyD
	KvRSi7RBgzTYzgIXQnFX9/vMoNOylJzUN6nSF7gIcIIriVqlAuY/T0IMrLn5ZjitagsC6d61BdiR9
	92i8HEVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc4Li-0000000A7hf-2FPF;
	Wed, 16 Jul 2025 15:47:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BB943000DA; Wed, 16 Jul 2025 17:47:14 +0200 (CEST)
Date: Wed, 16 Jul 2025 17:47:14 +0200
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
Message-ID: <20250716154714.GZ1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-13-gmonaco@redhat.com>
 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
 <cbb840b204f7de7e6304bc811e9c629eb0f77486.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbb840b204f7de7e6304bc811e9c629eb0f77486.camel@redhat.com>

On Wed, Jul 16, 2025 at 05:09:43PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 14:38 +0200, Peter Zijlstra wrote:
> > On Tue, Jul 15, 2025 at 09:14:29AM +0200, Gabriele Monaco wrote:
> > > Add the following tracepoints:
> > > * sched_set_need_resched(tsk, cpu, tif)
> > >     Called when a task is set the need resched [lazy] flag
> > > * sched_switch_vain(preempt, tsk, tsk_state)
> > >     Called when a task is selected again during __schedule
> > >     i.e. prev == next == tsk : no real context switch
> > 
> > > @@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq,
> > > struct task_struct *p,
> > >  	int flags = DEQUEUE_NOCLOCK;
> > >  
> > >  	if (signal_pending_state(task_state, p)) {
> > > +		trace_sched_set_state_tp(p, TASK_RUNNING, true);
> > >  		WRITE_ONCE(p->__state, TASK_RUNNING);
> > >  		*task_state_p = TASK_RUNNING;
> > >  		return false;
> > 
> > I'm confused on the purpose of this. How does this relate to say the
> > wakeup in signal_wake_up_state() ?
> 
> Also this adds more context: models like sssw (in this series) expect
> that, after a task is set to sleepable, it either goes to sleep or is
> woken up/set to runnable.
> 
> In this specific case, the task is set to runnable without tracing it,
> so the model doesn't know what happened, since it may not see a wakeup
> after that (the task is already runnable).
> 
> Now I'm not sure if there are other events that we are guaranteed to
> see to reconstruct this specific case (at some point we should see the
> signal, I assume).
> This just simplified things as that is the only state change that was
> not traced.
> 
> Am I missing anything obvious here?


AFAICT this is just a normal wakeup race.

Given:

  for (;;) {
    set_current_state(TASK_UNINTERRUPTIBLE);
    if (COND)
      break;
    schedule();
  }
  __set_current_state(TASK_RUNNING);

vs

  COND=1;
  wake_up_state(p, TASK_UNINTERRUPTIBLE);

The race is seeing COND before or after hitting schedule(). With
interruptible this simply becomes:


  for (;;) {
    set_current_state(TASK_INTERRUPTIBLE);
    if (SIGPENDING || COND)
      break;
    schedule();
  }
  __set_current_state(TASK_RUNNING);

vs

  COND=1;
  wake_up_state(p, TASK_INTERRUPTIBLE);

vs

  set_tsk_thread_flag(p, TIF_SIGPENDING);
  wake_up_state(p, TASK_INTERRUPTIBLE);


(same with KILLABLE, but for fatal signals only)
(except the signal thing will often exit with -EINTR / -ERESTARTSYS, but
that should matter here, right?)

How is the race for seeing SIGPENDING different from seeing COND?

Both will issue a wakeup; except in one case the wakeup is superfluous
because schedule didn't end up blocking because it already saw the
condition, while in the other case it did block and the wakeup is indeed
needed.

Anyway, I don't mind tracing it, but I am confused on that new (3rd)
argument to trace_sched_set_state_tp().

