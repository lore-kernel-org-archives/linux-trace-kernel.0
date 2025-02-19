Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298091E885;
	Wed, 19 Feb 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979573; cv=none; b=LLZyi7chULaD+MoG3V9cFA8uQ7eR8ZApg4HjItv12fUPvgzVT7WW3dlNC9QKkRCxThOD3TGkotW7IY277O9P009Cnj90ztB7beGlPpk9d7xustVnpCUg9dK6idXvBzkU7ZdslhbCofPWZwQpTOXnlcElQ6SAU8A1YM9+l9PyXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979573; c=relaxed/simple;
	bh=wjWDMZyRre3+QgzoR8Wj1C29FffW/HN/oi/Y+0p9bU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aw4/WP3mbqMsvW+6Hctf+FMISpHKDhpJV3BHE3HL/Sxvn+DKpB+asNbjb8mBCBEiWNfJt1NUnBXVucOip2j3fwxYwMev5TjnOSfXk5LMUQG3Zg4xExbdIl/94y3W27GFhsMCg7Y5zsNx9nm/Vb8DK0LdJ5EBLtMmH+4s6xghFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D761682;
	Wed, 19 Feb 2025 07:39:48 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5747A3F59E;
	Wed, 19 Feb 2025 07:39:18 -0800 (PST)
Message-ID: <8524c7c7-024f-4f17-9b89-ef9aedfca672@arm.com>
Date: Wed, 19 Feb 2025 15:39:15 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 5/9] khugepaged: generalize __collapse_huge_page_* for
 mTHP support
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-6-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-6-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> generalize the order of the __collapse_huge_page_* functions
> to support future mTHP collapse.
> 
> mTHP collapse can suffer from incosistant behavior, and memory waste
> "creep". disable swapin and shared support for mTHP collapse.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 48 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0cfcdc11cabd..3776055bd477 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -565,15 +565,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  					unsigned long address,
>  					pte_t *pte,
>  					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +					struct list_head *compound_pagelist,
> +					u8 order)

nit: I think we are mostly standardised on order being int. Is there any reason
to make it u8 here?

>  {
>  	struct page *page = NULL;
>  	struct folio *folio = NULL;
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>  	bool writable = false;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>  
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>  	     _pte++, address += PAGE_SIZE) {
>  		pte_t pteval = ptep_get(_pte);
>  		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -581,7 +583,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  			++none_or_zero;
>  			if (!userfaultfd_armed(vma) &&
>  			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= scaled_none)) {
>  				continue;
>  			} else {
>  				result = SCAN_EXCEED_NONE_PTE;
> @@ -609,8 +611,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		/* See khugepaged_scan_pmd(). */
>  		if (folio_likely_mapped_shared(folio)) {
>  			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> +			    shared > khugepaged_max_ptes_shared)) {
>  				result = SCAN_EXCEED_SHARED_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);

Same comment about events; I think you will want to be careful to only count
events for PMD-sized THP using count_vm_event() and introduce equivalent MTHP
events to cover all sizes.

>  				goto out;
> @@ -711,14 +713,15 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>  						struct vm_area_struct *vma,
>  						unsigned long address,
>  						spinlock_t *ptl,
> -						struct list_head *compound_pagelist)
> +						struct list_head *compound_pagelist,
> +						u8 order)
>  {
>  	struct folio *src, *tmp;
>  	pte_t *_pte;
>  	pte_t pteval;
>  
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> -	     _pte++, address += PAGE_SIZE) {
> +	for (_pte = pte; _pte < pte + (1 << order);
> +		_pte++, address += PAGE_SIZE) {

nit: you changed the indentation here.

>  		pteval = ptep_get(_pte);
>  		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>  			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> @@ -764,7 +767,8 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>  					     pmd_t *pmd,
>  					     pmd_t orig_pmd,
>  					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +					     struct list_head *compound_pagelist,
> +					     u8 order)
>  {
>  	spinlock_t *pmd_ptl;
>  
> @@ -781,7 +785,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>  	 * Release both raw and compound pages isolated
>  	 * in __collapse_huge_page_isolate.
>  	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + (1 << order), compound_pagelist);
>  }
>  
>  /*
> @@ -802,7 +806,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>  static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>  		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>  		unsigned long address, spinlock_t *ptl,
> -		struct list_head *compound_pagelist)
> +		struct list_head *compound_pagelist, u8 order)
>  {
>  	unsigned int i;
>  	int result = SCAN_SUCCEED;
> @@ -810,7 +814,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>  	/*
>  	 * Copying pages' contents is subject to memory poison at any iteration.
>  	 */
> -	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +	for (i = 0; i < (1 << order); i++) {
>  		pte_t pteval = ptep_get(pte + i);
>  		struct page *page = folio_page(folio, i);
>  		unsigned long src_addr = address + i * PAGE_SIZE;
> @@ -829,10 +833,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>  
>  	if (likely(result == SCAN_SUCCEED))
>  		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
> -						    compound_pagelist);
> +						    compound_pagelist, order);
>  	else
>  		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 compound_pagelist, order);
>  
>  	return result;
>  }
> @@ -1000,11 +1004,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>  static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  				       struct vm_area_struct *vma,
>  				       unsigned long haddr, pmd_t *pmd,
> -				       int referenced)
> +				       int referenced, u8 order)
>  {
>  	int swapped_in = 0;
>  	vm_fault_t ret = 0;
> -	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long address, end = haddr + (PAGE_SIZE << order);
>  	int result;
>  	pte_t *pte = NULL;
>  	spinlock_t *ptl;
> @@ -1035,6 +1039,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  		if (!is_swap_pte(vmf.orig_pte))
>  			continue;
>  
> +		if (order != HPAGE_PMD_ORDER) {
> +			result = SCAN_EXCEED_SWAP_PTE;
> +			goto out;
> +		}

A comment to explain the rationale for this divergent behaviour based on order
would be helpful.

> +
>  		vmf.pte = pte;
>  		vmf.ptl = ptl;
>  		ret = do_swap_page(&vmf);
> @@ -1114,7 +1123,6 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	int result = SCAN_FAIL;
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
> -

nit: no need for this whitespace change?

>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
>  	/*
> @@ -1149,7 +1157,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		 * that case.  Continuing to collapse causes inconsistency.
>  		 */
>  		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -						     referenced);
> +				referenced, HPAGE_PMD_ORDER);
>  		if (result != SCAN_SUCCEED)
>  			goto out_nolock;
>  	}
> @@ -1196,7 +1204,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>  	if (pte) {
>  		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -						      &compound_pagelist);
> +					&compound_pagelist, HPAGE_PMD_ORDER);
>  		spin_unlock(pte_ptl);
>  	} else {
>  		result = SCAN_PMD_NULL;
> @@ -1226,7 +1234,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  
>  	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>  					   vma, address, pte_ptl,
> -					   &compound_pagelist);
> +					   &compound_pagelist, HPAGE_PMD_ORDER);
>  	pte_unmap(pte);
>  	if (unlikely(result != SCAN_SUCCEED))
>  		goto out_up_write;

