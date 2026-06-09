Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1E31E82A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978365; cv=none; b=IRpPMEdUbpoiPfhcOGDmaMOhdrgc+mlxp+Z4Q3TmQZKX3I5wUGfLUawC1pz6rPslxcnX+o4mkOE9tSXUSwfcaBcAyCVGeeN0QgjN3mGNODpesEI62rTG2S7aTwXAN2PPKLyaCwVGHaNDAih9CjUqIr/I7ZG7orqO+4F2Rbw/tqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978365; c=relaxed/simple;
	bh=D8oGT5zf8p6nYrA8iMJLArWNCMyBT/0Rc1Un8hcXe40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fekMAQNSmLMLowhb1tFeF54krGznpxK7khPehFNfM7G1NK9OkZVviAJO5OEI9LixzISJ6e6i4mDV/hyp0Li3x/nbq73lkkHUsbZLhp0K8vdgFcKBcxujSh6Ewei6/yOL6MYG4q6KiAo4DkDyjjt8d3JCa8hp2yFE+07VphPAOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JZ1T1k9d; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JZ1T1k9d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780978361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4h6x44t/kUL5SJGKCThKAyRtoW9WrlvFmr2fXLO09kY=;
	b=JZ1T1k9dmfNfGxSCYXOE5B1BNYHUXaoBZFJM7tL5++Ew64OXoBMeebrwgAbt2wTLRUqGDP
	QvS/wtp+R9YSs7rg4JVmPaj+/Ev64gd+FXdmJV4LY2gNE9MRq4J9OkXPquGoTZew1+bs2l
	iuqJkMfsYm/i8jxh0QxrcwvENfug+D4=
From: JP Kobryn <jp.kobryn@linux.dev>
To: linux-mm@kvack.org,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	usama.arif@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	youngjun.park@lge.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
Date: Mon,  8 Jun 2026 21:11:56 -0700
Message-ID: <20260609041156.31127-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

LRU add batches can be drained before they reach capacity. This can be a
source of LRU lock contention, but it is not currently possible to
attribute these drains to callers with existing tracepoints.

Add mm_lru_add_drain to report the CPU and lru_add batch count when an
lru_add batch is drained. This allows tracing to distinguish full drains
from partial drains and attribute them to the calling stack.

Add mm_lru_drain_all_queue to report when lru_add_drain_all() queues
per-CPU drain work. This captures the requester stack and target CPU for
remote drain work. The event is named as a drain-all queue event because
the queued work can be needed for batches other than lru_add.

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 include/trace/events/pagemap.h | 40 ++++++++++++++++++++++++++++++++++
 mm/swap.c                      |  6 ++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 171524d3526d..ea8fc46bedb0 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -77,6 +77,46 @@ TRACE_EVENT(mm_lru_activate,
 	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
 );
 
+TRACE_EVENT(mm_lru_add_drain,
+
+	TP_PROTO(int cpu, unsigned int nr),
+
+	TP_ARGS(cpu, nr),
+
+	TP_STRUCT__entry(
+		__field(int,		cpu	)
+		__field(unsigned int,	nr	)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->nr	= nr;
+	),
+
+	TP_printk("cpu=%d nr=%u", __entry->cpu, __entry->nr)
+);
+
+TRACE_EVENT(mm_lru_drain_all_queue,
+
+	TP_PROTO(int target_cpu, bool force_all_cpus),
+
+	TP_ARGS(target_cpu, force_all_cpus),
+
+	TP_STRUCT__entry(
+		__field(int,	target_cpu	)
+		__field(bool,	force_all_cpus	)
+	),
+
+	TP_fast_assign(
+		__entry->target_cpu	= target_cpu;
+		__entry->force_all_cpus	= force_all_cpus;
+	),
+
+	TP_printk("target_cpu=%d force_all_cpus=%s",
+		__entry->target_cpu,
+		__entry->force_all_cpus ? "true" : "false")
+);
+
 #endif /* _TRACE_PAGEMAP_H */
 
 /* This part must be outside protection */
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8..c385b93582eb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
 {
 	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
 	struct folio_batch *fbatch = &fbatches->lru_add;
+	unsigned int nr_folios_add = folio_batch_count(fbatch);
 
-	if (folio_batch_count(fbatch))
+	if (nr_folios_add) {
 		folio_batch_move_lru(fbatch, lru_add);
+		trace_mm_lru_add_drain(cpu, nr_folios_add);
+	}
 
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
@@ -928,6 +931,7 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 		if (cpu_needs_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
+			trace_mm_lru_drain_all_queue(cpu, force_all_cpus);
 			__cpumask_set_cpu(cpu, &has_work);
 		}
 	}
-- 
2.54.0

