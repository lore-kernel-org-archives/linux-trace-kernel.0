Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D1313546
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076266; cv=none; b=MfTILvkon8iKnKBecpB/gyRcWAjnlHaSX+HMimqUXRLwa/LHRvAaUKp/Ty6uCsIJDSNp2akmur+TZSPBl+BThE9cmQf+QueGR/iUbOsM8xUnUJeLpghS+prhdKf3ST5Ub+Hsp/G9kSIMJIUfD300ITLpt3Zzbn7W00BKHZV2bZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076266; c=relaxed/simple;
	bh=5jPDF48P2bjVEyTxqX4bKFFyasTE4yGgINpsMNjhF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AtUamndhVYxeEBeco9NKEFz+nqR25XN7E/JhUe9jvRTpHJn/hY4Y/SQvCnvV+siaeKyBK2E7K6k0DVFYEHnP8GKfGMaeSaaqh4DhuRVQlKRCKG5yMAtTClIvLCLvUFoyiE7IyjUFF7Z8LGbWE3hFAs77SIAymP+AF9FpYzh/7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bqe4bm9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bqe4bm9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772076263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8AaiI+gTK7kOsUYQDfxNlCUt5iMnurxFPbLsxLyfO4=;
	b=Bqe4bm9wwLfcDiI6nlNfvD18VNg5GdIr3At5ESbuwrXebDgbaepOCBLWhnfgLuk5twq98B
	tq/CJKKuUYcUefVw1CvwrucONhV7qoIQBYonkNyWpm2+M7SofObSJREgA70AgUUIYUx6ar
	HCH3vdl5ukAa40eUYCuKBXGn/wHKUYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-EiVI62j_Po-BH1PXsuLQcw-1; Wed,
 25 Feb 2026 22:24:20 -0500
X-MC-Unique: EiVI62j_Po-BH1PXsuLQcw-1
X-Mimecast-MFC-AGG-ID: EiVI62j_Po-BH1PXsuLQcw_1772076259
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01F7D1956089;
	Thu, 26 Feb 2026 03:24:19 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5615619560B6;
	Thu, 26 Feb 2026 03:24:09 +0000 (UTC)
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
	lorenzo.stoakes@oracle.com,
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
Subject: [PATCH mm-unstable v15 04/13] mm/khugepaged: introduce collapse_max_ptes_none helper function
Date: Wed, 25 Feb 2026 20:24:07 -0700
Message-ID: <20260226032407.233121-1-npache@redhat.com>
In-Reply-To: <20260226031741.230674-1-npache@redhat.com>
References: <20260226031741.230674-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: luEkOFLqMUQtuU2J3RX9lfpINn_MRgP4i1ZXOkjg1C4_1772076259
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current mechanism for determining mTHP collapse scales the
khugepaged_max_ptes_none value based on the target order. This
introduces an undesirable feedback loop, or "creep", when max_ptes_none
is set to a value greater than HPAGE_PMD_NR / 2.

With this configuration, a successful collapse to order N will populate
enough pages to satisfy the collapse condition on order N+1 on the next
scan. This leads to unnecessary work and memory churn.

To fix this issue introduce a helper function that will limit mTHP
collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
This effectively supports two modes:

- max_ptes_none=0: never introduce new none-pages for mTHP collapse.
- max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
  available mTHP order.

This removes the possiblilty of "creep", while not modifying any uAPI
expectations. A warning will be emitted if any non-supported
max_ptes_none value is configured with mTHP enabled.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ecdbbf6a01a6..99f78f0e44c6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -456,6 +456,36 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
+/**
+ * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
+ * @order: The folio order being collapsed to
+ *
+ * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
+ * khugepaged_max_ptes_none value.
+ *
+ * For mTHP collapses, we currently only support khugepaged_max_pte_none values
+ * of 0 or (COLLAPSE_MAX_PTES_LIMIT). Any other value will emit a warning and
+ * no mTHP collapse will be attempted
+ *
+ * Return: Maximum number of empty PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_none(unsigned int order)
+{
+	if (is_pmd_order(order))
+		return khugepaged_max_ptes_none;
+
+	/* Zero/non-present collapse disabled. */
+	if (!khugepaged_max_ptes_none)
+		return 0;
+
+	if (khugepaged_max_ptes_none == COLLAPSE_MAX_PTES_LIMIT)
+		return (1 << order) - 1;
+
+	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %u\n",
+		      COLLAPSE_MAX_PTES_LIMIT);
+	return -EINVAL;
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
@@ -541,10 +571,18 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	struct folio *folio = NULL;
 	unsigned long addr = start_addr;
 	pte_t *_pte;
+	int max_ptes_none;
 	int none_or_zero = 0, shared = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
 	const unsigned long nr_pages = 1UL << order;
-	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
+
+	if (cc->is_khugepaged)
+		max_ptes_none = collapse_max_ptes_none(order);
+	else
+		max_ptes_none = COLLAPSE_MAX_PTES_LIMIT;
+
+	if (max_ptes_none == -EINVAL)
+		return result;
 
 	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
-- 
2.53.0

