Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com [74.125.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07548415F36
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202327; cv=none; b=QyGc5TYwcMdpA2+Wqmos1sVlem4QalyVc0E6QlQQWo1wjQawDbEUYyKpOEtAwz7v1E481JXxASZe71KuZTGhX8476IOmUfz2SoQjOWxsPYEUlqPpMZNmkLAOUnz5ULiGQlxoAfmIaanJppuNnB2eTw1wrAZIOJmsm4aOE4QkTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202327; c=relaxed/simple;
	bh=PzCZBjJWaCCKdMcSxGra6Fz+22Hq1J9zwQ18FQBKIA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzao+o+bNAGty4SOyf4AIct7LBeF5lBYzS+rEqHwFJSjl6PHyHr0crR/HRJtN8kPpFO0Bh8Xn0b+1HR2vTbsHwR7mUdjOe0XtvusDKBUVITASmjc8mgI9t8h0O+NARw42jq+OB5wTy48R/+D0sgxN+63rLiN8tOpLpEoMINRmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/w/ZqED; arc=none smtp.client-ip=74.125.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/w/ZqED"
Received: by mail-pz2-f32.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so306805a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202324; x=1789807124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bnGyTrhGQ9hlSyKFOD2fzct0ljWaLr72VtuDV6nx8cw=;
        b=k/w/ZqEDS7stp/4A2pjoIB6WE9+SI0noGVQnbCKoLJkueUmAHZ7iuUplXkFqgwQjMl
         uiN7u+KqfsEB4vGt67iK6VfCgMBZWX0L8pLAwXovvwEU2klTbs+9MFO/dQZL2oD3j+9x
         sErcOQFBbvlG1sUHajNkHNa7gXmPfAAziEH/MOnHldw/iBqp9xWgGgxU6yPtBrWPlPwJ
         VqVb0ag8QiBZV42vi6CFXCmUSdF1xtgpwD0kWzxdaupdhxfohyBk8egvdEzZMv3rqI9j
         S/duRnaRsa3iTvJDz0oPp5CU+hBbd4X8vcqW63vniIkF1ZXlh65fWKVGf5Vn+/kYIpqQ
         mlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202324; x=1789807124;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnGyTrhGQ9hlSyKFOD2fzct0ljWaLr72VtuDV6nx8cw=;
        b=ITUKdJ7YE+oSvyPKedHy8gScfTGzWZpXVaDp0NQyJ6SdVCJNtkLUJXRVphqVo7yLaK
         1dJtbTkyaGiqm1jZASP9ARWpih3FkrK++XigYy2Zw4miZlUGkvgAJFDNnetk8IeRWLgb
         BLXnOuvQ5mP+zF8U4V05AQf3pOaj5daG+kGV9pEfMTM2YvU1YTrPJwuTnsUj97W76l0P
         dd6HJmSICGlCuFYQT8bFwyqizS+EyWMXTrFmwCQhkaH59bz18ofypD5GCUbkA8G/Zc40
         ndcEeQ3sz43ZQ23F88JR9Qs2mbACOI+ev2bsgTRC4dcOFcI1NrjaOBuvHu4YuZCVGrDY
         Ofiw==
X-Forwarded-Encrypted: i=1; AKwUvBy7WT4APtaRrMUnpZmxHMBMezdjgyW9McpqMV9woRjKUmjYUDHYqzPvcH4q+7N44zOMiH4bv+jQlr9RZ7VcP2Amny4=@vger.kernel.org
X-Gm-Message-State: AFuF++nFO3bODGHTQ1uQjUImtqVmAK3Hq86IUnL8Qpdjq38Qvyisa3on
	R6HnXpUrptB4PRCH4uiPn5dwPpuQpQF3no0NESk3QT4QNMhk4u05Ga/S
X-Gm-Gg: AYBFou0Hr5Zhtf+HtRN2sa1OEp+li0KlSZmjXoEdKWM85FGVjrtMKwg0NqIjG6daS7Z
	Y++BQel9WxTdsfUgvJyHe5VC2Yrhn+bWpSzKEiXVMR7Rnsy4sBpKSCelkHkba6w1YsTjt+pOec0
	Qzo6BASSSmLNunJETeHatrb0Xl2Yk112vn7vOSOqh85f7Elp2thlwBiKkIP4wdw3rW1fTxSFUuD
	32XoMXNVLoZPuqtw2bYXmuFkJISWGtYnX9m+GJj4jWWv7HWP7Ydqb6OvuMyN2GkjdG3HdgVuPmN
	pZnjwJcgMGxtgimClCS4wLefJ4X3gbJ2kVIltytfZAFDrm7yO/lIoxxz2ejZYvDLkbOPyS9v/+J
	VhATAa+9Vx4IMrZeucO6jEDM5iuBvAsPquAyQOj4KAvPaY23lMQt8W7JOc+9cnjRI5XjH/XPakO
	lqR4Xy0BZVY1IcsP52dDVwZaK8lTow+MY6YGTD3mrWa1PHX3fZi8JeJtmS4+tPnzuXdOcATYFwA
	VfywLfeO8+r1pBqAgxwPxuXrpivPSDp2C+PN9YA
X-Received: by 2002:a17:90b:3b92:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39dbc1d95fbmr3492502a91.11.1789202323873;
        Sat, 12 Sep 2026 01:38:43 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:38:41 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 01/10] trace: add lock-free stackmap for stack trace deduplication
Date: Sat, 12 Sep 2026 16:37:44 +0800
Message-Id: <20260912083753.3426176-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add ftrace_stackmap, a lock-free hash map that stores kernel stack
records so the ftrace ring buffer can reference a stack by a 4-byte id
instead of carrying all of its frames. This patch adds the map, its text
export and reset path; the recording path is converted separately.

The implementation follows tracing_map.c's non-blocking design:

- cmpxchg-based insertion is usable from NMI, IRQ and process context
- a preallocated element pool keeps allocation out of the hot path
- linear probing uses a 2x table and a bounded probe length
- one map belongs to one trace_array

The Kconfig entry depends on ARCH_HAVE_NMI_SAFE_CMPXCHG because the hot
path is reachable from NMI context. Per-CPU atomic_long_t counters avoid
cross-CPU cacheline contention, use native-long operations instead of the
generic atomic64_t spinlock fallback on 32-bit systems, and saturate
rather than wrap.

Capacity is fixed here at 2^14 stack records, using about 8 MB for the
element pool. Concurrent insertion races can create duplicate records,
so this is not a strict unique-stack count. Boot-time sizing is added
separately.

ftrace_stackmap_get_id() rejects stacks deeper than 64 frames instead
of truncating them. entry->val uses release/acquire publication and
entry->key is read with READ_ONCE(). Claimed slots without an element
remain bounded gravestones when the pool is exhausted.

Reset clears only map-owned storage. It leaves the ring buffer intact
and can run while tracing is active, so older stack ids may stop
resolving or may resolve to a reused slot. Every valid get_id() call
enters an explicit rcu_read_lock_sched_notrace() section before checking
the resetting flag. Callers that observe an active reset leave without
touching map storage; admitted callers are drained before storage is
cleared. synchronize_rcu_tasks_rude() covers RCU-not-watching tracing
contexts, synchronize_rcu() covers the explicit RCU-sched sections,
including interrupt and NMI handlers, and reader_sem serializes tracefs
readers against clearing.

The text seq_file resolves adjusted addresses, renders the ftrace
trampoline marker, and accepts "0" or "reset" to clear the map.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig          |  23 ++
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace_stackmap.c | 718 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  34 ++
 4 files changed, 776 insertions(+)
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 084f34dc6c9f..6c40535a46e1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -412,6 +412,29 @@ config STACK_TRACER
 
 	  Say N if unsure.
 
+config FTRACE_STACKMAP
+	bool "Ftrace stack map deduplication"
+	depends on TRACING
+	depends on STACKTRACE
+	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select KALLSYMS
+	select TASKS_RUDE_RCU
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
+	  Writing to this file resets the stack map. Reading shows all stack
+	  records with their stack_id and reference count.
+
+	  Say Y if you want to reduce ftrace buffer usage for stack traces.
+	  Say N if unsure.
+
 config TRACE_PREEMPT_TOGGLE
 	bool
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..7710ec2659e9 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
 obj-$(CONFIG_OSNOISE_TRACER) += trace_osnoise.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
+obj-$(CONFIG_FTRACE_STACKMAP) += trace_stackmap.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
new file mode 100644
index 000000000000..b2e2115a15f9
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,718 @@
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
+ * Reset is a control-path operation that clears the map only. It
+ * does not touch the ring buffer and does not require tracing to be
+ * stopped. The protocol is:
+ *
+ *   - Every admitted get_id() operation enters an explicit notrace
+ *     RCU-sched read-side section before checking resetting. A caller
+ *     that observes resetting=1 returns -EINVAL.
+ *   - synchronize_rcu_tasks_rude() drains callers running where RCU is
+ *     not watching on architectures that permit tracing there. A normal
+ *     RCU grace period then drains the explicit read-side sections in
+ *     the RCU-watching tracing path, including interrupt and NMI handlers.
+ *
+ * A trace collected before a reset can therefore still contain
+ * TRACE_STACK_ID records whose id no longer resolves, or resolves to
+ * a slot that has since been reused. That is misleading userspace
+ * output, not corruption; see ftrace_stackmap_reset().
+ *
+ * The 32-bit jhash of the stack IPs is the hash table key. On hash
+ * collision, linear probing finds the next slot and full memcmp
+ * confirms the match.
+ *
+ * Concurrent userspace readers (cat stack_map) get a best-effort
+ * snapshot. They are coherent with the hot path (smp_load_acquire on
+ * entry->val); they are also serialized against reset via
+ * smap->reader_sem (readers take it in shared mode, reset in
+ * exclusive mode), so a reset cannot tear a single seq_file pass --
+ * it waits for the active read() pass to drop the rwsem before clearing
+ * the map. The hot path is coordinated with reset separately, via
+ * acquire/release on smap->resetting.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/percpu.h>
+#include <linux/random.h>
+#include <linux/rcupdate.h>
+#include <linux/log2.h>
+#include <asm/local.h>
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
+ * Memory ordering of entry->val: published with smp_store_release()
+ * by the inserter; consumed with smp_load_acquire() by every reader
+ * that dereferences the elt (get_id, seq_show). This pairs
+ * the writes to elt->{nr,ips,ref_count} (initialized BEFORE the
+ * publish) with the reads of those fields (which happen AFTER the
+ * load). seq_start / seq_next only test val for NULL and use the
+ * acquire load purely to keep memory ordering symmetric.
+ */
+
+/*
+ * Each pre-allocated element holds one stack trace record.
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
+static struct stackmap_elt *stackmap_load_elt(struct stackmap_entry *entry)
+{
+	/*
+	 * Pairs with the smp_store_release() that publishes entry->val
+	 * after fully initializing the element payload.
+	 */
+	return smp_load_acquire(&entry->val);
+}
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
+	/*
+	 * Reader/reset serialization. Held in shared mode (read lock)
+	 * across seq_file iteration; held in exclusive mode (write
+	 * lock) by reset's clearing phase. The hot path (get_id) does
+	 * not take this lock — it
+	 * uses smp_load_acquire/smp_store_release on entry->val and
+	 * the resetting flag for the lock-free protocol.
+	 */
+	struct rw_semaphore	reader_sem;
+	/*
+	 * Per-CPU atomic-long counters keep cross-CPU contention out of the
+	 * NMI-capable hot path. atomic_long_add_unless() uses the native long
+	 * width, so 32-bit kernels do not enter the generic atomic64_t
+	 * hashed-spinlock implementation. ARCH_HAVE_NMI_SAFE_CMPXCHG makes
+	 * the saturating update safe against same-CPU NMI interruption.
+	 */
+	atomic_long_t __percpu	*successes;	/* hits + new inserts */
+	atomic_long_t __percpu	*drops;
+};
+
+/*
+ * Map capacity: 2^FTRACE_STACKMAP_BITS stack records, with the hash
+ * table over-provisioned 2x on top of that. This gives 16K elements
+ * and a ~8 MB element pool, sized for the repetitive-stack workloads
+ * the map targets.
+ */
+#define FTRACE_STACKMAP_BITS		14
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
+	unsigned int bits = FTRACE_STACKMAP_BITS;
+
+	smap = kzalloc_obj(*smap, GFP_KERNEL);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+
+	smap->tr = tr;
+	smap->map_bits = bits;
+	smap->max_elts = 1U << bits;
+	smap->map_size = 1U << (bits + 1);	/* 2x over-provision */
+
+	smap->entries = vcalloc(smap->map_size, sizeof(*smap->entries));
+	if (!smap->entries)
+		goto fail;
+
+	/*
+	 * Single large vmalloc of the element pool, indexed flat.
+	 * At bits=18 this is 256K * sizeof(struct stackmap_elt). The
+	 * struct is ~520 B (8 + 4 + 4 + 64*8), so total ~135 MB.
+	 */
+	smap->elts = vcalloc(smap->max_elts, sizeof(*smap->elts));
+	if (!smap->elts)
+		goto fail;
+
+	smap->successes = alloc_percpu(atomic_long_t);
+	if (!smap->successes)
+		goto fail;
+	smap->drops = alloc_percpu(atomic_long_t);
+	if (!smap->drops)
+		goto fail;
+
+	smap->hash_seed = get_random_u32();
+	atomic_set(&smap->next_elt, 0);
+	atomic_set(&smap->resetting, 0);
+	init_rwsem(&smap->reader_sem);
+
+	return smap;
+
+fail:
+	/*
+	 * free_percpu()/vfree()/kfree() all handle NULL, and smap was
+	 * zero-initialized, so unwind in reverse allocation order.
+	 */
+	free_percpu(smap->drops);
+	free_percpu(smap->successes);
+	vfree(smap->elts);
+	vfree(smap->entries);
+	kfree(smap);
+	return ERR_PTR(-ENOMEM);
+}
+
+void ftrace_stackmap_destroy(struct ftrace_stackmap *smap)
+{
+	if (!smap || IS_ERR(smap))
+		return;
+	free_percpu(smap->drops);
+	free_percpu(smap->successes);
+	vfree(smap->elts);
+	vfree(smap->entries);
+	kfree(smap);
+}
+
+/**
+ * ftrace_stackmap_reset - clear all entries in the stackmap
+ * @smap: the stackmap to reset
+ *
+ * Returns 0 on success, or -EBUSY if another reset is already in
+ * progress.
+ *
+ * Clears the map only. The ring buffer is left alone and tracing does
+ * not need to be stopped, so a trace can still contain TRACE_STACK_ID
+ * records after the map has been cleared. Such an id either has no
+ * entry in stack_map, or -- once tracing continues and the slot is
+ * reused -- resolves to an unrelated stack. Both are misleading
+ * userspace output rather than corruption: reset frees nothing, it
+ * only memsets storage the map still owns.
+ *
+ * Caller is process context (the tracefs write handler).
+ *
+ * Protocol:
+ *   1. Atomically claim reset rights via cmpxchg on @resetting, which
+ *      makes subsequent get_id() callers leave their read-side section
+ *      without touching map storage.
+ *   2. synchronize_rcu_tasks_rude() drains callers running where RCU is
+ *      not watching on architectures that allow tracing there. Then
+ *      synchronize_rcu() drains the explicit notrace RCU-sched sections
+ *      in the RCU-watching tracing path, including interrupt and NMI
+ *      handlers.
+ *   3. Take @reader_sem exclusively to exclude tracefs readers, then
+ *      memset entries, elts, and counters.
+ *   4. Release the resetting flag with release semantics so any new
+ *      get_id() observes a fully cleared map.
+ *
+ * Why no get_id() can run concurrently with the memsets, given that its
+ * admission test is a plain flag read rather than a lock. Consider any
+ * get_id() RCU-sched read-side section, and note that the flag store in
+ * step 1 precedes the grace period in step 2:
+ *
+ *   - The section ends before synchronize_rcu() returns. The memsets run
+ *     after it returns, so the two cannot overlap, whichever value of
+ *     resetting that section happened to observe.
+ *   - The section ends after synchronize_rcu() returns. RCU then
+ *     guarantees a full memory barrier between the start of the grace
+ *     period and the start of that section, so the section observes
+ *     resetting == 1 and returns -EINVAL without touching map storage.
+ *
+ * A section that reads a stale zero and still runs during the memsets
+ * would have to satisfy both cases at once, so it cannot exist. See
+ * "Memory-Barrier Guarantees" in
+ * Documentation/RCU/Design/Requirements/Requirements.rst.
+ */
+static int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
+{
+	int cpu;
+
+	if (!smap)
+		return 0;
+
+	if (atomic_cmpxchg(&smap->resetting, 0, 1) != 0)
+		return -EBUSY;
+
+	/*
+	 * Each get_id() operation enters an explicit notrace RCU-sched
+	 * read-side section before checking resetting. On RCU-watching CPUs,
+	 * the normal grace period waits for those sections, including callers
+	 * from interrupt and NMI context. On architectures that permit tracing
+	 * while RCU is not watching, the rude grace period covers the remaining
+	 * context; it is intentionally a no-op on ARCH_WANTS_NO_INSTR
+	 * architectures.
+	 */
+	synchronize_rcu_tasks_rude();
+	synchronize_rcu();
+
+	/*
+	 * Take the reader_sem in exclusive mode. This serializes the
+	 * memset against any tracefs reader (seq_file iteration) that
+	 * may currently hold the rwsem for read. The Tasks RCU grace
+	 * periods already drained the hot path; this rwsem covers
+	 * process-context export readers.
+	 */
+	down_write(&smap->reader_sem);
+
+	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
+
+	atomic_set(&smap->next_elt, 0);
+	for_each_possible_cpu(cpu) {
+		atomic_long_set(per_cpu_ptr(smap->successes, cpu), 0);
+		atomic_long_set(per_cpu_ptr(smap->drops, cpu), 0);
+	}
+
+	up_write(&smap->reader_sem);
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
+	int ret;
+
+	if (!smap || !nr_entries)
+		return -EINVAL;
+	/*
+	 * Never truncate: a stack deeper than the map can hold must not be
+	 * silently shortened, or two distinct traces sharing their first
+	 * FTRACE_STACKMAP_MAX_DEPTH frames would be merged into one
+	 * stack_id. The caller is expected to fall back to a full stack
+	 * trace for such events. Reject defensively in case of a future
+	 * caller that forgets this contract.
+	 */
+	if (nr_entries > FTRACE_STACKMAP_MAX_DEPTH)
+		return -E2BIG;
+
+	/*
+	 * Enter the read-side section before checking resetting. If reset
+	 * has already claimed the map, reject the operation. Otherwise the
+	 * reset grace periods wait until this operation leaves the section
+	 * before clearing storage. The notrace variant is required because
+	 * this is part of the tracing hot path.
+	 */
+	rcu_read_lock_sched_notrace();
+	/*
+	 * atomic_read_acquire() pairs with atomic_set_release() in the
+	 * reset path. This ensures that subsequent reads of entry->key
+	 * and entry->val are ordered after this check; without acquire,
+	 * the CPU would only have a control dependency, which orders
+	 * subsequent stores but not loads (per LKMM).
+	 */
+	if (atomic_read_acquire(&smap->resetting)) {
+		ret = -EINVAL;
+		goto out;
+	}
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
+		/*
+		 * READ_ONCE() to avoid LKMM data race with concurrent
+		 * cmpxchg(&entry->key, 0, key_hash) on this slot.
+		 */
+		test_key = READ_ONCE(entry->key);
+
+		if (test_key == key_hash) {
+			val = stackmap_load_elt(entry);
+			/*
+			 * READ_ONCE(val->nr) keeps style consistent with
+			 * the seq_show reader. nr is write-once
+			 * (set before publish, never modified afterwards),
+			 * so the load is data-race-free, but READ_ONCE
+			 * silences any analysis tool that flags a plain
+			 * read of a field that is also read under acquire
+			 * elsewhere.
+			 */
+			if (val && READ_ONCE(val->nr) == nr_entries &&
+			    memcmp(val->ips, ips, trace_len) == 0) {
+				/*
+				 * ref_count is a best-effort popularity
+				 * counter. On a long (from-boot, multi-hour)
+				 * trace a hot stack can be hit billions of
+				 * times. atomic_add_unless() gives true
+				 * saturation at INT_MAX even under concurrent
+				 * hits on multiple CPUs (a plain
+				 * check-then-inc could let several CPUs past
+				 * the check near the cap and still wrap).
+				 */
+				atomic_add_unless(&val->ref_count, 1, INT_MAX);
+				/*
+				 * successes/drops are saturating throughput
+				 * counters. Keep them per-CPU to avoid
+				 * cross-CPU cacheline contention.
+				 */
+				atomic_long_add_unless(
+					this_cpu_ptr(smap->successes), 1, LONG_MAX);
+				ret = (int)idx;
+				goto out;
+			}
+			/*
+			 * val == NULL: another CPU is mid-insert, or this
+			 * slot is "claimed but empty" (pool exhausted).
+			 * val != NULL but mismatch: 32-bit hash collision
+			 * with a different stack. In both cases, advance.
+			 */
+		} else if (!test_key) {
+			/*
+			 * Free slot: try to claim it.
+			 *
+			 * If two CPUs race here with the same key_hash
+			 * (same stack), one loses the cmpxchg, advances,
+			 * and may insert the same stack at a later slot.
+			 * This can produce a small number of duplicate
+			 * entries under heavy contention. The trade-off
+			 * is accepted to keep the hot path lock-free;
+			 * ref_count is split across the duplicates and
+			 * total memory cost is bounded by the element
+			 * pool size.
+			 */
+			if (cmpxchg(&entry->key, 0, key_hash) == 0) {
+				struct stackmap_elt *elt;
+
+				elt = stackmap_get_elt(smap);
+				if (!elt) {
+					/*
+					 * Pool exhausted. Keep the claimed
+					 * slot as a gravestone. Readers skip
+					 * a NULL val, and the explicit probe
+					 * bound prevents accumulated
+					 * gravestones from turning a miss
+					 * into an unbounded table walk.
+					 */
+					atomic_long_add_unless(
+						this_cpu_ptr(smap->drops), 1,
+						LONG_MAX);
+					ret = -ENOSPC;
+					goto out;
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
+				atomic_long_add_unless(
+					this_cpu_ptr(smap->successes), 1, LONG_MAX);
+				ret = (int)idx;
+				goto out;
+			}
+			/* cmpxchg failed; another CPU claimed this slot. */
+		}
+
+		idx++;
+		probes++;
+	}
+
+	atomic_long_add_unless(this_cpu_ptr(smap->drops), 1, LONG_MAX);
+	ret = -ENOSPC;
+out:
+	rcu_read_unlock_sched_notrace();
+	return ret;
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
+	loff_t i;
+
+	if (!smap)
+		return NULL;
+	/*
+	 * Take the reader_sem to serialize against ftrace_stackmap_reset(),
+	 * which holds it for write while clearing the table. Released in
+	 * stackmap_seq_stop(), which seq_file calls regardless of whether
+	 * start() returned an element or NULL (per Documentation/filesystems
+	 * /seq_file.rst: "the iterator value returned by start() or next()
+	 * is guaranteed to be passed to a subsequent next() or stop()").
+	 */
+	down_read(&smap->reader_sem);
+	for (i = *pos; i < smap->map_size; i++) {
+		if (READ_ONCE(smap->entries[i].key) &&
+		    stackmap_load_elt(&smap->entries[i])) {
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
+	loff_t i;
+
+	if (!smap)
+		return NULL;
+	for (i = *pos + 1; i < smap->map_size; i++) {
+		if (READ_ONCE(smap->entries[i].key) &&
+		    stackmap_load_elt(&smap->entries[i])) {
+			*pos = i;
+			return &smap->entries[i];
+		}
+	}
+	/*
+	 * Advance *pos past the end so that on the next read() the
+	 * subsequent stackmap_seq_start() call returns NULL and the
+	 * iteration terminates. Without this, seq_read() would loop
+	 * on the last element.
+	 */
+	*pos = smap->map_size;
+	return NULL;
+}
+
+static void stackmap_seq_stop(struct seq_file *m, void *v)
+{
+	struct stackmap_seq_private *priv = m->private;
+	struct ftrace_stackmap *smap = priv->smap;
+
+	/*
+	 * seq_file invokes stop() unconditionally after each iteration
+	 * pass (see seq_read_iter / traverse), even when start() returned
+	 * NULL. Always release here, balanced against the down_read in
+	 * stackmap_seq_start().
+	 */
+	if (smap)
+		up_read(&smap->reader_sem);
+}
+
+static int stackmap_seq_show(struct seq_file *m, void *v)
+{
+	struct stackmap_entry *entry = v;
+	struct stackmap_seq_private *priv = m->private;
+	struct stackmap_elt *elt;
+	u32 idx = entry - priv->smap->entries;
+	u32 i, nr;
+
+	elt = stackmap_load_elt(entry);
+	if (!elt)
+		return 0;
+
+	nr = READ_ONCE(elt->nr);
+	if (nr > FTRACE_STACKMAP_MAX_DEPTH)
+		nr = FTRACE_STACKMAP_MAX_DEPTH;
+
+	seq_printf(m, "stack_id %u [ref %u, depth %u]\n",
+		   idx, atomic_read(&elt->ref_count), nr);
+	for (i = 0; i < nr; i++) {
+		unsigned long ip = elt->ips[i];
+
+		/*
+		 * Mirror trace_stack_print(): __ftrace_trace_stack()
+		 * may replace trampoline addresses with
+		 * FTRACE_TRAMPOLINE_MARKER before the stack reaches the
+		 * map, and normal addresses must go through
+		 * trace_adjust_address() (KASLR / module text delta)
+		 * before symbolization. Without this the export would
+		 * print a bogus symbol for the marker and unadjusted
+		 * addresses for everything else.
+		 */
+		if (ip == FTRACE_TRAMPOLINE_MARKER) {
+			seq_printf(m, "  [%u] [FTRACE TRAMPOLINE]\n", i);
+			continue;
+		}
+		seq_printf(m, "  [%u] %pS\n", i,
+			   (void *)trace_adjust_address(priv->smap->tr, ip));
+	}
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
+	struct ftrace_stackmap *smap = inode->i_private;
+	struct stackmap_seq_private *priv;
+	struct seq_file *m;
+	int ret;
+
+	if (!smap)
+		return -ENODEV;
+
+	/*
+	 * The text export symbolizes recorded kernel text addresses and
+	 * doubles as the reset control file, so it takes the same open-time
+	 * tracing policy as the other stackmap files: reject the open under
+	 * LOCKDOWN_TRACEFS or when tracing is globally disabled, and pin the
+	 * owning trace array for the lifetime of the fd.
+	 */
+	ret = tracing_check_open_get_tr(smap->tr);
+	if (ret)
+		return ret;
+
+	ret = seq_open_private(file, &stackmap_seq_ops,
+			       sizeof(struct stackmap_seq_private));
+	if (ret)
+		goto put_tr;
+
+	m = file->private_data;
+	priv = m->private;
+	priv->smap = smap;
+	return 0;
+
+put_tr:
+	trace_array_put(smap->tr);
+	return ret;
+}
+
+static int stackmap_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_seq_private *priv = m->private;
+	struct ftrace_stackmap *smap = priv->smap;
+	int ret;
+
+	ret = seq_release_private(inode, file);
+	trace_array_put(smap->tr);
+	return ret;
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
+	 * cmpxchg and returns -EBUSY if another reset is already in
+	 * progress.
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
+	.release	= stackmap_release,
+};
diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
new file mode 100644
index 000000000000..979d6fd76460
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACE_STACKMAP_H
+#define _TRACE_STACKMAP_H
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+#define FTRACE_STACKMAP_MAX_DEPTH	64
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
+
+extern const struct file_operations ftrace_stackmap_fops;
+
+#else
+
+struct ftrace_stackmap;
+static inline struct ftrace_stackmap *
+ftrace_stackmap_create(struct trace_array *tr) { return NULL; }
+static inline void ftrace_stackmap_destroy(struct ftrace_stackmap *s) { }
+static inline int ftrace_stackmap_get_id(struct ftrace_stackmap *s,
+					 unsigned long *ips, unsigned int n)
+{ return -EOPNOTSUPP; }
+
+#endif
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

