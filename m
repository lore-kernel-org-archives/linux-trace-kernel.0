Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2752CCC2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868852; cv=none; b=MCTwDNcFfNPYdumKbYN98X67H8gtwQNKu3YrKTIsIyCmidqwXfWC9PTzq1Zq1h+EV0aRo8jmLfOfsCNJMYHkdiTwhfq2egNjGM9Iis24xCArsLMsV6LbeC7CJ/XMZXM77Z+tjBedweYUn7mRaYqqoRBH1zSut2loPt40jjYYBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868852; c=relaxed/simple;
	bh=8Xx9VfYG62UoO2GXS5nYNhxLNevnF/o9z7mW7adsmMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVVVScFyy+4ksrdN32h5j3f6nQRqB+yS1J4gmGaEpKR8hLitV+Hopye24Clq6/T1yeh8P6g7euaeRPU3SqID66SAXOk4NdArvqwtOYyV+NkY3Z+Bf/5e0HpVxPO0I+eC07RMstv7moX8Xm73uggzswv1Q/k/O6jrXrFhBMxLllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlrYggjZ; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlrYggjZ"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so5015031c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868849; x=1791473649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQILXCbNTg3uilRJywVvrlkBNpYRNdVSU/c2Q3udK90=;
        b=NlrYggjZFEhLNbU+tStCHljv2StKUaTi45qHCJZCx4I9fK9wJ/8urTtbEkT/V6qN6x
         MqyFet3UUaCyk8mGCd4lf/ovnT0vKI+M/ueF2WlDn6nSUQ5Oo9CPK4owLifUEB9IPrPJ
         yAp+KsiONuoVVr2TFx0QjqkvHIgDjc5FU8UGAfK9XLYTKkfOfvoGKgtsz4Cc14loJ15u
         dMQMXopNcfpeJrwDH6cZezNS1O5AlWheRuSlT8RUcK+GIQPIO02bMi3JWcrMeSIAsX7D
         msOlHoRzhyUQMPNVbtBYT7xTEJe+lIsMPv0k92xQrLar5kxpN9xbYThT6MejkSnicyr2
         pSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868849; x=1791473649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQILXCbNTg3uilRJywVvrlkBNpYRNdVSU/c2Q3udK90=;
        b=rxJepCiSKy29f8cp/Rc3BsdJg4pusNn2NtWQgYLZWg+W05UAwL8bGkWe21T8J3E/SI
         mH+d6fUKKRgMiKy5omqBr18kXNgCQfOpGFjPuFfPPVGFbEAXLnPL8JT8FWDbiUkIExBn
         Co0szqZJDWx8AK3cMabvb70JDwXT28GUdpYL3KzQ2INoDurHu/+wINHDjnNQbi6hA83F
         vl2h4k9bR+b933SoeRTYVvMilvZb9mkw7vOf0sc5/dXQ5l3fZ2GO93a1RRbkMYQBuDVB
         4K6n2tKnmkHAx7fepGp434shQdLsxxP/qlg5Kqdt9K1lAkeQIbnyPG/CRFHrWeqb1Riz
         +4eA==
X-Forwarded-Encrypted: i=1; AKwUvBynPpqEwo5FMtnGi16dWR8sjuHj6eY1J0JMByqmsaQW4WeUPHbriAPQVFPCJzTfuFt5NCQMd+kgqZdnhdVbk/mepfE=@vger.kernel.org
X-Gm-Message-State: AFuF++mZDa6UvNkBvIHQ2919cFX2QuB9PN1YQxGG56NqdImTNQA122Mh
	aAEWHPw1Rg32L9RGjwNP9iAcZPo/sYS/5hPbgUZ6R11kQQA/gsrTo+VI
X-Gm-Gg: AYBFou2UTETifpmCL0B1KPrgkzH8qxWE/nlzFw41+zov3q+P0Z5Ly3rojU+ofq/AtO/
	YodO+aO54n4snzKsg5dnVgbOnMwjljD7Yi7PFzCxXq6U5kBDz+Wik7OaQwB6rpnUAxPA/SLV8eX
	iwsZqzK29whHtuW5Jx9wKoXs1u7Y5jhPT9LWN0zqEUHXTClut0oMLXjcsmFMTy94yDWQCIIQFP5
	eGJUjN3C0Ja3eYg760fFm5oV5xQofsQ2yAiIFp0QsP2WKdLhvJb8rmVIODZfQ2wjXGygfFQjwbl
	tVDUI4CwxMGvsy8FqJv0UpguvCQJlV8gnEvNcmZ0x8TwFI1tEdGi8kLiQUn+7jk6n1kOX0zJ3xV
	bPQx/rLcZWnLEFQmcMh29o9my+EMKeUUgANtfdz7odcJaFn4cWuYWDlzej06AudvFgxUEmx8+Nl
	3G5bstpKsz6H/nyStbXO4k7iV88qBwubLknYZkLVPi2MMj0oJtpDbW4SsnYf5WRpgl4g==
X-Received: by 2002:a05:7022:7e0b:b0:14a:5d07:9b with SMTP id a92af1059eb24-14d3641df3fmr5352454c88.28.1790868849303;
        Thu, 01 Oct 2026 08:34:09 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f266d1156sm146683c88.6.2026.10.01.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:34:08 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 23:33:48 +0800
Subject: [PATCH 1/2] mm/compaction: keep compaction deferral state per
 migration mode
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-mm-thp-async-compact-defer-v1-1-0174c7923430@gmail.com>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

try_to_compact_pages() defers a zone only after sync compaction fails,
so a failed async direct compaction is never deferred and repeats the
same futile zone scan on the next attempt. Deferring async compaction
needs state of its own: sync compaction may still succeed on the
pageblocks async skips, so it mustn't be deferred along with it.

Turn compact_considered, compact_defer_shift and compact_order_failed
into arrays indexed by sync, like compact_cached_migrate_pfn, and pass
the mode to the deferral helpers and tracepoints. All callers use the
sync state for now and a reset clears both. The deferral tracepoints
gain a sync field telling which state they report.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/mmzone.h            |  7 +++--
 include/trace/events/compaction.h | 27 ++++++++++--------
 mm/compaction.c                   | 60 +++++++++++++++++++++------------------
 3 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 94f9c3ff54160..91fbaa7aec6f9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1140,10 +1140,11 @@ struct zone {
 	 * are skipped before trying again. The number attempted since
 	 * last failure is tracked with compact_considered.
 	 * compact_order_failed is the minimum compaction failed order.
+	 * Indexed by sync, like compact_cached_migrate_pfn.
 	 */
-	unsigned int		compact_considered;
-	unsigned int		compact_defer_shift;
-	int			compact_order_failed;
+	unsigned int		compact_considered[ASYNC_AND_SYNC];
+	unsigned int		compact_defer_shift[ASYNC_AND_SYNC];
+	int			compact_order_failed[ASYNC_AND_SYNC];
 #endif
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index d05759d185389..23ac6e1750623 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -238,14 +238,15 @@ DEFINE_EVENT(mm_compaction_suitable_template, mm_compaction_suitable,
 
 DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, int order, bool sync),
 
-	TP_ARGS(zone, order),
+	TP_ARGS(zone, order, sync),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
 		__field(enum zone_type, idx)
 		__field(int, order)
+		__field(bool, sync)
 		__field(unsigned int, considered)
 		__field(unsigned int, defer_shift)
 		__field(int, order_failed)
@@ -255,15 +256,17 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 		__entry->nid = zone_to_nid(zone);
 		__entry->idx = zone_idx(zone);
 		__entry->order = order;
-		__entry->considered = zone->compact_considered;
-		__entry->defer_shift = zone->compact_defer_shift;
-		__entry->order_failed = zone->compact_order_failed;
+		__entry->sync = sync;
+		__entry->considered = zone->compact_considered[sync];
+		__entry->defer_shift = zone->compact_defer_shift[sync];
+		__entry->order_failed = zone->compact_order_failed[sync];
 	),
 
-	TP_printk("node=%d zone=%-8s order=%d order_failed=%d consider=%u limit=%lu",
+	TP_printk("node=%d zone=%-8s order=%d sync=%d order_failed=%d consider=%u limit=%lu",
 		__entry->nid,
 		__print_symbolic(__entry->idx, ZONE_TYPE),
 		__entry->order,
+		__entry->sync,
 		__entry->order_failed,
 		__entry->considered,
 		1UL << __entry->defer_shift)
@@ -271,23 +274,23 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_deferred,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, int order, bool sync),
 
-	TP_ARGS(zone, order)
+	TP_ARGS(zone, order, sync)
 );
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_defer_compaction,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, int order, bool sync),
 
-	TP_ARGS(zone, order)
+	TP_ARGS(zone, order, sync)
 );
 
 DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_defer_reset,
 
-	TP_PROTO(struct zone *zone, int order),
+	TP_PROTO(struct zone *zone, int order, bool sync),
 
-	TP_ARGS(zone, order)
+	TP_ARGS(zone, order, sync)
 );
 
 TRACE_EVENT(mm_compaction_kcompactd_sleep,
diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c67..7f8845d1990aa 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -124,35 +124,35 @@ static unsigned long release_free_list(struct list_head *freepages)
  * allocation success. 1 << compact_defer_shift, compactions are skipped up
  * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
  */
-static void defer_compaction(struct zone *zone, int order)
+static void defer_compaction(struct zone *zone, int order, bool sync)
 {
-	zone->compact_considered = 0;
-	zone->compact_defer_shift++;
+	zone->compact_considered[sync] = 0;
+	zone->compact_defer_shift[sync]++;
 
-	if (order < zone->compact_order_failed)
-		zone->compact_order_failed = order;
+	if (order < zone->compact_order_failed[sync])
+		zone->compact_order_failed[sync] = order;
 
-	if (zone->compact_defer_shift > COMPACT_MAX_DEFER_SHIFT)
-		zone->compact_defer_shift = COMPACT_MAX_DEFER_SHIFT;
+	if (zone->compact_defer_shift[sync] > COMPACT_MAX_DEFER_SHIFT)
+		zone->compact_defer_shift[sync] = COMPACT_MAX_DEFER_SHIFT;
 
-	trace_mm_compaction_defer_compaction(zone, order);
+	trace_mm_compaction_defer_compaction(zone, order, sync);
 }
 
 /* Returns true if compaction should be skipped this time */
-static bool compaction_deferred(struct zone *zone, int order)
+static bool compaction_deferred(struct zone *zone, int order, bool sync)
 {
-	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
+	unsigned long defer_limit = 1UL << zone->compact_defer_shift[sync];
 
-	if (order < zone->compact_order_failed)
+	if (order < zone->compact_order_failed[sync])
 		return false;
 
 	/* Avoid possible overflow */
-	if (++zone->compact_considered >= defer_limit) {
-		zone->compact_considered = defer_limit;
+	if (++zone->compact_considered[sync] >= defer_limit) {
+		zone->compact_considered[sync] = defer_limit;
 		return false;
 	}
 
-	trace_mm_compaction_deferred(zone, order);
+	trace_mm_compaction_deferred(zone, order, sync);
 
 	return true;
 }
@@ -165,24 +165,28 @@ static bool compaction_deferred(struct zone *zone, int order)
 void compaction_defer_reset(struct zone *zone, int order,
 		bool alloc_success)
 {
-	if (alloc_success) {
-		zone->compact_considered = 0;
-		zone->compact_defer_shift = 0;
+	int sync;
+
+	for (sync = 0; sync < ASYNC_AND_SYNC; sync++) {
+		if (alloc_success) {
+			zone->compact_considered[sync] = 0;
+			zone->compact_defer_shift[sync] = 0;
+		}
+		if (order >= zone->compact_order_failed[sync])
+			zone->compact_order_failed[sync] = order + 1;
 	}
-	if (order >= zone->compact_order_failed)
-		zone->compact_order_failed = order + 1;
 
-	trace_mm_compaction_defer_reset(zone, order);
+	trace_mm_compaction_defer_reset(zone, order, true);
 }
 
-/* Returns true if restarting compaction after many failures */
+/* Returns true if restarting sync compaction after many failures */
 static bool compaction_restarting(struct zone *zone, int order)
 {
-	if (order < zone->compact_order_failed)
+	if (order < zone->compact_order_failed[true])
 		return false;
 
-	return zone->compact_defer_shift == COMPACT_MAX_DEFER_SHIFT &&
-		zone->compact_considered >= 1UL << zone->compact_defer_shift;
+	return zone->compact_defer_shift[true] == COMPACT_MAX_DEFER_SHIFT &&
+		zone->compact_considered[true] >= 1UL << zone->compact_defer_shift[true];
 }
 
 /* Returns true if the pageblock should be scanned for pages to isolate. */
@@ -2855,7 +2859,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 				continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
-					&& compaction_deferred(zone, order)) {
+					&& compaction_deferred(zone, order, true)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
 			continue;
 		}
@@ -2893,7 +2897,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			 * so we defer compaction there. If it ends up
 			 * succeeding after all, it will be reset.
 			 */
-			defer_compaction(zone, order);
+			defer_compaction(zone, order, true);
 
 		/*
 		 * We might have stopped compacting due to need_resched() in
@@ -3111,7 +3115,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (compaction_deferred(zone, cc.order))
+		if (compaction_deferred(zone, cc.order, true))
 			continue;
 
 		ret = compaction_suit_allocation_order(zone,
@@ -3141,7 +3145,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 			 * We use sync migration mode here, so we defer like
 			 * sync direct compaction does.
 			 */
-			defer_compaction(zone, cc.order);
+			defer_compaction(zone, cc.order, true);
 		}
 
 		count_compact_events(KCOMPACTD_MIGRATE_SCANNED,

-- 
2.43.0

