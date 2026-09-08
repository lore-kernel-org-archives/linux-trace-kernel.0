Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200148F03D;
	Tue,  8 Sep 2026 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905453; cv=none; b=lE8gQSUsgmj6KEbDu4ZVDjbLPC6UytAtF7MoZN5fKqOT3qFGAlbT4d0WN1yC/TvRdi6QMbNtLJfKgdmnFbsOUbtTCO3DPn/Lg4yYw4UkLNSnWY0PaAEbe3YjQuNzbro9ea1uS+wgVxc/s8FSqfBPwVLmTvumgaqmOGbyhAfJx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905453; c=relaxed/simple;
	bh=gNYBg64ihDGtf5THFQ2b/ZNLa33YAv+/Ti3B+Op9leE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m19BOGju4NYHQjhvtHHHz+OPdzUq+3YLUCBWQo5ncVEUR9jYrKXqlEzF+pXZ5Z8GomRNlQQRJrz1bJ/RD//Yv0aI3HbNG5acc4T9KhenpHXCkprZgLQ5TV65A4YmhRVDxcO1vJKFGUTU9ja8C4I0cg4SSzzlLXGVYAiEPLT58mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNj/+fty; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNj/+fty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788905446; x=1820441446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNYBg64ihDGtf5THFQ2b/ZNLa33YAv+/Ti3B+Op9leE=;
  b=UNj/+ftyQIvcPLhS4qpd0Q12W7d3Kohzx+GnAEoBdsTBbw0KwqaBLCbe
   +L2cwggt5BK+Olwt2cblEzxEjFX1qBSt3k/JJpABdZ+B8T4/poC6ls2th
   wFO/EMlEsJlPuaqVOkRXzEeKpmV1LvCYapwZrSUHl67IOaUnpe4+1a5bS
   8LmjlW80XbKqKcdt22Za1XArt8Hsp/fh1V4fSXI2k2AjLW8tspR3oJqDZ
   Rbmj0FFL/hYoeWYq7Fz+4hVHtt93cAYT3zdHvk+SSjTg2F3D9ZkWM+qhQ
   mG/2+GdV2V9jdzNUyRyaYK3F4LqyjQNJvF3jWKs82gxK8OMdq/AomiSAV
   A==;
X-CSE-ConnectionGUID: CFnhXnlZR1KMmAW4Oz7TWQ==
X-CSE-MsgGUID: i+G2CNCuTMWAkGZSZUjc/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93017415"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="93017415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:10:24 -0700
X-CSE-ConnectionGUID: D8jD6GWwQjyo1jI6K4BK0w==
X-CSE-MsgGUID: pSgrYWolT5iCKE8Rsglgqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="296067800"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 08 Sep 2026 15:10:23 -0700
From: Ehab Ababneh <ehab.ababneh@intel.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Thomas Ballasi <tballasi@linux.microsoft.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Bunyod Suvonov <b.suvonov@sjtu.edu.cn>,
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [RFC PATCH 3/3] mm/vmscan: make kswapd wakeups NUMA load-aware
Date: Tue,  8 Sep 2026 15:10:56 -0700
Message-ID: <20260908221059.14777-4-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908221059.14777-1-ehab.ababneh@intel.com>
References: <20260908221059.14777-1-ehab.ababneh@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track a per-node 10-second rolling average of idle CPU cores and use
it in wakeup_kswapd() to decide how many kswapd threads to wake.

A background worker samples the number of idle cores on each NUMA node
once per second (node_cores - nr_running, clamped to zero) and maintains
a rolling average over a 10-second window. When memory pressure triggers
a wakeup, the number of kswapd threads woken is capped to that average
so reclaim scales with available CPU capacity.

On a lightly loaded node most cores are idle, so more threads wake and
reclaim can proceed quickly. On a saturated node few cores are idle, so
fewer threads wake, avoiding unnecessary scheduling contention that
would compete with the workload already running there.

Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 include/trace/events/vmscan.h |  28 +++
 mm/internal.h                 |   4 +-
 mm/page_alloc.c               |  16 +-
 mm/vmscan.c                   | 340 ++++++++++++++++++++++++++++++++--
 4 files changed, 359 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index b4bf7b8def1f..e4b10417fbb6 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -174,6 +174,34 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 		show_gfp_flags(__entry->gfp_flags))
 );
 
+TRACE_EVENT(mm_vmscan_kswapd_threads_to_wake,
+
+	TP_PROTO(int nid, int threads_to_wake, int node_cpus,
+		 int avg_idle_cores),
+
+	TP_ARGS(nid, threads_to_wake, node_cpus, avg_idle_cores),
+
+	TP_STRUCT__entry(
+		__field(int,	nid)
+		__field(int,	threads_to_wake)
+		__field(int,	node_cpus)
+		__field(int,	avg_idle_cores)
+	),
+
+	TP_fast_assign(
+		__entry->nid			= nid;
+		__entry->threads_to_wake	= threads_to_wake;
+		__entry->node_cpus		= node_cpus;
+		__entry->avg_idle_cores		= avg_idle_cores;
+	),
+
+	TP_printk("nid=%d threads_to_wake=%d node_cpus=%d avg_idle_cores=%d",
+		  __entry->nid,
+		  __entry->threads_to_wake,
+		  __entry->node_cpus,
+		  __entry->avg_idle_cores)
+);
+
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
 	TP_PROTO(gfp_t gfp_flags, int order, struct mem_cgroup *memcg),
diff --git a/mm/internal.h b/mm/internal.h
index 1c4cc3b7492b..94cebde4db05 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -645,13 +645,13 @@ extern char * const zone_names[MAX_NR_ZONES];
 /* perform sanity checks on struct pages being allocated or freed */
 DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
-extern int kswapd_threads;
+extern int max_kswapds_per_node;
 extern int max_kswapd_threads;
 extern int min_free_kbytes;
 extern int defrag_mode;
 
 void setup_per_zone_wmarks(void);
-void update_kswapd_threads(void);
+void update_max_kswapds_per_node(void);
 void calculate_min_free_kbytes(void);
 int __meminit init_per_zone_wmark_min(void);
 void page_alloc_sysctl_init(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index abecf96a599b..64178fcef1d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6615,9 +6615,9 @@ static int min_free_kbytes_sysctl_handler(const struct ctl_table *table, int wri
 	return 0;
 }
 
-static int kswapd_threads_sysctl_handler(const struct ctl_table *table,
-					 int write, void __user *buffer,
-					 size_t *length, loff_t *ppos)
+static int max_kswapds_per_node_sysctl_handler(const struct ctl_table *table,
+					       int write, void __user *buffer,
+					       size_t *length, loff_t *ppos)
 {
 	int rc;
 
@@ -6626,7 +6626,7 @@ static int kswapd_threads_sysctl_handler(const struct ctl_table *table,
 		return rc;
 
 	if (write)
-		update_kswapd_threads();
+		update_max_kswapds_per_node();
 
 	return 0;
 }
@@ -6794,11 +6794,11 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
-		.procname       = "kswapd_threads",
-		.data           = &kswapd_threads,
-		.maxlen         = sizeof(kswapd_threads),
+		.procname       = "max_kswapds_per_node",
+		.data           = &max_kswapds_per_node,
+		.maxlen         = sizeof(max_kswapds_per_node),
 		.mode           = 0644,
-		.proc_handler   = kswapd_threads_sysctl_handler,
+		.proc_handler   = max_kswapds_per_node_sysctl_handler,
 		.extra1         = SYSCTL_ONE,
 		.extra2         = &max_kswapd_threads,
 	},
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ad2b398a68f9..1a53ebd9ca22 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -32,6 +32,7 @@
 #include <linux/rmap.h>
 #include <linux/topology.h>
 #include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpuset.h>
 #include <linux/compaction.h>
 #include <linux/notifier.h>
@@ -58,12 +59,14 @@
 #include <linux/random.h>
 #include <linux/mmu_notifier.h>
 #include <linux/parser.h>
+#include <linux/smp.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
 #include <linux/sched/sysctl.h>
+#include <linux/slab.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -180,11 +183,283 @@ struct scan_control {
 };
 
 /*
- * Number of active kswapd threads
+ * Max and current number of kswapd threads per node.
  */
-#define DEF_KSWAPD_THREADS_PER_NODE 1
-int kswapd_threads = DEF_KSWAPD_THREADS_PER_NODE;
-int kswapd_threads_current = DEF_KSWAPD_THREADS_PER_NODE;
+#define DEF_MAX_KSWAPDS_PER_NODE 1
+int max_kswapds_per_node = DEF_MAX_KSWAPDS_PER_NODE;
+int current_kswapds_per_node = DEF_MAX_KSWAPDS_PER_NODE;
+
+#ifdef CONFIG_NUMA
+/*
+ * Per-node 10-second rolling average of idle CPU cores.
+ * Sampled once per second; used by wakeup_kswapd() to decide how many
+ * kswapd threads to wake without adding contention on a loaded node.
+ */
+#define KSWAPD_NUMA_AVG_WINDOW	10
+
+struct kswapd_node_idle_avg {
+	u32	samples[KSWAPD_NUMA_AVG_WINDOW];
+	u32	sum;
+	u8	idx;
+	u8	count;
+	u32	avg_idle_cores;	/* rolling average, written only by the work item */
+	int	nid;
+	int	node_cpus;	/* updated by cpuhp callbacks */
+	bool	started;
+	u64	last_sample_ns;
+	struct delayed_work work;
+};
+
+static struct kswapd_node_idle_avg *kswapd_idle_avg;
+static u64 *kswapd_prev_idle;
+static bool *kswapd_prev_idle_valid;
+
+static int kswapd_node_first_online_cpu(int nid)
+{
+	return cpumask_first_and(cpumask_of_node(nid), cpu_online_mask);
+}
+
+static u64 kswapd_read_idle_cpu(int cpu)
+{
+	if (!cpu_online(cpu))
+		return 0;
+
+	return kcpustat_field_idle(cpu);
+}
+
+static void kswapd_idle_avg_queue_work(struct kswapd_node_idle_avg *avg)
+{
+	int cpu;
+
+	cpu = kswapd_node_first_online_cpu(avg->nid);
+	if (cpu < nr_cpu_ids)
+		queue_delayed_work_on(cpu, system_wq, &avg->work, HZ);
+}
+
+static void kswapd_idle_avg_sample_workfn(struct work_struct *work)
+{
+	struct kswapd_node_idle_avg *avg;
+	u64 now_ns, elapsed_ns;
+	u64 idle_cores_milli = 0;
+	u32 idle_cores;
+	int cpu, node_cpus;
+
+	if (!kswapd_idle_avg || !kswapd_prev_idle || !kswapd_prev_idle_valid)
+		return;
+
+	avg = container_of(to_delayed_work(work), struct kswapd_node_idle_avg,
+			   work);
+	node_cpus = 0;
+	now_ns = ktime_get_ns();
+
+	if (!avg->last_sample_ns) {
+		avg->last_sample_ns = now_ns;
+		for_each_cpu(cpu, cpumask_of_node(avg->nid)) {
+			if (!cpu_online(cpu))
+				continue;
+			kswapd_prev_idle[cpu] = kswapd_read_idle_cpu(cpu);
+			kswapd_prev_idle_valid[cpu] = true;
+		}
+		kswapd_idle_avg_queue_work(avg);
+		return;
+	}
+
+	elapsed_ns = now_ns - avg->last_sample_ns;
+	avg->last_sample_ns = now_ns;
+
+	if (!elapsed_ns) {
+		kswapd_idle_avg_queue_work(avg);
+		return;
+	}
+
+	for_each_cpu(cpu, cpumask_of_node(avg->nid)) {
+		u64 idle_now, idle_delta;
+
+		if (!cpu_online(cpu))
+			continue;
+
+		node_cpus++;
+		idle_now = kswapd_read_idle_cpu(cpu);
+
+		if (!kswapd_prev_idle_valid[cpu]) {
+			kswapd_prev_idle_valid[cpu] = true;
+			kswapd_prev_idle[cpu] = idle_now;
+			continue;
+		}
+
+		idle_delta = idle_now - kswapd_prev_idle[cpu];
+		kswapd_prev_idle[cpu] = idle_now;
+
+		idle_cores_milli += div_u64(min(idle_delta, elapsed_ns) * 1000,
+						   elapsed_ns);
+	}
+
+	idle_cores = min_t(u32, DIV_ROUND_CLOSEST_ULL(idle_cores_milli, 1000),
+			   node_cpus);
+
+	if (avg->count == KSWAPD_NUMA_AVG_WINDOW)
+		avg->sum -= avg->samples[avg->idx];
+	else
+		avg->count++;
+
+	avg->samples[avg->idx] = idle_cores;
+	avg->sum += idle_cores;
+	avg->idx = (avg->idx + 1) % KSWAPD_NUMA_AVG_WINDOW;
+	WRITE_ONCE(avg->avg_idle_cores, DIV_ROUND_CLOSEST(avg->sum, avg->count));
+
+	if (READ_ONCE(avg->started))
+		kswapd_idle_avg_queue_work(avg);
+}
+
+static void kswapd_idle_avg_start_node(int nid)
+{
+	struct kswapd_node_idle_avg *avg;
+
+	if (!kswapd_idle_avg || nid < 0 || nid >= nr_node_ids)
+		return;
+
+	avg = &kswapd_idle_avg[nid];
+	if (READ_ONCE(avg->started))
+		return;
+
+	WRITE_ONCE(avg->started, true);
+	avg->last_sample_ns = 0;
+	kswapd_idle_avg_queue_work(avg);
+}
+
+static void kswapd_idle_avg_stop_node(int nid)
+{
+	struct kswapd_node_idle_avg *avg;
+	int cpu;
+
+	if (!kswapd_idle_avg || nid < 0 || nid >= nr_node_ids)
+		return;
+
+	avg = &kswapd_idle_avg[nid];
+	if (!READ_ONCE(avg->started))
+		return;
+
+	WRITE_ONCE(avg->started, false);
+	cancel_delayed_work_sync(&avg->work);
+
+	for_each_cpu(cpu, cpumask_of_node(nid))
+		kswapd_prev_idle_valid[cpu] = false;
+}
+
+static int kswapd_idle_avg_cpu_online(unsigned int cpu)
+{
+	if (kswapd_prev_idle_valid)
+		kswapd_prev_idle_valid[cpu] = false;
+
+	if (kswapd_idle_avg) {
+		int nid = cpu_to_node(cpu);
+
+		WRITE_ONCE(kswapd_idle_avg[nid].node_cpus,
+			   cpumask_weight_and(cpumask_of_node(nid), cpu_online_mask));
+	}
+
+	return 0;
+}
+
+static int kswapd_idle_avg_cpu_offline(unsigned int cpu)
+{
+	if (kswapd_prev_idle_valid)
+		kswapd_prev_idle_valid[cpu] = false;
+
+	if (kswapd_idle_avg) {
+		int nid = cpu_to_node(cpu);
+
+		WRITE_ONCE(kswapd_idle_avg[nid].node_cpus,
+			   cpumask_weight_and(cpumask_of_node(nid), cpu_online_mask));
+	}
+
+	return 0;
+}
+
+static u32 kswapd_node_avg_idle_cores(int nid)
+{
+	if (!kswapd_idle_avg || nid < 0 || nid >= nr_node_ids)
+		return 0;
+
+	return READ_ONCE(kswapd_idle_avg[nid].avg_idle_cores);
+}
+
+static int kswapd_node_cpu_count(int nid)
+{
+	if (!kswapd_idle_avg || nid < 0 || nid >= nr_node_ids)
+		return cpumask_weight_and(cpumask_of_node(nid), cpu_online_mask);
+
+	return READ_ONCE(kswapd_idle_avg[nid].node_cpus);
+}
+
+static void kswapd_idle_avg_init(void)
+{
+	int cpu;
+	int nid;
+	int ret;
+
+	kswapd_idle_avg = kcalloc(nr_node_ids, sizeof(*kswapd_idle_avg),
+				  GFP_KERNEL);
+	if (!kswapd_idle_avg)
+		return;
+
+	kswapd_prev_idle = kcalloc(nr_cpu_ids, sizeof(*kswapd_prev_idle),
+				   GFP_KERNEL);
+	if (!kswapd_prev_idle)
+		goto free_idle_avg;
+
+	kswapd_prev_idle_valid = kcalloc(nr_cpu_ids,
+					 sizeof(*kswapd_prev_idle_valid),
+					 GFP_KERNEL);
+	if (!kswapd_prev_idle_valid)
+		goto free_prev_idle;
+
+	for (nid = 0; nid < nr_node_ids; nid++) {
+		struct kswapd_node_idle_avg *avg = &kswapd_idle_avg[nid];
+
+		avg->nid = nid;
+		INIT_DELAYED_WORK(&avg->work, kswapd_idle_avg_sample_workfn);
+	}
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"mm/vmscan:online",
+					kswapd_idle_avg_cpu_online,
+					kswapd_idle_avg_cpu_offline);
+	if (ret < 0)
+		goto free_prev_idle_valid;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		kswapd_idle_avg_cpu_online(cpu);
+	cpus_read_unlock();
+
+	return;
+
+free_prev_idle_valid:
+	kfree(kswapd_prev_idle_valid);
+	kswapd_prev_idle_valid = NULL;
+free_prev_idle:
+	kfree(kswapd_prev_idle);
+	kswapd_prev_idle = NULL;
+free_idle_avg:
+	kfree(kswapd_idle_avg);
+	kswapd_idle_avg = NULL;
+}
+#else
+static inline u32 kswapd_node_avg_idle_cores(int nid)
+{
+	return 0;
+}
+
+static inline int kswapd_node_cpu_count(int nid)
+{
+	return cpumask_weight_and(cpumask_of_node(nid), cpu_online_mask);
+}
+
+static inline void kswapd_idle_avg_init(void) {}
+static inline void kswapd_idle_avg_start_node(int nid) {}
+static inline void kswapd_idle_avg_stop_node(int nid) {}
+#endif /* CONFIG_NUMA */
 
 #ifdef ARCH_HAS_PREFETCHW
 #define prefetchw_prev_lru_folio(_folio, _base, _field)			\
@@ -7490,6 +7765,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 {
 	pg_data_t *pgdat;
 	enum zone_type curr_idx;
+	int nid, threads_to_wake;
+	int node_cpus, avg_idle_cores;
 
 	if (!managed_zone(zone))
 		return;
@@ -7527,7 +7804,28 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
 				      gfp_flags);
-	wake_up_interruptible(&pgdat->kswapd_wait);
+
+	/* Determine how many kswapd threads to wake based on the 10-second
+	 * rolling average of idle cores on this NUMA node. More idle cores
+	 * means more threads can run without adding contention; fewer idle
+	 * cores means we keep the wakeup conservative.
+	 */
+	nid = pgdat->node_id;
+	avg_idle_cores = kswapd_node_avg_idle_cores(nid);
+	node_cpus = kswapd_node_cpu_count(nid);
+
+	/*
+	 * If no average is available yet (early boot), fall back to waking
+	 * a single thread to avoid stalling reclaim.
+	 */
+	threads_to_wake = max(1,
+			      min3(avg_idle_cores, node_cpus,
+				   READ_ONCE(current_kswapds_per_node)));
+
+	wake_up_nr(&pgdat->kswapd_wait, threads_to_wake);
+
+	trace_mm_vmscan_kswapd_threads_to_wake(nid, threads_to_wake, node_cpus,
+					       avg_idle_cores);
 }
 
 void kswapd_clear_hopeless(pg_data_t *pgdat, enum kswapd_clear_hopeless_reason reason)
@@ -7595,18 +7893,18 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 }
 #endif /* CONFIG_HIBERNATION */
 
-static void update_kswapd_threads_node(int nid)
+static void update_kswapds_per_node_node(int nid)
 {
 	pg_data_t *pgdat;
 	int drop, increase;
 	int last_idx, start_idx, hid;
-	int nr_threads = kswapd_threads_current;
+	int nr_threads = current_kswapds_per_node;
 
 	pgdat = NODE_DATA(nid);
 	pgdat_kswapd_lock(pgdat);
 	last_idx = nr_threads - 1;
-	if (kswapd_threads < nr_threads) {
-		drop = nr_threads - kswapd_threads;
+	if (max_kswapds_per_node < nr_threads) {
+		drop = nr_threads - max_kswapds_per_node;
 		for (hid = last_idx; hid > (last_idx - drop); hid--) {
 			if (pgdat->kswapd[hid]) {
 				kthread_stop(pgdat->kswapd[hid]);
@@ -7614,7 +7912,7 @@ static void update_kswapd_threads_node(int nid)
 			}
 		}
 	} else {
-		increase = kswapd_threads - nr_threads;
+		increase = max_kswapds_per_node - nr_threads;
 		start_idx = last_idx + 1;
 		for (hid = start_idx; hid < (start_idx + increase); hid++) {
 			pgdat->kswapd[hid] = kthread_run(kswapd, pgdat, "kswapd%d:%d",
@@ -7633,11 +7931,11 @@ static void update_kswapd_threads_node(int nid)
 	pgdat_kswapd_unlock(pgdat);
 }
 
-void update_kswapd_threads(void)
+void update_max_kswapds_per_node(void)
 {
 	int nid;
 
-	if (kswapd_threads_current == kswapd_threads)
+	if (current_kswapds_per_node == max_kswapds_per_node)
 		return;
 
 	/*
@@ -7646,11 +7944,11 @@ void update_kswapd_threads(void)
 	 */
 	mem_hotplug_begin();
 	for_each_node_state(nid, N_MEMORY)
-		update_kswapd_threads_node(nid);
+		update_kswapds_per_node_node(nid);
 
-	pr_info("kswapd_thread count changed, old:%d new:%d\n",
-		kswapd_threads_current, kswapd_threads);
-	kswapd_threads_current = kswapd_threads;
+	pr_info("max_kswapds_per_node changed, old:%d new:%d\n",
+		current_kswapds_per_node, max_kswapds_per_node);
+	current_kswapds_per_node = max_kswapds_per_node;
 	mem_hotplug_done();
 }
 
@@ -7663,7 +7961,7 @@ void __meminit kswapd_run(int nid)
 	int hid, nr_threads;
 
 	pgdat_kswapd_lock(pgdat);
-	nr_threads = kswapd_threads;
+	nr_threads = max_kswapds_per_node;
 	for (hid = 0; hid < nr_threads; hid++) {
 		if (!pgdat->kswapd[hid]) {
 			pgdat->kswapd[hid] =
@@ -7679,8 +7977,9 @@ void __meminit kswapd_run(int nid)
 			}
 		}
 	}
-	kswapd_threads_current = nr_threads;
+	current_kswapds_per_node = nr_threads;
 	pgdat_kswapd_unlock(pgdat);
+	kswapd_idle_avg_start_node(nid);
 }
 
 /*
@@ -7691,7 +7990,9 @@ void __meminit kswapd_stop(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	int hid;
-	int nr_threads = kswapd_threads_current;
+	int nr_threads = current_kswapds_per_node;
+
+	kswapd_idle_avg_stop_node(nid);
 
 	pgdat_kswapd_lock(pgdat);
 	for (hid = 0; hid < nr_threads; hid++) {
@@ -7730,6 +8031,7 @@ static int __init kswapd_init(void)
 	int nid;
 
 	swap_setup();
+	kswapd_idle_avg_init();
 	for_each_node_state(nid, N_MEMORY)
  		kswapd_run(nid);
 	register_sysctl_init("vm", vmscan_sysctl_table);
-- 
2.43.0

