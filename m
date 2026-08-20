Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C2442B2E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244340; cv=none; b=LHZImCHLQtrsYz+HFAeWaaJ35GzcJ/EkX7cPjxIR3XmIFkNDi3tPekv363CbspZlGbPgzo8mueL9yWCs2bpnwzbUwbTzhqTxhK8a3AvQBKiB8DYhRlH99H3TPoZZoLm72ZJAm4pW5d5hql9hd7uHZPn6v5qKZnCdkF4TkqvwsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244340; c=relaxed/simple;
	bh=b03pyz5tgLoqnwZWPuaKHHD/+9NPr7hrGTsEkaoSysM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JoltFmjf3WYNhFxaqkierjQY7AOw16ONNkBZMxt7QciZ9lu+CCjN9bCSzHeAdDEJW6+dN3F7cpFcoYap5TOpqxJpOwOT/pi4/D+HWleTInYJhNms499l90JQyrYtUTVPw2PE+kOimSfs9yHp6HFtMXrTrlvgr1PaO2outcux7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rax1xjkw; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rax1xjkw"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b03pyz5tgLoqnwZWPuaKHHD/+9NPr7hrGTsEkaoSysM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244333; v=1; x=1787849133;
 b=rax1xjkwiNJcy8K5gRj/QsiU5d0D8XyPt3lx1+WJR1iSn9Iz0m9fQC9zoBlnjsbAV3eR36hx
 Joe9q0CSADiP4ugcKLeGSZyysHZpFTHAOXOvaizngH2wID2fPG6+uTG/4CO+hf0BJ5y7Ys+ePMW
 EH5rdeCP7pniwvVKHOVLXyFM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 409b72284f7b54a9;
	Thu, 20 Aug 2026 16:45:32 +0000
X-Mizu-Trace-ID: 409b72284f7b54a9
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 0/9] rv: Add task latency over budget RV monitor
Date: Fri, 21 Aug 2026 00:45:09 +0800
Message-Id: <cover.1787243842.git.wen.yang@linux.dev>
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

Changes since v5
-----------------
Most of the fixes below address issues Sashiko (sashiko-bot@kernel.org)
flagged against this series; each is described on its own merits
below.

Patch 1: Reworded the DA_ALLOC_POOL comment; it could be misread as
  allowing the allocating path to run from scheduling context.
Patch 3: Fixed a duplicate "running" node in the DOT file that made
  rvgen mark it, instead of "stopped", as the model's final state.
Patch 6: Fixed automaton_tlob.final_states, generated before the DOT
  fix above and inheriting the same wrong value (trace-only, no
  functional impact).
Patch 7: Reworked per Gabriele's v4 feedback. Dropped
  CONFIG_TLOB_KUNIT_TEST; tlob_parse_uprobe_line()/
  tlob_parse_remove_line() stay static and are reached through a new
  rv_tlob_kunit_ops struct, exported the same way nomiss.c/sco.c expose
  rv_nomiss_ops/rv_sco_ops under the shared CONFIG_RV_MONITORS_KUNIT_TEST.
  tlob_kunit.c now follows the monitors/*/*_kunit.c convention and is
  included into rv_monitors_test.c instead of building standalone.
Patch 8: Fixed tracefs paths under ftracetest --rv mode; added a
  VERIFICATIONTEST_BINDIR fallback for installed kselftest trees; made
  uprobe_detail_waiting.tc skip on single-CPU machines instead of
  pinning a SCHED_FIFO-99 busy loop; guarded tlob_target.c's empty
  stop-probe bodies against being optimised away; added ELF
  program-header bounds checking to tlob_sym.c.
Patch 9: Fixed an infinite loop and a local root privilege-escalation
  window (sourcing test.d/functions from a world-writable directory)
  in the walk-up loop.

Testing
-------
Environment: x86_64, CONFIG_PREEMPT_RT=y, kernel built with virtme-ng
(vng --build), selftests built on the host and run inside the VM:
- KUnit: rv_mon suite (CONFIG_RV_MONITORS_KUNIT_TEST), rv_test_tlob case
  covering the uprobe-line parser
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
 include/rv/da_monitor.h                       |  152 ++-
 include/rv/ha_monitor.h                       |   13 +-
 include/rv/rv_uprobe.h                        |   90 ++
 kernel/trace/rv/Kconfig                       |    5 +
 kernel/trace/rv/Makefile                      |    2 +
 kernel/trace/rv/monitors/tlob/Kconfig         |   12 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 1145 +++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          |  149 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    |   87 ++
 kernel/trace/rv/monitors/tlob/tlob_kunit.h    |   17 +
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |   48 +
 kernel/trace/rv/rv_monitors_test.c            |    2 +
 kernel/trace/rv/rv_trace.h                    |    1 +
 kernel/trace/rv/rv_uprobe.c                   |   91 ++
 tools/testing/selftests/ftrace/ftracetest     |   26 +-
 .../testing/selftests/verification/.gitignore |    2 +
 tools/testing/selftests/verification/Makefile |    4 +
 .../test.d/tlob/run_tlob_tests.sh             |   23 +
 .../verification/test.d/tlob/uprobe_bind.tc   |   39 +
 .../test.d/tlob/uprobe_detail_running.tc      |   53 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |   52 +
 .../test.d/tlob/uprobe_detail_waiting.tc      |   76 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |   63 +
 .../test.d/tlob/uprobe_no_event.tc            |   17 +
 .../test.d/tlob/uprobe_restart.tc             |   79 ++
 .../test.d/tlob/uprobe_violation.tc           |   69 +
 .../testing/selftests/verification/tlob_sym.c |  225 ++++
 .../selftests/verification/tlob_target.c      |  138 ++
 tools/verification/models/tlob.dot            |   24 +
 31 files changed, 2884 insertions(+), 15 deletions(-)
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

