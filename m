Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5E33123D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154325; cv=none; b=dsd/NjWBIITx74YvrNUBSEkFsNqR1pRjcMlSpjt/4qKvpXt1k7HA0CbsQe5AzY9C7dOOHWQt8DGvPZy7T+DRcrD9n1a5VT2rjZ00FjlgtkJexzFdMnRqFPZMTIikCH4EE7cgIbY4kHsN4bi+bBh6WVf7ZwTc2+kcf65VCA/Bawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154325; c=relaxed/simple;
	bh=cquM22kQ1qwztn9LoA0LACh6bK4Sgp7dDbVzAOSs540=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZEaaLrWoRIr7hUgsug4gpIr/Aja1SRBKO1PGxWQ7f15ZNPNxnAixofM7RI4j2ynt6aJGzCpbNFRjShoc3YeRF6D26SQMhA696I0RuKkrsCMkXAWHjTfxGJDLzjpR533/Z8HvA5pBeAql5tvq5UXRuQ36JB8q24bSxIbEzYexmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQ5UmGuH; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQ5UmGuH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782154311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P2FntB3QrBOJu+PV6zq+MqWBctOWxjgmfPOSEN+T8fQ=;
	b=LQ5UmGuHzFWHqd4GHfy0JN96cJGwdY/deLgob6tnNEhffHniusw8d7dZWRP4O+D7ueXhqo
	saP0kl8mWM9szfoXk82w7rja1AKDf7JQnoge7BEACXrcmH6IDhOC6XNsL11Sh7ipaYm+9p
	Qo+lpUJuO2M0jG8xOjGMd2NExehc6rI=
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
Subject: [PATCH v5] mm/lruvec: trace LRU add drains and drain-all requests
Date: Mon, 22 Jun 2026 11:51:27 -0700
Message-ID: <20260622185127.24579-1-jp.kobryn@linux.dev>
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

Add mm_lru_add_drain_all to capture callers of __lru_add_drain_all and
whether they set the force flag for all CPUs. The tracepoint resembles
the signature of the enclosing function, but is needed because of
potential inlining.

Note that DECLARE_TRACE() is used for these new trace hooks to avoid
creating a new trace event ABI.

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v5:
  - change from trace events to bare trace hooks

v4: https://lore.kernel.org/linux-mm/20260610234808.212397-1-jp.kobryn@linux.dev/
  - renamed nr_folio_add to nr_folios in lru_add_drain()
  - renamed nr to nr_folios in tracepoint for consistency

v3: https://lore.kernel.org/linux-mm/20260610195220.12403-1-jp.kobryn@linux.dev/
  - restored and renamed tracepoint in __lru_add_drain_all

v2: https://lore.kernel.org/linux-mm/20260609041156.31127-1-jp.kobryn@linux.dev/
  - removed mm_lru_drain_all tracepoint

v1: https://lore.kernel.org/linux-mm/20260609041156.31127-1-jp.kobryn@linux.dev/

 include/trace/events/pagemap.h | 8 ++++++++
 mm/swap.c                      | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 171524d3526d..36c3a90f0acc 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -77,6 +77,14 @@ TRACE_EVENT(mm_lru_activate,
 	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
 );
 
+DECLARE_TRACE(mm_lru_add_drain,
+	      TP_PROTO(int cpu, unsigned int nr_folios),
+	      TP_ARGS(cpu, nr_folios));
+
+DECLARE_TRACE(mm_lru_add_drain_all,
+	      TP_PROTO(bool force_all_cpus),
+	      TP_ARGS(force_all_cpus));
+
 #endif /* _TRACE_PAGEMAP_H */
 
 /* This part must be outside protection */
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8..460e56370b3c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
 {
 	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
 	struct folio_batch *fbatch = &fbatches->lru_add;
+	unsigned int nr_folios = folio_batch_count(fbatch);
 
-	if (folio_batch_count(fbatch))
+	if (nr_folios) {
 		folio_batch_move_lru(fbatch, lru_add);
+		trace_mm_lru_add_drain_tp(cpu, nr_folios);
+	}
 
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
@@ -869,6 +872,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
+	trace_mm_lru_add_drain_all_tp(force_all_cpus);
+
 	/*
 	 * Guarantee folio_batch counter stores visible by this CPU
 	 * are visible to other CPUs before loading the current drain
-- 
2.54.0

