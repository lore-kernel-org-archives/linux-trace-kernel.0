Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5513CCFC2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446485; cv=none; b=OauwfoR2p+F54LFawLQfGW0Pwwtw28jztEsL05ggKjxa3HvluoDZsivA3c9EEj4M3dJRzjZiyWi+5b1CxZxJvJTkA/EZFRBFQsg1aDsCnYqeEpcbz7MZEIRGKQBju91AN3pFVE5T9Fo8RKdo+K2XB6J3ANzToZBh9ehG4azfTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446485; c=relaxed/simple;
	bh=YCh9Xsjw5Snz2j+M1AdaOBDzugZJImFYJ/RP87bVT4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Ga5Nqa/dBK9c0Uo6I4VwdgYDpyAJEAfMsyVdwySOcPM1obsav9GogqrDJw4fWx5b+LQYtOMAnH1yrZo3hupwvwDoKK+Yh0lz+pQzm7hphoQDiwGNdUuXDYBTUEVZezeXC94KQu37pn/j5p9Fl8nZnVvhzRRuZK1Tju/qhS9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw758IGD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw758IGD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36a3dd2e66eso1340341a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446476; x=1780051276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx761+FVC9cow+6cUcd+vha9JXwiIKXa/tnmrKTSGzE=;
        b=jw758IGDBpfz9VV9PnSq04lS+HbLAfHA7yHuICxHRr2eCnD6fbvvqj5mMhQ1seIVbi
         p5pALa84pjApGF3AN+iG16NenBsp8aAy+IsF/Cgw+OpeVQFejbiDtA/74nVTipcZIAYX
         dcL30SQFGJH2f0bNCJ5nIkeYC9UZtDfGs04JPLlwQbd6Xmg9RKNeyVR2KK1SbL+A+Qmt
         kf3PxJ0kyAGh7hkCgjsm41ejbaT4aK74QPztly1yTgseI3Nz9IuL6IOEkxPc/y0pmDTp
         cp3BNd2cqyiCvvBu2vUxNgPZ4q0rbFFeqfXRxwr3FAFhSIdUByAUINwrZhzBuQT1pRFz
         uGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446476; x=1780051276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx761+FVC9cow+6cUcd+vha9JXwiIKXa/tnmrKTSGzE=;
        b=cYPDu0pJTP3lw28W+mMTlPdsrk+Is7g0desXtjYdl+yQRUie9VuROSAynUdB/hd3CV
         d0fOeA1Z8EnOOZ8yEvCvzH6riK3CsOMQ885NDS06XxKkEjzZhp+9/6CMemDl3ZHclyvU
         /IIbAtp3CnQVsfJABNza8zgoFgaHEHB2IQOZCfcC/8DsapZmLonVXuYdddwS1XjWep+T
         tuBRdSnp3nqRRSGcxhnqc1MsbAbUC+49sTJZkdcsLOXNM6gQAfPix0MsDPEug8qqIyJc
         5qgkNigbAjiZHS9lQlUPKH+Ao4s36CF0djEKWIrezw6immc3x6zyiILIa48qiKTODAvi
         2kJQ==
X-Gm-Message-State: AOJu0YwjdwEeOxHBPe+KY/TuAtKagq1Dnnsp9fnajzdXlX3ZhHPtB5sn
	Wa5RmMYtHtR5HLkV8kUgQ6dqlgLewc1NwK8VyPYrbwzaJBiWJJ3yJAtvn9koDQ==
X-Gm-Gg: Acq92OGLjeTjs13k8P+/uul9D6TyH/ND4JOrVak7SfAEsbB1iF3l3lUlgnzwceqKlJV
	MF7gx0KSue3EC7spWtlIufqT2rhnZzyY9e/qyvjzH8B1KNuzvBm3MBfIGP82lm8k43hr4iKxu4T
	UqRYnOoOX0gQmyHn2pv8FVgbOst/STWtTrqQPYnV1/6Z80+s6nAdvxa+CuNMAtOm0+JwGpiXEi7
	iAU4P3NbmceE/JjmAFlN/xySV7qoVTdwKUTs4+VAnIlfauEY+tFhZXxDKBUt2N48K3Tz4sPvRuS
	KWSqOgNZzICqGRatHyYXeLIat9qyq9uyZyVSaPc0DusSfqDdqlZI/DD4+Fjd+GCHGM0vs6WqPrI
	oevK4ziADqMVMxiAyYZKRArDjK4fPTV5CPHZ4AWYwi0Z+3EIod67/RBK36ETuKG4MIlE+opGWDj
	V9+z6TSyYiPXQo7P5j9Pt0nBNu2tefwc3Ukl4lRw==
X-Received: by 2002:a05:6a21:600f:b0:3a0:b65a:5df2 with SMTP id adf61e73a8af0-3b3291e9dfdmr3152993637.23.1779446475790;
        Fri, 22 May 2026 03:41:15 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:9a21:4fdc:c1a5:7a8e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85200c3feesm1282942a12.0.2026.05.22.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:41:15 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: [PATCH v2 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Fri, 22 May 2026 18:40:15 +0800
Message-Id: <20260522104017.1668638-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522104017.1668638-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
 <20260522104017.1668638-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add a lock-free hash map (ftrace_stackmap) that deduplicates kernel
stack traces for the ftrace ring buffer. Instead of storing full
stack traces (80-160 bytes each) in the ring buffer for every event,
ftrace can store a 4-byte stack_id when the stackmap option is enabled.

The implementation is modeled after tracing_map.c (used by hist
triggers), using the same lock-free design based on Dr. Cliff Click's
non-blocking hash table algorithm:

- Lock-free insert via cmpxchg, safe in NMI/IRQ/any context
- Pre-allocated element pool (zero allocation on hot path)
- Linear probing with 2x over-provisioned table; probe length is
  bounded by FTRACE_STACKMAP_MAX_PROBE so worst-case insert/lookup
  is O(1) even when the table is heavily loaded with claimed-but-
  empty slots from pool exhaustion
- Single global instance (initialized for the global trace array)

The stackmap is exported via three tracefs nodes:
- stack_map: text export with symbol resolution (mode 0640)
- stack_map_stat: counters (entries, successes, drops, success_rate)
- stack_map_bin: binary export (all fields native-endian)

Counter naming:
- 'successes' counts events that were successfully assigned a
  stack_id (covers both first-time inserts and dedup hits).
- 'drops' counts events that fell back to recording the full stack
  (pool exhausted, probe limit reached, or reset in progress).
- 'success_rate' is successes / (successes + drops).

Reset semantics:
- Reset is a control-path operation only allowed when tracing is
  stopped on the owning trace_array. Online reset (with tracing
  active) is intentionally not supported to keep the proof
  obligations small.
- Reset uses atomic_cmpxchg() to claim the resetting flag, then
  verifies tracer_tracing_is_on() returns false. The resetting
  flag itself blocks subsequent get_id() callers; userspace
  re-enabling tracing after our check still cannot let new
  insertions through.
- synchronize_rcu() drains in-flight get_id() callers from the
  ftrace callback path, which runs preempt-disabled.
- Reset clears the resetting flag with atomic_set_release() so a
  subsequent get_id() observes a fully cleared map.
- Concurrent reset returns -EBUSY; reset while tracing is active
  returns -EBUSY.

Concurrency notes:
- entry->val publication uses smp_store_release() paired with
  smp_load_acquire() in all dereferencing readers (lookup, seq_show,
  bin_open). seq_start/seq_next only check val for NULL and use
  READ_ONCE().
- elt->nr is read with READ_ONCE() and clamped to MAX_DEPTH before
  use in seq_show and bin_open.
- Pool exhaustion: stackmap_get_elt() short-circuits via
  atomic_read() before the contended atomic RMW, avoiding cacheline
  contention once the pool is full. Slots that win cmpxchg but
  cannot get an elt are left 'claimed but empty'; subsequent
  lookups treat val==NULL as a miss and probe past them. The
  bounded probe length keeps per-event cost O(1).

Hash key:
- Per-instance random seed stored in the stackmap struct (no
  global state), seeded at create time.
- 32-bit jhash is forced to 1 if it lands on 0 (which is the
  free-slot sentinel). Full memcmp confirms matches.

Memory:
- Single flat vmalloc for the element pool (no per-elt kzalloc).
- bits parameter clamped to [10, 18]: at the maximum bits=18, the
  element pool is ~130 MB and a stack_map_bin snapshot may briefly
  allocate another ~130 MB.
- struct stackmap_bin_snapshot uses u64 (not size_t) for its size
  field so data[] is 8-byte aligned on both 32-bit and 64-bit
  architectures, avoiding alignment faults when writing u64 IPs
  on strict-alignment architectures.

Kernel command line parameter:
- ftrace_stackmap.bits=N: set map capacity (2^N unique stacks,
  range 10-18, default 14)

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig          |  21 ++
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace_stackmap.c | 643 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  56 +++
 4 files changed, 721 insertions(+)
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e130da35808f..2a63fd2c9a96 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -412,6 +412,27 @@ config STACK_TRACER
 
 	  Say N if unsure.
 
+config FTRACE_STACKMAP
+	bool "Ftrace stack map deduplication"
+	depends on TRACING
+	depends on STACKTRACE
+	select KALLSYMS
+	help
+	  This enables a global stack trace hash table for ftrace, inspired
+	  by eBPF's BPF_MAP_TYPE_STACK_TRACE. When enabled, ftrace can store
+	  only a stack_id in the ring buffer instead of the full stack trace,
+	  significantly reducing trace buffer usage when the same call stacks
+	  appear repeatedly.
+
+	  The deduplicated stacks are exported via:
+	    /sys/kernel/debug/tracing/stack_map
+
+	  Writing to this file resets the stack map. Reading shows all unique
+	  stacks with their stack_id and reference count.
+
+	  Say Y if you want to reduce ftrace buffer usage for stack traces.
+	  Say N if unsure.
+
 config TRACE_PREEMPT_TOGGLE
 	bool
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 1decdce8cbef..f1b6175099cc 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
 obj-$(CONFIG_OSNOISE_TRACER) += trace_osnoise.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
+obj-$(CONFIG_FTRACE_STACKMAP) += trace_stackmap.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
new file mode 100644
index 000000000000..b23a60e9286c
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ftrace Stack Map - Lock-free stack trace deduplication for ftrace
+ *
+ * Modeled after tracing_map.c (used by hist triggers), this provides
+ * a lock-free hash map optimized for the ftrace hot path. The design
+ * is based on Dr. Cliff Click's non-blocking hash table algorithm.
+ *
+ * Key properties:
+ * - Lock-free insert via cmpxchg, safe in NMI/IRQ/any context
+ * - Pre-allocated element pool (zero allocation on hot path)
+ * - Linear probing with 2x over-provisioned table; probe length
+ *   bounded by FTRACE_STACKMAP_MAX_PROBE to keep worst-case lookup
+ *   cost constant even when the table is heavily loaded
+ * - Single global instance (initialized for the global trace array)
+ *
+ * Reset is a control-path operation, only allowed when tracing is
+ * stopped on the owning trace_array. The protocol is:
+ *
+ *   - atomic_cmpxchg(&resetting, 0, 1) atomically claims reset rights
+ *     and blocks new get_id() callers (they observe resetting=1 and
+ *     return -EINVAL).
+ *   - tracer_tracing_is_on() is checked AFTER the cmpxchg, so the
+ *     resetting flag itself prevents new insertions even if userspace
+ *     re-enables tracing immediately after the check.
+ *   - synchronize_rcu() drains in-flight get_id() callers from the
+ *     ftrace callback path, which runs with preemption disabled.
+ *
+ * Online reset (with tracing active) is intentionally not supported
+ * to keep the design simple and the proof obligations small.
+ *
+ * The 32-bit jhash of the stack IPs is the hash table key. On hash
+ * collision, linear probing finds the next slot and full memcmp
+ * confirms the match.
+ *
+ * Concurrent userspace readers (cat stack_map / stack_map_bin) get
+ * a best-effort snapshot. They are coherent with the hot path
+ * (smp_load_acquire on entry->val), but they are not coherent with
+ * a concurrent reset; since reset requires tracing to be stopped,
+ * mid-iteration reset can produce truncated or partial output but
+ * never crashes.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/random.h>
+#include <linux/rcupdate.h>
+#include <linux/log2.h>
+
+#include "trace.h"
+#include "trace_stackmap.h"
+
+/*
+ * Bound the linear-probe scan length. With a 2x over-provisioned table,
+ * a well-distributed hash gives very short probe chains. Capping at 64
+ * keeps worst-case lookup O(1) even when the table is heavily loaded
+ * with claimed-but-empty slots from pool exhaustion.
+ */
+#define FTRACE_STACKMAP_MAX_PROBE	64
+
+/*
+ * Each pre-allocated element holds one unique stack trace.
+ * Fixed size: MAX_DEPTH entries regardless of actual depth.
+ */
+struct stackmap_elt {
+	u32		nr;		/* actual number of IPs */
+	atomic_t	ref_count;
+	unsigned long	ips[FTRACE_STACKMAP_MAX_DEPTH];
+};
+
+/*
+ * Hash table entry: a 32-bit key (jhash of stack) + pointer to elt.
+ * key == 0 means the slot is free.
+ */
+struct stackmap_entry {
+	u32			key;	/* 0 = free, non-zero = jhash */
+	struct stackmap_elt	*val;	/* NULL until fully published */
+};
+
+struct ftrace_stackmap {
+	struct trace_array	*tr;		/* owning trace_array */
+	unsigned int		map_bits;
+	unsigned int		map_size;	/* 1 << (map_bits + 1) */
+	unsigned int		max_elts;	/* 1 << map_bits */
+	u32			hash_seed;	/* per-instance jhash seed */
+	atomic_t		next_elt;	/* index into elts pool */
+	struct stackmap_entry	*entries;	/* hash table */
+	struct stackmap_elt	*elts;		/* flat element pool */
+	atomic_t		resetting;
+	atomic64_t		successes;	/* events served (hits + new inserts) */
+	atomic64_t		drops;
+};
+
+/*
+ * Cap the bits parameter to keep worst-case allocations bounded:
+ *   bits=18 → 256K elts, 512K slots, ~130 MB elt pool, ~130 MB bin
+ *             export.
+ * Smaller workloads should use the default (14) which gives 16K elts
+ * (~8 MB pool); bump bits via the ftrace_stackmap.bits= kernel
+ * parameter for higher unique-stack capacity.
+ */
+#define FTRACE_STACKMAP_BITS_MIN	10
+#define FTRACE_STACKMAP_BITS_MAX	18
+#define FTRACE_STACKMAP_BITS_DEFAULT	14
+
+static unsigned int stackmap_map_bits = FTRACE_STACKMAP_BITS_DEFAULT;
+static int __init stackmap_bits_setup(char *str)
+{
+	unsigned long val;
+
+	if (kstrtoul(str, 0, &val))
+		return -EINVAL;
+	val = clamp_val(val, FTRACE_STACKMAP_BITS_MIN, FTRACE_STACKMAP_BITS_MAX);
+	stackmap_map_bits = val;
+	return 0;
+}
+early_param("ftrace_stackmap.bits", stackmap_bits_setup);
+
+/* --- Element pool --- */
+
+static struct stackmap_elt *stackmap_get_elt(struct ftrace_stackmap *smap)
+{
+	int idx;
+
+	/*
+	 * Fast-path early-out once the pool is fully consumed. Avoids
+	 * the contended atomic RMW on next_elt for every traced event
+	 * after the pool is exhausted.
+	 */
+	if (atomic_read(&smap->next_elt) >= smap->max_elts)
+		return NULL;
+
+	idx = atomic_fetch_add_unless(&smap->next_elt, 1, smap->max_elts);
+	if (idx < smap->max_elts)
+		return &smap->elts[idx];
+	return NULL;
+}
+
+/* --- Create / Destroy / Reset --- */
+
+struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr)
+{
+	struct ftrace_stackmap *smap;
+	unsigned int bits;
+
+	smap = kzalloc(sizeof(*smap), GFP_KERNEL);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+
+	/* Defensive clamp: reject bogus bits even if early_param is bypassed. */
+	bits = clamp_val(stackmap_map_bits,
+			 FTRACE_STACKMAP_BITS_MIN,
+			 FTRACE_STACKMAP_BITS_MAX);
+
+	smap->tr = tr;
+	smap->map_bits = bits;
+	smap->max_elts = 1U << bits;
+	smap->map_size = 1U << (bits + 1);	/* 2x over-provision */
+	BUG_ON(!is_power_of_2(smap->map_size));
+
+	smap->entries = vzalloc(sizeof(*smap->entries) * smap->map_size);
+	if (!smap->entries) {
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Single large vmalloc of the element pool, indexed flat.
+	 * At bits=16 this is 64K * sizeof(struct stackmap_elt). The
+	 * struct is ~520 B (8 + 4 + 4 + 64*8), so total ~33 MB.
+	 */
+	smap->elts = vzalloc(sizeof(*smap->elts) * (size_t)smap->max_elts);
+	if (!smap->elts) {
+		vfree(smap->entries);
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	smap->hash_seed = get_random_u32();
+	atomic_set(&smap->next_elt, 0);
+	atomic_set(&smap->resetting, 0);
+	atomic64_set(&smap->successes, 0);
+	atomic64_set(&smap->drops, 0);
+
+	return smap;
+}
+
+void ftrace_stackmap_destroy(struct ftrace_stackmap *smap)
+{
+	if (!smap || IS_ERR(smap))
+		return;
+	vfree(smap->elts);
+	vfree(smap->entries);
+	kfree(smap);
+}
+
+/**
+ * ftrace_stackmap_reset - clear all entries in the stackmap
+ * @smap: the stackmap to reset
+ *
+ * Returns 0 on success, -EBUSY if another reset is already in
+ * progress, or if tracing is currently active on the owning
+ * trace_array.
+ *
+ * Online reset (with tracing active) is not supported. Caller must
+ * stop tracing first (echo 0 > tracing_on).
+ *
+ * Caller is process context (typically sysfs write handler).
+ *
+ * Protocol:
+ *   1. Atomically claim reset rights via cmpxchg on @resetting.
+ *   2. Verify tracing is stopped on @smap->tr; if not, release the
+ *      claim and return -EBUSY. The resetting flag itself blocks
+ *      any subsequent get_id() callers.
+ *   3. synchronize_rcu() drains in-flight get_id() callers from the
+ *      ftrace callback path (which runs preempt-disabled).
+ *   4. memset entries, elts, and counters.
+ *   5. Release the resetting flag with release semantics so any new
+ *      get_id() observes a fully cleared map.
+ */
+int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
+{
+	if (!smap)
+		return 0;
+
+	if (atomic_cmpxchg(&smap->resetting, 0, 1) != 0)
+		return -EBUSY;
+
+	if (smap->tr && tracer_tracing_is_on(smap->tr)) {
+		atomic_set(&smap->resetting, 0);
+		return -EBUSY;
+	}
+
+	/*
+	 * synchronize_rcu() itself is a full barrier; no extra smp_mb()
+	 * is needed before it. It drains in-flight ftrace callbacks that
+	 * may have already passed the resetting check with the old value.
+	 */
+	synchronize_rcu();
+
+	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
+
+	atomic_set(&smap->next_elt, 0);
+	atomic64_set(&smap->successes, 0);
+	atomic64_set(&smap->drops, 0);
+
+	/* Release resetting=0 so new get_id() observes a cleared map. */
+	atomic_set_release(&smap->resetting, 0);
+	return 0;
+}
+
+/* --- Core: get_id (lock-free, NMI-safe) --- */
+
+int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
+			   unsigned long *ips, unsigned int nr_entries)
+{
+	u32 key_hash, idx, test_key, trace_len;
+	struct stackmap_entry *entry;
+	struct stackmap_elt *val;
+	int probes = 0;
+
+	if (!smap || !nr_entries || atomic_read(&smap->resetting))
+		return -EINVAL;
+	if (nr_entries > FTRACE_STACKMAP_MAX_DEPTH)
+		nr_entries = FTRACE_STACKMAP_MAX_DEPTH;
+
+	trace_len = nr_entries * sizeof(unsigned long);
+	/*
+	 * jhash2() requires the length in u32 units and the data to be
+	 * u32-aligned. On 64-bit kernels sizeof(unsigned long)==8, so
+	 * trace_len is always a multiple of 8 (hence of 4). Use jhash2
+	 * directly; the cast to u32* is safe because ips[] is naturally
+	 * aligned to sizeof(unsigned long) >= 4.
+	 */
+	key_hash = jhash2((const u32 *)ips, trace_len / sizeof(u32),
+			  smap->hash_seed);
+	if (key_hash == 0)
+		key_hash = 1;	/* 0 means free slot */
+
+	idx = key_hash >> (32 - (smap->map_bits + 1));
+
+	while (probes < FTRACE_STACKMAP_MAX_PROBE) {
+		idx &= (smap->map_size - 1);
+		entry = &smap->entries[idx];
+		test_key = entry->key;
+
+		if (test_key == key_hash) {
+			/*
+			 * smp_load_acquire pairs with smp_store_release in
+			 * the publisher below; ensures we see fully-formed
+			 * elt fields (nr, ips, ref_count) before dereference.
+			 */
+			val = smp_load_acquire(&entry->val);
+			if (val && val->nr == nr_entries &&
+			    memcmp(val->ips, ips, trace_len) == 0) {
+				atomic_inc(&val->ref_count);
+				atomic64_inc(&smap->successes);
+				return (int)idx;
+			}
+			/*
+			 * val == NULL: another CPU is mid-insert, or this
+			 * slot is "claimed but empty" (pool exhausted).
+			 * val != NULL but mismatch: 32-bit hash collision
+			 * with a different stack. In both cases, advance.
+			 */
+		} else if (!test_key) {
+			/* Free slot: try to claim it */
+			if (cmpxchg(&entry->key, 0, key_hash) == 0) {
+				struct stackmap_elt *elt;
+
+				elt = stackmap_get_elt(smap);
+				if (!elt) {
+					/*
+					 * Pool exhausted. We claimed this
+					 * slot with cmpxchg but cannot fill
+					 * it. Leave key set so the slot
+					 * stays "claimed but empty" — future
+					 * lookups treat val==NULL as a miss
+					 * and probe past it. Cannot revert
+					 * key=0 without racing other CPUs.
+					 */
+					atomic64_inc(&smap->drops);
+					return -ENOSPC;
+				}
+
+				elt->nr = nr_entries;
+				atomic_set(&elt->ref_count, 1);
+				memcpy(elt->ips, ips, trace_len);
+
+				/*
+				 * Publish elt with release semantics so the
+				 * reader's smp_load_acquire can safely
+				 * dereference val->nr / val->ips.
+				 */
+				smp_store_release(&entry->val, elt);
+				atomic64_inc(&smap->successes);
+				return (int)idx;
+			}
+			/* cmpxchg failed; another CPU claimed this slot. */
+		}
+
+		idx++;
+		probes++;
+	}
+
+	atomic64_inc(&smap->drops);
+	return -ENOSPC;
+}
+
+/* --- Text export: /sys/kernel/debug/tracing/stack_map --- */
+
+struct stackmap_seq_private {
+	struct ftrace_stackmap	*smap;
+};
+
+static void *stackmap_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct stackmap_seq_private *priv = m->private;
+	struct ftrace_stackmap *smap = priv->smap;
+	u32 i;
+
+	if (!smap)
+		return NULL;
+	for (i = *pos; i < smap->map_size; i++) {
+		if (smap->entries[i].key && READ_ONCE(smap->entries[i].val)) {
+			*pos = i;
+			return &smap->entries[i];
+		}
+	}
+	return NULL;
+}
+
+static void *stackmap_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct stackmap_seq_private *priv = m->private;
+	struct ftrace_stackmap *smap = priv->smap;
+	u32 i;
+
+	if (!smap)
+		return NULL;
+	for (i = *pos + 1; i < smap->map_size; i++) {
+		if (smap->entries[i].key && READ_ONCE(smap->entries[i].val)) {
+			*pos = i;
+			return &smap->entries[i];
+		}
+	}
+	return NULL;
+}
+
+static void stackmap_seq_stop(struct seq_file *m, void *v) { }
+
+static int stackmap_seq_show(struct seq_file *m, void *v)
+{
+	struct stackmap_entry *entry = v;
+	struct stackmap_elt *elt = smp_load_acquire(&entry->val);
+	struct stackmap_seq_private *priv = m->private;
+	u32 idx = entry - priv->smap->entries;
+	u32 i, nr;
+
+	if (!elt)
+		return 0;
+
+	nr = READ_ONCE(elt->nr);
+	if (nr > FTRACE_STACKMAP_MAX_DEPTH)
+		nr = FTRACE_STACKMAP_MAX_DEPTH;
+
+	seq_printf(m, "stack_id %u [ref %u, depth %u]\n",
+		   idx, atomic_read(&elt->ref_count), nr);
+	for (i = 0; i < nr; i++)
+		seq_printf(m, "  [%u] %pS\n", i, (void *)elt->ips[i]);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static const struct seq_operations stackmap_seq_ops = {
+	.start	= stackmap_seq_start,
+	.next	= stackmap_seq_next,
+	.stop	= stackmap_seq_stop,
+	.show	= stackmap_seq_show,
+};
+
+static int stackmap_open(struct inode *inode, struct file *file)
+{
+	struct stackmap_seq_private *priv;
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open_private(file, &stackmap_seq_ops,
+			       sizeof(struct stackmap_seq_private));
+	if (ret)
+		return ret;
+	m = file->private_data;
+	priv = m->private;
+	priv->smap = inode->i_private;
+	return 0;
+}
+
+/*
+ * Accept exactly "0" or "reset" (optionally followed by a single newline).
+ */
+static bool stackmap_write_is_reset(const char *buf, size_t n)
+{
+	if (n > 0 && buf[n - 1] == '\n')
+		n--;
+	return (n == 1 && buf[0] == '0') ||
+	       (n == 5 && memcmp(buf, "reset", 5) == 0);
+}
+
+static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_seq_private *priv = m->private;
+	char buf[8];
+	size_t n = min(count, sizeof(buf) - 1);
+	int ret;
+
+	if (n == 0)
+		return -EINVAL;
+	if (copy_from_user(buf, ubuf, n))
+		return -EFAULT;
+	buf[n] = '\0';
+
+	if (!stackmap_write_is_reset(buf, n))
+		return -EINVAL;
+
+	/*
+	 * ftrace_stackmap_reset() atomically claims reset rights via
+	 * cmpxchg and returns -EBUSY if another reset is in progress
+	 * or if tracing is active.
+	 */
+	ret = ftrace_stackmap_reset(priv->smap);
+	if (ret)
+		return ret;
+	return count;
+}
+
+const struct file_operations ftrace_stackmap_fops = {
+	.open		= stackmap_open,
+	.read		= seq_read,
+	.write		= stackmap_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
+/* --- Stats --- */
+
+static int stackmap_stat_show(struct seq_file *m, void *v)
+{
+	struct ftrace_stackmap *smap = m->private;
+	u32 entries;
+	u64 successes, drops;
+
+	if (!smap) {
+		seq_puts(m, "stackmap not initialized\n");
+		return 0;
+	}
+
+	entries = atomic_read(&smap->next_elt);
+	successes = atomic64_read(&smap->successes);
+	drops = atomic64_read(&smap->drops);
+
+	seq_printf(m, "entries:      %u / %u\n", entries, smap->max_elts);
+	seq_printf(m, "table_size:   %u\n", smap->map_size);
+	seq_printf(m, "successes:    %llu\n", successes);
+	seq_printf(m, "drops:        %llu\n", drops);
+	if (successes + drops > 0)
+		seq_printf(m, "success_rate: %llu%%\n",
+			   successes * 100 / (successes + drops));
+	return 0;
+}
+
+static int stackmap_stat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, stackmap_stat_show, inode->i_private);
+}
+
+const struct file_operations ftrace_stackmap_stat_fops = {
+	.open		= stackmap_stat_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+/* --- Binary export --- */
+
+struct stackmap_bin_snapshot {
+	/*
+	 * Use u64 (not size_t) so data[] is 8-byte aligned on both
+	 * 32-bit and 64-bit architectures. The IP array within data[]
+	 * is accessed as u64*, which would alignment-fault on strict
+	 * architectures (e.g. older ARM, SPARC) if data[] started at
+	 * a 4-byte boundary.
+	 */
+	u64	size;
+	char	data[];
+};
+
+static int stackmap_bin_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_stackmap *smap = inode->i_private;
+	struct stackmap_bin_snapshot *snap;
+	struct ftrace_stackmap_bin_header *hdr;
+	size_t alloc_size, off;
+	u32 nr_entries, i, nr_stacks;
+
+	if (!smap)
+		return -ENODEV;
+
+	/*
+	 * Worst-case allocation size: every populated entry uses a
+	 * full-depth stack. The (+1) gives one slack slot in case a
+	 * concurrent insert lands between this snapshot and iteration.
+	 * The loop below performs an explicit bounds check anyway.
+	 *
+	 * At bits=16 this caps at ~33 MB. The file is mode 0440
+	 * (TRACE_MODE_READ), so only privileged users can open it.
+	 */
+	nr_entries = atomic_read(&smap->next_elt);
+	alloc_size = sizeof(*hdr) + (nr_entries + 1) *
+		     (sizeof(struct ftrace_stackmap_bin_entry) +
+		      FTRACE_STACKMAP_MAX_DEPTH * sizeof(u64));
+
+	snap = vmalloc(sizeof(*snap) + alloc_size);
+	if (!snap)
+		return -ENOMEM;
+
+	hdr = (struct ftrace_stackmap_bin_header *)snap->data;
+	hdr->magic = FTRACE_STACKMAP_BIN_MAGIC;
+	hdr->version = FTRACE_STACKMAP_BIN_VERSION;
+	hdr->reserved = 0;
+	off = sizeof(*hdr);
+	nr_stacks = 0;
+
+	for (i = 0; i < smap->map_size; i++) {
+		struct stackmap_entry *entry = &smap->entries[i];
+		struct stackmap_elt *elt;
+		struct ftrace_stackmap_bin_entry *e;
+		u64 *ips_out;
+		u32 k, nr;
+
+		if (!entry->key)
+			continue;
+		elt = smp_load_acquire(&entry->val);
+		if (!elt)
+			continue;
+
+		nr = READ_ONCE(elt->nr);
+		if (nr > FTRACE_STACKMAP_MAX_DEPTH)
+			nr = FTRACE_STACKMAP_MAX_DEPTH;
+
+		/* Bounds check: stop if we would overflow the allocation. */
+		if (off + sizeof(*e) + nr * sizeof(u64) > alloc_size)
+			break;
+
+		e = (struct ftrace_stackmap_bin_entry *)(snap->data + off);
+		e->stack_id = i;
+		e->nr = nr;
+		e->ref_count = atomic_read(&elt->ref_count);
+		e->reserved = 0;
+		off += sizeof(*e);
+
+		ips_out = (u64 *)(snap->data + off);
+		for (k = 0; k < nr; k++)
+			ips_out[k] = (u64)elt->ips[k];
+		off += nr * sizeof(u64);
+		nr_stacks++;
+	}
+
+	hdr->nr_stacks = nr_stacks;
+	snap->size = off;
+	file->private_data = snap;
+	return 0;
+}
+
+static ssize_t stackmap_bin_read(struct file *file, char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	struct stackmap_bin_snapshot *snap = file->private_data;
+
+	if (!snap)
+		return -EINVAL;
+	return simple_read_from_buffer(ubuf, count, ppos, snap->data, snap->size);
+}
+
+static int stackmap_bin_release(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+	return 0;
+}
+
+const struct file_operations ftrace_stackmap_bin_fops = {
+	.open		= stackmap_bin_open,
+	.read		= stackmap_bin_read,
+	.llseek		= default_llseek,
+	.release	= stackmap_bin_release,
+};
diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
new file mode 100644
index 000000000000..da51ed919e2c
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACE_STACKMAP_H
+#define _TRACE_STACKMAP_H
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+#define FTRACE_STACKMAP_MAX_DEPTH	64
+
+/* Binary export format */
+#define FTRACE_STACKMAP_BIN_MAGIC	0x464D5342	/* 'FSMB' */
+#define FTRACE_STACKMAP_BIN_VERSION	2
+
+struct ftrace_stackmap_bin_header {
+	u32 magic;
+	u32 version;
+	u32 nr_stacks;
+	u32 reserved;
+};
+
+struct ftrace_stackmap_bin_entry {
+	u32 stack_id;
+	u32 nr;
+	u32 ref_count;
+	u32 reserved;
+	/* followed by u64 ips[nr] */
+};
+
+struct trace_array;
+
+#ifdef CONFIG_FTRACE_STACKMAP
+
+struct ftrace_stackmap;
+
+struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr);
+void ftrace_stackmap_destroy(struct ftrace_stackmap *smap);
+int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
+			   unsigned long *ips, unsigned int nr_entries);
+int ftrace_stackmap_reset(struct ftrace_stackmap *smap);
+
+extern const struct file_operations ftrace_stackmap_fops;
+extern const struct file_operations ftrace_stackmap_stat_fops;
+extern const struct file_operations ftrace_stackmap_bin_fops;
+
+#else
+
+struct ftrace_stackmap;
+static inline struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr) { return NULL; }
+static inline void ftrace_stackmap_destroy(struct ftrace_stackmap *s) { }
+static inline int ftrace_stackmap_get_id(struct ftrace_stackmap *s,
+					 unsigned long *ips, unsigned int n)
+{ return -ENOSYS; }
+static inline int ftrace_stackmap_reset(struct ftrace_stackmap *s) { return 0; }
+
+#endif
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

