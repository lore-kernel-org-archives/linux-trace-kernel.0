Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF24AF152
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441880; cv=none; b=bpfqEcc+P94kkY3NXcBF1Nf2yV1GNgKJCdv5ybvycXdJeiQaBJ+GFtq+Ma5eFgnONXClyCXge/GkjlLu5yArl/HSJRbCw+4GUX14ymojG++ZUlaFIcQ0Mk50qGgUhySIQ2i7N+REOVJRL6pAdULD1k53SsfU+AuTu9jUGrFjLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441880; c=relaxed/simple;
	bh=p28XEEH1kpixUicKVEE089eYVlZgAl1mBUyC7gBW7y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lt9grf73B6YoqdUTtADLP2UCxENGW3zaj+lwaQhPR3pB1lw5/6dq+nwzL9FArYtrcpjeakHQPyA6wUr6QTdQ5qks7IQkr6dfYxnb0sdWa1Yddq9VVSXUIUQOfSUztNyo4ufhMoPCX2AD4X7vwmYnU54RNNrO3fkU8rb7oJUyAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVZACgkC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVZACgkC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39927410578so4123573a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441871; x=1789046671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsLdYmvcba4SL10LHOu/XTo8xdQ1ajJ/bsCzDniPOYo=;
        b=rVZACgkCHMmgMV/5aF2zhM4coWWNtt8aCq1eyqmS6tRgmMCoLvcZS6LYKnnmTannC9
         NzLiwVYR3j/ADeIK71leMAxu4jqB68Ch0GHEOpeT78dTyVU/rfzMR6ZODzFhSFqiGTvl
         rg3zcBqxDmtGIQay7yAepwA+rpHSakUUcxpPDU+BeyRK8ElmpOjV2bQVuNgc3jUqGvWs
         HHV8EGKHaGlJQVyuuyPxSarJxngPud2MylT03ltPUdRirV/Jfk8dRndTK5NPL9SJVssc
         GwyazrWyFSN+nN/AyF9R9822N064BgYfYn7QuIh+md2Nrrak1xJxyTklG+LRHBuoWMKF
         72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441871; x=1789046671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsLdYmvcba4SL10LHOu/XTo8xdQ1ajJ/bsCzDniPOYo=;
        b=Kefq5J5R6T0TIFfgf05d1RhNX6yEIP942hrk3Ouh7ZUOT8ZCTsDNB1/WzFCwEdkQbP
         yxJmTnHKxGxmufQ8m3yLlGJmaZuq7N3F0G/3NhpCeVTmkcn6ZMBLVPhWS71XnuFc7HrA
         6YTTRu49pjYlMTTmE1WhiCa/gq6pR2t5Dd5KFnw46fD2Hk4/ffN8Jta1EWeEFWDZp2JN
         6D0koejaB2D7OXduNe98IrkwYpZj/vV/5hjYfi+0Dpj84K6GH3ZQ2hugA9Pf3Wg9QdIn
         Y5QoilsW9WwuFMIp3iVKL2MvzrJWWOxwUV3tiTYg+nyAUJMzBS29qlslLB1jhpytikgu
         51WQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0fCqOoMl26BxNC7oHlg/zryXyFztS+acGc/x/gPEGKxdGD9p7fmX7I7U4JMf7RfvdR7Z4y/JFrYoQ13NVrzVz0bw=@vger.kernel.org
X-Gm-Message-State: AFuF++kfGIqMtsXUFIxIaYhGJw0sOTG4wv0mE7Gm2bpYbE0H/OQUeOb1
	ykXiyX/hyiR0sGUErpGZIC1aZyMFGYYz5s15berbltOgZaWj6u/cYL/4
X-Gm-Gg: AYBFou1bTt0qG+hP+Zx95TXGz/3xZ/Rq4DNuqa+/P49md4Umsplp3EQTptWdpYG5k41
	Wo7sOj3jEegDEGmAngDS9NPM6c9GJDAMdL600/a4mv9ajenEIF3uf9GJD5evkAZ58KNjHrcoDqV
	i/96yDIoe8zOsCjsH4qP2GSkS7VT7GZDExI1jLG4KxWP4gJIeUsr85G7eYDW99TbT8IQ/2tyf9q
	l+iNH3xXbirEZ5tqkMKobxz04HMscuUTmSQjLgjAtIZN3qa9P6PZZ7E1mMepdriZ9i9L2lPVbbW
	6kCiQVCZETNcGAhcUVGDJuPMHDhi065fQxDM+OVVg+tKTH4ji1FExg6v5ERKqoOV8hrEJlf67we
	AKWa201llCMiOhz89j1LHjpZ40r4qfUeibA+WAmBjitV/CPPWCGsaBKrx68PDa8SnyH6skug0XL
	r3b5R+yMYlJz5Jsnn2D5OfTACKaAb+zsxo50qJVVI5rhfWO1qKinBuXXjFTtAaTKvXdyeRUliVL
	4I=
X-Received: by 2002:a17:90b:57eb:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39aedfcc06amr19357985a91.6.1788441871077;
        Thu, 03 Sep 2026 06:24:31 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832b85bsm5580845a91.4.2026.09.03.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:24:30 -0700 (PDT)
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
Subject: [RFC PATCH v6 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Thu,  3 Sep 2026 21:24:06 +0800
Message-Id: <20260903132409.270195-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven, Masami, all,

This is v6 of the ftrace stackmap series, sent as a new thread.

Previous version:
  https://lore.kernel.org/all/20260902064242.28606-1-lipengfei28@xiaomi.com/

The series adds stack trace deduplication to ftrace. When the
'stackmap' option is enabled alongside 'stacktrace', the ring buffer
stores a 4-byte stack_id instead of a full kernel stack trace, and the
full stacks are exported once via tracefs (stack_map / stack_map_bin).

The series is based on v7.2-rc4-102-g4539944e5151.

Motivation
==========

The target use case is long-duration, from-boot kernel tracing where
the same stacks recur enormously often and the bottleneck is ring
buffer space, not CPU.

Concretely, consider tracing the slab allocator from boot for hours to
study memory aging and catch the allocation backtraces behind a usage
peak. With a stacktrace trigger on slab tracepoints, every event today
carries a full kernel stack (roughly 80-160 bytes). On a fixed-size
ring buffer, the buffer wraps in seconds to minutes and the early-boot
history is overwritten before it can be consumed.

For this workload the set of distinct stacks is small and highly
repetitive. Storing a 4-byte stack_id per event and the full stack only
once significantly increases the time span covered by the same ring
buffer. The intended model is to trace for a long time and resolve
stack_ids offline through stack_map or the included stack_map_bin
parser.

This is complementary to the existing full-stack recording. Deep
stacks, reset windows, map insertion failures, and the early pre-init
window fall back to full stacks.

Effect on retention
===================

Same fixed per-CPU buffer, slab allocation workload with a shallow
kernel stack (kmem_cache_alloc), stackmap OFF versus ON:

                  retained events   bytes/event   time span
  stackmap OFF        645,068          ~104 B        15.0 s
  stackmap ON       1,397,741           ~48 B        27.7 s
                     2.17x             2.17x          1.85x

The benefit grows with stack depth and stack repetition.

Changes since v5
================

  - Correct all three commit messages to describe map-only reset:
    reset works while tracing is active and does not clear the ring
    buffer.
  - Restore tracing_reset_all_cpus() to a private static helper and
    remove its unused declaration.
  - Add EXIT cleanup to the instance selftest and track instance
    ownership so cleanup cannot remove a pre-existing instance.
  - Reject truncated stack_map_bin entry headers and IP arrays in
    stackmap_dump.py instead of silently returning partial output.
  - Install stackmap_dump.py from the tools/tracing install target.
  - Define stack_map as the required resolver/reset node and
    stack_map_stat plus stack_map_bin as auxiliary observability nodes;
    align selftest requirements with that distinction.
  - Remove an unreachable basic-test branch around successes and drops.
  - Keep success_rate present as 0% after reset and define precisely
    what successes, drops, and success_rate count. Bypasses that never
    call the map are not included in the rate.
  - Reset the map at selftest entry and EXIT to avoid cross-test state;
    declare od as a required program for the binary ABI test.
  - Make ftrace_stackmap_reset() private and correct its tracefs
    write-handler documentation.
  - Clarify boot-time activation: deduplication starts only after the
    map is created, the required stack_map resolver exists, and the map
    is published to global_trace.stackmap. Events before publication
    use full-stack fallback.

Reset semantics
===============

Reset clears the map and nothing else. It does not require tracing to
be stopped and does not clear the ring buffer. A trace can therefore
still contain <stack_id N> records after reset. Such an id either no
longer resolves or, after slot reuse, resolves to an unrelated stack.
That is misleading userspace output, not kernel memory corruption:
reset frees nothing and only clears storage still owned by the map.
Read the trace out before resetting if existing ids must stay
meaningful.

Test results
============

Final v6 candidate b22d31e6e672, QEMU aarch64 virt:

  - Clean arm64 Image build: PASS
    KERNELRELEASE=7.2.0-rc4-00105-gb22d31e6e672
  - Function tracer stackmap suite: 20/20 PASS
  - Function-graph stackmap suite: 4/4 PASS
  - Boot-time activation suite: 3/3 PASS
  - No BUG, WARNING, Oops, Call trace, or Kernel panic in these runs.

The immediately preceding code-identical candidate was also
exercised with the full stability matrix before the final
Documentation-only wording correction:

  - bits=14 concurrent stress for 30 minutes: 15/15 PASS
    work=9,372,378, reset_ok=27,177, binary reads=449,497, errors=0
  - bits=10 saturation for 20 minutes: 16/16 PASS
    entries=1024/1024, successes=4,722,487, drops=56,842,925, errors=0
  - bits=18, 3 GB guest, concurrent stress for 10 minutes: 15/15 PASS
    work=2,719,022, reset_ok=5,501, binary reads=60,123, errors=0

The final candidate differs from that tested candidate only in the
boot-time activation paragraph and its matching commit-message text;
all kernel and tooling code is identical.

KASAN and lockdep were not enabled for these runs.

Local Sashiko review used sashiko 0.3.3, prompts revision
4e9a9051bc4237b6543cda194d2143080127671d, and the subjective-review
prompt. The full three-patch review found only the boot-time wording
issue above. A targeted review of the corrected final patch 3
completed with no findings.

Known limitations
=================

  - Per-instance stackmaps are not included. The option is gated to the
    global trace instance in both tracefs and set_tracer_flag().
  - Allocation is eager at fs_initcall when CONFIG_FTRACE_STACKMAP=y:
    roughly 8 MB at the default bits=14 and roughly 130 MB at bits=18.
  - Deduplication is best-effort. Under contention, two CPUs may insert
    duplicate entries for the same stack and split ref_count between
    them; memory remains bounded and each entry is self-consistent.
  - Reset can make ids already present in the trace unresolvable or
    misleading, as described above.
  - stack_map_bin is a best-effort snapshot serialized against reset,
    not a fully atomic export.
  - Only kernel stacks are covered.
  - trace-cmd/libtraceevent integration is left for follow-up.

Usage
=====

  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 187 ++++
 Documentation/trace/index.rst                 |   1 +
 kernel/trace/Kconfig                          |  22 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          | 226 ++++-
 kernel/trace/trace.h                          |  16 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_functions_graph.c          |   1 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_selftest.c                 |   1 +
 kernel/trace/trace_stackmap.c                 | 871 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  55 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 101 ++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  67 ++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    |  84 ++
 tools/tracing/Makefile                        |  13 +-
 tools/tracing/stackmap_dump.py                | 164 ++++
 17 files changed, 1843 insertions(+), 5 deletions(-)
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

