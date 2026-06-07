Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3832E62AC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848877; cv=none; b=sSqMTHXEeZZw53ZTZhlwxxwLzkEzgQwqmn4C+ux/eql9X4v6T8xC2jlfx8M+I2mDUPmWDGUibHuIan8n5Z1r5mGpFA52ly4E6lrDsf86XJu2w5gz84VQmQ0pPMYHvDIiyDNyHkHUBfSlvT1EoLjMQcgcNmAIUuNDILc0CdsMoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848877; c=relaxed/simple;
	bh=kQss2jpsdOyOJApUpKnOWzX8bjzhu2BLnWvK4Wpemqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=naGtlXikw9RGUQ3mnUaL1J596vBAz9dBpIoOmwSd7oMaNII0SkFuFE8UhDBUbpPNydH5TkdanSvTZKXU5yMOMWOsWgF6IRWvfpJbHu2aHE+sCusOtBBW+vYVrl61kXDKPbGGXxVlDTR+enOcPIlbtCNORFiyr6hsWOPWEbLOWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JnhwhB76; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JnhwhB76"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVK3bM2SqbfQ0HWadz6siMdRn0SzKn276tiFP2Sr4Xw=;
	b=JnhwhB767bl1c2OqeO2ciXFmIKNk0qAT+6OFZTBn1Y2/+dr89y9mQnt+IqVbg4nLwuqpIg
	mgVac1imKwNWIgwmQPJDuN5gyXAwevSOhktGT3gms7kq+pnVj6uRliqIcDF+Jt+0ExKUmz
	fjetDPToBRv+7CIyp/oheMpNakSso+o=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 0/9] rv/tlob: Add task latency over budget RV monitor
Date: Mon,  8 Jun 2026 00:13:48 +0800
Message-Id: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

This series introduces tlob (task latency over budget), a per-task
hybrid automaton RV monitor that measures elapsed wall-clock time across
a user-delimited code section and fires when the time exceeds a
configurable budget.

The series applies cleanly on top of:
  [1] git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-fixes-7.1
      "rv fixes for v7.1"

Background
----------
The existing wwnr monitor uses a two-state DA to detect tasks that are
woken but never run.  tlob extends the RV framework to a three-state
hybrid automaton:

  running  (initial) -- on CPU
  waiting             -- in the scheduler runqueue, not yet on CPU
  sleeping            -- blocked on a lock, I/O, or similar resource

A single HA clock invariant, clk_elapsed < BUDGET_NS(), is active in
all states.  The framework enforces it via a per-task hrtimer.  On
expiry, error_env_tlob is emitted, followed by detail_env_tlob which
carries a per-state time breakdown (running_ns, waiting_ns, sleeping_ns)
that pinpoints whether the overrun occurred in the running, waiting, or
sleeping state.

Userspace interface
-------------------
Tasks are registered for monitoring by writing to the tracefs monitor
file:

  # echo "p /path/to/binary:START_OFFSET STOP_OFFSET threshold=NS" \
        > /sys/kernel/tracing/rv/monitors/tlob/monitor

Two uprobes are registered at START_OFFSET (entry) and STOP_OFFSET
(exit) of the delimited section.  When a task executes the entry uprobe,
the monitor starts; when the task reaches the exit uprobe or the budget
expires, monitoring stops and the slot is returned to the pool.

Multiple uprobe pairs can be registered for the same binary or different
binaries.  Each task can have at most one active monitoring session; if
a task hits a start uprobe while already monitored, the prior session is
cancelled and a new one begins.

Series structure
----------------
Patch 1: rv/da: introduce DA_MON_ALLOCATION_STRATEGY
  Consolidates per-object DA storage allocation under a compile-time
  selector with three strategies:
    DA_ALLOC_AUTO   (default) - lock-free kmalloc_nolock; unbounded
    DA_ALLOC_POOL             - pre-allocated fixed-size pool
    DA_ALLOC_MANUAL           - caller pre-inserts storage

  da_handle_start_event() and da_handle_start_run_event() call
  da_prepare_storage() which resolves at compile time to the correct
  allocation function.

  This patch also includes critical correctness fixes for the pool
  implementation:
  - Add tracepoint_synchronize_unregister() in da_monitor_destroy_pool()
    to fix UAF where in-flight handlers access freed pool storage
  - Fix duplicate hash entry race in da_create_or_get_pool() via
    concurrent-insert detection under RCU
  - Add capacity field to fix build error (DA_MON_POOL_SIZE undeclared
    in da_pool_return_cb)

Patch 2: rv: add generic uprobe infrastructure for RV monitors
  Introduces rv_uprobe, a thin wrapper around uprobe_consumer for RV
  monitors.  Provides rv_uprobe_register(), rv_uprobe_unregister(),
  and rv_uprobe_sync() for safe teardown.

Patch 3: rv/tlob: add tlob model DOT file
  The formal model used to generate tlob.h.

Patch 4: rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
  Fixes a bug where ha_invariant_passed_ns() returned 0 early when
  env_store was invalid (U64_MAX), leaving it at U64_MAX and causing
  ha_check_invariant_ns() to always pass.  The fix calls ha_reset_clk_ns()
  then ha_set_invariant_ns() on first use.

Patch 5: rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  Allows tlob to override EVENT_NONE_LBL for its start_tlob self-loop.

Patch 6: rv/tlob: add tlob hybrid automaton monitor
  The main tlob implementation, including:
  - Three-state HA (running/waiting/sleeping)
  - Per-task hrtimer enforcement (HRTIMER_MODE_REL_HARD)
  - DA_ALLOC_POOL for allocation-free hot path
  - Uprobe registration via tracefs monitor file
  - Per-state time accumulation (running_ns, waiting_ns, sleeping_ns)
  - HIGH_RES_TIMERS dependency in Kconfig

Patches 7-9: Tests
  - KUnit tests for tlob monitor
  - Selftest infrastructure fixes
  - tlob selftests (uprobe binding, state tracking, violation detection)

Changes since v2
----------------
All feedback from Gabriele Monaco has been addressed:

-- Patch 02 (per-task slot ordering / ha_monitor_reset_env):
   Dropped from v3; rebased on top of Gabriele's series [1].

-- Patch 03 (verificationtest-ktap):
   Changed to use realpath for robustness as suggested.

-- Patch 04 (pre-allocated storage pool):
   Complete redesign as DA_MON_ALLOCATION_STRATEGY:
   - Three strategies (AUTO/POOL/MANUAL) via compile-time macro
   - da_monitor_init_prealloc() removed; da_monitor_init() selects
     internally
   - da_create_or_get_kmalloc() removed (no viable use case)
   - nomiss updated to use DA_ALLOC_MANUAL
   - da_extra_cleanup() hook added for per-entry teardown

   Critical bug fixes included in this patch:
   - tracepoint_synchronize_unregister() added to da_monitor_destroy_pool()
     to prevent UAF from in-flight handlers accessing freed pool storage
   - Duplicate hash entry race fixed in da_create_or_get_pool() via
     concurrent-insert detection and slot return under RCU
   - capacity field added to fix DA_MON_POOL_SIZE undeclared build error

-- Patch 05 (generic uprobe infrastructure):
   Carried unchanged into v3.

-- Patch 06 (rvgen __init arrow reset):
   Carried unchanged into v3.

-- Patch 08 (tlob monitor):
   Split and refactored:
   - ioctl interface deferred to follow-up series (tracefs-only in v3)
   - Handler simplification: three inline helpers (tlob_acc_running/
     waiting/sleeping) with scoped_guard(rcu)
   - do_prev/do_next flags removed (da_handle_event skips unmonitored)
   - scoped_guard(rcu) and guard(mutex) applied throughout
   - tlob_stop_all() removed; da_extra_cleanup() hook used instead
   - start_tlob self-loop added to DOT model as suggested
   - ha_setup_invariants() guards against redundant timer restart
   - HIGH_RES_TIMERS dependency added to Kconfig

Additional improvements in v3
------------------------------
Beyond the v2 feedback, this version includes:

1. Simplified tlob monitor implementation:
   - Removed redundant tlob_num_monitored atomic counter
     (da_handle_event already handles unmonitored tasks via hash lookup)
   - Eliminated extra cacheline touch on every sched_switch/sched_wakeup
   - Several repeated pattern simplifications.

2. Extracted common accumulation logic:
   - __tlob_acc() using offsetof() replaces three nearly-identical functions
   - Reduces code duplication while maintaining type safety

3. Complete test coverage:
   - KUnit tests for core functionality
   - Comprehensive selftests for uprobe integration, state tracking,
     and violation detection

Testing
-------
All patches have been tested on:
- x86_64 with CONFIG_PREEMPT_RT
- All KUnit tests pass
- All selftests pass with verificationtest-ktap

  
[1] git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-fixes-7.1
    "rv fixes for v7.1"


Wen Yang (9):
  rv/da: introduce DA_MON_ALLOCATION_STRATEGY
  rv: add generic uprobe infrastructure for RV monitors
  rv/tlob: add tlob model DOT file
  rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
  rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  rv/tlob: add tlob hybrid automaton monitor
  rv/tlob: add KUnit tests for the tlob monitor
  selftests/verification: fix verificationtest-ktap for out-of-tree
    execution
  selftests/verification: add tlob selftests

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_tlob.rst       | 177 ++++
 include/rv/da_monitor.h                       | 276 ++++-
 include/rv/ha_monitor.h                       |  22 +-
 include/rv/rv_uprobe.h                        | 119 +++
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   6 +-
 kernel/trace/rv/monitors/tlob/.kunitconfig    |   6 +
 kernel/trace/rv/monitors/tlob/Kconfig         |  19 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 968 ++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          | 148 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    |  92 ++
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |  49 +
 kernel/trace/rv/rv_trace.h                    |   1 +
 kernel/trace/rv/rv_uprobe.c                   | 182 ++++
 .../testing/selftests/verification/.gitignore |   2 +
 tools/testing/selftests/verification/Makefile |  19 +-
 .../verification/test.d/tlob/Makefile         |  20 +
 .../verification/test.d/tlob/test.d/functions |   1 +
 .../verification/test.d/tlob/tlob_sym.c       | 189 ++++
 .../verification/test.d/tlob/tlob_target.c    | 138 +++
 .../verification/test.d/tlob/uprobe_bind.tc   |  37 +
 .../test.d/tlob/uprobe_detail_running.tc      |  51 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  50 +
 .../test.d/tlob/uprobe_detail_waiting.tc      |  66 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |  64 ++
 .../test.d/tlob/uprobe_no_event.tc            |  19 +
 .../test.d/tlob/uprobe_violation.tc           |  67 ++
 .../verification/verificationtest-ktap        |   4 +-
 tools/verification/models/tlob.dot            |  22 +
 31 files changed, 2789 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/Makefile
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_target.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
 create mode 100644 tools/verification/models/tlob.dot

-- 
2.43.0

