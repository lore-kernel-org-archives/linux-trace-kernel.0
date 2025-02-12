Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58D2586F3;
	Wed, 12 Feb 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379889; cv=none; b=d5m4SndL5UvnxvPey4j0pwgshy0pLtYsEvTOe5ph7VGBng1ovlLTnHz16xpJfS2asACnRGZhHEhXS8HuYIabhSO0O2/ai1DknELJAQEKz4S7DyyvBotMuYivZJbNxEH00/llVg5BmEd1tI7lqwg9hProHww49EUAPgzT0jcfIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379889; c=relaxed/simple;
	bh=jMfdTRsZdI5eWoj3aWSlH0xyFaWuq8yWsFhqFzD+kCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsKxjLsJ8r83jErh9ONJKloXu0V4tJANT5cr3ZKC5XhsiPsIN3PGQ7IcTdiihz6R9DXWe5KnmeARK4ynBMwiCY1RGhuisRRUZ1sOPqtKci/k/qdu1JdJMMVJBfsLYEjR/hFdbXW12FaOlodf47TFmi/38lOBIrBX6iMHOttOctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPELDo8X; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPELDo8X"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1342379066b.3;
        Wed, 12 Feb 2025 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739379885; x=1739984685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fvzxk7wvgu91bGu3wJDWmHVE0pCbZmsOLUpuRRBS1Oo=;
        b=IPELDo8XCybDA94V3dqMxxlUG5PogtTcAxE5A23UUKckRH51ZAerPO7T2L7GDb/hBk
         V7RNyAcgC/FU8STPfPOTieyDEsuja9yQH/Ds23dO9YbcaSDyhAd8sVoXz/0hxSkymwkq
         RUKEzOHexDUqiLye4f1J0utFHAfpD5rt0eXKlUTCBLfefBhyxL25IArE+QUBfx/jZOAQ
         Cytu+yku9rkS3os25seC78MjTRlYJRbFNMxtE4r+q4QbDGXGENOcU2oy8UKh/t/mDchj
         C4zB3j0qii8q/ApruEXptJHKSceVZY1z4z1nJoC9LZeUiALE3WBAF3fbH4M0NMVdYOJO
         eYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379885; x=1739984685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvzxk7wvgu91bGu3wJDWmHVE0pCbZmsOLUpuRRBS1Oo=;
        b=bHPHd1OHwCguyTmjIigYhDt3r94l7nqUlRDWWLHNrPHz96RwirG8PdXL/Fw1H+JtW1
         Wj6KP7BdiL5K7/+KHPtqAypVuHql96fX0siHla5PttKeBmZqWNJZu/hH68il6HE7tqen
         4ELwwmv6gPJwcRAH3Yvmtti7tIaBypmLsg1b3O5s7BTXw2/fP9gpM0FpjOY9iHo5/HJ6
         mMjWIkjLTMNPHJz8t6+1NIuNB45c5SPiHHIO7eyf5B5VKRDBVML98wgvaeS+CTB8fmzd
         6q39dZDYqMWQjXO/FRF0j0/lUCqULP++5QQs/4kv0CHTardTezE/waDtkN8hwNX+JeXv
         WO4A==
X-Forwarded-Encrypted: i=1; AJvYcCWsAmbEId9UKqByC+SnAHHZ/Tcy8YYONyieoTy/c2Xyeyk0BASSpc7lhA1u3kPUW4IzcLPOwJZ7JapzQiM=@vger.kernel.org, AJvYcCXcsMrciMfzKEAe/2cpa6NntZLEuEzaBv7etVqYHB6OErhA0BI/3Y8FXXG5LNECTlZAnECkO4/mZ1511KLK1+mtsWWo@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbPv4jJYlKZXh/JFcBct9yLX41THjXW1cuJPFdq9D30dTaMlC
	Fjl8jxW+8hL1uc1wLDNwPf4+8FmH22CnOrhZaYos2WqstDlvCWlx
X-Gm-Gg: ASbGncu/+TP0F7TW+l7OvCmLll6XDWWngXPIAOtPeE+FOX+7A6P1+bTAt9dnm4J1EKo
	3HZo9k9Bp7FL5Jflv9+jiSL1dmcgP/7IfD7HbgmeqkMQBf6pCMV8SXuWYce6RFGMVTAuWEPnvu8
	yxkMGRnIhaOO8RPrlCmPISHDEt27zwuZLsreXOmIa0VVf+KexCbb78u3aT18mkFhRBqSa9X0UQJ
	vqiS1rsm0alRAlUo55GvmbMhMJm2h6Tq+J7QyrMU69lgdi9J3j6ANYsLVTLkM0yBk6atBVQq3zC
	8oORm9QL/Ll5MvQc8geXpaBctVpVIbFno16sSb3mN4kiGDxPSePHMKRrZr2fHQ==
X-Google-Smtp-Source: AGHT+IG7q/wYJM73PiW8r3OsiQSf89b8XBujhBqSp6Ld1tSLhvrTp1ylssyeX8E7sgzOgoQUiPkV8Q==
X-Received: by 2002:a17:907:d17:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-ab7f34d3323mr317980366b.48.1739379884809;
        Wed, 12 Feb 2025 09:04:44 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::6:8e63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78e3e212dsm1136599566b.147.2025.02.12.09.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:04:44 -0800 (PST)
Message-ID: <9ade1f26-1642-48b3-b7e4-ba571892c7d6@gmail.com>
Date: Wed, 12 Feb 2025 17:04:43 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/9] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-8-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211003028.213461-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:30, Nico Pache wrote:
> Introduce the ability for khugepaged to collapse to different mTHP sizes.
> While scanning a PMD range for potential collapse candidates, keep track
> of pages in MIN_MTHP_ORDER chunks via a bitmap. Each bit represents a
> utilized region of order MIN_MTHP_ORDER ptes. We remove the restriction
> of max_ptes_none during the scan phase so we dont bailout early and miss
> potential mTHP candidates.
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
>  mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 83 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c8048d9ec7fb..cd310989725b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1127,13 +1127,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  {
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> -	pte_t *pte;
> +	pte_t *pte, mthp_pte;
>  	pgtable_t pgtable;
>  	struct folio *folio;
>  	spinlock_t *pmd_ptl, *pte_ptl;
>  	int result = SCAN_FAIL;
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
> +	unsigned long _address = address + offset * PAGE_SIZE;
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
>  	/*
> @@ -1148,12 +1149,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
> @@ -1171,13 +1173,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
> @@ -1187,7 +1190,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>  	/* check if the pmd is still valid */
> @@ -1198,11 +1201,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	vma_start_write(vma);
>  	anon_vma_lock_write(vma->anon_vma);
>  
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> -				address + HPAGE_PMD_SIZE);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
> +				_address + (PAGE_SIZE << order));
>  	mmu_notifier_invalidate_range_start(&range);
>  
>  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> +
>  	/*
>  	 * This removes any huge TLB entry from the CPU so we won't allow
>  	 * huge and small TLB entries for the same virtual address to
> @@ -1216,10 +1220,10 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
> @@ -1248,8 +1252,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	anon_vma_unlock_write(vma->anon_vma);
>  
>  	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> -					   vma, address, pte_ptl,
> -					   &compound_pagelist, HPAGE_PMD_ORDER);
> +					   vma, _address, pte_ptl,
> +					   &compound_pagelist, order);
>  	pte_unmap(pte);
>  	if (unlikely(result != SCAN_SUCCEED))
>  		goto out_up_write;
> @@ -1260,20 +1264,37 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * write.
>  	 */
>  	__folio_mark_uptodate(folio);
> -	pgtable = pmd_pgtable(_pmd);
> -
> -	_pmd = mk_huge_pmd(&folio->page, vma->vm_page_prot);
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
> +		_pmd = mk_huge_pmd(&folio->page, vma->vm_page_prot);
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
> +		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
> +		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> +
> +		spin_lock(pmd_ptl);
> +		folio_ref_add(folio, (1 << order) - 1);
> +		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
> +		folio_add_lru_vma(folio, vma);
> +		spin_lock(pte_ptl);
> +		set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order));
> +		update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
> +		spin_unlock(pte_ptl);
> +		smp_wmb(); /* make pte visible before pmd */
> +		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> +		deferred_split_folio(folio, false);


Hi Nico,

This patch will have the same issue as the one I pointed out in
https://lore.kernel.org/all/82b9efd1-f2a6-4452-b2ea-6c163e17cdf7@gmail.com/ ?

