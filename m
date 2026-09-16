Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F54A6CD9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561082; cv=none; b=jkUBFGecrfwcg4DzWBRkus642duF8kJ05acma0XFbvK2fm1bhc/edswrnBF6YR8RT29NTwxElqH4XRSPFDy7b6cJVZ+9z1RohzGvI7hOotQcP6O8HpxTGsksBh07KQCoShCYT5MdkMA7yEYSwRZ0XiNoUekM03s5gQiw1/8mML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561082; c=relaxed/simple;
	bh=sGhhbpRXCSZiqq9AwMFqiHAd8QFegqbJzta1OrqUPoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s29Oe82+3QzAW7kU+MqTpK6xhgd4t0seP5JR4uPBez5yvuLw/8a6ruRHA/H3E9g28ZNQm0+XEZn6xikqk782MrBBLlmuQ5owCn5yEvgCt7T1UAZ1sTzwMLneK2eebiJFWjBwkD1IA/QMuJzSj34bnFdl8stX+CR+BdGVZtRkIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c25CGZ/2; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c25CGZ/2"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sGhhbpRXCSZiqq9AwMFqiHAd8QFegqbJzta1OrqUPoA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789561077; v=1; x=1790165877;
 b=c25CGZ/2a9gYO97w3wlEuqufGxCY8YY1R3JrasXSSYkaa0SdoRigNjuXzpjNMzsGBSWDfCLD
 td81QVhFUYbWlcC17XsgF4Y3CLvOdYzNqZY2DvlH/B/4+lRcF9U4NjrD81QUMGvUUf5svLevtpe
 kG4nxik3htx6lDDlhA3UIuYU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6aeebd5c5ba43b2f;
	Wed, 16 Sep 2026 12:17:57 +0000
X-Mizu-Trace-ID: 6aeebd5c5ba43b2f
X-Migadu-Flow: FLOW_OUT
Message-ID: <ce8c2ebf-7eb4-4afc-a007-1cfcec439ede@linux.dev>
Date: Wed, 16 Sep 2026 20:17:50 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
To: Baoquan He <baoquan.he@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-3-ridong.chen@linux.dev> <aqkoeJvFzqpoGeaP@fedora>
 <e38f2b80-20f2-4787-9e07-fb601552f550@linux.dev> <aqn7h3BVCCRFI2TI@fedora>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <aqn7h3BVCCRFI2TI@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/2026 10:14 AM, Baoquan He wrote:
> On 09/15/26 at 08:17pm, Ridong Chen wrote:
>>
>>
>> On 9/15/2026 7:14 PM, Baoquan He wrote:
>>> On 09/11/26 at 06:29pm, Ridong Chen wrote:
>>>> From: Ridong Chen <chenridong@xiaomi.com>
>>> ...snip...
>>>> ---
>>>>    include/trace/events/vmscan.h | 63 +++++++++++++++++++++++++++++++++++
>>>>    mm/vmscan.c                   |  6 ++++
>>>>    2 files changed, 69 insertions(+)
>>>>
>>>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>>>> index 8a872990b4be..5defa8f6719c 100644
>>>> --- a/include/trace/events/vmscan.h
>>>> +++ b/include/trace/events/vmscan.h
>>>> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>>>    		__print_symbolic(__entry->lru, LRU_NAMES))
>>>>    );
>>>> +TRACE_EVENT(mm_mglru_scan_folios,
>>>> +
>>>> +	TP_PROTO(struct lruvec *lruvec,
>>>> +		int highest_zoneidx,
>>>> +		int order,
>>>> +		unsigned long nr_requested,
>>>> +		unsigned long nr_scanned,
>>>> +		unsigned long nr_sorted,
>>>> +		unsigned long nr_skipped,
>>>> +		unsigned long nr_taken,
>>>> +		int lru,
>>>> +		unsigned long max_seq,
>>>> +		int tier,
>>>> +		unsigned long min_seq),
>>>
>>
>> Thank you for your review.
>>
>>> Do we need show nid? Guess phone vendor doesn't care about multi-NUMA
>>> system.
>>>
>>
>> Eh, nid is not an mglru-specific key. Since there are 12 elements here, it
>> can't be added here.
> 
> Hmm, we print memcg_id but not nid, it may not be so clear. How do you
> differentiate several lruvec-s on one memcg? I am not very familiar with
> trace mechanism, do we have a element number limit?
> 

Yes, it will fail to compile if there are more than 12 elements.

With AI's help, see

include/trace/bpf_probe.h
```
30 #define __CAST1(a,...) __CAST_TO_U64(a)
  31 #define __CAST2(a,...) __CAST_TO_U64(a), __CAST1(__VA_ARGS__)
  32 #define __CAST3(a,...) __CAST_TO_U64(a), __CAST2(__VA_ARGS__)
  33 #define __CAST4(a,...) __CAST_TO_U64(a), __CAST3(__VA_ARGS__)
  34 #define __CAST5(a,...) __CAST_TO_U64(a), __CAST4(__VA_ARGS__)
  35 #define __CAST6(a,...) __CAST_TO_U64(a), __CAST5(__VA_ARGS__)
  36 #define __CAST7(a,...) __CAST_TO_U64(a), __CAST6(__VA_ARGS__)
  37 #define __CAST8(a,...) __CAST_TO_U64(a), __CAST7(__VA_ARGS__)
  38 #define __CAST9(a,...) __CAST_TO_U64(a), __CAST8(__VA_ARGS__)
  39 #define __CAST10(a,...) __CAST_TO_U64(a), __CAST9(__VA_ARGS__)
  40 #define __CAST11(a,...) __CAST_TO_U64(a), __CAST10(__VA_ARGS__)
  41 #define __CAST12(a,...) __CAST_TO_U64(a), __CAST11(__VA_ARGS__)
/* tracepoints with more than 12 arguments will hit build error */
```

> Imagine I only want to trace this function, now I can see memcg_id,
> zone_idex, while don't know node/lruvec, that's a little pitty. Just my
> personal opinion, I could miss anything.
> 

Yeah, you are right. In my personal experience, I always enable 
trace_mm_vmscan_lru_isolate and trace_mm_vmscan_lru_shrink_inactive, which 
contain node_id. So we can see how the lruvec is scanned and shrunk, and we can 
get node_id from trace_mm_vmscan_lru_shrink_inactive. I am not arguing that this 
is exactly the 'correct' way to use these tracepoints, but I think it is a 
common usage.

I am open to that. If we want to record node_id, we have to remove an element. 
Maybe tier? But I would strongly recommend record memcg_id, we frequently need 
to check the reclaim behavior of a memcg, and most of our scenarios are non-NUMA.

>>
>>
>>> And I checked v1 thread, seems Steven suggested to move the two int to
>>> avoid extra padding.
>>>
>>
>> Yeah, I will update it. I updated v2 to fix Sashiko's issue, before Steven
>> had any comment.
>>
>>
>>>> +
>>>> +	TP_ARGS(lruvec, highest_zoneidx, order, nr_requested, nr_scanned,
>>>> +		nr_sorted, nr_skipped, nr_taken, lru, max_seq, tier, min_seq),
>>>> +
>>>> +	TP_STRUCT__entry(
>>>> +		__field(u64, memcg_id)
>>>> +		__field(int, highest_zoneidx)
>>>> +		__field(int, order)
>>>> +		__field(unsigned long, nr_requested)
>>>> +		__field(unsigned long, nr_scanned)
>>>> +		__field(unsigned long, nr_sorted)
>>>> +		__field(unsigned long, nr_skipped)
>>>> +		__field(unsigned long, nr_taken)
>>>> +		__field(int, lru)
>>>> +		__field(unsigned long, max_seq)
>>>> +		__field(int, tier)
>>>> +		__field(unsigned long, min_seq)
>>>> +	),
>>>> +
>>>> +	TP_fast_assign(
>>>> +		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
>>>> +		__entry->highest_zoneidx = highest_zoneidx;
>>>> +		__entry->order = order;
>>>> +		__entry->nr_requested = nr_requested;
>>>> +		__entry->nr_scanned = nr_scanned;
>>>> +		__entry->nr_sorted = nr_sorted;
>>>> +		__entry->nr_skipped = nr_skipped;
>>>> +		__entry->nr_taken = nr_taken;
>>>> +		__entry->lru = lru;
>>>> +		__entry->max_seq = max_seq;
>>>> +		__entry->tier = tier;
>>>> +		__entry->min_seq = min_seq;
>>>> +	),
>>>> +
>>>> +	TP_printk("memcg_id=%llu classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_sorted=%lu nr_skipped=%lu nr_taken=%lu lru=%s max_seq=%lu tier=%d min_seq=%lu",
>>>> +		__entry->memcg_id,
>>>> +		__entry->highest_zoneidx,
>>>> +		__entry->order,
>>>> +		__entry->nr_requested,
>>>> +		__entry->nr_scanned,
>>>> +		__entry->nr_sorted,
>>>> +		__entry->nr_skipped,
>>>> +		__entry->nr_taken,
>>>> +		__print_symbolic(__entry->lru, LRU_NAMES),
>>>> +		__entry->max_seq,
>>>> +		__entry->tier,
>>>> +		__entry->min_seq)
>>>> +);
>>>> +
>>>>    TRACE_EVENT(mm_vmscan_write_folio,
>>>>    	TP_PROTO(struct folio *folio),
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 2554a6513aa8..67f59aa73fb9 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>>>>    	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>>>>    				scanned, skipped, isolated,
>>>>    				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>>>> +	trace_mm_mglru_scan_folios(lruvec,
>>>> +				   sc->reclaim_idx, sc->order, nr_to_scan,
>>>> +				   scanned, sorted, skipped, isolated,
>>>> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
>>>> +				   lrugen->max_seq, tier,
>>>> +				   lrugen->min_seq[type]);
>>>
>>> And seems Steven also suggested to calculate lru, max_seq, min_seq in
>>> TP_fast_assign() in v1 which could be missed.
>>>
>>
>> Thanks, I will update it following Steven's suggestions.
>>
>>
>>>           TP_fast_assign(
>>>                   __entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
>>>                   __entry->highest_zoneidx = sc->reclaim_idx;
>>>                   __entry->order = sc->order;
>>>                   __entry->nr_requested = nr_requested;
>>>                   __entry->nr_scanned = nr_scanned;
>>>                   __entry->nr_sorted = nr_sorted;
>>>                   __entry->nr_skipped = nr_skipped;
>>>                   __entry->nr_taken = nr_taken;
>>>                   __entry->lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
>>>                   __entry->max_seq = lrugen->max_seq;
>>>                   __entry->tier = tier;
>>>                   __entry->min_seq = lrugen->min_seq;
>>>           ),
>>>
>>
>> However, 'sc' is an internal structure, so sc->order cannot be accessed in
>> TP_fast_assign(), and I don't think it is worth making scan_control an
>> external structure just for this.
> 
> Agree.
> 
>>
>>>
>>>>    	*isolatedp = isolated;
>>>>    	return scanned;
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> -- 
>> Best regards
>> Ridong
>>

-- 
Best regards
Ridong

