Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76A30D40C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163356; cv=none; b=GGoRgsrCu3fxnGxrQcfiHldRCAhzPYvZgYGE9yI0epNMxLy4K8x33ZwK6lxsNCNblI9PdMFbnSlfA+YggzvvmWNAcza90AAnSU0sE5F20pYEBt73L4v/JUoOhsOh+OR777hBuJ4kRA1JfrUBTV4hF/gJQWw0vnsSrAiZhGEcozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163356; c=relaxed/simple;
	bh=k4nFGdPytI9WbI/m8Uo4HPJsR1vDeK5EbpWQ/JEsp44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CLJLS2dxKrlfTQL9CxdQ9VRBcsrKjaiI45bvDe7R656WjFRyf4SQcSASVoVzciWoPPzyZu/wdtRy/r+rz95sSLdNzFTnirpjEg/HaIdnoDgb+di+k41ZgkBJq6V0wXWIOSVrdmrlQp7qpEe76DbDrH6cWUgnfHmX822YU6WdBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vzxz8N55; arc=none smtp.client-ip=95.215.58.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vzxz8N55"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k4nFGdPytI9WbI/m8Uo4HPJsR1vDeK5EbpWQ/JEsp44=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163349; v=1; x=1787768149;
 b=Vzxz8N55SykzNUG/hgEL6KZw7AJQitPZ01wetFn1BIieUNlNjV5H1oEHYn1dXW13c10Q2J0V
 twrnuU89cswVmItNJOI26vQUyRHn1UIl61305d82F+zdFKoxYXz85fmqUpw1gSkV0poYGGhcS33
 1T5yNdNaVDAwY9SVs7rAPqJU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 28acc0e3e6b22510;
	Wed, 19 Aug 2026 18:15:49 +0000
X-Mizu-Trace-ID: 28acc0e3e6b22510
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 0/9] rv: Add task latency over budget RV monitor
Date: Thu, 20 Aug 2026 02:15:17 +0800
Message-Id: <cover.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

This series introduces tlob (task latency over budget), a per-task
hybrid automaton RV monitor that measures elapsed wall-clock time across
a user-delimited code section and emits an error when the elapsed time
exceeds a configurable budget.

The monitor tracks three states (running, waiting, sleeping) driven by
sched_switch and sched_wakeup tracepoints.  A single clock invariant,
clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
(HRTIMER_MODE_REL_HARD).  On expiry, error_env_tlob is emitted, followed
by detail_env_tlob carrying a per-state time breakdown (running_ns,
waiting_ns, sleeping_ns).

Tasks are registered for monitoring by writing to the tracefs monitor
file:

  echo "p /path/to/binary:OFFSET_START OFFSET_STOP threshold=NS" \
       > /sys/kernel/tracing/rv/monitors/tlob/monitor

Two uprobes delimit the measured section without modifying the target
binary.  Multiple uprobe pairs can be active simultaneously.  A task may
repeat the START/STOP sequence any number of times: the entry parks in
the automaton's "stopped" state and later restarts in place, reusing the
same pool slot (see Patch 6).

Series structure
----------------
Patch 1: rv: Introduce DA_MON_ALLOCATION_STRATEGY
  Compile-time allocation strategy selector for per-object DA storage:
  DA_ALLOC_AUTO (default kmalloc), DA_ALLOC_POOL (pre-allocated mempool),
  DA_ALLOC_MANUAL (caller-managed).  DA_MON_POOL_SIZE alone selects pool
  mode.

Patch 2: rv: Add generic uprobe infrastructure for RV monitors
  Thin wrapper over uprobe_consumer for path resolution, registration,
  and safe synchronous teardown.  struct rv_uprobe embeds
  uprobe_consumer directly and holds the probed binary's path for its
  lifetime, avoiding a separate heap allocation per probe.

Patch 3: rv: Add tlob model DOT file
  Graphviz DOT specification of the tlob hybrid automaton.

Patch 4: rv: Fix ha_invariant_passed_ns silent bypass of invariant check
  Without this fix, ha_invariant_passed_ns() returns 0 on first call and
  leaves env_store at U64_MAX.  Every subsequent state transition resets
  the hrtimer to the full budget instead of the remaining time, so the
  budget never expires for tasks that transition between states.  This
  causes tlob's detail_sleeping and detail_waiting selftests to hang.

  This patch is a minimal fix in the current dual-representation
  framework.  Nam's series [1] refactors ha_monitor.h to a
  single-representation model; once it lands, tlob will need to be
  updated to the new API and this patch will be superseded by Gabriele's
  planned framework-level initialisation improvement.  We carry it here
  to keep the series self-contained and testable.

  [1] https://lore.kernel.org/lkml/08188c28f274da63a3f8549add3086a92aef45e5.1780908661.git.namcao@linutronix.de

Patch 5: rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  #ifndef guards for da_monitor_reset_hook and EVENT_NONE_LBL.

Patch 6: rv: Add tlob hybrid automaton monitor
  Main tlob implementation, including the parked-window redesign
  described below.

Patches 7-9: Tests
  KUnit tests for the uprobe-line parser; eight ftrace-style selftests
  for tlob; the ftracetest walk-up change needed to run them from the
  verification subdirectory.

Changes since v4
----------------
Series-wide:
- Subject tags normalized to a single "rv:" prefix (was rv/da:, rv/ha:,
  rv/tlob:) with summary words capitalized, matching the trace
  subsystem style
- Comments tightened throughout all patches: narrative prose and
  duplicated explanations removed, concise technical comments kept
- The ftracetest walk-up change (previously folded into the selftests
  patch) is split out as its own final patch, per Gabriele's suggestion;
  the series now has 9 patches

Patch 1 (DA storage):
- Pool storage redesigned from the lock-free llist stack to a
  pre-allocated mempool: mempool_init_kmalloc_pool() pre-allocates all
  slots at init and mempool_alloc_preallocated() pops one without
  touching the allocator, bounding start latency and returning -ENOSPC
  when exhausted; mempool_free() is safe from RCU-callback context
- da_extra_cleanup() hook added so per-object monitors can release
  pool-backed storage; the pool is torn down only after rcu_barrier()

Patch 2 (uprobe):
- struct rv_uprobe keeps a struct path (not an inode pointer) to the
  probed binary; the path is held from registration until after the sync
  barrier and released with path_put(), since uprobe_register() takes no
  inode reference of its own

Patch 6 (tlob): parked-window redesign
- The automaton gains a "stopped" state (see tlob.dot): ending a window
  (STOP uprobe, budget-timer expiry) no longer frees the entry; it stays
  parked in the hash table, and repeated START/STOP of the same region
  restarts in place, reusing the pool slot, hash entry and task_struct
  reference (no allocation, no get_task_struct, no hash churn)
- ws->stopping is now per-window (cleared on restart) while final
  teardown is claimed per-task through ws->destroying; the monitor
  disable path switches its claim to destroying as well
- Per-binding started_list plus tlob_unbind_reap(): removing a binding
  destroys tasks currently parked under it and detaches active ones,
  closing the leak where parked tasks lingered until exit
- Pool slots fenced at TLOB_MAX_MONITORED and backed by the mempool;
  fresh starts past the cap return -ENOSPC
- __tlob_acc() gates on stopping so scheduler events never reach a
  parked task (hence no "stopped" self-loops in the model)
- tlob_stop_task() now takes the firing binding and rejects (-EALREADY)
  a STOP that does not own the active window, so nested monitored
  regions cannot truncate a window mid-flight; task-exit cleanup passes
  NULL to skip the check, symmetric with the restart check

Patch 8 (selftests):
- uprobe_restart.tc added: drives the target through START/STOP twice in
  a loop, checking the second start restarts the parked window, plus an
  unbind-while-parked scenario leaving no stale state
- Test helpers moved out of test.d/tlob/ into the verification test
  root as tlob_sym.c / tlob_target.c; the per-directory Makefile is no
  longer needed
- The verification Makefile now follows the standard lib.mk selftest
  layout (TEST_GEN_FILES := tlob_sym tlob_target, export
  VERIFICATIONTEST_BINDIR := $(OUTPUT)); the original empty all: target
  is kept, so the diff over the base Makefile is exactly those two
  lines.  tlob_sym resolves ELF symbols in C, so the tests run without
  any binutils dependency.

Testing
-------
Environment: x86_64, CONFIG_PREEMPT_RT=y, kernel built with virtme-ng
(vng --build), selftests built on the host and run inside the VM:
- KUnit test suite: tlob uprobe-line parser tests
- 8 ftrace-style selftests: uprobe_bind, uprobe_violation,
  uprobe_no_event, uprobe_multi, uprobe_detail_{running,sleeping,
  waiting}, uprobe_restart
Both suites pass.  The pre-existing rv_* tests in the same directory
keep passing as well.

v4: https://lore.kernel.org/all/cover.1783524627.git.wen.yang@linux.dev/
v3: https://lore.kernel.org/all/cover.1780847473.git.wen.yang@linux.dev/
v2: https://lore.kernel.org/all/cover.1778522945.git.wen.yang@linux.dev/
v1: https://lore.kernel.org/all/cover.1776020428.git.wen.yang@linux.dev/

Wen Yang (9):
  rv: Introduce DA_MON_ALLOCATION_STRATEGY
  rv: Add generic uprobe infrastructure for RV monitors
  rv: Add tlob model DOT file
  rv: Fix ha_invariant_passed_ns silent bypass of invariant check
  rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  rv: Add tlob hybrid automaton monitor
  rv: Add KUnit tests for the tlob monitor
  selftests/verification: Add tlob selftests
  selftests/ftrace: Walk up to find test.d/functions when a subdirectory
    is passed

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_tlob.rst       |  194 +++
 include/rv/da_monitor.h                       |  140 +-
 include/rv/ha_monitor.h                       |   13 +-
 include/rv/rv_uprobe.h                        |   90 ++
 kernel/trace/rv/Kconfig                       |    5 +
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/tlob/.kunitconfig    |    5 +
 kernel/trace/rv/monitors/tlob/Kconfig         |   22 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 1134 +++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          |  155 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    |  139 ++
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |   48 +
 kernel/trace/rv/rv_trace.h                    |    1 +
 kernel/trace/rv/rv_uprobe.c                   |   91 ++
 tools/testing/selftests/ftrace/ftracetest     |   17 +-
 .../testing/selftests/verification/.gitignore |    2 +
 tools/testing/selftests/verification/Makefile |    4 +
 .../test.d/tlob/run_tlob_tests.sh             |   20 +
 .../verification/test.d/tlob/uprobe_bind.tc   |   35 +
 .../test.d/tlob/uprobe_detail_running.tc      |   49 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |   48 +
 .../test.d/tlob/uprobe_detail_waiting.tc      |   68 +
 .../verification/test.d/tlob/uprobe_multi.tc  |   59 +
 .../test.d/tlob/uprobe_no_event.tc            |   17 +
 .../test.d/tlob/uprobe_restart.tc             |   75 ++
 .../test.d/tlob/uprobe_violation.tc           |   65 +
 .../testing/selftests/verification/tlob_sym.c |  209 +++
 .../selftests/verification/tlob_target.c      |  138 ++
 tools/verification/models/tlob.dot            |   25 +
 30 files changed, 2860 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c
 create mode 100755 tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
 create mode 100644 tools/testing/selftests/verification/tlob_sym.c
 create mode 100644 tools/testing/selftests/verification/tlob_target.c
 create mode 100644 tools/verification/models/tlob.dot

base-commit: 785095112f4198de49760552374f364043c8dbdf 
-- 
2.25.1

