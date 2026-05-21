Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92C385D77
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373931; cv=none; b=Y9c4JJZMmXJuZcSmYsllNsiN0Kh8stpyTJQekKQ6aIt/+jZnm0rBrtR6Anu4R6DHM+O9b44XA8XikZa30PxohDNZOj5QzpJx54g6P/G3S3hQc1DINz/7xka6s+Bzu7b8M1mfi/G5rwPjHtT5EvD5pd/lzLonoA4vko6oVg42LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373931; c=relaxed/simple;
	bh=qqTHGNtAdJR6njNYFhcijhMPmNlbbK5byJxwoM/mP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXV61CThWcMX1NvvP6nmIlQcm2WRX643n/bjLQaDQ9T3NNZve6xI9hPXBbSH5/y86MkzbLGuieJ3vCxzog+oH9dkQqmSt8/40hlAc6V2jfc5ia/oFuZP6kfqzj2EW+fU4SJaNT61kC6rQeFxENKEGQ7RWG1f7rLABs6o7u8ODKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJSbNGAN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJSbNGAN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so1138402766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373928; x=1779978728; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0vl66cywBbtX7Nq9bJ38nsMuWAs11zIu+JbOH0/xPI=;
        b=YJSbNGANq8A5SehrxYtcacjggiUSkjF998uH0uVoQK7chOHT34yaHzxZgO3GPBOosf
         xBFtbT9Rsr0jx2UfaFDU5G5hFdoZWIntq00PbSjo37s5QOnCZnsRcBVwwZs8lKoVy8VJ
         vHO/UzmFL/UO0yUWWEqAHvxd1iKnh0EFcNvZimL9Mzh1OrXXFefbzCicAbMrIFgM+a7Q
         mPl2Ppx0Fjwa9k2TouTREpQTJPNp7urOOjQnnlcAUZWym5aspVO07Ru6egVZnKlDeqT2
         dmEFNYOqnUgN71SemdFH9e6t30hbgygXr5oPVm8h/jxhPulZ6sAjCwLS4jkfYDVtl+WB
         5jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373928; x=1779978728;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0vl66cywBbtX7Nq9bJ38nsMuWAs11zIu+JbOH0/xPI=;
        b=cJZNmAMl0HVL+ookGYVV5+rFB1OU2ogeQkXNR6/2IxE+dnOFk2L+7X9u1jTMdDzKrX
         hy/CqGfPwBDEQJFBtf8ZJ3njNcyWiSnVTbuh1sWX99w0vHhu8WYo4zzjZAAPXxNXMm4I
         D+KhTxMf9722feR46ZgAbjWP5HltEpQ32MuSYln+7lrmyMJrg4XPHwJdoVVH2N/BlWQz
         lm04LZQh6MawLwLOrx8c61+2WwCnaCPhbjpzA/LkTzF8CCme5BU34lIh/GsDt/IE/TWL
         hnT/4xdzpLnyW2QeGNsU+RDcMqcstKahf7zpzHsfPN382ntKJzF+XEC9gOsaLfdVlGoK
         MISw==
X-Forwarded-Encrypted: i=1; AFNElJ8dhC0Nk+WA6sKJ8wuAV8PbRxPDPv6F9u20nqaL7+9TS7FhIZnOjQLSRvXYneT+nbGWaqpTqh/O655wmHbNDRnXpJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+93H48u0M1nILTgXZYerg4n7mKdP+vNIoBHD4akLNEs0FeR/X
	f185ojHJp8DO6zrmNhD2jAueIKKdlQ1s2ICfKSujcj77jrzMl2lt64n2
X-Gm-Gg: Acq92OGXsPhxePAUSQxn1OyCLeaHakAIxcbxS6ls/foh9wVohFqqUdZrQHTbg1yJWOp
	dLswsE/Xqt2AHP+KQ+byBRC2aGjpshYtrHKZ7qWwt50GU1hIFjZ+Rr0rII5LTxIYZ6BOgqCf0hi
	3sndp/u/TW51+uNCZvS7Sx27ZFH3L1abMj/5UJljGA7U2ZopYqYPZnOc5G42Hay0+onJVlwokvN
	rNHEqNnHZJMLMkTnl6ZMKdO7t9WLP7a7rBqDONXvahC7IGn1/gu3RNzKjtuHcehTz1BIikLMeRU
	eQqOvlDVC3MphKyb4gFFHgpp0MYplwzcCSu++gIo2K8tU9Y87J4ahOfeKbM9D/tg+Fd0h/Pb8ho
	oZpGaUYJP3kmpVV3ZZeiFfGg+GEq1aoDoUgCRdTl0ECsYgboc/ZC9bSQ+ZY26rBu9MDyotYfwMT
	QDraiPOGLifepNjchQyevjDWEjCNtXrglh
X-Received: by 2002:a17:907:1df1:b0:bd5:17f9:e987 with SMTP id a640c23a62f3a-bdc16131c08mr140799866b.46.1779373927445;
        Thu, 21 May 2026 07:32:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc87e781a7sm57136666b.18.2026.05.21.07.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2026 07:32:06 -0700 (PDT)
Date: Thu, 21 May 2026 14:32:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Nico Pache <npache@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, byungchul@sk.com,
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
	jack@suse.cz, jackmanb@google.com, jannh@google.com,
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com,
	pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
	rdunlap@infradead.org, rientjes@google.com, rostedt@goodmis.org,
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
	sunnanyong@huawei.com, surenb@google.com,
	thomas.hellstrom@linux.intel.com, tiwai@suse.de,
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <20260521143206.evmha5goh6smhmha@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260511185817.686831-1-npache@redhat.com>
 <20260511185817.686831-12-npache@redhat.com>
 <8f9834db-8981-4eb1-ae46-94908943da3d@gmail.com>
 <20260521024654.2a7teoe665porz76@master>
 <91015820-f39a-4b06-89de-b49e5ca465fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91015820-f39a-4b06-89de-b49e5ca465fd@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, May 21, 2026 at 01:11:18PM +0800, Vernon Yang wrote:
>On Thu, May 21, 2026 at 02:46:54AM +0000, Wei Yang wrote:
>> On Thu, May 21, 2026 at 10:36:15AM +0800, Vernon Yang wrote:
>> >On Mon, May 11, 2026 at 12:58:11PM -0600, Nico Pache wrote:
>> >> Enable khugepaged to collapse to mTHP orders. This patch implements the
>> >> main scanning logic using a bitmap to track occupied pages and a stack
>> >> structure that allows us to find optimal collapse sizes.
>> >>
>> >> Previous to this patch, PMD collapse had 3 main phases, a light weight
>> >> scanning phase (mmap_read_lock) that determines a potential PMD
>> >> collapse, an alloc phase (mmap unlocked), then finally heavier collapse
>> >> phase (mmap_write_lock).
>> >>
>> >> To enabled mTHP collapse we make the following changes:
>> >>
>> >> During PMD scan phase, track occupied pages in a bitmap. When mTHP
>> >> orders are enabled, we remove the restriction of max_ptes_none during the
>> >> scan phase to avoid missing potential mTHP collapse candidates. Once we
>> >> have scanned the full PMD range and updated the bitmap to track occupied
>> >> pages, we use the bitmap to find the optimal mTHP size.
>> >>
>> >> Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
>> >> and determine the best eligible order for the collapse. A stack structure
>> >> is used instead of traditional recursion to manage the search. This also
>> >> prevents a traditional recursive approach when the kernel stack struct is
>> >> limited. The algorithm recursively splits the bitmap into smaller chunks to
>> >> find the highest order mTHPs that satisfy the collapse criteria. We start
>> >> by attempting the PMD order, then moved on the consecutively lower orders
>> >> (mTHP collapse). The stack maintains a pair of variables (offset, order),
>> >> indicating the number of PTEs from the start of the PMD, and the order of
>> >> the potential collapse candidate.
>> >>
>> >> The algorithm for consuming the bitmap works as such:
>> >>     1) push (0, HPAGE_PMD_ORDER) onto the stack
>> >>     2) pop the stack
>> >>     3) check if the number of set bits in that (offset,order) pair
>> >>        statisfy the max_ptes_none threshold for that order
>> >>     4) if yes, attempt collapse
>> >>     5) if no (or collapse fails), push two new stack items representing
>> >>        the left and right halves of the current bitmap range, at the
>> >>        next lower order
>> >>     6) repeat at step (2) until stack is empty.
>> >>
>> >> Below is a diagram representing the algorithm and stack items:
>> >>
>> >>                             offset   mid_offset
>> >>                             |        |
>> >>                             |        |
>> >>                             v        v
>> >>           ____________________________________
>> >>          |          PTE Page Table            |
>> >>          --------------------------------------
>> >> 			    <-------><------->
>> >>                              order-1  order-1
>> >>
>> >> mTHP collapses reject regions containing swapped out or shared pages.
>> >> This is because adding new entries can lead to new none pages, and these
>> >> may lead to constant promotion into a higher order mTHP. A similar
>> >> issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
>> >> introducing at least 2x the number of pages, and on a future scan will
>> >> satisfy the promotion condition once again. This issue is prevented via
>> >> the collapse_max_ptes_none() function which imposes the max_ptes_none
>> >> restrictions above.
>> >>
>> >> We currently only support mTHP collapse for max_ptes_none values of 0
>> >> and HPAGE_PMD_NR - 1. resulting in the following behavior:
>> >>
>> >>     - max_ptes_none=0: Never introduce new empty pages during collapse
>> >>     - max_ptes_none=HPAGE_PMD_NR-1: Always try collapse to the highest
>> >>       available mTHP order
>> >>
>> >> Any other max_ptes_none value will emit a warning and skip mTHP collapse
>> >> attempts. There should be no behavior change for PMD collapse.
>> >>
>> >> Once we determine what mTHP sizes fits best in that PMD range a collapse
>> >> is attempted. A minimum collapse order of 2 is used as this is the lowest
>> >> order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
>> >>
>> >> Currently madv_collapse is not supported and will only attempt PMD
>> >> collapse.
>> >>
>> >> We can also remove the check for is_khugepaged inside the PMD scan as
>> >> the collapse_max_ptes_none() function handles this logic now.
>> >>
>> >> Signed-off-by: Nico Pache <npache@redhat.com>
>> >> ---
>> >>  mm/khugepaged.c | 182 +++++++++++++++++++++++++++++++++++++++++++++---
>> >>  1 file changed, 174 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> >> index 3492b135d667..39bf7ea8a6e8 100644
>> >> --- a/mm/khugepaged.c
>> >> +++ b/mm/khugepaged.c
>> >> @@ -100,6 +100,30 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>> >>
>> >>  static struct kmem_cache *mm_slot_cache __ro_after_init;
>> >>
>> >> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
>> >> +/*
>> >> + * mthp_collapse() does an iterative DFS over a binary tree, from
>> >> + * HPAGE_PMD_ORDER down to KHUGEPAGED_MIN_MTHP_ORDER. The max stack
>> >> + * size needed for a DFS on a binary tree is height + 1, where
>> >> + * height = HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER.
>> >> + *
>> >> + * ilog2 is used in place of HPAGE_PMD_ORDER because some architectures
>> >> + * (e.g. ppc64le) do not define HPAGE_PMD_ORDER until after build time.
>> >> + */
>> >> +#define MTHP_STACK_SIZE	(ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER + 1)
>> >> +
>> >> +/*
>> >> + * Defines a range of PTE entries in a PTE page table which are being
>> >> + * considered for mTHP collapse.
>> >> + *
>> >> + * @offset: the offset of the first PTE entry in a PMD range.
>> >> + * @order: the order of the PTE entries being considered for collapse.
>> >> + */
>> >> +struct mthp_range {
>> >> +	u16 offset;
>> >> +	u8 order;
>> >> +};
>> >> +
>> >>  struct collapse_control {
>> >>  	bool is_khugepaged;
>> >>
>> >> @@ -111,6 +135,12 @@ struct collapse_control {
>> >>
>> >>  	/* nodemask for allocation fallback */
>> >>  	nodemask_t alloc_nmask;
>> >> +
>> >> +	/* Each bit represents a single occupied (!none/zero) page. */
>> >> +	DECLARE_BITMAP(mthp_bitmap, MAX_PTRS_PER_PTE);
>> >> +	/* A mask of the current range being considered for mTHP collapse. */
>> >> +	DECLARE_BITMAP(mthp_bitmap_mask, MAX_PTRS_PER_PTE);
>> >> +	struct mthp_range mthp_bitmap_stack[MTHP_STACK_SIZE];
>> >>  };
>> >>
>> >>  /**
>> >> @@ -1404,20 +1434,140 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>> >>  	return result;
>> >>  }
>> >>
>> >> +static void collapse_mthp_stack_push(struct collapse_control *cc, int *stack_size,
>> >> +				     u16 offset, u8 order)
>> >> +{
>> >> +	const int size = *stack_size;
>> >> +	struct mthp_range *stack = &cc->mthp_bitmap_stack[size];
>> >> +
>> >> +	VM_WARN_ON_ONCE(size >= MTHP_STACK_SIZE);
>> >> +	stack->order = order;
>> >> +	stack->offset = offset;
>> >> +	(*stack_size)++;
>> >> +}
>> >> +
>> >> +static struct mthp_range collapse_mthp_stack_pop(struct collapse_control *cc,
>> >> +						 int *stack_size)
>> >> +{
>> >> +	const int size = *stack_size;
>> >> +
>> >> +	VM_WARN_ON_ONCE(size <= 0);
>> >> +	(*stack_size)--;
>> >> +	return cc->mthp_bitmap_stack[size - 1];
>> >> +}
>> >> +
>> >> +static unsigned int collapse_mthp_count_present(struct collapse_control *cc,
>> >> +						u16 offset, unsigned int nr_ptes)
>> >> +{
>> >> +	bitmap_zero(cc->mthp_bitmap_mask, MAX_PTRS_PER_PTE);
>> >> +	bitmap_set(cc->mthp_bitmap_mask, offset, nr_ptes);
>> >> +	return bitmap_weight_and(cc->mthp_bitmap, cc->mthp_bitmap_mask, MAX_PTRS_PER_PTE);
>> >> +}
>> >> +
>> >> +/*
>> >> + * mthp_collapse() consumes the bitmap that is generated during
>> >> + * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
>> >> + *
>> >> + * Each bit in cc->mthp_bitmap represents a single occupied (!none/zero) page.
>> >> + * A stack structure cc->mthp_bitmap_stack is used to check different regions
>> >> + * of the bitmap for collapse eligibility. The stack maintains a pair of
>> >> + * variables (offset, order), indicating the number of PTEs from the start of
>> >> + * the PMD, and the order of the potential collapse candidate respectively. We
>> >> + * start at the PMD order and check if it is eligible for collapse; if not, we
>> >> + * add two entries to the stack at a lower order to represent the left and right
>> >> + * halves of the PTE page table we are examining.
>> >> + *
>> >> + *                         offset       mid_offset
>> >> + *                         |         |
>> >> + *                         |         |
>> >> + *                         v         v
>> >> + *      --------------------------------------
>> >> + *      |          cc->mthp_bitmap            |
>> >> + *      --------------------------------------
>> >> + *                         <-------><------->
>> >> + *                          order-1  order-1
>> >> + *
>> >> + * For each of these, we determine how many PTE entries are occupied in the
>> >> + * range of PTE entries we propose to collapse, then we compare this to a
>> >> + * threshold number of PTE entries which would need to be occupied for a
>> >> + * collapse to be permitted at that order (accounting for max_ptes_none).
>> >> + *
>> >> + * If a collapse is permitted, we attempt to collapse the PTE range into a
>> >> + * mTHP.
>> >> + */
>> >> +static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>> >> +		int referenced, int unmapped, struct collapse_control *cc,
>> >> +		unsigned long enabled_orders)
>> >> +{
>> >> +	unsigned int nr_occupied_ptes, nr_ptes;
>> >> +	int max_ptes_none, collapsed = 0, stack_size = 0;
>> >> +	unsigned long collapse_address;
>> >> +	struct mthp_range range;
>> >> +	u16 offset;
>> >> +	u8 order;
>> >> +
>> >> +	collapse_mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
>> >> +
>> >> +	while (stack_size) {
>> >> +		range = collapse_mthp_stack_pop(cc, &stack_size);
>> >> +		order = range.order;
>> >> +		offset = range.offset;
>> >> +		nr_ptes = 1UL << order;
>> >> +
>> >> +		if (!test_bit(order, &enabled_orders))
>> >> +			goto next_order;
>> >> +
>> >> +		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
>> >> +
>> >> +		if (max_ptes_none < 0)
>> >> +			return collapsed;
>> >> +
>> >> +		nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
>> >> +							       nr_ptes);
>> >> +
>> >> +		if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {
>> >> +			int ret;
>> >> +
>> >> +			collapse_address = address + offset * PAGE_SIZE;
>> >> +			ret = collapse_huge_page(mm, collapse_address, referenced,
>> >> +						 unmapped, cc, order);
>> >> +			if (ret == SCAN_SUCCEED) {
>> >> +				collapsed += nr_ptes;
>> >> +				continue;
>> >> +			}
>> >> +		}
>> >> +
>> >> +next_order:
>> >> +		if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
>> >
>> >Hi Nico, thank you very much for your contributions to this series.
>> >
>> >I found a minor issue, for MADV_COLLAPSE, if collapse_huge_page() fails
>> >for some reason (e.g. allocate folio), it goes to next_order and
>> >continues splitting to the next small order. However, enabled_orders
>> >only supports HPAGE_PMD_ORDER, so it keeps runing the split operations
>> >without any effective work until KHUGEPAGED_MIN_MTHP_ORDER is reached
>> >before exiting. For khugepaged, e.g. setting only 2MB to always, also
>> >same phenomenon.
>>
>> Yes, but it does no actual work since it is checked after pop up.
>>
>> >
>> >This does not affect the overall functionality of mthp collapse, just
>> >redundant.
>> >
>> >The redundant operations can be easily skipped with the following
>> >modification. If I miss some thing, please let me know. Thanks!
>> >
>> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> >index 1a25af3d6d0f..fa407cce525c 100644
>> >--- a/mm/khugepaged.c
>> >+++ b/mm/khugepaged.c
>> >@@ -1574,7 +1574,7 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>> > 		}
>> >
>> > next_order:
>> >-		if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
>> >+		if ((BIT(order) - 1) & enabled_orders) {
>> > 			const u8 next_order = order - 1;
>> > 			const u16 mid_offset = offset + (nr_ptes / 2);
>> >
>>
>> This would stop the iteration if there are other lower enabled order, right?
>             ^^^^                                  ^^^^^^^^^^^^^^^^^^^
>
>NO :)

Got it. You are right.

The logic here is all lower bits are not set, skip the rest.

>
>For more details, please refer to the following information.
>
>|              Scenario               | Old Behavior (order > 2) | New Behavior ((BIT(order)-1) & enabled_orders) |
>|-------------------------------------|--------------------------|------------------------------------------------|
>| MADV_COLLAPSE                       | Splits 9,8,7,...,3       | No split                                       |
>| khugepaged, only 2MB enabled        | Splits 9,8,7,...,3       | No split                                       |
>| khugepaged, only 2MB + 64KB enabled | Splits 9,8,7,...,3       | Splits 9,8,7,...,5                             |
>| khugepaged, only 32KB enabled       | Splits 9,8,7,...,3       | Splits 9,8,7,...,4                             |
>| khugepaged, only 16KB enabled       | Splits 9,8,7,...,3       | Splits 9,8,7,...,3                             |
>| khugepaged, all mTHP enabled        | Splits 9,8,7,...,3       | Splits 9,8,7,...,3                             |
>
>--
>Cheers,
>Vernon

-- 
Wei Yang
Help you, Help me
