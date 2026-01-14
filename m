Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F3379971;
	Wed, 14 Jan 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376484; cv=none; b=ZnDOkHoeONktkye98y/jrJ+trH9rqtbsZ59N0rkFoQGJycJadZjdMPBXetP6pKigwpxeEJAr4XNt/Lxur+J45dvOnJNnU214d0HN0W4BY0jtNhoYerNuW5065iammUuQzZ7dlpRiUHWWCv/oiP/u5QDfMwR7tblT0P/cR4n6emA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376484; c=relaxed/simple;
	bh=YTdVAgfK5gnPWN0zIJ1m9pCPeYWmsJ5yJ4O6kvkm164=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5pTXScfKcW10yEFfONdssGqfo20EWenuWV/oeao5L76iGINwPJ9K/eLUpvbUqUg0lQGfv/wD446LCwaS1AHOk/QGFaWdv7SvUPM37TjiUIH6uT8avUDrXm/8DlD02dGvjVWpUrE5msf5WBK9Fe/27iXFU+kTUX9iRUNdeXmyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HdN96whk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HdN96whk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768376477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m29ZRcbPtm9JpokMLGdHmu+Zzbc/y/DtDAKnbut40qw=;
	b=HdN96whkUmsgrx9dCvaK4FKjnr4b/YWZi+Fh8vqu/jrQVehdy5bbEPBksLoG5nWYZae1nR
	beLx7ZZTiyR/S7lgwaSgA4WQEEZ3Sb7TDvcBGH3jcq9M09gHEXmlApjzWAPXsqXksufhQq
	OOrdludBb226tISEMzE2u8UrtZjufKQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org,
	shakeel.butt@linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/vmscan: mitigate spurious kswapd_failures reset from direct reclaim
Date: Wed, 14 Jan 2026 15:40:35 +0800
Message-ID: <20260114074049.229935-2-jiayuan.chen@linux.dev>
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

When kswapd fails to reclaim memory, kswapd_failures is incremented.
Once it reaches MAX_RECLAIM_RETRIES, kswapd stops running to avoid
futile reclaim attempts. However, any successful direct reclaim
unconditionally resets kswapd_failures to 0, which can cause problems.

We observed an issue in production on a multi-NUMA system where a
process allocated large amounts of anonymous pages on a single NUMA
node, causing its watermark to drop below high and evicting most file
pages:

$ numastat -m
Per-node system memory usage (in MBs):
                          Node 0          Node 1           Total
                 --------------- --------------- ---------------
MemTotal               128222.19       127983.91       256206.11
MemFree                  1414.48         1432.80         2847.29
MemUsed                126807.71       126551.11       252358.82
SwapCached                  0.00            0.00            0.00
Active                  29017.91        25554.57        54572.48
Inactive                92749.06        95377.00       188126.06
Active(anon)            28998.96        23356.47        52355.43
Inactive(anon)          92685.27        87466.11       180151.39
Active(file)               18.95         2198.10         2217.05
Inactive(file)             63.79         7910.89         7974.68

With swap disabled, only file pages can be reclaimed. When kswapd is
woken (e.g., via wake_all_kswapds()), it runs continuously but cannot
raise free memory above the high watermark since reclaimable file pages
are insufficient. Normally, kswapd would eventually stop after
kswapd_failures reaches MAX_RECLAIM_RETRIES.

However, containers on this machine have memory.high set in their
cgroup. Business processes continuously trigger the high limit, causing
frequent direct reclaim that keeps resetting kswapd_failures to 0. This
prevents kswapd from ever stopping.

The key insight is that direct reclaim triggered by cgroup memory.high
performs aggressive scanning to throttle the allocating process. With
sufficiently aggressive scanning, even hot pages will eventually be
reclaimed, making direct reclaim "successful" at freeing some memory.
However, this success does not mean the node has reached a balanced
state - the freed memory may still be insufficient to bring free pages
above the high watermark. Unconditionally resetting kswapd_failures in
this case keeps kswapd alive indefinitely.

The result is that kswapd runs endlessly. Unlike direct reclaim which
only reclaims from the allocating cgroup, kswapd scans the entire node's
memory. This causes hot file pages from all workloads on the node to be
evicted, not just those from the cgroup triggering memory.high. These
pages constantly refault, generating sustained heavy IO READ pressure
across the entire system.

Fix this by only resetting kswapd_failures when the node is actually
balanced. This allows both kswapd and direct reclaim to clear
kswapd_failures upon successful reclaim, but only when the reclaim
actually resolves the memory pressure (i.e., the node becomes balanced).

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 mm/vmscan.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..6fd100130987 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2650,6 +2650,25 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			  lruvec_memcg(lruvec));
 }
 
+static void pgdat_reset_kswapd_failures(pg_data_t *pgdat)
+{
+	atomic_set(&pgdat->kswapd_failures, 0);
+}
+
+/*
+ * Reset kswapd_failures only when the node is balanced. Without this
+ * check, successful direct reclaim (e.g., from cgroup memory.high
+ * throttling) can keep resetting kswapd_failures even when the node
+ * cannot be balanced, causing kswapd to run endlessly.
+ */
+static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx);
+static inline void pgdat_try_reset_kswapd_failures(struct pglist_data *pgdat,
+						   struct scan_control *sc)
+{
+	if (pgdat_balanced(pgdat, sc->order, sc->reclaim_idx))
+		pgdat_reset_kswapd_failures(pgdat);
+}
+
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
@@ -5067,7 +5086,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	blk_finish_plug(&plug);
 done:
 	if (sc->nr_reclaimed > reclaimed)
-		atomic_set(&pgdat->kswapd_failures, 0);
+		pgdat_try_reset_kswapd_failures(pgdat, sc);
 }
 
 /******************************************************************************
@@ -6141,7 +6160,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
 	if (reclaimable)
-		atomic_set(&pgdat->kswapd_failures, 0);
+		pgdat_try_reset_kswapd_failures(pgdat, sc);
 	else if (sc->cache_trim_mode)
 		sc->cache_trim_mode_failed = 1;
 }
-- 
2.43.0

