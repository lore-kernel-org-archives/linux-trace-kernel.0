Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865832B9B6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476882; cv=none; b=O25v/z4XeVLN4vgYD735nMFi4AioB/9fVnQg48Ai8GcpiG5jh9CW8H3brV1ymyFc1nOdN310YAVdUiajeMuLvq0eQHtVkzE1942N1+wN+/AHuthS5Qd9+3WCrGaHYbHwc20KQF1ih36IfJCsOmh6+xRrM9dn2ESHmpfHZYm9Q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476882; c=relaxed/simple;
	bh=Joccb/6m/qotoTKxzfXXj7gjX+oAzcEhjQ92xhr+2jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8QC+TkZC0lxIlOnWaI/ZZp8FCSxSGI40eqnlfHrKyukwsBhiBMqZB1nOsvEC9UFXbWfpRQKXxhdTmQk3s3E56UdA3xefyMiVeFMAOQPEuB8hc2QeCJnv4kcI8GyYKuuKSsJdscWZhAS0BLyNiRvabpdsUu2NoJhgUB7Sq0yELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0bLYhr4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0bLYhr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777476879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x52e0fZe8hqgi5rk/2KtQuEEUkLEozDf77zUuE/vYO4=;
	b=I0bLYhr4fzf1caSxb77CH/zPDidq6lWljOnkZNYAyViSyaTvm/2oJ1NbPJl350fFTH30Ee
	ST0jcQa8xS15cvoeC2gAhkOcAUpOe2G17MER62cL3eHX3BXGKMKqk/9iR6atjcbsTK7+1K
	XuZMaE/ZBsezwUERo8IuIddmShZzblo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-TapKCuD6N8yhXhfKukSyoQ-1; Wed, 29 Apr 2026 11:34:37 -0400
X-MC-Unique: TapKCuD6N8yhXhfKukSyoQ-1
X-Mimecast-MFC-AGG-ID: TapKCuD6N8yhXhfKukSyoQ_1777476876
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6546ccc8989so1497514d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 08:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476876; x=1778081676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x52e0fZe8hqgi5rk/2KtQuEEUkLEozDf77zUuE/vYO4=;
        b=czBRTjHsUTcQBPOsKAhlC3/x6LkobhDnVgTi7LXAcKb09gdOJr4NkeE106Q0RKJ1Wi
         bVwacR+Eg+jq6cKA7XDjATYv3aI7CBxs9Rf7NOcRln6rthZj4kqIZAM1eSrwoYEEqKv2
         vkgCh1EcTd0M5TxK4hVSilKB8wNd3wrfhqc5Y58ttcZPKqcfLbHP0MzHu853UZgNjuT1
         2Kw7IpkJCEHtpnOgly3Yw27kPmLQdWNkxD5nJCESGisjHy6tfRHCwBpqu45zurV9mEVt
         K12gj+UU4Ic2sbr/dyNG1vuEZArGbOsaYVzvOmR4PHDcV6SPvgxaciDluPMImly3tJgz
         Gqqg==
X-Forwarded-Encrypted: i=1; AFNElJ9qmq18KgxyogWHOPCBj+BFTYJc94l8YZP8hWWFB7V9hdfRcZSNfJAix3+RwVoQiMcR7WEnWsK85MmPtIDCW02KzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOr84usNyZ04hesTbApEmMclccxCih52oRSL0ujq4PkpPUYAfs
	eCZYInD8jGMb9rX2JCQ7Qo9qq707MsOQMy+PIUNQ2FZd0N/8VhE25QuKYqSj/pNDj9EEntuSSi8
	s2eBGxLHU9kUjR+7CeFNKYON5RidMjSfpL13TYHXPiTnBONGCzgw4Pjxm7QAvADHTNsPhmV6qn8
	kCdv8SO1AGtCQ1W01FH1jXcj6MNK1fyz8GpxWDmDryKgGO6mru
X-Gm-Gg: AeBDietoBddNowaAK/4u7WKJGJmRv8x0U/Zvc0XaJ/DkBC8fN7O1+fV3j2Qjl3mo5db
	RnumIZ6z5WeJF+Qk23+rsmK4M56skGuTm+TYAOAX0QM+CzFY7Tu/C9HDBfmz9wMmn+dbS5ChQKp
	X+x4fpjq4vgmjTyuWuG2zmJYpRevboQpAooFovw2DmxLvEsfkAJCphqSAJYfbmziMn3hoJqXbi/
	Dp2g4mWxQpr6t/aaygivwkVQ9v3fCdWIGhoi/8oq9zduX5TPHE=
X-Received: by 2002:a53:b688:0:b0:650:3138:115 with SMTP id 956f58d0204a3-65beee4a1b0mr6260561d50.36.1777476875823;
        Wed, 29 Apr 2026 08:34:35 -0700 (PDT)
X-Received: by 2002:a53:b688:0:b0:650:3138:115 with SMTP id
 956f58d0204a3-65beee4a1b0mr6260501d50.36.1777476875210; Wed, 29 Apr 2026
 08:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-6-npache@redhat.com>
 <6025c087-378b-4754-b1f2-3c5448b49d6c@kernel.org>
In-Reply-To: <6025c087-378b-4754-b1f2-3c5448b49d6c@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 09:34:41 -0600
X-Gm-Features: AVHnY4LxGs5gVtTI63RcmHeUNNAvbBe-z9kQhpe1H901TsSecYTyWmk06JRVx0o
Message-ID: <CAA1CXcB-BpuryzNLznU_JS5XLvLmGoT34UK-bpMOPjE0GE1NEA@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 05/13] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 28UHWM6FQVVr4bTZUjzN45QXJPsezTvneypWIIEAAww_1777476876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 2:13 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
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
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 103 +++++++++++++++++++++++++++---------------------
>>   1 file changed, 57 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 283bb63854a5..ff6f9f1883ed 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1198,42 +1198,36 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>>      return SCAN_SUCCEED;
>>   }
>>
>> -static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
>> -            int referenced, int unmapped, struct collapse_control *cc)
>> +static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
>> +            int referenced, int unmapped, struct collapse_control *cc,
>> +            unsigned int order)
>>   {
>>      LIST_HEAD(compound_pagelist);
>>      pmd_t *pmd, _pmd;
>> -    pte_t *pte;
>> +    pte_t *pte = NULL;
>>      pgtable_t pgtable;
>>      struct folio *folio;
>>      spinlock_t *pmd_ptl, *pte_ptl;
>>      enum scan_result result = SCAN_FAIL;
>>      struct vm_area_struct *vma;
>>      struct mmu_notifier_range range;
>> +    bool anon_vma_locked = false;
>> +    const unsigned long pmd_addr = start_addr & HPAGE_PMD_MASK;
>> +    const unsigned long end_addr = start_addr + (PAGE_SIZE << order);
>
> In general, const read better when they are at the very top of this list.

Ack! still getting in the habit of this, sorry.

>
>>
>> -    VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> -
>> -    /*
>> -     * Before allocating the hugepage, release the mmap_lock read lock.
>> -     * The allocation can take potentially a long time if it involves
>> -     * sync compaction, and we do not need to hold the mmap_lock during
>> -     * that. We will recheck the vma after taking it again in write mode.
>> -     */
>> -    mmap_read_unlock(mm);
>> -
>
> You should spell out that locking change (moving it to the caller), and why it
> is required, in the patch description.
>
> I'd even have put this into a separate patch, as it's independent to the
> order-passing changes.

Yeah good point ill separate this out into its own patch, I also
realized I never updated the commit message for this patch to properly
describe this change. Whoops.


> [...]
>
>>       */
>>      __folio_mark_uptodate(folio);
>> -    pgtable = pmd_pgtable(_pmd);
>> -
>>      spin_lock(pmd_ptl);
>> -    BUG_ON(!pmd_none(*pmd));
>> -    pgtable_trans_huge_deposit(mm, pmd, pgtable);
>> -    map_anon_folio_pmd_nopf(folio, pmd, vma, address);
>> +    WARN_ON_ONCE(!pmd_none(*pmd));
>> +    if (is_pmd_order(order)) { /* PMD collapse */
>> +            pgtable = pmd_pgtable(_pmd);
>> +            pgtable_trans_huge_deposit(mm, pmd, pgtable);
>> +            map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
>> +    } else { /* mTHP collapse */
>
> Do both these comments (PMD collapse ...) really add any value? I'd say it's
> pretty self-documenting code already.

Yeah with the new is_pmd_order helper its def a little overkill. I'll
remove them. Thanks!


>
>> +            map_anon_folio_pte_nopf(folio, pte, vma, start_addr, /*uffd_wp=*/ false);
>> +            smp_wmb(); /* make PTEs visible before PMD. See pmd_install() */
>> +            pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>> +    }
>>      spin_unlock(pmd_ptl);
>>
>>      folio = NULL;
>>
>>      result = SCAN_SUCCEED;
>>   out_up_write:
>> +    if (anon_vma_locked)
>> +            anon_vma_unlock_write(vma->anon_vma);
>> +    if (pte)
>> +            pte_unmap(pte);
>

