Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743E4A1390
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708704; cv=none; b=QUyXHVba8OWiPafeyKZW9KwFW9CHNPrpXZkzq3jDHRe5KT7xLih2jMr+nGyAwgV/aTk28LMR0IEddLL2+uFX//hA0ismslDT+27dEpmPLIQzhyNEbFF58VeoSa1B5Gr7jmtRkMuH/jyEXn3CW/FRBe+vTB4z7/+XjfApk3wz6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708704; c=relaxed/simple;
	bh=84BDj62CIaOOrEjqzUOeBvGJQLs5Ycp61LQxrLCDm3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2gJkhHH8T1mcFClvknfBzCdevACyOp5tfKSumFXyqqZ6Ftobcz5mG1X7oxwja8CkLxY9RO5yC5TA+4C32ycgS+/6WP2QfY5LVoLmxHJpve0bTE1QQR9jqXli93wzsbgJg3t8DXEVXHjVMQ2qmWr8nIkZ8KuLUrjnBYkftZ5+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WOme3iZk; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WOme3iZk"
Date: Wed, 17 Jun 2026 08:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781708690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbMKVIg1ugQqoGUC2QorVo8Wp1VDG1veyx0si63uoJ8=;
	b=WOme3iZkjUstaFqsR8e6YxV33RE+tvJbmRG1dpljlqB6A5YYNHRMCwbcBkoSFlTB09aSpx
	1xBF1TWLDlHCOuNbPGqY0IUI8kKBcsZWGQ4X9q+Bth+V+yf6nv2NcW16PSjDKtJlpQLce3
	P4vtaBa/qoHNwZCasMMHzt9mdM2ZR8M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: JP Kobryn <jp.kobryn@linux.dev>, linux-mm@kvack.org, 
	willy@infradead.org, usama.arif@linux.dev, akpm@linux-foundation.org, 
	vbabka@kernel.org, mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, chrisl@kernel.org, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
Message-ID: <ajK1YsIJmD2ImbAk@linux.dev>
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
 <06122cae-e28b-4ded-a9dd-d380d31c5230@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06122cae-e28b-4ded-a9dd-d380d31c5230@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 17, 2026 at 01:11:16PM +0200, David Hildenbrand (Arm) wrote:
> On 6/10/26 21:52, JP Kobryn wrote:
> > LRU add batches can be drained before they reach capacity. This can be a
> > source of LRU lock contention, but it is not currently possible to
> > attribute these drains to callers with existing tracepoints.
> > 
> > Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> > lru_add batch is drained. This allows tracing to distinguish full drains
> > from partial drains and attribute them to the calling stack.
> > 
> > Add mm_lru_add_drain_all to capture callers of __lru_add_drain_all and
> > whether they set the force flag for all CPUs. The tracepoint resembles
> > the signature of the enclosing function, but is needed because of
> > potential inlining.
> > 
> > Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> > ---
> >  include/trace/events/pagemap.h | 37 ++++++++++++++++++++++++++++++++++
> >  mm/swap.c                      |  7 ++++++-
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
> > index 171524d3526d..ff3da07ccb40 100644
> > --- a/include/trace/events/pagemap.h
> > +++ b/include/trace/events/pagemap.h
> > @@ -77,6 +77,43 @@ TRACE_EVENT(mm_lru_activate,
> >  	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
> >  );
> >  
> > +TRACE_EVENT(mm_lru_add_drain,
> > +
> > +	TP_PROTO(int cpu, unsigned int nr),
> > +
> > +	TP_ARGS(cpu, nr),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int,		cpu	)
> > +		__field(unsigned int,	nr	)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->cpu	= cpu;
> > +		__entry->nr	= nr;
> > +	),
> > +
> > +	TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
> > +);
> > +
> > +TRACE_EVENT(mm_lru_add_drain_all,
> > +
> > +	TP_PROTO(bool force_all_cpus),
> > +
> > +	TP_ARGS(force_all_cpus),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(bool,	force_all_cpus	)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->force_all_cpus	= force_all_cpus;
> > +	),
> > +
> > +	TP_printk("force_all_cpus=%s",
> > +		__entry->force_all_cpus ? "true" : "false")
> > +);
> > +
> >  #endif /* _TRACE_PAGEMAP_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 588f50d8f1a8..e14b7612f896 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
> >  {
> >  	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
> >  	struct folio_batch *fbatch = &fbatches->lru_add;
> > +	unsigned int nr_folios_add = folio_batch_count(fbatch);
> >  
> > -	if (folio_batch_count(fbatch))
> > +	if (nr_folios_add) {
> >  		folio_batch_move_lru(fbatch, lru_add);
> > +		trace_mm_lru_add_drain(cpu, nr_folios_add);
> > +	}
> >  
> >  	fbatch = &fbatches->lru_move_tail;
> >  	/* Disabling interrupts below acts as a compiler barrier. */
> > @@ -869,6 +872,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
> >  	if (WARN_ON(!mm_percpu_wq))
> >  		return;
> >  
> > +	trace_mm_lru_add_drain_all(force_all_cpus);
> > +
> >  	/*
> >  	 * Guarantee folio_batch counter stores visible by this CPU
> >  	 * are visible to other CPUs before loading the current drain
> 
> Given that trace events can quickly become stable ABI [1], are we really sure we
> want to add this?

Yes, I think so as this is useful to get insights into lru cache draining.
Trace events being stable or not is secondary IMHO. If in future we rearchitect
the lru page handling where there is no cache draining anymore, we can make
these a noops.

> 
> [1] https://lore.kernel.org/r/20260603130006.7d2c4a62@gandalf.local.home
> 
> -- 
> Cheers,
> 
> David
