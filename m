Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E28380FC6;
	Sun, 23 Aug 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487478; cv=none; b=X+uQrsvCHSakkxQdQXdqUEmL0z5Yh8EK2Ft3bCKnKw9GqJHO0gdb849sFKQpR0HIjt3ni5ioA/FotxYqatszoDGEt3ObFafVlexnjPBvNcTa3ZvkhAf1POSr+AeUyV9bgra0Eza9waXK6ByUOV1mvR3aQlhz111LX8bk677ZHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487478; c=relaxed/simple;
	bh=31qEUMxCD1kfVB9JiEfF3V96sT9VroYttG2bG4L6wiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcWnXVv2GX7lQczgk4Pu7sCXCwVZ0J4L9zqtm8WRA3fSR+CvVuJlNY0GqzwTSuUCCEjG4rTr9pli1RahT+tn767oDpLWZ6kxqt2gxATCxxqp0KJ3GLPZQhlzlcNY7uX31MK7ynceo4vYka0+i4JSa7ylq1zXIxt3y5CblGJeHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdB62QeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdB62QeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9721F00A3A;
	Sun, 23 Aug 2026 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787487477;
	bh=phtAfk9967tvw5jCZ8EwhMxuR9BV70DOT2vnREg6Av0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JdB62QeLHfrgk01rU7saumkTHude9O5ljmTk8ojegK2RGvEuN1X6v0+bfsUBT3oC8
	 BrrdKyH8U+RenOUG0fNyJGhL761oH3Uggo6pqg/KnEcJ8gvjVzWNkQd+eUxp3Cy4nK
	 ppxrXNG7PBxHFWlT9GuW0UhWK/ezVtolSz/FTRGF7LcYtPJHhV8w4QvIyFiT59gttD
	 FqaZ/wlxuzjVHlojywG4R7foLh5P3doLWKkw0bKIj+L4G6DeZX6+lX3GRS653oR5vz
	 Kjhrj0tTRMDE2EJm5T0PvMXlQSrTWVyAkH+VBPOJmvZAcUq17e1hyIlMUAmNPEIf1f
	 EGV0bagWOWW5A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 23 Aug 2026 15:17:38 +0300
Subject: [PATCH 1/6] mm/gup: move gup_can_follow_protnone() to gup.c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
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

gup_can_follow_protnone() is defined in include/linux/mm.h but only used
by mm/gup.c.

First, there is no reason to have it in already gigantic header.

Next, the upcoming refactoring of userfaultfd flags will make
gup_can_follow_protnone() depend on userfaultfd_k.h which would cause a
cyclic header dependency.

Move gup_can_follow_protnone() to mm/gup.c.

No functional change.

Assisted-by: copilot:claude-opus-5
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h | 38 --------------------------------------
 mm/gup.c           | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0829e0d3b2d1..4daf9cd6ae8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4860,44 +4860,6 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 	return 0;
 }
 
-/*
- * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
- * a (NUMA hinting or userfaultfd RWP) fault is required.
- */
-static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
-					   unsigned int flags)
-{
-	/*
-	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
-	 * NUMA hinting. GUP must always take a fault so the access is
-	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
-	 *
-	 * Only do so while the VMA is accessible. If it has been made
-	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
-	 * below: forcing a fault there would loop, as handle_mm_fault() makes
-	 * no progress on protnone in an inaccessible VMA, and the access is
-	 * denied regardless of RWP anyway.
-	 */
-	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
-		return false;
-
-	/*
-	 * If callers don't want to honor NUMA hinting faults, no need to
-	 * determine if we would actually have to trigger a NUMA hinting fault.
-	 */
-	if (!(flags & FOLL_HONOR_NUMA_FAULT))
-		return true;
-
-	/*
-	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
-	 *
-	 * Requiring a fault here even for inaccessible VMAs would mean that
-	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
-	 * refuses to process NUMA hinting faults in inaccessible VMAs.
-	 */
-	return !vma_is_accessible(vma);
-}
-
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
diff --git a/mm/gup.c b/mm/gup.c
index eb898ea1ee22..500e2aa99e48 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -633,6 +633,44 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 	return NULL;
 }
 
+/*
+ * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
+ * a (NUMA hinting or userfaultfd RWP) fault is required.
+ */
+static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
+					   unsigned int flags)
+{
+	/*
+	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
+	 * NUMA hinting. GUP must always take a fault so the access is
+	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
+	 *
+	 * Only do so while the VMA is accessible. If it has been made
+	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
+	 * below: forcing a fault there would loop, as handle_mm_fault() makes
+	 * no progress on protnone in an inaccessible VMA, and the access is
+	 * denied regardless of RWP anyway.
+	 */
+	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
+		return false;
+
+	/*
+	 * If callers don't want to honor NUMA hinting faults, no need to
+	 * determine if we would actually have to trigger a NUMA hinting fault.
+	 */
+	if (!(flags & FOLL_HONOR_NUMA_FAULT))
+		return true;
+
+	/*
+	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
+	 *
+	 * Requiring a fault here even for inaccessible VMAs would mean that
+	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
+	 * refuses to process NUMA hinting faults in inaccessible VMAs.
+	 */
+	return !vma_is_accessible(vma);
+}
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 /* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
 static inline bool can_follow_write_pud(pud_t pud, struct page *page,

-- 
2.53.0

