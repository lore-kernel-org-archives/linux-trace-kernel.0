Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DD24DD17
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750201; cv=none; b=EJidDuIOR/HnJ2B/kY15vllVRJP9ozbklWZP+a5P85revf5CcvZ9Uboc7LSD+SC9p2sqt+JQ/9onrkiQdd6uQjSEns9ZeFbEthLCGoFGd62ZnrGcKWpVVwcg7kT5XGn1z21Eme0qiRL756wr5drpUfmh3uELsVrz0FTYfAhBiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750201; c=relaxed/simple;
	bh=Ouqj4GqJWjwYiY0gNW4BTPlwlgIunnGvFq2E9eGJsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfCCnrqPffR2Wwuz4Lzyy8CD6S5NTi8kxjrwX8/YSX6wiGetTgW06Gmyug90Yjg03vJT4gW+P3jlZlWrmLTaK+niEp9AZEY7YDCHrbxiU4CrOmQ14OzQwM1OOpAq3NfLz0JMlXR01VW2d32RlJRtrIOY0ggyh9KrEwOogd0JAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J1AoTa4b; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J1AoTa4b"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506bad34f51so28262541cf.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750199; x=1772354999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=degmio9cxdpzQuRYo2QvBbWquT2Pd1sYOKpzGMoeajE=;
        b=J1AoTa4bi2IOOhcduUTDkO0dYY6Xs0dyWF3OvN+AGw4ZVzZ71xL3XL9OmUDDclSgPz
         7WCF0lH93k1EeM+fFxODzmCZr+vccMR+N++msZ3nReP0vucfs+Dw4TEYcqkpoabhEkyO
         XQ6xWRN2LCujRzo3NwDNufq55dgjuIrXOXe7wM2g6z2A5PXcVWPaDwEWwPAtUwBDfS0h
         mw7UIY0pXHrMmyskBmhCygN3op0/sVwAjdY8U/ML4kD7aG2uSrg/hqKSBt1uQmx5fhG+
         LcyctMQsJMv7ywYj1WKRJ7KyucYsTcw1yj+/gUvfqhfPavv37YH/x9QPEwJnerneu2U+
         yiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750199; x=1772354999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=degmio9cxdpzQuRYo2QvBbWquT2Pd1sYOKpzGMoeajE=;
        b=UFWANvE3uC17Ht2kxAAkr2KxE4DeJ/JHWqqfQFKB5t97BMuNoEOQaGIYCLBx8Yy87b
         1JbazzVffDzaszvjtPYi8jBBbDJHVBFfWqRf6lIgO81T0NQ4a0mb2BlzNuFJmJX0tQKL
         dwp1sqlu+qJZjirh5ao01i1BCa0FPbTZjDdo9kk7GNDBRk9+O94wGEh4JgVH7u6nJJJJ
         sJoKoPsJKFPKD6sXlEZoJ1HJsXdCaGf2Db2hOuDM9Kt32Lyb6Vv0xD/Ty9JARvc7Q4DH
         4ZM6nScRZGT6swVeOUitpKY+5tnTcfXQ/L/UylMVT9VPvlKsSey4Rm9IGvYXrYiik/ba
         jYVg==
X-Forwarded-Encrypted: i=1; AJvYcCVD3jtAi3oEpTjZFpBKXsjAZviej1tsFCOSGW5qy3nBu2wym3E9I302c4Bu7zfwl3xKxqby0aT0ikvVjjxgFkYXwDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMplOuH0Uxcrt1JP+TlcM6dLHc84j+MjXP+Krr0MQspcZsvWi
	VyqxncH/83cMpx2JHfZaLCJN+StJd1kS5hNUdigWymNF2ktgi+/h6OmTOi6YTQC7b7g=
X-Gm-Gg: AZuq6aJJ4ODVa5SNF90Wf6zKBUA6X78tt4GXok/oOuindFWqb7lflEoPpy5noOQ8m0M
	1dxiS2GG1wv32LB8hicz2b7w5rodac4oLBU67j5mf1A/CGw2h7V5R8syhNLklEXU5zfhls61sqt
	ljC/9pDbUYzQ3vJ/OzOQHEiNvxJtaW/rnJi0jRm4PGtS38n5CAN+WWDS2pozaS0/7P/5912uXQn
	ksp+DOxO7VFUH0SedLJ8f4FUkLM/9D91RLF0SngocFo3ZiDjai5++NaLMPH7K7EXbRDVicBu7nt
	M/b66hQbP3oa811OChQIwFfBW+iZl9jW0omZrihm9wo6isOrtnwYDTTASAmHkgptIyE5EuSfC46
	1Cf0k87Td6RHsv1ghbDy3t4q2UjudfVMPKnSm7mNScYvdZJ6ME7b9XY6jtzA61zD/1lXyOs/zoe
	gSM8Z2df3oy6FiLo3Yq2Fq3xGaOPfY+JsE7VXCWdl3dq8vb+qy28x5BmEY6fiBZHc8Sm+RZioO9
	uFyAVc/n0zJDzI=
X-Received: by 2002:a05:622a:1307:b0:502:9b85:a609 with SMTP id d75a77b69052e-5070bbf23bamr76760921cf.30.1771750199062;
        Sun, 22 Feb 2026 00:49:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:58 -0800 (PST)
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
Subject: [RFC PATCH v4 17/27] mm/oom: NP_OPS_OOM_ELIGIBLE - private node OOM participation
Date: Sun, 22 Feb 2026 03:48:32 -0500
Message-ID: <20260222084842.1824063-18-gourry@gourry.net>
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

The OOM killer must know whether killing a task can actually free
memory such that pressure is reduced.

A private node only contributes to relieving pressure if it participates
in both reclaim and demotion. Without this check, the check, the OOM
killer may select an undeserving victim.

Introduce NP_OPS_OOM_ELIGIBLE and helpers node_oom_eligible() and
zone_oom_eligible().

Replace cpuset_mems_allowed_intersects() in oom_cpuset_eligible()
with oom_mems_intersect() that iterates N_MEMORY nodes and skips
ineligible private nodes.

Update constrained_alloc() to use zone_oom_eligible() for constraint
detection and node_oom_eligible() to exclude ineligible nodes from
totalpages accounting.

Remove cpuset_mems_allowed_intersects() as it has no remaining callers.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h       |  9 -------
 include/linux/node_private.h |  3 +++
 kernel/cgroup/cpuset.c       | 17 ------------
 mm/oom_kill.c                | 52 ++++++++++++++++++++++++++++++++----
 4 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 7b2f3f6b68a9..53ccfb00b277 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -97,9 +97,6 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-					  const struct task_struct *tsk2);
-
 #ifdef CONFIG_CPUSETS_V1
 #define cpuset_memory_pressure_bump() 				\
 	do {							\
@@ -241,12 +238,6 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-						 const struct task_struct *tsk2)
-{
-	return 1;
-}
-
 static inline void cpuset_memory_pressure_bump(void) {}
 
 static inline void cpuset_task_status_allowed(struct seq_file *m,
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 34be52383255..34d862f09e24 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -141,6 +141,9 @@ struct node_private_ops {
 /* Kernel reclaim (kswapd, direct reclaim, OOM) operates on this node */
 #define NP_OPS_RECLAIM			BIT(4)
 
+/* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
+#define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
+
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
  *
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1a597f0c7c6c..29789d544fd5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4530,23 +4530,6 @@ int cpuset_mem_spread_node(void)
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
-/**
- * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
- * @tsk1: pointer to task_struct of some task.
- * @tsk2: pointer to task_struct of some other task.
- *
- * Description: Return true if @tsk1's mems_allowed intersects the
- * mems_allowed of @tsk2.  Used by the OOM killer to determine if
- * one of the task's memory usage might impact the memory available
- * to the other.
- **/
-
-int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-				   const struct task_struct *tsk2)
-{
-	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
-}
-
 /**
  * cpuset_print_current_mems_allowed - prints current's cpuset and mems_allowed
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5eb11fbba704..cd0d65ccd1e8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -74,7 +74,45 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 	return oc->memcg != NULL;
 }
 
+/* Private nodes are only eligible if they support both reclaim and demotion */
+static inline bool node_oom_eligible(int nid)
+{
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	return (node_private_flags(nid) & NP_OPS_OOM_ELIGIBLE) ==
+		NP_OPS_OOM_ELIGIBLE;
+}
+
+static inline bool zone_oom_eligible(struct zone *zone, gfp_t gfp_mask)
+{
+	if (!node_oom_eligible(zone_to_nid(zone)))
+		return false;
+	return cpuset_zone_allowed(zone, gfp_mask);
+}
+
 #ifdef CONFIG_NUMA
+/*
+ * Killing a task can only relieve system pressure if freed memory can be
+ * demoted there and reclaim can operate on the node's pages, so we
+ * omit private nodes that aren't eligible.
+ */
+static bool oom_mems_intersect(const struct task_struct *tsk1,
+			       const struct task_struct *tsk2)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (!node_isset(nid, tsk1->mems_allowed))
+			continue;
+		if (!node_isset(nid, tsk2->mems_allowed))
+			continue;
+		if (!node_oom_eligible(nid))
+			continue;
+		return true;
+	}
+	return false;
+}
+
 /**
  * oom_cpuset_eligible() - check task eligibility for kill
  * @start: task struct of which task to consider
@@ -107,9 +145,10 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 		} else {
 			/*
 			 * This is not a mempolicy constrained oom, so only
-			 * check the mems of tsk's cpuset.
+			 * check the mems of tsk's cpuset, excluding private
+			 * nodes that do not participate in kernel reclaim.
 			 */
-			ret = cpuset_mems_allowed_intersects(current, tsk);
+			ret = oom_mems_intersect(current, tsk);
 		}
 		if (ret)
 			break;
@@ -291,16 +330,19 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 		return CONSTRAINT_MEMORY_POLICY;
 	}
 
-	/* Check this allocation failure is caused by cpuset's wall function */
+	/* Check this allocation failure is caused by cpuset or private node constraints */
 	for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
 			highest_zoneidx, oc->nodemask)
-		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
+		if (!zone_oom_eligible(zone, oc->gfp_mask))
 			cpuset_limited = true;
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask(nid, cpuset_current_mems_allowed) {
+			if (!node_oom_eligible(nid))
+				continue;
 			oc->totalpages += node_present_pages(nid);
+		}
 		return CONSTRAINT_CPUSET;
 	}
 	return CONSTRAINT_NONE;
-- 
2.53.0

