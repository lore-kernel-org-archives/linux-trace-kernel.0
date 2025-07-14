Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3D35979
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752453244; cv=none; b=eviqZBHqPi099PgfczKr4t17hB7W2qKbS1BUviIOrZsrmTvLPtMYgjsH41GGJgg3Xl/ahpbu0mygS3hRmAbd5TgbZj25NWjL7VnRXl/VuRce6OAY+acHnqsEWPwtIyFm6tjGtYNuNA3Hrn/nEPyMVWmTfHQnyMiCKmdMzhzXkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752453244; c=relaxed/simple;
	bh=4be4cgW3XfsbhL37Ix2aX+wtirdj7Pt+dk6FcvUFFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXgbmXnpS6BooOaCnHXdhUcMi77P/rtx0lUjZDcwjPnLnxw5WMzlIhlppm/utWR+gRJwAU63bcE1c+e2wSxaHLTRQwIEMgYgVYtRvdJqA6IuFk+0R+yp2XBIAjDcwo5PFfQ1kuW06XkWjAN3gsliaEd3VacO92xQ4XVd3IGlmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmLZSKei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmLZSKei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752453241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoRH+kStQ3aqXNZ/dhK5FJTZj9XLujnqaCkMuiFSjys=;
	b=HmLZSKeiDiS8I1YWQUEaTzZd3lWDSvepl1ikCJnN779nPLvntFOJiy+lvqgrGS9CUeYa/2
	WK/3No7q3S/veDgt6KL2kZes1iFcSX7qd1hbw9xBpPZ/iX/8AR2VTXZgzJIVGmLmn1USwt
	gZ8GuPwX4diwk6IL9XxK/c+fPPCSzXI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-vmakS4vuPsmh1ghP5sKzHw-1; Sun,
 13 Jul 2025 20:33:57 -0400
X-MC-Unique: vmakS4vuPsmh1ghP5sKzHw-1
X-Mimecast-MFC-AGG-ID: vmakS4vuPsmh1ghP5sKzHw_1752453233
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60C1A18011DF;
	Mon, 14 Jul 2025 00:33:53 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7FCD30001A1;
	Mon, 14 Jul 2025 00:33:38 +0000 (UTC)
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
	rdunlap@infradead.org,
	hughd@google.com
Subject: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_* for mTHP support
Date: Sun, 13 Jul 2025 18:31:58 -0600
Message-ID: <20250714003207.113275-6-npache@redhat.com>
In-Reply-To: <20250714003207.113275-1-npache@redhat.com>
References: <20250714003207.113275-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc9a35185604..ee54e3c1db4e 100644
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
@@ -994,11 +998,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
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
@@ -1029,6 +1033,15 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;
 
+		/* Dont swapin for mTHP collapse */
+		if (order != HPAGE_PMD_ORDER) {
+			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
+			pte_unmap(pte);
+			mmap_read_unlock(mm);
+			result = SCAN_EXCEED_SWAP_PTE;
+			goto out;
+		}
+
 		vmf.pte = pte;
 		vmf.ptl = ptl;
 		ret = do_swap_page(&vmf);
@@ -1149,7 +1162,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
 		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced);
+				referenced, HPAGE_PMD_ORDER);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
@@ -1197,7 +1210,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-						      &compound_pagelist);
+					&compound_pagelist, HPAGE_PMD_ORDER);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
@@ -1227,7 +1240,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
-					   &compound_pagelist);
+					   &compound_pagelist, HPAGE_PMD_ORDER);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
 		goto out_up_write;
-- 
2.50.0

