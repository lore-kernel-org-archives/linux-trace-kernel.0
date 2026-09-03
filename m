Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189644B0CAC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441914; cv=none; b=UJqAAO9tiODYQnAMMo/LffUdW5oFlfrTpUUwSVTF4GXWThKAnPSOOZ3o0674ySUJeKN5/lCaUFdUCmbThHJCF+OIXl89ixlffYjKyhxk8ffpGHDLYJXoTsuChqQuDmZdfCPn37KzzFQ2La5nz2rgdT1AwG/Lo1Knw3KjPG5nRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441914; c=relaxed/simple;
	bh=D50vtv0tJLr6SRI05DDKUYElUNcegfHCkUuMVsla+L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAP1q/g3D8j3ZF9ATjQqp+liPiYIXk0YmTRnzTQ4vEjfWjcNoGs/0uwsEF8wCwi85xupHFtcZH6ivVUCHz7/JsmUdRgNThjgEIKLn2RSS0tC2fWonpVNU4ETAbK/XyjY88wnI24N0VGUCTqzbfSYXw7PMvKjmL1j5C8SRFzHIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8n1W+OY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8n1W+OY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2071365a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441903; x=1789046703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eYI+T0nqql6Hcr/cIM+LpLa/O8zmlVs8ANnO9fPLbrg=;
        b=B8n1W+OY55/jW1ZDuSevZd3zR+irFMIp/O00v3u8zS5TSnubm7agiHBLVBG9yl7Z9M
         RXFXTS0eqA/IaSrCbEQFLhpBFqrq+ca2ssZiuCjvSumnjxsE+soq79SWScjJkOe5siUp
         NbJ08s+byGQznZkcHdMiovXZNq1O1OiqmVDQin5ZYKpaDYivaPk/7IDyUzkAVHc65Jsi
         RNkwqVz5X0iiYFEpMY7eBYdXs+pOFDyZCLlopamgwkuOLOS9Hxp+3VJlpMC2i3dhLsjR
         o1kWiYSWCLQ1Dq/ucI9Hz/5YN5iNVRPeJqvTG2HLBb84L5Dc0wUI7//iPtCvfyIwWtt6
         43BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441903; x=1789046703;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYI+T0nqql6Hcr/cIM+LpLa/O8zmlVs8ANnO9fPLbrg=;
        b=rDjm4EIHa4UilCwdVYw959/bvSKIJQMWWKASuQztVcDsK7pRgJsOuJDGetO32VS3EB
         +zx2IPIi4GIF/1Af1DWGoFgGY1bkQltyqxhZ7xzxCIxKYUt0JJhp2rxOiIhpgP8SIafz
         ykkE2PeyVf6gub0Dp/iRxyppcMyMNVtThYQ5MvT3T2yNW27ym4fFtXt++eHjRdBTr6ZS
         5lQvbm8/frwLqA+k1yQorydl8XIL7qGBn971pGg9excL/kKo7OyJn9gHdgWSQIRoDrK2
         3VwCDuLbj07ZUB96Uqs1QlYWkdiUEVvoQUMFkOaF91S4tFPt3NLHiS8vOU2KxxEDTOBU
         rQ0Q==
X-Forwarded-Encrypted: i=1; AKwUvByrE9v8DcIYijiIMrVFTNdBKHpq/Idd9tpg6+dQQSiWuQ1jWEqhJ3+I9j2iyCtegb+74Zo+cGF1ipH3wMlNpNFw3ZM=@vger.kernel.org
X-Gm-Message-State: AFuF++mtGvX6uxBilscfPcq7zS242NnweSEXVoQ0dHMh4UWof6zngHb8
	f7iKwZXDJ9fmJDUOQ+QPqQf/GH3/qiEf6nM8LVUnssP0fQy8cceDanHH
X-Gm-Gg: AYBFou3O5t5hjq613JIoZN7du4J/KSrtl0jOzjj+u0ufTBnuZm6W7qLqkeXFZMmcRto
	vicYEScF1/sYrB/+3PXK5Hw+uK0b5LaRaqQ7/Q2wPlgfB0r9lU4IrL6M1oqniHr9Oov5XLI7dRt
	FSoQw1Wy0S3/L+AzJvVhHWMQO3AksLH5JEuJv/f1Q+BGpAR1ZQ6WLA1mFi1kOWGkybFY7OvEhqf
	O5eeKwAQ8rDKw2dVMkRhJ0yFXkElqPj/d9iJdlZwSOtKwLA7/AB6xk0gMldKRzd/uxtTVC+I48K
	x+sLDlJVfk4BrQ8BYPqvL3PXOrbMLwpAlJqJRiqJsj1suK+3d1PprLJ5fbg3fI/IxZfBoSvgkfi
	fxswDhVEEEXNH01BErxB+Lmmxekw9Fje8AQgv2r0mJSF3goRWLihIdAl74Ed7RvhxPGW9eEmt+w
	WadzZwS/JwirIVProW2bxUkTzv+ss+apJdyZWTHb0PTSERqV6MbwcitqPLn3R0wH4OriA/WsHjY
	tw=
X-Received: by 2002:a17:90b:5828:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-39aee0850bcmr19354182a91.14.1788441903028;
        Thu, 03 Sep 2026 06:25:03 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832b85bsm5580845a91.4.2026.09.03.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:25:02 -0700 (PDT)
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
Subject: [RFC PATCH v6 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Thu,  3 Sep 2026 21:24:09 +0800
Message-Id: <20260903132409.270195-4-lipengfei28@xiaomi.com>
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

Add supporting files for the ftrace stackmap feature:

Documentation/trace/ftrace-stackmap.rst:
  Documentation covering design, usage, tracefs interface, binary
  format, and performance characteristics. Added to the 'Core Tracing
  Frameworks' toctree in Documentation/trace/index.rst. Documents:
  - Reset clears the map and nothing else: the trace buffer is left
    untouched and tracing does not have to be stopped, so <stack_id N>
    records in an already-collected trace can stop resolving after a
    reset. Read the trace out first if the ids need to stay meaningful
  - Boot-time activation via trace_options=stackmap: events use the
    full-stack fallback until the map and required resolver are created
    and the map is published to global_trace.stackmap
  - bits parameter range [10, 18] and worst-case memory usage
  - tracefs file modes (0640 / 0440), with stack_map required and
    stack_map_stat / stack_map_bin treated as auxiliary observability
    nodes whose creation failure does not disable deduplication
  - Best-effort snapshot semantics for stack_map_bin, serialized
    against reset via the reader_sem
  - Counter definitions and stable output: successes counts map operations
    that return a stack ID; drops counts capacity or probe-limit
    failures; success_rate excludes bypasses that never call the map
    and remains present as 0% when both counters are zero
  - Gravestone amplification when the pool is exhausted

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
  Functional selftest verifying:
  - required stackmap tracefs nodes exist; tests that consume auxiliary
    nodes declare them in '# requires:' and skip if unavailable
  - enabling stackmap + stacktrace produces stack_id events
  - stack_map_stat shows non-zero successes; a nonzero drops count is
    a legitimate by-design fallback and is not treated as failure
  - reset succeeds while tracing is active, since it clears the map
    only and leaves the ring buffer alone
  - reset also clears the map when tracing is stopped
  The test starts and exits with a map reset so a failed run cannot
  leak entries or counters into the next case. It reads trace contents
  BEFORE switching back to the nop tracer (tracer_init()
  unconditionally resets the ring buffer). The function:tracer
  dependency is declared in '# requires:' so ftracetest skips on
  kernels without CONFIG_FUNCTION_TRACER instead of failing spuriously.

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc:
  Verifies the reset semantics, stable statistics output, and binary ABI
  header:
  - 'echo 0 > stack_map' clears the map but leaves the trace buffer
    alone: the <stack_id N> records collected before the reset are
    all still present afterwards
  - stack_map_stat retains success_rate: 0% after reset
  - stack_map_bin begins with the expected magic and version
  The test declares od as a required program and resets the map at both
  entry and cleanup. The auxiliary stack_map_stat and stack_map_bin
  dependencies are declared in '# requires:' so allocation failures
  skip the test.

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc:
  Verifies the option is gated to the top-level instance: a secondary
  instance neither exposes options/stackmap nor the stack_map* nodes,
  and writing 'stackmap' to its aggregate trace_options file is
  rejected rather than accepted as a no-op. Cleanup removes the test
  instance only after this test created it, so a pre-existing instance
  cannot be removed on mkdir failure. The global checks require only
  options/stackmap and stack_map because the stat and binary nodes are
  auxiliary.

tools/tracing/stackmap_dump.py:
  Python script to parse the binary stack_map_bin export.
  Features:
  - Automatic endianness detection via magic number
  - Batched addr2line via stdin (avoids ARG_MAX with large stacks)
  - JSON output mode (ips are always hex addresses; the ftrace
    trampoline marker is shown only in the resolved symbols)
  - Top-N filtering by ref_count
  - Rejects truncated entry headers and IP arrays instead of returning
    partial output as a successful parse
  - Installed by the tools/tracing install target

Binary format: all fields are native-endian. The parser detects
byte order by reading the magic value (0x46534D42 = 'FSMB').

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605160010.fakzGVVq-lkp@intel.com/
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst       | 187 ++++++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 101 ++++++++++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  67 +++++++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    |  84 ++++++++
 tools/tracing/Makefile                        |  13 +-
 tools/tracing/stackmap_dump.py                | 164 +++++++++++++++
 7 files changed, 614 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
 create mode 100755 tools/tracing/stackmap_dump.py

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..59fdcfee66dc
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,187 @@
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
+To reset the stack map::
+
+    echo 0 > /sys/kernel/debug/tracing/stack_map
+
+Reset returns ``-EBUSY`` only if another reset is already in progress.
+
+Reset clears the map and nothing else: the trace buffer is left
+untouched and tracing does not have to be stopped. As a result a trace
+can still contain ``<stack_id N>`` records after a reset. Such an id
+either has no entry in ``stack_map``, or -- once tracing continues and
+the slot is reused -- resolves to an unrelated stack. That is
+misleading output, not corruption. If you need the ids in an existing
+trace to stay meaningful, read the trace out before resetting.
+
+Boot-time activation
+====================
+
+The stackmap option can be enabled from the kernel command line::
+
+    trace_options=stackmap,stacktrace
+
+Trace events that fire before the tracefs filesystem is initialized
+(``fs_initcall`` time) fall back to recording full stack traces.
+Deduplication starts only after the map is successfully created, the
+required ``stack_map`` resolver exists, and the map is
+published to ``global_trace.stackmap``. The crossover is automatic and
+lossless — no events are dropped, but early-boot stacks recorded before
+the crossover are not deduplicated.
+
+Tracefs Nodes
+=============
+
+``stack_map`` is the required resolver and reset node. The
+``stack_map_stat`` and ``stack_map_bin`` files are auxiliary observability nodes.
+If tracefs cannot create either auxiliary node, it emits a warning but does
+not disable stackmap; ``stack_map`` remains available to resolve and reset the
+map. The absence of an auxiliary node therefore does not disable stackmap.
+
+The files are owned by root and not world-readable (``stack_map``: 0640;
+``stack_map_stat`` and ``stack_map_bin``: 0440).
+
+``stack_map``
+    Text export of all deduplicated stacks with symbol resolution.
+    Writing ``0`` or ``reset`` clears all entries.
+
+``stack_map_stat``
+    Statistics: entries (allocated unique stacks), table_size,
+    successes (map operations that returned a stack ID), drops (map
+    capacity or probe-limit failures), and success_rate. The success_rate
+    is ``successes / (successes + drops)``; it does not include bypasses
+    that never call the map, such as deep stacks, reset windows, or ring
+    buffer reservation failures. The field is always present and reports
+    0% when no success or drop has occurred. Drops accumulate when the
+    element pool is exhausted; once that happens, slots that won the
+    cmpxchg but failed to allocate an element remain "claimed but empty"
+    and increase probe pressure for any future insert hashing to the same
+    bucket. Reset clears these gravestones.
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
index 000000000000..94ea259f38ef
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
@@ -0,0 +1,101 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap basic functionality
+# requires: stack_map stack_map_stat options/stackmap function:tracer
+
+# Test that ftrace stackmap deduplication works:
+# 1. Enable stackmap + stacktrace options
+# 2. Run function tracer briefly
+# 3. Verify trace contains <stack_id> events (read BEFORE switching
+#    tracer back to nop, since tracer_init() resets the ring buffer)
+# 4. Verify stack_map has entries and at least some successes. Drops are
+#    a legitimate by-design fallback counter and may be nonzero.
+# 5. Verify reset succeeds while tracing is active (it clears the map
+#    only and leaves the ring buffer alone)
+# 6. Verify reset also clears the map when tracing is stopped
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
+    echo 0 > stack_map 2>/dev/null
+}
+trap cleanup EXIT
+
+disable_tracing
+clear_trace
+echo 0 > stack_map || fail "initial stackmap reset failed"
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
+# stack instead of a stack_id. A nonzero drops count is therefore allowed
+# as long as deduplication also produced successful stack_id events.
+
+# Check stack_map text output is parseable
+first_id=$(cat stack_map | grep "^stack_id" | head -1 | awk '{print $2}')
+if [ -z "$first_id" ]; then
+    fail "stack_map output has no stack_id entries"
+fi
+
+# Reset does not require tracing to be stopped: it clears the map only
+# and leaves the ring buffer alone, so it must succeed with tracing on.
+enable_tracing
+echo 0 > stack_map || fail "stackmap reset failed while tracing is active"
+disable_tracing
+
+# Test reset works when tracing is stopped as well
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
index 000000000000..d88cad5fb128
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap option is gated to the top-level trace instance
+# requires: stack_map options/stackmap instances
+
+# The 'stackmap' option is added to TOP_LEVEL_TRACE_FLAGS, matching the
+# convention used for global-only options like 'printk' and 'record-cmd'.
+# Verify that:
+# 1. The global instance exposes options/stackmap and the required
+#    stack_map node. stack_map_stat and stack_map_bin are auxiliary and
+#    may be absent if their tracefs creation failed.
+# 2. A newly created secondary instance under instances/ does NOT expose
+#    options/stackmap or any stack_map* nodes.
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
+# Remove the temporary instance on any exit (success, fail, or interrupt)
+# so an aborted run does not leave instances/test_stackmap_gate behind
+# and poison later ftracetest runs. Do not remove a pre-existing instance
+# that made mkdir fail before this test acquired ownership.
+instance_created=0
+cleanup() {
+    if [ "$instance_created" -eq 1 ]; then
+        rmdir instances/test_stackmap_gate 2>/dev/null
+    fi
+}
+trap cleanup EXIT
+
+# 1. Global instance must expose the option and required map node
+test -e options/stackmap || fail "options/stackmap missing on global instance"
+test -e stack_map        || fail "stack_map missing on global instance"
+
+# 2. Create a secondary instance and verify it does NOT see the option
+#    or the stack_map* nodes.
+mkdir instances/test_stackmap_gate || fail "could not create secondary instance"
+instance_created=1
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
+instance_created=0
+
+echo "stackmap option gating to top-level instance works"
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
new file mode 100644
index 000000000000..9e442cddd886
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
@@ -0,0 +1,84 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap reset clears the map but not the trace buffer
+# requires: stack_map stack_map_stat stack_map_bin options/stackmap function:tracer od:program
+
+# Lock in the two things most likely to regress in the stackmap ABI /
+# lifetime:
+#   1. Resetting the stackmap (echo 0 > stack_map) clears the map and
+#      leaves the trace buffer alone. Existing <stack_id N> records
+#      therefore survive a reset; they may no longer resolve, which is
+#      documented as misleading-but-harmless userspace output.
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
+    echo 0 > stack_map 2>/dev/null
+}
+trap cleanup EXIT
+
+disable_tracing
+clear_trace
+echo 0 > stack_map || fail "initial stackmap reset failed"
+
+echo 1 > options/stackmap
+echo 1 > options/stacktrace
+echo function > current_tracer
+enable_tracing
+sleep 1
+disable_tracing
+
+# Sanity: the buffer must contain stack_id events before reset, otherwise
+# the buffer-untouched check below would be meaningless.
+before=$(grep -c "<stack_id" trace || true)
+: "${before:=0}"
+if [ "$before" -eq 0 ]; then
+    fail "no <stack_id> events captured before reset"
+fi
+
+# Reset clears the map only. It must succeed and must not disturb the
+# trace buffer.
+echo 0 > stack_map || fail "reset failed"
+
+after=$(grep -c "<stack_id" trace || true)
+: "${after:=0}"
+if [ "$after" -ne "$before" ]; then
+    fail "reset changed the trace buffer: $before -> $after <stack_id> events"
+fi
+
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries:=-1}"
+if [ "$entries" -ne 0 ]; then
+    fail "stackmap still has $entries entries after reset"
+fi
+
+rate=$(cat stack_map_stat | grep "^success_rate:" | awk '{print $2}')
+if [ "$rate" != "0%" ]; then
+    fail "stackmap reset success_rate is '$rate' (expected 0%)"
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
+echo "stackmap reset test passed: map cleared, $before stack_id events kept, ABI header ok"
+exit 0
diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
index 95e485f12d97..96643014c3c0 100644
--- a/tools/tracing/Makefile
+++ b/tools/tracing/Makefile
@@ -1,11 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 
+INSTALL ?= install
+BINDIR ?= /usr/bin
+
 all: latency rtla
 
 clean: latency_clean rtla_clean
 
-install: latency_install rtla_install
+install: latency_install rtla_install stackmap_install
+
+stackmap_install:
+	$(call QUIET_INSTALL,stackmap_dump.py)$(INSTALL) -D -m 755 stackmap_dump.py \
+		$(DESTDIR)$(BINDIR)/stackmap_dump.py
 
 latency:
 	$(call descend,latency)
@@ -25,5 +32,5 @@ rtla_install:
 rtla_clean:
 	$(call descend,rtla,clean)
 
-.PHONY: all install clean latency latency_install latency_clean \
-	rtla rtla_install rtla_clean
+.PHONY: all install clean stackmap_install latency latency_install \
+	latency_clean rtla rtla_install rtla_clean
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..5f9399f67d98
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
+            raise ValueError("Truncated stack entry header")
+        stack_id, nr, ref_count, _ = struct.unpack_from(entry_fmt, data, offset)
+        offset += ENTRY_SIZE
+
+        ips_size = nr * 8
+        if offset + ips_size > len(data):
+            raise ValueError(f"Truncated stack IP data for stack_id {stack_id}")
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

