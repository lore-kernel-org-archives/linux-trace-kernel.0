Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E437BE8D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121195; cv=none; b=l+IYHShKHsvdwOusvqfdy91HW6YcqPoLv/zILwIwZ+Q6jyBQACVwSyBb+WFVP+Z++/gUr6tSgkZxapvXcyShBUBmLiGlCpb1J9OQcRSylwqu4xkyXUiA4L2H9fprKVzxLuxo3BvXwLDRd6/0mlVfeoHKBVcYgmvuWTu8MBXbF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121195; c=relaxed/simple;
	bh=PdA92GaxC2iI5xrbQDhqtPgsCnUzs7qU2yK9O87omuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrIj4jlz0l7tViha1IB8KXa/vMTtT0uSgWYy6TBD6B0UVQd/DymLHR582HHXQYzMZ1fEd7eMeGJFoqYZ+VroczSn623qAZPjEUQvjVqpCDil8db8ufxqVDxHu0CWKOXuDxIowJPSIJBEWxMOFM9b6cLYpV1U9DpCAfCqDVEFMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KIT1SxJv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KIT1SxJv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781121180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fFNM+csKuGsAi8zW+tua6hmsF6Jv56ZUXMuPVDdT++g=;
	b=KIT1SxJvnnMM9esD4/wv1ZtvrkIc7so2MoZbLd8fD4HwqlXWLnTI1+chx03t1ehbZlvO7s
	Yb2l8RO/m2g+mbEg2u+yzJJ47onjz5+Z+eevu3UsW0VRqvjJ11JKxC5Wu+YlyBrOosrTTO
	hyNY3tLcrojL03mL86KA6EMszoCnHmQ=
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
Subject: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
Date: Wed, 10 Jun 2026 12:52:20 -0700
Message-ID: <20260610195220.12403-1-jp.kobryn@linux.dev>
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

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 include/trace/events/pagemap.h | 37 ++++++++++++++++++++++++++++++++++
 mm/swap.c                      |  7 ++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 171524d3526d..ff3da07ccb40 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -77,6 +77,43 @@ TRACE_EVENT(mm_lru_activate,
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
+TRACE_EVENT(mm_lru_add_drain_all,
+
+	TP_PROTO(bool force_all_cpus),
+
+	TP_ARGS(force_all_cpus),
+
+	TP_STRUCT__entry(
+		__field(bool,	force_all_cpus	)
+	),
+
+	TP_fast_assign(
+		__entry->force_all_cpus	= force_all_cpus;
+	),
+
+	TP_printk("force_all_cpus=%s",
+		__entry->force_all_cpus ? "true" : "false")
+);
+
 #endif /* _TRACE_PAGEMAP_H */
 
 /* This part must be outside protection */
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8..e14b7612f896 100644
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
@@ -869,6 +872,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
+	trace_mm_lru_add_drain_all(force_all_cpus);
+
 	/*
 	 * Guarantee folio_batch counter stores visible by this CPU
 	 * are visible to other CPUs before loading the current drain
-- 
2.54.0

