Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B321FF3E;
	Tue,  8 Jul 2025 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954964; cv=none; b=MY9ek3bE5uqmPvcgQ57ogyb9qwr4HSvrlbxEtbKVB1NNTqTEGFT51cv27XzRR+9GJ0XYor0tOocvZ1GLejU+hyojYBU6vKXCPK7+M7bxWZhE3109ft1clwOo1pso/SsqOxWFnWzEoo/4XdphEh6zXB1q0rMmPVYstz22zVsOIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954964; c=relaxed/simple;
	bh=pPOo+ktL9Tfotnr6ffVPd/vkVlhcENzcynw9OZkpRdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZVQoHWFNAuN51sU9qSrCVVUe+79TrK9KzsG1S50/LD4tov9c2181xO4Cw3lm1ff0+LkdLzPIQIwG13fgJPcRutPVaFBuhdlc+BozruQmnLjEzgc8WXvDoU2xFQqvJvXDVqvF67nw3BhRzsYReCqBEu2AxMuqstp5N2wQY8ZBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WgtQwHLl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WgtQwHLl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751954952; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zh0GZgGllEOdHJ4JfcnZXS605Yci87SIRFoTaKVIHL0=;
	b=WgtQwHLlxa1M42TBYI2ooP+5blNjMNxRxKxO/rzsAKwzRNXLL0wgQWfy0BinSS22T84tqW925Z5dR+ww8BbOLhpaCXZ7CIPfKZ9n9yR8UHYcRaeVHS0O8E8aAyKwCV8llTrVr/V63XG3a6KVM/PLPZQEkDPmAbVpystHaQzOq3s=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiL4DJh_1751954947 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:09:08 +0800
Message-ID: <342d5fe1-cd39-462c-b2a4-b5d6979a8a21@linux.alibaba.com>
Date: Tue, 8 Jul 2025 14:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/15] khugepaged: add per-order mTHP khugepaged stats
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-15-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250702055742.102808-15-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/2 13:57, Nico Pache wrote:
> With mTHP support inplace, let add the per-order mTHP stats for
> exceeding NONE, SWAP, and SHARED.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   include/linux/huge_mm.h |  3 +++
>   mm/huge_memory.c        |  7 +++++++
>   mm/khugepaged.c         | 15 ++++++++++++---
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index a6ea89fdaee6..6034b4c9dae5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -141,6 +141,9 @@ enum mthp_stat_item {
>   	MTHP_STAT_SPLIT_DEFERRED,
>   	MTHP_STAT_NR_ANON,
>   	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +	MTHP_STAT_COLLAPSE_EXCEED_SWAP,

This stat seems never used.

> +	MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>   	__MTHP_STAT_COUNT
>   };

Please also update the 'Documentation/admin-guide/mm/transhuge.rst' for 
these new statistics.

>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 69777a35e722..3eb1c34be601 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -632,6 +632,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>   DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>   DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> +
>   
>   static struct attribute *anon_stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
> @@ -648,6 +652,9 @@ static struct attribute *anon_stats_attrs[] = {
>   	&split_deferred_attr.attr,
>   	&nr_anon_attr.attr,
>   	&nr_anon_partially_mapped_attr.attr,
> +	&collapse_exceed_swap_pte_attr.attr,
> +	&collapse_exceed_none_pte_attr.attr,
> +	&collapse_exceed_shared_pte_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2c0962637c34..636b84bf1ca1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -594,7 +594,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				if (order == HPAGE_PMD_ORDER)
> +					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				else
> +					count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
>   				goto out;
>   			}
>   		}
> @@ -623,8 +626,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See khugepaged_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared)) {
> +			if (order != HPAGE_PMD_ORDER) {
> +				result = SCAN_EXCEED_SHARED_PTE;
> +				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> +				goto out;
> +			}
> +
> +			if (cc->is_khugepaged &&
> +				shared > khugepaged_max_ptes_shared) {
>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;

