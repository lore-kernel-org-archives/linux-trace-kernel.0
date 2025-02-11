Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1221DFDAB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233906; cv=none; b=pPEonWg2+KZ+XwrsP91IoAQYoQgHxKfgW31ntjPp1Wl/fUkGQcFzD7sYkgH4QV4YpBOHGGAkxLwqJsZF0CBbFoNRvu9fTjvBEsNNNK7dpF4w/hTIqSCAPKAem58OX4gb8ilO8YzYd+M1R5TNx+2L27s37jqjlc6MBDACM3iYF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233906; c=relaxed/simple;
	bh=zsg7Lb4sKnYhVww/v9vwP2UhGN1gjZUs4C+UjH1ebK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcRo+IVzauYDCDcphMK/qEBelGGwOEqPxm8TeDBh+auv6/SYqvos/8TpJxt8/LbSH49GeyQ7NKUa47oFQwFZWDYCuj0z93eLedpSOjvxmMLTrREbALDDWXsG7NzcVDLfYJQpyYthdEeE5s2hjXQvpx1FtiCbHiQ3zA4cdH7I9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtN31F8j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtN31F8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739233903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzjDVzZllkv1t501JGBPBZlzucpspDJXSDj68ZE8hcQ=;
	b=MtN31F8jjsyg24xrARU2X4F8PJqsX2QDTwt5BWLzK8ZyvLjvi5HDc7b2FNulI+u0cGGXBA
	yRudhV63/S2lby/8urxMLTNIisCqQPbYTEACdLTIQIq7CrKQNg/l+Vb8npTRF9G8v9XjRM
	83X1qFeazAT7SiWY7wSZwgK8FbzT+zQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-OM9rMKLZPIuLmOGLavR4PQ-1; Mon,
 10 Feb 2025 19:31:40 -0500
X-MC-Unique: OM9rMKLZPIuLmOGLavR4PQ-1
X-Mimecast-MFC-AGG-ID: OM9rMKLZPIuLmOGLavR4PQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735BC1800873;
	Tue, 11 Feb 2025 00:31:35 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FABA180035E;
	Tue, 11 Feb 2025 00:31:25 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com,
	david@redhat.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	audra@redhat.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	tiwai@suse.de
Subject: [RFC v2 3/9] khugepaged: generalize hugepage_vma_revalidate for mTHP support
Date: Mon, 10 Feb 2025 17:30:22 -0700
Message-ID: <20250211003028.213461-4-npache@redhat.com>
In-Reply-To: <20250211003028.213461-1-npache@redhat.com>
References: <20250211003028.213461-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For khugepaged to support different mTHP orders, we must generalize this
function for arbitrary orders.

No functional change in this patch.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4c88d17250f4..c834ea842847 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct collapse_control *cc)
 static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 				   bool expect_anon,
 				   struct vm_area_struct **vmap,
-				   struct collapse_control *cc)
+				   struct collapse_control *cc, int order)
 {
 	struct vm_area_struct *vma;
 	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
@@ -932,9 +932,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!vma)
 		return SCAN_VMA_NULL;
 
-	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
+	if (!thp_vma_suitable_order(vma, address, order))
 		return SCAN_ADDRESS_RANGE;
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1130,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		goto out_nolock;
 
 	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED) {
 		mmap_read_unlock(mm);
 		goto out_nolock;
@@ -1164,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -2796,7 +2796,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 			mmap_read_lock(mm);
 			mmap_locked = true;
 			result = hugepage_vma_revalidate(mm, addr, false, &vma,
-							 cc);
+							 cc, HPAGE_PMD_ORDER);
 			if (result  != SCAN_SUCCEED) {
 				last_fail = result;
 				goto out_nolock;
-- 
2.48.1

