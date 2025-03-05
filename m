Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA01FAC5C;
	Wed,  5 Mar 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165895; cv=none; b=F4gdaTji9yRPBRseo+8Dyy+Ckhv7HSas1CE2HDiZ0mdNSXd9xGdNFJP5s0hHv/0Kl3JYZSR25Cgvau07eFeKNlnZXZwSvDi+pMXnUTsbcE50S/NSOBh6JN3io9g3zTfv7gX04v7YZ/iYJe3l6znYFpq9YOd6oyCm4VHcLb3zfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165895; c=relaxed/simple;
	bh=egOC2PfcoDeyfTKNZ/NtHQw1qE5WDnh+O1nBdpnn79Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OooApXZrY4lad4vy+FoRgI1KZ+/eSDTXYnnj2bXABZgcxLfOIZBPztHin9+NOthHw7jasU/ZcaiVHIfPvYQ3ipGRWHavMTkCu3gRzjM81sWLWgq/f2aNELBxwATgCWNBn21+4szzwLlM6JZO0AsymywfccUoC/iV8oFKL1n4gF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 886911007;
	Wed,  5 Mar 2025 01:11:45 -0800 (PST)
Received: from [10.162.42.28] (K4MQJ0H1H2.blr.arm.com [10.162.42.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68643F66E;
	Wed,  5 Mar 2025 01:11:18 -0800 (PST)
Message-ID: <316c1ed4-bb22-4195-98ae-a4f50234131f@arm.com>
Date: Wed, 5 Mar 2025 14:41:15 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/9] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-8-npache@redhat.com>
 <0319c841-cde9-42f6-a230-39b050659f1a@arm.com>
 <CAA1CXcCej0ER2wPAdM4arw9JsZ7ZkS2e+hJRENSP0=q=pp8mJQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcCej0ER2wPAdM4arw9JsZ7ZkS2e+hJRENSP0=q=pp8mJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/03/25 12:43 am, Nico Pache wrote:
> On Wed, Feb 19, 2025 at 9:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 11/02/2025 00:30, Nico Pache wrote:
>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>> While scanning a PMD range for potential collapse candidates, keep track
>>> of pages in MIN_MTHP_ORDER chunks via a bitmap. Each bit represents a
>>> utilized region of order MIN_MTHP_ORDER ptes. We remove the restriction
>>> of max_ptes_none during the scan phase so we dont bailout early and miss
>>> potential mTHP candidates.
>>>
>>> After the scan is complete we will perform binary recursion on the
>>> bitmap to determine which mTHP size would be most efficient to collapse
>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>> determine how full a THP must be to be eligible.
>>>
>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>> pages, we dont perform the collapse.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>   mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++----------------
>>>   1 file changed, 83 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index c8048d9ec7fb..cd310989725b 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1127,13 +1127,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>   {
>>>        LIST_HEAD(compound_pagelist);
>>>        pmd_t *pmd, _pmd;
>>> -     pte_t *pte;
>>> +     pte_t *pte, mthp_pte;
>>>        pgtable_t pgtable;
>>>        struct folio *folio;
>>>        spinlock_t *pmd_ptl, *pte_ptl;
>>>        int result = SCAN_FAIL;
>>>        struct vm_area_struct *vma;
>>>        struct mmu_notifier_range range;
>>> +     unsigned long _address = address + offset * PAGE_SIZE;
>>>        VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>>
>>>        /*
>>> @@ -1148,12 +1149,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>                *mmap_locked = false;
>>>        }
>>>
>>> -     result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>>> +     result = alloc_charge_folio(&folio, mm, cc, order);
>>>        if (result != SCAN_SUCCEED)
>>>                goto out_nolock;
>>>
>>>        mmap_read_lock(mm);
>>> -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>>> +     *mmap_locked = true;
>>> +     result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>>>        if (result != SCAN_SUCCEED) {
>>>                mmap_read_unlock(mm);
>>>                goto out_nolock;
>>> @@ -1171,13 +1173,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>                 * released when it fails. So we jump out_nolock directly in
>>>                 * that case.  Continuing to collapse causes inconsistency.
>>>                 */
>>> -             result = __collapse_huge_page_swapin(mm, vma, address, pmd,
>>> -                             referenced, HPAGE_PMD_ORDER);
>>> +             result = __collapse_huge_page_swapin(mm, vma, _address, pmd,
>>> +                             referenced, order);
>>>                if (result != SCAN_SUCCEED)
>>>                        goto out_nolock;
>>>        }
>>>
>>>        mmap_read_unlock(mm);
>>> +     *mmap_locked = false;
>>>        /*
>>>         * Prevent all access to pagetables with the exception of
>>>         * gup_fast later handled by the ptep_clear_flush and the VM
>>> @@ -1187,7 +1190,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>         * mmap_lock.
>>>         */
>>>        mmap_write_lock(mm);
>>> -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>>> +     result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>>>        if (result != SCAN_SUCCEED)
>>>                goto out_up_write;
>>>        /* check if the pmd is still valid */
>>> @@ -1198,11 +1201,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>        vma_start_write(vma);
>>>        anon_vma_lock_write(vma->anon_vma);
>>>
>>> -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>> -                             address + HPAGE_PMD_SIZE);
>>> +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
>>> +                             _address + (PAGE_SIZE << order));
>>>        mmu_notifier_invalidate_range_start(&range);
>>>
>>>        pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>> +
>>>        /*
>>>         * This removes any huge TLB entry from the CPU so we won't allow
>>>         * huge and small TLB entries for the same virtual address to
>>> @@ -1216,10 +1220,10 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>        mmu_notifier_invalidate_range_end(&range);
>>>        tlb_remove_table_sync_one();
>>>
>>> -     pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>>> +     pte = pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
>>>        if (pte) {
>>> -             result = __collapse_huge_page_isolate(vma, address, pte, cc,
>>> -                                     &compound_pagelist, HPAGE_PMD_ORDER);
>>> +             result = __collapse_huge_page_isolate(vma, _address, pte, cc,
>>> +                                     &compound_pagelist, order);
>>>                spin_unlock(pte_ptl);
>>>        } else {
>>>                result = SCAN_PMD_NULL;
>>> @@ -1248,8 +1252,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>        anon_vma_unlock_write(vma->anon_vma);
>>>
>>>        result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>>> -                                        vma, address, pte_ptl,
>>> -                                        &compound_pagelist, HPAGE_PMD_ORDER);
>>> +                                        vma, _address, pte_ptl,
>>> +                                        &compound_pagelist, order);
>>>        pte_unmap(pte);
>>>        if (unlikely(result != SCAN_SUCCEED))
>>>                goto out_up_write;
>>> @@ -1260,20 +1264,37 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>         * write.
>>>         */
>>>        __folio_mark_uptodate(folio);
>>> -     pgtable = pmd_pgtable(_pmd);
>>> -
>>> -     _pmd = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>> -     _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>> -
>>> -     spin_lock(pmd_ptl);
>>> -     BUG_ON(!pmd_none(*pmd));
>>> -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>> -     folio_add_lru_vma(folio, vma);
>>> -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> -     set_pmd_at(mm, address, pmd, _pmd);
>>> -     update_mmu_cache_pmd(vma, address, pmd);
>>> -     deferred_split_folio(folio, false);
>>> -     spin_unlock(pmd_ptl);
>>> +     if (order == HPAGE_PMD_ORDER) {
>>> +             pgtable = pmd_pgtable(_pmd);
>>> +             _pmd = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>> +             _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>> +
>>> +             spin_lock(pmd_ptl);
>>> +             BUG_ON(!pmd_none(*pmd));
>>> +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
>>> +             folio_add_lru_vma(folio, vma);
>>> +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> +             set_pmd_at(mm, address, pmd, _pmd);
>>> +             update_mmu_cache_pmd(vma, address, pmd);
>>> +             deferred_split_folio(folio, false);
>>> +             spin_unlock(pmd_ptl);
>>> +     } else { //mTHP
>>> +             mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
>>> +             mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
>>> +
>>> +             spin_lock(pmd_ptl);
>>> +             folio_ref_add(folio, (1 << order) - 1);
>>> +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
>>> +             folio_add_lru_vma(folio, vma);
>>> +             spin_lock(pte_ptl);
>>> +             set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order));
>>> +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
>>> +             spin_unlock(pte_ptl);
>>> +             smp_wmb(); /* make pte visible before pmd */
>>> +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>> +             deferred_split_folio(folio, false);
>>> +             spin_unlock(pmd_ptl);
>>
>> I've only stared at this briefly, but it feels like there might be some bugs:
> 
> Sorry for the delayed response, I needed to catch up on some other
> work and wanted to make sure I looked into your questions before
> answering.
>>
>>   - Why are you taking the pmd ptl? and calling pmd_populate? Surely the pte
>> table already exists and is attached to the pmd? So we are only need to update
>> the pte entries here? Or perhaps the whole pmd was previously isolated?
> 
> The previous locking behavior is kept; however, because we are not
> installing a NEW pmd we need to repopulate the old PMD (like we do in
> the fail case). The PMD entry was cleared to avoid GUP-fast races.
>>
>>   - I think some arches use a single PTL for all levels of the pgtable? So in
>> this case it's probably not a good idea to nest the pmd and pte spin lock?
> 
> Thanks for pointing that out, I corrected it by making sure they dont nest!
> 
>>
>>   - Given the pte PTL is dropped then reacquired, is there any way that the ptes
>> could have changed under us? Is any revalidation required? Perhaps not if pte
>> table was removed from the PMD.
> 
> Correct, I believe we dont even need to take the PTL because of all
> the write locks we took-- but for now i'm trying to keep the locking
> changes to a minimum. We can focus on locking optimizations later.

Even the current code is sprinkled with comments like "Probably 
unnecessary" when, for example taking the PTL around set_ptes(). IMHO 
let us follow the same logic for now, and we can think about dropping 
the spinlocks later, so I will prefer taking the PMD-PTL around 
pmd_populate(), and take the PTE-PTL around set_ptes().

> 
>>
>>   - I would have guessed the memory ordering you want from smp_wmb() would
>> already be handled by the spin_unlock()?
> 
> Yes I think that is correct, I noticed other callers doing this, but
> on a second pass those are all lockless, so in this case we dont need
> it.
> 
>>
>>
>>> +     }
>>>
>>>        folio = NULL;
>>>
>>> @@ -1353,21 +1374,27 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>   {
>>>        pmd_t *pmd;
>>>        pte_t *pte, *_pte;
>>> +     int i;
>>>        int result = SCAN_FAIL, referenced = 0;
>>>        int none_or_zero = 0, shared = 0;
>>>        struct page *page = NULL;
>>>        struct folio *folio = NULL;
>>>        unsigned long _address;
>>> +     unsigned long enabled_orders;
>>>        spinlock_t *ptl;
>>>        int node = NUMA_NO_NODE, unmapped = 0;
>>>        bool writable = false;
>>> -
>>> +     int chunk_none_count = 0;
>>> +     int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - MIN_MTHP_ORDER);
>>> +     unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>>>        VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>>
>>>        result = find_pmd_or_thp_or_none(mm, address, &pmd);
>>>        if (result != SCAN_SUCCEED)
>>>                goto out;
>>>
>>> +     bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
>>> +     bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
>>>        memset(cc->node_load, 0, sizeof(cc->node_load));
>>>        nodes_clear(cc->alloc_nmask);
>>>        pte = pte_offset_map_lock(mm, pmd, address, &ptl);
>>> @@ -1376,8 +1403,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>                goto out;
>>>        }
>>>
>>> -     for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>> -          _pte++, _address += PAGE_SIZE) {
>>> +     for (i = 0; i < HPAGE_PMD_NR; i++) {
>>> +             if (i % MIN_MTHP_NR == 0)
>>> +                     chunk_none_count = 0;
>>> +
>>> +             _pte = pte + i;
>>> +             _address = address + i * PAGE_SIZE;
>>>                pte_t pteval = ptep_get(_pte);
>>>                if (is_swap_pte(pteval)) {
>>>                        ++unmapped;
>>> @@ -1400,16 +1431,14 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>                        }
>>>                }
>>>                if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>> +                     ++chunk_none_count;
>>>                        ++none_or_zero;
>>> -                     if (!userfaultfd_armed(vma) &&
>>> -                         (!cc->is_khugepaged ||
>>> -                          none_or_zero <= khugepaged_max_ptes_none)) {
>>> -                             continue;
>>> -                     } else {
>>> +                     if (userfaultfd_armed(vma)) {
>>>                                result = SCAN_EXCEED_NONE_PTE;
>>>                                count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>>                                goto out_unmap;
>>>                        }
>>> +                     continue;
>>>                }
>>>                if (pte_uffd_wp(pteval)) {
>>>                        /*
>>> @@ -1500,7 +1529,16 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>                     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
>>>                                                                     address)))
>>>                        referenced++;
>>> +
>>> +             /*
>>> +              * we are reading in MIN_MTHP_NR page chunks. if there are no empty
>>> +              * pages keep track of it in the bitmap for mTHP collapsing.
>>> +              */
>>> +             if (chunk_none_count < scaled_none &&
>>> +                     (i + 1) % MIN_MTHP_NR == 0)
>>> +                     bitmap_set(cc->mthp_bitmap, i / MIN_MTHP_NR, 1);
>>>        }
>>> +
>>>        if (!writable) {
>>>                result = SCAN_PAGE_RO;
>>>        } else if (cc->is_khugepaged &&
>>> @@ -1513,10 +1551,14 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>   out_unmap:
>>>        pte_unmap_unlock(pte, ptl);
>>>        if (result == SCAN_SUCCEED) {
>>> -             result = collapse_huge_page(mm, address, referenced,
>>> -                                         unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>>> -             /* collapse_huge_page will return with the mmap_lock released */
>>> -             *mmap_locked = false;
>>> +             enabled_orders = thp_vma_allowable_orders(vma, vma->vm_flags,
>>> +                     tva_flags, THP_ORDERS_ALL_ANON);
>>> +             result = khugepaged_scan_bitmap(mm, address, referenced, unmapped, cc,
>>> +                            mmap_locked, enabled_orders);
>>> +             if (result > 0)
>>> +                     result = SCAN_SUCCEED;
>>> +             else
>>> +                     result = SCAN_FAIL;
>>>        }
>>>   out:
>>>        trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
>>> @@ -2476,11 +2518,13 @@ static int khugepaged_collapse_single_pmd(unsigned long addr, struct mm_struct *
>>>                        fput(file);
>>>                        if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
>>>                                mmap_read_lock(mm);
>>> +                             *mmap_locked = true;
>>>                                if (khugepaged_test_exit_or_disable(mm))
>>>                                        goto end;
>>>                                result = collapse_pte_mapped_thp(mm, addr,
>>>                                                                 !cc->is_khugepaged);
>>>                                mmap_read_unlock(mm);
>>> +                             *mmap_locked = false;
>>>                        }
>>>                } else {
>>>                        result = khugepaged_scan_pmd(mm, vma, addr,
>>
> 

