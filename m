Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACC2C2361;
	Wed,  3 Sep 2025 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870092; cv=none; b=t9tdcr72OeiqX5eIbuePUeDZLig8li0NntPMIT17RNW0CakNaSOc+HRXOI64rTTYFroi+L6mT/kyn3ohRele2lleLGKK6DWaHjousaK1qcblyOVfzcR7xUK7yCun4I+5SGYIKhavrtdQA9TtTBOmo25+gLS+TUGzvcPLthq2GQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870092; c=relaxed/simple;
	bh=pCpIF9yEFX5Z8afykzZoOGFp+1bCMBjIY/+LG1kCqCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7rlFGCFAjtu2yjUQya+B0M0VlRaMsOvhlvMDpYlBtNXZaIPzRYRUU7DurT50nKlmiVX0IvE6lhPaf5Iv7P7l6y/srn2CxFmZNE6Kfm2XPyngKl4+4/UryQymTk0UTjTloD4F45KhTlyyBLC6IUnFgf7YJLpcekva1yK3hcA58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xuArzmV2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xuArzmV2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756870080; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9pNvoK8E483FKVV4UiISiOQElVaIf1JmFvnG6QIAnXY=;
	b=xuArzmV2AVC72U47CcF3YgD2OzW8xVIiaJxEYKnVZVmFJWN+dCtLVThNfQtf8Z8QLUw+T8uISnbJmG0/h5WPiXkO1S1MTpbt+xO/GxzTg7MOMVW94fDoC/FvWW8BJMw+a+dt1EgJMRvGFGtZV4u9WPHMtiVUW1jniwJXP4zeprI=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnA-49f_1756870075 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 11:27:57 +0800
Message-ID: <9ccc6d6b-c077-4b8a-b8da-99cabf182e17@linux.alibaba.com>
Date: Wed, 3 Sep 2025 11:27:54 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Usama Arif <usamaarif642@gmail.com>, David Hildenbrand
 <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
 <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
 <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com>
 <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
 <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com>
 <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
 <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com>
 <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
 <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/3 04:23, Usama Arif wrote:
> 
> 
> On 02/09/2025 12:03, David Hildenbrand wrote:
>> On 02.09.25 12:34, Usama Arif wrote:
>>>
>>>
>>> On 02/09/2025 10:03, David Hildenbrand wrote:
>>>> On 02.09.25 04:28, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2025/9/2 00:46, David Hildenbrand wrote:
>>>>>> On 29.08.25 03:55, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025/8/28 18:48, Dev Jain wrote:
>>>>>>>>
>>>>>>>> On 28/08/25 3:16 pm, Baolin Wang wrote:
>>>>>>>>> (Sorry for chiming in late)
>>>>>>>>>
>>>>>>>>> On 2025/8/22 22:10, David Hildenbrand wrote:
>>>>>>>>>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1),
>>>>>>>>>>>> but not sure
>>>>>>>>>>>> if we have to add that for now.
>>>>>>>>>>>
>>>>>>>>>>> Yeah not so sure about this, this is a 'just have to know' too, and
>>>>>>>>>>> yes you
>>>>>>>>>>> might add it to the docs, but people are going to be mightily
>>>>>>>>>>> confused, esp if
>>>>>>>>>>> it's a calculated value.
>>>>>>>>>>>
>>>>>>>>>>> I don't see any other way around having a separate tunable if we
>>>>>>>>>>> don't just have
>>>>>>>>>>> something VERY simple like on/off.
>>>>>>>>>>
>>>>>>>>>> Yeah, not advocating that we add support for other values than 0/511,
>>>>>>>>>> really.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Also the mentioned issue sounds like something that needs to be
>>>>>>>>>>> fixed elsewhere
>>>>>>>>>>> honestly in the algorithm used to figure out mTHP ranges (I may be
>>>>>>>>>>> wrong - and
>>>>>>>>>>> happy to stand corrected if this is somehow inherent, but reallly
>>>>>>>>>>> feels that
>>>>>>>>>>> way).
>>>>>>>>>>
>>>>>>>>>> I think the creep is unavoidable for certain values.
>>>>>>>>>>
>>>>>>>>>> If you have the first two pages of a PMD area populated, and you
>>>>>>>>>> allow for at least half of the #PTEs to be non/zero, you'd collapse
>>>>>>>>>> first a
>>>>>>>>>> order-2 folio, then and order-3 ... until you reached PMD order.
>>>>>>>>>>
>>>>>>>>>> So for now we really should just support 0 / 511 to say "don't
>>>>>>>>>> collapse if there are holes" vs. "always collapse if there is at
>>>>>>>>>> least one pte used".
>>>>>>>>>
>>>>>>>>> If we only allow setting 0 or 511, as Nico mentioned before, "At 511,
>>>>>>>>> no mTHP collapses would ever occur anyway, unless you have 2MB
>>>>>>>>> disabled and other mTHP sizes enabled. Technically, at 511, only the
>>>>>>>>> highest enabled order would ever be collapsed."
>>>>>>>> I didn't understand this statement. At 511, mTHP collapses will occur if
>>>>>>>> khugepaged cannot get a PMD folio. Our goal is to collapse to the
>>>>>>>> highest order folio.
>>>>>>>
>>>>>>> Yes, I’m not saying that it’s incorrect behavior when set to 511. What I
>>>>>>> mean is, as in the example I gave below, users may only want to allow a
>>>>>>> large order collapse when the number of present PTEs reaches half of the
>>>>>>> large folio, in order to avoid RSS bloat.
>>>>>>
>>>>>> How do these users control allocation at fault time where this parameter
>>>>>> is completely ignored?
>>>>>
>>>>> Sorry, I did not get your point. Why does the 'max_pte_none' need to
>>>>> control allocation at fault time? Could you be more specific? Thanks.
>>>>
>>>> The comment over khugepaged_max_ptes_none gives a hint:
>>>>
>>>> /*
>>>>    * default collapse hugepages if there is at least one pte mapped like
>>>>    * it would have happened if the vma was large enough during page
>>>>    * fault.
>>>>    *
>>>>    * Note that these are only respected if collapse was initiated by khugepaged.
>>>>    */
>>>>
>>>> In the common case (for anything that really cares about RSS bloat) you will just a
>>>> get a THP during page fault and consequently RSS bloat.
>>>>
>>>> As raised in my other reply, the only documented reason to set max_ptes_none=0 seems
>>>> to be when an application later (after once possibly getting a THP already during
>>>> page faults) did some MADV_DONTNEED and wants to control the usage of THPs itself using
>>>> MADV_COLLAPSE.
>>>>
>>>> It's a questionable use case, that already got more problematic with mTHP and page
>>>> table reclaim.
>>>>
>>>> Let me explain:
>>>>
>>>> Before mTHP, if someone would MADV_DONTNEED (resulting in
>>>> a page table with at least one pte_none entry), there would have been no way we would
>>>> get memory over-allocated afterwards with max_ptes_none=0.
>>>>
>>>> (1) Page faults would spot "there is a page table" and just fallback to order-0 pages.
>>>> (2) khugepaged was told to not collapse through max_ptes_none=0.
>>>>
>>>> But now:
>>>>
>>>> (A) With mTHP during page-faults, we can just end up over-allocating memory in such
>>>>       an area again: page faults will simply spot a bunch of pte_nones around the fault area
>>>>       and install an mTHP.
>>>>
>>>> (B) With page table reclaim (when zapping all PTEs in a table at once), we will reclaim the
>>>>       page table. The next page fault will just try installing a PMD THP again, because there is
>>>>       no PTE table anymore.
>>>>
>>>> So I question the utility of max_ptes_none. If you can't tame page faults, then there is only
>>>> limited sense in taming khugepaged. I think there is vale in setting max_ptes_none=0 for some
>>>> corner cases, but I am yet to learn why max_ptes_none=123 would make any sense.

Thanks David for your explanation. I see your point now.

>>> For PMD mapped THPs with THP shrinker, this has changed. You can basically tame pagefaults, as when you encounter
>>> memory pressure, the shrinker kicks in if the value is less than HPAGE_PMD_NR -1 (i.e. 511 for x86), and
>>> will break down those hugepages and free up zero-filled memory.
>>
>> You are not really taming page faults, though, you are undoing what page faults might have messed up :)
>>
>> I have seen in our prod workloads where
>>> the memory usage and THP usage can spike (usually when the workload starts), but with memory pressure,
>>> the memory usage is lower compared to with max_ptes_none = 511, while still still keeping the benefits
>>> of THPs like lower TLB misses.
>>
>> Thanks for raising that: I think the current behavior is in place such that you don't bounce back-and-forth between khugepaged collapse and shrinker-split.
>>
> 
> Yes, both collapse and shrinker split hinge on max_ptes_none to prevent one of these things thrashing the effect of the other.
> 
>> There are likely other ways to achieve that, when we have in mind that the thp shrinker will install zero pages and max_ptes_none includes
>> zero pages.
>>
>>>
>>> I do agree that the value of max_ptes_none is magical and different workloads can react very differently
>>> to it. The relationship is definitely not linear. i.e. if I use max_ptes_none = 256, it does not mean
>>> that the memory regression of using THP=always vs THP=madvise is halved.
>>
>> To which value would you set it? Just 510? 0?
>>
> 
> There are some very large workloads in the meta fleet that I experimented with and found that having
> a small value works out. I experimented with 0, 51 (10%) and 256 (50%). 51 was found to be an optimal
> comprimise in terms of application metrics improving, having an acceptable amount of memory regression and
> improved system level metrics (lower TLB misses, lower page faults). I am sure there was a better value out
> there for these workloads, but not possible to experiment with every value.
> 
> In terms of wider rollout across the fleet, we are going to target 0 (or a very very small value)
> when moving from THP=madvise to always. Mainly because it is the least likely to cause a memory regression as
> THP shrinker will deal with page faults faulting in mostly zero-filled pages and khugepaged wont collapse
> pages that are dominated by 4K zero-filled chunks.

Thanks for sharing this. We're also investigating what max_ptes_none 
should be set to in order to use the THP shrinker properly, and 
currently, our customers always set max_ptes_none to its default value: 
511, which is not good.

If 0 is better, it seems like there isn't much conflict with the values 
expected by mTHP collapse (0 and 511). Sounds good to me.
