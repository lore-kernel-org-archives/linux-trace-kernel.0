Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896183C4B90
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600676; cv=none; b=tA4ipzQfaEH14s1krnBESESWMd86++Iuo6haRQqSA9ipwlzIfqj/xS8mw1fl8b3sJ6DAdwRbvcZuw59ISFo86WYkgdJDjwyfp64DISmnvy6okdYzYBEa1HyUlvVtIPuUTn2qeuwUoj2z5bSyFU49Grj6u41A6kMJoxRqcLmEW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600676; c=relaxed/simple;
	bh=3DcpGCU9K6911shPV50gRl5M+deS3kNBx+fYBsUdgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+lT0lLEiOLbOLIag65ymEc56H8roKBUj+o8rnVLE1KKkVY/vfa51r7dtc5WsKELgxGi1cxYUfYRxAsX6IUc9z1oyG88SQqW3MahoKneXhpB8WX0MGCNFkMq9cvxVO4orzWHT+rh7ao4adPHvII46yWc5mQnPxm2MtRBsUGoG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEv8x2VE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEv8x2VE"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso8514152a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600673; x=1779205473; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv4qmA+sqyfYzE92vZNdsUTE214TmpdPKsUH6wG5Qt4=;
        b=HEv8x2VEh4Y3972hEATwBSj0usLVbIDgsrrMb2pypfcoIjSLmtrgpzQlO1JowF2D8L
         wzINJAwzmoOk6QIlwOJbf9UzZuTxn5JeTElYBoP7sgXINSnM7JsuSyt9UMEIoiXyv+gn
         40mfZpdhrdBBgE6MIdzqMg8RHieUgnOWQoLhnYGR3ZPvdL37EPVqUCDePBbQX4fyGbpx
         sDaoqSrjEFdyBlYOHnSIgbvHAcM+jUsSEPt7cv8xGbrSYM0Y492dFQcm4C1jH1wn2wCS
         3BqmW8ed5944CyKD0eGAbJtr1yHbqZM8ZcYaredmQHO9VgXw+dsJDo5bLqGEYL0EBOxa
         2fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600673; x=1779205473;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv4qmA+sqyfYzE92vZNdsUTE214TmpdPKsUH6wG5Qt4=;
        b=XVweqcJU0of2IacpTDBbLhSpTUTlyVFbH4P0sAgY2TCxP1pXzGdfvC9HCggs9qhrMK
         XUA1URAEDo+Y2MM0b2JkAxc0GBxBbBoCfH63cfbC9s5soh1Oigp6FgN5eEtjrjxDsn9R
         vM957rJP2seZpRFAGgWyMCerOmc7Z62a4by/osFZlmjQHH2OAsvrPBu58rQyBUQn1rFE
         UgYaztFZgSJLgbV3dlybyob7MVjSrcKpvbM38PKX8Je6T7dssQ8DN50NnhO9Wo4Hskja
         2gU9sX5cq7uIlt9UFGDebqAixHZ2U2im1ZJOIsSFu67ZHWukczDQGz1Mp2dObwwryCWG
         rctA==
X-Forwarded-Encrypted: i=1; AFNElJ+lU9yolWpaV7TAcdObf6kXgxMuWQDK2967x61cCirFtPkftVWwRr8R/1I+iea/Xm73QfMUx1TQ8UxWtDVzSVhL2DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VwJuuDd0RvGz99wPbW0w6YbmQvazNef4WqeS+iLO3d+x3iwc
	ebhUXNAE7GLYHQ/CPoXZam1HZSP2zgJ0c8fWkmrQpYzjHTZaUQv3JQkw
X-Gm-Gg: Acq92OEpRiqsDAIkaTsUhzLhj0TtkuE4JiXdYOhr6I+v9bzP7VlV/8ihFnENsH11QPW
	xQhu4xzDPrg1N/IoBI+QHjvpI/839t85YcyuDinauVV38ZcAUXN6l446U2lKo/roEFquDb04R9u
	GrKZmLawk9Yucck4EM+wRnekJtRFBiJi9FcIMyXKnjsUez8FqqiENs3PS2HIV7RWkf5wXT00I+g
	hc2uJZb2W3BylcxZepVv8fhifU9OujRJqvi5fNpGQxagcfzwoqw7Q+HXHDPqErIeXOzEJmBUOHW
	29+8nWPQSU3mvccoIyXzqiFRQ6fyvt71Z5LdZONX1W560v+AtaRJ+saxdzUygTaqYw9mIoukTqb
	q77jDR7QLHQQzO3M2HKAg3VhwtxQ6zun7tQkzvEZHencMyndN4KMOfZKxCjaofnh+O2jVVG3rid
	+IG5Wh6m5se6mOh+TMeBhQ5g==
X-Received: by 2002:a17:907:1c0d:b0:bd2:ed0:90f9 with SMTP id a640c23a62f3a-bd20ed09163mr410838466b.30.1778600672517;
        Tue, 12 May 2026 08:44:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac11b7084sm687780766b.28.2026.05.12.08.44.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2026 08:44:32 -0700 (PDT)
Date: Tue, 12 May 2026 15:44:31 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
	rdunlap@infradead.org, richard.weiyang@gmail.com,
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com,
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de,
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <20260512154431.jxcs632mqqatqtsw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260511185817.686831-1-npache@redhat.com>
 <20260511185817.686831-12-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511185817.686831-12-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, May 11, 2026 at 12:58:11PM -0600, Nico Pache wrote:
>Enable khugepaged to collapse to mTHP orders. This patch implements the
>main scanning logic using a bitmap to track occupied pages and a stack
>structure that allows us to find optimal collapse sizes.
>
>Previous to this patch, PMD collapse had 3 main phases, a light weight
>scanning phase (mmap_read_lock) that determines a potential PMD
>collapse, an alloc phase (mmap unlocked), then finally heavier collapse
>phase (mmap_write_lock).
>
>To enabled mTHP collapse we make the following changes:
>
>During PMD scan phase, track occupied pages in a bitmap. When mTHP
>orders are enabled, we remove the restriction of max_ptes_none during the
>scan phase to avoid missing potential mTHP collapse candidates. Once we
>have scanned the full PMD range and updated the bitmap to track occupied
>pages, we use the bitmap to find the optimal mTHP size.
>
>Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
>and determine the best eligible order for the collapse. A stack structure
>is used instead of traditional recursion to manage the search. This also
>prevents a traditional recursive approach when the kernel stack struct is
>limited. The algorithm recursively splits the bitmap into smaller chunks to
>find the highest order mTHPs that satisfy the collapse criteria. We start
>by attempting the PMD order, then moved on the consecutively lower orders
>(mTHP collapse). The stack maintains a pair of variables (offset, order),
>indicating the number of PTEs from the start of the PMD, and the order of
>the potential collapse candidate.
>
>The algorithm for consuming the bitmap works as such:
>    1) push (0, HPAGE_PMD_ORDER) onto the stack
>    2) pop the stack
>    3) check if the number of set bits in that (offset,order) pair
>       statisfy the max_ptes_none threshold for that order
>    4) if yes, attempt collapse
>    5) if no (or collapse fails), push two new stack items representing
>       the left and right halves of the current bitmap range, at the
>       next lower order
>    6) repeat at step (2) until stack is empty.
>
>Below is a diagram representing the algorithm and stack items:
>
>                            offset   mid_offset
>                            |        |
>                            |        |
>                            v        v
>          ____________________________________
>         |          PTE Page Table            |
>         --------------------------------------
>			    <-------><------->
>                             order-1  order-1
>
>mTHP collapses reject regions containing swapped out or shared pages.
>This is because adding new entries can lead to new none pages, and these
>may lead to constant promotion into a higher order mTHP. A similar
>issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
>introducing at least 2x the number of pages, and on a future scan will
>satisfy the promotion condition once again. This issue is prevented via
>the collapse_max_ptes_none() function which imposes the max_ptes_none
>restrictions above.
>
>We currently only support mTHP collapse for max_ptes_none values of 0
>and HPAGE_PMD_NR - 1. resulting in the following behavior:
>
>    - max_ptes_none=0: Never introduce new empty pages during collapse
>    - max_ptes_none=HPAGE_PMD_NR-1: Always try collapse to the highest
>      available mTHP order
>
>Any other max_ptes_none value will emit a warning and skip mTHP collapse
>attempts. There should be no behavior change for PMD collapse.
>
>Once we determine what mTHP sizes fits best in that PMD range a collapse
>is attempted. A minimum collapse order of 2 is used as this is the lowest
>order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
>
>Currently madv_collapse is not supported and will only attempt PMD
>collapse.
>
>We can also remove the check for is_khugepaged inside the PMD scan as
>the collapse_max_ptes_none() function handles this logic now.
>
>Signed-off-by: Nico Pache <npache@redhat.com>

[...]

>+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>+		int referenced, int unmapped, struct collapse_control *cc,
>+		unsigned long enabled_orders)
>+{
>+	unsigned int nr_occupied_ptes, nr_ptes;
>+	int max_ptes_none, collapsed = 0, stack_size = 0;
>+	unsigned long collapse_address;
>+	struct mthp_range range;
>+	u16 offset;
>+	u8 order;
>+
>+	collapse_mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
>+
>+	while (stack_size) {
>+		range = collapse_mthp_stack_pop(cc, &stack_size);
>+		order = range.order;
>+		offset = range.offset;
>+		nr_ptes = 1UL << order;
>+
>+		if (!test_bit(order, &enabled_orders))
>+			goto next_order;
>+
>+		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);

I am thinking whether there is a behavioral change for userfaultfd_armed(vma).

collapse_single_pmd()
    collapse_scan_pmd
        max_ptes_none = collapse_max_ptes_none(cc, vma)
        max_ptes_none = KHUGEPAGED_MAX_PTES_LIMIT                --- (1)
        mthp_collapse
            max_ptes_none = collapse_max_ptes_none(cc, NULL)     --- (2)
            collapse_huge_page(mm)
                hugepage_vma_revalidate(&vma)
                __collapse_huge_page_isolate(vma)
                    max_ptes_none = collapse_max_ptes_none(cc, vma)

Before mthp_collapse() introduced, userfaultfd_armed(vma) is skipped if there
is any pte_none_or_zero() in collapse_scan_pmd().

But now, max_ptes_none could be set to KHUGEPAGED_MAX_PTES_LIMIT at (1), so
that we can scan all the pte to get the bitmap. This means
userfaultfd_armed(vma) could continue even with pte_none_or_zero().

Then in mthp_collapse(), collapse_max_ptes_none() at (2) ignores
userfaultfd_armed(vma), which means it will continue to collapse a
userfaultfd_armed(vma) when there is pte_none_or_zero(). 

The good news is we will stop at __collapse_huge_page_isolate(), where we
get collapse_max_ptes_none() with vma. But we already did a lot of work.

Not sure if I missed something.

>+
>+		if (max_ptes_none < 0)
>+			return collapsed;
>+
>+		nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
>+							       nr_ptes);
>+
>+		if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {
>+			int ret;
>+
>+			collapse_address = address + offset * PAGE_SIZE;
>+			ret = collapse_huge_page(mm, collapse_address, referenced,
>+						 unmapped, cc, order);
>+			if (ret == SCAN_SUCCEED) {
>+				collapsed += nr_ptes;
>+				continue;
>+			}
>+		}
>+
>+next_order:
>+		if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
>+			const u8 next_order = order - 1;
>+			const u16 mid_offset = offset + (nr_ptes / 2);
>+
>+			collapse_mthp_stack_push(cc, &stack_size, mid_offset,
>+						 next_order);
>+			collapse_mthp_stack_push(cc, &stack_size, offset,
>+						 next_order);
>+		}
>+	}
>+	return collapsed;
>+}
>+
> static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 		struct vm_area_struct *vma, unsigned long start_addr,
> 		bool *lock_dropped, struct collapse_control *cc)
> {
>-	const int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
>+	int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
> 	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
> 	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
>+	enum tva_type tva_flags = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
> 	pmd_t *pmd;
>-	pte_t *pte, *_pte;
>-	int none_or_zero = 0, shared = 0, referenced = 0;
>+	pte_t *pte, *_pte, pteval;
>+	int i;
>+	int none_or_zero = 0, shared = 0, nr_collapsed = 0, referenced = 0;
> 	enum scan_result result = SCAN_FAIL;
> 	struct page *page = NULL;
> 	struct folio *folio = NULL;
> 	unsigned long addr;
>+	unsigned long enabled_orders;
> 	spinlock_t *ptl;
> 	int node = NUMA_NO_NODE, unmapped = 0;
> 
>@@ -1429,8 +1579,19 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 		goto out;
> 	}
> 
>+	bitmap_zero(cc->mthp_bitmap, MAX_PTRS_PER_PTE);
> 	memset(cc->node_load, 0, sizeof(cc->node_load));
> 	nodes_clear(cc->alloc_nmask);
>+
>+	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, tva_flags);

Would it be 0 at this point?

>+
>+	/*
>+	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
>+	 * scan all pages to populate the bitmap for mTHP collapse.
>+	 */
>+	if (enabled_orders != BIT(HPAGE_PMD_ORDER))
>+		max_ptes_none = KHUGEPAGED_MAX_PTES_LIMIT;
>+
> 	pte = pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> 	if (!pte) {
> 		cc->progress++;
>@@ -1438,11 +1599,13 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 		goto out;
> 	}
> 
>-	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>-	     _pte++, addr += PAGE_SIZE) {
>+	for (i = 0; i < HPAGE_PMD_NR; i++) {
>+		_pte = pte + i;
>+		addr = start_addr + i * PAGE_SIZE;
>+		pteval = ptep_get(_pte);
>+
> 		cc->progress++;
> 
>-		pte_t pteval = ptep_get(_pte);
> 		if (pte_none_or_zero(pteval)) {
> 			if (++none_or_zero > max_ptes_none) {
> 				result = SCAN_EXCEED_NONE_PTE;
>@@ -1522,6 +1685,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 			}
> 		}
> 
>+		/* Set bit for occupied pages */
>+		__set_bit(i, cc->mthp_bitmap);
> 		/*
> 		 * Record which node the original page is from and save this
> 		 * information to cc->node_load[].
>@@ -1580,10 +1745,11 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 	if (result == SCAN_SUCCEED) {
> 		/* collapse_huge_page expects the lock to be dropped before calling */
> 		mmap_read_unlock(mm);
>-		result = collapse_huge_page(mm, start_addr, referenced,
>-					    unmapped, cc, HPAGE_PMD_ORDER);
>+		nr_collapsed = mthp_collapse(mm, start_addr, referenced, unmapped,
>+					      cc, enabled_orders);
> 		/* collapse_huge_page will return with the mmap_lock released */

collapse_huge_page will return with mmap_lock released, but mthp_collapse()
may not?

> 		*lock_dropped = true;
>+		result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
> 	}
> out:
> 	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
>-- 
>2.54.0

-- 
Wei Yang
Help you, Help me
