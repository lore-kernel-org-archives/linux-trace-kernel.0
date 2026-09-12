Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799D41D12B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202390; cv=none; b=cy0BfUj9GuwNMy5RfFhrulVaqkmveUaSH0n7hEMkadS2EX/yQYBHpEAGg4MTfdR2nHIQWE1qHKjUt/FiQL2WvnmvrlQ+nwafPOCgzlrhVEtAtXcCgLPLkfNC+g1RmkmZNE7I0H8eM4R6kaa0VLtl0edK05FJzbeiSFgCuPGA1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202390; c=relaxed/simple;
	bh=q7wl1vA7DEBn3ekTpIFO+BAwyTfRRP1mHsjovaETwDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBbbJg/Obz55p8m1zDct8fPBvw1g/A1y+UMlQcuoNauKp5MV0lhyKpftJD987o8sPtyEt5n04r0kWDdNH/2Or4z+Sz6ja6PUCLu1BGJ00EwxvroVjC7EWLT7f5cMx4HELt4Xcegvi16BZGOG1oiTBfMmQDDmUlCkLwQdzYxEWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHsnZgAR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHsnZgAR"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so216956a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202387; x=1789807187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgiqQEZlxF00jBXvXXZ5S0eCoSzkO165Sa7y5QjVVCo=;
        b=DHsnZgARi5GcW/h+pPBZelhGKYewOaqHsKs7XWZPVvF65s2nGdj0bXeUAQFSuCxIVI
         p2HXuE1XZpIc5CU9VLFmCtBY6Q8Ym8NP/8lPf0NHvoQoyzDcbeCJsvjS/IW72+l7KnZy
         NXR/SgDCUImnP/NLNGYbKFNkw/wN4Km7zddiB2exdaBardW9abwymGh5s9ETQP9s4seD
         Se4NuIgLlmUe6TmHEnOdXdWWaa6wsnVc1Ml2NwglpobopQ7ofL49Es16NfcU1PglgdmP
         hf3nDOf+IOdkqejLgFDMNM/BCbjHdxVqR9JNAOGUWreR63J+lKGBDyuk95FlSM1J3AW1
         v+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202387; x=1789807187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgiqQEZlxF00jBXvXXZ5S0eCoSzkO165Sa7y5QjVVCo=;
        b=lkzw6nFC7mXHegEUHr9l6q/gweTt6NUmsU+aLaeq+bHVjNFCzQmyKi68I51V78IZ6E
         jdxHdD5fafiqoC4uoV/bNC0/EF7egnSV0K71pZsPtB7txmhtT8s9VFaxx57MfHEzv7RD
         7VgYSI2/it1GK9EjJEZdVEUyq5L4q5Uke+hVYEgalQKZxswLRjQWeQwv+/bnbxzG+sa8
         aNHkfa1NQ1LEiyjEebP7lsFURAc9sMnuYiWFSyUOss7tpIv4RUx7YiBlMvN1PUneAtB+
         9Uq/2x33lqiEtP+wkJqaR6Jg9MlR7F6z2dbUN/gIFFqH+Em4PGi5tNOk1ETk/YQ7zz+G
         eTVw==
X-Forwarded-Encrypted: i=1; AKwUvBwxP+tE+Ra/mVtl4ZiwLijBbMOG6Qfdfi4/r2VEKcFNiiiYjHrqsARlF8Lwxljp+tlHUXTuUwmWaEPOMx7P9HZND2E=@vger.kernel.org
X-Gm-Message-State: AFuF++kt/9kT+VzPXhvbefbwGcZWHTF7cQJpnihFtBnqxrPe7bAtXBoe
	w/zFJjGi2fRyksv5medWLVLBgM/DI37JzckAMCRC9/P3j+sjBp5ZVFPy
X-Gm-Gg: AYBFou1aZtadywNCc7l0P7zZRfliYzlL9cfefjzo2waU+0wPxcy19caoprHmkt2ZKcF
	SIZLu6+hFx5w8Tn6wdHzkNqK5QZjPKJVzBXdFWDwdQOtL3VgRQKpetPprCPaiLNGADfoPasARlb
	o2r8M+y41JmK+PxfzYL5p6DX+2WYy50C8ydDdyttlW3g63H01p00OnQ0ZK311CzvjxNU+csfoXn
	m+5gQYYcqRlai8DdrodSuDLdQFvPMN9EYidOj8YowSpcffeyi4CMZnYlsgrDHbrlqbku2ixmJ99
	FhFJ22RIE1CaznxtLCFtAw2xYrxTQ7qFmeq/mx9t/ANWYcTEmN22+vNPVrlFx76ImNQ+jYKF7dT
	ffiDjSJsXBPfI9GYP/yFPKIZeTZmwQSBFV7Zv77jzawcIEdRy6myS8neiQyp/sU5lsFLouvRTEt
	xndV0/u6UZkeIRb5B2Ot6CuUHKj8pV05C2Xw0f/OWgsnI9z89HbyA118zCKIKbXPpSLem/gdumC
	RevZDjtFhbTN1yPsJo8t+Pi0tnVOJUsBUDTcVsvD8p9bPt1OYw=
X-Received: by 2002:a17:90b:5704:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39dbc69cf98mr3379916a91.15.1789202386804;
        Sat, 12 Sep 2026 01:39:46 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:45 -0700 (PDT)
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
Subject: [RFC PATCH v7 07/10] tools/tracing: add a parser for the stackmap binary export
Date: Sat, 12 Sep 2026 16:37:50 +0800
Message-Id: <20260912083753.3426176-8-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add stackmap_dump.py to decode native-endian version 1 stack_map_bin
streams from a file or stdin and print text or JSON.

Parse incrementally with bounded reads. Validate the header count,
require stack depths from 1 through 64, reject trailing bytes, and
report malformed input without a traceback.

--top rejects negative values, keeps zero as unlimited, and selects a
stable top N with an O(N) heap instead of materializing and sorting the
whole input. Normal text output is emitted record by record.

JSON output is staged in a SpooledTemporaryFile so malformed later
records or symbolization failures leave stdout empty. The spool keeps up
to 1 MiB in memory and then spills to disk.

With --vmlinux, addr2line receives addresses on stdin in batches bounded
by both 128 records and 128 unique addresses. This avoids ARG_MAX and
bounds retained records even when addresses repeat. Document that
KASLR-slid core addresses and module addresses are unsupported.

Install the script from the tools/tracing install target and add parser,
CLI, streaming, memory-bound and error-path tests. Report totals as
stack records rather than strict unique stacks.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 tools/tracing/Makefile                    |  17 +-
 tools/tracing/stackmap_dump.py            | 354 +++++++++++++++
 tools/tracing/tests/test_stackmap_dump.py | 498 ++++++++++++++++++++++
 3 files changed, 866 insertions(+), 3 deletions(-)
 create mode 100755 tools/tracing/stackmap_dump.py
 create mode 100644 tools/tracing/tests/test_stackmap_dump.py

diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
index 95e485f12d97..8c2be033e360 100644
--- a/tools/tracing/Makefile
+++ b/tools/tracing/Makefile
@@ -1,11 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 
+INSTALL ?= install
+BINDIR ?= /usr/bin
+PYTHON ?= python3
+
 all: latency rtla
 
+check:
+	$(PYTHON) -m unittest discover -s tests -v
+
 clean: latency_clean rtla_clean
 
-install: latency_install rtla_install
+install: latency_install rtla_install stackmap_install
+
+stackmap_install:
+	$(call QUIET_INSTALL,stackmap_dump.py)$(INSTALL) -D -m 755 stackmap_dump.py \
+		$(DESTDIR)$(BINDIR)/stackmap_dump.py
 
 latency:
 	$(call descend,latency)
@@ -25,5 +36,5 @@ rtla_install:
 rtla_clean:
 	$(call descend,rtla,clean)
 
-.PHONY: all install clean latency latency_install latency_clean \
-	rtla rtla_install rtla_clean
+.PHONY: all check install clean stackmap_install latency latency_install \
+	latency_clean rtla rtla_install rtla_clean
diff --git a/tools/tracing/stackmap_dump.py b/tools/tracing/stackmap_dump.py
new file mode 100755
index 000000000000..cf461b49cee7
--- /dev/null
+++ b/tools/tracing/stackmap_dump.py
@@ -0,0 +1,354 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+stackmap_dump.py - Parse and display ftrace stack_map_bin binary export.
+
+Usage:
+    # Read straight from the device over a pipe
+    adb shell cat /sys/kernel/debug/tracing/stack_map_bin | stackmap_dump.py
+
+    # Or pull the file first and parse it
+    adb pull /sys/kernel/debug/tracing/stack_map_bin /tmp/stack_map.bin
+    python3 stackmap_dump.py /tmp/stack_map.bin
+
+    # With vmlinux when addresses already match its link-time range
+    # (for example, a nokaslr core kernel; modules are not supported)
+    python3 stackmap_dump.py /tmp/stack_map.bin --vmlinux vmlinux
+
+    # JSON output for tooling
+    python3 stackmap_dump.py /tmp/stack_map.bin --json
+"""
+
+import argparse
+import heapq
+import io
+import json
+import struct
+import subprocess
+import sys
+import tempfile
+
+MAGIC = 0x46534D42  # 'FSMB'
+HEADER_SIZE = 16  # 4 x u32
+ENTRY_SIZE = 16   # 4 x u32
+MAX_STACK_DEPTH_V1 = 64
+MAX_STACKS_V1 = 1 << 18
+SYMBOL_BATCH_RECORDS = 128
+SYMBOL_BATCH_ADDRESSES = 128
+SYMBOL_MAX_BATCHES = 64
+SYMBOL_MAX_ADDRESSES = 8192
+JSON_SPOOL_MEMORY_LIMIT = 1 << 20
+COPY_BUFFER_SIZE = 64 << 10
+
+# __ftrace_trace_stack() replaces trampoline addresses with this marker
+# before storing the stack, so the binary export carries it verbatim.
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
+        # Use stdin to avoid ARG_MAX with large address sets.
+        stdin = '\n'.join(hex(a) for a in addrs) + '\n'
+        result = subprocess.run(
+            ['addr2line', '-f', '-e', vmlinux],
+            input=stdin, capture_output=True, text=True, timeout=60
+        )
+    except subprocess.TimeoutExpired as error:
+        raise RuntimeError("addr2line failed: timed out") from error
+    except FileNotFoundError as error:
+        raise RuntimeError("addr2line failed: executable not found") from error
+    except OSError as error:
+        detail = error.strerror or str(error)
+        raise RuntimeError(f"addr2line failed: {detail}") from error
+
+    if result.returncode:
+        detail = result.stderr.strip() or f"exit status {result.returncode}"
+        raise RuntimeError(f"addr2line failed: {detail}")
+
+    lines = result.stdout.splitlines()
+    expected_lines = len(addrs) * 2
+    if (len(lines) != expected_lines or
+            any(not line for line in lines)):
+        raise RuntimeError(
+            "addr2line returned malformed output: "
+            f"expected {expected_lines} non-empty lines, got {len(lines)}")
+
+    symbols = {}
+    for i, addr in enumerate(addrs):
+        function = lines[i * 2]
+        if function != '??':
+            symbols[addr] = function
+    return symbols
+
+
+def read_exact(stream, size, error_message):
+    """Read exactly size bytes from a stream that may return short reads."""
+    chunks = []
+    remaining = size
+    while remaining:
+        chunk = stream.read(remaining)
+        if not chunk:
+            raise ValueError(error_message)
+        chunks.append(chunk)
+        remaining -= len(chunk)
+    return b''.join(chunks)
+
+
+def parse_stackmap_stream(stream):
+    """Yield (stack_id, ref_count, ips) tuples from a binary stream."""
+    header = read_exact(stream, HEADER_SIZE, "File too small for header")
+    endian = detect_endianness(header)
+    header_fmt = f'{endian}IIII'
+    entry_fmt = f'{endian}IIII'
+
+    _magic, version, nr_stacks, _reserved = struct.unpack(header_fmt, header)
+    if version != 1:
+        raise ValueError(f"Unsupported version: {version}")
+    if nr_stacks > MAX_STACKS_V1:
+        raise ValueError(
+            f"Invalid stack count {nr_stacks}: version 1 maximum is "
+            f"{MAX_STACKS_V1}")
+
+    for _ in range(nr_stacks):
+        entry = read_exact(stream, ENTRY_SIZE,
+                           "Truncated stack entry header")
+        stack_id, nr, ref_count, _reserved = struct.unpack(entry_fmt, entry)
+        if nr == 0:
+            raise ValueError(
+                "Invalid stack depth 0: version 1 minimum is 1")
+        if nr > MAX_STACK_DEPTH_V1:
+            raise ValueError(
+                f"Invalid stack depth {nr}: version 1 maximum is "
+                f"{MAX_STACK_DEPTH_V1}")
+
+        ips_data = read_exact(
+            stream, nr * 8,
+            f"Truncated stack IP data for stack_id {stack_id}")
+        ips = struct.unpack(f'{endian}{nr}Q', ips_data)
+        yield stack_id, ref_count, list(ips)
+
+    if stream.read(1):
+        raise ValueError(f"Trailing data after {nr_stacks} stack records")
+
+
+def parse_stackmap_bin(data):
+    """Parse in-memory binary data using the streaming parser."""
+    return list(parse_stackmap_stream(io.BytesIO(data)))
+
+
+def non_negative_int(value):
+    number = int(value)
+    if number < 0:
+        raise argparse.ArgumentTypeError("--top must be non-negative")
+    return number
+
+
+def select_top(records, limit):
+    """Select the largest ref_counts stably using O(limit) space."""
+    heap = []
+    for order, record in enumerate(records):
+        item = (record[1], -order, order, record)
+        if len(heap) < limit:
+            heapq.heappush(heap, item)
+        elif item[:2] > heap[0][:2]:
+            heapq.heapreplace(heap, item)
+
+    heap.sort(key=lambda item: (-item[0], item[2]))
+    return [item[3] for item in heap]
+
+
+def iter_symbol_batches(records):
+    """Group records without exceeding the unique-address limit."""
+    batch = []
+    addresses = set()
+    for record in records:
+        _stack_id, _ref_count, ips = record
+        record_addresses = {
+            ip for ip in ips if ip != FTRACE_TRAMPOLINE_MARKER
+        }
+        if (batch and
+                (len(batch) >= SYMBOL_BATCH_RECORDS or
+                 len(addresses | record_addresses) >
+                 SYMBOL_BATCH_ADDRESSES)):
+            yield batch, addresses
+            batch.clear()
+            addresses.clear()
+        batch.append(record)
+        addresses.update(record_addresses)
+    if batch:
+        yield batch, addresses
+
+
+class RecordRenderer:
+    """Write records incrementally without changing text or JSON formats."""
+
+    def __init__(self, output, json_output, include_symbols):
+        self.output = output
+        self.json_output = json_output
+        self.include_symbols = include_symbols
+        self.count = 0
+
+    @staticmethod
+    def terminal_safe(text):
+        """Escape terminal controls while preserving printable Unicode."""
+        escaped = []
+        for character in text:
+            codepoint = ord(character)
+            if character.isprintable():
+                escaped.append(character)
+            elif codepoint <= 0xff:
+                escaped.append(f'\\x{codepoint:02x}')
+            elif codepoint <= 0xffff:
+                escaped.append(f'\\u{codepoint:04x}')
+            else:
+                escaped.append(f'\\U{codepoint:08x}')
+        return ''.join(escaped)
+
+    @staticmethod
+    def render_ip(ip, symbols):
+        if ip == FTRACE_TRAMPOLINE_MARKER:
+            return TRAMPOLINE_LABEL
+        return symbols.get(ip, f'0x{ip:x}')
+
+    def emit(self, record, symbols):
+        stack_id, ref_count, ips = record
+        if self.json_output:
+            entry = {
+                'stack_id': stack_id,
+                'ref_count': ref_count,
+                'ips': [f'0x{ip:x}' for ip in ips]
+            }
+            if self.include_symbols:
+                entry['symbols'] = [self.render_ip(ip, symbols)
+                                    for ip in ips]
+            encoded = json.dumps(entry, indent=2)
+            indented = '\n'.join(f'  {line}' for line in encoded.splitlines())
+            if self.count == 0:
+                self.output.write('[\n')
+            else:
+                self.output.write(',\n')
+            self.output.write(indented)
+        else:
+            self.output.write(
+                f"stack_id {stack_id} [ref {ref_count}, depth {len(ips)}]\n")
+            for index, ip in enumerate(ips):
+                if ip == FTRACE_TRAMPOLINE_MARKER:
+                    self.output.write(
+                        f"  [{index}] {TRAMPOLINE_LABEL}\n")
+                    continue
+                symbol = symbols.get(ip, '')
+                if symbol:
+                    symbol = f' {self.terminal_safe(symbol)}'
+                self.output.write(f"  [{index}] 0x{ip:x}{symbol}\n")
+            self.output.write('\n')
+        self.count += 1
+
+    def finish(self):
+        if not self.json_output:
+            return
+        if self.count:
+            self.output.write('\n]\n')
+        else:
+            self.output.write('[]\n')
+
+
+def render_records(records, args, output):
+    renderer = RecordRenderer(output, args.json, bool(args.vmlinux))
+    if args.vmlinux:
+        batch_count = 0
+        address_count = 0
+        for batch, addresses in iter_symbol_batches(records):
+            batch_count += 1
+            address_count += len(addresses)
+            if (batch_count > SYMBOL_MAX_BATCHES or
+                    address_count > SYMBOL_MAX_ADDRESSES):
+                raise RuntimeError(
+                    "symbolization work limit exceeded: "
+                    f"maximum {SYMBOL_MAX_BATCHES} batches and "
+                    f"{SYMBOL_MAX_ADDRESSES} addresses")
+            symbols = batch_addr2line(args.vmlinux, list(addresses))
+            for record in batch:
+                renderer.emit(record, symbols)
+    else:
+        for record in records:
+            renderer.emit(record, {})
+    renderer.finish()
+    return renderer.count
+
+
+def main(argv=None, input_file=None, output=None, error=None):
+    parser = argparse.ArgumentParser(description='Parse ftrace stack_map_bin')
+    parser.add_argument('file', nargs='?', default='-',
+                        help="Path to stack_map_bin file, or '-' for stdin "
+                             "(the default)")
+    parser.add_argument(
+        '--vmlinux',
+        help=('Path to vmlinux for symbol resolution; addresses must already '
+              'match vmlinux (for example, nokaslr). KASLR runtime addresses '
+              'and module addresses are not supported. Symbolization is '
+              'limited to 8192 addresses in 64 batches'))
+    parser.add_argument('--json', action='store_true', help='JSON output')
+    parser.add_argument('--top', type=non_negative_int, default=0,
+                        help='Show only top N stacks by ref_count; 0 is unlimited')
+    args = parser.parse_args(argv)
+
+    output = output if output is not None else sys.stdout
+    error = error if error is not None else sys.stderr
+    stream = input_file
+    close_stream = False
+
+    try:
+        # stdin accepts a stack_map_bin stream directly from a pipe.
+        if stream is None:
+            if args.file == '-':
+                stream = sys.stdin.buffer
+            else:
+                stream = open(args.file, 'rb')
+                close_stream = True
+
+        records = parse_stackmap_stream(stream)
+        if args.top:
+            records = select_top(records, args.top)
+        if args.json:
+            with tempfile.SpooledTemporaryFile(
+                    max_size=JSON_SPOOL_MEMORY_LIMIT, mode='w+',
+                    encoding='utf-8') as staged_output:
+                count = render_records(records, args, staged_output)
+                staged_output.seek(0)
+                while True:
+                    chunk = staged_output.read(COPY_BUFFER_SIZE)
+                    if not chunk:
+                        break
+                    output.write(chunk)
+        else:
+            count = render_records(records, args, output)
+    except (ValueError, OSError, RuntimeError) as exception:
+        print(f"error: {exception}", file=error)
+        return 1
+    finally:
+        if close_stream:
+            stream.close()
+
+    print(f"Total: {count} stack records", file=error)
+    return 0
+
+
+if __name__ == '__main__':
+    sys.exit(main())
diff --git a/tools/tracing/tests/test_stackmap_dump.py b/tools/tracing/tests/test_stackmap_dump.py
new file mode 100644
index 000000000000..03769cbc190e
--- /dev/null
+++ b/tools/tracing/tests/test_stackmap_dump.py
@@ -0,0 +1,498 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import importlib.util
+import io
+import json
+import os
+from pathlib import Path
+import struct
+import subprocess
+import sys
+import tempfile
+import unittest
+from unittest import mock
+
+SCRIPT = Path(__file__).resolve().parents[1] / "stackmap_dump.py"
+SPEC = importlib.util.spec_from_file_location("stackmap_dump", SCRIPT)
+stackmap_dump = importlib.util.module_from_spec(SPEC)
+SPEC.loader.exec_module(stackmap_dump)
+
+
+def image(endian="<", version=1, entries=()):
+    data = bytearray(struct.pack(f"{endian}IIII", stackmap_dump.MAGIC,
+                                 version, len(entries), 0))
+    for stack_id, ref_count, ips in entries:
+        data += struct.pack(f"{endian}IIII", stack_id, len(ips),
+                            ref_count, 0)
+        data += struct.pack(f"{endian}{len(ips)}Q", *ips)
+    return bytes(data)
+
+
+class ShortReadInput(io.BytesIO):
+    def read(self, size=-1):
+        if size < 0:
+            raise AssertionError("unbounded read() is not allowed")
+        if size > stackmap_dump.MAX_STACK_DEPTH_V1 * 8:
+            raise AssertionError("read() exceeds one version 1 stack")
+        return super().read(min(size, 3))
+
+
+class StreamingGuardInput(io.BytesIO):
+    def __init__(self, data, first_record_end, output):
+        super().__init__(data)
+        self.first_record_end = first_record_end
+        self.output = output
+
+    def read(self, size=-1):
+        if (self.tell() >= self.first_record_end and
+                "stack_id 1" not in self.output.getvalue()):
+            raise AssertionError("next record read before current output")
+        return super().read(size)
+
+
+class TrackedRecord:
+    live_count = 0
+    max_live_count = 0
+
+    def __init__(self, stack_id, ip=None):
+        self.stack_id = stack_id
+        self.ip = 0x1000 + stack_id if ip is None else ip
+        type(self).live_count += 1
+        type(self).max_live_count = max(type(self).max_live_count,
+                                        type(self).live_count)
+
+    def __iter__(self):
+        return iter((self.stack_id, 1, [self.ip]))
+
+    def __del__(self):
+        type(self).live_count -= 1
+
+
+class StackmapParserTest(unittest.TestCase):
+    def test_little_endian_entry(self):
+        raw = image(entries=[(7, 3, [0x1234, 0x7fffffff])])
+        self.assertEqual(list(stackmap_dump.parse_stackmap_bin(raw)),
+                         [(7, 3, [0x1234, 0x7fffffff])])
+
+    def test_big_endian_entry(self):
+        raw = image(">", entries=[(9, 2, [0xabcdef])])
+        self.assertEqual(list(stackmap_dump.parse_stackmap_bin(raw)),
+                         [(9, 2, [0xabcdef])])
+
+    def test_bad_magic(self):
+        with self.assertRaisesRegex(ValueError, "Bad magic"):
+            list(stackmap_dump.parse_stackmap_bin(b"BAD!" + bytes(12)))
+
+    def test_unknown_version(self):
+        with self.assertRaisesRegex(ValueError, "Unsupported version"):
+            list(stackmap_dump.parse_stackmap_bin(image(version=2)))
+
+    def test_truncated_header(self):
+        with self.assertRaisesRegex(ValueError, "too small for header"):
+            list(stackmap_dump.parse_stackmap_bin(bytes(15)))
+
+    def test_truncated_entry_header(self):
+        raw = struct.pack("<IIII", stackmap_dump.MAGIC, 1, 1, 0)
+        with self.assertRaisesRegex(ValueError, "Truncated stack entry header"):
+            list(stackmap_dump.parse_stackmap_bin(raw))
+
+    def test_truncated_ip_data(self):
+        raw = image(entries=[(1, 1, [0x1234])])[:-1]
+        with self.assertRaisesRegex(ValueError, "Truncated stack IP data"):
+            list(stackmap_dump.parse_stackmap_bin(raw))
+
+    def test_rejects_records_beyond_header_count(self):
+        raw = image(entries=[(1, 1, [0x1234])])
+        raw = bytearray(raw)
+        struct.pack_into("<I", raw, 8, 0)
+        with self.assertRaisesRegex(ValueError, "Trailing data"):
+            stackmap_dump.parse_stackmap_bin(raw)
+
+    def test_cli_reports_malformed_input_without_traceback(self):
+        result = subprocess.run([sys.executable, str(SCRIPT), "-"],
+                                input=b"bad", capture_output=True)
+        stderr = result.stderr.decode()
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn("error: File too small for header", stderr)
+        self.assertNotIn("Traceback", stderr)
+
+    def test_cli_reports_missing_file_without_traceback(self):
+        missing = SCRIPT.parent / "does-not-exist.stackmap"
+        result = subprocess.run([sys.executable, str(SCRIPT), str(missing)],
+                                capture_output=True, text=True)
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn("error:", result.stderr)
+        self.assertNotIn("Traceback", result.stderr)
+
+    def test_cli_reports_addr2line_failure(self):
+        raw = image(entries=[(1, 2, [0x1234])])
+        with tempfile.TemporaryDirectory() as temp_dir:
+            addr2line = Path(temp_dir) / "addr2line"
+            addr2line.write_text(
+                "#!/bin/sh\necho controlled addr2line failure >&2\nexit 23\n",
+                encoding="utf-8")
+            addr2line.chmod(0o755)
+            env = os.environ.copy()
+            env["PATH"] = temp_dir
+            result = subprocess.run(
+                [sys.executable, str(SCRIPT), "-", "--vmlinux", "vmlinux"],
+                input=raw, capture_output=True, env=env)
+        stderr = result.stderr.decode()
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn(
+            "error: addr2line failed: controlled addr2line failure", stderr)
+        self.assertNotIn("Traceback", stderr)
+
+    def test_cli_reports_truncated_addr2line_output(self):
+        raw = image(entries=[(1, 2, [0x1234])])
+        with tempfile.TemporaryDirectory() as temp_dir:
+            addr2line = Path(temp_dir) / "addr2line"
+            addr2line.write_text(
+                "#!/bin/sh\nprintf 'resolved_function\\n'\n",
+                encoding="utf-8")
+            addr2line.chmod(0o755)
+            env = os.environ.copy()
+            env["PATH"] = temp_dir
+            result = subprocess.run(
+                [sys.executable, str(SCRIPT), "-", "--vmlinux", "vmlinux"],
+                input=raw, capture_output=True, env=env)
+        stderr = result.stderr.decode()
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn("error: addr2line returned malformed output", stderr)
+        self.assertNotIn("Traceback", stderr)
+
+    def test_cli_accepts_unresolved_addr2line_output(self):
+        raw = image(entries=[(1, 2, [0x1234])])
+        with tempfile.TemporaryDirectory() as temp_dir:
+            addr2line = Path(temp_dir) / "addr2line"
+            addr2line.write_text(
+                "#!/bin/sh\nprintf '??\\n??:0\\n'\n",
+                encoding="utf-8")
+            addr2line.chmod(0o755)
+            env = os.environ.copy()
+            env["PATH"] = temp_dir
+            result = subprocess.run(
+                [sys.executable, str(SCRIPT), "-", "--vmlinux", "vmlinux"],
+                input=raw, capture_output=True, env=env)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertIn(b"[0] 0x1234", result.stdout)
+
+    def test_cli_rejects_trailing_data(self):
+        raw = image(entries=[(1, 1, [0x1234])]) + b"junk"
+        result = subprocess.run([sys.executable, str(SCRIPT), "-"],
+                                input=raw, capture_output=True)
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn(b"error: Trailing data", result.stderr)
+
+    def test_cli_accepts_valid_input(self):
+        raw = image(entries=[(1, 2, [0x1234])])
+        result = subprocess.run([sys.executable, str(SCRIPT), "-", "--json"],
+                                input=raw, capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertIn(b'"stack_id": 1', result.stdout)
+
+    def test_stream_parser_handles_short_reads(self):
+        raw = image(entries=[(7, 3, [0x1234, 0x5678])])
+        self.assertEqual(list(stackmap_dump.parse_stackmap_stream(
+            ShortReadInput(raw))), [(7, 3, [0x1234, 0x5678])])
+
+    def test_rejects_stack_depth_above_version_1_limit(self):
+        raw = (struct.pack("<IIII", stackmap_dump.MAGIC, 1, 1, 0) +
+               struct.pack("<IIII", 7, 65, 1, 0))
+        with self.assertRaisesRegex(ValueError, "stack depth.*64"):
+            list(stackmap_dump.parse_stackmap_stream(io.BytesIO(raw)))
+
+    def test_accepts_stack_depth_at_version_1_limit(self):
+        ips = list(range(stackmap_dump.MAX_STACK_DEPTH_V1))
+        raw = image(entries=[(7, 1, ips)])
+        self.assertEqual(stackmap_dump.parse_stackmap_bin(raw), [(7, 1, ips)])
+
+    def test_rejects_stack_count_above_version_1_limit(self):
+        raw = struct.pack("<IIII", stackmap_dump.MAGIC, 1,
+                          (1 << 18) + 1, 0)
+        with self.assertRaisesRegex(ValueError, "stack count.*262144"):
+            list(stackmap_dump.parse_stackmap_stream(io.BytesIO(raw)))
+
+    def test_accepts_stack_count_at_version_1_limit(self):
+        raw = struct.pack("<IIII", stackmap_dump.MAGIC, 1, 1 << 18, 0)
+        with self.assertRaisesRegex(ValueError,
+                                    "Truncated stack entry header"):
+            list(stackmap_dump.parse_stackmap_stream(io.BytesIO(raw)))
+
+    def test_cli_rejects_negative_top(self):
+        raw = image(entries=[(1, 2, [0x1234])])
+        result = subprocess.run(
+            [sys.executable, str(SCRIPT), "-", "--top", "-1"],
+            input=raw, capture_output=True)
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn(b"--top must be non-negative", result.stderr)
+
+    def test_cli_top_zero_remains_unlimited(self):
+        raw = image(entries=[(1, 2, [0x1000]), (2, 1, [0x2000])])
+        result = subprocess.run(
+            [sys.executable, str(SCRIPT), "-", "--json", "--top", "0"],
+            input=raw, capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertEqual([entry["stack_id"] for entry in
+                          json.loads(result.stdout)], [1, 2])
+
+    def test_cli_top_n_is_descending_and_stable_for_ties(self):
+        raw = image(entries=[(1, 3, [0x1000]),
+                             (2, 9, [0x2000]),
+                             (3, 9, [0x3000]),
+                             (4, 9, [0x4000]),
+                             (5, 1, [0x5000])])
+        result = subprocess.run(
+            [sys.executable, str(SCRIPT), "-", "--json", "--top", "2"],
+            input=raw, capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertEqual([(entry["stack_id"], entry["ref_count"])
+                          for entry in json.loads(result.stdout)],
+                         [(2, 9), (3, 9)])
+
+    def test_rejects_zero_stack_depth(self):
+        raw = (struct.pack("<IIII", stackmap_dump.MAGIC, 1, 1, 0) +
+               struct.pack("<IIII", 7, 0, 1, 0))
+        with self.assertRaisesRegex(ValueError, "stack depth.*minimum is 1"):
+            list(stackmap_dump.parse_stackmap_stream(io.BytesIO(raw)))
+
+    def test_cli_empty_text_output_format(self):
+        result = subprocess.run([sys.executable, str(SCRIPT), "-"],
+                                input=image(), capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertEqual(result.stdout, b"")
+        self.assertEqual(result.stderr, b"Total: 0 stack records\n")
+
+    def test_cli_empty_json_output_format(self):
+        result = subprocess.run([sys.executable, str(SCRIPT), "-", "--json"],
+                                input=image(), capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertEqual(result.stdout, b"[]\n")
+        self.assertEqual(result.stderr, b"Total: 0 stack records\n")
+
+    def test_cli_multi_record_text_output_format(self):
+        raw = image(entries=[(7, 3, [0x1234,
+                                      stackmap_dump.FTRACE_TRAMPOLINE_MARKER]),
+                             (9, 1, [0xabcd])])
+        result = subprocess.run([sys.executable, str(SCRIPT), "-"],
+                                input=raw, capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        self.assertEqual(
+            result.stdout.decode(),
+            "stack_id 7 [ref 3, depth 2]\n"
+            "  [0] 0x1234\n"
+            "  [1] [FTRACE TRAMPOLINE]\n\n"
+            "stack_id 9 [ref 1, depth 1]\n"
+            "  [0] 0xabcd\n\n")
+        self.assertEqual(result.stderr, b"Total: 2 stack records\n")
+
+    def test_cli_multi_record_json_output_format(self):
+        raw = image(entries=[(7, 3, [0x1234]), (9, 1, [0xabcd])])
+        result = subprocess.run([sys.executable, str(SCRIPT), "-", "--json"],
+                                input=raw, capture_output=True)
+        self.assertEqual(result.returncode, 0, result.stderr.decode())
+        expected = json.dumps([
+            {"stack_id": 7, "ref_count": 3, "ips": ["0x1234"]},
+            {"stack_id": 9, "ref_count": 1, "ips": ["0xabcd"]},
+        ], indent=2) + "\n"
+        self.assertEqual(result.stdout.decode(), expected)
+        self.assertEqual(result.stderr, b"Total: 2 stack records\n")
+
+    def test_vmlinux_text_output_format(self):
+        raw = image(entries=[(7, 3, [
+            0x1000, 0x2000, stackmap_dump.FTRACE_TRAMPOLINE_MARKER])])
+        output = io.StringIO()
+        error = io.StringIO()
+        with mock.patch.object(stackmap_dump, "batch_addr2line",
+                               return_value={0x1000: "resolved"}):
+            result = stackmap_dump.main(
+                ["--vmlinux", "vmlinux"], input_file=io.BytesIO(raw),
+                output=output, error=error)
+
+        self.assertEqual(result, 0, error.getvalue())
+        self.assertEqual(
+            output.getvalue(),
+            "stack_id 7 [ref 3, depth 3]\n"
+            "  [0] 0x1000 resolved\n"
+            "  [1] 0x2000\n"
+            "  [2] [FTRACE TRAMPOLINE]\n\n")
+        self.assertEqual(error.getvalue(), "Total: 1 stack records\n")
+
+    def test_vmlinux_json_output_format(self):
+        raw = image(entries=[(7, 3, [
+            0x1000, 0x2000, stackmap_dump.FTRACE_TRAMPOLINE_MARKER])])
+        output = io.StringIO()
+        error = io.StringIO()
+        with mock.patch.object(stackmap_dump, "batch_addr2line",
+                               return_value={0x1000: "resolved"}):
+            result = stackmap_dump.main(
+                ["--json", "--vmlinux", "vmlinux"],
+                input_file=io.BytesIO(raw), output=output, error=error)
+
+        expected = json.dumps([{
+            "stack_id": 7,
+            "ref_count": 3,
+            "ips": ["0x1000", "0x2000", "0x7fffffff"],
+            "symbols": ["resolved", "0x2000", "[FTRACE TRAMPOLINE]"],
+        }], indent=2) + "\n"
+        self.assertEqual(result, 0, error.getvalue())
+        self.assertEqual(output.getvalue(), expected)
+        self.assertEqual(error.getvalue(), "Total: 1 stack records\n")
+
+    def test_json_malformed_later_record_leaves_stdout_empty(self):
+        raw = image(entries=[(1, 2, [0x1000]), (2, 1, [0x2000])])[:-1]
+        output = io.StringIO()
+        error = io.StringIO()
+
+        result = stackmap_dump.main(["--json"], input_file=io.BytesIO(raw),
+                                    output=output, error=error)
+
+        self.assertEqual(result, 1)
+        self.assertEqual(output.getvalue(), "")
+        self.assertIn("error: Truncated stack IP data", error.getvalue())
+
+    def test_json_later_addr2line_failure_leaves_stdout_empty(self):
+        raw = image(entries=[(stack_id, 1, [0x1000 + stack_id])
+                             for stack_id in range(129)])
+        output = io.StringIO()
+        error = io.StringIO()
+        with mock.patch.object(
+                stackmap_dump, "batch_addr2line",
+                side_effect=[{}, RuntimeError("addr2line failed: later batch")]):
+            result = stackmap_dump.main(
+                ["--json", "--vmlinux", "vmlinux"],
+                input_file=io.BytesIO(raw), output=output, error=error)
+
+        self.assertEqual(result, 1)
+        self.assertEqual(output.getvalue(), "")
+        self.assertEqual(error.getvalue(),
+                         "error: addr2line failed: later batch\n")
+
+    def test_text_streams_before_reading_the_next_record(self):
+        raw = image(entries=[(1, 2, [0x1000]), (2, 1, [0x2000])])
+        output = io.StringIO()
+        first_record_end = (stackmap_dump.HEADER_SIZE +
+                            stackmap_dump.ENTRY_SIZE + 8)
+        input_file = StreamingGuardInput(raw, first_record_end, output)
+        error = io.StringIO()
+
+        result = stackmap_dump.main([], input_file=input_file,
+                                    output=output, error=error)
+
+        self.assertEqual(result, 0, error.getvalue())
+        self.assertIn("stack_id 2", output.getvalue())
+
+    def test_json_input_uses_only_bounded_reads(self):
+        raw = image(entries=[(1, 2, [0x1000]), (2, 1, [0x2000])])
+        output = io.StringIO()
+        error = io.StringIO()
+
+        result = stackmap_dump.main(
+            ["--json"], input_file=ShortReadInput(raw),
+            output=output, error=error)
+
+        self.assertEqual(result, 0, error.getvalue())
+        self.assertEqual([entry["stack_id"]
+                          for entry in json.loads(output.getvalue())], [1, 2])
+
+    def test_json_does_not_materialize_all_records(self):
+        TrackedRecord.live_count = 0
+        TrackedRecord.max_live_count = 0
+
+        def records(_stream):
+            for stack_id in range(1000):
+                yield TrackedRecord(stack_id)
+
+        output = io.StringIO()
+        with mock.patch.object(stackmap_dump, "parse_stackmap_stream",
+                               side_effect=records):
+            result = stackmap_dump.main(
+                ["--json"], input_file=io.BytesIO(), output=output,
+                error=io.StringIO())
+
+        self.assertEqual(result, 0)
+        self.assertLessEqual(TrackedRecord.max_live_count, 2)
+        self.assertEqual(len(json.loads(output.getvalue())), 1000)
+
+    def test_vmlinux_symbolization_limits_unique_addresses_per_call(self):
+        raw = image(entries=[
+            (stack_id, 1, [0x10000 + stack_id * 4 + frame
+                           for frame in range(4)])
+            for stack_id in range(50)])
+        calls = []
+
+        def resolve(_vmlinux, addrs):
+            calls.append(list(addrs))
+            return {}
+
+        with mock.patch.object(stackmap_dump, "batch_addr2line",
+                               side_effect=resolve):
+            result = stackmap_dump.main(
+                ["--vmlinux", "vmlinux"], input_file=io.BytesIO(raw),
+                output=io.StringIO(), error=io.StringIO())
+
+        self.assertEqual(result, 0)
+        self.assertLessEqual(max(map(len, calls)), 128)
+        self.assertEqual(stackmap_dump.SYMBOL_BATCH_ADDRESSES, 128)
+
+    def test_vmlinux_duplicate_addresses_keep_record_batches_bounded(self):
+        TrackedRecord.live_count = 0
+        TrackedRecord.max_live_count = 0
+
+        def records(_stream):
+            for stack_id in range(1000):
+                yield TrackedRecord(stack_id, ip=0x1000)
+
+        with mock.patch.object(stackmap_dump, "parse_stackmap_stream",
+                               side_effect=records), mock.patch.object(
+                                   stackmap_dump, "batch_addr2line",
+                                   return_value={}):
+            result = stackmap_dump.main(
+                ["--json", "--vmlinux", "vmlinux"],
+                input_file=io.BytesIO(), output=io.StringIO(),
+                error=io.StringIO())
+
+        self.assertEqual(result, 0)
+        self.assertLessEqual(TrackedRecord.max_live_count, 130)
+
+    def test_vmlinux_rejects_aggregate_symbolization_work_above_limit(self):
+        raw = image(entries=[(stack_id, 1, [0x10000 + stack_id])
+                             for stack_id in range(8193)])
+        error = io.StringIO()
+        with mock.patch.object(stackmap_dump, "batch_addr2line",
+                               return_value={}):
+            result = stackmap_dump.main(
+                ["--vmlinux", "vmlinux"], input_file=io.BytesIO(raw),
+                output=io.StringIO(), error=error)
+
+        self.assertNotEqual(result, 0)
+        self.assertIn("symbolization work limit", error.getvalue())
+
+    def test_vmlinux_text_output_escapes_terminal_control_characters(self):
+        raw = image(entries=[(7, 3, [0x1000])])
+        output = io.StringIO()
+        with mock.patch.object(
+                stackmap_dump, "batch_addr2line",
+                return_value={0x1000: "name\x1b[2J\rspoof\tend"}):
+            result = stackmap_dump.main(
+                ["--vmlinux", "vmlinux"], input_file=io.BytesIO(raw),
+                output=output, error=io.StringIO())
+
+        self.assertEqual(result, 0)
+        self.assertIn(r"name\x1b[2J\x0dspoof\x09end", output.getvalue())
+        self.assertNotIn("\x1b", output.getvalue())
+        self.assertNotIn("\r", output.getvalue())
+        self.assertNotIn("\t", output.getvalue())
+
+    def test_help_states_vmlinux_kaslr_and_work_limits(self):
+        result = subprocess.run([sys.executable, str(SCRIPT), "--help"],
+                                capture_output=True, text=True, check=True)
+        self.assertIn("KASLR", result.stdout)
+        self.assertIn("module", result.stdout)
+        self.assertIn("8192", result.stdout)
+        self.assertIn("64 batches", result.stdout)
+
+
+if __name__ == "__main__":
+    unittest.main()
-- 
2.34.1

