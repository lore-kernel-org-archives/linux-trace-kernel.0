Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F593AE18F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798643; cv=none; b=q76B0KtFZ7km0+kP+UDcfW87FA1oPzQ046/PN+9wFk+bW9Of2S2A/+13FOzQXsrFkz5fC0UAiQ/YO6ZelH107eMvy4uxeWKdYjuQv0Q3Aa6JsfyPvtFSq0Y5xZZ0eolnt1mlzWt66h8Gh4PpurUOAY6CX15gHN8MbXzkxwnY/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798643; c=relaxed/simple;
	bh=KElQx1SsTYC8FTV6miolbo0y2qWvgSLcAaG1AjlVdfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bWobzAdvj3KvTX/aq75409RKl5yBIciroO0Gn5TyCy+jXctidimRWslZ2xUmhAaRNx2+7w9uPuZHTFWJfzw4opNbmLjHln3bDvEg2yX9gUMfzDhcvYeo40b1xY4bQDynY2+Tw30PXBUo7GaVCyXfOGbM7xwY7XwfuonHmbRGfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmuSMQzq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmuSMQzq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so891760a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777798641; x=1778403441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0TXFebOBkrQFdsHKAFpCWalVWtLPCeNooD3w1aSjjY=;
        b=jmuSMQzqCZQX/f5xoSrO+t0/GCFmUfpJpO/oCvUOlKFgZqgz/u4fVHvYteQzzfE48p
         TH1GFI5nwFO05nqEb0jRBU5YRNS12i3sqqkRWvU2lW2aEsKqmNa4117sjEv1rQyit01y
         jRT4vu3GcFhETOco+E4sCV/jJw3xiF6ZJbtqqJkO7aKHSPD1+RwCqbGWC8W16dYUmm5R
         l5D4yQJvJIZHt/fz+dcJzZ3TCPlvbkPGL9ue4cGCApTIvJs/vmtTZZQVzlAk6/waV35L
         LgghoqwsP7AJ6vLoQb5+1J0solEvzvkHLUa6rWX+61HRU2DgNbnRC/73qjBmHekKkMgK
         ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798641; x=1778403441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0TXFebOBkrQFdsHKAFpCWalVWtLPCeNooD3w1aSjjY=;
        b=Y1Sh99Tet8n9PSer+y9gKMyZxfDLIpi1Q/VNplycegtQksxphn7DZjC2CzMmJTa19k
         jfqCLmaiv7NZ8uMmPtTCktw75HVuk6avdi2r2Wm61c0PArsRSQkjhigrrHqAyAVpw1v4
         GoyoLz8jfJgIM9k0HH9Oiy5QUsKF4Pi7EgWGfjQ/F3aIAYj2spEo32K5DN31dEJuea1J
         X5xq2FWAjdNLJr39/kJ3eoBdJupOf7gf0XBzSj1ZMrCV2e8HNdsNpqpj8VbOZHChBHQU
         tRjA4xkVlhW9hCGb01XAQdIzrPyA3KL/qLs9V83vSQcyA/O+OgK+GWOtawL+L+SsrG35
         IXuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WDnNCsbZ9VGtXsoe7E5a/uGWUYEv2oPgOxyGZpCudX1+m5wWPCRauthYf3k9gooMYj9oUCplLxTd0U15N4RTMM6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynB5x9ENzsRNIXGVAXX432J+zxjh7lugLQ1hUua7aIYBomk9LG
	6+h5xqdzmZQ8YwcubonLhbKlFCxsKvkez/tx/Q0Tz+PHDxCmtBDNyPKX
X-Gm-Gg: AeBDiesBogbDhGmDvLX+TXTX03Uy2Mas50m+9jtez2hWjB2Vo0mVoPJk9e7weh6noBg
	+/u/KDtDJa/XQ4iCBXTPy2MyAVadz46Z56tJ8+TARknmjn/PUCncEinNPZ5Asi2f4behDN5uOJr
	4GEqDV2Dz6N27DFKcPqzXMw/9BdpRXwscu5vSH253jfD8bCMyGVqPp7CeLh/gQV3nqkQRHBTbll
	CAAuyYAWI13aLt187ZvqY9wNuDlbrX5wJ2DALxBO9NmZ5CdNjxsKG9Hj+F7ksHP/YcE8uKjSp2r
	skBFRN9oJ7z+S8KxwyGK0usSHYMRPW6YcvTsLZxRLoP8xmz5WQ0DgQ7GGkjD1RT5QJ51rNpQ0ks
	C5UkqFf3SWrfa+AIa+Auiw3TBViUNEM2PLsQfClpf1OyNhV82TasrRdPDtAO3TVAlVYEmblAkBZ
	MTyeIUfvXpVnj4cYIs5N1TLL9Dg7+uCN3q/WQuDqP5GDRqfO3EPw==
X-Received: by 2002:a17:902:ce11:b0:2ba:1202:4fc8 with SMTP id d9443c01a7336-2ba1202525fmr16484315ad.17.1777798640858;
        Sun, 03 May 2026 01:57:20 -0700 (PDT)
Received: from localhost ([183.227.123.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e791sm70589365ad.7.2026.05.03.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:57:20 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	kasong@tencent.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	ljs@kernel.org,
	baohua@kernel.org,
	mhiramat@kernel.org
Cc: linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH] mm: vmscan: rework lru_shrink and write_folio tracepoints
Date: Sun,  3 May 2026 16:57:05 +0800
Message-Id: <20260503085705.3276-1-qiwu.chen@transsion.com>
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

Fixes: 41ac1999c3e35 ("mm: vmscan: do not stall on writeback during memory compaction")
Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 include/trace/events/vmscan.h | 65 +++++++++++++++--------------------
 mm/vmscan.c                   |  9 ++---
 2 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 4445a8d9218d..d0a7fcd265e2 100644
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
 
@@ -362,19 +347,17 @@ TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
-		__field(int, reclaim_flags)
+		__field(int, lru)
 	),
 
 	TP_fast_assign(
 		__entry->pfn = folio_pfn(folio);
-		__entry->reclaim_flags = trace_reclaim_flags(
-						folio_is_file_lru(folio));
+		__entry->lru = folio_lru_list(folio);
 	),
 
-	TP_printk("page=%p pfn=0x%lx flags=%s",
+	TP_printk("page=%p lru=%s",
 		pfn_to_page(__entry->pfn),
-		__entry->pfn,
-		show_reclaim_flags(__entry->reclaim_flags))
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

