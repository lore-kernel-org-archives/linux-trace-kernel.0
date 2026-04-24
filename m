Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AC3016FC;
	Fri, 24 Apr 2026 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000498; cv=none; b=bWWB5S2IbVyxP3jnEOPpiEm6/BSMEYpJ86vKaKpMaK/oqUBAJNP5xmtoiUKapZAQTgYefBaM3b9AzEenn/HTWeK1xughGtSF3SbyhwQKRWci6Ajv+j9cMuGDxs6f3uCqZ7gd8f2XcGCD51Bv7eCpGOxEjoC5HdDFX1TDfHx96Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000498; c=relaxed/simple;
	bh=W++Xowgx77JKFlnjRViqybtmnhU+fIz2BoMIlWT0MTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWZArSp8GjP38n/PqkkFbjoeSSD/5xqaPn8KojMMytLB7RWRNwxU753vrwRd5POA/VylVkUbkprruN/flcAjObkwl9j/E6CRfJdMJ3TP5HD/v+4dCoEiI9VcPOAMKQASwnOVidxpIgMLQbsAWKv9mlfXgGvPEiBlRb+1B4IlPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=jl35am/A; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="jl35am/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1777000489;
	bh=W++Xowgx77JKFlnjRViqybtmnhU+fIz2BoMIlWT0MTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jl35am/AImuqxCCWBV1VA6kkI5AkprfA+wB5mb620xjQvOmQAd4RG8A/oB1eg9P2c
	 Yvj3137vCg8aotsrYo6E3Pei+RBurSgaEpFwUDDucQFA1ExS+GwFwH/XeiJrFWuERP
	 oUKqTv2DqWlgc2J0fR1QtSJECFU8ha3v9JaWtF6wB+Y6/Kg2BtJrXOHRZMKTybQIIZ
	 w4ihhWhOXP0SSsm9u25ydO7FJpPpeCaLMlfOabSEQTCz+n0aIYhqvGQjZrLUhOJaSy
	 ZGy9O75LLy1+um63r5HZhjjii3WXfSNUGvei7Erp3a1WmNONuUGNgYq6hx34X6kgbL
	 D82dOBEeLMa0Q==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id D05522FF4E5;
	Fri, 24 Apr 2026 03:14:49 +0000 (UTC)
Received: from dynamic.ipv6.sjtu.edu.cn (unknown [10.180.122.86])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 75E0A37C921;
	Fri, 24 Apr 2026 11:14:49 +0800 (CST)
From: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: david@kernel.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
Subject: [PATCH v2] mm/vmscan: add balance_pgdat begin/end tracepoints
Date: Fri, 24 Apr 2026 11:14:18 +0800
Message-ID: <20260424031418.174597-1-b.suvonov@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
References: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vmscan has six main reclaim entry points: try_to_free_pages() for
direct reclaim, try_to_free_mem_cgroup_pages() for memcg reclaim,
mem_cgroup_shrink_node() for memcg soft limit reclaim, node_reclaim()
for node reclaim, shrink_all_memory() for hibernation reclaim, and
balance_pgdat() for kswapd reclaim.

All of them, except for shrink_all_memory() and balance_pgdat(), already
have begin/end tracepoints. This makes it harder to trace which reclaim
path is responsible for memory reclaim activity, because kswapd reclaim
cannot be identified as cleanly as other reclaim entry points, even
though it is the main background reclaim path under memory pressure.
There may be no need to trace shrink_all_memory() as it is primarily
used during hibernation. So this patch adds the missing tracepoint pair
for balance_pgdat().

The begin tracepoint records the node id, requested reclaim order, and
the requested classzone bound (highest_zoneidx). The end tracepoint
records the node id, the reclaim order that balance_pgdat() finished
with, the requested classzone bound, and nr_reclaimed. Together, they
show the requested reclaim order and classzone bound, whether reclaim
fell back to a lower order, and how much reclaim work was done.

The end tracepoint also records highest_zoneidx even though it does not
change within a balance_pgdat() invocation. This keeps the end event
self-contained, so users can analyze reclaim results directly from end
events without depending on begin/end correlation, which is less
convenient when tracing is filtered or records are dropped. It also
makes it straightforward to relate nr_reclaimed and the final reclaim
order to the requested classzone bound.

Signed-off-by: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
---
v2:
- explain why highest_zoneidx is kept in the end tracepoint

 include/trace/events/vmscan.h | 52 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 4445a8d9218d..b4bf7b8def1f 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -96,6 +96,58 @@ TRACE_EVENT(mm_vmscan_kswapd_wake,
 		__entry->order)
 );
 
+TRACE_EVENT(mm_vmscan_balance_pgdat_begin,
+
+	TP_PROTO(int nid, int order, int highest_zoneidx),
+
+	TP_ARGS(nid, order, highest_zoneidx),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, order)
+		__field(int, highest_zoneidx)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->order = order;
+		__entry->highest_zoneidx = highest_zoneidx;
+	),
+
+	TP_printk("nid=%d order=%d highest_zoneidx=%-8s",
+		__entry->nid,
+		__entry->order,
+		__print_symbolic(__entry->highest_zoneidx, ZONE_TYPE))
+);
+
+TRACE_EVENT(mm_vmscan_balance_pgdat_end,
+
+	TP_PROTO(int nid, int order, int highest_zoneidx,
+		 unsigned long nr_reclaimed),
+
+	TP_ARGS(nid, order, highest_zoneidx, nr_reclaimed),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, order)
+		__field(int, highest_zoneidx)
+		__field(unsigned long, nr_reclaimed)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->order = order;
+		__entry->highest_zoneidx = highest_zoneidx;
+		__entry->nr_reclaimed = nr_reclaimed;
+	),
+
+	TP_printk("nid=%d order=%d highest_zoneidx=%-8s nr_reclaimed=%lu",
+		__entry->nid,
+		__entry->order,
+		__print_symbolic(__entry->highest_zoneidx, ZONE_TYPE),
+		__entry->nr_reclaimed)
+);
+
 TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 
 	TP_PROTO(int nid, int zid, int order, gfp_t gfp_flags),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd1b1aa12581..b2d89ed69d22 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7121,6 +7121,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.may_unmap = 1,
 	};
 
+	trace_mm_vmscan_balance_pgdat_begin(pgdat->node_id, order,
+					    highest_zoneidx);
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	psi_memstall_enter(&pflags);
 	__fs_reclaim_acquire(_THIS_IP_);
@@ -7314,6 +7316,9 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	psi_memstall_leave(&pflags);
 	set_task_reclaim_state(current, NULL);
 
+	trace_mm_vmscan_balance_pgdat_end(pgdat->node_id, sc.order,
+					  highest_zoneidx, sc.nr_reclaimed);
+
 	/*
 	 * Return the order kswapd stopped reclaiming at as
 	 * prepare_kswapd_sleep() takes it into account. If another caller
-- 
2.53.0

