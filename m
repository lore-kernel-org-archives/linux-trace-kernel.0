Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD6393419
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110229; cv=none; b=TqaU7conhQvgNNk9YyyRpS1bhFDHxT9cjdHF8JfGVlEcf1C77v8Mn2LZHXzVJYL0niQmRdfvlLTIRBExBx+WLpFB/6jHcoF95sonrnK7c1JckRWJzps9/tWPiItxnuoizUDT2vm+DuU5XARYMXZcot3znzp9zFEViD71YGhaXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110229; c=relaxed/simple;
	bh=iWOmyAXUUavrVY3TiJANaEH6X9ncc6VyxqYCWEFnsBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORRcnqD4tLtVaS+y15pcm+2qSGKp4AiG3qcw6+D/nRxjc+0ksiUZI82SrZ7zXL6pMWUSlE99Hpfc9q+FAA41K2MyzmRRbt6P6Z+X4PAP8dRPIg1WFtIeaeEXpDC4M1yBI+TcFE73uRA15Ix6irwuoCfzz8nKWOM7CdolErfhHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm7XAXAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm7XAXAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx3v1kWdLAeDnpT9dcpRX6ygzmWenOuVe38k+JYMvBg=;
	b=Nm7XAXAvzvzMPuS7cA8k3UCCkeN8Sk6PCP5R3jn41IBRrLsSmF61vRDDa3uyn2XunsDRXd
	FumkvvLpWjJwGz3zfT38KXB8cBSWrVfKW17LHB3MyL9J9s3mAilRM1s1U/GIjEj00tj+Mw
	4QrHpQey9SKaDIglTvzi37ouEhp395g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-qqYJc6KiM7qikWfTPuWS_g-1; Thu,
 22 Jan 2026 14:30:13 -0500
X-MC-Unique: qqYJc6KiM7qikWfTPuWS_g-1
X-Mimecast-MFC-AGG-ID: qqYJc6KiM7qikWfTPuWS_g_1769110212
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8720418005B2;
	Thu, 22 Jan 2026 19:30:12 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBF5F1958DC2;
	Thu, 22 Jan 2026 19:30:01 +0000 (UTC)
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
Subject: [PATCH mm-unstable v14 01/16] mm: introduce is_pmd_order helper
Date: Thu, 22 Jan 2026 12:28:26 -0700
Message-ID: <20260122192841.128719-2-npache@redhat.com>
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

In order to add mTHP support to khugepaged, we will often be checking if a
given order is (or is not) a PMD order. Some places in the kernel already
use this check, so lets create a simple helper function to keep the code clean
and readable.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h | 5 +++++
 mm/huge_memory.c        | 2 +-
 mm/khugepaged.c         | 4 ++--
 mm/mempolicy.c          | 2 +-
 mm/page_alloc.c         | 2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a4d9f964dfde..bd7f0e1d8094 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -771,6 +771,11 @@ static inline bool pmd_is_huge(pmd_t pmd)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline bool is_pmd_order(unsigned int order)
+{
+	return order == HPAGE_PMD_ORDER;
+}
+
 static inline int split_folio_to_list_to_order(struct folio *folio,
 		struct list_head *list, int new_order)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 44ff8a648afd..5eae85818635 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4097,7 +4097,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	if (old_order == HPAGE_PMD_ORDER)
+	if (is_pmd_order(old_order))
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	count_mthp_stat(old_order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
 	return ret;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fba6aea5bea6..b85d00670d14 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2000,7 +2000,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * we locked the first folio, then a THP might be there already.
 		 * This will be discovered on the first iteration.
 		 */
-		if (folio_order(folio) == HPAGE_PMD_ORDER &&
+		if (is_pmd_order(folio_order(folio)) &&
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
@@ -2327,7 +2327,7 @@ static enum scan_result hpage_collapse_scan_file(struct mm_struct *mm, unsigned
 			continue;
 		}
 
-		if (folio_order(folio) == HPAGE_PMD_ORDER &&
+		if (is_pmd_order(folio_order(folio)) &&
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dbd48502ac24..3802e52b01fc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2450,7 +2450,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
-	    order == HPAGE_PMD_ORDER && ilx != NO_INTERLEAVE_INDEX) {
+	    is_pmd_order(order) && ilx != NO_INTERLEAVE_INDEX) {
 		/*
 		 * For hugepage allocation and non-interleave policy which
 		 * allows the current node (or other explicitly preferred
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4104973e22f..e8a6d0d27b92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -719,7 +719,7 @@ static inline bool pcp_allowed_order(unsigned int order)
 	if (order <= PAGE_ALLOC_COSTLY_ORDER)
 		return true;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (order == HPAGE_PMD_ORDER)
+	if (is_pmd_order(order))
 		return true;
 #endif
 	return false;
-- 
2.52.0

