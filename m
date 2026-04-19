Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBF3033CF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625235; cv=none; b=hXUsfGgYKoQ2NU+Kf2niHJElwn2TzATwv1bfQeNJnk3W/J6C/2bhF5uwBCKy3LIVUGuY4iebPxIaq0owKPUX+JXgOGANsF+SMx5YoMOCRxDXxw6il6Y0XcwDg7uQM/9tNThrtZBd6szcZ3RwG3g+h8USp4/EEUM0Rv222xDkVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625235; c=relaxed/simple;
	bh=3ER+YTbmmwldanG3No1Su8z9uWQ8sh6J1G0sB86U8gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dFH/AktIdq6JEpKRkZ7iimua180/xAtd//edn74zLrBpQstg10MDM/75CvyTlNdItPLxuDu4Mkbgf7B80UtFMtolhURRBVKPu7mYzxSwTcfgrJIHsjv8hBKgQ7UQ3wn4D0Wszo+NuHRuiZDgHPFIunlNrwc1lyNpXcN2KKJjrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZCeThwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZCeThwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776625229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gbD4f/RO2mWPwJriUyvKl0G7J4huajbSVgy4DAT/PQ=;
	b=fZCeThwNqBU1Wl43N23aIS4ocdHqqjxei9z+CxSsohep1U3LntohzskRILAVTNTAFQhss/
	G/qLebWE2u48NGwUhWbo9Zdz8EH5Epzqh6TLBG/PgfzSjxYlXutG9VInIjoxJGl1yUg9CA
	QzaPvPAEMBJp4DdtSmg61su7qlLjtDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-6gm84o8iNMCx8NE0C4lc7A-1; Sun,
 19 Apr 2026 15:00:25 -0400
X-MC-Unique: 6gm84o8iNMCx8NE0C4lc7A-1
X-Mimecast-MFC-AGG-ID: 6gm84o8iNMCx8NE0C4lc7A_1776625224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700721956094;
	Sun, 19 Apr 2026 19:00:24 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E2C5195608E;
	Sun, 19 Apr 2026 19:00:08 +0000 (UTC)
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
Subject: [PATCH 7.2 v16 06/13] mm/khugepaged: skip collapsing mTHP to smaller orders
Date: Sun, 19 Apr 2026 12:57:43 -0600
Message-ID: <20260419185750.260784-7-npache@redhat.com>
In-Reply-To: <20260419185750.260784-1-npache@redhat.com>
References: <20260419185750.260784-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: W5Qw_MOnr0FknvGK6Q5VTQU234tHe8G7ngKgX_ciK38_1776625224
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
some pages being unmapped. Skip these cases until we have a way to check
if its ok to collapse to a smaller mTHP size (like in the case of a
partially mapped folio). This check is also not done during the scan phase
as the current collapse order is unknown at that time.

This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].

[1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org> 
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ff6f9f1883ed..8740d379882e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -686,6 +686,14 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				goto out;
 			}
 		}
+		/*
+		 * TODO: In some cases of partially-mapped folios, we'd actually
+		 * want to collapse.
+		 */
+		if (!is_pmd_order(order) && folio_order(folio) >= order) {
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			goto out;
+		}
 
 		if (folio_test_large(folio)) {
 			struct folio *f;
-- 
2.53.0

