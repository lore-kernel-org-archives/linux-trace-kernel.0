Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF367533593
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955233; cv=none; b=TdB0z5FIfm3cwCwUOZUHQEbT+2zdAvvbj1iTbAte9jsrGzdSBtxmhd9BJqIEQLVsDVDeTUeXlHV5khJ3u3lTtYn26lOiiH5524037ZrdrmVVo71LGI70LGIOZjWtNvSUlMoUZoE1WvNeOUTqBuwOVncFjoJpdWGf2x+HW6aGfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955233; c=relaxed/simple;
	bh=SwCnXXsaf+fnrTsFYwqQVitrQ3IBYAM246XJcfjgCMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzFcrUldp2J+X+IaxDufoKah8mncJ3gDJiVXso2z5VFqdfhIRD0SabjXjSzdshA+DMdgTMj0u6hrNABGNRO7HM7Gaxag1PBIKsnJdWsWSZGJzBn+nZZJDOr94Fgk3WQlop1YuELqLS733/oOWsC/hX3UMzwPQAo1FLt8uvdtyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJxIezej; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJxIezej"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SwCnXXsaf+fnrTsFYwqQVitrQ3IBYAM246XJcfjgCMM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788955228; v=1; x=1789560028;
 b=tJxIezejdWMqrldv6KuK3+fv2knycsSL08OcGIXbQcrWpeKJxiOcmvIDo61qepZxkHiQHwMf
 1B7v0f3MJt7UViXmPHBNLm+sSxSr7ZLQnZPgW1PJ3ZaZSfUBRm67ruzvU0rexSzLZPpUlK3Wig3
 Q5wNHqLCbafhrS4OPTRHEwhg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d4edfe393dee372;
	Wed, 09 Sep 2026 12:00:26 +0000
X-Mizu-Trace-ID: 1d4edfe393dee372
X-Migadu-Flow: FLOW_OUT
Message-ID: <102f6ff6-46f9-4734-a056-694eb2c0129b@linux.dev>
Date: Wed, 9 Sep 2026 20:00:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm/mglru: add tracepoint for folio isolation
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
 <20260907042447.2450663-2-ridong.chen@linux.dev>
 <CAGsJ_4zT0HcbkQjdPFPBeaqbGcYp4WE6sghDzz=0evhhupCs3g@mail.gmail.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4zT0HcbkQjdPFPBeaqbGcYp4WE6sghDzz=0evhhupCs3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/2026 2:40 PM, Barry Song wrote:
> On Mon, Sep 7, 2026 at 12:25 PM Ridong Chen <ridong.chen@linux.dev> wrote:
>>
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> MGLRU's scan_folios() and evict_folios() emit the classic-LRU
>> tracepoints trace_mm_vmscan_lru_isolate() and
>> trace_mm_vmscan_lru_shrink_inactive(). Those predate MGLRU and are
>> indistinguishable from the classic-LRU path: they carry no generation,
>> sequence, memcg or swappiness context, so a trace of an MGLRU run cannot
>> tell which memcg a given scan/evict belongs to, nor how far reclaim has
>> progressed through the generations.
>>
>> Add mm_mglru_isolate_folios, emitted once per isolate_folios() call with
>> the memcg id, the type actually scanned, the effective swappiness, the
>> scanned/isolated counts, and the anon/file min_seq and max_seq. The
>> min_seq/max_seq triplet ties each isolation to the generation layout it
>> ran against, which the classic-LRU tracepoints cannot express.
>>
>> This is emitted at the isolate_folios() layer, which is MGLRU-specific
>> and has no classic-LRU counterpart, so it neither changes nor duplicates
>> the existing scan/evict tracepoints.
>>
> 
> I have no objection to MGLRU having some tracepoints. However, one
> major concern is that the code is changing rapidly, so the tracepoints
> may not be stable. We would need to maintain them as the code evolves.
> 

Indeed. GEN-LRU has been available for several years now, and many vendors are 
already using it, so adding tracepoints is a necessary step.

>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
>> ---
>>   include/trace/events/vmscan.h | 47 +++++++++++++++++++++++++++++++++++
>>   mm/vmscan.c                   |  9 ++++++-
>>   2 files changed, 55 insertions(+), 1 deletion(-)
>>
> [...]
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 8409ea4bbf37..771fe6827939 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
> [...]
>> @@ -4876,6 +4877,12 @@ static int isolate_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>>                  goto retry;
>>          }
>>
>> +done:
>> +       trace_mm_mglru_isolate_folios(mem_cgroup_id(lruvec_memcg(lruvec)),
>> +                                     type, swappiness, total_scanned, *isolated,
>> +                                     lrugen->min_seq[LRU_GEN_ANON],
>> +                                     lrugen->min_seq[LRU_GEN_FILE],
>> +                                     lrugen->max_seq);
> 
> Maybe `scan_folios()` would be a better place for this, as it can more
> directly reflect what we're doing for each type.
> 

scan_folios() already contains the trace_mm_vmscan_lru_isolate 
tracepoint(traditional tracepoint), but it lacks any GEN-LRU-specific 
information. Adding another tracepoint there would be redundant. Therefore, I 
placed the new tracepoint in isolate_folios(), where it can capture GEN-LRU's 
specific details. Additionally, it can indicate whether a fallback to the other 
type has occurred.

> 
>>          return total_scanned;
>>   }
>>
> 
> Best Regards
> Barry

-- 
Best regards
Ridong

