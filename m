Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AF3CCFCA;
	Fri,  8 May 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257336; cv=none; b=I3Rznn8wBN9M1GRT9ztfCo+CyLP69swS0KboKTu7xGhrAbiOAXn3NadB9g7R9NtgK4jnSVofn3xs0hDQ9D8HxiD5POVKKrK0d/PNCieYjTSxW7ZDqOwOdnXfEufe2BVntrgMh0BPxU3lpU0lGRMU9rSTFASPV+Hp7GJudxZF7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257336; c=relaxed/simple;
	bh=1uMuGN04UYFs3z+YrwL58o6n66Bmk4tKC0/21HQOwpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4vm2QtqIsjRD11v7qGpJ+niHFunj2/A5P7roZNc6XnL+wllJhvGjPsREdL5PFyrp1QNuwCF6jSWZghOkAT0pbXlsR67iHd37OPrmxS6A2bGTPN16bentLKKORsMfEp6LKivTs8kQdHjcq0UGnVanKwO2e5ZuzHXODhO/oc7E0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6zcL0rJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6zcL0rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD07C2BCB0;
	Fri,  8 May 2026 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778257336;
	bh=1uMuGN04UYFs3z+YrwL58o6n66Bmk4tKC0/21HQOwpM=;
	h=From:To:Cc:Subject:Date:From;
	b=G6zcL0rJ8Qr/uA3lwhygDYoxgmjWaahp9qUo7LK4StbMtC/ZyGqIDbVsYTcf9/0sK
	 f9TJKVCw58sLiXS9+KDAr7mbuUYZV/qysOLLPmkE3+0gI21VEwm7YcFcJwwFvjrXvE
	 7aehZRqfgGbeXdkBfmgQjBVRzbZpP1g+vbFuD9UKuf0x/mEgrMSBMKrR26O5QebuzD
	 gjwIZjFX54weoAVo8kRzd7EkbyeDsPUbWnk2C9hD2wmhFSyUrjO1qUiTfj1xrfdfhZ
	 tsHlVrTy3k54IQqm15MSogoHD3rY2qh39iVjqLLdOu7p5kx6SeQAvz/8A9WrsH8/Om
	 Ixi2voU2uPsMQ==
From: hawk@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	hawk@kernel.org
Subject: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock acquisitions
Date: Fri,  8 May 2026 18:22:06 +0200
Message-ID: <20260508162207.3315781-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add tracepoints to the page allocator fast paths that acquire
zone->lock, allowing diagnosis of lock contention in production.

Three tracepoints are introduced:
  kmem:mm_zone_lock_contended - fires when trylock fails (lock is held)
  kmem:mm_zone_locked         - fires on every acquisition
  kmem:mm_zone_lock_unlock    - fires on every release

Each event records the NUMA node, zone name, batch count, and caller.
The mm_zone_locked event additionally records wait_ns: the time spent
spinning when contended, measured via local_clock() with IRQs disabled
to ensure accurate same-CPU timestamps.

The lock/unlock paths are wrapped in __zone_lock()/__zone_unlock()
helpers that use trylock-first to separate the contended and
uncontended cases.  Only the fast paths (free_pcppages_bulk,
rmqueue_bulk, free_one_page) are covered.  Other zone->lock holders
such as compaction, page isolation, and memory hotplug are not
instrumented.

For minimum overhead in production, enable only mm_zone_lock_contended
which fires only on actual contention.  Enable mm_zone_locked for
wait-time analysis, and add mm_zone_lock_unlock for hold-time
measurement.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/trace/events/kmem.h | 101 ++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  50 +++++++++++++++---
 2 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index cd7920c81f85..870c68c70d57 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -458,6 +458,107 @@ TRACE_EVENT(rss_stat,
 		__print_symbolic(__entry->member, TRACE_MM_PAGES),
 		__entry->size)
 	);
+
+/*
+ * Tracepoints for zone->lock on the page allocator fast paths only.
+ * Other code paths that acquire zone->lock (compaction, isolation,
+ * memory hotplug, vmstat, etc.) are not covered here.
+ *
+ * Three events:
+ *   mm_zone_lock_contended - trylock failed, about to spin
+ *   mm_zone_locked         - lock acquired, includes wait_ns when
+ *                            contended (zero otherwise)
+ *   mm_zone_lock_unlock    - lock released
+ *
+ * For production use with minimum overhead, enable only
+ * mm_zone_lock_contended -- it fires only when trylock detects the
+ * lock is already held.
+ *
+ * For wait-time analysis, enable mm_zone_locked -- its wait_ns
+ * field gives the spin duration directly.  Adding unlock allows
+ * hold-time measurement, at the cost of one event per acquisition.
+ */
+TRACE_EVENT(mm_zone_lock_contended,
+
+	TP_PROTO(struct zone *zone, int count, unsigned long caller),
+
+	TP_ARGS(zone, count, caller),
+
+	TP_STRUCT__entry(
+		__field(	int,		node_id		)
+		__string(	name,		zone->name	)
+		__field(	int,		count		)
+		__field(	unsigned long,	caller		)
+	),
+
+	TP_fast_assign(
+		__entry->node_id = zone_to_nid(zone);
+		__assign_str(name);
+		__entry->count = count;
+		__entry->caller = caller;
+	),
+
+	TP_printk("node=%d zone=%-8s count=%-5d caller=%pS",
+		  __entry->node_id, __get_str(name),
+		  __entry->count, (void *)__entry->caller)
+);
+
+TRACE_EVENT(mm_zone_locked,
+
+	TP_PROTO(struct zone *zone, int count, bool contended,
+		 unsigned long caller, u64 wait_ns),
+
+	TP_ARGS(zone, count, contended, caller, wait_ns),
+
+	TP_STRUCT__entry(
+		__field(	int,		node_id		)
+		__string(	name,		zone->name	)
+		__field(	int,		count		)
+		__field(	bool,		contended	)
+		__field(	unsigned long,	caller		)
+		__field(	u64,		wait_ns		)
+	),
+
+	TP_fast_assign(
+		__entry->node_id = zone_to_nid(zone);
+		__assign_str(name);
+		__entry->count = count;
+		__entry->contended = contended;
+		__entry->caller = caller;
+		__entry->wait_ns = wait_ns;
+	),
+
+	TP_printk("node=%d zone=%-8s count=%-5d contended=%d caller=%pS wait=%llu ns",
+		  __entry->node_id, __get_str(name),
+		  __entry->count, __entry->contended,
+		  (void *)__entry->caller, __entry->wait_ns)
+);
+
+TRACE_EVENT(mm_zone_lock_unlock,
+
+	TP_PROTO(struct zone *zone, int count, unsigned long caller),
+
+	TP_ARGS(zone, count, caller),
+
+	TP_STRUCT__entry(
+		__field(	int,		node_id		)
+		__string(	name,		zone->name	)
+		__field(	int,		count		)
+		__field(	unsigned long,	caller		)
+	),
+
+	TP_fast_assign(
+		__entry->node_id = zone_to_nid(zone);
+		__assign_str(name);
+		__entry->count = count;
+		__entry->caller = caller;
+	),
+
+	TP_printk("node=%d zone=%-8s count=%-5d caller=%pS",
+		  __entry->node_id, __get_str(name),
+		  __entry->count, (void *)__entry->caller)
+);
+
 #endif /* _TRACE_KMEM_H */
 
 /* This part must be outside protection */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 227d58dc3de6..08018e9beab4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/sched/clock.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
@@ -1447,6 +1448,43 @@ bool free_pages_prepare(struct page *page, unsigned int order)
 	return __free_pages_prepare(page, order, FPI_NONE);
 }
 
+/*
+ * Helper functions for locking zone->lock with tracepoints.
+ *
+ * This makes it easier to diagnose locking issues and contention in
+ * production environments.  The @count parameter indicates the number
+ * of pages being freed or allocated in the batch operation.
+ *
+ * For minimum overhead attach to kmem:mm_zone_lock_contended, which
+ * only gets activated when trylock detects lock is contended.
+ */
+static inline void
+__zone_lock(struct zone *zone, int count, unsigned long *flags)
+	__acquires(&zone->lock)
+{
+	unsigned long caller = _RET_IP_;
+	u64 wait_start, wait_time = 0;
+	bool contended;
+
+	local_irq_save(*flags);
+	contended = !spin_trylock(&zone->lock);
+	if (contended) {
+		wait_start = local_clock();
+		trace_mm_zone_lock_contended(zone, count, caller);
+		spin_lock(&zone->lock);
+		wait_time = local_clock() - wait_start;
+	}
+	trace_mm_zone_locked(zone, count, contended, caller, wait_time);
+}
+
+static inline void
+__zone_unlock(struct zone *zone, int count, unsigned long *flags)
+	__releases(&zone->lock)
+{
+	trace_mm_zone_lock_unlock(zone, count, _RET_IP_);
+	spin_unlock_irqrestore(&zone->lock, *flags);
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
@@ -1469,7 +1507,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	__zone_lock(zone, count, &flags);
 
 	while (count > 0) {
 		struct list_head *list;
@@ -1502,7 +1540,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (count > 0 && !list_empty(list));
 	}
 
-	spin_unlock_irqrestore(&zone->lock, flags);
+	__zone_unlock(zone, count, &flags);
 }
 
 /* Split a multi-block free page into its individual pageblocks. */
@@ -1551,7 +1589,7 @@ static void free_one_page(struct zone *zone, struct page *page,
 			return;
 		}
 	} else {
-		spin_lock_irqsave(&zone->lock, flags);
+		__zone_lock(zone, 1 << order, &flags);
 	}
 
 	/* The lock succeeded. Process deferred pages. */
@@ -1569,7 +1607,7 @@ static void free_one_page(struct zone *zone, struct page *page,
 		}
 	}
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
-	spin_unlock_irqrestore(&zone->lock, flags);
+	__zone_unlock(zone, 1 << order, &flags);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
@@ -2525,7 +2563,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (!spin_trylock_irqsave(&zone->lock, flags))
 			return 0;
 	} else {
-		spin_lock_irqsave(&zone->lock, flags);
+		__zone_lock(zone, count, &flags);
 	}
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2545,7 +2583,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 */
 		list_add_tail(&page->pcp_list, list);
 	}
-	spin_unlock_irqrestore(&zone->lock, flags);
+	__zone_unlock(zone, i, &flags);
 
 	return i;
 }
-- 
2.43.0

