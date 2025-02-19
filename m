Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07CE1E0DCC;
	Wed, 19 Feb 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955688; cv=none; b=oK2e+S62CfMCHnMiDaZYMPl+3Ds40uawqOfj3a9KRzliie0djhPINmxftSXhl5l1kCNVMhhPxbl/JZndFL28X8KIIaTIUV3nv0AtJrDP5lN2m1Yxy/AiXeSEOjDzgRK2ee462YT4epK8QDnN56SASjUuBmeqbPItDrkYstjDgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955688; c=relaxed/simple;
	bh=4ZF+IDR/YcxslvffVCQ3La/45BRp6O51IZvH5X4zpjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8/jirn24cwBAcR/NNc524IcmWm7fy3E22IUm9Alp/REXSRQhO2HmDPO/0O6q1jRLTr5OQzeT6iB2m9eZgnV9jb77I2KNJz5COjqrdbshChN/MkEzbEyI6p4jYFuGSRtjzNQAKN9X1RWgXG0KbsLodWWEpxMApcsYIvMp2dvjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE981682;
	Wed, 19 Feb 2025 01:01:43 -0800 (PST)
Received: from [10.162.42.15] (K4MQJ0H1H2.blr.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB183F5A1;
	Wed, 19 Feb 2025 01:01:12 -0800 (PST)
Message-ID: <867280bf-2ba1-4e83-8e16-9d93e1c41e08@arm.com>
Date: Wed, 19 Feb 2025 14:31:09 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/9] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <8a37f99b-f207-4688-bc90-7f8e6900e29d@arm.com>
 <CAA1CXcDHCesahmZs21rVP=xai9C=-TpK_7=_8DMqxGJRJzyKSA@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcDHCesahmZs21rVP=xai9C=-TpK_7=_8DMqxGJRJzyKSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/02/25 4:00 am, Nico Pache wrote:
> On Tue, Feb 18, 2025 at 9:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 11/02/2025 00:30, Nico Pache wrote:
>>> The following series provides khugepaged and madvise collapse with the
>>> capability to collapse regions to mTHPs.
>>>
>>> To achieve this we generalize the khugepaged functions to no longer depend
>>> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
>>> (defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
>>> using a bitmap. After the PMD scan is done, we do binary recursion on the
>>> bitmap to find the optimal mTHP sizes for the PMD range. The restriction
>>> on max_ptes_none is removed during the scan, to make sure we account for
>>> the whole PMD range. max_ptes_none will be scaled by the attempted collapse
>>> order to determine how full a THP must be to be eligible. If a mTHP collapse
>>> is attempted, but contains swapped out, or shared pages, we dont perform the
>>> collapse.
>>>
>>> With the default max_ptes_none=511, the code should keep its most of its
>>> original behavior. To exercise mTHP collapse we need to set max_ptes_none<=255.
>>> With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep" and
>>
>> nit: I think you mean "max_ptes_none >= HPAGE_PMD_NR/2" (greater or *equal*)?
>> This is making my head hurt, but I *think* I agree with you that if
>> max_ptes_none is less than half of the number of ptes in a pmd, then creep
>> doesn't happen.
> Haha yea the compressed bitmap does not make the math super easy to
> follow, but i'm glad we arrived at the same conclusion :)
>>
>> To make sure I've understood;
>>
>>   - to collapse to 16K, you would need >=3 out of 4 PTEs to be present
>>   - to collapse to 32K, you would need >=5 out of 8 PTEs to be present
>>   - to collapse to 64K, you would need >=9 out of 16 PTEs to be present
>>   - ...
>>
>> So if we start with 3 present PTEs in a 16K area, we collapse to 16K and now
>> have 4 PTEs in a 32K area which is insufficient to collapse to 32K.
>>
>> Sounds good to me!
> Great! Another easy way to think about it is, with max_ptes_none =
> HPAGE_PMD_NR/2, a collapse will double the size, and we only need half
> for it to collapse again. Each size is 2x the last, so if we hit one
> collapse, it will be eligible again next round.

Please someone correct me if I am wrong.

Consider this; you are collapsing a 256K folio. => #PTEs = 256K/4K = 64 
=> #chunks = 64 / 8 = 8.

Let the PTE state within the chunks be as follows:

Chunk 0: < 5 filled   Chunk 1: 5 filled   Chunk 2: 5 filled   Chunk 3: 5 
filled

Chunk 4: 5 filled   Chunk 5: < 5 filled   Chunk 6: < 5 filled   Chunk 7: 
< 5 filled

Consider max_ptes_none = 40% (512 * 40 / 100 = 204.8 (round down) = 204 
< HPAGE_PMD_NR/2).
=> To collapse we need at least 60% of the PTEs filled.

Your algorithm marks chunks in the bitmap if 60% of the chunk is filled. 
Then, if the number of chunks set is greater than 60%, then we will 
collapse.

Chunk 0 will be marked zero because less than 5 PTEs are filled => 
percentage filled <= 50%

Right now the state is
0111 1000
where the indices are the chunk numbers.
Since #1s = 4 => percent filled = 4/8 * 100 = 50%, 256K folio collapse 
won't happen.

For the first 4 chunks, the percent filled is 75%.  So the state becomes
1111 1000
after 128K collapse, and now 256K collapse will happen.

Either I got this correct, or I do not understand the utility of 
maintaining chunks :) What you are doing is what I am doing except that 
my chunk size = 1.

>>
>>> constantly promote mTHPs to the next available size.
>>>
>>> Patch 1:     Some refactoring to combine madvise_collapse and khugepaged
>>> Patch 2:     Refactor/rename hpage_collapse
>>> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
>>> Patch 6-9:   The mTHP patches
>>>
>>> ---------
>>>   Testing
>>> ---------
>>> - Built for x86_64, aarch64, ppc64le, and s390x
>>> - selftests mm
>>> - I created a test script that I used to push khugepaged to its limits while
>>>     monitoring a number of stats and tracepoints. The code is available
>>>     here[1] (Run in legacy mode for these changes and set mthp sizes to inherit)
>>>     The summary from my testings was that there was no significant regression
>>>     noticed through this test. In some cases my changes had better collapse
>>>     latencies, and was able to scan more pages in the same amount of time/work,
>>>     but for the most part the results were consistant.
>>> - redis testing. I tested these changes along with my defer changes
>>>    (see followup post for more details).
>>> - some basic testing on 64k page size.
>>> - lots of general use. These changes have been running in my VM for some time.
>>>
>>> Changes since V1 [2]:
>>> - Minor bug fixes discovered during review and testing
>>> - removed dynamic allocations for bitmaps, and made them stack based
>>> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
>>> - Updated trace events to include collapsing order info.
>>> - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
>>> - No longer require a chunk to be fully utilized before setting the bit. Use
>>>     the same max_ptes_none scaling principle to achieve this.
>>> - Skip mTHP collapse that requires swapin or shared handling. This helps prevent
>>>     some of the "creep" that was discovered in v1.
>>>
>>> [1] - https://gitlab.com/npache/khugepaged_mthp_test
>>> [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat.com/
>>>
>>> Nico Pache (9):
>>>    introduce khugepaged_collapse_single_pmd to unify khugepaged and
>>>      madvise_collapse
>>>    khugepaged: rename hpage_collapse_* to khugepaged_*
>>>    khugepaged: generalize hugepage_vma_revalidate for mTHP support
>>>    khugepaged: generalize alloc_charge_folio for mTHP support
>>>    khugepaged: generalize __collapse_huge_page_* for mTHP support
>>>    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
>>>    khugepaged: add mTHP support
>>>    khugepaged: improve tracepoints for mTHP orders
>>>    khugepaged: skip collapsing mTHP to smaller orders
>>>
>>>   include/linux/khugepaged.h         |   4 +
>>>   include/trace/events/huge_memory.h |  34 ++-
>>>   mm/khugepaged.c                    | 422 +++++++++++++++++++----------
>>>   3 files changed, 306 insertions(+), 154 deletions(-)
>>>
>>
> 
> 

