Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386529;
	b=okPe3tUnDEmQhhEBVqCWUknlt8qOmskbCBQwfEffRJOl9DAxJ68YlpuRiDQ0B5oTWzmk
	 J0/9TDzz+V1fOx4Kf/W6YEcBl02J9opfHG7hAyUOSUK4YCDPNFXsxJwUVB8ht+Wwcd5xC
	 pmlJ7g7OLVyPYwEFnrsIP899CgMSV2F6pqevOg0bzhfpRCYYfhZuQ4OmuvwuRZ+DGp9IA
	 McFIB+/9lczeQBWj4gAdLRc8ELomifpbCxtlJCDqGwsu8rHrMXHqRzDcV2BecysN3eMpS
	 x5GCyWuOjNwOmdqFAlPDecmyTg4JptEEIK3w99YQXSCFIyQlGHYzQBpEIWzZaKYQLOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386529;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6ne6roaEV/RhWN6heK6JAW4EAyY6eRh4+UTmgKxS2xQ=;
	b=tm84ZIZHeCV5SGS9Pq+aI535DdhcCdxLrUOIge2H0tfNDJ46yqEj0A1ArV+s+C7v1lOh
	 8BTDSjFpxda9Hzu7v2NoABkHR755/00IB9EkR+PqvYIfbol0FuweUpUDnRlTp16KQ9kWn
	 oVeaaJTrC9MM5tBSlKNVZAIf5GWQ81hL235BeonRU8Cd25LitXpvRVW2l4TEU9St2KSdB
	 cTYaZjB05sIqyXscc2e9P9JUtYjFZjiP92P1Xd2XhtvJLb+wg/8m/Hiv2TQyH92ZKPsCi
	 hIMARe7kOD4pVO8xNn9MBljEAkDqyn7UtnsCmb0wJ5lh7Bws9xeOmGD9gu6vGQ6l4nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jLw1kKQn;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451E606A338;
	Wed, 11 Nov 2026 08:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2451E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jLw1kKQn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jLw1kKQnWdtnbsc3Lag6qkbq3XK5BwnAzRiy1q0o6KojkCVMtM+iXGfqBvIx2wWv0u1mBmhCG5kYg
	 X2tqaTRUpnsWQbZIVVxhqapEErI/TdVQALTRx6bayDL8M1KYYJl3S6Kj9Q7Mrzd95QHXL1s+kkmHA3
	 6TCc/IIS/Ci0mRlM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af42a5f02d-d7972;
	Wed, 11 Nov 2026 16:42:07 +0800 (CST)
X-RM-TRANSID:2ee76af42a5f02d-d7972
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af42a5c326-d5536;
	Wed, 11 Nov 2026 16:42:07 +0800 (CST)
X-RM-TRANSID:2eea6af42a5c326-d5536
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: vbabka@kernel.org,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+212c2d1f47994035cf7f@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] mm/compaction: Mark concurrent compact_considered accesses
Date: Wed, 11 Nov 2026 16:42:05 +0800
Message-ID: <20261111084205.80997-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct compaction and kcompactd update compact_considered without a
common lock. KCSAN reports the plain increment racing with a reset.
This counter is an approximate backoff heuristic and already permits
concurrent increments to be lost.

Use a local snapshot for the saturating increment and mark all shared
loads and stores, including the tracepoint snapshot. Preserve the
existing saturation limit and deferral decisions.

Fixes: 4f92e2586b43 ("mm: compaction: defer compaction using an exponential backoff when compaction fails")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 include/trace/events/compaction.h |  2 +-
 mm/compaction.c                   | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index d05759d18538..42303a4835f5 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -255,7 +255,7 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 		__entry->nid = zone_to_nid(zone);
 		__entry->idx = zone_idx(zone);
 		__entry->order = order;
-		__entry->considered = zone->compact_considered;
+		__entry->considered = READ_ONCE(zone->compact_considered);
 		__entry->defer_shift = zone->compact_defer_shift;
 		__entry->order_failed = zone->compact_order_failed;
 	),
diff --git a/mm/compaction.c b/mm/compaction.c
index f1b2060eb201..04b93d3545af 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -126,7 +126,7 @@ static unsigned long release_free_list(struct list_head *freepages)
  */
 static void defer_compaction(struct zone *zone, int order)
 {
-	zone->compact_considered = 0;
+	WRITE_ONCE(zone->compact_considered, 0);
 	zone->compact_defer_shift++;
 
 	if (order < zone->compact_order_failed)
@@ -142,15 +142,16 @@ static void defer_compaction(struct zone *zone, int order)
 static bool compaction_deferred(struct zone *zone, int order)
 {
 	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
+	unsigned long considered;
 
 	if (order < zone->compact_order_failed)
 		return false;
 
-	/* Avoid possible overflow */
-	if (++zone->compact_considered >= defer_limit) {
-		zone->compact_considered = defer_limit;
+	/* This is a heuristic; concurrent updates may be lost. */
+	considered = READ_ONCE(zone->compact_considered) + 1;
+	WRITE_ONCE(zone->compact_considered, min(considered, defer_limit));
+	if (considered >= defer_limit)
 		return false;
-	}
 
 	trace_mm_compaction_deferred(zone, order);
 
@@ -166,7 +167,7 @@ void compaction_defer_reset(struct zone *zone, int order,
 		bool alloc_success)
 {
 	if (alloc_success) {
-		zone->compact_considered = 0;
+		WRITE_ONCE(zone->compact_considered, 0);
 		zone->compact_defer_shift = 0;
 	}
 	if (order >= zone->compact_order_failed)
@@ -182,7 +183,7 @@ static bool compaction_restarting(struct zone *zone, int order)
 		return false;
 
 	return zone->compact_defer_shift == COMPACT_MAX_DEFER_SHIFT &&
-		zone->compact_considered >= 1UL << zone->compact_defer_shift;
+		READ_ONCE(zone->compact_considered) >= 1UL << zone->compact_defer_shift;
 }
 
 /* Returns true if the pageblock should be scanned for pages to isolate. */
-- 
2.51.0



