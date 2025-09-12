Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063C23AB8B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647791; cv=none; b=sHI30C9cZnqNU3+hY3Nzzf/kDjCwfUuG6ItMDeiha1vY9VxtXzr+n9vOrVU6ivbbTp4Iv5VOEtptR1ckWdrWAgr1Z9liB0cF4nC2lWsFpGCIQQdVL4uJ+1NF6q/XCg9Le/UDwYPY0zdPPiSlVWqk+GdtAfK8E6R1y1IHoD6Gf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647791; c=relaxed/simple;
	bh=7pqbCJ9/PHYK9lxKpwin8Kj6OUbSQUOWrCq3PNz5MHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNgofX7azp/GAfr7LZKU41F/skvlJL6n1/Apa+3KdBnRPcs+Plfc62doOvuUHcMYoi/iAddbKMr19/cIbLDQ5BKS/XYyekkccK3CPyAcirygCfO1d+lG7iKNouuVl+ysSYW6R7OZBi+IFhhnO7isql9ktgN6O9YnAYbpSb+h2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBI7vAa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBI7vAa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757647789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgAeDXTdH58+NNzWxsAhtBgj8QkDsiIiiAbzGEuCw8U=;
	b=aBI7vAa7ZiaLRg+DAX1gFymAvC3CWsuNDiB1CUMbgSqN0mjhHzhfxOFC55Mi3AH4A3eUT9
	g/JdXbiRV1X4DvZONO/KdS+gz3FOR13IfDCfvhdN28eghEeCbbqdGoNrljh6wPxucMac9C
	/mcZe/RK3xoUmhokFQoFhAPkEvKPZjk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-DbG21aV7NumJcjM1VAnbGg-1; Thu,
 11 Sep 2025 23:29:44 -0400
X-MC-Unique: DbG21aV7NumJcjM1VAnbGg-1
X-Mimecast-MFC-AGG-ID: DbG21aV7NumJcjM1VAnbGg_1757647780
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D4F81955E9A;
	Fri, 12 Sep 2025 03:29:39 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29C631800576;
	Fri, 12 Sep 2025 03:29:28 +0000 (UTC)
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
	kas@kernel.org,
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
	hughd@google.com,
	richard.weiyang@gmail.com,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Subject: [PATCH v11 02/15] introduce collapse_single_pmd to unify khugepaged and madvise_collapse
Date: Thu, 11 Sep 2025 21:27:57 -0600
Message-ID: <20250912032810.197475-3-npache@redhat.com>
In-Reply-To: <20250912032810.197475-1-npache@redhat.com>
References: <20250912032810.197475-1-npache@redhat.com>
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

Create collapse_single_pmd to increase code reuse and create an entry
point to these two users.

Refactor madvise_collapse and collapse_scan_mm_slot to use the new
collapse_single_pmd function. This introduces a minor behavioral change
that is most likely an undiscovered bug. The current implementation of
khugepaged tests collapse_test_exit_or_disable before calling
collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
case. By unifying these two callers madvise_collapse now also performs
this check. We also modify the return value to be SCAN_ANY_PROCESS which
properly indicates that this process is no longer valid to operate on.

We also guard the khugepaged_pages_collapsed variable to ensure its only
incremented for khugepaged.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 97 ++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 40fa6e0a6b2d..63d2ba4b2b6d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2370,6 +2370,53 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
+/*
+ * Try to collapse a single PMD starting at a PMD aligned addr, and return
+ * the results.
+ */
+static int collapse_single_pmd(unsigned long addr,
+		struct vm_area_struct *vma, bool *mmap_locked,
+		struct collapse_control *cc)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int result;
+	struct file *file;
+	pgoff_t pgoff;
+
+	if (vma_is_anonymous(vma)) {
+		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
+		goto end;
+	}
+
+	file = get_file(vma->vm_file);
+	pgoff = linear_page_index(vma, addr);
+
+	mmap_read_unlock(mm);
+	*mmap_locked = false;
+	result = collapse_scan_file(mm, addr, file, pgoff, cc);
+	fput(file);
+	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
+		goto end;
+
+	mmap_read_lock(mm);
+	*mmap_locked = true;
+	if (collapse_test_exit_or_disable(mm)) {
+		mmap_read_unlock(mm);
+		*mmap_locked = false;
+		return SCAN_ANY_PROCESS;
+	}
+	result = collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
+	if (result == SCAN_PMD_MAPPED)
+		result = SCAN_SUCCEED;
+	mmap_read_unlock(mm);
+	*mmap_locked = false;
+
+end:
+	if (cc->is_khugepaged && result == SCAN_SUCCEED)
+		++khugepaged_pages_collapsed;
+	return result;
+}
+
 static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
 					    struct collapse_control *cc)
 	__releases(&khugepaged_mm_lock)
@@ -2443,34 +2490,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
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
-				*result = collapse_scan_file(mm,
-					khugepaged_scan.address, file, pgoff, cc);
-				fput(file);
-				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
-					mmap_read_lock(mm);
-					if (collapse_test_exit_or_disable(mm))
-						goto breakouterloop;
-					*result = collapse_pte_mapped_thp(mm,
-						khugepaged_scan.address, false);
-					if (*result == SCAN_PMD_MAPPED)
-						*result = SCAN_SUCCEED;
-					mmap_read_unlock(mm);
-				}
-			} else {
-				*result = collapse_scan_pmd(mm, vma,
-					khugepaged_scan.address, &mmap_locked, cc);
-			}
-
-			if (*result == SCAN_SUCCEED)
-				++khugepaged_pages_collapsed;
 
+			*result = collapse_single_pmd(khugepaged_scan.address,
+						      vma, &mmap_locked, cc);
 			/* move to next address */
 			khugepaged_scan.address += HPAGE_PMD_SIZE;
 			progress += HPAGE_PMD_NR;
@@ -2786,34 +2808,19 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
 		nodes_clear(cc->alloc_nmask);
-		if (!vma_is_anonymous(vma)) {
-			struct file *file = get_file(vma->vm_file);
-			pgoff_t pgoff = linear_page_index(vma, addr);
 
-			mmap_read_unlock(mm);
-			mmap_locked = false;
-			result = collapse_scan_file(mm, addr, file, pgoff, cc);
-			fput(file);
-		} else {
-			result = collapse_scan_pmd(mm, vma, addr,
-						   &mmap_locked, cc);
-		}
+		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
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
2.51.0

