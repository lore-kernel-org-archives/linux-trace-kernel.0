Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C7226884;
	Thu,  6 Feb 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848604; cv=none; b=DPecFIFCmEpr2YfkpW+GpHCSEISYRHm2RbI1R/I55F2TMh88SsM2ww3pRbqp0KhQS1EcfSAYyKUGhzqM4iKFwnG4eblw12Q9iDOeVW/i+nXkn0qe6bLtND3kymBy1mHxbTuVl92jZ93Fjuj4/Mw208J7GXqYIfjr7/kJdA/bDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848604; c=relaxed/simple;
	bh=DYpME27A+ab/pShQvnBeasd17GEf4TEkvqRicVcaXYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0o1ck4ghPsdLrwAvvR0/Ymy5a1QzoEN/E4wamgybXU+LrX1xc1Tn7R0GzF5/EQN6YNvGJt81Xu3Mm5jtflrVn78zoCamuBfbIYN0tgf4B3GDufAKqPrxHACUhffCyNtzZvnLoKRofRb9GhvhTDPTo2jQ7FMmnGj6+bv99S2EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51590C4CEE2;
	Thu,  6 Feb 2025 13:30:00 +0000 (UTC)
Date: Thu, 6 Feb 2025 08:30:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>,
 jgross@suse.com, Andrew.Cooper3@citrix.com, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, Joseph Salisbury <joseph.salisbury@oracle.com>,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206083039.0916ad24@gandalf.local.home>
In-Reply-To: <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 22:07:12 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > RT tasks don't have a time slice. They are affected by events. An external
> > interrupt coming in, or a timer going off that states something is
> > happening. Perhaps we could use this for SCHED_RR or maybe even
> > SCHED_DEADLINE, as those do have time slices.
> >
> > But if it does get used, it should only be used when the task being
> > scheduled is the same SCHED_RR priority, or if SCHED_DEADLINE will not fail
> > its guarantees.
> >  
> 
> Right, it would apply still to RR/DL though...

But it would have to guarantee that the RR it is delaying is of the same
priority, and that delaying the DL is not going to cause something to miss
its deadline.

> 
> > > In any case, if you want this to only work on FAIR tasks and not RT
> > > tasks, why is that only possible to do with rseq() + LAZY preemption
> > > and not Prakash's new API + all preemption modes?
> > >
> > > Also you can just ignore RT tasks (not that I'm saying that's a good
> > > idea but..) in taskshrd_delay_resched() in that patch if you ever
> > > wanted to do that.
> > >
> > > I just feel the RT latency thing is a non-issue AFAICS.  
> >
> > Have you worked on any RT projects before?  
> 
> Heh.. I think maybe you misunderstood my statement, I was mentioning
> that I felt (similar to Peter I think) that NOT adopting this feature
> generically for all tasks due to a concern of 50us latency maybe does
> not make sense since poorly designed app / random hardware already
> have this issue. I think the main concern discussed in this thread is
> (and please CMIIW):

We have code that has sub 100us latency and less. If some random user space
application applies this, adding 50us (or even 20us) will break these. And
this has nothing to do with poorly designed applications or hardware.

By adding this as a feature that works everywhere, you will break use cases
that work today.


> 1. Locking down this feature to only SCHED_OTHER versus making it
> generic (maybe sched_ext could also use it?).

sched_ext can do whatever it wants ;-)

But the reason I picked SCHED_OTHER is because that's the only policy that
has no control of when it gets preempted by lower priority processes.

This isn't about "hey I'm in a critical section can you delay higher
priority applications with strict deadlines for me?"

The scheduler tick comes at random moments. SCHED_OTHER is more about
performance and not about latency. Sure, we want better latency when it
comes to reaction times, but that's usually in the millisec range. Not
microsecond range. RT and DL tasks do care about microseconds. And every
microsecond counts. This is why I was fine in limiting this to 50us.

> 2. Tying it to specific preemption methods which may change user mode
> behavior/expectation (because LAZY is tied to preemption method).

Well, every time a user task calls a system call, it is affected by the
preemption method. And I also reported how this can work in all preemption
methods, but only for SCHED_OTHER. It will just take some work on how the
kernel handles NEED_RESCHED_LAZY. User space will be unaware of any of this.

> 3. Overloading the purpose of LAZY: My understanding is, the purpose
> of LAZY is to let the scheduler decide if it wants to preempt based on
> preemption mode. It is not based on any hint, just on the preemption
> mode. I guess you are overloading LAZY by making LAZY flag also extend
> userspace timeslice (versus say making the time-slice extension hint
> its own thing...).

I already replied about that. Note, LAZY was created in PREEMPT_RT for this
very purpose (but in the kernel), and ported to vanilla for a slightly
different purpose.

Here's the history:

  PREEMPT_RT would convert spin_locks in the kernel to sleeping mutexes.

  This made RT tasks respond much faster to events.

  But non-RT (SCHED_OTHER) started suffering performance issues.

  When looking at the performance issues, we found that it was due to tasks
  holding these sleeping spin_locks and being preempted. That is, the
  preemption of holding spin_locks was causing more contention and slowing
  things down tremendously.

  To first handle this, adaptive mutexes was introduced. These would spin
  if the owner of the lock was still running, and would go to sleep if the
  owner goes to sleep. This helped things quite a bit, but PREEMPT_RT was
  still suffer a performance deficit compared to non-RT.

  This was because of the timer tick on SCHED_OTHER tasks that could
  preempt a task holding a spin lock.

  NEED_RESCHED_LAZY was introduced to remedy this. It would be set for
  SCHED_OTHER tasks and NEED_RESCHED for RT tasks. If the task was holding
  a sleeping spin lock, the NEED_RESCHED_LAZY would not preempt the running
  task, but NEED_RESCHED would. If the SCHED_OTHER task was not holding a
  sleeping spin_lock it would be preempted regardless.

This improved the performance of SCHED_OTHER tasks in PREEMPT_RT to be as
good as what was in vanilla.

You see, LAZY was *created* for this purpose. Of letting the scheduler know
that the running task is in a critical section and the timer tick should
not preempt a SCHED_OTHER task.

I just wanted to extend this to SCHED_OTHER in user space too.

> 
> Yes, I have worked on RT projects before --  you would know better
> than anyone. :-D. But admittedly, I haven't got to work much with
> PREEMPT_RT systems.

Just using RT policy to improve performance is not an RT project. I'm
talking about projects that if you miss a deadline things crash. Where the
project works very hard to make sure everything works as intended.

I'm totally against allowing SCHED_OTHER to use any feature that can delay
an RT/DL task (unless of course it is to help those, like priority inheritance).

There's several RT folks on this thread. I wonder if any of
them are OK with this?

-- Steve
