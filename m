Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACE3F413B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730711; cv=none; b=XNE/0HvziH+DWeHzs+GRO2lNrPAaIbKq7908sQtZb5BZSxDXATp6HN8+AgNVmlDfJTKvJgtXstDFW4f5sftStlLRHb9BG5wj0ixz9BCYgpXDOnoNksCenMaTmE/pQlXtKPeFRJjs+hsCuFw0xga5OcLNei/YvS82Yhb1tIrDcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730711; c=relaxed/simple;
	bh=ipPqbURLaeUouRXUL3f3pSrO0+z2uI3IB8jGANpIyAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az/GUuY9mqlH2hGktXTqK0uCfiKnjLYtuoiGJsdhRV9fkhGn7RX0OH4NB1RQCAowAWJ1UhtaaOCtZS6XNbVZTMIZ/evgt6JDANgd51QIt/1NNUj/OHAnQZzUQ/ODNyqxtMTJEadIYf83s/Lt31t3wh2C5rBBRk3qSlgXTRXJCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afrlgyIt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afrlgyIt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba21d32776so50991055ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730708; x=1779335508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx4se+DYa5wypPaIJXHxb8KwHMypPz6kixZY56ylDzE=;
        b=afrlgyIt4iOyuqajvmpBJuYOWuF7jEwWsx5QwqzY/oohRIVL2Dl5DkubxhP0p1A8nI
         rGZbEMxGsmrYHW//Hn/h+I9LTY2VySUyS+DCl7F7q0Jnp+xighqpEvqM8K7QFMXjACOM
         WNtG2z7ytbQhE1xM2wDvcrUHTMzWGKgNjeZcZc/9es21g72ntApJgEkhyx004tkCusXf
         U69F9+aGy6N1X1E0R/WQowo5bK1KDVHGPcFi66gxxUprM9/BijmJyOEHN0rBNULV7fYz
         WgwBMivdYBXzcJHsIFRpJpCAHvBnb7lcncy8xyQf0aWNuubANCgpO8ePbkA4WmpBCqW/
         LJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730708; x=1779335508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yx4se+DYa5wypPaIJXHxb8KwHMypPz6kixZY56ylDzE=;
        b=Si50kSXKwhE1+vEUVJzBjBHWygLB0Cv3V/4+mRWGH/kmG6XdOSH2RM7gkcxeFBg8Oi
         WChahUAX1OBUuPC5NXvoMqNLhRzuwbChGzgyTam98uVYHsLTK0oJMGA8RZIrh06WWZlu
         id0DcDB7ALl/pJJ73DKvCTi2f5lDtaktEQN9oec1aPBGOxxPDErQ2hnSTBnu/44Dx1zx
         DuL2nSJvU4BxPDTbvTBbRU9dxHdzyto2JLEKb+grbyH/a3JQorjicoiUmXhwb1zNMyMn
         RXPvQXFW9kuio+FzfCKq81rxsW/XnKi6XHespKcekm6ZaRlVTra9cXWAellN+TtEfKNi
         WVow==
X-Gm-Message-State: AOJu0YyNEmd8kQnF2TPbJVjaEjMx9HhLA4HfmsSa6Mn+84SCzAXOONeD
	VANzeZA/0mfQwTDtveG1qr4tevno+2KsfJDHpLGvBj/2n9tXNhwogVwJf3lqRxzkGGI=
X-Gm-Gg: Acq92OH5GAVSFvfteDExbR8IYgYnp1zkOETcwF3EvImG8/SZXbAGrXdGo8LXUz7Y/AE
	5MoQq2qGzZ7vSVlc3VGIxkfIHzdnGC1NSjg4S41uNIVEA8pL7YGBSrFjaBDXIg35rS+SKxH3odI
	ExR0UodJmKDUrUhAXog86VCjUNISDqrqY8lY2rC8uDtYx6K+5HfFl7G3thZFx4KXu88MazvgRB0
	CgIw3g5iw3Bi+bgNGmioLxVQoyrrFetUHlAQOPLXUhckrVy5bAYLiCaCazCjslpx0c2097PiiPg
	TWuDcU9TRYCBp2tgI+ZDl05M9J4iJ8/8Xs7a2U4efhND19vHkwTuMIIlhouDpymbx/MAym9DISQ
	IpwK543IfRIsMEjJH/8PbyHxtbLaJ8W2ZPlLXjAPm9/oM62yC0C1GCIsJ4PCaS/vGmyw88ESBzf
	4mgmZgKKyy2C2NkfzjPOkVkrehX8Ur/b9T2yADrA==
X-Received: by 2002:a17:903:8cf:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2bd27133c5fmr38960425ad.2.1778730708015;
        Wed, 13 May 2026 20:51:48 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3771:9b3a:64a3:f42d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm8189435ad.6.2026.05.13.20.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:51:47 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Thu, 14 May 2026 11:49:14 +0800
Message-Id: <20260514034916.2162517-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
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

- Lock-free insert via cmpxchg (safe in NMI/IRQ/any context)
- Pre-allocated element pool (zero allocation on hot path)
- Linear probing with 2x over-provisioned table
- Per-trace_array instance support

The stackmap is exported via three tracefs nodes:
- stack_map: text export with symbol resolution
- stack_map_stat: statistics (entries, hits, drops, hit_rate)
- stack_map_bin: binary export for efficient userspace consumption

Kernel command line parameter:
- ftrace_stackmap.bits=N: set map capacity (2^N unique stacks)

Test results on ARM64 (SM8850, Android 16, kernel 6.12):
- 774 unique stacks from kmem_cache_alloc in 1 second
- 100% hit rate, 0 drops
- 92% hit rate under heavy load (all kmem events)

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig          |  21 ++
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace_stackmap.c | 569 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  54 ++++
 4 files changed, 645 insertions(+)
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
index 000000000000..c402e7e7f902
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ftrace Stack Map - Lock-free stack trace deduplication for ftrace
+ *
+ * Modeled after tracing_map.c (used by hist triggers), this provides
+ * a lock-free hash map optimized for the ftrace hot path. The design
+ * is based on Dr. Cliff Click's non-blocking hash table algorithm.
+ *
+ * Key properties:
+ * - Lock-free insert via cmpxchg (safe in NMI/IRQ/any context)
+ * - Pre-allocated element pool (zero allocation on hot path)
+ * - Linear probing with 2x over-provisioned table
+ * - Per-trace_array instance support
+ *
+ * The 32-bit jhash of the stack IPs is used as the hash table key.
+ * On hash collision (different stacks, same 32-bit hash), linear
+ * probing finds the next slot. Full stack comparison (memcmp) is
+ * used to confirm matches.
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
+
+#include "trace.h"
+#include "trace_stackmap.h"
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
+	unsigned int		map_bits;
+	unsigned int		map_size;	/* 1 << (map_bits + 1) */
+	unsigned int		max_elts;	/* 1 << map_bits */
+	atomic_t		next_elt;	/* index into elts pool */
+	struct stackmap_entry	*entries;	/* hash table */
+	struct stackmap_elt	**elts;		/* pre-allocated pool */
+	atomic_t		resetting;
+	atomic64_t		hits;
+	atomic64_t		drops;
+};
+
+static u32 stackmap_hash_seed;
+
+static unsigned int stackmap_map_bits = 14;	/* 16384 elts, 32768 slots */
+static int __init stackmap_bits_setup(char *str)
+{
+	unsigned long val;
+
+	if (kstrtoul(str, 0, &val))
+		return -EINVAL;
+	val = clamp_val(val, 10, 20);	/* 1K - 1M elts */
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
+	idx = atomic_fetch_add_unless(&smap->next_elt, 1, smap->max_elts);
+	if (idx < smap->max_elts)
+		return smap->elts[idx];
+	return NULL;
+}
+
+static int stackmap_alloc_elts(struct ftrace_stackmap *smap)
+{
+	unsigned int i;
+
+	smap->elts = vzalloc(sizeof(*smap->elts) * smap->max_elts);
+	if (!smap->elts)
+		return -ENOMEM;
+
+	for (i = 0; i < smap->max_elts; i++) {
+		smap->elts[i] = kzalloc(sizeof(struct stackmap_elt), GFP_KERNEL);
+		if (!smap->elts[i])
+			goto fail;
+	}
+	return 0;
+fail:
+	while (i--)
+		kfree(smap->elts[i]);
+	vfree(smap->elts);
+	smap->elts = NULL;
+	return -ENOMEM;
+}
+
+static void stackmap_free_elts(struct ftrace_stackmap *smap)
+{
+	unsigned int i;
+
+	if (!smap->elts)
+		return;
+	for (i = 0; i < smap->max_elts; i++)
+		kfree(smap->elts[i]);
+	vfree(smap->elts);
+	smap->elts = NULL;
+}
+
+/* --- Create / Destroy / Reset --- */
+
+struct ftrace_stackmap *ftrace_stackmap_create(void)
+{
+	struct ftrace_stackmap *smap;
+	static bool seed_initialized;
+	int err;
+
+	smap = kzalloc(sizeof(*smap), GFP_KERNEL);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+
+	smap->map_bits = stackmap_map_bits;
+	smap->max_elts = 1 << smap->map_bits;
+	smap->map_size = smap->max_elts * 2;	/* 2x over-provision */
+
+	smap->entries = vzalloc(sizeof(*smap->entries) * smap->map_size);
+	if (!smap->entries) {
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = stackmap_alloc_elts(smap);
+	if (err) {
+		vfree(smap->entries);
+		kfree(smap);
+		return ERR_PTR(err);
+	}
+
+	atomic_set(&smap->next_elt, 0);
+	atomic_set(&smap->resetting, 0);
+	atomic64_set(&smap->hits, 0);
+	atomic64_set(&smap->drops, 0);
+
+	if (!seed_initialized) {
+		stackmap_hash_seed = get_random_u32();
+		seed_initialized = true;
+	}
+
+	return smap;
+}
+
+void ftrace_stackmap_destroy(struct ftrace_stackmap *smap)
+{
+	if (!smap || IS_ERR(smap))
+		return;
+	stackmap_free_elts(smap);
+	vfree(smap->entries);
+	kfree(smap);
+}
+
+void ftrace_stackmap_reset(struct ftrace_stackmap *smap)
+{
+	unsigned int i;
+
+	if (!smap)
+		return;
+
+	/*
+	 * Reset protocol:
+	 *
+	 * 1. Set resetting=1 so get_id() returns -EINVAL immediately.
+	 *    get_id() callers in NMI/IRQ context will see this and bail
+	 *    out before touching entries or elts.
+	 *
+	 * 2. smp_mb() ensures the resetting store is visible to all CPUs
+	 *    before we start clearing entries.  Any get_id() that already
+	 *    passed the resetting check will complete its cmpxchg and
+	 *    WRITE_ONCE(entry->val) before we memset, because:
+	 *    - the cmpxchg claims the slot atomically
+	 *    - WRITE_ONCE(entry->val) happens before we clear entries
+	 *    We accept that a handful of in-flight inserts may write into
+	 *    entries that we are about to clear; those entries will simply
+	 *    be wiped by the memset below, which is safe.
+	 *
+	 * 3. Clear entries table, then reset elt pool.
+	 *
+	 * 4. Clear resetting=0 with another smp_mb() so new get_id()
+	 *    calls see a fully reset map.
+	 */
+	atomic_set(&smap->resetting, 1);
+	smp_mb();
+
+	/* Clear hash table */
+	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+
+	/* Reset elt pool */
+	for (i = 0; i < smap->max_elts; i++)
+		memset(smap->elts[i], 0, sizeof(struct stackmap_elt));
+
+	atomic_set(&smap->next_elt, 0);
+	atomic64_set(&smap->hits, 0);
+	atomic64_set(&smap->drops, 0);
+
+	smp_mb();
+	atomic_set(&smap->resetting, 0);
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
+	int dup_try = 0;
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
+			  stackmap_hash_seed);
+	if (key_hash == 0)
+		key_hash = 1;	/* 0 means free slot */
+
+	idx = key_hash >> (32 - (smap->map_bits + 1));
+
+	while (1) {
+		idx &= (smap->map_size - 1);
+		entry = &smap->entries[idx];
+		test_key = entry->key;
+
+		if (test_key && test_key == key_hash) {
+			val = READ_ONCE(entry->val);
+			if (val && val->nr == nr_entries &&
+			    memcmp(val->ips, ips, trace_len) == 0) {
+				atomic_inc(&val->ref_count);
+				atomic64_inc(&smap->hits);
+				return (int)idx;
+			} else if (unlikely(!val)) {
+				/* Another CPU is mid-insert; retry */
+				dup_try++;
+				if (dup_try > smap->map_size) {
+					atomic64_inc(&smap->drops);
+					break;
+				}
+				continue;
+			}
+		}
+
+		if (!test_key) {
+			/* Free slot: try to claim it */
+			if (!cmpxchg(&entry->key, 0, key_hash)) {
+				struct stackmap_elt *elt;
+
+				elt = stackmap_get_elt(smap);
+				if (!elt) {
+					/*
+					 * Pool exhausted. We claimed this slot with
+					 * cmpxchg but cannot fill it. Leave key set
+					 * so the slot stays "claimed but empty" —
+					 * future lookups will skip it (val == NULL
+					 * triggers the mid-insert retry path which
+					 * will eventually drop). This is safer than
+					 * writing key=0 without cmpxchg, which could
+					 * race with another CPU's cmpxchg on the same
+					 * slot.
+					 */
+					atomic64_inc(&smap->drops);
+					break;
+				}
+
+				elt->nr = nr_entries;
+				atomic_set(&elt->ref_count, 1);
+				memcpy(elt->ips, ips, trace_len);
+
+				/* Ensure elt is fully visible before publish */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
+				atomic64_inc(&smap->hits);
+				return (int)idx;
+			} else {
+				/* cmpxchg failed; someone else claimed it */
+				dup_try++;
+				continue;
+			}
+		}
+
+		idx++;
+		dup_try++;
+		if (dup_try > smap->map_size) {
+			atomic64_inc(&smap->drops);
+			break;
+		}
+	}
+
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
+		if (smap->entries[i].key && smap->entries[i].val) {
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
+	for (i = *pos + 1; i < smap->map_size; i++) {
+		if (smap->entries[i].key && smap->entries[i].val) {
+			*pos = i;
+			return &smap->entries[i];
+		}
+	}
+	*pos = i;
+	return NULL;
+}
+
+static void stackmap_seq_stop(struct seq_file *m, void *v) { }
+
+static int stackmap_seq_show(struct seq_file *m, void *v)
+{
+	struct stackmap_entry *entry = v;
+	struct stackmap_elt *elt = entry->val;
+	struct stackmap_seq_private *priv = m->private;
+	u32 idx = entry - priv->smap->entries;
+	u32 i;
+
+	if (!elt)
+		return 0;
+
+	seq_printf(m, "stack_id %u [ref %u, depth %u]\n",
+		   idx, atomic_read(&elt->ref_count), elt->nr);
+	for (i = 0; i < elt->nr; i++)
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
+static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_seq_private *priv = m->private;
+	char buf[8];
+	size_t n = min(count, sizeof(buf) - 1);
+
+	if (copy_from_user(buf, ubuf, n))
+		return -EFAULT;
+	buf[n] = '\0';
+	if (n == 0 || (buf[0] != '0' && strncmp(buf, "reset", 5) != 0))
+		return -EINVAL;
+
+	ftrace_stackmap_reset(priv->smap);
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
+	u64 hits, drops;
+
+	if (!smap) {
+		seq_puts(m, "stackmap not initialized\n");
+		return 0;
+	}
+
+	entries = atomic_read(&smap->next_elt);
+	hits = atomic64_read(&smap->hits);
+	drops = atomic64_read(&smap->drops);
+
+	seq_printf(m, "entries:    %u / %u\n", entries, smap->max_elts);
+	seq_printf(m, "table_size: %u\n", smap->map_size);
+	seq_printf(m, "hits:       %llu\n", hits);
+	seq_printf(m, "drops:      %llu\n", drops);
+	if (hits + drops > 0)
+		seq_printf(m, "hit_rate:   %llu%%\n",
+			   hits * 100 / (hits + drops));
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
+	size_t	size;
+	char	data[];
+};
+
+static int stackmap_bin_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_stackmap *smap = inode->i_private;
+	struct stackmap_bin_snapshot *snap;
+	struct ftrace_stackmap_bin_header *hdr;
+	size_t alloc_size, off;
+	u32 i, nr_stacks;
+
+	if (!smap)
+		return -ENODEV;
+
+	/*
+	 * Allocate based on actual entry count, not max_elts worst case.
+	 * Each entry needs a header struct plus up to MAX_DEPTH u64 IPs.
+	 * Add 1 to nr_entries to avoid zero-size alloc on empty map.
+	 */
+	{
+		u32 nr_entries = atomic_read(&smap->next_elt);
+
+		alloc_size = sizeof(*hdr) + (nr_entries + 1) *
+			     (sizeof(struct ftrace_stackmap_bin_entry) +
+			      FTRACE_STACKMAP_MAX_DEPTH * sizeof(u64));
+	}
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
+		u32 k;
+
+		if (!entry->key)
+			continue;
+		elt = READ_ONCE(entry->val);
+		if (!elt)
+			continue;
+
+		e = (struct ftrace_stackmap_bin_entry *)(snap->data + off);
+		e->stack_id = i;
+		e->nr = elt->nr;
+		e->ref_count = atomic_read(&elt->ref_count);
+		e->reserved = 0;
+		off += sizeof(*e);
+
+		ips_out = (u64 *)(snap->data + off);
+		for (k = 0; k < elt->nr; k++)
+			ips_out[k] = (u64)elt->ips[k];
+		off += elt->nr * sizeof(u64);
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
index 000000000000..74ad649a79f7
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,54 @@
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
+#ifdef CONFIG_FTRACE_STACKMAP
+
+struct ftrace_stackmap;
+
+struct ftrace_stackmap *ftrace_stackmap_create(void);
+void ftrace_stackmap_destroy(struct ftrace_stackmap *smap);
+int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
+			   unsigned long *ips, unsigned int nr_entries);
+void ftrace_stackmap_reset(struct ftrace_stackmap *smap);
+
+extern const struct file_operations ftrace_stackmap_fops;
+extern const struct file_operations ftrace_stackmap_stat_fops;
+extern const struct file_operations ftrace_stackmap_bin_fops;
+
+#else
+
+struct ftrace_stackmap;
+static inline struct ftrace_stackmap *ftrace_stackmap_create(void) { return NULL; }
+static inline void ftrace_stackmap_destroy(struct ftrace_stackmap *s) { }
+static inline int ftrace_stackmap_get_id(struct ftrace_stackmap *s,
+					 unsigned long *ips, unsigned int n)
+{ return -ENOSYS; }
+static inline void ftrace_stackmap_reset(struct ftrace_stackmap *s) { }
+
+#endif
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

