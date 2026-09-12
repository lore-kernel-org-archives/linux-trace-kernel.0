Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA83F23BE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202381; cv=none; b=U2QvRs2SiOsqu2Yxe7uf2gZIKOcF+LOkOWSajYkQ++h/v8byoem7vdHvxuOp1cbYdJ4yY/PnuAv/tcZyyoeQ66VzeWKDCECnTa99Sya8EvkY+7u/F3RovRQfHwb0SSU7naaDk0Y0nW6iXRnoHlbkJuFK2URM8VG7fCSgavzG1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202381; c=relaxed/simple;
	bh=YETqqdZ2IPNRf7c89JgtfOyCwISowkym5Zw1SUw9U5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXfn+BOZsZAhjeMzTT4n55cLrLmZt7DhUHMPWMWkEQlDHF5mQMdIa+b1Hy7qHgGTIQ0twOO2LhvEO4FGP5ghmW/hZxo0z+WNVS8NNADjEcSUP8HO4E7t1R4SIPhDunxtKpQXIR53GirwccvL5f6/StZR29Ukde2ser3h2D+U204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4beix2V; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4beix2V"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2469838a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202377; x=1789807177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdkHb1sFuJnFL770dT8rkZgU+mX2FcmKosAbmnL3GtY=;
        b=L4beix2V6wOo+NqiZsXtAFBXUQB6L1LfDahM/kFm/Idi2Nc7w9nkJGipoaWU2cCD3D
         Ljw04ciPtvmF6tBp8KaYdcUCY9+r5u+lLjwhaYy9YNrFcHMBJLhXe26DW5BH11EDjPly
         rrwnVwk8E93VOb8awD5bevAtqmnb5jCoTN3opAzcdsog/ZvLcdE928SpiSujL5uHdIM7
         D/DCqFWdCpUAY3Xt+VBNPBxE3jR2hrW0kkEt33wSFnTe+kKPK0XF4wRbZxKeDEqMMXVT
         y4e2H6DcQ27+Gm5828Z3r307aua0P5REXFYEV+C/x6QtL/zMfdtOqd+8uqwa2PV99yxZ
         5PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202377; x=1789807177;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdkHb1sFuJnFL770dT8rkZgU+mX2FcmKosAbmnL3GtY=;
        b=f6nurkGY9K4HhgUTksKp850A1lCFblqeBCPgJjXWQQehGx+44p0eYlK8UTEO8y7oRV
         3bdr+RJhxpwK1MH5VuyGfClwHsp9DHvTezn2K2oLSSaPMGOr0Q5eBsn5DE9IY/3v/WMY
         L8WuutN4eN2iRRcKlQBZyO1wWbxXV/l9CGhDfHP9MmbkSHLH4I93xKJCAEyhT3ftEg2v
         k5o2MPa+QRByY0mvkXTLT2jjI4QhGH2wJ8OFbaMZm+S73WD9K6qJzmyyaGoxLywKCGGE
         jfzZawcybpec6luCI4YPJvZ4olSF11Gblrlrh8XIRjmzYJbkskLTtaC8jMRuHAl4g7Sp
         nkZA==
X-Forwarded-Encrypted: i=1; AKwUvBxs5HORwyTKA6cwRrHka+7roKrqEKiMP2XSAJC4M90HJSAMU0WjbKCNsIdUhqQBmwQgxFPrHHzBsMGlYa5AaD956PA=@vger.kernel.org
X-Gm-Message-State: AFuF++k5f5ReFkR5vg5hWpNNdErlgCNNNJ7/C8mXTG0PC/licLtwnjvA
	ZrhItX2w71vIajly0/mY/yoGP0EmHAxUuMNfR6oZwKxQmYg7sR1Uglfa
X-Gm-Gg: AYBFou28CeAzrGFJtEYoGawmLj7cgrZXha1MuHfCg40Jad2rW8nqkALupVHdBbIzPgL
	eGdWAMx8Qv8KthnY0X8E+oqIeppP41D/odvHqmN4JYr7U6xvLAfiSdKEaZwJNOVrSSHTGFWiva7
	fyCnQyuk+aDv0Er61uNc7E/CAJrAJFPcxFbrMJ4z+WlRXd9DNIw4YB7rn1IxrscskeiJ8zyfi4d
	Fx1eqAVwccdPnUuvo5QITK4KWN7UatZHWvs7GuE2q5v/3F85wMWTGYAabG1yN6jkOzmk0JGgB5f
	s3mAbrutx3siyhSOU4Uqf63RZ6ftAcbwouIfE7gNxIr1QDSL29UX7Ze65jLRPuWFSe86BP7qZM+
	XwInu0cQDWun3EkuqIMTaI4x98mOJOPtDrs0bFfAlH6I3MTeOsxJF7C5iV1xh004VzKDtC4Y+yk
	iuheeU8gVftKTb6pLMxDYxQEUN0WPAHhwLVqZ2136QWvG1cXIIHYdJ7gk4AehoMZMlx66ZIBEL7
	JbYo8KRIsPV93hxzDvK9elYpSL+Y2ZnZXmyAK3xFfqOfcErwHgV
X-Received: by 2002:a17:90b:390d:b0:39b:370e:c807 with SMTP id 98e67ed59e1d1-39d9c1fcb7cmr12800232a91.17.1789202376766;
        Sat, 12 Sep 2026 01:39:36 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:35 -0700 (PDT)
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
Subject: [RFC PATCH v7 06/10] Documentation: tracing: document the ftrace stackmap
Date: Sat, 12 Sep 2026 16:37:49 +0800
Message-Id: <20260912083753.3426176-7-lipengfei28@xiaomi.com>
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

Document stackmap configuration, tracefs interfaces, reset semantics,
binary ABI and implementation trade-offs.

Call out the externally visible details:

- reset clears only the map, so ids already present in the ring buffer
  may become unresolved or resolve to a reused slot
- boot-time deduplication begins when global_trace.stackmap is
  published; the preceding full-stack path still has normal
  ring-buffer reservation failure semantics
- capacity is measured in stack records and concurrent duplicates can
  consume it
- entries counts claimed element records and can include duplicates or
  records not yet published
- stack_map is required while stack_map_stat and stack_map_bin are
  auxiliary
- stack_map_bin uses native byte order and version 1
- open-time bitmap membership yields exactly nr_stacks records but is
  not a payload snapshot, so ref_count can change
- reset is detected at the next seq pass after buffered bytes drain and
  reports -ESTALE; a completed old export still ends with normal EOF

- CONFIG_FTRACE_STACKMAP allocates the map at tracefs initialization even
  when the runtime option remains disabled; the default element pool is
  about 8 MiB and the maximum is about 130-135 MiB
- stack_map_bin exposes raw adjusted kernel IPs without kptr_restrict
  sanitization; mode 0440 plus tracing_check_open_get_tr() and
  LOCKDOWN_TRACEFS form its access boundary
- reset keeps the fixed 4-byte, non-generation-tagged stack-id ABI, so an
  old id can resolve to a reused slot

Also describe the address-adjustment and offline-symbolization limits,
including KASLR and module addresses.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst | 241 ++++++++++++++++++++++++
 Documentation/trace/index.rst           |   1 +
 2 files changed, 242 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..1857c1d67292
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,241 @@
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
+- ``ftrace_stackmap.bits=N`` - Set map capacity to 2^N stack records
+  (default: 14 → 16384 records; valid range: 10-18). Concurrent duplicate
+  entries can consume this capacity.
+
+  At ``bits=18`` the kernel reserves roughly 130 MB of vmalloc memory
+  for the element pool. The cap is set intentionally to bound memory
+  usage.
+
+The map is allocated when tracefs initializes after
+``CONFIG_FTRACE_STACKMAP=y`` has been built in and the required resolver node
+can be created. This allocation happens even if the runtime ``stackmap`` option
+remains disabled. On a 64-bit kernel, the element pool consumes roughly 8 MiB
+at the default ``bits=14`` and 130-135 MiB at ``bits=18``; the hash table and
+small per-CPU metadata are additional allocations.
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
+the slot is reused -- resolves to an unrelated stack. The 4-byte IDs are not
+generation-tagged, so a consumer cannot distinguish that reuse from the ID
+alone. That is misleading output, not corruption. If you need the ids in an
+existing trace to stay meaningful, read the trace out before resetting.
+
+Boot-time activation
+====================
+
+The stackmap option can be enabled from the kernel command line::
+
+    trace_options=stackmap,stacktrace
+
+The regular full-stack fallback remains in use until the map is successfully
+created, the required ``stack_map`` resolver exists, and the map is published
+to ``global_trace.stackmap``. Deduplication starts at that publication
+boundary. While the map is unpublished, the fallback makes the usual
+ring-buffer reservation, which can still fail under the existing ring-buffer
+semantics. Early-boot stacks recorded before publication are not deduplicated.
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
+``stack_map``, ``stack_map_stat`` and ``stack_map_bin`` all use
+``tracing_check_open_get_tr()`` in ``open()``. It rejects access under
+``LOCKDOWN_TRACEFS`` or when the tracing subsystem is globally disabled
+(``tracing_disabled``), and pins the owning trace array until release. The
+check applies at open time, so raising lockdown after tracefs has been
+populated still blocks later opens, including the ``stack_map`` reset write.
+
+``stack_map_bin`` is additionally a raw tracing ABI: its payload contains
+raw kernel instruction pointers after ``trace_adjust_address()`` and
+does not apply ``kptr_restrict`` sanitization. VFS permissions restrict
+the file to mode 0440.
+This follows the existing trust boundary for raw tracing interfaces such as
+``trace_pipe_raw`` and ``available_filter_functions_addrs``.
+
+``stack_map``
+    Text export of all deduplicated stacks with symbol resolution.
+    Writing ``0`` or ``reset`` clears all entries.
+
+``stack_map_stat``
+    ``entries`` is the number of element records claimed since the last reset.
+    Other statistics are table_size, successes (map operations that returned a
+    stack ID), drops (map capacity or probe-limit failures), and success_rate.
+    Entries is not a strict count of unique stacks: it can include duplicate
+    records created by concurrent insertions and records claimed but not yet
+    published in the hash table.
+    The success_rate is ``successes / (successes + drops)``; it does not include
+    bypasses that never call the map, such as deep stacks, reset windows, or ring
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
+    un-offset. The dump tool's ``--vmlinux`` mode is therefore valid only
+    when core-kernel addresses already match that vmlinux, for example
+    with ``nokaslr``. It does not resolve KASLR-slid or module addresses.
+
+    The table is streamed rather than copied into a private payload
+    buffer. At ``open()``, the kernel records the currently populated
+    slot numbers in a bitmap and sets ``nr_stacks`` to that exact count.
+    The bitmap is at most 64 KiB at the largest supported table size;
+    stack payloads remain in the map and are emitted through
+    ``seq_file``. Entries inserted after ``open()`` are not part of that
+    fd's record set, so exactly ``nr_stacks`` records follow the header.
+
+    Because the reader lock is released between ``read()`` calls, a
+    reset can land part-way through reading the file. That would
+    otherwise splice two generations of the map into one stream, which a
+    binary consumer could not detect, so the export tracks a generation
+    counter. After any data already buffered by the current ``seq_file``
+    pass has been consumed, the next pass that needs to resume iteration
+    detects a reset and fails with ``-ESTALE``. It never appends records
+    from the new generation. ``ESTALE`` is used instead of ``EAGAIN``
+    because ``seq_file`` treats ``EAGAIN`` as an internal retry during
+    seeks. Reopen the file and read it again.
+
+    A reader that has already reached the end of the export is not
+    affected: the final ``read()`` returns 0 as usual even if a reset
+    happened, because no data remains that could come from a different
+    generation.
+
+The text export has no generation check. It serializes each ``seq_file``
+pass against reset through the same rwsem, but a ``stack_map`` reader that
+spans a reset can still produce text from two generations across separate
+``read()`` calls, and nothing reports that. Symbolized text is meant to be
+read rather than parsed as a record stream, so this is deliberate. A
+consumer that needs a consistent snapshot should either read ``stack_map``
+completely within a window where no reset happens, or use
+``stack_map_bin``, which does detect the change.
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
+- Stack records: ~3000
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
-- 
2.34.1

