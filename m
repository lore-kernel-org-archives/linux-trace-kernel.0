Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971227;
	b=nWc1NOlxi3iBvaK8TIjazef5Q80r6mwiBU4jXoF/ssOYYdCeZ3y2i9lecYU2J2OzBbNc
	 dLAxdHgQF4jb4WF8hHu9BNCIuOfxipNA4fRj3lg35SB2PRLkAZxIcnfVj61TRr1DddvQz
	 HNz4LU/bE3Ina2wnmxdGFKD5iLw4F2CirzJoW7BVDDa2pjgyncUfWgFhqU/wwVS2igQMb
	 cckrAgL23fccnxp94Vz0QZkg9NxTcmO8OKdoXVH1AqWo7kJKgr7VcYysho7tUwdF2MqzF
	 2uXAtdoIoJzgs7j032OvzHlcyaumk4k4Rt5QrWoEw37T/QN7crWXzSIrOJQT7yEqITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971227;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q5STX0i0nZe9qBiCwKpYPE22fAldGg2mVbLAiRStB5A=;
	b=XwFT7vWJkPy9ZkVAZ5NY+en5Oek4PMjpLwj0ZP0r2Om4HsoQyVS1smztW8CMgZjG5SRt
	 Kfv02cvliwNLYoNeM9htbx7neYmRbcMQ2emZ6/cDgbzZq2/eNvP4F4ew3ROYZj9YXQVHV
	 +8BSyh4WoMVD0HRzyIWd+iBGtqdtraExLrbFB54ScAgKp/HMvv5t+byeTZtSlU23Ol+mp
	 Ljg/6MPYfwnp1abAEd8rCzLuvBVdMQv6MkNwxsS2cGX4ZHn/EGyL5A/m13g9i+aY1Q5W3
	 vy8RVHyORJXTHxbAd47oLJbEMk6zXXYggFmz9mvvmST0NohUSEP40Lw4t0Q11T1Re9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d+UUy9as;
	arc=none smtp.remote-ip=91.218.175.143
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D8606A33D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52D8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d+UUy9as
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lnwy3IIIUITEEW39wV2rv1u7rm4YP9o1MSolIsKb45g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971224; v=1; x=1794576024;
 b=d+UUy9aspeg05aRgdUPdJVvaOjeqMoZfnDpLYQi1940Np4kpll30/qDONd5+cxzLYxZ8GLiN
 XB6ebn3egq/iymbFovBTJAKowW++5xgglIECQAj/4dfcQQzWZ0WRAqTTtjN0HFAI1Qj55pwzYJo
 7NAG6KDYwzR0DHDg2y3Y3KWE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 42ebb214afb95bc7;
	Fri, 06 Nov 2026 13:20:17 +0000
X-Mizu-Trace-ID: 42ebb214afb95bc7
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
Subject: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Date: Fri,  6 Nov 2026 21:18:27 +0800
Message-ID: <20261106131829.3228926-6-cui.tao@linux.dev>
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

IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
that a user supplied queue region is physically contiguous, and the
page array for that check is plain GFP_KERNEL.  The size comes from
cmd->length, a u64 that is only overflow checked, and the array is
freed again as soon as the contiguity check fails, so the allocation
can be repeated concurrently: a 1GB region costs about 2MB of
uncharged memory per attempt.

Every other iommufd allocation that scales with user input is already
charged, and the pinned pages charge the mapper at map time.  Charge
this array like the rest.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/iommu/iommufd/viommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f7951057a1e5..ab17e190da49 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -330,7 +330,8 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
 	 * Set __GFP_NOWARN to avoid syzkaller blowups
 	 */
-	pages = kvzalloc_objs(*pages, max_npages, GFP_KERNEL | __GFP_NOWARN);
+	pages = kvzalloc_objs(*pages, max_npages,
+			      GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.43.0

