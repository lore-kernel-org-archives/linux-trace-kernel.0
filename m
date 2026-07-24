Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B633470114;
	Fri, 24 Jul 2026 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932221; cv=none; b=QzpAgXHzbWKVQ7zxjcvSkF4pP7/sf4c9JlrvUI0Bs+EUHZRId45uZQDS2GXrgPS2rz7C44UhE0Jnb/1wqipJCZX426HpocgJlMxWKzKl/mUdZmIDsEoO678NjaMIrF5Xr6mMOdRyTpXSxAdiG443nlvauIm8djHpaJGDevB/ObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932221; c=relaxed/simple;
	bh=SxU/YkSx9/aDHrnwD+QcDLHCxGTwlDX2cC7MmSC4v78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4tmE2p5p79Znshx0jfshOarkMB8nQIaktKk8GQCDY4AO/wAF7+Wis40aM7nb2Igdl71b/TC8PZQzEIOmHr5nYtl52kuNGjJFPgUisP2AjTd/h1PXisfDHmR/p0Bb8IELw10vLLuiZGfSVxnCm4m5zk3jCewS09fhaerMHBcIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=RVCkNQ0h; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="RVCkNQ0h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qDlbQ/k/gKhextbIPqwqCwZ5BabZN9oEFBEjCjmG3eE=; b=RVCkNQ0hfcZsXJGNqnk2s4AJat
	5GNYVKosxlBdUigBnazluK5OVF0UCUomWI4E0gm1sKSyQ2DpZ+Ve3tIRlSFSnuh2kflmXApNDjUUy
	gxxxgxZDK+Zu5kiplzcnWTHxBVCkgfs3azyY4shlHCrtJXqFOOpJwEQwoT59m8dBOlzuDGVHaelLx
	9vu7z4jFwPmPhdj9bAGq53MEVutyT93H6mHz4OREXM9GZBMKTOl1XR7MZjlGNdhiKzL/CVQTn0RWx
	GCawa8mEsly9K9s3yOHmXaRVfdOenUeerOK0giEoty7aWhdLSK/ThtyzZ3pM42YvYQPfRKES+Rp9i
	Oa/5MXxQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wnOOs-0000000027h-1CWq;
	Fri, 24 Jul 2026 18:29:50 -0400
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH RFC v4 03/12] mm: rename get_user_page_vma_remote() to get_user_page_lookup_vma()
Date: Fri, 24 Jul 2026 18:29:25 -0400
Message-ID: <20260724222934.1463812-4-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724222934.1463812-1-riel@surriel.com>
References: <20260724222934.1463812-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_user_page_vma_remote() faults in the page at @addr in a remote mm and
also looks up the VMA that covers it, handing both back to the caller.

This cleans up the namespace for adding a get_user_page_vma() variant where
the caller already has the vma.

No functional change intended.

Assisted-by: Claude:claude-opus-4.8
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/arm64/kernel/mte.c   | 2 +-
 arch/x86/kernel/uprobes.c | 2 +-
 include/linux/mm.h        | 2 +-
 mm/memory.c               | 4 ++--
 mm/rmap.c                 | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 1a9aad6ef22a..7a6ecc3d9294 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -459,7 +459,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		struct vm_area_struct *vma;
 		unsigned long tags, offset;
 		void *maddr;
-		struct page *page = get_user_page_vma_remote(mm, addr,
+		struct page *page = get_user_page_lookup_vma(mm, addr,
 							     gup_flags, &vma);
 		struct folio *folio;
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3af979fb41d3..329efac0cfb3 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1036,7 +1036,7 @@ static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst,
 	struct vm_area_struct *vma;
 	struct page *page;
 
-	page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
+	page = get_user_page_lookup_vma(mm, vaddr, gup_flags, &vma);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 	uprobe_copy_from_page(page, vaddr, dst, len);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..24ead14b4790 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3238,7 +3238,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 /*
  * Retrieves a single page alongside its VMA. Does not support FOLL_NOWAIT.
  */
-static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
+static inline struct page *get_user_page_lookup_vma(struct mm_struct *mm,
 						    unsigned long addr,
 						    int gup_flags,
 						    struct vm_area_struct **vmap)
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..3b86eeaf084f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7039,7 +7039,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *maddr;
 		struct folio *folio;
 		struct vm_area_struct *vma = NULL;
-		struct page *page = get_user_page_vma_remote(mm, addr,
+		struct page *page = get_user_page_lookup_vma(mm, addr,
 							     gup_flags, &vma);
 
 		if (IS_ERR(page)) {
@@ -7167,7 +7167,7 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 		struct page *page;
 		struct vm_area_struct *vma = NULL;
 
-		page = get_user_page_vma_remote(mm, addr, gup_flags, &vma);
+		page = get_user_page_lookup_vma(mm, addr, gup_flags, &vma);
 		if (IS_ERR(page)) {
 			/*
 			 * Treat as a total failure for now until we decide how
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9..b36f2e219b8f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2838,7 +2838,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	 * (non-device-exclusive) PTE and issue a MMU_NOTIFY_EXCLUSIVE.
 	 */
 retry:
-	page = get_user_page_vma_remote(mm, addr,
+	page = get_user_page_lookup_vma(mm, addr,
 					FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
 					&vma);
 	if (IS_ERR(page))
-- 
2.53.0-Meta

