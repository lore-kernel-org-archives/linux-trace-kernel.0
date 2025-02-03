Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936120B21A;
	Mon,  3 Feb 2025 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601107; cv=none; b=GAgm+NmGmb/992FknUWeWw69OwOO2A3ARYfRYJCwXOOyVaDbV2VhcPKQ/Q5agCCLnly5cvOe4GzCcmRL4YuA4wEaWF+TxHy70Q51XJAO2vXffLx1j+ZhiDMZfL5mrjjsICafEPOSCXjuz4svCfEHsIrxatI3p80d2rHknnRzboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601107; c=relaxed/simple;
	bh=FkW+/k4qnI5ImGpLLfCarcFaagK6ISJfKAGXyFcxhs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMdBfr0DQevkohVns7JcMsDiIgFDhOIcMjVWCouuyp48/uEcpjlmj4X2XPOW/urOJ7zwoa4UVcG1QTaersBkfK0ZcZzYmb/9YIYcIlcU1nPoivQck5nvwtbwzVuoAhuU8gYeTfrxxISJtui8UDMUCe+mfQ6ZAJ136xJ0A2f5OTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67837C4CED2;
	Mon,  3 Feb 2025 16:45:03 +0000 (UTC)
Date: Mon, 3 Feb 2025 11:45:37 -0500
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
Message-ID: <20250203114537.6a30c7c0@gandalf.local.home>
In-Reply-To: <20250203084306.GC505@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 09:43:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Lazy is not the default, nor even the recommended preemption method at
> this time.

That's OK. If it is considered to be the default in the future, this can
wait.

> 
> Lazy will not ever be the only preemption method, full isn't going
> anywhere.

That's fine too, as full preemption has the same issue of preempting
kernel mutexes. Full preemption is for something that likely doesn't want
this feature anyway.

> 
> Lazy only applies to fair (and whatever bpf things end up using
> resched_curr_lazy()).

Is that a problem? User spin locks for RT tasks are very dangerous. If an
RT task preempts the owner that is of lower priority, it can cause a
deadlock (if the two tasks are pinned to the same CPU). Which BTW,
Sebastion mentioned in the Stable RT meeting that glibc supplies a
pthread_spin_lock() and doesn't have in the man page anything about this
possible scenario.

> 
> Lazy works on tick granularity, which is variable per the HZ config, and
> way too long for any of this nonsense.

Patch 2 changes that to do what you wrote the last time. It has a max wait
time of 50us.

> 
> So by tying this to lazy, you get something that doesn't actually work
> most of the time, and when it works, it has variable and bad behaviour.

Um no. If we wait for lazy to become the default behavior, it will work
most of the time. And when it does work, it has strict behavior of 50us. 

> 
> So yeah, crap.

As your rationale was not correct, I will disagree with this being crap.


> 
> This really isn't difficult to understand, and I've told you this
> before.

And I listened to what you told me before. Patch 2 implements the 50us max
that you suggested. I separated it out because it made the code simpler to
understand and debug. The change log even mentioned:

     For the moment, it lets it run for one more tick (which will be
     changed later).

That "changed later" is the second patch in this series.

With the "this can wait until lazy is default", is because we have an
"upstream first" policy. As long as there is some buy-in to the changes, we
can go ahead and implement it on our devices. We do not have to wait for it
to be accepted. But if there's a strong NAK to the idea, it is much harder
to get it implemented internally.

I would also implement a way for user space to know if it is supported or
not. Perhaps have the cr_counter of the rseq initialized to some value that
tells user space this is supported in the current configuration of the
kernel? This would make there be "no surprises".

Our current use case is actually for VMs. Which requires a slightly
different method. Instead of having the cr_counter that is used for telling
the kernel the task is in a critical section, the rseq would contain a
pointer to some user space memory that has that counter. The reason is that
this memory would need to be mapped between the VM guest kernel and the VM
VCPU emulation thread. Mathieu did not want to allow exposure of the VM
VCPU thread's rseq structure to the VM guest kernel. Having a separate
memory map for that is more secure.

Then the raw spin locks of the guest VM kernel could be implemented using
this method as well. We do find performance issues when a VCPU of a guest
kernel is preempted while holding spin locks.

We can focus more on this VM use case, and we could then give better
benchmarks. But again, his depends on whether or not you intend on NAKing
this approach altogether.

-- Steve
