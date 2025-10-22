Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FF34D4E1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158372; cv=none; b=KMFYGWX2FYLwgIBu0APyPMbndVGthT59BjV01GJHUP5ICuCvta0LhwiAAOnpP2s6l5eX35g2o3ph8NHEK1HXHqWLQUyUaYCHwgpFMd74uCKe08c+i36usUYCfitx9gw2rjk6SkfsswSSYbpxIAnCc7pfzl1opGExR0p3PTRRlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158372; c=relaxed/simple;
	bh=udc3lQ5qAqYENhuSsmZKCiBf6b+fPZg0MkdxeumsA+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2QIuLsbLZOZV8nWdT+bNqnradAnALo/92mO9a0C2XnwM6ZkCyXI/Dt1KVkndYgIv4W5Lktd/3SXJflMeNGfm8VJyaGoQxVKXm5CoMJ27eqSHQg1wqlyJuVBkiQYZJCg3sH2HJKat+ErBcuFlGHoqlKUuMt/NliMvw4UqWeeWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd56Y8wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd56Y8wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zERItD4tpTSTLZu1EAujIdQUQv57c0MEV45Tz1yZd+8=;
	b=Dd56Y8wyWT8XvBcICByijkrQcyiLChzpKA2cYYZGu9ZIq4TilwAjhdHt+Td2rxh7irBdgp
	sfOwW94UPGPFoGQivr9K7OOwsSto+O904+PKXe5I4+cIjftPN1yUOgNscY646BPZBi6K5L
	zFnDI+S36qsFxT5O21BgthU2gW7MfxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-CNNjUI14NuKWDUrtXV7l9w-1; Wed,
 22 Oct 2025 14:39:25 -0400
X-MC-Unique: CNNjUI14NuKWDUrtXV7l9w-1
X-Mimecast-MFC-AGG-ID: CNNjUI14NuKWDUrtXV7l9w_1761158360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9AF718002C9;
	Wed, 22 Oct 2025 18:39:19 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04CFA19560B4;
	Wed, 22 Oct 2025 18:39:09 +0000 (UTC)
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
Subject: [PATCH v12 mm-new 06/15] khugepaged: introduce collapse_max_ptes_none helper function
Date: Wed, 22 Oct 2025 12:37:08 -0600
Message-ID: <20251022183717.70829-7-npache@redhat.com>
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

The current mechanism for determining mTHP collapse scales the
khugepaged_max_ptes_none value based on the target order. This
introduces an undesirable feedback loop, or "creep", when max_ptes_none
is set to a value greater than HPAGE_PMD_NR / 2.

With this configuration, a successful collapse to order N will populate
enough pages to satisfy the collapse condition on order N+1 on the next
scan. This leads to unnecessary work and memory churn.

To fix this issue introduce a helper function that caps the max_ptes_none
to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
the max_ptes_none number by the (PMD_ORDER - target collapse order).

The limits can be ignored by passing full_scan=true, this is useful for
madvise_collapse (which ignores limits), or in the case of
collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
collapse is available.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4ccebf5dda97..286c3a7afdee 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
+/**
+ * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
+ * @order: The folio order being collapsed to
+ * @full_scan: Whether this is a full scan (ignore limits)
+ *
+ * For madvise-triggered collapses (full_scan=true), all limits are bypassed
+ * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
+ *
+ * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
+ * khugepaged_max_ptes_none value.
+ *
+ * For mTHP collapses, scale down the max_ptes_none proportionally to the folio
+ * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedback loop.
+ *
+ * Return: Maximum number of empty PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
+{
+	unsigned int max_ptes_none;
+
+	/* ignore max_ptes_none limits */
+	if (full_scan)
+		return HPAGE_PMD_NR - 1;
+
+	if (order == HPAGE_PMD_ORDER)
+		return khugepaged_max_ptes_none;
+
+	max_ptes_none = min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - 1);
+
+	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
+
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
@@ -546,7 +579,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
 	const unsigned long nr_pages = 1UL << order;
-	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
+	int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
 
 	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
-- 
2.51.0

