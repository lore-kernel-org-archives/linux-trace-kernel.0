Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72B3002C8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625185; cv=none; b=jUo8ht5vMu8ND2e+YFRRR27nNoMem0wCu6cIj7twSCcRlf+pOPBKszrtr2JCOZPQ1YDFgyCg0Gy9RYokVWUocZR5Q4V1AhiaJCFnn5MCidWDUw+bjks8+TPyhTJjgYzk6rf8CDVrFoU6rphZbRP/ByHnTsTNlMKwbidRROqXGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625185; c=relaxed/simple;
	bh=8C83PnZiI6uhPVxr1d7J8EPyzyzk1MqX9S8lPbooTU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NMjU5uPLw4awUFK5t0ZD/3ZjrbM1IDRmxC36Wim4nDWeUHwSHkPgpnYflQyud35xHdN1v8hAcbojtkxe1CDM5LqlHQd2oaYNV64yyp63LlGO6ZSBXsbVxblgf+OcfeY6HjKKBqGGiU4b1zKERO7xQQ1d977ce2+JUwVvhEWftV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM83r0j8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM83r0j8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776625178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpiEosJanpfJUaGRhwa4O3aVZ0/wcJYLu3b9XwgPJO4=;
	b=UM83r0j8WXQfpg/V2/JhwsnemHBBl9I31MDuNAa+mxQTQjlcS7QTvEYcaA60n2K1nz7afG
	SIvfpc8gzjEF7c3e/4YMqqMpiwflj+0/nMLptpQ9NhXfAAZFlmzMVjr+2zt2XIvwMXXvFE
	bafIi9LDaxp+7PY37erYLAnhMAizXho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-4mITkLacO6O1kjAcuUXwMQ-1; Sun,
 19 Apr 2026 14:59:34 -0400
X-MC-Unique: 4mITkLacO6O1kjAcuUXwMQ-1
X-Mimecast-MFC-AGG-ID: 4mITkLacO6O1kjAcuUXwMQ_1776625173
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7CBD19560AA;
	Sun, 19 Apr 2026 18:59:33 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E18C9195608E;
	Sun, 19 Apr 2026 18:59:15 +0000 (UTC)
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
	Liam.Howlett@oracle.com,
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
Subject: [PATCH 7.2 v16 03/13] mm/khugepaged: rework max_ptes_* handling with helper functions
Date: Sun, 19 Apr 2026 12:57:40 -0600
Message-ID: <20260419185750.260784-4-npache@redhat.com>
In-Reply-To: <20260419185750.260784-1-npache@redhat.com>
References: <20260419185750.260784-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 4VPoHbehTm6wb-R5h20mdVL2D_qxbLwL1EvsQrUeDwU_1776625173
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The following cleanup reworks all the max_ptes_* handling into helper
functions. This increases the code readability and will later be used to
implement the mTHP handling of these variables.

With these changes we abstract all the madvise_collapse() special casing
(dont respect the sysctls) away from the functions that utilize them. And
will later in this series to cleanly restrict mTHP collapses behaviors.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 114 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index afac6bc4e76d..f42b55421191 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -348,6 +348,58 @@ static bool pte_none_or_zero(pte_t pte)
 	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
 }
 
+/**
+ * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
+ * @cc: The collapse control struct
+ * @vma: The vma to check for userfaultfd
+ *
+ * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
+ * empty page.
+ *
+ * Return: Maximum number of empty PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
+		struct vm_area_struct *vma)
+{
+	if (vma && userfaultfd_armed(vma))
+		return 0;
+	if (!cc->is_khugepaged)
+		return HPAGE_PMD_NR;
+	return khugepaged_max_ptes_none;
+}
+
+/**
+ * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse
+ * @cc: The collapse control struct
+ *
+ * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
+ * shared page.
+ *
+ * Return: Maximum number of shared PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
+{
+	if (!cc->is_khugepaged)
+		return HPAGE_PMD_NR;
+	return khugepaged_max_ptes_shared;
+}
+
+/**
+ * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse
+ * @cc: The collapse control struct
+ *
+ * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
+ * swap page.
+ *
+ * Return: Maximum number of swap PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
+{
+	if (!cc->is_khugepaged)
+		return HPAGE_PMD_NR;
+	return khugepaged_max_ptes_swap;
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     vm_flags_t *vm_flags, int advice)
 {
@@ -546,21 +598,19 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
+	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
 
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
+			if (++none_or_zero > max_ptes_none) {
 				result = SCAN_EXCEED_NONE_PTE;
 				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 				goto out;
 			}
+			continue;
 		}
 		if (!pte_present(pteval)) {
 			result = SCAN_PTE_NON_PRESENT;
@@ -591,9 +641,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 
 		/* See collapse_scan_pmd(). */
 		if (folio_maybe_mapped_shared(folio)) {
-			++shared;
-			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
+			if (++shared > max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out;
@@ -1270,6 +1318,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 	unsigned long addr;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
+	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
+	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
 
 	VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
 
@@ -1294,36 +1345,29 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
+			if (++none_or_zero > max_ptes_none) {
 				result = SCAN_EXCEED_NONE_PTE;
 				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 				goto out_unmap;
 			}
+			continue;
 		}
 		if (!pte_present(pteval)) {
-			++unmapped;
-			if (!cc->is_khugepaged ||
-			    unmapped <= khugepaged_max_ptes_swap) {
-				/*
-				 * Always be strict with uffd-wp
-				 * enabled swap entries.  Please see
-				 * comment below for pte_uffd_wp().
-				 */
-				if (pte_swp_uffd_wp_any(pteval)) {
-					result = SCAN_PTE_UFFD_WP;
-					goto out_unmap;
-				}
-				continue;
-			} else {
+			if (++unmapped > max_ptes_swap) {
 				result = SCAN_EXCEED_SWAP_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				goto out_unmap;
 			}
+			/*
+			 * Always be strict with uffd-wp
+			 * enabled swap entries.  Please see
+			 * comment below for pte_uffd_wp().
+			 */
+			if (pte_swp_uffd_wp_any(pteval)) {
+				result = SCAN_PTE_UFFD_WP;
+				goto out_unmap;
+			}
+			continue;
 		}
 		if (pte_uffd_wp(pteval)) {
 			/*
@@ -1366,9 +1410,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		 * is shared.
 		 */
 		if (folio_maybe_mapped_shared(folio)) {
-			++shared;
-			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
+			if (++shared > max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out_unmap;
@@ -2329,6 +2371,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, NULL);
+	unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
 
 	present = 0;
 	swap = 0;
@@ -2341,8 +2385,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 
 		if (xa_is_value(folio)) {
 			swap += 1 << xas_get_order(&xas);
-			if (cc->is_khugepaged &&
-			    swap > khugepaged_max_ptes_swap) {
+			if (swap > max_ptes_swap) {
 				result = SCAN_EXCEED_SWAP_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				break;
@@ -2413,8 +2456,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		cc->progress += HPAGE_PMD_NR;
 
 	if (result == SCAN_SUCCEED) {
-		if (cc->is_khugepaged &&
-		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
+		if (present < HPAGE_PMD_NR - max_ptes_none) {
 			result = SCAN_EXCEED_NONE_PTE;
 			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
-- 
2.53.0

