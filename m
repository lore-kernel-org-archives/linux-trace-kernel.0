Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36843DEA4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122633; cv=none; b=oMcv0Hgnit0D6ADUWe/TdFSvlvZ9rYMyqDvhKjEmhUgHVuVeGKjYHhtenaFWsa1eHwNRQj3Bo8vt3Uz6IpApEeO/+ZOD1O0uYM3Lu2xWOrPAkKa6o6j34yvqPi8/wBVge+JUepae6UQ17iuIMl/q8dvPyoo2bGa+zFT8mJuk2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122633; c=relaxed/simple;
	bh=g5xNOknu84CKDZN5IQmWT85FT3qL1QmesKNb79arhdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQ5guJUCEM6erQbyp34WLWHnHpd70ouui/i8aD9wZDL9CvDDGoii3cOPxMhgidnHqKh0bsuOCSrHAwTrI4NJMss9Q8eodeZNxRDT0xSOXsT1XwsfAc4Y5/8Q5RJXmcpSn8YQFYnwJw3B6PIpkWoRQK7r+o5LbxjS2q+NnG3S98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aef1eTjV; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aef1eTjV"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g5xNOknu84CKDZN5IQmWT85FT3qL1QmesKNb79arhdM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122627; v=1; x=1789727427;
 b=Aef1eTjVrm46A0vgLyFjNEkDfapE3r9tTcoesUBPRE4ALnx1byFWfxRUlT0Z7idyD0MRGNlu
 VBW/7RXTMySamhx9fqttL+wN2l8lZdOMxMIn7j+shOWWoAIZVgu1Pmp1eAzfHuznCyr/sVpuBi4
 wrr0I1CRlX663oDU+kaSWWbI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f4fa41675c0fe4c3;
	Fri, 11 Sep 2026 10:30:04 +0000
X-Mizu-Trace-ID: f4fa41675c0fe4c3
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
Subject: [PATCH v2 1/3] mm/mglru: factor out lru_gen_seq_nr_pages()
Date: Fri, 11 Sep 2026 18:29:37 +0800
Message-Id: <20260911102939.2485750-2-ridong.chen@linux.dev>
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

Both lruvec_evictable_size() and the debugfs lru_gen_seq_show() compute
the number of pages in a generation the same way: sum lrugen->nr_pages
over all zones for a given (gen, type) and clamp each term to >= 0.

Factor that out into lru_gen_seq_nr_pages() so the open-coded zone loop
lives in one place. No functional change.

A follow-up patch adds a tracepoint that needs the same per-generation
page count, and will reuse this helper instead of open-coding it again.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 mm/vmscan.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 40d3f1b48a74..2554a6513aa8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2813,6 +2813,18 @@ static int get_nr_gens(struct lruvec *lruvec, int type)
 	return lruvec->lrugen.max_seq - lruvec->lrugen.min_seq[type] + 1;
 }
 
+/* the number of pages in a generation, summed over zones and clamped to >= 0 */
+static unsigned long lru_gen_seq_nr_pages(struct lru_gen_folio *lrugen, int gen, int type)
+{
+	int zone;
+	unsigned long size = 0;
+
+	for (zone = 0; zone < MAX_NR_ZONES; zone++)
+		size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+
+	return size;
+}
+
 static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
 {
 	int type;
@@ -4239,7 +4251,7 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 
 static unsigned long lruvec_evictable_size(struct lruvec *lruvec, int swappiness)
 {
-	int gen, type, zone;
+	int gen, type;
 	unsigned long seq, total = 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	DEFINE_MAX_SEQ(lruvec);
@@ -4248,8 +4260,7 @@ static unsigned long lruvec_evictable_size(struct lruvec *lruvec, int swappiness
 	for_each_evictable_type(type, swappiness) {
 		for (seq = min_seq[type]; seq <= max_seq; seq++) {
 			gen = lru_gen_from_seq(seq);
-			for (zone = 0; zone < MAX_NR_ZONES; zone++)
-				total += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+			total += lru_gen_seq_nr_pages(lrugen, gen, type);
 		}
 	}
 
@@ -5738,19 +5749,16 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 		seq = 0;
 
 	for (; seq <= max_seq; seq++) {
-		int type, zone;
+		int type;
 		int gen = lru_gen_from_seq(seq);
 		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 		seq_printf(m, " %10lu %10u", seq, jiffies_to_msecs(jiffies - birth));
 
 		for (type = 0; type < ANON_AND_FILE; type++) {
-			unsigned long size = 0;
+			unsigned long size = lru_gen_seq_nr_pages(lrugen, gen, type);
 			char mark = full && seq < min_seq[type] ? 'x' : ' ';
 
-			for (zone = 0; zone < MAX_NR_ZONES; zone++)
-				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
-
 			seq_printf(m, " %10lu%c", size, mark);
 		}
 
-- 
2.34.1

