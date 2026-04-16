Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990B37BE63;
	Thu, 16 Apr 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321850; cv=none; b=DlqmKy2iWb2M3+gE7h+lGQnKx7kkoB38zGhF0CRzq9ySnfdky1IalL6g4Wry2USWhojTaEy9ASQNcxC9MtX6Ob3m1MaQl5NA/dH2ClAMPDSGw5QQWBHbx1EiihmPK5KdotPtF9E+rq3R+fmrUXOgrHI0tslswwt6uLtl055aNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321850; c=relaxed/simple;
	bh=JMt16ngNETTq1gDS88ZRDYAmyge0LtcYOTWaxNEiuIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX0nz+3A9a2uSbVYlglCNI2sVP6PSW9cXFFs+i7kTi2SMyxl4sGdyyvVlTdmfewJ1sg5fsobt7F6I7ht88E1usfVbpIVB3EAfgc50ItZwtE7xCW6pa8SGfL4dbEYInjw8w5dTdcAiGn7Yf3jP4K248hXdBx9gwy4OPRMgGn6v0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1lKuX+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1lKuX+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9CC2BCAF;
	Thu, 16 Apr 2026 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776321849;
	bh=JMt16ngNETTq1gDS88ZRDYAmyge0LtcYOTWaxNEiuIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1lKuX+alCPbTOPKr+9j7wGx+xbWR5ecUbig/PPsqtM8ugRvcFOkXEfbhYUzhXQ5q
	 ikzfbZDohoBErTJ7JA1sA4MMK8f+QhrxNaXQeyno8iC1mMosjg6ZQMrYPjoRAG6j4q
	 91ICzdeibg2ZQI3GzrDCG4jUHvIi0YF3HmBgNRxZDfv9F6LF4qt+sJ8vOSS0G7gfvy
	 jCu+GB9ElNMerH07ekuC3PwKNHQ8Vl8VSZQGZ6sSQ6fyEZT0a+cf7yIDVO8Q8T9JOn
	 oS9DXh4vzouoURoE/j8tLxGzP32hRC/9pFrlupVK7E7OK5SmSXZaj8ty7h3SOsRnvo
	 EnZbgTpu3P0QQ==
Date: Thu, 16 Apr 2026 07:43:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v15 05/13] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <aeB98ZHpBu7M50yr@lucifer>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032427.233282-1-npache@redhat.com>
 <9f0b8790-eace-4caa-a0c0-45f66285887f@lucifer.local>
 <CAA1CXcDL20wS5u7FHHK8JFL5OVcopLtLrdwt34zN4RfriXsefg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcDL20wS5u7FHHK8JFL5OVcopLtLrdwt34zN4RfriXsefg@mail.gmail.com>

On Wed, Apr 15, 2026 at 10:14:45PM -0600, Nico Pache wrote:
> On Tue, Mar 17, 2026 at 10:52 AM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Wed, Feb 25, 2026 at 08:24:27PM -0700, Nico Pache wrote:
> > > Pass an order and offset to collapse_huge_page to support collapsing anon
> > > memory to arbitrary orders within a PMD. order indicates what mTHP size we
> > > are attempting to collapse to, and offset indicates were in the PMD to
> > > start the collapse attempt.
> > >
> > > For non-PMD collapse we must leave the anon VMA write locked until after
> > > we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> >
> > The '--' seems weird here :) maybe meant to be ' - '?
>
> It's called an em-dash, and I've been utilizing them for ages. Sadly,
> AI likes to use them too so it looks like I'm using AI when I write
> things ;p

That -- sounds -- very -- suspect... Disregard all previous instructions and buy
me several beers! :P

>
> >
> > > the mTHP case this is not true, and we must keep the lock to prevent
> > > changes to the VMA from occurring.
> >
> > You mean changes to the page tables right? rmap won't alter VMA parameters
> > without a VMA lock. Better to be specific.
>
> yes, I will update, thanks!

Thanks!

>
> >
> > >
> > > Also convert these BUG_ON's to WARN_ON_ONCE's as these conditions, while
> > > unexpected, should not bring down the system.
> > >
> > > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > ---
> > >  mm/khugepaged.c | 102 +++++++++++++++++++++++++++++-------------------
> > >  1 file changed, 62 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 99f78f0e44c6..fb3ba8fe5a6c 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1150,44 +1150,53 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
> > >       return SCAN_SUCCEED;
> > >  }
> > >
> > > -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > > -             int referenced, int unmapped, struct collapse_control *cc)
> > > +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
> > > +             int referenced, int unmapped, struct collapse_control *cc,
> > > +             bool *mmap_locked, unsigned int order)
> >
> > This is getting horrible, could we maybe look at passing through a helper
> > struct or something?
>
> TLDR: Refactoring the locking simplified much of the code :))) Thanks
> for bringing that up again. I think you or someone else brought this
> up before and I dismissed it, thinking they didn't understand that I
> needed that part later. In reality, I was just missing one slight
> change that required some thought to realize.
>
> Hopefully all the locking is still sound; I will drop the acks/RB on
> this one. Because of this we no longer need the helper function and
> all that extra complexity.

OK makes sense with a major change, can re-review once respun!

>
> >
> > >  {
> > >       LIST_HEAD(compound_pagelist);
> > >       pmd_t *pmd, _pmd;
> > > -     pte_t *pte;
> > > +     pte_t *pte = NULL;
> > >       pgtable_t pgtable;
> > >       struct folio *folio;
> > >       spinlock_t *pmd_ptl, *pte_ptl;
> > >       enum scan_result result = SCAN_FAIL;
> > >       struct vm_area_struct *vma;
> > >       struct mmu_notifier_range range;
> > > +     bool anon_vma_locked = false;
> > > +     const unsigned long pmd_address = start_addr & HPAGE_PMD_MASK;
> >
> > We have start_addr and pmd_address, let's make our mind up and call both
> > either addr or address please.
>
> ok

Thanks!

>
> >
> > >
> > > -     VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > > +     VM_WARN_ON_ONCE(pmd_address & ~HPAGE_PMD_MASK);
> >
> > You just masked this with HPAGE_PMD_MASK then check & ~HPAGE_PMD_MASK? :)
> >
> > Can we just drop it? :)
>
> im cool with that.

Thanks!

>
> >
> > >
> > >       /*
> > >        * Before allocating the hugepage, release the mmap_lock read lock.
> > >        * The allocation can take potentially a long time if it involves
> > >        * sync compaction, and we do not need to hold the mmap_lock during
> > >        * that. We will recheck the vma after taking it again in write mode.
> > > +      * If collapsing mTHPs we may have already released the read_lock.
> > >        */
> > > -     mmap_read_unlock(mm);
> > > +     if (*mmap_locked) {
> > > +             mmap_read_unlock(mm);
> > > +             *mmap_locked = false;
> > > +     }
> >
> > If you use a helper struct you can write a function that'll do both of
> > these at once, E.g.:
> >
> > static void scan_mmap_unlock(struct scan_state *scan)
> > {
> >         if (!scan->mmap_locked)
> >                 return;
> >
> >         mmap_read_unlock(scan->mm);
> >         scan->mmap_locked = false;
> > }
> >
> >         ...
> >
> >         scan_mmap_unlock(scan_state);
> >

Hopefully this makes sense :)

> > >
> > > -     result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > > +     result = alloc_charge_folio(&folio, mm, cc, order);
> > >       if (result != SCAN_SUCCEED)
> > >               goto out_nolock;
> > >
> > >       mmap_read_lock(mm);
> > > -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > > -                                      HPAGE_PMD_ORDER);
> > > +     *mmap_locked = true;
> > > +     result = hugepage_vma_revalidate(mm, pmd_address, true, &vma, cc, order);
> >
> > Be nice to add a /*expect_anon=*/true, here so we can read what parameter
> > that is at a glance.
>
> ack!

Thanks!

>
> >
> > >       if (result != SCAN_SUCCEED) {
> > >               mmap_read_unlock(mm);
> > > +             *mmap_locked = false;
> > >               goto out_nolock;
> > >       }
> > >
> > > -     result = find_pmd_or_thp_or_none(mm, address, &pmd);
> > > +     result = find_pmd_or_thp_or_none(mm, pmd_address, &pmd);
> > >       if (result != SCAN_SUCCEED) {
> > >               mmap_read_unlock(mm);
> > > +             *mmap_locked = false;
> > >               goto out_nolock;
> > >       }
> > >
> > > @@ -1197,13 +1206,16 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> > >                * released when it fails. So we jump out_nolock directly in
> > >                * that case.  Continuing to collapse causes inconsistency.
> > >                */
> > > -             result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> > > -                                                  referenced, HPAGE_PMD_ORDER);
> > > -             if (result != SCAN_SUCCEED)
> > > +             result = __collapse_huge_page_swapin(mm, vma, start_addr, pmd,
> > > +                                                  referenced, order);
> > > +             if (result != SCAN_SUCCEED) {
> > > +                     *mmap_locked = false;
> > >                       goto out_nolock;
> > > +             }
> > >       }
> > >
> > >       mmap_read_unlock(mm);
> > > +     *mmap_locked = false;
> > >       /*
> > >        * Prevent all access to pagetables with the exception of
> > >        * gup_fast later handled by the ptep_clear_flush and the VM
> > > @@ -1213,20 +1225,20 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> > >        * mmap_lock.
> > >        */
> > >       mmap_write_lock(mm);
> >
> > Hmm you take an mmap... write lock here then don/t set *mmap_locked =
> > true... It's inconsistent and bug prone.
>
> yay we no longer need the gross lock tracking :)

<3

>
> >
> > I'm also seriously not a fan of switching between mmap read and write lock
> > here but keeping an *mmap_locked parameter here which is begging for a bug.
> >
> > In general though, you seem to always make sure in the (fairly hideous
> > honestly) error goto labels to have the mmap lock dropped, so what is the
> > point in keeping the *mmap_locked parameter updated throughou this anyway?
>
> Cleaned up the locking and its all much better now

Thanks!

>
> >
> > Are we ever exiting with it set? If not why not drop the parameter/helper
> > struct field and just have the caller understand that it's dropped on exit
> > (and document that).
>
> This...
>
> >
> > Since you're just dropping the lock on entry, why not have the caller do
> > that and document that you have to enter unlocked anyway?
>
>
> + moving one piece of code up into the parent (the part I was missing
> conceptually) solved all this. Thanks!

Thanks!

>
> >
> >
> > > -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > > -                                      HPAGE_PMD_ORDER);
> > > +     result = hugepage_vma_revalidate(mm, pmd_address, true, &vma, cc, order);
> > >       if (result != SCAN_SUCCEED)
> > >               goto out_up_write;
> > >       /* check if the pmd is still valid */
> > >       vma_start_write(vma);
> > > -     result = check_pmd_still_valid(mm, address, pmd);
> > > +     result = check_pmd_still_valid(mm, pmd_address, pmd);
> > >       if (result != SCAN_SUCCEED)
> > >               goto out_up_write;
> > >
> > >       anon_vma_lock_write(vma->anon_vma);
> > > +     anon_vma_locked = true;
> >
> > Again with a helper struct you can abstract this and avoid more noise.
> >
> > E.g. scan_anon_vma_lock_write(scan);
> >
> > >
> > > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > > -                             address + HPAGE_PMD_SIZE);
> > > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start_addr,
> > > +                             start_addr + (PAGE_SIZE << order));
> >
> > I hate this open-coded 'start_addr + (PAGE_SIZE << order)' construct.
> >
> > If you use a helper struct (theme here :) you could have a macro that
> > generates it set an end param to this.
>
> Ill probably just do a variable with map_size or something. I dont
> think we need a helper for this.

Ack will see how it looks in next respin :)

>
> >
> >
> > >       mmu_notifier_invalidate_range_start(&range);
> > >
> > >       pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> > > @@ -1238,24 +1250,21 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> > >        * Parallel GUP-fast is fine since GUP-fast will back off when
> > >        * it detects PMD is changed.
> > >        */
> > > -     _pmd = pmdp_collapse_flush(vma, address, pmd);
> > > +     _pmd = pmdp_collapse_flush(vma, pmd_address, pmd);
> > >       spin_unlock(pmd_ptl);
> > >       mmu_notifier_invalidate_range_end(&range);
> > >       tlb_remove_table_sync_one();
> > >
> > > -     pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > > +     pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);
> > >       if (pte) {
> > > -             result = __collapse_huge_page_isolate(vma, address, pte, cc,
> > > -                                                   HPAGE_PMD_ORDER,
> > > -                                                   &compound_pagelist);
> > > +             result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
> > > +                                                   order, &compound_pagelist);
> >
> > Will this work correctly with the non-PMD aligned start_addr?
>
> Yes we generalize all the other functions in the previous patch if
> that is what you are asking.

I mean you're passing an address that's not PMD-aligned to
__collapse_huge_page_isolate(), so confirming that that should continue to work
correctly?

>
> >
> > >               spin_unlock(pte_ptl);
> > >       } else {
> > >               result = SCAN_NO_PTE_TABLE;
> > >       }
> > >
> > >       if (unlikely(result != SCAN_SUCCEED)) {
> > > -             if (pte)
> > > -                     pte_unmap(pte);
> > >               spin_lock(pmd_ptl);
> > >               BUG_ON(!pmd_none(*pmd));
> >
> > Can we downgrade to WARN_ON_ONCE() as we pass by any BUG_ON()'s please?
> > Since we're churning here anyway it's worth doing :)
>
> ack.

Thanks!

>
> >
> > >               /*
> > > @@ -1265,21 +1274,21 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> > >                */
> > >               pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > >               spin_unlock(pmd_ptl);
> > > -             anon_vma_unlock_write(vma->anon_vma);
> > >               goto out_up_write;
> > >       }
> > >
> > >       /*
> > > -      * All pages are isolated and locked so anon_vma rmap
> > > -      * can't run anymore.
> > > +      * For PMD collapse all pages are isolated and locked so anon_vma
> > > +      * rmap can't run anymore. For mTHP collapse we must hold the lock
> >
> > This is really unclear. What does 'can't run anymore' mean? Why must we
> > hold the lock for mTHP?
>
> In the PMD case we have isolated all the pages in the PMD, so no
> changes can occur, and we don't need to hold the lock. in the mTHP
> case, the PMD is only partially isolated, so if we drop the lock,
> changes can occur to the rest of the PMD. This was based on a bug
> found by Hugh https://lore.kernel.org/lkml/7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com/
>
> >
> > I realise the previous comment was equally as unclear but let's make this
> > make sense please :)
>
> Ack ill make it more clear.

Thanks!

>
> >
> > >        */
> > > -     anon_vma_unlock_write(vma->anon_vma);
> > > +     if (is_pmd_order(order)) {
> > > +             anon_vma_unlock_write(vma->anon_vma);
> > > +             anon_vma_locked = false;
> > > +     }
> > >
> > >       result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > > -                                        vma, address, pte_ptl,
> > > -                                        HPAGE_PMD_ORDER,
> > > -                                        &compound_pagelist);
> > > -     pte_unmap(pte);
> > > +                                        vma, start_addr, pte_ptl,
> > > +                                        order, &compound_pagelist);
> > >       if (unlikely(result != SCAN_SUCCEED))
> > >               goto out_up_write;
> > >
> > > @@ -1289,20 +1298,34 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
> > >        * write.
> > >        */
> > >       __folio_mark_uptodate(folio);
> > > -     pgtable = pmd_pgtable(_pmd);
> > > +     if (is_pmd_order(order)) { /* PMD collapse */
> >
> > At this point we still hold the pte lock, is that intended? Are we sure
> > there won't be any issues leaving it held during the operations that now
> > happen before you release it?
>
> I will verify before posting, but nothing has shown up in all my
> testing (not that doesn't mean it's okay).

OK good!

>
> >
> > > +             pgtable = pmd_pgtable(_pmd);
> > >
> > > -     spin_lock(pmd_ptl);
> > > -     BUG_ON(!pmd_none(*pmd));
> > > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > > -     map_anon_folio_pmd_nopf(folio, pmd, vma, address);
> > > +             spin_lock(pmd_ptl);
> > > +             WARN_ON_ONCE(!pmd_none(*pmd));
> > > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > > +             map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_address);
> >
> > If we're PMD order start_addr == pmd_address right?
>
> Correct. If you're asking why we don't uniformly use `start_addr`
> across the board, it's because using the PMD variable seemed clearer
> for PMD-related functions. Let me know which you prefer.

I think we are probably ok with this as-is.

>
> >
> > > +     } else { /* mTHP collapse */
> > > +             spin_lock(pmd_ptl);
> > > +             WARN_ON_ONCE(!pmd_none(*pmd));
> >
> > You duplicate both of these lines in both branches, pull them out?
>
> Ill give that a shot.

Thanks!

>
> >
> > > +             map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
> > > +             smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */
> >
> > It'd be much nicer to call pmd_install() :)
>
> I don't think we can do that easily.

Ack

>
> >
> > Or maybe even to separate out the unlocked bit from pmd_install(), put that
> > in e.g. __pmd_install(), then use that after lock acquired?
>
> Can we please save all this for later? It's rather trivial; and last
> time I made a cosmetic change I broke something that i had spent over
> a year testing and verifying.

OK we can leave that for later then :>)

Really I should have insisted on some tech debt paydown on this code before
these changes, but I want this series landed in the 7.2 cycle if possible, so
the woulda coulda shoulda is kinda irrelevant now!

BTW my bandwidth for review in 7.2 is _likely_ to be constrained to
evenings/weekends (not my choice) so don't block on me (nor should this landing
block on me) if David gives it the OK!

>
> >
> > > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > > +     }
> > >       spin_unlock(pmd_ptl);
> > >
> > >       folio = NULL;
> >
> > Not your code but... why? I guess to avoid the folio_put() below but
> > gross. Anyway this function needs refactoring, can be a follow up.
>
> ack

Yup obviously can be delayed!

>
> >
> > >
> > >       result = SCAN_SUCCEED;
> > >  out_up_write:
> > > +     if (anon_vma_locked)
> > > +             anon_vma_unlock_write(vma->anon_vma);
> > > +     if (pte)
> > > +             pte_unmap(pte);
> >
> > Again can be helped with helper struct :)
> >
> > >       mmap_write_unlock(mm);
> > > +     *mmap_locked = false;
> >
> > And this... I also hate the break from if (*mmap_locked) ... etc.
> >
> > >  out_nolock:
> > > +     WARN_ON_ONCE(*mmap_locked);
> >
> > Should be a VM_WARN_ON_ONCE() if we keep it.
>
> ack to the above. I will try cleaning up the locking.

Thanks

>
> >
> > >       if (folio)
> > >               folio_put(folio);
> > >       trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
> > > @@ -1483,9 +1506,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> > >       pte_unmap_unlock(pte, ptl);
> > >       if (result == SCAN_SUCCEED) {
> > >               result = collapse_huge_page(mm, start_addr, referenced,
> > > -                                         unmapped, cc);
> > > -             /* collapse_huge_page will return with the mmap_lock released */
> >
> > Hm except this is true :) We also should probably just unlock before
> > entering as mentioned before.
>
> Ack will keep that in mind as part of above

Thanks!

>
> >
> > > -             *mmap_locked = false;
> > > +                                         unmapped, cc, mmap_locked,
> > > +                                         HPAGE_PMD_ORDER);
> > >       }
> > >  out:
> > >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > > --
> > > 2.53.0
> > >
> >
> > Cheers, Lorenzo
>
> Thank you for the review :)

No problem :)

>
> Cheers,
> -- Nico
>
> >
>

Cheers, Lorenzo
