Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7535E1B5;
	Thu,  4 Jun 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576451; cv=none; b=M0Eq73faoy8l/jxl6F8HW9codoqeXEISKW5j8lUAJBasZN6+IiNegLGk/iVQsFA137FPiAV8bsaLhXzc8MOx+zNEJjNgZroxSf6VQbMMruGP158JhTXXcxIpUDa8VbrCG45ECq/+PpCN8tjI4Z+MCoZ2vPwc6At9A8c8kC5YKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576451; c=relaxed/simple;
	bh=gdedar459vsMSFxl9/kWW91qvvU9Z+FRDiQswxnd6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNJ9otkifmIj/muQwrZ82buZ/ojfkBpU9F9Y39wgRdDeaGiIKFeg5+SBTN7vIWlTnqq8YLaxoCoIctdCbn73mHGcJcWR53o55eyOylD++buH8buji4MQHcYpHr0JHcGrERzui7WjzMLiEglvEqmgl6nMvIPPDqXue/mfseo/y3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmbeSmfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmbeSmfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF3B1F00893;
	Thu,  4 Jun 2026 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576450;
	bh=nF1iBW3FnQDK77z6Z/erssj/aJgmx1yuGL+yjDuzS7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FmbeSmfP3EK9rBz/hN1P235JwHBuwKRZqChSyPgRQ0akT4zcsHmAOwY8SpA8L/0D0
	 HApsu4hM0YRqD/0/ychCxMQqWguRZdqvZ/uUPIYcdS7cXhn/mN8Ky9ChjKbGkO7J3x
	 1THCiOccp+vQWU94FMtFxgj8o47NEOki/Okk4TzYLtdp0L4lkNQpoMgQrqwmh2a7el
	 sJQPHqQHuyX1tZ8Jy89q3GawXcKUhAJICfbN7f+dTaRca2xtZKd96SQeoeWxu4aJO/
	 oRVa6qNGwkhpV4gK5Fzqkt3zPzqKzqFNFGTejf6zO2tMnDmGTchjiWSFZuMC/KLKFp
	 6menozUfpMnoQ==
Date: Thu, 4 Jun 2026 13:33:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, npache@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	usama.arif@linux.dev
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <aiFlNd9vr_NJi3Ah@lucifer>
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev>
 <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>

On Mon, Jun 01, 2026 at 08:54:24AM +0200, David Hildenbrand (Arm) wrote:
> On 6/1/26 05:28, Lance Yang wrote:
> >
> > On Sun, May 31, 2026 at 10:00:17PM +0200, David Hildenbrand (Arm) wrote:
> >> On 5/31/26 11:39, Lance Yang wrote:
> >>>
> >>>
> >>> Emm ... is it safe to use map_anon_folio_pte_nopf() here?
> >>>
> >>> At this point pmdp_collapse_flush() has cleared the PMD from the page
> >>> tables. The PTE table we are updating is only reachable through the saved
> >>> old PMD value, _pmd, until pmd_populate() below.
> >>>
> >>> map_anon_folio_pte_nopf() does set_ptes() and then calls
> >>> update_mmu_cache_range(). Documentation/core-api/cachetlb.rst describes
> >>> that hook as:
> >>>
> >>> "
> >>> 	At the end of every page fault, this routine is invoked to tell
> >>> 	the architecture specific code that translations now exists
> >>> 	in the software page tables for address space "vma->vm_mm"
> >>> 	at virtual address "address" for "nr" consecutive pages.
> >>> "
> >>>
> >>> But that does not seem true here yet, since the PTE table is not
> >>> reachable from vma->vm_mm when update_mmu_cache_range() is called.
> >>>
> >>> Should we avoid calling update_mmu_cache_range() until after the PTE
> >>> table is reinstalled with pmd_populate()?
> >>
> >> I recall that update_mmu_cache* users mostly care about updating folios flags,
> >> for the folio derived from the PTE ... or flushing caches for the user address.
> >>
> >> So intuitively I would say "the architecture code doesn't care that the PMD
> >> table will only be visible to HW shortly after". The important thing should be
> >> that it will definetly happen, and that nothing else is curently there or can be
> >> there?
> >
> > Ah, fair point.
> >
> > I was mostly worried about arch hooks that walk vma->vm_mm again, rather
> > than only using the pte pointer passed in. For example, mips does:
>
> Right, a re-walk would be the real problem.
>
> >
> >   update_mmu_cache_range()
> >     -> __update_tlb()
> >       -> pgd_offset(vma->vm_mm, address)
> >       -> pte_offset_map(...)
> >
> > and __update_tlb() has this assumption:
> >
> > 		/*
> > 		 * update_mmu_cache() is called between pte_offset_map_lock()
> > 		 * and pte_unmap_unlock(), so we can assume that ptep is not
> > 		 * NULL here: and what should be done below if it were NULL?
> > 		 */
> >
> > So if khugepaged happens to run with current->active_mm == vma->vm_mm
> > here, could __update_tlb() hit the none PMD, get NULL from

I really wish people would say Pxx _entry_ :) so confusing.

> > pte_offset_map(), and then dereference it?
>
> Likely yes -- that MIPS code is horrible. And the comment in MIPS code
> even spells that out. :(
>
> Do you know about other code like that, or is MIPS the only one doing a
> re-walk and crossing fingers?
>
> >
> > Just wanted to raise it since some arch code may still have assumptions
> > like this, and the always-enable-mTHP work is getting closer ...
>
> Right. I assume set_pte_at() couldn't trigger something similar (re-walk) in arch code,
> because we simply provide the ptep. update_mmu_cache_range() only consumes the pte.
>
> >
> > Probably very very very hard to hit, though :)
>
> Delaying update_mmu_cache_range() is nasty, as we'd have to make sure that
> nobody can interfere in the meantime ... and the PMD lock will not be sufficient.
>
> Maybe we could reinstall the page table with the cleared (none) entries while
> still holding the PTL?

You mean the cleared PTE entries that are to be updated with the collapsed
larger folio?

>
> Thinking out loud:

After staring at this long enough, this does seems like a viable solution yes.

I hate how subtle this is.

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5ba298d420b7..e39b750b1e6f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1413,13 +1413,17 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>                 map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>         } else {
>                 /*
> -                * set_ptes is called in map_anon_folio_pte_nopf with the
> -                * pmd_ptl lock still held; this is safe as the PMD is expected
> -                * to be none. The pmd entry is then repopulated below.
> +                * Re-insert the page table with the cleared entries, but
> +                * hold the PTL, such that no one can mess with the re-installed
> +                * page table until we updated the temporarily-cleared entries
> +                * through map_anon_folio_pte_nopf().
>                  */

You may say nit, but, I think we should be clearly stating the problem here. Yes
we want to hold the PTL to stop anybody else messing with it yet, but we're
really doing this because of:

map_anon_folio_pte_nopf
-> update_mmu_cache_range
-> rewalk
-> try to look up an entry that's not yet actually installed
-> bang

Right?

So maybe something like:

	Re-insert the PMD entry pointing to the PTE page table with cleared
	entries first, because map_anon_folio_pte_nopf() invokes
	update_mmu_cache_range() which may cause a rewalk of the page tables and
	blow up if the supplied PTE entry belongs to a PTE table that is not yet
	present there.

	We hold the PTE PTL to avoid anything else messing with this until we're
	ready.


> -               map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
> -               smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */

(I guess better to comment on the smp_wmb() stuff in the other message about
this.)

> +               if (pte_ptl != pmd_ptl)
> +                       spin_lock(pte_ptl);

(Obviously should be spin_lock_nested() as David says later)

It seems a bit weird to me that we acquire the PTE lock:

	pte = pte_offset_map_lock(mm, &_pmd, start_addr, &pte_ptl);

Clear out the mTHP entries we're going to remove:

	if (pte) {
		result = __collapse_huge_page_isolate(vma, start_addr, pte, cc,
						      order, &compound_pagelist);

THen unlock the PTE:

		spin_unlock(pte_ptl);

Before again reacquiring here, especially given this is an unreachable PTE
table.

But then again not doing that would require us to add some error handling logic
to unlock again so it's probably not vital.

>                 pmd_populate(mm, pmd, pmd_pgtable(_pmd));

So we're protecting against concurrent rmap and fault handlers with the PTL such
that installing this is safe right?

Are we good against GUP fast? I guess a race will be fine with that, or will it?
I suppose before it would have skipped the range entirely because of the missing
PMD entry anyway.

(in any case we also hold anon_vma write lock too.)

> +               map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
> +               if (pte_ptl != pmd_ptl)
> +                       spin_unlock(pte_ptl);
>         }
>         spin_unlock(pmd_ptl);
>
>
>
> --
> Cheers,
>
> David

Thanks, Lorenzo
