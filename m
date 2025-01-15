Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522971D6DBB;
	Wed, 15 Jan 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971065; cv=none; b=MkrIY3ARkhUkGlz6+pZNiuQDtxR1YjZhD1i2Lqy+Z6bZTELaETZlQQELK5GxQttppBdiLBadRcHU8bGgH+Z25hifOV66CYuv/IGNEExOAlm76ERlP2ffLea0JSxunkZfNVO7nyy3Xc9zmd5/cZDx3XvQ3UnWp8JebR/tSz7kx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971065; c=relaxed/simple;
	bh=q3n1ZeAtXWa1wJ3Kfqg0zYhvAXxW12rvKXew84gB7hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzvqFUiY1ncqpAxidU2VnUh00X0ud3MNISXmzPe2LzQPw8niwTvVpl2I3XVIN2pIZokk7hcWqISgM9H9rKiCQpTcwNcj6WZmvSwSiLm6o2pxEWC699DprzQMNkTDxquGPubpKojxHvhETfuDuJaYAIpMLzkv3tIExrG3m0l6Ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VN3jPQ9+; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VN3jPQ9+"
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BEFFBC0000D8;
	Wed, 15 Jan 2025 11:47:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BEFFBC0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1736970478;
	bh=q3n1ZeAtXWa1wJ3Kfqg0zYhvAXxW12rvKXew84gB7hk=;
	h=From:To:Cc:Subject:Date:From;
	b=VN3jPQ9+eOVk9phdvWiyN+TJws0+BxKw1FZXKyJ+iv7eL4Ibe4sPIDGi1IpmOoW7o
	 JhZX70m+PcFHCcS4/7fXdccIIeYFs+IXijnL6sdP552+cH3Q0sf7tVAmojkiqN53ck
	 TJ5jjUztrbNf0EUx/A/2ZkxgJQVgcE0iZONJAVGM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4F35818041CAC6;
	Wed, 15 Jan 2025 11:47:58 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Michael Kelley <mhklinux@outlook.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Eder Zulian <ezulian@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] swiotlb: Introduce DMA_ATTR_SKIP_DEVICE_SYNC
Date: Wed, 15 Jan 2025 11:46:44 -0800
Message-ID: <20250115194659.618438-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Chen <justin.chen@broadcom.com>

Network device driver's receive path typically do the following:

- dma_map_single(.., DMA_FROM_DEVICE)
- dma_sync_single_for_cpu() to allow the CPU to inspect packet
  descriptors
- dma_unmap_single(.., DMA_FROM_DEVICE) when releasing the buffer

Each of those operations incurs a copy from the original buffer to the
TLB buffer, even if the device is known to be writing full buffers.

Add a DMA_ATTR_SKIP_DEVICE_SYNC flag which can be set by device drivers
to skip the copy at dma_map_single() to speed up the RX path when the
device is known to be doing full buffer writes.

This has been seen to provide a 20% speedup for Wi-Fi RX throughput
testing.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
[florian: commit message, add DMA-API attribute flag]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 Documentation/core-api/swiotlb.rst        | 4 +++-
 include/linux/dma-mapping.h               | 6 ++++++
 include/trace/events/dma.h                | 3 ++-
 kernel/dma/swiotlb.c                      | 8 ++++++++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..ccd9c1891200 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,3 +130,12 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
+
+DMA_ATTR_SKIP_DEVICE_SYNC
+-------------------------
+
+Device drivers can set DMA_ATTR_SKIP_DEVICE_SYNC in order to avoid doing a copy
+from the original buffer to the TLB buffer for dma_map_single() with a
+DMA_FROM_DEVICE direction. This can be used to save an extra copy in a device
+driver's data path when using swiotlb bounce buffering.
+
diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 9e0fe027dd3b..3bc1f9ba67b2 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -67,7 +67,9 @@ to the driver for programming into the device. If a DMA operation specifies
 multiple memory buffer segments, a separate bounce buffer must be allocated for
 each segment. swiotlb_tbl_map_single() always does a "sync" operation (i.e., a
 CPU copy) to initialize the bounce buffer to match the contents of the original
-buffer.
+buffer, except if DMA_ATTR_SKIP_DEVICE_SYNC is specified and the direction is
+DMA_FROM_DEVICE. This is a performance optimization that may not be suitable for
+all platforms.
 
 swiotlb_tbl_unmap_single() does the reverse. If the DMA operation might have
 updated the bounce buffer memory and DMA_ATTR_SKIP_CPU_SYNC is not set, the
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..bfdaa65f8e9d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -58,6 +58,12 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_SKIP_DEVICE_SYNC: used to indicate that the buffer does not need to
+ * be synchronized to the device.
+ */
+#define DMA_ATTR_SKIP_DEVICE_SYNC	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c..6eb8fd7e3515 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -31,7 +31,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
-		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
+		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
+		{ DMA_ATTR_SKIP_DEVICE_SYNC, "SKIP_DEVICE_SYNC" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..8dab89bf5e33 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1435,8 +1435,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * the original data, even if it's garbage, is necessary to match
 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
+	 *
+	 * Setting DMA_ATTR_SKIP_DEVICE_SYNC will negate the behavior described
+	 * before and avoid the copy from the original buffer to the TLB
+	 * buffer.
 	 */
+	if (dir == DMA_FROM_DEVICE && (attrs & DMA_ATTR_SKIP_DEVICE_SYNC))
+		goto out;
+
 	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
+out:
 	return tlb_addr;
 }
 
-- 
2.43.0

