Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167A3E3DA4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295160; cv=none; b=YI29fWBRCqAecXppD9gu4zQ6O0cJ9ZVN7CA7+KKl8xBDZ7WdCB/LQpQCZ7bZipBOMr/Uv/Z2h4yPGWHgieu2OA+n2CxZbhQ70AFjnivC7Bq6gFeOiOf15WUtCYc2bx7sy2KQnpL1nR9i9zAgrpjb7AIY884HEqc4Pd7HAnBtfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295160; c=relaxed/simple;
	bh=RBRi6I3a87/juJLx+fNqZVRPmjDwMN9oEpqOjLUx424=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoMrD6dFpyPi45/wzlWriyQRMFM0n40Vx/Fl5eLOqGvR9J/SA7Sc1RZWLEv86YfHz7qzBF5wLUYH+/HcxCjHrDp48iSRU1gxjAMOrQV5HJiy7nyjedtqofGHc7ZRCVuRAScQVXL5ZvI5QcwMdKMLoodeqosn+xUC8knk5hPX0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w0cdeFZ+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w0cdeFZ+"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RBRi6I3a87/juJLx+fNqZVRPmjDwMN9oEpqOjLUx424=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789295146; v=1; x=1789899946;
 b=w0cdeFZ+8XOD6hCw74SDPrBrIySEC7wind7pLhSxdkWWliAl+pRJbM1vCWK5X76U1ECD+rDT
 uYEWCqc889aCXrmQFsHi+y6Q92zdBUEdCQyylKyR5w1AS3xqneCk2t/2cdwCbLuav6LoanJGc7N
 /z7S46IcHp2uJz7sx8hrzdjo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 211913a8fa41334d;
	Sun, 13 Sep 2026 10:25:46 +0000
X-Mizu-Trace-ID: 211913a8fa41334d
X-Migadu-Flow: FLOW_OUT
Message-ID: <cec74135-b7c6-4405-8e0e-d33564429121@linux.dev>
Date: Sun, 13 Sep 2026 18:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/mglru: add tracepoint for scan_folios()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
 <20260911072848.2346073-3-ridong.chen@linux.dev>
 <20260911101120.25e3495a@gandalf.local.home>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260911101120.25e3495a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2026 10:11 PM, Steven Rostedt wrote:
> On Fri, 11 Sep 2026 15:28:47 +0800
> Ridong Chen <ridong.chen@linux.dev> wrote:
> 
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>> index 8a872990b4be..c39dfacef033 100644
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>>   		__print_symbolic(__entry->lru, LRU_NAMES))
>>   );
>>   
>> +TRACE_EVENT(mm_mglru_scan_folios,
>> +
>> +	TP_PROTO(u64 memcg_id,
>> +		int highest_zoneidx,
>> +		int order,
>> +		unsigned long nr_requested,
>> +		unsigned long nr_scanned,
>> +		unsigned long nr_sorted,
>> +		unsigned long nr_skipped,
>> +		unsigned long nr_taken,
>> +		int lru,
>> +		unsigned long max_seq,
>> +		int tier,
>> +		unsigned long min_seq),
>> +
>> +	TP_ARGS(memcg_id, highest_zoneidx, order, nr_requested, nr_scanned,
>> +		nr_sorted, nr_skipped, nr_taken, lru, max_seq, tier, min_seq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u64, memcg_id)
>> +		__field(int, highest_zoneidx)
>> +		__field(int, order)
>> +		__field(unsigned long, nr_requested)
>> +		__field(unsigned long, nr_scanned)
>> +		__field(unsigned long, nr_sorted)
>> +		__field(unsigned long, nr_skipped)
>> +		__field(unsigned long, nr_taken)
>> +		__field(int, lru)
>> +		__field(unsigned long, max_seq)
>> +		__field(int, tier)
>> +		__field(unsigned long, min_seq)
> 

Thank you very much for your review.

> Please keep "int"s together. This creates a structure that is used to write
> into the ring buffer. On 64bit machines, the above would add 4 bytes of
> padding after each int, whereas:
> 
> 		__field(unsigned long, max_seq)
> 		__field(unsigned long, min_seq)
> 		__field(int, lru)
> 		__field(int, tier)
> 
> 
> would not.
> 

Will upate.

>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->memcg_id = memcg_id;
>> +		__entry->highest_zoneidx = highest_zoneidx;
>> +		__entry->order = order;
>> +		__entry->nr_requested = nr_requested;
>> +		__entry->nr_scanned = nr_scanned;
>> +		__entry->nr_sorted = nr_sorted;
>> +		__entry->nr_skipped = nr_skipped;
>> +		__entry->nr_taken = nr_taken;
>> +		__entry->lru = lru;
>> +		__entry->max_seq = max_seq;
>> +		__entry->tier = tier;
>> +		__entry->min_seq = min_seq;
>> +	),
>> +
>> +	TP_printk("memcg_id=%llu classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_sorted=%lu nr_skipped=%lu nr_taken=%lu lru=%s max_seq=%lu tier=%d min_seq=%lu",
>> +		__entry->memcg_id,
>> +		__entry->highest_zoneidx,
>> +		__entry->order,
>> +		__entry->nr_requested,
>> +		__entry->nr_scanned,
>> +		__entry->nr_sorted,
>> +		__entry->nr_skipped,
>> +		__entry->nr_taken,
>> +		__print_symbolic(__entry->lru, LRU_NAMES),
>> +		__entry->max_seq,
>> +		__entry->tier,
>> +		__entry->min_seq)
>> +);
>> +
>>   TRACE_EVENT(mm_vmscan_write_folio,
>>   
>>   	TP_PROTO(struct folio *folio),
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2554a6513aa8..bd1b9ecf2e84 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>>   	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>>   				scanned, skipped, isolated,
>>   				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>> +	trace_mm_mglru_scan_folios(mem_cgroup_id(lruvec_memcg(lruvec)),
>> +				   sc->reclaim_idx, sc->order, nr_to_scan,
>> +				   scanned, sorted, skipped, isolated,
>> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
>> +				   lrugen->max_seq, tier,
>> +				   lrugen->min_seq[type]);
> 
> Can't this information be processed in the tracepoint? That is:
> 
> 	TP_PROTO(struct lruvec *lruvec,
> 		 struct scan_control *sc,
> 		 struct lru_gen_folio *lrugen,
> 		 unsigned long nr_requested,
> 		 unsigned long nr_scanned,
> 		 unsigned long nr_sorted,
> 		 unsigned long nr_skipped,
> 		 unsigned long nr_taken,
> 		 int type),
> 
> 	TP_ARGS(lruvec, sc, lrugen, nr_requested, nr_scanned,
> 		nr_sorted, nr_skipped, nr_taken, type),
> 
> 	TP_STRUCT__entry(
> 		__field(u64, memcg_id)
> 		__field(int, highest_zoneidx)
> 		__field(int, order)
> 		__field(unsigned long, nr_requested)
> 		__field(unsigned long, nr_scanned)
> 		__field(unsigned long, nr_sorted)
> 		__field(unsigned long, nr_skipped)
> 		__field(unsigned long, nr_taken)
> 		__field(unsigned long, max_seq)
> 		__field(unsigned long, min_seq)
> 		__field(int, lru)
> 		__field(int, tier)
> 	),
> 
> 	TP_fast_assign(
> 		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
> 		__entry->highest_zoneidx = sc->reclaim_idx;
> 		__entry->order = sc->order;
> 		__entry->nr_requested = nr_requested;
> 		__entry->nr_scanned = nr_scanned;
> 		__entry->nr_sorted = nr_sorted;
> 		__entry->nr_skipped = nr_skipped;
> 		__entry->nr_taken = nr_taken;
> 		__entry->lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> 		__entry->max_seq = lrugen->max_seq;
> 		__entry->tier = tier;
> 		__entry->min_seq = lrugen->min_seq;
> 	),
> 
> 
> This moves the code to generate the parameters into the TP_fast_assign()
> which is in a separate text section. It remove code from the work flow
> improving instruction cache.
> 
> Same can be done for that trace_mm_vmscan_lru_isolate() trace event.
> 

Sashiko has reported the same issue, so I updated my series [1] when I received 
Sashiko's report. Thank you again for pointing this out.

[1] https://lore.kernel.org/linux-mm/20260911102939.2485750-3-ridong.chen@linux.dev/

> 
>>   
>>   	*isolatedp = isolated;
>>   	return scanned;
>> -- 

-- 
Best regards
Ridong

