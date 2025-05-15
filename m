Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E301A28D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279411; cv=none; b=dshTSaKbAWlRYXIcipwP/KnT3pLRLC5COLmTirDJG+Pmn8UcigIrWOkjQhkqVef2cwslfK4+AnuMXxGBeDjGski1ORqXkaLqRHe+Lwcxf6+mnxVLw3pgyJR03Yz9x05mec0pHGDXUz2Cb1ha6DdgrGl0jjbgRRHM91JvaprIswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279411; c=relaxed/simple;
	bh=rZG0W9gShX8ZkarrXn4Q4mdgOrT70bhWKNb+0D824YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7hAUQJuvCKkgOCIvnt/yLMZe5Vq5trZlcskb1pDis9aIfxrOnPysCKw2nxG/ONvFNm1+9Yj4PvzvkJUZ1lSCmItpK5FscrO5ERMdmV26XVTw4mxjCxfpEF+GOXdQvYMLvn4YQeugUTKsa55M2j1rTz+FrriwykNjHrchpo2eUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DveS7EBW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DveS7EBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747279408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syVueP3EsNMt8QnyrnfxvyQxJqj9XQQFWMPiuMj2fdA=;
	b=DveS7EBWf7V6Kv/hXsfEmV/4nM0SuNJEqAb7x0rACraUU0P0pc1CLxvhceS8PJuwetcL6r
	SYsp11M2x2zJhVkTsnVViy45tZNqEncfhLQHfRZTM8RIH7EthgOfg2AnZS+aZj4+lN2FuX
	XeRjip0FfM1H2T440yGCSJ8PD6D6w18=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-khFgA3_wMOaUfFhSrHMoIw-1; Wed,
 14 May 2025 23:23:25 -0400
X-MC-Unique: khFgA3_wMOaUfFhSrHMoIw-1
X-Mimecast-MFC-AGG-ID: khFgA3_wMOaUfFhSrHMoIw_1747279401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3F5D180048E;
	Thu, 15 May 2025 03:23:20 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61E5518008F4;
	Thu, 15 May 2025 03:23:04 +0000 (UTC)
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
Subject: [PATCH v7 02/12] introduce khugepaged_collapse_single_pmd to unify khugepaged and madvise_collapse
Date: Wed, 14 May 2025 21:22:16 -0600
Message-ID: <20250515032226.128900-3-npache@redhat.com>
In-Reply-To: <20250515032226.128900-1-npache@redhat.com>
References: <20250515032226.128900-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The khugepaged daemon and madvise_collapse have two different
implementations that do almost the same thing.

Create khugepaged_collapse_single_pmd to increase code
reuse and create an entry point for future khugepaged changes.

Refactor madvise_collapse and khugepaged_scan_mm_slot to use
the new khugepaged_collapse_single_pmd function.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 806bcd8c5185..5457571d505a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2353,6 +2353,48 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
+/*
+ * Try to collapse a single PMD starting at a PMD aligned addr, and return
+ * the results.
+ */
+static int khugepaged_collapse_single_pmd(unsigned long addr,
+				   struct vm_area_struct *vma, bool *mmap_locked,
+				   struct collapse_control *cc)
+{
+	int result = SCAN_FAIL;
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
+		struct file *file = get_file(vma->vm_file);
+		pgoff_t pgoff = linear_page_index(vma, addr);
+
+		mmap_read_unlock(mm);
+		*mmap_locked = false;
+		result = khugepaged_scan_file(mm, addr, file, pgoff, cc);
+		fput(file);
+		if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
+			mmap_read_lock(mm);
+			*mmap_locked = true;
+			if (khugepaged_test_exit_or_disable(mm)) {
+				result = SCAN_ANY_PROCESS;
+				goto end;
+			}
+			result = collapse_pte_mapped_thp(mm, addr,
+							 !cc->is_khugepaged);
+			if (result == SCAN_PMD_MAPPED)
+				result = SCAN_SUCCEED;
+			mmap_read_unlock(mm);
+			*mmap_locked = false;
+		}
+	} else {
+		result = khugepaged_scan_pmd(mm, vma, addr, mmap_locked, cc);
+	}
+	if (cc->is_khugepaged && result == SCAN_SUCCEED)
+		++khugepaged_pages_collapsed;
+end:
+	return result;
+}
+
 static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 					    struct collapse_control *cc)
 	__releases(&khugepaged_mm_lock)
@@ -2427,34 +2469,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
-			if (!vma_is_anonymous(vma)) {
-				struct file *file = get_file(vma->vm_file);
-				pgoff_t pgoff = linear_page_index(vma,
-						khugepaged_scan.address);
-
-				mmap_read_unlock(mm);
-				mmap_locked = false;
-				*result = hpage_collapse_scan_file(mm,
-					khugepaged_scan.address, file, pgoff, cc);
-				fput(file);
-				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
-					mmap_read_lock(mm);
-					if (hpage_collapse_test_exit_or_disable(mm))
-						goto breakouterloop;
-					*result = collapse_pte_mapped_thp(mm,
-						khugepaged_scan.address, false);
-					if (*result == SCAN_PMD_MAPPED)
-						*result = SCAN_SUCCEED;
-					mmap_read_unlock(mm);
-				}
-			} else {
-				*result = hpage_collapse_scan_pmd(mm, vma,
-					khugepaged_scan.address, &mmap_locked, cc);
-			}
-
-			if (*result == SCAN_SUCCEED)
-				++khugepaged_pages_collapsed;
 
+			*result = khugepaged_collapse_single_pmd(khugepaged_scan.address,
+						vma, &mmap_locked, cc);
+			/* If we return SCAN_ANY_PROCESS we are holding the mmap_lock */
+			if (*result == SCAN_ANY_PROCESS)
+				goto breakouterloop;
 			/* move to next address */
 			khugepaged_scan.address += HPAGE_PMD_SIZE;
 			progress += HPAGE_PMD_NR;
@@ -2773,36 +2793,18 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
 		nodes_clear(cc->alloc_nmask);
-		if (!vma_is_anonymous(vma)) {
-			struct file *file = get_file(vma->vm_file);
-			pgoff_t pgoff = linear_page_index(vma, addr);
 
-			mmap_read_unlock(mm);
-			mmap_locked = false;
-			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
-							  cc);
-			fput(file);
-		} else {
-			result = hpage_collapse_scan_pmd(mm, vma, addr,
-							 &mmap_locked, cc);
-		}
+		result = khugepaged_collapse_single_pmd(addr, vma, &mmap_locked, cc);
+
 		if (!mmap_locked)
 			*prev = NULL;  /* Tell caller we dropped mmap_lock */
 
-handle_result:
 		switch (result) {
 		case SCAN_SUCCEED:
 		case SCAN_PMD_MAPPED:
 			++thps;
 			break;
 		case SCAN_PTE_MAPPED_HUGEPAGE:
-			BUG_ON(mmap_locked);
-			BUG_ON(*prev);
-			mmap_read_lock(mm);
-			result = collapse_pte_mapped_thp(mm, addr, true);
-			mmap_read_unlock(mm);
-			goto handle_result;
-		/* Whitelisted set of results where continuing OK */
 		case SCAN_PMD_NULL:
 		case SCAN_PTE_NON_PRESENT:
 		case SCAN_PTE_UFFD_WP:
-- 
2.49.0

