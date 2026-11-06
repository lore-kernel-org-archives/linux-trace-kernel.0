Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009097;
	b=TuWW6UnLD6VpWj8uFqnnKh+2cX3JnI+OH3rsH/j8jDTnSdkOzfErTQ76SXiS5HBd6YGA
	 NrWx1meam8E8QeSHSXU5kba2JPwW3/Kendu8rjoReZfMzT2cLMtONunGaSXPNVOp/ByTl
	 RQi6GL6f16qWD4zJTr8W0x0P+oI1IcZVm7xBYxP1FZSsQxM4qP+CDFdgbbSPi6nBUaWLx
	 +Nc7nJrZBXeIp9qR4q2wu2g7l+c/W3RNQe4jwFfDcHFUpKia2jdor/sP9PX0q7xTWg297
	 7LNl4XFUXV77K5lTLNmCoicLV2NdQHpWJ7Vc9+Uca13d25McFz+Xj2SplaSfVSRmuWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009097;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lfHkyy9F0GN/3hlkFeSrQiqR30IMzmcD3m/nAdVEVYo=;
	b=0ChFzTih7pm5bbn9XvkLJKY+pIi8DKLE1g2VxRnQVkaiSqZILihL6hcKbdIVRFF1LFLs
	 z9X/ExmyYcUGiWzuphGoHMKojd448qCxsoDIpG40G6yL6Q3xvJ7nxo5D8i4/7mcWoQUiA
	 F9yS3uArHsEGROodEweoETe5G+iBFzlvW/7JQbJU4rjJ2mKR46utqAvdouuckl5IJuQnz
	 G25XzAZbtP9AkRhsZiil8C5GNq34Wh7FeV9TbwcSEeTiTFnfC7e5H1yQ63lBZ3JjK/YzB
	 e1BfTU6Zsyj2aKARg0MYiOzC1EEVpccayvHVYmOv+Nv1SM1VwMKVWJGWEHbmtg4hUDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2bUN91Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC7606A326;
	Fri,  6 Nov 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2bUN91Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D2C1F008A2;
	Fri,  6 Nov 2026 23:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794009097;
	bh=lfHkyy9F0GN/3hlkFeSrQiqR30IMzmcD3m/nAdVEVYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n2bUN91QYL5hhj1DTmnS8jzjWtwSLhUihk3RAJa64EoL5JgttMem1Pj0ZjstoIbbM
	 2Bzby0qdkERcMPcX1r+7egf+b4XQ4DgBARNmV/S/+W1jQ6ki1+01e3qXE13QuTOeKN
	 V1nNA4t0+0ZoPppyqkcb9IKd67ck0pifGttaprR3Nkbh5nkSanQp0s4UGdjL0IEiCh
	 Ml3xz3BBUGUMEnCHK1piAuXfdtMSxy7Omso5MCb7pTUu7p+mJOPgFW2aFZ0zpf2ndP
	 qBYnl71jg4YVL/9B90WfikpLPax7R374AvP+hR6Y5r7JxVpEasmlZaTKZQodLKJOWd
	 EDRdnmhNPFWVQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 07 Nov 2026 00:51:06 +0100
Subject: [PATCH 2/2] mm/khugepaged: check for empty PTE tables before
 retracting
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-b4-uffd_marker_loss-v1-2-82926b22704c@kernel.org>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
In-Reply-To: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Peter Xu <peterx@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7308; i=david@kernel.org;
 h=from:subject:message-id; bh=34SRpvzvO0Nshm7TUytyAhxQ4DZ5vKoV8iMQD9fw14g=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLepb9dk6Fe9D/PbQKT2/pqD++WFb+iS7KSb7He4/jBx
 F2ec+51RykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABMJXcfwv84jztwnKp3/84LA
 1Y/i+JRX3V/9IHRep+emhIbNf1Rm/GD4Z/7w1PKfD7ueP2Li/K3+pfzqpcpUzvUPTloy6e9okX8
 5hwkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

retract_page_tables() uses elaborate (error-prone) logic to avoid scanning
whether a page table is empty.

Let's prevent more future bugs and reduce the complexity by doing it
just like try_collapse_pte_mapped_thp(): scan if the page table is
empty. Keep the check for anon_vma in place.

Scan under the PTE lock only and try to grab the PMD lock afterwards.
If that fails, drop the PTE lock, take both locks in the right order
and check again. This avoids holding the PMD lock during the scan in
the common case.

This will now retract in more cases where the VMA flags were an
over-indication, with the cost of scanning more frequently under lock.

We could scan lockless first, but it doesn't really seem worth it for
now. If this ever becomes a problem, we could do that, or alternatively
refuse again more of the VMA flags early.

The structure of the retraction code is now similar to
try_collapse_pte_mapped_thp(), with some slight differences (e.g.,
initial empty scan) that make this harder to generalize. But likely we
should look in the future into merging more of that code.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 127 ++++++++++++++++++++------------------------------------
 1 file changed, 45 insertions(+), 82 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2a5ee8fc42335..f39ea3d076554 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1884,8 +1884,9 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		return SCAN_VMA_CHECK;
 
 	/*
-	 * Keep pmd pgtable while the uffd bit is in use; see comment in
-	 * retract_page_tables().
+	 * Keep the PTE table for uffd-wp and RWP registrations: it may
+	 * contain per-PTE protection state that cannot be reconstructed
+	 * from the page cache.
 	 */
 	if (userfaultfd_protected(vma))
 		return SCAN_PTE_UFFD;
@@ -2081,48 +2082,6 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	try_collapse_pte_mapped_thp(mm, addr, install_pmd);
 }
 
-/* Can we retract page tables for this file-backed VMA? */
-static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
-{
-	/*
-	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
-	 * got written to. These VMAs are likely not worth removing
-	 * page tables from, as PMD-mapping is likely to be split later.
-	 *
-	 * Can't use vma_has_anon_rmap() here as the VMA may be stabilised
-	 * by the file rmap lock.
-	 */
-	if (READ_ONCE(vma->anon_vma))
-		return false;
-
-	/*
-	 * When a vma is registered with uffd-wp or RWP, we cannot recycle
-	 * the page table because there may be pte markers installed.
-	 * VM_UFFD_RWP ranges similarly rely on per-PTE uffd state
-	 * and cannot be recycled to a shared PMD. Other vmas can still
-	 * have the same file mapped hugely, but skip this one: it will
-	 * always be mapped in small page size for these registrations.
-	 */
-	if (userfaultfd_protected(vma))
-		return false;
-
-	/*
-	 * Preserve guard and poison markers when retracting page tables.
-	 *
-	 * These flags are set atomically on marker installation under mmap/VMA
-	 * read lock, and here we may not hold any VMA or mmap lock at all.
-	 *
-	 * This is therefore serialised on the PTE page table lock, which is
-	 * obtained on marker installation after the flag is set, so this
-	 * check being performed under this lock excludes races.
-	 */
-	if (vma_test_atomic_flag(vma, VMA_MAYBE_GUARD_BIT) ||
-	    vma_test_atomic_flag(vma, VMA_MAYBE_UFFD_POISON_BIT))
-		return false;
-
-	return true;
-}
-
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
@@ -2133,10 +2092,18 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		struct mm_struct *mm;
 		unsigned long addr;
 		pmd_t *pmd, pgt_pmd;
-		spinlock_t *pml;
-		spinlock_t *ptl;
+		pte_t *pte;
+		spinlock_t *pml = NULL, *ptl;
 		bool success = false;
 
+		/*
+		 * Skip private mappings that have been written to: we'll likely
+		 * split them as soon as we CoW later. Use READ_ONCE() because
+		 * we are neither holding the VMA lock nor the mmap_lock.
+		 */
+		if (READ_ONCE(vma->anon_vma))
+			continue;
+
 		addr = vma->vm_start +
 			((pgoff - vma_start_pgoff(vma)) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK ||
@@ -2150,52 +2117,48 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		if (collapse_test_exit(mm))
 			continue;
 
-		if (!file_backed_vma_is_retractable(vma))
-			continue;
-
 		/* PTEs were notified when unmapped; but now for the PMD? */
 		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 					addr, addr + HPAGE_PMD_SIZE);
 		mmu_notifier_invalidate_range_start(&range);
 
-		pml = pmd_lock(mm, pmd);
-		/*
-		 * The lock of new_folio is still held, we will be blocked in
-		 * the page fault path, which prevents the pte entries from
-		 * being set again. So even though the old empty PTE page may be
-		 * concurrently freed and a new PTE page is filled into the pmd
-		 * entry, it is still empty and can be removed.
-		 *
-		 * So here we only need to recheck if the state of pmd entry
-		 * still meets our requirements, rather than checking pmd_same()
-		 * like elsewhere.
-		 */
-		if (check_pmd_state(pmd) != SCAN_SUCCEED)
-			goto drop_pml;
-		ptl = pte_lockptr(mm, pmd);
-		if (ptl != pml)
-			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			goto unlock;
 
 		/*
-		 * Huge page lock is still held, so normally the page table must
-		 * remain empty; and we have already skipped vmas with an anon
-		 * rmap and userfaultfd_wp() vmas.  But since the mmap_lock is not
-		 * held, it is still possible for a racing userfaultfd_ioctl() or
-		 * madvise() to have inserted ptes or markers.  Now that we hold
-		 * ptlock, repeating the retractable checks protects us from
-		 * races against the prior checks.
+		 * The folio lock prevents file faults from modifying the
+		 * page table, but other things (userfaultfd, CoW, guard
+		 * markers) could have modified the page table until we lock it
+		 * and check.
 		 */
-		if (likely(file_backed_vma_is_retractable(vma))) {
-			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
-			pmdp_get_lockless_sync();
-			success = true;
-		}
+		if (!pte_table_empty(pte))
+			goto unlock;
 
-		if (ptl != pml)
-			spin_unlock(ptl);
-drop_pml:
-		spin_unlock(pml);
+		pml = pmd_lockptr(mm, pmd);
+		if (ptl != pml && !spin_trylock(pml)) {
+			pte_unmap_unlock(pte, ptl);
+			ptl = NULL;
+
+			pml = pmd_lock(mm, pmd);
+			pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
+			if (!pte)
+				goto unlock;
+			if (ptl != pml)
+				spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+			if (!pte_table_empty(pte))
+				goto unlock;
+		}
+
+		pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
+		pmdp_get_lockless_sync();
+		success = true;
+unlock:
+		if (pte)
+			pte_unmap_unlock(pte, ptl);
+		if (pml && pml != ptl)
+			spin_unlock(pml);
 		mmu_notifier_invalidate_range_end(&range);
 
 		if (success) {

-- 
2.43.0

