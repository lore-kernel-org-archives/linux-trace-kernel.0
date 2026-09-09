Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D31A54EEB1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957819; cv=none; b=RLfNOMZQv+e4i4zEcxTXWKgNm19SIbrIDQN+IwZLG5xw0zbee0Pe3CVkj5UTsai8rIiZWJXqT2cqTWEgxHSlMmXL/H1IYbn9Haas7CoyjQSjpgS+YrdHzYDUZH62ZkzNYZfkz+3btH8TyxfoOQetzn5SSUApDU7MRCTBTQDHtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957819; c=relaxed/simple;
	bh=jqiubL+tagB99Gjb+Dzn8xdJMbDXci+TetbI3A6BRTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvNs5/cTG2mKeqdTiGMTJeRi+dHxC6c2f0C62Yo9KCCK1eFhRNHU7qJRum8wclQQvcV9Fku+QfBZggB2VrEBikpFfyvWEDY5BNeDisgvla3Ac9PVAwrNO7W0xAS/pJTZqrWy5q3a1E7UX4weXN8AWK88yW6dlASw97oQ7hw53Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJAONsKd; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJAONsKd"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jqiubL+tagB99Gjb+Dzn8xdJMbDXci+TetbI3A6BRTs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788957814; v=1; x=1789562614;
 b=rJAONsKdu+sg+H/uk6gTd2G/TsAB/Jc0+tG+jAvP/PyL4wDIrKwqC9W5BhDm4PVsESHGmtAs
 yDh+KXYaTxl+Btmbn5r7SvHvuxrMi5B8DF7n91yeQcRcBDvfzXJsqrWksFQtfDZJL3GETqFjEJ4
 cIdr3XgOPyxygcWJ5tvCqfZQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d2d73bfd903f7147;
	Wed, 09 Sep 2026 12:43:34 +0000
X-Mizu-Trace-ID: d2d73bfd903f7147
X-Migadu-Flow: FLOW_OUT
Message-ID: <ebd30222-01db-491f-852c-bf5261f95f47@linux.dev>
Date: Wed, 9 Sep 2026 20:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm/mglru: add tracepoint for inc_max_seq
To: Barry Song <baohua@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260907042447.2450663-1-ridong.chen@linux.dev>
 <20260907042447.2450663-3-ridong.chen@linux.dev>
 <CAGsJ_4zvJmdiicZAefUyjn4RjP=hBxE95fjpR9HM+SFJ8S_aCQ@mail.gmail.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4zvJmdiicZAefUyjn4RjP=hBxE95fjpR9HM+SFJ8S_aCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/2026 2:45 PM, Barry Song wrote:
> On Mon, Sep 7, 2026 at 12:25 PM Ridong Chen <ridong.chen@linux.dev> wrote:
>>
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
>> youngest generation. There is currently no tracepoint on this path, so
>> the moment a new generation is created, and how the min_seq of each type
>> trails behind it, cannot be observed as it happens.
>>
>> Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped, with
>> the memcg id and the new max_seq alongside the anon and file min_seq.
>> Paired with the mm_mglru_isolate_folios tracepoint it makes the full
>> aging-to-eviction window observable per memcg.
>>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
>> ---
>>   include/trace/events/vmscan.h | 30 ++++++++++++++++++++++++++++++
>>   mm/vmscan.c                   |  4 ++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>> index a0e3cf75294b..ab93c2f4b318 100644
>> --- a/include/trace/events/vmscan.h
>> +++ b/include/trace/events/vmscan.h
>> @@ -439,6 +439,36 @@ TRACE_EVENT(mm_mglru_isolate_folios,
>>                  __entry->max_seq)
>>   );
>>
>> +TRACE_EVENT(mm_mglru_inc_max_seq,
>> +
>> +       TP_PROTO(u64 memcg_id,
>> +               unsigned long max_seq,
>> +               unsigned long anon_min_seq,
>> +               unsigned long file_min_seq),
>> +
>> +       TP_ARGS(memcg_id, max_seq, anon_min_seq, file_min_seq),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(u64, memcg_id)
>> +               __field(unsigned long, max_seq)
>> +               __field(unsigned long, anon_min_seq)
>> +               __field(unsigned long, file_min_seq)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->memcg_id = memcg_id;
>> +               __entry->max_seq = max_seq;
>> +               __entry->anon_min_seq = anon_min_seq;
>> +               __entry->file_min_seq = file_min_seq;
>> +       ),
>> +
>> +       TP_printk("memcg_id=%llu max_seq=%lu anon_min_seq=%lu file_min_seq=%lu",
>> +               __entry->memcg_id,
>> +               __entry->max_seq,
>> +               __entry->anon_min_seq,
>> +               __entry->file_min_seq)
>> +);
>> +
>>   TRACE_EVENT(mm_vmscan_write_folio,
>>
>>          TP_PROTO(struct folio *folio),
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 771fe6827939..3c806a57d113 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4065,6 +4065,10 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
>>          WRITE_ONCE(lrugen->timestamps[next], jiffies);
>>          /* make sure preceding modifications appear */
>>          smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
>> +       trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
>> +                                  lrugen->max_seq,
>> +                                  lrugen->min_seq[LRU_GEN_ANON],
>> +                                  lrugen->min_seq[LRU_GEN_FILE]);
> 
> I suspect we also want to know the number of pages in each generation,
> similar to:
> 
> /sys/kernel/debug # cat lru_gen
> memcg 1 /
>   node     0
>            0      25672          0          85
>            1      25672          0        4249
>            2      25672         21           0
>            3      25672          0           0
> memcg 19 /A
>   node     0
>            0      23036          0           0
>            1      23036          0           0
>            2      23036          0           0
>            3      23036          0           0
> 
Thanks.

Will add.

-- 
Best regards
Ridong

