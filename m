Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79172F7EF2;
	Fri,  5 Jun 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683338; cv=none; b=qrNnYasYC6BvEHWU9k9Nx40CZ7SUAlabtSGMyOikzpP6ld+7WAlEbODD7YFCSn85wXtpc/vplqBjuuHuIoTWA5JV2yjHjmBwhn4oUeElbVVjS02qicBclVdxJb1W5XcwLCMx04HhrpDM4tJC65kvRkK8hb3h278LJgNEV1Eq7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683338; c=relaxed/simple;
	bh=UbWSzDZ9VmnmThlimm6vXWprWmd3cIp+pSGFMBJLpSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieRolXudzRErinctuwCgPH2MXy9JQJGuO1/9+5jroCkgVgl5ZTD503q2b+bAYY/DAiFcq64jLGL1L3kYUlJFmn1+HKvBbPIuG0SJGgyzJcJtau0Vp8rpb99j6s/4LXhjRRST/GVUyX1LJX3XNkm4jEaX3StzxChwb9r8iUYmaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPs0Z/Oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPs0Z/Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FA71F00893;
	Fri,  5 Jun 2026 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780683336;
	bh=reeAFoaFN+CcGwhazrbMB4doZ8QUZrono+SMRJCmxq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPs0Z/OjVHZLjqP6hNhuyanUv7GJ5SEtlBUVtbQu6bVhaiqKvCUIcR7tBr+PRPxS5
	 Zo7NUDhX2vZubZ5fIXOKAg7MlxnlPrg443U7H8kngrWNWMPC+HfNlry25RKXxLH66d
	 jppbwogIn0jn1YS5vFuk+Cm+KNAl20X4dUZcbxcph2vRe/J6my9mqIZmQFtgDAGLfC
	 GdFjC6m9tdw/t2STwogh9W9QR+5hq84UuYwCgQ1vfs4WxHuUe5hfN6STzhqhGb1OFb
	 TYRyz16RQ5buQbFEuba0FsGKPanpGD5jYsutLbw3f5LKGiEAUAjVu3VJqbH6PIdB25
	 +a7/RHLTsvMwQ==
Date: Fri, 5 Jun 2026 19:15:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <aiMNT7fBUkZS1EJK@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-7-npache@redhat.com>
 <95390529-3a80-473c-9433-958db7a2dc6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95390529-3a80-473c-9433-958db7a2dc6c@kernel.org>

On Fri, Jun 05, 2026 at 07:48:17PM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 18:14, Nico Pache wrote:
> > Pass an order to collapse_huge_page to support collapsing anon memory to
> > arbitrary orders within a PMD. order indicates what mTHP size we are
> > attempting to collapse to.
> >
> > For non-PMD collapse we must leave the anon VMA write locked until after
> > we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> > the mTHP case this is not true, and we must keep the lock to prevent
> > access/changes to the page tables. This can happen if the rmap walkers hit
> > a pmd_none while the PMD entry is currently unavailable due to being
> > temporarily removed during the collapse phase.
> >
> > To properly establish the page table hierarchy without violating any
> > expectations from certain architectures (e.g. MIPS), we must make sure to
> > have the PMD reinstalled before the PTEs, and hold both PTE/PMD locks
> > before calling update_mmu_cache_range() (if they are distinct locks).
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
>
> [...]
>
> >  	 */
> >  	__folio_mark_uptodate(folio);
> > -	pgtable = pmd_pgtable(_pmd);
> > -
> >  	spin_lock(pmd_ptl);
> > -	BUG_ON(!pmd_none(*pmd));
> > -	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -	map_anon_folio_pmd_nopf(folio, pmd, vma, address);
> > +	VM_WARN_ON_ONCE(!pmd_none(*pmd));
> > +	if (is_pmd_order(order)) {
> > +		pgtable = pmd_pgtable(_pmd);
> > +		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
> > +	} else {
> > +		/*
> > +		 * Some architectures (e.g. MIPS) walk the live page table in
> > +		 * their implementation. update_mmu_cache_range() must be called
> > +		 * with a valid page table hierarchy and the PTE lock held.
> > +		 * Acquire it nested inside pmd_ptl when they are distinct locks.
> > +		 */
> > +		if (pte_ptl != pmd_ptl)
> > +			spin_lock_nested(pte_ptl, SINGLE_DEPTH_NESTING);
> > +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +		map_anon_folio_pte_nopf(folio, pte, vma, start_addr,
> > +					  /*uffd_wp=*/ false);
> > +		if (pte_ptl != pmd_ptl)
> > +			spin_unlock(pte_ptl);
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
>
> We re-enable some page table walkers before we unmap the PTE.
>
> We still hold the mmap lock in write mode, so nothing would currently try
> reclaiming the page table concurrently.

Reclaim uses rmap walkers though?

Oh you mean as in page table teardown, we're safe from higher level page table
teardown, but we're not safe from zap PTE page table teardown, as
CONFIG_PT_RECLAIM makes this possible on zap now.

That is RCU safe, so the unmap would keep us safe here, but now we could lose
the PTE page table.

But, only MADV_DONTNEED sets reclaim_pt = true, and that holds the VMA read lock
so we're safe.

And anyway:

MADV_DONTNEED - VMA read lock (we hold VMA write lock)
zap_vma_for_reaping() - mmap read lock
process teardown, munmap - mmap read lock
fault - vma/mmap read lock

So the vma/mmap locks save us from those.

So rmap-wise, only the i_mmap walkers remain (truncate, hole punch, et al. and
also hugetlbfs truncate/hole-punch which does its own nonsense too), but none of
those allow for reclaim_pt to happen in any case.

So yeah we're safe but we should what, reorder these 2 statements?

But yes I agree that can be a follow-up, nothing's broken AFAICT.

>
> So I guess this works right now, but we should likely rework that code later to
> either revert both statements. Or maybe we can simply unmap like we did, and
> simply remap before we call map_anon_folio_pte_nopf()? Remapping should not fail.
>
> Alternatively to an unmap+remap, I think we could also unmap earlier for PMD
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6de935e76ceb..ba2a2508dda6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1378,6 +1378,8 @@ static enum scan_result collapse_huge_page(struct
> mm_struct *mm, unsigned long s
>         if (is_pmd_order(order)) {
>                 anon_vma_unlock_write(vma->anon_vma);
>                 anon_vma_locked = false;
> +               pte_unmap(pte);
> +               pte = NULL;
>         }
>
>         result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>
> But this can also be handled later.

Yup I mean it'd be nicer to do it in one place if we can (+ impact of holding
RCU lock longer not an issue), but all this code needs rewokr anyway.

>
> We now hold an anon_vma lock a bit longer for !pmd-collapse. But there is also
> less to copy. If that bites us, we can try optimizing later.

Yeah I do worry about holding these locks longer. But we'll see.

>
>
> So after another skim, I think this patch is ready for primetime. We can address
> the things mentioned above later ... and any fallout can be fixed later, if any.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Yes, also from my side - after a git range-diff and looking into above, LGTM,
so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Now to go look at the core algo patch :)

>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo
