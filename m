Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4142AF8D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661011; cv=none; b=LWOZB0DQqbEnYrJ4pBv96eJuTS0HDz1g7372vu6PofvcsRXaakQUiCGudRpCyQG7likR77pzdJJtzkbuECchqHs4xOwQ1eC7bYFQ4aUYwiZiClctt4YWU05NisZf1WellIbzg6sj8hvJ4IHUmfx9q8zMOpMzbE4NoyuBqLc8KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661011; c=relaxed/simple;
	bh=DBxi0BOOwrT4xCseyDgm+w1BLMxRq77pCreq5EfGDkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=hU3/z/+e2MnefuVCr6tikARBLNZhI9uP6QzY9pzI0mw01HZxeLIeb/FNygi+DeeHG7DN3nkEEzS1y80OeDuq3EXsI9xveJdYROiLX1eVVfZf8vhG2YfI+hLfIoQHdycdNEo2CgJmTOZsZNZ8lBYmKf+5i2MSJhQleg1Z4zRpOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M/plwnle; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M/plwnle"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260825123000euoutp01f11288c1bf4b3012b38ac39ff50f11bc~PDDVfOMMv0908509085euoutp01b
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 12:30:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260825123000euoutp01f11288c1bf4b3012b38ac39ff50f11bc~PDDVfOMMv0908509085euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787661000;
	bh=/CFXDg3L0aD6SB3xy+cQUqcdazmfSamoOM2pD2VK9/8=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=M/plwnleb557HnWW2Dgy9vnFWSWbm89jMkXmfdBPQP4QBiSMtpwH1WVf0GPG0YzkB
	 gifzRvzJLk6W7MqMdMgDOgPSNREwbE762LekRDsHSM41/dqjMNjK0W8f2FmZQdds1C
	 PimsNKW8gsS17sEJpl3sKl4RVUT9KVaiQ48N53po=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260825123000eucas1p248f943e21b217192142c843eb427dd76~PDDVEpmia1504115041eucas1p2S;
	Tue, 25 Aug 2026 12:30:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260825122959eusmtip1bd8675e1e80e324fa87b118bf74d4d66~PDDULpsjo1767517675eusmtip1d;
	Tue, 25 Aug 2026 12:29:59 +0000 (GMT)
Message-ID: <e7605d7a-85f1-4339-99d2-85c0df884ec2@samsung.com>
Date: Tue, 25 Aug 2026 14:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 05/10] mm/cma: Introduce cma_alloc_at() API
To: "David Hildenbrand (Arm)" <david@kernel.org>, Thierry Reding
	<thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan
	Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Content-Language: en-US
In-Reply-To: <ae6c93e6-10f2-4bac-be61-118bbfc3c05d@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260825123000eucas1p248f943e21b217192142c843eb427dd76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260820180431eucas1p21be3f213606c4dbef2e4a73a2c1623f0
X-EPHeader: CA
X-CMS-RootMailID: 20260820180431eucas1p21be3f213606c4dbef2e4a73a2c1623f0
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
	<20260814-tegra-vpr-v5-5-71832b5d0246@nvidia.com>
	<CGME20260820180431eucas1p21be3f213606c4dbef2e4a73a2c1623f0@eucas1p2.samsung.com>
	<ae6c93e6-10f2-4bac-be61-118bbfc3c05d@kernel.org>

On 20.08.2026 20:04, David Hildenbrand (Arm) wrote:
>> /* This part must be outside protection */> diff --git a/mm/cma.c b/mm/cma.c
>> index a10ea37a261d..1e1ebae79090 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -936,6 +936,141 @@ struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
>> return __cma_alloc_frozen(cma, 1 << order, order, gfp);
>> }
>> +static int cma_range_alloc_at(struct cma *cma, struct cma_memrange *cmr,
>> + unsigned long offset, unsigned long count,
>> + struct page **pagep, gfp_t gfp)
>> +{
>> + struct page *page = NULL;
>> + unsigned long pfn;
>> + int ret = -EBUSY;
>> +
>> + spin_lock_irq(&cma->lock);
>> +
>> + /*
>> + * If the request is larger than the available number of pages, stop
>> + * right away.
>> + */
>> + if (count > cma->available_count)
>> + goto unlock;
>> +
>> + ret = bitmap_allocate(cmr->bitmap, offset, count);
>> + if (ret < 0)
>> + goto unlock;
>> +
>> + pfn = cmr->base_pfn + offset;
>> + page = pfn_to_page(pfn);
>> +
>> + /*
>> + * Do not hand out page ranges that are not contiguous, so
>> + * callers can just iterate the pages without having to worry
>> + * about these corner cases.
>> + */
>> + if (!page_range_contiguous(page, count)) {
>> + pr_warn_ratelimited("%s: %s: skipping non-contiguous area [0x%lx-0x%lx]",
>> + __func__, cma->name, pfn, pfn + count - 1);
>> + ret = -EBUSY;
>> + goto clear;
>> + }
>> +
>> + cma->available_count -= count;
>> +
>> + /*
>> + * It's safe to drop the lock here. We've marked this region for
>> + * our exclusive use. If the migration fails we will take the
>> + * lock again and unmark it.
>> + */
>> + spin_unlock_irq(&cma->lock);
>> +
>> + mutex_lock(&cma->alloc_mutex);
>> + ret = alloc_contig_frozen_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
>> + mutex_unlock(&cma->alloc_mutex);
>> +
> There is quite some code duplication with cma_range_alloc(). Please try harder
> to factor common code out and reuse it.
>
>
> > ...
> Also here, way too much code duplication with __cma_alloc_frozen().
>
> There must be a better way :)

Maybe the existing 'alloc' functions could call 'alloc_at' variant internally

(with locks adjusted and moved out).


> (I really prefer this direction of the patch set)

Definitely, I also like this approach much more than previous attempt with

'dynamically' instantiated cma regions.



Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

