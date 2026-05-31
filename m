Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062274A35;
	Sun, 31 May 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257632; cv=none; b=IRSaT/TZEAx7UVq9B+0ggnQgcrXQuo62sFQxQ13wyENMmIGUJoyxOTZDJowsh6usf8f8DgDaEooOnf5T7BLQWWafCspu1K6IskRXvogYWp9womrA7JQWw2azQvGag/kHmuRK4ZouHSq8yAumhxw+J68O7vAFUEcPDEA6RykRwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257632; c=relaxed/simple;
	bh=ai2uQTiry2ZQyQvfuQnOKySrUjDpNzEFIXYFlPbEoCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmTzUyCT1ziT3dVw/L3Cv6mIPqGqJKj0Ecrj+TksD3PSWL+r/s+IB0VEFM+RZgUEfo4FewjxtuNhxboYmJhLMo5n+ZmRUYt4og7tRAdZYYS30g2LWVYAZ11+TugO9sIvc9hMy6LJmYDmiaU9WPURRIuVFovbp7xgLSoPc7WZG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yukqwlh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yukqwlh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E9A1F00893;
	Sun, 31 May 2026 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780257630;
	bh=aEPYmd3+KmSGb58hk3YvHjJwSc7TSC3VwrFHdZzW7T0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yukqwlh43Y7HfHVE0H6+8wyDPPNZoUJNTHula00Bbpoj0kRLSjAG/1XYDnWIGXp6U
	 lOaTpRvnhBZWAJMp1EI9OyNB0qC7O0NeaFfYpm6s6JmgiEY3kMwz9U7xhBMulSGvaG
	 ZlB90Odwdi9AdJkXL93atrSsz2Tf/ca2W8S64HUZhYgSzB5J2xoJn821Q0dviL/ZZC
	 SgwnPkzTZAvKUhf9QH522tIteT79/RdLSciPWYx6woLgUejtQdRwWZ/59LU/n1eQkl
	 DK78iCc2SLAHY/hTlJUc7Zqmjv2PbNMaDIAiUPhac+XJuVZRFgCKpU0wA5+v/JBSc5
	 9wpJFyGjEnCJg==
Message-ID: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
Date: Sun, 31 May 2026 22:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: Lance Yang <lance.yang@linux.dev>, npache@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, liam@infradead.org, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com,
 usama.arif@linux.dev
References: <20260522150009.121603-7-npache@redhat.com>
 <20260531093942.19644-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260531093942.19644-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/26 11:39, Lance Yang wrote:
> 
> On Fri, May 22, 2026 at 09:00:01AM -0600, Nico Pache wrote:
>> Pass an order and offset to collapse_huge_page to support collapsing anon
>> memory to arbitrary orders within a PMD. order indicates what mTHP size we
>> are attempting to collapse to, and offset indicates were in the PMD to
>> start the collapse attempt.
>>
>> For non-PMD collapse we must leave the anon VMA write locked until after
>> we collapse the mTHP-- in the PMD case all the pages are isolated, but in
>> the mTHP case this is not true, and we must keep the lock to prevent
>> access/changes to the page tables. This can happen if the rmap walkers hit
>> a pmd_none while the PMD entry is currently unavailable due to being
>> temporarily removed during the collapse phase.
>>
>> Acked-by: Usama Arif <usama.arif@linux.dev>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>> mm/khugepaged.c | 93 +++++++++++++++++++++++++++++--------------------
>> 1 file changed, 55 insertions(+), 38 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index fab35d318641..d64f42f66236 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1214,34 +1214,36 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>>  * while allocating a THP, as that could trigger direct reclaim/compaction.
>>  * Note that the VMA must be rechecked after grabbing the mmap_lock again.
>>  */
>> -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
>> -		int referenced, int unmapped, struct collapse_control *cc)
>> +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
>> +		int referenced, int unmapped, struct collapse_control *cc,
>> +		unsigned int order)
>> {
>> +	const unsigned long pmd_addr = start_addr & HPAGE_PMD_MASK;
>> +	const unsigned long end_addr = start_addr + (PAGE_SIZE << order);
>> 	LIST_HEAD(compound_pagelist);
>> 	pmd_t *pmd, _pmd;
>> -	pte_t *pte;
>> +	pte_t *pte = NULL;
>> 	pgtable_t pgtable;
>> 	struct folio *folio;
>> 	spinlock_t *pmd_ptl, *pte_ptl;
>> 	enum scan_result result = SCAN_FAIL;
>> 	struct vm_area_struct *vma;
>> 	struct mmu_notifier_range range;
>> +	bool anon_vma_locked = false;
>>
>> -	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> -
>> -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>> +	result = alloc_charge_folio(&folio, mm, cc, order);
>> 	if (result != SCAN_SUCCEED)
>> 		goto out_nolock;
>>
>> 	mmap_read_lock(mm);
>> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>> -					 HPAGE_PMD_ORDER);
>> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
>> +					 &vma, cc, order);
>> 	if (result != SCAN_SUCCEED) {
>> 		mmap_read_unlock(mm);
>> 		goto out_nolock;
>> 	}
>>
>> -	result = find_pmd_or_thp_or_none(mm, address, &pmd);
>> +	result = find_pmd_or_thp_or_none(mm, pmd_addr, &pmd);
>> 	if (result != SCAN_SUCCEED) {
>> 		mmap_read_unlock(mm);
>> 		goto out_nolock;
>> @@ -1253,8 +1255,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>> 		 * released when it fails. So we jump out_nolock directly in
>> 		 * that case.  Continuing to collapse causes inconsistency.
>> 		 */
>> -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
>> -						     referenced, HPAGE_PMD_ORDER);
>> +		result = __collapse_huge_page_swapin(mm, vma, start_addr, pmd,
>> +						     referenced, order);
>> 		if (result != SCAN_SUCCEED)
>> 			goto out_nolock;
>> 	}
>> @@ -1269,20 +1271,21 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>> 	 * mmap_lock.
>> 	 */
>> 	mmap_write_lock(mm);
>> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>> -					 HPAGE_PMD_ORDER);
>> +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
>> +					 &vma, cc, order);
>> 	if (result != SCAN_SUCCEED)
>> 		goto out_up_write;
>> 	/* check if the pmd is still valid */
>> 	vma_start_write(vma);
>> -	result = check_pmd_still_valid(mm, address, pmd);
>> +	result = check_pmd_still_valid(mm, pmd_addr, pmd);
>> 	if (result != SCAN_SUCCEED)
>> 		goto out_up_write;
>>
>> 	anon_vma_lock_write(vma->anon_vma);
>> +	anon_vma_locked = true;
>>
>> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>> -				address + HPAGE_PMD_SIZE);
>> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_addr,
>> +				end_addr);
>> 	mmu_notifier_invalidate_range_start(&range);
>>
>> 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>> @@ -1294,26 +1297,23 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>> 	 * Parallel GUP-fast is fine since GUP-fast will back off when
>> 	 * it detects PMD is changed.
>> 	 */
>> -	_pmd = pmdp_collapse_flush(vma, address, pmd);
>> +	_pmd = pmdp_collapse_flush(vma, pmd_addr, pmd);
>> 	spin_unlock(pmd_ptl);
>> 	mmu_notifier_invalidate_range_end(&range);
>> 	tlb_remove_table_sync_one();
>>
>> -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>> +	pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
>> 	if (pte) {
>> -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
>> -						      HPAGE_PMD_ORDER,
>> -						      &compound_pagelist);
>> +		result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
>> +						      order, &compound_pagelist);
>> 		spin_unlock(pte_ptl);
>> 	} else {
>> 		result = SCAN_NO_PTE_TABLE;
>> 	}
>>
>> 	if (unlikely(result != SCAN_SUCCEED)) {
>> -		if (pte)
>> -			pte_unmap(pte);
>> 		spin_lock(pmd_ptl);
>> -		BUG_ON(!pmd_none(*pmd));
>> +		WARN_ON_ONCE(!pmd_none(*pmd));
>> 		/*
>> 		 * We can only use set_pmd_at when establishing
>> 		 * hugepmds and never for establishing regular pmds that
>> @@ -1321,21 +1321,24 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>> 		 */
>> 		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>> 		spin_unlock(pmd_ptl);
>> -		anon_vma_unlock_write(vma->anon_vma);
>> 		goto out_up_write;
>> 	}
>>
>> 	/*
>> -	 * All pages are isolated and locked so anon_vma rmap
>> -	 * can't run anymore.
>> +	 * For PMD collapse all pages are isolated and locked so anon_vma
>> +	 * rmap can't run anymore. For mTHP collapse the PMD entry has been
>> +	 * removed and not all pages are isolated and locked, so we must hold
>> +	 * the lock to prevent neighboring folios from attempting to access
>> +	 * this PMD until its reinstalled.
>> 	 */
>> -	anon_vma_unlock_write(vma->anon_vma);
>> +	if (is_pmd_order(order)) {
>> +		anon_vma_unlock_write(vma->anon_vma);
>> +		anon_vma_locked = false;
>> +	}
>>
>> 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>> -					   vma, address, pte_ptl,
>> -					   HPAGE_PMD_ORDER,
>> -					   &compound_pagelist);
>> -	pte_unmap(pte);
>> +					   vma, start_addr, pte_ptl,
>> +					   order, &compound_pagelist);
>> 	if (unlikely(result != SCAN_SUCCEED))
>> 		goto out_up_write;
>>
>> @@ -1345,18 +1348,32 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>> 	 * write.
>> 	 */
>> 	__folio_mark_uptodate(folio);
>> -	pgtable = pmd_pgtable(_pmd);
>> -
>> 	spin_lock(pmd_ptl);
>> -	BUG_ON(!pmd_none(*pmd));
>> -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>> -	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
>> +	WARN_ON_ONCE(!pmd_none(*pmd));
>> +	if (is_pmd_order(order)) {
>> +		pgtable = pmd_pgtable(_pmd);
>> +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>> +		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>> +	} else {
>> +		/*
>> +		 * set_ptes is called in map_anon_folio_pte_nopf with the
>> +		 * pmd_ptl lock still held; this is safe as the PMD is expected
>> +		 * to be none. The pmd entry is then repopulated below.
>> +		 */
>> +		map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
> 
> Emm ... is it safe to use map_anon_folio_pte_nopf() here?
> 
> At this point pmdp_collapse_flush() has cleared the PMD from the page
> tables. The PTE table we are updating is only reachable through the saved
> old PMD value, _pmd, until pmd_populate() below.
> 
> map_anon_folio_pte_nopf() does set_ptes() and then calls
> update_mmu_cache_range(). Documentation/core-api/cachetlb.rst describes
> that hook as:
> 
> "
> 	At the end of every page fault, this routine is invoked to tell
> 	the architecture specific code that translations now exists
> 	in the software page tables for address space "vma->vm_mm"
> 	at virtual address "address" for "nr" consecutive pages.
> "
> 
> But that does not seem true here yet, since the PTE table is not
> reachable from vma->vm_mm when update_mmu_cache_range() is called.
> 
> Should we avoid calling update_mmu_cache_range() until after the PTE
> table is reinstalled with pmd_populate()?

I recall that update_mmu_cache* users mostly care about updating folios flags,
for the folio derived from the PTE ... or flushing caches for the user address.

So intuitively I would say "the architecture code doesn't care that the PMD
table will only be visible to HW shortly after". The important thing should be
that it will definetly happen, and that nothing else is curently there or can be
there?



-- 
Cheers,

David
