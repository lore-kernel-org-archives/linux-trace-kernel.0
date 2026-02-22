Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30248257851
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750209; cv=none; b=qKF/CjDvoyz20LY3MvoH3QdOkQIqvLsYEjtdAPXOI2LJupWh5DGdV5cI4476vJjExrv76jG4/atNCXTLgbzf0mTn21YqWxROAJFD+7nsyFfo3Brj2uiXTk9g9Nz2iZ5lufc1SC92hRSLXJhH60dKQ52M/Xppy8ii3TDvSKwx3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750209; c=relaxed/simple;
	bh=ugHHZgdJqiJXcDB88oSYbue+JadFi16VcX0GKhbfi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tj4ls3GasOmk7kKZfxQxBzPgT8Jl/K48+Ycrpo2fpMInoiuJH4jgcO7VHN0balYaNXX7DaXlkmhyZIIRmLSvMf/8npo1esXdoON0QQBsoE+yYCRVjfS0eGZ96SikHA7H2+mv1gHyRiT+znznoc72hF7Mskt2qm2NbnMSYqUPQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=On3dGfWn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="On3dGfWn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896fb37d1f0so61728276d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750207; x=1772355007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=On3dGfWnTNN//RWAohKdA4pL2lZMV7MeYMGS62VGhOuMecRzlrq6gWIUBvvjT5HHaT
         ix0alOvAxYuQ/UF+iHgKCZE1NJ79jby/hFklKqI20yPQKV0JhOMMvBMaZOx6y5VFqasu
         PpoEFeOQ4c5xjZymZwU32/WzBKtFDimqsUNPxVd+Hzs3PhECgFQfjxBc4ZJ7nJ0j4Tav
         GAApuP8InCI4mdI9yqeN6yb7hyMt1wufFWCiqqn5Rp/vjRlXJIeLQSU0ZCV50UEqj30o
         H714Ynl0lEEugwsUlVjrRsqiFuJ8lgwu88JAZR6TsNox+hwHL9BvbHO6/efoXdrXQeu+
         Huew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750207; x=1772355007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=ZosteZVcePbsHwF+FIfMg4hYugASUVCuqM1chF505dG5mTrBjaj4HOOyYl7jq24g5E
         r2VSi0lDVLS6OVZp3SpGve+O0u9Nh8eeRSXgYqMbBxK/9MQq3dhV95SQ8FqV0oUgBaz+
         VhGhyKDxUXQ+Z7pgRlku6euZ1y4odI0qCub1TDTBhyYDbhKNrt6yT/HelO0gqFjsezKN
         V2mGiBxK+yrOKUvgjOBfhmfjXW4YKDXxxw2Mpk5NrHcs4NLl9mBniB/xte6lm9N/H9v2
         JGr44/PzWOfvbfiJ+S412tcqw1VDXuIMwFiTBnLmj+WuShFCO42zDBQyBH9ijUWD52tg
         1W2g==
X-Forwarded-Encrypted: i=1; AJvYcCV3FDU7J2eqebkQfAb3dDZ1PP1NjlBDEKuVFB29giv4ePYkkCIVkpWvtGaK/hlbLfWEbaHYx4xDMENYHds3t+ccTeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjwDqNcbKS64NCZgMghJA/48WyHEGqzgu7l8q0kuMuX6dhqUJ
	v3KS8fj0DHGr+x8mh24G7C/Q+XFpUQmx0i5Kkoq9VZwWm0TizNDxqtBmy5lQinrpdFc=
X-Gm-Gg: AZuq6aL4jsABhaja5ZIwg4d1l84fBSAn4nWFbyv2tDpr868xOfsdjo7wNsObSY3aT/g
	tsqL5CJhQUiUm81FDncYExSMNcZvF9l4aZrTfNMDMlPFUH4GtnFge0rTi2D2s+t9vqMOtawNifN
	Jwc6C9M4eTh0CKRoeaVZbaxTb7RyMHR7WXii3vr1tXKpTi6zMewhPYNuapvC4gqAcczpTV2r0sY
	uZloKKlJowWvqM5CBrsKs7jQIBqsKp8PuhMYldNkVPR1a2x/TDP1773RyazXGUcXjlo4JANCJEn
	bGcVrzk8R3c+UKQ5lpXI7VYlqBEY3JdlUYuJWaQX14bAGNJ7NDMP/c7k2iBA7UhEVu2rwIQYjps
	QV65immo49LIHeOA5T7RY6laPWAR8NtTy6QWP/IHkgr1+kDa8sMjLkICyeTClO1RoQjT/KMddmH
	k7DUaBf4EmkRZNqkHdVwN9Yt0SaJlHLl1NJbHjVn56QJeLqoYHfKjS0YqtUZ+AD8kCKLBolRb1D
	fd6j/hySmgkbDI=
X-Received: by 2002:a05:622a:209:b0:4ff:4a7c:da11 with SMTP id d75a77b69052e-5070bba08b0mr86322821cf.11.1771750207039;
        Sun, 22 Feb 2026 00:50:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:06 -0800 (PST)
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
Subject: [RFC PATCH v4 19/27] mm/compaction: NP_OPS_COMPACTION - private node compaction support
Date: Sun, 22 Feb 2026 03:48:34 -0500
Message-ID: <20260222084842.1824063-20-gourry@gourry.net>
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

Private node zones should not be compacted unless the service explicitly
opts in - as compaction requires migration and services may have
PFN-based metadata that needs updating.

Add a folio_migrate callback which fires from migrate_folio_move() for
each relocated folio before faults are unblocked.

Add zone_supports_compaction() which returns true for normal zones and
checks NP_OPS_COMPACTION for N_MEMORY_PRIVATE zones.

Filter three direct compaction zone loops:
  - compaction_zonelist_suitable() (reclaimer eligibility)
  - try_to_compact_pages()         (direct compaction)
  - compact_node()                 (proactive/manual compaction)

kcompactd paths are intentionally unfiltered -- the service is
responsible for starting kcompactd on its node.

NP_OPS_COMPACTION requires NP_OPS_MIGRATION.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++++
 include/linux/node_private.h |  2 ++
 mm/compaction.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 88aaac45e814..da523aca18fa 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -965,6 +965,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    !(ops->flags & NP_OPS_MIGRATION))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_COMPACTION) &&
+	    !(ops->flags & NP_OPS_MIGRATION))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 5ac60db1f044..fe0336773ddb 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -142,6 +142,8 @@ struct node_private_ops {
 #define NP_OPS_RECLAIM			BIT(4)
 /* Allow NUMA balancing to scan and migrate folios on this node */
 #define NP_OPS_NUMA_BALANCING		BIT(5)
+/* Allow compaction to run on the node.  Service must start kcompactd. */
+#define NP_OPS_COMPACTION		BIT(6)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
diff --git a/mm/compaction.c b/mm/compaction.c
index 6a65145b03d8..d8532b957ec6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,9 +24,26 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/node_private.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
+
+/*
+ * Private node zones require NP_OPS_COMPACTION to opt in.  Normal zones
+ * always support compaction.
+ */
+static inline bool zone_supports_compaction(struct zone *zone)
+{
+#ifdef CONFIG_NUMA
+	if (!node_state(zone_to_nid(zone), N_MEMORY_PRIVATE))
+		return true;
+	return zone_private_flags(zone, NP_OPS_COMPACTION);
+#else
+	return true;
+#endif
+}
+
 /*
  * Fragmentation score check interval for proactive compaction purposes.
  */
@@ -2443,6 +2460,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2832,6 +2852,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2906,6 +2929,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		if (!populated_zone(zone))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (fatal_signal_pending(current))
 			return -EINTR;
 
-- 
2.53.0

