Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BD3A1D05
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525980; cv=none; b=Pj2JejSBp6UutS2Is4U6hZtpwDEuvIeurKp8PR2AKX/OP6ujQwXcW+TnOIG1JdHwhAol65Ju5FqNCUvnXF2py6FzNVQeqyvCJm730Mc+/X3i5KsPi8BHyExM4wHC3VaemhUnjxb6UTmMhTzfRzSne/62BdHKWqFb7gTQ8RBkMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525980; c=relaxed/simple;
	bh=CyidUpaGKZke+CQtiyUeS5fd94FAj9N8Fqz763vb+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G6UZTYy3EL1YLC+RPaToPZoJENOSTEKN1dK9ueCwZ5Tcwq2CbD+RIQZegtgGe3g3aMgsE59QVsdcQKAES99hXf9f3+9g3LQ7kHgIwU9iQJHbrwJPU35UMPl9n1cnONDcy8S1frsyA0Hzb2dC2J8leObnDLVVC+GTxQgocTchmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsj494CV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsj494CV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778525976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut++ei4ddQyzYP5S/Hg8gq8aYue9qDckDI2miv49seY=;
	b=gsj494CVlP5C3hBRCJqdb9sSSXfCFKqfpXH/2en40NVzF7F/oRb04BDMA/SKaj+NiUvJZt
	+BEVLoTqZbME7ipfs4RLxXooaMXL16UzIKHVgewAUisn/efhnh0EuTc4qqaZ1L5mvqhpTj
	PZqvGNEHmi8qY4DT2krLsxexprwjtd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-xN5rW7PPPLCwBlhdDirjVQ-1; Mon,
 11 May 2026 14:59:30 -0400
X-MC-Unique: xN5rW7PPPLCwBlhdDirjVQ-1
X-Mimecast-MFC-AGG-ID: xN5rW7PPPLCwBlhdDirjVQ_1778525969
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A22419560B7;
	Mon, 11 May 2026 18:59:29 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD86430001BE;
	Mon, 11 May 2026 18:59:09 +0000 (UTC)
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
	liam@infradead.org,
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
Subject: [PATCH mm-unstable v17 04/14] mm/khugepaged: generalize __collapse_huge_page_* for mTHP support
Date: Mon, 11 May 2026 12:58:04 -0600
Message-ID: <20260511185817.686831-5-npache@redhat.com>
In-Reply-To: <20260511185817.686831-1-npache@redhat.com>
References: <20260511185817.686831-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Ssu4I6adqlS8aakEJKAAHmivJBd_4Jgs5xFIKBQoZwg_1778525969
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
than HPAGE_PMD_NR / 2. [1]

With this configuration, a successful collapse to order N will populate
enough pages to satisfy the collapse condition on order N+1 on the next
scan. This leads to unnecessary work and memory churn.

To fix this issue introduce a helper function that will limit mTHP
collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
This effectively supports two modes: [2]

- max_ptes_none=0: never collapses if it encounters an empty PTE or a PTE
  that maps the shared zeropage. Consequently, no memory bloat.
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

[1] - https://lore.kernel.org/all/e46ab3ab-a3d7-4fb7-9970-d0704bd5d05a@arm.com
[2] - https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat.com

Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/trace/events/huge_memory.h |   3 +-
 mm/khugepaged.c                    | 117 ++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index bcdc57eea270..443e0bd13fdb 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -39,7 +39,8 @@
 	EM( SCAN_STORE_FAILED,		"store_failed")			\
 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
-	EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
+	EM(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
+	EMe(SCAN_INVALID_PTES_NONE,	"invalid_ptes_none")
 
 #undef EM
 #undef EMe
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f68853b3caa7..27465161fa6d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -61,6 +61,7 @@ enum scan_result {
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
+	SCAN_INVALID_PTES_NONE,
 };
 
 #define CREATE_TRACE_POINTS
@@ -353,37 +354,60 @@ static bool pte_none_or_zero(pte_t pte)
  * PTEs for the given collapse operation.
  * @cc: The collapse control struct
  * @vma: The vma to check for userfaultfd
+ * @order: The folio order being collapsed to
  *
  * Return: Maximum number of none-page or zero-page PTEs allowed for the
  * collapse operation.
  */
-static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
-		struct vm_area_struct *vma)
+static int collapse_max_ptes_none(struct collapse_control *cc,
+		struct vm_area_struct *vma, unsigned int order)
 {
+	unsigned int max_ptes_none = khugepaged_max_ptes_none;
 	// If the vma is userfaultfd-armed, allow no none-page or zero-page PTEs.
 	if (vma && userfaultfd_armed(vma))
 		return 0;
 	// for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
-	// For all other cases repect the user defined maximum.
-	return khugepaged_max_ptes_none;
+	// for PMD collapse, respect the user defined maximum.
+	if (is_pmd_order(order))
+		return max_ptes_none;
+	/* Zero/non-present collapse disabled. */
+	if (!max_ptes_none)
+		return 0;
+	// for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
+	// scale the maximum number of PTEs to the order of the collapse.
+	if (max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
+		return (1 << order) - 1;
+
+	// We currently only support max_ptes_none values of 0 or KHUGEPAGED_MAX_PTES_LIMIT.
+	// Emit a warning and return -EINVAL.
+	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
+		      KHUGEPAGED_MAX_PTES_LIMIT);
+	return -EINVAL;
 }
 
 /**
  * collapse_max_ptes_shared - Calculate maximum allowed PTEs that map shared
  * anonymous pages for the given collapse operation.
  * @cc: The collapse control struct
+ * @order: The folio order being collapsed to
  *
  * Return: Maximum number of PTEs that map shared anonymous pages for the
  * collapse operation
  */
-static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
+static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
+		unsigned int order)
 {
 	// for MADV_COLLAPSE, do not restrict the number of PTEs that map shared
 	// anonymous pages.
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
+	// for mTHP collapse do not allow collapsing anonymous memory pages that
+	// are shared between processes.
+	if (!is_pmd_order(order))
+		return 0;
+	// for PMD collapse, respect the user defined maximum.
 	return khugepaged_max_ptes_shared;
 }
 
@@ -391,16 +415,22 @@ static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
  * collapse_max_ptes_swap - Calculate the maximum allowed non-present PTEs or the
  * maximum allowed non-present pagecache entries for the given collapse operation.
  * @cc: The collapse control struct
+ * @order: The folio order being collapsed to
  *
  * Return: Maximum number of non-present PTEs or the maximum allowed non-present
  * pagecache entries for the collapse operation.
  */
-static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
+static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
+		unsigned int order)
 {
 	// for MADV_COLLAPSE, do not restrict the number PTEs entries or
 	// pagecache entries that are non-present.
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
+	// for mTHP collapse do not allow any non-present PTEs or pagecache entries.
+	if (!is_pmd_order(order))
+		return 0;
+	// for PMD collapse, respect the user defined maximum.
 	return khugepaged_max_ptes_swap;
 }
 
@@ -594,18 +624,22 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
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
+		return SCAN_INVALID_PTES_NONE;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none_or_zero(pteval)) {
@@ -738,18 +772,18 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
@@ -802,11 +836,10 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
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
 
 	/*
@@ -822,7 +855,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * Release both raw and compound pages isolated
 	 * in __collapse_huge_page_isolate.
 	 */
-	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
+	release_pte_pages(pte, pte + nr_pages, compound_pagelist);
 }
 
 /*
@@ -842,16 +875,17 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
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
 
 	/*
 	 * Copying pages' contents is subject to memory poison at any iteration.
 	 */
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < nr_pages; i++) {
 		pte_t pteval = ptep_get(pte + i);
 		struct page *page = folio_page(folio, i);
 		unsigned long src_addr = address + i * PAGE_SIZE;
@@ -870,10 +904,10 @@ static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *foli
 
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
@@ -1044,12 +1078,12 @@ static enum scan_result check_pmd_still_valid(struct mm_struct *mm,
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
@@ -1081,6 +1115,19 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
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
@@ -1200,7 +1247,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
 		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced);
+						     referenced, HPAGE_PMD_ORDER);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
@@ -1248,6 +1295,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
+						      HPAGE_PMD_ORDER,
 						      &compound_pagelist);
 		spin_unlock(pte_ptl);
 	} else {
@@ -1278,6 +1326,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
+					   HPAGE_PMD_ORDER,
 					   &compound_pagelist);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
@@ -1313,9 +1362,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		bool *lock_dropped, struct collapse_control *cc)
 {
-	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
-	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
-	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
+	const int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
+	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
+	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
 	pmd_t *pmd;
 	pte_t *pte, *_pte;
 	int none_or_zero = 0, shared = 0, referenced = 0;
@@ -2369,8 +2418,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		unsigned long addr, struct file *file, pgoff_t start,
 		struct collapse_control *cc)
 {
-	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL);
-	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
+	const int max_ptes_none = collapse_max_ptes_none(cc, NULL, HPAGE_PMD_ORDER);
+	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
 	struct folio *folio = NULL;
 	struct address_space *mapping = file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, start);
-- 
2.54.0

