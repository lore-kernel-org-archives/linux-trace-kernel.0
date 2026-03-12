Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE7734F481
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335970; cv=none; b=LItUj7R+gsd3vijLYABvyX3LOuEWz5Mrz85hOp77yBZXz+58hzMW+lHv58G1+PTF0xvtFHs0HFYQIwEV1PW5oi4SNCbIJsrxMys+deZhBGfPjXqjEHNeYYJDAdqj1X6Nfns+8REraRP5XBw9TrgvY85w2rfSuYg4ThaqTuAZz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335970; c=relaxed/simple;
	bh=0QaE6+eARLJliTc2HYtdCFEvfBfs4s8yC9Rpe6RkxzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T9waL3pChRoqwADl95B5zZX2jn3sFzQ0eijPMAsjAP2SCjYjKAZe45oiwYri0drcLFBpp2A4PFh7YAGFNqtz4O6biJa3e0dHkIrsvDQ9YmzLhvMCytB26ZZOebcJEnG1DT0wQXX1Mpf7RWPMuJwIv9Wpxa3oPh07MzJvxffH3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kaq1fkca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kaq1fkca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773335968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rClnSez6Rd2Uvv6Rbu/vDMRHH/ocJVNEShhCFEl9Uew=;
	b=Kaq1fkcamM+QywUVURiRVGqb81EkvtiQ7/uIHEWedYXWDkZDaEOgejNPmxPbK7DNUUWAdz
	ntaQUrDuwUK+ChVei2B6jveLvhDMm7AGscvrYmFkaI+wg6p7u7wQE5gjUG+bkvcG+1EJod
	C1eauvffeHMqqNZH5fM5LPY5La13zBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-KL_PIp-gMo2IPduoGaW5og-1; Thu,
 12 Mar 2026 13:19:25 -0400
X-MC-Unique: KL_PIp-gMo2IPduoGaW5og-1
X-Mimecast-MFC-AGG-ID: KL_PIp-gMo2IPduoGaW5og_1773335963
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABF5E1800372;
	Thu, 12 Mar 2026 17:19:22 +0000 (UTC)
Received: from fedora (unknown [10.22.64.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2A09630002DA;
	Thu, 12 Mar 2026 17:19:16 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:19:15 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <abLzS0T_wEt_SkL6@fedora>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-2-wander@redhat.com>
 <20260311193503.GS606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311193503.GS606826@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: mvwIVsb00e4xPT_j7wiDAWkydssI3JChlkZvAp4KBlQ_1773335963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 08:35:03PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 09:50:15AM -0300, Wander Lairson Costa wrote:
> 
> > +extern void __trace_preempt_on(void);
> > +extern void __trace_preempt_off(void);
> > +
> > +DECLARE_TRACEPOINT(preempt_enable);
> > +DECLARE_TRACEPOINT(preempt_disable);
> > +
> > +#define __preempt_trace_enabled(type, val) \
> > +	(tracepoint_enabled(preempt_##type) && preempt_count() == (val))
> > +
> > +static __always_inline void preempt_count_add(int val)
> > +{
> > +	__preempt_count_add(val);
> > +
> > +	if (__preempt_trace_enabled(disable, val))
> > +		__trace_preempt_off();
> > +}
> > +
> > +static __always_inline void preempt_count_sub(int val)
> > +{
> > +	if (__preempt_trace_enabled(enable, val))
> > +		__trace_preempt_on();
> > +
> > +	__preempt_count_sub(val);
> > +}
> >  #else
> >  #define preempt_count_add(val)	__preempt_count_add(val)
> >  #define preempt_count_sub(val)	__preempt_count_sub(val)
> >  #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
> >  #endif
> >  
> > +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
> > +#define preempt_count_dec_and_test() \
> > +	({ preempt_count_sub(1); should_resched(0); })
> > +#endif
> 
> Why!?!
> 
> Why can't you simply have:
> 
> static __always_inline bool preempt_count_dec_and_test(void)
> {
> 	if (__preempt_trace_enabled(enable, 1))
> 		__trace_preempt_on();
> 
> 	return __preempt_count_dec_and_test();
> }

Indeed it improved the generated code. Thanks a lot.

> 
> Also, given how !x86 architectures were just complaining about how
> terrible their preempt_emable() is, I'm really not liking this much at
> all.
> 

I will look deeper in arm64 and riscv generated code. If there are other
specific architectures that concerns you, please let me know.

> Currently the x86 preempt_disable() is _1_ instruction and
> preempt_enable() is all of 3. Adding in these tracepoints will bloat
> every single such site by at least another 4-5.
> 

Yes, there is a tradeoff. As I said before, I am looking at the hot path
(tracepoint no activated). Furthermore, when CONFIG_TRACE_PREEMPT_TOGGLE
and CONFIG_TRACE_IRQFLAGS_TOGGLE are off (default config), the code
generated is the same, byte by byte, of the stock kernel.

> That's significant bloat, for really very little gain. Realistically
> nobody is going to need these.
> 

Of course, I can't speak for others, but more than once I debugged issues
that those tracepoints had made my life far easier. Those cases convinced
me that such a feature would be worth it. But if you don't see
value and will reject the patches no matter what, nothing can be done,
and I will have to accept defeat.

