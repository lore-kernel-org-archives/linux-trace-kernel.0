Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236540D599
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051393; cv=none; b=hM/iv1yDFdjhKcepMSeNHvELpf2u0UGYIvhd/ZEfVrgM0Ytn8gFAwTbKrXpTkE1rvsCGGjmc3WaEiNIWyaWP9kBTtigiGJ27GA+OhO5oiKto1mNy5MfcZOeB4b2d6hjGsJqClJ+wEdsDCYzPoP8LLzmZfBM3lcZREZryzZI61Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051393; c=relaxed/simple;
	bh=LHcZsEXdnVHezmSiNhyaOdVrmvBWhcUXgGCQU7gHSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6yYOwhxCRxWKqZ+EdQikx6qpgAHaLFkHmTBpk0LCnvDN4L23Neao9HbftlOUhzTWo2V1iyqi/4am7ad1K6tl1cx2EBRvNHzDxevbSx5yPkaidfmEuNZtqkDK756ZY15ypPt1KiBXFLrn+XJsKpC3pFUmnFtv6pjMR89Dr8EKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k2Ykltry; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2Ykltry"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781051379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n6nRitLA5dXPldaPWFJdkV5WToaQRP9IZnc/9WgQeWE=;
	b=k2YkltryaSxG3AYCOSdIpuXULa3fQ8OUMTERCHllVLhHajWA21GfAKY3mmj4y1OIY0Ll+u
	slAp1PHk4pDzgon8/6fFc2Z1xLfIvaOIPZ0bj/wjj8VBODn21z+8Aod9n4xk4kZzMLMlFT
	NhnyfLkdTaiG95Q8ZhTlOO10X6Mih8o=
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
Subject: [PATCH v2] mm/lruvec: trace LRU add drains
Date: Tue,  9 Jun 2026 17:29:19 -0700
Message-ID: <20260610002919.14102-1-jp.kobryn@linux.dev>
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

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
v2:
  - removed mm_lru_drain_all tracepoint

v1: https://lore.kernel.org/linux-mm/20260609041156.31127-1-jp.kobryn@linux.dev/

 include/trace/events/pagemap.h | 19 +++++++++++++++++++
 mm/swap.c                      |  5 ++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 171524d3526d..fc28745507be 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -77,6 +77,25 @@ TRACE_EVENT(mm_lru_activate,
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
 #endif /* _TRACE_PAGEMAP_H */
 
 /* This part must be outside protection */
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8..8fd6808bfc6e 100644
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
-- 
2.54.0

