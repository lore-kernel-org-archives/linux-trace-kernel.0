Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBB40D573
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050590; cv=none; b=nMZkNEKDpWMW7G8rg37K4YFupiVl0vs/iNMxJ1B8qyCMbr0pJ/24svTUGj8UEFKIGeIuh5QhL+9mcdUfigA6ZLDfCMn79p9ljqveTV+OZsUa7RunZDa1h8dMc/PNsIOOPc4tjegtEjilIPqSglafowG8R99jM+y4U8B5hCU4IYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050590; c=relaxed/simple;
	bh=1qEhKH8eLIpNJfBM7HtfGzPi9tRD6Z9NlG2W7FylMA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=joobVyY+84VBZlqFKLTPRfEuaYSKtWGT547nTy4g06+UHKsMRDOyr8Nu9pDd/FQfRazM9HkIrpAPjRK7/IiIRZssGrn6j2g3e6hy00JCt93ogSu+d+njrnsS7qrhMa/6B7lAnaSJsDiWq+JGi+9EalS4nbmI1wIurrOd3jFWFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N9AMYlrX; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N9AMYlrX"
Message-ID: <d676cf78-4b0a-4d6b-b322-f64826aaca75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781050586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzAEXk5KPclAfgMQutz0DumixpunNsLKg76V7zToonI=;
	b=N9AMYlrXIzwyumzQyTktM8h0i2p/fp9gGlSYYjTuCcWTo0CU4e3r5Tz0uYM9RIo4S+s1oI
	GlvvisRrUGs11EEmukx64OEAofPGvmS6m2gNCdWqQnpAtVS41aHrLJo6/PjatMbFct5p+a
	tVN1NPWTWUFVqj0vu+4gkubpRzuFVMw=
Date: Tue, 9 Jun 2026 17:16:15 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, willy@infradead.org, shakeel.butt@linux.dev,
 usama.arif@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org,
 mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260609041156.31127-1-jp.kobryn@linux.dev>
 <CAGsJ_4xk2Q3xTkQYMPb7rnvnvVsjp24uXRcOja5RxqSbQpdoEg@mail.gmail.com>
 <3e55e520-b979-4b1c-874c-3b4e5ca629e2@linux.dev>
Content-Language: en-US
In-Reply-To: <3e55e520-b979-4b1c-874c-3b4e5ca629e2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/9/26 5:07 PM, JP Kobryn wrote:
> On 6/9/26 12:44 AM, Barry Song wrote:
>> On Tue, Jun 9, 2026 at 12:12 PM JP Kobryn <jp.kobryn@linux.dev> wrote:
>>>
>>> LRU add batches can be drained before they reach capacity. This can be a
>>> source of LRU lock contention, but it is not currently possible to
>>> attribute these drains to callers with existing tracepoints.
>>>
>>> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
>>> lru_add batch is drained. This allows tracing to distinguish full drains
>>> from partial drains and attribute them to the calling stack.
>>>
>>> Add mm_lru_drain_all_queue to report when lru_add_drain_all() queues
>>> per-CPU drain work. This captures the requester stack and target CPU for
>>> remote drain work. The event is named as a drain-all queue event because
>>> the queued work can be needed for batches other than lru_add.
>>>
>>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
>>> ---
>>>  include/trace/events/pagemap.h | 40 ++++++++++++++++++++++++++++++++++
>>>  mm/swap.c                      |  6 ++++-
>>>  2 files changed, 45 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
>>> index 171524d3526d..ea8fc46bedb0 100644
>>> --- a/include/trace/events/pagemap.h
>>> +++ b/include/trace/events/pagemap.h
>>> @@ -77,6 +77,46 @@ TRACE_EVENT(mm_lru_activate,
>>>         TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
>>>  );
>>>
>>> +TRACE_EVENT(mm_lru_add_drain,
>>> +
>>> +       TP_PROTO(int cpu, unsigned int nr),
>>> +
>>> +       TP_ARGS(cpu, nr),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(int,            cpu     )
>>> +               __field(unsigned int,   nr      )
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->cpu    = cpu;
>>> +               __entry->nr     = nr;
>>> +       ),
>>> +
>>> +       TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
>>> +);
>>> +
>>> +TRACE_EVENT(mm_lru_drain_all_queue,
>>> +
>>> +       TP_PROTO(int target_cpu, bool force_all_cpus),
>>> +
>>> +       TP_ARGS(target_cpu, force_all_cpus),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(int,    target_cpu      )
>>> +               __field(bool,   force_all_cpus  )
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->target_cpu     = target_cpu;
>>> +               __entry->force_all_cpus = force_all_cpus;
>>> +       ),
>>> +
>>> +       TP_printk("target_cpu=%d force_all_cpus=%s",
>>> +               __entry->target_cpu,
>>> +               __entry->force_all_cpus ? "true" : "false")
>>> +);
>>> +
>>>  #endif /* _TRACE_PAGEMAP_H */
>>>
>>>  /* This part must be outside protection */
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index 588f50d8f1a8..c385b93582eb 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
>>>  {
>>>         struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
>>>         struct folio_batch *fbatch = &fbatches->lru_add;
>>> +       unsigned int nr_folios_add = folio_batch_count(fbatch);
>>>
>>> -       if (folio_batch_count(fbatch))
>>> +       if (nr_folios_add) {
>>>                 folio_batch_move_lru(fbatch, lru_add);
>>> +               trace_mm_lru_add_drain(cpu, nr_folios_add);
>>> +       }
>>>
>>>         fbatch = &fbatches->lru_move_tail;
>>>         /* Disabling interrupts below acts as a compiler barrier. */
>>> @@ -928,6 +931,7 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
>>>                 if (cpu_needs_drain(cpu)) {
>>>                         INIT_WORK(work, lru_add_drain_per_cpu);
>>>                         queue_work_on(cpu, mm_percpu_wq, work);
>>> +                       trace_mm_lru_drain_all_queue(cpu, force_all_cpus);
>>
>> Do you need tracing on each CPU individually, or is tracing the
>> entire __lru_add_drain_all() invocation sufficient?
> 
> I think the latter would be fine. The remote work will invoke the
> mm_lru_add_drain tracepoint, which will show up as kworker stacks. Since
> the event already has the CPU, we could see where queued drains actually
> ran.

Actually if it's just a single invocation and the only event data is the
force flag, a tracepoint may not even be needed. Other probes can be
installed on function invocation and read the single argument. I can
drop this from v2 and keep the single mm_lru_add_drain tracepoint.
