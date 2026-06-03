Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3A43DA59;
	Wed,  3 Jun 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480551; cv=none; b=sp6WKwAR98XYspoB7d092oRwka7O887vHSgcpl4t21iACwgJ5Wq4+FD8jRhVg0epdOTAOlYBNTqcL3BI/M0riCQ1Ue5XJ4khfxOHNsiVBHHLR0qv8C+BSmKi/LLR36IEQ8nun90ZVtU2mcq+4hDwFfF/A1CuenrU8Dm0TrS3mqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480551; c=relaxed/simple;
	bh=0TyQGe4Ec/j2RQI3LmJVPtC3UKOvffJW9+0s1ZL0fyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goVY8MaQzo/yjmv0h/BENN7CfgkYh54o6/ivjzz0WoEY/yFL9wJCPl5VmpkWRjJBk30rJjDxn9enHeTI+BFuRzAar+tZcbQmjrDGNeqcTLcuwpyU6AmNhuEum44USaAi0fkQMm+G4awcVCKhxX2b2kw5sFRxl3iRlApxNqlEGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZELoh770; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZELoh770"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8C61F00893;
	Wed,  3 Jun 2026 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780480547;
	bh=TSgStdg4r20O9DWrCx2c1JrFgzKjF5JyWw+4KONqiHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZELoh770qprhXSkJ72LkyIWtwH3H2nFUjNYwNSPCyxe0rxDELZAckjoe5yGiVg352
	 KlvAzNNTvvdQ/WLZWmGZSlMShNKKanVigvXXbOF/F9HgQq/FNmxTRKIkj/sdjszZ4l
	 aHNMg1zeEWYITJS0XgXdlKJMf9Xn/dX2ymSRrl9PcYsbWpNJwsjUEHHNFLpYuv8MOU
	 5Nu/32PTwuUcAXkwaN+5mnJZpF2UsdlY2CWZJRPcR2BN87/sRNSGVlW50IRwnEwWzr
	 7dDSkQi0c6YRZ0yhtWL4CPC4tM3yPuJqtzFHfahQVFuMilfm7n/LN5sIFbeg/EzPzv
	 tGtf1zdo0waww==
Message-ID: <b5616c79-8123-4717-b56e-b5be131eadef@kernel.org>
Date: Wed, 3 Jun 2026 11:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, vbabka@suse.cz, vishal.moola@gmail.com,
 wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
 yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 zokeefe@google.com, Usama Arif <usama.arif@linux.dev>, usamaarif642@gmail.com
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
 <b8380eb3-096a-49f1-9ace-99c1e75888b4@kernel.org>
 <CAA1CXcBg1su-bk3i_H+TW4-nTgvGSGqRNeC9MpQo7sGeH8ejnA@mail.gmail.com>
 <d3c2b00c-6810-434a-b837-0707b0a11611@kernel.org>
 <19639b08-5bf1-4974-9635-c458d512fa38@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <19639b08-5bf1-4974-9635-c458d512fa38@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 19:23, Nico Pache wrote:
> 
> 
> On 6/1/26 7:15 AM, David Hildenbrand (Arm) wrote:
>>>
>>> So I looked into your items below. It seems logical, and I think it
>>> works the same way; however, your method seems slightly harder to
>>> understand due to all the edge cases and more error-prone to future
>>> changes (the stack holds implicit knowledge of the offset/order that
>>> must now be tracked in the edge cases).
>>>
>>> Given the stack is 24 bytes, I'm not sure if the extra complexity is
>>> worth saving that small amount of memory. Although we would also be
>>> getting rid of (3?) functions, so both approaches have pros and cons.
>>
>> I consider a simple forward loop over the offset ... less complexity compared to
>> a stack structure :)
>>
>>>
>>> I will implement a patch comparing your solution against mine and send
>>> it here, then we can decide which approach is better.
>>
>> Right, throw it over the fence and I'll see how to improve it further.
> 
> Ok heres what the diff looks like on top of my V19. 
> 
> you can access the tree here https://gitlab.com/npache/linux/-/commits/mthp-v19?ref_type=heads for easier review.
> 
> So far I have no problem with this approach it appeared cleaner than i thought. Did some light testing. Gonna throw it more through the ringer tomorrow. 

It's very clean.

Almost too nice to be true ;)

[...]

>  	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
>  	enum scan_result last_result = SCAN_FAIL;
> -	int collapsed = 0, stack_size = 0;
> +	int collapsed = 0;
>  	bool alloc_failed = false;
>  	unsigned long collapse_address;
> -	struct mthp_range range;
> -	u16 offset;
> -	u8 order;
> +	unsigned int offset = 0;
> +	unsigned int order = HPAGE_PMD_ORDER;


In include/linux/huge_mm.h we have

	highest_order()

and

	next_order()

They essentially allow you to get rid of the test_bit() and just jump to the
next enabled order right away.

I assume with only a handful of enabled_orders, that might be much more efficient.

I tried to optimize it and ended with the following, which is completely untested.

I think it might make sense to defer that and start with the simple approach you have.

I do wonder, though, about the last hunk below: should we bail out early if
enabled_orders is suddenly 0?



From 0d8ff955b3071f354b7fc9b627820fa374fa99dc Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 3 Jun 2026 11:52:44 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/huge_mm.h |   5 ++
 mm/khugepaged.c         | 132 ++++++++++++++++++++++------------------
 2 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 48496f09909b..099318bc1181 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -205,6 +205,11 @@ static inline int highest_order(unsigned long orders)
 	return fls_long(orders) - 1;
 }
 
+static inline int smallest_order(unsigned long orders)
+{
+	return __ffs(orders);
+}
+
 static inline int next_order(unsigned long *orders, int prev)
 {
 	*orders &= ~BIT(prev);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6de935e76ceb..49be9d1a88cb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -99,8 +99,6 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
-#define KHUGEPAGED_MIN_MTHP_ORDER	2
-
 struct collapse_control {
 	bool is_khugepaged;
 
@@ -1454,76 +1452,86 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
  */
 static enum scan_result mthp_collapse(struct mm_struct *mm,
 		unsigned long address, int referenced, int unmapped,
-		struct collapse_control *cc, unsigned long enabled_orders)
+		struct collapse_control *cc, const unsigned long enabled_orders)
 {
-	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
 	enum scan_result last_result = SCAN_FAIL;
 	int collapsed = 0;
 	bool alloc_failed = false;
 	unsigned long collapse_address;
 	unsigned int offset = 0;
-	unsigned int order = HPAGE_PMD_ORDER;
 
+	/* We cannot collapse anon folios to order-1 or order-0. */
+	VM_WARN_ON_ONCE(!enabled_order || (enabled_orders & 0x3));
 
 	while (offset < HPAGE_PMD_NR) {
-		nr_ptes = 1UL << order;
-
-		if (!test_bit(order, &enabled_orders))
-			goto next_order;
-
-		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
-		nr_occupied_ptes = bitmap_weight_from(cc->mthp_present_ptes, offset,
-						      offset + nr_ptes);
-
-		if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {
-			enum scan_result ret;
-
-			collapse_address = address + offset * PAGE_SIZE;
-			ret = collapse_huge_page(mm, collapse_address, referenced,
-						 unmapped, cc, order);
-
-			switch (ret) {
-			/* Cases where we continue to next collapse candidate */
-			case SCAN_SUCCEED:
-				collapsed += nr_ptes;
-				fallthrough;
-			case SCAN_PTE_MAPPED_HUGEPAGE:
-				goto next_offset;
-			/* Cases where lower orders might still succeed */
-			case SCAN_ALLOC_HUGE_PAGE_FAIL:
-				alloc_failed = true;
-				fallthrough;
-			case SCAN_LACK_REFERENCED_PAGE:
-			case SCAN_EXCEED_NONE_PTE:
-			case SCAN_EXCEED_SWAP_PTE:
-			case SCAN_EXCEED_SHARED_PTE:
-			case SCAN_PAGE_LOCK:
-			case SCAN_PAGE_COUNT:
-			case SCAN_PAGE_NULL:
-			case SCAN_DEL_PAGE_LRU:
-			case SCAN_PTE_NON_PRESENT:
-			case SCAN_PTE_UFFD_WP:
-			case SCAN_PAGE_LAZYFREE:
-				last_result = ret;
-				goto next_order;
-			/* Cases where no further collapse is possible */
-			case SCAN_PMD_MAPPED:
-				fallthrough;
-			default:
-				last_result = ret;
-				goto done;
+		/*
+		 * We can only collapse to a maximum order for a given offset.
+		 * So ignore all orders that do not apply to the current
+		 * offset, then see if any order to collapse to remains.
+		 */
+		unsigned long orders = enabled_orders & GENMASK(__ffs(offset), 0);
+		unsigned int order = highest_order(orders);
+
+		while (order) {
+			const unsigned int nr_ptes = 1UL << order;
+			unsigned int nr_occupied_ptes, max_ptes_none;
+
+			max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
+			nr_occupied_ptes = bitmap_weight_from(cc->mthp_present_ptes, offset,
+							      offset + nr_ptes);
+
+			if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {
+				enum scan_result ret;
+
+				collapse_address = address + offset * PAGE_SIZE;
+				ret = collapse_huge_page(mm, collapse_address, referenced,
+							 unmapped, cc, order);
+
+				switch (ret) {
+				/* Cases where we continue to next collapse candidate */
+				case SCAN_SUCCEED:
+					collapsed += nr_ptes;
+					fallthrough;
+				case SCAN_PTE_MAPPED_HUGEPAGE:
+					goto next_offset;
+				/* Cases where lower orders might still succeed */
+				case SCAN_ALLOC_HUGE_PAGE_FAIL:
+					alloc_failed = true;
+					fallthrough;
+				case SCAN_LACK_REFERENCED_PAGE:
+				case SCAN_EXCEED_NONE_PTE:
+				case SCAN_EXCEED_SWAP_PTE:
+				case SCAN_EXCEED_SHARED_PTE:
+				case SCAN_PAGE_LOCK:
+				case SCAN_PAGE_COUNT:
+				case SCAN_PAGE_NULL:
+				case SCAN_DEL_PAGE_LRU:
+				case SCAN_PTE_NON_PRESENT:
+				case SCAN_PTE_UFFD_WP:
+				case SCAN_PAGE_LAZYFREE:
+					last_result = ret;
+					break;
+				/* Cases where no further collapse is possible */
+				case SCAN_PMD_MAPPED:
+					fallthrough;
+				default:
+					last_result = ret;
+					goto done;
+				}
 			}
-		}
 
-next_order:
-		if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
-			(BIT(order) - 1) & enabled_orders) {
-			order = order - 1;
-			continue;
+			order = next_order(&orders, order);
 		}
+
 next_offset:
-		offset += nr_ptes;
-		order = min_t(int, __ffs(offset), HPAGE_PMD_ORDER);
+		/*
+		 * Continue with the next collapse candidate. If we do not
+		 * have an order, skip to nest smallest mTHP we can collapse to.
+		 */
+		if (order)
+			offset += 1UL << order;
+		else
+			offset = ALIGN(offset + 1, smallest_order(enabled_orders));
 	}
 done:
 	if (collapsed)
@@ -1567,6 +1575,12 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 
 	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, tva_flags);
 
+	if (unlikely(!enabled_orders)) {
+		cc->progress++;
+		result = SCAN_SUCCEED;
+		goto out;
+	}
+
 	/*
 	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
 	 * scan all pages to populate the bitmap for mTHP collapse.
-- 
2.43.0


-- 
Cheers,

David
