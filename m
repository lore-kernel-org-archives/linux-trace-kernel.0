Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC481D7989
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263672; cv=none; b=ZdNRBDB+Z9zx71sqVD4m3OK4xiA5Cx++e9hj87AfdqEFuhcnuHZTkq1UB7nwlexuBCsRQK4mB+Qt76fTBpHwhcSCpBt+Rq4wS/OCf+csO255x8SsekR9ZEP+Ki/hiS0UJiT5Dqw3P8nYExtamsXQc24zgRKt4aJ1Yv4icMpcbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263672; c=relaxed/simple;
	bh=7ZpSoewhKU7eN4frzrDG+nKfoYaE4waFluXDMv9yrEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhUECY3JGhBWG6q9oKcwfzdcBUMicSLxEmXgch+J59r0qLCsXXoGm145zdeVKX2vetPBMNSv36wwKKSpPuUzCqrV+6N8Ii3q+oszIZogMa4+j5/RFJRwgi4F5kSCgd1iTSwNb300kctn7ReMRlhh08S3aSV8kREd+A3pX7CDeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQ5e+kKl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQ5e+kKl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729263668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ydd5/5k0GyzrDpIcMZoEJ/GlEO8PTBGwqqIyFBsrzJU=;
	b=AQ5e+kKlXfWgQ+4/9Qe5hKblGe0DBFgg0bHn+PuSb+c3ScIazmYfJik0xHBLc4vLDav9Na
	hZXEkGx89tT5pElf2ueAxaFrFdDknkVHsAPDC8N6BLT/FUxRNJM+zN3cdaxb3qBgGUtkAy
	bH7xvgYmroXdZstnQTMA5NtvUOopsWw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 1/4] dma-mapping: Use macros to define events in a class
Date: Fri, 18 Oct 2024 11:00:34 -0400
Message-Id: <20241018150036.2878190-2-sean.anderson@linux.dev>
In-Reply-To: <20241018150036.2878190-1-sean.anderson@linux.dev>
References: <20241018150036.2878190-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use a macro to avoid repeating the parameters and arguments for each event
in a class.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 include/trace/events/dma.h | 60 ++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b0f41265191c..3d348cea4d7c 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -65,15 +65,14 @@ DECLARE_EVENT_CLASS(dma_map,
 		decode_dma_attrs(__entry->attrs))
 );
 
-DEFINE_EVENT(dma_map, dma_map_page,
-	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
-		 size_t size, enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+#define DEFINE_MAP_EVENT(name) \
+DEFINE_EVENT(dma_map, name, \
+	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr, \
+		 size_t size, enum dma_data_direction dir, unsigned long attrs), \
+	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs))
 
-DEFINE_EVENT(dma_map, dma_map_resource,
-	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
-		 size_t size, enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs));
+DEFINE_MAP_EVENT(dma_map_page);
+DEFINE_MAP_EVENT(dma_map_resource);
 
 DECLARE_EVENT_CLASS(dma_unmap,
 	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
@@ -104,15 +103,14 @@ DECLARE_EVENT_CLASS(dma_unmap,
 		decode_dma_attrs(__entry->attrs))
 );
 
-DEFINE_EVENT(dma_unmap, dma_unmap_page,
-	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
-		 enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, addr, size, dir, attrs));
+#define DEFINE_UNMAP_EVENT(name) \
+DEFINE_EVENT(dma_unmap, name, \
+	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size, \
+		 enum dma_data_direction dir, unsigned long attrs), \
+	TP_ARGS(dev, addr, size, dir, attrs))
 
-DEFINE_EVENT(dma_unmap, dma_unmap_resource,
-	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
-		 enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, addr, size, dir, attrs));
+DEFINE_UNMAP_EVENT(dma_unmap_page);
+DEFINE_UNMAP_EVENT(dma_unmap_resource);
 
 TRACE_EVENT(dma_alloc,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
@@ -279,15 +277,14 @@ DECLARE_EVENT_CLASS(dma_sync_single,
 		__entry->size)
 );
 
-DEFINE_EVENT(dma_sync_single, dma_sync_single_for_cpu,
-	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction dir),
-	TP_ARGS(dev, dma_addr, size, dir));
+#define DEFINE_SYNC_SINGLE_EVENT(name) \
+DEFINE_EVENT(dma_sync_single, name, \
+	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size, \
+		 enum dma_data_direction dir), \
+	TP_ARGS(dev, dma_addr, size, dir))
 
-DEFINE_EVENT(dma_sync_single, dma_sync_single_for_device,
-	TP_PROTO(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction dir),
-	TP_ARGS(dev, dma_addr, size, dir));
+DEFINE_SYNC_SINGLE_EVENT(dma_sync_single_for_cpu);
+DEFINE_SYNC_SINGLE_EVENT(dma_sync_single_for_device);
 
 DECLARE_EVENT_CLASS(dma_sync_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
@@ -326,15 +323,14 @@ DECLARE_EVENT_CLASS(dma_sync_sg,
 				sizeof(unsigned int), sizeof(unsigned int)))
 );
 
-DEFINE_EVENT(dma_sync_sg, dma_sync_sg_for_cpu,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
-		 enum dma_data_direction dir),
-	TP_ARGS(dev, sg, nents, dir));
+#define DEFINE_SYNC_SG_EVENT(name) \
+DEFINE_EVENT(dma_sync_sg, name, \
+	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents, \
+		 enum dma_data_direction dir), \
+	TP_ARGS(dev, sg, nents, dir))
 
-DEFINE_EVENT(dma_sync_sg, dma_sync_sg_for_device,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
-		 enum dma_data_direction dir),
-	TP_ARGS(dev, sg, nents, dir));
+DEFINE_SYNC_SG_EVENT(dma_sync_sg_for_cpu);
+DEFINE_SYNC_SG_EVENT(dma_sync_sg_for_device);
 
 #endif /*  _TRACE_DMA_H */
 
-- 
2.35.1.1320.gc452695387.dirty

