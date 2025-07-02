Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AF1FAC4A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435995; cv=none; b=U0Q0fuo11+EpunABCi5+TgpBKLqp10IfpcyHBaVYJNoi6JNi63gLaTV6Yqe5odJR+i6V6KqpzTvRUAczM+kqnQKlmWjzjuBCFqPccp4ebwKtSFDOFzznopcgAyODDCDSG/kvlJZ35QDhfA1qyhLW9K27C3c53YjE0xTJ7qEdNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435995; c=relaxed/simple;
	bh=1JRxXv/vT4tubdq8u46J7Pglj5F5ADS+7/ZJ18EuI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcqWwAHxOT9D3AKlo55rrFzyqTTRl6MuJpA3OMoEPbnBWYzR66mEx65zv4FUkwY39aGpgaLHtI50BWoApWFem17YxKHJ5cN+vEKWmIEn7412G/r6SAB7gOuYIIZ62PgW8yflHXrw3h6wQYAuOB6UfMNqh7KJp6yc0pRhdJjvjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUjZL9Lx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUjZL9Lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751435992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIH9BDMaqlzsWlJNg+YrL5p/TLctNhwLDQLMETbbVIg=;
	b=JUjZL9LxHWObZoZ7I+54YsVkR5SjwgLzZ2mPX2xp74gD7IAP3Rns7mSTI5Z4s0DHfHScNe
	TmAtDlgy9kjhDFtA4qvCux94jFGLbC9OXh6GYfTrZaGZVWHTLS/+SXZabIDiZZiCGmOtqX
	ZcbjFOBTI+g6q3viZBlgRwHsGZqX8WA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-azsAXXNdMmySHwJ0VGwUkg-1; Wed,
 02 Jul 2025 01:59:49 -0400
X-MC-Unique: azsAXXNdMmySHwJ0VGwUkg-1
X-Mimecast-MFC-AGG-ID: azsAXXNdMmySHwJ0VGwUkg_1751435985
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B8BF1955EC1;
	Wed,  2 Jul 2025 05:59:44 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66DED18003FC;
	Wed,  2 Jul 2025 05:59:29 +0000 (UTC)
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
Subject: [PATCH v8 05/15] khugepaged: generalize __collapse_huge_page_* for mTHP support
Date: Tue,  1 Jul 2025 23:57:32 -0600
Message-ID: <20250702055742.102808-6-npache@redhat.com>
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

generalize the order of the __collapse_huge_page_* functions
to support future mTHP collapse.

mTHP collapse can suffer from incosistant behavior, and memory waste
"creep". disable swapin and shared support for mTHP collapse.

No functional changes in this patch.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5ff4a5bdf5f6..7a176f3b7729 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -552,15 +552,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long address,
 					pte_t *pte,
 					struct collapse_control *cc,
-					struct list_head *compound_pagelist)
+					struct list_head *compound_pagelist,
+					u8 order)
 {
 	struct page *page = NULL;
 	struct folio *folio = NULL;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
 	bool writable = false;
+	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + (1 << order);
 	     _pte++, address += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none(pteval) || (pte_present(pteval) &&
@@ -568,7 +570,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
+			     none_or_zero <= scaled_none)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -596,8 +598,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		/* See hpage_collapse_scan_pmd(). */
 		if (folio_maybe_mapped_shared(folio)) {
 			++shared;
-			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
+			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
+			    shared > khugepaged_max_ptes_shared)) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out;
@@ -698,13 +700,14 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						struct vm_area_struct *vma,
 						unsigned long address,
 						spinlock_t *ptl,
-						struct list_head *compound_pagelist)
+						struct list_head *compound_pagelist,
+						u8 order)
 {
 	struct folio *src, *tmp;
 	pte_t *_pte;
 	pte_t pteval;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + (1 << order);
 	     _pte++, address += PAGE_SIZE) {
 		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
@@ -751,7 +754,8 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 					     pmd_t *pmd,
 					     pmd_t orig_pmd,
 					     struct vm_area_struct *vma,
-					     struct list_head *compound_pagelist)
+					     struct list_head *compound_pagelist,
+					     u8 order)
 {
 	spinlock_t *pmd_ptl;
 
@@ -768,7 +772,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * Release both raw and compound pages isolated
 	 * in __collapse_huge_page_isolate.
 	 */
-	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
+	release_pte_pages(pte, pte + (1 << order), compound_pagelist);
 }
 
 /*
@@ -789,7 +793,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
 		unsigned long address, spinlock_t *ptl,
-		struct list_head *compound_pagelist)
+		struct list_head *compound_pagelist, u8 order)
 {
 	unsigned int i;
 	int result = SCAN_SUCCEED;
@@ -797,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 	/*
 	 * Copying pages' contents is subject to memory poison at any iteration.
 	 */
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < (1 << order); i++) {
 		pte_t pteval = ptep_get(pte + i);
 		struct page *page = folio_page(folio, i);
 		unsigned long src_addr = address + i * PAGE_SIZE;
@@ -816,10 +820,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 
 	if (likely(result == SCAN_SUCCEED))
 		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
-						    compound_pagelist);
+						    compound_pagelist, order);
 	else
 		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
-						 compound_pagelist);
+						 compound_pagelist, order);
 
 	return result;
 }
@@ -986,11 +990,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
 static int __collapse_huge_page_swapin(struct mm_struct *mm,
 				       struct vm_area_struct *vma,
 				       unsigned long haddr, pmd_t *pmd,
-				       int referenced)
+				       int referenced, u8 order)
 {
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
-	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+	unsigned long address, end = haddr + (PAGE_SIZE << order);
 	int result;
 	pte_t *pte = NULL;
 	spinlock_t *ptl;
@@ -1021,6 +1025,14 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;
 
+		/* Dont swapin for mTHP collapse */
+		if (order != HPAGE_PMD_ORDER) {
+			pte_unmap(pte);
+			mmap_read_unlock(mm);
+			result = SCAN_EXCEED_SWAP_PTE;
+			goto out;
+		}
+
 		vmf.pte = pte;
 		vmf.ptl = ptl;
 		ret = do_swap_page(&vmf);
@@ -1141,7 +1153,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
 		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced);
+				referenced, HPAGE_PMD_ORDER);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
@@ -1189,7 +1201,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-						      &compound_pagelist);
+					&compound_pagelist, HPAGE_PMD_ORDER);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
@@ -1219,7 +1231,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
-					   &compound_pagelist);
+					   &compound_pagelist, HPAGE_PMD_ORDER);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
 		goto out_up_write;
-- 
2.49.0

