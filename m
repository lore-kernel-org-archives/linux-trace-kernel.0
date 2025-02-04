Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7E2C190;
	Tue,  4 Feb 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681523; cv=none; b=UMjTSFFNXfQecgNM/O86cft5qC8UmW9oVMC8+ei5BlAt0I69u2uwJgGm0RyAHJ3y6lFTEBkDJt8MsecXMBeMiqpq/6+2NWPCJnerPwgdHBFDzQjT+YMMO6WDrOA4HzItsWu4/8V59bQk8dc1N4qvdmN2+Xo6Saduogpe5+nHWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681523; c=relaxed/simple;
	bh=CkLgufEZxLECrlEuNLBib4Qq/TDvgfRXBAGJyc/cS4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAyaUrPb19RGmogAUrzkTjPYUDXrpZEJGMAKzbRc0uVkSh5fMopTkUqbpcPdzo+v38Em3LlatqNHklxcBFQPvl33ynD89apiyfjbfIv168vdTht09gOUUp+qeZ/CoLXDOL+OroD3o/qZPl5FtRhpY4eh0DjRjPABRMxnDBDiEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6121C4CEDF;
	Tue,  4 Feb 2025 15:05:18 +0000 (UTC)
Date: Tue, 4 Feb 2025 10:05:55 -0500
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
Message-ID: <20250204100555.1a641b9b@gandalf.local.home>
In-Reply-To: <20250204081653.18dfe905@gandalf.local.home>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<20250204091613.GQ7145@noisy.programming.kicks-ass.net>
	<20250204075100.3fcbfda8@gandalf.local.home>
	<20250204081653.18dfe905@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

n Tue, 4 Feb 2025 08:16:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Feb 2025 07:51:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > I'm so confused, WTF do you then need the lazy crap?  
> 
> IOW, the "lazy crap" was created to solve this very issue. The holding of
> sleeping spin locks interrupted by a scheduler tick. I'm just giving user
> space the same feature that we gave the kernel in PREEMPT_RT.
> 

Also, I believe it is best to follow the current preemption method and
that's what the NEED_RESCHED_LAZY gives us.

Let's say you have a low priority program, maybe even malicious, that goes
into a loop of calling a system call that can run for almost a millisecond
without sleeping.

In PREEMPT_NONE, this low priority program can cause RT tasks a latency of
a millisecond because if an RT task wakes up as the program just enters the
system call, it will have to wait for it to exit that system call for it to
run, which might be close to that millisecond.

For PREEMPT_VOLUNTARY, it will only preempt tasks until it hits a
might_sleep(), or cond_resched() (but so would PREEMPT_NONE on the
cond_resched(), but we want to get rid of those).

For PREEMPT_FULL, the program shouldn't affect any other task because its
system call will simply be preempted.

Now let's look at this new feature. It allows a task to ask for some
extended time to get out of a critical section if possible.

If we decide in the future that we remove PREEMPT_NONE and
PREEMPT_VOLUNTARY with a dynamic type like:

TYPE       |    Sched Tick  |  RT Wakeup  |   Enter user space |
===========+================+=============+====================+
None       |    Set LAZY    |   Set LAZY  |     schedule       |
-----------+----------------+-------------+--------------------+
Voluntary? |    Set LAZY    |   schedule  |     schedule       |
-----------+----------------+-------------+--------------------+
Full       |    schedule    |   schedule  |     schedule       |
-----------+----------------+-------------+--------------------+

(The "Enter user space" is when a NEED_RESCHED is set)

Where in NONE, the LAZY flag is set for both the sched tick and the RT
wakeup and it doesn't schedule until it hits user space.

In "Voluntary", the LAZY flag is set only for sched tick on SCHED_OTHER
tasks, but RT tasks will get to be scheduled immediately (depending on
preempt_disable of course).

With "Full" it will schedule whenever it can.

With that task that calls that long system call, which method type above is
in place determines the latency of other tasks.

Now, if we add this feature, I want it to behave the same as a long system
call. Where it would only extend the time if a long system call would
extend the time, as that means it wouldn't modify the typical behavior of
the system for other tasks, but it would help in the performance for the
task that is requesting this feature.

With this feature:

TYPE       |    Sched Tick  |  RT Wakeup  |   Enter user space    |
===========+================+=============+=======================+
None       |    Set LAZY    |   Set LAZY  |     schedule if !LAZY |
-----------+----------------+-------------+-----------------------+
Voluntary? |    Set LAZY    |   schedule  |     schedule if !LAZY |
-----------+----------------+-------------+-----------------------+
Full       |    schedule    |   schedule  |     schedule          |
-----------+----------------+-------------+-----------------------+

Thus, in NONE, it would likely get to extend its time just like if it
called a long system call. This can include even making RT tasks wait a
little longer, just like they would wait on a system call.

In "Voluntary", it would only get its timeslice extended if it was another
SCHED_OTHER task that is to be scheduled. But if an RT task would wake up,
it would schedule immediately regardless if a extended time slice was
requested or not.

In "Full", it probably makes sense to simply disable this feature (the
program would see that it is disabled when it registers the rseq), as it
would never get its time slice extended, as a system call would be
preempted immediately if it was interrupted.

So back to your question about why I'm tying this to the "lazy crap", is
because I want the behavior of other tasks to not change due to one task
asking for an extended time slice.

-- Steve
