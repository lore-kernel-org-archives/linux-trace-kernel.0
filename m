Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4E502B1;
	Thu, 24 Apr 2025 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497317; cv=none; b=HpKzsLjdE2e3epleNpjZqZF4TYnq1HIWLrY+1QxWEI3x7sP9SVPFSSgBRkTn0XVwKwFmTCOany8MMVyF+WSc7ZD/vxYb3BTjPYMPtN00kT+pL6YSlNaRcBiEYsPgOFf8QcKb1rT4mX4Nd0p3IXOugnq6Y3gJUX9M76HkawvpOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497317; c=relaxed/simple;
	bh=M7139PzVyYycpaeFCqj8wuCKkvCagsdDr6j8nz7nMT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTLtcdhhMF4PVBHJc0WUKJyRbyJ4mRnW13Cs09L9mTyT7O4r76l+iybNepyVWOOXlN305FQ336+VnqWaZb4csCU7DrgkeAS5ob0GDOsGv/hUPLgf9VGcc+u6Z5Rhzu3rk96AfOGKX4GYdoV2z/Q4sTIzZ7Ji/3vhCmgjtGtuJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZI8b75Rw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZI8b75Rw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745497308; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=96rZkPR8RJnCqVOLwUnJiqjdHf3YOUV8iWh99OEjfFk=;
	b=ZI8b75RwNdn+zpP62lJ28pPSrjjlhRUs9Kq/1qLYBpnRlAwn4qHpuPMX6xHKYl7pmoslFw5Oi71UGLo8w+irKTjioB6w1Ko2XugtcCUhBqeTykh68neMIg5vnDjgK7W3vAK+b3NlkxnaT0Roktqp5nLKj+F5/2K/lQSENei3EL0=
Received: from 192.168.1.7(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXzOB6s_1745497303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 20:21:45 +0800
Message-ID: <3f52af67-489d-46b0-867f-202b59864692@linux.alibaba.com>
Date: Thu, 24 Apr 2025 20:21:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] khugepaged: add mTHP support
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
 <20250417000238.74567-8-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> Introduce the ability for khugepaged to collapse to different mTHP sizes.
> While scanning PMD ranges for potential collapse candidates, keep track
> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
> mTHPs are enabled we remove the restriction of max_ptes_none during the
> scan phase so we dont bailout early and miss potential mTHP candidates.
> 
> After the scan is complete we will perform binary recursion on the
> bitmap to determine which mTHP size would be most efficient to collapse
> to. max_ptes_none will be scaled by the attempted collapse order to
> determine how full a THP must be to be eligible.
> 
> If a mTHP collapse is attempted, but contains swapped out, or shared
> pages, we dont perform the collapse.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 88 insertions(+), 34 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 83230e9cdf3a..ece39fd71fe6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1136,13 +1136,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   {
>   	LIST_HEAD(compound_pagelist);
>   	pmd_t *pmd, _pmd;
> -	pte_t *pte;
> +	pte_t *pte, mthp_pte;
>   	pgtable_t pgtable;
>   	struct folio *folio;
>   	spinlock_t *pmd_ptl, *pte_ptl;
>   	int result = SCAN_FAIL;
>   	struct vm_area_struct *vma;
>   	struct mmu_notifier_range range;
> +	unsigned long _address = address + offset * PAGE_SIZE;
>   
>   	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>   
> @@ -1158,12 +1159,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		*mmap_locked = false;
>   	}
>   
> -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> +	result = alloc_charge_folio(&folio, mm, cc, order);
>   	if (result != SCAN_SUCCEED)
>   		goto out_nolock;
>   
>   	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
> +	*mmap_locked = true;
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>   	if (result != SCAN_SUCCEED) {
>   		mmap_read_unlock(mm);
>   		goto out_nolock;
> @@ -1181,13 +1183,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		 * released when it fails. So we jump out_nolock directly in
>   		 * that case.  Continuing to collapse causes inconsistency.
>   		 */
> -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -				referenced, HPAGE_PMD_ORDER);
> +		result = __collapse_huge_page_swapin(mm, vma, _address, pmd,
> +				referenced, order);
>   		if (result != SCAN_SUCCEED)
>   			goto out_nolock;
>   	}
>   
>   	mmap_read_unlock(mm);
> +	*mmap_locked = false;
>   	/*
>   	 * Prevent all access to pagetables with the exception of
>   	 * gup_fast later handled by the ptep_clear_flush and the VM
> @@ -1197,7 +1200,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * mmap_lock.
>   	 */
>   	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>   	if (result != SCAN_SUCCEED)
>   		goto out_up_write;
>   	/* check if the pmd is still valid */
> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	vma_start_write(vma);
>   	anon_vma_lock_write(vma->anon_vma);
>   
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> -				address + HPAGE_PMD_SIZE);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
> +				_address + (PAGE_SIZE << order));
>   	mmu_notifier_invalidate_range_start(&range);
>   
>   	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> +
>   	/*
>   	 * This removes any huge TLB entry from the CPU so we won't allow
>   	 * huge and small TLB entries for the same virtual address to
> @@ -1226,10 +1230,10 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	mmu_notifier_invalidate_range_end(&range);
>   	tlb_remove_table_sync_one();
>   
> -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> +	pte = pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
>   	if (pte) {
> -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -					&compound_pagelist, HPAGE_PMD_ORDER);
> +		result = __collapse_huge_page_isolate(vma, _address, pte, cc,
> +					&compound_pagelist, order);
>   		spin_unlock(pte_ptl);
>   	} else {
>   		result = SCAN_PMD_NULL;
> @@ -1258,8 +1262,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	anon_vma_unlock_write(vma->anon_vma);
>   
>   	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> -					   vma, address, pte_ptl,
> -					   &compound_pagelist, HPAGE_PMD_ORDER);
> +					   vma, _address, pte_ptl,
> +					   &compound_pagelist, order);
>   	pte_unmap(pte);

pte is unmapped here, but...

>   	if (unlikely(result != SCAN_SUCCEED))
>   		goto out_up_write;
> @@ -1270,20 +1274,35 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * write.
>   	 */
>   	__folio_mark_uptodate(folio);
> -	pgtable = pmd_pgtable(_pmd);
> -
> -	_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
> -	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> -
> -	spin_lock(pmd_ptl);
> -	BUG_ON(!pmd_none(*pmd));
> -	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> -	folio_add_lru_vma(folio, vma);
> -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> -	set_pmd_at(mm, address, pmd, _pmd);
> -	update_mmu_cache_pmd(vma, address, pmd);
> -	deferred_split_folio(folio, false);
> -	spin_unlock(pmd_ptl);
> +	if (order == HPAGE_PMD_ORDER) {
> +		pgtable = pmd_pgtable(_pmd);
> +		_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
> +		_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> +
> +		spin_lock(pmd_ptl);
> +		BUG_ON(!pmd_none(*pmd));
> +		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
> +		folio_add_lru_vma(folio, vma);
> +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> +		set_pmd_at(mm, address, pmd, _pmd);
> +		update_mmu_cache_pmd(vma, address, pmd);
> +		deferred_split_folio(folio, false);
> +		spin_unlock(pmd_ptl);
> +	} else { //mTHP

(Nit: use '/* xxx */' format)

> +		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
> +		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> +
> +		spin_lock(pmd_ptl);
> +		folio_ref_add(folio, (1 << order) - 1);
> +		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
> +		folio_add_lru_vma(folio, vma);
> +		set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order));

You still used the unmapped pte? Looks incorrect to me.

> +		update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
> +
> +		smp_wmb(); /* make pte visible before pmd */
> +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> +		spin_unlock(pmd_ptl);
> +	}
>   
>   	folio = NULL;
>   
> @@ -1364,31 +1383,58 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   {
>   	pmd_t *pmd;
>   	pte_t *pte, *_pte;
> +	int i;
>   	int result = SCAN_FAIL, referenced = 0;
>   	int none_or_zero = 0, shared = 0;
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	unsigned long _address;
> +	unsigned long enabled_orders;
>   	spinlock_t *ptl;
>   	int node = NUMA_NO_NODE, unmapped = 0;
> +	bool is_pmd_only;
>   	bool writable = false;
> -
> +	int chunk_none_count = 0;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
> +	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>   	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>   
>   	result = find_pmd_or_thp_or_none(mm, address, &pmd);
>   	if (result != SCAN_SUCCEED)
>   		goto out;
>   
> +	bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
>   	memset(cc->node_load, 0, sizeof(cc->node_load));
>   	nodes_clear(cc->alloc_nmask);
> +
> +	enabled_orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> +		tva_flags, THP_ORDERS_ALL_ANON);
> +
> +	is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
>   	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
>   	if (!pte) {
>   		result = SCAN_PMD_NULL;
>   		goto out;
>   	}
>   
> -	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> -	     _pte++, _address += PAGE_SIZE) {
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +		/*
> +		 * we are reading in KHUGEPAGED_MIN_MTHP_NR page chunks. if
> +		 * there are pages in this chunk keep track of it in the bitmap
> +		 * for mTHP collapsing.
> +		 */
> +		if (i % KHUGEPAGED_MIN_MTHP_NR == 0) {
> +			if (chunk_none_count <= scaled_none)
> +				bitmap_set(cc->mthp_bitmap,
> +					   i / KHUGEPAGED_MIN_MTHP_NR, 1);
> +
> +			chunk_none_count = 0;
> +		}
> +
> +		_pte = pte + i;
> +		_address = address + i * PAGE_SIZE;
>   		pte_t pteval = ptep_get(_pte);
>   		if (is_swap_pte(pteval)) {
>   			++unmapped;
> @@ -1411,10 +1457,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   			}
>   		}
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +			++chunk_none_count;
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			    (!cc->is_khugepaged || !is_pmd_only ||
> +				none_or_zero <= khugepaged_max_ptes_none)) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -1510,6 +1557,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   								     address)))
>   			referenced++;
>   	}
> +
>   	if (!writable) {
>   		result = SCAN_PAGE_RO;
>   	} else if (cc->is_khugepaged &&
> @@ -1522,8 +1570,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   out_unmap:
>   	pte_unmap_unlock(pte, ptl);
>   	if (result == SCAN_SUCCEED) {
> -		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
> +		result = khugepaged_scan_bitmap(mm, address, referenced, unmapped, cc,
> +			       mmap_locked, enabled_orders);
> +		if (result > 0)
> +			result = SCAN_SUCCEED;
> +		else
> +			result = SCAN_FAIL;
>   	}
>   out:
>   	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
> @@ -2479,11 +2531,13 @@ static int khugepaged_collapse_single_pmd(unsigned long addr,
>   			fput(file);
>   			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
>   				mmap_read_lock(mm);
> +				*mmap_locked = true;
>   				if (khugepaged_test_exit_or_disable(mm))
>   					goto end;
>   				result = collapse_pte_mapped_thp(mm, addr,
>   								 !cc->is_khugepaged);
>   				mmap_read_unlock(mm);
> +				*mmap_locked = false;
>   			}
>   		} else {
>   			result = khugepaged_scan_pmd(mm, vma, addr,
