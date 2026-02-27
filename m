Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090843D503;
	Fri, 27 Feb 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206665; cv=none; b=O7rRscE59zRFPTA33JF4KL/PDv1XJHkliuV3yW4/KYIx2NRZTW+8Q7fUNRxSGvLuirKp9fK5kh6iaJJYbe2+cW7Ne2k/wlCa1CDfG6pQZzVgod3AzMBXWLZ9/D+7PzTIq6dUhf3cJf5Q3uI7GQ5Uu6kynrEOj8Z6cKn3rT/Pn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206665; c=relaxed/simple;
	bh=Zd9smhzX0Z/zheSrQ74z21U8wNc6Jfpdy1TuQAPPx8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbJkc7dhakRZns+Cc1DLKOVmXiTcAcZTiem8q+Bzl8ax4dtJbvrFjH/IzRwF2HosnCtxzm7C+Wp/YAHwDis8tFQagWFtwgVhf8gdpjRWbrX9gxtEE4FgW+6p29651yowYAT2Q1DbmeN1ArlWdjENDER2zjGZ7pPSXv6evzCFvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mZkLpNSx; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mZkLpNSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1772206657;
	bh=TkHwF7BlYff6jdk+S19J6dVNCPWWYptmECBBQYyXzl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZkLpNSx9822xzcf/BesAB0krI1At1wDqeTKB5mw71wTCgO3xnm6e+/Jqa5jnNQs4
	 +2DWJb7I5DcZkG+dfUkJlGSQfH7YZau0+Ego9UObawBmp4T7Sx0K02vC9nhMHhntaK
	 bk8QYEsqZomV1hXDT3wLnK2yz02ysyHIVMGDJm+/iaxkXD3cEkjYI3bh9ccJZ5Ijnm
	 GBi3G1BLlgf9OtoOmY45YcB/r2YX2D89ZjQe04PbYn3WPy/aWVZwlIitrHPDXhbQtH
	 3d1/z+Lr5NCob1bwlS29la9h6oTpyvAl/WmNQ+rfMuOnOOvlJshYccLBJhi5Waa/Tx
	 q1PbyEekLSS5g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fMssF0B9MzKCt;
	Fri, 27 Feb 2026 10:37:37 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
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
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v18 2/3] lib: Test hierarchical per-cpu counters
Date: Fri, 27 Feb 2026 10:37:29 -0500
Message-Id: <20260227153730.1556542-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260227153730.1556542-1-mathieu.desnoyers@efficios.com>
References: <20260227153730.1556542-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Kunit tests for hierarchical per-cpu counters.

Keep track of two sets of hierarchical counters, each meant to
have the same precise sum at any time, but distributed differently
across the topology.

Keep track of an atomic counter along with each hierarchical
counter, for sum validation.

Those tests cover:

- Single-threaded (no concurrency) updates.
- Concurrent updates of counters from various CPUs.

Perform the following validations:

- Compare the precise sum of counters with the sum tracked by
  an atomic counter.
- Compare the precise sum of two sets of hierarchical counters.
- Approximated comparison of hierarchical counter with atomic counter.
- Approximated comparison of two sets of hierarchical counters.
- Validate the bounds of approximation ranges.

Run with the following .kunit/.kunitconfig:

CONFIG_KUNIT=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_NR_CPUS=32
CONFIG_HOTPLUG_CPU=y
CONFIG_PERCPU_COUNTER_TREE_TEST=y

With the following execution (to use SMP):

./tools/testing/kunit/kunit.py run --arch=x86_64 --qemu_args="-smp 12"

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
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
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
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
Changes since v17:
- Use percpu_counter_tree_{init,destroy}_many,
- Add coverage for percpu_counter_tree_{init,destroy},
- Add coverage for percpu_counter_tree_set.
- Fix wait queue head reinit bug. Use DECLARE_WAIT_QUEUE_HEAD
  instead.
---
 lib/Kconfig                           |  12 +
 lib/tests/Makefile                    |   2 +
 lib/tests/percpu_counter_tree_kunit.c | 399 ++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 lib/tests/percpu_counter_tree_kunit.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..0b8241e5b548 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -52,6 +52,18 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config PERCPU_COUNTER_TREE_TEST
+	tristate "Hierarchical Per-CPU counter test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds Kunit tests for the hierarchical per-cpu counters.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  When in doubt, say N.
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..d282aa23d273 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -56,4 +56,6 @@ obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
 obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
 
+obj-$(CONFIG_PERCPU_COUNTER_TREE_TEST) += percpu_counter_tree_kunit.o
+
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/percpu_counter_tree_kunit.c b/lib/tests/percpu_counter_tree_kunit.c
new file mode 100644
index 000000000000..a79176655c4b
--- /dev/null
+++ b/lib/tests/percpu_counter_tree_kunit.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-FileCopyrightText: 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+#include <kunit/test.h>
+#include <linux/percpu_counter_tree.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/random.h>
+
+struct multi_thread_test_data {
+	long increment;
+	int nr_inc;
+	int counter_index;
+};
+
+#define NR_COUNTERS	2
+
+/* Hierarchical per-CPU counter instances. */
+static struct percpu_counter_tree counter[NR_COUNTERS];
+static struct percpu_counter_tree_level_item *items;
+
+/* Global atomic counters for validation. */
+static atomic_long_t global_counter[NR_COUNTERS];
+
+static DECLARE_WAIT_QUEUE_HEAD(kernel_threads_wq);
+static atomic_t kernel_threads_to_run;
+
+static void complete_work(void)
+{
+	if (atomic_dec_and_test(&kernel_threads_to_run))
+		wake_up(&kernel_threads_wq);
+}
+
+static void hpcc_print_info(struct kunit *test)
+{
+	kunit_info(test, "Running test with %d CPUs\n", num_online_cpus());
+}
+
+static void add_to_counter(int counter_index, unsigned int nr_inc, long increment)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_inc; i++) {
+		percpu_counter_tree_add(&counter[counter_index], increment);
+		atomic_long_add(increment, &global_counter[counter_index]);
+	}
+}
+
+static void check_counters(struct kunit *test)
+{
+	int counter_index;
+
+	/* Compare each counter with its global counter. */
+	for (counter_index = 0; counter_index < NR_COUNTERS; counter_index++) {
+		long v = atomic_long_read(&global_counter[counter_index]);
+		long approx_sum = percpu_counter_tree_approximate_sum(&counter[counter_index]);
+		unsigned long under_accuracy = 0, over_accuracy = 0;
+		long precise_min, precise_max;
+
+		/* Precise comparison. */
+		KUNIT_EXPECT_EQ(test, percpu_counter_tree_precise_sum(&counter[counter_index]), v);
+		KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_precise_compare_value(&counter[counter_index], v));
+
+		/* Approximate comparison. */
+		KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_approximate_compare_value(&counter[counter_index], v));
+
+		/* Accuracy limits checks. */
+		percpu_counter_tree_approximate_accuracy_range(&counter[counter_index], &under_accuracy, &over_accuracy);
+
+		KUNIT_EXPECT_GE(test, (long)(approx_sum - (v - under_accuracy)), 0);
+		KUNIT_EXPECT_LE(test, (long)(approx_sum - (v + over_accuracy)), 0);
+		KUNIT_EXPECT_GT(test, (long)(approx_sum - (v - under_accuracy - 1)), 0);
+		KUNIT_EXPECT_LT(test, (long)(approx_sum - (v + over_accuracy + 1)), 0);
+
+		/* Precise min/max range check. */
+		percpu_counter_tree_approximate_min_max_range(approx_sum, under_accuracy, over_accuracy, &precise_min, &precise_max);
+
+		KUNIT_EXPECT_GE(test, v - precise_min, 0);
+		KUNIT_EXPECT_LE(test, v - precise_max, 0);
+		KUNIT_EXPECT_GT(test, v - (precise_min - 1), 0);
+		KUNIT_EXPECT_LT(test, v - (precise_max + 1), 0);
+	}
+	/* Compare each counter with the second counter. */
+	KUNIT_EXPECT_EQ(test, percpu_counter_tree_precise_sum(&counter[0]), percpu_counter_tree_precise_sum(&counter[1]));
+	KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_precise_compare(&counter[0], &counter[1]));
+	KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_approximate_compare(&counter[0], &counter[1]));
+}
+
+static int multi_thread_worker_fn(void *data)
+{
+	struct multi_thread_test_data *td = data;
+
+	add_to_counter(td->counter_index, td->nr_inc, td->increment);
+	complete_work();
+	kfree(td);
+	return 0;
+}
+
+static void test_run_on_specific_cpu(struct kunit *test, int target_cpu, int counter_index, unsigned int nr_inc, long increment)
+{
+	struct task_struct *task;
+	struct multi_thread_test_data *td = kzalloc(sizeof(struct multi_thread_test_data), GFP_KERNEL);
+
+	KUNIT_EXPECT_PTR_NE(test, td, NULL);
+	td->increment = increment;
+	td->nr_inc = nr_inc;
+	td->counter_index = counter_index;
+	atomic_inc(&kernel_threads_to_run);
+	task = kthread_run_on_cpu(multi_thread_worker_fn, td, target_cpu, "kunit_multi_thread_worker");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
+}
+
+static void init_kthreads(void)
+{
+	atomic_set(&kernel_threads_to_run, 1);
+}
+
+static void fini_kthreads(void)
+{
+	/* Release our own reference. */
+	complete_work();
+	/* Wait for all others threads to run. */
+	wait_event(kernel_threads_wq, (atomic_read(&kernel_threads_to_run) == 0));
+}
+
+static void test_sync_kthreads(void)
+{
+	fini_kthreads();
+	init_kthreads();
+}
+
+static void init_counters(struct kunit *test, unsigned long batch_size)
+{
+	int i, ret;
+
+	items = kzalloc(percpu_counter_tree_items_size() * NR_COUNTERS, GFP_KERNEL);
+	KUNIT_EXPECT_PTR_NE(test, items, NULL);
+	ret = percpu_counter_tree_init_many(counter, items, NR_COUNTERS, batch_size, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	for (i = 0; i < NR_COUNTERS; i++)
+		atomic_long_set(&global_counter[i], 0);
+}
+
+static void fini_counters(void)
+{
+	percpu_counter_tree_destroy_many(counter, NR_COUNTERS);
+	kfree(items);
+}
+
+enum up_test_inc_type {
+	INC_ONE,
+	INC_MINUS_ONE,
+	INC_RANDOM,
+};
+
+/*
+ * Single-threaded tests. Those use many threads to run on various CPUs,
+ * but synchronize for completion of each thread before running the
+ * next, effectively making sure there are no concurrent updates.
+ */
+static void do_hpcc_test_single_thread(struct kunit *test, int _cpu0, int _cpu1, enum up_test_inc_type type)
+{
+	unsigned long batch_size_order = 5;
+	int cpu0 = _cpu0;
+	int cpu1 = _cpu1;
+	int i;
+
+	init_counters(test, 1UL << batch_size_order);
+	init_kthreads();
+	for (i = 0; i < 10000; i++) {
+		long increment;
+
+		switch (type) {
+		case INC_ONE:
+			increment = 1;
+			break;
+		case INC_MINUS_ONE:
+			increment = -1;
+			break;
+		case INC_RANDOM:
+			increment = (long) get_random_long() % 50000;
+			break;
+		}
+		if (_cpu0 < 0)
+			cpu0 = cpumask_any_distribute(cpu_online_mask);
+		if (_cpu1 < 0)
+			cpu1 = cpumask_any_distribute(cpu_online_mask);
+		test_run_on_specific_cpu(test, cpu0, 0, 1, increment);
+		test_sync_kthreads();
+		test_run_on_specific_cpu(test, cpu1, 1, 1, increment);
+		test_sync_kthreads();
+		check_counters(test);
+	}
+	fini_kthreads();
+	fini_counters();
+}
+
+static void hpcc_test_single_thread_first(struct kunit *test)
+{
+	int cpu = cpumask_first(cpu_online_mask);
+
+	do_hpcc_test_single_thread(test, cpu, cpu, INC_ONE);
+	do_hpcc_test_single_thread(test, cpu, cpu, INC_MINUS_ONE);
+	do_hpcc_test_single_thread(test, cpu, cpu, INC_RANDOM);
+}
+
+static void hpcc_test_single_thread_first_random(struct kunit *test)
+{
+	int cpu = cpumask_first(cpu_online_mask);
+
+	do_hpcc_test_single_thread(test, cpu, -1, INC_ONE);
+	do_hpcc_test_single_thread(test, cpu, -1, INC_MINUS_ONE);
+	do_hpcc_test_single_thread(test, cpu, -1, INC_RANDOM);
+}
+
+static void hpcc_test_single_thread_random(struct kunit *test)
+{
+	do_hpcc_test_single_thread(test, -1, -1, INC_ONE);
+	do_hpcc_test_single_thread(test, -1, -1, INC_MINUS_ONE);
+	do_hpcc_test_single_thread(test, -1, -1, INC_RANDOM);
+}
+
+/* Multi-threaded SMP tests. */
+
+static void do_hpcc_multi_thread_increment_each_cpu(struct kunit *test, unsigned long batch_size, unsigned int nr_inc, long increment)
+{
+	int cpu;
+
+	init_counters(test, batch_size);
+	init_kthreads();
+	for_each_online_cpu(cpu) {
+		test_run_on_specific_cpu(test, cpu, 0, nr_inc, increment);
+		test_run_on_specific_cpu(test, cpu, 1, nr_inc, increment);
+	}
+	fini_kthreads();
+	check_counters(test);
+	fini_counters();
+}
+
+static void do_hpcc_multi_thread_increment_even_cpus(struct kunit *test, unsigned long batch_size, unsigned int nr_inc, long increment)
+{
+	int cpu;
+
+	init_counters(test, batch_size);
+	init_kthreads();
+	for_each_online_cpu(cpu) {
+		test_run_on_specific_cpu(test, cpu, 0, nr_inc, increment);
+		test_run_on_specific_cpu(test, cpu & ~1, 1, nr_inc, increment); /* even cpus. */
+	}
+	fini_kthreads();
+	check_counters(test);
+	fini_counters();
+}
+
+static void do_hpcc_multi_thread_increment_single_cpu(struct kunit *test, unsigned long batch_size, unsigned int nr_inc, long increment)
+{
+	int cpu;
+
+	init_counters(test, batch_size);
+	init_kthreads();
+	for_each_online_cpu(cpu) {
+		test_run_on_specific_cpu(test, cpu, 0, nr_inc, increment);
+		test_run_on_specific_cpu(test, cpumask_first(cpu_online_mask), 1, nr_inc, increment);
+	}
+	fini_kthreads();
+	check_counters(test);
+	fini_counters();
+}
+
+static void do_hpcc_multi_thread_increment_random_cpu(struct kunit *test, unsigned long batch_size, unsigned int nr_inc, long increment)
+{
+	int cpu;
+
+	init_counters(test, batch_size);
+	init_kthreads();
+	for_each_online_cpu(cpu) {
+		test_run_on_specific_cpu(test, cpu, 0, nr_inc, increment);
+		test_run_on_specific_cpu(test, cpumask_any_distribute(cpu_online_mask), 1, nr_inc, increment);
+	}
+	fini_kthreads();
+	check_counters(test);
+	fini_counters();
+}
+
+static void hpcc_test_multi_thread_batch_increment(struct kunit *test)
+{
+	unsigned long batch_size_order;
+
+	for (batch_size_order = 2; batch_size_order < 10; batch_size_order++) {
+		unsigned int nr_inc;
+
+		for (nr_inc = 1; nr_inc < 1024; nr_inc *= 2) {
+			long increment;
+
+			for (increment = 1; increment < 100000; increment *= 10) {
+				do_hpcc_multi_thread_increment_each_cpu(test, 1UL << batch_size_order, nr_inc, increment);
+				do_hpcc_multi_thread_increment_even_cpus(test, 1UL << batch_size_order, nr_inc, increment);
+				do_hpcc_multi_thread_increment_single_cpu(test, 1UL << batch_size_order, nr_inc, increment);
+				do_hpcc_multi_thread_increment_random_cpu(test, 1UL << batch_size_order, nr_inc, increment);
+			}
+		}
+	}
+}
+
+static void hpcc_test_multi_thread_random_walk(struct kunit *test)
+{
+	unsigned long batch_size_order = 5;
+	int loop;
+
+	for (loop = 0; loop < 100; loop++) {
+		int i;
+
+		init_counters(test, 1UL << batch_size_order);
+		init_kthreads();
+		for (i = 0; i < 1000; i++) {
+			long increment = (long) get_random_long() % 512;
+			unsigned int nr_inc = ((unsigned long) get_random_long()) % 1024;
+
+			test_run_on_specific_cpu(test, cpumask_any_distribute(cpu_online_mask), 0, nr_inc, increment);
+			test_run_on_specific_cpu(test, cpumask_any_distribute(cpu_online_mask), 1, nr_inc, increment);
+		}
+		fini_kthreads();
+		check_counters(test);
+		fini_counters();
+	}
+}
+
+static void hpcc_test_init_one(struct kunit *test)
+{
+	struct percpu_counter_tree pct;
+	struct percpu_counter_tree_level_item *counter_items;
+	int ret;
+
+	counter_items = kzalloc(percpu_counter_tree_items_size(), GFP_KERNEL);
+	KUNIT_EXPECT_PTR_NE(test, counter_items, NULL);
+	ret = percpu_counter_tree_init(&pct, counter_items, 32, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	percpu_counter_tree_destroy(&pct);
+	kfree(counter_items);
+}
+
+static void hpcc_test_set(struct kunit *test)
+{
+	static long values[] = {
+		5, 100, 127, 128, 255, 256, 4095, 4096, 500000, 0,
+		-5, -100, -127, -128, -255, -256, -4095, -4096, -500000,
+	};
+	struct percpu_counter_tree pct;
+	struct percpu_counter_tree_level_item *counter_items;
+	int i, ret;
+
+	counter_items = kzalloc(percpu_counter_tree_items_size(), GFP_KERNEL);
+	KUNIT_EXPECT_PTR_NE(test, counter_items, NULL);
+	ret = percpu_counter_tree_init(&pct, counter_items, 32, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	for (i = 0; i < ARRAY_SIZE(values); i++) {
+		long v = values[i];
+
+		percpu_counter_tree_set(&pct, v);
+		KUNIT_EXPECT_EQ(test, percpu_counter_tree_precise_sum(&pct), v);
+		KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_approximate_compare_value(&pct, v));
+
+		percpu_counter_tree_add(&pct, v);
+		KUNIT_EXPECT_EQ(test, percpu_counter_tree_precise_sum(&pct), 2 * v);
+		KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_approximate_compare_value(&pct, 2 * v));
+
+		percpu_counter_tree_add(&pct, -2 * v);
+		KUNIT_EXPECT_EQ(test, percpu_counter_tree_precise_sum(&pct), 0);
+		KUNIT_EXPECT_EQ(test, 0, percpu_counter_tree_approximate_compare_value(&pct, 0));
+	}
+
+	percpu_counter_tree_destroy(&pct);
+	kfree(counter_items);
+}
+
+static struct kunit_case hpcc_test_cases[] = {
+	KUNIT_CASE(hpcc_print_info),
+	KUNIT_CASE(hpcc_test_single_thread_first),
+	KUNIT_CASE(hpcc_test_single_thread_first_random),
+	KUNIT_CASE(hpcc_test_single_thread_random),
+	KUNIT_CASE(hpcc_test_multi_thread_batch_increment),
+	KUNIT_CASE(hpcc_test_multi_thread_random_walk),
+	KUNIT_CASE(hpcc_test_init_one),
+	KUNIT_CASE(hpcc_test_set),
+	{}
+};
+
+static struct kunit_suite hpcc_test_suite = {
+	.name = "percpu_counter_tree",
+	.test_cases = hpcc_test_cases,
+};
+
+kunit_test_suite(hpcc_test_suite);
+
+MODULE_DESCRIPTION("Test cases for hierarchical per-CPU counters");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.5

