Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935335E546
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376495; cv=none; b=ZJkm+ruihTZiRIcAXYtEN9xFo8NnTOUPxsvGijh6oJzNZnzS0bI5opwtJJpKb/LhlHow7PaO16Kzi686s5PeFx+N0wIqzVSmn/ZYFoPmrIG2Ni7MG/LGcJLzBZwbHwnxzhKIlqJb+MjnD2lU103kW5s2Y1Ez15tbyYgZmT5hSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376495; c=relaxed/simple;
	bh=DhQb4dNhELPWC8zIgpmV+VnbB0DpBj+2058/o+oR8Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHTLRRXDSxrFjK0PCvqSRnLPtoKOMIqXaUOFaHfa3gnZQI469lqDgTHXphIGuZW1D0JpA8YI9ouHkw0qcUDP1EAswc0IVt0z3IwDqrwkmAxNQX0wll/t0VprwC9Yp+lNhGBWZ2H4h2Emb5PNgol+32UpFRVTcScEw1w6p0BxeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EwIKnBY0; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EwIKnBY0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768376488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x3YqP9ZG6FyL2JK7Cc+pkWrJriDPOZs61tUnMuCISM=;
	b=EwIKnBY0ptJt79ezcxQtB+XpWywMpIAhrAHe/965yMbyYfj/AB6iOJvD0YLPcAWnpaGVYn
	l66Gxdy+0N1R+XFSDbjz5JWdK7Ki2JexfGflIoyCyuwprwpCp0UCIqd4CR/GmwGRvOVK1e
	M+iUSM9aWzMnwm043wnCZkMuRFMmgf0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org,
	shakeel.butt@linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm/vmscan: add tracepoint and reason for kswapd_failures reset
Date: Wed, 14 Jan 2026 15:40:36 +0800
Message-ID: <20260114074049.229935-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260114074049.229935-1-jiayuan.chen@linux.dev>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Currently, kswapd_failures is reset in multiple places (kswapd,
direct reclaim, PCP freeing, memory-tiers), but there's no way to
trace when and why it was reset, making it difficult to debug
memory reclaim issues.

This patch:

1. Introduce pgdat_reset_kswapd_failures() as a wrapper function to
   centralize kswapd_failures reset logic.

2. Add reset_kswapd_failures_reason enum to distinguish reset sources:
   - RESET_KSWAPD_FAILURES_KSWAPD: reset from kswapd context
   - RESET_KSWAPD_FAILURES_DIRECT: reset from direct reclaim
   - RESET_KSWAPD_FAILURES_PCP: reset from PCP page freeing
   - RESET_KSWAPD_FAILURES_OTHER: reset from other paths

3. Add tracepoints for better observability:
   - mm_vmscan_reset_kswapd_failures: traces each reset with reason
   - mm_vmscan_kswapd_reclaim_fail: traces each kswapd reclaim failure

---
Test results:

$ trace-cmd record -e vmscan:mm_vmscan_reset_kswapd_failures -e vmscan:mm_vmscan_kswapd_reclaim_fail
$ # generate memory pressure
$ trace-cmd report
cpus=4
kswapd1-73  [002]  24.863112: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=1
kswapd1-73  [002]  24.863472: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=2
kswapd1-73  [002]  24.863813: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=3
kswapd1-73  [002]  24.864141: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=4
kswapd1-73  [002]  24.864462: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=5
kswapd1-73  [002]  24.864779: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=6
kswapd1-73  [002]  24.865103: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=7
kswapd1-73  [002]  24.865421: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=8
kswapd1-73  [002]  24.865737: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=9
kswapd1-73  [002]  24.866070: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=10
kswapd1-73  [002]  24.866385: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=11
kswapd1-73  [002]  24.866701: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=12
kswapd1-73  [002]  24.867016: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=13
kswapd1-73  [002]  24.867333: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=14
kswapd1-73  [002]  24.867649: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=15
kswapd1-73  [002]  24.867965: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=16
kswapd0-72  [001]  25.020464: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=1
kswapd0-72  [001]  25.021054: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=2
kswapd0-72  [001]  25.021628: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=3
kswapd0-72  [001]  25.022217: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=4
kswapd0-72  [001]  25.022790: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=5
kswapd0-72  [001]  25.023366: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=6
kswapd0-72  [001]  25.023937: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=7
kswapd0-72  [001]  25.024511: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=8
kswapd0-72  [001]  25.025092: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=9
kswapd0-72  [001]  25.025665: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=10
kswapd0-72  [001]  25.026249: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=11
kswapd0-72  [001]  25.026824: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=12
kswapd0-72  [001]  25.027398: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=13
kswapd0-72  [001]  25.027976: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=14
kswapd0-72  [001]  25.028554: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=15
kswapd0-72  [001]  25.029140: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=16
ann-416     [002]  25.577925: mm_vmscan_reset_kswapd_failures: nid=0 reason=PCP
dd-417      [002]  35.111721: mm_vmscan_reset_kswapd_failures: nid=1 reason=DIRECT

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/mmzone.h        |  9 +++++++
 include/trace/events/vmscan.h | 51 +++++++++++++++++++++++++++++++++++
 mm/memory-tiers.c             |  2 +-
 mm/page_alloc.c               |  2 +-
 mm/vmscan.c                   | 16 +++++++----
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307..3f4d2928d8dc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1531,6 +1531,15 @@ static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
 	return pgdat->node_start_pfn + pgdat->node_spanned_pages;
 }
 
+enum reset_kswapd_failures_reason {
+	RESET_KSWAPD_FAILURES_OTHER = 0,
+	RESET_KSWAPD_FAILURES_KSWAPD,
+	RESET_KSWAPD_FAILURES_DIRECT,
+	RESET_KSWAPD_FAILURES_PCP,
+};
+
+void pgdat_reset_kswapd_failures(pg_data_t *pgdat, enum reset_kswapd_failures_reason reason);
+
 #include <linux/memory_hotplug.h>
 
 void build_all_zonelists(pg_data_t *pgdat);
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 490958fa10de..0747ad2f7932 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -40,6 +40,16 @@
 		{_VMSCAN_THROTTLE_CONGESTED,	"VMSCAN_THROTTLE_CONGESTED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
+TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_OTHER);
+TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_KSWAPD);
+TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_DIRECT);
+TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_PCP);
+
+#define reset_kswapd_src				\
+	{RESET_KSWAPD_FAILURES_KSWAPD,	"KSWAPD"},	\
+	{RESET_KSWAPD_FAILURES_DIRECT,	"DIRECT"},	\
+	{RESET_KSWAPD_FAILURES_PCP,	"PCP"},		\
+	{RESET_KSWAPD_FAILURES_OTHER,	"OTHER"}
 
 #define trace_reclaim_flags(file) ( \
 	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
@@ -535,6 +545,47 @@ TRACE_EVENT(mm_vmscan_throttled,
 		__entry->usec_delayed,
 		show_throttle_flags(__entry->reason))
 );
+
+TRACE_EVENT(mm_vmscan_kswapd_reclaim_fail,
+
+	TP_PROTO(int nid, int failures),
+
+	TP_ARGS(nid, failures),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, failures)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->failures = failures;
+	),
+
+	TP_printk("nid=%d failures=%d",
+		__entry->nid, __entry->failures)
+);
+
+TRACE_EVENT(mm_vmscan_reset_kswapd_failures,
+
+	TP_PROTO(int nid, int reason),
+
+	TP_ARGS(nid, reason),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, reason)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->reason = reason;
+	),
+
+	TP_printk("nid=%d reason=%s",
+		__entry->nid,
+		__print_symbolic(__entry->reason, reset_kswapd_src))
+);
 #endif /* _TRACE_VMSCAN_H */
 
 /* This part must be outside protection */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 864811fff409..8188f341bd77 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -956,7 +956,7 @@ static ssize_t demotion_enabled_store(struct kobject *kobj,
 		struct pglist_data *pgdat;
 
 		for_each_online_pgdat(pgdat)
-			atomic_set(&pgdat->kswapd_failures, 0);
+			pgdat_reset_kswapd_failures(pgdat, RESET_KSWAPD_FAILURES_OTHER);
 	}
 
 	return count;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7..cadf2c8b06a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2918,7 +2918,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 */
 		if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES &&
 		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
-			atomic_set(&pgdat->kswapd_failures, 0);
+			pgdat_reset_kswapd_failures(pgdat, RESET_KSWAPD_FAILURES_PCP);
 	}
 	return ret;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6fd100130987..8d9f3d29fe3b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2650,9 +2650,11 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			  lruvec_memcg(lruvec));
 }
 
-static void pgdat_reset_kswapd_failures(pg_data_t *pgdat)
+void pgdat_reset_kswapd_failures(pg_data_t *pgdat, enum reset_kswapd_failures_reason reason)
 {
-	atomic_set(&pgdat->kswapd_failures, 0);
+	/* Only trace actual resets, not redundant zero-to-zero */
+	if (atomic_xchg(&pgdat->kswapd_failures, 0))
+		trace_mm_vmscan_reset_kswapd_failures(pgdat->node_id, reason);
 }
 
 /*
@@ -2666,7 +2668,8 @@ static inline void pgdat_try_reset_kswapd_failures(struct pglist_data *pgdat,
 						   struct scan_control *sc)
 {
 	if (pgdat_balanced(pgdat, sc->order, sc->reclaim_idx))
-		pgdat_reset_kswapd_failures(pgdat);
+		pgdat_reset_kswapd_failures(pgdat, current_is_kswapd() ?
+			RESET_KSWAPD_FAILURES_KSWAPD : RESET_KSWAPD_FAILURES_DIRECT);
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -7153,8 +7156,11 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	 * watermark_high at this point. We need to avoid increasing the
 	 * failure count to prevent the kswapd thread from stopping.
 	 */
-	if (!sc.nr_reclaimed && !boosted)
-		atomic_inc(&pgdat->kswapd_failures);
+	if (!sc.nr_reclaimed && !boosted) {
+		int fail_cnt = atomic_inc_return(&pgdat->kswapd_failures);
+		/* kswapd context, low overhead to trace every failure */
+		trace_mm_vmscan_kswapd_reclaim_fail(pgdat->node_id, fail_cnt);
+	}
 
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
-- 
2.43.0

