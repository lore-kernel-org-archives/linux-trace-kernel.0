Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A53F6C28
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796444; cv=none; b=kZUZIzRDajmwam3p+VYwzSQPQS5oDOwLyp27hOaVkXnw7DGaguWZU3plSDM8zarzXTYtC81F1lP1jnFt3TQaEre24E61MKgrHR6vCX6TlPzLSBtV5dgR+U63i4fpXa7RspoNlk6XoFo8iTnUGHx2utQdeLSluVP/9bZix0M0d1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796444; c=relaxed/simple;
	bh=7dXfYLqXXHz/zzNEt9CxgmXo5e7tNE8y0U7UoQWT9CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKIsm/0NcOC+oBfaYjIwCU43q7j3yrgmLXQ2Gzvr9/pGjZh3E32DeMyJ5JZtW+N1Bmi7ic+Cesl1s+iPG+9KnQSyJMXkFt6NbwDeuLslOWygAk/ppuUEZveK9LbIDN8/h7zk7kCIrW25FxEw3wTwlQ0Rl4Ak3Kweyc0Foe30MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzbaGR8s; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzbaGR8s"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso4396211a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796433; x=1780401233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJE9EN6+Z3/bVQ/jKJ2h2ipRodpjDG/kmXUV8v2yycQ=;
        b=OzbaGR8sSsxUbcZF5LMPAJ1GaV5oYffzDcOdkecHwe3NGDmmNCeNNalouhSZAy9QPv
         826JAgBKpUcsz4IGPl+3EFy4XObV5/thEh23fb2Tpu1lw4IlObGUILPY35kLr459/T6+
         QeQQGuQAu65KDiGYq2zYTpXR1L/jY91wOK7C7oVXrSBWg6Rhh28ig1mgs7zgnHu1YhRp
         bPDr+KEsUX+vmoBeWHvo/AC9IapNAtz4Cp1APD2nzWzjhUoEzPD3gJg+NvEsIKVZKTMx
         RiWZ5o6MBiKAVXCTmbmUQbO86cW66rjcuShJ2qrJSVKD9ZmRPmLGOuCTIZdvR4PQAb7m
         mvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796433; x=1780401233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJE9EN6+Z3/bVQ/jKJ2h2ipRodpjDG/kmXUV8v2yycQ=;
        b=FLxKRut8lrUg51Web02hLd6qUZ4jJjFNf12N16/LXe11yibMnxHbJKb0gmKIWDnAx1
         iyOwyGxdnYNRJBLOUG5G6ftG35ch5Wjfauy4HjPpLATtc5t1hbZMIPLV9CLDkPtfb9rj
         HLeY+ImmoM6mmoB+hmH2wyFi3291DVO+RZEJSdqj7yY8jVzsUeN6gDXyuW1n6wN6z/+l
         A9j5iZfAx4jkx2Y00LJ7pmw9OVfty1UDWSV3pPZjucXLnd5jU0N8XgsZwIstcPpRPlbU
         WZ9MA+8s9fmmTZ93k6ORdd3ZEbdIda72L52CoXhM9UBAExZbw6cbw5HA/lP6danbF+Ti
         lDyg==
X-Gm-Message-State: AOJu0YwzxMwOr/eixRbxFcfgxbCCqewQlA5bsvf1DgBQM8fJOLpM4uhE
	oMMjZsb6j33CeIABNrCnmCjLzVx5oZN+i/3Pln6t5xFiBWfUAGzPOHeM
X-Gm-Gg: Acq92OEVdv3I6vM7il2sfJhQXhh2AL32tNz4y6On6KsF/zbrnv2RNdmZOkq8ZVjnzjW
	NKGB95ZmK1riB7Tx0Qe2UQva9QIg8g5ldND5wf86q4T8nIwqjakLYVeXY/s8dtEK4sjZDz6velr
	0DPWN5zV5MzS9BHKnOlFQNGvlPE/p+erDmV9JrL2dL9C9ULUAxihnRPqmOHc6LmkshWrv1JCj2N
	tQZ/OH+NchVR4ZqeJkrYRtrSEXoi74vmUbfKwJZe5bl1vOdzCutrW226O/2R19I1xJT4Xk4+MlQ
	URdY74ysSK22sxYFK5qggEaG5PKivhQYa2u42WbsDiieni6Zshm4/w9Y4Xz4FfrwTFzx7EMNcUU
	ZhmHuE8kAzi7B4+pGvRPdw194R+CAPZ+PXYG/6kQPIICYZ6ycvqMUQRmGMBpf11Uq2d4cmgRC+2
	VZixryB/SqKBrL3+biLJk9XFp3BDRjzJd1dHlpkg==
X-Received: by 2002:a17:903:4b07:b0:2bd:b50f:c1bf with SMTP id d9443c01a7336-2beb06464edmr199879845ad.38.1779796433395;
        Tue, 26 May 2026 04:53:53 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d6ff:7a7e:f223:7f2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dd75bsm163399345ad.69.2026.05.26.04.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:53:52 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	Pengfei Li <lipengfei28@xiaomi.com>,
	kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v3 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Tue, 26 May 2026 19:52:45 +0800
Message-Id: <c885ce963112a9238054837c28e66dbc3556768d.1779769138.git.lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779769138.git.lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com> <cover.1779769138.git.lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add supporting files for the ftrace stackmap feature:

Documentation/trace/ftrace-stackmap.rst:
  Documentation covering design, usage, tracefs interface, binary
  format, and performance characteristics. Added to the 'Core Tracing
  Frameworks' toctree in Documentation/trace/index.rst. Documents:
  - Reset requires tracing to be stopped first
  - Boot-time activation via trace_options=stackmap
  - bits parameter range [10, 18] and worst-case memory usage
  - tracefs file modes (0640 / 0440)
  - Best-effort snapshot semantics for stack_map_bin
  - Counter naming: successes (events served), drops, success_rate
  - Gravestone amplification when the pool is exhausted

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
  Functional selftest verifying:
  - stackmap tracefs nodes exist
  - enabling stackmap + stacktrace produces stack_id events
  - stack_map_stat shows non-zero successes and zero drops
  - reset clears entries when tracing is stopped
  - reset is rejected (-EBUSY) while tracing is active
  Test reads trace contents BEFORE switching back to the nop tracer
  (tracer_init() unconditionally calls tracing_reset_online_cpus(),
  which would empty the ring buffer). The function:tracer dependency
  is declared in '# requires:' so ftracetest skips on kernels without
  CONFIG_FUNCTION_TRACER instead of failing spuriously. An EXIT trap
  restores options/stackmap and options/stacktrace on any exit path.

tools/tracing/stackmap_dump.py:
  Python script to parse the binary stack_map_bin export.
  Features:
  - Automatic endianness detection via magic number
  - Batched addr2line via stdin (avoids ARG_MAX with large stacks)
  - JSON output mode
  - Top-N filtering by ref_count

Binary format: all fields are native-endian. The parser detects
byte order by reading the magic value (0x464D5342 = 'FSMB').

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605160010.fakzGVVq-lkp@intel.com/
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst       | 162 ++++++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 103 +++++++++++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  42 +++++
 tools/tracing/stackmap_dump.py                | 150 ++++++++++++++++
 5 files changed, 458 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100755 tools/tracing/stackmap_dump.py

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..191347be3664
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Ftrace Stack Map
+======================
+
+:Author: Pengfei Li <lipengfei28@xiaomi.com>
+
+Overview
+========
+
+The ftrace stack map provides stack trace deduplication for the ftrace
+ring buffer. When enabled, instead of storing full kernel stack traces
+(typically 80-160 bytes each) in the ring buffer for every event, ftrace
+stores only a 4-byte ``stack_id``. The full stacks are maintained in a
+separate hash table and exported via tracefs for userspace to resolve.
+
+This is inspired by eBPF's ``BPF_MAP_TYPE_STACK_TRACE`` but integrated
+into ftrace's infrastructure, requiring no userspace daemon.
+
+Configuration
+=============
+
+Enable ``CONFIG_FTRACE_STACKMAP=y`` in the kernel config.
+
+Kernel command line parameters:
+
+- ``ftrace_stackmap.bits=N`` - Set map capacity to 2^N unique stacks
+  (default: 14 → 16384 stacks; valid range: 10-18).
+
+  At ``bits=18`` the kernel reserves roughly 130 MB of vmalloc memory
+  for the element pool. Each ``open()`` of ``stack_map_bin`` may
+  briefly allocate a similar amount for a snapshot. The cap is set
+  intentionally to bound memory usage.
+
+Usage
+=====
+
+Enable stack deduplication::
+
+    echo 1 > /sys/kernel/debug/tracing/options/stackmap
+    echo 1 > /sys/kernel/debug/tracing/options/stacktrace
+    echo function > /sys/kernel/debug/tracing/current_tracer
+
+The trace output will show ``<stack_id N>`` instead of full stack traces::
+
+    sh-1234 [006] d.h.. 123.456789: <stack_id 42>
+
+To view the actual stacks::
+
+    cat /sys/kernel/debug/tracing/stack_map
+
+Output format::
+
+    stack_id 42 [ref 1337, depth 8]
+      [0] schedule+0x48/0xc0
+      [1] schedule_timeout+0x1c/0x30
+      ...
+
+To view statistics::
+
+    cat /sys/kernel/debug/tracing/stack_map_stat
+
+Output::
+
+    entries:      2500 / 16384
+    table_size:   32768
+    successes:    148923
+    drops:        0
+    success_rate: 100%
+
+To reset the stack map (tracing must be stopped first)::
+
+    echo 0 > /sys/kernel/debug/tracing/tracing_on
+    echo 0 > /sys/kernel/debug/tracing/stack_map
+
+Reset returns ``-EBUSY`` if tracing is currently active, or if another
+reset is already in progress.
+
+Boot-time activation
+====================
+
+The stackmap option can be enabled from the kernel command line::
+
+    trace_options=stackmap,stacktrace
+
+Trace events that fire before the tracefs filesystem is initialized
+(``fs_initcall`` time) fall back to recording full stack traces; once
+``ftrace_stackmap_create()`` runs, subsequent events are deduplicated.
+The crossover is automatic and lossless — no events are dropped, but
+early-boot stacks recorded before the crossover are not deduplicated.
+
+Tracefs Nodes
+=============
+
+The stack_map files are owned by root and not world-readable
+(``stack_map``: 0640; ``stack_map_stat`` and ``stack_map_bin``: 0440).
+
+``stack_map``
+    Text export of all deduplicated stacks with symbol resolution.
+    Writing ``0`` or ``reset`` clears all entries (only when tracing
+    is stopped).
+
+``stack_map_stat``
+    Statistics: entries (allocated unique stacks), table_size,
+    successes (events served), drops (events that fell back to
+    full-stack recording), and success_rate. Drops accumulate when
+    the element pool is exhausted; once that happens, slots that
+    won the cmpxchg but failed to allocate an element remain
+    "claimed but empty" and increase probe pressure for any future
+    insert hashing to the same bucket. Reset (when tracing is
+    stopped) clears these gravestones.
+
+``stack_map_bin``
+    Binary export for efficient userspace consumption. Format:
+
+    - Header (16 bytes): magic(u32) + version(u32) + nr_stacks(u32) + reserved(u32)
+    - Per stack: stack_id(u32) + nr(u32) + ref_count(u32) + reserved(u32) + ips(u64 × nr)
+
+    All fields are written in the kernel's native byte order.
+    Userspace tools detect endianness by reading the magic value.
+    Magic: ``0x464D5342`` ('FSMB'), Version: 2.
+
+    The export is a best-effort snapshot allocated at ``open()``;
+    concurrent inserts during the snapshot may be truncated. A
+    bounds check ensures no overflow.
+
+Design
+======
+
+The stack map is modeled after ``tracing_map.c`` (used by hist triggers),
+using a lock-free design based on Dr. Cliff Click's non-blocking hash table
+algorithm:
+
+- **Lookup/Insert**: Lock-free via ``cmpxchg``, safe in NMI/IRQ/any context
+- **Memory**: Pre-allocated element pool, zero allocation on the hot path
+  (no GFP_ATOMIC failures under memory pressure)
+- **Collision**: Linear probing with a 2x over-provisioned table; probe
+  length is bounded so worst-case insert/lookup is O(1)
+- **Scope**: Currently supports the global trace instance
+- **Hash**: 32-bit jhash with a per-instance random seed; full ``memcmp``
+  confirms matches
+
+Deduplication is best-effort, not strict: if two CPUs race in the
+insert path with the same ``key_hash`` (i.e. the same stack), the
+``cmpxchg`` loser advances by one slot and may insert the same stack
+again. Under heavy contention this can produce a small number of
+duplicate entries for the same stack; ``ref_count`` is then split
+across the duplicates. Total memory is still bounded by the element
+pool size, and lookup correctness is unaffected (each duplicate is
+a self-consistent entry with its own ``stack_id``). The trade-off is
+intentional and keeps the hot path lock-free.
+
+Performance
+===========
+
+Typical results on an aarch64 SMP system (function tracer, 2 seconds):
+
+- Unique stacks: ~3000
+- Dedup rate: 84-98% (depends on workload diversity)
+- Ring buffer savings: ~80% for stack data
+- Overhead per event: ~50ns (one jhash + hash table lookup)
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5d9bf4694d5d..ac8b1141c23a 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -33,6 +33,7 @@ the Linux kernel.
    ftrace
    ftrace-design
    ftrace-uses
+   ftrace-stackmap
    kprobes
    kprobetrace
    fprobetrace
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
new file mode 100644
index 000000000000..18fa998ae460
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
@@ -0,0 +1,103 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap basic functionality
+# requires: stack_map options/stackmap function:tracer
+
+# Test that ftrace stackmap deduplication works:
+# 1. Enable stackmap + stacktrace options
+# 2. Run function tracer briefly
+# 3. Verify trace contains <stack_id> events (read BEFORE switching
+#    tracer back to nop, since tracer_init() resets the ring buffer)
+# 4. Verify stack_map has entries and zero drops
+# 5. Verify reset is rejected (-EBUSY) while tracing is active
+# 6. Verify reset clears the map when tracing is stopped
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
+# Restore state on any exit (success, fail, or interrupt) so a
+# half-finished test does not leave stacktrace/stackmap enabled.
+cleanup() {
+    disable_tracing 2>/dev/null
+    echo nop > current_tracer 2>/dev/null
+    echo 0 > options/stackmap 2>/dev/null
+    echo 0 > options/stacktrace 2>/dev/null
+}
+trap cleanup EXIT
+
+disable_tracing
+clear_trace
+
+# Verify stackmap files exist
+test -f stack_map      || fail "stack_map file missing"
+test -f stack_map_stat || fail "stack_map_stat file missing"
+test -f stack_map_bin  || fail "stack_map_bin file missing"
+
+# Enable stackmap dedup
+echo 1 > options/stackmap
+echo 1 > options/stacktrace
+
+# Run function tracer briefly
+echo function > current_tracer
+enable_tracing
+sleep 1
+disable_tracing
+
+# Read trace contents NOW, before switching tracer back to nop.
+# tracer_init() unconditionally calls tracing_reset_online_cpus(),
+# so the ring buffer would be empty after 'echo nop > current_tracer'.
+count=$(grep -c "<stack_id" trace || true)
+: "${count:=0}"
+if [ "$count" -eq 0 ]; then
+    fail "trace has no <stack_id> events"
+fi
+
+# Now safe to switch back and disable options
+echo nop > current_tracer
+echo 0 > options/stackmap
+
+# Check stack_map_stat
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries:=0}"
+if [ "$entries" -eq 0 ]; then
+    fail "stackmap has zero entries after tracing"
+fi
+
+successes=$(cat stack_map_stat | grep "^successes:" | awk '{print $2}')
+: "${successes:=0}"
+if [ "$successes" -eq 0 ]; then
+    fail "stackmap has zero successes"
+fi
+
+drops=$(cat stack_map_stat | grep "^drops:" | awk '{print $2}')
+: "${drops:=0}"
+if [ "$drops" -ne 0 ]; then
+    fail "stackmap had $drops drops (pool exhausted?)"
+fi
+
+# Check stack_map text output is parseable
+first_id=$(cat stack_map | grep "^stack_id" | head -1 | awk '{print $2}')
+if [ -z "$first_id" ]; then
+    fail "stack_map output has no stack_id entries"
+fi
+
+# Test that reset is rejected while tracing is active
+enable_tracing
+if echo 0 > stack_map 2>/dev/null; then
+    disable_tracing
+    fail "stackmap reset should fail while tracing is active"
+fi
+disable_tracing
+
+# Test reset works when tracing is stopped
+echo 0 > stack_map
+entries_after=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries_after:=-1}"
+if [ "$entries_after" -ne 0 ]; then
+    fail "stackmap reset did not clear entries (got $entries_after)"
+fi
+
+echo "stackmap basic test passed: $entries unique stacks, $successes successes, $drops drops"
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
new file mode 100644
index 000000000000..49848eac2624
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap option is gated to the top-level trace instance
+# requires: stack_map options/stackmap instances
+
+# The 'stackmap' option is added to TOP_LEVEL_TRACE_FLAGS, matching the
+# convention used for global-only options like 'printk' and 'record-cmd'.
+# Verify that:
+# 1. The global instance exposes options/stackmap and the stack_map* nodes.
+# 2. A newly created secondary instance under instances/ does NOT expose
+#    options/stackmap or stack_map* nodes.
+
+fail() {
+    echo "FAIL: $1"
+    rmdir instances/test_stackmap_gate 2>/dev/null
+    exit_fail
+}
+
+# 1. Global instance must expose the option and the nodes
+test -e options/stackmap || fail "options/stackmap missing on global instance"
+test -e stack_map        || fail "stack_map missing on global instance"
+test -e stack_map_stat   || fail "stack_map_stat missing on global instance"
+test -e stack_map_bin    || fail "stack_map_bin missing on global instance"
+
+# 2. Create a secondary instance and verify it does NOT see the option
+#    or the stack_map* nodes.
+mkdir instances/test_stackmap_gate || fail "could not create secondary instance"
+
+if [ -e instances/test_stackmap_gate/options/stackmap ]; then
+    fail "secondary instance unexpectedly exposes options/stackmap"
+fi
+
+for f in stack_map stack_map_stat stack_map_bin; do
+    if [ -e instances/test_stackmap_gate/$f ]; then
+        fail "secondary instance unexpectedly has $f"
+    fi
+done
+
+rmdir instances/test_stackmap_gate || fail "could not remove secondary instance"
+
+echo "stackmap option gating to top-level instance works"
+exit 0
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..fcd8ddcd97de
--- /dev/null
+++ b/tools/tracing/stackmap_dump.py
@@ -0,0 +1,150 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+stackmap_dump.py - Parse and display ftrace stack_map_bin binary export.
+
+Usage:
+    # Pull from device and parse
+    adb pull /sys/kernel/debug/tracing/stack_map_bin /tmp/stack_map.bin
+    python3 stackmap_dump.py /tmp/stack_map.bin
+
+    # With vmlinux for offline symbol resolution
+    python3 stackmap_dump.py /tmp/stack_map.bin --vmlinux vmlinux
+
+    # JSON output for tooling
+    python3 stackmap_dump.py /tmp/stack_map.bin --json
+"""
+
+import struct
+import sys
+import argparse
+import json
+import subprocess
+
+MAGIC = 0x464D5342  # 'FSMB'
+HEADER_SIZE = 16  # 4 x u32
+ENTRY_SIZE = 16   # 4 x u32
+
+
+def detect_endianness(data):
+    """Detect byte order from magic number in header."""
+    if len(data) < 4:
+        raise ValueError("File too small")
+    magic_le = struct.unpack_from('<I', data, 0)[0]
+    if magic_le == MAGIC:
+        return '<'
+    magic_be = struct.unpack_from('>I', data, 0)[0]
+    if magic_be == MAGIC:
+        return '>'
+    raise ValueError(f"Bad magic: 0x{magic_le:08x} (neither LE nor BE)")
+
+
+def batch_addr2line(vmlinux, addrs):
+    """Resolve multiple addresses in one addr2line invocation."""
+    if not addrs:
+        return {}
+    try:
+        # Feed addresses on stdin to avoid ARG_MAX limits with large
+        # numbers of addresses (one stack can have 30+ frames; a
+        # snapshot can have thousands of unique stacks).
+        stdin = '\n'.join(hex(a) for a in addrs) + '\n'
+        result = subprocess.run(
+            ['addr2line', '-f', '-e', vmlinux],
+            input=stdin, capture_output=True, text=True, timeout=60
+        )
+        lines = result.stdout.split('\n')
+        # addr2line outputs 2 lines per address: function name + source location
+        symbols = {}
+        for i, addr in enumerate(addrs):
+            idx = i * 2
+            if idx < len(lines) and lines[idx] and lines[idx] != '??':
+                symbols[addr] = lines[idx]
+        return symbols
+    except (subprocess.TimeoutExpired, FileNotFoundError) as e:
+        print(f"warning: addr2line failed: {e}", file=sys.stderr)
+        return {}
+
+
+def parse_stackmap_bin(data):
+    """Parse binary stackmap data, yield (stack_id, ref_count, [ips])."""
+    if len(data) < HEADER_SIZE:
+        raise ValueError("File too small for header")
+
+    endian = detect_endianness(data)
+    header_fmt = f'{endian}IIII'
+    entry_fmt = f'{endian}IIII'
+
+    magic, version, nr_stacks, _ = struct.unpack_from(header_fmt, data, 0)
+    if version != 2:
+        raise ValueError(f"Unsupported version: {version}")
+
+    offset = HEADER_SIZE
+    for _ in range(nr_stacks):
+        if offset + ENTRY_SIZE > len(data):
+            break
+        stack_id, nr, ref_count, _ = struct.unpack_from(entry_fmt, data, offset)
+        offset += ENTRY_SIZE
+
+        ips_size = nr * 8
+        if offset + ips_size > len(data):
+            break
+        ips = struct.unpack_from(f'{endian}{nr}Q', data, offset)
+        offset += ips_size
+
+        yield stack_id, ref_count, list(ips)
+
+
+def main():
+    parser = argparse.ArgumentParser(description='Parse ftrace stack_map_bin')
+    parser.add_argument('file', help='Path to stack_map_bin file')
+    parser.add_argument('--vmlinux', help='Path to vmlinux for symbol resolution')
+    parser.add_argument('--json', action='store_true', help='JSON output')
+    parser.add_argument('--top', type=int, default=0,
+                        help='Show only top N stacks by ref_count')
+    args = parser.parse_args()
+
+    with open(args.file, 'rb') as f:
+        data = f.read()
+
+    stacks = list(parse_stackmap_bin(data))
+
+    if args.top > 0:
+        stacks.sort(key=lambda x: x[1], reverse=True)
+        stacks = stacks[:args.top]
+
+    # Batch symbol resolution
+    symbols = {}
+    if args.vmlinux:
+        all_addrs = set()
+        for _, _, ips in stacks:
+            all_addrs.update(ips)
+        symbols = batch_addr2line(args.vmlinux, list(all_addrs))
+
+    if args.json:
+        output = []
+        for stack_id, ref_count, ips in stacks:
+            entry = {
+                'stack_id': stack_id,
+                'ref_count': ref_count,
+                'ips': [f'0x{ip:x}' for ip in ips]
+            }
+            if args.vmlinux:
+                entry['symbols'] = [symbols.get(ip, f'0x{ip:x}')
+                                    for ip in ips]
+            output.append(entry)
+        print(json.dumps(output, indent=2))
+    else:
+        for stack_id, ref_count, ips in stacks:
+            print(f"stack_id {stack_id} [ref {ref_count}, depth {len(ips)}]")
+            for i, ip in enumerate(ips):
+                sym = symbols.get(ip, '')
+                if sym:
+                    sym = f' {sym}'
+                print(f"  [{i}] 0x{ip:x}{sym}")
+            print()
+
+    print(f"Total: {len(stacks)} unique stacks", file=sys.stderr)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

