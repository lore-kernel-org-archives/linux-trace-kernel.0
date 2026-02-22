Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85403261B92
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750217; cv=none; b=hDbyRNpSXSYK7RYKdp7KSoxgL8SDxdbCSOwhp7zrgVq34fkQ8DuheoawanQoFLJs6Qnt6x94++irznsJ+T5x/UZI/S+exdjqLyFzRx0jJDygWSda7urmoEe3v5Nxm80bDtVFWaNeUm7FMwjT67ed0umGMZlS6wj5RHPk6mFV/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750217; c=relaxed/simple;
	bh=244yDtSyFVbK83TYYa36HIEQwZx1d31NEEAoZWs7XP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0uv+QrTOSjFzWwFUh0CmC4on9SJSsyyK8zXhZl9pwFTy+5n4v67daqq3jkn5d6AGrFWZIIEwgEo7BzLDVEetmhaez/AjwUSBcg0ke/sCKFfAGSx51SoRidlF5A0X/pvZFcqu6sX1/vfpdKN/39PFD2Fkko9vX52Ys1mZh+sBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZSsseRur; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZSsseRur"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a1b23c05so43291461cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750214; x=1772355014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=ZSsseRurZipjzhbnIpwLXt+nRR66anrop8z0XJHW+ZDaD/Va8PKodL5a/mYWGhnfJ0
         0TKUBSYJCjdc8wyQiEnTzu2h6694bpTicZ8mzL1agkPMmgQAn2bdtP+gOyd6DklaHvN0
         Y3ZWl+kmUtJcpuLpuP5iNgoAtBuRd1zXN4tdMIsLuusXHCmRcqr1vJDgNyGhffES1kyj
         xRiyUWIak4M3jGfwu/jC0TkTkyGoP4oJOeA5m9l3Xt1ZLEo39EO8+j5hFc3RYsJkuV4Z
         3G6w1rKwsJ5H9CtSSCkBOtHHEIBUAYYBde6lXq86/1TjLJW5lj8SHRf2H/ASgSyy+uOM
         pr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750214; x=1772355014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=dmQaWEf7j5C2DdSXja0iqmuQFWpoBRnj+rfLs/uzcJIz11JuE9rD4NjnhQU0DOIGvL
         vmrrV5vJM/pnPGLS9WZpDo8dc4AFVSdF2fw4Z4IV284qX5DwXPOf5J8eqR2KLBn06maY
         EvjMl6cLUbTzxyofKv8ZE0JrGGUwvbeYCP/b7xq1WlOBZP5uKpXO107pF/aq1D7Mp8ZN
         PHDkECyFyCGNYiyg39ejOvw0V+Zm4XCPKMtCEHrhM9yy0t1lkBR9Kc4ZC5oBKAL+gVXs
         lVZUWrJ6W0QwnEKDHnVqIe24mojTf73MMtZ1EpbjTxU9SEc+moFgQtl+WmlW7splN4Ji
         ZPVA==
X-Forwarded-Encrypted: i=1; AJvYcCWl2MzDpy6fJzHSQJCzvBEkRF4172JplkxMDSWmA6zu0NRpQf/LANmhTt86+TIemI225L+c8qQldg2dGRungB8dLMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUozWx1nOeZ/bPLEYkFc0AnsOdS0f5Dt2cu/VnoGjoz5SnI3w
	tmGigz86NTuMpTXcmZQ/ZWYAfhYKNuvSTgnFgrZr8DXT34HiegktLZ5I7Ja2fCgs60I=
X-Gm-Gg: AZuq6aLwFoNVxzc2MGCTVOZj6r3h5xuuQmJBx8YG/oDn3x1J0yl4X4MMM3fLB9Xw3Pu
	cvMvbELt/hOp1m97yTyaGYtpkhJh1MDbGNo+IqvXNMCoc6kuuHkgD+9k6pmP6jmIzmKLrbN1nLy
	KUv5w8x+dKQI0FYBzJgrxfqjFPbQvfM7NsXEZvp1b0kDfcwDLgIT4sIbnKVDS64RhHmBc7LXr7F
	3Qh/A3IG1UpRfQWhYs7984gAi/T3ZbAFTQRJpe4UvRPdk9UM9qjR1Q59B7TOlgZAMbb2nf3XSu/
	vRgaumZ95J5luAS8ALvrecEGU96rWvc9KXWvPotJGm+n+UKOEax8nWfFTHVhPONQ2c5/tMuvhDm
	CCZspGc4jSOXs+VNNFtwVxJgG6SOpBDt4743EAsR6dml86t52kla69ab/rGFeGoA9jVWu8liavo
	bD3CYaaSD3jnqw6UsM0k8Tlo+hDHLUWHp3oEXsqKoA9Pi2mguQndK5qY6DXAmjsmKR44OIATohz
	SLVhhGTrAENcJ8=
X-Received: by 2002:ac8:58c3:0:b0:501:4b96:466d with SMTP id d75a77b69052e-5070bc97e29mr62373271cf.50.1771750214354;
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 21/27] mm/memory-failure: add memory_failure callback to node_private_ops
Date: Sun, 22 Feb 2026 03:48:36 -0500
Message-ID: <20260222084842.1824063-22-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a void memory_failure notification callback to struct
node_private_ops so services managing N_MEMORY_PRIVATE nodes notified
when a page on their node experiences a hardware error.

The callback is notification only -- the kernel always proceeds with
standard hwpoison handling for online pages.

The notification hook fires after TestSetPageHWPoison succeeds and
before get_hwpoison_page giving the service a chance to clean up.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h |  6 ++++++
 mm/internal.h                | 16 ++++++++++++++++
 mm/memory-failure.c          | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7a7438fb9eda..d2669f68ac20 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -113,6 +113,10 @@ struct node_reclaim_policy {
  *   watermark_boost lifecycle (kswapd will not clear it).
  *   If NULL, normal boost policy applies.
  *
+ * @memory_failure: Notification of hardware error on a page on this node.
+ *   [folio-referenced callback]
+ *   Notification only, kernel always handles the failure.
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -127,6 +131,8 @@ struct node_private_ops {
 	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
 				   enum pgtable_level level);
 	void (*reclaim_policy)(int nid, struct node_reclaim_policy *policy);
+	void (*memory_failure)(struct folio *folio, unsigned long pfn,
+			       int mf_flags);
 	unsigned long flags;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index db32cb2d7a29..64467ca774f1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1608,6 +1608,22 @@ static inline void node_private_reclaim_policy(int nid,
 }
 #endif
 
+static inline void folio_managed_memory_failure(struct folio *folio,
+						unsigned long pfn,
+						int mf_flags)
+{
+	/* Zone device pages handle memory failure via dev_pagemap_ops */
+	if (folio_is_zone_device(folio))
+		return;
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->memory_failure)
+			ops->memory_failure(folio, pfn, mf_flags);
+	}
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c80c2907da33..79c91d44ec1e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2379,6 +2379,15 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * Notify private-node services about the hardware error so they
+	 * can update internal tracking (e.g., CXL poison lists, stop
+	 * demoting to failing DIMMs).  This is notification only -- the
+	 * kernel proceeds with standard hwpoison handling regardless.
+	 */
+	if (unlikely(page_is_private_managed(p)))
+		folio_managed_memory_failure(page_folio(p), pfn, flags);
+
 	/*
 	 * We need/can do nothing about count=0 pages.
 	 * 1) it's a free page, and therefore in safe hand:
@@ -2825,6 +2834,12 @@ static int soft_offline_in_use_page(struct page *page)
 		return 0;
 	}
 
+	if (!folio_managed_allows_migrate(folio)) {
+		pr_info("%#lx: cannot migrate private node folio\n", pfn);
+		folio_put(folio);
+		return -EBUSY;
+	}
+
 	isolated = isolate_folio_to_list(folio, &pagelist);
 
 	/*
-- 
2.53.0

