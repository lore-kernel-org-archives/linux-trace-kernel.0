Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03403002D1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119391; cv=none; b=FdGtzsSXZiu2lfwgxIDPrHB+GZm4T3nTJA72BgPtDyVqkoD/Ze4/awHsG0zOjYiS/MB7UksEGqx7d4kqZMuX5GIs4yz4i53SoIlsmW5jhujLFbIRFAgrn5mQKkkc87Bn0jpWaalMiS8MPk0oeJ5Uyz++opTzrWTSzItTR6xGfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119391; c=relaxed/simple;
	bh=NJewdxZvpJ4YYH3dhp3E3gyPK09zc/gdxzJ1PEAjB8I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QT/31ROp0YytGgyT3N6SEbErsjqNUZxETZup6zgAGH3drek8GmqbgLfZSxaEMBaDJRqgR9cw3Kc0chT/+zT+MqunKmR5be1x92vBkJD8HRCYjoU0u671KN0uFQHZGdYIM9zy5bE7WEfVRT3Jgb4Butwz1pVBpey/QVfB5iHTfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9HpL/4+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9HpL/4+"
Message-ID: <ffdf9b07-487b-4668-a91b-27b0ab29c70d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781119226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWcyqlFHr5mEY42mMiFua4E/gMz+s/X2vILeDjuLg30=;
	b=J9HpL/4+E3jEKvbtYmDAMJUgYViuJPtNed4QFKKvOa1p4lg+r7fS6BGHUGAvB3m36bE+ek
	V92qDCwWhQGhPfkq24rX/i31U5boavRKK4AoX2zXj34jzt5/6YVceXVs1yx1iHuYldBGzh
	yu5+6uON6ZndR5c6kTbmdfg3aeshNZI=
Date: Wed, 10 Jun 2026 12:20:19 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Barry Song <baohua@kernel.org>, linux-mm@kvack.org, willy@infradead.org,
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
 <d676cf78-4b0a-4d6b-b322-f64826aaca75@linux.dev> <aii7WWFmAyoXn9rk@linux.dev>
 <6e7739cc-327e-4ca9-86f4-17729b624632@linux.dev>
Content-Language: en-US
In-Reply-To: <6e7739cc-327e-4ca9-86f4-17729b624632@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 11:54 AM, JP Kobryn wrote:
> On 6/9/26 6:21 PM, Shakeel Butt wrote:
>> On Tue, Jun 09, 2026 at 05:16:15PM -0700, JP Kobryn wrote:
>>> On 6/9/26 5:07 PM, JP Kobryn wrote:
>>>> On 6/9/26 12:44 AM, Barry Song wrote:
>>>>> On Tue, Jun 9, 2026 at 12:12 PM JP Kobryn <jp.kobryn@linux.dev> wrote:
>>>>>>
>>>>>> LRU add batches can be drained before they reach capacity. This can be a
>>>>>> source of LRU lock contention, but it is not currently possible to
>>>>>> attribute these drains to callers with existing tracepoints.
>>>>>>
>>>>>> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
>>>>>> lru_add batch is drained. This allows tracing to distinguish full drains
>>>>>> from partial drains and attribute them to the calling stack.
>>>>>>
>>>>>> Add mm_lru_drain_all_queue to report when lru_add_drain_all() queues
>>>>>> per-CPU drain work. This captures the requester stack and target CPU for
>>>>>> remote drain work. The event is named as a drain-all queue event because
>>>>>> the queued work can be needed for batches other than lru_add.
>>>>>>
>>>>>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
>>>>>> ---
>>>>>>  include/trace/events/pagemap.h | 40 ++++++++++++++++++++++++++++++++++
>>>>>>  mm/swap.c                      |  6 ++++-
>>>>>>  2 files changed, 45 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
>>>>>> index 171524d3526d..ea8fc46bedb0 100644
>>>>>> --- a/include/trace/events/pagemap.h
>>>>>> +++ b/include/trace/events/pagemap.h
>>>>>> @@ -77,6 +77,46 @@ TRACE_EVENT(mm_lru_activate,
>>>>>>         TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
>>>>>>  );
>>>>>>
>>>>>> +TRACE_EVENT(mm_lru_add_drain,
>>>>>> +
>>>>>> +       TP_PROTO(int cpu, unsigned int nr),
>>>>>> +
>>>>>> +       TP_ARGS(cpu, nr),
>>>>>> +
>>>>>> +       TP_STRUCT__entry(
>>>>>> +               __field(int,            cpu     )
>>>>>> +               __field(unsigned int,   nr      )
>>>>>> +       ),
>>>>>> +
>>>>>> +       TP_fast_assign(
>>>>>> +               __entry->cpu    = cpu;
>>>>>> +               __entry->nr     = nr;
>>>>>> +       ),
>>>>>> +
>>>>>> +       TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
>>>>>> +);
>>>>>> +
>>>>>> +TRACE_EVENT(mm_lru_drain_all_queue,
>>>>>> +
>>>>>> +       TP_PROTO(int target_cpu, bool force_all_cpus),
>>>>>> +
>>>>>> +       TP_ARGS(target_cpu, force_all_cpus),
>>>>>> +
>>>>>> +       TP_STRUCT__entry(
>>>>>> +               __field(int,    target_cpu      )
>>>>>> +               __field(bool,   force_all_cpus  )
>>>>>> +       ),
>>>>>> +
>>>>>> +       TP_fast_assign(
>>>>>> +               __entry->target_cpu     = target_cpu;
>>>>>> +               __entry->force_all_cpus = force_all_cpus;
>>>>>> +       ),
>>>>>> +
>>>>>> +       TP_printk("target_cpu=%d force_all_cpus=%s",
>>>>>> +               __entry->target_cpu,
>>>>>> +               __entry->force_all_cpus ? "true" : "false")
>>>>>> +);
>>>>>> +
>>>>>>  #endif /* _TRACE_PAGEMAP_H */
>>>>>>
>>>>>>  /* This part must be outside protection */
>>>>>> diff --git a/mm/swap.c b/mm/swap.c
>>>>>> index 588f50d8f1a8..c385b93582eb 100644
>>>>>> --- a/mm/swap.c
>>>>>> +++ b/mm/swap.c
>>>>>> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
>>>>>>  {
>>>>>>         struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
>>>>>>         struct folio_batch *fbatch = &fbatches->lru_add;
>>>>>> +       unsigned int nr_folios_add = folio_batch_count(fbatch);
>>>>>>
>>>>>> -       if (folio_batch_count(fbatch))
>>>>>> +       if (nr_folios_add) {
>>>>>>                 folio_batch_move_lru(fbatch, lru_add);
>>>>>> +               trace_mm_lru_add_drain(cpu, nr_folios_add);
>>>>>> +       }
>>>>>>
>>>>>>         fbatch = &fbatches->lru_move_tail;
>>>>>>         /* Disabling interrupts below acts as a compiler barrier. */
>>>>>> @@ -928,6 +931,7 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
>>>>>>                 if (cpu_needs_drain(cpu)) {
>>>>>>                         INIT_WORK(work, lru_add_drain_per_cpu);
>>>>>>                         queue_work_on(cpu, mm_percpu_wq, work);
>>>>>> +                       trace_mm_lru_drain_all_queue(cpu, force_all_cpus);
>>>>>
>>>>> Do you need tracing on each CPU individually, or is tracing the
>>>>> entire __lru_add_drain_all() invocation sufficient?
>>>>
>>>> I think the latter would be fine. The remote work will invoke the
>>>> mm_lru_add_drain tracepoint, which will show up as kworker stacks. Since
>>>> the event already has the CPU, we could see where queued drains actually
>>>> ran.
>>>
>>> Actually if it's just a single invocation and the only event data is the
>>> force flag, a tracepoint may not even be needed. Other probes can be
>>> installed on function invocation and read the single argument. I can
>>> drop this from v2 and keep the single mm_lru_add_drain tracepoint.
>>
>> No we do want to trace the callers requesting to drain from all the CPUs. If you
>> trace just lru_add_drain_cpu() then you will only see that the drain is
>> requested for a given CPU but no information on the requester. 
>>
>> Also as Barry said, I think single trace for whole __lru_add_drain_all() is good
>> enough.
> 
> Right, but couldn't that already be done with fentry or kprobe? If we
> only need the calling stack and the argument value of force_all_cpus I
> don't see a strong need for a dedicated tracepoint.

Nevermind that. I see it's declared inline so I'll add a tracepoint and
send v3.

