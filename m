Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DE36E467
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475126; cv=none; b=O+WDWXRotQSdkJKfFCTwWk78XuNHnJwx4S27fX5f1AwR7jNGAADbclbm7x1ndA98YwhwxtdIuaeheYK4nP3givhlkwAlEW1GxLT2kERt81VJMUD2E+UxmOcIicBsII5IdmiEnjGkJrEpqnMgHN1WZVF3VTIGP91sH6V57ZN+GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475126; c=relaxed/simple;
	bh=CLCroR6ABemoQ+yX+4/wvOqT//sR7JYg30e4vinZhN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvAjKm/OX3NeHxAV3sly5zK8rGFSBEtO5M0FPgduZbcZbPWQP3hWcVY/0pwiefxm002K4hrsWEOmAHxIVCQghpKU73j6KRgxxjdwlKLGf1wVDZvtuPld8eBLcEnGwBsAmT0nyccc8uoLUOHEND++dfCxKnwXT4eCJkB64gjn4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f97Y7Fe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f97Y7Fe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777475124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUTLsAIEpGj17Dq3l/AJDprb4dis7oVAYZKNdJ3rJyI=;
	b=f97Y7Fe75EkrrP2Qc/ZBqLfnu5gmLqPoIJLFXDVIJqmwAPeybs6QtXl/yqNS3LAEHROp+Y
	gABv2MEPOVnEMpGy4ZOn1LqqtkojWl/zJdLjKEo0dSXNO0sa9OUssBK6d51nEIwhUMARgq
	e4KvD12BzBAvJveqEqHgI4uNggNvgxM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-ZNo0rVR2NAmMSgEKz8aKRw-1; Wed, 29 Apr 2026 11:05:18 -0400
X-MC-Unique: ZNo0rVR2NAmMSgEKz8aKRw-1
X-Mimecast-MFC-AGG-ID: ZNo0rVR2NAmMSgEKz8aKRw_1777475114
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38ec3a86367so52162041fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475114; x=1778079914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUTLsAIEpGj17Dq3l/AJDprb4dis7oVAYZKNdJ3rJyI=;
        b=HHsdEMMlDu2/8gjUYa21O46Xeb/0TfV65FZYXnYS2CgrIoq9yERPrwu+fsouKXNlto
         1sZJE++cioM8c1tBuXvf8IlTJ9ctgLRJ32caW8Cn7raQjzSOIzfWz1TANOnT+Rw4zUkl
         YQnZBq0CXon5GoHihK02K43X91h5vgHjpoOxz5RO/4i0KVZcyZCvHDZovVJW98aosD4e
         gIgyprR4cG/n2OfvZIF+zOSfhCxY9ffTlKc+MOr8ce8A9P8enDj8GVrhCNsBclvNpkJH
         TOWn2tJktFYz66fpOj3nTCo1dlziqHWAb/ybT+BV8maXzVoGkLlg7hA4w0ijp3EA1IDH
         C9NA==
X-Forwarded-Encrypted: i=1; AFNElJ+5cW/rB38aQKYdNSvB+HjTd9VhTqjx6TikrZzFQug5jIu1xzFQYgtQ1b9o0ltI3VMHzpPJ2PjVJ2kqTzK3vikTv10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBb0zjK7uyM6yAG44W0TEmJcEpVjLQkC+a0EbU+7emkcykiBGd
	QIuxYxak711HhJP9T3yGwjPa/tFuXFUwpfta0nje1PeTZ69Ck8afVrkWamyTDb6a8BRMKhuBsf5
	DezNi1r6YwAiyyFRM3cTt4r/ZI/xwn8bIlgnTs19+Ms/BSXB1laH8TH2hsAEZdOFZFbB7FWIRHO
	I7BNM2vAGtPBRDgjDmuOqJ9XWZLBVtwrey4r0A+McAzIY0sRJJ
X-Gm-Gg: AeBDiev89n/tfqol5WmvP5TI2Qhn2ORo2alZr1pkWByywaFxj1Z32w9FfEEuN1Vr8xe
	DATiHut9LgT8M9n6xPH8/t5hmy1UV8lLeREoRGJ1vPh/SqPGI5KhzWCt0gVBYs+DMQ28l2TWM0w
	LEqvuYRYPNfVg2UTPgbDXL260D3VlFaEMohbqdQItjKlQNgDkreJIqTuCKv6+GXnqAtFPrPHyQ+
	MkfCH623hkKgzXM2hRMF4UeK7pCUY+tybKubp2uYa5zmnaCqw4=
X-Received: by 2002:a2e:be90:0:b0:38a:291c:dbcc with SMTP id 38308e7fff4ca-39240f7ae4bmr32131501fa.19.1777475113447;
        Wed, 29 Apr 2026 08:05:13 -0700 (PDT)
X-Received: by 2002:a2e:be90:0:b0:38a:291c:dbcc with SMTP id
 38308e7fff4ca-39240f7ae4bmr32130881fa.19.1777475112731; Wed, 29 Apr 2026
 08:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-5-npache@redhat.com> <20260420135554.27067-1-usama.arif@linux.dev>
In-Reply-To: <20260420135554.27067-1-usama.arif@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 09:05:16 -0600
X-Gm-Features: AVHnY4KqhjJ7yDGmLi98Dh0LcQMTG9pjpcmQvJpRxqOZ7Z3wYdlwUP6DO0sgnOE
Message-ID: <CAA1CXcAbUwWgZapCRiRbCDsxBAZVWV59fQF+RfHoWaX+HnRpbg@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 04/13] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Qfb2xTBZCBX4ncQNlLDtx8RFfvvAkLo9oOHvXifn4g_1777475114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/20/26 7:55 AM, Usama Arif wrote:
> On Sun, 19 Apr 2026 12:57:41 -0600 Nico Pache <npache@redhat.com> wrote:
>
>> generalize the order of the __collapse_huge_page_* and collapse_max_*
>> functions to support future mTHP collapse.
>>
>> The current mechanism for determining collapse with the
>> khugepaged_max_ptes_none value is not designed with mTHP in mind. This
>> raises a key design issue: if we support user defined max_pte_none values
>> (even those scaled by order), a collapse of a lower order can introduces
>> an feedback loop, or "creep", when max_ptes_none is set to a value greater
>> than HPAGE_PMD_NR / 2.
>>
>> With this configuration, a successful collapse to order N will populate
>> enough pages to satisfy the collapse condition on order N+1 on the next
>> scan. This leads to unnecessary work and memory churn.
>>
>> To fix this issue introduce a helper function that will limit mTHP
>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
>> This effectively supports two modes:
>>
>> - max_ptes_none=0: never introduce new none-pages for mTHP collapse.
>> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>>    available mTHP order.
>>
>> This removes the possiblilty of "creep", while not modifying any uAPI
>> expectations. A warning will be emitted if any non-supported
>> max_ptes_none value is configured with mTHP enabled.
>>
>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
>> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
>> shared or swapped entry.
>>
>> No functional changes in this patch; however it defines future behavior
>> for mTHP collapse.
>>
>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 124 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 88 insertions(+), 36 deletions(-)
>>
>
> Small nits. Most might not need change.

No you brought some good points :) Thanks for your reviews!

>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f42b55421191..283bb63854a5 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -352,51 +352,86 @@ static bool pte_none_or_zero(pte_t pte)
>>    * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>>    * @cc: The collapse control struct
>>    * @vma: The vma to check for userfaultfd
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>> - * empty page.
>> + * empty page. For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the
>> + * configured khugepaged_max_ptes_none value.
>> + *
>> + * For mTHP collapses, we currently only support khugepaged_max_pte_none values
>> + * of 0 or (KHUGEPAGED_MAX_PTES_LIMIT). Any other value will emit a warning and
>> + * no mTHP collapse will be attempted
>>    *
>>    * Return: Maximum number of empty PTEs allowed for the collapse operation
>>    */
>> -static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>> -            struct vm_area_struct *vma)
>> +static int collapse_max_ptes_none(struct collapse_control *cc,
>> +            struct vm_area_struct *vma, unsigned int order)
>>   {
>>      if (vma && userfaultfd_armed(vma))
>>              return 0;
>>      if (!cc->is_khugepaged)
>>              return HPAGE_PMD_NR;
>> -    return khugepaged_max_ptes_none;
>> +    if (is_pmd_order(order))
>> +            return khugepaged_max_ptes_none;
>> +    /* Zero/non-present collapse disabled. */
>> +    if (!khugepaged_max_ptes_none)
>> +            return 0;
>> +    if (khugepaged_max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
>> +            return (1 << order) - 1;
>> +
>
> There are 2 reads of khugepaged_max_ptes_none here.
> A concurrent sysctl write between reads can yield "0 then non-zero" or "LIMIT
> then mid-value".
>
> Would be good to just snapshot once at the start of the function and use that
> value?

Yeah good point, that would avoid any really hard to reproduce, but
probably very unlikely to occur bugs.

>
>> +    pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
>> +                  KHUGEPAGED_MAX_PTES_LIMIT);
>
> IMO, warn_once can get lost quickly in dmesg. Maybe pr_warn_ratelimited?
>
> Not sure what others opinions are..

I see David already reply'd to this. I guess we keep the warn once or
hard limit to 0. My fear with the latter is that would then violate the
whole concern (and the only reason we have 0/511) support in the first
place. If we could violate this uAPI expectation then I would then want
to reintroduce hardcapping max_ptes_none to HPAGE_PMD_NR/2 if its above
this value.

So in eyes, lets just keep this as is for now.

>
>> +    return -EINVAL;
>>   }
>>
>>   /**
>>    * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse
>>    * @cc: The collapse control struct
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>>    * shared page.
>>    *
>> + * For mTHP collapses, we currently dont support collapsing memory with
>> + * shared memory.
>> + *
>>    * Return: Maximum number of shared PTEs allowed for the collapse operation
>>    */
>> -static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
>> +static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
>> +            unsigned int order)
>>   {
>>      if (!cc->is_khugepaged)
>>              return HPAGE_PMD_NR;
>> +    if (!is_pmd_order(order))
>> +            return 0;
>> +
>>      return khugepaged_max_ptes_shared;
>>   }
>>
>>   /**
>>    * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse
>>    * @cc: The collapse control struct
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>>    * swap page.
>>    *
>> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
>> + * khugepaged_max_ptes_swap value.
>> + *
>> + * For mTHP collapses, we currently dont support collapsing memory with
>> + * swapped out memory.
>> + *
>>    * Return: Maximum number of swap PTEs allowed for the collapse operation
>>    */
>> -static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
>> +static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
>> +            unsigned int order)
>>   {
>>      if (!cc->is_khugepaged)
>>              return HPAGE_PMD_NR;
>> +    if (!is_pmd_order(order))
>> +            return 0;
>> +
>>      return khugepaged_max_ptes_swap;
>>   }
>>
>> @@ -590,18 +625,22 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>
>>   static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>              unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
>> -            struct list_head *compound_pagelist)
>> +            unsigned int order, struct list_head *compound_pagelist)
>>   {
>> +    const unsigned long nr_pages = 1UL << order;
>>      struct page *page = NULL;
>>      struct folio *folio = NULL;
>>      unsigned long addr = start_addr;
>>      pte_t *_pte;
>>      int none_or_zero = 0, shared = 0, referenced = 0;
>>      enum scan_result result = SCAN_FAIL;
>> -    unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
>> -    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
>> +    int max_ptes_none = collapse_max_ptes_none(cc, vma, order);
>> +    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, order);
>> +
>> +    if (max_ptes_none < 0)
>> +            return result;
>
> Would a dedicated SCAN_INVALID_PTES_NONE make more sense here instead
> of SCAN_FAIL?

Yeah thats a good idea, let me see if i can make that work.

>
>>
>> -    for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>> +    for (_pte = pte; _pte < pte + nr_pages;
>>           _pte++, addr += PAGE_SIZE) {
>>              pte_t pteval = ptep_get(_pte);
>>              if (pte_none_or_zero(pteval)) {
>> @@ -734,18 +773,18 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>   }
>>
>>   static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>> -                                            struct vm_area_struct *vma,
>> -                                            unsigned long address,
>> -                                            spinlock_t *ptl,
>> -                                            struct list_head *compound_pagelist)
>> +            struct vm_area_struct *vma, unsigned long address,
>> +            spinlock_t *ptl, unsigned int order,
>> +            struct list_head *compound_pagelist)
>>   {
>> -    unsigned long end = address + HPAGE_PMD_SIZE;
>> +    const unsigned long nr_pages = 1UL << order;
>> +    unsigned long end = address + (PAGE_SIZE << order);
>>      struct folio *src, *tmp;
>>      pte_t pteval;
>>      pte_t *_pte;
>>      unsigned int nr_ptes;
>>
>> -    for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
>> +    for (_pte = pte; _pte < pte + nr_pages; _pte += nr_ptes,
>>           address += nr_ptes * PAGE_SIZE) {
>>              nr_ptes = 1;
>>              pteval = ptep_get(_pte);
>> @@ -798,13 +837,11 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>   }
>>
>>   static void __collapse_huge_page_copy_failed(pte_t *pte,
>> -                                         pmd_t *pmd,
>> -                                         pmd_t orig_pmd,
>> -                                         struct vm_area_struct *vma,
>> -                                         struct list_head *compound_pagelist)
>> +            pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>> +            unsigned int order, struct list_head *compound_pagelist)
>>   {
>> +    const unsigned long nr_pages = 1UL << order;
>>      spinlock_t *pmd_ptl;
>> -
>
> Shouldn't remove the newline above?

Ack thank you

>
>>      /*
>>       * Re-establish the PMD to point to the original page table
>>       * entry. Restoring PMD needs to be done prior to releasing
>> @@ -818,7 +855,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>>       * Release both raw and compound pages isolated
>>       * in __collapse_huge_page_isolate.
>>       */
>> -    release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
>> +    release_pte_pages(pte, pte + nr_pages, compound_pagelist);
>>   }
>>
>>   /*
>> @@ -838,16 +875,16 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>>    */
>>   static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>>              pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>> -            unsigned long address, spinlock_t *ptl,
>> +            unsigned long address, spinlock_t *ptl, unsigned int order,
>>              struct list_head *compound_pagelist)
>>   {
>> +    const unsigned long nr_pages = 1UL << order;
>>      unsigned int i;
>>      enum scan_result result = SCAN_SUCCEED;
>> -
>
> Same here?

its probably from me reordering nr_pages to the top. ack! thanks

>
>>      /*
>>       * Copying pages' contents is subject to memory poison at any iteration.
>>       */
>> -    for (i = 0; i < HPAGE_PMD_NR; i++) {
>> +    for (i = 0; i < nr_pages; i++) {
>>              pte_t pteval = ptep_get(pte + i);
>>              struct page *page = folio_page(folio, i);
>>              unsigned long src_addr = address + i * PAGE_SIZE;
>> @@ -866,10 +903,10 @@ static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *foli
>>
>>      if (likely(result == SCAN_SUCCEED))
>>              __collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
>> -                                                compound_pagelist);
>> +                                                order, compound_pagelist);
>>      else
>>              __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
>> -                                             compound_pagelist);
>> +                                             order, compound_pagelist);
>>
>>      return result;
>>   }
>> @@ -1040,12 +1077,12 @@ static enum scan_result check_pmd_still_valid(struct mm_struct *mm,
>>    * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
>>    */
>>   static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>> -            struct vm_area_struct *vma, unsigned long start_addr, pmd_t *pmd,
>> -            int referenced)
>> +            struct vm_area_struct *vma, unsigned long start_addr,
>> +            pmd_t *pmd, int referenced, unsigned int order)
>
> Will probably find out in later reviews, but there is tracepoint in __collapse_huge_page_swapin.
> Would be good to add order in that tracepoint if you are adding order here?

Yep! There is a patch that updates the tracepoints.

>
>>   {
>>      int swapped_in = 0;
>>      vm_fault_t ret = 0;
>> -    unsigned long addr, end = start_addr + (HPAGE_PMD_NR * PAGE_SIZE);
>> +    unsigned long addr, end = start_addr + (PAGE_SIZE << order);
>>      enum scan_result result;
>>      pte_t *pte = NULL;
>>      spinlock_t *ptl;
>> @@ -1077,6 +1114,19 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>>                  pte_present(vmf.orig_pte))
>>                      continue;
>>
>> +            /*
>> +             * TODO: Support swapin without leading to further mTHP
>> +             * collapses. Currently bringing in new pages via swapin may
>> +             * cause a future higher order collapse on a rescan of the same
>> +             * range.
>> +             */
>> +            if (!is_pmd_order(order)) {
>
> Would it be good to introduce this in the patch that activates it? No strong
> preference btw. Just that its dead code in this patch itself.

No we are trying to get everything ready before the patch(es) that
actually activates this feature. Everything related to order is
currently dead code at this moment until the later commits.

Cheers,
-- Nico


>
>> +                    pte_unmap(pte);
>> +                    mmap_read_unlock(mm);
>> +                    result = SCAN_EXCEED_SWAP_PTE;
>> +                    goto out;
>> +            }
>> +
>>              vmf.pte = pte;
>>              vmf.ptl = ptl;
>>              ret = do_swap_page(&vmf);
>> @@ -1196,7 +1246,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>               * that case.  Continuing to collapse causes inconsistency.
>>               */
>>              result = __collapse_huge_page_swapin(mm, vma, address, pmd,
>> -                                                 referenced);
>> +                                                 referenced, HPAGE_PMD_ORDER);
>>              if (result != SCAN_SUCCEED)
>>                      goto out_nolock;
>>      }
>> @@ -1244,6 +1294,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>      pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>>      if (pte) {
>>              result = __collapse_huge_page_isolate(vma, address, pte, cc,
>> +                                                  HPAGE_PMD_ORDER,
>>                                                    &compound_pagelist);
>>              spin_unlock(pte_ptl);
>>      } else {
>> @@ -1274,6 +1325,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>>
>>      result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>>                                         vma, address, pte_ptl,
>> +                                       HPAGE_PMD_ORDER,
>>                                         &compound_pagelist);
>>      pte_unmap(pte);
>>      if (unlikely(result != SCAN_SUCCEED))
>> @@ -1318,9 +1370,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>      unsigned long addr;
>>      spinlock_t *ptl;
>>      int node = NUMA_NO_NODE, unmapped = 0;
>> -    unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
>> -    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
>> -    unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
>> +    int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
>> +    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
>> +    unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
>>
>>      VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
>>
>> @@ -2371,8 +2423,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>>      int present, swap;
>>      int node = NUMA_NO_NODE;
>>      enum scan_result result = SCAN_SUCCEED;
>> -    unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL);
>> -    unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
>> +    int max_ptes_none = collapse_max_ptes_none(cc, NULL, HPAGE_PMD_ORDER);
>> +    unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
>>
>>      present = 0;
>>      swap = 0;
>> --
>> 2.53.0
>>
>>
>

