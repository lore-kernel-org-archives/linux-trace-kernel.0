Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904481E0089
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188851; cv=none; b=k9JNrUQLHgmjywnk4jQKDI0VuMjrQ5VaDSmeDbAqvmlhcIgXxPuyhm9VN9wqTR68/1twnJ4LG6DprBqAEvMFZTi16HhXU/6bNzeA0ABhJvwQV249c0KQmIvoVxQLa3AhWCimJi2eYGXmTdL3M3AlaBWkcHyfBxTwYIffp0CHrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188851; c=relaxed/simple;
	bh=Bkxf/s2KVugIM6ypQC9OHaVP5BGsDoJqzVxswBQsqLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZhmrMqEAUvUVoKsjG8Howm8GjbIQKBJqpNMD9pKjn4esQIivzyph0StWmJ/OIHMvty4W22ooVM4QKTsraSWByyd4t9LXb8t+liMP8/IWk52J3Lay8NKqyrunPpCn3Z/XfWD42brlvKG/LAtKt+CvDs3skNwEtqae7xte55FmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cuRuTJaQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cuRuTJaQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729188847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4+EelHK0Kh0nAsHxkJLrbq+zC392Zdrc6//8o5rDy0=;
	b=cuRuTJaQlcgxCM1mjYSkLgff+DNPD8vIUGZcFslEp5RVh5KPhMY2tTOItMrUBAGlS8xlAR
	QCl7EnQF0FNUksuZCqj6bxjZ7CNwTFI5lbBjhi9q6MzbyTaYAnFgXcLzqG+iHTCqzAdQG8
	4T/rHKIw8PRWp93GT9HZhWfE31nC+Zc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] dma-mapping: Trace more error paths
Date: Thu, 17 Oct 2024 14:13:54 -0400
Message-Id: <20241017181354.2834674-4-sean.anderson@linux.dev>
In-Reply-To: <20241017181354.2834674-1-sean.anderson@linux.dev>
References: <20241017181354.2834674-1-sean.anderson@linux.dev>
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

 include/trace/events/dma.h | 41 ++++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c       | 27 +++++++++++++++++--------
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 9bc647f9ad4d..321cce327404 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -161,6 +161,12 @@ DEFINE_EVENT(_dma_alloc, dma_alloc_pages,
 		 unsigned long attrs),
 	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
 
+DEFINE_EVENT(_dma_alloc, dma_alloc_sgt_err,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
+
 TRACE_EVENT(dma_alloc_sgt,
 	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
 		 enum dma_data_direction dir, gfp_t flags, unsigned long attrs),
@@ -325,6 +331,41 @@ TRACE_EVENT(dma_map_sg,
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

