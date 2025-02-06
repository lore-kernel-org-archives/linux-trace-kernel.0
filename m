Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0791EA7C6;
	Thu,  6 Feb 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850288; cv=none; b=UcrpLtl7ap33Ywe8PFx2rQGvR5JTIsQioXagN5VNRrYFKIjp04eUd0z82Bsq7yM5C/y9hs6pLazBiuUIXUJ16ntUyMo6SjgKe8cAfVQBBvd/UaIEWVEKvQyAEObo6TgqD+1Kc1fxfjzMWSt9BS/fHieZadKaTSL+259KBxdFBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850288; c=relaxed/simple;
	bh=cEhkfPaoicf2zxAScAcOmhV+Jht47Dii7DLMmmIYkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvO3bHP7pJqhIqRNPp43ZF94spNQ9zo3PbCBZqVDisE8GdtfBH2p5AQWletB7n9VdG8B5KXN3ivxpKy8/G6tDKE6KXCXSxjlMcoRBk3Uz3CGAsAQlUuCmTuTbX4y7FLfiF9oKPa2zreLlWk27I9ULr4qv9XAFA48tQJiG87EHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qFAwRwU9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qFAwRwU9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aS8G2mLVXo/L1oMuqtZDMH9m5wICqaE0EgdSFqltFMQ=; b=qFAwRwU94EzqKbEILUMXjByVGu
	JJUSIYThEUJtvIxP64w/gKtfzM6b27fey57XMLUMpS/KXaNn0cCKxSiHGGPQzWuNbLAbzhWA+r/Ku
	MychWV9G2HX0R3YVIouwsRdbEu/CR82pZr5Xd8D5PNzyBJPoabJPnmNyQAZ2c9zw3e6Pn3IMsM7Nq
	8B7w7WH0BdIVUjvQG89CwZo7NMODIyVO5WSPm7SboBMh5rFiJvdFbsSzbN0iNKnv1NecjbtIIaV7U
	GtNwR/t/gAZeKGy9ZD97CTVPQ25AGA20AVxOtwZ7YGrRT5+0/8VyPgZjSOrhzbi/j0BKytkEQnH4G
	LzO0Kbow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2O1-000000065sw-1yNY;
	Thu, 06 Feb 2025 13:57:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D9B23003E1; Thu,  6 Feb 2025 14:57:44 +0100 (CET)
Date: Thu, 6 Feb 2025 14:57:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20250206135744.GQ7145@noisy.programming.kicks-ass.net>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250206134859.GP7145@noisy.programming.kicks-ass.net>
 <20250206135353.i1tp4vDv@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206135353.i1tp4vDv@linutronix.de>

On Thu, Feb 06, 2025 at 02:53:53PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-06 14:48:59 [+0100], Peter Zijlstra wrote:
> > On Thu, Feb 06, 2025 at 02:44:08PM +0100, Sebastian Andrzej Siewior wrote:
> > > SCHED_OTHER vs SCHED_OTHER after all. But please don't delay a wakeup of
> > > SCHED_FIFO/ RR/ DL because of this LAZY hint.
> > 
> > Thing will get delayed if interrupts are disabled or kernel has
> > preemption disabled too. So as long as we ensure hint crap is of equal
> > order, nothing cares if you do.
> > 
> > If you can't tell the difference between task does hint crap in
> > userspace and task is in the middle of syscall, you can't tell the
> > difference.
> 
> I can tell the difference if I see a trace where an interrupt fires,
> performs a wakeup and the SCHED_OTHER task remains on CPU while the task
> SCHED_FIFO task sits on the runqueue until a timer fires.

Right, but so what? Same delay will happen if interrupt fires in the
middle of a preempt_disable() region.

Or if interrupt gets pending while interrupts are disabled, except your
trace will not show that.

Your worst case response time isn't affected. That's all that matters.


