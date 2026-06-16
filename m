Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9803EDE62
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592132; cv=none; b=GEhssfTI4+cdsPDFzhWjRRW9YoV3Edkx3NHgehWkEwsHGcX6GF+EK4jSls8/OtuM0VYpsOqC0AVZehra4WUBEFQjkzciyvyLHpVL83KWP83SxzlnVzAlr2sQp2xD65ED5SEsqHLKzYy8ZVNznMI7P+ZT7Qc/EvDXQIKeqjPbFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592132; c=relaxed/simple;
	bh=NxLdElKIHmJLQNvdTE08WaFPWZpQn0e7dC3lUvZ1JOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuYaudpJfv8B7Bd//5OZmmuq5E0Olsrd5tfXVg/ATut78HjBQZlCNBv4OEeVY9ycIyGkCDAeEyeTMNqgZF6kmCEF95AeO9a5DLNf/kvRPm21h8kGTOj+N/vEp+zRA2V1lrOB+HuezCWfDjIn8hC/BllmiOsXYK1ifHLbSXOntlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2EWZ0Gl; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2EWZ0Gl"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1384ebe7a10so6618921c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592129; x=1782196929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvk5WayeZpGT+7V9K082C6hOqXsCiT3L8n5BFolWty0=;
        b=d2EWZ0Gl/ba5Q/z5lOrisx1uooOU9ZOoG5PTUk+el5ur0lxHUN+Wl0NDXoPOeRLA4R
         PgXAcSiudu6LufIpnlQ0TnieREGG900Fo+9jUJuMvr0kTTjyjz1N20pUM8t2gSrXb5lN
         21JYSkswpjcExBbIGYCMxJqytOKBZz9sQ0bJgrMHaxfw7FNpondCpkPHj+R485l3d/u2
         312WCkbw2k4mWkbm/V+EKCVmB1+Qa2DOsXYCXzQRruELOzoatS+gqTmftWlzult8LNUc
         3h5J1VRIAMttlaInKII7HBp5CdHErd/+vOW6+nNj6DVniwlB+aYuER92sp3SIpogsMma
         HTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592129; x=1782196929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bvk5WayeZpGT+7V9K082C6hOqXsCiT3L8n5BFolWty0=;
        b=l/mvW8CleUsUvie8cL8ef9fn/pQUHx18tkkJ8N5GhWUY+KB1aN1me/H85++MgbDdpc
         6sEfQnuQ1s6irH2FkzAlWLF5ed33TFxcGgKELNMDqATXw4mq3bQil9uu4ulJbcNFpIj7
         +ILDyj3m2gi/RRxbtXWqgkQ6ZZYJbLnqRVW50m5bnydGJYGqTLoqTWAGS9LBNCjyuiZF
         0IOyW9Tt489EvLNY5lB3Od1Jb8wbooFGkiYFkYzeyjeDUvxFpzrZ8ZAjzCCKG2wJjp42
         +bMkIcJfcYVi1dI1twNri/yNQAemfwImecSnDONC1mK3XhCk+dwgqPKHidcO5Q2Ohx6c
         z4oA==
X-Forwarded-Encrypted: i=1; AFNElJ+vvXLYeIbM/DFDV+OMTE15Cg0twl1L82wr3LQnzSxuhMojze1Xxi/IQtFrU7lJQn2AZmDUZOahGHHlgAvimBW/4cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QmzFEgAFBOEZWcF/eZnrMEL2R+RBCrN9XXfWnNGItgrs8tJZ
	mh/VooFZG+D4QWuS5sMlCnvfrueXXnuSCZRj1uBb3UYhPBf5FMi2/UZG
X-Gm-Gg: Acq92OGWuJBtK5mcXXdSwBf/Mo++srxi/HnewDv8ZAx3aJWvYuAJRcI/iIVAhaqcX+9
	wfFWuMQI5e3HdHSRJF4S7jKh9WUheHJIj4sag1pITQXv77Vfku0uSPSNEK6LtjN7nSXcZaeixF0
	q8o7Js7gL3fpfVEE9wOkD4u++ss7Zpbs/dowKT8Ml7lKDscZ3ANX169TUYwbzrTi/MVRD8O/lF7
	TFV2JmQpjY7zSogcoLIMpbNUN3xv9dJoPA0EF24Y0DVVJoLCoyB1EHOBoYFeKOPbw3fhCjku5qg
	WeCdc21tWSPrsJ22t1Hd1HKH19wPD5lC8hNzq9umaIxAXYRba2X2FiECR03Rv4aIlxpQ7jwFZ1s
	VCBSoSQhSNcOkiwfEIjKmbJZUP2eD0voTPH6Jmbt+KPc+rMuDm1MOSVGUyOsnF0hGcWk2q+3K9I
	urMBK4LrIKYk+EUWAO3MkK5qeWp8JIzjL1fLlqOh1KhdWt8xpK
X-Received: by 2002:a05:7022:693:b0:12d:b993:c68f with SMTP id a92af1059eb24-1384bb1c45fmr9754837c88.4.1781592128428;
        Mon, 15 Jun 2026 23:42:08 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:55be:2dbe:9cd4:7306])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm12499158c88.4.2026.06.15.23.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:42:07 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lipengfei28@xiaomi.com,
	zhangbo56@xiaomi.com
Subject: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Tue, 16 Jun 2026 14:41:17 +0800
Message-Id: <20260616064119.438063-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616064119.438063-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
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

The Kconfig depends on ARCH_HAVE_NMI_SAFE_CMPXCHG, matching the
existing tracing_map / hist_triggers requirement: the lock-free
hot path uses cmpxchg in a context that may be reached from NMI.

The stackmap is exported via three tracefs nodes:
- stack_map: text export with symbol resolution (mode 0640)
- stack_map_stat: counters (entries, successes, drops, success_rate)
- stack_map_bin: binary export (magic 0x46534D42 'FSMB', version 1,
  all fields native-endian)

ftrace_stackmap_get_id() never truncates: a stack deeper than
FTRACE_STACKMAP_MAX_DEPTH (64) returns -E2BIG so the caller records a
full stack instead. This prevents two distinct traces that share their
first 64 frames from being merged into one stack_id.

Hot-path counters use per-CPU local_t (NMI-safe single-instruction
increments) instead of atomic64_t. atomic64_t falls back to
raw_spinlock_t-based emulation on 32-bit GENERIC_ATOMIC64 systems,
which would deadlock if an NMI hit while the spinlock was held.
local_t avoids this hazard. All counters saturate rather than wrap on
long (from-boot, multi-hour) traces: ref_count via
atomic_add_unless(.., INT_MAX) and successes/drops via
local_add_unless(.., LONG_MAX).

Reset semantics:
- Reset is a control-path operation only allowed when tracing is
  stopped on the owning trace_array. Online reset (with tracing
  active) is intentionally not supported.
- Reset is destructive: under the reader_sem write lock it clears the
  owning trace_array's ring buffer (and snapshot buffer) BEFORE the
  map, so an external observer never sees "trace still has
  <stack_id N> but the map is already empty". The buffers are cleared
  with tracing_reset_all_cpus() rather than _online_cpus() so a
  TRACE_STACK_ID written by a now-offline CPU cannot survive a reset.
- Reset uses atomic_cmpxchg() to claim the resetting flag, then
  verifies tracer_tracing_is_on() returns false.
- synchronize_rcu() drains in-flight get_id() callers from the
  ftrace callback path (which runs preempt-disabled).
- The reader_sem (rw_semaphore) serializes the clearing against
  tracefs readers (seq_file iteration and stack_map_bin snapshot),
  which run in process context and aren't covered by
  synchronize_rcu(). Readers take it shared, reset takes it
  exclusive, so a reset cannot tear an iteration in progress. The
  hot path doesn't take this lock.
- Reset clears the resetting flag with atomic_set_release() so a
  subsequent get_id() observes a fully cleared map.
- get_id() uses atomic_read_acquire() on resetting so subsequent
  loads of entry->key/val are properly ordered after the check
  (control dependencies only order stores per LKMM).
- Concurrent reset, or reset while tracing is active, returns -EBUSY.

Concurrency notes:
- entry->val publication uses smp_store_release() paired with
  smp_load_acquire() in all dereferencing readers.
- entry->key reads (in get_id, seq_start/next, bin_open) use
  READ_ONCE() to avoid LKMM data races with the cmpxchg writer.
- elt->nr is read with READ_ONCE() and clamped to MAX_DEPTH before
  use in seq_show and bin_open.
- Pool exhaustion: stackmap_get_elt() short-circuits via
  atomic_read() before the contended atomic RMW, avoiding cacheline
  contention once the pool is full. Slots that win cmpxchg but
  cannot get an elt are left 'claimed but empty'; subsequent
  lookups treat val==NULL as a miss and probe past them.

Hash key:
- Per-instance random seed stored in the stackmap struct (no
  global state), seeded at create time.
- 32-bit jhash is forced to 1 if it lands on 0 (which is the
  free-slot sentinel). Full memcmp confirms matches.

Memory:
- Single flat vmalloc for the element pool (no per-elt kzalloc).
- bits parameter clamped to [10, 18]: at the maximum bits=18, the
  element pool is ~135 MB and a stack_map_bin snapshot may briefly
  allocate another ~135 MB.
- struct stackmap_bin_snapshot uses u64 (not size_t) for its size
  field so data[] is 8-byte aligned on both 32-bit and 64-bit
  architectures, avoiding alignment faults when writing u64 IPs
  on strict-alignment architectures.

Kernel command line parameter:
- ftrace_stackmap.bits=N: set map capacity (2^N unique stacks,
  range 10-18, default 14)

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig          |  22 +
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace_stackmap.c | 889 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  57 +++
 4 files changed, 969 insertions(+)
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e130da35808f..e49cae886ff0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -412,6 +412,28 @@ config STACK_TRACER
 
 	  Say N if unsure.
 
+config FTRACE_STACKMAP
+	bool "Ftrace stack map deduplication"
+	depends on TRACING
+	depends on STACKTRACE
+	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
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
index 8d3d96e847d8..c2d9b2bf895a 100644
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
index 000000000000..9e9fdf85071d
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,889 @@
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
+ *   - trace_types_lock serializes the tracer_tracing_is_on() check and
+ *     the destructive ring-buffer reset against tracefs writes to
+ *     tracing_on.
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
+ * (smp_load_acquire on entry->val); they are also serialized
+ * against reset via smap->reader_sem (readers take it in shared
+ * mode, reset in exclusive mode), so a reset cannot tear an
+ * iteration in progress -- it waits for active readers to drop
+ * the rwsem before clearing the map. The hot path is coordinated
+ * with reset separately, via acquire/release on smap->resetting.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/local_lock.h>
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
+ * that dereferences the elt (get_id, seq_show, bin_open). This pairs
+ * the writes to elt->{nr,ips,ref_count} (initialized BEFORE the
+ * publish) with the reads of those fields (which happen AFTER the
+ * load). seq_start / seq_next only test val for NULL and use the
+ * acquire load purely to keep memory ordering symmetric.
+ */
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
+	 * across seq_file iteration and binary snapshot construction;
+	 * held in exclusive mode (write lock) by reset's clearing
+	 * phase. The hot path (get_id) does not take this lock — it
+	 * uses smp_load_acquire/smp_store_release on entry->val and
+	 * the resetting flag for the lock-free protocol.
+	 */
+	struct rw_semaphore	reader_sem;
+	/*
+	 * Per-CPU counters using local_t. local_t increments are NMI-
+	 * safe on all architectures (single-instruction or interrupt-
+	 * masked) and avoid the raw_spinlock_t fallback that
+	 * atomic64_t uses on 32-bit GENERIC_ATOMIC64 — which would
+	 * deadlock if an NMI hit while the spinlock was held.
+	 */
+	local_t __percpu	*successes;	/* events served (hits + new inserts) */
+	local_t __percpu	*drops;
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
+	smap = kzalloc_obj(*smap, GFP_KERNEL);
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
+
+	smap->entries = vzalloc(sizeof(*smap->entries) * smap->map_size);
+	if (!smap->entries) {
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Single large vmalloc of the element pool, indexed flat.
+	 * At bits=18 this is 256K * sizeof(struct stackmap_elt). The
+	 * struct is ~520 B (8 + 4 + 4 + 64*8), so total ~135 MB.
+	 */
+	smap->elts = vzalloc(sizeof(*smap->elts) * (size_t)smap->max_elts);
+	if (!smap->elts) {
+		vfree(smap->entries);
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	smap->successes = alloc_percpu(local_t);
+	if (!smap->successes) {
+		vfree(smap->elts);
+		vfree(smap->entries);
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+	smap->drops = alloc_percpu(local_t);
+	if (!smap->drops) {
+		free_percpu(smap->successes);
+		vfree(smap->elts);
+		vfree(smap->entries);
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	smap->hash_seed = get_random_u32();
+	atomic_set(&smap->next_elt, 0);
+	atomic_set(&smap->resetting, 0);
+	init_rwsem(&smap->reader_sem);
+
+	return smap;
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
+ *   2. Take trace_types_lock to serialize against tracefs writes to
+ *      tracing_on.
+ *   3. Verify tracing is stopped on @smap->tr; if not, release the
+ *      claim and return -EBUSY. The resetting flag itself blocks
+ *      any subsequent get_id() callers.
+ *   4. synchronize_rcu() drains in-flight get_id() callers from the
+ *      ftrace callback path (which runs preempt-disabled).
+ *   5. Reset the ring buffer(s), then memset entries, elts, and
+ *      counters.
+ *   6. Release the resetting flag with release semantics so any new
+ *      get_id() observes a fully cleared map.
+ */
+int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
+{
+	struct trace_array *tr;
+	int ret = 0;
+
+	if (!smap)
+		return 0;
+
+	if (atomic_cmpxchg(&smap->resetting, 0, 1) != 0)
+		return -EBUSY;
+
+	mutex_lock(&trace_types_lock);
+
+	tr = smap->tr;
+	if (tr && tracer_tracing_is_on(tr)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/*
+	 * synchronize_rcu() itself is a full barrier; no extra smp_mb()
+	 * is needed before it. It drains in-flight ftrace callbacks that
+	 * may have already passed the resetting check with the old value.
+	 */
+	synchronize_rcu();
+
+	/*
+	 * Take the reader_sem in exclusive mode. This serializes the
+	 * memset against any tracefs reader (seq_file iteration or
+	 * stack_map_bin snapshot) that may currently hold the rwsem
+	 * for read. synchronize_rcu() already drained the hot path;
+	 * this rwsem covers process-context readers that aren't
+	 * preempt-disabled.
+	 */
+	down_write(&smap->reader_sem);
+
+	/*
+	 * Clear the ring buffer(s) BEFORE the map, both under the write
+	 * lock. The ring buffer may still hold TRACE_STACK_ID events
+	 * whose stack_id points at slots we are about to free/reuse.
+	 * Resetting the buffer first guarantees an external observer
+	 * never sees the inconsistent "trace still has <stack_id N> but
+	 * the map is already empty" window: it sees either (old buffer,
+	 * old map) or (cleared buffer, old map) or (cleared buffer,
+	 * cleared map) -- never (old buffer, cleared map).
+	 *
+	 * Use tracing_reset_all_cpus() (not _online_cpus) so per-CPU
+	 * buffers belonging to currently offline CPUs are also cleared.
+	 * The ring buffer is allocated per-possible-CPU; an offline CPU's
+	 * buffer can still hold a TRACE_STACK_ID event written before
+	 * the CPU went offline. tracing_reset_online_cpus() iterates
+	 * for_each_online_buffer_cpu() and would leave that data behind
+	 * to be observed once the CPU comes back online (or by the
+	 * trace reader, which iterates all allocated CPU buffers),
+	 * recreating the stale-stack_id window we are trying to close.
+	 *
+	 * Since reset requires tracing to be stopped, this makes "reset"
+	 * an explicitly destructive operation on the owning trace_array,
+	 * keeping ring-buffer stack_ids and the map coherent.
+	 */
+	if (tr) {
+		tracing_reset_all_cpus(&tr->array_buffer);
+#ifdef CONFIG_TRACER_SNAPSHOT
+		if (tr->allocated_snapshot)
+			tracing_reset_all_cpus(&tr->snapshot_buffer);
+#endif
+	}
+
+	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
+
+	atomic_set(&smap->next_elt, 0);
+	{
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			local_set(per_cpu_ptr(smap->successes, cpu), 0);
+			local_set(per_cpu_ptr(smap->drops, cpu), 0);
+		}
+	}
+
+	up_write(&smap->reader_sem);
+
+out_unlock:
+	mutex_unlock(&trace_types_lock);
+
+	/* Release resetting=0 so new get_id() observes a cleared map. */
+	atomic_set_release(&smap->resetting, 0);
+	return ret;
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
+	/*
+	 * atomic_read_acquire() pairs with atomic_set_release() in the
+	 * reset path. This ensures that subsequent reads of entry->key
+	 * and entry->val are ordered after this check; without acquire,
+	 * the CPU would only have a control dependency, which orders
+	 * subsequent stores but not loads (per LKMM).
+	 */
+	if (!smap || !nr_entries || atomic_read_acquire(&smap->resetting))
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
+			 * the seq_show / bin_open readers. nr is write-once
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
+				 * successes/drops are best-effort throughput
+				 * counters. Saturate at LONG_MAX so they do
+				 * not wrap on long runs (notably where local_t
+				 * is 32-bit), matching ref_count's behaviour.
+				 */
+				local_add_unless(this_cpu_ptr(smap->successes),
+						 1, LONG_MAX);
+				return (int)idx;
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
+					 * Pool exhausted. We claimed this
+					 * slot with cmpxchg but cannot fill
+					 * it. Leave key set so the slot
+					 * stays "claimed but empty" — future
+					 * lookups treat val==NULL as a miss
+					 * and probe past it. Cannot revert
+					 * key=0 without racing other CPUs.
+					 */
+					local_add_unless(this_cpu_ptr(smap->drops),
+							 1, LONG_MAX);
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
+				local_add_unless(this_cpu_ptr(smap->successes),
+						 1, LONG_MAX);
+				return (int)idx;
+			}
+			/* cmpxchg failed; another CPU claimed this slot. */
+		}
+
+		idx++;
+		probes++;
+	}
+
+	local_add_unless(this_cpu_ptr(smap->drops), 1, LONG_MAX);
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
+	u32 i;
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
+	u64 successes = 0, drops = 0;
+	u32 entries;
+	int cpu;
+
+	if (!smap) {
+		seq_puts(m, "stackmap not initialized\n");
+		return 0;
+	}
+
+	entries = atomic_read(&smap->next_elt);
+	for_each_possible_cpu(cpu) {
+		successes += local_read(per_cpu_ptr(smap->successes, cpu));
+		drops += local_read(per_cpu_ptr(smap->drops, cpu));
+	}
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
+	 * At bits=18 this caps at ~135 MB. The file is mode 0440
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
+	/*
+	 * Take reader_sem to serialize against ftrace_stackmap_reset(),
+	 * which clears the table and elt pool under the write lock.
+	 */
+	down_read(&smap->reader_sem);
+
+	for (i = 0; i < smap->map_size; i++) {
+		struct stackmap_entry *entry = &smap->entries[i];
+		struct stackmap_elt *elt;
+		struct ftrace_stackmap_bin_entry *e;
+		u64 *ips_out;
+		u32 k, nr;
+
+		if (!READ_ONCE(entry->key))
+			continue;
+		elt = stackmap_load_elt(entry);
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
+		for (k = 0; k < nr; k++) {
+			unsigned long ip = elt->ips[k];
+
+			/*
+			 * Emit the trampoline marker verbatim so userspace
+			 * can render it as [FTRACE TRAMPOLINE]; pass every
+			 * other address through trace_adjust_address() so the
+			 * binary export follows the same address-adjustment
+			 * rules as the text export.
+			 */
+			if (ip == FTRACE_TRAMPOLINE_MARKER)
+				ips_out[k] = (u64)FTRACE_TRAMPOLINE_MARKER;
+			else
+				ips_out[k] = (u64)trace_adjust_address(smap->tr, ip);
+		}
+		off += nr * sizeof(u64);
+		nr_stacks++;
+	}
+
+	up_read(&smap->reader_sem);
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
index 000000000000..7c2e5ab9d36d
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,57 @@
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
+#define FTRACE_STACKMAP_BIN_MAGIC	0x46534D42	/* 'FSMB' */
+#define FTRACE_STACKMAP_BIN_VERSION	1
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
+static inline struct ftrace_stackmap *
+ftrace_stackmap_create(struct trace_array *tr) { return NULL; }
+static inline void ftrace_stackmap_destroy(struct ftrace_stackmap *s) { }
+static inline int ftrace_stackmap_get_id(struct ftrace_stackmap *s,
+					 unsigned long *ips, unsigned int n)
+{ return -EOPNOTSUPP; }
+static inline int ftrace_stackmap_reset(struct ftrace_stackmap *s) { return 0; }
+
+#endif
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

