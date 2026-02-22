Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCC256C6D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750205; cv=none; b=g0tnJSO38yT1gxvwkP9Ngguoim/IUoFU1McYDmS/GsuUF1HfkYYGN8zPONDYWU3xxiJ9UgVzX+RHqE4HcKmmXCzU97pcQLng4jDNmhVczsPwad75AccZlEuojpqukeBRv1eeLAqypzdkvEKt50a2/ClYKGW993jo2RVPEFOKxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750205; c=relaxed/simple;
	bh=4PBnYmCqvqclF+wOA5GwV12GKX5dBQimyZrSCkCYzv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3eEqwhjb7C9FYwAARqdmhLhJIewKqROizrsNmO8dFC0MnKKKSPt4K79CuuN76+Sw/PuJD+f7Y6ioYuXG2CpaukXHyWyBiTq2DlN8YesGXX0ZVtjoOsjIXIDKUlXrTaWC2+VSdjbvZbQFo1jR+mTIMfUa7FdGsX2AfwA/D3WUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lsiDxAm1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lsiDxAm1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506bcb23a78so29928461cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750203; x=1772355003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vF7vDru1wu4C4IPdmOP0dgYFxJxyuUKkceiB3IYEd0=;
        b=lsiDxAm1WZk67Swptw9t09vi3jOkKauYvoRYrHJWIQdwp2cxD93s4+hnHI4tSGL2Er
         h0B7HHhwXu5IGLYhEoCflt5tZzDeveKy36yZ2AyUadvzZr7Ih1AfOlg4nIherONyq0Bh
         DESKsA3QWLF0RtC3cUhyD5fw11T1ayw/itGkTjTAwtcTh5NpgJl0a6vqlSz6qVoMp7Tj
         BFMNrydITPvhG9DIS4rl0pIlijjl8pwixkCR+SBwfF/KYz/Bak1JM2UiBcHqFqf6wmX5
         n1VWkCQXYrrOyAo5PgHeIC1Ohg/87wzCQV1zFj/bHxyHF+fGT1qBhabKfWsDZiC9/7LF
         MxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750203; x=1772355003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1vF7vDru1wu4C4IPdmOP0dgYFxJxyuUKkceiB3IYEd0=;
        b=A9Uxz/awK8FKV/X9J5loxOysdF/plHbdHO43hE0DQfyurPiEfZ8VG633/o0GswODI/
         fyXoEqVKTsMhuGk9lVvq0Ymt8e6O9wnX0BTK/+sLDaMe4iNYWdZbtUOjkgcaRkrZlQUL
         YvHWdIKKaU0f8rzSZMbISPQcDf+VGsojUu0vMNDhAB9Fo29etAfuPXdHVJsDjZ4mqZ9o
         +8OUpKh1HPxkf1oXU9a7ZMOiMSBSpOBeee+RxTOxPL7b1YMlKtWdB6vRqWVco64You+h
         4kibLSToNf7/MQKCUB6weklyFV4oTJ9rtVh+qBKrjD4RrFnevNiqF5SUtvqqa2HKe2M0
         i5wg==
X-Forwarded-Encrypted: i=1; AJvYcCXRetVb/Lfg1ww+Kv6rtUFjvt9agrn2w3c5Sr1t3yc3u866bMpbW/EFNDa+jt0TaAb12xtvZOGriY9yI/8WcF9K344=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERiTGT8Z0eHMvk02ajwklEQoYfOTkDvdLAVeCl6aZkQN+aKSW
	hAEdgylzuR1xtUII7ZGbjKaEnI1rjHJokTtULEQn7oMXs9ByY2Lp3ruEVxUicQ1g4Ik=
X-Gm-Gg: AZuq6aK1NMvKUR6HDeg4iD/uJySSrOGE3XIc8psaA24JxGw+vaQ6iovpA66GpneQFzU
	9srOJ9QAzgtGP6Jnb5jYRWeTpxS54MgLmXQNXYsLp44C4QT4K5kxJDvEdXbs/UBqzjfFnxT/+Z+
	4a5o3+WjRMrQxrJ25usj7/dfcOBL3iZEL6tAe6JWkMOYOSfpueFdOwGxRUZO5jeHAITkuPob26n
	iwLmLuqvhKO2XEKuI67tHxnXE5tQ1r9CjJSE7kRffPny7BZKGDNXZvar6FkHqfx+e5rCBN/F2we
	/Az6lHkFCZ1CX4D5lp0UiLUizZiaiiikqVvleSD7dAOK3V9Uai0zNvXF5hzH181NvC84xXy0+dU
	omSSG1tAeAW0puucXZgh7KpagkQa/tT1MD5XRVVOquH8pFtz43s6/62VnS7vboPDTFvwjQE/J8j
	KQ82GsQAClQHKtRqOio9kLvbAxjO9ctjF2arQfOYSrm5q79Z6EGWMs8H52pAvwKE0WCIP4/X6Ps
	oafiSVRKAePAgk=
X-Received: by 2002:a05:622a:14c9:b0:4ee:1fbe:80de with SMTP id d75a77b69052e-5070bca9b78mr73724161cf.63.1771750202674;
        Sun, 22 Feb 2026 00:50:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:02 -0800 (PST)
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
Subject: [RFC PATCH v4 18/27] mm/memory: NP_OPS_NUMA_BALANCING - private node NUMA balancing
Date: Sun, 22 Feb 2026 03:48:33 -0500
Message-ID: <20260222084842.1824063-19-gourry@gourry.net>
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

Not all private nodes may wish to engage in NUMA balancing faults.

Add the NP_OPS_NUMA_BALANCING flag (BIT(5)) as an opt-in method.

Introduce folio_managed_allows_numa() helper:
   ZONE_DEVICE folios always return false (never NUMA-scanned)
   NP_OPS_NUMA_BALANCING filters for private nodes

In do_numa_page(), if a private-node folio with NP_OPS_PROTECT_WRITE
is still on its node after a failed/skipped migration, enforce
write-protection so the next write triggers handle_fault.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++++
 include/linux/node_private.h | 16 ++++++++++++++++
 mm/memory.c                  | 11 +++++++++++
 mm/mempolicy.c               |  5 ++++-
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a4955b9b5b93..88aaac45e814 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -961,6 +961,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    (ops->flags & NP_OPS_PROTECT_WRITE))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_NUMA_BALANCING) &&
+	    !(ops->flags & NP_OPS_MIGRATION))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 34d862f09e24..5ac60db1f044 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -140,6 +140,8 @@ struct node_private_ops {
 #define NP_OPS_PROTECT_WRITE		BIT(3)
 /* Kernel reclaim (kswapd, direct reclaim, OOM) operates on this node */
 #define NP_OPS_RECLAIM			BIT(4)
+/* Allow NUMA balancing to scan and migrate folios on this node */
+#define NP_OPS_NUMA_BALANCING		BIT(5)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
@@ -263,6 +265,15 @@ static inline void folio_managed_split_cb(struct folio *original_folio,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static inline bool folio_managed_allows_numa(struct folio *folio)
+{
+	if (!folio_is_private_managed(folio))
+		return true;
+	if (folio_is_zone_device(folio))
+		return false;
+	return folio_private_flags(folio, NP_OPS_NUMA_BALANCING);
+}
+
 static inline int folio_managed_allows_user_migrate(struct folio *folio)
 {
 	if (folio_is_zone_device(folio))
@@ -443,6 +454,11 @@ int node_private_clear_ops(int nid, const struct node_private_ops *ops);
 
 #else /* !CONFIG_NUMA || !CONFIG_MEMORY_HOTPLUG */
 
+static inline bool folio_managed_allows_numa(struct folio *folio)
+{
+	return !folio_is_zone_device(folio);
+}
+
 static inline int folio_managed_allows_user_migrate(struct folio *folio)
 {
 	return -ENOENT;
diff --git a/mm/memory.c b/mm/memory.c
index 0f78988befef..88a581baae40 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/node_private.h>
 
 #include <trace/events/kmem.h>
 
@@ -6041,6 +6042,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
+	/*
+	 * We do not need to check private-node folios here because the private
+	 * memory service either never opted in to NUMA balancing, or it did
+	 * and we need to restore private PTE controls on the failure path.
+	 */
+
 	nid = folio_nid(folio);
 	nr_pages = folio_nr_pages(folio);
 
@@ -6078,6 +6085,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	/*
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
+	 *
+	 * If the folio is still on a private node with NP_OPS_PROTECT_WRITE,
+	 * enforce write-protection so the next write triggers handle_fault.
+	 * This covers migration-failed and migration-skipped paths.
 	 */
 	if (unlikely(folio && folio_managed_wrprotect(folio))) {
 		writable = false;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8ac014950e88..8a3a9916ab59 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -861,7 +861,10 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || folio_test_ksm(folio))
+		return false;
+
+	if (unlikely(!folio_managed_allows_numa(folio)))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.0

