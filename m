Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200C19CC14
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284539; cv=none; b=SWs9RRI1NU7qNjFHZS7HkYZJQbtm4AxB8zL7Wcpqi5JX6WlwMiMX+dPMBTQ9uryUt39ppr7hnG2lyX4T3h1++E+Xw9f2T0CxxtAtEppGnw5IU6TbE2j7A8hIBaaKILaqAgMhBbBCIRnqQjtRMXlF73lG+NDUmlEAdOt7hyj2bvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284539; c=relaxed/simple;
	bh=xXb7WP3F0K39sxQbdFXi4iNvPZUb8tntO5MzvQy3Olo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBfNcEwBlgM7yWlkOV6N7Wy1Krr9XIZSGHgupHRPUtAEcoF0zXiYLotLJOt2CMqh/+FrAcy14lU1wEp5iKNNB5vsTEycVSTYFCm7VAXe4nOws7GfpKz8dW58KzggYLjZIXtR0f21bQNCj4A+hk10BdnkOVeHT1laPlt3AdCV0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pB5gPnos; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pB5gPnos"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780284534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGqe1xP59WaPQHJPwgOhJ6HEmEBn7hlp4YbZ8TjEsWg=;
	b=pB5gPnosZrseYYPqwmoGXuQMwKGKOs4C0M9gSF0jM0TC+3sb11mw1MAL/OqH2PFg3bKiGg
	DIu87NJ8sRdc7plHLulyU7UR1XzwEkbjUmiKa25DEwUgng7xT/7HBYISi3dO01QyYPpyEF
	Y0RzaG2mv/G6ZJW4ahIt40m/ty9oE84=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: lance.yang@linux.dev,
	npache@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com,
	usama.arif@linux.dev
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize collapse_huge_page for mTHP collapse
Date: Mon,  1 Jun 2026 11:28:04 +0800
Message-Id: <20260601032804.96122-1-lance.yang@linux.dev>
In-Reply-To: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Sun, May 31, 2026 at 10:00:17PM +0200, David Hildenbrand (Arm) wrote:
>On 5/31/26 11:39, Lance Yang wrote:
>> 
>> On Fri, May 22, 2026 at 09:00:01AM -0600, Nico Pache wrote:
>>> Pass an order and offset to collapse_huge_page to support collapsing anon
>>> memory to arbitrary orders within a PMD. order indicates what mTHP size we
>>> are attempting to collapse to, and offset indicates were in the PMD to
>>> start the collapse attempt.
>>>
>>> For non-PMD collapse we must leave the anon VMA write locked until after
>>> we collapse the mTHP-- in the PMD case all the pages are isolated, but in
>>> the mTHP case this is not true, and we must keep the lock to prevent
>>> access/changes to the page tables. This can happen if the rmap walkers hit
>>> a pmd_none while the PMD entry is currently unavailable due to being
>>> temporarily removed during the collapse phase.
>>>
>>> Acked-by: Usama Arif <usama.arif@linux.dev>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>> mm/khugepaged.c | 93 +++++++++++++++++++++++++++++--------------------
>>> 1 file changed, 55 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index fab35d318641..d64f42f66236 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1214,34 +1214,36 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>>>  * while allocating a THP, as that could trigger direct reclaim/compaction.
>>>  * Note that the VMA must be rechecked after grabbing the mmap_lock again.
>>>  */
>>> -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>> -		int referenced, int unmapped, struct collapse_control *cc)
>>> +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
>>> +		int referenced, int unmapped, struct collapse_control *cc,
>>> +		unsigned int order)
>>> {
>>> +	const unsigned long pmd_addr = start_addr & HPAGE_PMD_MASK;
>>> +	const unsigned long end_addr = start_addr + (PAGE_SIZE << order);
>>> 	LIST_HEAD(compound_pagelist);
>>> 	pmd_t *pmd, _pmd;
>>> -	pte_t *pte;
>>> +	pte_t *pte = NULL;
>>> 	pgtable_t pgtable;
>>> 	struct folio *folio;
>>> 	spinlock_t *pmd_ptl, *pte_ptl;
>>> 	enum scan_result result = SCAN_FAIL;
>>> 	struct vm_area_struct *vma;
>>> 	struct mmu_notifier_range range;
>>> +	bool anon_vma_locked = false;
>>>
>>> -	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>> -
>>> -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>>> +	result = alloc_charge_folio(&folio, mm, cc, order);
>>> 	if (result != SCAN_SUCCEED)
>>> 		goto out_nolock;
>>>
>>> 	mmap_read_lock(mm);
>>> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>>> -					 HPAGE_PMD_ORDER);
>>> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
>>> +					 &vma, cc, order);
>>> 	if (result != SCAN_SUCCEED) {
>>> 		mmap_read_unlock(mm);
>>> 		goto out_nolock;
>>> 	}
>>>
>>> -	result = find_pmd_or_thp_or_none(mm, address, &pmd);
>>> +	result = find_pmd_or_thp_or_none(mm, pmd_addr, &pmd);
>>> 	if (result != SCAN_SUCCEED) {
>>> 		mmap_read_unlock(mm);
>>> 		goto out_nolock;
>>> @@ -1253,8 +1255,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>> 		 * released when it fails. So we jump out_nolock directly in
>>> 		 * that case.  Continuing to collapse causes inconsistency.
>>> 		 */
>>> -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
>>> -						     referenced, HPAGE_PMD_ORDER);
>>> +		result = __collapse_huge_page_swapin(mm, vma, start_addr, pmd,
>>> +						     referenced, order);
>>> 		if (result != SCAN_SUCCEED)
>>> 			goto out_nolock;
>>> 	}
>>> @@ -1269,20 +1271,21 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>> 	 * mmap_lock.
>>> 	 */
>>> 	mmap_write_lock(mm);
>>> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>>> -					 HPAGE_PMD_ORDER);
>>> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
>>> +					 &vma, cc, order);
>>> 	if (result != SCAN_SUCCEED)
>>> 		goto out_up_write;
>>> 	/* check if the pmd is still valid */
>>> 	vma_start_write(vma);
>>> -	result = check_pmd_still_valid(mm, address, pmd);
>>> +	result = check_pmd_still_valid(mm, pmd_addr, pmd);
>>> 	if (result != SCAN_SUCCEED)
>>> 		goto out_up_write;
>>>
>>> 	anon_vma_lock_write(vma->anon_vma);
>>> +	anon_vma_locked = true;
>>>
>>> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>> -				address + HPAGE_PMD_SIZE);
>>> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_addr,
>>> +				end_addr);
>>> 	mmu_notifier_invalidate_range_start(&range);
>>>
>>> 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>> @@ -1294,26 +1297,23 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>> 	 * Parallel GUP-fast is fine since GUP-fast will back off when
>>> 	 * it detects PMD is changed.
>>> 	 */
>>> -	_pmd = pmdp_collapse_flush(vma, address, pmd);
>>> +	_pmd = pmdp_collapse_flush(vma, pmd_addr, pmd);
>>> 	spin_unlock(pmd_ptl);
>>> 	mmu_notifier_invalidate_range_end(&range);
>>> 	tlb_remove_table_sync_one();
>>>
>>> -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>>> +	pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
>>> 	if (pte) {
>>> -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
>>> -						      HPAGE_PMD_ORDER,
>>> -						      &compound_pagelist);
>>> +		result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
>>> +						      order, &compound_pagelist);
>>> 		spin_unlock(pte_ptl);
>>> 	} else {
>>> 		result = SCAN_NO_PTE_TABLE;
>>> 	}
>>>
>>> 	if (unlikely(result != SCAN_SUCCEED)) {
>>> -		if (pte)
>>> -			pte_unmap(pte);
>>> 		spin_lock(pmd_ptl);
>>> -		BUG_ON(!pmd_none(*pmd));
>>> +		WARN_ON_ONCE(!pmd_none(*pmd));
>>> 		/*
>>> 		 * We can only use set_pmd_at when establishing
>>> 		 * hugepmds and never for establishing regular pmds that
>>> @@ -1321,21 +1321,24 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>> 		 */
>>> 		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>> 		spin_unlock(pmd_ptl);
>>> -		anon_vma_unlock_write(vma->anon_vma);
>>> 		goto out_up_write;
>>> 	}
>>>
>>> 	/*
>>> -	 * All pages are isolated and locked so anon_vma rmap
>>> -	 * can't run anymore.
>>> +	 * For PMD collapse all pages are isolated and locked so anon_vma
>>> +	 * rmap can't run anymore. For mTHP collapse the PMD entry has been
>>> +	 * removed and not all pages are isolated and locked, so we must hold
>>> +	 * the lock to prevent neighboring folios from attempting to access
>>> +	 * this PMD until its reinstalled.
>>> 	 */
>>> -	anon_vma_unlock_write(vma->anon_vma);
>>> +	if (is_pmd_order(order)) {
>>> +		anon_vma_unlock_write(vma->anon_vma);
>>> +		anon_vma_locked = false;
>>> +	}
>>>
>>> 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>>> -					   vma, address, pte_ptl,
>>> -					   HPAGE_PMD_ORDER,
>>> -					   &compound_pagelist);
>>> -	pte_unmap(pte);
>>> +					   vma, start_addr, pte_ptl,
>>> +					   order, &compound_pagelist);
>>> 	if (unlikely(result != SCAN_SUCCEED))
>>> 		goto out_up_write;
>>>
>>> @@ -1345,18 +1348,32 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>> 	 * write.
>>> 	 */
>>> 	__folio_mark_uptodate(folio);
>>> -	pgtable = pmd_pgtable(_pmd);
>>> -
>>> 	spin_lock(pmd_ptl);
>>> -	BUG_ON(!pmd_none(*pmd));
>>> -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> -	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
>>> +	WARN_ON_ONCE(!pmd_none(*pmd));
>>> +	if (is_pmd_order(order)) {
>>> +		pgtable = pmd_pgtable(_pmd);
>>> +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> +		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>>> +	} else {
>>> +		/*
>>> +		 * set_ptes is called in map_anon_folio_pte_nopf with the
>>> +		 * pmd_ptl lock still held; this is safe as the PMD is expected
>>> +		 * to be none. The pmd entry is then repopulated below.
>>> +		 */
>>> +		map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
>> 
>> Emm ... is it safe to use map_anon_folio_pte_nopf() here?
>> 
>> At this point pmdp_collapse_flush() has cleared the PMD from the page
>> tables. The PTE table we are updating is only reachable through the saved
>> old PMD value, _pmd, until pmd_populate() below.
>> 
>> map_anon_folio_pte_nopf() does set_ptes() and then calls
>> update_mmu_cache_range(). Documentation/core-api/cachetlb.rst describes
>> that hook as:
>> 
>> "
>> 	At the end of every page fault, this routine is invoked to tell
>> 	the architecture specific code that translations now exists
>> 	in the software page tables for address space "vma->vm_mm"
>> 	at virtual address "address" for "nr" consecutive pages.
>> "
>> 
>> But that does not seem true here yet, since the PTE table is not
>> reachable from vma->vm_mm when update_mmu_cache_range() is called.
>> 
>> Should we avoid calling update_mmu_cache_range() until after the PTE
>> table is reinstalled with pmd_populate()?
>
>I recall that update_mmu_cache* users mostly care about updating folios flags,
>for the folio derived from the PTE ... or flushing caches for the user address.
>
>So intuitively I would say "the architecture code doesn't care that the PMD
>table will only be visible to HW shortly after". The important thing should be
>that it will definetly happen, and that nothing else is curently there or can be
>there?

Ah, fair point.

I was mostly worried about arch hooks that walk vma->vm_mm again, rather
than only using the pte pointer passed in. For example, mips does:

  update_mmu_cache_range()
    -> __update_tlb()
      -> pgd_offset(vma->vm_mm, address)
      -> pte_offset_map(...)

and __update_tlb() has this assumption:

		/*
		 * update_mmu_cache() is called between pte_offset_map_lock()
		 * and pte_unmap_unlock(), so we can assume that ptep is not
		 * NULL here: and what should be done below if it were NULL?
		 */

So if khugepaged happens to run with current->active_mm == vma->vm_mm
here, could __update_tlb() hit the none PMD, get NULL from
pte_offset_map(), and then dereference it?

Just wanted to raise it since some arch code may still have assumptions
like this, and the always-enable-mTHP work is getting closer ...

Probably very very very hard to hit, though :)

Cheers, Lance
