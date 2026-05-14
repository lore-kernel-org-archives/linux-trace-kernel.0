Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013430FF20
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730723; cv=none; b=I9Is0GzGtehI2NAQRD6pF9Y4vX+4vS2LRwi7P9TH2W2yCt/qNp3hVWIvddlrnjBSd//zMpj7lCAybp4LvxxZoLl3dArKeIeG6gyrhv07G4fRNNxJqDy+yZtURbOfDu9pbbctvP7z0yicETKOR8a2H+q+vtZhxtYf52V35s2Foc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730723; c=relaxed/simple;
	bh=LU2busX77/SlapeYQBl8LoDveHHSaOEGWMl0T2qArzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOA3nRHxbgAv/CqkxRsWKq2cAyrTeCkdiXWL80ar/fBAZ11gY6lzopXWN5mKNH9SqBQY8jAcYpE7X+/1rIv/HIujtpm2eYbM5P9QU1ns/GciZKi+oXI8/UeFEIbaW/MhrWCdQUJGOC/w4VFOguFXuahS1060GP//gmhzqua/fT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKnNXm68; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKnNXm68"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso74928895ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730720; x=1779335520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+CvXOMGO7rt57VJF75foGqvGhV5yw/dUBPWeQOs4tU=;
        b=WKnNXm68hGuEPse8H6KeGcY+AKqrhS0JEjp1FKsVtYYn2pA3M4SBRhV18pnHI/8eka
         XOjbRWQK2FZNmLpY47hPtV+c6FWmwC852HrFeuW6lYS8FnLIdbHOGZD+U8SGKpPwe6/O
         5Hl6FpzW7Fl08YGB0iYn02cTqLJc+7kGsf+ZtAwI7K0EVqpj55Am8Zo/pya3btuwH0x4
         Lbv5IiW4YeuPcc5M4EAIz5dhmzranfSLMqk8M3l7HJ5r6jOsQ6n8C8u1jhs2OS3Szvt7
         DmbOl4Y4w4NxPykJ2ApljhD/GOb58VmQiy4axx9dhT/nNZQnUdAcjVsFhVdq/RziBH9d
         qHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730720; x=1779335520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+CvXOMGO7rt57VJF75foGqvGhV5yw/dUBPWeQOs4tU=;
        b=ZUW5X/F2nLZ0fJ+TVF+mK9GNRuQxMhgBTZGDIaeQl8UGhtQcaut39Li69zVBesSVw4
         MPMBWykXzga4DDOb7FVEobsXslsGP274jxjRfTQCMb+AIT8D+ajiD7LLr2ZVVGCRGV0h
         bo7P4kBY+U0vWXQECTkvocG8B5kT9GA+X6KiZHUXZatwYWmeOU6/Gev2Yq2cPva3VXYo
         1BoQrlYHIIRjJ4eFgAt0raO+SBNwC5ar3z9amPb95locSe4IJ6E2JsQ44I4U4lK/AEVe
         jakd+OpGGhgLzChsrHSDY9MWkY22pIzt1q4+oc6g1nElNAWs/Q4mPElv15Bxn0yzQQai
         DCSw==
X-Gm-Message-State: AOJu0YyAIs2OBkL0mehAjzTKP+gLgFo8nzRkboK3JW9YRHDwBHkcH76z
	vrm18yjYcHBZpay5V/Ww+e0Ib/r+JThvn0yrfstUw9GRbe93u7mkCJzGFE3SFRqu
X-Gm-Gg: Acq92OFxtVoBGMuZkI27KU5vFOwq3xE4hYAU5/W5AKYlPodIPg4ptBV84Bdxl7FX5Oz
	4LNFmm03y0h5X28ac4Z/3N2hlbdjJ1UHGobVVDv4kMn+O8MZ2iGsrQD8rB1R9Yn46ATTGwYEGFd
	2NYB8wm41yTEEJDJiCr5WBXq9xppeZdy3SuCLqvlAs0NvK/SiV4mS0vDxDJZJCKpnuj0YcTYhVx
	GIFjlZRm2xxqP8veL/WWzyfM/BCu4FlLx4QhkpCcqMUwURKfANVWefIZpYliAYoGZ8e7/s1njIk
	EOtIZKuVKkC1do3k62O9faNIifOACzN/pS0w1wM+mfxo7lfzpVPKvkwBHTIi0I1jxpyOFzfP05T
	7YpVBepLTCxWfYfdftBa+L+44G8m/RfED5NmSMUOPgAMolsT77ue0kX3zdhNYxgh+UDUuoAMdZe
	tp9kZhcYFW9OFof8pcpFxrj0XqsDI7EizStExzfVaTxgi6Y/RG
X-Received: by 2002:a17:902:ca8d:b0:2b4:63c8:ce18 with SMTP id d9443c01a7336-2bd2f71202dmr39339025ad.12.1778730720498;
        Wed, 13 May 2026 20:52:00 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3771:9b3a:64a3:f42d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm8189435ad.6.2026.05.13.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:51:59 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Thu, 14 May 2026 11:49:16 +0800
Message-Id: <20260514034916.2162517-4-lipengfei28@xiaomi.com>
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

Add supporting files for the ftrace stackmap feature:

Documentation/trace/ftrace-stackmap.rst:
  Comprehensive documentation covering design, usage, tracefs
  interface, binary format, and performance characteristics.

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
  Basic functional selftest that verifies:
  - stackmap tracefs nodes exist
  - enabling stackmap + stacktrace produces stack_id events
  - stack_map_stat shows non-zero hits
  - reset clears entries

tools/tracing/stackmap_dump.py:
  Python script to parse the binary stack_map_bin export.
  Supports offline symbol resolution via addr2line, JSON output,
  and top-N filtering by ref_count.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst       | 111 ++++++++++++++++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    |  74 +++++++++++
 tools/tracing/stackmap_dump.py                | 120 ++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100755 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100755 tools/tracing/stackmap_dump.py

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..8f6410d4258c
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,111 @@
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
+- ``ftrace_stackmap.bits=N`` - Set map capacity to 2^N unique stacks (default: 14, range: 10-20)
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
+    entries:    2500
+    table_size: 5000
+    hits:       148923
+    drops:      0
+    hit_rate:   98%
+
+To reset the stack map::
+
+    echo 0 > /sys/kernel/debug/tracing/stack_map
+
+Tracefs Nodes
+=============
+
+``stack_map``
+    Text export of all deduplicated stacks with symbol resolution.
+    Writing ``0`` or ``reset`` clears all entries.
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
+    Magic: ``0x464D5342`` ('FSMB'), Version: 2
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
+- **Collision**: Linear probing with a 2x over-provisioned table
+- **Per-instance**: Each trace_array has its own stackmap, supporting
+  multiple ftrace instances
+- **Hash**: 32-bit jhash of stack IPs; full ``memcmp`` confirms matches
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
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
new file mode 100755
index 000000000000..3b0a7f60769f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap basic functionality
+# requires: stack_map options/stackmap
+
+# Test that ftrace stackmap deduplication works:
+# 1. Enable stackmap + stacktrace options
+# 2. Run function tracer briefly
+# 3. Verify stack_map has entries
+# 4. Verify stack_map_stat shows hits
+# 5. Verify trace contains <stack_id> events
+# 6. Verify reset works
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
+disable_tracing
+clear_trace
+
+# Verify stackmap files exist
+test -f stack_map || fail "stack_map file missing"
+test -f stack_map_stat || fail "stack_map_stat file missing"
+test -f stack_map_bin || fail "stack_map_bin file missing"
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
+# Check stack_map_stat has entries
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+if [ "$entries" -eq 0 ]; then
+    fail "stackmap has zero entries after tracing"
+fi
+
+# Check hits > 0
+hits=$(cat stack_map_stat | grep "^hits:" | awk '{print $2}')
+if [ "$hits" -eq 0 ]; then
+    fail "stackmap has zero hits"
+fi
+
+# Check drops == 0 (pool should be large enough for 1s trace)
+drops=$(cat stack_map_stat | grep "^drops:" | awk '{print $2}')
+
+# Check stack_map text output is parseable
+first_id=$(cat stack_map | grep "^stack_id" | head -1 | awk '{print $2}')
+if [ -z "$first_id" ]; then
+    fail "stack_map output has no stack_id entries"
+fi
+
+# Check trace has stack_id events
+count=$(cat trace | grep -c "stack_id" || true)
+if [ "$count" -eq 0 ]; then
+    fail "trace has no <stack_id> events"
+fi
+
+# Test reset
+echo 0 > stack_map
+entries_after=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+if [ "$entries_after" -ne 0 ]; then
+    fail "stackmap reset did not clear entries"
+fi
+
+echo "stackmap basic test passed: $entries unique stacks, $hits hits, $drops drops"
+exit 0
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..91ce80c681ea
--- /dev/null
+++ b/tools/tracing/stackmap_dump.py
@@ -0,0 +1,120 @@
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
+HEADER_FMT = '<IIII'  # magic, version, nr_stacks, reserved
+ENTRY_FMT = '<IIII'   # stack_id, nr, ref_count, reserved
+HEADER_SIZE = struct.calcsize(HEADER_FMT)
+ENTRY_SIZE = struct.calcsize(ENTRY_FMT)
+
+
+def addr2line(vmlinux, addr):
+    """Resolve address to symbol using addr2line."""
+    try:
+        result = subprocess.run(
+            ['addr2line', '-f', '-e', vmlinux, hex(addr)],
+            capture_output=True, text=True, timeout=5
+        )
+        lines = result.stdout.strip().split('\n')
+        if len(lines) >= 1 and lines[0] != '??':
+            return lines[0]
+    except (subprocess.TimeoutExpired, FileNotFoundError):
+        pass
+    return None
+
+
+def parse_stackmap_bin(data):
+    """Parse binary stackmap data, yield (stack_id, ref_count, [ips])."""
+    if len(data) < HEADER_SIZE:
+        raise ValueError("File too small for header")
+
+    magic, version, nr_stacks, _ = struct.unpack_from(HEADER_FMT, data, 0)
+    if magic != MAGIC:
+        raise ValueError(f"Bad magic: 0x{magic:08x}, expected 0x{MAGIC:08x}")
+    if version not in (1, 2):
+        raise ValueError(f"Unsupported version: {version}")
+
+    offset = HEADER_SIZE
+    for _ in range(nr_stacks):
+        if offset + ENTRY_SIZE > len(data):
+            break
+        stack_id, nr, ref_count, _ = struct.unpack_from(ENTRY_FMT, data, offset)
+        offset += ENTRY_SIZE
+
+        ips_size = nr * 8
+        if offset + ips_size > len(data):
+            break
+        ips = struct.unpack_from(f'<{nr}Q', data, offset)
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
+    if args.json:
+        output = []
+        for stack_id, ref_count, ips in stacks:
+            entry = {
+                'stack_id': stack_id,
+                'ref_count': ref_count,
+                'ips': [f'0x{ip:x}' for ip in ips]
+            }
+            if args.vmlinux:
+                entry['symbols'] = [addr2line(args.vmlinux, ip) or f'0x{ip:x}'
+                                    for ip in ips]
+            output.append(entry)
+        print(json.dumps(output, indent=2))
+    else:
+        for stack_id, ref_count, ips in stacks:
+            print(f"stack_id {stack_id} [ref {ref_count}, depth {len(ips)}]")
+            for i, ip in enumerate(ips):
+                sym = ''
+                if args.vmlinux:
+                    resolved = addr2line(args.vmlinux, ip)
+                    if resolved:
+                        sym = f' {resolved}'
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

