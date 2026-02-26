Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CB3876BA;
	Thu, 26 Feb 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130419; cv=none; b=cnXy2JuWwgSkPwKZDb7gHt3ZofrHfxEGoy55kihEtFRWL/HliNLEtDe0D2X3Vs7rh04x1PJ9/n+BJHfDyEb0ZYMFNZgrSQSVYJaiz/f67yK2QoerFKBwdEiLyYqalirfrMbcOcex/eUd6bJ8DL3nTPz901Xe5Mj8oAitzYXQWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130419; c=relaxed/simple;
	bh=423FuvyZDcQO91qV7GzD47gLhEmq6wEa5zZ+oKqIc5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRQb10vKF7yyaXQu4taOtDqLbVzVOmZCPrZw3QsEAB9cyfqWadpbZhnvQxGjG3IyC6hbn/M1L9NkQJPM29XCAqTZ4jnxJBqkqW4c/+uXOKzVqhnDZG1ynlRgm6rfdujGDL7R/6cgZwmOTiVuNTZB1Ml1HEQ0l6FiasJ4jbFjDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=vBLYGgPj; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="vBLYGgPj"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id B544EB2CE6;
	Thu, 26 Feb 2026 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772130416;
	bh=VnarcZL6OFxxZW+5dIiPmeVy2i+4K3SDVOOUTXPmso0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vBLYGgPjjaEaDcu21JHBT8fT25PuBvt7zgHb5AY+vWJpqFAonFxYDXRxA6goWwsmO
	 7CB4emaBe/hJsbx3wCSzCOeOotv3DKRunsC9uMVKTBHFcvk3Bch9O4bqmGoD1D0Cmf
	 W4pdTWUJksc/DgtdmIuMXuhYH5rZEsNI7SVoykSM=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v3 4/5] mm: rename zone->lock to zone->_lock
Date: Thu, 26 Feb 2026 18:26:21 +0000
Message-ID: <1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772129168.git.d@ilvokhin.com>
References: <cover.1772129168.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This intentionally breaks direct users of zone->lock at compile time so
all call sites are converted to the zone lock wrappers. Without the
rename, present and future out-of-tree code could continue using
spin_lock(&zone->lock) and bypass the wrappers and tracing
infrastructure.

No functional change intended.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/mmzone.h    |  7 +++++--
 include/linux/zone_lock.h | 12 ++++++------
 mm/compaction.c           |  4 ++--
 mm/internal.h             |  2 +-
 mm/page_alloc.c           | 16 ++++++++--------
 mm/page_isolation.c       |  4 ++--
 mm/page_owner.c           |  2 +-
 7 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e51190a55e4..32bca655fce5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1009,8 +1009,11 @@ struct zone {
 	/* zone flags, see below */
 	unsigned long		flags;
 
-	/* Primarily protects free_area */
-	spinlock_t		lock;
+	/*
+	 * Primarily protects free_area. Should be accessed via zone_lock_*
+	 * helpers.
+	 */
+	spinlock_t		_lock;
 
 	/* Pages to be freed when next trylock succeeds */
 	struct llist_head	trylock_free_pages;
diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
index c531e26280e6..5ce1aa38d500 100644
--- a/include/linux/zone_lock.h
+++ b/include/linux/zone_lock.h
@@ -7,32 +7,32 @@
 
 static inline void zone_lock_init(struct zone *zone)
 {
-	spin_lock_init(&zone->lock);
+	spin_lock_init(&zone->_lock);
 }
 
 #define zone_lock_irqsave(zone, flags)				\
 do {								\
-	spin_lock_irqsave(&(zone)->lock, flags);		\
+	spin_lock_irqsave(&(zone)->_lock, flags);		\
 } while (0)
 
 #define zone_trylock_irqsave(zone, flags)			\
 ({								\
-	spin_trylock_irqsave(&(zone)->lock, flags);		\
+	spin_trylock_irqsave(&(zone)->_lock, flags);		\
 })
 
 static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
 {
-	spin_unlock_irqrestore(&zone->lock, flags);
+	spin_unlock_irqrestore(&zone->_lock, flags);
 }
 
 static inline void zone_lock_irq(struct zone *zone)
 {
-	spin_lock_irq(&zone->lock);
+	spin_lock_irq(&zone->_lock);
 }
 
 static inline void zone_unlock_irq(struct zone *zone)
 {
-	spin_unlock_irq(&zone->lock);
+	spin_unlock_irq(&zone->_lock);
 }
 
 #endif /* _LINUX_ZONE_LOCK_H */
diff --git a/mm/compaction.c b/mm/compaction.c
index 9f7997e827bd..aed5bf468fd3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -506,7 +506,7 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
 static bool compact_zone_lock_irqsave(struct zone *zone,
 				      unsigned long *flags,
 				      struct compact_control *cc)
-__acquires(&zone->lock)
+__acquires(&zone->_lock)
 {
 	/* Track if the lock is contended in async mode */
 	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
@@ -1402,7 +1402,7 @@ static bool suitable_migration_target(struct compact_control *cc,
 		int order = cc->order > 0 ? cc->order : pageblock_order;
 
 		/*
-		 * We are checking page_order without zone->lock taken. But
+		 * We are checking page_order without zone->_lock taken. But
 		 * the only small danger is that we skip a potentially suitable
 		 * pageblock, so it's not worth to check order for valid range.
 		 */
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..6cb06e21ce15 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -710,7 +710,7 @@ static inline unsigned int buddy_order(struct page *page)
  * (d) a page and its buddy are in the same zone.
  *
  * For recording whether a page is in the buddy system, we set PageBuddy.
- * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
+ * Setting, clearing, and testing PageBuddy is serialized by zone->_lock.
  *
  * For recording page's order, we use page_private(page).
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5d13fe9b79f..56ca27a07a62 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -815,7 +815,7 @@ compaction_capture(struct capture_control *capc, struct page *page,
 static inline void account_freepages(struct zone *zone, int nr_pages,
 				     int migratetype)
 {
-	lockdep_assert_held(&zone->lock);
+	lockdep_assert_held(&zone->_lock);
 
 	if (is_migrate_isolate(migratetype))
 		return;
@@ -2473,7 +2473,7 @@ enum rmqueue_mode {
 
 /*
  * Do the hard work of removing an element from the buddy allocator.
- * Call me with the zone->lock already held.
+ * Call me with the zone->_lock already held.
  */
 static __always_inline struct page *
 __rmqueue(struct zone *zone, unsigned int order, int migratetype,
@@ -2501,7 +2501,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	 * fallbacks modes with increasing levels of fragmentation risk.
 	 *
 	 * The fallback logic is expensive and rmqueue_bulk() calls in
-	 * a loop with the zone->lock held, meaning the freelists are
+	 * a loop with the zone->_lock held, meaning the freelists are
 	 * not subject to any outside changes. Remember in *mode where
 	 * we found pay dirt, to save us the search on the next call.
 	 */
@@ -3203,7 +3203,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 	struct zone *zone = page_zone(page);
 
 	/* zone lock should be held when this function is called */
-	lockdep_assert_held(&zone->lock);
+	lockdep_assert_held(&zone->_lock);
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
@@ -7086,7 +7086,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * pages.  Because of this, we reserve the bigger range and
 	 * once this is done free the pages we are not interested in.
 	 *
-	 * We don't have to hold zone->lock here because the pages are
+	 * We don't have to hold zone->_lock here because the pages are
 	 * isolated thus they won't get removed from buddy.
 	 */
 	outer_start = find_large_buddy(start);
@@ -7655,7 +7655,7 @@ void accept_page(struct page *page)
 		return;
 	}
 
-	/* Unlocks zone->lock */
+	/* Unlocks zone->_lock */
 	__accept_page(zone, &flags, page);
 }
 
@@ -7672,7 +7672,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 		return false;
 	}
 
-	/* Unlocks zone->lock */
+	/* Unlocks zone->_lock */
 	__accept_page(zone, &flags, page);
 
 	return true;
@@ -7813,7 +7813,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 
 	/*
 	 * Best effort allocation from percpu free list.
-	 * If it's empty attempt to spin_trylock zone->lock.
+	 * If it's empty attempt to spin_trylock zone->_lock.
 	 */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 56a272f38b66..78b58dae2015 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -212,7 +212,7 @@ static int set_migratetype_isolate(struct page *page, enum pb_isolate_mode mode,
 	zone_unlock_irqrestore(zone, flags);
 	if (mode == PB_ISOLATE_MODE_MEM_OFFLINE) {
 		/*
-		 * printk() with zone->lock held will likely trigger a
+		 * printk() with zone->_lock held will likely trigger a
 		 * lockdep splat, so defer it here.
 		 */
 		dump_page(unmovable, "unmovable page");
@@ -553,7 +553,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Test all pages in the range is free(means isolated) or not.
  * all pages in [start_pfn...end_pfn) must be in the same zone.
- * zone->lock must be held before call this.
+ * zone->_lock must be held before call this.
  *
  * Returns the last tested pfn.
  */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8178e0be557f..54a4ba63b14f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -799,7 +799,7 @@ static void init_pages_in_zone(struct zone *zone)
 				continue;
 
 			/*
-			 * To avoid having to grab zone->lock, be a little
+			 * To avoid having to grab zone->_lock, be a little
 			 * careful when reading buddy page order. The only
 			 * danger is that we skip too much and potentially miss
 			 * some early allocated pages, which is better than
-- 
2.47.3

