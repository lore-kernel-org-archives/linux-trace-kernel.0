Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CD47887F;
	Thu,  4 Jun 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576808; cv=none; b=HOibtiXnAYK1AU7VxWqUh4L8I12MrrYuQ5/b2XzjfomD452lUgLGrJn/dZukpvNCBUYZ9soxnAWQbawqZg4uNjnbsU7YLjaOISbd/4qltQNJGBs6CY80hCa6lSxynuS7o5VpqbnZRHxnahOV9Qf0iMIWXBYH43muAw0eVYryuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576808; c=relaxed/simple;
	bh=pclW1AIePm60uNooJqTgNYLAEYB8wxyrLQufPlIIbs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK41wqNRiF7hWnHT/3m4IY0tirgybHeiKO2ADUF1XAAP5/AfNYusMx9qiS1EjOXuVW7yzxGr4YquEeDM8uguuljNK1YX0u5af1xIduKwp8VUrVS0DS0lrv/64LhgZ84ha/aUdyBTw/DPmKNcV09lXV6UBmxmMA9Y/5ElxBlUXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQcWP/EL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQcWP/EL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BB81F00893;
	Thu,  4 Jun 2026 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576802;
	bh=4opj3K3uvrQEthGEJN16ENfmtJloc4qZSIKDG3RA7Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NQcWP/EL7C6pg9NfqaZ2/W/FLgJwoEBsiF2qspJ7ArpAAHHaFprJ7Owscsu0ObHEK
	 +nv7dN08Gg7R/ljt1B9d2k8qb6z+yIzfBlALlPL2NibVIfwKCC0kKPZrEz9aSOg+de
	 fqyj6nMO058us8qPDQU0uVUHOJHSAQWOLtCIPYR3hMki6Ftw6Apb8HTbw6zvyFMd/h
	 5dPazzKOJ7kWztn9FhL8Y1Dc1W5YTGdkexWL0i4HxmmMIVJbNf0GDjtcVaKDmCuIeN
	 yRqzbeJOGgIsXeUgE3clScJoWp6R+9gIGCvyKG5Bw1GBAFsi8Euii5szkYPuP9ym5Q
	 QbG46cDWxTdjg==
Date: Thu, 4 Jun 2026 13:39:47 +0100
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
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <aiFw80oLty6F_-8m@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-7-npache@redhat.com>
 <aiFTSLb0kkTR7I9A@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFTSLb0kkTR7I9A@lucifer>

On Thu, Jun 04, 2026 at 12:38:30PM +0100, Lorenzo Stoakes wrote:
> I will go review the thread about the cache maintenance separately and
> respond about that.
>
> On Fri, May 22, 2026 at 09:00:01AM -0600, Nico Pache wrote:
> > Pass an order and offset to collapse_huge_page to support collapsing anon
> > memory to arbitrary orders within a PMD. order indicates what mTHP size we
> > are attempting to collapse to, and offset indicates were in the PMD to
> > start the collapse attempt.
> >
> > For non-PMD collapse we must leave the anon VMA write locked until after
> > we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> > the mTHP case this is not true, and we must keep the lock to prevent
> > access/changes to the page tables. This can happen if the rmap walkers hit
> > a pmd_none while the PMD entry is currently unavailable due to being
> > temporarily removed during the collapse phase.
> >
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> The logic LGTM generally, some questions for understanding below, and of
> course as per above I want to review the Lance/David subthread.
>
> Thanks!
>
> > ---
> >  mm/khugepaged.c | 93 +++++++++++++++++++++++++++++--------------------
> >  1 file changed, 55 insertions(+), 38 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fab35d318641..d64f42f66236 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1214,34 +1214,36 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
> >   * while allocating a THP, as that could trigger direct reclaim/compaction.
> >   * Note that the VMA must be rechecked after grabbing the mmap_lock again.
> >   */
> > -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > -		int referenced, int unmapped, struct collapse_control *cc)
> > +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
> > +		int referenced, int unmapped, struct collapse_control *cc,
> > +		unsigned int order)
> >  {
> > +	const unsigned long pmd_addr = start_addr & HPAGE_PMD_MASK;
> > +	const unsigned long end_addr = start_addr + (PAGE_SIZE << order);
> >  	LIST_HEAD(compound_pagelist);
> >  	pmd_t *pmd, _pmd;
> > -	pte_t *pte;
> > +	pte_t *pte = NULL;
>
> As mentioned elsewhere for some reason this was dropped in
> mm-unstable. Maybe a bad conflict resolution?
>
> >  	pgtable_t pgtable;
> >  	struct folio *folio;
> >  	spinlock_t *pmd_ptl, *pte_ptl;
> >  	enum scan_result result = SCAN_FAIL;
> >  	struct vm_area_struct *vma;
> >  	struct mmu_notifier_range range;
> > +	bool anon_vma_locked = false;
> >
> > -	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > -
> > -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > +	result = alloc_charge_folio(&folio, mm, cc, order);
> >  	if (result != SCAN_SUCCEED)
> >  		goto out_nolock;
> >
> >  	mmap_read_lock(mm);
> > -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > -					 HPAGE_PMD_ORDER);
> > +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
> > +					 &vma, cc, order);
> >  	if (result != SCAN_SUCCEED) {
> >  		mmap_read_unlock(mm);
> >  		goto out_nolock;
> >  	}
> >
> > -	result = find_pmd_or_thp_or_none(mm, address, &pmd);
> > +	result = find_pmd_or_thp_or_none(mm, pmd_addr, &pmd);
> >  	if (result != SCAN_SUCCEED) {
> >  		mmap_read_unlock(mm);
> >  		goto out_nolock;
> > @@ -1253,8 +1255,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> >  		 * released when it fails. So we jump out_nolock directly in
> >  		 * that case.  Continuing to collapse causes inconsistency.
> >  		 */
> > -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> > -						     referenced, HPAGE_PMD_ORDER);
> > +		result = __collapse_huge_page_swapin(mm, vma, start_addr, pmd,
> > +						     referenced, order);
> >  		if (result != SCAN_SUCCEED)
> >  			goto out_nolock;
> >  	}
> > @@ -1269,20 +1271,21 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> >  	 * mmap_lock.
> >  	 */
> >  	mmap_write_lock(mm);
> > -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > -					 HPAGE_PMD_ORDER);
> > +	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
> > +					 &vma, cc, order);
> >  	if (result != SCAN_SUCCEED)
> >  		goto out_up_write;
> >  	/* check if the pmd is still valid */
> >  	vma_start_write(vma);

Hmm actually I think we have another problem here.

For PMD THP this is fine. Only a single VMA can span the range we need, and it
will span the entire PMD.

But for mTHP we have an issue...

See below...

> > -	result = check_pmd_still_valid(mm, address, pmd);
> > +	result = check_pmd_still_valid(mm, pmd_addr, pmd);
> >  	if (result != SCAN_SUCCEED)
> >  		goto out_up_write;
> >
> >  	anon_vma_lock_write(vma->anon_vma);
> > +	anon_vma_locked = true;
>
> I worry that we hold this lock a lot longer now? Maybe the algorithmic
> change alters that, but Claude did suggest on the s390 bug that longer lock
> hold might be an issue.
>
> I wonder if we'll observe lock contention as a result?
>
> Correct me if I'm wrong and we're not holding longer than previously,
> however. Just appears that we do.
>
> >
> > -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -				address + HPAGE_PMD_SIZE);
> > +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_addr,
> > +				end_addr);
> >  	mmu_notifier_invalidate_range_start(&range);
> >
> >  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> > @@ -1294,26 +1297,23 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> >  	 * Parallel GUP-fast is fine since GUP-fast will back off when
> >  	 * it detects PMD is changed.
> >  	 */
> > -	_pmd = pmdp_collapse_flush(vma, address, pmd);
> > +	_pmd = pmdp_collapse_flush(vma, pmd_addr, pmd);

...So we exclude VMA locked faults faulting in a new PMD entry for PMD-sized THP
but for mTHP we might have _another_ VMA that spans another part of the range
mapped by the same PMD entry.

So we clear this, but we do not have a write lock on any other VMA, and so
racing VMA read locks can install a new PMD entry.

> >  	spin_unlock(pmd_ptl);

Especially since you unlock this :)

And...

> >  	mmu_notifier_invalidate_range_end(&range);
> >  	tlb_remove_table_sync_one();
> >
> > -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > +	pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
> >  	if (pte) {
> > -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> > -						      HPAGE_PMD_ORDER,
> > -						      &compound_pagelist);
> > +		result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
> > +						      order, &compound_pagelist);
> >  		spin_unlock(pte_ptl);
> >  	} else {
> >  		result = SCAN_NO_PTE_TABLE;
> >  	}
> >
> >  	if (unlikely(result != SCAN_SUCCEED)) {
> > -		if (pte)
> > -			pte_unmap(pte);
>
> OK I seem to remember this is because we're holding the anon_vma lock
> longer. That does imply that on e.g. x86-64 the RCU lock is being held a
> bit longer also as well as the anon_vma loc.
>
> I guess it's also because we need to hold anon_vma and pte lock because
> we're fiddling around at PTE level for mTHP not just PMD level as 'classic'
> THP did.
>
> (Rememberings going on here :)
>
> >  		spin_lock(pmd_ptl);
> > -		BUG_ON(!pmd_none(*pmd));
> > +		WARN_ON_ONCE(!pmd_none(*pmd));

...this will get triggered.

I don't know whether we can safely hold the PMD lock across everything here for
mTHP?

Maybe the solution would have to be to scan through VMAs in the range of the PMD
and VMA write lock each of them?

That could cause some 'interesting' lock contention issues though? Then again,
we will be releasing the mmap write lock soon enough which will drop the VMA
write locks.

> >  		/*
> >  		 * We can only use set_pmd_at when establishing
> >  		 * hugepmds and never for establishing regular pmds that
> > @@ -1321,21 +1321,24 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> >  		 */
> >  		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> >  		spin_unlock(pmd_ptl);
> > -		anon_vma_unlock_write(vma->anon_vma);
> >  		goto out_up_write;
> >  	}
> >
> >  	/*
> > -	 * All pages are isolated and locked so anon_vma rmap
> > -	 * can't run anymore.
> > +	 * For PMD collapse all pages are isolated and locked so anon_vma
> > +	 * rmap can't run anymore. For mTHP collapse the PMD entry has been
> > +	 * removed and not all pages are isolated and locked, so we must hold
>
> Right because some PTE entries be unaffected by the change.
>
> > +	 * the lock to prevent neighboring folios from attempting to access
> > +	 * this PMD until its reinstalled.
>
> OK. This is slightly annoying for my CoW context work as it means there's
> another case where we need to explicitly hold an anon_vma lock for
> correctness :)
>
> Anyway I will think about that separately, is what it is. And in fact
> motivates to want this merged earlier so I can work against it :)
>
>
> >  	 */
> > -	anon_vma_unlock_write(vma->anon_vma);
> > +	if (is_pmd_order(order)) {
> > +		anon_vma_unlock_write(vma->anon_vma);
> > +		anon_vma_locked = false;
> > +	}
> >
> >  	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -					   vma, address, pte_ptl,
> > -					   HPAGE_PMD_ORDER,
> > -					   &compound_pagelist);
> > -	pte_unmap(pte);
> > +					   vma, start_addr, pte_ptl,
> > +					   order, &compound_pagelist);
> >  	if (unlikely(result != SCAN_SUCCEED))
> >  		goto out_up_write;
> >
> > @@ -1345,18 +1348,32 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> >  	 * write.
> >  	 */
> >  	__folio_mark_uptodate(folio);
> > -	pgtable = pmd_pgtable(_pmd);
> > -
> >  	spin_lock(pmd_ptl);
> > -	BUG_ON(!pmd_none(*pmd));
> > -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
> > +	WARN_ON_ONCE(!pmd_none(*pmd));
> > +	if (is_pmd_order(order)) {
> > +		pgtable = pmd_pgtable(_pmd);
> > +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
> > +	} else {
> > +		/*
> > +		 * set_ptes is called in map_anon_folio_pte_nopf with the
> > +		 * pmd_ptl lock still held; this is safe as the PMD is expected
>
> PMD entry you mean?
>
> > +		 * to be none. The pmd entry is then repopulated below.
> > +		 */
> > +		map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
>
> So here we populate entries in the existing PTE _table_ to point at the new
> order>0 folio? With arm64 of course doing transparent contpte stuff?
>
> > +		smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */
> > +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>
> And then we reinstall the pre-existing PMD _entry_ from none -> what it was
> before?
>
> > +	}
> >  	spin_unlock(pmd_ptl);
> >
> >  	folio = NULL;
> >
> >  	result = SCAN_SUCCEED;
> >  out_up_write:
> > +	if (anon_vma_locked)
> > +		anon_vma_unlock_write(vma->anon_vma);
> > +	if (pte)
> > +		pte_unmap(pte);
> >  	mmap_write_unlock(mm);
> >  out_nolock:
> >  	if (folio)
> > @@ -1536,7 +1553,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  		/* collapse_huge_page expects the lock to be dropped before calling */
> >  		mmap_read_unlock(mm);
> >  		result = collapse_huge_page(mm, start_addr, referenced,
> > -					    unmapped, cc);
> > +					    unmapped, cc, HPAGE_PMD_ORDER);
> >  		/* collapse_huge_page will return with the mmap_lock released */
> >  		*lock_dropped = true;
> >  	}
> > --
> > 2.54.0
> >

Thanks, Lorenzo
