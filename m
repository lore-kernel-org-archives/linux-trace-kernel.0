Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831F1E3DC8;
	Wed, 28 May 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435529; cv=none; b=A0m6Qeig85WNci3zGzHfhHsANLJkdABRdFI+B1++gAP0N2qWdzMlwbF7TEVdxzXdvhjtXd3Rt/IG42Hpav2g8QNT+qL0hYHG4bKBAPsP15/8by7PDi2BupcR0MO0ofRwc197V8YPOktP0iYiETKdKGSgbmS+HVweGVp9g54m/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435529; c=relaxed/simple;
	bh=bIYbEVWluhCTPXdhEP2fq4IWKcmxg1+/ZE8+yCBn38M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYNA47k1+YgETBMyJZY0VjF9CU1XZACVT8wQC7w9SDpR9AE939iLjSRkdRIQFd4SLoOkKRvkBtujoOVFOocm+Yr6NZ/8E2Dqdqrf5EyoUc8iiuKq0jDIzzuH+2jqu+RsZaANBzOLTZSC7nIuAvOCRL2ZQrVXOilfip3cNhPyuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PBal/pqn; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PBal/pqn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748435524; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZbL34hcVzNUdnkbTcE5pb/KuNOeDYKvzQq5G8mjvizg=;
	b=PBal/pqn5GI60krA/uA7TusuXeveZIQg0vVXQjjfs5RlIVWQXWNzY7Ik1UEUw0sOGfPMqvJ9JVL5TkNaumhvecVVjgydQNgtTdbxS3y6oQgDJ2j2LlI93BfX4XuN8NDm4CukZ20tXGEE9x7ZWVPOm7FtRmLO7BSKrB0jorY6qEo=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcDRdUh_1748435520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 20:32:01 +0800
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
Subject: [PATCH 1/2] mm: khugepaged: allow khugepaged to check all anonymous mTHP orders
Date: Wed, 28 May 2025 20:31:46 +0800
Message-ID: <ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250515032226.128900-1-npache@redhat.com>
References: <20250515032226.128900-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have now allowed mTHP collapse, but thp_vma_allowable_order() still only
checks if the PMD-sized mTHP is allowed to collapse. This prevents scanning
and collapsing of 64K mTHP when only 64K mTHP is enabled. Thus, we should
modify the checks to allow all large orders of anonymous mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0723b184c7a4..16542ecf02dc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -491,8 +491,11 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+		unsigned long orders = vma_is_anonymous(vma) ?
+					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
+
+		if (thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
+					    orders))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -2618,6 +2621,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
 	for_each_vma(vmi, vma) {
+		unsigned long orders = vma_is_anonymous(vma) ?
+					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
 		unsigned long hstart, hend;
 
 		cond_resched();
@@ -2625,8 +2630,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+		if (!thp_vma_allowable_orders(vma, vma->vm_flags,
+					TVA_ENFORCE_SYSFS, orders)) {
 skip:
 			progress++;
 			continue;
-- 
2.43.5

