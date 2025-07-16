Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589F14A09C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673984; cv=none; b=TT9FtgCB+I2lNV1H38zDp67nUzuqjuK+eEnIGfr8kRNKfTH7tGvtMTY4Oo4YRgeczYH4xtWxUx+W1xMq5osOdUAXRffoEs8N5erSUlKbq/KjeGpmjSvnCWp0X502YG33sAOMt/Ms+1HI0LgWYO0gsy/Nh65RFY01drlQiupl2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673984; c=relaxed/simple;
	bh=gM8lG1lrQSIkN7oDX6dKz6O5t1S9r2+P/y8yQPDL5ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIn4utf5Vmfx2NO7Z/AAyf5SyY9vLcDHeYc0Orjo75bymRLbcl0paExd3Lx7PG4Tu9UvszdMBVx4RmLBiot082/kZAPaJ5zsX3lf0OVzgRIQxy6RexgZ/TyC547WiGzsO/rIgy+PSMxVTyAx4hqdoFrjr5QQrktEAHHE6SUhR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4N3zRU8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4N3zRU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2hEgszt28JQupDfGysmj0gfn6zmuQJL6RXp5bak691Y=;
	b=h4N3zRU8d1xbgkEVNe2eLq8mdjdrX0IDNzpX4+hAoHa6Wj/8tOAZj2cLb9FJQ+O3UvlN8e
	9ZV6d9Scr/b8v+aU2ca9HDiACBNz7PkZ5H1jOUUz+hhQrnikAv5g0Y4/tDhS7uSm7HqjiV
	TSW8UBBrjdifVubAcUNL2AlMzn7fl6Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-EU6pQKsMP2y-vwuXO3hlZw-1; Wed, 16 Jul 2025 09:53:00 -0400
X-MC-Unique: EU6pQKsMP2y-vwuXO3hlZw-1
X-Mimecast-MFC-AGG-ID: EU6pQKsMP2y-vwuXO3hlZw_1752673979
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so58392165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673979; x=1753278779;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hEgszt28JQupDfGysmj0gfn6zmuQJL6RXp5bak691Y=;
        b=UibrGw2CPQq5OeyYnCdqji8oIxjiQAgkhQco5wIyP8rihmXU5Q21aB3Hu4hADZ2DZl
         IJE2onI0wwF4YG4lQ68HorvPRlNvCvnpm7vMW6diLX5Com6NwgGjLaHFZF6X9Vt0I4gE
         mh6B2v5fN2/rw8a+TucqezIPSvUUDRpUGAq5SGC6ldt3rfXfsm4kDbTH0GV0XGt/Wq7/
         lx8OienB4JJFIq06nuNrh08os3zcdQ0cSJhyCfG9PoSs/vRH97Tbq3cWVGKYZ6g1ezxR
         s8/lSSK2YNZg+V8bI1hU+bXizmDFzeV2iiMhFflEaVN4uEVoLRI47dr9NETshSU78GDc
         6sOA==
X-Forwarded-Encrypted: i=1; AJvYcCVdU1CQ9BQEfMthpQVX6ZSQhtrTKT/awjr8TtOesEu9j7W3NAbPcuNw5sNEIaMPHs8JLpL50ZCERfVrUFYdVyHHAG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9gN3WzADoc8cX5lMG1zkbPP3epyrUt2la5mPYYTl2aWh6DeT
	EEAd8bsYrqkdvVYUe4w+sukeLix4eX97Ad+ggES5bUEH846pocpAEloY9tWqn3qg0LCMLHoZOBq
	CbaJpJefCb0ZWUYnlLEUg2xVaxkiPaFcO/mN9MjZN+SIMuK9FmgIq6I3MTWJU44LJr7oWoAIDYw
	==
X-Gm-Gg: ASbGncv6k+eYzfP/NierkTEe0j/45S01KsR1N78HYLhtAQ2QOAJOTJVUsGbbxD8IMm7
	jyPKdEdTEF7xp9oXMovycon+YK5K/lnhpipZkdr2bUe1niUsNQFQ4WZlk6VhzPf5WW95lTqnTtq
	YGI8FBXu/5EfLKcG0Ne9adti7IVMUxR3ImSfL2pkZRBF0ThAMewKml05y564qlZV7MvlGuvm2Q9
	LQU1ifFlo2Nb9ubtuUKBfdSdD3TXIS+h2cNCAmSdWxeFaMctcRZE9Cw+ivvDISKMp+twcIV/lSp
	gOUUoPjJmDaHrLJlKsC23Anlt03+3Dn8XLL2SpWvH7pUnqFgNccEOKTPFx4jYQgDmUe7i2iIA6J
	gQoOh4QE7zBTim8y7FeuuYEs5cnNlcenBWyDGzL0G3tMlxtpbPq2bzoEdQ00NLMjFwx8=
X-Received: by 2002:a05:600c:358e:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-45630f70a3fmr21102745e9.10.1752673979149;
        Wed, 16 Jul 2025 06:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1TNtzlzJ7egUESdA177O1gyjYddzvwkp42ozHw6wJak5kcrOoLKHmEWqRXZFI+D3BLLhdEA==
X-Received: by 2002:a05:600c:358e:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-45630f70a3fmr21102105e9.10.1752673978549;
        Wed, 16 Jul 2025 06:52:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1d5sm18035063f8f.78.2025.07.16.06.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:52:58 -0700 (PDT)
Message-ID: <d2f622f6-3ef2-4227-b672-2fbd3a7dc931@redhat.com>
Date: Wed, 16 Jul 2025 15:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-6-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-6-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W_4SVumk0LDVZoaDis7Xf1x6Pjynp3GAZyVJx1q25NY_1752673979
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> generalize the order of the __collapse_huge_page_* functions
> to support future mTHP collapse.
> 
> mTHP collapse can suffer from incosistant behavior, and memory waste
> "creep". disable swapin and shared support for mTHP collapse.
> 
> No functional changes in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cc9a35185604..ee54e3c1db4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -552,15 +552,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					unsigned long address,
>   					pte_t *pte,
>   					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +					struct list_head *compound_pagelist,
> +					u8 order)

u8 ... (applies to all instances)

>   {
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	pte_t *_pte;
>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>   	bool writable = false;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);

"scaled_max_ptes_none" maybe?

>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -568,7 +570,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
>   			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= scaled_none)) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -596,8 +598,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See hpage_collapse_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> +			    shared > khugepaged_max_ptes_shared)) {

Please add a comment why we do something different with PMD. As 
commenting below, does this deserve a TODO?

>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;
> @@ -698,13 +700,14 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   						struct vm_area_struct *vma,
>   						unsigned long address,
>   						spinlock_t *ptl,
> -						struct list_head *compound_pagelist)
> +						struct list_head *compound_pagelist,
> +						u8 order)
>   {
>   	struct folio *src, *tmp;
>   	pte_t *_pte;
>   	pte_t pteval;
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> @@ -751,7 +754,8 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   					     pmd_t *pmd,
>   					     pmd_t orig_pmd,
>   					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +					     struct list_head *compound_pagelist,
> +					     u8 order)
>   {
>   	spinlock_t *pmd_ptl;
>   
> @@ -768,7 +772,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   	 * Release both raw and compound pages isolated
>   	 * in __collapse_huge_page_isolate.
>   	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + (1 << order), compound_pagelist);
>   }
>   
>   /*
> @@ -789,7 +793,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>   		unsigned long address, spinlock_t *ptl,
> -		struct list_head *compound_pagelist)
> +		struct list_head *compound_pagelist, u8 order)
>   {
>   	unsigned int i;
>   	int result = SCAN_SUCCEED;
> @@ -797,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   	/*
>   	 * Copying pages' contents is subject to memory poison at any iteration.
>   	 */
> -	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +	for (i = 0; i < (1 << order); i++) {
>   		pte_t pteval = ptep_get(pte + i);
>   		struct page *page = folio_page(folio, i);
>   		unsigned long src_addr = address + i * PAGE_SIZE;
> @@ -816,10 +820,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   
>   	if (likely(result == SCAN_SUCCEED))
>   		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
> -						    compound_pagelist);
> +						    compound_pagelist, order);
>   	else
>   		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 compound_pagelist, order);
>   
>   	return result;
>   }
> @@ -994,11 +998,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>   static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   				       struct vm_area_struct *vma,
>   				       unsigned long haddr, pmd_t *pmd,
> -				       int referenced)
> +				       int referenced, u8 order)
>   {
>   	int swapped_in = 0;
>   	vm_fault_t ret = 0;
> -	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long address, end = haddr + (PAGE_SIZE << order);
>   	int result;
>   	pte_t *pte = NULL;
>   	spinlock_t *ptl;
> @@ -1029,6 +1033,15 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;
>   
> +		/* Dont swapin for mTHP collapse */

Should we turn this into a TODO, because it's something to figure out 
regarding the scaling etc?

> +		if (order != HPAGE_PMD_ORDER) {
> +			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> +			pte_unmap(pte);
> +			mmap_read_unlock(mm);
> +			result = SCAN_EXCEED_SWAP_PTE;
> +			goto out;
> +		}
> +
>   		vmf.pte = pte;
>   		vmf.ptl = ptl;
>   		ret = do_swap_page(&vmf);
> @@ -1149,7 +1162,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		 * that case.  Continuing to collapse causes inconsistency.
>   		 */
>   		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
> -						     referenced);
 > +				referenced, HPAGE_PMD_ORDER);

Indent messed up. Feel free to exceed 80 chars if it aids readability.

>   		if (result != SCAN_SUCCEED)
>   			goto out_nolock;
>   	}
> @@ -1197,7 +1210,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>   	if (pte) {
>   		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -						      &compound_pagelist);
> +					&compound_pagelist, HPAGE_PMD_ORDER);

Dito.


Apart from that, nothing jumped at me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

