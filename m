Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718116;
	b=YDAHQSMejARWFZf/hI/2kZl+TVPfdL3o9fFr2gZhBECpd+RAVMJ9WdaWtQLOssSreAlr
	 l9n0fp8b6WgZ2+DvR6Rvd3CN96iQQaR+y/OlsDqWssbtbsJfAuYAYsSa3BznjXPINKa1N
	 ZRLCH7oK7I0rniG5Eo98E9GonaJVHn7tjEVUVBVJuBMgO8Tit1uxSGsMU5KCM6TNs4BrL
	 gUS1dsBtuqnzGHJuIXR1arqh2d6J/L55GFAt7OjPxfU8ZscGQfR1pIzdjbdz8kLcG4viE
	 3KnAtxt5ZGHsejZ4r2he7VVwu7vKXpI1TpWJOMhAif4Z3M6f9rDEAGDPxylqupUM3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718116;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lNoDcgtyIRtshKKQA77hdTnKAgEL8asv9kuIbWA+WPc=;
	b=cs+nLenylHSLw66iUqIk+Zivt30gDLuZekkjJYu93K5qAUpvy6BFc29DKeeUKG3OapaD
	 8ifZ3kkSqCOb0xiO4dmjdNpTdhdR9RxnRTc+pUF4EG2metFyJtDcipHQxQCnDHgvkw2JX
	 HfhSbRrMXbsMtxLraSBhqvRPZjnLfRINuJimkZoPqNrs3rbR0xufSxvI1DoqJL6k5Iz82
	 XqvmXwikOnxmo7Dv1HDCml+z+n3o8NzKUbn86maVgJ6Xyovgk+m3DI9klBBib+t+9rcKZ
	 jG/AXBEbQ6LNUSkK8QzwSDne0eK/rZAt5WMnAr/Q0efaZTwED+tPyYuFQXAsdqdUwxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=rCRivMKW;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F5606A31C;
	Thu, 26 Nov 2026 18:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=rCRivMKW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lNoDcgtyIRtshKKQA77hdTnKAgEL8asv9kuIbWA+WPc=; b=rCRivMKWHsAiaN8JRlhI3+jK8V
	+T0Sca7uBnOGSjoNNgOIu0W/geC6OsBdDDKHdzjRIcHhNB5bzFnkkOsNVQXeN2IPAGJ8hWqRGNud1
	xB8l50rPqNOIrVlfnsBMeXw7ADQb9DDVc9h0iN+TWHrU3Tvk4rO9wReixGol+gBuRHEV7N9zkX2pG
	TgapIprlCIPmlc11tAhkkZwRC6D+vvG5pFVy98gkr0VgvMT3hVRWRrmsGVmi+DmWl22Ab7Mh2/6rM
	5c8QEQcK+s55noA2BmBwI3gc8CBlWaXq/akpEkUsUqOiyP6l82caF79JOtrR49T/1NR8v2hmHqgpq
	LLLLjTVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWeJB-0000000A55i-2Zkw;
	Thu, 26 Nov 2026 18:35:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F22E302186; Thu, 26 Nov 2026 19:34:53 +0100 (CET)
Date: Thu, 26 Nov 2026 19:34:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hongyan Xia <hongyan.xia@transsion.com>, Song Liu <song@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] sched/preempt: Check notrace preempt-count updates
Message-ID: <20261126183453.GM49833@noisy.programming.kicks-ass.net>
References: <cover.1795631277.git.kmehltretter@gmail.com>
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
In-Reply-To: <cover.1795631277.git.kmehltretter@gmail.com>

On Thu, Nov 26, 2026 at 03:30:51AM +0100, Karl Mehltretter wrote:

> Hongyan Xia (1):
>   arm64: Always inline raw preempt count updates
> 
> Karl Mehltretter (2):
>   arm64: Always inline preempt count and reschedule checks
>   sched/preempt: Check preempt counts in notrace helpers
> 
>  arch/arm64/include/asm/preempt.h | 10 ++++----
>  include/linux/preempt.h          | 23 +++++++++++++-----
>  kernel/sched/core.c              | 40 ++++++++++++++++++++++++++++----
>  kernel/trace/Kconfig             |  1 +
>  4 files changed, 59 insertions(+), 15 deletions(-)

A quick reading doesn't show anything weird; I'll sit on them a while --
at the very least until I get an ACK from an ARM64 person ;-)
