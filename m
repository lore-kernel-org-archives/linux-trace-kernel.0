Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039236AB7B;
	Thu, 26 Feb 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130418; cv=none; b=ctILYSmJWYqqS7XEcDw+yxpksAHrilXKKlLJLXC23rlg2WRttUGn9KapaRnEjhd/i0/uC7p25L4vBDEUfg0cVDcrnSRQmpLwA0W3b1BVMxMuZaHg1AxoIGm8fMCrLFTVb94syjHXjqeV4kL79E07z3oRNHxrFU3DmCnbBNefazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130418; c=relaxed/simple;
	bh=rSn4PUzFbaSEZ8iIx7J/wSS/IrJY8/Rnndc3IZP2wvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftWHq+zZc3guzK+KVw/btv1G2Ut3OQlMV+KikE0521+G6LA3J9E2H4YMuBAr+G2GuUXYkV7DEL58dwgWMtzjLpTeaZQkTZ+3ptKKNcbN75QzeBHdGZnrFQr229EQdTcGlQt9rbf2kT88LzKW9LIneqipNLuyIHn2fLuJjnC8ifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ROUBdTKd; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ROUBdTKd"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 5976EB2CE3;
	Thu, 26 Feb 2026 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772130415;
	bh=HXRtBBG/qhw0slRma85SDcDIachKM+DkOh/vjMaFIu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROUBdTKdAI2asAnZVnKs+ciEM4SjsPZwqQLfD3v+GHvBhTDiiyYhMHaeCQQlPHtGm
	 r0tsUeUHrtF5h6G3bZpEsfJzcCPyjb6Kg4sfxcrRsh3ZZEaWw/uzEW6WdzhQ+QChFR
	 LthCPlRh1pASvysPqMKh34FyuhkEaC+fnjdWT5c8=
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
Subject: [PATCH v3 3/5] mm: convert compaction to zone lock wrappers
Date: Thu, 26 Feb 2026 18:26:20 +0000
Message-ID: <01729baf359e4c6612aead53f1fcb644f782d1de.1772129168.git.d@ilvokhin.com>
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

Compaction uses compact_lock_irqsave(), which currently operates
on a raw spinlock_t pointer so it can be used for both zone->lock
and lruvec->lru_lock. Since zone lock operations are now wrapped,
compact_lock_irqsave() can no longer directly operate on a
spinlock_t when the lock belongs to a zone.

Split the helper into compact_zone_lock_irqsave() and
compact_lruvec_lock_irqsave(), duplicating the small amount of
shared logic. As there are only two call sites and both statically
know the lock type, this avoids introducing additional abstraction
or runtime dispatch in the compaction path.

No functional change intended.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 mm/compaction.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 47b26187a5df..9f7997e827bd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -503,19 +503,36 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
  *
  * Always returns true which makes it easier to track lock state in callers.
  */
-static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
-						struct compact_control *cc)
-	__acquires(lock)
+static bool compact_zone_lock_irqsave(struct zone *zone,
+				      unsigned long *flags,
+				      struct compact_control *cc)
+__acquires(&zone->lock)
 {
 	/* Track if the lock is contended in async mode */
 	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
-		if (spin_trylock_irqsave(lock, *flags))
+		if (zone_trylock_irqsave(zone, *flags))
 			return true;
 
 		cc->contended = true;
 	}
 
-	spin_lock_irqsave(lock, *flags);
+	zone_lock_irqsave(zone, *flags);
+	return true;
+}
+
+static bool compact_lruvec_lock_irqsave(struct lruvec *lruvec,
+					unsigned long *flags,
+					struct compact_control *cc)
+__acquires(&lruvec->lru_lock)
+{
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			return true;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 	return true;
 }
 
@@ -531,7 +548,6 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
  * Returns true if compaction should abort due to fatal signal pending.
  * Returns false when compaction can continue.
  */
-
 static bool compact_unlock_should_abort(struct zone *zone,
 					unsigned long flags,
 					bool *locked,
@@ -616,8 +632,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 		/* If we already hold the lock, we can skip some rechecking. */
 		if (!locked) {
-			locked = compact_lock_irqsave(&cc->zone->lock,
-								&flags, cc);
+			locked = compact_zone_lock_irqsave(cc->zone, &flags, cc);
 
 			/* Recheck this is a buddy page under lock */
 			if (!PageBuddy(page))
@@ -1163,7 +1178,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			compact_lruvec_lock_irqsave(lruvec, &flags, cc);
 			locked = lruvec;
 
 			lruvec_memcg_debug(lruvec, folio);
-- 
2.47.3

