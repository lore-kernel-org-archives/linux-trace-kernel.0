Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7C25B09E;
	Fri, 22 May 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482848; cv=none; b=rOp2aKYEM0BEnk1JRuZ/uIUifhpCafsymMppcjzCEd6nJeBb5PBx293BRgBnZimjKwn8bm2T+J4J3b4a3BHMLYs8xnWgwPcvWrNEXyJ2OyB2GZ9zfZlsoQToeDhegbnEWqVkaIyAQYuxT6HwVWaskORFbS+e03YMgpkmPNO3HYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482848; c=relaxed/simple;
	bh=PwUkc5WBoTvQu4zwbPERYVBBD8vFVBvQS2QIk9uteV0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dDoHnhsqCfP4p/IlhyvKipPDJhOZxmVeNN7UtWSPRUaZ0SKTWlzAytu8OOd4wQYl05JmFMQoxz23cU7aSC3fYSiDE69h4PFY5tIzAmcEgYFr5DPBA0u37fN6go2xpbOGIs2z0m+Z+SyFWOhHjUF/j64XRP7xwieVFCQ34g+9xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f0+AmlY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f0+AmlY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1733B1F000E9;
	Fri, 22 May 2026 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779482846;
	bh=5i7QPODMLrxZnmiREAIuBEYGYbpe74GrBuxM8qMSb8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f0+AmlY/ShT2/hpXajnodxaUa5AAFQFk5ixmYQ8axR/pndLRRMHuif4PUOb5XCAEm
	 MxEvzk7xP3oldzwRS2Ih+XxQPGuLMQUylC9mf0PumzUs8tHCmKwTvzeF6wR2wZw2Nn
	 U+tEF6psyus2ZJpUHECfLIqG7f6SioONFBd54JfE=
Date: Fri, 22 May 2026 13:47:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
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
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-Id: <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
In-Reply-To: <20260522150009.121603-1-npache@redhat.com>
References: <20260522150009.121603-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 08:59:55 -0600 Nico Pache <npache@redhat.com> wrote:

> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.

Thanks, I've update mm.git's mm-unstable branch to this version.

It sounds like I might be dropping it soon, haven't started looking at
that yet.  But let's at least eyeball the latest version at this time.

Sashiko was able to apply this, so the base-it-on-hotfixes thing worked
well, thanks.  The AI checking made a few allegations:

	https://sashiko.dev/#/patchset/20260522150009.121603-1-npache@redhat.com

> V18 Changes:
> - Added RBs/Acks
> - [patch 02] Guard count_memcg_folio_events with is_pmd_order() to keep
>   THP_COLLAPSE_ALLOC PMD-only (Usama, Lance)
> - [patch 03] Convert C++ comments to C-style; fix "none-page" terminology
>   to "empty PTEs or PTEs mapping the shared zeropage"; drop unnecessary
>   userfaultfd comment; add const to local max_ptes_* variables; fix
>   "repect" typo (Lance, David)
> - [patch 04] collapse_max_ptes_none() now returns 0 instead of -EINVAL for
>   unsupported values; remove SCAN_INVALID_PTES_NONE; change return type
>   from int to unsigned int and propagate to all callers; add comment above
>   __collapse_huge_page_swapin explaining mTHP swap bail-out (David,
>   Lorenzo, Lance, Wei Yang, Usama)
> - [patch 05] Rewrite collapse_huge_page lock comment to David's suggested
>   wording (David)
> - [patch 11] Propagate unsigned int return type for max_ptes_none; remove
>   the now-unnecessary negative return check (consequence of patch 04);
>   Add optimization to the next_order goto that will prevent unnecessary
>   iterations if there are no lower orders enabled (Vernon); update locking
>   comment; pass VMA to mthp_collapse to improve uffd-armed detection, and
>   prevent unnecessary work. (Wei)
> - [patch 14] Update documentation to reflect fallback-to-0 behavior
> 

Below is how v18 altered mm.git.

Quite a lot of it seems to be replacement of "//"-style comments.  It's
unfortunate that this work isn't separated from the substantive
changes.  We could have done that with a few followup fixes rather than
a wholesale replacement of the series.


 Documentation/admin-guide/mm/transhuge.rst |    5 
 include/trace/events/huge_memory.h         |    3 
 mm/khugepaged.c                            |  121 +++++++++----------
 3 files changed, 66 insertions(+), 63 deletions(-)

--- a/Documentation/admin-guide/mm/transhuge.rst~b
+++ a/Documentation/admin-guide/mm/transhuge.rst
@@ -312,8 +312,9 @@ when collapsing a group of small pages i
 For PMD-sized THP collapse, this directly limits the number of empty pages
 allowed in the 2MB region.
 
-For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. Any other value
-will emit a warning and no mTHP collapse will be attempted.
+For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. At
+HPAGE_PMD_NR - 1, we collapse to the highest possible order. Any intermediate
+value will emit a warning and mTHP collapse will default to max_ptes_none=0.
 
 A higher value allows more empty pages, potentially leading to more memory
 usage but better THP performance. A lower value is more conservative and
--- a/include/trace/events/huge_memory.h~b
+++ a/include/trace/events/huge_memory.h
@@ -39,8 +39,7 @@
 	EM( SCAN_STORE_FAILED,		"store_failed")			\
 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
 	EM( SCAN_PAGE_FILLED,		"page_filled")			\
-	EM(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")	\
-	EMe(SCAN_INVALID_PTES_NONE,	"invalid_ptes_none")
+	EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
 
 #undef EM
 #undef EMe
--- a/mm/khugepaged.c~b
+++ a/mm/khugepaged.c
@@ -61,7 +61,6 @@ enum scan_result {
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
 	SCAN_PAGE_DIRTY_OR_WRITEBACK,
-	SCAN_INVALID_PTES_NONE,
 };
 
 #define CREATE_TRACE_POINTS
@@ -380,41 +379,43 @@ static bool pte_none_or_zero(pte_t pte)
 }
 
 /**
- * collapse_max_ptes_none - Calculate maximum allowed none-page or zero-page
- * PTEs for the given collapse operation.
+ * collapse_max_ptes_none - Calculate maximum allowed empty PTEs or PTEs mapping
+ * the shared zeropage for the given collapse operation.
  * @cc: The collapse control struct
  * @vma: The vma to check for userfaultfd
  * @order: The folio order being collapsed to
  *
- * Return: Maximum number of none-page or zero-page PTEs allowed for the
- * collapse operation.
+ * Return: Maximum number of empty/shared zeropage PTEs for the collapse operation
  */
-static int collapse_max_ptes_none(struct collapse_control *cc,
+static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
 		struct vm_area_struct *vma, unsigned int order)
 {
 	unsigned int max_ptes_none = khugepaged_max_ptes_none;
-	// If the vma is userfaultfd-armed, allow no none-page or zero-page PTEs.
+
 	if (vma && userfaultfd_armed(vma))
 		return 0;
-	// for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
+	/* for MADV_COLLAPSE, allow any empty/shared zeropage PTEs */
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
-	// for PMD collapse, respect the user defined maximum.
+	/* for PMD collapse, respect the user defined maximum */
 	if (is_pmd_order(order))
 		return max_ptes_none;
-	/* Zero/non-present collapse disabled. */
-	if (!max_ptes_none)
-		return 0;
-	// for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
-	// scale the maximum number of PTEs to the order of the collapse.
+	/*
+	 * for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_PTES_LIMIT,
+	 * scale the maximum number of PTEs to the order of the collapse.
+	 */
 	if (max_ptes_none == KHUGEPAGED_MAX_PTES_LIMIT)
 		return (1 << order) - 1;
-
-	// We currently only support max_ptes_none values of 0 or KHUGEPAGED_MAX_PTES_LIMIT.
-	// Emit a warning and return -EINVAL.
-	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
-		      KHUGEPAGED_MAX_PTES_LIMIT);
-	return -EINVAL;
+	if (!max_ptes_none)
+		return 0;
+	/*
+	 * For mTHP collapse of values other than 0 or KHUGEPAGED_MAX_PTES_LIMIT,
+	 * emit a warning and return 0.
+	 */
+	pr_warn_once("mTHP collapse does not support max_ptes_none values"
+		     " other than 0 or %u, defaulting to 0.\n",
+		     KHUGEPAGED_MAX_PTES_LIMIT);
+	return 0;
 }
 
 /**
@@ -429,15 +430,19 @@ static int collapse_max_ptes_none(struct
 static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
 		unsigned int order)
 {
-	// for MADV_COLLAPSE, do not restrict the number of PTEs that map shared
-	// anonymous pages.
+	/*
+	 * For MADV_COLLAPSE, do not restrict the number of PTEs that map shared
+	 * anonymous pages.
+	 */
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
-	// for mTHP collapse do not allow collapsing anonymous memory pages that
-	// are shared between processes.
+	/*
+	 * for mTHP collapse do not allow collapsing anonymous memory pages that
+	 * are shared between processes.
+	 */
 	if (!is_pmd_order(order))
 		return 0;
-	// for PMD collapse, respect the user defined maximum.
+	/* for PMD collapse, respect the user defined maximum */
 	return khugepaged_max_ptes_shared;
 }
 
@@ -453,14 +458,16 @@ static unsigned int collapse_max_ptes_sh
 static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
 		unsigned int order)
 {
-	// for MADV_COLLAPSE, do not restrict the number PTEs entries or
-	// pagecache entries that are non-present.
+	/*
+	 * For MADV_COLLAPSE, do not restrict the number PTEs entries or
+	 * pagecache entries that are non-present.
+	 */
 	if (!cc->is_khugepaged)
 		return HPAGE_PMD_NR;
-	// for mTHP collapse do not allow any non-present PTEs or pagecache entries.
+	/* for mTHP collapse do not allow any non-present PTEs or pagecache entries */
 	if (!is_pmd_order(order))
 		return 0;
-	// for PMD collapse, respect the user defined maximum.
+	/* for PMD collapse, respect the user defined maximum */
 	return khugepaged_max_ptes_swap;
 }
 
@@ -593,9 +600,8 @@ static unsigned long collapse_allowable_
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
-	    collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED) &&
-	    hugepage_enabled())
+	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) && hugepage_enabled()
+	    && collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED))
 		__khugepaged_enter(vma->vm_mm);
 }
 
@@ -670,6 +676,8 @@ static enum scan_result __collapse_huge_
 		unsigned long start_addr, pte_t *pte, struct collapse_control *cc,
 		unsigned int order, struct list_head *compound_pagelist)
 {
+	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, order);
+	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, order);
 	const unsigned long nr_pages = 1UL << order;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
@@ -677,11 +685,6 @@ static enum scan_result __collapse_huge_
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
-	int max_ptes_none = collapse_max_ptes_none(cc, vma, order);
-	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, order);
-
-	if (max_ptes_none < 0)
-		return SCAN_INVALID_PTES_NONE;
 
 	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
@@ -1136,6 +1139,10 @@ static enum scan_result check_pmd_still_
  * Bring missing pages in from swap, to complete THP collapse.
  * Only done if khugepaged_scan_pmd believes it is worthwhile.
  *
+ * For mTHP orders the function bails on the first swap entry, because
+ * faulting pages back in during collapse could re-populate PTEs that
+ * push a later scan over the threshold for a higher-order collapse.
+ *
  * Called and returns without pte mapped or spinlocks held.
  * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
  */
@@ -1257,19 +1264,18 @@ static enum scan_result alloc_charge_fol
 		return SCAN_CGROUP_CHARGE_FAIL;
 	}
 
-	count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
+	if (is_pmd_order(order))
+		count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
 
 	*foliop = folio;
 	return SCAN_SUCCEED;
 }
 
 /*
- * collapse_huge_page expects the mmap_read_lock to be dropped before
- * entering this function. The function will also always return with the lock
- * dropped. The function starts by allocation a folio, which can potentially
- * take a long time if it involves sync compaction, and we do not need to hold
- * the mmap_lock during that. We must recheck the vma after taking it again in
- * write mode.
+ * collapse_huge_page expects the mmap_lock to be unlocked before entering and
+ * will always return with the lock unlocked, to avoid holding the mmap_lock
+ * while allocating a THP, as that could trigger direct reclaim/compaction.
+ * Note that the VMA must be rechecked after grabbing the mmap_lock again.
  */
 static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long start_addr,
 		int referenced, int unmapped, struct collapse_control *cc,
@@ -1500,12 +1506,12 @@ static unsigned int collapse_mthp_count_
  * If a collapse is permitted, we attempt to collapse the PTE range into a
  * mTHP.
  */
-static int mthp_collapse(struct mm_struct *mm, unsigned long address,
-		int referenced, int unmapped, struct collapse_control *cc,
-		unsigned long enabled_orders)
+static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, int referenced, int unmapped,
+		struct collapse_control *cc, unsigned long enabled_orders)
 {
-	unsigned int nr_occupied_ptes, nr_ptes;
-	int max_ptes_none, collapsed = 0, stack_size = 0;
+	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
+	int collapsed = 0, stack_size = 0;
 	unsigned long collapse_address;
 	struct mthp_range range;
 	u16 offset;
@@ -1522,10 +1528,7 @@ static int mthp_collapse(struct mm_struc
 		if (!test_bit(order, &enabled_orders))
 			goto next_order;
 
-		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
-
-		if (max_ptes_none < 0)
-			return collapsed;
+		max_ptes_none = collapse_max_ptes_none(cc, vma, order);
 
 		nr_occupied_ptes = collapse_mthp_count_present(cc, offset,
 							       nr_ptes);
@@ -1565,7 +1568,7 @@ static int mthp_collapse(struct mm_struc
 		}
 
 next_order:
-		if (order > KHUGEPAGED_MIN_MTHP_ORDER) {
+		if ((BIT(order) - 1) & enabled_orders) {
 			const u8 next_order = order - 1;
 			const u16 mid_offset = offset + (nr_ptes / 2);
 
@@ -1582,9 +1585,9 @@ static enum scan_result collapse_scan_pm
 		struct vm_area_struct *vma, unsigned long start_addr,
 		bool *lock_dropped, struct collapse_control *cc)
 {
-	int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
 	const unsigned int max_ptes_shared = collapse_max_ptes_shared(cc, HPAGE_PMD_ORDER);
 	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma, HPAGE_PMD_ORDER);
 	enum tva_type tva_flags = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
 	pmd_t *pmd;
 	pte_t *pte, *_pte, pteval;
@@ -1772,9 +1775,9 @@ out_unmap:
 	if (result == SCAN_SUCCEED) {
 		/* collapse_huge_page expects the lock to be dropped before calling */
 		mmap_read_unlock(mm);
-		nr_collapsed = mthp_collapse(mm, start_addr, referenced, unmapped,
-					      cc, enabled_orders);
-		/* collapse_huge_page will return with the mmap_lock released */
+		nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
+					     unmapped, cc, enabled_orders);
+		/* mmap_lock was released above, set lock_dropped */
 		*lock_dropped = true;
 		result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
 	}
@@ -2665,7 +2668,7 @@ static enum scan_result collapse_scan_fi
 		unsigned long addr, struct file *file, pgoff_t start,
 		struct collapse_control *cc)
 {
-	const int max_ptes_none = collapse_max_ptes_none(cc, NULL, HPAGE_PMD_ORDER);
+	const unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL, HPAGE_PMD_ORDER);
 	const unsigned int max_ptes_swap = collapse_max_ptes_swap(cc, HPAGE_PMD_ORDER);
 	struct folio *folio = NULL;
 	struct address_space *mapping = file->f_mapping;
_

