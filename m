Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4451EB2F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848432; cv=none; b=Cl6mUriJ+ySL1cKGvXKFDcIXK2ZcTSDlf7ZXtI/yNUGBDppiC2JuTD2CvjQBudyiCyIT+y4PlVKA+savArKLFMiGUbMv6Qc5lfo800NtcwDhTg64iWCxkjMKKnhAcBPv+QPEucMVcNl2o5TnV0+tvhC7nqCcV+MxQfjLWhw21FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848432; c=relaxed/simple;
	bh=3e1+MZWGpKfoFUphx5evAJ085wtOt2CNl6Hdg2o56e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddO7fAHb+a6lVJbOSpqBuJsAb5MJ/PQiYfdk4HsnuhYamN7ummBHqe4Fyhs7A400VGQRZo066jMzpK9OEYTtYoWloGfbXYCGpwLQwHhvPG65anLsI/DMgWauliObgR3/dzAq86roj1UZ+yaNRb/Rcct4JqnFF+kOGNP7EizcS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3Alol9A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3Alol9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744848430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rsu+kW9XQvd8cb4ogIt+3inIZ/x/N8vglI6dddRaN8M=;
	b=Q3Alol9A5V6NOLWuRyPxMcaYXf0jx0OrO/jbnwZ5MgmPCprCA5DbXRalwCk5MKz7uOS4qB
	Ld0SWHWhlgpI6dKR0BYgB+mL0CxbnsHDhZ1oR/s3g47MmFATWmyKybVRobxXW+5gUSOI3F
	H7MMkBGaPXXBuejWealx1r8XmmgZ/vQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-O2DxmUD9M1aq1EuL9WBcpA-1; Wed,
 16 Apr 2025 20:07:07 -0400
X-MC-Unique: O2DxmUD9M1aq1EuL9WBcpA-1
X-Mimecast-MFC-AGG-ID: O2DxmUD9M1aq1EuL9WBcpA_1744848422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DCD2180034A;
	Thu, 17 Apr 2025 00:07:02 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D3D1180176A;
	Thu, 17 Apr 2025 00:06:54 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
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
Subject: [PATCH v4 07/12] khugepaged: add mTHP support
Date: Wed, 16 Apr 2025 18:02:33 -0600
Message-ID: <20250417000238.74567-8-npache@redhat.com>
In-Reply-To: <20250417000238.74567-1-npache@redhat.com>
References: <20250417000238.74567-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 34 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 83230e9cdf3a..ece39fd71fe6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1136,13 +1136,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 {
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
-	pte_t *pte;
+	pte_t *pte, mthp_pte;
 	pgtable_t pgtable;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	int result = SCAN_FAIL;
 	struct vm_area_struct *vma;
 	struct mmu_notifier_range range;
+	unsigned long _address = address + offset * PAGE_SIZE;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -1158,12 +1159,13 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		*mmap_locked = false;
 	}
 
-	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
+	result = alloc_charge_folio(&folio, mm, cc, order);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
 
 	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
+	*mmap_locked = true;
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
 	if (result != SCAN_SUCCEED) {
 		mmap_read_unlock(mm);
 		goto out_nolock;
@@ -1181,13 +1183,14 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
@@ -1197,7 +1200,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, order);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
@@ -1226,10 +1230,10 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
@@ -1258,8 +1262,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
-					   vma, address, pte_ptl,
-					   &compound_pagelist, HPAGE_PMD_ORDER);
+					   vma, _address, pte_ptl,
+					   &compound_pagelist, order);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
 		goto out_up_write;
@@ -1270,20 +1274,35 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
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
+	} else { //mTHP
+		mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
+		mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
+
+		spin_lock(pmd_ptl);
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
 
@@ -1364,31 +1383,58 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
+
+			chunk_none_count = 0;
+		}
+
+		_pte = pte + i;
+		_address = address + i * PAGE_SIZE;
 		pte_t pteval = ptep_get(_pte);
 		if (is_swap_pte(pteval)) {
 			++unmapped;
@@ -1411,10 +1457,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
@@ -1510,6 +1557,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 								     address)))
 			referenced++;
 	}
+
 	if (!writable) {
 		result = SCAN_PAGE_RO;
 	} else if (cc->is_khugepaged &&
@@ -1522,8 +1570,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
 	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
@@ -2479,11 +2531,13 @@ static int khugepaged_collapse_single_pmd(unsigned long addr,
 			fput(file);
 			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
 				mmap_read_lock(mm);
+				*mmap_locked = true;
 				if (khugepaged_test_exit_or_disable(mm))
 					goto end;
 				result = collapse_pte_mapped_thp(mm, addr,
 								 !cc->is_khugepaged);
 				mmap_read_unlock(mm);
+				*mmap_locked = false;
 			}
 		} else {
 			result = khugepaged_scan_pmd(mm, vma, addr,
-- 
2.48.1

