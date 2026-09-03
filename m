Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44A4AFE1D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441902; cv=none; b=b/5Iau3NkqmsTKdsOsFrDgF6QTQzArUJZsOzekfW5OB/18KL6/EisJ8v6d+4CG0DY8oFIlSTI91qdMexat1a+43rIiz+ZYVLJXMwzDEfPDSj2k4p/6N4wDAvBkK+kHuTl9wizlGV0SA3PPP4T/6M2V0+ZX/KR0MQgk/o8xQOS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441902; c=relaxed/simple;
	bh=bOWxWN8pxBwuRgIl1jcvBA5e/d1NPxq3m/wHdycwAo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCVxmpjtJiBgLeQIX2KXfqRp3bsCtkiticZmWpbBjEDSxrg0tiI1nIT97avV+z6fa600D6ZycEUTAVKyUps75EAdEdZwxf6OPd97cNuTkFl685EKNTBeSj7z5r0xeXTdeb1CkWs+rW+LlZN7nbXklFryyS+9F+zgnpuJ3hJOhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJbIlpmk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJbIlpmk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2071055a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441883; x=1789046683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPn4Nfz9gA3vgZoRh1YV6HLN3dwgMfjoZPgCvV43lX8=;
        b=iJbIlpmk2C7crYEYATk4rmPt1SDdxgYjoz5DVpqVslKQyiMkX0H9DeJHsodJu5j+Af
         Thr7L1xVYihyQRHUO3BixyGKO6EamJ/j8JTESZpr+ks1cX8Colyl9qZTvx4Ub7kkqwJU
         WGO7TpU3RX8qAyVaeYWNh7RYaiiSd1MBvIMmuiy6S5kTUDRTSvjHobZs/sE/ldqGsJTn
         cIxX/ZdG/smoY8Yab71tQmr3X8tyCxYKMpi2SX5rcp7ePBQ1naUzhLAiT95OjT17A1pM
         puvjel7Sk+MwgVZFVV/lJ82F+Cfm2h70EabySffZNushgiPwoGFqMe5TIXCaDHqXRXGm
         wbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441883; x=1789046683;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPn4Nfz9gA3vgZoRh1YV6HLN3dwgMfjoZPgCvV43lX8=;
        b=fXBFt8pHvxTJuRmWg9hlj6rQKY2Y+Nqmk6GgC0KOa8t2LxEYV6e7Z0rzho+IiVLXsj
         Vo2FjUblXIEzxWIIOo74MDAd/oNNtZaYGJXT0AlylDlpKgzaogY1pTQvbhoBucOGVjc+
         kdqWSZZ2oK6DpMNeJSZdG698gusvI7mD0IFphhV5U6TXsD79Mv2ik8sSn9KhoEYwnQdZ
         eNPh8nJ3CdcruCQ6DKWEgwinZzSfvOIgAIncaNmph91WYNFgUTfZeU157VlE4UwhP9cl
         LfIS/HIC6S1vL+UsvbMGtdWUq4LAVashWQ0ZMOhr2mi27QQeKhBvt1fnO/1Bdj/YjbDq
         7Grw==
X-Forwarded-Encrypted: i=1; AKwUvBzoN0fcPljTrnOZ9ByA+bIDRAGXbslqqljpBzlxm9LTwbrpC5fOC3Qssh7Y5YGBrvXYv03j1lrEOvUaoE2wpDpc0u4=@vger.kernel.org
X-Gm-Message-State: AFuF++nU3ZP8ZRslfuZIpMOR7/h+8+b1OecEcpOK6J+85c1Y04z56KRw
	V/XxTI3t5PjmYGiuz6KFEXqgslZ6YbsDkgATRS3nVisLQYUC+JWljiT0
X-Gm-Gg: AYBFou0NYx3C34BNDx2rZydYnt/dt6KySFVf/Wy4jQIQxH5W0IIBr9i3+IuACoySXqc
	UB0qlGAxuOtCXBZYSHN2h1hry9dt5li6a2TXrBKYYn6CocioBvTiz7NOLhcRgaYfOAvY/kdGkx4
	//VKjXVzenjv1tlfNH95/iiOa1jqMG2oeGuSFQFoWCPU/lsU4wcx/1s0P1Y+heEqeD3NCGnrvt2
	8HAqd5kLqfaCj3w0cjdod58hNeDMk+EiCpeNi6oEghBdIOuqOx4GEtRJYfEQJCEQdmh5OpvOEak
	gMusiCo/UbjCRWsn1CORdqMV8bwHO7qpi/9fiqHZvyqDcRzIiLsoXpNr2EHxUsJ5hKENUTSGnMK
	LGj/mse9GXvNEmaksb6ewVb44BbwMoXW1GiKb1Z2fqHPgWwpbObvDNkiULL6LJaBzLR6+b0efiS
	RA3jGPEC5YyCjlwL0Cy4oGclETgDqvYK/TzouDRtFRDiLFGsmmEgJ453R0kcTVk3MwP3fLXOybG
	lWnft1USgjPkCA=
X-Received: by 2002:a17:90b:17cf:b0:398:d286:344d with SMTP id 98e67ed59e1d1-39aee178e92mr18300453a91.22.1788441882466;
        Thu, 03 Sep 2026 06:24:42 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832b85bsm5580845a91.4.2026.09.03.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:24:41 -0700 (PDT)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v6 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Thu,  3 Sep 2026 21:24:07 +0800
Message-Id: <20260903132409.270195-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903132409.270195-1-lipengfei28@xiaomi.com>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
- Reset clears the map and nothing else. It does not touch the ring
  buffer and does not require tracing to be stopped. A trace collected
  before a reset can therefore still contain TRACE_STACK_ID records
  whose id no longer resolves, or resolves to a slot that has since
  been reused. That is misleading userspace output, not corruption:
  reset frees nothing, it only memsets storage the map still owns.
- Reset uses atomic_cmpxchg() to claim the resetting flag, which also
  turns away new get_id() callers (they observe resetting=1 and return
  -EINVAL). A concurrent reset returns -EBUSY.
- synchronize_rcu() drains in-flight get_id() callers from the ftrace
  callback path. That path runs with preemption disabled, and a
  preempt-disabled region is itself an RCU read-side critical section
  (see the synchronize_rcu() kerneldoc), so the grace period covers it
  with no explicit rcu_read_lock().
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
 kernel/trace/trace_stackmap.c | 871 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  55 +++
 4 files changed, 949 insertions(+)
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 084f34dc6c9f..2447fc59f7c7 100644
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
index 000000000000..479716bebb6c
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,871 @@
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
+ *   - atomic_cmpxchg(&resetting, 0, 1) atomically claims reset rights
+ *     and blocks new get_id() callers (they observe resetting=1 and
+ *     return -EINVAL).
+ *   - synchronize_rcu() drains in-flight get_id() callers from the
+ *     ftrace callback path. That path runs with preemption disabled,
+ *     and a preempt-disabled region is itself an RCU read-side
+ *     critical section (see the synchronize_rcu() kerneldoc: since
+ *     v5.0, regions across which interrupts, preemption or softirqs
+ *     are disabled also serve as RCU read-side critical sections), so
+ *     the grace period covers it with no explicit rcu_read_lock().
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
+#include <linux/math64.h>
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
+	 * Single-opener guard for stack_map_bin. Each open builds a
+	 * full vmalloc snapshot (up to ~135 MB at bits=18); serialize
+	 * opens so concurrent readers cannot pin several at once.
+	 */
+	atomic_t		bin_open;
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
+	smap->successes = alloc_percpu(local_t);
+	if (!smap->successes)
+		goto fail;
+	smap->drops = alloc_percpu(local_t);
+	if (!smap->drops)
+		goto fail;
+
+	smap->hash_seed = get_random_u32();
+	atomic_set(&smap->next_elt, 0);
+	atomic_set(&smap->resetting, 0);
+	atomic_set(&smap->bin_open, 0);
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
+ *      also blocks subsequent get_id() callers.
+ *   2. synchronize_rcu() drains in-flight get_id() callers from the
+ *      ftrace callback path. That path is preempt-disabled, which is
+ *      itself an RCU read-side critical section, so the grace period
+ *      covers it without an explicit rcu_read_lock().
+ *   3. Take @reader_sem exclusively to exclude tracefs readers, then
+ *      memset entries, elts, and counters.
+ *   4. Release the resetting flag with release semantics so any new
+ *      get_id() observes a fully cleared map.
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
+	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
+
+	atomic_set(&smap->next_elt, 0);
+	for_each_possible_cpu(cpu) {
+		local_set(per_cpu_ptr(smap->successes, cpu), 0);
+		local_set(per_cpu_ptr(smap->drops, cpu), 0);
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
+	if (successes + drops > 0) {
+		/*
+		 * mul_u64_u64_div_u64() uses a 128-bit intermediate, so
+		 * (successes * 100) cannot overflow even when successes
+		 * approaches U64_MAX on a very long trace.
+		 */
+		successes = mul_u64_u64_div_u64(successes, 100, successes + drops);
+	} else {
+		successes = 0;
+	}
+	seq_printf(m, "success_rate: %llu%%\n", successes);
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
+	struct ftrace_stackmap_bin_entry *e;
+	size_t alloc_size, off;
+	u32 nr_entries, i, nr_stacks;
+
+	if (!smap)
+		return -ENODEV;
+
+	/*
+	 * Serialize opens: only one snapshot may be pinned at a time
+	 * (see @bin_open). Released in stackmap_bin_release().
+	 */
+	if (atomic_cmpxchg(&smap->bin_open, 0, 1) != 0)
+		return -EBUSY;
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
+	alloc_size = sizeof(*hdr) +
+		     (nr_entries + 1) * struct_size(e, ips, FTRACE_STACKMAP_MAX_DEPTH);
+
+	snap = vmalloc(sizeof(*snap) + alloc_size);
+	if (!snap) {
+		atomic_set(&smap->bin_open, 0);
+		return -ENOMEM;
+	}
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
+		if (off + struct_size(e, ips, nr) > alloc_size)
+			break;
+
+		e = (struct ftrace_stackmap_bin_entry *)(snap->data + off);
+		e->stack_id = i;
+		e->nr = nr;
+		e->ref_count = atomic_read(&elt->ref_count);
+		e->reserved = 0;
+
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
+				e->ips[k] = (u64)FTRACE_TRAMPOLINE_MARKER;
+			else
+				e->ips[k] = (u64)trace_adjust_address(smap->tr, ip);
+		}
+		off += struct_size(e, ips, nr);
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
+	struct ftrace_stackmap *smap = inode->i_private;
+
+	vfree(file->private_data);
+	if (smap)
+		atomic_set(&smap->bin_open, 0);
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
index 000000000000..80415b985627
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,55 @@
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
+	u64 ips[];		/* nr entries follow the header */
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
+
+#endif
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

