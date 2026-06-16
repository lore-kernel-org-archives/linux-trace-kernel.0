Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00B3E7BCB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592122; cv=none; b=hQQjAXoPN57d7Xr8KYbO1qeUUJ8E6TR7IZSj54Rn9I2pbmklIMmOL4ebAN8iCSuSlahyma4HO4gkdiVud/IZluHlwyJKSfHUohNRqKdEKCfDsv6s0PL96qFtSPSav8UKx1O8HI+iUAClVMtlpC97msSaEdv6lTkewU9qY7BGe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592122; c=relaxed/simple;
	bh=WuHs7pvtH2baovnauiy7L8A2sXk7Cwcl2Uqq2xBgYzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCSQs365MtQcpMOUbrgcgLepcfpKNGRxtzTspBhA523NVbVR1oWDCjLF5jhO08i0YktZj3y6EoIWMDfxKYAZ2RjIMMmZlH1MDGA9rR2tMpqElq1/Z+I2n31xG1VWoE98gkbKsA/0PGEFNhXZ3ZcpbqNAtu2nlX/L/UI1ulqHAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0yuInHl; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0yuInHl"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13810b63a1aso9592916c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592120; x=1782196920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpxz8uat0VAwhdnDYW8Lc9U4R0TwiGMD6WGOkNlDK5k=;
        b=Y0yuInHl4X/WTdJ4vCmlM8nw+q029YD5yrsSQVPEA/WWhfqJu7cxcw/sFytwyuJ4OJ
         M9qrnP8lI+l4JH78DRup5Qofb2Ps4EBBXB+Uxg9iDgUxdVrYItGAi6xej+yOdDPmpCfO
         xGnENVhv6gblLEDGXVcEZEj4jKTq3OpwzMxbaC06FfBIgR+isJXpRXq4AYJ+X9Veh3d7
         qebe5YK7u5kc3MhjtPsfd0qsfPl8Aq4ugrBYeauNAcOC7on+9Ed+VW5i9pamdSyEjY9X
         vMHavllz/Snd2AQXgbmGJuyj/7P1Eg8mqhspDrm0wPKwB2lgia1Jw8WWx27AHGLsEGNR
         Stpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592120; x=1782196920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpxz8uat0VAwhdnDYW8Lc9U4R0TwiGMD6WGOkNlDK5k=;
        b=Eu/d9IFmUSAjQPp2ENk87QhiBc5AbDNeYRFgmOIBpfsFUj03J1PEhnsqz+K3+LZBRm
         hvy/tn6CZocCKTL4z3SKrXxMxbX/hn1weNIf9aawjzC2aSVH5RTnZ64hKqsu27i/e+TV
         ycRDO7IBCI1RBkkB5T/88/zXZ/JjaTSvQ+jGBm62QwGEuPvsVixhQz77CTDZs91/nK1I
         pLn/LA6uAknW1646GjR64vdArEpWhIQt7hJzWUWDCbGCM4VkxI+Bd2+DcXDrwoxa55ig
         JEM/AmSoPuN7kHOhjsabWihPHJq87rpPO7qK6qfoBWr5Ssdds0cOSer9WRvVfiCW0pCh
         iRUw==
X-Forwarded-Encrypted: i=1; AFNElJ/v+cy8GAinH9JuESTUL6lV40ptIcTxaRe8n5+JFAWnQBnwRLR4cL04CgXwDR8LWsfKV6frF3DcvO0Z3qvLdTqnlF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyndn/knzXlrGq7zHiSfB/CO04yHItR1PNOpqzv0rDw+vnUenew
	sXgRTW/UOlMA/nM8UqxLEiIHn3HrximWRxYv7b6PRbrRdpvKMSTiimyo
X-Gm-Gg: Acq92OGUtxcKwg7UxaIwqIxs3kbgcES8rfDto2w+rky5OCwuf8+cib963XyQuR1md2I
	mQl2F55o2yiD1D7DaUdn+HH+PL5AywODSmqKYtdJJcOVj6tHYQ8SNgtp6Pmnb0Iu25Iz8bOXV9G
	EL6i2nyEXiAFh4yknyQiPQrDUNXtgs9rSVH77c7r8KgZKTarAkjT4smR/o+Lm/tAxNv7B9ZJ28E
	tyZzayJKxV5BI94+kb7KxDFcp2iHbyjAeu9uEjIWh0a8XulXErb0di4yWNsGHGBLmGGT/JZSk8d
	OezRbZWRpKW4dO+hMu4YkSu2BBVNAZyi3WiQ+87h3RyduGUq3tJ98HRIacakV0YDiO0DUf08X1C
	PISnPMdXMvjZYz2dKZ1yL+QuZkptnDGIL99HCQE7GHY+nLlTgfQfm42SX4H5/CAfWUfqM8beMIh
	X6L4o3/6fvCDXV1cpOIMHdcusc/8Ubc40MJeMXuxYqhCBMxe7m
X-Received: by 2002:a05:7022:38d:b0:138:212b:705b with SMTP id a92af1059eb24-13985eab60emr1374091c88.12.1781592120124;
        Mon, 15 Jun 2026 23:42:00 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:55be:2dbe:9cd4:7306])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm12499158c88.4.2026.06.15.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:41:59 -0700 (PDT)
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
Subject: [RFC PATCH v4 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Tue, 16 Jun 2026 14:41:16 +0800
Message-Id: <20260616064119.438063-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Masami, Steven, all,

This is v4 of the ftrace stackmap series. It is sent as a new thread.

v3: https://lore.kernel.org/all/cover.1779769138.git.lipengfei28@xiaomi.com/

The series adds stack trace deduplication to ftrace. When the
'stackmap' option is enabled alongside 'stacktrace', the ring buffer
stores a 4-byte stack_id instead of a full kernel stack trace, and the
full stacks are exported once via tracefs (stack_map / stack_map_bin).

Rebased onto v7.1-rc5 (e8c2f9fdadee).

Motivation
==========

The target use case is long-duration, from-boot kernel tracing where
the same stacks recur enormously often and the bottleneck is ring
buffer space, not CPU.

Concretely: tracing the slab allocator from boot for hours to study
memory aging and to catch the allocation backtraces behind a usage
peak. With a stacktrace trigger on the slab tracepoints, every event
today carries a full kernel stack (~80-160 bytes). On a fixed-size
ring buffer that bounds how far back in time the trace reaches: the
buffer wraps in seconds to minutes and the early-boot history -- the
part we care about -- is overwritten before it can be consumed.

In this workload the set of distinct stacks is small and highly
repetitive, so storing a 4-byte stack_id per event and the full stack
only once dramatically increases the time span a given buffer covers.
The intended operating model is exactly the low-overhead one ftrace is
good at: let the trace run for a long time producing a comparatively
small, dense log, then resolve stack_ids offline (cat stack_map, or
parse stack_map_bin with the included tool) during analysis.

This is complementary to, not a replacement for, the existing full
stack recording: deep stacks and the early pre-init window still fall
back to full stacks (see below).

Effect on retention
====================

Same fixed per-CPU buffer, slab allocation workload with a shallow
kernel stack (kmem_cache_alloc), stackmap OFF vs ON:

                  retained events   bytes/event   time span
  stackmap OFF        645,068          ~104 B        15.0 s
  stackmap ON       1,397,741           ~48 B        27.7 s
                     2.17x             2.17x          1.85x

The buffer holds ~2.17x more events and reaches ~1.85x further back in
time for the same memory. The win grows with stack depth and with how
repetitive the stacks are; for deep, highly-repeated stacks the
per-event size approaches the 4-byte stack_id plus event header.

Changes since v3
================

Correctness:
  - Deep stacks are never silently truncated or merged. A stack deeper
    than FTRACE_STACKMAP_MAX_DEPTH (64) now falls back to a full stack
    trace; ftrace_stackmap_get_id() returns -E2BIG rather than
    truncating, so two distinct stacks sharing their first 64 frames
    can no longer collapse to one stack_id.
  - reset is now genuinely destructive and coherent: under the
    reader_sem write lock it clears the owning trace_array's ring
    buffer (and snapshot) BEFORE clearing the map, and uses
    tracing_reset_all_cpus() rather than _online_cpus() so a
    TRACE_STACK_ID written by a now-offline CPU cannot survive and
    dangle against a cleared map.
  - __ftrace_trace_stack() reserves the TRACE_STACK_ID ring-buffer
    slot before inserting into the map, so stack_map_stat counters and
    ref_count stay consistent with what the ring buffer actually
    references (failed reservation -> full stack, map untouched).
  - ref_count / successes / drops now saturate (INT_MAX / LONG_MAX)
    instead of wrapping on multi-hour, billions-of-hits traces.

Global-instance gating:
  - Enabling 'stackmap' on a secondary instance via the aggregate
    trace_options file is now rejected, not just hidden in the
    per-instance options/ directory.
  - tracefs init is failure-atomic: the required stack_map file is
    created before the map pointer is published; if it cannot be
    created the map is destroyed and never published. An init-state
    (PENDING/DONE/FAILED) lets boot-time trace_options=stackmap set
    the flag before the map exists (hot path falls back until it is
    published) while still rejecting enables after a permanent init
    failure, so options/stackmap never reports an enabled no-op.

ABI / tooling:
  - Binary magic corrected to 0x46534D42 ('FSMB'); version is 1 (first
    upstream ABI). Documentation, tool and selftest updated to match.
  - Text and binary exports now follow the same trampoline-marker and
    trace_adjust_address() handling as the normal stack print path.
  - stackmap_dump.py emits hex addresses in 'ips' and shows the ftrace
    trampoline marker only in the resolved 'symbols'.

Selftests:
  - New stackmap-reset.tc: verifies reset clears stale <stack_id N>
    from the trace buffer and checks the stack_map_bin magic/version.
  - stackmap-instance-gate.tc extended to verify the trace_options
    write path is rejected on a secondary instance.
  - stackmap-basic.tc no longer treats a nonzero drops count as a
    failure (drops is a by-design fallback); only zero successes with
    nonzero drops is fatal.

Open questions for maintainers
==============================

Two design points where I would value direction before polishing
further:

1. Eager vs lazy allocation. The element pool is allocated at
   fs_initcall when CONFIG_FTRACE_STACKMAP=y, regardless of whether
   userspace ever enables the option (~8 MB at the default bits=14,
   up to ~135 MB at bits=18). This keeps the hot path allocation-free
   with no allocation-failure path under tracing pressure. Is eager
   allocation acceptable, or would you prefer lazy allocation on the
   first 'echo 1 > options/stackmap'?

2. Binary ABI now or later. stack_map_bin is a new tracefs binary
   interface (magic 0x46534D42, version 1). Is it acceptable to
   introduce it now, or would you prefer the first version ship with
   the text stack_map interface only and add the binary export once
   trace-cmd / libtraceevent integration is designed?

Test results
============

QEMU (aarch64 virt, v7.1-rc5 + this series), boot to init smoke test:
  - stackmap functional suite: 16/16 PASS, including reset clearing the
    trace buffer (stale <stack_id> count 48 -> 0), stack_map_bin
    magic/version, global-vs-secondary instance gating, and the
    trace_options rejection on a secondary instance.
  - boot-time activation (trace_options=stackmap,stacktrace on the
    kernel cmdline): 3/3 PASS -- the option survives the
    pre-initialization window and the map is live once published.
  - ftrace startup self-tests pass with the new TRACE_STACK_ID entry.

Device retention numbers above were collected on a Xiaomi SM8850
(ARM64) running an Android workload, comparing the same buffer with
the option off and on.

Known limitations
=================

- Per-instance stackmap support is not included; the option is gated
  to the global instance (in the tracefs layout and at the
  set_tracer_flag() write path). Per-instance maps are a follow-up.
- Deduplication is best-effort, not strict: under heavy concurrent
  contention two CPUs racing with the same stack hash may each claim a
  different slot, producing a few duplicate entries; ref_count is then
  split across them. This keeps the hot path lock-free.
- The stackmap covers kernel stacks only.
- stack_map_bin is a best-effort snapshot, serialized against reset
  but not a fully atomic export.
- trace-cmd / libtraceevent integration is left for follow-up once the
  binary format settles (see open question 2).

Usage
=====

  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 177 ++++
 Documentation/trace/index.rst                 |   1 +
 kernel/trace/Kconfig                          |  22 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          | 216 ++++-
 kernel/trace/trace.h                          |  17 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_selftest.c                 |   1 +
 kernel/trace/trace_stackmap.c                 | 889 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  57 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 111 +++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  54 ++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    |  76 ++
 tools/tracing/stackmap_dump.py                | 164 ++++
 15 files changed, 1821 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
 create mode 100755 tools/tracing/stackmap_dump.py

-- 
2.34.1

