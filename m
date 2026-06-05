Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D05464D;
	Fri,  5 Jun 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683525; cv=none; b=M+GinXX47VQU3SXnSp4kiJP6SD7iv78cHfFnv64tyMVzlrRMvgb1cOBwnzZssmf/hHywb41wQgQTpWk2LH8+8yiOG4XJi7RAonGVh1HJpeokMGllds9AETmLNaQoZSJwc4l+59TKy89SQ1v8d8+GAl4kKMsaMWOBLWUxUO1DtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683525; c=relaxed/simple;
	bh=V687/aQ8qsu9whblPhFdeorh3gEgBlaZcMgCYbRcCsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVCTMXCqNNk7ppwAiqg3qNr0cdeYI/ldvTFmRVBt9EWj5OvASFIOIsNCkQRKuxVu7d4154mN5R+hdnnxVQy5xMjEUlRRQpd7f7NmL5/xQgQEJddUyEJqPpDCfX5f0UzP4I3Fl3iRfEpD/q9Eu/DHtjwYZFP7Ffw03nan0qZaZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4BUjc1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4BUjc1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B41F1F00893;
	Fri,  5 Jun 2026 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780683523;
	bh=VsfnnuV7Lfql0MYlQqIZUbPhs5YZZ6KH0i1RULfVN4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4BUjc1m6/0QUr7A7TLY8oRCoo6JjcObXw6xKsR6a7XSlBgOXlxb+RkwoOAE+2mVR
	 p1+//6qos+c/TpE5ALjDeudfdLOZz+Q2B1Xl1EICC9LGbAqoEKD3PGDOn1XCwkZiKy
	 /9uXb2FTUpeeG0kPy/m2eZ4H57NTPc7v7pPuP58BIIlt0dB4JBPZdx+9+7vOu/4UwB
	 oXJWizLnic6q3fh4X+RqTk7cWD9NAyWtG1nIIHWbvUbhQLYIliDVZ7FnwqTXqE2g4J
	 ZJueDach8kK1h6jfqmoCNrYjRwmTKJX2or9jF/TufwtH+3Rzknr9bE6QCeTecT3dum
	 FggdHMkLX1g9w==
Date: Fri, 5 Jun 2026 19:18:28 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <aiMSqmIdajP8b25G@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-7-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605161422.213817-7-npache@redhat.com>

On Fri, Jun 05, 2026 at 10:14:13AM -0600, Nico Pache wrote:
> Pass an order to collapse_huge_page to support collapsing anon memory to
> arbitrary orders within a PMD. order indicates what mTHP size we are
> attempting to collapse to.
>
> For non-PMD collapse we must leave the anon VMA write locked until after
> we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> the mTHP case this is not true, and we must keep the lock to prevent
> access/changes to the page tables. This can happen if the rmap walkers hit
> a pmd_none while the PMD entry is currently unavailable due to being
> temporarily removed during the collapse phase.
>
> To properly establish the page table hierarchy without violating any
> expectations from certain architectures (e.g. MIPS), we must make sure to
> have the PMD reinstalled before the PTEs, and hold both PTE/PMD locks
> before calling update_mmu_cache_range() (if they are distinct locks).
>
> Signed-off-by: Nico Pache <npache@redhat.com>

In case Andrew missing my tag in the lengthily reply in [0]:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

:)

(Though probably he has a script that does this for him!)

[0]:https://lore.kernel.org/linux-mm/aiMNT7fBUkZS1EJK@lucifer/

Cheers, Lorenzo

> ---
>  mm/khugepaged.c | 105 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 38 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e4b2ca77ecf6..c2769d82a719 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1228,34 +1228,36 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>   * while allocating a THP, as that could trigger direct reclaim/compaction.
>   * Note that the VMA must be rechecked after grabbing the mmap_lock again.
>   */
> -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
> -		int referenced, int unmapped, struct collapse_control *cc)
> +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
> +		int referenced, int unmapped, struct collapse_control *cc,
> +		unsigned int order)
>  {
> +	const unsigned long pmd_addr = start_addr & HPAGE_PMD_MASK;
> +	const unsigned long end_addr = start_addr + (PAGE_SIZE << order);
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> -	pte_t *pte;
> +	pte_t *pte = NULL;
>  	pgtable_t pgtable;
>  	struct folio *folio;
>  	spinlock_t *pmd_ptl, *pte_ptl;
>  	enum scan_result result = SCAN_FAIL;
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
> +	bool anon_vma_locked = false;
>
> -	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> -
> -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> +	result = alloc_charge_folio(&folio, mm, cc, order);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>
>  	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> -					 HPAGE_PMD_ORDER);
> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
> +					 &vma, cc, order);
>  	if (result != SCAN_SUCCEED) {
>  		mmap_read_unlock(mm);
>  		goto out_nolock;
>  	}
>
> -	result = find_pmd_or_thp_or_none(mm, address, &pmd);
> +	result = find_pmd_or_thp_or_none(mm, pmd_addr, &pmd);
>  	if (result != SCAN_SUCCEED) {
>  		mmap_read_unlock(mm);
>  		goto out_nolock;
> @@ -1267,8 +1269,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  		 * released when it fails. So we jump out_nolock directly in
>  		 * that case.  Continuing to collapse causes inconsistency.
>  		 */
> -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -						     referenced, HPAGE_PMD_ORDER);
> +		result = __collapse_huge_page_swapin(mm, vma, start_addr, pmd,
> +						     referenced, order);
>  		if (result != SCAN_SUCCEED)
>  			goto out_nolock;
>  	}
> @@ -1283,20 +1285,28 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> -					 HPAGE_PMD_ORDER);
> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
> +					 &vma, cc, order);
>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>  	/* check if the pmd is still valid */
>  	vma_start_write(vma);
> -	result = check_pmd_still_valid(mm, address, pmd);
> +	result = check_pmd_still_valid(mm, pmd_addr, pmd);
>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>
>  	anon_vma_lock_write(vma->anon_vma);
> +	anon_vma_locked = true;
>
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> -				address + HPAGE_PMD_SIZE);
> +	/*
> +	 * Only notify about the PTE range we will actually modify. While we
> +	 * temporary unmap the whole PTE table for mTHP collapse, we'll remap
> +	 * it later, leaving other PTEs effectively unmodified. The locks we
> +	 * hold prevent anybody from stumbling over such temporarily unmapped
> +	 * PTE tables.
> +	 */
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_addr,
> +				end_addr);
>  	mmu_notifier_invalidate_range_start(&range);
>
>  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> @@ -1308,26 +1318,23 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  	 * Parallel GUP-fast is fine since GUP-fast will back off when
>  	 * it detects PMD is changed.
>  	 */
> -	_pmd = pmdp_collapse_flush(vma, address, pmd);
> +	_pmd = pmdp_collapse_flush(vma, pmd_addr, pmd);
>  	spin_unlock(pmd_ptl);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_remove_table_sync_one();
>
> -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> +	pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
>  	if (pte) {
> -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -						      HPAGE_PMD_ORDER,
> -						      &compound_pagelist);
> +		result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
> +						      order, &compound_pagelist);
>  		spin_unlock(pte_ptl);
>  	} else {
>  		result = SCAN_NO_PTE_TABLE;
>  	}
>
>  	if (unlikely(result != SCAN_SUCCEED)) {
> -		if (pte)
> -			pte_unmap(pte);
>  		spin_lock(pmd_ptl);
> -		BUG_ON(!pmd_none(*pmd));
> +		VM_WARN_ON_ONCE(!pmd_none(*pmd));
>  		/*
>  		 * We can only use set_pmd_at when establishing
>  		 * hugepmds and never for establishing regular pmds that
> @@ -1335,21 +1342,24 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  		 */
>  		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>  		spin_unlock(pmd_ptl);
> -		anon_vma_unlock_write(vma->anon_vma);
>  		goto out_up_write;
>  	}
>
>  	/*
> -	 * All pages are isolated and locked so anon_vma rmap
> -	 * can't run anymore.
> +	 * For PMD collapse all pages are isolated and locked so anon_vma
> +	 * rmap can't run anymore. For mTHP collapse the PMD entry has been
> +	 * removed and not all pages are isolated and locked, so we must hold
> +	 * the lock to prevent neighboring folios from attempting to access
> +	 * this PMD until its reinstalled.
>  	 */
> -	anon_vma_unlock_write(vma->anon_vma);
> +	if (is_pmd_order(order)) {
> +		anon_vma_unlock_write(vma->anon_vma);
> +		anon_vma_locked = false;
> +	}
>
>  	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> -					   vma, address, pte_ptl,
> -					   HPAGE_PMD_ORDER,
> -					   &compound_pagelist);
> -	pte_unmap(pte);
> +					   vma, start_addr, pte_ptl,
> +					   order, &compound_pagelist);
>  	if (unlikely(result != SCAN_SUCCEED))
>  		goto out_up_write;
>
> @@ -1359,18 +1369,37 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>  	 * write.
>  	 */
>  	__folio_mark_uptodate(folio);
> -	pgtable = pmd_pgtable(_pmd);
> -
>  	spin_lock(pmd_ptl);
> -	BUG_ON(!pmd_none(*pmd));
> -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> -	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
> +	VM_WARN_ON_ONCE(!pmd_none(*pmd));
> +	if (is_pmd_order(order)) {
> +		pgtable = pmd_pgtable(_pmd);
> +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> +		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
> +	} else {
> +		/*
> +		 * Some architectures (e.g. MIPS) walk the live page table in
> +		 * their implementation. update_mmu_cache_range() must be called
> +		 * with a valid page table hierarchy and the PTE lock held.
> +		 * Acquire it nested inside pmd_ptl when they are distinct locks.
> +		 */
> +		if (pte_ptl != pmd_ptl)
> +			spin_lock_nested(pte_ptl, SINGLE_DEPTH_NESTING);
> +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> +		map_anon_folio_pte_nopf(folio, pte, vma, start_addr,
> +					  /*uffd_wp=*/ false);
> +		if (pte_ptl != pmd_ptl)
> +			spin_unlock(pte_ptl);
> +	}
>  	spin_unlock(pmd_ptl);
>
>  	folio = NULL;
>
>  	result = SCAN_SUCCEED;
>  out_up_write:
> +	if (anon_vma_locked)
> +		anon_vma_unlock_write(vma->anon_vma);
> +	if (pte)
> +		pte_unmap(pte);
>  	mmap_write_unlock(mm);
>  out_nolock:
>  	if (folio)
> @@ -1550,7 +1579,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		/* collapse_huge_page expects the lock to be dropped before calling */
>  		mmap_read_unlock(mm);
>  		result = collapse_huge_page(mm, start_addr, referenced,
> -					    unmapped, cc);
> +					    unmapped, cc, HPAGE_PMD_ORDER);
>  		/* collapse_huge_page will return with the mmap_lock released */
>  		*lock_dropped = true;
>  	}
> --
> 2.54.0
>
