Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0B1A0BD0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054487; cv=none; b=STgEoTA/3N0qFXv3dMOblrw5NsIbuZ4pmGKTGFwWc0A7hV2KV3YEkYb1f5ykHyiV7GS8whpu5XbMEji/VzLERVWV4O0xKRDp/ylaZdLssg2sXwMoNNpQOVaHtDX2esupekFHm4J+d6P3BMB0D04HUfnVUYBioi9pa8iMF1K6n8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054487; c=relaxed/simple;
	bh=LFSsSIVwO0hYIW+25OIBD3VzbBk6Il5TWPT5Q3MoOQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSBIRY5iQGQ/S6QC/uFBPXxuJTbDmSDAO5EiRiEf+FzuUJVq574+PI53xl4Urc+VgKOml9dvAn/oCciroEBJR59Pdw16XC9pIsVY7Vb1wN5wX5dC++lsNed6JASY4gXWLIcRns26SE+V5OFHNBJUB6y+EsHji5H1AcywDME2g0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lx5n6/+d; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lx5n6/+d"
Date: Tue, 9 Jun 2026 18:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781054473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azd4gYJ8VwEn2xnFPZe1dtA7NyI9LqyXIAgOAuiZywE=;
	b=Lx5n6/+dbX6TSJvF8ziNSZj3YhshjgeYfUcQDJVS9dPCZZfET22G20+Pf/vqtgLrj9wPs5
	0YuheS0EQbx5JuKl5MpexDUnIWhLeb+pYnVWSVyVsa5IvT70EfyAvWwAYUmhIFjm4c2ZkT
	oIx9CMq63WH0TFjWB4/fgIf0qyWSzk8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	willy@infradead.org, usama.arif@linux.dev, akpm@linux-foundation.org, 
	vbabka@kernel.org, mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chrisl@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
Message-ID: <aii7WWFmAyoXn9rk@linux.dev>
References: <20260609041156.31127-1-jp.kobryn@linux.dev>
 <CAGsJ_4xk2Q3xTkQYMPb7rnvnvVsjp24uXRcOja5RxqSbQpdoEg@mail.gmail.com>
 <3e55e520-b979-4b1c-874c-3b4e5ca629e2@linux.dev>
 <d676cf78-4b0a-4d6b-b322-f64826aaca75@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d676cf78-4b0a-4d6b-b322-f64826aaca75@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 09, 2026 at 05:16:15PM -0700, JP Kobryn wrote:
> On 6/9/26 5:07 PM, JP Kobryn wrote:
> > On 6/9/26 12:44 AM, Barry Song wrote:
> >> On Tue, Jun 9, 2026 at 12:12 PM JP Kobryn <jp.kobryn@linux.dev> wrote:
> >>>
> >>> LRU add batches can be drained before they reach capacity. This can be a
> >>> source of LRU lock contention, but it is not currently possible to
> >>> attribute these drains to callers with existing tracepoints.
> >>>
> >>> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> >>> lru_add batch is drained. This allows tracing to distinguish full drains
> >>> from partial drains and attribute them to the calling stack.
> >>>
> >>> Add mm_lru_drain_all_queue to report when lru_add_drain_all() queues
> >>> per-CPU drain work. This captures the requester stack and target CPU for
> >>> remote drain work. The event is named as a drain-all queue event because
> >>> the queued work can be needed for batches other than lru_add.
> >>>
> >>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> >>> ---
> >>>  include/trace/events/pagemap.h | 40 ++++++++++++++++++++++++++++++++++
> >>>  mm/swap.c                      |  6 ++++-
> >>>  2 files changed, 45 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
> >>> index 171524d3526d..ea8fc46bedb0 100644
> >>> --- a/include/trace/events/pagemap.h
> >>> +++ b/include/trace/events/pagemap.h
> >>> @@ -77,6 +77,46 @@ TRACE_EVENT(mm_lru_activate,
> >>>         TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
> >>>  );
> >>>
> >>> +TRACE_EVENT(mm_lru_add_drain,
> >>> +
> >>> +       TP_PROTO(int cpu, unsigned int nr),
> >>> +
> >>> +       TP_ARGS(cpu, nr),
> >>> +
> >>> +       TP_STRUCT__entry(
> >>> +               __field(int,            cpu     )
> >>> +               __field(unsigned int,   nr      )
> >>> +       ),
> >>> +
> >>> +       TP_fast_assign(
> >>> +               __entry->cpu    = cpu;
> >>> +               __entry->nr     = nr;
> >>> +       ),
> >>> +
> >>> +       TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
> >>> +);
> >>> +
> >>> +TRACE_EVENT(mm_lru_drain_all_queue,
> >>> +
> >>> +       TP_PROTO(int target_cpu, bool force_all_cpus),
> >>> +
> >>> +       TP_ARGS(target_cpu, force_all_cpus),
> >>> +
> >>> +       TP_STRUCT__entry(
> >>> +               __field(int,    target_cpu      )
> >>> +               __field(bool,   force_all_cpus  )
> >>> +       ),
> >>> +
> >>> +       TP_fast_assign(
> >>> +               __entry->target_cpu     = target_cpu;
> >>> +               __entry->force_all_cpus = force_all_cpus;
> >>> +       ),
> >>> +
> >>> +       TP_printk("target_cpu=%d force_all_cpus=%s",
> >>> +               __entry->target_cpu,
> >>> +               __entry->force_all_cpus ? "true" : "false")
> >>> +);
> >>> +
> >>>  #endif /* _TRACE_PAGEMAP_H */
> >>>
> >>>  /* This part must be outside protection */
> >>> diff --git a/mm/swap.c b/mm/swap.c
> >>> index 588f50d8f1a8..c385b93582eb 100644
> >>> --- a/mm/swap.c
> >>> +++ b/mm/swap.c
> >>> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
> >>>  {
> >>>         struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
> >>>         struct folio_batch *fbatch = &fbatches->lru_add;
> >>> +       unsigned int nr_folios_add = folio_batch_count(fbatch);
> >>>
> >>> -       if (folio_batch_count(fbatch))
> >>> +       if (nr_folios_add) {
> >>>                 folio_batch_move_lru(fbatch, lru_add);
> >>> +               trace_mm_lru_add_drain(cpu, nr_folios_add);
> >>> +       }
> >>>
> >>>         fbatch = &fbatches->lru_move_tail;
> >>>         /* Disabling interrupts below acts as a compiler barrier. */
> >>> @@ -928,6 +931,7 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
> >>>                 if (cpu_needs_drain(cpu)) {
> >>>                         INIT_WORK(work, lru_add_drain_per_cpu);
> >>>                         queue_work_on(cpu, mm_percpu_wq, work);
> >>> +                       trace_mm_lru_drain_all_queue(cpu, force_all_cpus);
> >>
> >> Do you need tracing on each CPU individually, or is tracing the
> >> entire __lru_add_drain_all() invocation sufficient?
> > 
> > I think the latter would be fine. The remote work will invoke the
> > mm_lru_add_drain tracepoint, which will show up as kworker stacks. Since
> > the event already has the CPU, we could see where queued drains actually
> > ran.
> 
> Actually if it's just a single invocation and the only event data is the
> force flag, a tracepoint may not even be needed. Other probes can be
> installed on function invocation and read the single argument. I can
> drop this from v2 and keep the single mm_lru_add_drain tracepoint.

No we do want to trace the callers requesting to drain from all the CPUs. If you
trace just lru_add_drain_cpu() then you will only see that the drain is
requested for a given CPU but no information on the requester. 

Also as Barry said, I think single trace for whole __lru_add_drain_all() is good
enough.
