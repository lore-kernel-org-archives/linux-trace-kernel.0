Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86439DBE9;
	Tue, 30 Jun 2026 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849642; cv=none; b=Onv8hPk76/2X3a/inJU87ttMsFW/TURGH3je/1IbxO9KOl++uvMAJKVVAKT22MJaYlFJqtzs2BGDFKC3uvuYdKrgBGotfJIaqiYkhe4Ck2g2g6GFO/ZJSr2rkLDem+ZaKeUl/NSbtuOKta1RCXZGJ9uo8c9v9TWVT+EsH6BKwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849642; c=relaxed/simple;
	bh=D3Y55NQcFxqGkbe5kqmU6GpsSL8YwbnDASIQLku/BIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QU+T0t4G2YPMM+CXz9M1tOWoBGW5T0ucrKeDozjFgYLMDFrASzdLAu8sWmKxdlQLv0TiI66JqdKA5uAX0aO1mV5i/nGSDEIicHUU8yA7y95j0ivAFhwZuo+LvGFIpLk6vS0WRkHZvXFpsGZy8M3XfAZF6gug2pprnqlZ84rvEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1weedH-00000000LCC-0iJs;
	Tue, 30 Jun 2026 22:00:35 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Date: Tue, 30 Jun 2026 22:00:11 +0200
Message-ID: <20260630200022.1826420-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsl edma events store a pointer to a struct fsl_edma_engine in the
ringbuffer and dereference it when a log entry is printed. At this time,
the pointer may no longer be valid.

Event injection can be used to trigger a crash:

$ cd /sys/kernel/tracing
$ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
$ cat trace

The log output needs only edma->membase. Add a membase field at the end
of the event and use the new field for log output. Keep the existing
fields for backward compatibility.

Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/dma/fsl-edma-trace.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
index d3541301a247..45d964a3726d 100644
--- a/drivers/dma/fsl-edma-trace.h
+++ b/drivers/dma/fsl-edma-trace.h
@@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
 		__field(struct fsl_edma_engine *, edma)
 		__field(void __iomem *, addr)
 		__field(u32, value)
+		__field(void __iomem *, membase)
 	),
 	TP_fast_assign(
 		__entry->edma = edma;
 		__entry->addr = addr;
 		__entry->value = value;
+		__entry->membase = edma->membase;
 	),
 	TP_printk("offset %08x: value %08x",
-		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+		(u32)(__entry->addr - __entry->membase), __entry->value)
 );
 
 DEFINE_EVENT(edma_log_io, edma_readl,
-- 
2.43.7

