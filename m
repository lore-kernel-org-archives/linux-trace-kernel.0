Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8933B71A4;
	Mon, 14 Sep 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372073; cv=none; b=MZC/W0DAfpvTdPFsrw+i46LQTy/r/Hp9FJqjZtLggBsJM+PGF9UYdw0nIw1gMq/hw7X3mxTcqlWJKpUV4xfj/l5PW1xgtP3FvaZpDSn82yjmYnDGEhY9NQKMN3oE0ikV6h3Mp+LF4/Kp43w9IdBSzBmrVAWPeEyBdkWAisoNBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372073; c=relaxed/simple;
	bh=DQN69g5qWHF/IRp1isRr4PeS6KmUUjwIEjcNMgdU1ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4ycnXNF7iC1bTW2NLIO9CO798UxjVUdmbB6c38yiTClXmhtVknURQ2MyvFqY+31bkhLClx+B2lvioPr/RQbvuv+pAtSUNt1Ery4ROJQHpKds1xpCBpJuOb2XtWPOAoixit/eeN46DB4HsYR+JAMG18TUVxWvA7wPzrebmdKmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kl6QXR0C; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kl6QXR0C"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789372067; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sXl5SrD59PL5uo/0jpXBuV8d/KfS78Pkn/98KycEw6E=;
	b=kl6QXR0C7S8pPlSqpdUSwCGrAhK5K6EVnrksnXEMD/eS00OktgPE2dgNnY0pRKIxIoAKypowe1/hSZDxJQevF0Ywm8E9DnynFedkES8dZM2lw7SfKiilsPTArKRx6Je/GciJrxRXPjgYkUc4XF/20xuuKF6ebfmtbDCXlZw0jWI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XAtKirq_1789372064;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XAtKirq_1789372064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 15:47:45 +0800
Message-ID: <9c8c7c91-b159-4342-8af7-3a8171e85389@linux.alibaba.com>
Date: Mon, 14 Sep 2026 15:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
To: Ridong Chen <ridong.chen@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260911102939.2485750-3-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 6:29 PM, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> MGLRU's scan_folios() emits the classic-LRU tracepoint
> trace_mm_vmscan_lru_isolate(), which predates MGLRU. It reports the
> scan/isolate counts and the LRU type, but carries no generation or
> memcg context, so a trace of an MGLRU run cannot tell which memcg a
> given scan belongs to, nor how far reclaim has progressed through the
> generations.
> 
> Add mm_mglru_scan_folios next to it, reporting the same counters plus
> nr_sorted (folios moved to a younger generation by sort_folio()) and
> the MGLRU context the classic tracepoint lacks: the memcg id, and the
> max_seq, tier and min_seq of the type being scanned.
> 
> scan_folios() is the MGLRU-specific layer where folios are actually
> scanned, so it has no classic-LRU counterpart. That the classic
> trace_mm_vmscan_lru_isolate() has lived here stably shows this is a
> long-lived place to hook, and the new tracepoint can be enabled on its
> own to observe the MGLRU-specific information. The existing tracepoint
> is left unchanged.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>   include/trace/events/vmscan.h | 63 +++++++++++++++++++++++++++++++++++
>   mm/vmscan.c                   |  6 ++++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 8a872990b4be..5defa8f6719c 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>   		__print_symbolic(__entry->lru, LRU_NAMES))
>   );
>   

[snip]

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2554a6513aa8..67f59aa73fb9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>   	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>   				scanned, skipped, isolated,
>   				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> +	trace_mm_mglru_scan_folios(lruvec,
> +				   sc->reclaim_idx, sc->order, nr_to_scan,
> +				   scanned, sorted, skipped, isolated,
> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
> +				   lrugen->max_seq, tier,
> +				   lrugen->min_seq[type]);

Both tracepoints will print some duplicated content, and I'm not sure 
it's worth a new tracepoint just to trace max_seq and min_seq.

Anyway, I'm not against this patch, but I'd like to hear others' opinions.
