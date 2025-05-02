Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435962E403;
	Fri,  2 May 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149044; cv=none; b=TDrRxDzW3uKaJMm25zbyTsu8pcN2dwv26r4RGJY0X8LpitLK30A4DccpEISeCyMvW2DnD4hUCK13KRNCbaVnHjycbiyvwdD8+JfQZ+MlUge4xBbYiJMb1u/J33gu1XcAmQ02mY1y2XMjqJamlcyv4Drpl/LG3idnbj9JSXfKsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149044; c=relaxed/simple;
	bh=mRj4fkGpGfbl8/PyU3OJoYFMz/IoqS58+i5emRF5ruo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfCY0n9My0xaErCLikc0QKPT1vAhfQ/eE0XmOq0edtIFDuHnbgVRTiOqG8A8EJRo6nd685pECTA9V++KYU3pciyJxSw8IbGePMJSH9sfAE6A0I1e/FDiI2rx30ZFQY+zPUWhQIka66YWK1RxL3irJ4hmNu4ujEqRCdxy3b3kh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tHVT2c4R; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tHVT2c4R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746149031; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nCxVZm3wSwg9n3/8gMY7iE/dhHvHfCteXR6U47l0Wpc=;
	b=tHVT2c4RfejuQ7hzT53ZF9wwauzBPuwSPiWxIvUFpAwe/gftFzipBm4rF3/sqGb/ZyGOP6TvnBXuc8E+TxT0/gK69JnKZlOOjyPko9NPBOG4OeU3i8GMUsY7UK02pJF4ln80ApXfabz87SUlsGm/4vM+4jn3nFY30r9osf29NmI=
Received: from 30.0.191.233(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYtVH7S_1746149025 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 02 May 2025 09:23:47 +0800
Message-ID: <83a66442-b7c7-42e7-af4e-fd211d8ed6f8@linux.alibaba.com>
Date: Fri, 2 May 2025 09:23:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-7-npache@redhat.com>
 <5feb1d57-e069-4469-9751-af4fb067e858@linux.alibaba.com>
 <CAA1CXcDWX7zsW03Wwg_OHRhJ2nrt6OaLd5bn8ccX0StoN1kGUQ@mail.gmail.com>
 <CAA1CXcDarV2LqLcSRpb=a_A5YFBc26dBT0cCYdLj-8jGKZ53Yw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcDarV2LqLcSRpb=a_A5YFBc26dBT0cCYdLj-8jGKZ53Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/2 07:03, Nico Pache wrote:
> On Wed, Apr 30, 2025 at 12:56 PM Nico Pache <npache@redhat.com> wrote:
>>
>> On Wed, Apr 30, 2025 at 4:08 AM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2025/4/29 02:12, Nico Pache wrote:
>>>> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
>>>> To add mTHP support we use this scan to instead record chunks of utilized
>>>> sections of the PMD.
>>>>
>>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
>>>> that represents chunks of utilized regions. We can then determine what
>>>> mTHP size fits best and in the following patch, we set this bitmap while
>>>> scanning the anon PMD.
>>>>
>>>> max_ptes_none is used as a scale to determine how "full" an order must
>>>> be before being considered for collapse.
>>>>
>>>> When attempting to collapse an order that has its order set to "always"
>>>> lets always collapse to that order in a greedy manner without
>>>> considering the number of bits set.
>>>>
>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>> ---
>>>>    include/linux/khugepaged.h |  4 ++
>>>>    mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>>>>    2 files changed, 89 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>>>> index 1f46046080f5..18fe6eb5051d 100644
>>>> --- a/include/linux/khugepaged.h
>>>> +++ b/include/linux/khugepaged.h
>>>> @@ -1,6 +1,10 @@
>>>>    /* SPDX-License-Identifier: GPL-2.0 */
>>>>    #ifndef _LINUX_KHUGEPAGED_H
>>>>    #define _LINUX_KHUGEPAGED_H
>>>> +#define KHUGEPAGED_MIN_MTHP_ORDER    2
>>>
>>> Still better to add some comments to explain explicitly why choose 2 as
>>> the MIN_MTHP_ORDER.
>> Ok i'll add a note that explicitly states that the min order of anon mTHPs is 2
>>>
>>>> +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
>>>> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
>>>> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>>>>
>>>>    extern unsigned int khugepaged_max_ptes_none __read_mostly;
>>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index e21998a06253..6e67db86409a 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>>>>
>>>>    static struct kmem_cache *mm_slot_cache __ro_after_init;
>>>>
>>>> +struct scan_bit_state {
>>>> +     u8 order;
>>>> +     u16 offset;
>>>> +};
>>>> +
>>>>    struct collapse_control {
>>>>        bool is_khugepaged;
>>>>
>>>> @@ -102,6 +107,18 @@ struct collapse_control {
>>>>
>>>>        /* nodemask for allocation fallback */
>>>>        nodemask_t alloc_nmask;
>>>> +
>>>> +     /*
>>>> +      * bitmap used to collapse mTHP sizes.
>>>> +      * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
>>>> +      */
>>>> +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
>>>> +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
>>>> +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
>>>> +};
>>>> +
>>>> +struct collapse_control khugepaged_collapse_control = {
>>>> +     .is_khugepaged = true,
>>>>    };
>>>>
>>>>    /**
>>>> @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
>>>>        remove_wait_queue(&khugepaged_wait, &wait);
>>>>    }
>>>>
>>>> -struct collapse_control khugepaged_collapse_control = {
>>>> -     .is_khugepaged = true,
>>>> -};
>>>> -
>>>>    static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>>>>    {
>>>>        int i;
>>>> @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>>>>
>>>>    static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>                              int referenced, int unmapped,
>>>> -                           struct collapse_control *cc)
>>>> +                           struct collapse_control *cc, bool *mmap_locked,
>>>> +                               u8 order, u16 offset)
>>>>    {
>>>>        LIST_HEAD(compound_pagelist);
>>>>        pmd_t *pmd, _pmd;
>>>> @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>         * The allocation can take potentially a long time if it involves
>>>>         * sync compaction, and we do not need to hold the mmap_lock during
>>>>         * that. We will recheck the vma after taking it again in write mode.
>>>> +      * If collapsing mTHPs we may have already released the read_lock.
>>>>         */
>>>> -     mmap_read_unlock(mm);
>>>> +     if (*mmap_locked) {
>>>> +             mmap_read_unlock(mm);
>>>> +             *mmap_locked = false;
>>>> +     }
>>>>
>>>>        result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>>>>        if (result != SCAN_SUCCEED)
>>>> @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>    out_up_write:
>>>>        mmap_write_unlock(mm);
>>>>    out_nolock:
>>>> +     *mmap_locked = false;
>>>>        if (folio)
>>>>                folio_put(folio);
>>>>        trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>>>>        return result;
>>>>    }
>>>>
>>>> +// Recursive function to consume the bitmap
>>>
>>> Nit: please use '/* Xxxx */' for comments in this patch.
>>>
>>>> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
>>>> +                     int referenced, int unmapped, struct collapse_control *cc,
>>>> +                     bool *mmap_locked, unsigned long enabled_orders)
>>>> +{
>>>> +     u8 order, next_order;
>>>> +     u16 offset, mid_offset;
>>>> +     int num_chunks;
>>>> +     int bits_set, threshold_bits;
>>>> +     int top = -1;
>>>> +     int collapsed = 0;
>>>> +     int ret;
>>>> +     struct scan_bit_state state;
>>>> +     bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
>>>> +
>>>> +     cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
>>>> +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
>>>> +
>>>> +     while (top >= 0) {
>>>> +             state = cc->mthp_bitmap_stack[top--];
>>>> +             order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
>>>> +             offset = state.offset;
>>>> +             num_chunks = 1 << (state.order);
>>>> +             // Skip mTHP orders that are not enabled
>>>> +             if (!test_bit(order, &enabled_orders))
>>>> +                     goto next;
>>>> +
>>>> +             // copy the relavant section to a new bitmap
>>>> +             bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
>>>> +                               MTHP_BITMAP_SIZE);
>>>> +
>>>> +             bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
>>>> +             threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
>>>> +                             >> (HPAGE_PMD_ORDER - state.order);
>>>> +
>>>> +             //Check if the region is "almost full" based on the threshold
>>>> +             if (bits_set > threshold_bits || is_pmd_only
>>>> +                     || test_bit(order, &huge_anon_orders_always)) {
>>>
>>> When testing this patch, I disabled the PMD-sized THP and enabled
>>> 64K-sized mTHP, but it still attempts to collapse into a PMD-sized THP
>>> (since bits_set > threshold_bits is ture). This doesn't seem reasonable?
>> We are still required to have PMD enabled for mTHP collapse to work.
>> It's a limitation of the current khugepaged code (it currently only
>> adds mm_slots when PMD is enabled).
>> We've discussed this in the past and are looking for a proper way
>> forward, but the solution becomes tricky.
>>
>> However I'm surprised that it still collapses due to the code below.
>> I'll test this out later today.
> 
> Following up, you are correct, if I disable the PMD size within the
> mTHP enabled settings (echo never >
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled) it still
> collapses to PMDs. I believe the global variable takes precedent. I'm
> not sure what the correct behavior is... I will look into it further
> 
>>      +             if (!test_bit(order, &enabled_orders))
>>      +                     goto next;

IMO, we should respect the mTHP sysfs control interfaces and use the 
'TVA_ENFORCE_SYSFS' flag when determining allowable orders through 
thp_vma_allowable_orders().
