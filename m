Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17385478D;
	Wed, 17 Dec 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935247; cv=none; b=VwMFs5lPBelB8u5HYTLKYyOQn7+ekf3lAQ3k3MrXkdaZ+DSvCcsL3eiRRG0Ow4zBU5ucIS51Sov/6dgWx4BoyfFc6T+6RnturNYY8ZpsgEbbiLcA7d5uAIlSfRCN4j0zigi9h6Fpt/wQcNkroVb6YROYy6JQIbKi8nHNBBU02Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935247; c=relaxed/simple;
	bh=bWv38s9EaDla/rAJNzBejZoonZB4ZsznmSFCB7PTrCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm+Y2GO2C9ukIn5CcH9RD1hjnrWe7thInLUIVU++tw/VmjDCRSk/zLiVVen168plKvZZqLH9bgMU6MNGkfA6Fs91N/ST+ZDc6GKhlRPT6jg+QKJ8Uc8cek2vUljx9OoE9umvDKbLnqRI+5HdAH3y6o6gO54sKD/tQyRSM8GrIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=muu5nR/W; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="muu5nR/W"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765935239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LOBi0mCLSN1pX4/fJ7qcbzGYmH1wlSSOqnzZMNKNsIA=;
	b=muu5nR/WUMVrFwX8qeW3SR6z+o4m8Pa+vdcQmNyqtJ34hvqnSl1YGJ7hOFnkNtKTwfazxN9nugwCdc8TDayzQhiGVu1pLPOd6FP2vSi1JByyj6iwhAQYuZlh+RwHjJMy1WvWo9Xes1NpVk966M51qKYMY9OOpc/Cf0CbScjTpyw=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wv1EBZW_1765935235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 09:33:56 +0800
Message-ID: <45d61f3c-b721-4e42-8aa6-5f252193d2b7@linux.alibaba.com>
Date: Wed, 17 Dec 2025 09:33:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 mm-new 07/16] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-8-npache@redhat.com>
 <95b1403f-3ddb-43ff-b481-2ecc6ab8352f@linux.alibaba.com>
 <CAA1CXcCtp2OwTmm-1EYUpOhsey1sv7CRFu8454m16C=k9iaN6g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcCtp2OwTmm-1EYUpOhsey1sv7CRFu8454m16C=k9iaN6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/17 07:26, Nico Pache wrote:
> On Tue, Dec 16, 2025 at 1:12 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Hi Nico,
> 
> Hi Baolin! Thanks for testing :)
> 
> Did you happen to test with the changes I asked Andrew to append to
> this commit?
> 
> Either way, I think your fixup makes more sense than mine.

Ah, I did not notice your fixup commit earlier, which seems to address 
this problem. And as I said, we don't need to call release_pte_pages() 
in this case.

>> On 2025/12/2 01:46, Nico Pache wrote:
>>> The current mechanism for determining mTHP collapse scales the
>>> khugepaged_max_ptes_none value based on the target order. This
>>> introduces an undesirable feedback loop, or "creep", when max_ptes_none
>>> is set to a value greater than HPAGE_PMD_NR / 2.
>>>
>>> With this configuration, a successful collapse to order N will populate
>>> enough pages to satisfy the collapse condition on order N+1 on the next
>>> scan. This leads to unnecessary work and memory churn.
>>>
>>> To fix this issue introduce a helper function that will limit mTHP
>>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
>>> This effectively supports two modes:
>>>
>>> - max_ptes_none=0: never introduce new none-pages for mTHP collapse.
>>> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>>>     available mTHP order.
>>>
>>> This removes the possiblilty of "creep", while not modifying any uAPI
>>> expectations. A warning will be emitted if any non-supported
>>> max_ptes_none value is configured with mTHP enabled.
>>>
>>> The limits can be ignored by passing full_scan=true, this is useful for
>>> madvise_collapse (which ignores limits), or in the case of
>>> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
>>> collapse is available.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 8dab49c53128..f425238d5d4f 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -463,6 +463,44 @@ void __khugepaged_enter(struct mm_struct *mm)
>>>                wake_up_interruptible(&khugepaged_wait);
>>>    }
>>>
>>> +/**
>>> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>>> + * @order: The folio order being collapsed to
>>> + * @full_scan: Whether this is a full scan (ignore limits)
>>> + *
>>> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
>>> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
>>> + *
>>> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
>>> + * khugepaged_max_ptes_none value.
>>> + *
>>> + * For mTHP collapses, we currently only support khugepaged_max_pte_none values
>>> + * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and no mTHP
>>> + * collapse will be attempted
>>> + *
>>> + * Return: Maximum number of empty PTEs allowed for the collapse operation
>>> + */
>>> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
>>> +{
>>> +     /* ignore max_ptes_none limits */
>>> +     if (full_scan)
>>> +             return HPAGE_PMD_NR - 1;
>>> +
>>> +     if (!is_mthp_order(order))
>>> +             return khugepaged_max_ptes_none;
>>> +
>>> +     /* Zero/non-present collapse disabled. */
>>> +     if (!khugepaged_max_ptes_none)
>>> +             return 0;
>>> +
>>> +     if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>>> +             return (1 << order) - 1;
>>> +
>>> +     pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %d\n",
>>> +                   HPAGE_PMD_NR - 1);
>>> +     return -EINVAL;
>>> +}
>>> +
>>>    void khugepaged_enter_vma(struct vm_area_struct *vma,
>>>                          vm_flags_t vm_flags)
>>>    {
>>> @@ -550,7 +588,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>        pte_t *_pte;
>>>        int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>>>        const unsigned long nr_pages = 1UL << order;
>>> -     int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>>> +     int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
>>> +
>>> +     if (max_ptes_none == -EINVAL)
>>> +             goto out;
>>
>> After testing your patchset, I hit the following crash. The reason is
>> that when 'max_ptes_none' is -EINVAL here, it shouldn't goto out to call
>> release_pte_pages(), because the '_pte' hasn't been initialized at this
>> point, and there's no need to release folios either.
>>
>> After applying the fix below, the crash issue is resolved. I'm not sure
>> whether Andrew will help fix this or if you will send a new version to
>> address this issue.
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 8cffaf59ced8..2e8171a6d7df 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -646,7 +646,7 @@ static int __collapse_huge_page_isolate(struct
>> vm_area_struct *vma,
>>           int max_ptes_none = collapse_max_ptes_none(order,
>> !cc->is_khugepaged);
>>
>>           if (max_ptes_none == -EINVAL)
>> -               goto out;
>> +               return result;
>>
>>           for (_pte = pte; _pte < pte + nr_pages;
>>                _pte++, addr += PAGE_SIZE) {
>>
>> "
>> [  565.319345] Unable to handle kernel paging request at virtual address
>> fffffffffffffffa
>> .......
>> [  565.319409] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000001f8549a000
>> [  565.319416] [fffffffffffffffa] pgd=0000001f85f2a403,
>> p4d=0000001f85f2a403, pud=0000001f85f2b403, pmd=0000000000000000
>> [  565.319427] Internal error: Oops: 0000000096000006 [#1]  SMP
>> .......
>> [  565.326733] pc : release_pte_pages+0x68/0x178
>> [  565.326960] lr : __collapse_huge_page_isolate+0xc0/0x748
>> [  565.327232] sp : ffff800083593910
>> .......
>> [  565.331476] Call trace:
>> [  565.331664]  release_pte_pages+0x68/0x178 (P)
>> [  565.331940]  __collapse_huge_page_isolate+0xc0/0x748
>> [  565.332249]  collapse_huge_page+0x4cc/0xa70
>> [  565.332510]  mthp_collapse+0x254/0x2a8
>> [  565.332754]  collapse_scan_pmd+0x5a0/0x6d8
>> [  565.333010]  collapse_single_pmd+0x214/0x288
>> [  565.333275]  collapse_scan_mm_slot.constprop.0+0x2ac/0x460
>> [  565.333617]  khugepaged+0x204/0x2c8
>> [  565.333992]  kthread+0xf8/0x110
>> [  565.334368]  ret_from_fork+0x10/0x20
>> "
>>
>>>
>>>        for (_pte = pte; _pte < pte + nr_pages;
>>>             _pte++, addr += PAGE_SIZE) {
>>

