Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7C1E8851
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521440; cv=none; b=PROZQSH6V6wdZaVv0V87VT8GrHMuuCpBZpEwm3dD30Uy3V9xwprRdx2WQByQiXRiMn9/OK7W1o13kcx8xC9x6mrCjvcJV1KHZFNbcooJpUhfxjy6y3hNyiBZkV7f/xwgjhzP4srxJ2UcoTe8kRD+tGEIYi1kZzsvMhX5YBh7E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521440; c=relaxed/simple;
	bh=w9UslHje9Y25HqAgD6FbzkeP4dbMjaWhYX4yiay4hlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY0Yv80K5c59Cv3BcAHhDhqZwuZiJomwM+VNiy2VmyOPc16PrNwEX62aESIVzyLXBR6g/Qjr3BnrOq+uNTKbwWLYTABZgz0gtWKvpgEN2YQiYnzQf9b6VhR7hY8cmaBSf+ahJIXztUdIW70TJ2mDiRLNVQScqAMd23dNuRL3g9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJ2u1bPs; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJ2u1bPs"
Message-ID: <a61b0a48-d55b-494b-a7e8-04b02dc87e21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729521431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mA3Yw+C9FhQPBZ1Ah8zRphQ8BomtwMtOAV4fpiUEPcc=;
	b=eJ2u1bPspCyKDFZxOYZF29T/F5YR3lGU6492LgXb8AdIZzBVRtPhQseMWnXFwjoj34pFEu
	sKP9lxrJA6CzixQ0rwCZRsSEeqU1ooRRSJ6G80JOv6L/YeQ25aqCDcIEKGNfoJG6jYhjZq
	9PhKEImi9KUCn+kUt8TkQPdAmugnTuc=
Date: Mon, 21 Oct 2024 10:37:07 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] dma-mapping: Trace more error paths
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20241017181354.2834674-1-sean.anderson@linux.dev>
 <20241017181354.2834674-4-sean.anderson@linux.dev>
 <5e01b376-b905-4775-badf-41d31d2a821c@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <5e01b376-b905-4775-badf-41d31d2a821c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/21/24 06:38, Robin Murphy wrote:
> On 2024-10-17 7:13 pm, Sean Anderson wrote:
>> It can be surprising to the user if DMA functions are only traced on
>> success. On failure, it can be unclear what the source of the problem
>> is. Fix this by tracing all functions even when they fail. Cases where
>> we BUG/WARN are skipped, since those should be sufficiently noisy
>> already.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   include/trace/events/dma.h | 41 ++++++++++++++++++++++++++++++++++++++
>>   kernel/dma/mapping.c       | 27 +++++++++++++++++--------
>>   2 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>> index 9bc647f9ad4d..321cce327404 100644
>> --- a/include/trace/events/dma.h
>> +++ b/include/trace/events/dma.h
>> @@ -161,6 +161,12 @@ DEFINE_EVENT(_dma_alloc, dma_alloc_pages,
>>            unsigned long attrs),
>>       TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
>>   +DEFINE_EVENT(_dma_alloc, dma_alloc_sgt_err,
>> +    TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
>> +         size_t size, enum dma_data_direction dir, gfp_t flags,
>> +         unsigned long attrs),
>> +    TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
>> +
>>   TRACE_EVENT(dma_alloc_sgt,
>>       TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
>>            enum dma_data_direction dir, gfp_t flags, unsigned long attrs),
>> @@ -325,6 +331,41 @@ TRACE_EVENT(dma_map_sg,
>>           decode_dma_attrs(__entry->attrs))
>>   );
>>   +TRACE_EVENT(dma_map_sg_err,
>> +    TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>> +         int err, enum dma_data_direction dir, unsigned long attrs),
>> +    TP_ARGS(dev, sgl, nents, err, dir, attrs),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(device, dev_name(dev))
>> +        __dynamic_array(u64, phys_addrs, nents)
>> +        __field(int, err)
>> +        __field(enum dma_data_direction, dir)
>> +        __field(unsigned long, attrs)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        struct scatterlist *sg;
>> +        int i;
>> +
>> +        __assign_str(device);
>> +        for_each_sg(sgl, sg, nents, i)
>> +            ((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
>> +        __entry->err = err;
>> +        __entry->dir = dir;
>> +        __entry->attrs = attrs;
>> +    ),
>> +
>> +    TP_printk("%s dir=%s dma_addrs=%s err=%d attrs=%s",
>> +        __get_str(device),
>> +        decode_dma_data_direction(__entry->dir),
>> +        __print_array(__get_dynamic_array(phys_addrs),
>> +                  __get_dynamic_array_len(phys_addrs) /
>> +                sizeof(u64), sizeof(u64)),
>> +        __entry->err,
>> +        decode_dma_attrs(__entry->attrs))
>> +);
>> +
>>   TRACE_EVENT(dma_unmap_sg,
>>       TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>>            enum dma_data_direction dir, unsigned long attrs),
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index b8a6bc492fae..636dbb0629a4 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -223,6 +223,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>           debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
>>       } else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
>>                   ents != -EIO && ents != -EREMOTEIO)) {
>> +        trace_dma_map_sg_err(dev, sg, nents, ents, dir, attrs);
> 
> Isn't this just a case of moving the existing tracepoint up outside the "if (ents > 0)" condition?

This is a separate tracepoint (_err) to simplify collecting/printing the
addresses.

> 
>>           return -EIO;
>>       }
>>   @@ -604,20 +605,26 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>       if (WARN_ON_ONCE(flag & __GFP_COMP))
>>           return NULL;
>>   -    if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>> +    if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
>> +        trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
>> +                DMA_BIDIRECTIONAL, flag, attrs);
>>           return cpu_addr;
>> +    }
>>         /* let the implementation decide on the zone to allocate from: */
>>       flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>>   -    if (dma_alloc_direct(dev, ops))
>> +    if (dma_alloc_direct(dev, ops)) {
>>           cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
>> -    else if (use_dma_iommu(dev))
>> +    } else if (use_dma_iommu(dev)) {
>>           cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
>> -    else if (ops->alloc)
>> +    } else if (ops->alloc) {
>>           cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
>> -    else
>> +    } else {
>> +        trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
>> +                attrs);
>>           return NULL;
> 
> Similarly just move this return down past the tracepoint, same as the hunk below?

OK

>> +    }
>>         trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
>>               flag, attrs);
>> @@ -642,11 +649,11 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>>        */
>>       WARN_ON(irqs_disabled());
>>   -    if (!cpu_addr)
>> -        return;
>> -
>>       trace_dma_free(dev, cpu_addr, dma_handle, size, DMA_BIDIRECTIONAL,
>>                  attrs);
>> +    if (!cpu_addr)
>> +        return;
>> +
>>       debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
>>       if (dma_alloc_direct(dev, ops))
>>           dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
>> @@ -688,6 +695,8 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
>>           trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
>>                         size, dir, gfp, 0);
>>           debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
>> +    } else {
>> +        trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
> 
> Could we move the page_to_virt() into the event definiton and let that handle NULL, then similarly hoist the tracepoint out of the condition?

Then we cannot reuse the event class for trace_dma_alloc, which does not
have a struct page available.

>>       }
>>       return page;
>>   }
>> @@ -772,6 +781,8 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>>           sgt->nents = 1;
>>           trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
>>           debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
>> +    } else {
>> +        trace_dma_alloc_sgt_err(dev, NULL, 0, size, gfp, dir, attrs);
> 
> And again similarly here - if I'm interested in calls to dma_alloc_contiguous(), I'd rather have a "dma_alloc_contiguous" tracepoint which can tell me both the arguments and the result at a glance, than have to remember to trace two distinct other things based on internal details.

Isn't it a case of just doing `perf record -e 'dma:dma_alloc_sgt*'`?

Fundamentally, these events have different information available, and
dealing with this in a generic manner is inconvenient.

--Sean
