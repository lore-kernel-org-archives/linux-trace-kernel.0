Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC428F1;
	Wed, 23 Apr 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392019; cv=none; b=PDXcyggOccSrEQ1BKZe9HrcXU2lWVNAP6I9cLcnuoCAJPvxDqzr6QjBEZVCLvMX/zL0jb8ak7RGU0pNYk4w6zLnUiuO5KtNfkRKlCcKV0exjqulWgMz4AjGFOSIYYWc69uoxLqNpm+R1enWwq1ueypQvLm4luI2lXnR9S8otRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392019; c=relaxed/simple;
	bh=xpATX4YPLLbunDJY/h6rrrlMjarYrKzu1tsDc/qnu5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mblSIJLpIHQbC4QhdiWf/uatA+fSEISOtvUr2/wnUxODi0h5T7e6+p+Lx73kK0AQwB0QBiReohApKwuvpT2w/PO0b9XW1ri/QSB1Kf1LRsfHS+o0PEhEaiN/QUCHfSA4sdtvlmzqpQI0u6xC5atVGlSKEd5jyJXg9lYs1HtoQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CFKu/2lA; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CFKu/2lA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745392005; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=thXgRC2w3R+DXRSmVN/fbZ2OtHbJLiM3ElorRiOdk/U=;
	b=CFKu/2lANlPSeSxe+qdrTZrBnZ9slDBHZGvnpS4qxYuuEXGBJSRcL+HBd6DOh0dcyWGFrWtHrfTtkn6ajJqPB44flEIxYlmIG+4yFjETjvQ0PZemfyk1TJ6nJuVUM/8CHTOzUpO083L9Bz33NSyfkvvVldMjI/bfdUj2UxzsJ5c=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXtXK1g_1745392001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 15:06:42 +0800
Message-ID: <977ef858-ea03-4ea7-9420-6275ecd6a40d@linux.alibaba.com>
Date: Wed, 23 Apr 2025 15:06:40 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] khugepaged: generalize alloc_charge_folio()
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
 <20250417000238.74567-5-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-5-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/4/17 08:02, Nico Pache wrote:
> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/huge_mm.h |  2 ++
>   mm/huge_memory.c        |  4 ++++
>   mm/khugepaged.c         | 17 +++++++++++------
>   3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f190998b2ebd..55b242335420 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -123,6 +123,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>   	MTHP_STAT_ZSWPOUT,
>   	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e97a97586478..7798c9284533 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -680,6 +682,8 @@ static struct attribute *any_stats_attrs[] = {
>   #endif
>   	&split_attr.attr,
>   	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 54d7f43da69c..883e9a46359f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1074,21 +1074,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   }
>   
>   static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, u8 order)
>   {
>   	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>   		     GFP_TRANSHUGE);
>   	int node = khugepaged_find_target_node(cc);
>   	struct folio *folio;
>   
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>   	if (!folio) {
>   		*foliop = NULL;
> -		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order == HPAGE_PMD_ORDER)
> +			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>   	}
>   
> -	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order == HPAGE_PMD_ORDER)
> +		count_vm_event(THP_COLLAPSE_ALLOC);
> +	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> +
>   	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {

Nit: while we are at it, why not add a 
‘MTHP_STAT_COLLAPSE_CHARGE_FAILED’, which is the same as anonymous and 
shmem mTHP allocation?

>   		folio_put(folio);
>   		*foliop = NULL;
> @@ -1125,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 */
>   	mmap_read_unlock(mm);
>   
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out_nolock;
>   
> @@ -1849,7 +1854,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>   	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>   
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out;
>   
