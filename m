Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786226;
	b=IaG7jWRGdOYg/ujiVTDQSmujPvJSKcyZZqoGqsuVbkGq/Cm9IfsIVbTb8AvrmyzWYok6
	 VlaQsI9FPHg2DBKs1Y3hnvSMfncuaf4G0x5GhEtb9ECdD5BQoBAeXy/bq3jEg+mf7dHhR
	 bQOPOX75G7/Er0L0AL+jw4L2x4T3RD+SDY5NFbRAkoziJqw5G92zYryXYgEiEjBxlCX+b
	 VHkEop3ozf9ZHg9T+UUmLnu91+nXYXZ9h4SJvkcoWMOu9ZiQ2O1zpoQ3FJeJdfudS8/aO
	 NXYuq92MiSZleO7/b1HYMZLXgG9kj4hsAs7TJklcDywLf7iPCOUhyW2+f8XnN8vM+NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786226;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Yj/cYH2V4QNf36wK2nXeT6NREFy2vtk6o6Y7I0HUTvw=;
	b=LmxVRZk7G7ymoNlOhBgZnEo9blSr2GKr97NJ/hIUOF+G0Nsh4xgSaNC/rqUr0eZzNKLs
	 o+iwBEk98mLVZeBPpbe+KGQ8sRELYMJ8SoNcLX1biqkfdzql+n2zPNFpbzGe0RHjWwdIL
	 ANCwMH/8YGFzMBN6PbNFhNdrZ04WJxfuv/hUUF2dbJktG57crlsS//HfkjjbplZGJ7Une
	 AxwROBLmz4PT4FfmmLcM0+F8vGz4qbj3s3cQStOOHq49fdFCxiEKIz8zTmyQncyGfbTKF
	 NnbRnj/0lbStvIimWxBAkbuU2t/S/5ZWAulpZQEcSlCMyWWLNHHOkVO5najRGTk6tBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC946606A326;
	Wed,  4 Nov 2026 09:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC946606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5378c9735;
	Wed, 4 Nov 2026 17:56:54 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Nov 2026 17:56:53 +0800
Message-ID: <179378621331.55520.2052332247156241151@stu.pku.edu.cn>
Subject: [PATCH v3] tracing/probes: bound symstr stores to reserved length
In-Reply-To: <179367391951.8187.17152618045554425533@stu.pku.edu.cn>
References: <179367391951.8187.17152618045554425533@stu.pku.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1a5fd79cb03a2kunm548c819715b7cc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHR1DVhgfGBpJTElOHUNMQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTU
	NVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DWZvHNRd4473L4oOwcT7qRJ13ZU4UnQDc7vN2LoWZDnLi1PtJa875Nzs4UY3fAPgzNuUxFzgqUbUK8GvEGRG/gy7dX0oWxGkBLQ1HFm8tb4EIfguhZIaD+h1/amQN4fv1Uq1A5dbh6/ym91IpRu4HXBbZd+bWGUrgLh/gaKdKzs=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=Yj/cYH2V4QNf36wK2nXeT6NREFy2vtk6o6Y7I0HUTvw=;
	h=date:mime-version:subject:message-id:from;

Traceprobe calculates dynamic string sizes before storing the values.  A
probed pointer can change between those passes, so
fetch_store_symstrlen() can reserve space for a short symbol while
fetch_store_symstring() observes a longer one.  The store path then
overwrites the trace record.

Format the symbol into a temporary KSYM_SYMBOL_LEN buffer and copy only
the bytes that fit in the reserved field, including a trailing NUL.
Update __data_loc with the length actually stored so consumers do not
read beyond the truncated value.

Fixes: b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
Changes in v3:
- encode the actual stored length in __data_loc after truncation
- encode a zero length if symbol formatting fails

 kernel/trace/trace_probe_tmpl.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8db12f758fdae..8acc0f0ebd7a6 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -87,15 +87,27 @@ fetch_store_symstrlen(unsigned long addr)
 static nokprobe_inline int
 fetch_store_symstring(unsigned long addr, void *dest, void *base)
 {
+	char namebuf[KSYM_SYMBOL_LEN];
 	int maxlen = get_loc_len(*(u32 *)dest);
 	void *__dest;
+	int len;
 
 	if (unlikely(!maxlen))
 		return -ENOMEM;
 
 	__dest = get_loc_data(dest, base);
+	len = sprint_symbol(namebuf, addr);
+	if (len < 0) {
+		*(u32 *)dest = make_data_loc(0, __dest - base);
+		return 0;
+	}
+
+	len = min(len, maxlen - 1);
+	memcpy(__dest, namebuf, len);
+	((char *)__dest)[len] = '\0';
+	*(u32 *)dest = make_data_loc(len + 1, __dest - base);
 
-	return sprint_symbol(__dest, addr);
+	return len + 1;
 }
 
 /* common part of process_fetch_insn*/
-- 
2.39.5 (Apple Git-154)
