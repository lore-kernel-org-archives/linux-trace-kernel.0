Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477C35DA46
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056624; cv=none; b=a7dtfh7EPQ+9JdjOyh4q+LWQNWAM6OiEa7vF/K1vi5qpNHh62rjJBsGXEy8S8o2UH04PIw3jB1g0CSXqnDl5t5kXSeD1d60iNvCqwkRDn+ssp4NI6tL07Y9sJO4Kmm6xzyoCAQVjP/oVtxD9B8h6j81NslmVaKQL6cmgCk4LWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056624; c=relaxed/simple;
	bh=CnunHxUj3GAeffOuVMg7wrjdXLaEq1ma+sPheTvYJtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RwZ/rj+sDcRisBuLR/yu4zOO7UzRZPXdpO3XLB/mEdRA54M5v7ipWjzSXAzIFa1fjkHmxYTkXniO1RIPTeH/N6m5etK6qerWWINCpCejycSxGe+S8OFb7T914Gosz515tEi4up1/4zcH55zx4bh/QudZ9QedPm94C0ccrX6jcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC7E4T00; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC7E4T00"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so4415918b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778056622; x=1778661422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITQMVtuTNnqVfa8PUokcDI98Exfd6k/BoWWKWfOl9xo=;
        b=NC7E4T00npA9en2re7DgnAdi09BpFKPztAyZbpvssrGmZHpH1iZ0n2pB0E8J08U3Qq
         oOCXYuWQRvMuw/9ENBiK3hDRzMFhqeZR/QjMNNXMgcy4DCqBcBu16ce9shtV0qHhPO/1
         3w2put78d/sXb3xPitBXWUhjzJbPik8PJFqVdFHfnOXO15FV3zzUrF2CggQ4yKkRC30X
         mbjHTX9Qg18Pcfs9qXoPC18JEgfkBZKcketj3CMA29bEsBGygf0igxQ9N1FLqGzSzjHU
         ps3Dk+MjAK3K6Ox8/wVYCY7dNJ81/yo5csaiK5yUYfOjvuiJNxQ3GCK18kONC2snIQJH
         l3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778056622; x=1778661422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITQMVtuTNnqVfa8PUokcDI98Exfd6k/BoWWKWfOl9xo=;
        b=NuYUr6chL1lBCi6/a4SfCkRG+0hHQ0FO2bqyF422IOKTRFkDiBuWh2/2LFK3hiUHHq
         XADJodXQNxd4jRAxlSuG7N3JTAoplSBPgQlh7hgLrHRlCNuh/IGDohs4OlpH64rXzox1
         PPUytk05ZJv5lv7t9700/5Yz62xXTdbSCGIBZBtZjXfS400AB6RztJLmjLDmu3QcG2l4
         GD4xw9I7wv7e98Pjg57qm0hkTQGPPOOoQHEiMOEMU2E3N53vOZvdwDaF81FmFmcBL2NL
         NT8YoqTuqxoN2jKC2x7Ex/X2JSIeBr1vLwVPoHTdbuQwPetr/rCg06NhmpSRhzVtnSQ9
         HpoA==
X-Gm-Message-State: AOJu0YzuRzWV1mNjaAAOhUPZzA7r6+/J7NRc/bt7bmWP2Uw5FEO3TwsT
	NCqXAcZQICJGqs/MyRmLF5KeZRFAL+W+MEcMyGwMVpW3eMcFycI5HFUJ
X-Gm-Gg: AeBDievHrlVK7selbiJ/M2L1Ml0sJz8ZUbnynrni6ZE9nBURcJ+FMEZpuQUqUV2rM6x
	n3usmdyCT4Z1UNBTslgKhscpIqpqF+XRedHmg3pNDzvkBSreAub7TJC3GYjc0LmLJdOz5JOr82k
	9vMz8Ov4u37Zvo9Xkg1G2LuTwCqEd3efLKof/rFgIRdpxmshEr7aIrLhk6JZjI36NWNJ7FMKs/i
	ee14QyUZ7HZWsse/ZcR+xG0D/PrKMG++Sfs/WlfFtD3WmVCQeRRTN3URz8wJtt7aqilIuhAaYuE
	/czl/n2PeI2yxlwnzBoJG4Hfo8JRToP4rb/tpLbdaEQeBpxS4S7dRIjA6UzicR2u5bUP9GD5JUI
	Xtgq9ZRrqmReVb9HOL6GKv+ZNmGb8Zltrw4+Xeo3YRKzT1mB+gPvWQFDLv9KALVJv2wmwgLIbbY
	yw9Mb5WRYtDMxEk3khyK896Bj2A8iTZkCLtPsz9IMDOC3khlo=
X-Received: by 2002:a05:6a00:198f:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-83a5c8b06f9mr2156160b3a.21.1778056621788;
        Wed, 06 May 2026 01:37:01 -0700 (PDT)
Received: from localhost ([154.39.63.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm4949965b3a.53.2026.05.06.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:37:01 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	willy@infradead.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio tracepoints
Date: Wed,  6 May 2026 16:36:52 +0800
Message-Id: <20260506083652.100160-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, reclaim_flags always contains RECLAIM_WB_ASYNC in lru_shrink
tracepoints since commit 41ac1999c3e35 ("mm: vmscan: do not stall on
writeback during memory compaction"), which is useless for debugging
memory pressure issues. Other RECLAIM_WB_* flags are not used anywhere
else, so they can be directly removed.
This patch reworks the lru_shrink and write_folio tracepoints for better
correlation and analysis:
 - traces each folio lru type instead of reclaim_flags.
 - traces each lru_shrink with reason.
 - remove the printing of the unnecessary PFN for mm_vmscan_write_folio.

Fixes: 41ac1999c3e35 ("mm: vmscan: do not stall on writeback during memory compaction")
Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 include/trace/events/vmscan.h | 71 +++++++++++++++--------------------
 mm/vmscan.c                   |  9 +++--
 2 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 4445a8d9218d..e3cecd4b4524 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -11,22 +11,6 @@
 #include <linux/memcontrol.h>
 #include <trace/events/mmflags.h>
 
-#define RECLAIM_WB_ANON		0x0001u
-#define RECLAIM_WB_FILE		0x0002u
-#define RECLAIM_WB_MIXED	0x0010u
-#define RECLAIM_WB_SYNC		0x0004u /* Unused, all reclaim async */
-#define RECLAIM_WB_ASYNC	0x0008u
-#define RECLAIM_WB_LRU		(RECLAIM_WB_ANON|RECLAIM_WB_FILE)
-
-#define show_reclaim_flags(flags)				\
-	(flags) ? __print_flags(flags, "|",			\
-		{RECLAIM_WB_ANON,	"RECLAIM_WB_ANON"},	\
-		{RECLAIM_WB_FILE,	"RECLAIM_WB_FILE"},	\
-		{RECLAIM_WB_MIXED,	"RECLAIM_WB_MIXED"},	\
-		{RECLAIM_WB_SYNC,	"RECLAIM_WB_SYNC"},	\
-		{RECLAIM_WB_ASYNC,	"RECLAIM_WB_ASYNC"}	\
-		) : "RECLAIM_WB_NONE"
-
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
 #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
 #define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
@@ -51,10 +35,11 @@ TRACE_DEFINE_ENUM(KSWAPD_CLEAR_HOPELESS_PCP);
 	{KSWAPD_CLEAR_HOPELESS_PCP,	"PCP"},		\
 	{KSWAPD_CLEAR_HOPELESS_OTHER,	"OTHER"}
 
-#define trace_reclaim_flags(file) ( \
-	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
-	(RECLAIM_WB_ASYNC) \
-	)
+#define trace_reclaim_reason_ops		\
+	{PGSTEAL_KSWAPD,	"KSWAPD"},	\
+	{PGSTEAL_DIRECT,	"DIRECT"},	\
+	{PGSTEAL_KHUGEPAGED,	"KHUGEPAGED"}, \
+	{PGSTEAL_PROACTIVE,	"PROACTIVE"}
 
 TRACE_EVENT(mm_vmscan_kswapd_sleep,
 
@@ -361,20 +346,18 @@ TRACE_EVENT(mm_vmscan_write_folio,
 	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, pfn)
-		__field(int, reclaim_flags)
+		__field(unsigned long, folio)
+		__field(int, lru)
 	),
 
 	TP_fast_assign(
-		__entry->pfn = folio_pfn(folio);
-		__entry->reclaim_flags = trace_reclaim_flags(
-						folio_is_file_lru(folio));
+		__entry->folio = folio;
+		__entry->lru = folio_lru_list(folio);
 	),
 
-	TP_printk("page=%p pfn=0x%lx flags=%s",
-		pfn_to_page(__entry->pfn),
-		__entry->pfn,
-		show_reclaim_flags(__entry->reclaim_flags))
+	TP_printk("folio=%p lru=%s",
+		__entry->folio,
+		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
 TRACE_EVENT(mm_vmscan_reclaim_pages,
@@ -426,9 +409,9 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 
 	TP_PROTO(int nid,
 		unsigned long nr_scanned, unsigned long nr_reclaimed,
-		struct reclaim_stat *stat, int priority, int file),
+		struct reclaim_stat *stat, int priority, int lru, int reason),
 
-	TP_ARGS(nid, nr_scanned, nr_reclaimed, stat, priority, file),
+	TP_ARGS(nid, nr_scanned, nr_reclaimed, stat, priority, lru, reason),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
@@ -443,7 +426,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
-		__field(int, reclaim_flags)
+		__field(int, lru)
+		__field(int, reason)
 	),
 
 	TP_fast_assign(
@@ -459,10 +443,11 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
-		__entry->reclaim_flags = trace_reclaim_flags(file);
+		__entry->lru = lru;
+		__entry->reason = reason;
 	),
 
-	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d lru=%s reason=%s",
 		__entry->nid,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
@@ -470,16 +455,17 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_activate0, __entry->nr_activate1,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
 		__entry->priority,
-		show_reclaim_flags(__entry->reclaim_flags))
+		__print_symbolic(__entry->lru, LRU_NAMES),
+		__print_symbolic(__entry->reason, trace_reclaim_reason_ops))
 );
 
 TRACE_EVENT(mm_vmscan_lru_shrink_active,
 
 	TP_PROTO(int nid, unsigned long nr_taken,
 		unsigned long nr_active, unsigned long nr_deactivated,
-		unsigned long nr_referenced, int priority, int file),
+		unsigned long nr_referenced, int priority, int lru, int reason),
 
-	TP_ARGS(nid, nr_taken, nr_active, nr_deactivated, nr_referenced, priority, file),
+	TP_ARGS(nid, nr_taken, nr_active, nr_deactivated, nr_referenced, priority, lru, reason),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
@@ -488,7 +474,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		__field(unsigned long, nr_deactivated)
 		__field(unsigned long, nr_referenced)
 		__field(int, priority)
-		__field(int, reclaim_flags)
+		__field(int, lru)
+		__field(int, reason)
 	),
 
 	TP_fast_assign(
@@ -498,15 +485,17 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		__entry->nr_deactivated = nr_deactivated;
 		__entry->nr_referenced = nr_referenced;
 		__entry->priority = priority;
-		__entry->reclaim_flags = trace_reclaim_flags(file);
+		__entry->lru = lru;
+		__entry->reason = reason;
 	),
 
-	TP_printk("nid=%d nr_taken=%ld nr_active=%ld nr_deactivated=%ld nr_referenced=%ld priority=%d flags=%s",
+	TP_printk("nid=%d nr_taken=%ld nr_active=%ld nr_deactivated=%ld nr_referenced=%ld priority=%d lru=%s reason=%s",
 		__entry->nid,
 		__entry->nr_taken,
 		__entry->nr_active, __entry->nr_deactivated, __entry->nr_referenced,
 		__entry->priority,
-		show_reclaim_flags(__entry->reclaim_flags))
+		__print_symbolic(__entry->lru, LRU_NAMES),
+		__print_symbolic(__entry->reason, trace_reclaim_reason_ops))
 );
 
 TRACE_EVENT(mm_vmscan_node_reclaim_begin,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd1b1aa12581..4ee84db91635 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2044,7 +2044,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 		sc->nr.file_taken += nr_taken;
 
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
-			nr_scanned, nr_reclaimed, &stat, sc->priority, file);
+			nr_scanned, nr_reclaimed, &stat, sc->priority, lru, item);
 	return nr_reclaimed;
 }
 
@@ -2151,7 +2151,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	lruvec_lock_irq(lruvec);
 	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
-			nr_deactivate, nr_rotated, sc->priority, file);
+			nr_deactivate, nr_rotated, sc->priority, lru,
+			PGSTEAL_KSWAPD + reclaimer_offset(sc));
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
@@ -4854,9 +4855,10 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false, memcg);
 	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
+	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
-			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
+			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON, item);
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		DEFINE_MIN_SEQ(lruvec);
@@ -4892,7 +4894,6 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
 
-	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	mod_lruvec_state(lruvec, item, reclaimed);
 	mod_lruvec_state(lruvec, PGSTEAL_ANON + type, reclaimed);
 
-- 
2.25.1

