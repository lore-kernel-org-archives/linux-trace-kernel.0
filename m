Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15A3D891D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429195; cv=none; b=meKGe4WKHlSNntDBlihoiaSnF8mJh0D44SbfKwjWeK7LDQ4bleKL3Q/qghWaenstEOmyNrP1Hc6wa2K+Fos9ZLXinKu/4FMSnNaytm0AzO/urUjn97/TlOyornydO6WqlaihLvpuU1Cmum1Sybe/KEEwtHh8tlhJi8+8KCibL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429195; c=relaxed/simple;
	bh=yole13EigkRSd7xBnzu90SvW8e/P0ie4BQTT6so7T30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYZCrG0rnxPNLA0vOPhTsqg79eo1OihUmaXCCliRWb22kRVMPFqwrL4jq/1QMCYWsxl3XrdKkyCPex9+mB1fRP7GzMBnIimFTAhWZZkjKQmIk8BIB8bo2Va2gn95rOaQTeDWqdP9EpKwsDXRMq30kZmlzZGNZCPO9MrWJdjkSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLFeF4Wo; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLFeF4Wo"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca696c4b152so31713a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429194; x=1784033994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSA218qTv4mgdJzlBuvqRuFwwy+LpVW2vHjrCuIOTHM=;
        b=LLFeF4WoVhr1Qr4l8//yLNNC8cKXeoxkjBeiM6bTGASy0g5RHfuvF3ihwFV8chigt7
         NInO3yzgyKgab25uEjAHOaijgwKEuxy6m9QFy2ijFipPMcnZQsKmkcdbHgw/SpLqTm5C
         oM9i/Utwpypb+KNjdO2RAkvi67CLF838BN3srwZekCnP4KfZVtvmXDh3ECxrLr/QNHMn
         O7xVhXGz0Zb5q4GHhg7nrhrxGDGrMJrTgNTsKPvA8Z6/DjVrBr8Hgt+YMoSeyfHjGMjj
         UYnvvJ/bVYc7SqZgMBHrr3o4gyJJ0CW5aEcp9ZRHkLuRupQ106suKTUV6g3Gjo4mIKXx
         V+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429194; x=1784033994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSA218qTv4mgdJzlBuvqRuFwwy+LpVW2vHjrCuIOTHM=;
        b=fR2+2GZrRJEZnpg/5FMmHGpOaQQAZ2JRaj2tP0iMdwFuNuTihGZ9jT1sAgCw+AA0SZ
         7m8tVJ/XCBUqlbp5x3IRaSt5fIh1jmXZjQhu2Pr/Y14xTHMY+VJQJeNqyk2o8WHOg1Qd
         e0ImP2PO4vq3GkrHie5PGlbmUOSksCmmwwbuE5FFlI0yeyKF0OclBFLcTMKq3dQe2lmg
         iMZ1SzZeRkS8qdy3fuwEcwxYHlpnjrGR3KUeKr6K0RjmMYXus10V5BFEUvGk+a7a/74J
         qkfp8yN5AMPrNPrxdf1EUQQJwmQE4huIH0mY6jpkjhpVgfR/NVyT66ofJwpqo8sW5IAG
         9h1A==
X-Forwarded-Encrypted: i=1; AHgh+RpNZPyPROtJ8zO6fN2bRce/B88eMoCKPTzivZHJx6fTKW8CbnxTVYxfspaFTfLqHoAn9IuZA/Tpsing00RpG//+31o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16q67CGyDNRRO74psQ6lO6tL6czsG/i/2blQPM7ycyGNMumIg
	7zjDBcoz3tkDFsIk2x5ZBKwP0idr4hVFA4vYRow3IpySWRKfhMr0Wky4b63QXsiQ
X-Gm-Gg: AfdE7cno+2LbNGvZfH74WmfeTIFQYc7hKCftI2bAvXbFIrKd06rbzeP0YGnqeMJ9M0B
	vkSJ8LhkOSw63ltapytJOq0iGsPjbVRLjyVux7jwnmFqLw8XvAIFLuLcdFgOZNry7FRqyeq77f3
	mPp1789M6W9XNKF0qURiMJHE6vLihVCeq8s/Njj/3MGyvUxlHdFWVIsvxvD0n2wgmAFGuENyu3b
	JZiTh38zPxCqG2YE5LNP5/Z0kbXo6CQ9D2sSn/djWr+myU8TyxRsPTUTFT8NYDTzO2p98UN1aag
	t7PyOyFU2vbGgkOG/wg2YfweX3wxQR28O3itYZABpG6RP+7zsft78n5R57UHfFau9dgUx4gtgej
	7JdyWqbjXFvXu7Mj3wqRrXqai0Qc7+NF5bsxS4B9Bp58/LUPcSgKE4HIu7bfXoWw4naN+xelfcH
	MrFluHaWOjD0F/TSY5/dlXAbUNGw==
X-Received: by 2002:a05:6a00:760a:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-8482f74dc6emr1994798b3a.75.1783429193368;
        Tue, 07 Jul 2026 05:59:53 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:59:52 -0700 (PDT)
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
Subject: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into VM_LOCKED VMAs under compaction
Date: Tue,  7 Jul 2026 20:59:22 +0800
Message-ID: <20260707125925.3725177-2-chenwandun1@gmail.com>
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

When compact_unevictable_allowed=0, unevictable pages should not be
migrated. However, mlock_folio_batch in the mlock[all] syscall introduces
a race, mlock_folio() sets PG_mlocked immediately but defers PG_unevictable
to mlock_folio_batch(), causing pages that are about to become unevictable
to be migrated, which violates the intent of compact_unevictable_allowed,
and causes spike latency in RT kernels [1].

In order to fix this, migration is forbidden for pages mapped into VMAs
marked with VM_LOCKED. In addition, two early-return paths are introduced,
filter out mlocked pages, return early to avoid unnecessary operations.

Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/ [1]
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/linux-rt-users/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/#t
---
 include/linux/compaction.h |  6 ++++++
 include/linux/rmap.h       |  3 +++
 mm/compaction.c            |  8 +++++++-
 mm/migrate.c               | 23 +++++++++++++++++++----
 mm/rmap.c                  | 12 +++++++++---
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index f29ef0653546..04e60f65b976 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 extern void __meminit kcompactd_run(int nid);
 extern void __meminit kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
+extern bool compaction_allow_unevictable(void);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
 {
 }
 
+static inline bool compaction_allow_unevictable(void)
+{
+	return true;
+}
+
 #endif /* CONFIG_COMPACTION */
 
 struct node;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8dc0871e5f00..359c7426b6b9 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -102,6 +102,9 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_RESPECT_MLOCK	= 0x100,/* leave VM_LOCKED vmas mapped instead
+					 * of installing a migration entry
+					 */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/compaction.c b/mm/compaction.c
index f08765ade014..5d256930e389 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		is_unevictable = folio_test_unevictable(folio);
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
+		if (!(mode & ISOLATE_UNEVICTABLE) &&
+		    (is_unevictable || folio_test_mlocked(folio)))
 			goto isolate_fail_put;
 
 		/*
@@ -1898,6 +1899,11 @@ typedef enum {
  * compactable pages.
  */
 static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+
+bool compaction_allow_unevictable(void)
+{
+	return sysctl_compact_unevictable_allowed;
+}
 /*
  * Tunable for proactive compaction. It determines how
  * aggressively the kernel should compact memory in the
diff --git a/mm/migrate.c b/mm/migrate.c
index a786549551e3..3a15eb13e82b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1202,7 +1202,7 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		struct list_head *ret)
+		struct list_head *ret, enum migrate_reason reason)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1210,6 +1210,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	struct anon_vma *anon_vma = NULL;
 	bool locked = false;
 	bool dst_locked = false;
+	enum ttu_flags ttu = 0;
 
 	dst = get_new_folio(src, private);
 	if (!dst)
@@ -1249,9 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
-	if (folio_test_mlocked(src))
+	if (folio_test_mlocked(src)) {
 		old_folio_state |= FOLIO_WAS_MLOCKED;
 
+		if (reason == MR_COMPACTION && !compaction_allow_unevictable()) {
+			rc = -EBUSY;
+			goto out;
+		}
+	}
+
 	if (folio_test_writeback(src)) {
 		/*
 		 * Only in the case of a full synchronous migration is it
@@ -1324,7 +1331,14 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+
+		if (mode == MIGRATE_ASYNC)
+			ttu |= TTU_BATCH_FLUSH;
+
+		if (reason == MR_COMPACTION && !compaction_allow_unevictable())
+			ttu |= TTU_RESPECT_MLOCK;
+
+		try_to_migrate(src, ttu);
 		old_folio_state |= FOLIO_WAS_MAPPED;
 	}
 
@@ -1905,7 +1919,8 @@ static int migrate_pages_batch(struct list_head *from,
 			}
 
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-					private, folio, &dst, mode, ret_folios);
+					private, folio, &dst, mode, ret_folios,
+					reason);
 			/*
 			 * The rules are:
 			 *	0: folio will be put on unmap_folios list,
diff --git a/mm/rmap.c b/mm/rmap.c
index 0fb7a1b82cf3..3cb7f6337d38 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2420,6 +2420,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long pfn;
 	unsigned long hsz = 0;
 
+	if ((flags & TTU_RESPECT_MLOCK) && (vma->vm_flags & VM_LOCKED))
+		return false;
+
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
@@ -2741,11 +2744,14 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	};
 
 	/*
-	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
-	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
+	 * Migration normally ignores mlock, but TTU_RESPECT_MLOCK asks it to
+	 * leave folios mapped into VM_LOCKED vmas alone.  Only TTU_RMAP_LOCKED,
+	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, TTU_BATCH_FLUSH and TTU_RESPECT_MLOCK
+	 * are supported.
 	 */
 	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-					TTU_SYNC | TTU_BATCH_FLUSH)))
+					TTU_SYNC | TTU_BATCH_FLUSH |
+					TTU_RESPECT_MLOCK)))
 		return;
 
 	if (folio_is_zone_device(folio) &&
-- 
2.43.0

