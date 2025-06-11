Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBA2E6138;
	Wed, 11 Jun 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650470; cv=none; b=hLjSO7K6Uii4UfDge8HHXeQvQtDrNRyihJjv3ZBDOh+5A7Kye6A4HZSRdd7eetqn4XTPgdUwu+qCDYrwI2YcmaYcjE/06iWrWgJ8JQ8TcA9h7YCnQHWcWw+uj37gzJP9CzF7QMwVrddUwSFa5x+YGjCybFG07xjzkKNfztW5cZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650470; c=relaxed/simple;
	bh=NhrX07/ZRSceAn54EclTOUnzutUk0530NLo3rTyHdVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Rgd0bT6sVhnCAN1fFUkxAkm+6yhVrVRcC1dW47TeLK34g2dXPAJKU7v9GnxjEFtN1YlPzjE3GaRL2kx7wufWm+ZjMBf1XOYR3kpMepzCtP6PPlfRT5AhInuLlg786DBjoHMGNx92TXGtyhMnMTZ+tdkU/8nlOLJajYE9+JgvRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 6D4FABE498;
	Wed, 11 Jun 2025 14:01:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 6FCE43E;
	Wed, 11 Jun 2025 14:01:03 +0000 (UTC)
Date: Wed, 11 Jun 2025 10:01:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@infradead.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>
Subject: [PATCH] swiotlb: iommu/dma: Move trace_swiotlb_bounced() into
 swiotlb_tbl_map_single()
Message-ID: <20250611100103.7b3c28c8@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6FCE43E
X-Stat-Signature: zem11qtoa7ykw6s6gddeq3hq71qif9n9
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PYlVOI4oQyNuuyaYyZm8y38u7vsKXNRc=
X-HE-Tag: 1749650463-15101
X-HE-Meta: U2FsdGVkX18M7A5fI6gPAjUd2fEJ01YjEmjh1dDQzNYPemSoCd1WtbC40yqMvEmrGa9hOqxcdlCQy4XFylpb8spwpcafpM51yiX9QdT0V4GYPdx+TWqjEdf9EZViGd45soNlCOp/dBaJ5dJsy/k6uQhQtAdmIkDCChkWUwkDYnh2LdF/biASjAlu3IpPUiRwWKxnpFiI8Ho9dNs2AS5EyhGCVospmhYOKGIuKWtTTi8qjH0qJL8Nvp7yyjTZhZMXDNaqnBtQei/HYi5RawNDlegOwJajSrYhyT4sjuJKGPUINEsZAY5vObj/3RLe/kkZXq0+xTpKnHkpDdM9Hc+3ETjmBmqRE2I1hIMpnlG03H8MuwQXVsiALyZapJtS7AHPUHAtnKnqsxq1buBNbrq16RZQ987gI+r1Pseq5jAWJYjyTFZjBQKaCkbNAz+XVVlHRrUzoWV5jGmZj6YOnLDcTK25rrt7tmEZ4bbIZSRK2Is=

From: Steven Rostedt <rostedt@goodmis.org>

I'm working on code that will warn when a tracepoint is defined but not
used. As the TRACE_EVENT() logic still creates all the code regardless if
something calls the trace_<event>() function. It wastes around 5K per trace
event (less for tracepoints).

But it seems that the code in drivers/iommu/dma-iommu.c does the opposite.
It calls the trace_swiotlb_bounced() tracepoint without it being defined.
The tracepoint is defined in kernel/dma/swiotlb.c when CONFIG_SWIOTLB is
defined, but this code exists when that config is not defined.

This now fails with my work because I have all the callers reference the
tracepoint that they will call.

Thanks to the kernel test robot, it found this:

  https://lore.kernel.org/all/202506091015.7zd87kI7-lkp@intel.com/

Instead of calling trace_swiotlb_bounced() from drivers/iommu/dma-iommu.c
where it is useless when CONFIG_SWIOTLB is not defined, move the
tracepoint into swiotlb_tbl_map_single(). This also makes it consistent
with which memory is being traced (physical as supposed to dma address).

Fixes: ed18a46262be4 ("iommu/dma: Factor out a iommu_dma_map_swiotlb helper")
Closes: https://lore.kernel.org/all/20250610202457.5a599336@gandalf.local.home/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/iommu/dma-iommu.c | 2 --
 kernel/dma/swiotlb.c      | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..1935b360cc94 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1153,8 +1153,6 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	trace_swiotlb_bounced(dev, phys, size);
-
 	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
 			attrs);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..c112f1d98861 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1379,6 +1379,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	phys_addr_t tlb_addr;
 	unsigned short pad_slots;
 
+	trace_swiotlb_bounced(dev, orig_addr, mapping_size);
+
 	if (!mem || !mem->nslabs) {
 		dev_warn_ratelimited(dev,
 			"Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
-- 
2.47.2

