Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FC1F8BD6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877093; cv=none; b=skUHp4HeK1eGSEA2RHEAHlovP8BJ+tXKawMK3iHjiaCZbz05/OohSR39Z88B4uT5sVtzYROSYRzL3aLGLqCcua0IUEiPwzU4SEnmijn0qec5rxMBKeZn3Lm/7E7ws+HH00mvgFVm7WRL70UY7U6HNM+0tUENBkJeIS5ajStEwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877093; c=relaxed/simple;
	bh=b+/pKjCOHx8PFHM/aUEXmSr7r16RM7sN6iD9DAbltME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euR9dZF87fa1p/TiuMd8cvtBH+UGUI1b2fe/9OgS7CjW/y3pWTE3+hf8TkfhIJpalQCegA2csGgsCj19D5KrmAaUpehxNjXqujbkcbKA1zniLnYlRyzhb4XLvERosbfltR+9qS2jt4Xu//Fjg/fN8+GkwwF36Tbf4t78pT7MSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CddlsIq/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CddlsIq/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768877090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pls5MXmyRyRItrjpCM4LqoeGJ08hhYmNWXA6AmLbX1E=;
	b=CddlsIq/Ciydyqy4nKbcYe6ckcjbSG+ZOowYiATHpCXohzhOJCjnIjqmiLbLJWxRorTMPY
	tDX3Ud3S3yxDcjyHrSJEj4zQtkOz/RK8+FnIs5eNgF0sXMYDMFXFXA8xFcPdn6K7sq/xbI
	YTYn0BLs4eO9e2FdexEzxOwtLkEJkgI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
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
Subject: [PATCH v4 1/2] mm/vmscan: mitigate spurious kswapd_failures reset from direct reclaim
Date: Tue, 20 Jan 2026 10:43:48 +0800
Message-ID: <20260120024402.387576-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260120024402.387576-1-jiayuan.chen@linux.dev>
References: <20260120024402.387576-1-jiayuan.chen@linux.dev>
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

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/mmzone.h |  2 ++
 mm/vmscan.c            | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307..3a0f52188ff6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1536,6 +1536,8 @@ static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
 void build_all_zonelists(pg_data_t *pgdat);
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
 		   enum zone_type highest_zoneidx);
+void kswapd_try_clear_hopeless(struct pglist_data *pgdat,
+			       unsigned int order, int highest_zoneidx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int highest_zoneidx, unsigned int alloc_flags,
 			 long free_pages);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..ecd019b8b452 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5067,7 +5067,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	blk_finish_plug(&plug);
 done:
 	if (sc->nr_reclaimed > reclaimed)
-		atomic_set(&pgdat->kswapd_failures, 0);
+		kswapd_try_clear_hopeless(pgdat, sc->order, sc->reclaim_idx);
 }
 
 /******************************************************************************
@@ -6141,7 +6141,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
 	if (reclaimable)
-		atomic_set(&pgdat->kswapd_failures, 0);
+		kswapd_try_clear_hopeless(pgdat, sc->order, sc->reclaim_idx);
 	else if (sc->cache_trim_mode)
 		sc->cache_trim_mode_failed = 1;
 }
@@ -7414,6 +7414,24 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
+static void kswapd_clear_hopeless(pg_data_t *pgdat)
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
+void kswapd_try_clear_hopeless(struct pglist_data *pgdat,
+			       unsigned int order, int highest_zoneidx)
+{
+	if (pgdat_balanced(pgdat, order, highest_zoneidx))
+		kswapd_clear_hopeless(pgdat);
+}
+
 #ifdef CONFIG_HIBERNATION
 /*
  * Try to free `nr_to_reclaim' of memory, system-wide, and return the number of
-- 
2.43.0

