Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD98F77
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848381; cv=none; b=hodbIErF6Lkg5dsy8XQvNJTK9E5cjhQiUQsHwfEvQ1o3vZd8OLtSRk7uUtY8MUbKWitHoZ6O/jKMQ/c+V1TdJqYYVphaZIyIEUKkmDFrbmYOzXYy0ux9W20cJV/DEyMB+GR97NzltV9BWn/bXfNAmHoTTC5xOu5ycs+/EiZdbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848381; c=relaxed/simple;
	bh=fTz2z0ZV7k5YYpPb1mlOMdsidZRgWxe8wViBQfC8f0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjP88QaCEWLS+D8T+igtULKqaOmY2T4FtZceswDYXq/7WXvRRVioryy5x++OoO8ESoWXSgV6MiMc9sTNE8I+C9L1RDVDu+rhZXP5qew+znMJq8d9SYX5qXMzIxmhEr3xIb2IVYXz4Tsd5RbfjGM/q+divxHmi4Rjv8BsFZ139cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLNyt6RP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLNyt6RP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744848379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVq/V6kv0JN45ZLrYl5+wg/xnTqkuoTtgwETvad5uYo=;
	b=aLNyt6RPxujzz3ydXVy8LXkyyLHO4A9LYbOPMi7YNB4z0O7GKLb4Vb+AGSDeuxl2X2AkGn
	RA5msnGsyBBbCQDZLK10AZZuCTd5lC0UqnRJ/Ph95wcsk+FYoyKMDNa4a6UWRQKype4Xmq
	eTIsvRLAN3KxxWKaldda0oF5O50IvjY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-C30RwnqPPOSrXDaLCZZx7Q-1; Wed,
 16 Apr 2025 20:06:14 -0400
X-MC-Unique: C30RwnqPPOSrXDaLCZZx7Q-1
X-Mimecast-MFC-AGG-ID: C30RwnqPPOSrXDaLCZZx7Q_1744848370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8174F1800446;
	Thu, 17 Apr 2025 00:06:08 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 560011800352;
	Thu, 17 Apr 2025 00:05:59 +0000 (UTC)
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
Subject: [PATCH v4 01/12] introduce khugepaged_collapse_single_pmd to unify khugepaged and madvise_collapse
Date: Wed, 16 Apr 2025 18:02:27 -0600
Message-ID: <20250417000238.74567-2-npache@redhat.com>
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

The khugepaged daemon and madvise_collapse have two different
implementations that do almost the same thing.

Create khugepaged_collapse_single_pmd to increase code
reuse and create an entry point for future khugepaged changes.

Refactor madvise_collapse and khugepaged_scan_mm_slot to use
the new khugepaged_collapse_single_pmd function.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 92 ++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8838ba8207a..cecadc4239e7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2363,6 +2363,48 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
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
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+
+	if (thp_vma_allowable_order(vma, vma->vm_flags,
+					tva_flags, PMD_ORDER)) {
+		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
+			struct file *file = get_file(vma->vm_file);
+			pgoff_t pgoff = linear_page_index(vma, addr);
+
+			mmap_read_unlock(mm);
+			*mmap_locked = false;
+			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
+							  cc);
+			fput(file);
+			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
+				mmap_read_lock(mm);
+				if (hpage_collapse_test_exit_or_disable(mm))
+					goto end;
+				result = collapse_pte_mapped_thp(mm, addr,
+								 !cc->is_khugepaged);
+				mmap_read_unlock(mm);
+			}
+		} else {
+			result = hpage_collapse_scan_pmd(mm, vma, addr,
+							 mmap_locked, cc);
+		}
+		if (cc->is_khugepaged && result == SCAN_SUCCEED)
+			++khugepaged_pages_collapsed;
+	}
+end:
+	return result;
+}
+
 static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 					    struct collapse_control *cc)
 	__releases(&khugepaged_mm_lock)
@@ -2437,33 +2479,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
-			if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
-				struct file *file = get_file(vma->vm_file);
-				pgoff_t pgoff = linear_page_index(vma,
-						khugepaged_scan.address);
 
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
@@ -2783,36 +2801,18 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
 		nodes_clear(cc->alloc_nmask);
-		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
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
2.48.1

