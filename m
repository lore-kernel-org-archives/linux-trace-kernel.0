Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAD1EB5FE;
	Sat, 19 Jul 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752900163; cv=none; b=P+rn3deeUuHyU2mwBXhaTfO6hZXkpfB6jrK8pL+IOJGFYFlnFkhNrMwPAa6a7h3lWtwFVCCmQCV4eUJjIrVmPf9oUKUWbrUGz1ZJvtg7nBkDKp9UVJ9KkoySQ/2nsPNDHiZAVXcD5PuFS7RWJ5ywtZqOVH1Y64em5aKdxd7fxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752900163; c=relaxed/simple;
	bh=CzC5pqPC3rj+q45u8C5JXJkj0iWnQUlos6IL4hbWoec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ4Ft3lVoJNqWbvAQ8yOVWutJYICQV5f4TmxdNzFWLGzldGAzjb4zIt0UL8E/7JigjkD5nzpyI6lP+KptlI+gWGZoOghxZ4C0oYIjjVjGySJBfSt66ix1JpqE3hbx2KAXxhg3Yu91YiF91AmagKACrZDpaXRRTQ5c/JWFEALkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pLFuCFuX; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pLFuCFuX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752900151; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9oej1REGPtmYzgvYFkCGpw3X1FEJMShlnggkh0bLJCE=;
	b=pLFuCFuXmHy4YcNT02/XWOYt4dEBc9Z8AZ2iXNl5aBff6L0Fc/cN/TmvH8HjAX2i8wU+/DR6BKKQuFOt7k+sKSCh0hdZOxRn9IEqW+eUyJ7+aaoMt9QbWhsbrVwajhfmS8ftK6uYBLVywLOo3U8v+5K7jlA2OdTPUv1tfuoQLW4=
Received: from 30.134.69.216(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjDoVlU_1752900146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 19 Jul 2025 12:42:27 +0800
Message-ID: <65b7519d-acff-4700-8bba-3c856f57a495@linux.alibaba.com>
Date: Sat, 19 Jul 2025 12:42:25 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/14] khugepaged: add per-order mTHP khugepaged stats
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
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
 <20250714003207.113275-14-npache@redhat.com>
 <94c8899a-f116-4b6a-94d3-f8295ee3f535@linux.alibaba.com>
 <CAA1CXcDQeiMjVhxVjnCvBuTQLSBQh0ea7FJXg52ebNFDHfXm1g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcDQeiMjVhxVjnCvBuTQLSBQh0ea7FJXg52ebNFDHfXm1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/19 05:00, Nico Pache wrote:
> On Thu, Jul 17, 2025 at 11:05 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/7/14 08:32, Nico Pache wrote:
>>> With mTHP support inplace, let add the per-order mTHP stats for
>>> exceeding NONE, SWAP, and SHARED.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    Documentation/admin-guide/mm/transhuge.rst | 17 +++++++++++++++++
>>>    include/linux/huge_mm.h                    |  3 +++
>>>    mm/huge_memory.c                           |  7 +++++++
>>>    mm/khugepaged.c                            | 15 ++++++++++++---
>>>    4 files changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index 2c523dce6bc7..28c8af61efba 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -658,6 +658,23 @@ nr_anon_partially_mapped
>>>           an anonymous THP as "partially mapped" and count it here, even though it
>>>           is not actually partially mapped anymore.
>>>
>>> +collapse_exceed_swap_pte
>>> +       The number of anonymous THP which contain at least one swap PTE.
>>> +       Currently khugepaged does not support collapsing mTHP regions that
>>> +       contain a swap PTE.
>>> +
>>> +collapse_exceed_none_pte
>>> +       The number of anonymous THP which have exceeded the none PTE threshold.
>>> +       With mTHP collapse, a bitmap is used to gather the state of a PMD region
>>> +       and is then recursively checked from largest to smallest order against
>>> +       the scaled max_ptes_none count. This counter indicates that the next
>>> +       enabled order will be checked.
>>> +
>>> +collapse_exceed_shared_pte
>>> +       The number of anonymous THP which contain at least one shared PTE.
>>> +       Currently khugepaged does not support collapsing mTHP regions that
>>> +       contain a shared PTE.
>>> +
>>>    As the system ages, allocating huge pages may be expensive as the
>>>    system uses memory compaction to copy data around memory to free a
>>>    huge page for use. There are some counters in ``/proc/vmstat`` to help
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 4042078e8cc9..e0a27f80f390 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -141,6 +141,9 @@ enum mthp_stat_item {
>>>        MTHP_STAT_SPLIT_DEFERRED,
>>>        MTHP_STAT_NR_ANON,
>>>        MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
>>> +     MTHP_STAT_COLLAPSE_EXCEED_SWAP,
>>> +     MTHP_STAT_COLLAPSE_EXCEED_NONE,
>>> +     MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>>>        __MTHP_STAT_COUNT
>>>    };
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index e2ed9493df77..57e5699cf638 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -632,6 +632,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>>    DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>>    DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>>>    DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
>>> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
>>> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
>>> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
>>> +
>>>
>>>    static struct attribute *anon_stats_attrs[] = {
>>>        &anon_fault_alloc_attr.attr,
>>> @@ -648,6 +652,9 @@ static struct attribute *anon_stats_attrs[] = {
>>>        &split_deferred_attr.attr,
>>>        &nr_anon_attr.attr,
>>>        &nr_anon_partially_mapped_attr.attr,
>>> +     &collapse_exceed_swap_pte_attr.attr,
>>> +     &collapse_exceed_none_pte_attr.attr,
>>> +     &collapse_exceed_shared_pte_attr.attr,
>>>        NULL,
>>>    };
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index d0c99b86b304..8a5873d0a23a 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -594,7 +594,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>                                continue;
>>>                        } else {
>>>                                result = SCAN_EXCEED_NONE_PTE;
>>> -                             count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>> +                             if (order == HPAGE_PMD_ORDER)
>>> +                                     count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>> +                             else
>>> +                                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
>>
>> Please follow the same logic as other mTHP statistics, meaning there is
>> no need to filter out PMD-sized orders, because mTHP also supports
>> PMD-sized orders. So logic should be:
>>
>> if (order == HPAGE_PMD_ORDER)
>>          count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>
>> count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> Good point-- I will fix that!
>>
>>>                                goto out;
>>>                        }
>>>                }
>>> @@ -623,8 +626,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>                /* See khugepaged_scan_pmd(). */
>>>                if (folio_maybe_mapped_shared(folio)) {
>>>                        ++shared;
>>> -                     if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
>>> -                         shared > khugepaged_max_ptes_shared)) {
>>> +                     if (order != HPAGE_PMD_ORDER) {
>>> +                             result = SCAN_EXCEED_SHARED_PTE;
>>> +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
>>> +                             goto out;
>>> +                     }
>>
>> Ditto.
> Thanks!
> 
> There is also the SWAP one, which is slightly different as it is
> calculated during the scan phase, and in the mTHP case in the swapin
> faulting code. Not sure if during the scan phase we should also
> increment the counter for the PMD order... or just leave it as a
> general vm_event counter since it's not attributed to an order during
> scan. I believe the latter is the correct approach and only attribute
> an order to it in the __collapse_huge_page_swapin function if its mTHP
> collapses.

Yes, that latter approach sounds reasonable to me.
