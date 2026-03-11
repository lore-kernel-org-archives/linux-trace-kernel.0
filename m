Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5140DFB4;
	Wed, 11 Mar 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258212; cv=none; b=HeKguHvr76QxEj54QgR4561X6pwqMYppG+rLdv7bBXJE1rzEX8Lj/tjnTEn4fkvfeFHfQveqEqbTsG6EKMQ33uGR8x8r7hAqXMcq2CTT8JsHZBoZbjihr1wbjcnIfJQ3nDYQjIpUoF+InwF54g0jz9PpuucA8LDtPS66ubqml7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258212; c=relaxed/simple;
	bh=4TEi+jqLlZ9qbpD1JgkM8T6Bt5w4P/AFKvByOBeHz8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW0xxNTnxOR/DlD13jMAj+sJ9/KpvQiBaVHYxiPMHmKGVgkLNx8YuQI1njgUgZVsXLubR9PGIa2tWeVm2EB8xLbclPNFjmeaCrwqs6E8dbEFsYgMoADfzArBiFgJVr5iUsQQ57LpudSipDoBsVMjLnCll7tgzK7MJCr7I5FVLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jp4Oruiu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jp4Oruiu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=THNnTH4shQqlQQkcNYa5YOvoM0/c3YHvCzdf2nverQM=; b=Jp4Oruiu1jN5AHkqKvFZe/GuyX
	TZCZjQXB1c7U+JC07xpimVKgdXTwHvWZt/CEaFpSgHET8bnPZuDOaJPrDVX+GNnzSS7itLB0KCdXh
	IFL2OJK4kR2IFHaQg1TAzOBUM7W5dEs5lX9RmqqvWW1bznHEziY2tUEpF5fw5gstSBhMZt0FEK99M
	U1YDuKZ80UFxXiuJfeMss/awDbynujlw1Kx1B4beuTZNEhks6vLMhWMnymoyhOY2F6D5ZQGT8uG37
	yZbFJk2+DadFa8lltZBjOF01wamWAr5gFZJnUTc0ti1nb1imzwhSKL/Idejrq1P8zNC9N0VvR1KiB
	+RQdly2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0PSm-0000000ACUr-0okS;
	Wed, 11 Mar 2026 19:43:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4B3F0300462; Wed, 11 Mar 2026 20:35:03 +0100 (CET)
Date: Wed, 11 Mar 2026 20:35:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20260311193503.GS606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311125021.197638-2-wander@redhat.com>

On Wed, Mar 11, 2026 at 09:50:15AM -0300, Wander Lairson Costa wrote:

> +extern void __trace_preempt_on(void);
> +extern void __trace_preempt_off(void);
> +
> +DECLARE_TRACEPOINT(preempt_enable);
> +DECLARE_TRACEPOINT(preempt_disable);
> +
> +#define __preempt_trace_enabled(type, val) \
> +	(tracepoint_enabled(preempt_##type) && preempt_count() == (val))
> +
> +static __always_inline void preempt_count_add(int val)
> +{
> +	__preempt_count_add(val);
> +
> +	if (__preempt_trace_enabled(disable, val))
> +		__trace_preempt_off();
> +}
> +
> +static __always_inline void preempt_count_sub(int val)
> +{
> +	if (__preempt_trace_enabled(enable, val))
> +		__trace_preempt_on();
> +
> +	__preempt_count_sub(val);
> +}
>  #else
>  #define preempt_count_add(val)	__preempt_count_add(val)
>  #define preempt_count_sub(val)	__preempt_count_sub(val)
>  #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
>  #endif
>  
> +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
> +#define preempt_count_dec_and_test() \
> +	({ preempt_count_sub(1); should_resched(0); })
> +#endif

Why!?!

Why can't you simply have:

static __always_inline bool preempt_count_dec_and_test(void)
{
	if (__preempt_trace_enabled(enable, 1))
		__trace_preempt_on();

	return __preempt_count_dec_and_test();
}

Also, given how !x86 architectures were just complaining about how
terrible their preempt_emable() is, I'm really not liking this much at
all.

Currently the x86 preempt_disable() is _1_ instruction and
preempt_enable() is all of 3. Adding in these tracepoints will bloat
every single such site by at least another 4-5.

That's significant bloat, for really very little gain. Realistically
nobody is going to need these.
