Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266347;
	b=NhjEfWNecmWmLXeUrLcax1SQANYinfRQat6GnoxXJPjlwS/IcJLaBQ2b56foQfgsqJiw
	 RxFxKR8dB2DvOvT3SZCrrlXvU+skf9uCRhDpxS+Lwio2RRQx9CQqlqfO97wRnZdJdsCvJ
	 iE51zOZgx8NkqTu3tuaUfbYH4QeGqmXcDZC1jX3br7001Q2bJ6Vvdu7pmcVmx+l4Zc7oh
	 m7gWDEepkCw/nUUcg9tlyxvhVqRuug2yTo6iq4AmEvUPjLydUgH+yArUKvGxc7o8hdrnx
	 QXxQKuKZYhPaKwENcL0w2R9izyMLNWbVBua7/9XXgy69sT77mKs6nYVQnF1dTNZUz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266347;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9QVb+91XYYBUr8R59VhzK+f/JX4StneV4cYQuLGB04s=;
	b=zuH1puDq+TinQPSCrf4rClDdVj/nP3Ae2981GWdMxED32LYdVmYXoz9M0l4/yjsP1/L8
	 jSLedYkIJxZc9G5lXfmX6V3Q3fZJGK4WwxjpfE1KZKHCxFabvcr9ar+0ay/w51Sx9Md14
	 ZnKmhonXAB+vk+qRtFfb2kgTtBtp55RAehlskAQovOpc7n1b4InhqPnbQfL+0geDEeSYN
	 FZIZF7pjNDjiEL2CeYZT57X0rMX7g9Txiv7pdwZsgdjC1jBiJFKsiaLEmYQfYjxZl6v8a
	 IZM+jGA/jY3Y1qE52IYKxo14MufSQYQZt7n8/EvFaFwQKUkgNk4g2F3Z0q37jUA/Ggg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=tvo3Kx0W;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B709606A31C;
	Thu, 29 Oct 2026 09:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B709606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=tvo3Kx0W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9QVb+91XYYBUr8R59VhzK+f/JX4StneV4cYQuLGB04s=; b=tvo3Kx0WyXFmj5M1UvwLLzlyRd
	+tPht+PutUDK9vhZCFChbmxYV68/EO1F64DavgTMgqxxqQKL795BQUJuLN6EviC/v9eCsVF0z5uRC
	x19XRvbyqDt4SmLO/C0GjnzTmlX+3X5ClUru9Os+JtIBJtPmh1JX4q5R7N0X1uE76fBfVwMFUMfHX
	GNOEX8uD1TPYzyljcWQZnMmsMD+Q6hEvICezSBh4ITqD8fAbL9XAeHO2IatFqLLinlugDee5J3UDa
	chJ92lordKxmQdKlAl430pe6b5m1qQQt8HKYWyta3yjE8QAkfeSG7UXMEmHRgaJWvr/3u0cJozy0+
	1XgqVJVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMUe-0000000E6mx-1M9Z;
	Thu, 29 Oct 2026 09:32:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6E93C300329; Thu, 29 Oct 2026 10:32:19 +0100 (CET)
Date: Thu, 29 Oct 2026 10:32:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] sched: Split preempt-count bookkeeping from
 raw updates
Message-ID: <20261029093219.GH1779021@noisy.programming.kicks-ass.net>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-4-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028033127.82193-4-kmehltretter@gmail.com>

On Wed, Oct 28, 2026 at 04:31:17AM +0100, Karl Mehltretter wrote:
> Very early hardirq entry code needs to update the preempt count before
> instrumentable debug and tracing code can run. Conversely, hardirq return
> code needs to finish instrumentable validation and latency tracing before
> raw teardown.
> 
> Add a small hardirq-entry header with irqentry_hardirq_count_start() to
> stage the raw HARDIRQ_OFFSET addition and record whether it was applied in
> an opaque cookie. With DEBUG_PREEMPT and without separate reschedule bits,
> route an already-negative count through a noinstr slow helper which
> preserves the existing DEBUG_LOCKS_WARN_ON() oops short circuit. Add
> irqentry_hardirq_count_finish() to report a rejected addition or complete
> post-add debug checks and latency tracing, and add
> irqentry_hardirq_count_sub_prepare() for validation and tracing before a
> raw subtraction. Keep preempt_count_add() and preempt_count_sub() behavior
> and ordering unchanged.
> 
> Keep latency tracing in each calling path so CALLER_ADDR0 identifies the
> caller. Force the start and stop helpers inline because trace provenance
> depends on their stack frames.

Urgh, so much crazy.

So WARNs in noinstr code are 'fine'. That is, they should not happen, if
they do, bad things have happened and we need the warning out ASAP, if
it takes the machine down, too bad. See the
instrumentation_{begin,end}() markers in x86 asm/bug.h.

But yes, the tracing needs to go. But moving that around should not be
this ugly and also, that will give you the opportunity to fix
preempt_{en,dis}able_notrace(), since they currently also skip the bound
checks.
