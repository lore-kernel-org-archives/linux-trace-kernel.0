Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CED353A6B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755129; cv=none; b=gx4uk8Ci4uZPYJQ9A5jV+6SliIOhprdkbyFb/LYVNv49A8KBEk125jSGZaokHjHse9kfsA2kBFh3tzt8uGbxTCrU1YJfkX63qzolsqXR54l4b1ICga85OLxUDIeNlojPWMeCEpnKYwGP2m50+WrtmN0TYsNXMiHSgq4Hff6Byyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755129; c=relaxed/simple;
	bh=fMRMz0ejBh4DpIRYS+wm2oHU4pJhDLj/9tGMxFwRUKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVdcdz2Oci7Zg78slfzF3nQXgbLDYDfZs0O1aYS4xjZJjXP4s4chpOATClN6wFSVfLOh9nreIrvnGYXm+x+CUWCV4XIoiUd6QQXUdlV5ixp3XJw3DQkLmdVw2xgi+yr2BzaMXKBC29B3SvBczEIh9dzUjSJ0YYuge/6booG9B2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=byVwoUCh; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="byVwoUCh"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fMRMz0ejBh4DpIRYS+wm2oHU4pJhDLj/9tGMxFwRUKQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788755125; v=1; x=1789359925;
 b=byVwoUChGuNvb/pGK332+rp7H2BfVy6PrzCxkKSH0XnVKtTMKV8WTnuA6Z5tcCHtaazO3bUR
 OsmmVWivmAsPO2v3F8RgB+UVcw8teFxakftumJWTE3Q4NgPOZ1TYJPc763E95D5fxFN2/e69giF
 Z+LSVuRGi2b5eN1zl7AiFjNg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id acc1ac3b5cca2887;
	Mon, 07 Sep 2026 04:25:25 +0000
X-Mizu-Trace-ID: acc1ac3b5cca2887
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH RFC 1/2] mm/mglru: add tracepoint for folio isolation
Date: Mon,  7 Sep 2026 12:24:46 +0800
Message-Id: <20260907042447.2450663-2-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907042447.2450663-1-ridong.chen@linux.dev>
References: <20260907042447.2450663-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

MGLRU's scan_folios() and evict_folios() emit the classic-LRU
tracepoints trace_mm_vmscan_lru_isolate() and
trace_mm_vmscan_lru_shrink_inactive(). Those predate MGLRU and are
indistinguishable from the classic-LRU path: they carry no generation,
sequence, memcg or swappiness context, so a trace of an MGLRU run cannot
tell which memcg a given scan/evict belongs to, nor how far reclaim has
progressed through the generations.

Add mm_mglru_isolate_folios, emitted once per isolate_folios() call with
the memcg id, the type actually scanned, the effective swappiness, the
scanned/isolated counts, and the anon/file min_seq and max_seq. The
min_seq/max_seq triplet ties each isolation to the generation layout it
ran against, which the classic-LRU tracepoints cannot express.

This is emitted at the isolate_folios() layer, which is MGLRU-specific
and has no classic-LRU counterpart, so it neither changes nor duplicates
the existing scan/evict tracepoints.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 include/trace/events/vmscan.h | 47 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  9 ++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 8a872990b4be..a0e3cf75294b 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -392,6 +392,53 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
+TRACE_EVENT(mm_mglru_isolate_folios,
+
+	TP_PROTO(u64 memcg_id,
+		int type,
+		int swappiness,
+		unsigned long nr_scanned,
+		unsigned long nr_isolated,
+		unsigned long anon_min_seq,
+		unsigned long file_min_seq,
+		unsigned long max_seq),
+
+	TP_ARGS(memcg_id, type, swappiness, nr_scanned, nr_isolated,
+		anon_min_seq, file_min_seq, max_seq),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(int, type)
+		__field(int, swappiness)
+		__field(unsigned long, nr_scanned)
+		__field(unsigned long, nr_isolated)
+		__field(unsigned long, anon_min_seq)
+		__field(unsigned long, file_min_seq)
+		__field(unsigned long, max_seq)
+	),
+
+	TP_fast_assign(
+		__entry->memcg_id = memcg_id;
+		__entry->type = type;
+		__entry->swappiness = swappiness;
+		__entry->nr_scanned = nr_scanned;
+		__entry->nr_isolated = nr_isolated;
+		__entry->anon_min_seq = anon_min_seq;
+		__entry->file_min_seq = file_min_seq;
+		__entry->max_seq = max_seq;
+	),
+
+	TP_printk("memcg_id=%llu type=%s swappiness=%d nr_scanned=%lu nr_isolated=%lu anon_min_seq=%lu file_min_seq=%lu max_seq=%lu",
+		__entry->memcg_id,
+		__entry->type ? "file" : "anon",
+		__entry->swappiness,
+		__entry->nr_scanned,
+		__entry->nr_isolated,
+		__entry->anon_min_seq,
+		__entry->file_min_seq,
+		__entry->max_seq)
+);
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8409ea4bbf37..771fe6827939 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4843,6 +4843,7 @@ static int isolate_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	bool type_fallback_allowed = !is_single_type_reclaim(swappiness);
 	int type = get_type_to_scan(lruvec, swappiness);
 	int total_scanned = 0, scanned, tier;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	bool tried = false;
 
 retry:
@@ -4854,7 +4855,7 @@ static int isolate_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (*isolated) {
 		*isolate_type = type;
 		*isolate_scanned = scanned;
-		return total_scanned;
+		goto done;
 	}
 
 	/*
@@ -4876,6 +4877,12 @@ static int isolate_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 		goto retry;
 	}
 
+done:
+	trace_mm_mglru_isolate_folios(mem_cgroup_id(lruvec_memcg(lruvec)),
+				      type, swappiness, total_scanned, *isolated,
+				      lrugen->min_seq[LRU_GEN_ANON],
+				      lrugen->min_seq[LRU_GEN_FILE],
+				      lrugen->max_seq);
 	return total_scanned;
 }
 
-- 
2.34.1

