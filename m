Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C320D4FD;
	Tue,  4 Feb 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673429; cv=none; b=uGuvrWj7d+Fw+B2Y2wzx20xIgjdqP7gLmFCpYU4TM/Ne5l5JBnSajBkKcoPp61sMbDX4TgMwYb9L9LalOkZopKgSA5DcA0UCOumibK+Eoqnd7Ka55K2dqh8ef31j7MorIOM83Ok1A5Fn2rVIHM8Hp1WYWfpJds5kJOLBDHN51xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673429; c=relaxed/simple;
	bh=JYq4lA4tXtp+3MUanleura52qsXla53IeOokyysVpvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMkBZio04mCnRyn0cIa9X4EM+8QWvUa2wS+WSBfbFXzxs5nzXj/cx52ANNdgzZerpnl8Otu4u+6tPUIATJkXDRmzxWeAoThFqtm/gdPFcbRTD9RERpzlDmdYUBC7o7lqvSXxRp6E7wWxe6W8mi8U2+8U73fcPcgJYLVLaU50vQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20619C4CEDF;
	Tue,  4 Feb 2025 12:50:25 +0000 (UTC)
Date: Tue, 4 Feb 2025 07:51:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250204075100.3fcbfda8@gandalf.local.home>
In-Reply-To: <20250204091613.GQ7145@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<20250204091613.GQ7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 10:16:13 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> And yes, you can still use the whole 'delay preemption' hint for RT
> tasks just fine. Spinlocks isn't the only thing. It can be used to make
> any RSEQ section more likely to succeed.
> 
> 
> > Patch 2 changes that to do what you wrote the last time. It has a max wait
> > time of 50us.  
> 
> I'm so confused, WTF do you then need the lazy crap?
> 
> You're making things needlessly complicated again.

Do we really want to delay an RT task by 50us?

That will cause a lot more regressions.

This is a performance feature not a latency one. RT tasks are about
limiting latency and will sacrifice performance to do so. PREEMPT_RT has
great minimal latency at the expense of performance. We try to improve
performance but never at the sacrifice of latency.

RT wakeups are also more predictable. That is, they happen when an event
comes in or a timer expires and when an RT task wakes up it is to run ASAP
to handle some event.

This is about SCHED_OTHER tasks where the scheduler decides when a task
gets to run and will preempt it when its quota is over. The task has no
idea when that will happen. This is about giving the kernel a hint that
it's a bad time to interrupt the task and if it can just wait another 50us
or less, then it would be fine to schedule. SCHED_OTHER tasks never have
latency requirements less than a millisecond. And SCHED_OTHER tasks are
effected by other SCHED_OTHER tasks, even those that are lower priority.

My patches here were based on where the NEED_RESCHED_LAZY came from, and
that was from the PREEMPT_RT patch. The problem was that the kernel would
allow preemption almost everywhere. This was great for RT tasks, but non RT
tasks suffered performance issues. That's because of the timer tick going
off while a SCHED_OTHER task was holding a spin_lock converted into a mutex
and it would be scheduled out while holding that sleeping spin_lock. This
increased the amount of contention on that spin_lock, and that affected
performance.

The fix was to introduce NEED_RESCHED_LAZY which would not have the
SCHED_OTHER task preempt while holding a sleeping spin_lock. This put back
the performance close to non PREEMPT_RT.

This work I'm doing is based on that. It doesn't make sense to delay RT
tasks for a performance improvement.

-- Steve
