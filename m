Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496A3AA195;
	Tue, 20 Jan 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941035; cv=none; b=TqrlrSNtL9CNq8xdVKrIA5X51SC862lYAgvx9UhHPwBda/Ss1iq+LHHM48U37MAP0Hsg1jktY/Fduyq0WCVg3H7NiB6D8y2bnHJrWCZQ201CzxAKHRav8LXdNNhek2+xLWH1woiyPh8BfdIBjidMNPwkE9chvBgxLGCrX5S0s5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941035; c=relaxed/simple;
	bh=gQqT6mFfMSf2uJPK6Qy5o07DzG64JdRhARiJi+q6Ngs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mkk9EfrLPZd+BvPHHEdSAdZawF6MNHMKjfuTYixky4ZemDazfUNDxdyu1wgeYKDGccM7pPOpoJPIJHYRe536ETistR3DVkGC1tUFgf4Vtru5PswHIhUt1I6CrRCgHi/Cvr//qEGoly9DdetZPq4lhcxFqnC0uL30PCQ4g3YdXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vXDZ5y5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vXDZ5y5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C42AC16AAE;
	Tue, 20 Jan 2026 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768941034;
	bh=gQqT6mFfMSf2uJPK6Qy5o07DzG64JdRhARiJi+q6Ngs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vXDZ5y5aVLeXC2R4rIUZdrkYjLUf5R/CiCq8HTi/ZdjcIbrSKGXrQbdGhPflSixiE
	 DkuRq02KU+hX8OS9UL5rhBuTl5+X0OG6+HlqnhHWrPYfHxCAGYYw6onUZpiK+FETx9
	 4C8YH0/Vy7mfu8scc/+ee6cRqdujTEVaxj9Af3jk=
Date: Tue, 20 Jan 2026 12:30:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Jiayuan Chen <jiayuan.chen@shopee.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm/vmscan: mitigate spurious kswapd_failures
 reset and add tracepoints
Message-Id: <20260120123033.b2f0dec292fba02d5c8aafab@linux-foundation.org>
In-Reply-To: <20260120024402.387576-1-jiayuan.chen@linux.dev>
References: <20260120024402.387576-1-jiayuan.chen@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 10:43:47 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> == Problem ==
> 
> We observed an issue in production on a multi-NUMA system where kswapd
> runs endlessly, causing sustained heavy IO READ pressure across the
> entire system.
> 
> The root cause is that direct reclaim triggered by cgroup memory.high
> keeps resetting kswapd_failures to 0, even when the node cannot be
> balanced. This prevents kswapd from ever stopping after reaching
> MAX_RECLAIM_RETRIES.
> 

Updated, thanks.

> v3 -> v4: https://lore.kernel.org/linux-mm/20260114074049.229935-1-jiayuan.chen@linux.dev/
>   - Add Acked-by tags
>   - Some modifications suggested by Johannes Weiner 

Here's how v4 altered mm.git:


 include/linux/mmzone.h        |   26 ++++++++-----
 include/trace/events/vmscan.h |   24 ++++++------
 mm/memory-tiers.c             |    2 -
 mm/page_alloc.c               |    4 +-
 mm/show_mem.c                 |    3 -
 mm/vmscan.c                   |   60 +++++++++++++++++---------------
 mm/vmstat.c                   |    2 -
 7 files changed, 64 insertions(+), 57 deletions(-)

--- a/include/linux/mmzone.h~b
+++ a/include/linux/mmzone.h
@@ -1531,26 +1531,30 @@ static inline unsigned long pgdat_end_pf
 	return pgdat->node_start_pfn + pgdat->node_spanned_pages;
 }
 
-enum reset_kswapd_failures_reason {
-	RESET_KSWAPD_FAILURES_OTHER = 0,
-	RESET_KSWAPD_FAILURES_KSWAPD,
-	RESET_KSWAPD_FAILURES_DIRECT,
-	RESET_KSWAPD_FAILURES_PCP,
-};
-
-void pgdat_reset_kswapd_failures(pg_data_t *pgdat, enum reset_kswapd_failures_reason reason);
-
 #include <linux/memory_hotplug.h>
 
 void build_all_zonelists(pg_data_t *pgdat);
-void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
-		   enum zone_type highest_zoneidx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int highest_zoneidx, unsigned int alloc_flags,
 			 long free_pages);
 bool zone_watermark_ok(struct zone *z, unsigned int order,
 		unsigned long mark, int highest_zoneidx,
 		unsigned int alloc_flags);
+
+enum kswapd_clear_hopeless_reason {
+	KSWAPD_CLEAR_HOPELESS_OTHER = 0,
+	KSWAPD_CLEAR_HOPELESS_KSWAPD,
+	KSWAPD_CLEAR_HOPELESS_DIRECT,
+	KSWAPD_CLEAR_HOPELESS_PCP,
+};
+
+void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
+		   enum zone_type highest_zoneidx);
+void kswapd_try_clear_hopeless(struct pglist_data *pgdat,
+			       unsigned int order, int highest_zoneidx);
+void kswapd_clear_hopeless(pg_data_t *pgdat, enum kswapd_clear_hopeless_reason reason);
+bool kswapd_test_hopeless(pg_data_t *pgdat);
+
 /*
  * Memory initialization context, use to differentiate memory added by
  * the platform statically or via memory hotplug interface.
--- a/include/trace/events/vmscan.h~b
+++ a/include/trace/events/vmscan.h
@@ -40,16 +40,16 @@
 		{_VMSCAN_THROTTLE_CONGESTED,	"VMSCAN_THROTTLE_CONGESTED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
-TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_OTHER);
-TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_KSWAPD);
-TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_DIRECT);
-TRACE_DEFINE_ENUM(RESET_KSWAPD_FAILURES_PCP);
-
-#define reset_kswapd_src				\
-	{RESET_KSWAPD_FAILURES_KSWAPD,	"KSWAPD"},	\
-	{RESET_KSWAPD_FAILURES_DIRECT,	"DIRECT"},	\
-	{RESET_KSWAPD_FAILURES_PCP,	"PCP"},		\
-	{RESET_KSWAPD_FAILURES_OTHER,	"OTHER"}
+TRACE_DEFINE_ENUM(KSWAPD_CLEAR_HOPELESS_OTHER);
+TRACE_DEFINE_ENUM(KSWAPD_CLEAR_HOPELESS_KSWAPD);
+TRACE_DEFINE_ENUM(KSWAPD_CLEAR_HOPELESS_DIRECT);
+TRACE_DEFINE_ENUM(KSWAPD_CLEAR_HOPELESS_PCP);
+
+#define kswapd_clear_hopeless_reason_ops		\
+	{KSWAPD_CLEAR_HOPELESS_KSWAPD,	"KSWAPD"},	\
+	{KSWAPD_CLEAR_HOPELESS_DIRECT,	"DIRECT"},	\
+	{KSWAPD_CLEAR_HOPELESS_PCP,	"PCP"},		\
+	{KSWAPD_CLEAR_HOPELESS_OTHER,	"OTHER"}
 
 #define trace_reclaim_flags(file) ( \
 	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
@@ -566,7 +566,7 @@ TRACE_EVENT(mm_vmscan_kswapd_reclaim_fai
 		__entry->nid, __entry->failures)
 );
 
-TRACE_EVENT(mm_vmscan_reset_kswapd_failures,
+TRACE_EVENT(mm_vmscan_kswapd_clear_hopeless,
 
 	TP_PROTO(int nid, int reason),
 
@@ -584,7 +584,7 @@ TRACE_EVENT(mm_vmscan_reset_kswapd_failu
 
 	TP_printk("nid=%d reason=%s",
 		__entry->nid,
-		__print_symbolic(__entry->reason, reset_kswapd_src))
+		__print_symbolic(__entry->reason, kswapd_clear_hopeless_reason_ops))
 );
 #endif /* _TRACE_VMSCAN_H */
 
--- a/mm/memory-tiers.c~b
+++ a/mm/memory-tiers.c
@@ -955,7 +955,7 @@ static ssize_t demotion_enabled_store(st
 		struct pglist_data *pgdat;
 
 		for_each_online_pgdat(pgdat)
-			pgdat_reset_kswapd_failures(pgdat, RESET_KSWAPD_FAILURES_OTHER);
+			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_OTHER);
 	}
 
 	return count;
--- a/mm/page_alloc.c~b
+++ a/mm/page_alloc.c
@@ -2945,9 +2945,9 @@ static bool free_frozen_page_commit(stru
 		 * 'hopeless node' to stay in that state for a while.  Let
 		 * kswapd work again by resetting kswapd_failures.
 		 */
-		if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES &&
+		if (kswapd_test_hopeless(pgdat) &&
 		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
-			pgdat_reset_kswapd_failures(pgdat, RESET_KSWAPD_FAILURES_PCP);
+			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
 }
--- a/mm/show_mem.c~b
+++ a/mm/show_mem.c
@@ -278,8 +278,7 @@ static void show_free_areas(unsigned int
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
 			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			str_yes_no(atomic_read(&pgdat->kswapd_failures) >=
-				   MAX_RECLAIM_RETRIES),
+			str_yes_no(kswapd_test_hopeless(pgdat)),
 			K(node_page_state(pgdat, NR_BALLOON_PAGES)));
 	}
 
--- a/mm/vmscan.c~b
+++ a/mm/vmscan.c
@@ -506,7 +506,7 @@ static bool skip_throttle_noprogress(pg_
 	 * If kswapd is disabled, reschedule if necessary but do not
 	 * throttle as the system is likely near OOM.
 	 */
-	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
+	if (kswapd_test_hopeless(pgdat))
 		return true;
 
 	/*
@@ -2647,28 +2647,6 @@ static bool can_age_anon_pages(struct lr
 			  lruvec_memcg(lruvec));
 }
 
-void pgdat_reset_kswapd_failures(pg_data_t *pgdat, enum reset_kswapd_failures_reason reason)
-{
-	/* Only trace actual resets, not redundant zero-to-zero */
-	if (atomic_xchg(&pgdat->kswapd_failures, 0))
-		trace_mm_vmscan_reset_kswapd_failures(pgdat->node_id, reason);
-}
-
-/*
- * Reset kswapd_failures only when the node is balanced. Without this
- * check, successful direct reclaim (e.g., from cgroup memory.high
- * throttling) can keep resetting kswapd_failures even when the node
- * cannot be balanced, causing kswapd to run endlessly.
- */
-static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx);
-static inline void pgdat_try_reset_kswapd_failures(struct pglist_data *pgdat,
-						   struct scan_control *sc)
-{
-	if (pgdat_balanced(pgdat, sc->order, sc->reclaim_idx))
-		pgdat_reset_kswapd_failures(pgdat, current_is_kswapd() ?
-			RESET_KSWAPD_FAILURES_KSWAPD : RESET_KSWAPD_FAILURES_DIRECT);
-}
-
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
@@ -5086,7 +5064,7 @@ static void lru_gen_shrink_node(struct p
 	blk_finish_plug(&plug);
 done:
 	if (sc->nr_reclaimed > reclaimed)
-		pgdat_try_reset_kswapd_failures(pgdat, sc);
+		kswapd_try_clear_hopeless(pgdat, sc->order, sc->reclaim_idx);
 }
 
 /******************************************************************************
@@ -6153,7 +6131,7 @@ again:
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
 	if (reclaimable)
-		pgdat_try_reset_kswapd_failures(pgdat, sc);
+		kswapd_try_clear_hopeless(pgdat, sc->order, sc->reclaim_idx);
 	else if (sc->cache_trim_mode)
 		sc->cache_trim_mode_failed = 1;
 }
@@ -6458,7 +6436,7 @@ static bool allow_direct_reclaim(pg_data
 	int i;
 	bool wmark_ok;
 
-	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
+	if (kswapd_test_hopeless(pgdat))
 		return true;
 
 	for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
@@ -6867,7 +6845,7 @@ static bool prepare_kswapd_sleep(pg_data
 		wake_up_all(&pgdat->pfmemalloc_wait);
 
 	/* Hopeless node, leave it to direct reclaim */
-	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
+	if (kswapd_test_hopeless(pgdat))
 		return true;
 
 	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
@@ -7395,7 +7373,7 @@ void wakeup_kswapd(struct zone *zone, gf
 		return;
 
 	/* Hopeless node, leave it to direct reclaim if possible */
-	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES ||
+	if (kswapd_test_hopeless(pgdat) ||
 	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
 	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
@@ -7415,6 +7393,32 @@ void wakeup_kswapd(struct zone *zone, gf
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
+void kswapd_clear_hopeless(pg_data_t *pgdat, enum kswapd_clear_hopeless_reason reason)
+{
+	/* Only trace actual resets, not redundant zero-to-zero */
+	if (atomic_xchg(&pgdat->kswapd_failures, 0))
+		trace_mm_vmscan_kswapd_clear_hopeless(pgdat->node_id, reason);
+}
+
+/*
+ * Reset kswapd_failures only when the node is balanced. Without this
+ * check, successful direct reclaim (e.g., from cgroup memory.high
+ * throttling) can keep resetting kswapd_failures even when the node
+ * cannot be balanced, causing kswapd to run endlessly.
+ */
+void kswapd_try_clear_hopeless(struct pglist_data *pgdat,
+			       unsigned int order, int highest_zoneidx)
+{
+	if (pgdat_balanced(pgdat, order, highest_zoneidx))
+		kswapd_clear_hopeless(pgdat, current_is_kswapd() ?
+			KSWAPD_CLEAR_HOPELESS_KSWAPD : KSWAPD_CLEAR_HOPELESS_DIRECT);
+}
+
+bool kswapd_test_hopeless(pg_data_t *pgdat)
+{
+	return atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES;
+}
+
 #ifdef CONFIG_HIBERNATION
 /*
  * Try to free `nr_to_reclaim' of memory, system-wide, and return the number of
--- a/mm/vmstat.c~b
+++ a/mm/vmstat.c
@@ -1840,7 +1840,7 @@ static void zoneinfo_show_print(struct s
 		   "\n  start_pfn:           %lu"
 		   "\n  reserved_highatomic: %lu"
 		   "\n  free_highatomic:     %lu",
-		   atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES,
+		   kswapd_test_hopeless(pgdat),
 		   zone->zone_start_pfn,
 		   zone->nr_reserved_highatomic,
 		   zone->nr_free_highatomic);
_

