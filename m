Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11494C9540
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525993; cv=none; b=sYde5n+DKBuTdBHFXnlJeEdFEBpqWP1gm/4v0DwuA5zXG39Iv2z4CEj5HC96FzwcDBZkWtPjiuJ22QvIUrvAb0q1Fv3M9SVDZX/hDOdG4hdQmqQso+jPf8tBhK/Ef9vedqg5gOkTM46h+9Mv8CzId0X+TQtfLi9y5eoyCV/kbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525993; c=relaxed/simple;
	bh=3EU7mOFy6o+zU3UPReqPeMf7yOrTSpSWIF952q+LgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mWiavQq92nFxrJ/pUtPVpiFw/YqDreaNvTbAumF9IBlXVH70evMbu4P+sn6Uxtb5mAJhOJ6qzQ9jhq9Fy2rYsNVGD5+2URx/4sX7Ot9z7TEQ8Hi68iciz+w+Uw4I/G2fKb32nH9wtiurT/eM84WgQuNhIX9V4rFWtSF9JLugokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKGRsusi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKGRsusi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778525990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVpNWhE7VBVo0N9l7XrAz43ZB8IVoxkWPZ1WSgC2EWs=;
	b=dKGRsusiBXzlHOQSwv+RL+YdC1c+vfBQn1d1G38dHEZ1EIxGs3RPzdxo1fJU4L/F8x9mUZ
	m3CVDdS6dRBLpQ/1kmesdDz0YgbfKDd3o9QLuRGkLJn+2E/b+F7t8QT2RDL+D7Mexqs+MI
	Whu5TzEdyQMt11f0fzYju+EWp244dcE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-SZKn99v_MZqBFK3pKsYjLw-1; Mon,
 11 May 2026 14:59:49 -0400
X-MC-Unique: SZKn99v_MZqBFK3pKsYjLw-1
X-Mimecast-MFC-AGG-ID: SZKn99v_MZqBFK3pKsYjLw_1778525988
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A7D81956089;
	Mon, 11 May 2026 18:59:48 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA3CB30001BE;
	Mon, 11 May 2026 18:59:29 +0000 (UTC)
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
	liam@infradead.org,
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
Subject: [PATCH mm-unstable v17 05/14] mm/khugepaged: require collapse_huge_page to enter/exit with the lock dropped
Date: Mon, 11 May 2026 12:58:05 -0600
Message-ID: <20260511185817.686831-6-npache@redhat.com>
In-Reply-To: <20260511185817.686831-1-npache@redhat.com>
References: <20260511185817.686831-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 7t8GWHYkdcWhjdpI9ieg8JqeFJxkc7YN6u99GUGfwkY_1778525988
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the collapse_huge_page function requires the mmap_read_lock to
enter with it held, and exit with it dropped. This function moves the
unlock into its parent caller, and changes this semantic to requiring it
to enter/exit with it always unlocked.

In future patches, we need this expectation, as for in mTHP collapse, we
may have already have dropped the lock, and do not want to conditionally
check for this by passing through the lock_dropped variable.

No functional change is expected as one of the first things the
collapse_huge_page function does is drop this lock before allocating the
hugepage.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 27465161fa6d..37a5f6791816 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1199,6 +1199,14 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
 	return SCAN_SUCCEED;
 }
 
+/*
+ * collapse_huge_page expects the mmap_read_lock to be dropped before
+ * entering this function. The function will also always return with the lock
+ * dropped. The function starts by allocation a folio, which can potentially
+ * take a long time if it involves sync compaction, and we do not need to hold
+ * the mmap_lock during that. We must recheck the vma after taking it again in
+ * write mode.
+ */
 static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		int referenced, int unmapped, struct collapse_control *cc)
 {
@@ -1214,14 +1222,6 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
-	/*
-	 * Before allocating the hugepage, release the mmap_lock read lock.
-	 * The allocation can take potentially a long time if it involves
-	 * sync compaction, and we do not need to hold the mmap_lock during
-	 * that. We will recheck the vma after taking it again in write mode.
-	 */
-	mmap_read_unlock(mm);
-
 	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
@@ -1526,6 +1526,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
+		/* collapse_huge_page expects the lock to be dropped before calling */
+		mmap_read_unlock(mm);
 		result = collapse_huge_page(mm, start_addr, referenced,
 					    unmapped, cc);
 		/* collapse_huge_page will return with the mmap_lock released */
-- 
2.54.0

