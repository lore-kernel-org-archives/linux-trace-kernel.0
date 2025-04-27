Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7F1BF58;
	Sun, 27 Apr 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745722330; cv=none; b=sL8z2FNrECTbxeZ8snJdCSsy5pse9ZNR2xydG6mDG6SFktYu5opVU2UEAiZFgucSzu8f6KGBhCqDt5AVHnY/iSP/+ZWW/y3xRqVpfmCyLrfmSmpimbH6M+xAYGtCwYEMe7Gt7cBe5WRZNe42G6V3VPX8aLadF/lmNAPeUjnvvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745722330; c=relaxed/simple;
	bh=VRzYfPOqmTOEx8IP2DEXI8W+F2Y3OcwWJjkhRpfFHCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YshxZrkVQSKc5KGzW3zQ3jZ2ms2FodRyaK8Fh70MGo5fdvLjh7/fdQ07OcfTHT5QtrVSlRpq+XxmcSOb35vDwpJAPgf3kfTEsMWanazmr29oBmvjaQ0rhsgt1pc1oWuhHi8QivFMHmttJ/amI9kQdAJ2TZS/1XWFjshJkI7qDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hU8ZYD1H; arc=none smtp.client-ip=47.90.199.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hU8ZYD1H"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745722307; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iEt3uhcsxnbov9JPbGYyEFMzZDrl62NJAHFLHUNnAIs=;
	b=hU8ZYD1HWaQj2QU3EhcPPuWe5F3jh7f2VBIpek1ZRPeyjTogj6B8yEdxDUDGp6nCBhxnvNh5vozu4wKPDDLKnfK/x6WWmN09qcJRpeSzbYIiUQTEcO7Brvza6kU8NbjDYAoh0Bx2LxVlhIZTR6hPG1aCv0JkAlWch8UToSy5600=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WY7FM4o_1745722302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 10:51:43 +0800
Message-ID: <5de38fe3-4a73-443b-87d1-0c836ffdbe30@linux.alibaba.com>
Date: Sun, 27 Apr 2025 10:51:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
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
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-7-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-7-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> khugepaged scans PMD ranges for potential collapse to a hugepage. To add
> mTHP support we use this scan to instead record chunks of utilized
> sections of the PMD.
> 
> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the PMD.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> When attempting to collapse an order that has its order set to "always"
> lets always collapse to that order in a greedy manner without
> considering the number of bits set.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   include/linux/khugepaged.h |  4 ++
>   mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 1f46046080f5..18fe6eb5051d 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef _LINUX_KHUGEPAGED_H
>   #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2

Why is the minimum mTHP order set to 2? IMO, the file large folios can 
support order 1, so we don't expect to collapse exec file small folios 
to order 1 if possible?

(PS: I need more time to understand your logic in this patch, and any 
additional explanation would be helpful:) )

> +#define KHUGEPAGED_MIN_MTHP_NR	(1<<KHUGEPAGED_MIN_MTHP_ORDER)
> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>   
>   extern unsigned int khugepaged_max_ptes_none __read_mostly;
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5e9272ab82da..83230e9cdf3a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
>   static struct kmem_cache *mm_slot_cache __ro_after_init;
>   
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>   struct collapse_control {
>   	bool is_khugepaged;
>   
> @@ -102,6 +107,18 @@ struct collapse_control {
>   
>   	/* nodemask for allocation fallback */
>   	nodemask_t alloc_nmask;
> +
> +	/*
> +	 * bitmap used to collapse mTHP sizes.
> +	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> +	 */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>   };
>   
>   /**
> @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
>   	remove_wait_queue(&khugepaged_wait, &wait);
>   }
>   
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>   static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>   {
>   	int i;
> @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>   
>   static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)
>   {
>   	LIST_HEAD(compound_pagelist);
>   	pmd_t *pmd, _pmd;
> @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * The allocation can take potentially a long time if it involves
>   	 * sync compaction, and we do not need to hold the mmap_lock during
>   	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>   	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>   
>   	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
> @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   out_up_write:
>   	mmap_write_unlock(mm);
>   out_nolock:
> +	*mmap_locked = false;
>   	if (folio)
>   		folio_put(folio);
>   	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>   	return result;
>   }
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
> +	bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
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
> +		if (bits_set > threshold_bits || is_pmd_only
> +			|| test_bit(order, &huge_anon_orders_always)) {
> +			ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
> +					mmap_locked, order, offset * KHUGEPAGED_MIN_MTHP_NR);
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
> +
>   static int khugepaged_scan_pmd(struct mm_struct *mm,
>   				   struct vm_area_struct *vma,
>   				   unsigned long address, bool *mmap_locked,
> @@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   	pte_unmap_unlock(pte, ptl);
>   	if (result == SCAN_SUCCEED) {
>   		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc);
> -		/* collapse_huge_page will return with the mmap_lock released */
> -		*mmap_locked = false;
> +					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>   	}
>   out:
>   	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
