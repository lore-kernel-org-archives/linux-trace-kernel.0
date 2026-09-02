Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB81386C12
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331397; cv=none; b=XNlHyolP1UVhK9oasORBDtM3WUOvjTQuXjDQo/SScD2d9OWYJAvXXMUVVi8FgzpH9QjNRs3hojRLTPZsQ4OS6gwXThH09Dsr2KsKncRDk5MwWOAtkosXx1AL+36EFeOiBD9gkxL62M09PgYL8T8VQgoP+cHjc98nYlLkXtcOa/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331397; c=relaxed/simple;
	bh=oa1klZ84Y9HmXIG2PVYw0CNJgGARwSO7qDclCIvlE1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwVDmxkWVvGXFX+M9w27GqpV8EIsMm/8hSVDbDMofyekEabQhJU1sG8r0BVHhm9YXnt6X7x8zi7a6wMfod++hIGD/7sWJxDPH5wVEiNSO0p5IptU+w5Y+OUvEwwKrQKDyFL+2bWG/FMmIU30wmFh0W3OS0TlB3ETSfME3bdKD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu1ifnvX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu1ifnvX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1481833a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331394; x=1788936194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0OSJfETTdYTriCW7H435cPMeyJW78V2WXqxeEnE0Nw=;
        b=Hu1ifnvXdUOXTa0Saz7ezlgs1N5jtfvbLKkjhW12O7olFujjfzmjfdPn4C/3h4nJa6
         qJUkf+BVcPTMHRR3duFCHH5Ky+xhAS5R/1C8u0wflzSh22yoUBXwVjYJ33u3q4+DkwNp
         OtBN8ZBOyqUF39l6zSdmpYTZDqeXxdjK6b4G19tw1CRgVU5a0Wv4Zldmcm/soZkMYziq
         ZQ4HJIGnjHGn/snvZUsY0zhwnUkUSq9uJkN1YYjktS1Bo+uFQjaSQ9YG/zPP9/qEBLne
         ra2PTxWZMUBvkIBjA52xN1zkuLtRFFzSqPdlGxZ905fXxoRBmYyQSdhNFAplSgPfhlBi
         Rywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331394; x=1788936194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0OSJfETTdYTriCW7H435cPMeyJW78V2WXqxeEnE0Nw=;
        b=ibiaVieT4lBknCpXBvqbtKsiFyPmwKQJSyOLci/uzPDnwJzXWuWcfyBYy8mseGzLCv
         Har9uUHKTG2a9yMHhbGNfrs0IaK9ti/+dVYs+tNmIo+XvfRAgQYRS3rbiJ2J1IPn2t9J
         4lPrsK1fBvAo4Qk++UvagElMNdEkdQ0+jrqtp8+vTYGcCuE2EORDuSww82j0vAuDneHi
         LbRh8nRh2l3cCFV0NUO6U79X+kUVO+Y5hVTb+p9Ajp1I1dALP6w4L/7wbzt7MoDiTAWm
         58QINAm9/Q13yBEJ/PQ+bGDAC7T92dZzuMyvv+4CNFr05ofRDFWxIsboNs9By9+TcA01
         upzA==
X-Forwarded-Encrypted: i=1; AKwUvBzn8B9RpVIUfDCDcABJ+U8gTeiUoVnLKKT4MIKR2ESE0Md855rfOBqIsMbGCbbz/R2p0+YYQldu6qiESwSNOQF4kvk=@vger.kernel.org
X-Gm-Message-State: AFuF++lLWQzuSRtKrYHt+2f4pUOLJ1z3CyfRXpdv56d1ZdGQBkJ6hj4Q
	GAzoa2kMsLcLLpRqPaOZA5BA7aQjXYdQA0+MzhUaFY12bSgYXPEFPiNP
X-Gm-Gg: AYBFou1fGnmpgPA022geVwkuui1fVRIrdXKNWFLy2AZ0hvzi4yDLPEK6pgaaHCQICl6
	f6Ttg/aL/FYmWwpHs3RfUL04FVB3KjHKsgpVlNdgwArgU6ss0rLRShu3wp0ijVsoMlcVz50MnLX
	/fE5+hqvVkyAmy33H4v2u4ayMS4+rUSSEjXkE7lMgWQOv0E3UHrqSS5AtqqgFiISHBbej8LlLk+
	iUZeqh4u0wmyzNxR6SBDbhB3rESpK+A7ItkfNmY9uJfuEXm9IU4Rv1s3fljvVfJwVRNlxWBzZR4
	ZFI7eV/7HK+gO52nGmM+1byC5q6ZBK7Mx5vRSOfwQ6G3IGBanltHTNnN+0emKCAH1RBXW7gvG0r
	yjpxii9d6JH8u0mLl38nDPBfjnHNA7vj/97zB6Bod4eZaBnQZ2KUfnTDXE99J8txoTYOmLdfk2E
	YHns5qHsi+sYHZeuPoI9X/NUfewjUhzXJXSHHF2kbsFKQFVxEB9jY2aAiv1DuMU6A20PfE/5+JU
	yO4WIdAtJM/24f5ze6Pid3BhHjnI04=
X-Received: by 2002:a17:90b:5445:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-39af63f7f7amr788751a91.8.1788331394288;
        Tue, 01 Sep 2026 23:43:14 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:2c95:4917:f0fe:b444])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d80433dsm9373143a91.17.2026.09.01.23.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:43:13 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v5 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Wed,  2 Sep 2026 14:42:39 +0800
Message-Id: <20260902064242.28606-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Steven, Masami, all,

This is v5 of the ftrace stackmap series, sent as a new thread.

v4: https://lore.kernel.org/all/20260616064119.438063-1-lipengfei28@xiaomi.com/

The series adds stack trace deduplication to ftrace. When the
'stackmap' option is enabled alongside 'stacktrace', the ring buffer
stores a 4-byte stack_id instead of a full kernel stack trace, and the
full stacks are exported once via tracefs (stack_map / stack_map_bin).

Rebased onto v7.2-rc4 (4539944e5151).

v5 is the cleanups Steven asked for on v4, five issues I found myself,
and one behaviour change: reset is simplified the way Steven suggested
(details below). No functional change to the dedup algorithm itself.

Mathieu: patch 1 is the lock-free map. The memory ordering there
(entry->val release/acquire publishing the element payload, key only
under READ_ONCE, and resetting + synchronize_rcu() for teardown) is
the part I would most like a second pair of eyes on.

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

Changes since v4
================

From Steven's review of v4:
  - ftrace_stackmap_create() uses vcalloc() for both the hash table
    and the element pool instead of vzalloc(size * n).
  - ftrace_stackmap_create() error handling collapsed into a single
    goto-fail ladder, freeing in reverse allocation order.
  - Dropped the anonymous block in ftrace_stackmap_reset(); the cpu
    iterator is declared at function scope.
  - struct ftrace_stackmap_bin_entry grew a u64 ips[] flexible array
    member, and stackmap_bin_open() now uses struct_size(e, ips, nr)
    and writes through e->ips. The on-disk byte layout is unchanged,
    so the binary format is not affected.
  - Undid a few 80-column line wraps in the tracefs init path that
    were hurting readability.

reset semantics -- the one behaviour change in v5:
  - Steven pointed out on the v4 thread [1] that reset was stricter
    than it needs to be. v5 drops both parts of that strictness:
    reset no longer returns -EBUSY when tracing is on, and it no
    longer clears the ring buffer. It now clears the map and nothing
    else, which also let the tracer_tracing_is_on() check, the
    trace_types_lock section and the snapshot-buffer handling go away
    (patch 1 is 56 lines shorter as a result).

    I had replied that I would do this as a follow-up rather than hold
    this respin. On reflection there is no reason to ship the stricter
    version first, so it is folded in here instead.

    The consequence is that a trace can still contain <stack_id N>
    records after a reset. Such an id either has no entry in
    stack_map, or -- once tracing continues and the slot is reused --
    resolves to an unrelated stack. That is misleading userspace
    output, not corruption: the map is still guarded by the resetting
    flag plus synchronize_rcu(), and reset frees nothing, it only
    memsets storage the map still owns. This is spelled out in the
    ftrace_stackmap_reset() kernel-doc and in ftrace-stackmap.rst.

    [1] https://lore.kernel.org/all/20260821235129.078dd489@fedora/

Issues found locally since v4:
  - The IS_ERR() branch of the stackmap init path modified
    global_trace.trace_flags without trace_types_lock, racing
    set_tracer_flag(). It now goes through the same
    stackmap_mark_init_failed() helper as the other failure path.
  - TRACE_STACK_ID was not handled in print_graph_function_flags(),
    so with current_tracer=function_graph a stack_id event fell
    through to print_graph_comment() instead of being punted to its
    own printer like TRACE_STACK. Now handled alongside TRACE_STACK.
  - stack_map_stat computed the success rate as successes * 100 before
    dividing, which can overflow u64 now that the counters saturate at
    LONG_MAX. Uses mul_u64_u64_div_u64().
  - stack_map_bin allocated a fresh snapshot on every open, so
    repeatedly opening without closing could pin a lot of vmalloc
    space. It is now single-open.
  - stackmap_seq_start() and stackmap_seq_next() held the seq_file
    position in a u32, narrowing the loff_t the iterator is handed.
    The position is driven by our own next() and bounded by map_size,
    so this was not reachable in practice, but the correctness of the
    truncation depended on an invariant that was not visible locally.
    Both now keep it in a loff_t.

Still open
==========

Eager vs lazy allocation. The element pool is allocated at fs_initcall
when CONFIG_FTRACE_STACKMAP=y, regardless of whether userspace ever
enables the option (~8 MB at the default bits=14, up to ~135 MB at
bits=18). This keeps the hot path allocation-free with no
allocation-failure path under tracing pressure. v5 keeps eager
allocation; if you would rather not pay the resident cost when the
option is never enabled, switching to lazy allocation on the first
'echo 1 > options/stackmap' is a contained change and I will do it in
v6 rather than hold this version on it.

stack_map_bin is kept as-is. Steven's suggestion to give the bin entry
a flexible array member is taken as acceptance that the binary
interface can land now; say the word if you would rather ship the text
interface first.

Test results
============

QEMU (aarch64 virt, v7.2-rc4 + this series), no BUG/WARNING/Oops in
any run:
  - functional suite: 19/19 PASS. Covers stack_map_bin magic/version
    (0x46534d42 / 1, confirming the flexible-array change did not move
    the on-disk layout), the single-open guard returning EBUSY on a
    second open and recovering after close, reset now being accepted
    while tracing is on, reset clearing the map (11 -> 0 entries) while
    leaving the ring buffer untouched (149 -> 149 stack_id records),
    the success_rate computation, and global-vs-secondary instance
    gating including the trace_options write rejection.
  - function_graph + stackmap: 4/4 PASS with 173 stack_id events in the
    graph output, rendering as
      ksoftirqd/0-14  [000] d..2.  6.731781: <stack_id 16416>
    i.e. punted to the event's own printer rather than being formatted
    as a graph comment, which is what the print_graph_function_flags()
    fix is for.
  - boot-time activation (trace_options=stackmap,stacktrace on the
    kernel cmdline): 3/3 PASS, 58 stacks and 421 hits recorded before
    init runs, 0 drops.

Build: kernel/trace/{trace_stackmap,trace,trace_functions_graph}.o
compile clean (0 errors, 0 warnings) with the arm64 cross toolchain.

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
- reset clears the map only and leaves the ring buffer alone, so
  stack_ids in an already-collected trace can stop resolving after a
  reset, as described above.
- The stackmap covers kernel stacks only.
- stack_map_bin is a best-effort snapshot, serialized against reset
  but not a fully atomic export.
- trace-cmd / libtraceevent integration is left for follow-up.

Usage
=====

  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 175 ++++
 Documentation/trace/index.rst                 |   1 +
 kernel/trace/Kconfig                          |  22 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          | 228 ++++-
 kernel/trace/trace.h                          |  17 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_functions_graph.c          |   1 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_selftest.c                 |   1 +
 kernel/trace/trace_stackmap.c                 | 869 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  57 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 110 +++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  54 ++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    |  77 ++
 tools/tracing/stackmap_dump.py                | 164 ++++
 16 files changed, 1812 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
 create mode 100755 tools/tracing/stackmap_dump.py


base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
-- 
2.34.1

