Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFB1DE3BE;
	Mon, 31 Mar 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743460584; cv=none; b=MyMaS6QwSA36QurhF+Zan7nGiv/DgQ/OGw1+T7VRhJjFcjGAbZCT201jR+yMtsJZhUODDSuVMBWyYm8rqBuUKw00iquIP2dnVI2dLNNmlf2OcjyonSzEYoTPRsXagCV8s+fc5s5kQxJef0my1o6J61ieKwb9nOyc7n5+ECkUYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743460584; c=relaxed/simple;
	bh=2lAD1P+Ycq01hmPeWnFVMjDM5l+lqq+xPQLwhRtP4cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnDEewu++mcBFEer1Vj5bAOHUAZ7+anolLmlwNwyha2ddl3pVZuihYd3XSN3lcCSxJUnHlYwObJcIsn90sTQXpSXLNLT3EpL9YXWzQ+kmy7GAbFopncRF92najh1N/kZtN5NU1v187vt6zTmAK8SzIdR0kWFmOMFa4Wy1UjdA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=WHy1thQO; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="WHy1thQO"
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 71A46827B2;
	Mon, 31 Mar 2025 18:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1743460575; bh=2lAD1P+Ycq01hmPeWnFVMjDM5l+lqq+xPQLwhRtP4cU=;
	h=From:To:Cc:Subject:Date:From;
	b=WHy1thQO9sDrhIoG9qZVnrkhlPgmBEviqRYvoasPXNqBgjLabX4NhEXaJbN8pWqko
	 0nLh+ZtHYARkv201X1/OsuDYqg6nSIZralUjLYfP6brRn/Px1Op7jw19xySaGgiSoJ
	 ZI5eeDOmg0tSHB6G50374yB3MIhlS0hcjGKcT7eYInb6Cr3gGZTSLYiOCSkIDpjcv/
	 H7LgKthqWB7qYB3sMasoYVMrYInNVBQY8w0MRmkgWyYpJo3Pyp5+GjSXTWQkFF0Bn5
	 hS6Y9odRNrD2K/jrZLekcCbRmAIp5p8RpMyGfWMdps+lfV12+CZI6xlKiunGkXTaDr
	 obkr6YGWEaEUw==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
Date: Mon, 31 Mar 2025 18:35:14 -0400
Message-ID: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Resend as requested as RFC and minus prereq-patch-id junk]

Recently, several internal services had an RSS usage regression as part of a
kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
read RSS statistics in a backup watchdog process to monitor and decide if
they'd overrun their memory budget. Now, however, a representative service
with five threads, expected to use about a hundred MB of memory, on a 250-cpu
machine had memory usage tens of megabytes different from the expected amount
-- this constituted a significant percentage of inaccuracy, causing the
watchdog to act.

This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter") [1].  Previously, the memory error was bounded by
64*nr_threads pages, a very livable megabyte. Now, however, as a result of
scheduler decisions moving the threads around the CPUs, the memory error could
be as large as a gigabyte.

This is a really tremendous inaccuracy for any few-threaded program on a
large machine and impedes monitoring significantly. These stat counters are
also used to make OOM killing decisions, so this additional inaccuracy could
make a big difference in OOM situations -- either resulting in the wrong
process being killed, or in less memory being returned from an OOM-kill than
expected.

Finally, while the change to percpu_counter does significantly improve the
accuracy over the previous per-thread error for many-threaded services, it does
also have performance implications - up to 12% slower for short-lived processes
and 9% increased system time in make test workloads [2].

A previous attempt to address this regression by Peng Zhang [3] used a hybrid
approach with delayed allocation of percpu memory for rss_stats, showing
promising improvements of 2-4% for process operations and 6.7% for page
faults.

This RFC takes a different direction by replacing percpu_counters with a
more efficient set of per-NUMA-node atomics. The approach:

- Uses one atomic per node up to a bound to reduce cross-node updates.
- Keeps a similar batching mechanism, with a smaller batch size.
- Eliminates the use of a spin lock during batch updates, bounding stat
  update latency.
- Reduces percpu memory usage and thus thread startup time.

Most importantly, this bounds the total error to 32 times the number of NUMA
nodes, significantly smaller than previous error bounds.

On a 112-core machine, lmbench showed comparable results before and after this
patch.  However, on a 224 core machine, performance improvements were
significant over percpu_counter:
- Pagefault latency improved by 8.91%
- Process fork latency improved by 6.27%
- Process fork/execve latency improved by 6.06%
- Process fork/exit latency improved by 6.58%

will-it-scale also showed significant improvements on these machines.

[1] https://lore.kernel.org/all/20221024052841.3291983-1-shakeelb@google.com/
[2] https://lore.kernel.org/all/20230608111408.s2minsenlcjow7q3@quack3/
[3] https://lore.kernel.org/all/20240418142008.2775308-1-zhangpeng362@huawei.com/

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

---

This is mostly a resend of an earlier patch, where I made an utter hash
of specifying a base commit (and forgot to update my commit text to not
call it an RFC, and forgot to update my email to the one I use for
upstream work...). This is based on akpm/mm-unstable as of today.

v1 can be found at
https://lore.kernel.org/lkml/20250325221550.396212-1-sweettea-kernel@dorminy.me/

Some interesting ideas came out of that discussion: Mathieu Desnoyers
has a design doc for a improved percpu counter, multi-level, with
constant drift, at 
https://lore.kernel.org/lkml/a89cb4d9-088e-4ed6-afde-f1b097de8db9@efficios.com/
and would like performance comparisons against just reducing the batch
size in the existing code;
and Mateusz Guzik would also like a more general solution and is also
working to fix the performance issues by caching mm state. Finally,
Lorenzo Stoakes nacks, as it's too speculative and needs more
discussion.

I think the important part is that this improves accuracy; the current
scheme is difficult to use on many-cored machines. It improves
performance, but there are tradeoffs; but it tightly bounds the
inaccuracy so that decisions can actually be reasonably made with the
resulting numbers.

This patch assumes that intra-NUMA node atomic updates are very cheap and that
assigning CPUs to an atomic counter by numa_node_id() % 16 is suitably
balanced. However, if each atomic were shared by only, say, eight CPUs from the
same NUMA node, this would further reduce atomic contention at the cost of more
memory and more complicated assignment of CPU to atomic index. I don't think
that additional complication is worth it given that this scheme seems to get
good performance, but it might be. I do need to actually test the impact
on a many-cores-one-NUMA-node machine, and I look forward to testing out
Mathieu's heirarchical percpu counter with bounded error.

---
 include/linux/mm.h          | 36 ++++++++++++++++++++++++++++++++----
 include/linux/mm_types.h    |  9 ++++++++-
 include/trace/events/kmem.h |  2 +-
 kernel/fork.c               |  9 +--------
 4 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fdd7cb8609a5..b27a79a36a57 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2694,30 +2694,58 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 /*
  * per-process(per-mm_struct) statistics.
  */
+static inline long get_mm_counter_slow(struct mm_struct *mm,
+						int member)
+{
+	long ret = atomic64_read(&mm->rss_stat[member].global);
+
+	for (int i = 0; i < _MM_NUMA_COUNTERS; i++)
+		ret += atomic64_read(&mm->rss_stat[member].numa_counters[i]);
+	return ret;
+}
+
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	s64 val = atomic64_read(&mm->rss_stat[member].global);
+
+	if (val < 0)
+		return 0;
+	return val;
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
+static inline void __mm_update_numa_counter(struct mm_struct *mm, int member,
+					    long value)
+{
+	size_t index = numa_node_id() % _MM_NUMA_COUNTERS;
+	struct mm_pernuma_counter *rss_stat = &mm->rss_stat[member];
+	atomic64_t *numa_counter = &rss_stat->numa_counters[index];
+	s64 val = atomic64_add_return(value, numa_counter);
+
+	if (abs(val) >= _MM_NUMA_COUNTERS_BATCH) {
+		atomic64_add(val, &rss_stat->global);
+		atomic64_add(-val, numa_counter);
+	}
+}
+
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	percpu_counter_add(&mm->rss_stat[member], value);
+	__mm_update_numa_counter(mm, member, value);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_inc(&mm->rss_stat[member]);
+	__mm_update_numa_counter(mm, member, 1);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_dec(&mm->rss_stat[member]);
+	__mm_update_numa_counter(mm, member, -1);
 
 	mm_trace_rss_stat(mm, member);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index aac7c87b04e1..a305fbebc8f6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -889,6 +889,13 @@ struct mm_cid {
 };
 #endif
 
+#define _MM_NUMA_COUNTERS MIN(MAX_NUMNODES, 32)
+#define _MM_NUMA_COUNTERS_BATCH max(32, (num_possible_cpus() >> NODES_SHIFT) * 2)
+struct mm_pernuma_counter {
+	atomic64_t global;
+	atomic64_t numa_counters[_MM_NUMA_COUNTERS];
+};
+
 struct kioctx_table;
 struct iommu_mm_data;
 struct mm_struct {
@@ -1055,7 +1062,7 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+		struct mm_pernuma_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index f74925a6cf69..72b8278fdb40 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -477,7 +477,7 @@ TRACE_EVENT(rss_stat,
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
+		__entry->size = (atomic64_read(&mm->rss_stat[member].global)
 							    << PAGE_SHIFT);
 	),
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 83cb82643817..3de71d335022 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -838,7 +838,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
+		long x = get_mm_counter_slow(mm, i);
 
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
@@ -940,7 +940,6 @@ void __mmdrop(struct mm_struct *mm)
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
-	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
 
 	free_mm(mm);
 }
@@ -1327,16 +1326,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_cid(mm, p))
 		goto fail_cid;
 
-	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
-				     NR_MM_COUNTERS))
-		goto fail_pcpu;
-
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
-fail_pcpu:
-	mm_destroy_cid(mm);
 fail_cid:
 	destroy_context(mm);
 fail_nocontext:

base-commit: e026356e4192ff5a52c1d535e6b9e3fa50def2c4
-- 
2.48.1

