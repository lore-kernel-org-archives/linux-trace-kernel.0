Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B951805E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233914; cv=none; b=jGm/E6awTvTuzEbcJmJX56iOlxoAFvp7fZi6ggCsCMK1+mZv6wErGLawsr615g6uTXu0zypaSJM+/Wggi/rxqADX2V4cbW4Bk9fRuWPE5oTHOdRtLUlWMHkFZYaVBAUbudBfnjHT+h0jtB/AlgKw14CD0Z0F5dSQjpefyqGvh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233914; c=relaxed/simple;
	bh=exluz/RAmIVPLGFMkT8KUSBrUpp5/n1b2knsIKpRLuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl48BScCV+iQIIN1AOEddwPaPrbpSJlEtQs/A6IQcF7MZC3jxNB82hCOSwjUR9+2NBVo4p9O7JQk0Yt8OaVsBzfl2osKA8jspk9VshB1uURqC1FQi2kbkeYkxRWtFp6b6TwU3Hcgh9isu3KxkBZqFrfEKxnhg4eNcZmnuMNvkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bszaF5oh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bszaF5oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739233912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0sopSeKMteOebrJDoWD56LIp+P2qMN45Do9CiZPN14=;
	b=bszaF5ohyyE88Dkld4htpnePyqWDU6oPketEnXt0GXMNIG6hjavc6CB4fAdALoXeps0OrP
	MNaLpawC3LyIqUw3Y+YU443eTKHdltovdCQ0m0xqz1dQQ4ziyypMT5DAzv6UTYXdSDrwge
	vl0MdaB3zQxJ9FhS/ncOzuf3ck+pbIs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480--IkTyaSUNSaX2JxRcwKqPA-1; Mon,
 10 Feb 2025 19:31:50 -0500
X-MC-Unique: -IkTyaSUNSaX2JxRcwKqPA-1
X-Mimecast-MFC-AGG-ID: -IkTyaSUNSaX2JxRcwKqPA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 236541800373;
	Tue, 11 Feb 2025 00:31:46 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2B4718004A7;
	Tue, 11 Feb 2025 00:31:35 +0000 (UTC)
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
Subject: [RFC v2 4/9] khugepaged: generalize alloc_charge_folio for mTHP support
Date: Mon, 10 Feb 2025 17:30:23 -0700
Message-ID: <20250211003028.213461-5-npache@redhat.com>
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

alloc_charge_folio allocates the new folio for the khugepaged collapse.
Generalize the order of the folio allocations to support future mTHP
collapsing.

No functional changes in this patch.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c834ea842847..0cfcdc11cabd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1074,14 +1074,14 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 }
 
 static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
-			      struct collapse_control *cc)
+			      struct collapse_control *cc, int order)
 {
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = khugepaged_find_target_node(cc);
 	struct folio *folio;
 
-	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
+	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
 	if (!folio) {
 		*foliop = NULL;
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
@@ -1125,7 +1125,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 */
 	mmap_read_unlock(mm);
 
-	result = alloc_charge_folio(&folio, mm, cc);
+	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
 
@@ -1851,7 +1851,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
-	result = alloc_charge_folio(&new_folio, mm, cc);
+	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
-- 
2.48.1

