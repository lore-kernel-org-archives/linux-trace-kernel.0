Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451E2AE66
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436040; cv=none; b=AegwztYh1ijI/v+2IMPQ2KnrmLYpbNAtBoVk2yxnIS4APiyZXu/55l+agUh9BRctHXkjjwhRlSuuciCEkW3gKXbLlx2mSj4Tw2nQmNy8wgcnmDCs+5nMmhv+pLs8gy4f4j4p36zDssE3BXlXcdO3cSYmAy9QvGrIWuLlczbzZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436040; c=relaxed/simple;
	bh=vUBEjYbGY3JxaS0BK4Tz2WAGo1AGM70r1TbHyW1HY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeg8ngl4JFEmiiNaaI+iOxRQCKA2gc1+9URpLdt/DmbNnoXDmBmFKc7rPGUnaf7GAJerd0b7pMTu9DcyHlCNMFXrRo+DQp+wwtdSkKnabDbtE03BRA5H30eDoZxIroTET3mkGBc63W3X3iZu9U+sOtBILyxEbxRaFYT98SlY1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9Sqwxm3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9Sqwxm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751436037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnM62A0y0GYLJiYfrqmXPdYYIUiA0LEzu0+nPh3D+kk=;
	b=a9Sqwxm34xaHCDmW4mWr2/QzFIyyHz3Hjz37W6Y8n/YDAiCNjtyZ2NLm45DNb5zcpe5CKw
	ZSZV+bBctESoba2QeJAr9YgISzg2JK3W9zrCP3htymeaCpMBzVmpXH8AsHcpO/6peUABZf
	u3EkKt8NH8E0ALAXmgDg+teEE1Oh+iw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-paYXR1uOMJuRxkW0FtiDog-1; Wed,
 02 Jul 2025 02:00:36 -0400
X-MC-Unique: paYXR1uOMJuRxkW0FtiDog-1
X-Mimecast-MFC-AGG-ID: paYXR1uOMJuRxkW0FtiDog_1751436032
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3099A1953941;
	Wed,  2 Jul 2025 06:00:32 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E860F18003FC;
	Wed,  2 Jul 2025 06:00:16 +0000 (UTC)
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
	kirill.shutemov@linux.intel.com,
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
	rdunlap@infradead.org
Subject: [PATCH v8 08/15] khugepaged: skip collapsing mTHP to smaller orders
Date: Tue,  1 Jul 2025 23:57:35 -0600
Message-ID: <20250702055742.102808-9-npache@redhat.com>
In-Reply-To: <20250702055742.102808-1-npache@redhat.com>
References: <20250702055742.102808-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
some pages being unmapped. Skip these cases until we have a way to check
if its ok to collapse to a smaller mTHP size (like in the case of a
partially mapped folio).

This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].

[1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a42f08edb0e4..61d2b3ebc7ac 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -612,7 +612,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		folio = page_folio(page);
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
-		/* See hpage_collapse_scan_pmd(). */
+		if (order != HPAGE_PMD_ORDER && folio_order(folio) >= order) {
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			goto out;
+		}
+
+		/* See khugepaged_scan_pmd(). */
 		if (folio_maybe_mapped_shared(folio)) {
 			++shared;
 			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
-- 
2.49.0

