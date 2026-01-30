Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAF2D061B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790478; cv=none; b=OaojQtxvnSPZ59YJcgZwgjmso+B8TWdWk9RFuvfaaIXQ/FcNInV7VMZbnUXR0CpCPp9OkykIpdv7y7Zln1oZZHxOf2mGtZdyHXn+LwuK+r7JCRQpkcyc1Qf5eFeW2GT2cS2GocpF4OY1XR9ILyB37mfUATH6EZtbs4iFZzhWYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790478; c=relaxed/simple;
	bh=FNnZCV4GxI7Bv0UQYcLRyKrzqOBKUrr7i9KdRno9TaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpsFESoFLQXvahFaFhzlMRX9xW2PZ1NI748wgA1nisbtq/r/XBLLfT+ZJprTnREYBFJpG4vb0P3HzGUMriv4we2b4wbQ5lrU71yee71MK5iQv32RGgwYYL4knt5eDlToy/xfb5ySNsKWdaS5gUfn7A14C/fEzFn6fqxwzVPEXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vd8O0H9X; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vd8O0H9X"
Message-ID: <d6c7d83c-687b-4844-b515-9f7342278628@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769790473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqMQEIs5tQs1P3VA+UVkzrDC1zRe8RXMz3zQFhJ//+4=;
	b=Vd8O0H9XnoAirItg+LcZHYPLjBhK4a5kj6Kti1/a3Y7OoOkkv2dDCv/6kQm+A2ZQ1EwV07
	1ypR15YWqfp8kUuhpdDgPyVmA0nTJWwpu1SaUTBQl0IeypuB28e3jisLTumBfLy//hnxDJ
	nvlezOaQo3ZCF2LTtevvB4VUAXidWyM=
Date: Fri, 30 Jan 2026 11:27:47 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] tracing/dma: Cap dma_map_sg tracepoint arrays to
 prevent buffer overflow
To: Deepanshu Kartikey <kartikey406@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ptesarik@suse.com
Cc: m.szyprowski@samsung.com, jgg@ziepe.ca, leon@kernel.org,
 kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
References: <20260130155215.69737-1-kartikey406@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260130155215.69737-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/30/26 10:52, Deepanshu Kartikey wrote:
> The dma_map_sg tracepoint can trigger a perf buffer overflow when
> tracing large scatter-gather lists. With devices like virtio-gpu
> creating large DRM buffers, nents can exceed 1000 entries, resulting
> in:
> 
>   phys_addrs: 1000 * 8 bytes = 8,000 bytes
>   dma_addrs:  1000 * 8 bytes = 8,000 bytes
>   lengths:    1000 * 4 bytes = 4,000 bytes
>   Total: ~20,000 bytes
> 
> This exceeds PERF_MAX_TRACE_SIZE (8192 bytes), causing:
> 
>   WARNING: CPU: 0 PID: 5497 at kernel/trace/trace_event_perf.c:405
>   perf buffer not large enough, wanted 24620, have 8192
> 
> Cap all three dynamic arrays at 128 entries using min() in the array
> size calculation. This ensures arrays are only as large as needed
> (up to the cap), avoiding unnecessary memory allocation for small
> operations while preventing overflow for large ones.
> 
> The tracepoint now records the full nents/ents counts and a truncated
> flag so users can see when data has been capped.
> 
> Changes in v2:
> - Use min(nents, DMA_TRACE_MAX_ENTRIES) for dynamic array sizing
>   instead of fixed DMA_TRACE_MAX_ENTRIES allocation (feedback from
>   Steven Rostedt)
> - This allocates only what's needed up to the cap, avoiding waste
>   for small operations
> 
> Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=28cea38c382fd15e751a
> Tested-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  include/trace/events/dma.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index b3fef140ae15..33e99e792f1a 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -275,6 +275,8 @@ TRACE_EVENT(dma_free_sgt,
>  				sizeof(u64), sizeof(u64)))
>  );
>  
> +#define DMA_TRACE_MAX_ENTRIES 128
> +
>  TRACE_EVENT(dma_map_sg,
>  	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>  		 int ents, enum dma_data_direction dir, unsigned long attrs),
> @@ -282,9 +284,12 @@ TRACE_EVENT(dma_map_sg,
>  
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
> -		__dynamic_array(u64, phys_addrs, nents)
> -		__dynamic_array(u64, dma_addrs, ents)
> -		__dynamic_array(unsigned int, lengths, ents)
> +		__field(int, full_nents)
> +		__field(int, full_ents)
> +		__field(bool, truncated)
> +		__dynamic_array(u64, phys_addrs,  min(nents, DMA_TRACE_MAX_ENTRIES))
> +		__dynamic_array(u64, dma_addrs, min(ents, DMA_TRACE_MAX_ENTRIES))
> +		__dynamic_array(unsigned int, lengths, min(ents, DMA_TRACE_MAX_ENTRIES))
>  		__field(enum dma_data_direction, dir)
>  		__field(unsigned long, attrs)
>  	),
> @@ -292,11 +297,16 @@ TRACE_EVENT(dma_map_sg,
>  	TP_fast_assign(
>  		struct scatterlist *sg;
>  		int i;
> +		int traced_nents = min_t(int, nents, DMA_TRACE_MAX_ENTRIES);
> +		int traced_ents = min_t(int, ents, DMA_TRACE_MAX_ENTRIES);
>  
>  		__assign_str(device);
> -		for_each_sg(sgl, sg, nents, i)
> +		__entry->full_nents = nents;
> +		__entry->full_ents = ents;
> +		__entry->truncated = (nents > DMA_TRACE_MAX_ENTRIES) || (ents > DMA_TRACE_MAX_ENTRIES);
> +		for_each_sg(sgl, sg, traced_nents, i)
>  			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
> -		for_each_sg(sgl, sg, ents, i) {
> +		for_each_sg(sgl, sg, traced_ents, i) {
>  			((u64 *)__get_dynamic_array(dma_addrs))[i] =
>  				sg_dma_address(sg);
>  			((unsigned int *)__get_dynamic_array(lengths))[i] =
> @@ -306,9 +316,12 @@ TRACE_EVENT(dma_map_sg,
>  		__entry->attrs = attrs;
>  	),
>  
> -	TP_printk("%s dir=%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
> +	TP_printk("%s dir=%s nents=%d/%d ents=%d/%d%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
>  		__get_str(device),
>  		decode_dma_data_direction(__entry->dir),
> +		min_t(int, __entry->full_nents, DMA_TRACE_MAX_ENTRIES), __entry->full_nents,
> +		min_t(int, __entry->full_ents, DMA_TRACE_MAX_ENTRIES), __entry->full_ents,
> +		__entry->truncated ? " [TRUNCATED]" : "",
>  		__print_array(__get_dynamic_array(dma_addrs),
>  			      __get_dynamic_array_len(dma_addrs) /
>  				sizeof(u64), sizeof(u64)),

Reviwed-by: Sean Anderson <sean.anderson@linux.dev>

Although it's a bit unusual that there's no limit on dynamic arrays like there is for %*ph.
