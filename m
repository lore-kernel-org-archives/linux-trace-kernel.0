Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A644A724
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526154; cv=none; b=vCAoxrjXLBCUOv9Pp2r6d27WRrQtVkB0eg28Eq3lDt+qRk+qY3xqgRZsOQUVio/0Sap6wbZNuvp1+Z5QhFfo0i/bsT5R8qFXKZGWLl/uvrcozpir64O73KaJCO2cuacFQV5LUWSjsu+GG2ZJrjeOZQsPr75a4hGnmU4PkpOBMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526154; c=relaxed/simple;
	bh=pnPFm6MG2oJBwsHYmDwxjy8gRPVnTd2ALbTsnK9jiyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lP2V2kkqoqZOLykxJRRTE8WOcb9GGWXuG7PBapwGOXHz97blMjslH1PEJnxDui731ZE7Hy5M2bp+KQpq+CmHV0VhVM6mh5m4KUw+kcAOZbucrr6EwtkfgQIAah/yxBrvYSe40PPCYBVhA4W9UQ1uJhYY2RBcWta86glzwHZ9mDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnnRRdyG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnnRRdyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778526150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcIsBkvpgdnNq3E3JSrfLEznaBAzIQ/TOuUYoY7MXoc=;
	b=YnnRRdyGpmZ8emmV9JTaWQCja0YAhVchUaiFgxMMNv1hwSJ1In1swkH3qvjYhtXe3/n1UP
	szIdnHdtwKF/8rMD4Ml4hd1G/gJh5ZQrF65icNtHNmdMmlM3y1nfrHHFw9VEFT9yPV4Luw
	GH+wm+8/UfZUKMIBIWph6ZS4rFmgIas=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-8WcUUBZENVaJ_mOApAdfzQ-1; Mon,
 11 May 2026 15:02:27 -0400
X-MC-Unique: 8WcUUBZENVaJ_mOApAdfzQ-1
X-Mimecast-MFC-AGG-ID: 8WcUUBZENVaJ_mOApAdfzQ_1778526145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E791800451;
	Mon, 11 May 2026 19:02:25 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4D5130001BE;
	Mon, 11 May 2026 19:02:06 +0000 (UTC)
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
	zokeefe@google.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH mm-unstable v17 13/14] mm/khugepaged: run khugepaged for all orders
Date: Mon, 11 May 2026 12:58:13 -0600
Message-ID: <20260511185817.686831-14-npache@redhat.com>
In-Reply-To: <20260511185817.686831-1-npache@redhat.com>
References: <20260511185817.686831-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: hTwLABj6bQndXJw2igYCVAJau2bMrz4lWn-W99rOdJ4_1778526145
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Baolin Wang <baolin.wang@linux.alibaba.com>

If any order (m)THP is enabled we should allow running khugepaged to
attempt scanning and collapsing mTHPs. In order for khugepaged to operate
when only mTHP sizes are specified in sysfs, we must modify the predicate
function that determines whether it ought to run to do so.

This function is currently called hugepage_pmd_enabled(), this patch
renames it to hugepage_enabled() and updates the logic to check to
determine whether any valid orders may exist which would justify
khugepaged running.

We must also update collapse_allowable_orders() to check all orders if
the vma is anonymous and the collapse is khugepaged.

After this patch khugepaged mTHP collapse is fully enabled.

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f0ae02936638..5ba298d420b7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -522,23 +522,23 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
 		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
 }
 
-static bool hugepage_pmd_enabled(void)
+static bool hugepage_enabled(void)
 {
 	/*
 	 * We cover the anon, shmem and the file-backed case here; file-backed
 	 * hugepages, when configured in, are determined by the global control.
-	 * Anon pmd-sized hugepages are determined by the pmd-size control.
+	 * Anon hugepages are determined by its per-size mTHP control.
 	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
 	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
 	 */
 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 	    hugepage_global_enabled())
 		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
+	if (READ_ONCE(huge_anon_orders_always))
 		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
+	if (READ_ONCE(huge_anon_orders_madvise))
 		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
+	if (READ_ONCE(huge_anon_orders_inherit) &&
 	    hugepage_global_enabled())
 		return true;
 	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
@@ -579,7 +579,13 @@ void __khugepaged_enter(struct mm_struct *mm)
 static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
 		vm_flags_t vm_flags, enum tva_type tva_flags)
 {
-	unsigned long orders = BIT(HPAGE_PMD_ORDER);
+	unsigned long orders;
+
+	/* If khugepaged is scanning an anonymous vma, allow mTHP collapse */
+	if ((tva_flags == TVA_KHUGEPAGED) && vma_is_anonymous(vma))
+		orders = THP_ORDERS_ALL_ANON;
+	else
+		orders = BIT(HPAGE_PMD_ORDER);
 
 	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
@@ -588,10 +594,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
-	    hugepage_pmd_enabled()) {
-		if (collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED))
-			__khugepaged_enter(vma->vm_mm);
-	}
+	    collapse_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED) &&
+	    hugepage_enabled())
+		__khugepaged_enter(vma->vm_mm);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
@@ -2945,7 +2950,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
 
 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && hugepage_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -3018,7 +3023,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (hugepage_pmd_enabled())
+	if (hugepage_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -3049,7 +3054,7 @@ void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_pmd_enabled()) {
+	if (!hugepage_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -3099,7 +3104,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled()) {
+	if (hugepage_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -3125,7 +3130,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled() && khugepaged_thread)
+	if (hugepage_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
-- 
2.54.0

