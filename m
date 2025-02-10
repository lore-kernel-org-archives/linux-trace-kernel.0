Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198D24E4D0;
	Mon, 10 Feb 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225740; cv=none; b=nF2vd9UIGqVFmX9gXpIwmrMJZcRPWz/etNN1Y8mtrjJuNGFRPXPojgfwdgknNjvK5Grj82oe7iZbv2zHZhDqK+71DHHBX8NC0v4TercfbAWsN1T+30Iy3LDsXy9KFKyAfnB3FxA0jIc2P1+QJXxl4MLpmuOksH0Zmw5IDmBugeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225740; c=relaxed/simple;
	bh=JBugsF4suao+uRLDc+amLaMCUNW+RfTAy/NRSarvDZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5hZRCLrbgt2D41/gN2eSQkfOsUxoRe7pXy0ADpVsxm+HFWZVMu0lhP6Bcf6WU281DcWdu4gVQ08vLpfkMOg0gYc4plrndpL5ixNALHF0DtI9JP07RaL/8Fq0xMQveW2cGETpSXcTQ2bl5qoGNtbdW8FL3WJ7u2e7nVdIlkXMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C9DC4CEE6;
	Mon, 10 Feb 2025 22:15:36 +0000 (UTC)
Date: Mon, 10 Feb 2025 17:15:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Prakash Sangappa <prakash.sangappa@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
 Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com, Joseph
 Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250210171539.64268143@gandalf.local.home>
In-Reply-To: <20250210220433.24f6c6c7@pumpkin>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250210144321.1f5974a6@gandalf.local.home>
	<20250210220433.24f6c6c7@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 22:04:33 +0000
David Laight <david.laight.linux@gmail.com> wrote:


> My 'gut feel' is that all the context switches with PREEMPT_RT add a significant
> overhead.

"gut feel" is normally not something we care about. You can have a gut feel
to try new code, but it's the benchmarks and measurements that are the only
input for actual decisions.

> It might not matter if your system is lightly loaded (overspecified),
> but if you need to run at 95%+ cpu then they will hit you hard.
> 
> Maybe you can afford to drop softint and napi code to a high(ish) priority
> thread, but I'd have thought that most interrupts should stay that way and
> most spinlocks stay as spinlocks - and probably all disable interrupts!
> Any interrupts that take 'a long time' or spinlocks that are held for 'a long time'
> really need changing anyway.

There's a lot of users of PREEMPT_RT where things work under load. We've
been arguing about those things being changed for a long time (over 20
years), and that hasn't worked out well. The PREEMPT_RT method was used to
fix that. There's just too many places that grab a spin lock and iterate a
list that doesn't have a bound size.

> 
> But there are some really dreadful bits of code in the kernel.
> One of the Intel ethernet drivers spins for ages whenever the bios is accessing
> the hardware - you can't run RTP audio tests on that system.
> 
> Perhaps interrupt disable and pre-emption times should (optionally) be monitored
> and a warning output every time they go up significantly.
> A 'name and shame' policy might improve matters.

We have interrupt and preemption off latency tracers. Note, any
measurements you add can cause noticeable performance hits. They are small,
but still noticeable. Which is why I recommend disabling them on any
production system.

-- Steve
