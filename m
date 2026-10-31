Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437323;
	b=miAm9TdniYQhq1rxWqIFmiezVRf+HwKZR7uQ4HfRz1aOEgItL64NGSX+gXyP8YNjzrqn
	 gLnMIWNLA1d7p7UekKkAWTzK5fn5TSAzvS/EyQdCeblxkH6UEHZRtbFgWUyYTZ3rqkYy4
	 GWg2OGTPpUSHrfK2LX1gwijf+bTzbgv3Hs0g/mmH03eUI25OqzuYGLAN1uKxJ2Y4UBUhu
	 Ad+KwCOK/WChKFltmram5boUDxgD84zTCPQ5jNeCKyIltxtkA014M/pHcJwMZ0nps1M1U
	 F1+GDZgOH2yl5VZ9fuG3onDuWmCoeRZPblqV+GSHK4c3mVx3wWK7gCgrSVp3lsm8uDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437323;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=olUAZWb4rGnN0WOUAfDAcNNMoLgDIGZnl5od4gLL/8A=;
	b=F91+Un8ZxMeto1ZBQtkNlQgkZmbURmNKUw/73s40LVtbzva1wejPSRmxTv6Zr/g3o60F
	 wcenv5Rg85/Eh0etnxMtm76DdTicq6B026PR5xN/9sGUCY3mX1SiSM6MctShw34VSsCNr
	 cRY1rVXugTR8nzwJv5797IkZM9y74iKVbrQKyLoEcotVxIbox8howKQY4WtuxQvpqWtNo
	 8YxaDpmmsGvrTaxMHfqNDLFursZZ9oNVeW9wvHQDyNv1phZKiuZOdbX9H6lzfZKqXOf4a
	 5STuzH5VU2w38s1KTnZF5uZmbqV7gK6UDK5tluYgaR0msWwQI35rPVkOBEM1/QLrfZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uGbX2OdZ;
	arc=none smtp.remote-ip=95.215.58.110
Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D6606A322
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 09:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 855D6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uGbX2OdZ
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7oaQzh3qIYdYljiSohYitxTlhwMYY+sEAEK75MIPRFw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793437320; v=1; x=1794042120;
 b=uGbX2OdZDDvuT9QNY7AfoBgt6rUlIIG5PSNdObeHyALrAP1okGgWz4f4p4tTlFqHUVD9j1ZG
 WNLlsgtgdqhG2FdFDIK/q1pbYHcHJt4dC+IeeW8D2XxgOoScxqh4x1OtVzHYOKDlGLCVUo/J4NZ
 bShoJ8QG63/QOTYhq/BftB7w=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bda5cc6f278b6035;
	Sat, 31 Oct 2026 09:02:00 +0000
X-Mizu-Trace-ID: bda5cc6f278b6035
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v5 6/6] mm/mglru: add tracepoint for inc_max_seq()
Date: Sat, 31 Oct 2026 17:00:41 +0800
Message-ID: <20261031090041.58574-7-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031090041.58574-1-ridong.chen@linux.dev>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
youngest generation. There is currently no tracepoint on this path, so
the moment a new generation is created, and how the min_seq of each type
trails behind it, cannot be observed as it happens.

Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped while
the lruvec lock is still held, with the node id, memcg id, the new
max_seq, the anon and file min_seq, and the number of pages in each
generation for both types, summed over zones and clamped to >= 0 the
same way the debugfs lru_gen file reports them. The nr_anon/nr_file
arrays are indexed by generation slot, so the emitted max_seq/min_seq
say which slot holds which seq. They are printed with __print_array(),
so the output is hex and its length follows MAX_NR_GENS automatically.

Only the lruvec is passed in; all of the above is collected in
TP_fast_assign(), so inc_max_seq() does no extra work when the event is
disabled. Paired with mm_mglru_scan_folios it makes the full
aging-to-eviction window observable per memcg.

Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 mm/trace_vmscan.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c       |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
index 8148b8224422..cddf42b5849a 100644
--- a/mm/trace_vmscan.h
+++ b/mm/trace_vmscan.h
@@ -456,6 +456,53 @@ TRACE_EVENT(mm_mglru_scan_folios,
 		__entry->min_seq)
 );
 
+TRACE_EVENT(mm_mglru_inc_max_seq,
+
+	TP_PROTO(struct lruvec *lruvec),
+
+	TP_ARGS(lruvec),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(unsigned long, max_seq)
+		__field(unsigned long, anon_min_seq)
+		__field(unsigned long, file_min_seq)
+		__array(unsigned long, nr_anon, MAX_NR_GENS)
+		__array(unsigned long, nr_file, MAX_NR_GENS)
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		struct lru_gen_folio *lrugen = &lruvec->lrugen;
+		int gen, zone;
+
+		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
+		__entry->max_seq = lrugen->max_seq;
+		__entry->anon_min_seq = lrugen->min_seq[LRU_GEN_ANON];
+		__entry->file_min_seq = lrugen->min_seq[LRU_GEN_FILE];
+		/* summed over zones and clamped to >= 0, as debugfs lru_gen does */
+		for (gen = 0; gen < MAX_NR_GENS; gen++) {
+			__entry->nr_anon[gen] = 0;
+			__entry->nr_file[gen] = 0;
+			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
+				__entry->nr_anon[gen] +=
+					max(lrugen->nr_pages[gen][LRU_GEN_ANON][zone], 0L);
+				__entry->nr_file[gen] +=
+					max(lrugen->nr_pages[gen][LRU_GEN_FILE][zone], 0L);
+			}
+		}
+		__entry->nid = lruvec_pgdat(lruvec)->node_id;
+	),
+
+	TP_printk("nid=%d memcg_id=%llu max_seq=%lu anon_min_seq=%lu file_min_seq=%lu nr_anon=%s nr_file=%s",
+		__entry->nid,
+		__entry->memcg_id,
+		__entry->max_seq,
+		__entry->anon_min_seq,
+		__entry->file_min_seq,
+		__print_array(__entry->nr_anon, MAX_NR_GENS, sizeof(unsigned long)),
+		__print_array(__entry->nr_file, MAX_NR_GENS, sizeof(unsigned long)))
+);
 #endif /* CONFIG_LRU_GEN */
 
 TRACE_EVENT(mm_vmscan_write_folio,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ff51fee872f8..24cb2b7779b1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4134,6 +4134,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+
+	trace_mm_mglru_inc_max_seq(lruvec);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
-- 
2.43.0

