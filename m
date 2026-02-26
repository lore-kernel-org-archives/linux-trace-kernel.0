Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DE285CB4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076384; cv=none; b=oy9grEm1s0Li48B3Q0Mt1xuusvLBSbcw7EjGjB4vJjil9HzZZ00wyUkzsBOEcM+PxrYO0YL7BdZhjTeE3BA6VPB/NqBIqcw3TiUTJuCbJU2xw7ehmA709aszUlG/ZbG+lUZyALIRNLbaWEu9H2bJ0K1/tBScWQAZe166gh43Bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076384; c=relaxed/simple;
	bh=zyr2irytQx8acTHoJQlEbGE2aDq3lbHslOEaEKRDR5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EIsHLAEQuMx+Y08421gX2JX2EtQPbxu3yk5nd6vTK/n8DEVtiqE/t9VXVu07CX1uaOCzV6B0H5DvO33biB8/Q1Vk6nQG99mdMjSQG8PwW1aK8541nyY6uvUDomf7KP/3g5p1oU/irgwjOmMo8q9odrzVSYqpMFdSH6GG0QVHOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Itje8zUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Itje8zUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772076381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xytCvH2X8ef3/V/rmF3mLSfeJ+7HIq0lAPBHFQUkqck=;
	b=Itje8zUPJesownsXNEyrndtk26Kx7dB6lvSDLOIK8sFJF8lywfVPw2nVI8NJdaa8z1raFY
	y6Iv12+kupgnaE1kUCZUOgzBi4K056qiE6UEXdErtebje7Qysio3iZ/jfhLp1x6nLEncej
	RJ+k8JgvvwgqpuKPVjabk6KQb3dQFu8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-yjffftFVNziBStqP46kiKw-1; Wed,
 25 Feb 2026 22:26:18 -0500
X-MC-Unique: yjffftFVNziBStqP46kiKw-1
X-Mimecast-MFC-AGG-ID: yjffftFVNziBStqP46kiKw_1772076377
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B1271956052;
	Thu, 26 Feb 2026 03:26:17 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10B181800465;
	Thu, 26 Feb 2026 03:26:07 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com,
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
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	npache@redhat.com,
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
Subject: [PATCH mm-unstable v15 10/13] mm/khugepaged: Introduce mTHP collapse support
Date: Wed, 25 Feb 2026 20:26:05 -0700
Message-ID: <20260226032605.234046-1-npache@redhat.com>
In-Reply-To: <20260226031741.230674-1-npache@redhat.com>
References: <20260226031741.230674-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: iw3NvAumEg5OT1vCTYYLZtyaS-13rtcsw3wgdiINyz4_1772076377
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Enable khugepaged to collapse to mTHP orders. This patch implements the
main scanning logic using a bitmap to track occupied pages and a stack
structure that allows us to find optimal collapse sizes.

Previous to this patch, PMD collapse had 3 main phases, a light weight
scanning phase (mmap_read_lock) that determines a potential PMD
collapse, a alloc phase (mmap unlocked), then finally heavier collapse
phase (mmap_write_lock).

To enabled mTHP collapse we make the following changes:

During PMD scan phase, track occupied pages in a bitmap. When mTHP
orders are enabled, we remove the restriction of max_ptes_none during the
scan phase to avoid missing potential mTHP collapse candidates. Once we
have scanned the full PMD range and updated the bitmap to track occupied
pages, we use the bitmap to find the optimal mTHP size.

Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
and determine the best eligible order for the collapse. A stack structure
is used instead of traditional recursion to manage the search. The
algorithm recursively splits the bitmap into smaller chunks to find the
highest order mTHPs that satisfy the collapse criteria. We start by
attempting the PMD order, then moved on the consecutively lower orders
(mTHP collapse). The stack maintains a pair of variables (offset, order),
indicating the number of PTEs from the start of the PMD, and the order of
the potential collapse candidate.

The algorithm for consuming the bitmap works as such:
    1) push (0, HPAGE_PMD_ORDER) onto the stack
    2) pop the stack
    3) check if the number of set bits in that (offset,order) pair
       statisfy the max_ptes_none threshold for that order
    4) if yes, attempt collapse
    5) if no (or collapse fails), push two new stack items representing
       the left and right halves of the current bitmap range, at the
       next lower order
    6) repeat at step (2) until stack is empty.

Below is a diagram representing the algorithm and stack items:

                           offset       mid_offset
                            |         |
                            |         |
                            v         v
          ____________________________________
         |          PTE Page Table            |
         --------------------------------------
			    <-------><------->
                             order-1  order-1

We currently only support mTHP collapse for max_ptes_none values of 0
and HPAGE_PMD_NR - 1. resulting in the following behavior:

    - max_ptes_none=0: Never introduce new empty pages during collapse
    - max_ptes_none=HPAGE_PMD_NR-1: Always try collapse to the highest
      available mTHP order

Any other max_ptes_none value will emit a warning and skip mTHP collapse
attempts. There should be no behavior change for PMD collapse.

Once we determine what mTHP sizes fits best in that PMD range a collapse
is attempted. A minimum collapse order of 2 is used as this is the lowest
order supported by anon memory as defined by THP_ORDERS_ALL_ANON.

mTHP collapses reject regions containing swapped out or shared pages.
This is because adding new entries can lead to new none pages, and these
may lead to constant promotion into a higher order (m)THP. A similar
issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
introducing at least 2x the number of pages, and on a future scan will
satisfy the promotion condition once again. This issue is prevented via
the collapse_max_ptes_none() function which imposes the max_ptes_none
restrictions above.

Currently madv_collapse is not supported and will only attempt PMD
collapse.

We can also remove the check for is_khugepaged inside the PMD scan as
the collapse_max_ptes_none() function handles this logic now.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 189 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 180 insertions(+), 9 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2fdfb6d42cf9..1c3711ed4513 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -99,6 +99,32 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
+#define KHUGEPAGED_MIN_MTHP_ORDER	2
+/*
+ * The maximum number of mTHP ranges that can be stored on the stack.
+ * This is calculated based on the number of PTE entries in a PTE page table
+ * and the minimum mTHP order.
+ *
+ * ilog2(MAX_PTRS_PER_PTE) is log2 of the maximum number of PTE entries.
+ * This gives you the PMD_ORDER, and is needed in place of HPAGE_PMD_ORDER due
+ * to restrictions of some architectures (ie ppc64le).
+ *
+ * At most there will be 1 << (PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER) mTHP ranges
+ */
+#define MTHP_STACK_SIZE	(1UL << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
+
+/*
+ * Defines a range of PTE entries in a PTE page table which are being
+ * considered for (m)THP collapse.
+ *
+ * @offset: the offset of the first PTE entry in a PMD range.
+ * @order: the order of the PTE entries being considered for collapse.
+ */
+struct mthp_range {
+	u16 offset;
+	u8 order;
+};
+
 struct collapse_control {
 	bool is_khugepaged;
 
@@ -107,6 +133,11 @@ struct collapse_control {
 
 	/* nodemask for allocation fallback */
 	nodemask_t alloc_nmask;
+
+	/* bitmap used for mTHP collapse */
+	DECLARE_BITMAP(mthp_bitmap, MAX_PTRS_PER_PTE);
+	DECLARE_BITMAP(mthp_bitmap_mask, MAX_PTRS_PER_PTE);
+	struct mthp_range mthp_bitmap_stack[MTHP_STACK_SIZE];
 };
 
 /**
@@ -1361,17 +1392,138 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	return result;
 }
 
+static void mthp_stack_push(struct collapse_control *cc, int *stack_size,
+				   u16 offset, u8 order)
+{
+	const int size = *stack_size;
+	struct mthp_range *stack = &cc->mthp_bitmap_stack[size];
+
+	VM_WARN_ON_ONCE(size >= MTHP_STACK_SIZE);
+	stack->order = order;
+	stack->offset = offset;
+	(*stack_size)++;
+}
+
+static struct mthp_range mthp_stack_pop(struct collapse_control *cc, int *stack_size)
+{
+	const int size = *stack_size;
+
+	VM_WARN_ON_ONCE(size <= 0);
+	(*stack_size)--;
+	return cc->mthp_bitmap_stack[size - 1];
+}
+
+static unsigned int mthp_nr_occupied_pte_entries(struct collapse_control *cc,
+						 u16 offset, unsigned long nr_pte_entries)
+{
+	bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
+	bitmap_set(cc->mthp_bitmap_mask, offset, nr_pte_entries);
+	return bitmap_weight_and(cc->mthp_bitmap, cc->mthp_bitmap_mask, HPAGE_PMD_NR);
+}
+
+/*
+ * mthp_collapse() consumes the bitmap that is generated during
+ * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
+ *
+ * Each bit in cc->mthp_bitmap represents a single occupied (!none/zero) page.
+ * A stack structure cc->mthp_bitmap_stack is used to check different regions
+ * of the bitmap for collapse eligibility. The stack maintains a pair of
+ * variables (offset, order), indicating the number of PTEs from the start of
+ * the PMD, and the order of the potential collapse candidate respectively. We
+ * start at the PMD order and check if it is eligible for collapse; if not, we
+ * add two entries to the stack at a lower order to represent the left and right
+ * halves of the PTE page table we are examining.
+ *
+ *                         offset       mid_offset
+ *                         |         |
+ *                         |         |
+ *                         v         v
+ *      --------------------------------------
+ *      |          cc->mthp_bitmap            |
+ *      --------------------------------------
+ *                         <-------><------->
+ *                          order-1  order-1
+ *
+ * For each of these, we determine how many PTE entries are occupied in the
+ * range of PTE entries we propose to collapse, then we compare this to a
+ * threshold number of PTE entries which would need to be occupied for a
+ * collapse to be permitted at that order (accounting for max_ptes_none).
+
+ * If a collapse is permitted, we attempt to collapse the PTE range into a
+ * mTHP.
+ */
+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
+		int referenced, int unmapped, struct collapse_control *cc,
+		bool *mmap_locked, unsigned long enabled_orders)
+{
+	unsigned int max_ptes_none, nr_occupied_ptes;
+	struct mthp_range range;
+	unsigned long collapse_address;
+	int collapsed = 0, stack_size = 0;
+	unsigned long nr_pte_entries;
+	u16 offset;
+	u8 order;
+
+	mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
+
+	while (stack_size > 0) {
+		range = mthp_stack_pop(cc, &stack_size);
+		order = range.order;
+		offset = range.offset;
+		nr_pte_entries = 1UL << order;
+
+		if (!test_bit(order, &enabled_orders))
+			goto next_order;
+
+		if (cc->is_khugepaged)
+			max_ptes_none = collapse_max_ptes_none(order);
+		else
+			max_ptes_none = COLLAPSE_MAX_PTES_LIMIT;
+
+		if (max_ptes_none == -EINVAL)
+			return collapsed;
+
+		nr_occupied_ptes = mthp_nr_occupied_pte_entries(cc, offset, nr_pte_entries);
+
+		if (nr_occupied_ptes >= nr_pte_entries - max_ptes_none) {
+			int ret;
+
+			collapse_address = address + offset * PAGE_SIZE;
+			ret = collapse_huge_page(mm, collapse_address, referenced,
+						 unmapped, cc, mmap_locked,
+						 order);
+			if (ret == SCAN_SUCCEED) {
+				collapsed += nr_pte_entries;
+				continue;
+			}
+		}
+
+next_order:
+		if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
+			const u8 next_order = order - 1;
+			const u16 mid_offset = offset + (nr_pte_entries / 2);
+
+			mthp_stack_push(cc, &stack_size, mid_offset, next_order);
+			mthp_stack_push(cc, &stack_size, offset, next_order);
+		}
+	}
+	return collapsed;
+}
+
 static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr, bool *mmap_locked,
 		unsigned int *cur_progress, struct collapse_control *cc)
 {
 	pmd_t *pmd;
 	pte_t *pte, *_pte;
-	int none_or_zero = 0, shared = 0, referenced = 0;
+	int i;
+	int none_or_zero = 0, shared = 0, nr_collapsed = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
 	struct page *page = NULL;
+	unsigned int max_ptes_none;
 	struct folio *folio = NULL;
 	unsigned long addr;
+	unsigned long enabled_orders;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
 
@@ -1384,8 +1536,21 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		goto out;
 	}
 
+	bitmap_zero(cc->mthp_bitmap, HPAGE_PMD_NR);
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
+	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, cc->is_khugepaged);
+
+	/*
+	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
+	 * scan all pages to populate the bitmap for mTHP collapse.
+	 */
+	if (cc->is_khugepaged && enabled_orders == BIT(HPAGE_PMD_ORDER))
+		max_ptes_none = collapse_max_ptes_none(HPAGE_PMD_ORDER);
+	else
+		max_ptes_none = COLLAPSE_MAX_PTES_LIMIT;
+
 	pte = pte_offset_map_lock(mm, pmd, start_addr, &ptl);
 	if (!pte) {
 		if (cur_progress)
@@ -1394,17 +1559,18 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		goto out;
 	}
 
-	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
-	     _pte++, addr += PAGE_SIZE) {
+	for (i = 0; i < HPAGE_PMD_NR; i++) {
+		_pte = pte + i;
+		addr = start_addr + i * PAGE_SIZE;
+		pte_t pteval = ptep_get(_pte);
+
 		if (cur_progress)
 			*cur_progress += 1;
 
-		pte_t pteval = ptep_get(_pte);
 		if (pte_none_or_zero(pteval)) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
+			    none_or_zero <= max_ptes_none) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -1478,6 +1644,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
+		/* Set bit for occupied pages */
+		bitmap_set(cc->mthp_bitmap, i, 1);
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
@@ -1534,9 +1702,12 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
-		result = collapse_huge_page(mm, start_addr, referenced,
-					    unmapped, cc, mmap_locked,
-					    HPAGE_PMD_ORDER);
+		nr_collapsed = mthp_collapse(mm, start_addr, referenced, unmapped,
+					      cc, mmap_locked, enabled_orders);
+		if (nr_collapsed > 0)
+			result = SCAN_SUCCEED;
+		else
+			result = SCAN_FAIL;
 	}
 out:
 	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
-- 
2.53.0

