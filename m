Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7B2DEA64
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556683; cv=none; b=POCQDC3SRyLQ8Hl0+8fcJlVYiwVFcINu5qAO30a5z2RanhNHnC27uxJxY2+D+SdUZ2Vz6NgHkA1zG4fm6lCLT9xd5BNzcVBWWwGK6rIfKl6bUqZ1Sk37r7SUVd3bGyYw9HPwWe7jNVL7ZviNRjHzos8pVGO/sNkRtBHiD8leb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556683; c=relaxed/simple;
	bh=pr8lCbKq73Mp4PrFh0ihuLm1jAkJ+1oxPzb2i9xJmGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hos6Cw/Mt36cqDtdLdj0IufL2J+DyXodoQAXGUjNeUTZsqag4U5aHVznPIxky6T/AwgftCK1YsTeHbENSX0sja8Bmh13AVqaRFL5HCbbhLXiCLK982ustMZTcrwB90uCbBH0d/cYE0Tw15GJYPgQDTwh7A6pzov+Q3IN+gWakOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a7VpjxJd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a7VpjxJd"
Message-ID: <703b22dc-0123-42ba-9984-074b9cda468c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761556668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dm/mUbcMAMZo9wS8DsBcQxN0CKzM7e2WXj+TwSYfMcs=;
	b=a7VpjxJdsAE7IaId8HUK0fWulHLBBBlPdBgisXLI8HsC5jSpnqn0RWI3TOiFJ+HoLyFGKb
	fOsLV6/nyVa7CRopxslpJS2jE6iPH3Y7UVgkHeh1oxU5h/DTMIp9n83ksu3aSf5DB9BdIe
	AAPk02rr8BVzg6VEVgfCPY6Y71vljfo=
Date: Mon, 27 Oct 2025 17:17:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 mm-new 05/15] khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Content-Language: en-US
To: Nico Pache <npache@redhat.com>
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, linux-mm@kvack.org,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 vbabka@suse.cz, rppt@kernel.org, jannh@google.com, pfalcato@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-6-npache@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251022183717.70829-6-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/23 02:37, Nico Pache wrote:
> generalize the order of the __collapse_huge_page_* functions
> to support future mTHP collapse.
> 
> mTHP collapse will not honor the khugepaged_max_ptes_shared or
> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
> shared or swapped entry.

Yeah, IMHO, it's the right call to avoid the complexity of potential
"collapse creep" at this stage and get the core functionality right first ;)

> 
> No functional changes in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Cool! LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>


>   mm/khugepaged.c | 78 ++++++++++++++++++++++++++++++-------------------
>   1 file changed, 48 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 36ee659acfbb..4ccebf5dda97 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -537,25 +537,25 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   }
>   
>   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> -					unsigned long start_addr,
> -					pte_t *pte,
> -					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +		unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
> +		unsigned int order, struct list_head *compound_pagelist)
>   {
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	unsigned long addr = start_addr;
>   	pte_t *_pte;
>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> +	const unsigned long nr_pages = 1UL << order;
> +	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + nr_pages;
>   	     _pte++, addr += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
>   		if (pte_none_or_zero(pteval)) {
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
>   			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= max_ptes_none)) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -583,8 +583,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See collapse_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			/*
> +			 * TODO: Support shared pages without leading to further
> +			 * mTHP collapses. Currently bringing in new pages via
> +			 * shared may cause a future higher order collapse on a
> +			 * rescan of the same range.
> +			 */
> +			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> +			    shared > khugepaged_max_ptes_shared)) {
>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;
> @@ -677,18 +683,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   }
>   
>   static void __collapse_huge_page_copy_succeeded(pte_t *pte,
> -						struct vm_area_struct *vma,
> -						unsigned long address,
> -						spinlock_t *ptl,
> -						struct list_head *compound_pagelist)
> +		struct vm_area_struct *vma, unsigned long address,
> +		spinlock_t *ptl, unsigned int order,
> +		struct list_head *compound_pagelist)
>   {
> -	unsigned long end = address + HPAGE_PMD_SIZE;
> +	unsigned long end = address + (PAGE_SIZE << order);
>   	struct folio *src, *tmp;
>   	pte_t pteval;
>   	pte_t *_pte;
>   	unsigned int nr_ptes;
> +	const unsigned long nr_pages = 1UL << order;
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
> +	for (_pte = pte; _pte < pte + nr_pages; _pte += nr_ptes,
>   	     address += nr_ptes * PAGE_SIZE) {
>   		nr_ptes = 1;
>   		pteval = ptep_get(_pte);
> @@ -741,13 +747,11 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   }
>   
>   static void __collapse_huge_page_copy_failed(pte_t *pte,
> -					     pmd_t *pmd,
> -					     pmd_t orig_pmd,
> -					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> +		unsigned int order, struct list_head *compound_pagelist)
>   {
>   	spinlock_t *pmd_ptl;
> -
> +	const unsigned long nr_pages = 1UL << order;
>   	/*
>   	 * Re-establish the PMD to point to the original page table
>   	 * entry. Restoring PMD needs to be done prior to releasing
> @@ -761,7 +765,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   	 * Release both raw and compound pages isolated
>   	 * in __collapse_huge_page_isolate.
>   	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + nr_pages, compound_pagelist);
>   }
>   
>   /*
> @@ -781,16 +785,16 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>    */
>   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> -		unsigned long address, spinlock_t *ptl,
> +		unsigned long address, spinlock_t *ptl, unsigned int order,
>   		struct list_head *compound_pagelist)
>   {
>   	unsigned int i;
>   	int result = SCAN_SUCCEED;
> -
> +	const unsigned long nr_pages = 1UL << order;
>   	/*
>   	 * Copying pages' contents is subject to memory poison at any iteration.
>   	 */
> -	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +	for (i = 0; i < nr_pages; i++) {
>   		pte_t pteval = ptep_get(pte + i);
>   		struct page *page = folio_page(folio, i);
>   		unsigned long src_addr = address + i * PAGE_SIZE;
> @@ -809,10 +813,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   
>   	if (likely(result == SCAN_SUCCEED))
>   		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
> -						    compound_pagelist);
> +						    order, compound_pagelist);
>   	else
>   		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 order, compound_pagelist);
>   
>   	return result;
>   }
> @@ -985,13 +989,12 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>    * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
>    */
>   static int __collapse_huge_page_swapin(struct mm_struct *mm,
> -				       struct vm_area_struct *vma,
> -				       unsigned long start_addr, pmd_t *pmd,
> -				       int referenced)
> +		struct vm_area_struct *vma, unsigned long start_addr,
> +		pmd_t *pmd, int referenced, unsigned int order)
>   {
>   	int swapped_in = 0;
>   	vm_fault_t ret = 0;
> -	unsigned long addr, end = start_addr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long addr, end = start_addr + (PAGE_SIZE << order);
>   	int result;
>   	pte_t *pte = NULL;
>   	spinlock_t *ptl;
> @@ -1022,6 +1025,19 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;
>   
> +		/*
> +		 * TODO: Support swapin without leading to further mTHP
> +		 * collapses. Currently bringing in new pages via swapin may
> +		 * cause a future higher order collapse on a rescan of the same
> +		 * range.
> +		 */
> +		if (order != HPAGE_PMD_ORDER) {
> +			pte_unmap(pte);
> +			mmap_read_unlock(mm);
> +			result = SCAN_EXCEED_SWAP_PTE;
> +			goto out;
> +		}
> +
>   		vmf.pte = pte;
>   		vmf.ptl = ptl;
>   		ret = do_swap_page(&vmf);
> @@ -1142,7 +1158,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		 * that case.  Continuing to collapse causes inconsistency.
>   		 */
>   		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -						     referenced);
> +						     referenced, HPAGE_PMD_ORDER);
>   		if (result != SCAN_SUCCEED)
>   			goto out_nolock;
>   	}
> @@ -1190,6 +1206,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>   	if (pte) {
>   		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> +						      HPAGE_PMD_ORDER,
>   						      &compound_pagelist);
>   		spin_unlock(pte_ptl);
>   	} else {
> @@ -1220,6 +1237,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   
>   	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>   					   vma, address, pte_ptl,
> +					   HPAGE_PMD_ORDER,
>   					   &compound_pagelist);
>   	pte_unmap(pte);
>   	if (unlikely(result != SCAN_SUCCEED))

