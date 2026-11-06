Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971181;
	b=bcZo6vxZ7+pNgCK+R7st9rfTg9nnHACXyg7j3yO5KFIlpaMZT+Y4ZIr/mZU4tLynSy6F
	 iwpnz19VE3FNCbEnBQHDkMwnFDFeHJLVNGGXpTdUxdVqOpP8bJ+fdzI+K3XZLpcWvY+D5
	 I4y4J03m9RhMvwmSEJZgMtCeA3gtx9/cuOjNP4NRgB4G2qsYR5fQtPSgx5FSom87HNzgU
	 xO6vPyYeC6ZrRLNAoXdXWw6vbXl9cigZNm3jKww1LOHQN+u6cEiqKuAHTsLexEsi2sTb8
	 6mnIiCJsWOCUsYS1sbrqwIBryXJubEjut1De5sr9zY27g/uncnYJGnFY9bZAPtzRjog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971181;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uHDTPFGM/AF1nyT/Yc6bbkTHW5yMlJbnq5ZETvmi2Vs=;
	b=ceDHIlZBFwi2BkfaImxeALvF8travFSw2LenaFZ2K8J62q0JMIf78QVBJqP38dBZXPuq
	 mBzFGxXI6j5dl0EWC1sFzvqL4gmSSrtz7UI24uah+9oppkO1DvgY6lFSGYBTPocYd00HI
	 YtQWABXtRyVA2eQA5+YFiMr9ofEFs79OafR+ZveJ+kz5XWYbL1Yx20SX2rvtVBYZ7e6qu
	 Jz1yqeOs3gIos6NBWziaS6BOzf5xHMXTStYDe0+SA717GdDMwAwRDBM9VfGc2OoHsymVj
	 QvmPaolEe2Oab6QJu4RL0Eqlp/LX9dMei5coYvpmA9duEczhqan5RoTt787aOlnFlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e39dX1aD;
	arc=none smtp.remote-ip=95.215.58.82
Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D3606A32C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0D3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e39dX1aD
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=55Gu1BuWJQRvJsCcgFgbtSGQhBxGx47gTgITgbn0eiI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971178; v=1; x=1794575978;
 b=e39dX1aDFsU5NTPTFLe3+RT+3/gSUyvAl18yS049B+1+avfXR5NJDC/GkY5xOMwPLboBKIzd
 N/1dhMtcwKi5kzXqiwRZhxE3jiyRM5th46sYicPK4WAzdzE7WYf96hN+5fs28ZwivqYdNalGYQh
 JAlb8yu3ez3DJaz2LqvdS2LE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2231816b5623e6c8;
	Fri, 06 Nov 2026 13:19:38 +0000
X-Mizu-Trace-ID: 2231816b5623e6c8
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org,
	dgilbert@interlog.com,
	mkp@kernel.org,
	loberman@redhat.com,
	jmeneghi@redhat.com,
	kraxel@redhat.com,
	vivek.kasireddy@intel.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	rostedt@goodmis.org,
	vdonnefort@google.com,
	mhiramat@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	axboe@kernel.dk
Cc: linux-mm@kvack.org,
	James.Bottomley@HansenPartnership.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com,
	mason@kernel.org,
	aesteve@redhat.com,
	tjmercier@google.com,
	harry@kernel.org,
	vbabka@suse.cz,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
Date: Fri,  6 Nov 2026 21:18:24 +0800
Message-ID: <20261106131829.3228926-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106131829.3228926-1-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
data pages keep the accounting of the memfd they were instantiated in,
but the bookkeeping around them does not: the page pointer array and
the pinned_folios array, both sized by the buffer page count, plus the
transient folios array sized by the memfd folio count, are plain
GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
memory, and size_limit_mb defaults to INT_MAX.

Charge the three kvmalloc allocations so the creator pays for the
metadata it induces.  The system heap in the same subsystem already
accounts its buffer allocation; the data pages here stay with the
memfd.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/dma-buf/udmabuf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd0046242..40182c82df6b 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,11 +190,12 @@ static void unpin_all_folios(struct udmabuf *ubuf)
 
 static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
+	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt, GFP_KERNEL_ACCOUNT);
 	if (!ubuf->pages)
 		return -ENOMEM;
 
-	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
+	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt,
+					    GFP_KERNEL_ACCOUNT);
 	if (!ubuf->pinned_folios)
 		return -ENOMEM;
 
@@ -387,7 +388,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (ret)
 		goto err;
 
-	folios = kvmalloc_objs(*folios, max_nr_folios);
+	folios = kvmalloc_objs(*folios, max_nr_folios, GFP_KERNEL_ACCOUNT);
 	if (!folios) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.43.0

