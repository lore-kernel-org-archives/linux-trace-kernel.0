Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4C20FAAB
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750148; cv=none; b=pMKBB1eNYNR3DSukCXqOyzgDiXUvO7WTif9AzGb/FF3vRVMhk6d/oR/I1QX6d56UsJrZ3XiVLw8e+V+xOW7caPD7BkBtd17FlFHrzfJHNy+Lf4DfxGGvKSvfMIqV8Gqk86f+psJWEyWJOXAJgzhGVauhJCiEMjlLdzXgfVm2VCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750148; c=relaxed/simple;
	bh=sAkLCb212Za2s4GNdxcsRgPVrH5x9YHyij8LRwqdLNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apzy9wGBBQW/eplXB2/PuU+jMkNL13iYjGBHzOjAw3KhrUFWhryyq8uZMkro/odDsWujQHXjyMcgHrOW9JuyQziuowOPCZUkIGJ3sqDhICLJqvRla9VE4NIxI8595B2LCHLOoEWBHv4tRbsUm97y4fw3t2xGlo5LLwrDlT41Evw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Lmv1jvS9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Lmv1jvS9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506362ac5f7so32420511cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750145; x=1772354945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84BLe7DIZgrLHIYUbF37QCRxTh9GXhBrS3ZeLS92Kiw=;
        b=Lmv1jvS9rON1Dhgds6AQ83J1D1/Ly4UK4s2+PPiKi5vQnR23Fms+KMp0YvN9zjTAu/
         N0yK9QVRstC3ObFxAVbqsZV3jrDo6fuDaOw6N1eP+RW191Ucpdi9HkLBAVoYQ1SWWpSK
         Ncl9cnkwSYLezibPH8yx2tlHzDIbr9EtroUJ4yOCBpmBY4vFkQFLyn6M9UFQSl3JrX43
         T/T8XYqf9vo6m99hZ8biJpr+C4DZVAhLzzRHYfePH6nCRlqaUKo6oKpuj42OzOzPuYhp
         7CcpJtU3C2dvkoOQJIz+8i77XXPTIHXzjYiTipdJCTFfDpAiLYQuMgKl8GtrEXbUmF3R
         AvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750145; x=1772354945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84BLe7DIZgrLHIYUbF37QCRxTh9GXhBrS3ZeLS92Kiw=;
        b=BfyrOL+yOP+Rk3ptNBjtMYGI0WHE24SCaFNuRAsvlmvKRaOhEW0D0emxaQrDbUS+vG
         9x6J/vupRQziz3LjJFIHoEYunQQ8561GiSehdWX/v1JkgFTEs3bhlLDoR/ldVKs9+F91
         Ec5neSlMNpuh+vJOS/k/7uKXM6ZJoYdyqBB5sqp7gSCaPLKuKcjB1MgNEsPSOA7KqUpT
         hqzE+/NSlAshytMoP8XrU/RKHNSOYbnBFw1GXhM7aaRmhwCbgjjoDCgwD76OvUElaC2t
         Pr6YSjNOy/tHnVav7fuK8oQTbvdWC7q3MS6X1AeTPKt4BzDATZj57X2BHCaTh2Z1SYCE
         yI/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNVCYOs3vKnDHPKSeFFOt31csGOcPi27am7ZrkXvEZM7SHtYdZ6Hzob5rAnEQErHisodpPDPvjIm0IKyxFRsGQhLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskTr1UHahA6iez7F575pmP+KsiwQLAZqQL9l8mesFJ8RaiaJv
	r69IFPiyRP4iFqE79cvIvw9VF6YzrG/4W5/Gl5w1CC649CE/rnltLN+lSKtyVrhdqqI=
X-Gm-Gg: AZuq6aIwnwlhHVSRaKu2ictVjFvSkCiOqlJz3OfRlyNurNIsFXB78xTE4kvfhNirulB
	gpmo61vhAxmxeX1XypPv5OlwyNBieQzu0+1XOwMTV3osvQvUMqVvv4+wUdXx1Wh2J8DznG2d49E
	9p7f3ys47Z7w2VmmLAdwoRchcsFjKIuooWMPg4h8gaQH67fEKi9KUX0eBBplQQX8oIXRq+vwdH1
	ln3ik8/5cd1ly/bbUB/FDgqIw7pIGJrTuzGv3Xu2TofgHHQRvAiEJR8gwB/2XzhoLdcZgy6JYRY
	qC/UeeKPhVc4dXI2Kj3t9rtyH6q3SnOwaaLqaDBRTgTLcIyYvC/wCYju80J41WD0T5SBzcQBBlo
	DnrH/nSqon2HT7gadPy/nqWCLET4gJ++6cSGjPOyLD0LTz/rFHuOGNBMf90N0inpOTq1xQGIJ/o
	HF12RDeNRhwv9yfCrjFyE/pyOCnId6pMobCE+fRLcbu5s6+kuXztyV9rveyv0uRkYRkYNw+/UnZ
	43nqVQBgA9mMp4=
X-Received: by 2002:a05:622a:113:b0:4f4:a9cf:5d40 with SMTP id d75a77b69052e-5070bba20d9mr79750811cf.11.1771750145024;
        Sun, 22 Feb 2026 00:49:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:04 -0800 (PST)
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
Subject: [RFC PATCH v4 03/27] mm/page_alloc: add numa_zone_allowed() and wire it up
Date: Sun, 22 Feb 2026 03:48:18 -0500
Message-ID: <20260222084842.1824063-4-gourry@gourry.net>
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

Various locations in mm/ open-code cpuset filtering with:

  cpusets_enabled() && ALLOC_CPUSET && !__cpuset_zone_allowed()

This pattern does not account for N_MEMORY_PRIVATE nodes on systems
without cpusets, so private-node zones can leak into allocation
paths that should only see general-purpose memory.

Add numa_zone_allowed() which consolidates zone filtering. It checks
cpuset membership when cpusets are enabled, and otherwise gates
N_MEMORY_PRIVATE zones behind __GFP_PRIVATE globally.

Replace the open-coded patterns in mm/ with the new helper.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c |  6 ++----
 mm/hugetlb.c    |  2 +-
 mm/internal.h   |  7 +++++++
 mm/page_alloc.c | 31 ++++++++++++++++++++-----------
 mm/slub.c       |  3 ++-
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..6a65145b03d8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2829,10 +2829,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51273baec9e5..f2b914ab5910 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1353,7 +1353,7 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
-		if (!cpuset_zone_allowed(zone, gfp_mask))
+		if (!numa_zone_alloc_allowed(ALLOC_CPUSET, zone, gfp_mask))
 			continue;
 		/*
 		 * no need to ask again on the same node. Pool is node rather than
diff --git a/mm/internal.h b/mm/internal.h
index 23ee14790227..97023748e6a9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1206,6 +1206,8 @@ extern int node_reclaim_mode;
 
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 extern int find_next_best_node(int node, nodemask_t *used_node_mask);
+extern bool numa_zone_alloc_allowed(int alloc_flags, struct zone *zone,
+			      gfp_t gfp_mask);
 #else
 #define node_reclaim_mode 0
 
@@ -1218,6 +1220,11 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	return NUMA_NO_NODE;
 }
+static inline bool numa_zone_alloc_allowed(int alloc_flags, struct zone *zone,
+				     gfp_t gfp_mask)
+{
+	return true;
+}
 #endif
 
 static inline bool node_reclaim_enabled(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2facee0805da..47f2619d3840 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3690,6 +3690,21 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
 				node_reclaim_distance;
 }
+
+/* Returns true if allocation from this zone is permitted */
+bool numa_zone_alloc_allowed(int alloc_flags, struct zone *zone, gfp_t gfp_mask)
+{
+	/* Gate N_MEMORY_PRIVATE zones behind __GFP_PRIVATE */
+	if (!(gfp_mask & __GFP_PRIVATE) &&
+	    node_state(zone_to_nid(zone), N_MEMORY_PRIVATE))
+		return false;
+
+	/* If cpusets is being used, check mems_allowed */
+	if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET))
+		return cpuset_zone_allowed(zone, gfp_mask);
+
+	return true;
+}
 #else	/* CONFIG_NUMA */
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
@@ -3781,10 +3796,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
@@ -4585,10 +4598,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
@@ -5084,10 +5095,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
-		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
-		    !__cpuset_zone_allowed(zone, gfp)) {
+		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp))
 			continue;
-		}
 
 		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
 		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
diff --git a/mm/slub.c b/mm/slub.c
index 861592ac5425..e4bd6ede81d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3595,7 +3595,8 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 
 			n = get_node(s, zone_to_nid(zone));
 
-			if (n && cpuset_zone_allowed(zone, pc->flags) &&
+			if (n && numa_zone_alloc_allowed(ALLOC_CPUSET, zone,
+						   pc->flags) &&
 					n->nr_partial > s->min_partial) {
 				slab = get_partial_node(s, n, pc);
 				if (slab) {
-- 
2.53.0

