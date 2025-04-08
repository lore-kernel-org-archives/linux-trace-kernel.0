Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9822D7AA;
	Tue,  8 Apr 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128324; cv=none; b=vFOlxOemFsTACkk7QrqrLwFNIuvUUoIQR9fPZLbUMKFnTp8r0TXMyA9G/KbE7vN11rHpgXBs3K/dVlhngEpFYM5SERKvHOvRdCKzBk5b7UN2eLC1UElSlxUUG5tcRMaVd10BcSVPw/fY6NgIiM0SDEYFSEIvEV7YDJMx4BN5FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128324; c=relaxed/simple;
	bh=30nP+t9oyZ1F0fRLjqbXH1OPlVwPLFQRPahG/PJCRkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C01rcPDSVBJyPOqbkt4NhKDf21QCO5jMK4CtJ3sUcAIOQrqnOeBdV/p+HsVf8gc1Wgl3OH5rOt7pbUXvV7DLE2JhWYfKN9BHP42iBZLs1zlT+d0xixxUtXT0CibdPPyyoYIbwnVphfi+rJECC3bjA3ecAXaOrlFiDUW7x3mS3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DMJNR1lt; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DMJNR1lt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1744128315;
	bh=30nP+t9oyZ1F0fRLjqbXH1OPlVwPLFQRPahG/PJCRkI=;
	h=From:To:Cc:Subject:Date:From;
	b=DMJNR1ltTOJSyotfY1foVwYw+MAd6XhPR9Kyl1q0uADQ2SJqbuiOIbRzs8ITyqfL5
	 sc0xyB0k9CFAi3Kmyy9ycS0RWXW6QpJnDsGQvUH4TUCPEGtpyvvcsIO1FFK1HT3THS
	 rLFEGRfU2qtbWlEaqY64sIaIP+LIOvRBzfJPwdqxZuBx/uQiRZ+He5iajdXVfoHqJH
	 g18vn1KEOKtSbq/AZKXsfLB+rC8vGSbpu6Qpd4nhU55UQEuss8GRg5A9Y8BWqjt87O
	 Dr8ZIJpreMtMNf8oJkeZ4mOFf5dbk8987H5mmjYx7F9sN2nfDaS+V3RqDldb+NDs8A
	 d+QY8UCldvm8Q==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZX9s63lBPz1Cv3;
	Tue,  8 Apr 2025 12:05:14 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Sweet Tea Dorminy <sweettea@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Date: Tue,  8 Apr 2025 12:05:08 -0400
Message-Id: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Motivation

The purpose of this hierarchical split-counter scheme is to:

- Minimize contention when incrementing and decrementing counters,
- Provide fast access to a sum approximation,
- Provide a sum approximation with an acceptable accuracy level when
  scaling to many-core systems.
- Provide approximate and precise comparison of two counters, and
  between a counter and a value.

It aims at fixing the per-mm RSS tracking which has become too
inaccurate for OOM killer purposes on large many-core systems [1].

* Design

The hierarchical per-CPU counters propagate a sum approximation through
a binary tree. When reaching the batch size, the carry is propagated
through a binary tree which consists of log2(nr_cpu_ids) levels. The
batch size for each level is twice the batch size of the prior level.

Example propagation diagram with 8 cpus:

Level 0:  0    1    2    3    4    5    6    7
          |   /     |   /     |   /     |   /
          |  /      |  /      |  /      |  /
          | /       | /       | /       | /
Level 1:  0         1         2         3
          |       /           |       /
          |    /              |    /
          | /                 | /
Level 2:  0                   1
          |               /
          |         /
          |   /
Level 3:  0

The maximum inaccuracy is bound by: batch_size * log2(nr_cpus) * nr_cpus
which evolves with O(n*log(n)) as the number of CPUs increases.

Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
Changes since v1:
- Remove percpu_counter_tree_precise_sum_unbiased from public header,
  make this function static,
- Introduce precise and approximate comparisons between two counters,
- Reorder the struct percpu_counter_tree fields,
- Introduce approx_sum field, which points to the approximate sum
  for the percpu_counter_tree_approximate_sum() fast path.
---
 include/linux/percpu_counter_tree.h | 102 +++++++++
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 313 ++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

diff --git a/include/linux/percpu_counter_tree.h b/include/linux/percpu_counter_tree.h
new file mode 100644
index 000000000000..aac5a711de3e
--- /dev/null
+++ b/include/linux/percpu_counter_tree.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/* SPDX-FileCopyrightText: 2025 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> */
+
+#ifndef _PERCPU_COUNTER_TREE_H
+#define _PERCPU_COUNTER_TREE_H
+
+#include <linux/cleanup.h>
+#include <linux/preempt.h>
+#include <linux/atomic.h>
+#include <linux/percpu.h>
+
+struct percpu_counter_tree_level_item {
+	atomic_t count;
+} ____cacheline_aligned_in_smp;
+
+struct percpu_counter_tree {
+	/* Fast-path fields. */
+	unsigned int __percpu *level0;
+	unsigned int level0_bit_mask;
+	atomic_t *approx_sum;
+	int bias;			/* bias for counter_set */
+
+	/* Slow-path fields. */
+	struct percpu_counter_tree_level_item *items;
+	unsigned int batch_size;
+	unsigned int inaccuracy;	/* approximation imprecise within ± inaccuracy */
+	unsigned int nr_levels;
+	unsigned int nr_cpus;
+};
+
+int percpu_counter_tree_init(struct percpu_counter_tree *counter, unsigned int batch_size);
+void percpu_counter_tree_destroy(struct percpu_counter_tree *counter);
+void percpu_counter_tree_add_slowpath(struct percpu_counter_tree *counter, int inc);
+int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter);
+int percpu_counter_tree_approximate_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
+int percpu_counter_tree_approximate_compare_value(struct percpu_counter_tree *counter, int v);
+int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
+int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v);
+void percpu_counter_tree_set_bias(struct percpu_counter_tree *counter, int bias);
+void percpu_counter_tree_set(struct percpu_counter_tree *counter, int v);
+unsigned int percpu_counter_tree_inaccuracy(struct percpu_counter_tree *counter);
+
+/* Fast paths */
+
+static inline
+int percpu_counter_tree_carry(int orig, int res, int inc, unsigned int bit_mask)
+{
+	if (inc < 0) {
+		inc = -(-inc & ~(bit_mask - 1));
+		/*
+		 * xor bit_mask: underflow.
+		 *
+		 * If inc has bit set, decrement an additional bit if
+		 * there is _no_ bit transition between orig and res.
+		 * Else, inc has bit cleared, decrement an additional
+		 * bit if there is a bit transition between orig and
+		 * res.
+		 */
+		if ((inc ^ orig ^ res) & bit_mask)
+			inc -= bit_mask;
+	} else {
+		inc &= ~(bit_mask - 1);
+		/*
+		 * xor bit_mask: overflow.
+		 *
+		 * If inc has bit set, increment an additional bit if
+		 * there is _no_ bit transition between orig and res.
+		 * Else, inc has bit cleared, increment an additional
+		 * bit if there is a bit transition between orig and
+		 * res.
+		 */
+		if ((inc ^ orig ^ res) & bit_mask)
+			inc += bit_mask;
+	}
+	return inc;
+}
+
+static inline
+void percpu_counter_tree_add(struct percpu_counter_tree *counter, int inc)
+{
+	unsigned int bit_mask = counter->level0_bit_mask, orig, res;
+
+	if (!inc)
+		return;
+	/* Make sure the fast and slow paths use the same cpu number. */
+	guard(migrate)();
+	res = this_cpu_add_return(*counter->level0, inc);
+	orig = res - inc;
+	inc = percpu_counter_tree_carry(orig, res, inc, bit_mask);
+	if (!inc)
+		return;
+	percpu_counter_tree_add_slowpath(counter, inc);
+}
+
+static inline
+int percpu_counter_tree_approximate_sum(struct percpu_counter_tree *counter)
+{
+	return (int) ((unsigned int)atomic_read(counter->approx_sum) +
+		      (unsigned int)READ_ONCE(counter->bias));
+}
+
+#endif  /* _PERCPU_COUNTER_TREE_H */
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..d803a3a63288 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -201,6 +201,7 @@ obj-$(CONFIG_TEXTSEARCH_KMP) += ts_kmp.o
 obj-$(CONFIG_TEXTSEARCH_BM) += ts_bm.o
 obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
 obj-$(CONFIG_SMP) += percpu_counter.o
+obj-$(CONFIG_SMP) += percpu_counter_tree.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
diff --git a/lib/percpu_counter_tree.c b/lib/percpu_counter_tree.c
new file mode 100644
index 000000000000..b530ba9dd61b
--- /dev/null
+++ b/lib/percpu_counter_tree.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-FileCopyrightText: 2025 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+/*
+ * Split Counters With Binary Tree Approximation Propagation
+ *
+ * * Propagation diagram when reaching batch size thresholds (± batch size):
+ *
+ * Example diagram for 8 CPUs:
+ *
+ * log2(8) = 3 levels
+ *
+ * At each level, each pair propagates its values to the next level when
+ * reaching the batch size thresholds.
+ *
+ * Counters at levels 0, 1, 2 can be kept on a single byte (±128 range),
+ * although it may be relevant to keep them on 32-bit counters for
+ * simplicity. (complexity vs memory footprint tradeoff)
+ *
+ * Counter at level 3 can be kept on a 32-bit counter.
+ *
+ * Level 0:  0    1    2    3    4    5    6    7
+ *           |   /     |   /     |   /     |   /
+ *           |  /      |  /      |  /      |  /
+ *           | /       | /       | /       | /
+ * Level 1:  0         1         2         3
+ *           |       /           |       /
+ *           |    /              |    /
+ *           | /                 | /
+ * Level 2:  0                   1
+ *           |               /
+ *           |         /
+ *           |   /
+ * Level 3:  0
+ *
+ * * Approximation inaccuracy:
+ *
+ * BATCH(level N): Level N batch size.
+ *
+ * Example for BATCH(level 0) = 32.
+ *
+ * BATCH(level 0) =  32
+ * BATCH(level 1) =  64
+ * BATCH(level 2) = 128
+ * BATCH(level N) = BATCH(level 0) * 2^N
+ *
+ *            per-counter     global
+ *            inaccuracy      inaccuracy
+ * Level 0:   [ -32 ..  +31]  ±256  (8 * 32)
+ * Level 1:   [ -64 ..  +63]  ±256  (4 * 64)
+ * Level 2:   [-128 .. +127]  ±256  (2 * 128)
+ * Total:      ------         ±768  (log2(nr_cpu_ids) * BATCH(level 0) * nr_cpu_ids)
+ *
+ * -----
+ *
+ * Approximate Sum Carry Propagation
+ *
+ * Let's define a number of counter bits for each level, e.g.:
+ *
+ * log2(BATCH(level 0)) = log2(32) = 5
+ *
+ *               nr_bit        value_mask                      range
+ * Level 0:      5 bits        v                             0 ..  +31
+ * Level 1:      1 bit        (v & ~((1UL << 5) - 1))        0 ..  +63
+ * Level 2:      1 bit        (v & ~((1UL << 6) - 1))        0 .. +127
+ * Level 3:     25 bits       (v & ~((1UL << 7) - 1))        0 .. 2^32-1
+ *
+ * Note: Use a full 32-bit per-cpu counter at level 0 to allow precise sum.
+ *
+ * Note: Use cacheline aligned counters at levels above 0 to prevent false sharing.
+ *       If memory footprint is an issue, a specialized allocator could be used
+ *       to eliminate padding.
+ *
+ * Example with expanded values:
+ *
+ * counter_add(counter, inc):
+ *
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = percpu_add_return(counter @ Level 0, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b00011111);  // Clear used bits
+ *                 // xor bit 5: underflow
+ *                 if ((inc ^ orig ^ res) & 0b00100000)
+ *                         inc -= 0b00100000;
+ *         } else {
+ *                 inc &= ~0b00011111;           // Clear used bits
+ *                 // xor bit 5: overflow
+ *                 if ((inc ^ orig ^ res) & 0b00100000)
+ *                         inc += 0b00100000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = atomic_add_return(counter @ Level 1, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b00111111);  // Clear used bits
+ *                 // xor bit 6: underflow
+ *                 if ((inc ^ orig ^ res) & 0b01000000)
+ *                         inc -= 0b01000000;
+ *         } else {
+ *                 inc &= ~0b00111111;           // Clear used bits
+ *                 // xor bit 6: overflow
+ *                 if ((inc ^ orig ^ res) & 0b01000000)
+ *                         inc += 0b01000000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = atomic_add_return(counter @ Level 2, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b01111111);  // Clear used bits
+ *                 // xor bit 7: underflow
+ *                 if ((inc ^ orig ^ res) & 0b10000000)
+ *                         inc -= 0b10000000;
+ *         } else {
+ *                 inc &= ~0b01111111;           // Clear used bits
+ *                 // xor bit 7: overflow
+ *                 if ((inc ^ orig ^ res) & 0b10000000)
+ *                         inc += 0b10000000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         atomic_add(counter @ Level 3, inc);
+ */
+
+#include <linux/percpu_counter_tree.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/math.h>
+
+int percpu_counter_tree_init(struct percpu_counter_tree *counter, unsigned int batch_size)
+{
+	/* Batch size must be power of 2 */
+	if (!batch_size || (batch_size & (batch_size - 1)))
+		return -EINVAL;
+	counter->nr_levels = get_count_order(nr_cpu_ids);
+	counter->nr_cpus = 1UL << counter->nr_levels;
+	counter->batch_size = batch_size;
+	counter->level0_bit_mask = 1UL << get_count_order(batch_size);
+	counter->inaccuracy = counter->nr_levels * batch_size * counter->nr_cpus;
+	counter->bias = 0;
+	counter->level0 = alloc_percpu(unsigned int);
+	if (!counter->level0)
+		return -ENOMEM;
+	counter->items = kzalloc(counter->nr_cpus - 1 *
+				 sizeof(struct percpu_counter_tree_level_item),
+				 GFP_KERNEL);
+	if (!counter->items) {
+		free_percpu(counter->level0);
+		return -ENOMEM;
+	}
+	counter->approx_sum = &counter->items[counter->nr_cpus - 2].count;
+	return 0;
+}
+
+void percpu_counter_tree_destroy(struct percpu_counter_tree *counter)
+{
+	free_percpu(counter->level0);
+	kfree(counter->items);
+}
+
+/* Called with migration disabled. */
+void percpu_counter_tree_add_slowpath(struct percpu_counter_tree *counter, int inc)
+{
+	struct percpu_counter_tree_level_item *item = counter->items;
+	unsigned int level_items = counter->nr_cpus >> 1;
+	unsigned int level, nr_levels = counter->nr_levels;
+	unsigned int bit_mask = counter->level0_bit_mask;
+	unsigned int cpu = smp_processor_id();
+
+	for (level = 1; level < nr_levels; level++) {
+		atomic_t *count = &item[cpu & (level_items - 1)].count;
+		unsigned int orig, res;
+
+		bit_mask <<= 1;
+		res = atomic_add_return_relaxed(inc, count);
+		orig = res - inc;
+		inc = percpu_counter_tree_carry(orig, res, inc, bit_mask);
+		item += level_items;
+		level_items >>= 1;
+		if (!inc)
+			return;
+	}
+	atomic_add(inc, counter->approx_sum);
+}
+
+/*
+ * Precise sum. Perform the sum of all per-cpu counters.
+ */
+static
+int percpu_counter_tree_precise_sum_unbiased(struct percpu_counter_tree *counter)
+{
+	unsigned int sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum += *per_cpu_ptr(counter->level0, cpu);
+	return (int) sum;
+}
+
+int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter)
+{
+	return percpu_counter_tree_precise_sum_unbiased(counter) + READ_ONCE(counter->bias);
+}
+
+/*
+ * Do an approximate comparison of two counters.
+ * Return 0 if counters do not differ by more than the sum of their
+ * respective inaccuracy ranges,
+ * Return -1 if counter @a less than counter @b,
+ * Return 1 if counter @a is greater than counter @b.
+ */
+int percpu_counter_tree_approximate_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b)
+{
+	int count_a = percpu_counter_tree_approximate_sum(a),
+	    count_b = percpu_counter_tree_approximate_sum(b);
+
+	if (abs(count_a - count_b) <= (a->inaccuracy + b->inaccuracy))
+		return 0;
+	if (count_a < count_b)
+		return -1;
+	return 1;
+}
+
+/*
+ * Do an approximate comparison of a counter against a given value.
+ * Return 0 if the value is within the inaccuracy range of the counter,
+ * Return -1 if the value less than counter,
+ * Return 1 if the value is greater than counter.
+ */
+int percpu_counter_tree_approximate_compare_value(struct percpu_counter_tree *counter, int v)
+{
+	int count = percpu_counter_tree_approximate_sum(counter);
+
+	if (abs(v - count) <= counter->inaccuracy)
+		return 0;
+	if (count < v)
+		return -1;
+	return 1;
+}
+
+/*
+ * Do a precise comparison of two counters.
+ * Return 0 if the counters are equal,
+ * Return -1 if counter @a less than counter @b,
+ * Return 1 if counter @a is greater than counter @b.
+ */
+int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b)
+{
+	int count_a = percpu_counter_tree_approximate_sum(a),
+	    count_b = percpu_counter_tree_approximate_sum(b);
+
+	if (abs(count_a - count_b) <= (a->inaccuracy + b->inaccuracy)) {
+		if (b->inaccuracy < a->inaccuracy) {
+			count_a = percpu_counter_tree_precise_sum(a);
+			if (abs(count_a - count_b) <= b->inaccuracy)
+				count_b = percpu_counter_tree_precise_sum(b);
+		} else {
+			count_b = percpu_counter_tree_precise_sum(b);
+			if (abs(count_a - count_b) <= a->inaccuracy)
+				count_a = percpu_counter_tree_precise_sum(a);
+		}
+	}
+	if (count_a > count_b)
+		return -1;
+	if (count_a > count_b)
+		return 1;
+	return 0;
+}
+
+/*
+ * Do a precise comparision of a counter against a given value.
+ * Return 0 if the value is equal to the counter,
+ * Return -1 if the value less than counter,
+ * Return 1 if the value is greater than counter.
+ */
+int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v)
+{
+	int count = percpu_counter_tree_approximate_sum(counter);
+
+	if (abs(v - count) <= counter->inaccuracy)
+		count = percpu_counter_tree_precise_sum(counter);
+	if (count < v)
+		return -1;
+	if (count > v)
+		return 1;
+	return 0;
+}
+
+void percpu_counter_tree_set_bias(struct percpu_counter_tree *counter, int bias)
+{
+	WRITE_ONCE(counter->bias, bias);
+}
+
+void percpu_counter_tree_set(struct percpu_counter_tree *counter, int v)
+{
+	percpu_counter_tree_set_bias(counter,
+				     v - percpu_counter_tree_precise_sum_unbiased(counter));
+}
+
+unsigned int percpu_counter_tree_inaccuracy(struct percpu_counter_tree *counter)
+{
+	return counter->inaccuracy;
+}
-- 
2.39.5

