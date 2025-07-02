Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50901F8ADD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435949; cv=none; b=OfAsg23nVBKWoKyocklPkYUqUjxkQZJCKNXXDP5CeXMTiQY+/yEmS67rE+paEp6FTnqd/o+O1DvrigQc6kJ2bT3c4CpGApZMZo32MnHOhLSihw2k5RebauzRFvnEUTqJmPRrkDjvSDY0oSqTe7NcKgxNndf4YwMTP+T81GmjgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435949; c=relaxed/simple;
	bh=ej7QtjMFRmKKOvyMP8hAoxz47HgxGbvRh5grnaKsYXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCzn/uLtCkNdT4jchuuxgfMyhB7AZ2ipqEDdA8em8LFfdxpPJ1OCwbiKhVwyHkiyI+OV2ECodkyJ1gjkoa/78F7ZRvGGO9mCw/ztSZe89Ykb5Z4vHM/pCewdBNS50fUi0sJz0LNxzjad82M9EzaVHIeHMEQsMSN+8k7VVYsFdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyVSzx47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyVSzx47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751435947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SKcei+/sNkOhdwaQhaPJzluqvYvNAfrvgdfOhPY5dU=;
	b=VyVSzx47OonwC28f21h8My6SOB8xJl7C3EhTxm3cKm7Lynl3S/w49YnCyY3nRZUAEgjLAA
	RO6a54BDueMI1vyYhgmZJ+5E0SolPeo0B5xErrxpM3NUZiGOY6Bx14WMTXd2Nfwny06nOg
	ZcsFZp4mZB/5coYSFcgkBB2++onSoHw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-rDf9V_ijOHOWfnRk4VAVBg-1; Wed,
 02 Jul 2025 01:59:01 -0400
X-MC-Unique: rDf9V_ijOHOWfnRk4VAVBg-1
X-Mimecast-MFC-AGG-ID: rDf9V_ijOHOWfnRk4VAVBg_1751435937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07C69195FD30;
	Wed,  2 Jul 2025 05:58:56 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3581800287;
	Wed,  2 Jul 2025 05:58:39 +0000 (UTC)
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
Subject: [PATCH v8 02/15] introduce khugepaged_collapse_single_pmd to unify khugepaged and madvise_collapse
Date: Tue,  1 Jul 2025 23:57:29 -0600
Message-ID: <20250702055742.102808-3-npache@redhat.com>
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

The khugepaged daemon and madvise_collapse have two different
implementations that do almost the same thing.

Create khugepaged_collapse_single_pmd to increase code reuse and create an
entry point these two users.

Refactor madvise_collapse and khugepaged_scan_mm_slot to use the new
khugepaged_collapse_single_pmd function. This introduces a minor
behavioral change that is most likely an undiscovered bug. The current
implementation of khugepaged tests khugepaged_test_exit_or_disable
before calling khugepaged_pte_mapped_thp, but we weren't doing it in the
madvise_collapse case. By unifying these two callers madvise_collapse
now also performs this check.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f27fe7ca9b86..bf69e81a3d82 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2354,6 +2354,50 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
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
+				mmap_read_unlock(mm);
+				*mmap_locked = false;
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
@@ -2428,34 +2472,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
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
 			/* move to next address */
 			khugepaged_scan.address += HPAGE_PMD_SIZE;
 			progress += HPAGE_PMD_NR;
@@ -2772,35 +2791,19 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
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
 			*lock_dropped = true;
 
-handle_result:
 		switch (result) {
 		case SCAN_SUCCEED:
 		case SCAN_PMD_MAPPED:
 			++thps;
 			break;
-		case SCAN_PTE_MAPPED_HUGEPAGE:
-			BUG_ON(mmap_locked);
-			mmap_read_lock(mm);
-			result = collapse_pte_mapped_thp(mm, addr, true);
-			mmap_read_unlock(mm);
-			goto handle_result;
 		/* Whitelisted set of results where continuing OK */
+		case SCAN_PTE_MAPPED_HUGEPAGE:
 		case SCAN_PMD_NULL:
 		case SCAN_PTE_NON_PRESENT:
 		case SCAN_PTE_UFFD_WP:
-- 
2.49.0

