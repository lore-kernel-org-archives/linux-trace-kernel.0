Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D5380FC6;
	Sun, 23 Aug 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487494; cv=none; b=o3KNTHmWj2gdZ7FF6qV6+cFYRjWDfljBbWFyVledC8S+3qVC2daQPQC2uT+WcqvmpVMU32Cv7CYHegj6Wu1pqHuy0Q8llsEm6rFcH4bLLYXeclDFPv5v1SsW+0g5E8lOUaK1zxQ2w9O0d+p72UT3W/5KDY/4+YV1d07f+qn7w6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487494; c=relaxed/simple;
	bh=Qg7yx77FSVBEj+CsfPgiLo7sYpsRpr/h5Y+cKLlLcrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJ8w3Ino5mx2yjGVfzPLsfldbIRNNbwQoUzZEhoEE1/xcTmmtFaytNtGtpaObm2r0z6+0ElcdznJtmzpedM1FC0QGu8Sn3lYouP9pgqc6t3NU23cIGKIOqQKCExBXDeEZsR42NZidofd8n5K0eUNueGIolb4uYMmQlIqXrwKZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1iX059/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1iX059/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB31F00A3A;
	Sun, 23 Aug 2026 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787487493;
	bh=nPcwKjVe7nvZQyU74ZGx+OhASVw5VhjTqdhj+ioxLpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g1iX059/4fd671ipoP1cbd8ep4SvuMjBn2cP6Nmd1GFSZz4JBgseMsWqA3UYSw0An
	 HQRWbf0n89PZVfi9hwgTvOF3htN9Dwr2umNmTOcziuGSoCxI6MrTZDkJonFATEkoXu
	 bOUH7gWOBRjroBmd9mMq+HVynUNmUXmAk3TcKzFkUV5z0NK6tKfCBzg528GuJtHtm3
	 1XHuHpTTiAWfznjJ2OKA6uRkSHTeREfiJNjVC/jBH7YeanuaqHH+/u6L0Rw0uHETqZ
	 kOywUx3JSn3XISIR1I+COtEeys1DRIiGtfh/TxvThI1iwPvEISDqM8MZJgZnUoDJ+y
	 J3FXqk71iVqwQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 23 Aug 2026 15:17:40 +0300
Subject: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Muchun Song <muchun.song@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>, 
 Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev

Move userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected()
ahead of uffd_disable_huge_pmd_share() and uffd_disable_fault_around()
and make the latter two use the helpers rather than open coded VMA flag
masks.

Convert open coded VMA flag test in mfill_get_vma() to userfaultfd_wp()
as well.

With every user of the per-VMA uffd modes going through the helpers,
their underlying representation can be changed in the next step.

No functional change.

Assisted-by: copilot:claude-opus-5
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/userfaultfd_k.h | 70 +++++++++++++++++++++----------------------
 mm/userfaultfd.c              |  2 +-
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3396d270b159..d8262e3dc134 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -168,42 +168,6 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
 }
 
-/*
- * Never enable huge pmd sharing on some uffd registered vmas:
- *
- * - VM_UFFD_WP and VM_UFFD_RWP VMAs, because the write protect / access
- *   tracking information is per pgtable entry.
- *
- * - VM_UFFD_MINOR VMAs, because otherwise we would never get minor faults for
- *   VMAs which share huge pmds. (If you have two mappings to the same
- *   underlying pages, and fault in the non-UFFD-registered one with a write,
- *   with huge pmd sharing this would *also* setup the second UFFD-registered
- *   mapping, and we'd not get minor faults.)
- */
-static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
-{
-	return vma_test_any_mask(vma,
-		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
-					VMA_UFFD_MINOR));
-}
-
-/*
- * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
- * MINOR registered range, fault around will be a total disaster and ptes can
- * be installed without notifications; for WP it should mostly be fine as long
- * as the fault around checks for pte_none() before the installation, however
- * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
- * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
- * and pollute the tracked working set, so each page must be populated by its
- * own fault.
- */
-static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
-{
-	return vma_test_any_mask(vma,
-		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
-					VMA_UFFD_MINOR));
-}
-
 static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
@@ -235,6 +199,40 @@ static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
 	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
 }
 
+/*
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - uffd-WP and uffd-RWP VMAs, because the write protect / access tracking
+ *   information is per pgtable entry.
+ *
+ * - uffd-MINOR VMAs, because otherwise we would never get minor faults for
+ *   VMAs which share huge pmds. (If you have two mappings to the same
+ *   underlying pages, and fault in the non-UFFD-registered one with a write,
+ *   with huge pmd sharing this would *also* setup the second UFFD-registered
+ *   mapping, and we'd not get minor faults.)
+ */
+static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
+{
+	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
+	       userfaultfd_rwp(vma);
+}
+
+/*
+ * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
+ * MINOR registered range, fault around will be a total disaster and ptes can
+ * be installed without notifications; for WP it should mostly be fine as long
+ * as the fault around checks for pte_none() before the installation, however
+ * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
+ * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
+ * and pollute the tracked working set, so each page must be populated by its
+ * own fault.
+ */
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
+	       userfaultfd_rwp(vma);
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74f04c323c50..32003aa04943 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -261,7 +261,7 @@ static int mfill_get_vma(struct mfill_state *state)
 	 * validate 'mode' now that we know the dst_vma: don't allow
 	 * a wrprotect copy if the userfaultfd didn't register as WP.
 	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if ((flags & MFILL_ATOMIC_WP) && !userfaultfd_wp(dst_vma))
 		goto out_unlock;
 
 	if (is_vm_hugetlb_page(dst_vma))

-- 
2.53.0

