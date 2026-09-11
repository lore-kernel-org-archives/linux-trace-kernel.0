Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8E42900A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122642; cv=none; b=rA8U2qPXJ8Cz11h3/IbkNTQNC9pyNVSZArQ5+/nkqZUtW4i+Zbr7P4u+o4J+vzwW7g3WYczayf0MhaQ2QTAXIKNv2gsO2xxSkOzYGpV2Xf8eN6gG+5MKG6JzaKqYC7SQ6I5UI75BRZNZ8qCTIMkRhXoT1wJeNnJqRbiiyMxVBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122642; c=relaxed/simple;
	bh=f5e278sD3gNZ2nE15RiHlcOXf/umzmsjPSOt99uIDKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIb0uusA2sVVznK7UtCbyZPUI6n1oRzn0fhn0rNLNPpzk94hKKfQi2bSvkMRDyW7zbjd/To9kOpR0CqY8i3MY4Okqbz2MGmVGVHdPxvekvFVOD8hOP4xZjElIhjH5RSrlbNkLC0csV1plH2NuB6l773kj9UGy5DCKmbl5mx6lgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1i9gxW9; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1i9gxW9"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f5e278sD3gNZ2nE15RiHlcOXf/umzmsjPSOt99uIDKs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122637; v=1; x=1789727437;
 b=a1i9gxW9iuVtYN3wWZ2tqB50zw/lmzUSnqUg0inrvBsJXHd1htJsAaOTW+PU4OasyviCyKQf
 viEt4FQTpT26qST2EUfNFmWQjIaZXgWeShUGL06wPcg6epVy5/qoe6s/z2PK3h3uI0vsPsQ/gfq
 NqvfkMbOEx97Dm2fgQ8+AZOo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d4f4926e87c551a;
	Fri, 11 Sep 2026 10:30:36 +0000
X-Mizu-Trace-ID: 5d4f4926e87c551a
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
Date: Fri, 11 Sep 2026 18:29:38 +0800
Message-Id: <20260911102939.2485750-3-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911102939.2485750-1-ridong.chen@linux.dev>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

MGLRU's scan_folios() emits the classic-LRU tracepoint
trace_mm_vmscan_lru_isolate(), which predates MGLRU. It reports the
scan/isolate counts and the LRU type, but carries no generation or
memcg context, so a trace of an MGLRU run cannot tell which memcg a
given scan belongs to, nor how far reclaim has progressed through the
generations.

Add mm_mglru_scan_folios next to it, reporting the same counters plus
nr_sorted (folios moved to a younger generation by sort_folio()) and
the MGLRU context the classic tracepoint lacks: the memcg id, and the
max_seq, tier and min_seq of the type being scanned.

scan_folios() is the MGLRU-specific layer where folios are actually
scanned, so it has no classic-LRU counterpart. That the classic
trace_mm_vmscan_lru_isolate() has lived here stably shows this is a
long-lived place to hook, and the new tracepoint can be enabled on its
own to observe the MGLRU-specific information. The existing tracepoint
is left unchanged.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 include/trace/events/vmscan.h | 63 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  6 ++++
 2 files changed, 69 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 8a872990b4be..5defa8f6719c 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
+TRACE_EVENT(mm_mglru_scan_folios,
+
+	TP_PROTO(struct lruvec *lruvec,
+		int highest_zoneidx,
+		int order,
+		unsigned long nr_requested,
+		unsigned long nr_scanned,
+		unsigned long nr_sorted,
+		unsigned long nr_skipped,
+		unsigned long nr_taken,
+		int lru,
+		unsigned long max_seq,
+		int tier,
+		unsigned long min_seq),
+
+	TP_ARGS(lruvec, highest_zoneidx, order, nr_requested, nr_scanned,
+		nr_sorted, nr_skipped, nr_taken, lru, max_seq, tier, min_seq),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(int, highest_zoneidx)
+		__field(int, order)
+		__field(unsigned long, nr_requested)
+		__field(unsigned long, nr_scanned)
+		__field(unsigned long, nr_sorted)
+		__field(unsigned long, nr_skipped)
+		__field(unsigned long, nr_taken)
+		__field(int, lru)
+		__field(unsigned long, max_seq)
+		__field(int, tier)
+		__field(unsigned long, min_seq)
+	),
+
+	TP_fast_assign(
+		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
+		__entry->highest_zoneidx = highest_zoneidx;
+		__entry->order = order;
+		__entry->nr_requested = nr_requested;
+		__entry->nr_scanned = nr_scanned;
+		__entry->nr_sorted = nr_sorted;
+		__entry->nr_skipped = nr_skipped;
+		__entry->nr_taken = nr_taken;
+		__entry->lru = lru;
+		__entry->max_seq = max_seq;
+		__entry->tier = tier;
+		__entry->min_seq = min_seq;
+	),
+
+	TP_printk("memcg_id=%llu classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_sorted=%lu nr_skipped=%lu nr_taken=%lu lru=%s max_seq=%lu tier=%d min_seq=%lu",
+		__entry->memcg_id,
+		__entry->highest_zoneidx,
+		__entry->order,
+		__entry->nr_requested,
+		__entry->nr_scanned,
+		__entry->nr_sorted,
+		__entry->nr_skipped,
+		__entry->nr_taken,
+		__print_symbolic(__entry->lru, LRU_NAMES),
+		__entry->max_seq,
+		__entry->tier,
+		__entry->min_seq)
+);
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2554a6513aa8..67f59aa73fb9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
+	trace_mm_mglru_scan_folios(lruvec,
+				   sc->reclaim_idx, sc->order, nr_to_scan,
+				   scanned, sorted, skipped, isolated,
+				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
+				   lrugen->max_seq, tier,
+				   lrugen->min_seq[type]);
 
 	*isolatedp = isolated;
 	return scanned;
-- 
2.34.1

