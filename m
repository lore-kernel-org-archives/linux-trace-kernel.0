Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280426A0AB;
	Wed, 23 Apr 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393412; cv=none; b=ZeiAM0ZLNploGQupcki2heJkk3xr5m0gWYsacfIiznTZev88LEqpJSEc5qZ4QM+5h6dE5EDKrnMipEo03jHjQ2OaPyu5fwuBGmp5LXFgOjB7j2lguUvzeULmX1+TKnDOX9Z2S+6VW5K0dnK7NKasl0I3I5k2r5dERBlMXkKA6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393412; c=relaxed/simple;
	bh=o+phP31kmrAYsA7kQQZnwNWQ6u/lBY83aHaSbMuUKkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJCFhcBgL4VYef/Xw9sIVSYQJhR2LPlfhgOxuu/2+U4SW4/anTaa18f/tvPaYQOdeiEf/W25gt7LY6VCfp6cKNaVkBFY9wAe/tRTHycQvLk+l2hIrk6nFby31RkNdzV/eF9Iog0/fEOXvwhHfQP+fceQUZ98LpmtuE+VKL479go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s4yOJDK4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s4yOJDK4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745393406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lH4lDINRe2o7t1vSewfvz5VOPesF2wiTgnlvHI8Ti7Y=;
	b=s4yOJDK4EVklcxUrVbpwCkhrArbBuH1BZn2dLeKsJAKBARNsh0UvndxnnijhwTAcpAjzzDaQDUQR8kMhbZPza0ymsN0EIBg3mmAgTP8z1jKsdGX9xjMS/52zHKr4YbEURQ1OTaFYMVtoKLqh4odcChasPsiuyLhFirFm6Bxacno=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXtXXfj_1745393402 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 15:30:03 +0800
Message-ID: <e4e4aaae-92be-4cd2-9435-dccad99961bf@linux.alibaba.com>
Date: Wed, 23 Apr 2025 15:30:02 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
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
 <20250417000238.74567-6-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-6-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> generalize the order of the __collapse_huge_page_* functions
> to support future mTHP collapse.
> 
> mTHP collapse can suffer from incosistant behavior, and memory waste
> "creep". disable swapin and shared support for mTHP collapse.
> 
> No functional changes in this patch.
> 
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 46 ++++++++++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 883e9a46359f..5e9272ab82da 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -565,15 +565,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					unsigned long address,
>   					pte_t *pte,
>   					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +					struct list_head *compound_pagelist,
> +					u8 order)
>   {
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	pte_t *_pte;
>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>   	bool writable = false;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -581,7 +583,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
>   			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= scaled_none)) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -609,8 +611,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See hpage_collapse_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> +			    shared > khugepaged_max_ptes_shared)) {
>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;
> @@ -711,13 +713,14 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   						struct vm_area_struct *vma,
>   						unsigned long address,
>   						spinlock_t *ptl,
> -						struct list_head *compound_pagelist)
> +						struct list_head *compound_pagelist,
> +						u8 order)
>   {
>   	struct folio *src, *tmp;
>   	pte_t *_pte;
>   	pte_t pteval;
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> @@ -764,7 +767,8 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   					     pmd_t *pmd,
>   					     pmd_t orig_pmd,
>   					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +					     struct list_head *compound_pagelist,
> +					     u8 order)
>   {
>   	spinlock_t *pmd_ptl;
>   
> @@ -781,7 +785,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   	 * Release both raw and compound pages isolated
>   	 * in __collapse_huge_page_isolate.
>   	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + (1 << order), compound_pagelist);
>   }
>   
>   /*
> @@ -802,7 +806,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>   		unsigned long address, spinlock_t *ptl,
> -		struct list_head *compound_pagelist)
> +		struct list_head *compound_pagelist, u8 order)
>   {
>   	unsigned int i;
>   	int result = SCAN_SUCCEED;
> @@ -810,7 +814,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   	/*
>   	 * Copying pages' contents is subject to memory poison at any iteration.
>   	 */
> -	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +	for (i = 0; i < (1 << order); i++) {
>   		pte_t pteval = ptep_get(pte + i);
>   		struct page *page = folio_page(folio, i);
>   		unsigned long src_addr = address + i * PAGE_SIZE;
> @@ -829,10 +833,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   
>   	if (likely(result == SCAN_SUCCEED))
>   		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
> -						    compound_pagelist);
> +						    compound_pagelist, order);
>   	else
>   		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 compound_pagelist, order);
>   
>   	return result;
>   }
> @@ -1000,11 +1004,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>   static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   				       struct vm_area_struct *vma,
>   				       unsigned long haddr, pmd_t *pmd,
> -				       int referenced)
> +				       int referenced, u8 order)
>   {
>   	int swapped_in = 0;
>   	vm_fault_t ret = 0;
> -	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long address, end = haddr + (PAGE_SIZE << order);
>   	int result;
>   	pte_t *pte = NULL;
>   	spinlock_t *ptl;
> @@ -1035,6 +1039,12 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;
>   
> +		/* Dont swapin for mTHP collapse */
> +		if (order != HPAGE_PMD_ORDER) {
> +			result = SCAN_EXCEED_SWAP_PTE;
> +			goto out;
> +		}

IMO, this check should move into hpage_collapse_scan_pmd(), that means 
if we scan the swap ptes for mTHP collapse, then we can return 
'SCAN_EXCEED_SWAP_PTE' to abort the collapse earlier.

The logic is the same as how you handle the shared ptes for mTHP.

>   		vmf.pte = pte;
>   		vmf.ptl = ptl;
>   		ret = do_swap_page(&vmf);
> @@ -1154,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		 * that case.  Continuing to collapse causes inconsistency.
>   		 */
>   		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -						     referenced);
> +				referenced, HPAGE_PMD_ORDER);
>   		if (result != SCAN_SUCCEED)
>   			goto out_nolock;
>   	}
> @@ -1201,7 +1211,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>   	if (pte) {
>   		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -						      &compound_pagelist);
> +					&compound_pagelist, HPAGE_PMD_ORDER);
>   		spin_unlock(pte_ptl);
>   	} else {
>   		result = SCAN_PMD_NULL;
> @@ -1231,7 +1241,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   
>   	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>   					   vma, address, pte_ptl,
> -					   &compound_pagelist);
> +					   &compound_pagelist, HPAGE_PMD_ORDER);
>   	pte_unmap(pte);
>   	if (unlikely(result != SCAN_SUCCEED))
>   		goto out_up_write;
