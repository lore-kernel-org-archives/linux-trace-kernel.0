Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568B3043D8;
	Tue,  2 Dec 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661999; cv=none; b=HA6E9KBciH7YTaj63+eyDQo4unHCvFnOAiqdTD06oqWEvs7skQWj4/bOeFZgqAOiAjxJnyKr1cxd7RNXgT7teRdKh0bkp9300w5AolNYT4Sz3E+pApJSpKjmNv93illTjaEf0F085eZ8BiE7tjaRRJvB/OrxGGKMewz2UcvHOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661999; c=relaxed/simple;
	bh=a5Yom6muXdU8znppGHz4/ry6dYtXv9L9bvKwGC5Umjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K78Y0wuca7ErHBVLHt0h4PxYlPQFvlqZ1UJjEDFxrpFTObcSjqndKQlnhGYugogK3oOPU7JzBpzQzcUcvQkhiL7LUk2o46mK0dHEsnFvDCmT/nQ2Paz74uFZ84hx1bq/XqDNBP42BPcvoV/Z/otjwfcZoX4oOeEIKvRsN/R0c3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=St7uTVSS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="St7uTVSS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764661994; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V4loCZFItKzWub1Mw+gmTM0Qo7GDtzfcb9k6DM+79VY=;
	b=St7uTVSSRAxzbE3pbga1/E9zgmKVVCOa9JB1ZqA1W659L0XFa1zrYq/4gB/t3aQtN7L6c09rctxLyWxvBWelkOas/Mtdb2P/rsgQF22N3irZM8hFXTTl2DC6D3c5+fCyZJ8qWd24c7yy3JjygM3ekReB/K7lmWsNSzT1gf3PXDY=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WtveLei_1764661989 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 15:53:11 +0800
Message-ID: <09821512-dbfe-4577-8b42-31df8328a998@linux.alibaba.com>
Date: Tue, 2 Dec 2025 15:53:09 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 mm-new 07/16] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-8-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251201174627.23295-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/2 01:46, Nico Pache wrote:
> The current mechanism for determining mTHP collapse scales the
> khugepaged_max_ptes_none value based on the target order. This
> introduces an undesirable feedback loop, or "creep", when max_ptes_none
> is set to a value greater than HPAGE_PMD_NR / 2.
> 
> With this configuration, a successful collapse to order N will populate
> enough pages to satisfy the collapse condition on order N+1 on the next
> scan. This leads to unnecessary work and memory churn.
> 
> To fix this issue introduce a helper function that will limit mTHP
> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> This effectively supports two modes:
> 
> - max_ptes_none=0: never introduce new none-pages for mTHP collapse.
> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>    available mTHP order.
> 
> This removes the possiblilty of "creep", while not modifying any uAPI
> expectations. A warning will be emitted if any non-supported
> max_ptes_none value is configured with mTHP enabled.
> 
> The limits can be ignored by passing full_scan=true, this is useful for
> madvise_collapse (which ignores limits), or in the case of
> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> collapse is available.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8dab49c53128..f425238d5d4f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -463,6 +463,44 @@ void __khugepaged_enter(struct mm_struct *mm)
>   		wake_up_interruptible(&khugepaged_wait);
>   }
>   
> +/**
> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
> + * @order: The folio order being collapsed to
> + * @full_scan: Whether this is a full scan (ignore limits)
> + *
> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> + *
> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
> + * khugepaged_max_ptes_none value.
> + *
> + * For mTHP collapses, we currently only support khugepaged_max_pte_none values
> + * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and no mTHP
> + * collapse will be attempted
> + *
> + * Return: Maximum number of empty PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
> +{
> +	/* ignore max_ptes_none limits */
> +	if (full_scan)
> +		return HPAGE_PMD_NR - 1;
> +
> +	if (!is_mthp_order(order))
> +		return khugepaged_max_ptes_none;
> +
> +	/* Zero/non-present collapse disabled. */
> +	if (!khugepaged_max_ptes_none)
> +		return 0;
> +
> +	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
> +		return (1 << order) - 1;
> +
> +	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %d\n",
> +		      HPAGE_PMD_NR - 1);
> +	return -EINVAL;
> +}

Thanks. That aligns with what we talked about previously. So
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
