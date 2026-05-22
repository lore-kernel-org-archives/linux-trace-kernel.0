Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922E466B63
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462194; cv=none; b=IUsIUZexQgrwiHjMAKyzQLbeHz67bUQdBIPI8bPP4KbAdE1POJWilcvxHppHY5kG086AdbRMOTNzfDOVet2euu6FPsIs/Kt69jDdl8qCGhtvA+z92bARwblXGL70LWRp/BIfL8aSo7Ajb5nXQOvHCLdj5i8iExRIb+ff/TC/45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462194; c=relaxed/simple;
	bh=n0Yt7DsxkCHd5UxgNIlCxVQPLNxa1Qj2HnKBvKOKk68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LWjltxRXRe/BFOGgTwtVW2WGasQM3rNAQa91fOgZ2W6jz6KRX8XFd/hkDIHXjz5uXBnzbinwsMyEODZFVX29wN0KsuRTxg3NKtj3/6f2K2SAkc3uPSpR7q0sZhQhHocpkSBR+Ktklc15/UqbveluKQDqiaTDp8WXyytgda6/eM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoaRNCBX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoaRNCBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779462190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWfwFFjl6Lb4dHrdy8ub/C3enhHFGrLhYF9NHuqt4M4=;
	b=NoaRNCBXBKYaSCRqqRLqYxk2PTSxquB31DSc62e0gNvS5Oq03n92DDWmpLSbP9+9RMjgJC
	/5szGhWredqkKFeR0KgDyYBv4uFxcr+cEtDcjRWgBYtdyRuQX2ozen+sW+guUihl2oka/x
	ivqybb986MzTj90uegWZMtkp0u5l4ug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-Y9yaIetZOm2-3UAeYPb19A-1; Fri,
 22 May 2026 11:03:07 -0400
X-MC-Unique: Y9yaIetZOm2-3UAeYPb19A-1
X-Mimecast-MFC-AGG-ID: Y9yaIetZOm2-3UAeYPb19A_1779462186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C5219560A2;
	Fri, 22 May 2026 15:03:06 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.24.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B9471800576;
	Fri, 22 May 2026 15:02:48 +0000 (UTC)
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
	liam@infradead.org,
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
Subject: [PATCH mm-unstable v18 10/14] mm/khugepaged: introduce collapse_allowable_orders helper function
Date: Fri, 22 May 2026 09:00:05 -0600
Message-ID: <20260522150009.121603-11-npache@redhat.com>
In-Reply-To: <20260522150009.121603-1-npache@redhat.com>
References: <20260522150009.121603-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: O6Lif7N5o4kFiTbsXwrAj-ySbqbYVe_5OpdiUznidy0_1779462186
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add collapse_allowable_orders() to generalize THP order eligibility. The
function determines which THP orders are permitted based on collapse
context (khugepaged vs madv_collapse).

This consolidates collapse configuration logic and provides a clean
interface for future mTHP collapse support where the orders may be
different.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4534025bc81d..64ceebc9d8a7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -552,12 +552,21 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
+/* Check what orders are allowed based on the vma and collapse type */
+static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
+		vm_flags_t vm_flags, enum tva_type tva_flags)
+{
+	unsigned long orders = BIT(HPAGE_PMD_ORDER);
+
+	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+		if (collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -2680,7 +2689,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 			cc->progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
+		if (!collapse_allowable_orders(vma, vma->vm_flags, TVA_KHUGEPAGED)) {
 			cc->progress++;
 			continue;
 		}
@@ -2989,7 +2998,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
+	if (!collapse_allowable_orders(vma, vma->vm_flags, TVA_FORCED_COLLAPSE))
 		return -EINVAL;
 
 	cc = kmalloc_obj(*cc);
-- 
2.54.0

