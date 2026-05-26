Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3D3F7865
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796425; cv=none; b=rpBlcvYia6m7wd8bRXqFxtDbnXs94o6CV7QWz2KZJbMfBMqFBNPzLQsXUkM3sr0FhsZPXQOy8lFuKzxJXn35jmQI8/ol9fTC9VDtrdt0Z6rIbzaBWB7xdOo1/V3Dyk3XdMAy6NvkcJ5KjS3tdiYcMdcyyJz8Lpk4Y6kzkUkEISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796425; c=relaxed/simple;
	bh=EbQOvTn4ph8TVffYaMIFIVIEik7JZoNJsXWomiq5Y1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGuGD9UYjxoSg4aIrktOoLbv+YcNivVze5BjBzx3S4TskqOGsIptJCImtnikR5EHCbdHRfskmrOHV7UIsTcTMbq5UA0TgN5cqBa6GROsN2EEB35X1hrHyuwsriJzGpPlnl7xv52HQe8sLuKMQAiVb5ih3nzy2vLeyZNplOWfMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6zEm9w5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6zEm9w5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b4583f0a1aso74900535ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796412; x=1780401212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUx+ZkmXLqnU8en6VxaoihTvj5DaX2JioOA7l6GrXzg=;
        b=G6zEm9w5DRFpJou9qZ2i5so1k3fUgrhQximV8VTwWKBGvQUK8sr1cJ5T5CqTrpFIEi
         fnOEpLck9aD20RILX7jn7vOrTMor/Q1Gc/pMi/zOsQqm0zPpcP7XdjcLRQ/5Sxr6ua2L
         Pi6vF5bZQ6N6PkxhUmV8c35rserPv5QNiZdgDbZ2zUXnx6qMNbB1Gpj128Yg2jmEON/+
         MHVsDfAn0E/G8sw+TX/hUv6y3kvP82hDoZGs1+CNaHORlehODBb5B4r+4c+6DZEQ2YL7
         QylqMq73piEDWzO1ic+NXDvJ2S/0JORpB1KwiN63RDqPmEql1bUblX2WTnFVYihGPpKK
         f6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796412; x=1780401212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUx+ZkmXLqnU8en6VxaoihTvj5DaX2JioOA7l6GrXzg=;
        b=mulr8iChSHs8qA/KL1I1Q7HoYZO14I1wk42zq+1W2i2YhcMS60XhbJhEfnjIkEK6Mh
         +7ihcVNE4g2gs0KYAA2i4yzDISirKtiHN6iDM4S0blS4zknEPkaS91n06+pvLiLQbMOT
         4Q9z2A4YsxNYThdC6HaQHGkyRjqj7H1vLp21upbonO+LuCWTxeMhcRc63btaOcqE5uUR
         60+5dzUSxxdnVIa0tp8QlT6Sj7wnQwd2mMErtvC+MnWLMctFuJgQ3XVRSQwDIjZshxFj
         aJ5jAK52QdIuqfmBdqXeRLdXAXfD2OyHS542lPfIfj+OUaPqc/9KoE9zGc/GkWbOQ9r8
         psWA==
X-Gm-Message-State: AOJu0Yxw/gtjbFfyy+57bFMoWeEFxI3DZrQwOfQMeQl8G2TPdBLBm2UF
	Jt94S2jxsY3UXJPBLToX1r45wH/Xme0YJxL1eaCwImf4/cP6pivENOXX
X-Gm-Gg: Acq92OE4ZlyyuECI/VtyWfvdYcD8pWOg/rCte/Mx6kf4/tlT3LpyyI7xExEWjXMTgeV
	MpYYmHXAHp23WddzuCfAVtwX+BQrR4r4oZWzdJdzgTXozpGJGmLZ2oWBdaIJBAU9Dy3mNktoIVJ
	t/wNFhhsdMhZpDOmSwxOhdy7xIJMZeuvl5zNgTPVqnWxYExWfcOLxbiCHhGU8x0blWW4W/DpbbF
	iimk+A8BhFup0oobhrClREqF2z6LoKsZulC32TUE/WpSEVjEwq0w7NrRTtOM3Fi48rpeY7ihfNO
	cbLi93IIFtnK17MvdLURc4i0zHnJPHD4jTvnDq00SezDIM+eHnc/vGMBYSsjQNufr5nYkrRNTWz
	B5/HusBSwMeBEVnJGzc/XLl4oo44ecyXGoyVKDf3w6VtjF4VowAQkuGZr42MRwObCzQJHhlAEqK
	0TTe0U8tgXpK4W2xVea+gxNCCzWOrfM9oOk9FhEQ==
X-Received: by 2002:a17:903:1a27:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2beb0758412mr197212355ad.15.1779796412391;
        Tue, 26 May 2026 04:53:32 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d6ff:7a7e:f223:7f2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dd75bsm163399345ad.69.2026.05.26.04.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:53:31 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	Pengfei Li <lipengfei28@xiaomi.com>
Subject: [RFC PATCH v3 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Tue, 26 May 2026 19:52:42 +0800
Message-Id: <cover.1779769138.git.lipengfei28@xiaomi.com>
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

Hi Masami, Steven, all,

This is v3 of the ftrace stackmap series. It addresses the Sashiko
review on v2 [1] that Masami pointed out.

[1] https://sashiko.dev/#/patchset/20260522104017.1668638-1-lipengfei28%40xiaomi.com

The series adds stack trace deduplication to ftrace. When the
stacktrace option is enabled, the ring buffer stores a 4-byte
stack_id instead of a full kernel stack trace, while the full
stacks are exported via tracefs.

Rebased onto v7.1-rc5 (e8c2f9fdadee) before sending.

Changes since v2
================

Patch 1 (lock-free stackmap):
  - Hot-path counters changed from atomic64_t to per-CPU local_t.
    This avoids the raw_spinlock_t fallback that atomic64_t uses on
    32-bit GENERIC_ATOMIC64, which would deadlock from NMI context.
  - reset() now serializes against tracefs readers via an
    rw_semaphore (held for write during the clearing memset, held
    for read by seq_file iteration and bin snapshot construction).
    synchronize_rcu() alone was insufficient because seq_file/bin
    readers are in process context, not preempt-disabled.
  - get_id() uses atomic_read_acquire() on smap->resetting so
    subsequent loads of entry->key/val are properly ordered after
    the check (LKMM control dependencies only order stores).
  - All plain reads of entry->key now use READ_ONCE() to avoid
    LKMM data races with the cmpxchg writer.
  - val->nr in the hot path now uses READ_ONCE() to keep style
    consistent with the seq_show / bin_open readers.
  - stackmap_seq_next() now updates *pos past map_size on EOF so
    seq_read() terminates instead of looping on the last element.
  - Added a comment in the cmpxchg-claim path documenting that
    two CPUs racing with the same key_hash may produce a small
    number of duplicate entries; this is an accepted trade-off
    for keeping the hot path lock-free.
  - Removed BUG_ON in create path (the constraint is satisfied by
    construction; no runtime check needed).

Patch 2 (integration):
  - 'stackmap' is added to TOP_LEVEL_TRACE_FLAGS and
    ZEROED_TRACE_FLAGS so the option is only exposed under the
    top-level trace instance, matching the convention used for
    other global-only options such as 'printk' and 'record-cmd'.
    Secondary instances under tracing/instances/*/ no longer see
    the option at all, instead of seeing it as a silent no-op.
  - TRACE_STACK_ID added to trace_valid_entry() in trace_selftest.c
    so ftrace startup selftests don't reject the entry type.
  - Corrected a comment about how global_trace.stackmap is
    zero-initialized (BSS, not kzalloc).

Patch 3 (docs / selftest / tooling):
  - Selftest now reads trace contents BEFORE switching back to the
    nop tracer (tracer_init() calls tracing_reset_online_cpus()
    which would have emptied the ring buffer).
  - Added 'function:tracer' to the selftest '# requires:' line so
    ftracetest skips when CONFIG_FUNCTION_TRACER is disabled
    instead of failing spuriously.
  - Selftest grep tightened to '<stack_id' to avoid future
    false-positives if any other tracepoint name contains
    "stack_id".
  - New stackmap-instance-gate.tc selftest asserts the option and
    stack_map* nodes are present on the global instance and absent
    on a freshly-created secondary instance, locking in the
    TOP_LEVEL_TRACE_FLAGS gating behavior introduced in patch 2.
  - Documentation Performance section made vendor-neutral
    ("aarch64 SMP system" instead of a specific device name) and
    the term "Hit rate" replaced with "Dedup rate" to match the
    actual stat field name (success_rate).
  - Documentation Design section now states that deduplication is
    best-effort under heavy contention (cmpxchg races may produce
    a small number of duplicate entries for the same stack), so
    users observing entries > unique-stacks have a documented
    explanation.

Test results
============

Device: Xiaomi SM8850 (ARM64), Android 16, kernel 6.12 (OGKI)
Config: CONFIG_FTRACE_STACKMAP=y, bits=14 (16384 elts, 32768 slots)
Method: 5-second capture with stacktrace trigger

Functional tests (all PASS):
  - tracefs nodes (stack_map / stack_map_stat / stack_map_bin) exist
  - options/stackmap writable, trace shows <stack_id N>
  - stack_map text export with correct symbols
  - reset clears entries when tracing stopped
  - reset rejected (-EBUSY) while tracing active
  - per-event trigger: only specified events get stacks

Performance (sched_switch, 5s):
  entries:       466 / 16384
  successes:     9159
  drops:         0
  success_rate:  100%
  dedup rate:    95.2% (466 unique stacks / 9625 total events)

Performance (kmem_cache_alloc, 5s):
  entries:       1177 / 16384
  successes:     60078
  drops:         0
  success_rate:  100%
  dedup rate:    98.1% (1177 unique stacks / 61255 total events)

Ring buffer space savings:
  Event               Full stack         Stackmap           Saving
  ----------------    ---------------    ---------------    ------
  sched_switch        9625 × 88B=847KB   12B×9625+88B×466=156KB   82%
  kmem_cache_alloc    61255×88B=5.4MB    12B×61255+88B×1177=839KB  85%

QEMU validation (v3 base: v7.1-rc5)
===================================

The series boots cleanly on aarch64 QEMU. A post-init smoke test
(12/12 PASS) verified all functional behaviors including:
- tracefs nodes appear with correct file modes
- stack_id events emitted, kernel symbols resolve correctly
  (e.g. __schedule+0x7cc/0x1138)
- reset rejected with -EBUSY while tracing is active
- reset clears the map when tracing is stopped
- per-CPU local_t counters aggregate correctly across CPUs
- stack_map_bin magic correct (0x464D5342 'FSMB')
- 'stackmap' option visible on the global instance, hidden on
  secondary instances under tracing/instances/*/

Boot-time activation via 'trace_options=stackmap,stacktrace' works:
events that fire before stackmap initialization fall back to
recording full stack traces; later events are deduplicated. No
events are dropped due to the transition.

Known limitations
=================

- Per-instance stackmap support is not included in this series.
  Following the convention used for other global-only options
  (PRINTK, RECORD_CMD), the 'stackmap' option is gated to the
  top-level trace instance via TOP_LEVEL_TRACE_FLAGS, so it is
  not exposed under tracing/instances/*/options/. Per-instance
  maps would be a follow-up.
- The element pool is allocated eagerly at fs_initcall when
  CONFIG_FTRACE_STACKMAP=y, regardless of whether userspace will
  ever enable the option. At the default bits=14 this is roughly
  8 MB of vmalloc; at the maximum bits=18, ~135 MB. The eager
  allocation keeps the hot path entirely allocation-free and
  avoids any allocation-failure path under tracing pressure.
  Lazy allocation on first 'echo 1 > options/stackmap' is a
  reasonable follow-up if maintainers prefer that trade-off.
- Deduplication is best-effort, not strict: under heavy
  concurrent contention two CPUs racing in the insert path with
  the same stack hash may each succeed in claiming a different
  slot, producing a small number of duplicate entries for the
  same stack. ref_count is then split across the duplicates.
  This is intentional: it keeps the hot path lock-free and
  bounds memory by the element pool size.
- The stackmap currently covers kernel stacks only.
- stack_map_bin is a best-effort snapshot, not a fully atomic export.
- trace-cmd / libtraceevent integration is left for follow-up once
  the binary format settles.

Usage
=====

  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace


Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 162 ++++
 Documentation/trace/index.rst                 |   1 +
 kernel/trace/Kconfig                          |  22 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  78 +-
 kernel/trace/trace.h                          |  16 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_selftest.c                 |   1 +
 kernel/trace/trace_stackmap.c                 | 780 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  57 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 103 +++
 .../test.d/ftrace/stackmap-instance-gate.tc   |  42 +
 tools/tracing/stackmap_dump.py                | 150 ++++
 14 files changed, 1449 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
 create mode 100755 tools/tracing/stackmap_dump.py

-- 
2.34.1

