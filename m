Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42F32A3C3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611156; cv=none; b=C1BvqeId8dxP8saxMnb9h2MoMTEv9LOXnXmsb4dHaKVfnHpovyrmNS/LcBUyoeNNsnWUwyA3yzhZvepHP+CEPOWfbNs/4a25AnqXhhQxSo8Z7X0LTVvqOzjoDg3Rk32ItamFEdJoZcjLQMlijZKC+IEJ6dbv0uIKDdLCPOBsw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611156; c=relaxed/simple;
	bh=bUoF8o+qhtqbCIHGE+B5eohfl/qebE8G1Jg9K7je0to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJHLTTQRM1FDBsMjAf7sSRntwUVSgjN+J9RXihvF0HAvmjmoyHL/oyp0f+hNem4d45MGUHQI6Q+9TNsQAOXhOU7SeV0Tps+AObTL6eGeNUFLKkXe3PvzW4Mw8Dgg+ccohS9tjEtmy/xA6XXso/EmhLBpw5O+7pGjWrMsTaxj3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEvsBevJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEvsBevJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755611153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENywRgeFkaGbdbIXNdDIup+iQujNfOziwpxb6S+KNKI=;
	b=IEvsBevJePTjJYTcQLVjqFVRzktp326qy13Mso4Ci3JI+CCJOiyohx4Gb81au+00NQ0bD8
	dZ7zGsRPvneofZhc8NMzV6I+kZyOMr/KXRsmTeoPikUxDLd2+wo9qVaT0nyjbat9mTxMrd
	oMSzyiPkhtLja2W7CDADKyKCS8irVjg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-PodVLyjuPvO85QIsdcVHrg-1; Tue,
 19 Aug 2025 09:45:49 -0400
X-MC-Unique: PodVLyjuPvO85QIsdcVHrg-1
X-Mimecast-MFC-AGG-ID: PodVLyjuPvO85QIsdcVHrg_1755611145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 044EC19775E2;
	Tue, 19 Aug 2025 13:45:45 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.137])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4934119560AB;
	Tue, 19 Aug 2025 13:45:26 +0000 (UTC)
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
	rdunlap@infradead.org,
	hughd@google.com
Subject: [PATCH v10 09/13] khugepaged: enable collapsing mTHPs even when PMD THPs are disabled
Date: Tue, 19 Aug 2025 07:42:01 -0600
Message-ID: <20250819134205.622806-10-npache@redhat.com>
In-Reply-To: <20250819134205.622806-1-npache@redhat.com>
References: <20250819134205.622806-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Baolin Wang <baolin.wang@linux.alibaba.com>

We have now allowed mTHP collapse, but thp_vma_allowable_order() still only
checks if the PMD-sized mTHP is allowed to collapse. This prevents scanning
and collapsing of 64K mTHP when only 64K mTHP is enabled. Thus, we should
modify the checks to allow all large orders of anonymous mTHP.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7d9b5100bea1..2cadd07341de 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -491,7 +491,11 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+		unsigned long orders = vma_is_anonymous(vma) ?
+					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
+
+		if (thp_vma_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED,
+					    orders))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -2671,6 +2675,8 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
 
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
 	for_each_vma(vmi, vma) {
+		unsigned long orders = vma_is_anonymous(vma) ?
+					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
 		unsigned long hstart, hend;
 
 		cond_resched();
@@ -2678,7 +2684,8 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
+		if (!thp_vma_allowable_orders(vma, vma->vm_flags,
+			TVA_KHUGEPAGED, orders)) {
 skip:
 			progress++;
 			continue;
-- 
2.50.1

