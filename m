Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E7F3AB276
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718507; cv=none; b=qS/9Ix8qTdLI7k2jrHzSYzHs0PxY746mFwG3pvXS2gTkKYJCTrzKC1v+HUeaMRV3SNgof9qqI+lyXriC35coQj2sxqWB7YKpDqvdUNgidDEJj8/ZA2tdtF2+KNvo9W929E9QxfKwGKaZHFdMLpu/mUfk9yH7pG9pKH/oSD35y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718507; c=relaxed/simple;
	bh=RasEgT2907MY2ZI59minn8SsyAMJCt3vXGiNWDZ8Xg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuwFt1mqEdA0696a5jAN7Ml6arVSj0aH3d7dgtapExFzHyt3Y+AIvLVULT1DoUUbKdTvmz1ONX8LnOYyIx0t+YMkVojImmgYU3A4uRXevpEUoP3g4rXCNoW8RMNpWmvgXCmdQQ0mHu79GRj4hEjSFBm60qZo4EFQ4P22p9UPAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zd4WLsk9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zd4WLsk9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779718504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itKpTuLYIUvP30cNjWVOPkjnvKVCYDW9rRvfBThd6oI=;
	b=Zd4WLsk9uBDH2eySIZ7eL6N/P+fh3q15ZnI1gw/AuOg95VebkLPl8asBl8d/NJELuN+GmD
	nMBW+fi7wlw2Na+0jWQ+CFBzN6G3i3UosGNleGDWIVTj8uYm/UXgUAF9fpKxk1oAWSsm85
	6q160ZKOD5w/E21NgZf/s2WIaP8zZYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-zRqmcf0YOU-blTiaNk7CQw-1; Mon, 25 May 2026 10:15:02 -0400
X-MC-Unique: zRqmcf0YOU-blTiaNk7CQw-1
X-Mimecast-MFC-AGG-ID: zRqmcf0YOU-blTiaNk7CQw_1779718501
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso6626670f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 07:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718501; x=1780323301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itKpTuLYIUvP30cNjWVOPkjnvKVCYDW9rRvfBThd6oI=;
        b=MiWce/2J0rQ1oBT5xhCcrwmCo8RlB8dn69ocNKvnYgYK1bKHvLRJ0q1vZ+TAQ5siPA
         gjZUw37BrUpzO8isyl4MX4iHMdlkVXP+qOjn+C4aUjt7cbhDlRMmoTg5lAJMCIa0KUTy
         b/2J09wHgXs1MXzvqlmvNkAkA58g9xUBtaN1kVIW61hDx0RYbaWWvEyQj6xAjFSysi6O
         6fePTiCbWlfJSg6CaAypHSwWkG6IQfRPk7CQKLJWu4uW24PlII2vVuq/HfJaHkWQPMqu
         00KFuAgMxLQhkGNA/sHqz8piSjbbBr0d4m2phQEi02Zd6eg2NdpvCOZ6MxLsH83inQGY
         rPcg==
X-Forwarded-Encrypted: i=1; AFNElJ/KM9JFmrKC5pliOzF6HIgeP1Nnq8km/DxD9fiMyzcfjoRq+SmXCXm5EQqEk9r6Mka0UJSJ91umqxG1E+HhAdJKJ7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZcWiiLauUzrJGbZTEibOHFGJRpl6pJfL9FYbd4c79V4ZQvwF
	1XcXkOtAARfhexzvYIPN/eYUSanHfgjmuWm19Yusz3G/TA1PzQY89ZGg0j3DbrOwd/Ahu7DpALS
	Q2CLWWo5Fqgk3F8zmY1/ea1luS2cXEefIxaE/hL0QQEj2PZkngtth9dSMU71rZEe7Yt7nul0Rwg
	==
X-Gm-Gg: Acq92OGvsrKXuhzQX7At2nuELIgvDTjVesLG+MHdFDJ1t8Y9w79y/8ODjxfXBrRv/bB
	OgvGZBAM+JltkPePYMgulYmdtqiewug7MHyk1nTbdTp05GfqGYm9kJL2SL4whA2IHluknGiqj5s
	E3cWFSlLm/eeGpHfE2U+rrpmpkM8bQYDB6IDQeMZrRMHubvrZYRNF8bhjhRexLMfN7Ql0UFHXoT
	E347HnpiaGjN2HojZEZRRTkzpX3y0CX042vCPAoCvzUWzjAyrS1cVyyTLxPgnDFFI5m3/ldLOhu
	WIwhHalH+knqJ/4gaLcMt30t6MuagXChfEktamQuIyldaI5MgVbtuvOBNKHF0z6NhsRxJ9rcpsh
	YKBo3xU9rHLe9+RTS1gYWglM=
X-Received: by 2002:a05:6000:1882:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-45eb3681134mr25369597f8f.12.1779718501179;
        Mon, 25 May 2026 07:15:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1882:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-45eb3681134mr25369452f8f.12.1779718500520;
        Mon, 25 May 2026 07:15:00 -0700 (PDT)
Received: from [192.168.1.144] ([88.147.84.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d48e23sm26489805f8f.20.2026.05.25.07.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 07:14:59 -0700 (PDT)
Message-ID: <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com>
Date: Mon, 25 May 2026 08:15:53 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Cc: aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260522150009.121603-12-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8iXs-9ykaSE1s3Rw1wtH9sugQQnx2MMMCReP6MeUMxM_1779718501
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/22/26 9:00 AM, Nico Pache wrote:
> Enable khugepaged to collapse to mTHP orders. This patch implements the
> main scanning logic using a bitmap to track occupied pages and a stack
> structure that allows us to find optimal collapse sizes.
>
> Previous to this patch, PMD collapse had 3 main phases, a light weight
> scanning phase (mmap_read_lock) that determines a potential PMD
> collapse, an alloc phase (mmap unlocked), then finally heavier collapse
> phase (mmap_write_lock).
>
> To enabled mTHP collapse we make the following changes:
>
> During PMD scan phase, track occupied pages in a bitmap. When mTHP
> orders are enabled, we remove the restriction of max_ptes_none during the
> scan phase to avoid missing potential mTHP collapse candidates. Once we
> have scanned the full PMD range and updated the bitmap to track occupied
> pages, we use the bitmap to find the optimal mTHP size.
>
> Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
> and determine the best eligible order for the collapse. A stack structure
> is used instead of traditional recursion to manage the search. This also
> prevents a traditional recursive approach when the kernel stack struct is
> limited. The algorithm recursively splits the bitmap into smaller chunks to
> find the highest order mTHPs that satisfy the collapse criteria. We start
> by attempting the PMD order, then moved on the consecutively lower orders
> (mTHP collapse). The stack maintains a pair of variables (offset, order),
> indicating the number of PTEs from the start of the PMD, and the order of
> the potential collapse candidate.
>
> The algorithm for consuming the bitmap works as such:
>      1) push (0, HPAGE_PMD_ORDER) onto the stack
>      2) pop the stack
>      3) check if the number of set bits in that (offset,order) pair
>         statisfy the max_ptes_none threshold for that order
>      4) if yes, attempt collapse
>      5) if no (or collapse fails), push two new stack items representing
>         the left and right halves of the current bitmap range, at the
>         next lower order
>      6) repeat at step (2) until stack is empty.
>
> Below is a diagram representing the algorithm and stack items:
>
>                              offset   mid_offset
>                              |        |
>                              |        |
>                              v        v
>            ____________________________________
>           |          PTE Page Table            |
>           --------------------------------------
> 			    <-------><------->
>                               order-1  order-1
>
> mTHP collapses reject regions containing swapped out or shared pages.
> This is because adding new entries can lead to new none pages, and these
> may lead to constant promotion into a higher order mTHP. A similar
> issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> introducing at least 2x the number of pages, and on a future scan will
> satisfy the promotion condition once again. This issue is prevented via
> the collapse_max_ptes_none() function which imposes the max_ptes_none
> restrictions above.
>
> We currently only support mTHP collapse for max_ptes_none values of 0
> and HPAGE_PMD_NR - 1. resulting in the following behavior:
>
>      - max_ptes_none=0: Never introduce new empty pages during collapse
>      - max_ptes_none=HPAGE_PMD_NR-1: Always try collapse to the highest
>        available mTHP order
>
> Any other max_ptes_none value will emit a warning and default mTHP
> collapse to max_ptes_none=0. There should be no behavior change for PMD
> collapse.
>
> Once we determine what mTHP sizes fits best in that PMD range a collapse
> is attempted. A minimum collapse order of 2 is used as this is the lowest
> order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
>
> Currently madv_collapse is not supported and will only attempt PMD
> collapse.
>
> We can also remove the check for is_khugepaged inside the PMD scan as
> the collapse_max_ptes_none() function handles this logic now.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 181 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 172 insertions(+), 9 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 64ceebc9d8a7..d3d7db8be26c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -99,6 +99,30 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
>   static struct kmem_cache *mm_slot_cache __ro_after_init;
>   
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
> +/*
> + * mthp_collapse() does an iterative DFS over a binary tree, from
> + * HPAGE_PMD_ORDER down to KHUGEPAGED_MIN_MTHP_ORDER. The max stack
> + * size needed for a DFS on a binary tree is height + 1, where
> + * height = HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER.
> + *
> + * ilog2 is used in place of HPAGE_PMD_ORDER because some architectures
> + * (e.g. ppc64le) do not define HPAGE_PMD_ORDER until after build time.
> + */
> +#define MTHP_STACK_SIZE	(ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER + 1)
> +
> +/*
> + * Defines a range of PTE entries in a PTE page table which are being
> + * considered for mTHP collapse.
> + *
> + * @offset: the offset of the first PTE entry in a PMD range.
> + * @order: the order of the PTE entries being considered for collapse.
> + */
> +struct mthp_range {
> +	u16 offset;
> +	u8 order;
> +};
> +
>   struct collapse_control {
>   	bool is_khugepaged;
>   
> @@ -110,6 +134,12 @@ struct collapse_control {
>   
>   	/* nodemask for allocation fallback */
>   	nodemask_t alloc_nmask;
> +
> +	/* Each bit represents a single occupied (!none/zero) page. */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_PTRS_PER_PTE);
> +	/* A mask of the current range being considered for mTHP collapse. */
> +	DECLARE_BITMAP(mthp_bitmap_mask, MAX_PTRS_PER_PTE);
> +	struct mthp_range mthp_bitmap_stack[MTHP_STACK_SIZE];
>   };
>   
>   /**
> @@ -1411,20 +1441,137 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>   	return result;
>   }
>   
> +static void collapse_mthp_stack_push(struct collapse_control *cc, int *stack_size,
> +				     u16 offset, u8 order)
> +{
> +	const int size = *stack_size;
> +	struct mthp_range *stack = &cc->mthp_bitmap_stack[size];
> +
> +	VM_WARN_ON_ONCE(size >= MTHP_STACK_SIZE);
> +	stack->order = order;
> +	stack->offset = offset;
> +	(*stack_size)++;
> +}
> +
> +static struct mthp_range collapse_mthp_stack_pop(struct collapse_control *cc,
> +						 int *stack_size)
> +{
> +	const int size = *stack_size;
> +
> +	VM_WARN_ON_ONCE(size <= 0);
> +	(*stack_size)--;
> +	return cc->mthp_bitmap_stack[size - 1];
> +}
> +
> +static unsigned int collapse_mthp_count_present(struct collapse_control *cc,
> +						u16 offset, unsigned int nr_ptes)
> +{
> +	bitmap_zero(cc->mthp_bitmap_mask, MAX_PTRS_PER_PTE);
> +	bitmap_set(cc->mthp_bitmap_mask, offset, nr_ptes);
> +	return bitmap_weight_and(cc->mthp_bitmap, cc->mthp_bitmap_mask, MAX_PTRS_PER_PTE);
> +}
> +
> +/*
> + * mthp_collapse() consumes the bitmap that is generated during
> + * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
> + *
> + * Each bit in cc->mthp_bitmap represents a single occupied (!none/zero) page.
> + * A stack structure cc->mthp_bitmap_stack is used to check different regions
> + * of the bitmap for collapse eligibility. The stack maintains a pair of
> + * variables (offset, order), indicating the number of PTEs from the start of
> + * the PMD, and the order of the potential collapse candidate respectively. We
> + * start at the PMD order and check if it is eligible for collapse; if not, we
> + * add two entries to the stack at a lower order to represent the left and right
> + * halves of the PTE page table we are examining.
> + *
> + *                         offset       mid_offset
> + *                         |         |
> + *                         |         |
> + *                         v         v
> + *      --------------------------------------
> + *      |          cc->mthp_bitmap            |
> + *      --------------------------------------
> + *                         <-------><------->
> + *                          order-1  order-1
> + *
> + * For each of these, we determine how many PTE entries are occupied in the
> + * range of PTE entries we propose to collapse, then we compare this to a
> + * threshold number of PTE entries which would need to be occupied for a
> + * collapse to be permitted at that order (accounting for max_ptes_none).
> + *
> + * If a collapse is permitted, we attempt to collapse the PTE range into a
> + * mTHP.
> + */
> +static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
> +		unsigned long address, int referenced, int unmapped,
> +		struct collapse_control *cc, unsigned long enabled_orders)
> +{
> +	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> +	int collapsed = 0, stack_size = 0;
> +	unsigned long collapse_address;
> +	struct mthp_range range;
> +	u16 offset;
> +	u8 order;
> +
> +	collapse_mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
> +
> +	while (stack_size) {
> +		range = collapse_mthp_stack_pop(cc, &stack_size);
> +		order = range.order;
> +		offset = range.offset;
> +		nr_ptes = 1UL << order;
> +
> +		if (!test_bit(order, &enabled_orders))
> +			goto next_order;
> +
> +		max_ptes_none = collapse_max_ptes_none(cc, vma, order);
> +
> +		nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
> +							       nr_ptes);
> +
> +		if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {
> +			int ret;
> +
> +			collapse_address = address + offset * PAGE_SIZE;
> +			ret = collapse_huge_page(mm, collapse_address, referenced,
> +						 unmapped, cc, order);
> +			if (ret == SCAN_SUCCEED) {
> +				collapsed += nr_ptes;
> +				continue;
> +			}
> +		}
> +
> +next_order:
> +		if ((BIT(order) - 1) & enabled_orders) {
> +			const u8 next_order = order - 1;
> +			const u16 mid_offset = offset + (nr_ptes / 2);
> +
> +			collapse_mthp_stack_push(cc, &stack_size, mid_offset,
> +						 next_order);
> +			collapse_mthp_stack_push(cc, &stack_size, offset,
> +						 next_order);
> +		}
> +	}
> +	return collapsed;
> +}

Hi Andrew,

Can you please append the following fixup that reverts one of the

changes requested in V17. The issue with the change is described

below.


commit 1e099144dfcdd28e3b3b50b32535798db53866aa
Author: Nico Pache <npache@redhat.com>
Date:   Mon May 25 07:38:59 2026 -0600

     fixup: fix potential use-after-free of vma in mthp_collapse()

     Between V17 and v18, one reviewer (Wei) brought up that we are not 
doing
     the uffd-armed check until deep in the collapse operation. While not
     functionally incorrect, it can lead to unnecessary work.

     We optimized this by passing the vma variable to mthp_collapse() 
and using
     the collapse_max_ptes_none() function to check the state of uffd-armed
     preventing the wasted work later in the collapse.

     mthp_collapse() is called after mmap_read_unlock(), so the vma pointer
     can become stale. Remove the vma parameter and pass NULL to
     collapse_max_ptes_none() instead.

     Signed-off-by: Nico Pache <npache@redhat.com>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d3d7db8be26c..a901db5c9201 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1502,9 +1502,9 @@ static unsigned int 
collapse_mthp_count_present(struct collapse_control *cc,
   * If a collapse is permitted, we attempt to collapse the PTE range into a
   * mTHP.
   */
-static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
-        unsigned long address, int referenced, int unmapped,
-        struct collapse_control *cc, unsigned long enabled_orders)
+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
+        int referenced, int unmapped, struct collapse_control *cc,
+        unsigned long enabled_orders)
  {
      unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
      int collapsed = 0, stack_size = 0;
@@ -1524,7 +1524,7 @@ static int mthp_collapse(struct mm_struct *mm, 
struct vm_area_struct *vma,
          if (!test_bit(order, &enabled_orders))
              goto next_order;

-        max_ptes_none = collapse_max_ptes_none(cc, vma, order);
+        max_ptes_none = collapse_max_ptes_none(cc, NULL, order);

          nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
                                     nr_ptes);
@@ -1749,7 +1749,7 @@ static enum scan_result collapse_scan_pmd(struct 
mm_struct *mm,
      if (result == SCAN_SUCCEED) {
          /* collapse_huge_page expects the lock to be dropped before 
calling */
          mmap_read_unlock(mm);
-        nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
+        nr_collapsed = mthp_collapse(mm, start_addr, referenced,
                           unmapped, cc, enabled_orders);
          /* mmap_lock was released above, set lock_dropped */
          *lock_dropped = true;


> +
>   static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>   		struct vm_area_struct *vma, unsigned long start_addr,
>   		bool *lock_dropped, struct collapse_control *cc)
>   {
> -	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
>   	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
>   	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
> +	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
> +	enum tva_type tva_flags = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
>   	pmd_t *pmd;
> -	pte_t *pte, *_pte;
> -	int none_or_zero = 0, shared = 0, referenced = 0;
> +	pte_t *pte, *_pte, pteval;
> +	int i;
> +	int none_or_zero = 0, shared = 0, nr_collapsed = 0, referenced = 0;
>   	enum scan_result result = SCAN_FAIL;
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	unsigned long addr;
> +	unsigned long enabled_orders;
>   	spinlock_t *ptl;
>   	int node = NUMA_NO_NODE, unmapped = 0;
>   
> @@ -1436,8 +1583,19 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>   		goto out;
>   	}
>   
> +	bitmap_zero(cc->mthp_bitmap, MAX_PTRS_PER_PTE);
>   	memset(cc->node_load, 0, sizeof(cc->node_load));
>   	nodes_clear(cc->alloc_nmask);
> +
> +	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, tva_flags);
> +
> +	/*
> +	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
> +	 * scan all pages to populate the bitmap for mTHP collapse.
> +	 */
> +	if (enabled_orders != BIT(HPAGE_PMD_ORDER))
> +		max_ptes_none = KHUGEPAGED_MAX_PTES_LIMIT;
> +
>   	pte = pte_offset_map_lock(mm, pmd, start_addr, &ptl);
>   	if (!pte) {
>   		cc->progress++;
> @@ -1445,11 +1603,13 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>   		goto out;
>   	}
>   
> -	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> -	     _pte++, addr += PAGE_SIZE) {
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +		_pte = pte + i;
> +		addr = start_addr + i * PAGE_SIZE;
> +		pteval = ptep_get(_pte);
> +
>   		cc->progress++;
>   
> -		pte_t pteval = ptep_get(_pte);
>   		if (pte_none_or_zero(pteval)) {
>   			if (++none_or_zero > max_ptes_none) {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -1529,6 +1689,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>   			}
>   		}
>   
> +		/* Set bit for occupied pages */
> +		__set_bit(i, cc->mthp_bitmap);
>   		/*
>   		 * Record which node the original page is from and save this
>   		 * information to cc->node_load[].
> @@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>   	if (result == SCAN_SUCCEED) {
>   		/* collapse_huge_page expects the lock to be dropped before calling */
>   		mmap_read_unlock(mm);
> -		result = collapse_huge_page(mm, start_addr, referenced,
> -					    unmapped, cc, HPAGE_PMD_ORDER);
> -		/* collapse_huge_page will return with the mmap_lock released */
> +		nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
> +					     unmapped, cc, enabled_orders);
> +		/* mmap_lock was released above, set lock_dropped */
>   		*lock_dropped = true;
> +		result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
>   	}
>   out:
>   	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,

