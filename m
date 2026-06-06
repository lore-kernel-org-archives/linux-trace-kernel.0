Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68853822A8
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Jun 2026 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780741709; cv=none; b=JNCsCTICdzFibgISRns8k2P1sKzYG0qF/AYHd5OzVKJt4AQPzwW936NEJH6Z+jRTlo8nYna0MGBn1Mhrzi/0IAGnZ6/7012864qy5bSx/5xv6buSDYC9zpaHkH9OwLiWFp6V/u+ISFKB0PBAgygM97YNiES4A4R91QKfyqw/5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780741709; c=relaxed/simple;
	bh=GHoTcONfMoUBbNg0a/I7UedOlX6bhzxJh0KG2TcvHuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxtHPVEKSMBFLd3ACni/tpwd9xHgPaR+s7+yn3mXFj7PekO7bRv6Ff9mJIFuN3Ndb6wmqIlwbRaMYoz3P9sPQEBqt5ClvXAU+ze07wv6pnoDqRX8fzfWxLlL5LgA42KURCrl+MNLh20zH7l6gOKOBfgpB2chJlsHXEQxYpMpC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6KAtCE3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6KAtCE3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780741694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixuH/LfALlrfKgOZm24yiyJIMUqb8sCxZWDdh8LUM4A=;
	b=K6KAtCE3UrgoB4NqbuZY6+ccRBrtt7M3bsrGIK13xnJmAgMp3SGL65mrOhkBW1ptu3nVjs
	/21C/yyEAcDLWw95xRvWywPJEWcKCFOZYL/IXSRMpUxoLDv02UkQ31csZY+enTPlaSBOix
	IWCopmPzXD7+AISZL84I2YVMqTaaPGc=
From: Lance Yang <lance.yang@linux.dev>
To: npache@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 11/14] mm/khugepaged: Introduce mTHP collapse support
Date: Sat,  6 Jun 2026 18:28:00 +0800
Message-Id: <20260606102800.26940-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-12-npache@redhat.com>
References: <20260605161422.213817-12-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:18AM -0600, Nico Pache wrote:
>Enable khugepaged to collapse to mTHP orders. This patch implements the
>main scanning logic using a bitmap to track occupied pages and the
>algorithm to find optimal collapse sizes.
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
>Implement mthp_collapse() to walk forward through the bitmap and
>determine the best eligible order for each naturally-aligned region. The
>algorithm starts at the beginning of the PMD range and, for each offset,
>tries the highest order that fits the alignment. If the number of
>occupied PTEs in that region satisfies the max_ptes_none threshold for
>that order, a collapse is attempted. On failure, the order is
>decremented and the same offset is retried at the next smaller size. Once
>the smallest enabled order is exhausted (or a collapse succeeds), the
>offset advances past the region just processed, and the next attempt
>starts at the highest order permitted by the new offset's natural
>alignment.
>
>The algorithm works as follows:
>    1) set offset=0 and order=HPAGE_PMD_ORDER
>    2) if the order is not enabled, go to step (5)
>    3) count occupied PTEs in the (offset, order) range using
>       bitmap_weight_from()
>    4) if the count satisfies the max_ptes_none threshold, attempt
>       collapse; on success, advance to step (6)
>    5) if a smaller enabled order exists, decrement order and retry
>       from step (2) at the same offset
>    6) advance offset past the current region and compute the next
>       order from the new offset's natural alignment via __ffs(offset),
>       capped at HPAGE_PMD_ORDER
>    7) repeat from step (2) until the full PMD range is covered
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
>Any other max_ptes_none value will emit a warning and default mTHP
>collapse to max_ptes_none=0. There should be no behavior change for PMD
>collapse.
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
>---
> mm/khugepaged.c | 146 +++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 138 insertions(+), 8 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index ec886a031952..430047316f43 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -99,6 +99,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
> 
> static struct kmem_cache *mm_slot_cache __ro_after_init;
> 
>+#define KHUGEPAGED_MIN_MTHP_ORDER	2
>+
> struct collapse_control {
> 	bool is_khugepaged;
> 
>@@ -110,6 +112,9 @@ struct collapse_control {
> 
> 	/* nodemask for allocation fallback */
> 	nodemask_t alloc_nmask;
>+
>+	/* Each bit represents a single occupied (!none/zero) page. */
>+	DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
> };
> 
> /**
>@@ -1440,20 +1445,130 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> 	return result;
> }
> 
>+/* Return the highest naturally aligned order that fits at @offset within a PMD. */
>+static unsigned int max_order_from_offset(unsigned int offset)
>+{
>+	if (offset == 0)
>+		return HPAGE_PMD_ORDER;
>+
>+	return min_t(unsigned int, __ffs(offset), HPAGE_PMD_ORDER);
>+}
>+
>+/*
>+ * mthp_collapse() consumes the bitmap that is generated during
>+ * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
>+ *
>+ * Each bit in cc->mthp_present_ptes represents a single occupied (!none/zero)
>+ * page. We start at the PMD order and check if it is eligible for collapse;
>+ * if not, we check the left and right halves of the PTE page table we are
>+ * examining at a lower order.
>+ *
>+ * For each of these, we determine how many PTE entries are occupied in the
>+ * range of PTE entries we propose to collapse, then we compare this to a
>+ * threshold number of PTE entries which would need to be occupied for a
>+ * collapse to be permitted at that order (accounting for max_ptes_none).
>+ *
>+ * If a collapse is permitted, we attempt to collapse the PTE range into a
>+ * mTHP.
>+ */
>+static enum scan_result mthp_collapse(struct mm_struct *mm,
>+		unsigned long address, int referenced, int unmapped,
>+		struct collapse_control *cc, unsigned long enabled_orders)
>+{
>+	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
>+	enum scan_result last_result = SCAN_FAIL;
>+	int collapsed = 0;
>+	bool alloc_failed = false;
>+	unsigned long collapse_address;
>+	unsigned int offset = 0;
>+	unsigned int order = HPAGE_PMD_ORDER;
>+
>+	while (offset < HPAGE_PMD_NR) {
>+		nr_ptes = 1UL << order;
>+
>+		if (!test_bit(order, &enabled_orders))
>+			goto next_order;
>+
>+		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
>+		nr_occupied_ptes = bitmap_weight_from(cc->mthp_present_ptes, offset,
>+						      offset + nr_ptes);
>+
>+		if (nr_occupied_ptes >= nr_ptes - max_ptes_none) {

Looks broken for swap PTEs in PMD collapse ...

collapse_scan_pmd() allows them up to max_ptes_swap and record them in
unmapped, but they don't get a bit in mthp_present_ptes. And then
mthp_collapse() does the check above:

nr_occupied_ptes >= nr_ptes - max_ptes_none

So max_ptes_none=0 + 511 present PTEs + one allowed swap PTE won't even
call collapse_huge_page() for PMD order.

Shouldn't we account for them in the PMD-order check? Something like:

if (is_pmd_order(order))
	nr_occupied_ptes += unmapped;

Cheers, Lance
 
>+			enum scan_result ret;
>+
>+			collapse_address = address + offset * PAGE_SIZE;
>+			ret = collapse_huge_page(mm, collapse_address, referenced,
>+						 unmapped, cc, order);
>+			switch (ret) {
>+			/* Cases where we continue to next collapse candidate */
>+			case SCAN_SUCCEED:
>+				collapsed += nr_ptes;
>+				fallthrough;
>+			case SCAN_PTE_MAPPED_HUGEPAGE:
>+				goto next_offset;
>+			/* Cases where lower orders might still succeed */
>+			case SCAN_ALLOC_HUGE_PAGE_FAIL:
>+				alloc_failed = true;
>+				last_result = ret;
>+				goto next_order;
>+			/* Cases where no further collapse is possible */
>+			case SCAN_PMD_MAPPED:
>+				fallthrough;
>+			default:
>+				last_result = ret;
>+				goto done;
>+			}
>+		}
>+
>+next_order:
>+		/*
>+		 * Continue with the next smaller order if there is still
>+		 * any smaller order enabled. When at the smallest order
>+		 * we must always move to the next offset.
>+		 */
>+		if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
>+			(enabled_orders & GENMASK(order - 1, 0))) {
>+			order--;
>+			continue;
>+		}
>+next_offset:
>+		/*
>+		 * Advance past the region we just processed and determine the
>+		 * highest order we can attempt next. Since huge pages must be
>+		 * naturally aligned, the max order we can attempt next is
>+		 * limited by the alignment of the new offset.
>+		 * E.g. if we collapsed a order-2 mTHP at offset 0, offset
>+		 * becomes 4 and __ffs(4) == 2, so the next attempt starts at
>+		 * order 2.
>+		 */
>+		offset += nr_ptes;
>+		order = max_order_from_offset(offset);
>+	}
>+done:
>+	if (collapsed)
>+		return SCAN_SUCCEED;
>+	if (alloc_failed)
>+		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>+	return last_result;
>+}
>+
> static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 		struct vm_area_struct *vma, unsigned long start_addr,
> 		bool *lock_dropped, struct collapse_control *cc)
> {
>-	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
> 	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
> 	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
>+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
>+	enum tva_type tva_flags = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
> 	pmd_t *pmd;
>-	pte_t *pte, *_pte;
>+	pte_t *pte, *_pte, pteval;
>+	int i;
> 	int none_or_zero = 0, shared = 0, referenced = 0;
> 	enum scan_result result = SCAN_FAIL;
> 	struct page *page = NULL;
> 	struct folio *folio = NULL;
> 	unsigned long addr;
>+	unsigned long enabled_orders;
> 	spinlock_t *ptl;
> 	int node = NUMA_NO_NODE, unmapped = 0;
> 
>@@ -1465,8 +1580,19 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 		goto out;
> 	}
> 
>+	bitmap_zero(cc->mthp_present_ptes, MAX_PTRS_PER_PTE);
> 	memset(cc->node_load, 0, sizeof(cc->node_load));
> 	nodes_clear(cc->alloc_nmask);
>+
>+	enabled_orders = collapse_possible_orders(vma, vma->vm_flags, tva_flags);
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
>@@ -1474,11 +1600,13 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
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
>@@ -1558,6 +1686,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 			}
> 		}
> 
>+		/* Set bit for occupied pages */
>+		__set_bit(i, cc->mthp_present_ptes);
> 		/*
> 		 * Record which node the original page is from and save this
> 		 * information to cc->node_load[].
>@@ -1616,9 +1746,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 	if (result == SCAN_SUCCEED) {
> 		/* collapse_huge_page expects the lock to be dropped before calling */
> 		mmap_read_unlock(mm);
>-		result = collapse_huge_page(mm, start_addr, referenced,
>-					    unmapped, cc, HPAGE_PMD_ORDER);
>-		/* collapse_huge_page will return with the mmap_lock released */
>+		result = mthp_collapse(mm, start_addr, referenced,
>+				       unmapped, cc, enabled_orders);
>+		/* mmap_lock was released above, set lock_dropped */
> 		*lock_dropped = true;
> 	}
> out:
>-- 
>2.54.0
>
>
