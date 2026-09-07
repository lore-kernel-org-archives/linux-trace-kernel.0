Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5922DC79F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755137; cv=none; b=ldpGSyprrQBTUcW0NBDdFB1MhPsSbqlP0E8hMm14IHPgR62uItCJQcD2aLV3CiPJNDSinWb8ggt8Tl103MPhyUdkVFUa7TALcY2iQUnT28jX8jRErlNHJ/Lw8i52UMmHMtLhcPzwTFNRNx1t7hMyZhBxvLIsqMEWoHY8ITjKqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755137; c=relaxed/simple;
	bh=mK2et90Pf4XLD3r0uXRQiTeVcL8gxLH+/TQolfNphI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFt7scywBbQaPPoqR3i5LNeCvSPYV1+nyLakctuGf/UO4ZcH8lMFqhrG1RYPB1upqHwj2ulikAC+ZUSlLzFJdm4UK3+y+DvxIPOfgTe996fHVREAnK9sVGDHXNntebjl1yzKKVdq5Ma1+2hoPvvv3CiXmZQc/cKp5B1QG4GdKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTYxUOTX; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTYxUOTX"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mK2et90Pf4XLD3r0uXRQiTeVcL8gxLH+/TQolfNphI4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788755134; v=1; x=1789359934;
 b=JTYxUOTXL1GOPawvOBiUf4pkF8n5ytKR22NHEzOCgWUj42zFrqOXedAn0vV6rG+yJwu3I1Wj
 P9emkQj7WgF9S/c58Hx8TRX49KFPrj2r2RwdezQAw8NyVjU45iIAxVl7IMeElZBS5OjHb7Wly9m
 Yh8mFhAud2C9m7BYBP+BLtRE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f2e3209ee265622f;
	Mon, 07 Sep 2026 04:25:33 +0000
X-Mizu-Trace-ID: f2e3209ee265622f
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
Subject: [PATCH RFC 2/2] mm/mglru: add tracepoint for inc_max_seq
Date: Mon,  7 Sep 2026 12:24:47 +0800
Message-Id: <20260907042447.2450663-3-ridong.chen@linux.dev>
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

Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
youngest generation. There is currently no tracepoint on this path, so
the moment a new generation is created, and how the min_seq of each type
trails behind it, cannot be observed as it happens.

Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped, with
the memcg id and the new max_seq alongside the anon and file min_seq.
Paired with the mm_mglru_isolate_folios tracepoint it makes the full
aging-to-eviction window observable per memcg.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 include/trace/events/vmscan.h | 30 ++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a0e3cf75294b..ab93c2f4b318 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -439,6 +439,36 @@ TRACE_EVENT(mm_mglru_isolate_folios,
 		__entry->max_seq)
 );
 
+TRACE_EVENT(mm_mglru_inc_max_seq,
+
+	TP_PROTO(u64 memcg_id,
+		unsigned long max_seq,
+		unsigned long anon_min_seq,
+		unsigned long file_min_seq),
+
+	TP_ARGS(memcg_id, max_seq, anon_min_seq, file_min_seq),
+
+	TP_STRUCT__entry(
+		__field(u64, memcg_id)
+		__field(unsigned long, max_seq)
+		__field(unsigned long, anon_min_seq)
+		__field(unsigned long, file_min_seq)
+	),
+
+	TP_fast_assign(
+		__entry->memcg_id = memcg_id;
+		__entry->max_seq = max_seq;
+		__entry->anon_min_seq = anon_min_seq;
+		__entry->file_min_seq = file_min_seq;
+	),
+
+	TP_printk("memcg_id=%llu max_seq=%lu anon_min_seq=%lu file_min_seq=%lu",
+		__entry->memcg_id,
+		__entry->max_seq,
+		__entry->anon_min_seq,
+		__entry->file_min_seq)
+);
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 771fe6827939..3c806a57d113 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4065,6 +4065,10 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+	trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
+				   lrugen->max_seq,
+				   lrugen->min_seq[LRU_GEN_ANON],
+				   lrugen->min_seq[LRU_GEN_FILE]);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
-- 
2.34.1

