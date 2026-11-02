Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646460;
	b=kc04t8zzMW9ZS2E+eBiH6//qTtlEutSqhLKF6gGkFEQa+R9f3B6Wr59Q7UsnT/CYWyEm
	 +byCa9UkGx+9HWk6jDJKO+mzI/wOu7GPOoxKStvP1fqq2z388TZN1fLofduMrG9sOpY/b
	 r0McxvBPIsP1QV+bCegkNN7tawrxh0m0wiP5xIzY+q/jod1kL8ME3YbBALkuOPiaLTC36
	 U042KxFQFzrr4pzRGTYHewE3znbTNOyOXnhTImzrtBRj7uuta125VS3IP6uuxEHeWWk99
	 R+IxToFqSv3iQQi9EWU3rV87k0N/TcPvAlKkbEpODFYIxOKp+Fvel2NIAm9Z9qPQlNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646460;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VkXsaoSLVTWJcVxptaLcb2Va32AkS9rqUKGJYDNNmz8=;
	b=nNp2JExpHNvIuEvjfEgnWz5PAyKtDS6oHVJCl2vqRZUx0VOaS4MN6yM5H9ImxBvVw+99
	 9DAX3JyGJ28UYLOM4HZY17T7/8WuRTaK4yLhZR/blvohLVajQatiOwWjtljKMjFMDp2Nt
	 /ktmGJBCqUXndo4UobucDL2RTO4ge+jleArN8JIE8MzY8Mtannnu9Kook0/81WYklwPWC
	 +zmifQy3iPvRoolXzyem6dqPNhS/1rtrhG3tNsOwm+lBfzW7VRDOQdP/wDXibtcqRNbtR
	 MS2dcg26jLnhb0CphZ/DtZqo2BlMyCaP4LPmo1+vhJ6mUKaTBN2mInajNZxhEHjLhkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uyG+7GMU;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183D606A329;
	Mon,  2 Nov 2026 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3183D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uyG+7GMU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793646452;
	bh=VkXsaoSLVTWJcVxptaLcb2Va32AkS9rqUKGJYDNNmz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyG+7GMU6LjVIp1P2ecUfqplG13tXvrkXn/ZzYJPVPEMKRmGvaj1Jb5+keQntLfty
	 h+371lPQEU1A6EDgDLMC26f/iui6Klx0x7+UVSeEORWKszRzEEWtvD2lR26C2MyV18
	 SBThvh/MWcoSL+Tp1Cw90Kj++MEhHZfrUydIfjqxLMG0X15980uKb9Z3whvxV/O0B9
	 8NS9UUwxJprG4mSfNv4vGMob5gEtu/LZdtfiTDcuJpg3b/H40f6mtVz11BRzuwrzzf
	 +t5umJEwnIoKYSFBhLtTLgd2ud5NhZdEGJM2/8lH1AltxXhiS3b9tSIEuNTi/DObSM
	 AqoCnVSwm6nvA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jJLn01KfBzKSL;
	Mon, 02 Nov 2026 14:07:32 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	David Carlier <devnexen@gmail.com>,
	Josh Law <objecting@objecting.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH v23 03/10] mm: use hierarchical per-cpu counters for the RSS counters
Date: Mon,  2 Nov 2026 14:07:01 -0500
Message-Id: <20261102190708.1287100-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
References: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
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

Use hierarchical per-cpu counters for RSS tracking to bound the inaccuracy
of the per-mm RSS approximation on large many-core systems [1].

The approximation is read by /proc/PID/stat (rss), by the RSS high
watermark (VmHWM in /proc/PID/status, getrusage() ru_maxrss, taskstats
hiwater_rss), by the taskstats integral RSS, by NUMA balancing to scale
its scan period, and by the mark_victim OOM tracepoint.
/proc/PID/status, /proc/PID/statm, the OOM killer and the rss_stat
tracepoint use precise sums, which iterate over all CPUs for each read:
the tracepoint since commit f1a7941243c1 ("mm: convert mm's rss stats
into percpu_counter"), and the others since commit 82241a83cd15 ("mm:
fix the inaccurate memory statistics issue for users") and
commit 5898aa8f9a0b ("mm: fix OOM killer inaccuracy on large many-core
systems").

Here is a (possibly incomplete) list of the prior approaches that were
used or proposed, along with their downside:

1) Per-thread rss tracking: large error on many-thread processes.

2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
   increased system time in make test workloads [1]. Moreover, the
   inaccuracy increases with O(n^2) with the number of CPUs.

3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
   error is high with systems that have lots of NUMA nodes (32 times
   the number of NUMA nodes).

4) Use a precise per-cpu counter sum for each counter value query:
   Requires iteration on each possible CPU for each sum, which
   adds overhead on large many-core systems running many processes.

The approach proposed here is to replace the per-cpu counters by the
hierarchical per-cpu counters, which bounds the inaccuracy based on the
system topology with O(N*logN).

* Testing results:

Test hardware: 2 sockets AMD EPYC 9654 96-Core Processor (384 logical CPUs)

Methodology:

Comparing the current upstream implementation with the hierarchical
counters is done with a debug patch, which keeps both implementations
wired up in parallel, and a test program, neither part of this series.
The single-process, single-threaded program hops randomly across CPUs in
the system, calling mmap(2) and munmap(2) on random CPUs, keeping track of
an array of 100000 mapping slots, randomly choosing slots to either map 1
to 16 pages or unmap them.

get_mm_counter() is instrumented to compare both counter approximations
to the precise value, and to record the largest delta of each.  The test
runs in a KVM guest with 384 vCPUs, each pinned to its own CPU of the test
hardware, with the NUMA topology of the host.

With the counters of this patch, before the single-threaded mode added
later in the series, the upstream implementation counter approximation
reaches an 830MB delta from the precise value within the first seconds,
while the mappings accumulate, compared to a 106MB delta with the
hierarchical counter.  The hierarchical counter approximation is
guaranteed to be within 158.5MB of the precise value in both directions
on that hardware topology, compared to 1.1GB for the upstream
implementation (384 CPUs * 767 pages).

* Fast path implementation comparison

The new percpu_counter_tree_add() updates a per-cpu byte with a
this_cpu_try_cmpxchg() loop on the fast path, like the upstream
percpu_counter_add_batch().  When the per-cpu residual reaches the batch
size, it calls a slow path which "trickles up" the carry to upper level
counters with atomic_add_return(), each of them keeping its own residual.

In comparison, the upstream percpu_counter_add_batch() takes a global
raw_spin_lock_irqsave() when reaching the batch size, and flushes the
whole per-cpu count into the global count.

The hierarchical implementation is therefore expected to have less
contention on mid-sized allocations than the upstream counters because
the atomic counters tracking those bits are each shared by a fraction of
the CPUs.

* Benchmarks

Using will-it-scale page_fault1 benchmarks to compare the upstream
counters to the hierarchical counters of this patch.  This is done with
hyperthreading disabled at runtime, so the counter tree keeps its shape
for 384 logical CPUs, while the upstream batch size follows the 192
online ones (384 instead of 768).  The differences are within the
boot-to-boot spread of up to 3%, and the multi-threaded runs, bound by
the mmap_lock, have a standard deviation of 5% to 11%: no regression is
measured, and no gain is claimed.  The numbers with the whole series are
in patch 7 and the cover letter.

                                          upstream   hierarchical     delta
page_fault1_processes -s 100 -t 1           544932         557092     +2.2%
page_fault1_threads -s 100 -t 1             547501         557742     +1.9%
page_fault1_processes -s 100 -t 96        37374404       37580199     +0.6%
page_fault1_threads -s 100 -t 96           2311884        2299998     -0.5%
page_fault1_processes -s 100 -t 192       69491758       70590309     +1.6%
page_fault1_threads -s 100 -t 192          2284108        2271423     -0.6%

* Memory Use

Each mm_struct holds NR_MM_COUNTERS (4) counters, initialized together
by percpu_counter_tree_init_many() with a batch size of 32, so their tree
items share cache lines.  Per mm, on a 64-bit arch with 64-byte cache
lines, compared to the upstream percpu counters, along with the maximum
inaccuracy of each counter in pages:

                  Bytes per mm         Accuracy (pages)
  nr_cpus fan-out    hpcc  upstream      hpcc    upstream
        2 2           200       192      +-62        +-62
       16 16          256       416     +-496       +-496
       64 16,4        704      1184    +-3904      +-8128
      128 8,16       1728      2208    +-7552     +-32640
      256 8,4,8      3776      4256   +-21248    +-130816
      384 8,8,8      6336      6304   +-40576    +-294528
      512 8,8,8      6848      8352   +-44544    +-523776
     1024 8,8,16    13504     16544   +-89088   +-2096128
     4096 8,8,8,8   53952     65696  +-471040  +-33550336

This counts the 4 counter structures, their per-cpu data, and the tree
items, without the rounding of the slab cache holding them.  The
fan-out is listed from the per-cpu counters to the root.  Up to 32 CPUs,
the tree is flat.  Up to 16 CPUs, its accuracy matches the upstream
counters, whose batch size of max(32, 2 * nr_cpus) grows beyond, making
them less accurate than the hierarchical counters, except from 33 to 39
CPUs, where the intermediate counters of the 16,4 tree make the
hierarchical counters up to 1.37 times less accurate.

The hierarchical counters use less memory than the upstream counters
from 3 to 64 CPUs.  The tree is shaped for nr_cpus rounded up to a power
of 2: when nr_cpus is a power of 2, they also use less memory beyond 64
CPUs (at most 0.89 times as much).  Between powers of 2, fewer CPUs
share the cost of the tree items: 1.01 times at 384 logical CPUs, 1.09
at 192 and 0.94 at 96, and up to 1.47 times just above a power of 2 (at
129 CPUs, 1.23 at 65 and 1.36 at 257).

* mm_struct layout

percpu_counter_tree_init_many() allocates the per-cpu data and the tree
items of the RSS counters, so their size in mm_struct does not depend on
the number of CPUs: struct mm_struct shrinks by 32 bytes, as a struct
percpu_counter_tree is 32 bytes, compared to 40 for a struct
percpu_counter.

* rss_stat tracepoint

The rss_stat tracepoint keeps reporting the precise sum, now computed
from the hierarchical per-cpu counter.

Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
Link: https://lkml.kernel.org/r/20260227153730.1556542-4-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
Changes since v22:
- The library allocates the per-cpu counters and the tree items of the
  RSS counters: mm_struct holds no tree items, and the static init_mm
  and efi_mm need no change.
- check_mm(): sum each RSS counter once.
- Keep reporting the precise sum in the rss_stat tracepoint. Switching
  it to the approximation is done by a separate patch.
- Initialize the 4 RSS counters together so their tree items share cache
  lines.
- Fix checkpatch warnings.
---
 include/linux/mm.h          | 10 +++++-----
 include/linux/mm_types.h    |  3 ++-
 include/trace/events/kmem.h |  3 +--
 kernel/fork.c               | 13 +++++++++----
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f167950926a..36242c7ff84f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3607,33 +3607,33 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	return percpu_counter_tree_approximate_sum_positive(&mm->rss_stat[member]);
 }
 
 static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
 {
-	return percpu_counter_sum_positive(&mm->rss_stat[member]);
+	return percpu_counter_tree_precise_sum_positive(&mm->rss_stat[member]);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	percpu_counter_add(&mm->rss_stat[member], value);
+	percpu_counter_tree_add(&mm->rss_stat[member], value);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_inc(&mm->rss_stat[member]);
+	percpu_counter_tree_add(&mm->rss_stat[member], 1);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_dec(&mm->rss_stat[member]);
+	percpu_counter_tree_add(&mm->rss_stat[member], -1);
 
 	mm_trace_rss_stat(mm, member);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e..20b4517b7329 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu_counter_tree.h>
 #include <linux/types.h>
 #include <linux/futex_types.h>
 #include <linux/rseq_types.h>
@@ -1350,7 +1351,7 @@ struct mm_struct {
 		unsigned long saved_e_flags;
 #endif
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+		struct percpu_counter_tree rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index cd7920c81f85..ac4c96db7638 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -448,8 +448,7 @@ TRACE_EVENT(rss_stat,
 		 */
 		__entry->curr = current->mm == mm && !(current->flags & PF_KTHREAD);
 		__entry->member = member;
-		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
-							    << PAGE_SHIFT);
+		__entry->size = get_mm_counter_sum(mm, member) << PAGE_SHIFT;
 	),
 
 	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
diff --git a/kernel/fork.c b/kernel/fork.c
index 8b108ed37152..02e25115ff85 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -137,6 +137,11 @@
  */
 #define MAX_THREADS FUTEX_TID_MASK
 
+/*
+ * Batch size of rss stat approximation
+ */
+#define RSS_STAT_BATCH_SIZE	32
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -633,7 +638,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
+		long x = percpu_counter_tree_precise_sum(&mm->rss_stat[i]);
 
 		if (unlikely(x)) {
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
@@ -738,7 +743,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
-	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	percpu_counter_tree_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
 
 	free_mm(mm);
 }
@@ -1143,8 +1148,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 	if (mm_alloc_sched(mm))
 		goto fail_sched;
 
-	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
-				     NR_MM_COUNTERS))
+	if (percpu_counter_tree_init_many(mm->rss_stat, NR_MM_COUNTERS, RSS_STAT_BATCH_SIZE,
+					  GFP_KERNEL_ACCOUNT))
 		goto fail_pcpu;
 
 	lru_gen_init_mm(mm);
-- 
2.47.3

