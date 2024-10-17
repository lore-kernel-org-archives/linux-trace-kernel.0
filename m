Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45691DFE2A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188847; cv=none; b=OcuRyoudBpN/6nD84+7BpL0KMM82DH4GXogtUuJ8b+VfjR+sYNSWzhJ2V4sZc3VkdJW3en3bN6Th4fR7W27UBRnFjXooddqPGmPST634uHnT2y7NpQ0O9QLLs4vyfuKmsWpgfHEl+J8Cvcr1hTVbBTty9bTt9XvQZA7Jzi7BUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188847; c=relaxed/simple;
	bh=MsL1f0Lb/Owf1AcAtJ4AWA6ChQa9KfgUzX+gkKWNoi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjEKcBFoQIy4YF5xKr30rZjzOJbQTx94Ozs5gSZsejVFH2RvFN9zLnD8mYXnLlQDZU8IwC2Nt1FOX0KyqzPdO7MXzZfNcO77K5wnYCuZBQyMqa3Z3ly7xZIn7pokPPNDKGwMJd4pphmg6PI+0S/i5ATsIP8yDfOfQjGPfRqR2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lRTBqOlE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lRTBqOlE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729188840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGYq3uSJdy/Jg+NTNJFQaKRLcjv44fFmLT/rLc2pR6E=;
	b=lRTBqOlEl8InTGYADg0sDJ1ce1yAavaiWboDEz+SH3d9H2kA6VCPCrFU4xF98VJhpLPV4N
	twqiMc4wHqjI/BFDifiHaSO3vxh42rgMicg5jNf3M1Tvp/aTirfH7tyfZiMkdsO8r4L0F6
	tbqyrapf6G5qhJ5BENNNs2ty7Wx1JIc=
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
Subject: [PATCH 0/3] dma-mapping: Trace more error paths
Date: Thu, 17 Oct 2024 14:13:51 -0400
Message-Id: <20241017181354.2834674-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some DMA functions are not traced when they fail. I found this pretty
confusing, since it seems like the device skips calling the DMA function
and fails anyway. This series adds some additional tracepoints to
address this.


Sean Anderson (3):
  dma-mapping: Trace dma_alloc/free direction
  dma-mapping: Use trace_dma_alloc for dma_alloc* instead of using
    trace_dma_map
  dma-mapping: Trace more error paths

 include/trace/events/dma.h | 161 +++++++++++++++++++++++++++++++++++--
 kernel/dma/mapping.c       |  37 ++++++---
 2 files changed, 178 insertions(+), 20 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

