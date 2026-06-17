Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705B37FF76;
	Wed, 17 Jun 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694683; cv=none; b=F3tZo4bk8bcxzOi1oFm+wZISmYvMyQkX7huud7Zy6+mceUTsNoiqGjfubziaYh77/DF9FZPKhKqa+lNm6typOFHr85K4zT5Azxt1oXQ5Il4o/4nFKUg6holTTvo9WicQOJkN9Na5gJHxYxING/oKzBn5aS+xv0Rp77I+pBqg13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694683; c=relaxed/simple;
	bh=baqqMi0HbpVGro7oJjM4kRgehZNRoXZThuBkUG5xkfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjqYQK8/HvMeHLod65jb909oKHJK+VRWxkM9ekTeGmI5xkohEOSLBJan+IdVlF2TRdE6V9isuUBqJzbMF6CpxuYYd0sy/pUqT7q/7DVDmHzOt7DsfSE8DqHLmJwN/6YaBL/YaH6W4fRZ/sZz4uhQow1OEMMyjYUpqeqDSi0/Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2GISETD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2GISETD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511181F000E9;
	Wed, 17 Jun 2026 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781694682;
	bh=SiaKWxtsrJCVgybVhz4X8gHJGp58KurwzLbmq6ogImQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L2GISETDR7ytjswxWuQiaw6cu9KE+dOUjms263mMicLABEo1Ubjx5XRDqidUmu+P5
	 E+DNoNpojjUwY50aQisyeFc8e4pQWCcB2XFFkj/b5ZgDIDHwM4teqOIeoVDQ6RFk+8
	 +EuMiRth+LUSq2hVlr+ZBw/4XB1HKemkbdrfV9UBzs2pTiUilN9yMPYhh3MGBs+WZh
	 nWrTcJbkdY9IIyVtJwXLVhXUM1onmEXFtpauv5b2QRU8yr1ei2HU/rfVNKZYdUEaBz
	 ffdC4rcEP1px/qGJnjFm+SJV3akJOsaCrpsHpj+ZdlWUQus1N0gqfq9PxQoNg+nstt
	 WMf6nHHMZhrfg==
Message-ID: <06122cae-e28b-4ded-a9dd-d380d31c5230@kernel.org>
Date: Wed, 17 Jun 2026 13:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
To: JP Kobryn <jp.kobryn@linux.dev>, linux-mm@kvack.org, willy@infradead.org,
 shakeel.butt@linux.dev, usama.arif@linux.dev, akpm@linux-foundation.org,
 vbabka@kernel.org, mhocko@suse.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kasong@tencent.com,
 qi.zheng@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
 youngjun.park@lge.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260610195220.12403-1-jp.kobryn@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 21:52, JP Kobryn wrote:
> LRU add batches can be drained before they reach capacity. This can be a
> source of LRU lock contention, but it is not currently possible to
> attribute these drains to callers with existing tracepoints.
> 
> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> lru_add batch is drained. This allows tracing to distinguish full drains
> from partial drains and attribute them to the calling stack.
> 
> Add mm_lru_add_drain_all to capture callers of __lru_add_drain_all and
> whether they set the force flag for all CPUs. The tracepoint resembles
> the signature of the enclosing function, but is needed because of
> potential inlining.
> 
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> ---
>  include/trace/events/pagemap.h | 37 ++++++++++++++++++++++++++++++++++
>  mm/swap.c                      |  7 ++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
> index 171524d3526d..ff3da07ccb40 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -77,6 +77,43 @@ TRACE_EVENT(mm_lru_activate,
>  	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
>  );
>  
> +TRACE_EVENT(mm_lru_add_drain,
> +
> +	TP_PROTO(int cpu, unsigned int nr),
> +
> +	TP_ARGS(cpu, nr),
> +
> +	TP_STRUCT__entry(
> +		__field(int,		cpu	)
> +		__field(unsigned int,	nr	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu	= cpu;
> +		__entry->nr	= nr;
> +	),
> +
> +	TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
> +);
> +
> +TRACE_EVENT(mm_lru_add_drain_all,
> +
> +	TP_PROTO(bool force_all_cpus),
> +
> +	TP_ARGS(force_all_cpus),
> +
> +	TP_STRUCT__entry(
> +		__field(bool,	force_all_cpus	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->force_all_cpus	= force_all_cpus;
> +	),
> +
> +	TP_printk("force_all_cpus=%s",
> +		__entry->force_all_cpus ? "true" : "false")
> +);
> +
>  #endif /* _TRACE_PAGEMAP_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/swap.c b/mm/swap.c
> index 588f50d8f1a8..e14b7612f896 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
>  {
>  	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
>  	struct folio_batch *fbatch = &fbatches->lru_add;
> +	unsigned int nr_folios_add = folio_batch_count(fbatch);
>  
> -	if (folio_batch_count(fbatch))
> +	if (nr_folios_add) {
>  		folio_batch_move_lru(fbatch, lru_add);
> +		trace_mm_lru_add_drain(cpu, nr_folios_add);
> +	}
>  
>  	fbatch = &fbatches->lru_move_tail;
>  	/* Disabling interrupts below acts as a compiler barrier. */
> @@ -869,6 +872,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  
> +	trace_mm_lru_add_drain_all(force_all_cpus);
> +
>  	/*
>  	 * Guarantee folio_batch counter stores visible by this CPU
>  	 * are visible to other CPUs before loading the current drain

Given that trace events can quickly become stable ABI [1], are we really sure we
want to add this?

[1] https://lore.kernel.org/r/20260603130006.7d2c4a62@gandalf.local.home

-- 
Cheers,

David
