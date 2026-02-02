Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B42248A8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046458; cv=none; b=tleUsS5h2UFAi2faliAXqEXcOcjqBbL1+Ie0YTG5j4fOYPjzCdGENX2Xg4YSG+IqYTvIQ2FzSxKLsnLFXpKmPCj/I3dsLNUoDqJLbCyHjWyjqcVZ45CTjJ68W7wHkmVOoHmi3hhVMQ2JneLbZe5HmUM+ORG4KT+ASGQBPamoxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046458; c=relaxed/simple;
	bh=bLG1Jgr6mMCPedSXLq9DXOo7QoXM+k7SdGc/ctljiq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hFDXmE/bgJXKtU+hWu7L4k1ut1BzywCmh0E5Mxf+2/HNSHwJ7KYaW6nClKVRP2xWa+9X80wSG+odh6/08bViPjw2glhfpUUQIk4YssnHduSPTI3pRVb1CyoUVKXRbrhp1ycp+vHeevNqZbVHFHICWgIYshNjbaSU3XmMoy4GfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VrIqt9qe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VrIqt9qe"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260202153408euoutp0258d8cb1ace296074ebad11c775e12159~Qd930p4Yh0749907499euoutp02g
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 15:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260202153408euoutp0258d8cb1ace296074ebad11c775e12159~Qd930p4Yh0749907499euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770046448;
	bh=/rFXgi0S415xV9XINCPrkrW6y6+J9uLi84djYLOpsXE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VrIqt9qe2rt67ypWw3RqoxamZx1jEOE5e/BDQgAYKPOVMQbnXf+9b/Lis4pz/bIIQ
	 wNacQneZkbFnSxJKTw0/IltK4+Yh/rtfSot4dUX+FlY40TE+aZ4a4gVY2JgHSwZkp0
	 QGhWkXUKuuNMZ72YekxDaIBUsqeIhW+rRRuEN8jA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260202153408eucas1p11f6d79397d0b375e43f203278e76a546~Qd93fUDXG0250302503eucas1p1v;
	Mon,  2 Feb 2026 15:34:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260202153407eusmtip2767ebec8c8e9a24b576e50637c6680b4~Qd928QCRt2681226812eusmtip2R;
	Mon,  2 Feb 2026 15:34:07 +0000 (GMT)
Message-ID: <df4d15d9-5a6a-4a16-8600-b4b2217d928d@samsung.com>
Date: Mon, 2 Feb 2026 16:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] tracing/dma: Cap dma_map_sg tracepoint arrays to
 prevent buffer overflow
To: Deepanshu Kartikey <kartikey406@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ptesarik@suse.com
Cc: jgg@ziepe.ca, leon@kernel.org, kbusch@kernel.org,
	sean.anderson@linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260130155215.69737-1-kartikey406@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260202153408eucas1p11f6d79397d0b375e43f203278e76a546
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260130155235eucas1p2d71cf12e01f087b12707aea009c68d8e
X-EPHeader: CA
X-CMS-RootMailID: 20260130155235eucas1p2d71cf12e01f087b12707aea009c68d8e
References: <CGME20260130155235eucas1p2d71cf12e01f087b12707aea009c68d8e@eucas1p2.samsung.com>
	<20260130155215.69737-1-kartikey406@gmail.com>

On 30.01.2026 16:52, Deepanshu Kartikey wrote:
> The dma_map_sg tracepoint can trigger a perf buffer overflow when
> tracing large scatter-gather lists. With devices like virtio-gpu
> creating large DRM buffers, nents can exceed 1000 entries, resulting
> in:
>
>    phys_addrs: 1000 * 8 bytes = 8,000 bytes
>    dma_addrs:  1000 * 8 bytes = 8,000 bytes
>    lengths:    1000 * 4 bytes = 4,000 bytes
>    Total: ~20,000 bytes
>
> This exceeds PERF_MAX_TRACE_SIZE (8192 bytes), causing:
>
>    WARNING: CPU: 0 PID: 5497 at kernel/trace/trace_event_perf.c:405
>    perf buffer not large enough, wanted 24620, have 8192
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
>    instead of fixed DMA_TRACE_MAX_ENTRIES allocation (feedback from
>    Steven Rostedt)
> - This allocates only what's needed up to the cap, avoiding waste
>    for small operations
>
> Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
> Closes: https://protect2.fireeye.com/v1/url?k=6e1b074b-0f901278-6e1a8c04-000babff9bb7-c332a06151070595&q=1&e=71ff52e1-1daa-4a0f-81b1-6593694574b3&u=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D28cea38c382fd15e751a
> Tested-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

Applied to dma-mapping-fixes, thanks!

> ---
>   include/trace/events/dma.h | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index b3fef140ae15..33e99e792f1a 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -275,6 +275,8 @@ TRACE_EVENT(dma_free_sgt,
>   				sizeof(u64), sizeof(u64)))
>   );
>   
> +#define DMA_TRACE_MAX_ENTRIES 128
> +
>   TRACE_EVENT(dma_map_sg,
>   	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>   		 int ents, enum dma_data_direction dir, unsigned long attrs),
> @@ -282,9 +284,12 @@ TRACE_EVENT(dma_map_sg,
>   
>   	TP_STRUCT__entry(
>   		__string(device, dev_name(dev))
> -		__dynamic_array(u64, phys_addrs, nents)
> -		__dynamic_array(u64, dma_addrs, ents)
> -		__dynamic_array(unsigned int, lengths, ents)
> +		__field(int, full_nents)
> +		__field(int, full_ents)
> +		__field(bool, truncated)
> +		__dynamic_array(u64, phys_addrs,  min(nents, DMA_TRACE_MAX_ENTRIES))
> +		__dynamic_array(u64, dma_addrs, min(ents, DMA_TRACE_MAX_ENTRIES))
> +		__dynamic_array(unsigned int, lengths, min(ents, DMA_TRACE_MAX_ENTRIES))
>   		__field(enum dma_data_direction, dir)
>   		__field(unsigned long, attrs)
>   	),
> @@ -292,11 +297,16 @@ TRACE_EVENT(dma_map_sg,
>   	TP_fast_assign(
>   		struct scatterlist *sg;
>   		int i;
> +		int traced_nents = min_t(int, nents, DMA_TRACE_MAX_ENTRIES);
> +		int traced_ents = min_t(int, ents, DMA_TRACE_MAX_ENTRIES);
>   
>   		__assign_str(device);
> -		for_each_sg(sgl, sg, nents, i)
> +		__entry->full_nents = nents;
> +		__entry->full_ents = ents;
> +		__entry->truncated = (nents > DMA_TRACE_MAX_ENTRIES) || (ents > DMA_TRACE_MAX_ENTRIES);
> +		for_each_sg(sgl, sg, traced_nents, i)
>   			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
> -		for_each_sg(sgl, sg, ents, i) {
> +		for_each_sg(sgl, sg, traced_ents, i) {
>   			((u64 *)__get_dynamic_array(dma_addrs))[i] =
>   				sg_dma_address(sg);
>   			((unsigned int *)__get_dynamic_array(lengths))[i] =
> @@ -306,9 +316,12 @@ TRACE_EVENT(dma_map_sg,
>   		__entry->attrs = attrs;
>   	),
>   
> -	TP_printk("%s dir=%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
> +	TP_printk("%s dir=%s nents=%d/%d ents=%d/%d%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
>   		__get_str(device),
>   		decode_dma_data_direction(__entry->dir),
> +		min_t(int, __entry->full_nents, DMA_TRACE_MAX_ENTRIES), __entry->full_nents,
> +		min_t(int, __entry->full_ents, DMA_TRACE_MAX_ENTRIES), __entry->full_ents,
> +		__entry->truncated ? " [TRUNCATED]" : "",
>   		__print_array(__get_dynamic_array(dma_addrs),
>   			      __get_dynamic_array_len(dma_addrs) /
>   				sizeof(u64), sizeof(u64)),

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

