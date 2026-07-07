Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4082EEE75
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429233; cv=none; b=VrqH5G/KJHO4w2tliUnEnigR3Ge2GKr6pG1TcxXQQ6SSHdS064ojizyixLN2bDECQ+lqLR0Aqk0RbvW9QEhOGnEuK4DXk/SXWt0hm6idxIk3u31ZxJlP/t7sdgBiA1gu3GcNf49MmLmWoIHwKT53/uhR84kaTj9a0JXQh3sr67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429233; c=relaxed/simple;
	bh=RvXzUh+Z5rLxburgzcvo+g9ZGozfoPunlEYEQZcFbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1qIgQR2f9xY69x2BYZm8kpx7qbIv6EyfUAZuZo3f68JMcjkU1maRI60DQpgLmafSByswk+YjBLM/SzCae67hqPdbZbFmeIiAvTsWONgvSrOzWO2rfM1J6A3PEhVApblda6gi5o1AHZ8RrDp+9VU36c1xrKMj3gyiU/qCdgXE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/MXcVGo; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/MXcVGo"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c9a20e73d7cso1331036a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429232; x=1784034032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W5DUkb1JUBfDdw5NFLWUB/50kxa7q0vorvfnztH0I4=;
        b=R/MXcVGovvHJ1FQtgUZyl77G4rx3dRgmO9eqWDl/DtoFC8heKGDf98n7fhQHF2osIi
         HcqsTdfIlZg3AmgMW8ou8/IgzOXNvkt8ewSyK1k35MeTxNagjDiSpaqwcUCOVgtedY0E
         CxF9fFw3FS00ffbnoHKe1c60FIykgWhoHw/ULe7pHGNpOABTO6585dBeyhsMymYJfM8S
         LL37JlaWYmV7+rjY54AoTuvKqojoP6BEtBptUQBiUp42jIclQPFoOgy2o8AMPBtTYjCB
         j2RB2XlrxUbqed93AICy33rqn0/bpJ0oVRiSMNKN1lpjaPQRe7KoJuiVOMv8b+ne/vF5
         k0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429232; x=1784034032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5W5DUkb1JUBfDdw5NFLWUB/50kxa7q0vorvfnztH0I4=;
        b=ibpJv805VEOqr55L3+nw5Tt2khGGmaCueymm6kQQvpDQhl+GiI4GImhiL2fEFotfCD
         VDd8F1SX5Pm7t2I73JJaGfICuxqhdR8mrN01hZt/fXBc/FaP7n3gprcUHx0SlRzp1o8v
         KrCWwPcn0DUg3X99NHPQmNBPV6uk9SeV8qJrm5d9N7IXupuwOMUd+3vcilYbt2DOasob
         9frYbkSx4l8oGZZc8bYHYzxufGgUhCXMp7Nc3r/sXg1gw73H/b0+xvEdLuhkbqKc2Ds4
         /b53QE9ZLPA0gXUgwL3KEcVjcsCr8cSp2MFSoNqUFpB39tTbvRRg6wvKsFV7LXxMCdUU
         r9aA==
X-Forwarded-Encrypted: i=1; AHgh+RodjnK+bDyqSaQxKTyme8RoGhCYWzRGxPZKwgONIVb3Ss9N6G0Vw+vAwhhneYKFJHE7qfQSN13qsH4l99Nqo32dlQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgJYiT+DZiwu0+8VTkIvC8eoVu02zeI0NamcmwZdopJI6PtVi
	Vtq+5oAFUDH9UOBQhjkXxvK26fk1BgvXw6eydjqZDrJG50BlcQh27D1f
X-Gm-Gg: AfdE7ckuHaDpO+oaIhCPqth1bjExNK84bunMNHMsrCnychQHMKYWwz8oL4nsyawf+HN
	2c7fv4k9lcqDNznnkoAHuAmf+WRyDdnfIHjvE8wJFD7wK208QWid2S2rSNxxFAfcKDwAXoeptlK
	469OZ2sSmTKRhSM3Ufplefpx1vAOwYULEaroKNKHcvqOciv2k0YAfodR4ZqSxGp9QOum7PrKRx8
	XjpQrA9dNlShw/CjhAzCA6UsOYTZBKYMyjS9bVZXX0dVrtf7ca1EoXMqmQJtcLGbM1nm/SLRkj3
	UsBQphbXRSGI95LDZWvp+a/B/Fy6mipZ6ftjzNHsa06Hmw52A4MU5RrfoIParUNrIrhP4wT2wtU
	0itxgYJXqM833GWtMg3z0jHvtTG0QC4Gt96Qtt9el9788PjZ0ZzaaElkRxa0jEP/RP0rTij/fPc
	IM/HN9179YutTN6KHD/Ue4xUyMiA==
X-Received: by 2002:a05:6a00:1819:b0:847:8b1d:22fe with SMTP id d2e1a72fcca58-84826df12a7mr4541501b3a.50.1783429231350;
        Tue, 07 Jul 2026 06:00:31 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:00:30 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking a range
Date: Tue,  7 Jul 2026 20:59:25 +0800
Message-ID: <20260707125925.3725177-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707125925.3725177-1-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

The region covered by mlock[all] may contain CMA pages. cma_alloc installs
migration entries in the page table, if a memory access occurs at this
point, it must wait for the migration to complete, which may cause
latency spikes on the RT kernels.

Try to move the migration cost into the mlock[all] caller, which is
typically a setup path. So reduce the chance of latency spikes on RT
kernels by migrating the currently mapped CMA pages out of CMA region.

Suggested-by: Frank van der Linden <fvdl@google.com>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/#t
---
 mm/mlock.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index ac65de40b22b..f56c685533f5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/migrate.h>
 #include <linux/compaction.h>
 
 #include "internal.h"
@@ -428,6 +429,119 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_CMA
+static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct list_head *folio_list = walk->private;
+	spinlock_t *ptl;
+	pte_t *start_pte, *pte;
+	pte_t ptent;
+	struct folio *folio;
+	unsigned int step = 1;
+
+	if (!(vma->vm_flags & VM_LOCKED))
+		return 0;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (!pmd_present(*pmd)) {
+			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
+				spin_unlock(ptl);
+				pmd_migration_entry_wait(vma->vm_mm, pmd);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
+			goto out;
+		}
+		if (is_huge_zero_pmd(*pmd))
+			goto out;
+		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
+		if (is_migrate_cma_page(&folio->page))
+			isolate_folio_to_list(folio, folio_list);
+		goto out;
+	}
+
+	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (pte = start_pte; addr != end; pte += step, addr += step * PAGE_SIZE) {
+		step = 1;
+		ptent = ptep_get(pte);
+		if (!pte_present(ptent)) {
+			if (unlikely(softleaf_is_migration(softleaf_from_pte(ptent)))) {
+				pte_unmap_unlock(start_pte, ptl);
+				migration_entry_wait(vma->vm_mm, pmd, addr);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
+			continue;
+		}
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio || folio_is_zone_device(folio))
+			continue;
+		step = folio_mlock_step(folio, pte, addr, end);
+		if (is_migrate_cma_page(&folio->page))
+			continue;
+		isolate_folio_to_list(folio, folio_list);
+	}
+	pte_unmap(start_pte);
+out:
+	spin_unlock(ptl);
+	cond_resched();
+	return 0;
+}
+
+static const struct mm_walk_ops mlock_collect_migratable_ops = {
+	.pmd_entry	= mlock_collect_migratable_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
+};
+
+static void mlock_migrate_cma_range(unsigned long start, unsigned long len)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long end = start + len;
+	LIST_HEAD(folio_list);
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_HIGHUSER | __GFP_NOWARN,
+		.reason = MR_SYSCALL,
+	};
+
+	if (compaction_allow_unevictable())
+		return;
+
+	lru_cache_disable();
+
+	if (mmap_read_lock_killable(mm))
+		goto out;
+
+	walk_page_range(mm, start, end, &mlock_collect_migratable_ops,
+			&folio_list);
+	mmap_read_unlock(mm);
+
+	if (list_empty(&folio_list))
+		goto out;
+
+	if (migrate_pages(&folio_list, alloc_migration_target, NULL,
+			  (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL))
+		putback_movable_pages(&folio_list);
+out:
+	lru_cache_enable();
+}
+#else
+static inline void mlock_migrate_cma_range(unsigned long start,
+					   unsigned long len)
+{
+}
+#endif /* CONFIG_CMA */
+
 /*
  * mlock_vma_pages_range() - mlock any pages already in the range,
  *                           or munlock all pages in the range.
@@ -678,6 +792,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	error = __mm_populate(start, len, 0);
 	if (error)
 		return __mlock_posix_error_return(error);
+	mlock_migrate_cma_range(start, len);
 	return 0;
 }
 
@@ -790,8 +905,10 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	    capable(CAP_IPC_LOCK))
 		ret = apply_mlockall_flags(flags);
 	mmap_write_unlock(current->mm);
-	if (!ret && (flags & MCL_CURRENT))
+	if (!ret && (flags & MCL_CURRENT)) {
 		mm_populate(0, TASK_SIZE);
+		mlock_migrate_cma_range(0, TASK_SIZE);
+	}
 
 	return ret;
 }
-- 
2.43.0

