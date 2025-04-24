Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27371DCB09;
	Thu, 24 Apr 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481523; cv=none; b=u80pz2zp2gf4nChJDxFoSJTgz7j0Uwu5wE7aH3qMAsE06F3JbuZeZbc/dohOLdWYFiQ0hPMntidUnJB0r5WayraRz4PNAs8enFqJyY/urixGhgEaLqGEPWzezg5CLOprWRoVq2IEGQqVbnxw8oSM9uvWd6EuKLw6joZbLXpW2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481523; c=relaxed/simple;
	bh=tiwn9v3aK9K6L91aMY8XVChRQjqYycpigDSG2isrsx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTxCEa5Sowj/mbkHvc4V7oqtnwnTJViEgnvCuVw7A/YIQgiAJP10kqyStiuetMuoq/Dt7tmOr0XZAD5X8BTwnktpnDGznLsIzGPlwEuNXc/Mts1F0p3PvDP64+xeYVGyEovzYo76VcnAmIaVQjb5U6O5tHArpughzxuiJeHi8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nFgtRDSK; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nFgtRDSK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745481516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H0gocb5iI1crfNKS2sNjti9gog88ZtstDnT2iPYTsTI=;
	b=nFgtRDSKzkLCMaQBwicR0BY8cIjI9Bh7Jil5R1taaIrnZsTnOaXgn27oQbY1mS7xwVIHXz9ZOuSO/PrxOY7H7uSyqvBxmlooL76ZrnSNWraXZReNckOeKJOzx/YsWDce5WyeHd+vT/mPZ9UDBXFwyuDh0S0L5PnrU8jspos5dWg=
Received: from 30.74.146.225(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXyI6u0_1745481512 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 15:58:33 +0800
Message-ID: <30180bde-d813-40dd-83f4-0cc04daf6df6@linux.alibaba.com>
Date: Thu, 24 Apr 2025 15:58:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] khugepaged: add per-order mTHP khugepaged stats
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-12-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-12-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> With mTHP support inplace, let add the per-order mTHP stats for
> exceeding NONE, SWAP, and SHARED.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   include/linux/huge_mm.h |  3 +++
>   mm/huge_memory.c        |  7 +++++++
>   mm/khugepaged.c         | 16 +++++++++++++---
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 55b242335420..782d3a7854b4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -139,6 +139,9 @@ enum mthp_stat_item {
>   	MTHP_STAT_SPLIT_DEFERRED,
>   	MTHP_STAT_NR_ANON,
>   	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +	MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> +	MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>   	__MTHP_STAT_COUNT
>   };
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7798c9284533..de4704af0022 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -633,6 +633,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
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
> @@ -649,6 +653,9 @@ static struct attribute *anon_stats_attrs[] = {
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
> index 67da0950b833..38643a681ba5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -604,7 +604,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
> @@ -633,8 +636,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
> @@ -1060,6 +1069,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   
>   		/* Dont swapin for mTHP collapse */
>   		if (order != HPAGE_PMD_ORDER) {
> +			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);

Should be MTHP_STAT_COLLAPSE_EXCEED_SWAP?

>   			result = SCAN_EXCEED_SWAP_PTE;
>   			goto out;
>   		}
