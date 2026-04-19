Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B692FFF81
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625199; cv=none; b=HXgexeQNHppln1daZO2V2pC2ZsSr9fXlHjDoObPeWYZcMq/obcd1CKL6uZE9U+X6DBSr3uzznZPjc+AyVynS/zrEIiLeewywP0l7YttYgqA9T//FZT7NU2nD6H/qDtELAWQJhroDm8mdSaesPVS35bhFUCR9Bglfjm3zEnGptNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625199; c=relaxed/simple;
	bh=t3Q6ODkUzyUrpawyjPBCySG9QyBhFccdmUWCcPXos0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H/5W23dyfGeI4By1r48Mj/o6vc3/FMlADvtI0BrLnADyqdxXIQscSaY0L4sLqDvsKmFLLA8RUrByfF3QphVHbn0aPKn6OAhL9Y9+QT6/uMdlLR/NY/2Xic//mkjIE+LSumqty5sTANTh7DBFj91gMIA2KY2CQeT5nq6DRNHjJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ4IWK98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ4IWK98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776625195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3ELmtG1D0kWfzKPqqA8nVVpkTNegL6V2K5I0oBSsQs=;
	b=IJ4IWK98Gn54OzDi97JEHpAFnWx8Z+KCJzXmsmtWCHMMwg6xpJ9TM5mAcBZkQZ5d/vqG5T
	rxvx3uIZK3RgvOCL0cViRk/4YV2hOoKAxgDjs9pN6SqLj0XEchOTrJkwYQpUtprkXWvpq+
	gABnc9evgjbutEKmWSpGvnnmwU1qyv4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-Cw5j3xtlNhuYKhAt1bseTg-1; Sun,
 19 Apr 2026 14:59:52 -0400
X-MC-Unique: Cw5j3xtlNhuYKhAt1bseTg-1
X-Mimecast-MFC-AGG-ID: Cw5j3xtlNhuYKhAt1bseTg_1776625190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF7151800451;
	Sun, 19 Apr 2026 18:59:50 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BDEF1956095;
	Sun, 19 Apr 2026 18:59:34 +0000 (UTC)
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
	ljs@kernel.org,
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
Subject: [PATCH 7.2 v16 04/13] mm/khugepaged: generalize __collapse_huge_page_* for mTHP support
Date: Sun, 19 Apr 2026 12:57:41 -0600
Message-ID: <20260419185750.260784-5-npache@redhat.com>
In-Reply-To: <20260419185750.260784-1-npache@redhat.com>
References: <20260419185750.260784-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: UN3MQdgYMJ-o4jjHZZ6w_WF3KvqOiklruyNBCsqIBCs_1776625190
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

generalize the order of the __collapse_huge_page_* and collapse_max_*
functions to support future mTHP collapse.

The current mechanism for determining collapse with the
khugepaged_max_ptes_none value is not designed with mTHP in mind. This
raises a key design issue: if we support user defined max_pte_none values
(even those scaled by order), a collapse of a lower order can introduces
an feedback loop, or "creep", when max_ptes_none is set to a value greater
than HPAGE_PMD_NR / 2.

With this configuration, a successful collapse to order N will populate
enough pages to satisfy the collapse condition on order N+1 on the next
scan. This leads to unnecessary work and memory churn.

To fix this issue introduce a helper function that will limit mTHP
collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
This effectively supports two modes:

- max_ptes_none=0: never introduce new none-pages for mTHP collapse.
- max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
  available mTHP order.

This removes the possiblilty of "creep", while not modifying any uAPI
expectations. A warning will be emitted if any non-supported
max_ptes_none value is configured with mTHP enabled.

mTHP collapse will not honor the khugepaged_max_ptes_shared or
khugepaged_max_ptes_swap parameters, and will fail if it encounters a
shared or swapped entry.

No functional changes in this patch; however it defines future behavior
for mTHP collapse.

Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 124 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 36 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f42b55421191..283bb63854a5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -352,51 +352,86 @@ static bool pte_none_or_zero(pte_t pte)
  * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
  * @cc: The collapse control struct
  * @vma: The vma to check for userfaultfd
+ * @order: The folio order being collapsed to
  *
  * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
- * empty page.
+ * empty page. For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the
+ * configured khugepaged_max_ptes_none value.
+ *
+ * For mTHP collapses, we currently only support khugepaged_max_pte_none values
+ * of 0 or (KHUGEPAGED_MAX_PTES_LIMIT). Any other value will emit a warning and
+ * no mTHP collapse will be attempted
  *
  * Return: Maximum number of empty PTEs allowed for the collapse operation
  */
-static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
-		struct vm_area_struct *vma)
+static int collapse_max_ptes_none(struct collapse_control *cc,
+		struct vm_area_struct *vma, unsigned int order)
 {
 	if (vma && userfaultfd_armed(vma))
 		return 0;
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
-	return khugepaged_max_ptes_none;
+	if (is_pmd_order(order))
+		return khugepaged_max_ptes_none;
+	/* Zero/non-present collapse disabled. */
+	if (!khugepaged_max_ptes_none)
+		return 0;
+	if (khugepaged_max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
+		return (1 << order) - 1;
+
+	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
+		      KHUGEPAGED_MAX_PTES_LIMIT);
+	return -EINVAL;
 }
 
 /**
  * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse
  * @cc: The collapse control struct
+ * @order: The folio order being collapsed to
  *
  * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
  * shared page.
  *
+ * For mTHP collapses, we currently dont support collapsing memory with
+ * shared memory.
+ *
  * Return: Maximum number of shared PTEs allowed for the collapse operation
  */
-static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
+static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
+		unsigned int order)
 {
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
+	if (!is_pmd_order(order))
+		return 0;
+
 	return khugepaged_max_ptes_shared;
 }
 
 /**
  * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse
  * @cc: The collapse control struct
+ * @order: The folio order being collapsed to
  *
  * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
  * swap page.
  *
+ * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
+ * khugepaged_max_ptes_swap value.
+ *
+ * For mTHP collapses, we currently dont support collapsing memory with
+ * swapped out memory.
+ *
  * Return: Maximum number of swap PTEs allowed for the collapse operation
  */
-static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
+static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
+		unsigned int order)
 {
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
+	if (!is_pmd_order(order))
+		return 0;
+
 	return khugepaged_max_ptes_swap;
 }
 
@@ -590,18 +625,22 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
 static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
-		struct list_head *compound_pagelist)
+		unsigned int order, struct list_head *compound_pagelist)
 {
+	const unsigned long nr_pages = 1UL << order;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
 	unsigned long addr = start_addr;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
-	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
-	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
+	int max_ptes_none = collapse_max_ptes_none(cc, vma, order);
+	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, order);
+
+	if (max_ptes_none < 0)
+		return result;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none_or_zero(pteval)) {
@@ -734,18 +773,18 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 }
 
 static void __collapse_huge_page_copy_succeeded(pte_t *pte,
-						struct vm_area_struct *vma,
-						unsigned long address,
-						spinlock_t *ptl,
-						struct list_head *compound_pagelist)
+		struct vm_area_struct *vma, unsigned long address,
+		spinlock_t *ptl, unsigned int order,
+		struct list_head *compound_pagelist)
 {
-	unsigned long end = address + HPAGE_PMD_SIZE;
+	const unsigned long nr_pages = 1UL << order;
+	unsigned long end = address + (PAGE_SIZE << order);
 	struct folio *src, *tmp;
 	pte_t pteval;
 	pte_t *_pte;
 	unsigned int nr_ptes;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
+	for (_pte = pte; _pte < pte + nr_pages; _pte += nr_ptes,
 	     address += nr_ptes * PAGE_SIZE) {
 		nr_ptes = 1;
 		pteval = ptep_get(_pte);
@@ -798,13 +837,11 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 }
 
 static void __collapse_huge_page_copy_failed(pte_t *pte,
-					     pmd_t *pmd,
-					     pmd_t orig_pmd,
-					     struct vm_area_struct *vma,
-					     struct list_head *compound_pagelist)
+		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
+		unsigned int order, struct list_head *compound_pagelist)
 {
+	const unsigned long nr_pages = 1UL << order;
 	spinlock_t *pmd_ptl;
-
 	/*
 	 * Re-establish the PMD to point to the original page table
 	 * entry. Restoring PMD needs to be done prior to releasing
@@ -818,7 +855,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * Release both raw and compound pages isolated
 	 * in __collapse_huge_page_isolate.
 	 */
-	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
+	release_pte_pages(pte, pte + nr_pages, compound_pagelist);
 }
 
 /*
@@ -838,16 +875,16 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
  */
 static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
-		unsigned long address, spinlock_t *ptl,
+		unsigned long address, spinlock_t *ptl, unsigned int order,
 		struct list_head *compound_pagelist)
 {
+	const unsigned long nr_pages = 1UL << order;
 	unsigned int i;
 	enum scan_result result = SCAN_SUCCEED;
-
 	/*
 	 * Copying pages' contents is subject to memory poison at any iteration.
 	 */
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < nr_pages; i++) {
 		pte_t pteval = ptep_get(pte + i);
 		struct page *page = folio_page(folio, i);
 		unsigned long src_addr = address + i * PAGE_SIZE;
@@ -866,10 +903,10 @@ static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *foli
 
 	if (likely(result == SCAN_SUCCEED))
 		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
-						    compound_pagelist);
+						    order, compound_pagelist);
 	else
 		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
-						 compound_pagelist);
+						 order, compound_pagelist);
 
 	return result;
 }
@@ -1040,12 +1077,12 @@ static enum scan_result check_pmd_still_valid(struct mm_struct *mm,
  * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
  */
 static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
-		struct vm_area_struct *vma, unsigned long start_addr, pmd_t *pmd,
-		int referenced)
+		struct vm_area_struct *vma, unsigned long start_addr,
+		pmd_t *pmd, int referenced, unsigned int order)
 {
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
-	unsigned long addr, end = start_addr + (HPAGE_PMD_NR * PAGE_SIZE);
+	unsigned long addr, end = start_addr + (PAGE_SIZE << order);
 	enum scan_result result;
 	pte_t *pte = NULL;
 	spinlock_t *ptl;
@@ -1077,6 +1114,19 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
 		    pte_present(vmf.orig_pte))
 			continue;
 
+		/*
+		 * TODO: Support swapin without leading to further mTHP
+		 * collapses. Currently bringing in new pages via swapin may
+		 * cause a future higher order collapse on a rescan of the same
+		 * range.
+		 */
+		if (!is_pmd_order(order)) {
+			pte_unmap(pte);
+			mmap_read_unlock(mm);
+			result = SCAN_EXCEED_SWAP_PTE;
+			goto out;
+		}
+
 		vmf.pte = pte;
 		vmf.ptl = ptl;
 		ret = do_swap_page(&vmf);
@@ -1196,7 +1246,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
 		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced);
+						     referenced, HPAGE_PMD_ORDER);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
@@ -1244,6 +1294,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
+						      HPAGE_PMD_ORDER,
 						      &compound_pagelist);
 		spin_unlock(pte_ptl);
 	} else {
@@ -1274,6 +1325,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
+					   HPAGE_PMD_ORDER,
 					   &compound_pagelist);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
@@ -1318,9 +1370,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 	unsigned long addr;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
-	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
-	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
-	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
+	int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
+	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
+	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
 
 	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
 
@@ -2371,8 +2423,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
-	unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL);
-	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
+	int max_ptes_none = collapse_max_ptes_none(cc, NULL, HPAGE_PMD_ORDER);
+	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
 
 	present = 0;
 	swap = 0;
-- 
2.53.0

