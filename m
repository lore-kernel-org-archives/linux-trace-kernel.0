Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412539571A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110314; cv=none; b=XaGB++OaUP/skZDXJf3jC0FF4H4gsxxICJCmkdNjRYIrn3fKBo6wPBpqoEyIawGdb95R2lP4Az2UuoLSOSOJ5fgSz98mfj9P3km68FESjPd69RVfsfF9gH4t/dyAcuO4TQuYkfansb3F9EMyfNu2r3AXhzyHuilkXwucJjj4phE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110314; c=relaxed/simple;
	bh=XKDxFzCTgfvdwqS16TtnVlGAzIXYXev+dE6P4GLUfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm1jlNZfTlfCGRgLjvI0Ccv55zZtEjlwvulEa5qSh5IBNGN3gDjmo6M9Abtn/UBrGfUf+b2r8aZWUaClsif7ugj5hlJmfe8a5zy8tG503Y+Qi0iVrxpIf3dKfhrSp34F8OEA5pq2+OYUx3i5/DpD7rNp0VHqe2gMrcy4247+lOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hd6dqVyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd6dqVyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnTtNcQqLnyAtCjmCaSMz8Sgg0jhE6UAUhgK77mSITg=;
	b=Hd6dqVyV8WNFx+V2ZVIpbtJfebQwNUx+UzexheZiXmsFxF/Bb8xhs1WHTp63k7+Ef6oPWu
	2Z65mN6hJb55feHKOg1DtHvZF7HHM7mFNKvZmA3fPmQY6i78mq+D5d/5qJhcQ2oh9b8hZk
	KI3ULdFbAzX18/oP3CHJrVo0srrS2/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-J4Z3VOGEMfuYKGVw5YZC6Q-1; Thu,
 22 Jan 2026 14:31:42 -0500
X-MC-Unique: J4Z3VOGEMfuYKGVw5YZC6Q-1
X-Mimecast-MFC-AGG-ID: J4Z3VOGEMfuYKGVw5YZC6Q_1769110301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ED7D1955F2C;
	Thu, 22 Jan 2026 19:31:41 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44AFF1958DC6;
	Thu, 22 Jan 2026 19:31:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: npache@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
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
	zokeefe@google.com,
	rientjes@google.com,
	rdunlap@infradead.org,
	hughd@google.com,
	richard.weiyang@gmail.com
Subject: [PATCH mm-unstable v14 10/16] khugepaged: add per-order mTHP collapse failure statistics
Date: Thu, 22 Jan 2026 12:28:35 -0700
Message-ID: <20260122192841.128719-11-npache@redhat.com>
In-Reply-To: <20260122192841.128719-1-npache@redhat.com>
References: <20260122192841.128719-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add three new mTHP statistics to track collapse failures for different
orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:

- collapse_exceed_swap_pte: Increment when mTHP collapse fails due to swap
	PTEs

- collapse_exceed_none_pte: Counts when mTHP collapse fails due to
  	exceeding the none PTE threshold for the given order

- collapse_exceed_shared_pte: Counts when mTHP collapse fails due to shared
  	PTEs

These statistics complement the existing THP_SCAN_EXCEED_* events by
providing per-order granularity for mTHP collapse attempts. The stats are
exposed via sysfs under
`/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
supported hugepage size.

As we currently dont support collapsing mTHPs that contain a swap or
shared entry, those statistics keep track of how often we are
encountering failed mTHP collapses due to these restrictions.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
 include/linux/huge_mm.h                    |  3 +++
 mm/huge_memory.c                           |  7 +++++++
 mm/khugepaged.c                            | 16 ++++++++++++---
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index c51932e6275d..eebb1f6bbc6c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -714,6 +714,30 @@ nr_anon_partially_mapped
        an anonymous THP as "partially mapped" and count it here, even though it
        is not actually partially mapped anymore.
 
+collapse_exceed_none_pte
+       The number of collapse attempts that failed due to exceeding the
+       max_ptes_none threshold. For mTHP collapse, Currently only max_ptes_none
+       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other value will
+       emit a warning and no mTHP collapse will be attempted. khugepaged will
+       try to collapse to the largest enabled (m)THP size; if it fails, it will
+       try the next lower enabled mTHP size. This counter records the number of
+       times a collapse attempt was skipped for exceeding the max_ptes_none
+       threshold, and khugepaged will move on to the next available mTHP size.
+
+collapse_exceed_swap_pte
+       The number of anonymous mTHP PTE ranges which were unable to collapse due
+       to containing at least one swap PTE. Currently khugepaged does not
+       support collapsing mTHP regions that contain a swap PTE. This counter can
+       be used to monitor the number of khugepaged mTHP collapses that failed
+       due to the presence of a swap PTE.
+
+collapse_exceed_shared_pte
+       The number of anonymous mTHP PTE ranges which were unable to collapse due
+       to containing at least one shared PTE. Currently khugepaged does not
+       support collapsing mTHP PTE ranges that contain a shared PTE. This
+       counter can be used to monitor the number of khugepaged mTHP collapses
+       that failed due to the presence of a shared PTE.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9941fc6d7bd8..e8777bb2347d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -144,6 +144,9 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
 	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
+	MTHP_STAT_COLLAPSE_EXCEED_SWAP,
+	MTHP_STAT_COLLAPSE_EXCEED_NONE,
+	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 00fc92062d70..7c0b072fc6b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -639,6 +639,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
 DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
+
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -655,6 +659,9 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
 	&nr_anon_partially_mapped_attr.attr,
+	&collapse_exceed_swap_pte_attr.attr,
+	&collapse_exceed_none_pte_attr.attr,
+	&collapse_exceed_shared_pte_attr.attr,
 	NULL,
 };
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8bb70e1401ad..96f1c28646ba 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -602,7 +602,9 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				if (is_pmd_order(order))
+					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
 				goto out;
 			}
 		}
@@ -632,10 +634,17 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			 * shared may cause a future higher order collapse on a
 			 * rescan of the same range.
 			 */
-			if (!is_pmd_order(order) || (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared)) {
+			if (!is_pmd_order(order)) {
+				result = SCAN_EXCEED_SHARED_PTE;
+				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
+				goto out;
+			}
+
+			if (cc->is_khugepaged &&
+			    shared > khugepaged_max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
+				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
 				goto out;
 			}
 		}
@@ -1082,6 +1091,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
 		 * range.
 		 */
 		if (!is_pmd_order(order)) {
+			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
 			pte_unmap(pte);
 			mmap_read_unlock(mm);
 			result = SCAN_EXCEED_SWAP_PTE;
-- 
2.52.0

