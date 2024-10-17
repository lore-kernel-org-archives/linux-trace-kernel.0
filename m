Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851B1E009D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188851; cv=none; b=Z1TQ9s2M/XCW53+i129Q598/5ssyHgb3XyhLkfZ18Dw7txjpotiyqWE4oFHpkGJF8PCsTSXU0jjDqbimCuTX0O+hcrj/M6vy07m8JwPUK6Fef2rbjYDDhtgiqFX9hYwByttHlNzRuLQi0AW726ue8NCIMO4La5Q9hvKA7PJLjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188851; c=relaxed/simple;
	bh=uA8a1ikplMyqr+uLsKVt9H+ZhJSzfwtxijknmp+of3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWM5Ij+hdOFp9IwOay6BFxlCcZkeUtsl8BBLBF60w7zaLvPLBd54WOWlyie+B2tUOGszK4EOnbfZVSmz/x7jesEuIZeOsBbn7iTlbDIl24j6Q+G+Oxv2sx0HHll4DA34fo0wpdpwfmDr0XsA+fW2OkApD7o+2266Tn1CeaMuq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fiVr8PLn; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fiVr8PLn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729188845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VE/LN5ytV5ixrWdnI2IQyWvpMxqaOvoKt4lNHXW/fY=;
	b=fiVr8PLnqCX5MuBdmy8lNmqvxcjDHmQFvQO9Z5Wd3u6BO5fSLqXTKDVKZ5Z1CLXLIsd1qa
	SyBHm+FIXkQBlDHA2xYWB3+/YrwfTb+yd6Na/LW3lCQ0t+srQ4Nql5khArhJHH6W1fXlmI
	geFVLXRSr8eNXrvRXCh0c3///1wd5UY=
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
Subject: [PATCH 2/3] dma-mapping: Use trace_dma_alloc for dma_alloc* instead of using trace_dma_map
Date: Thu, 17 Oct 2024 14:13:53 -0400
Message-Id: <20241017181354.2834674-3-sean.anderson@linux.dev>
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

In some cases, we use trace_dma_map to trace dma_alloc* functions. This
generally follows dma_debug. However, this does not record all of the
relevant information for allocations, such as GFP flags. Create new
dma_alloc tracepoints for these functions. Note that while
dma_alloc_noncontiguous may allocate discontiguous pages (from the CPU's
point of view), the device will only see one contiguous mapping.
Therefore, we just need to trace dma_addr and size.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 include/trace/events/dma.h | 102 ++++++++++++++++++++++++++++++++++++-
 kernel/dma/mapping.c       |  10 ++--
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 012729cc178f..9bc647f9ad4d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -114,7 +114,7 @@ DEFINE_EVENT(dma_unmap, dma_unmap_resource,
 		 enum dma_data_direction dir, unsigned long attrs),
 	TP_ARGS(dev, addr, size, dir, attrs));
 
-TRACE_EVENT(dma_alloc,
+DECLARE_EVENT_CLASS(_dma_alloc,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
 		 size_t size, enum dma_data_direction dir, gfp_t flags,
 		 unsigned long attrs),
@@ -149,7 +149,60 @@ TRACE_EVENT(dma_alloc,
 		decode_dma_attrs(__entry->attrs))
 );
 
-TRACE_EVENT(dma_free,
+DEFINE_EVENT(_dma_alloc, dma_alloc,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
+
+DEFINE_EVENT(_dma_alloc, dma_alloc_pages,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
+
+TRACE_EVENT(dma_alloc_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir, gfp_t flags, unsigned long attrs),
+	TP_ARGS(dev, sgt, size, dir, flags, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(gfp_t, flags)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->flags = flags;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s flags=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		show_gfp_flags(__entry->flags),
+		decode_dma_attrs(__entry->attrs))
+);
+
+DECLARE_EVENT_CLASS(_dma_free,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
 		 size_t size, enum dma_data_direction dir, unsigned long attrs),
 	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs),
@@ -181,6 +234,51 @@ TRACE_EVENT(dma_free,
 		decode_dma_attrs(__entry->attrs))
 );
 
+DEFINE_EVENT(_dma_free, dma_free,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs));
+
+DEFINE_EVENT(_dma_free, dma_free_pages,
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs));
+
+TRACE_EVENT(dma_free_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sgt, size, dir),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)))
+);
+
 TRACE_EVENT(dma_map_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 944ac835030a..b8a6bc492fae 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -685,8 +685,8 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
 	if (page) {
-		trace_dma_map_page(dev, page_to_phys(page), *dma_handle, size,
-				   dir, 0);
+		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
+				      size, dir, gfp, 0);
 		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
 	}
 	return page;
@@ -710,7 +710,7 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
-	trace_dma_unmap_page(dev, dma_handle, size, dir, 0);
+	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
 	debug_dma_unmap_page(dev, dma_handle, size, dir);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
@@ -770,7 +770,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
-		trace_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
+		trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	}
 	return sgt;
@@ -789,7 +789,7 @@ static void free_single_sgt(struct device *dev, size_t size,
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
-	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
+	trace_dma_free_sgt(dev, sgt, size, dir);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
 
 	if (use_dma_iommu(dev))
-- 
2.35.1.1320.gc452695387.dirty

