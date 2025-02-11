Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD871509A0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=u8jSEfIPyRcfy/ERArZSs9tGTdgbLdRv+K42JuXiF82BucjYLMy+7Z/ZA32DTAsdY8icCD26zzRRFQgFuyun+xnLhbMC6QJ2y2ZyCD3LiuyT1aDNqTYtCstpxG+1OqBlqx4vBYTrU8Q7AJvmTiigcF3Ae+RxAeX7zJpG/QxGccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=xB7GjRFu5QBg0HB0KB9s8GMGBeDvPBs3p/kxcTdlWKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYV4WFYEaGjxo57ndzmFsS1OlLCkRAFPidi77VHaU7rUX4S+DlBzps+jIoMn6cr0BbMw9EeTJTqX6ozC2HEho2kNIgdWXCs/zCbpodOWi9ZcTAHPZ5XwUHgMt5qxc8DE9sNSk7rVGoDAFrfTX/xEoEDrtNUWT8iDsqcm2Ocr1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzlzoKhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzlzoKhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739233894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgDjeCsWqrbzoq3HtDwQTNQUeXq83w6g2bNTg/9HnMA=;
	b=UzlzoKhENc/yTsudbLVJi4sd4x6l3hO0Dg0RF7tx0qQxQo0BD0NOIMq2kNeR1L+4d671aq
	eK1rFCNs3MGmSH1JaDtpZdeeRhZS5PMYRGIL0HtwYZM7CAVAA4HQwv+CTx+2WwSHg65odh
	uBXB85IuGgJnrdDvW5tyaRJ4ftAcmrs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-J1BlQCIqOI2vd53uE_jn0w-1; Mon,
 10 Feb 2025 19:31:30 -0500
X-MC-Unique: J1BlQCIqOI2vd53uE_jn0w-1
X-Mimecast-MFC-AGG-ID: J1BlQCIqOI2vd53uE_jn0w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 020FE19560B7;
	Tue, 11 Feb 2025 00:31:25 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E24981800358;
	Tue, 11 Feb 2025 00:31:14 +0000 (UTC)
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
Subject: [RFC v2 2/9] khugepaged: rename hpage_collapse_* to khugepaged_*
Date: Mon, 10 Feb 2025 17:30:21 -0700
Message-ID: <20250211003028.213461-3-npache@redhat.com>
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

functions in khugepaged.c use a mix of hpage_collapse and khugepaged
as the function prefix.

rename all of them to khugepaged to keep things consistent and slightly
shorten the function names.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 46faee67378b..4c88d17250f4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
 	kmem_cache_destroy(mm_slot_cache);
 }
 
-static inline int hpage_collapse_test_exit(struct mm_struct *mm)
+static inline int khugepaged_test_exit(struct mm_struct *mm)
 {
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
+static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm)
 {
-	return hpage_collapse_test_exit(mm) ||
+	return khugepaged_test_exit(mm) ||
 	       test_bit(MMF_DISABLE_THP, &mm->flags);
 }
 
@@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 	int wakeup;
 
 	/* __khugepaged_exit() must not run from under us */
-	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
+	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
 		return;
 
@@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
 	} else if (mm_slot) {
 		/*
 		 * This is required to serialize against
-		 * hpage_collapse_test_exit() (which is guaranteed to run
+		 * khugepaged_test_exit() (which is guaranteed to run
 		 * under mmap sem read mode). Stop here (after we return all
 		 * pagetables will be destroyed) until khugepaged has finished
 		 * working on the pagetables under the mmap_lock.
@@ -606,7 +606,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		folio = page_folio(page);
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
-		/* See hpage_collapse_scan_pmd(). */
+		/* See khugepaged_scan_pmd(). */
 		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
@@ -851,7 +851,7 @@ struct collapse_control khugepaged_collapse_control = {
 	.is_khugepaged = true,
 };
 
-static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
+static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
 {
 	int i;
 
@@ -886,7 +886,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
 }
 
 #ifdef CONFIG_NUMA
-static int hpage_collapse_find_target_node(struct collapse_control *cc)
+static int khugepaged_find_target_node(struct collapse_control *cc)
 {
 	int nid, target_node = 0, max_value = 0;
 
@@ -905,7 +905,7 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
 	return target_node;
 }
 #else
-static int hpage_collapse_find_target_node(struct collapse_control *cc)
+static int khugepaged_find_target_node(struct collapse_control *cc)
 {
 	return 0;
 }
@@ -925,7 +925,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	struct vm_area_struct *vma;
 	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
 
-	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
+	if (unlikely(khugepaged_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
 
 	*vmap = vma = find_vma(mm, address);
@@ -992,7 +992,7 @@ static int check_pmd_still_valid(struct mm_struct *mm,
 
 /*
  * Bring missing pages in from swap, to complete THP collapse.
- * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
+ * Only done if khugepaged_scan_pmd believes it is worthwhile.
  *
  * Called and returns without pte mapped or spinlocks held.
  * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
@@ -1078,7 +1078,7 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
 {
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
-	int node = hpage_collapse_find_target_node(cc);
+	int node = khugepaged_find_target_node(cc);
 	struct folio *folio;
 
 	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
@@ -1264,7 +1264,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	return result;
 }
 
-static int hpage_collapse_scan_pmd(struct mm_struct *mm,
+static int khugepaged_scan_pmd(struct mm_struct *mm,
 				   struct vm_area_struct *vma,
 				   unsigned long address, bool *mmap_locked,
 				   struct collapse_control *cc)
@@ -1380,7 +1380,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * hit record.
 		 */
 		node = folio_nid(folio);
-		if (hpage_collapse_scan_abort(node, cc)) {
+		if (khugepaged_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
 			goto out_unmap;
 		}
@@ -1449,7 +1449,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit(mm)) {
+	if (khugepaged_test_exit(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
@@ -1744,7 +1744,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
 			continue;
 
-		if (hpage_collapse_test_exit(mm))
+		if (khugepaged_test_exit(mm))
 			continue;
 		/*
 		 * When a vma is registered with uffd-wp, we cannot recycle
@@ -2266,7 +2266,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
-static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
+static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
 				    struct file *file, pgoff_t start,
 				    struct collapse_control *cc)
 {
@@ -2311,7 +2311,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		node = folio_nid(folio);
-		if (hpage_collapse_scan_abort(node, cc)) {
+		if (khugepaged_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
 			break;
 		}
@@ -2357,7 +2357,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 #else
-static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
+static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
 				    struct file *file, pgoff_t start,
 				    struct collapse_control *cc)
 {
@@ -2389,19 +2389,19 @@ static int khugepaged_collapse_single_pmd(unsigned long addr, struct mm_struct *
 
 			mmap_read_unlock(mm);
 			*mmap_locked = false;
-			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
+			result = khugepaged_scan_file(mm, addr, file, pgoff,
 							  cc);
 			fput(file);
 			if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
 				mmap_read_lock(mm);
-				if (hpage_collapse_test_exit_or_disable(mm))
+				if (khugepaged_test_exit_or_disable(mm))
 					goto end;
 				result = collapse_pte_mapped_thp(mm, addr,
 								 !cc->is_khugepaged);
 				mmap_read_unlock(mm);
 			}
 		} else {
-			result = hpage_collapse_scan_pmd(mm, vma, addr,
+			result = khugepaged_scan_pmd(mm, vma, addr,
 							 mmap_locked, cc);
 		}
 		if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
@@ -2449,7 +2449,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		goto breakouterloop_mmap_lock;
 
 	progress++;
-	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
+	if (unlikely(khugepaged_test_exit_or_disable(mm)))
 		goto breakouterloop;
 
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
@@ -2457,7 +2457,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		unsigned long hstart, hend;
 
 		cond_resched();
-		if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
+		if (unlikely(khugepaged_test_exit_or_disable(mm))) {
 			progress++;
 			break;
 		}
@@ -2479,7 +2479,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			bool mmap_locked = true;
 
 			cond_resched();
-			if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
+			if (unlikely(khugepaged_test_exit_or_disable(mm)))
 				goto breakouterloop;
 
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
@@ -2515,7 +2515,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
 	 */
-	if (hpage_collapse_test_exit(mm) || !vma) {
+	if (khugepaged_test_exit(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.48.1

