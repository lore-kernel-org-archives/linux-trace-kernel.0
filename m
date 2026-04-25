Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF72175A70;
	Sat, 25 Apr 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108453; cv=none; b=HAFWyU74X/rJpbr+bDerZeubCsnKg1W4Q6YetRRVFxopWRCnlNjc9+8mUBOubcyWbLfarXmrDDI/uNVIJ0bqSyebdFimvIa5caVeMRFjW4Gf6tSV1OTPN8dIRynN9igaX6WsuGOFoTX6qRfHP5V5WhMvhdepWsyMxNzyNQd6zQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108453; c=relaxed/simple;
	bh=0o9y/jPA68LJvW1ebkXs+XPjp5lX/gb5yWnx4ETqriI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0PGKw3T3jyz3amCVBJsAwvGgxSxqrcEmrnIqjg0CNTu6sdsbjUVBI2SbopoIYz0aZET6wnOoNp3NCjKjxjJZfSnzqSYIcXWQKVsE7xnmEZ5sG51qKrehWzHRILXSqxh0n424TegzWv5A9TrWEarhBKVK3k4Z5CdHs7CLDQ3MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=LGwCbYzK; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="LGwCbYzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1777108440;
	bh=0o9y/jPA68LJvW1ebkXs+XPjp5lX/gb5yWnx4ETqriI=;
	h=From:To:Cc:Subject:Date;
	b=LGwCbYzKUoeAO2Dnv7Fkazn0dJBNNX1Ct6+9tB0o/cc9yIwkA2/hhtq59U2F+VQlX
	 WY/4vnC/OsB8VEwhpSlz1r/GZj/RZNKHbSGB7uyFFX8l9rI5ljHdi99g1XHIt5erCU
	 xurUgLjlRWB1xBqvzpNs2g0RDnS64wW8FflCYL/blvnlV65IuSPTE5Xii9ihNN3wEu
	 wroYn5F9NjSBXPrZLRgttFrmVlHK27i6Ru22ly7fhyg0TZGadbdUIKauDJmFakLLow
	 tz4XmndOKX2jcDvh27nir1SwuylJsQHDhc5Gk9xcPUcyzjSTF4PEYx6ap/zdfqGYuN
	 qBqvu08HtyCTw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 84E2E2FF4E5;
	Sat, 25 Apr 2026 09:14:00 +0000 (UTC)
Received: from dynamic.ipv6.sjtu.edu.cn (unknown [10.180.122.86])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id EFE6337C921;
	Sat, 25 Apr 2026 17:13:59 +0800 (CST)
From: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
To: akpm@linux-foundation.org,
	vbabka@kernel.org,
	linux-mm@kvack.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
Subject: [PATCH] mm/page_alloc: add tracepoint for PCP refills
Date: Sat, 25 Apr 2026 17:13:35 +0800
Message-ID: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page allocator already has mm_page_pcpu_drain to trace pages
drained from the per-cpu page lists back to the buddy allocator. There
is no matching tracepoint for the opposite direction, where
rmqueue_bulk() refills a PCP list from the buddy allocator.

mm_page_alloc_zone_locked is not a good substitute for this. It is
emitted from __rmqueue_smallest(), which is used both by rmqueue_bulk()
and by the direct buddy allocation path. Its percpu_refill field is
derived from the allocation order and migratetype, so it does not
reliably identify whether the allocation came from a PCP refill.

Add mm_page_pcpu_refill and emit it from rmqueue_bulk() for each page
added to the PCP list. The new tracepoint uses the same page, order and
migratetype fields as mm_page_pcpu_drain, making refill and drain
activity directly comparable.

Signed-off-by: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
---
 include/trace/events/kmem.h | 23 +++++++++++++++++++++++
 mm/page_alloc.c             |  1 +
 2 files changed, 24 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index cd7920c81f85..16985604fc51 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -243,6 +243,29 @@ DEFINE_EVENT(mm_page, mm_page_alloc_zone_locked,
 	TP_ARGS(page, order, migratetype, percpu_refill)
 );
 
+TRACE_EVENT(mm_page_pcpu_refill,
+
+	TP_PROTO(struct page *page, unsigned int order, int migratetype),
+
+	TP_ARGS(page, order, migratetype),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	pfn		)
+		__field(	unsigned int,	order		)
+		__field(	int,		migratetype	)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
+		__entry->order		= order;
+		__entry->migratetype	= migratetype;
+	),
+
+	TP_printk("page=%p pfn=0x%lx order=%d migratetype=%d",
+		pfn_to_page(__entry->pfn), __entry->pfn,
+		__entry->order, __entry->migratetype)
+);
+
 TRACE_EVENT(mm_page_pcpu_drain,
 
 	TP_PROTO(struct page *page, unsigned int order, int migratetype),
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65e205111553..a60b73ed39a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2544,6 +2544,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
+		trace_mm_page_pcpu_refill(page, order, migratetype);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-- 
2.53.0

