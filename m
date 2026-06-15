Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7F22538F;
	Mon, 15 Jun 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527693; cv=none; b=a0nxn7zN3FxrsOHV7rFQU7OYov9ijjn1O4AyzlYTYUlK606gp79nocE/jdJZagbhEbh1bOrfbcJC67dh29525YmtVn6MxJIDzUv5zvd9P2J3Lou6SD6cb2kz0w4bAPdjQb7nQTWYgKvwjnOIPuHsGkbXInyn4pvByO65bfRIKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527693; c=relaxed/simple;
	bh=lJfieZFFK8NXea4q7lRr2mPr/MGmBByHOTxo+jpON3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+oUJiVDM28Rjui+2Cj5JwMfLum7XiG0s2lOzyHcGx37HwZiP2vOC34yx6oDM5esFvGYFl6I/zfLFgDbj1zv4Lthb6mv1p9WoCW9bqVgIKCMBHmGjbkfbu9960uexKcvZTXFNBYeFOU512CeKfsgk4ZM3rUzaq4o/76JGPb8Yeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYVz7P9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYVz7P9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7457B1F000E9;
	Mon, 15 Jun 2026 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527691;
	bh=8VyjfsV/ktL3KuCoCLelWbW40DiX0xBkWn5tF7vIyh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CYVz7P9LV2QX4XlthkHBX1rO6kL1DUTzp7BdfjL73c3NIMmRAfhr+3PX5nzfqCLA5
	 SqgG9Zl9xtD3RN6ctSO4yjG99zAERH+gyqHICL0k/PE88QmZ2lp96muv2x8r5cbLYu
	 DYOr/mfWXbdS4gfcCPGwewFM56gxCBmB5jE0pjr/htWrBHTzNPMo0cIWJKdaKSbQ9i
	 C+DpFWT/zjasoE77Zz8pHU9crWaa1aVbKYGEnp5/L66qDjnNEECygG2DdyN+ffSZvh
	 tpMdeX9Kz873Cm73n24bU98O/RY9AEZW5rTpo1sjwKfSxNXe+4zeF/VgjQ0S944pVy
	 hNM9XjC41SknA==
Message-ID: <5fd2445c-e916-417e-9d02-94af1611cdbc@kernel.org>
Date: Mon, 15 Jun 2026 14:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/lruvec: trace LRU add drains and drain-all requests
Content-Language: en-US
To: JP Kobryn <jp.kobryn@linux.dev>, linux-mm@kvack.org, willy@infradead.org,
 shakeel.butt@linux.dev, usama.arif@linux.dev, akpm@linux-foundation.org,
 mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chrisl@kernel.org, shikemeng@huaweicloud.com,
 nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260610234808.212397-1-jp.kobryn@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260610234808.212397-1-jp.kobryn@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 01:48, JP Kobryn wrote:
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
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
> v4:
>   - renamed nr_folio_add to nr_folios in lru_add_drain()
>   - renamed nr to nr_folios in tracepoint for consistency
> 
> v3: https://lore.kernel.org/linux-mm/20260610195220.12403-1-jp.kobryn@linux.dev/
>   - restored and renamed tracepoint in __lru_add_drain_all
> 
> v2: https://lore.kernel.org/linux-mm/20260609041156.31127-1-jp.kobryn@linux.dev/
>   - removed mm_lru_drain_all tracepoint
> 
> v1: https://lore.kernel.org/linux-mm/20260609041156.31127-1-jp.kobryn@linux.dev/
> 
>  include/trace/events/pagemap.h | 37 ++++++++++++++++++++++++++++++++++
>  mm/swap.c                      |  7 ++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
> index 171524d3526d..df6ac4d13dcf 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -77,6 +77,43 @@ TRACE_EVENT(mm_lru_activate,
>  	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
>  );
>  
> +TRACE_EVENT(mm_lru_add_drain,
> +
> +	TP_PROTO(int cpu, unsigned int nr_folios),
> +
> +	TP_ARGS(cpu, nr_folios),
> +
> +	TP_STRUCT__entry(
> +		__field(int,		cpu	)
> +		__field(unsigned int,	nr_folios	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu	= cpu;
> +		__entry->nr_folios	= nr_folios;
> +	),
> +
> +	TP_printk("cpu=%d nr_folios=%u", __entry->cpu, __entry->nr_folios)
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
> index 588f50d8f1a8..b506fa912a93 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
>  {
>  	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
>  	struct folio_batch *fbatch = &fbatches->lru_add;
> +	unsigned int nr_folios = folio_batch_count(fbatch);
>  
> -	if (folio_batch_count(fbatch))
> +	if (nr_folios) {
>  		folio_batch_move_lru(fbatch, lru_add);
> +		trace_mm_lru_add_drain(cpu, nr_folios);
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

