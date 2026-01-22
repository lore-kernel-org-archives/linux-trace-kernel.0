Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BA385EDA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110290; cv=none; b=iv+umhHW82PKjM/4kAhdgT8Js33DazG9a0AZk48TjiWalOpCFKfjFCEg74jgCQ8VnrvFXC6QriYVjrYqBAdRDZbk1CK1ZcbDHhiOGdEBev5XlfFFQ+3OxQLt+FT/kKrMuyehg0dgqUB0paqpSabXH+DkUUWBP5E5QOzUp6yj15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110290; c=relaxed/simple;
	bh=5N4LhNuGsMSpPBkqKPF2gC8sd4NXq5hk5L7EKBlu0Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srDTPZ+cHnnvlwnq8Q0YUOktn0u/lPDQHEqSzd8PEzcVoYCpKy26ABaiuS08dSms8ninpVlRgK7YVZl/M8220r2LZvtxdUWj3Mw+5r8hSDlZFWeLi2qEvO4hFLaQosCPoTgAVOTB/upZHb9HIdaAbg2YmoPeCWfNFQshVR3q53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdyJQep6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdyJQep6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4E8ptoTH7R+DRn1I9NeMb51UC/7t3y9Bwu4ndN7kkE=;
	b=LdyJQep6s6Qg/DhJp3+sc3qChiGh5lqd9RQS8oKl16BawO0RDH1fokMur8XmoXW1Ih/3p7
	sMIMBeXAdPu1HRJ4OSrTqDjVjWLLheNEf9wsvyAoloup+uQchMioNOakC6Zcvo8ubvPvXZ
	v7Tets88+zoGyAZ4yqSpsAJuY6IBZNg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-xQ83yP6HOn2kPmSKsmBhRA-1; Thu,
 22 Jan 2026 14:31:14 -0500
X-MC-Unique: xQ83yP6HOn2kPmSKsmBhRA-1
X-Mimecast-MFC-AGG-ID: xQ83yP6HOn2kPmSKsmBhRA_1769110273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0751219775A5;
	Thu, 22 Jan 2026 19:31:13 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C07CA1958DC1;
	Thu, 22 Jan 2026 19:31:03 +0000 (UTC)
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
Subject: [PATCH mm-unstable v14 07/16] khugepaged: introduce collapse_max_ptes_none helper function
Date: Thu, 22 Jan 2026 12:28:32 -0700
Message-ID: <20260122192841.128719-8-npache@redhat.com>
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

The limits can be ignored by passing full_scan=true, this is useful for
madvise_collapse (which ignores limits), or in the case of
collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
collapse is available.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0f68902edd9a..9b7e05827749 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -460,6 +460,44 @@ void __khugepaged_enter(struct mm_struct *mm)
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
+ * For mTHP collapses, we currently only support khugepaged_max_pte_none values
+ * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and no mTHP
+ * collapse will be attempted
+ *
+ * Return: Maximum number of empty PTEs allowed for the collapse operation
+ */
+static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
+{
+	/* ignore max_ptes_none limits */
+	if (full_scan)
+		return HPAGE_PMD_NR - 1;
+
+	if (is_pmd_order(order))
+		return khugepaged_max_ptes_none;
+
+	/* Zero/non-present collapse disabled. */
+	if (!khugepaged_max_ptes_none)
+		return 0;
+
+	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
+		return (1 << order) - 1;
+
+	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %d\n",
+		      HPAGE_PMD_NR - 1);
+	return -EINVAL;
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
@@ -548,7 +586,10 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	int none_or_zero = 0, shared = 0, referenced = 0;
 	enum scan_result result = SCAN_FAIL;
 	const unsigned long nr_pages = 1UL << order;
-	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
+	int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
+
+	if (max_ptes_none == -EINVAL)
+		return result;
 
 	for (_pte = pte; _pte < pte + nr_pages;
 	     _pte++, addr += PAGE_SIZE) {
-- 
2.52.0

