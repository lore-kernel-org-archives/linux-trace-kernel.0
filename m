Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D02022D1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263678; cv=none; b=BBc78TIITLZ2hwhZ1aX4BhtxhJ1J4Eff4mTf7lUc7zX+UivH8jIZyQqeCKYszXo035oeKvXurIe3hCG6NG77jU7zOPmo123Irp2eBPV8rXZnUxt/wPUTAVFRwrJp43RPBBSAQNVo3cSdb1yN4AZGEFVaxodNbIzWn08qFE/GYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263678; c=relaxed/simple;
	bh=A3Lz2IfVqiIipQitI8fDEdX8UYcXD7hjFScsNlsiR3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I94M6ifQTMNAuIZCSAVePqaRaAWPNIF+j/01LotOpS9e6k64scHRjs/gG4mNmhUQ69zg/8LY6YGVkKn8z0I9HFyRdFOcbQCEg5Zu6Je7CLNDBkxYQDDq/5oPQCsbPuLxpW6FWNjAAalR+TtMZVHwKRczpHtGlLYlqCjPcIS7a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSps4bNO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSps4bNO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729263674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBJJ7oPpaFz0LR7gPspJ9h0X3KUBu9OIrY8jq+HwuDc=;
	b=NSps4bNOHqkjB+tH585eG40awWL+idXl+7W8kpGcm7qVBQMN75wMIl8rALN1gAPnfr0Tgy
	YUcukIJvMtw89l2IUONyJnXoLVcn6UXZjIjt3EN9Ng4TkoyQvQP9T6VGwsl7I3JcFgY5Fi
	+QyeQI+MUbLK3mLJAIGPTUNe9gI3Svc=
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
Subject: [PATCH v2 4/4] dma-mapping: Trace more error paths
Date: Fri, 18 Oct 2024 11:00:37 -0400
Message-Id: <20241018150036.2878190-5-sean.anderson@linux.dev>
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

It can be surprising to the user if DMA functions are only traced on
success. On failure, it can be unclear what the source of the problem
is. Fix this by tracing all functions even when they fail. Cases where
we BUG/WARN are skipped, since those should be sufficiently noisy
already.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Use macros to define events in a class

 include/trace/events/dma.h | 36 ++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c       | 27 +++++++++++++++++++--------
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 7a9606b8934e..d8ddc27b6a7c 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -156,6 +156,7 @@ DEFINE_EVENT(dma_alloc_class, name, \
 
 DEFINE_ALLOC_EVENT(dma_alloc);
 DEFINE_ALLOC_EVENT(dma_alloc_pages);
+DEFINE_ALLOC_EVENT(dma_alloc_sgt_err);
 
 TRACE_EVENT(dma_alloc_sgt,
 	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
@@ -320,6 +321,41 @@ TRACE_EVENT(dma_map_sg,
 		decode_dma_attrs(__entry->attrs))
 );
 
+TRACE_EVENT(dma_map_sg_err,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
+		 int err, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sgl, nents, err, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, nents)
+		__field(int, err)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->err = err;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s err=%d attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		__entry->err,
+		decode_dma_attrs(__entry->attrs))
+);
+
 TRACE_EVENT(dma_unmap_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir, unsigned long attrs),
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b8a6bc492fae..636dbb0629a4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -223,6 +223,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 				ents != -EIO && ents != -EREMOTEIO)) {
+		trace_dma_map_sg_err(dev, sg, nents, ents, dir, attrs);
 		return -EIO;
 	}
 
@@ -604,20 +605,26 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (WARN_ON_ONCE(flag & __GFP_COMP))
 		return NULL;
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
+	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
+		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
+				DMA_BIDIRECTIONAL, flag, attrs);
 		return cpu_addr;
+	}
 
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_alloc_direct(dev, ops))
+	if (dma_alloc_direct(dev, ops)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
-	else if (use_dma_iommu(dev))
+	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
-	else if (ops->alloc)
+	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
-	else
+	} else {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
 		return NULL;
+	}
 
 	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
 			flag, attrs);
@@ -642,11 +649,11 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	 */
 	WARN_ON(irqs_disabled());
 
-	if (!cpu_addr)
-		return;
-
 	trace_dma_free(dev, cpu_addr, dma_handle, size, DMA_BIDIRECTIONAL,
 		       attrs);
+	if (!cpu_addr)
+		return;
+
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
@@ -688,6 +695,8 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
 				      size, dir, gfp, 0);
 		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
+	} else {
+		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
 	}
 	return page;
 }
@@ -772,6 +781,8 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		sgt->nents = 1;
 		trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
+	} else {
+		trace_dma_alloc_sgt_err(dev, NULL, 0, size, gfp, dir, attrs);
 	}
 	return sgt;
 }
-- 
2.35.1.1320.gc452695387.dirty

