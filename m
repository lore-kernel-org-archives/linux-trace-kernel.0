Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496D448CE6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111784; cv=none; b=jKrK6KV8C0xk3USUy3yeu0zCCbzIzJj+gbtvU5ejMN8I4aZdi6SI1yalYc02hy3jfcTlP/SuoPdlnZ5l+ufnBGq78Nmnr7eMQSib2IGItmvQIGwbbhLif6o+e+nq52KZsAbL5INTXmEa1eQLnmI56r1GrOpsDmJ+uSorQw2UDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111784; c=relaxed/simple;
	bh=FpcPo83nhWnkkp6me6q/GY/YfYdp1OKd5imnFWeXBLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXHGT9SUgKxEh/R98q9P/KaWurBPlf1PG487bGDcgrvi2N4FOLkD+gS9OhOB6CT7T8tet0/2EvirHC61Mi4rilg/kW6wFKWL+e0zzVAS7UuKx0EyeEyI3MVdxMe70Zxk0QQYmIYLtB3f5nhoyYeRx4w0KZElWN92tbuQEzycc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1tsNtNW; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1tsNtNW"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FpcPo83nhWnkkp6me6q/GY/YfYdp1OKd5imnFWeXBLg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789111780; v=1; x=1789716580;
 b=C1tsNtNWOICb2y94PHvNp02pWal59w3l81qylbVBR7bTe7+LLoYcYZ1F8VZzQy6v58XjJ2CL
 k9hi5qfwXgetgx1sSf4ZPncgPj+gwXOPaE3HASs7mATvmk6knR2yHDwhHgDvR/7/MSJ4JKo0+Kg
 Izks7hAkpt4xfZ8c9Zqbqjkw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b9bafcc2d8f444;
	Fri, 11 Sep 2026 07:29:40 +0000
X-Mizu-Trace-ID: a8b9bafcc2d8f444
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
Subject: [PATCH 3/3] mm/mglru: add tracepoint for inc_max_seq()
Date: Fri, 11 Sep 2026 15:28:48 +0800
Message-Id: <20260911072848.2346073-4-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911072848.2346073-1-ridong.chen@linux.dev>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
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
 mm/vmscan.c                   | 22 ++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index c39dfacef033..9cf3f4564afb 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -455,6 +455,44 @@ TRACE_EVENT(mm_mglru_scan_folios,
 		__entry->min_seq)
 );
 
+TRACE_EVENT(mm_mglru_inc_max_seq,
+
+	TP_PROTO(u64 memcg_id,
+		unsigned long max_seq,
+		unsigned long anon_min_seq,
+		unsigned long file_min_seq,
+		unsigned long *nr_anon,
+		unsigned long *nr_file),
+
+	TP_ARGS(memcg_id, max_seq, anon_min_seq, file_min_seq, nr_anon, nr_file),
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
+		__entry->memcg_id = memcg_id;
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
index bd1b9ecf2e84..d0e59baf5d5c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4100,6 +4100,26 @@ static void try_to_inc_min_seq(struct lruvec *lruvec, int swappiness)
 	}
 }
 
+static void trace_inc_max_seq(struct lruvec *lruvec)
+{
+	int type, gen;
+	unsigned long nr[ANON_AND_FILE][MAX_NR_GENS];
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+
+	if (!trace_mm_mglru_inc_max_seq_enabled())
+		return;
+
+	for (type = 0; type < ANON_AND_FILE; type++)
+		for (gen = 0; gen < MAX_NR_GENS; gen++)
+			nr[type][gen] = lru_gen_seq_nr_pages(lrugen, gen, type);
+
+	trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
+				   lrugen->max_seq,
+				   lrugen->min_seq[LRU_GEN_ANON],
+				   lrugen->min_seq[LRU_GEN_FILE],
+				   nr[LRU_GEN_ANON], nr[LRU_GEN_FILE]);
+}
+
 static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness)
 {
 	bool success;
@@ -4159,6 +4179,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+
+	trace_inc_max_seq(lruvec);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
-- 
2.34.1

