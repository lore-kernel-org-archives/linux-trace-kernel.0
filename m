Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787C1C6FEB;
	Thu,  6 Feb 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851759; cv=none; b=SF5JKTVwV/FZhp+xuKkBLLs1xUdyGAAlJA9B1DuPPTrC5Ie3SaC+918NJJPBLMP4xWcWIson+GRJRJg42CaICdDkDRP5461Kvsw9ifiOi58pWx5jfmyNCIYQJ4d/ILmZwYQNpFTMt4zjaR/S6816mu7d84jf2zfqQNINtvsN1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851759; c=relaxed/simple;
	bh=Ql2qwMDAvI/A3hP4Gi3+MQih4sdMF7M/cEfdxpPlaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK9FddVIHOUOFUeS/72nsFogwE9px+cmmFenLtASeAFeh7l0pEVkZlBpwZLLFJ/nQlMRmFCyVsWfoQZGRD4rQTpK/ldoD8olLucpq0JE4WbhsHNX7ZU2ApGgfb7HCLgw6xB9hooaFPC6J7U1IUOSbM3hxpt9dEEZDWhuOhAPZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zi5eh1B/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMI2yJw2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zi5eh1B/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMI2yJw2"
Date: Thu, 6 Feb 2025 15:22:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738851756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GZ0eW3ydhChOWf2KoO0stzIjEJNWi+XUy5NFjSLt4Q=;
	b=zi5eh1B/VgIhag2+mS2V58qg96ULzdik12zgp3j8dOlt6fSvQLG+VIo2b3WW6lzxuwlKtP
	T6GCFUrIsKEW4PFa/n9dX5cP87vwjnKxnOvVgxoqA6TTCBJjyladBCQC8hTAgDHKJkauvE
	XgnP/6FAaMl5xRxCnmMlUDZarAMVUQ4PetGJJUvVFhcgKyvheKKrIijp07PirsfrVpRWhO
	4i0Gf3BSnrNPA6geu2ZSB7m6iYLSvsy4g44wtDABn62BR+NRhREMEMv99cwdkFCJTOnn4A
	dp9+KtCDzvhuIkjyjXQkHz3/OM8G4zE+m1TTApNIUDH6ppb16To8VDKfD0gSNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738851756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GZ0eW3ydhChOWf2KoO0stzIjEJNWi+XUy5NFjSLt4Q=;
	b=QMI2yJw2GyINqfZEYUCNRybW6orTAhTQPXCGAfKk1EOA+92G0S40wkoeFJ8DuqsDqv1a2u
	/R29RuTIMfWrpMBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206142234.-kcSg0xr@linutronix.de>
References: <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250206134859.GP7145@noisy.programming.kicks-ass.net>
 <20250206135353.i1tp4vDv@linutronix.de>
 <20250206135744.GQ7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206135744.GQ7145@noisy.programming.kicks-ass.net>

On 2025-02-06 14:57:44 [+0100], Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 02:53:53PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-02-06 14:48:59 [+0100], Peter Zijlstra wrote:
> > > On Thu, Feb 06, 2025 at 02:44:08PM +0100, Sebastian Andrzej Siewior wrote:
> > > > SCHED_OTHER vs SCHED_OTHER after all. But please don't delay a wakeup of
> > > > SCHED_FIFO/ RR/ DL because of this LAZY hint.
> > > 
> > > Thing will get delayed if interrupts are disabled or kernel has
> > > preemption disabled too. So as long as we ensure hint crap is of equal
> > > order, nothing cares if you do.
> > > 
> > > If you can't tell the difference between task does hint crap in
> > > userspace and task is in the middle of syscall, you can't tell the
> > > difference.
> > 
> > I can tell the difference if I see a trace where an interrupt fires,
> > performs a wakeup and the SCHED_OTHER task remains on CPU while the task
> > SCHED_FIFO task sits on the runqueue until a timer fires.
> 
> Right, but so what? Same delay will happen if interrupt fires in the
> middle of a preempt_disable() region.

But I do see an interrupt and a wakeup in the middle of a
preempt-disable section based on the preempt-counter. Then once the
preempt-disabled section is done, sched-switch is expected.

> Or if interrupt gets pending while interrupts are disabled, except your
> trace will not show that.

That is true. In general we try not to have a lot of these. Also pushing
the "unexpected" part of the CPU such as unrelated interrupts. So may
end up a RT thread and SCHED_OTHER threads on the same CPU. It would be
very unfortunate if this "let me give a bit extra time so I get out of
my critical section" within this SCHED_OTHER application affects the RT
application.
You run SCHED_OTHER tasks and a cyclic interrupt wakes your RT task
every ms. You expect to be scheduled asap, so ideally 0us but 70us in
real world. Then this feature adds 20us on top?

> Your worst case response time isn't affected. That's all that matters.

Sebastian
