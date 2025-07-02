Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26322AE8B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436092; cv=none; b=XmAO0lASIrgIg0H05/2QuEPbUh8hi2Zc4iQSQ0kYKcszaXRYjJdQjeeFdm5u2SZu9zAqQNGwqb4tH5JjxIYCB2JkCD3v0lZG7svsLPxVC0VIG6MlsJFJGaHvtX48vLxiflUix5ZfTTnh+Kg87pKk5rH6Xp37D8jXswajaramT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436092; c=relaxed/simple;
	bh=g4V9DvZy86AmYxsZbjXmyqrMPPS/X9r+lilkJ6a6Wac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O93TlT+AqZlUG5cTZqi7L8+cOgfYRpRkaZsDA6ACijCrlrvWqOBSZbvHrRlLq9LdCFItzzl67crcGGgELLP/mU6kKpn4YvML4QH9jWMjnwurNVSuGjwhJ/Ijy46YOVDUJegrDq6zh5CO34Ks5aTKfnOg4ySWLLIMG2abcwFKLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvMZn8gG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvMZn8gG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751436089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pClnkwE28GE4qFvtDIHtCpJBujOjEEnlN0VFfKLLmHs=;
	b=DvMZn8gG2ODqmmfjxx/WFFR1I+KZp1axmOJ9/Ucz84deJPSzpn8KhUB1bcti5+Q/XWWq6Y
	tVJAYWS1Pn22UCBbSXOTtagVaDySgw1bgdC+m5PMjT+d0fK/Dp5/t3vz8nmnTvQcECU6aX
	BBcQBpazVDxCqFDSb3VgWBOy2AD19G4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-vEXaRJnlMOeMD53K8UT_uA-1; Wed,
 02 Jul 2025 02:01:28 -0400
X-MC-Unique: vEXaRJnlMOeMD53K8UT_uA-1
X-Mimecast-MFC-AGG-ID: vEXaRJnlMOeMD53K8UT_uA_1751436081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39E1C180120D;
	Wed,  2 Jul 2025 06:01:19 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5241B18003FC;
	Wed,  2 Jul 2025 06:01:04 +0000 (UTC)
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
Subject: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check all anonymous mTHP orders
Date: Tue,  1 Jul 2025 23:57:38 -0600
Message-ID: <20250702055742.102808-12-npache@redhat.com>
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

Allow madvise_collapse to scan/collapse all mTHP orders without the
strict requirement of needing the PMD-order enabled.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b96a7327b9c0..6ea681b81647 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2930,11 +2930,13 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	unsigned long hstart, hend, addr;
 	int thps = 0, last_fail = SCAN_FAIL;
 	bool mmap_locked = true;
+	unsigned long orders = vma_is_anonymous(vma) ?
+					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
 
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
+	if (!thp_vma_allowable_orders(vma, vma->vm_flags, 0, orders))
 		return -EINVAL;
 
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
@@ -2956,7 +2958,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 			mmap_read_lock(mm);
 			mmap_locked = true;
 			result = hugepage_vma_revalidate(mm, addr, false, &vma,
-							 cc, BIT(HPAGE_PMD_ORDER));
+							 cc, orders);
 			if (result  != SCAN_SUCCEED) {
 				last_fail = result;
 				goto out_nolock;
-- 
2.49.0

