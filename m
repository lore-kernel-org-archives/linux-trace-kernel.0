Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8F3CD8CD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446494; cv=none; b=A40o+e/uYSe3k6UP5RmelUUVU+FK3zOblDXRcCrJydcVpjFEBqTR1kAAGZZxl44FiBe/v4D4bl7S9LafgvVjOtLj/qUXlwBZX1D6ZvvNn1oRIUnTkSbTCQ2GFS+7KBLxQtb0HqhyhdXgQ1RlPcQRUDeI1ZpbHPR8rnGh4bIRwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446494; c=relaxed/simple;
	bh=YnhARjoR2achW0qVPc//wJnFnjplveFY3wti7KhnGJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQz7l95YATd2jkBASinUFHF3kWxQj5LS6r+3+1NQf5lirrHBNbnC2HANqmm6/xA6UlSvcKOgxxCc1jQXYkYSrRBKapotU2ijC3zhAdgOkeMtf+AMKQafBCKahKXpiA0skD8O+TvqtiH4m7JtkVRF8fgvZhWmiz9SUN6zRcMDHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOjmmWOD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOjmmWOD"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2616693a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446490; x=1780051290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB8E6xUBrMkQP8ebx8+gCpC7rvCJlL/tAjTiX9u35Zc=;
        b=LOjmmWOD6nc/LS6C9M6fsmlndL/i++9JMbE4kUAD+lTaydkTvbwe6VHjgrpI3UJtaT
         ph/Zbz+q6OzrkUoMR2CgpOwEWXECu/+Bxq+6UBVROQ3Lm/a8kgYsTxUHVw70sB8njAh0
         YEqQ3ixP/Fk3S/hb/FpU8nTd8imB20ob/SmIrDSU2d7xWPJuy533qhvRPO2c8H5/C9qj
         gv0rMrmrzEpW5i+vBnuTHn+nTuntxIHraJ9TVfdlfoQBGhDznLrtQnqh9ajIqfZG2dcD
         ZJnhPrDLCBAfDuEPhJBzqjIG9cG3OjUTeY4YSJscNAT+nZ0g5+IUhi0C72o44fts6rFu
         MMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446490; x=1780051290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WB8E6xUBrMkQP8ebx8+gCpC7rvCJlL/tAjTiX9u35Zc=;
        b=KG/BM4APB2skYOvm28Ts3JqdUPt7QSnq2TRX2KWS75uW3WJkIdNERLZPV8P2AJhVey
         u0GifExLVKI68zhYKlQcCcXLCsj58heaxy1tDb3gM2rFhfcz5GFoRDUZ9WDs/DxkNhOS
         pmn0xaEP8/beU3pButZYLG0qxbaAlP8AAVL8/QbvOLGun0mybqCdEpezNZ3QKSngG+lW
         ZHhptyCOSOuRUfMwwtJyaMYRGcK+eM1Sgpol5ErsTC3ysUKEIbKKr7rSQQLRHyq9A1GG
         6yhfr7LepYX7YqYp7qax+/gXeM7yShpK3lMo8WAvF37FnytlrKnmi14JbqINlQWfnD/X
         NadQ==
X-Gm-Message-State: AOJu0YwFf4mDT+odh9CXRp4L+bsg7ffSf2Oy5Hl70uIssiQSABLHMLfp
	bqDwgkFYKU0aHo4kps5aNzvP6AodfWYLj2G2GzdXwozvlNDSIFiA3Oqwj+xQjg==
X-Gm-Gg: Acq92OFK/+fyctCZfup414QKbnesBDaR5Oo5gIT0mDn8HI3ej48YtLD8vXBmUXOwF4/
	+UH+C0u1cA3s8UnyFdZH1GkANe5jOT+g3lTnbvKw8spRysWx4Csd9EUBcGarilXoIgHUbtiIr5h
	RYLPxL2DR1WZ3y355vRs+Vlv/iHWf8RWaosVSttD/+cnFY5ca/tpykSXQqcYAG/uAzZVOd44jwJ
	nERhyaxvGt31zk00StaRuVNVekPcpGFnlSd2ISpS0B3VzRQ242wKbl+5atXc2ymVkH+tTtA10h3
	kXRXlJHyg9cbCaQZDHr17G3Z+dnNHpTPnKAQMQ/cmcNtZnGDfXLP91bCD7VhmEcF57ByVHtOM16
	YVGYZJZ+l/5XBeEht/pwjVWU+4zbC54qokNf9d0OedvZWBgKyct2dQ5xKmAKZ1qR4/4zAKZJN+N
	J8iybhZTSTYmrATjwTcIiSMMaH4pexlxexOIA3+Q==
X-Received: by 2002:a05:6a20:7350:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3b328c7077amr3337167637.5.1779446489981;
        Fri, 22 May 2026 03:41:29 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:9a21:4fdc:c1a5:7a8e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85200c3feesm1282942a12.0.2026.05.22.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:41:29 -0700 (PDT)
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
Subject: [PATCH v2 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Fri, 22 May 2026 18:40:17 +0800
Message-Id: <20260522104017.1668638-4-lipengfei28@xiaomi.com>
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

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
  Functional selftest verifying:
  - stackmap tracefs nodes exist
  - enabling stackmap + stacktrace produces stack_id events
  - stack_map_stat shows non-zero successes and zero drops
  - reset clears entries when tracing is stopped
  - reset is rejected (-EBUSY) while tracing is active
  Uses an EXIT trap to restore options/stackmap and options/stacktrace
  on any exit path.

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
 Documentation/trace/ftrace-stackmap.rst       | 145 +++++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 100 ++++++++++++
 tools/tracing/stackmap_dump.py                | 150 ++++++++++++++++++
 4 files changed, 396 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100755 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100755 tools/tracing/stackmap_dump.py

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..1230d44d1d23
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,145 @@
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
+    Statistics: entry count, hits, drops, and hit rate.
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
+Performance
+===========
+
+Typical results on ARM64 Android device (function tracer, 2 seconds):
+
+- Unique stacks: ~3000
+- Hit rate: 84-98% (depends on workload diversity)
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
new file mode 100755
index 000000000000..34e4e31ff7a1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
@@ -0,0 +1,100 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap basic functionality
+# requires: stack_map options/stackmap
+
+# Test that ftrace stackmap deduplication works:
+# 1. Enable stackmap + stacktrace options
+# 2. Run function tracer briefly
+# 3. Verify stack_map has entries
+# 4. Verify stack_map_stat shows successes and zero drops
+# 5. Verify trace contains <stack_id> events
+# 6. Verify reset works when tracing is stopped
+# 7. Verify reset is rejected (-EBUSY) while tracing is active
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
+echo nop > current_tracer
+echo 0 > options/stackmap
+
+# Check stack_map_stat has entries (default empty to avoid [: too many args)
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries:=0}"
+if [ "$entries" -eq 0 ]; then
+    fail "stackmap has zero entries after tracing"
+fi
+
+# Check successes > 0
+successes=$(cat stack_map_stat | grep "^successes:" | awk '{print $2}')
+: "${successes:=0}"
+if [ "$successes" -eq 0 ]; then
+    fail "stackmap has zero successes"
+fi
+
+# Check drops == 0 (pool should be large enough for 1s trace)
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
+# Check trace has stack_id events
+count=$(grep -c "stack_id" trace || true)
+if [ "$count" -eq 0 ]; then
+    fail "trace has no <stack_id> events"
+fi
+
+# Test reset (tracing must be stopped — disable_tracing was called above)
+echo 0 > stack_map
+entries_after=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries_after:=-1}"
+if [ "$entries_after" -ne 0 ]; then
+    fail "stackmap reset did not clear entries (got $entries_after)"
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
+echo "stackmap basic test passed: $entries unique stacks, $successes successes, $drops drops"
+exit 0
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..fc5d0c9cf0af
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
+    if version not in (1, 2):
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

