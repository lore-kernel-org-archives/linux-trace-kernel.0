Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770D23C519
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647833; cv=none; b=ZRhKFrtPmHo5BYVohIFcIN02toh/d8+Vjg8u+j9jXVmlzRwo0Iy8LrNicb8cq9VwOo1or+5AcaiO/dEDnt1mQHWXipDlSD429RBLp8HKcVUghzXBkprsl6AFhloRmBEBuEULtjk1Dy3bWMf1MDlPPKY/Vbe447PDdtoW+3XqAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647833; c=relaxed/simple;
	bh=nCxK5YTs9NXIxASgRRsqjljX/6Or2lDcz9lxyWphGMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq69VbY3vzqU/iggik/l9WQl1ucproAxcyovyjBDH1gkOoefMsXLMLvyxb35L5uPFnAtyzD8ewfuqqrHTJHpmNGHsch0N6KcnoFzz08mA75n80uTiHxmj707Mxwg0C7mcW2uDJez6JI3NeB9ZKI4WLpEgtHJcyrG+0yWa4rW0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikKDJO7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikKDJO7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757647831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01Jz9/k0vzI/AACRV7RtMTOuI2wxHsxgFib4uYq4G7A=;
	b=ikKDJO7nTyw6SsHUFxBjWikNVI3YhppFG+oLBeQmfJqstoH4aIn98JFG/eLLcL6DaBOge0
	JHwHkTivFnmse+FWAQs7yondgr/zFaPeLmVDwYJiLW86AzHIJtA4Nthev1S2Q7CjYI8lYj
	VD5DaBtaUyKdS7SJ2XPaCOlS2vgWX/U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-ZY1NzjJ6PU22UsrupP4zCA-1; Thu,
 11 Sep 2025 23:30:24 -0400
X-MC-Unique: ZY1NzjJ6PU22UsrupP4zCA-1
X-Mimecast-MFC-AGG-ID: ZY1NzjJ6PU22UsrupP4zCA_1757647820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D3A41800343;
	Fri, 12 Sep 2025 03:30:19 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D81BA1800451;
	Fri, 12 Sep 2025 03:30:09 +0000 (UTC)
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
Subject: [PATCH v11 06/15] khugepaged: introduce collapse_max_ptes_none helper function
Date: Thu, 11 Sep 2025 21:28:01 -0600
Message-ID: <20250912032810.197475-7-npache@redhat.com>
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

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0ae0b63fc9b..4587f2def5c1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -468,6 +468,26 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
+/* Returns the scaled max_ptes_none for a given order.
+ * Caps the value to HPAGE_PMD_NR/2 - 1 in the case of mTHP collapse to prevent
+ * a feedback loop. If max_ptes_none is greater than HPAGE_PMD_NR/2, the value
+ * would lead to collapses that introduces 2x more pages than the original
+ * number of pages. On subsequent scans, the max_ptes_none check would be
+ * satisfied and the collapses would continue until the largest order is reached
+ */
+static int collapse_max_ptes_none(unsigned int order)
+{
+	int max_ptes_none;
+
+	if (order != HPAGE_PMD_ORDER &&
+	    khugepaged_max_ptes_none >= HPAGE_PMD_NR/2)
+		max_ptes_none = HPAGE_PMD_NR/2 - 1;
+	else
+		max_ptes_none = khugepaged_max_ptes_none;
+	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
+
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
@@ -554,7 +574,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	struct folio *folio = NULL;
 	pte_t *_pte;
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
-	int scaled_max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
+	int scaled_max_ptes_none = collapse_max_ptes_none(order);
 	const unsigned long nr_pages = 1UL << order;
 
 	for (_pte = pte; _pte < pte + nr_pages;
-- 
2.51.0

