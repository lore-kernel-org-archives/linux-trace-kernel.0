Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCF1397
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Jan 2026 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767334699; cv=none; b=lPvhUCi5l0Am/DYxbJawtdXt3Z3giaIq6qSJhwqzlfrhxNPRX8CxQXlg+XFTQWIM/hKmSgWbQI3dEC+2VTbEmwm/8SwGBdOmlCOMlPr7RCgMp0N8cb60WM17hgJ9LMu3oaj5aurRPOGWx89x9BNAGQwzoSQZGDcf+evsh7ItYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767334699; c=relaxed/simple;
	bh=rvVUTxI3sl/dBrj9ZY9pXH6xhKb5bAk61+SpRF95xos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmucweBtDrAe2iRfox+pLYxRBkgHz0ypN3P22LUBfbNBX/JG3OqmGJBUey03Ra51AQ7RXoBwtxsqoFHe0P+dxxPf5U5tk1O4Be5hx1wljdCu9vgulMDd6E3qagfwICdvp5Cfzleg2ECsP45ffcM4K+7uphW01uEHihkvgSzhHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hy7dwZk0; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hy7dwZk0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767334683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wIgtotwjXNQ9yqFMyPJfsL0psaFasUQk+W6358KND8c=;
	b=Hy7dwZk0P0FYPxT4jmdk5pOT2DvnnqliJSn1wK0MzHHZf+9ZNURW07+EXtHYhVrBfSLfDh
	1BM9CwW+tcI4sRfVBswpoKmwjW6YkvCfwc5NM6HhICG5ZfI4zxO0cIAB/Z3YxOCBQ+vHBS
	69WqXfx8HcaYh3bt8xLKHq/+Zu79D8Y=
From: Leon Hwang <leon.hwang@linux.dev>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kerneljasonxing@gmail.com,
	lance.yang@linux.dev,
	jiayuan.chen@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Leon Huang Fu <leon.huangfu@shopee.com>
Subject: [PATCH net-next v2] page_pool: Add page_pool_release_stalled tracepoint
Date: Fri,  2 Jan 2026 14:17:18 +0800
Message-ID: <20260102061718.210248-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a new tracepoint to track stalled page pool releases,
providing better observability for page pool lifecycle issues.

Problem:
Currently, when a page pool shutdown is stalled due to inflight pages,
the kernel only logs a warning message via pr_warn(). This has several
limitations:

1. The warning floods the kernel log after the initial DEFER_WARN_INTERVAL,
   making it difficult to track the progression of stalled releases
2. There's no structured way to monitor or analyze these events
3. Debugging tools cannot easily capture and correlate stalled pool
   events with other network activity

Solution:
Add a new tracepoint, page_pool_release_stalled, that fires when a page
pool shutdown is stalled. The tracepoint captures:
- pool: pointer to the stalled page_pool
- inflight: number of pages still in flight
- sec: seconds since the release was deferred

The implementation also modifies the logging behavior:
- pr_warn() is only emitted during the first warning interval
  (DEFER_WARN_INTERVAL to DEFER_WARN_INTERVAL*2)
- The tracepoint is fired always, reducing log noise while still
  allowing monitoring tools to track the issue

This allows developers and system administrators to:
- Use tools like perf, ftrace, or eBPF to monitor stalled releases
- Correlate page pool issues with network driver behavior
- Analyze patterns without parsing kernel logs
- Track the progression of inflight page counts over time

Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v1 -> v2:
 - Drop RFC.
 - Store 'pool->user.id' to '__entry->id' (per Steven Rostedt).
 - https://lore.kernel.org/netdev/20251125082207.356075-1-leon.hwang@linux.dev/
---
 include/trace/events/page_pool.h | 24 ++++++++++++++++++++++++
 net/core/page_pool.c             |  6 ++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 31825ed30032..c34de6a5ae80 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -113,6 +113,30 @@ TRACE_EVENT(page_pool_update_nid,
 		  __entry->pool, __entry->pool_nid, __entry->new_nid)
 );
 
+TRACE_EVENT(page_pool_release_stalled,
+
+	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
+
+	TP_ARGS(pool, inflight, sec),
+
+	TP_STRUCT__entry(
+		__field(const struct page_pool *, pool)
+		__field(u32,			  id)
+		__field(int,			  inflight)
+		__field(int,			  sec)
+	),
+
+	TP_fast_assign(
+		__entry->pool		= pool;
+		__entry->id		= pool->user.id;
+		__entry->inflight	= inflight;
+		__entry->sec		= sec;
+	),
+
+	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
+		  __entry->pool, __entry->id, __entry->inflight, __entry->sec)
+);
+
 #endif /* _TRACE_PAGE_POOL_H */
 
 /* This part must be outside protection */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb..01564aa84c89 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1222,8 +1222,10 @@ static void page_pool_release_retry(struct work_struct *wq)
 	    (!netdev || netdev == NET_PTR_POISON)) {
 		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
 
-		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
-			__func__, pool->user.id, inflight, sec);
+		if (sec >= DEFER_WARN_INTERVAL / HZ && sec < DEFER_WARN_INTERVAL * 2 / HZ)
+			pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
+				__func__, pool->user.id, inflight, sec);
+		trace_page_pool_release_stalled(pool, inflight, sec);
 		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
 	}
 
-- 
2.52.0

