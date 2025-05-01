Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBF14658D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 May 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746104341; cv=none; b=Uau3+UMYs8rPA9M/eu4awOvy6a5JkXb7grZEQIs4uuDVAWhr0jTfonFZ2mLOa2+0Hf0/Qjm3xr9pzj/OBihl8eYxwW+mu3Zwn2ibylmiW+pJr8Vy3PB88KDBP+4ckn9RAar37VOerUw8uT7kvOSsZMO/sdzG7KBfkKFGZ2/6kLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746104341; c=relaxed/simple;
	bh=yojtMk73UAVacnXOBfIf6QZHxSFcwnWKdXRW5oojDl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SMD1WvGrYvf48owD0h/KQ8nSheCg9MZAoTakAnzNBdgv0ekRWPT05YiPmAzYkpzkK5zQP5hbDCqpcFQB/fBcGSRl3wRiBupaLtGHxwRgo22ZhNn9f8Tr0j+OqR4/sKa5ZHgEaMzvOlixPLl5SVnxN7+e3zaWkJksPo/chcsGZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FN9hMIDC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN9hMIDC"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b07d607dc83so679751a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 May 2025 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746104338; x=1746709138; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/uwiPmd6nJFkUmn7dXA5yxU25PIcIi6hqiJ9YDm23c=;
        b=FN9hMIDCF/xiluBGVckW0AyiAq8HRby9VLxf2c/8M0RHvNtGl+97nr9cgl4NZfrQ/7
         1AQYP13r7yrtqCUaG0i0WJ6AazpXnNWPtssr6mfPjmPzQMssqmUUo7pDT5C7nNQCIV2F
         7J1tDZlC3hrBUgOnA05NbcMFojXaDHvrYg7RXRH/MxMJKzyfd9tjEq7ag/4OCS3DYdJm
         OXHPf+ZYqo/7rBS4UGHtcAsld0pRbndwIlCBRAK+NuPL1wmmu1UHkTESMXPthuxPL7Sp
         ICgQn9o+YdtlbRzNtO9GqTAYHUoWBk6SDK9yAchdbL/CBMmmUwmV7HZDkA5ILPK8dFTW
         zy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746104338; x=1746709138;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/uwiPmd6nJFkUmn7dXA5yxU25PIcIi6hqiJ9YDm23c=;
        b=U/xrCK4Opd6MIP3uzNgiJ+bqvB4RWbJ7UEfMEhSBuWXeaIHNCTfR54L7CqHUOk5gfY
         W2koDwmrsll24MLFgIL3ESUIOsJ5Y5TVYC3DgIoqj61bP+3Yp0f3ngUrPGyBU4ZSnlhe
         E+KuxZ3QpsDOKehPzNcauz3qmdjUlc2PhlO6sizMWThUql4L2PSCV/Bcu5kmElRAggaL
         m1dMUepEkEPWG8ORaleqbEvNqlpqEbmmvxpfDaXV7p8cH9XM6P3i3NNavD79kHiYDgRX
         4xHGcqXg+h80NeQurR8cloujVyLc+LNoCYa9OSTgMHD2gnJJpXEMuMrGciiXrqkPF9i2
         FZGA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+WTzGdtS/TjcNdIwtLSLJFF3ttsfHfcsodm6TVtKY4FvqTLpVlbRZDUVueQKuHsjmVtnIbS43+w+LGkxZxbBe0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVRCcHTHGAzvl2eX42u4rISVAKrTHMamR/KbZVwAt/JvncwP5
	BjWi4Mrl4xdNU/A8zgE+C34hQkN7bNk66b7jyzXXhE6fNKm0qtgAIIXxiW/Y1w==
X-Gm-Gg: ASbGnct46oCzVQNSkn1ckFytx8Pbb28+5TdAtjRY71sWyABHAPh/ThICcOMOuKyCCic
	8px9neOqIuZAqVTpWnJua2/EX486jBCRWQdeKGgZE1AaBWSsS2GkyUmwA+hJWLd4KNb/bLQ3HRg
	R0vHzgq85FoNhOZ22tuoFluZhcePSWV3amXdjL8fzAqHKl6LPNqPAMC58iko+kEP/IApw/j4XLD
	kQzlZLuwSaynimSb32A+cwbOM7qVQ76DpeKNwjmypmUdY2GyMZVBspal/p0WYtvgb5y+9GkRw7s
	R9rlQz2e70uD2DVAoL3MLWnuI/A+/wAmbrJOfb7kUWJie3oVjWrqA93GTMXBem0Wo5eh8EyVTZS
	dzo0cI+PMb2CL18GFId4khjs7
X-Google-Smtp-Source: AGHT+IHolu2831cgzGp4QIYeiALbqm9JdAyjLEQou6v04sT8hgrIFJ/qJ3PbvfoP8Uql2b+1GkV1UA==
X-Received: by 2002:a17:90b:5610:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-30a41cfc332mr4553771a91.2.1746104337929;
        Thu, 01 May 2025 05:58:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4748e852sm769002a91.23.2025.05.01.05.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 05:58:56 -0700 (PDT)
Date: Thu, 1 May 2025 05:58:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Nico Pache <npache@redhat.com>
cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
    baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
    willy@infradead.org, peterx@redhat.com, ziy@nvidia.com, 
    wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
    vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
    yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
    aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
    will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
    jglisse@google.com, surenb@google.com, zokeefe@google.com, 
    hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
    rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
    Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
In-Reply-To: <20250428181218.85925-8-npache@redhat.com>
Message-ID: <7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com>
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Apr 2025, Nico Pache wrote:

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

There are locking errors in this patch.  Let me comment inline below,
then at the end append the fix patch I'm using, to keep mm-new usable
for me. But that's more of an emergency rescue than a recommended fixup:
I don't much like your approach here, and hope it will change in v6.

> ---
>  mm/khugepaged.c | 125 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 88 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6e67db86409a..3a846cd70c66 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1136,13 +1136,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  {
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> -	pte_t *pte;
> +	pte_t *pte, mthp_pte;

I didn't wait to see the problem, just noticed that in the v4->v5
update, pte gets used at out_up_write, but there are gotos before
pte has been initialized. Declare pte = NULL here.

>  	pgtable_t pgtable;
>  	struct folio *folio;
>  	spinlock_t *pmd_ptl, *pte_ptl;
>  	int result = SCAN_FAIL;
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
> +	unsigned long _address = address + offset * PAGE_SIZE;
>  
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
> @@ -1158,12 +1159,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		*mmap_locked = false;
>  	}
>  
> -	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> +	result = alloc_charge_folio(&folio, mm, cc, order);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>  
>  	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
> +	*mmap_locked = true;
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>  	if (result != SCAN_SUCCEED) {
>  		mmap_read_unlock(mm);
>  		goto out_nolock;
> @@ -1181,13 +1183,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		 * released when it fails. So we jump out_nolock directly in
>  		 * that case.  Continuing to collapse causes inconsistency.
>  		 */
> -		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -				referenced, HPAGE_PMD_ORDER);
> +		result = __collapse_huge_page_swapin(mm, vma, _address, pmd,
> +				referenced, order);
>  		if (result != SCAN_SUCCEED)
>  			goto out_nolock;
>  	}
>  
>  	mmap_read_unlock(mm);
> +	*mmap_locked = false;
>  	/*
>  	 * Prevent all access to pagetables with the exception of
>  	 * gup_fast later handled by the ptep_clear_flush and the VM
> @@ -1197,7 +1200,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>  	/* check if the pmd is still valid */
> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,

I spent a long time trying to work out why the include/linux/swapops.h:511
BUG is soon hit - the BUG which tells there's a migration entry left behind
after its folio has been unlocked.

In the patch at the end you'll see that I've inserted a check here, to
abort if the VMA following the revalidated "vma" is sharing the page table
(and so also affected by clearing *pmd).  That turned out not to be the
problem (WARN_ONs inserted never fired in my limited testing), but it still
looks to me as if some such check is needed.  Or I may be wrong, and
"revalidate" (a better place for the check) does actually check that, but
it wasn't obvious, and I haven't spent more time looking at it (but it did
appear to rule out the case of a VMA before "vma" sharing the page table).

>  	vma_start_write(vma);
>  	anon_vma_lock_write(vma->anon_vma);
>  
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> -				address + HPAGE_PMD_SIZE);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
> +				_address + (PAGE_SIZE << order));

mmu_notifiers tend to be rather a mystery to me, so I've made no change
below, but it's not obvious whether it's correct clear the *pmd but only
notify of clearing a subset of that range: what's outside the range soon
gets replaced as it was, but is that good enough?  I don't know.

>  	mmu_notifier_invalidate_range_start(&range);
>  
>  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> +
>  	/*
>  	 * This removes any huge TLB entry from the CPU so we won't allow
>  	 * huge and small TLB entries for the same virtual address to

The line I want to comment on does not appear in this diff context:
	_pmd = pmdp_collapse_flush(vma, address, pmd);

That is appropriate for a THP occupying the whole range of the page table,
but is a surprising way to handle an "mTHP" of just some of its ptes:
I would expect you to be invalidating and replacing just those.

And that is the cause of the swapops:511 BUGs: "uninvolved" ptes are
being temporarily hidden, so not found when remove_migration_ptes()
goes looking for them.

This reliance on pmdp_collapse_flush() can be rescued, with stricter
locking (comment below); but I don't like it, and notice Jann has
picked up on it too.  I hope v6 switches to handling ptes by ptes.

> @@ -1226,18 +1230,16 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_remove_table_sync_one();
>  
> -	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> +	pte = pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
>  	if (pte) {
> -		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -					&compound_pagelist, HPAGE_PMD_ORDER);
> +		result = __collapse_huge_page_isolate(vma, _address, pte, cc,
> +					&compound_pagelist, order);
>  		spin_unlock(pte_ptl);
>  	} else {
>  		result = SCAN_PMD_NULL;
>  	}
>  
>  	if (unlikely(result != SCAN_SUCCEED)) {
> -		if (pte)
> -			pte_unmap(pte);
>  		spin_lock(pmd_ptl);
>  		BUG_ON(!pmd_none(*pmd));
>  		/*
> @@ -1258,9 +1260,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	anon_vma_unlock_write(vma->anon_vma);

Phew, it's just visible there in the context.  The anon_vma lock is what
keeps out racing lookups; so, that anon_vma_unlock_write() (and its
"All pages are isolated and locked" comment) is appropriate in the
HPAGE_PMD_SIZEd THP case, but has to be left until later for mTHP ptes.

But the anon_vma lock may well span a much larger range than the pte
lock, and the pmd lock certainly spans a much larger range than the
pte lock; so we really prefer to release anon_vma lock and pmd lock
as soon as is safe, and use pte lock in preference where possible.

>  
>  	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> -					   vma, address, pte_ptl,
> -					   &compound_pagelist, HPAGE_PMD_ORDER);
> -	pte_unmap(pte);
> +					   vma, _address, pte_ptl,
> +					   &compound_pagelist, order);
>  	if (unlikely(result != SCAN_SUCCEED))
>  		goto out_up_write;
>  
> @@ -1270,25 +1271,42 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * write.
>  	 */
>  	__folio_mark_uptodate(folio);
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
> +	} else { /* mTHP collapse */
> +		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
> +		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> +
> +		spin_lock(pmd_ptl);

I haven't changed that, but it is odd: yes, pmd_ptl will be required
when doing the pmd_populate(), but it serves no purpose here when
fiddling around with ptes in a disconnected page table.

> +		folio_ref_add(folio, (1 << order) - 1);
> +		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
> +		folio_add_lru_vma(folio, vma);
> +		set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order));
> +		update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
> +
> +		smp_wmb(); /* make pte visible before pmd */
> +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> +		spin_unlock(pmd_ptl);
> +	}
>  
>  	folio = NULL;
>  
>  	result = SCAN_SUCCEED;

Somewhere around here it becomes safe for mTHP to anon_vma_unlock_write().

>  out_up_write:
> +	if (pte)
> +		pte_unmap(pte);
>  	mmap_write_unlock(mm);
>  out_nolock:
>  	*mmap_locked = false;
> @@ -1364,31 +1382,58 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  {
>  	pmd_t *pmd;
>  	pte_t *pte, *_pte;
> +	int i;
>  	int result = SCAN_FAIL, referenced = 0;
>  	int none_or_zero = 0, shared = 0;
>  	struct page *page = NULL;
>  	struct folio *folio = NULL;
>  	unsigned long _address;
> +	unsigned long enabled_orders;
>  	spinlock_t *ptl;
>  	int node = NUMA_NO_NODE, unmapped = 0;
> +	bool is_pmd_only;
>  	bool writable = false;
> -
> +	int chunk_none_count = 0;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
> +	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
>  	result = find_pmd_or_thp_or_none(mm, address, &pmd);
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  
> +	bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
>  	memset(cc->node_load, 0, sizeof(cc->node_load));
>  	nodes_clear(cc->alloc_nmask);
> +
> +	enabled_orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> +		tva_flags, THP_ORDERS_ALL_ANON);
> +
> +	is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
>  	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
>  	if (!pte) {
>  		result = SCAN_PMD_NULL;
>  		goto out;
>  	}
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
>  		pte_t pteval = ptep_get(_pte);
>  		if (is_swap_pte(pteval)) {
>  			++unmapped;
> @@ -1411,10 +1456,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  			}
>  		}
>  		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +			++chunk_none_count;
>  			++none_or_zero;
>  			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			    (!cc->is_khugepaged || !is_pmd_only ||
> +				none_or_zero <= khugepaged_max_ptes_none)) {
>  				continue;
>  			} else {
>  				result = SCAN_EXCEED_NONE_PTE;
> @@ -1510,6 +1556,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  								     address)))
>  			referenced++;
>  	}
> +
>  	if (!writable) {
>  		result = SCAN_PAGE_RO;
>  	} else if (cc->is_khugepaged &&
> @@ -1522,8 +1569,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  out_unmap:
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
> -		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
> +		result = khugepaged_scan_bitmap(mm, address, referenced, unmapped, cc,
> +			       mmap_locked, enabled_orders);
> +		if (result > 0)
> +			result = SCAN_SUCCEED;
> +		else
> +			result = SCAN_FAIL;
>  	}
>  out:
>  	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
> -- 
> 2.48.1

Fixes to 07/12 "khugepaged: add mTHP support".
But I see now that the first hunk is actually not to this 07/12, but to
05/12 "khugepaged: generalize __collapse_huge_page_* for mTHP support":
the mTHP check added in __collapse_huge_page_swapin() forgets to unmap
and unlock before returning, causing RCU imbalance warnings and lockups.
I won't separate it out here, let me leave that to you.

And I had other fixes to v4, which you've fixed differently in v5,
I haven't looked up which patch: where khugepaged_collapse_single_pmd()
does mmap_read_(un)lock() around collapse_pte_mapped_thp().  I dislike
your special use of result SCAN_ANY_PROCESS there, because mmap_locked
is precisely the tool for that job, so just lock and unlock without
setting *mmap_locked true (but I'd agree that mmap_locked is confusing,
and offhand wouldn't want to assert exactly what it means - does it
mean that mmap lock was *never* dropped, so "vma" is safe without
revalidation? depends on where it's used perhaps).

Hugh

---
 mm/khugepaged.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c1c637dbcb81..2c814c239d65 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1054,6 +1054,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 
 		/* Dont swapin for mTHP collapse */
 		if (order != HPAGE_PMD_ORDER) {
+			pte_unmap(pte);
+			mmap_read_unlock(mm);
 			result = SCAN_EXCEED_SWAP_PTE;
 			goto out;
 		}
@@ -1136,7 +1138,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 {
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
-	pte_t *pte, mthp_pte;
+	pte_t *pte = NULL, mthp_pte;
 	pgtable_t pgtable;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
@@ -1208,6 +1210,21 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	if (vma->vm_end < address + HPAGE_PMD_SIZE) {
+		struct vm_area_struct *next_vma = find_vma(mm, vma->vm_end);
+		/*
+		 * We must not clear *pmd if it is used by the following VMA.
+		 * Well, perhaps we could if it, and all following VMAs using
+		 * this same page table, share the same anon_vma, and so are
+		 * locked out together: but keep it simple for now (and this
+		 * code might better belong in hugepage_vma_revalidate()).
+		 */
+		if (next_vma && next_vma->vm_start < address + HPAGE_PMD_SIZE) {
+			result = SCAN_ADDRESS_RANGE;
+			goto out_up_write;
+		}
+	}
+
 	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
@@ -1255,15 +1272,17 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	/*
 	 * All pages are isolated and locked so anon_vma rmap
-	 * can't run anymore.
-	 */
-	anon_vma_unlock_write(vma->anon_vma);
+	 * can't run anymore - IF the entire extent has been isolated.
+	 * anon_vma lock may cover a large area: better unlock a.s.a.p.
+	 */	
+	if (order == HPAGE_PMD_ORDER)
+		anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, _address, pte_ptl,
 					   &compound_pagelist, order);
 	if (unlikely(result != SCAN_SUCCEED))
-		goto out_up_write;
+		goto out_unlock_anon_vma;
 
 	/*
 	 * The smp_wmb() inside __folio_mark_uptodate() ensures the
@@ -1304,6 +1323,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	folio = NULL;
 
 	result = SCAN_SUCCEED;
+out_unlock_anon_vma:
+	if (order != HPAGE_PMD_ORDER)
+		anon_vma_unlock_write(vma->anon_vma);
 out_up_write:
 	if (pte)
 		pte_unmap(pte);
-- 
2.43.0
