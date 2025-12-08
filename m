Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2A2749CF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217667; cv=none; b=ZWEs8SKj0i+aLtJGzMTK53iN/tscrbM622WjPDuPP2pYz0C98waLDLweAo8KDeP6xJcbo2UzTeqEyH9CrVn2/Jkl3cNdVCpz39TxE5A4oWEjViFhiOoC1SWx/Jj/4uKQabzEU9awOPCK4apkD7Y1TNC8K5Pvd7J7dvaeNaroe6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217667; c=relaxed/simple;
	bh=tKw6qczXunB50cMQfiGALn7G46ZQ4TYCbOMWIuHQJi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ghyb6rcKgqpMTGkVjRnDSdE0DsyfujiFr7EwQkXSLTnB192DPYX590RKlaSiG4XiPK7Pf/5orKTwbM8D2Qn0ZKa0Fo5zqFpBgKIHuNO6nWv3b4b7QVwQKM518uAsoaTUjJv2+G1uaQ+OBtO93PAKMoSODxI7xROLBbjlu+zoGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JhiqhJM2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JhiqhJM2"
Received: from LAPTOP-U3CCR7C6.lan (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 072E32116043;
	Mon,  8 Dec 2025 10:14:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 072E32116043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765217665;
	bh=InvdrRFrXQJFqVg8lDeFoDfygxUx+JgnbS36d8q94EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhiqhJM2u5tzc5NRoGeTIykMccIi//sq5h+Nt1I9Lnag1yWsGdu4gbzgEkMVeNJ1b
	 DhZGFSgi/V1R11okSVyfih8Wcpm48KGwOnMosHes3gLWx8/RBBqy8tAziGrl/z4PdD
	 6j4rkoMg7uH9wPJvikQsvFc1awg4BGRMGqulXCeY=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Date: Mon,  8 Dec 2025 10:14:12 -0800
Message-Id: <20251208181413.4722-2-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208181413.4722-1-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory reclaim events are currently difficult to attribute to
specific cgroups, making debugging memory pressure issues
challenging.  This patch adds memory cgroup ID (memcg_id) to key
vmscan tracepoints to enable better correlation and analysis.

For operations not associated with a specific cgroup, the field
is defaulted to 0.

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
---
 include/trace/events/vmscan.h | 65 +++++++++++++++++++++--------------
 mm/vmscan.c                   | 17 ++++-----
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d59..afc9f80d03f34 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -114,85 +114,92 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(int order, gfp_t gfp_flags, unsigned short memcg_id),
 
-	TP_ARGS(order, gfp_flags),
+	TP_ARGS(order, gfp_flags, memcg_id),
 
 	TP_STRUCT__entry(
 		__field(	int,	order		)
 		__field(	unsigned long,	gfp_flags	)
+		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->order		= order;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
+		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("order=%d gfp_flags=%s",
+	TP_printk("order=%d gfp_flags=%s memcg_id=%u",
 		__entry->order,
-		show_gfp_flags(__entry->gfp_flags))
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->memcg_id)
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(int order, gfp_t gfp_flags, unsigned short memcg_id),
 
-	TP_ARGS(order, gfp_flags)
+	TP_ARGS(order, gfp_flags, memcg_id)
 );
 
 #ifdef CONFIG_MEMCG
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(int order, gfp_t gfp_flags, unsigned short memcg_id),
 
-	TP_ARGS(order, gfp_flags)
+	TP_ARGS(order, gfp_flags, memcg_id)
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(int order, gfp_t gfp_flags, unsigned short memcg_id),
 
-	TP_ARGS(order, gfp_flags)
+	TP_ARGS(order, gfp_flags, memcg_id)
 );
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, unsigned short memcg_id),
 
-	TP_ARGS(nr_reclaimed),
+	TP_ARGS(nr_reclaimed, memcg_id),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	nr_reclaimed	)
+		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->nr_reclaimed	= nr_reclaimed;
+		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("nr_reclaimed=%lu", __entry->nr_reclaimed)
+	TP_printk("nr_reclaimed=%lu memcg_id=%u",
+		__entry->nr_reclaimed,
+		__entry->memcg_id)
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, unsigned short memcg_id),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(nr_reclaimed, memcg_id)
 );
 
 #ifdef CONFIG_MEMCG
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, unsigned short memcg_id),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(nr_reclaimed, memcg_id)
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, unsigned short memcg_id),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(nr_reclaimed, memcg_id)
 );
 #endif /* CONFIG_MEMCG */
 
@@ -209,6 +216,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(struct shrinker *, shr)
 		__field(void *, shrink)
 		__field(int, nid)
+		__field(unsigned short, memcg_id)
 		__field(long, nr_objects_to_shrink)
 		__field(unsigned long, gfp_flags)
 		__field(unsigned long, cache_items)
@@ -221,6 +229,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->shr = shr;
 		__entry->shrink = shr->scan_objects;
 		__entry->nid = sc->nid;
+		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
 		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
 		__entry->gfp_flags = (__force unsigned long)sc->gfp_mask;
 		__entry->cache_items = cache_items;
@@ -229,10 +238,11 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 	),
 
-	TP_printk("%pS %p: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d memcg_id: %u objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->memcg_id,
 		__entry->nr_objects_to_shrink,
 		show_gfp_flags(__entry->gfp_flags),
 		__entry->cache_items,
@@ -242,15 +252,16 @@ TRACE_EVENT(mm_shrink_slab_start,
 );
 
 TRACE_EVENT(mm_shrink_slab_end,
-	TP_PROTO(struct shrinker *shr, int nid, int shrinker_retval,
+	TP_PROTO(struct shrinker *shr, struct shrink_control *sc, int shrinker_retval,
 		long unused_scan_cnt, long new_scan_cnt, long total_scan),
 
-	TP_ARGS(shr, nid, shrinker_retval, unused_scan_cnt, new_scan_cnt,
+	TP_ARGS(shr, sc, shrinker_retval, unused_scan_cnt, new_scan_cnt,
 		total_scan),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(int, nid)
+		__field(unsigned short, memcg_id)
 		__field(void *, shrink)
 		__field(long, unused_scan)
 		__field(long, new_scan)
@@ -260,7 +271,8 @@ TRACE_EVENT(mm_shrink_slab_end,
 
 	TP_fast_assign(
 		__entry->shr = shr;
-		__entry->nid = nid;
+		__entry->nid = sc->nid;
+		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
 		__entry->shrink = shr->scan_objects;
 		__entry->unused_scan = unused_scan_cnt;
 		__entry->new_scan = new_scan_cnt;
@@ -268,10 +280,11 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->total_scan = total_scan;
 	),
 
-	TP_printk("%pS %p: nid: %d unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d memcg_id: %u unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->memcg_id,
 		__entry->unused_scan,
 		__entry->new_scan,
 		__entry->total_scan,
@@ -463,9 +476,9 @@ TRACE_EVENT(mm_vmscan_node_reclaim_begin,
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_node_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, unsigned short memcg_id),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(nr_reclaimed, memcg_id)
 );
 
 TRACE_EVENT(mm_vmscan_throttled,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 258f5472f1e90..0e65ec3a087a5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -931,7 +931,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
 
-	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
@@ -7092,11 +7092,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		return 1;
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
+	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask, 0);
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
-	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
+	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed, 0);
 	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
@@ -7126,7 +7126,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
-						      sc.gfp_mask);
+						      sc.gfp_mask,
+						      mem_cgroup_id(memcg));
 
 	/*
 	 * NOTE: Although we can get the priority field, using it
@@ -7137,7 +7138,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 */
 	shrink_lruvec(lruvec, &sc);
 
-	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
+	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed, mem_cgroup_id(memcg));
 
 	*nr_scanned = sc.nr_scanned;
 
@@ -7171,13 +7172,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
+	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask, mem_cgroup_id(memcg));
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
+	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed, mem_cgroup_id(memcg));
 	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
@@ -8072,7 +8073,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	fs_reclaim_release(sc.gfp_mask);
 	psi_memstall_leave(&pflags);
 
-	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
+	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed, 0);
 
 	return sc.nr_reclaimed >= nr_pages;
 }
-- 
2.33.8

