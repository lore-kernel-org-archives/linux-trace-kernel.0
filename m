Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AEE338585
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611307; cv=none; b=ck6lGPfEECDamQ2VKAC+lt0Bc99bGHs7f4w+IB29fNt8UvjSS/Ytogtu/B1e4Nh/abOp26fI1ZjiXsmO9Ux6GNTDzLsieWeyMK7EQFbEsS2DcvK5SN/6OSQ7eQNbyb5AZsy4Qsm14j0xFH/B7g5uqMD+DAuS4Ah6qwQLHfsRj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611307; c=relaxed/simple;
	bh=MVNCO9CCFRrSrdwsokx3+ZpeY6ATWlVHP/l2rhOEFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1O/PGyNav1BzE7fb4KkTbwW16yR2U78RY0UfRCw/IYtDfuUFm/DFDzoXXYN1T2WaBhoJt0rtFn/hWVZ0M+62wsN+wvNxHkRcISDRgdWbz9Yq9C6S2WzXZoRztoh+GuJ3TINmE3ZarLswrRdYJMFaV1+XRuofw69Rp9pHyCUyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHbJDZc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHbJDZc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764611305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcFeC5ga18zDW/y4c+8+LptEu5ewghzUAe0iXgNeSNw=;
	b=SHbJDZc4msoGFqsJ7Ljy/5SI/GfJBk+EGmP3e8xNCAtlrkOghLtO/shXUotnUow8oJG4K9
	TWFBlM9dVRjdLH2emOmFEVxCOmKLDqQNXfKBTpmv3d3CBoyXQVvFxz0BUExhmiuym8apBk
	KA85Ezg/lbEy8P0rsP2rFQSvUQO204Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-LPOO6yvWMW63oEqcofsNxw-1; Mon,
 01 Dec 2025 12:48:22 -0500
X-MC-Unique: LPOO6yvWMW63oEqcofsNxw-1
X-Mimecast-MFC-AGG-ID: LPOO6yvWMW63oEqcofsNxw_1764611297
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9071180122B;
	Mon,  1 Dec 2025 17:48:14 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.66.60])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21AB1180047F;
	Mon,  1 Dec 2025 17:48:04 +0000 (UTC)
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
Subject: [PATCH v13 mm-new 05/16] khugepaged: introduce is_mthp_order helper
Date: Mon,  1 Dec 2025 10:46:16 -0700
Message-ID: <20251201174627.23295-6-npache@redhat.com>
In-Reply-To: <20251201174627.23295-1-npache@redhat.com>
References: <20251201174627.23295-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In order to add mTHP support, we will often be checking if a given order
is a mTHP or PMD order. Lets create a simple helper function to keep the
code clean and readable.

Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8599c7fa112e..9c041141b2e3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -338,6 +338,11 @@ static bool pte_none_or_zero(pte_t pte)
 	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
 }
 
+static bool is_mthp_order(unsigned int order)
+{
+	return order != HPAGE_PMD_ORDER;
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     vm_flags_t *vm_flags, int advice)
 {
@@ -1071,13 +1076,13 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
 	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
 	if (!folio) {
 		*foliop = NULL;
-		if (order == HPAGE_PMD_ORDER)
+		if (!is_mthp_order(order))
 			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 	}
 
-	if (order == HPAGE_PMD_ORDER)
+	if (!is_mthp_order(order))
 		count_vm_event(THP_COLLAPSE_ALLOC);
 	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
 
-- 
2.51.1

