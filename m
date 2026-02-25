Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70493B52EB;
	Wed, 25 Feb 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030658; cv=none; b=IwX8EBqr8qZPejp/0X3/aGKe3Z+J0as+3ljsjjE1pODTMDZY+faZWXJri+iLNL9s3jvDUiHb719waGjYJ88tAud/LoDq7I4dJaOzg108hFlAa2mD0F8+tHF4Fp3usycb0NdGgkgOvg06g/N8vspHW1G/ngllAkZOnbCKtPcXGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030658; c=relaxed/simple;
	bh=XuSfjF2RRGkM16rzb8mAbF67sULehTwhSol/VbuJn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emwDrH0zUIuDphUIezIlOs9c4/5cCEbJ+37x2TsYgl6AvXDraiH2JZK/cQr456pqcPWr07RY9VvoPRjul7+XuBXtcAIM55M5bTQHVNO0FhYRhSomKxaztCfn22hjLR2iJ/FUarjRCA7Ea68UBk6IE4MVbzg1SxvTfaLzyFp8BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=kMtaTYHl; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="kMtaTYHl"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E0213B2C2F;
	Wed, 25 Feb 2026 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772030655;
	bh=vTtbvJ++bwhhe7M/mQwQ3ureU9ZQDF6UDHCC9y1Yr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kMtaTYHlxSqZitW5RYngNMzxYFgLX8N2ZTzu2pqsy0AaCh3VwKjW3FD21ZoWAhcBE
	 eZdbnxruMRgCzzoj47HlfY0hN3RyRrxw7fMObHfoN3GbBxXyjTF19QWm0iCcnBDmsD
	 x22IVfyoUiMBmZ2EyVhIqlv8byVNiExkhd5GzFjQ=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v2 3/4] mm: convert compaction to zone lock wrappers
Date: Wed, 25 Feb 2026 14:43:05 +0000
Message-ID: <9710c3448c6c984164c93d7c6c0283e06ff987bf.1772030186.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772030186.git.d@ilvokhin.com>
References: <cover.1772030186.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compaction uses compact_lock_irqsave(), which currently operates
on a raw spinlock_t pointer so that it can be used for both
zone->lock and lru_lock. Since zone lock operations are now wrapped,
compact_lock_irqsave() can no longer operate directly on a spinlock_t
when the lock belongs to a zone.

Introduce struct compact_lock to abstract the underlying lock type. The
structure carries a lock type enum and a union holding either a zone
pointer or a raw spinlock_t pointer, and dispatches to the appropriate
lock/unlock helper.

No functional change intended.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 mm/compaction.c | 73 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 47b26187a5df..c3b97379a963 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -494,6 +494,53 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
 }
 #endif /* CONFIG_COMPACTION */
 
+enum compact_lock_type {
+	COMPACT_LOCK_ZONE,
+	COMPACT_LOCK_RAW_SPINLOCK,
+};
+
+struct compact_lock {
+	enum compact_lock_type type;
+	union {
+		struct zone *zone;
+		spinlock_t *lock; /* Reference to lru lock */
+	};
+};
+
+static bool compact_do_trylock_irqsave(struct compact_lock lock,
+				       unsigned long *flags)
+{
+	if (lock.type == COMPACT_LOCK_ZONE)
+		return zone_trylock_irqsave(lock.zone, *flags);
+
+	return spin_trylock_irqsave(lock.lock, *flags);
+}
+
+static void compact_do_zone_lock_irqsave(struct zone *zone,
+					 unsigned long *flags)
+__acquires(zone->lock)
+{
+	zone_lock_irqsave(zone, *flags);
+}
+
+static void compact_do_raw_lock_irqsave(spinlock_t *lock,
+					unsigned long *flags)
+__acquires(lock)
+{
+	spin_lock_irqsave(lock, *flags);
+}
+
+static void compact_do_lock_irqsave(struct compact_lock lock,
+				    unsigned long *flags)
+{
+	if (lock.type == COMPACT_LOCK_ZONE) {
+		compact_do_zone_lock_irqsave(lock.zone, flags);
+		return;
+	}
+
+	compact_do_raw_lock_irqsave(lock.lock, flags);
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. For async compaction, trylock and record if the
@@ -503,19 +550,19 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
  *
  * Always returns true which makes it easier to track lock state in callers.
  */
-static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
-						struct compact_control *cc)
-	__acquires(lock)
+static bool compact_lock_irqsave(struct compact_lock lock,
+				 unsigned long *flags,
+				 struct compact_control *cc)
 {
 	/* Track if the lock is contended in async mode */
 	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
-		if (spin_trylock_irqsave(lock, *flags))
+		if (compact_do_trylock_irqsave(lock, flags))
 			return true;
 
 		cc->contended = true;
 	}
 
-	spin_lock_irqsave(lock, *flags);
+	compact_do_lock_irqsave(lock, flags);
 	return true;
 }
 
@@ -531,7 +578,6 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
  * Returns true if compaction should abort due to fatal signal pending.
  * Returns false when compaction can continue.
  */
-
 static bool compact_unlock_should_abort(struct zone *zone,
 					unsigned long flags,
 					bool *locked,
@@ -616,8 +662,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 		/* If we already hold the lock, we can skip some rechecking. */
 		if (!locked) {
-			locked = compact_lock_irqsave(&cc->zone->lock,
-								&flags, cc);
+			struct compact_lock zol = {
+				.type = COMPACT_LOCK_ZONE,
+				.zone = cc->zone,
+			};
+
+			locked = compact_lock_irqsave(zol, &flags, cc);
 
 			/* Recheck this is a buddy page under lock */
 			if (!PageBuddy(page))
@@ -1160,10 +1210,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
+			struct compact_lock zol = {
+				.type = COMPACT_LOCK_RAW_SPINLOCK,
+				.lock = &lruvec->lru_lock,
+			};
+
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			compact_lock_irqsave(zol, &flags, cc);
 			locked = lruvec;
 
 			lruvec_memcg_debug(lruvec, folio);
-- 
2.47.3

