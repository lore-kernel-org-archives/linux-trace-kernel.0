Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D318DB3A;
	Mon, 17 Feb 2025 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774366; cv=none; b=MvhFv4cOXTE13nwLGSWf0CxJ+EpTSjIMhavYMLthdxXAzFS2poH7JiANY/MjLn4gj/HjGF9ojWc42BtwMlKsD2IcQcpR9XITSIODKAUFPNblbOt8pDUPVFVbF1Vw0+kwpkUjNUwh+rEX9CbqiwCenPhuWRgw3Fn3LoQHA2MHae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774366; c=relaxed/simple;
	bh=1ygNsLOXbxIHY3FpCR4Lwf8Cf9fnupC7i0/rcObujDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eH9eorwlrdPy7GWCm9YozohrgGs65WXu9uSkwbognmwLhVcB4suPgwZPnB35yzDppfG4jQYkw8JuRG1whd1mJw0ivLtQGwMBdFxm/xs4PBh/AeMMjUE9R/RyYWkmDZT7oBlo/+TQpN0m4pXpbCNW59/udQusPR4rHIAq1oUUpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC90C1063;
	Sun, 16 Feb 2025 22:39:41 -0800 (PST)
Received: from [10.162.41.27] (K4MQJ0H1H2.blr.arm.com [10.162.41.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A0A3F59E;
	Sun, 16 Feb 2025 22:39:09 -0800 (PST)
Message-ID: <fae7019f-517f-4ad2-a5c2-2e839e5087ce@arm.com>
Date: Mon, 17 Feb 2025 12:09:06 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/9] khugepaged: mTHP support
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
 raquini@redhat.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250211003028.213461-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/02/25 6:00 am, Nico Pache wrote:
> The following series provides khugepaged and madvise collapse with the
> capability to collapse regions to mTHPs.
> 
> To achieve this we generalize the khugepaged functions to no longer depend
> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
> (defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
> using a bitmap. After the PMD scan is done, we do binary recursion on the
> bitmap to find the optimal mTHP sizes for the PMD range. The restriction
> on max_ptes_none is removed during the scan, to make sure we account for
> the whole PMD range. max_ptes_none will be scaled by the attempted collapse
> order to determine how full a THP must be to be eligible. If a mTHP collapse
> is attempted, but contains swapped out, or shared pages, we dont perform the
> collapse.
> 
> With the default max_ptes_none=511, the code should keep its most of its
> original behavior. To exercise mTHP collapse we need to set max_ptes_none<=255.
> With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep" and
> constantly promote mTHPs to the next available size.

How does creep stop when max_ptes_none <= 255?

> 
> Patch 1:     Some refactoring to combine madvise_collapse and khugepaged
> Patch 2:     Refactor/rename hpage_collapse
> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> Patch 6-9:   The mTHP patches
> 
> ---------
>   Testing
> ---------
> - Built for x86_64, aarch64, ppc64le, and s390x
> - selftests mm
> - I created a test script that I used to push khugepaged to its limits while
>     monitoring a number of stats and tracepoints. The code is available
>     here[1] (Run in legacy mode for these changes and set mthp sizes to inherit)
>     The summary from my testings was that there was no significant regression
>     noticed through this test. In some cases my changes had better collapse
>     latencies, and was able to scan more pages in the same amount of time/work,
>     but for the most part the results were consistant.
> - redis testing. I tested these changes along with my defer changes
>    (see followup post for more details).
> - some basic testing on 64k page size.
> - lots of general use. These changes have been running in my VM for some time.
> 
> Changes since V1 [2]:
> - Minor bug fixes discovered during review and testing
> - removed dynamic allocations for bitmaps, and made them stack based
> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> - Updated trace events to include collapsing order info.
> - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
> - No longer require a chunk to be fully utilized before setting the bit. Use
>     the same max_ptes_none scaling principle to achieve this.
> - Skip mTHP collapse that requires swapin or shared handling. This helps prevent
>     some of the "creep" that was discovered in v1.
> 
> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat.com/
> 
> Nico Pache (9):
>    introduce khugepaged_collapse_single_pmd to unify khugepaged and
>      madvise_collapse
>    khugepaged: rename hpage_collapse_* to khugepaged_*
>    khugepaged: generalize hugepage_vma_revalidate for mTHP support
>    khugepaged: generalize alloc_charge_folio for mTHP support
>    khugepaged: generalize __collapse_huge_page_* for mTHP support
>    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
>    khugepaged: add mTHP support
>    khugepaged: improve tracepoints for mTHP orders
>    khugepaged: skip collapsing mTHP to smaller orders
> 
>   include/linux/khugepaged.h         |   4 +
>   include/trace/events/huge_memory.h |  34 ++-
>   mm/khugepaged.c                    | 422 +++++++++++++++++++----------
>   3 files changed, 306 insertions(+), 154 deletions(-)
> 

