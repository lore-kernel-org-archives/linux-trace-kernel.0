Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900977;
	b=t7fxDUS6pvXWK3izDlTlEVBtoNwP/RZgEt5uaQ1AeMVJ1RQ+e03RX/VJDHeTcJXVsmg4
	 oWrlmdbta/qWdqPjNWh7dh+eYTSnD3ifVrQlAdcfEMhFRlIkrLi4FniI9KPZt5SqgvJai
	 H4TIFzsZi+2zRouQomy/dRXVt2Xasu3WDhNId4llR4Y6HlXPAnc2wWp24Jpn5ElFAVaGn
	 Pdzk0PWVElxxg4hJGczTG5dvUq8/PnHIdYjQIN1r5VkEJe6F1kHF3Omn2Y5u7yKEMp9Jq
	 hEF1PqisCx86+lo/1Q37DLNPXkoIZz0fdtgHoWvP+HcXAFYQCOCBiF4naKXmWSuRXQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900977;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=O6rdcFIWEGfMi9DEa3RyFdTLRhmm3qmV9KabimJJxgM=;
	b=NutQ2vueZNVhR6AEVa0xkCXgFDlnePA62yokn6CtD1zWpC5p4br2yLJo3SsuWKa2I/t+
	 8EnxuN24PSuX/6IC6o7alMfOiRUh9Xv8dzuoYBoyMVb7OQ65BV4z6k3XFupfiWySXmVDX
	 LIjO3SIovuhnQJW5yCUZaC0ndi7t7aNP4RMazwVfDHoB6knpdCILBSNLpWM6y3Rf04aOu
	 WXSR9WfzL/KRePFK9DpIfaJ5ObbY9vxoLyO+cqZnIXyixe4HDEEa53o4XhNTr7PECCI6W
	 tMqIi0vKE5vK/rWoCXaJblh7oRGriqtpdJ/1BNOZwSPk3jWX7QX94U3HdWrC+vQTWIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AYqoYDTb;
	arc=none smtp.remote-ip=95.215.58.185
Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45334606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45334606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AYqoYDTb
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CQoQROxyiHAluxd6tuOEX3ivLeiFIAd3ibNhaXbglXc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793900974; v=1; x=1794505774;
 b=AYqoYDTbN/A18ScczY1lGxAcGen0nDt2MtEI93ANl2jxf9/v90CiC5cSHWmhl7hVDRlSny/e
 URoP34iWPF5BwWNkDnHkRwVeykCsOlc1cterGwBzo/EmOe7geT3clQS5ggiN/u01rnO5r6z6aep
 dc27YE5EGA8iGDJqVfxiAeAA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2815e8c7a8e653f7;
	Thu, 05 Nov 2026 17:49:34 +0000
X-Mizu-Trace-ID: 2815e8c7a8e653f7
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 00/14] rv: Add task latency over budget RV monitor
Date: Fri,  6 Nov 2026 01:49:00 +0800
Message-Id: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

This series introduces tlob (task latency over budget), a per-task
hybrid automaton RV monitor that measures elapsed wall-clock time across
a user-delimited code section and emits an error when the elapsed time
exceeds a configurable budget.

The monitor tracks four states (running, waiting, sleeping, stopped)
driven by sched_switch and sched_wakeup tracepoints. A single clock
invariant, clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
(HRTIMER_MODE_REL_HARD). On expiry error_env_tlob is emitted; which
phase consumed the budget (running, waiting or sleeping) is recovered
from event_tlob in user space (see monitor_tlob.rst).

Tasks are registered for monitoring by writing to the tracefs monitor
file:
  echo "p:myregion /path/to/binary:OFFSET_START OFFSET_STOP threshold=NS" \
       >> /sys/kernel/tracing/rv/monitors/tlob/monitor

Two uprobes delimit the measured section without modifying the target
binary. Multiple uprobe pairs can be active simultaneously. A task may
repeat the START/STOP sequence any number of times: the entry parks in
the automaton's "stopped" state and restarts in place, reusing the
same pre-allocated slot.

Changes in v8
=============
This version is a comprehensive rework addressing Gabriele Monaco's
review on v7, with substantial simplifications to both framework
support and the tlob monitor itself:

1. HA timer teardown and underflow fixes (Patches 1-5):
   - Deleted ha_timer_ready() completely. Following Gabriele's
     suggestion, ha_monitor_free_env() now checks da_monitoring() to
     disarm the hrtimer on the storage free path (Patch 4).
   - Isolated the HA underflow and timer free path KUnit tests into a
     dedicated compilation unit (kernel/trace/rv/rv_ha_kunit.c) guarded
     by CONFIG_RV_HA_MONITOR, avoiding polluting rv_monitors_test.c
     (Patches 3, 5).

2. Framework per-object storage improvements (Patches 6-8):
   - Added DA_OBJ_EMBEDDED_TYPE support based on Gabriele's PoC.
     Per-object DA storage can now directly embed monitor-specific
     target data inside struct da_monitor_storage, completely eliminating
     secondary dynamic memory allocations and double pointer dereferences
     (Patch 8).
   - Added smp_store_release/smp_load_acquire memory barriers between
     da_storage_set_target() and da_storage_is_empty(), and ensured
     da_get_target() returns NULL if the storage slot is not yet filled.

3. Generic uprobe helper infrastructure (Patch 9):
   - Extracted reusable rv_uprobe registration and synchronization
     helpers into include/rv/rv_uprobe.h and kernel/trace/rv/rv_uprobe.c.

4. Major tlob simplification (Patch 11):
   - Reduced tlob.c from ~1065 lines to ~660 lines (-38% code size).
   - Completely removed the private mempool (tlob_record_pool) and custom
     allocator; tlob now relies entirely on the framework's pre-allocated
     storage via DA_MON_POOL_SIZE.
   - Removed the parallel state machine (OPEN, CLOSED, RETIRED) and
     tlob_binding_lock. Window lifecycle is now 100% managed by the
     automaton states and framework storage lifecycle.
   - Replaced complex quiesce/reap/RCU callouts with a clean RCU walk
     (tlob_release_binding()) executed after rv_uprobe_unregister_sync().
   - Optimized timer re-arming on the scheduler hot path.
   - Refined error semantics: nested START is detected as an illegal event
     (running x start) and reported via error_tlob without altering the
     running window; pool exhaustion cleanly returns -ENOSPC.

5. Test coverage and selftests expansion (Patches 12-14):
   - Added 3 new selftests covering critical edge cases:
     * uprobe_task_exit.tc: verifies task exit/SIGKILL inside an active
       window disarms the timer with no orphaned/late violations.
     * uprobe_nested_start.tc: verifies nested START reporting and
       window integrity.
     * uprobe_pool_exhausted.tc: verifies the 64-task cap and graceful
       rejection of the 65th task.
   - Extended tlob_target with "nest" mode.
   - All 13 selftests and all KUnit test suites pass cleanly.

Series structure
================

Part 1: Independent fixes and enhancements to the RV/HA framework
  Patch 1: rv: Force environment reset action on HA monitor start
  Patch 2: rv: Fix ha_monitor timer and invariant underflow
  Patch 3: rv: Add a KUnit test for the HA timer underflow
  Patch 4: rv: Disarm HA timers on the storage free path
  Patch 5: rv: Add a KUnit test for the storage free path
  Patch 6: rv: Make da_monitor_reset_hook, sync_hook and EVENT_NONE_LBL
           overridable
  Patch 7: rv: Introduce DA_MON_ALLOCATION_STRATEGY
  Patch 8: rv: Support embedded target types in per-object DA storage
  Patch 9: rv: Add generic uprobe infrastructure for RV monitors

Part 2: The tlob monitor and models
  Patch 10: rv: Add tlob model DOT file
  Patch 11: rv: Add tlob hybrid automaton monitor

Part 3: Testing and selftests
  Patch 12: rv: Add KUnit tests for the tlob monitor
  Patch 13: selftests/verification: Add tlob selftests
  Patch 14: selftests/ftrace: Walk up parent dirs to find test.d/functions

v7: https://lore.kernel.org/all/cover.1791745088.git.wen.yang@linux.dev/
v6: https://lore.kernel.org/all/cover.1787243842.git.wen.yang@linux.dev/
v4: https://lore.kernel.org/all/cover.1783524627.git.wen.yang@linux.dev/
v3: https://lore.kernel.org/all/cover.1780847473.git.wen.yang@linux.dev/
v2: https://lore.kernel.org/all/cover.1778522945.git.wen.yang@linux.dev/
v1: https://lore.kernel.org/all/cover.1776020428.git.wen.yang@linux.dev/

Gabriele Monaco (1):
  rv: Force environment reset action on HA monitor start

Wen Yang (13):
  rv: Fix ha_monitor timer and invariant underflow
  rv: Add a KUnit test for the HA timer underflow
  rv: Disarm HA timers on the storage free path
  rv: Add a KUnit test for the storage free path
  rv: Make da_monitor_reset_hook, sync_hook and EVENT_NONE_LBL
    overridable
  rv: Introduce DA_MON_ALLOCATION_STRATEGY
  rv: Support embedded target types in per-object DA storage
  rv: Add generic uprobe infrastructure for RV monitors
  rv: Add tlob model DOT file
  rv: Add tlob hybrid automaton monitor
  rv: Add KUnit tests for the tlob monitor
  selftests/verification: Add tlob selftests
  selftests/ftrace: Walk up parent dirs to find test.d/functions

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_tlob.rst       | 162 ++++
 include/rv/da_monitor.h                       | 226 +++++-
 include/rv/ha_monitor.h                       |  53 +-
 include/rv/rv_uprobe.h                        |  35 +
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   2 +-
 kernel/trace/rv/monitors/opid/opid.h          |   1 +
 kernel/trace/rv/monitors/tlob/Kconfig         |  12 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 743 ++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          | 143 ++++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    | 151 ++++
 kernel/trace/rv/monitors/tlob/tlob_kunit.h    |  18 +
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |  20 +
 kernel/trace/rv/rv_ha_kunit.c                 | 201 +++++
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 kernel/trace/rv/rv_trace.h                    |   1 +
 kernel/trace/rv/rv_uprobe.c                   |  56 ++
 tools/testing/selftests/ftrace/ftracetest     |  19 +-
 .../testing/selftests/verification/.gitignore |   1 +
 tools/testing/selftests/verification/Makefile |   4 +
 tools/testing/selftests/verification/config   |   3 +
 .../selftests/verification/test.d/functions   |   9 +
 .../test.d/tlob/run_tlob_tests.sh             |  32 +
 .../verification/test.d/tlob/uprobe_bind.tc   |  47 ++
 .../test.d/tlob/uprobe_disable_live.tc        |  79 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |  58 ++
 .../test.d/tlob/uprobe_multi_instance.tc      |  65 ++
 .../test.d/tlob/uprobe_nested_start.tc        |  62 ++
 .../test.d/tlob/uprobe_no_event.tc            |  17 +
 .../test.d/tlob/uprobe_overlap_register.tc    |  66 ++
 .../test.d/tlob/uprobe_pool_exhausted.tc      |  75 ++
 .../test.d/tlob/uprobe_restart.tc             |  66 ++
 .../test.d/tlob/uprobe_restart_violation.tc   |  48 ++
 .../test.d/tlob/uprobe_task_exit.tc           |  65 ++
 .../test.d/tlob/uprobe_unbind_live.tc         |  65 ++
 .../test.d/tlob/uprobe_violation.tc           |  53 ++
 .../selftests/verification/tlob_target.c      | 156 ++++
 tools/verification/models/tlob.dot            |  27 +
 tools/verification/rvgen/rvgen/dot2c.py       |   2 +
 41 files changed, 2829 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_ha_kunit.c
 create mode 100644 kernel/trace/rv/rv_uprobe.c
 create mode 100755 tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_nested_start.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_pool_exhausted.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_task_exit.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
 create mode 100644 tools/testing/selftests/verification/tlob_target.c
 create mode 100644 tools/verification/models/tlob.dot

-- 
2.25.1

