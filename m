Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339A2857E9;
	Wed, 28 May 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435535; cv=none; b=pJ97HAeQZtT5UNv35vn1z0xEKyFCvbUjAJJko3HZccDFD091WWyFGezr3h0+QNOfRik80mCqcDbO/uSrvpu8Ex5+/IaaGmKGSzZuWIbzCRWvqceWk6EgAmVO6J5T7yVyOlz2z7sKRo6xPy6U3P0BfX4ApLdipKcgkEd9hAh3a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435535; c=relaxed/simple;
	bh=XsuGcvuuUUXS4jLOz4WB0yYprAtWn37b+rIUVP12rHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tir7gO3Hcs4QWSldHfvGKuCdeSwU8ClsBpj7KUlU/vUWsX2NHKqtw6d9YxktJJfizbGDzd93MN9HAOYyP6lTWVSMFX1B/+xL1YwrQW5+Q/yZaAE1irfshrKIbIOf8zgYPE/upixfGVjn/w/ansn9qMCUDUqoA0SSFF/1CH2Bkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sGVWfweY; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sGVWfweY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748435525; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pFNh0IVheZ8qINWFs4u+FxqVL8vEpYnDU+CU4iwFCWw=;
	b=sGVWfweY0PrtEwmYxRuPhkp8JReIeP0T7p/K6QxyBgxhot/y94qu1l9Rynpcl83VuyiE/wXZgubORVeIUvmdhcvLRrl+0jIegQgGX+rTabJbkYhuLEaYhXyngmnmlUVSRdmXDs6FIlor2V5goKvopOYNfAxZW11e157o1tI094k=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcDRdVN_1748435522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 20:32:02 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: npache@redhat.com
Cc: Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jglisse@google.com,
	kirill.shutemov@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	rientjes@google.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: [PATCH 2/2] mm: khugepaged: kick khugepaged for enabling none-PMD-sized mTHPs
Date: Wed, 28 May 2025 20:31:47 +0800
Message-ID: <5ced00b4f9e53138fac98125655a533730857e7b.1748435162.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com>
References: <ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When only non-PMD-sized mTHP is enabled (such as only 64K mTHP enabled),
we should also allow kicking khugepaged to attempt scanning and collapsing
64K mTHP. Modify hugepage_pmd_enabled() to support mTHP collapse, and
while we are at it, rename it to make the function name more clear.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16542ecf02dc..155ef8d286e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -430,7 +430,7 @@ static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm)
 	       test_bit(MMF_DISABLE_THP, &mm->flags);
 }
 
-static bool hugepage_pmd_enabled(void)
+static bool hugepage_enabled(void)
 {
 	/*
 	 * We cover the anon, shmem and the file-backed case here; file-backed
@@ -442,11 +442,11 @@ static bool hugepage_pmd_enabled(void)
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
@@ -490,7 +490,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_pmd_enabled()) {
+	    hugepage_enabled()) {
 		unsigned long orders = vma_is_anonymous(vma) ?
 					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
 
@@ -2711,7 +2711,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 
 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && hugepage_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2784,7 +2784,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (hugepage_pmd_enabled())
+	if (hugepage_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2815,7 +2815,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_pmd_enabled()) {
+	if (!hugepage_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2865,7 +2865,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled()) {
+	if (hugepage_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2891,7 +2891,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled() && khugepaged_thread)
+	if (hugepage_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
-- 
2.43.5

