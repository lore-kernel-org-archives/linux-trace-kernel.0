Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9B34E75C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158403; cv=none; b=jArMqigYcpxxKs+RrlhVdLlLOuB3sfVMzR25EIsHYukI5I4ImgiFNL50hmqBWUh+2DlvEEzcLgt8fXVqRf/lsX18kXMaIUQGT7VihifgN94xogQe6dOMB0xsgNyKCJaGJUPLhlsX1ISa3+ADgf8T38wSHp1+GkAtwchh1Mk5Yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158403; c=relaxed/simple;
	bh=KLrK/s/cGhMSr3Ciz35pe3Xg6onDJWf7KcvAbB6jkF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn6UgMeejh7jyX+tNLUEuGE/APqW5IWg37CFz/IxaSOdbEytx2TfLpyVuia8jRPwRAJtUHx8oSrVj2gnWWirDNpPE3Isa3S7KVTenb/m7jbG7V6iOmtzYsW8yqcha8bDhCKzPKkUoCZMxarDGeRdkkLyiHebV/9ozH9iC6tABRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDbBAhTW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDbBAhTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vK1RS4Zk73trufPBSaFPSUR9TYlw/wAla4oKRU3Q2A=;
	b=TDbBAhTWVNJh7z3IBS4w7IWnWgceVGD1fqUpMn8Sa0nj9VMyVbGfsNU76zHcQWHru0rptr
	i33E6wwoK8VA3xjUOkZE6BvFIjXklNMmwy9U4Rg0KD5fCwVCmBgPrzXCJaLSFpSIV0www3
	JnNAKqjtsNC3jKBA6DnmJJxWVy39Yd0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-16FQH2eaOmWNqsjZWIxpBg-1; Wed,
 22 Oct 2025 14:39:56 -0400
X-MC-Unique: 16FQH2eaOmWNqsjZWIxpBg-1
X-Mimecast-MFC-AGG-ID: 16FQH2eaOmWNqsjZWIxpBg_1761158391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BE9E19560B3;
	Wed, 22 Oct 2025 18:39:51 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55D0C19560B4;
	Wed, 22 Oct 2025 18:39:42 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
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
Subject: [PATCH v12 mm-new 09/15] khugepaged: add per-order mTHP collapse failure statistics
Date: Wed, 22 Oct 2025 12:37:11 -0600
Message-ID: <20251022183717.70829-10-npache@redhat.com>
In-Reply-To: <20251022183717.70829-1-npache@redhat.com>
References: <20251022183717.70829-1-npache@redhat.com>
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
 Documentation/admin-guide/mm/transhuge.rst | 23 ++++++++++++++++++++++
 include/linux/huge_mm.h                    |  3 +++
 mm/huge_memory.c                           |  7 +++++++
 mm/khugepaged.c                            | 16 ++++++++++++---
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 13269a0074d4..7c71cda8aea1 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -709,6 +709,29 @@ nr_anon_partially_mapped
        an anonymous THP as "partially mapped" and count it here, even though it
        is not actually partially mapped anymore.
 
+collapse_exceed_none_pte
+       The number of anonymous mTHP pte ranges where the number of none PTEs
+       exceeded the max_ptes_none threshold. For mTHP collapse, khugepaged
+       checks a PMD region and tracks which PTEs are present. It then tries
+       to collapse to the largest enabled mTHP size. The allowed number of empty
+       PTEs is the max_ptes_none threshold scaled by the collapse order. This
+       counter records the number of times a collapse attempt was skipped for
+       this reason, and khugepaged moved on to try the next available mTHP size.
+
+collapse_exceed_swap_pte
+       The number of anonymous mTHP pte ranges which contain at least one swap
+       PTE. Currently khugepaged does not support collapsing mTHP regions
+       that contain a swap PTE. This counter can be used to monitor the
+       number of khugepaged mTHP collapses that failed due to the presence
+       of a swap PTE.
+
+collapse_exceed_shared_pte
+       The number of anonymous mTHP pte ranges which contain at least one shared
+       PTE. Currently khugepaged does not support collapsing mTHP pte ranges
+       that contain a shared PTE. This counter can be used to monitor the
+       number of khugepaged mTHP collapses that failed due to the presence
+       of a shared PTE.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3d29624c4f3f..4b2773235041 100644
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
index 0063d1ba926e..7335b92969d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -638,6 +638,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
 DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
+
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -654,6 +658,9 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
 	&nr_anon_partially_mapped_attr.attr,
+	&collapse_exceed_swap_pte_attr.attr,
+	&collapse_exceed_none_pte_attr.attr,
+	&collapse_exceed_shared_pte_attr.attr,
 	NULL,
 };
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d741af15e18c..053202141ea3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -592,7 +592,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				if (order == HPAGE_PMD_ORDER)
+					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
 				goto out;
 			}
 		}
@@ -622,10 +624,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			 * shared may cause a future higher order collapse on a
 			 * rescan of the same range.
 			 */
-			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared)) {
+			if (order != HPAGE_PMD_ORDER) {
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
@@ -1073,6 +1082,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		 * range.
 		 */
 		if (order != HPAGE_PMD_ORDER) {
+			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
 			pte_unmap(pte);
 			mmap_read_unlock(mm);
 			result = SCAN_EXCEED_SWAP_PTE;
-- 
2.51.0

