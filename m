Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE62EFDA4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625143; cv=none; b=Hi3W18QFKAgYj1WTSR+/iHyws0/ou3yVQ2Lmk2nUVUF80S6tlnW4n0cGgFTvp4OGJp4tOnYmQL0ptdILpO3Mdi/5RCGPa3LIxrZ58LvyXI3ylUTrjEFgLPjXxMNOwLk/5CGTwXROkV/xAIZLaFi0roMzJjsASW3F50kI2igiu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625143; c=relaxed/simple;
	bh=aSNtmOwocdnRpfiN/L3GhAXbU3swyhPeWvhe2YUzEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H46R1khOfRMYaga6rdkBBcOHpV/l8prs0NVlzk0K2YEU6Tmqh0MDpk5gHAb8ogri/aAwlxTNKEZUhD/E1k3alRDwBpml/b3JdO0QoXtWMM6OA4leKjySSqvlMh0UQzlWxZKyi154ommxRS9MfabIDDebqek1+AN1at4IVtGmffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg5U27eF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg5U27eF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776625140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LJaOyXdmI63cfNVNKc4jzTWWvQfAeh+OPxH5aN4fYk=;
	b=Jg5U27eF4+gOlUQIRMhpvuzPmH3a+pCTqxNr6vX2idL2FOKXOg0Hc9Mm3mvmM+XEKzoiPW
	TDZq6RrpggrPB6us/XkpOZoD/b9jivhPQLgiFZgOW3+7gm7lik2ONLi5zz1e7Q0X6B8Ayf
	97JELBJDyDob/GxU9g/l+ZfSSa2owfc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-D1VMC3nnMtenRTH-2o9vGA-1; Sun,
 19 Apr 2026 14:58:57 -0400
X-MC-Unique: D1VMC3nnMtenRTH-2o9vGA-1
X-Mimecast-MFC-AGG-ID: D1VMC3nnMtenRTH-2o9vGA_1776625136
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52B851800451;
	Sun, 19 Apr 2026 18:58:56 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8235A19560AB;
	Sun, 19 Apr 2026 18:58:35 +0000 (UTC)
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
Subject: [PATCH 7.2 v16 01/13] mm/khugepaged: generalize hugepage_vma_revalidate for mTHP support
Date: Sun, 19 Apr 2026 12:57:38 -0600
Message-ID: <20260419185750.260784-2-npache@redhat.com>
In-Reply-To: <20260419185750.260784-1-npache@redhat.com>
References: <20260419185750.260784-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: eZz6J4f8KnvGbHTfqI7TEx7uG_TJs3XuedkqKWePPCs_1776625136
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

For khugepaged to support different mTHP orders, we must generalize this
to check if the PMD is not shared by another VMA and that the order is
enabled.

No functional change in this patch. Also correct a comment about the
functionality of the revalidation and fix a double space issues.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..53e7e4be172d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -902,12 +902,13 @@ static int collapse_find_target_node(struct collapse_control *cc)
 
 /*
  * If mmap_lock temporarily dropped, revalidate vma
- * before taking mmap_lock.
+ * after taking the mmap_lock again.
  * Returns enum scan_result value.
  */
 
 static enum scan_result hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
-		bool expect_anon, struct vm_area_struct **vmap, struct collapse_control *cc)
+		bool expect_anon, struct vm_area_struct **vmap,
+		struct collapse_control *cc, unsigned int order)
 {
 	struct vm_area_struct *vma;
 	enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED :
@@ -920,15 +921,16 @@ static enum scan_result hugepage_vma_revalidate(struct mm_struct *mm, unsigned l
 	if (!vma)
 		return SCAN_VMA_NULL;
 
+	/* Always check the PMD order to ensure its not shared by another VMA */
 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
 		return SCAN_ADDRESS_RANGE;
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
+	if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, BIT(order)))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
 	 * remapped to file after khugepaged reaquired the mmap_lock.
 	 *
-	 * thp_vma_allowable_order may return true for qualified file
+	 * thp_vma_allowable_orders may return true for qualified file
 	 * vmas.
 	 */
 	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
@@ -1121,7 +1123,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 		goto out_nolock;
 
 	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
+					 HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED) {
 		mmap_read_unlock(mm);
 		goto out_nolock;
@@ -1155,7 +1158,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
+					 HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -2857,8 +2861,8 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 			mmap_unlocked = false;
 			*lock_dropped = true;
 			result = hugepage_vma_revalidate(mm, addr, false, &vma,
-							 cc);
-			if (result  != SCAN_SUCCEED) {
+							 cc, HPAGE_PMD_ORDER);
+			if (result != SCAN_SUCCEED) {
 				last_fail = result;
 				goto out_nolock;
 			}
-- 
2.53.0

