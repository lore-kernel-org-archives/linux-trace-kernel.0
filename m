Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0240F721
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376686; cv=none; b=VS1NMyjAP741aDt/PhicbPWp04Hh7ja4H0S5A2DQvN59LHJmrQkks2LlkA7RVXIzcA4itlh2VWRjgR0Is4NQ9Hf0zx7JjQkZT2RY4LQDqHUxWFkIiybWjpSbFxg2IDy20qtdwsEIeqP9VIXZschYYzBGL9nHdBJ2B/8pHBK8L9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376686; c=relaxed/simple;
	bh=cyHRGG1jP0E/7LSzChuUoiK/6HUy6jQ8rWqx8S/GEFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnSG8FocnNhCh3iAKP/rX2h6S4XUXBSTRW4CftBM84AP3mldRQrNmjxKRrhSFLkbyyJzAFe5n5zXLDzsCr++hVm5/E150DZup3/DA3/z1Wgjl+5w2FE4jd5dYWbNvIoMNp7kOvW8F54ieoXdPVyNa4+mn22LvkFRuzE/iqeQTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BEteMCVW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BEteMCVW"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cyHRGG1jP0E/7LSzChuUoiK/6HUy6jQ8rWqx8S/GEFs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789376681; v=1; x=1789981481;
 b=BEteMCVWd56/AC6D47UbBT9CFGQwz7GFuTCbIKz1imFLAqkHq4Prq4ohtE3jTAuiyERyx9lC
 PX7NYxz15QZQzu2nIydA8HJ5wxSr10hFeioqB48B7SnAc4Wnv4Q7oipkYTew0L9bWmwcvZgFd72
 OfJCef3vgvbzAEMJWo/qygrE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b890552444941dff;
	Mon, 14 Sep 2026 09:04:40 +0000
X-Mizu-Trace-ID: b890552444941dff
X-Migadu-Flow: FLOW_OUT
Message-ID: <fb8d932f-2dd9-442d-b829-575acf8480f8@linux.dev>
Date: Mon, 14 Sep 2026 17:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-3-ridong.chen@linux.dev>
 <9c8c7c91-b159-4342-8af7-3a8171e85389@linux.alibaba.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <9c8c7c91-b159-4342-8af7-3a8171e85389@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/14/2026 3:47 PM, Baolin Wang wrote:
> 
> 
> On 9/11/26 6:29 PM, Ridong Chen wrote:
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> MGLRU's scan_folios() emits the classic-LRU tracepoint
>> trace_mm_vmscan_lru_isolate(), which predates MGLRU. It reports the
>> scan/isolate counts and the LRU type, but carries no generation or
>> memcg context, so a trace of an MGLRU run cannot tell which memcg a
>> given scan belongs to, nor how far reclaim has progressed through the
>> generations.
>>
>> Add mm_mglru_scan_folios next to it, reporting the same counters plus
>> nr_sorted (folios moved to a younger generation by sort_folio()) and
>> the MGLRU context the classic tracepoint lacks: the memcg id, and the
>> max_seq, tier and min_seq of the type being scanned.
>>
>> scan_folios() is the MGLRU-specific layer where folios are actually
>> scanned, so it has no classic-LRU counterpart. That the classic
>> trace_mm_vmscan_lru_isolate() has lived here stably shows this is a
>> long-lived place to hook, and the new tracepoint can be enabled on its
>> own to observe the MGLRU-specific information. The existing tracepoint
>> is left unchanged.
>>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
>> ---
>>   include/trace/events/vmscan.h | 63 +++++++++++++++++++++++++++++++++++
>>   mm/vmscan.c                   |  6 ++++
>>   2 files changed, 69 insertions(+)
>>
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>> index 8a872990b4be..5defa8f6719c 100644
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>           __print_symbolic(__entry->lru, LRU_NAMES))
>>   );
> 
> [snip]
> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2554a6513aa8..67f59aa73fb9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct 
>> lruvec *lruvec,
>>       trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>>                   scanned, skipped, isolated,
>>                   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>> +    trace_mm_mglru_scan_folios(lruvec,
>> +                   sc->reclaim_idx, sc->order, nr_to_scan,
>> +                   scanned, sorted, skipped, isolated,
>> +                   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
>> +                   lrugen->max_seq, tier,
>> +                   lrugen->min_seq[type]);
> 
> Both tracepoints will print some duplicated content, and I'm not sure it's worth 
> a new tracepoint just to trace max_seq and min_seq.
> 
> Anyway, I'm not against this patch, but I'd like to hear others' opinions.

Thank you for your review.

Since the lruvec is per memcg and per node, we would like to know how the memcg 
scans and reclaims its lruvec.

I am also concerned that the content may be duplicated where we place it here. 
However, with Barry's suggestion, it is stable here. What is more, the trace is 
under the control of the trace event gate. It is convenient to control and would 
not lead to any regression when they are disabled.

As my cover letter mentions, with the current trace events, we don't know when 
the per-memcg lruvec ages, when it is scanned and reclaimed, or with what 
seq(gen). With this series, we can tell the memcg aging and reclaim actions.

-- 
Best regards
Ridong

