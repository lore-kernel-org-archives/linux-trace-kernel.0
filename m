Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B174068;
	Sat,  1 Feb 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738451181; cv=none; b=nL7LYVBMEapBPf3Vzo/FvTCHKlZUVBhx6ZaHcnMm/QJ/10t6Y+F9O+5ULkavc5bqHThCnl08Pc1saqewCalXUTeK2KK8NTok23mYaCR0nKn3UoatdWZi0UvY7qZK9hrbodwUGVIuQhGjEBuhqFt5aqxOeZK6vQ9L7JBj8FX7XSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738451181; c=relaxed/simple;
	bh=N0CqlKtJwAu+UTsIlLcEoaI234rCTvf5Hq7XDplVXJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnQDSQRadTLYUJ5OJZexaAxMFkEc8zW7CcgI1Ens0S4TcjzNFX/Wd9VuMcQ743HlMgsgNRC0l3+0L/tTVDutLA9ZiPSrUKj2wXNfn+/HUN0MqEmRkm+DtXeXruDxKmpXnnDlDtzprhqHX+Bnua98WBkFX7DTWnV3VPeg86ATBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5409C4CED3;
	Sat,  1 Feb 2025 23:06:17 +0000 (UTC)
Date: Sat, 1 Feb 2025 18:06:17 -0500
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
Message-ID: <20250201180617.491ce087@batman.local.home>
In-Reply-To: <20250201181129.GA34937@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 19:11:29 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Feb 01, 2025 at 07:47:32AM -0500, Steven Rostedt wrote:
> > 
> > 
> > On February 1, 2025 6:59:06 AM EST, Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > >I still have full hate for this approach.  
> > 
> > So what approach would you prefer?  
> 
> The one that does not rely on the preemption method -- I think I posted
> something along those line, and someone else recently reposted something
> bsaed on it.
> 
> Tying things to the preemption method is absurdly bad design -- and I've
> told you that before.

How exactly is it "bad design"? Changing the preemption method itself
changes the way applications schedule and can be very noticeable to the
applications themselves.

No preempt, applications will have high latency every time any
application does a system call.

Preempt voluntary is a little more reactive, but more randomly done.

The preempt lazy kconfig has:

          This option provides a scheduler driven preemption model that
          is fundamentally similar to full preemption, but is less
          eager to preempt SCHED_NORMAL tasks in an attempt to
          reduce lock holder preemption and recover some of the performance
          gains seen from using Voluntary preemption.

This could be a config option called PREEMPT_USER_LAZY that extends the
"reduce lock holder preemption of user space spin locks".

But if your issue is with relying on the preemption method, does that
mean you prefer to have this feature for any preemption method? That may
require still using the LAZY flag that can cause a schedule in the
kernel but not in user space?

Note, my group is actually more interested in implementing this for
VMs. But that requires another level of redirection of the pointers.

That is, qemu could create a device that shares memory between the
guest kernel and the qemu VCPU thread. The guest kernel could update
the counter in this shared memory before grabbing a raw_spin_lock which
act like this patch set does. The difference would be that the counter
would need to live in a memory page that only has this information in
it and not the rseq structure itself. Mathieu was concerned about leaks
and corruption in the rseq structure by a malicious guest. Thus, the
counter would have to be a clean memory page that is shared between the
guest and the qemu thread.

The rseq would then have a pointer to this memory, and the host kernel
would then have to traverse that pointer to the location of the counter.

In other words, my real goal is to have this working for guests on
their raw_spin_locks. We first tried to do this in KVM directly, but
the KVM maintainers said this is more a generic scheduling issue and
doesn't belong in KVM. I agreed with them.

-- Steve
