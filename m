Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527B1F417A;
	Wed, 19 Feb 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982495; cv=none; b=FuH5wivKAXzTbW7yu4weoMxIcS1e4C6sFEj5RIzpQf9DAjw21xCP+dr2rzuieqyFRTmKwMRpMN/mBHZFBPUSAtiZFHuP+xrVoVYoA+r/EYoqvtL0BTIw2oKhoHfdXjr3CwEa4RczEZs6Ue+cMisBoZYxpZ4o1lZ1Ttr0OIsIWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982495; c=relaxed/simple;
	bh=03mjRazqH1+4mh4Osyw26ht/kETosjEXzyl6ncsS1lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drwKEICWBWWZmHFfHvc63eS5FYKFB7aGGGFWBTlHvYNOCh70ESGBpjH2lDeU/Lia9wkioSr2WvmHJPLkuPFKk5THizxPCA0QpFtGKplFsrQIsfglklq7qiNEjyRYV7ntR6q6GzMJ8lwpYwwoqf8tfXCMZJ/CxogtQd8rvsdonrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E23A31682;
	Wed, 19 Feb 2025 08:28:30 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 141003F6A8;
	Wed, 19 Feb 2025 08:28:05 -0800 (PST)
Message-ID: <45b898f2-c514-44d3-bbd9-523772c71b0b@arm.com>
Date: Wed, 19 Feb 2025 16:28:04 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 6/9] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-7-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-7-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> khugepaged scans PMD ranges for potential collapse to a hugepage. To add
> mTHP support we use this scan to instead record chunks of fully utilized
> sections of the PMD.
> 
> create a bitmap to represent a PMD in order MTHP_MIN_ORDER chunks.
> by default we will set this to order 3. The reasoning is that for 4K 512

I'm still a bit confused by this (hopefully to be resolved as I'm about to read
the code); Does this imply that the smallest order you can collapse to is order
3? Because that would be different from the fault handler. For anon memory we
can support order-2 and above. I believe that these days files can support order-1.

There is a case for wanting to support order-2 for arm64. We have a (not yet
well deployed) technology called Hardware Page Aggregation (HPA) which can
automatically (transparent to SW) aggregate (usually) 4 contiguous pages into a
single TLB. I'd like the solution to be compatible with that.

> PMD size this results in a 64 bit bitmap which has some optimizations.
> For other arches like ARM64 64K, we can set a larger order if needed.
> 
> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the PMD.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> If a order is set to "always" lets always collapse to that order in a
> greedy manner.

This is not the policy that the fault handler uses, and I think we should use
the same policy in both places.

The fault handler gets a list of orders that are permitted for the VMA, then
prefers the highest orders in that list.

I don't think we should be preferring a smaller "always" order over a larger
"madvise" order if MADV_HUGEPAGE is set for the VMA (if that's what your
statement was suggesting).

> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/khugepaged.h |  4 ++
>  mm/khugepaged.c            | 89 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 86 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 1f46046080f5..1fe0c4fc9d37 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
> +#define MIN_MTHP_ORDER	3
> +#define MIN_MTHP_NR	(1<<MIN_MTHP_ORDER)
> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE * PAGE_SIZE) - MIN_MTHP_ORDER))

I don't think you want "* PAGE_SIZE" here? I think MAX_MTHP_BITMAP_SIZE wants to
specify the maximum number of groups of MIN_MTHP_NR pte entries in a PTE table?

In that case, MAX_PTRS_PER_PTE will be 512 on x86_64. Your current formula will
give 262144 (which is 32KB!). I think you just need:

#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - MIN_MTHP_ORDER))

> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - MIN_MTHP_ORDER))

Perhaps all of these macros need a KHUGEPAGED_ prefix? Otherwise MIN_MTHP_ORDER,
especially, is misleading. The min MTHP order is not 3.

>  
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 3776055bd477..c8048d9ec7fb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>  
>  static struct kmem_cache *mm_slot_cache __ro_after_init;
>  
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>  struct collapse_control {
>  	bool is_khugepaged;
>  
> @@ -102,6 +107,15 @@ struct collapse_control {
>  
>  	/* nodemask for allocation fallback */
>  	nodemask_t alloc_nmask;
> +
> +	/* bitmap used to collapse mTHP sizes. 1bit = order MIN_MTHP_ORDER mTHP */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>  };
>  
>  /**
> @@ -851,10 +865,6 @@ static void khugepaged_alloc_sleep(void)
>  	remove_wait_queue(&khugepaged_wait, &wait);
>  }
>  
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>  static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>  {
>  	int i;
> @@ -1112,7 +1122,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  
>  static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)
>  {
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> @@ -1130,8 +1141,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * The allocation can take potentially a long time if it involves
>  	 * sync compaction, and we do not need to hold the mmap_lock during
>  	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>  	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>  
>  	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
> @@ -1266,12 +1281,71 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  out_up_write:
>  	mmap_write_unlock(mm);
>  out_nolock:
> +	*mmap_locked = false;
>  	if (folio)
>  		folio_put(folio);
>  	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>  	return result;
>  }
>  
> +// Recursive function to consume the bitmap
> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +			int referenced, int unmapped, struct collapse_control *cc,
> +			bool *mmap_locked, unsigned long enabled_orders)
> +{
> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1 << (state.order);
> +		// Skip mTHP orders that are not enabled
> +		if (!test_bit(order, &enabled_orders))
> +			goto next;
> +
> +		// copy the relavant section to a new bitmap
> +		bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
> +				  MTHP_BITMAP_SIZE);
> +
> +		bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
> +		threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
> +				>> (HPAGE_PMD_ORDER - state.order);
> +
> +		//Check if the region is "almost full" based on the threshold
> +		if (bits_set > threshold_bits
> +			|| test_bit(order, &huge_anon_orders_always)) {
> +			ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
> +					mmap_locked, order, offset * MIN_MTHP_NR);
> +			if (ret == SCAN_SUCCEED) {
> +				collapsed += (1 << order);
> +				continue;
> +			}
> +		}
> +
> +next:
> +		if (state.order > 0) {
> +			next_order = state.order - 1;
> +			mid_offset = offset + (num_chunks / 2);
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, mid_offset };
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, offset };
> +			}
> +	}
> +	return collapsed;
> +}

I'm struggling to understand the details of this function. I'll come back to it
when I have more time.

> +
>  static int khugepaged_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
> @@ -1440,7 +1514,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
>  		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc);
> +					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>  		/* collapse_huge_page will return with the mmap_lock released */
>  		*mmap_locked = false;

Given that collapse_huge_page() now takes mmap_locked and sets it to false on
return, I don't think we need this line here any longer?

>  	}
> @@ -2856,6 +2930,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	mmdrop(mm);
>  	kfree(cc);
>  
> +
>  	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
>  			: madvise_collapse_errno(last_fail);
>  }

