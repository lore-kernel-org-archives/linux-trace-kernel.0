Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E91C27;
	Thu, 15 May 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291519; cv=none; b=okubH6YqJ24X2DMreE6NFW5/Nyuv7PV/uiWjjliv398LBiCS2+Bu9x0DRT4myf74KTVHOln8nv6v6mqKQRXj2jWs34Bk25bQwBHY/KoP+PMM6AWGzrc65EmRM3rVzwkwOzX3MWt18d3PwekDgRk4tyLkwV88AXUPWMB/OkWCgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291519; c=relaxed/simple;
	bh=PBKzVFyzAbO+TDFDw+A93LfuGrvhUJ5Rqp80UVYFtwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5+6BYaKWRSpHeXI0EDTGNuZIjl7jyzYpnNJ8DBjFnWXKjFN4eUrCA1tph0Vrb3wxSEgzIEeUg6cics7u1SXNmNd/oWVrN/Nri8uf89K9KW/v+kNOjgpEKPieYWDaADPVHp70HYsgB6jEwmJ3PnKGqIc57PD0K22c+D5ZgweMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 469B512FC;
	Wed, 14 May 2025 23:45:03 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 593293F673;
	Wed, 14 May 2025 23:45:03 -0700 (PDT)
Message-ID: <55e5169b-2cba-47e0-8e16-ced29ad4d879@arm.com>
Date: Thu, 15 May 2025 12:15:00 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
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
 rdunlap@infradead.org
References: <20250515030312.125567-1-npache@redhat.com>
 <CAA1CXcAKk5z+gTrQDe-eLsxkrsNrf8G9HD5KBPTJv_EECei_Mg@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcAKk5z+gTrQDe-eLsxkrsNrf8G9HD5KBPTJv_EECei_Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/05/25 8:51 am, Nico Pache wrote:
> Ugh... So sorry, I forgot to turn off the chain-reply-to.
> 
> resending V7 *facepalm*

In the future you can just send the same version again with [RESEND] 
prefixed in the subject, that prevents confusion.

> 
> On Wed, May 14, 2025 at 9:03 PM Nico Pache <npache@redhat.com> wrote:
>>
>> The following series provides khugepaged and madvise collapse with the
>> capability to collapse anonymous memory regions to mTHPs.
>>
>> To achieve this we generalize the khugepaged functions to no longer depend
>> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
>> (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. This info is
>> tracked using a bitmap. After the PMD scan is done, we do binary recursion
>> on the bitmap to find the optimal mTHP sizes for the PMD range. The
>> restriction on max_ptes_none is removed during the scan, to make sure we
>> account for the whole PMD range. When no mTHP size is enabled, the legacy
>> behavior of khugepaged is maintained. max_ptes_none will be scaled by the
>> attempted collapse order to determine how full a THP must be to be
>> eligible. If a mTHP collapse is attempted, but contains swapped out, or
>> shared pages, we dont perform the collapse.
>>
>> With the default max_ptes_none=511, the code should keep its most of its
>> original behavior. To exercise mTHP collapse we need to set
>> max_ptes_none<=255. With max_ptes_none > HPAGE_PMD_NR/2 you will
>> experience collapse "creep" and constantly promote mTHPs to the next
>> available size. This is due the fact that it will introduce at least 2x
>> the number of pages, and on a future scan will satisfy that condition once
>> again.
>>
>> Patch 1:     Refactor/rename hpage_collapse
>> Patch 2:     Some refactoring to combine madvise_collapse and khugepaged
>> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
>> Patch 6-9:   The mTHP patches
>> Patch 10-11: Tracing/stats
>> Patch 12:    Documentation
>>
>> ---------
>>   Testing
>> ---------
>> - Built for x86_64, aarch64, ppc64le, and s390x
>> - selftests mm
>> - I created a test script that I used to push khugepaged to its limits
>>     while monitoring a number of stats and tracepoints. The code is
>>     available here[1] (Run in legacy mode for these changes and set mthp
>>     sizes to inherit)
>>     The summary from my testings was that there was no significant
>>     regression noticed through this test. In some cases my changes had
>>     better collapse latencies, and was able to scan more pages in the same
>>     amount of time/work, but for the most part the results were consistent.
>> - redis testing. I tested these changes along with my defer changes
>>    (see followup post for more details).
>> - some basic testing on 64k page size.
>> - lots of general use.
>>
>> V6 Changes:
>> - Dont release the anon_vma_lock early (like in the PMD case), as not all
>>    pages are isolated.
>> - Define the PTE as null to avoid a uninitilized condition
>> - minor nits and newline cleanup
>> - make sure to unmap and unlock the pte for the swapin case
>> - change the revalidation to always check the PMD order (as this will make
>>    sure that no other VMA spans it)
>>
>> V5 Changes [2]:
>> - switched the order of patches 1 and 2
>> - fixed some edge cases on the unified madvise_collapse and khugepaged
>> - Explained the "creep" some more in the docs
>> - fix EXCEED_SHARED vs EXCEED_SWAP accounting issue
>> - fix potential highmem issue caused by a early unmap of the PTE
>>
>> V4 Changes:
>> - Rebased onto mm-unstable
>> - small changes to Documentation
>>
>> V3 Changes:
>> - corrected legacy behavior for khugepaged and madvise_collapse
>> - added proper mTHP stat tracking
>> - Minor changes to prevent a nested lock on non-split-lock arches
>> - Took Devs version of alloc_charge_folio as it has the proper stats
>> - Skip cases were trying to collapse to a lower order would still fail
>> - Fixed cases were the bitmap was not being updated properly
>> - Moved Documentation update to this series instead of the defer set
>> - Minor bugs discovered during testing and review
>> - Minor "nit" cleanup
>>
>> V2 Changes:
>> - Minor bug fixes discovered during review and testing
>> - removed dynamic allocations for bitmaps, and made them stack based
>> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
>> - Updated trace events to include collapsing order info.
>> - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
>> - No longer require a chunk to be fully utilized before setting the bit.
>>     Use the same max_ptes_none scaling principle to achieve this.
>> - Skip mTHP collapse that requires swapin or shared handling. This helps
>>     prevent some of the "creep" that was discovered in v1.
>>
>> [1] - https://gitlab.com/npache/khugepaged_mthp_test
>> [2] - https://lore.kernel.org/all/20250428181218.85925-1-npache@redhat.com/
>>
>> Dev Jain (1):
>>    khugepaged: generalize alloc_charge_folio()
>>
>> Nico Pache (11):
>>    khugepaged: rename hpage_collapse_* to khugepaged_*
>>    introduce khugepaged_collapse_single_pmd to unify khugepaged and
>>      madvise_collapse
>>    khugepaged: generalize hugepage_vma_revalidate for mTHP support
>>    khugepaged: generalize __collapse_huge_page_* for mTHP support
>>    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
>>    khugepaged: add mTHP support
>>    khugepaged: skip collapsing mTHP to smaller orders
>>    khugepaged: avoid unnecessary mTHP collapse attempts
>>    khugepaged: improve tracepoints for mTHP orders
>>    khugepaged: add per-order mTHP khugepaged stats
>>    Documentation: mm: update the admin guide for mTHP collapse
>>
>>   Documentation/admin-guide/mm/transhuge.rst |  14 +-
>>   include/linux/huge_mm.h                    |   5 +
>>   include/linux/khugepaged.h                 |   4 +
>>   include/trace/events/huge_memory.h         |  34 +-
>>   mm/huge_memory.c                           |  11 +
>>   mm/khugepaged.c                            | 472 ++++++++++++++-------
>>   6 files changed, 382 insertions(+), 158 deletions(-)
>>
>> --
>> 2.49.0
>>
> 

