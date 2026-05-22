Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C283CB90A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446475; cv=none; b=LqogEEpihhgD5gq+Th/OAdLGkLXQYwaMSAwkw+b9PFR4kfDX79N1CMxGs/J+kI9ZxElAlvkupSr0UtSw1l0pzL3EqqwrmGHWjmN+4KAPqTUf7xHUvJopZmbb0WEFJWBRKkDTICA5mx+hvt+jDnH+qVDvu6GsnXcu7YU8c5EyB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446475; c=relaxed/simple;
	bh=0e8ZGY7FJO+d5GxC/6DsZaMX2EIrEtVFlsT8k/tHiMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQ3zVpsRAnkpD8zPNWgOSdCeH7+vo2j91txfU/3059tJMEcOGgJM2Uk/QTSaEbrf4y2E53BL0oYlubli9YzwFh/UdGCNOs8zupw+xSWgjAtSqRwvstHFTusCnuHoEaJcdJ/m4cTF6kPHoocLp7Z7hgkMZPa8dUz0PW5yDpwlIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdJgwr/f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdJgwr/f"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36a3dd2e66eso1340302a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446468; x=1780051268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgASa1gifaoNlWq5HdbACRgqivV723D/xAJbdWOyHfU=;
        b=OdJgwr/fXBLixMeS4LlYHpRLiIbep4gpImb1Mdgu2OzrjlkY3LgTd4eEXP4VS9YFBX
         /r27MpqdyT7mdOI2YhTNKnhBV6RqXZts6aiZYOuCt/4+Wp4YC8OgaGn1cM3X4jlrY0fw
         B45Jh1plPLqm05Yi7eCm7oAH7+9mGw4h+8zWEsToKf7BMyYD+zYVkqh6Upv9LlDao4L7
         INvEr+1vMsUFyRBs0jvewH+SSUvzc+uBAR4yh1p1p/Y8RJSK/PZmZkv9tGPzrYMw+0mD
         g6Sp3uIMY8IK4YmpT4ffQdkuIdsErsB/G4KyjqLOM5AKMh5nUrxZ/x9BXzEC9jEKpjzK
         /5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446468; x=1780051268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgASa1gifaoNlWq5HdbACRgqivV723D/xAJbdWOyHfU=;
        b=D46gbu35fq/EtFUMj87lq6OHpFcyiyWcOKNUEnXzS1pQDmM1yTZ3T3atHn0ncz7r3U
         E33eZIxoOA100gcwktNQO4EbmO72WRdOdUQgVpGtNgXwM+i4+4YB6Qv2MTkg4nAlioEp
         niFuJpQ1Wa0Ke9xpLVDq8EmUP6ilzYwlboXVkv1VNoVLUV/eIXFdPMK40E4KKDJGhYa5
         TAFt7QKrakWZPRPqoEkNDGDpPa/qhGwgxDw3hGDePJTiThiM6W9iT2oEeMCjbbKnRv4o
         FqucOZbHzmhkkNIql8AsT/IuQq1NPAFLV9s1yy0xhLEp7QXFlYK+JqMlWBYyQ3B2x5+2
         enqg==
X-Gm-Message-State: AOJu0YzfP35NntQHlgXGjZGeA7i3FcRB/QVoqJN4uxSDFCrPSHqchF7U
	sDRROlf+UkPWagL6NNP+w3nplywHI7HfNPfa02/LcO2MBZpcu//FLtWiDGqrYA==
X-Gm-Gg: Acq92OGAM4yvq6fPKg9Dc8YSklw4g3Zf8X5BvW4TRqbLoIy+GRf+72ajmEJdFSXZXg4
	YthsOEH824iBrIrw0k3IkDlo68BIudYOM9NijpsymMI/vV+W/iSC7r0eBdJ4kTyHojfDHCb2a8D
	OGj/fBXfps2qU3xGLpO8jjUdk5v9p2Ge2uTM2knXrOXRc62asFL28LxOd2zRM9JEGW5j0StpaLG
	h8tU8/7AjcwvmFp3oDaMHmiNU16e0l7a7n5E2NcWHNSNtAR6Tfy1qSv/0gEzAz24C3bDjZaSz4B
	SgqTdX9dfgb110Gok4DjOsqVZd00EslxFUVMqyYBpComjdXVtSUQM8Uv1vExd4M7Fw3Ojd42myg
	BXwAAdp3JhQUaZQx/s06TFqWM7kigUeozsh9lr2jn0rwvDKBokF6ruzNpOID0Xx/U4qdve1R1NH
	U6X46sSzu8/zpdUQTzRb4CvZriu0ZTCI8my9jP/A==
X-Received: by 2002:a17:90b:1c07:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36a674b76d3mr3108771a91.0.1779446468283;
        Fri, 22 May 2026 03:41:08 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:9a21:4fdc:c1a5:7a8e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85200c3feesm1282942a12.0.2026.05.22.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:41:07 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Fri, 22 May 2026 18:40:14 +0800
Message-Id: <20260522104017.1668638-1-lipengfei28@xiaomi.com>
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

Hi Steven, all,

This is v2 of the ftrace stackmap series. It addresses the Sashiko
review at [1] and incorporates the kernel test robot's toctree fix.

The series adds stack trace deduplication to ftrace. When the
stacktrace option is enabled, the ring buffer stores a 4-byte
stack_id instead of a full kernel stack trace, while the full
stacks are exported via tracefs.

Problem
=======

With stacktrace enabled, each trace event stores a full kernel
stack (typically 10-20 frames x 8 bytes = 80-160 bytes). On
production devices with 4-8 MB trace buffers, this fills the
buffer in seconds, limiting the usefulness of boot-time tracing
and always-on performance monitoring.

Design
======

The implementation is a lock-free hash map modeled after
tracing_map.c, as suggested by Steven [2]:

- lock-free insert via cmpxchg, safe in NMI/IRQ/any context
- pre-allocated element pool, so there is no allocation on the hot path
- linear probing with a 2x over-provisioned table
- bounded probe length to keep worst-case lookup/insert cost bounded
- currently implemented for the global trace instance

The ring buffer stores only stack_id. Full stacks are exported via:

  /sys/kernel/debug/tracing/stack_map
  /sys/kernel/debug/tracing/stack_map_stat
  /sys/kernel/debug/tracing/stack_map_bin

Reset semantics
===============

Reset is treated as a control-path operation and is only supported
when tracing is stopped on the owning trace_array. Online reset is
intentionally not supported.

The reset path:
- atomically claims reset rights via cmpxchg
- rejects reset with -EBUSY if tracing is active
- blocks new get_id() callers via the resetting flag
- waits for in-flight ftrace callback paths with synchronize_rcu()
- clears the map and releases resetting with release semantics

Why not reuse tracing_map.c
===========================

This series follows the same overall lock-free approach, but uses a
purpose-built structure. tracing_map.c is designed for histogram-style
aggregation with fixed-size keys and value fields, while this use case
needs variable-length stack storage plus reference counting.

Why not reuse BPF stackmap
==========================

BPF_MAP_TYPE_STACK_TRACE addresses a similar problem, but requires a
BPF program and the BPF runtime. This series keeps the functionality
inside ftrace and available without CONFIG_BPF.

Unlike BPF stackmap, which may replace entries on collision, this
design keeps stack_id stable once assigned, which is important because
ring buffer events may reference that stack_id long after insertion.

Test results
============

Platform: ARM64 Qualcomm SM8850 (8 cores), kernel 6.12, bits=14,
tracing sched_switch + kmem_cache_alloc with stacktrace trigger,
5-second capture, default ring buffer.

Per-event payload (measured from tracing stats):

  Event                    Full stack    Stackmap    Reduction
  ---------------------    ----------    --------    ---------
  sched_switch             102 B/entry   48 B/entry    -53%
  kmem_cache_alloc         111 B/entry   44 B/entry    -60%

In the same 5-second capture window, the smaller per-event footprint
translated to many more retained events before wraparound. For
sched_switch:

  - without stackmap:      43,950 retained entries
  - with stackmap:      1,710,044 retained entries

During the same runs, the stackmap observed a few thousand unique
stacks and no drops.

Boot-time activation is also supported via:

  trace_options=stackmap,stacktrace

Events that occur before stackmap initialization fall back to full
stack traces; later events are deduplicated. This transition does
not itself drop events, but early boot stacks recorded before
initialization are not deduplicated.

QEMU validation
===============

The series also runs cleanly in QEMU on aarch64 (mainline,
qemu-system-aarch64, 2 vCPU, virt machine, busybox initrd).

A post-init smoke test verified:
- stack_map, stack_map_stat, stack_map_bin, and options/stackmap exist
- enabling stackmap + stacktrace produces stack_id events
- stack_map_stat shows non-zero successes and zero drops
- reset is rejected with -EBUSY while tracing is active
- reset clears the map when tracing is stopped
- stack_map_bin magic is correct

Changes since RFC v1
====================

- tightened reset semantics: reset now requires tracing to be stopped
  and returns -EBUSY if tracing is active or another reset is in progress
- fixed publication/consumption ordering with smp_store_release() /
  smp_load_acquire()
- bounded probe length and added pool-exhaustion fast-path handling
- moved hash_seed into struct ftrace_stackmap
- switched the element pool to a single flat vmalloc allocation
- bounded bits range to [10, 18] to limit worst-case memory usage
- fixed TRACE_ITER(STACKMAP) handling
- tightened stack_map reset input parsing
- renamed stat counters to "successes" / "success_rate" so the meaning
  is unambiguous (counts events served, including first-time inserts)
- added documentation, selftest coverage, and userspace dump tooling

Known limitations
=================

- Per-instance stackmap support is not included in this series.
- The stackmap currently covers kernel stacks only.
- stack_map_bin is a best-effort snapshot, not a fully atomic export.
- trace-cmd / libtraceevent integration is left for follow-up once the
  binary format settles.

Usage
=====

  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace

[1] https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260514034916.2162517-1-lipengfei28%40xiaomi.com
[2] https://lore.kernel.org/all/20260513085145.30dd23e0@fedora/

Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 145 ++++
 Documentation/trace/index.rst                 |   1 +
 kernel/trace/Kconfig                          |  21 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  66 ++
 kernel/trace/trace.h                          |  16 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_stackmap.c                 | 643 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  56 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    | 100 +++
 tools/tracing/stackmap_dump.py                | 150 ++++
 12 files changed, 1237 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h
 create mode 100755 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100755 tools/tracing/stackmap_dump.py

-- 
2.34.1
