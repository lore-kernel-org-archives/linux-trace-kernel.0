Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CC1EFF93
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436027; cv=none; b=O5mfli178VKzVB4uGcr0osKcn3BNoaRU6eBKDzTghpyYHWIbLmrmf6C4ZEmQCJiLkEgF9oQPSygSUlPSCxcbrL8mOY+62fBurMdEf/O9jC5WsR5aPDazSDb01dxIoy7RHqv7C04dwMoflTxKY1WjvljDsF6vSpx7gEvnQZ9RUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436027; c=relaxed/simple;
	bh=PCNRiR0tv58myAMxv9Rq9/Fc/h9SDsZWQjtfGknDC2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw8/pN1QH9rFMsZTrOBIpoRptMeVXIreMtHZj0sAbm7FRNuqC335GyA+Y4t8+/IznVX1koCgACUhRwGBzwNEZ9EgF35I5+Bs+pdm8tEPlRLPsCIttzIyTY7+stwFLbJ76P8ed4kHFTF6j03g8GkZuEN8q8qpvQS8panyKSF271Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR6/nJYv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR6/nJYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751436024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0XP3utHs9NNbHopP0WUO88kGA3T6jwUuBhRcDkxWFY=;
	b=GR6/nJYvRGvLOzBzyzYZZoeffTZQJbDahNh5VljAiVqRrbG9nwiHHCLg7+NRftO5AjK8xO
	uMUxfXzu1FywrLhb9ypzQ6G8F1iGjSPQtIOans0uxQk98/t3D/27C0qHL60z824poQ4F3K
	WxfxhI14KBxym89gv5ziavMpdmf4HUc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-P9pgslO0Nc6aXLvNMw9oBg-1; Wed,
 02 Jul 2025 02:00:20 -0400
X-MC-Unique: P9pgslO0Nc6aXLvNMw9oBg-1
X-Mimecast-MFC-AGG-ID: P9pgslO0Nc6aXLvNMw9oBg_1751436016
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31CE1180029E;
	Wed,  2 Jul 2025 06:00:16 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9BD318003FC;
	Wed,  2 Jul 2025 06:00:00 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v8 07/15] khugepaged: add mTHP support
Date: Tue,  1 Jul 2025 23:57:34 -0600
Message-ID: <20250702055742.102808-8-npache@redhat.com>
In-Reply-To: <20250702055742.102808-1-npache@redhat.com>
References: <20250702055742.102808-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce the ability for khugepaged to collapse to different mTHP sizes.
While scanning PMD ranges for potential collapse candidates, keep track
of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
mTHPs are enabled we remove the restriction of max_ptes_none during the
scan phase so we dont bailout early and miss potential mTHP candidates.

After the scan is complete we will perform binary recursion on the
bitmap to determine which mTHP size would be most efficient to collapse
to. max_ptes_none will be scaled by the attempted collapse order to
determine how full a THP must be to be eligible.

If a mTHP collapse is attempted, but contains swapped out, or shared
pages, we dont perform the collapse.

For non-PMD collapse we must leave the anon VMA write locked until after
we collapse the mTHP-- in the PMD case all the pages are isolated, but in
the non-PMD case this is not true, and we must keep the lock to prevent
changes to the VMA from occurring.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 139 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 43 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5e8496398afd..a42f08edb0e4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1124,13 +1124,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 {
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
-	pte_t *pte;
+	pte_t *pte = NULL, mthp_pte;
 	pgtable_t pgtable;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	int result = SCAN_FAIL;
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
+	unsigned long _address = address + offset * PAGE_SIZE;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -1146,13 +1147,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		*mmap_locked = false;
 	}
 
-	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
+	result = alloc_charge_folio(&folio, mm, cc, order);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
 
 	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
-					 BIT(HPAGE_PMD_ORDER));
+	*mmap_locked = true;
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, BIT(order));
 	if (result != SCAN_SUCCEED) {
 		mmap_read_unlock(mm);
 		goto out_nolock;
@@ -1170,13 +1171,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 * released when it fails. So we jump out_nolock directly in
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
-		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-				referenced, HPAGE_PMD_ORDER);
+		result = __collapse_huge_page_swapin(mm, vma, _address, pmd,
+				referenced, order);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
 
 	mmap_read_unlock(mm);
+	*mmap_locked = false;
 	/*
 	 * Prevent all access to pagetables with the exception of
 	 * gup_fast later handled by the ptep_clear_flush and the VM
@@ -1186,8 +1188,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
-					 BIT(HPAGE_PMD_ORDER));
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, BIT(order));
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -1198,11 +1199,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
-				address + HPAGE_PMD_SIZE);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
+				_address + (PAGE_SIZE << order));
 	mmu_notifier_invalidate_range_start(&range);
 
 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
+
 	/*
 	 * This removes any huge TLB entry from the CPU so we won't allow
 	 * huge and small TLB entries for the same virtual address to
@@ -1216,18 +1218,16 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_remove_table_sync_one();
 
-	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
+	pte = pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
 	if (pte) {
-		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-					&compound_pagelist, HPAGE_PMD_ORDER);
+		result = __collapse_huge_page_isolate(vma, _address, pte, cc,
+					&compound_pagelist, order);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
 	}
 
 	if (unlikely(result != SCAN_SUCCEED)) {
-		if (pte)
-			pte_unmap(pte);
 		spin_lock(pmd_ptl);
 		BUG_ON(!pmd_none(*pmd));
 		/*
@@ -1242,17 +1242,17 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	}
 
 	/*
-	 * All pages are isolated and locked so anon_vma rmap
-	 * can't run anymore.
+	 * For PMD collapse all pages are isolated and locked so anon_vma
+	 * rmap can't run anymore
 	 */
-	anon_vma_unlock_write(vma->anon_vma);
+	if (order == HPAGE_PMD_ORDER)
+		anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
-					   vma, address, pte_ptl,
-					   &compound_pagelist, HPAGE_PMD_ORDER);
-	pte_unmap(pte);
+					   vma, _address, pte_ptl,
+					   &compound_pagelist, order);
 	if (unlikely(result != SCAN_SUCCEED))
-		goto out_up_write;
+		goto out_unlock_anon_vma;
 
 	/*
 	 * The smp_wmb() inside __folio_mark_uptodate() ensures the
@@ -1260,25 +1260,46 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * write.
 	 */
 	__folio_mark_uptodate(folio);
-	pgtable = pmd_pgtable(_pmd);
-
-	_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
-	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
-
-	spin_lock(pmd_ptl);
-	BUG_ON(!pmd_none(*pmd));
-	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
-	folio_add_lru_vma(folio, vma);
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
-	set_pmd_at(mm, address, pmd, _pmd);
-	update_mmu_cache_pmd(vma, address, pmd);
-	deferred_split_folio(folio, false);
-	spin_unlock(pmd_ptl);
+	if (order == HPAGE_PMD_ORDER) {
+		pgtable = pmd_pgtable(_pmd);
+		_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
+		_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
+
+		spin_lock(pmd_ptl);
+		BUG_ON(!pmd_none(*pmd));
+		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
+		folio_add_lru_vma(folio, vma);
+		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		set_pmd_at(mm, address, pmd, _pmd);
+		update_mmu_cache_pmd(vma, address, pmd);
+		deferred_split_folio(folio, false);
+		spin_unlock(pmd_ptl);
+	} else { /* mTHP collapse */
+		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
+		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
+
+		spin_lock(pmd_ptl);
+		BUG_ON(!pmd_none(*pmd));
+		folio_ref_add(folio, (1 << order) - 1);
+		folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUSIVE);
+		folio_add_lru_vma(folio, vma);
+		set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order));
+		update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
+
+		smp_wmb(); /* make pte visible before pmd */
+		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
+		spin_unlock(pmd_ptl);
+	}
 
 	folio = NULL;
 
 	result = SCAN_SUCCEED;
+out_unlock_anon_vma:
+	if (order != HPAGE_PMD_ORDER)
+		anon_vma_unlock_write(vma->anon_vma);
 out_up_write:
+	if (pte)
+		pte_unmap(pte);
 	mmap_write_unlock(mm);
 out_nolock:
 	*mmap_locked = false;
@@ -1354,31 +1375,57 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 {
 	pmd_t *pmd;
 	pte_t *pte, *_pte;
+	int i;
 	int result = SCAN_FAIL, referenced = 0;
 	int none_or_zero = 0, shared = 0;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
 	unsigned long _address;
+	unsigned long enabled_orders;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
+	bool is_pmd_only;
 	bool writable = false;
-
+	int chunk_none_count = 0;
+	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	result = find_pmd_or_thp_or_none(mm, address, &pmd);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
+	bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
+	bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
+	enabled_orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+		tva_flags, THP_ORDERS_ALL_ANON);
+
+	is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
+
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!pte) {
 		result = SCAN_PMD_NULL;
 		goto out;
 	}
 
-	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
-	     _pte++, _address += PAGE_SIZE) {
+	for (i = 0; i < HPAGE_PMD_NR; i++) {
+		/*
+		 * we are reading in KHUGEPAGED_MIN_MTHP_NR page chunks. if
+		 * there are pages in this chunk keep track of it in the bitmap
+		 * for mTHP collapsing.
+		 */
+		if (i % KHUGEPAGED_MIN_MTHP_NR == 0) {
+			if (chunk_none_count <= scaled_none)
+				bitmap_set(cc->mthp_bitmap,
+					   i / KHUGEPAGED_MIN_MTHP_NR, 1);
+			chunk_none_count = 0;
+		}
+
+		_pte = pte + i;
+		_address = address + i * PAGE_SIZE;
 		pte_t pteval = ptep_get(_pte);
 		if (is_swap_pte(pteval)) {
 			++unmapped;
@@ -1401,10 +1448,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			}
 		}
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+			++chunk_none_count;
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
+			    (!cc->is_khugepaged || !is_pmd_only ||
+				none_or_zero <= khugepaged_max_ptes_none)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -1500,6 +1548,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 								     address)))
 			referenced++;
 	}
+
 	if (!writable) {
 		result = SCAN_PAGE_RO;
 	} else if (cc->is_khugepaged &&
@@ -1512,8 +1561,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
-		result = collapse_huge_page(mm, address, referenced,
-					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
+		result = khugepaged_scan_bitmap(mm, address, referenced, unmapped, cc,
+			       mmap_locked, enabled_orders);
+		if (result > 0)
+			result = SCAN_SUCCEED;
+		else
+			result = SCAN_FAIL;
 	}
 out:
 	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
-- 
2.49.0

