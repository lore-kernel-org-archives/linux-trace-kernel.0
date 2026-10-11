Received: from mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1C3E168A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747589; cv=none; b=Dlg3ybtxSBDSGwh8/iSx4z1nVP3Kcp/fiCCJpIx/S94J65qW6J/ZOY1+MDXFe4fg3AVpWUXC6wF5s1cEoVnDhu36VrZ9lAZVzaBe3kt1fdWje1N06rPKhleVS6xsaX/dmMEC0XnSz/5o8KGVN5ERSKa6yWtb3hhAzpbC9qPnU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747589; c=relaxed/simple;
	bh=iMX9OqUzatwIC62Z2q7AUPdvCrpGGw1ZMLGuIr5rKpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j57wYHxc9w1d7n3SszJBXP1U7ydZCjR1lifVnctnPQJTkeDKf3Hpnzh7xfkmvzgYghcpcolqCnRY1vnk58rC3CFiXuGvZxSaBXwd7FtUYoPQph99h/mYNyuFuJK/8oQlLpxJVaptYsyeEKwgY+ByTekWIiK7iT3tDhyPbxpcxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYE0GG04; arc=none smtp.client-ip=95.215.58.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYE0GG04"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iMX9OqUzatwIC62Z2q7AUPdvCrpGGw1ZMLGuIr5rKpc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747583; v=1; x=1792352383;
 b=eYE0GG04PQoETwmZCAuUxIoCaUtK92LwBuFGZJXVsCTUxyv3K7n/BKKPZSxZNdkDKBrxvl50
 wPPhIZjv2z3yHw/FQy7DLu78vBuxVExvjFcpqiVUJLHdtaLgnweES/+5wcVRvAxwsmRoK7K2xpH
 0Br8T2r/YckDctQP0NmeexCA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9e999e94e3bfc8a3;
	Sun, 11 Oct 2026 19:39:42 +0000
X-Mizu-Trace-ID: 9e999e94e3bfc8a3
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
Date: Mon, 12 Oct 2026 03:39:06 +0800
Message-Id: <cover.1791745088.git.wen.yang@linux.dev>
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

The monitor tracks four states (running, waiting, sleeping, stopped)
driven by sched_switch and sched_wakeup tracepoints.  A single clock
invariant, clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
(HRTIMER_MODE_REL_HARD).  On expiry error_env_tlob is emitted; which
phase consumed the budget (running, waiting or sleeping) is recovered
from event_tlob in user space, see monitor_tlob.rst.

Tasks are registered for monitoring by writing to the tracefs monitor
file:
  echo "p:myregion /path/to/binary:OFFSET_START OFFSET_STOP threshold=NS" \
       >> /sys/kernel/tracing/rv/monitors/tlob/monitor

Two uprobes delimit the measured section without modifying the target
binary.  Multiple uprobe pairs can be active simultaneously.  A task may
repeat the START/STOP sequence any number of times: the entry parks in
the automaton's "stopped" state and later restarts in place, reusing the
same pool slot (see Patch 11).

The series opens with five patches that fix the framework on their own
and apply to the base independently of tlob; the rest add the
infrastructure tlob needs and then tlob itself.

Patches 1 and 2 fix the HA environment lifecycle and must stay in this
order.  Patch 1 stops storing the ENV_INVALID_VALUE sentinel: monitors
now reset their stored variables to a real clock anchor on start.  Patch
2 then clamps the timer remainder and rewrites the invariant check as
store + expire_ns >= time_ns so neither side underflows.  That rewrite
overflows when the stored value is still the sentinel, so it has to
follow Patch 1: the reverse order leaves a window in which a monitor
whose clock was never anchored reports spurious violations.  Patch 3
adds KUnit coverage for both paths.

Patch 4 is the framework fix tlob depends on.  tlob arms its hrtimer from
sched_switch and destroys storage from the uprobe and exit paths, so a
reader that resolved the storage before hash_del_rcu() can re-arm past
the teardown's cancel and leave the timer queued on a pool slot that is
freed a grace period later:
  CPU2 (sched event for T)            CPU1 (echo -:NAME >> monitor)
  ha_setup_invariants() reads OPEN
  hrtimer_start(): waits on           xchg(&rec->state, TLOB_RETIRED)
  hrtimer_cpu_base->lock              cancel (takes the same lock first)
                                      hash_del_rcu(), call_rcu()
  enqueues the hrtimer
                                      GP ends, slot returned to the pool

Both sides contend for the same hrtimer_cpu_base->lock, so a normal lock
handoff is enough.  The state recheck in ha_setup_invariants() narrows
the window but cannot close it: the reader resolved the storage before
the unlink, so the first point past it is the RCU callback.  Patch 5 adds
KUnit coverage for the new free hook.

Series structure
================

Fixes to the framework, independent of tlob:

Patch 1: rv: Force environment reset action on HA monitor start
  Cherry-picked from Gabriele's patch.  Instead of starting
  with the ENV_INVALID_VALUE sentinel and waiting for the first explicit
  reset, ha_monitor_reset_all_stored() now calls the monitor-supplied
  ha_reset_env(), which sets a fresh clock anchor for ns-granularity
  clocks.  Monitors with no stored variable define HA_NO_RESET, emitted
  automatically by rvgen.  This removes the invalid-env special case
  from constraint checks and lets tlob re-anchor its clock on restart.
  Carried unchanged from Gabriele's reply to v6; it is not upstream yet.
  If it lands through his tree first, it will be dropped from this
  series.

Patch 2: rv: Fix ha_monitor timer and invariant underflow
  Clamp the HA timer remainder to 0 (fire immediately) when the budget
  already elapsed, and rewrite the invariant check so neither side can
  underflow.  Without it a late state transition arms the timer far into
  the future and the monitor stops enforcing the budget.

Patch 3: rv: Add a KUnit test for the HA timer underflow
  Covers both paths: the invariant holds with the uptime below the
  budget, and a timer armed after the budget elapsed expires immediately.

Patch 4: rv: Disarm HA timers on the storage free path
  Add da_monitor_free_hook(), called right before a per-object storage
  is freed, and have HA cancel its timer there; kfree_rcu() becomes
  call_rcu() so the RCU free path has a callback to hook.

Patch 5: rv: Add a KUnit test for the storage free path
  KUnit coverage for the Patch 4 free hook.

New infrastructure:

Patch 6: rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  #ifndef guards for da_monitor_reset_hook and EVENT_NONE_LBL.

Patch 7: rv: Introduce DA_MON_ALLOCATION_STRATEGY
  Compile-time allocation strategy selector for per-object DA storage:
  DA_ALLOC_AUTO (default kmalloc), DA_ALLOC_POOL (pre-allocated mempool),
  DA_ALLOC_MANUAL (caller-managed).  DA_MON_POOL_SIZE alone selects pool
  mode.

Patch 8: rv: Add per-object teardown hook da_extra_cleanup
  Split out of the tlob patch per Gabriele's request, so the framework
  change can be reviewed on its own.

Patch 9: rv: Add generic uprobe infrastructure for RV monitors
  Thin wrapper over uprobe_consumer for path resolution, registration,
  and safe synchronous teardown.  struct rv_uprobe embeds
  uprobe_consumer directly and holds an inode reference for the probed
  binary for its lifetime.  Also introduces config RV_UPROBE and the
  Makefile rule to keep git bisect cleanly passing across the series.

tlob:

Patch 10: rv: Add tlob model DOT file
  Graphviz DOT specification of the tlob hybrid automaton.

Patch 11: rv: Add tlob hybrid automaton monitor
  Main tlob implementation.

Patch 12: rv: Add KUnit tests for the tlob monitor
  Parser tests reached through a const rv_tlob_kunit_ops struct of
  function pointers, covering valid lines, malformed inputs, and
  out-of-range thresholds.

Patch 13: selftests/verification: Add tlob selftests
  Eleven ftrace-style selftests covering binding, violation, multi-binding,
  multi-task sharing of one binding, overlap registration rejection,
  unbind/disable on live tasks, start/stop restart, and the per-state
  breakdown derived from event_tlob.

Patch 14: selftests/ftrace: Walk up parent dirs to find test.d/functions
  The ftracetest walk-up change needed to run the verification tests
  from the verification subdirectory.

Changes since v6

================

The series is now grouped: the framework fixes come first, then the new
infrastructure, then tlob.

New in this revision:
  - Patches 1 and 2: the HA environment lifecycle and timer fixes, in
    that order (see above).  Patch 3 adds KUnit coverage for both.

  - Patch 4 (was 1): the HA timer teardown fix, found while auditing
    tlob's own teardown.  The gap is in the framework; a monitor cannot
    close it.  Patch 5 adds KUnit coverage, and Patch 8 splits the
    per-object teardown hook out of the tlob patch.

  - Dropped detail_env_tlob and the per-state accounting.  Which phase
    consumed the budget is now derived from event_tlob in user space;
    monitor_tlob.rst documents the recipe.  This removes the per-record
    lock and the accumulator from the hot path, and tlob no longer
    deviates from "run a model and spot violations" (Gabriele, v2).

  - The model gives stopped a self-loop for every scheduler event, and the
    sched handlers call da_handle_event() unconditionally.  The
    source-side gate that skipped events while stopped is gone; the logic
    lives in the model (Gabriele, v6).

  - tlob_sym.c (a 235-line ELF parser) is replaced by a sym_offset()
    shell helper built on readelf (Gabriele, v3).

  - tlob_preempt_work, identical to tlob_busy_work, is dropped and the
    busy-wait body is shared (Gabriele, v3).

  - The KUnit and DOT commit messages were rewritten as requested
    (Gabriele, v6).

  - Dropped three patches that no longer stand on their own: "rv: Fix
    ha_invariant_passed_ns silent bypass of invariant check" (Patch 1
    makes it unnecessary), "rv: Check the decoded fields in the tlob
    parser tests" and "selftests/verification: Fix up the tlob selftests"
    (folded into the patches they fix, so each patch is complete on its
    own).

Also folded into the patches they belong to, from earlier review rounds:
the DA_MON_POOL_SIZE dual-macro simplification and DA_ALLOC_MANUAL
(Gabriele), the invariant-check rewrite (sashiko-bot), and the tlob
teardown/error-path fixes: security_locked_down(LOCKDOWN_TRACEFS) in
tlob_monitor_open(), the single tlob_record_state word with
TLOB_RETIRED as the only licence to free, tlob_add_uprobe()'s rollback
running the full nosync/quiesce/sync/reap sequence, and
tlob_remove_all_uprobes() holding tlob_uprobe_mutex across the sync and
the reap.

Testing
=======
Environment: x86_64, CONFIG_PREEMPT_RT=y, kernel built with virtme-ng
(vng --build), selftests built on the host and run inside the VM via
`ftracetest --rv ../verification` (the verificationtest-ktap entry
point, with logs redirected to /tmp):
- KUnit: rv_mon suite (CONFIG_RV_MONITORS_KUNIT_TEST), rv_test_tlob case
  covering the uprobe-line parser
- 11 ftrace-style selftests: uprobe_bind, uprobe_violation,
  uprobe_no_event, uprobe_multi, uprobe_multi_instance,
  uprobe_detail_{running,sleeping,waiting}, uprobe_restart,
  uprobe_overlap_register, uprobe_restart_violation
Both suites pass.  The pre-existing rv_* tests in the same directory
and the rest of the rv_mon KUnit suite (nomiss, sco, sssw, sts, opid,
pagefault, sleep) keep passing as well.

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
  rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  rv: Introduce DA_MON_ALLOCATION_STRATEGY
  rv: Add per-object teardown hook da_extra_cleanup
  rv: Add generic uprobe infrastructure for RV monitors
  rv: Add tlob model DOT file
  rv: Add tlob hybrid automaton monitor
  rv: Add KUnit tests for the tlob monitor
  selftests/verification: Add tlob selftests
  selftests/ftrace: Walk up parent dirs to find test.d/functions

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_tlob.rst       |  154 +++
 include/rv/da_monitor.h                       |  154 ++-
 include/rv/ha_monitor.h                       |   61 +-
 include/rv/rv_uprobe.h                        |   35 +
 kernel/trace/rv/Kconfig                       |    5 +
 kernel/trace/rv/Makefile                      |    2 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |    2 +-
 kernel/trace/rv/monitors/opid/opid.h          |    1 +
 kernel/trace/rv/monitors/tlob/Kconfig         |   12 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 1049 +++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          |  142 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    |  151 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.h    |   18 +
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |   20 +
 kernel/trace/rv/rv_monitors_test.c            |  162 +++
 kernel/trace/rv/rv_trace.h                    |    1 +
 kernel/trace/rv/rv_uprobe.c                   |   56 +
 tools/testing/selftests/ftrace/ftracetest     |   19 +-
 .../testing/selftests/verification/.gitignore |    1 +
 tools/testing/selftests/verification/Makefile |    4 +
 tools/testing/selftests/verification/config   |    3 +
 .../selftests/verification/test.d/functions   |    9 +
 .../test.d/tlob/run_tlob_tests.sh             |   32 +
 .../verification/test.d/tlob/uprobe_bind.tc   |   47 +
 .../test.d/tlob/uprobe_breakdown.tc           |  136 +++
 .../test.d/tlob/uprobe_disable_live.tc        |   79 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |   58 +
 .../test.d/tlob/uprobe_multi_instance.tc      |   65 +
 .../test.d/tlob/uprobe_no_event.tc            |   17 +
 .../test.d/tlob/uprobe_overlap_register.tc    |   66 ++
 .../test.d/tlob/uprobe_restart.tc             |   66 ++
 .../test.d/tlob/uprobe_restart_violation.tc   |   48 +
 .../test.d/tlob/uprobe_unbind_live.tc         |   65 +
 .../test.d/tlob/uprobe_violation.tc           |   53 +
 .../selftests/verification/tlob_target.c      |  127 ++
 tools/verification/models/tlob.dot            |   27 +
 tools/verification/rvgen/rvgen/dot2c.py       |    2 +
 38 files changed, 2930 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c
 create mode 100755 tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_breakdown.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
 create mode 100644 tools/testing/selftests/verification/tlob_target.c
 create mode 100644 tools/verification/models/tlob.dot

-- 
2.25.1

