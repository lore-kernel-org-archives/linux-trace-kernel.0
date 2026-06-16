Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415E3DCD90
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592150; cv=none; b=f3AY4wd+WY4QhSmHqB6mqieOK1XOUu5GaCLvlpRmIn+jwOqRTAByrDP541pUd1MfMZpjX+99QXGIWKBGRKeOsiILDV7RlkjaC/h8LJJRuveYd+yeDiLUOwQ1QOcvx1jlGjQRnaj4oLV00X7GzpD8fhCnYCF0dyZDM7iQYLKq1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592150; c=relaxed/simple;
	bh=WcZjrEZRfh3S+gNhBagj2KSvnMhBuQ9BnZjQPPnfosw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o52emwHI5WAJzovyKuNFaWa/D4/doQLxWZmYiGEm8H2TQoDJL0nrmfQ+2HmlDyTgebBvlRgHBcqEu6pTykTn021DOAcaEdwAHnxzx8qsKOlZf3TwG6Pl12qy7b8+x1hh4tvIRuAU1L3SFo4FRUYaNwZGFN4IpWe+DCTFCU8KWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0KIce9H; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0KIce9H"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13988680a69so554586c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592147; x=1782196947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdc1n+XKhvad81vsVkXIxxp7+FIV7UAbFF/cS0eyfrM=;
        b=J0KIce9H301kNnYBKMaQM0948+SBU0IVW7itqJpf3XbX4VwpKXZCWuKe+Etgm5gcBZ
         1MSeH0JeYERbuWcb5hvOYr7dLRCyg+QEHpO7MBZUCNxUQbLZiYCLhkQyQEnXxuT2Hqei
         vKntKi4B3XRZWlhn65Epn0m4CrGEJQVa8z8tyGf+7cfblAzmiM2Vp0MWzlYJqxjMTRb1
         v+RlqT0vLs9O2mdXaEEtyICQGzCHk1m1gRHrs5/a35Y3oRBfBG6g8oDZZAaH25MJ3tgo
         nSTirVrlA4HJviIq7CK17HIKjUd0sczZJYHNEDweCosn4ZrQyz64xMVeltMgVocZa9ba
         t8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592147; x=1782196947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdc1n+XKhvad81vsVkXIxxp7+FIV7UAbFF/cS0eyfrM=;
        b=huyFSeDw07JYN249U/8GQZc9pM8U6HIKuB1h/IHFmVuI+cwz+sRXupt6N5vHB5IHHE
         zLU3SnwSsaAVhOA6elgdr1Pk66CVwC4YGY9gCk5n5SB1usVI8C+lEjDh8Sl72wdpG1Jt
         6SmH1dIb+q2UaFsNNi+fJkoFF4mT8pddza3T+LRhM/NN5ppoqncnhrcFGjCInXO4tcMl
         QIW6yAZk55GxYByvpXf2XcNJw4WxBSbgdlwkHx+8I0XviC/lEFt1VZT3HKeKboKch5ma
         8LrO8VXVpV/iBCDQ01+FgqhwFNI41T3SFpM5+prLswbnfmghUSBE7l7U3q2I1d4oI7N3
         QHeg==
X-Forwarded-Encrypted: i=1; AFNElJ9aBluzkcRiBqMTpIE058rBmMmxUIKQvt0ABrneng8yGQgQnDAOMjylJGMBpYfksOND/PLQ4qgZbfLElug5KLzn6MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnzPq9oqtpWSuQtf7soVS6pTibswVeWnscsDDzH4Egx4z9itTH
	6AnosO0+82o43ne4jITyKb4L5f0wu0Osen1dGbrTCi2kyfNuI36p7S1v
X-Gm-Gg: Acq92OFg/Jcx/+xXAeiT0nZzyY9reJd48IRKbGkXM/M/ehH2P94c/3FCoZNhzD56UUs
	yoztJR3hDumyhYs//i7eCtYbwPA6eyDa67+ZXcXhTWh+xbHA/20jvrB/ID5bDJyZV9opMxUeLcB
	ync/3v76mPP6xcOmWfYsYDCoafjiFxnY9a694GhudhNdDr9/fLHNfRyRRlUs/tiyF/thKrqeksk
	FsSwME0wVJxb02IHAKKlPtb6c428aoSUGXAdmwpvAouOZxODvzsmdPJIlG31VuDWAUecSAw5SNy
	1prax8N6HAXvVFITkbLfRAy40h4r4CwHJQDL6EtEx16+NDWs+fz2kNndcT1hkoIieRDtnfDOuvT
	DLnBIPszjTceUfwmL7uFGo0x3szEKjvQFwjPp3Owzhmw0GosW3ENyOHtVmufV93YYzAYpV28zx7
	e5VttWqsftqZPr4s9tkp2H5NGRmkcEMhask9Ie3Q==
X-Received: by 2002:a05:7022:f9a:b0:139:89ad:8deb with SMTP id a92af1059eb24-13989ad9011mr314176c88.9.1781592146682;
        Mon, 15 Jun 2026 23:42:26 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:55be:2dbe:9cd4:7306])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm12499158c88.4.2026.06.15.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:42:24 -0700 (PDT)
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
	zhangbo56@xiaomi.com,
	kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v4 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Tue, 16 Jun 2026 14:41:19 +0800
Message-Id: <20260616064119.438063-4-lipengfei28@xiaomi.com>
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

Add supporting files for the ftrace stackmap feature:

Documentation/trace/ftrace-stackmap.rst:
  Documentation covering design, usage, tracefs interface, binary
  format, and performance characteristics. Added to the 'Core Tracing
  Frameworks' toctree in Documentation/trace/index.rst. Documents:
  - Reset is destructive: it requires tracing to be stopped and also
    clears the ring buffer so no stale <stack_id N> survives
  - Boot-time activation via trace_options=stackmap
  - bits parameter range [10, 18] and worst-case memory usage
  - tracefs file modes (0640 / 0440)
  - Best-effort snapshot semantics for stack_map_bin, serialized
    against reset via the reader_sem
  - Counter naming: successes (events served), drops, success_rate;
    successes/drops are best-effort and saturate on long runs
  - Gravestone amplification when the pool is exhausted

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
  Functional selftest verifying:
  - stackmap tracefs nodes exist
  - enabling stackmap + stacktrace produces stack_id events
  - stack_map_stat shows non-zero successes (a nonzero drops count is
    a legitimate by-design fallback and is not treated as failure;
    only zero successes alongside nonzero drops is fatal)
  - reset clears entries when tracing is stopped
  - reset is rejected (-EBUSY) while tracing is active
  Test reads trace contents BEFORE switching back to the nop tracer
  (tracer_init() unconditionally resets the ring buffer). The
  function:tracer dependency is declared in '# requires:' so
  ftracetest skips on kernels without CONFIG_FUNCTION_TRACER instead
  of failing spuriously.

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc:
  Verifies the destructive-reset semantics and the binary ABI header:
  - after 'echo 0 > stack_map', the trace buffer no longer contains
    any stale <stack_id N>
  - stack_map_bin begins with the expected magic and version

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc:
  Verifies the option is gated to the top-level instance: a secondary
  instance neither exposes options/stackmap nor the stack_map* nodes,
  and writing 'stackmap' to its aggregate trace_options file is
  rejected rather than accepted as a no-op.

tools/tracing/stackmap_dump.py:
  Python script to parse the binary stack_map_bin export.
  Features:
  - Automatic endianness detection via magic number
  - Batched addr2line via stdin (avoids ARG_MAX with large stacks)
  - JSON output mode (ips are always hex addresses; the ftrace
    trampoline marker is shown only in the resolved symbols)
  - Top-N filtering by ref_count

Binary format: all fields are native-endian. The parser detects
byte order by reading the magic value (0x46534D42 = 'FSMB').

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605160010.fakzGVVq-lkp@intel.com/
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst       | 177 ++++++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 111 +++++++++++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  54 ++++++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    |  76 ++++++++
 tools/tracing/stackmap_dump.py                | 164 ++++++++++++++++
 6 files changed, 583 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
 create mode 100755 tools/tracing/stackmap_dump.py

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..8d0b5c389862
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,177 @@
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
+Reset is destructive to the trace buffer: because the ring buffer may
+still hold ``<stack_id N>`` events that reference soon-to-be-reused
+slots, resetting the map also resets the owning trace buffer (and its
+snapshot, if allocated). This keeps ring-buffer stack_ids and the map
+coherent. Read out any trace data you need before resetting.
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
+    Magic: ``0x46534D42`` ('FSMB'), Version: 1.
+
+    Trampoline frames are exported as the sentinel value
+    ``0x7fffffff`` (FTRACE_TRAMPOLINE_MARKER); all other addresses are
+    passed through ``trace_adjust_address()`` so they match the
+    ``stack_map`` text output's address-adjustment rules. Note this is
+    the same adjustment ftrace applies to its own trace output (mainly
+    relevant for persistent / last-boot buffers), not a general KASLR
+    un-offset: resolving these addresses offline still requires the
+    matching kernel's symbol information.
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
index 000000000000..64dfe7cc66bd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
@@ -0,0 +1,111 @@
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
+# 4. Verify stack_map has entries and at least some successes (drops is
+#    a legitimate by-design fallback counter and is allowed to be nonzero;
+#    only zero successes alongside nonzero drops indicates breakage)
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
+# drops is a legitimate by-design fallback counter: when the map is full
+# or under heavy probe pressure, stackmap falls back to recording a full
+# stack instead of a stack_id. A nonzero drops count is therefore not a
+# failure. Only treat it as fatal if dedup never worked at all (no
+# successes), which would indicate the feature is genuinely broken rather
+# than merely under pressure.
+if [ "$successes" -eq 0 ] && [ "$drops" -ne 0 ]; then
+    fail "stackmap had $drops drops and zero successes (feature broken?)"
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
index 000000000000..28810ba20432
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
@@ -0,0 +1,54 @@
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
+# 3. The aggregate trace_options file still reaches set_tracer_flag(),
+#    so writing 'stackmap' there must be rejected on a secondary
+#    instance. Otherwise the bit could appear set in trace_options
+#    while the hot path silently falls back to a full stack trace
+#    (tr->stackmap == NULL).
+if echo stackmap > instances/test_stackmap_gate/trace_options 2>/dev/null; then
+    fail "secondary instance accepted 'echo stackmap > trace_options'"
+fi
+if grep -qw stackmap instances/test_stackmap_gate/trace_options; then
+    fail "secondary instance trace_options reports stackmap as set"
+fi
+
+rmdir instances/test_stackmap_gate || fail "could not remove secondary instance"
+
+echo "stackmap option gating to top-level instance works"
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
new file mode 100644
index 000000000000..803cc282f9ab
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap reset clears the trace buffer and ABI header
+# requires: stack_map options/stackmap function:tracer
+
+# Lock in the two things most likely to regress in the stackmap ABI /
+# lifetime:
+#   1. Resetting the stackmap (echo 0 > stack_map, tracing stopped) also
+#      clears the trace buffer, so no stale <stack_id N> can be left
+#      dangling against an emptied map.
+#   2. The stack_map_bin header carries the expected magic ('FSMB' =
+#      0x46534D42) and version (1).
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
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
+echo 1 > options/stackmap
+echo 1 > options/stacktrace
+echo function > current_tracer
+enable_tracing
+sleep 1
+disable_tracing
+
+# Sanity: the buffer must contain stack_id events before reset, otherwise
+# the post-reset emptiness check below would be meaningless.
+before=$(grep -c "<stack_id" trace || true)
+: "${before:=0}"
+if [ "$before" -eq 0 ]; then
+    fail "no <stack_id> events captured before reset"
+fi
+
+# Reset while tracing is stopped. This must succeed AND clear the trace
+# buffer (destructive reset semantics).
+echo 0 > stack_map || fail "reset rejected while tracing stopped"
+
+after=$(grep -c "<stack_id" trace || true)
+: "${after:=0}"
+if [ "$after" -ne 0 ]; then
+    fail "trace still has $after stale <stack_id> events after reset"
+fi
+
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries:=-1}"
+if [ "$entries" -ne 0 ]; then
+    fail "stackmap still has $entries entries after reset"
+fi
+
+# Binary export header: magic 'FSMB' (0x46534D42) + version 1.
+# od -tx4 renders the 32-bit words in the target's native byte order,
+# which matches what the kernel wrote, so the comparison is endian-safe.
+if command -v od >/dev/null 2>&1; then
+    magic=$(od -An -tx4 -N4 stack_map_bin | tr -d ' \n')
+    if [ "$magic" != "46534d42" ]; then
+        fail "stack_map_bin bad magic: 0x$magic (expected 46534d42)"
+    fi
+    ver=$(od -An -tx4 -j4 -N4 stack_map_bin | tr -d ' \n')
+    if [ "$ver" != "00000001" ]; then
+        fail "stack_map_bin bad version: 0x$ver (expected 00000001)"
+    fi
+fi
+
+echo "stackmap reset test passed: cleared $before stack_id events, ABI header ok"
+exit 0
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..2d9c49b776e6
--- /dev/null
+++ b/tools/tracing/stackmap_dump.py
@@ -0,0 +1,164 @@
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
+MAGIC = 0x46534D42  # 'FSMB'
+HEADER_SIZE = 16  # 4 x u32
+ENTRY_SIZE = 16   # 4 x u32
+
+# __ftrace_trace_stack() replaces trampoline addresses with this marker
+# (FTRACE_TRAMPOLINE_MARKER == (unsigned long)INT_MAX) before the stack
+# is stored, so the binary export carries it verbatim.
+FTRACE_TRAMPOLINE_MARKER = 0x7fffffff
+TRAMPOLINE_LABEL = '[FTRACE TRAMPOLINE]'
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
+    if version != 1:
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
+            all_addrs.update(ip for ip in ips
+                             if ip != FTRACE_TRAMPOLINE_MARKER)
+        symbols = batch_addr2line(args.vmlinux, list(all_addrs))
+
+    def render(ip):
+        if ip == FTRACE_TRAMPOLINE_MARKER:
+            return TRAMPOLINE_LABEL
+        return symbols.get(ip, f'0x{ip:x}')
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
+                entry['symbols'] = [render(ip) for ip in ips]
+            output.append(entry)
+        print(json.dumps(output, indent=2))
+    else:
+        for stack_id, ref_count, ips in stacks:
+            print(f"stack_id {stack_id} [ref {ref_count}, depth {len(ips)}]")
+            for i, ip in enumerate(ips):
+                if ip == FTRACE_TRAMPOLINE_MARKER:
+                    print(f"  [{i}] {TRAMPOLINE_LABEL}")
+                    continue
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

