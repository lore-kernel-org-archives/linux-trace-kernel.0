Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C322440656
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122648; cv=none; b=kOGWFufjqsEDEh9TZf/3jmg95Bba1mUO8Q1Umn2GOqQ+vTzS+D0u/kJRkMXFCPv1DnaDozBbBeAy9rsSGyb0fe1y7c0AMtaHlD1xnBBKdLrsk1q39B2KggzySNOoRpXwGKw/pHlPH5KpUf6blzIK391lObBTNIQcy/0P96gGWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122648; c=relaxed/simple;
	bh=g+Mf/kGaBSRXqlRStbFxv9nvRzYBpUgfPbFtW3GN2lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNTd3VUaoifpBhO8xmmPCSrvkXilbtIvfPh4d6XmwKV0dRfmQSNfyCqFbfxs14Jd7xinysUyyyb8UISp+BHsNbNrHIK0g3Y409gkEDwG7IHpey2V1Zi2GSAgM5JKVhvwLoPLhHLpp/gJLgoZb9zDbbPht85OXKiRB+oIKft8GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BzEEi9MF; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BzEEi9MF"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g+Mf/kGaBSRXqlRStbFxv9nvRzYBpUgfPbFtW3GN2lM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122643; v=1; x=1789727443;
 b=BzEEi9MFIx2W5/R4L8onsD37pl0LiBvCvmUbhg0dhfrids0Qo7MXMe2CcZuwoed//NL0I3kV
 /jckL3QZvm+TWpsQyu+ZOwEF6nmYLh0HD8wSbAHs1nfiLZ7Uj6GcrNTpbjxMQuO5CKS1S2YEiZ8
 gIqrNZjQK5YLbQB0rbSDr1pQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4018faa0ac020977;
	Fri, 11 Sep 2026 10:30:43 +0000
X-Mizu-Trace-ID: 4018faa0ac020977
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
Subject: [PATCH v2 3/3] mm/mglru: add tracepoint for inc_max_seq()
Date: Fri, 11 Sep 2026 18:29:39 +0800
Message-Id: <20260911102939.2485750-4-ridong.chen@linux.dev>
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

Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
youngest generation. There is currently no tracepoint on this path, so
the moment a new generation is created, and how the min_seq of each type
trails behind it, cannot be observed as it happens.

Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped, with
the memcg id, the new max_seq, the anon and file min_seq, and the number
of pages in each generation for both types, summed over zones the same
way the debugfs lru_gen file reports them. The nr_anon/nr_file arrays are
indexed by generation slot, so the emitted max_seq/min_seq say which slot
holds which seq. They are printed with __print_array(), so the output is
hex and its length follows MAX_NR_GENS automatically. Paired with the
mm_mglru_scan_folios tracepoint it makes the full aging-to-eviction
window observable per memcg.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 include/trace/events/vmscan.h | 38 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   | 23 +++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 5defa8f6719c..a20c6b2e062f 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -455,6 +455,44 @@ TRACE_EVENT(mm_mglru_scan_folios,
 		__entry->min_seq)
 );
 
+TRACE_EVENT(mm_mglru_inc_max_seq,
+
+	TP_PROTO(struct lruvec *lruvec,
+		unsigned long max_seq,
+		unsigned long anon_min_seq,
+		unsigned long file_min_seq,
+		unsigned long *nr_anon,
+		unsigned long *nr_file),
+
+	TP_ARGS(lruvec, max_seq, anon_min_seq, file_min_seq, nr_anon, nr_file),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(unsigned long, max_seq)
+		__field(unsigned long, anon_min_seq)
+		__field(unsigned long, file_min_seq)
+		__array(unsigned long, nr_anon, MAX_NR_GENS)
+		__array(unsigned long, nr_file, MAX_NR_GENS)
+	),
+
+	TP_fast_assign(
+		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
+		__entry->max_seq = max_seq;
+		__entry->anon_min_seq = anon_min_seq;
+		__entry->file_min_seq = file_min_seq;
+		memcpy(__entry->nr_anon, nr_anon, sizeof(__entry->nr_anon));
+		memcpy(__entry->nr_file, nr_file, sizeof(__entry->nr_file));
+	),
+
+	TP_printk("memcg_id=%llu max_seq=%lu anon_min_seq=%lu file_min_seq=%lu nr_anon=%s nr_file=%s",
+		__entry->memcg_id,
+		__entry->max_seq,
+		__entry->anon_min_seq,
+		__entry->file_min_seq,
+		__print_array(__entry->nr_anon, MAX_NR_GENS, sizeof(unsigned long)),
+		__print_array(__entry->nr_file, MAX_NR_GENS, sizeof(unsigned long)))
+);
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 67f59aa73fb9..d1495a7d469d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4100,6 +4100,27 @@ static void try_to_inc_min_seq(struct lruvec *lruvec, int swappiness)
 	}
 }
 
+static void trace_inc_max_seq(struct lruvec *lruvec)
+{
+	int type, gen;
+	unsigned long nr[ANON_AND_FILE][MAX_NR_GENS];
+	struct lru_gen_folio *lrugen;
+
+	if (!trace_mm_mglru_inc_max_seq_enabled())
+		return;
+
+	lrugen = &lruvec->lrugen;
+	for (type = 0; type < ANON_AND_FILE; type++)
+		for (gen = 0; gen < MAX_NR_GENS; gen++)
+			nr[type][gen] = lru_gen_seq_nr_pages(lrugen, gen, type);
+
+	trace_mm_mglru_inc_max_seq(lruvec,
+				   lrugen->max_seq,
+				   lrugen->min_seq[LRU_GEN_ANON],
+				   lrugen->min_seq[LRU_GEN_FILE],
+				   nr[LRU_GEN_ANON], nr[LRU_GEN_FILE]);
+}
+
 static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness)
 {
 	bool success;
@@ -4159,6 +4180,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+
+	trace_inc_max_seq(lruvec);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
-- 
2.34.1

