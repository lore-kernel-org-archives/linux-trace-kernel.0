Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837747CC86
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523930; cv=none; b=mzrxUqw8AEpAgvNrq2o/bbwdM7NkpSSoiCs+kKlSpsDPw+V3K3xoFnSH7YzCfPZSN9LPX9T4I66B+xdX1qev9KEKIcdF/ccNUojknOP73hK3FoZ6wr0CsiWOiINSHaTTNQuFXZiHGmCaHayn9C6A5973xsAT09lXfMh+1jW8C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523930; c=relaxed/simple;
	bh=x0LjjCFtBkjGtLHVnkgvSvbdUet/2z2sPZJRqCDTcTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K4SiOL5E9G+O+jB/jHHBmDKgJGfX4duw8x8yYgUFp73fhnj0KKubytC/FPlq9V3gCr+aagSUF24FN+gvmOpyPx+KQbOwi/6pns4oFjcj/wEaOrKXwhNBiebUF31sfVMpgOqAbRcF4vfUN/F2YjdqC5xSe+2YZvFNxlI0Mgrb+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BdFsWs8Y; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BdFsWs8Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4gd4PRotLv4l65iNv6cdovupI/mDgolR1fUA8uznZA=;
	b=BdFsWs8YNMDW23DeaoPLOL/Yio1v8YQQ7CjtCpxcY5S/tiOSh1Oz37H7C4inKkLlbQG/yn
	FYOVShz8+zW/wCzczO7ngJLBhc/m8bgCw33csadzbXCwJzUQ7kN3DrHheaX5sKCbOlZM/j
	85+c4rdG6gL/j5VXgG6We/C7pzslWKY=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 00/10] rv/tlob: Add task latency over budget RV monitor
Date: Tue, 12 May 2026 02:24:46 +0800
Message-Id: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

This series introduces tlob (task latency over budget), a per-task
hybrid automaton RV monitor that measures elapsed wall-clock time across
a user-delimited code section and fires when the time exceeds a
configurable budget.

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

Two userspace interfaces are provided:

  ioctl (/dev/rv): TLOB_IOCTL_TRACE_START / TLOB_IOCTL_TRACE_STOP for
    in-process self-instrumentation; TRACE_STOP returns -EOVERFLOW if
    the budget was exceeded during the window.

  tracefs (monitors/tlob/monitor): write "p PATH:START STOP threshold=NS"
    to attach uprobes to an unmodified binary.  The start uprobe calls
    tlob_start_task() and the stop uprobe calls tlob_stop_task().

Infrastructure additions
------------------------
The series also includes several prerequisite additions to the RV
framework that are useful beyond tlob:

  rv/da: two bug fixes for race conditions in da_monitor_destroy() and
    the monitoring flag memory ordering that affect existing per-task
    monitors (patches 1-2).

  rv/da: pre-allocated storage pool (da_monitor_init_prealloc) to avoid
    kmalloc on the scheduler tracepoint hot path and to support
    PREEMPT_RT configurations (patch 4).

  rv: generic uprobe infrastructure (rv_uprobe) providing a thin wrapper
    around uprobe_consumer with a per-binding priv pointer and fully
    synchronous detach semantics (patch 5).

  rvgen: support for reset() annotations on the __init arrow, enabling
    monitors where a clock is reset once at object creation and active
    in all states (patch 6).

Testing
-------
KUnit (five suites, 19 test cases):

  tlob_task_api          -- start/stop lifecycle, error paths, -ENOSPC,
                            deadline firing in each state
  tlob_sched_integration -- context-switch accounting, monitoring a
                            kthread other than current
  tlob_uprobe_format     -- add/remove format acceptance and rejection
                            via tlob_create_or_delete_uprobe()
  tlob_trace_output      -- event_tlob and error_env_tlob field values
  tlob_violation_react   -- error count per budget expiry; per-state
                            ns breakdown dominance

kselftest (12 tests, run via verificationtest-ktap on x86_64 with vng):

  TAP version 13
  1..12
  ok 1 Test monitor enable/disable
  ok 2 Test monitor reactor setting
  ok 3 Check available monitors
  ok 4 Test wwnr monitor with printk reactor
  ok 5 Test tlob ioctl self-instrumentation (within/over-budget, error paths)
  ok 6 Test tlob monitor tracefs interface (enable/disable and files)
  ok 7 uprobe binding: visible in monitor file, removable, duplicate offset rejected
  ok 8 uprobe detail sleeping: sleeping_ns dominates when task blocks between probes
  ok 9 uprobe detail waiting: waiting_ns dominates when task is preempted between probes
  ok 10 Two bindings on same binary with different offsets and budgets fire independently
  ok 11 Verify no spurious error_env_tlob events without an active uprobe binding
  ok 12 uprobe violation: error_env_tlob and detail_env_tlob fire with correct fields
  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes in v2 (addressing review by Gabriele)
----------------------------------------------------------------
- Switch from a custom hash table to RV_MON_PER_OBJ with
  "typedef struct tlob_task_state *monitor_target"; the per-invocation
  threshold is carried in the target struct and accessed via
  ha_get_target(ha_mon)->threshold_us, following the nomiss monitor
  pattern.

- Replace the explicit unmonitored state and da_monitor_init_hook()
  timer arming with da_handle_start_event() for initial state setup,
  then ha_reset_clk_ns() + ha_start_timer_ns() directly.  The HA clock
  invariant clk_elapsed < BUDGET_NS() is now expressed in the DOT model
  and enforced by the HA framework.

- Drop the v1 KUnit test suite that validated every DA transition matrix
  entry; replace with five suites that test meaningful behaviours:
  start/stop lifecycle, context-switch accounting, uprobe format
  validation, trace event field values, and violation reaction with
  per-state ns breakdown.

- Move selftests from tools/testing/selftests/rv/ into the existing
  tools/testing/selftests/verification/ harness; test logic is expressed
  as ftracetest .tc scripts under test.d/tlob/, with helper binaries
  (tlob_ioctl, tlob_target) built by tlob/Makefile and located via PATH.


Wen Yang (10):
  rv/da: fix monitor start ordering and memory ordering for monitoring
    flag
  rv/da: fix per-task da_monitor_destroy() ordering and sync
  selftests/verification: fix verificationtest-ktap for out-of-tree
    execution
  rv/da: add pre-allocated storage pool for per-object monitors
  rv: add generic uprobe infrastructure for RV monitors
  rvgen: support reset() on the __init arrow for global-window HA clocks
  rv/tlob: add tlob model DOT file
  rv/tlob: add tlob hybrid automaton monitor
  rv/tlob: add KUnit tests for the tlob monitor
  selftests/verification: add tlob selftests

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_tlob.rst       |  213 +++
 MAINTAINERS                                   |    3 +
 include/linux/rv.h                            |   45 +
 include/rv/automata.h                         |   15 +
 include/rv/da_monitor.h                       |  234 ++-
 include/rv/ha_monitor.h                       |   33 +-
 include/rv/rv_uprobe.h                        |  119 ++
 include/uapi/linux/rv.h                       |   86 ++
 kernel/trace/rv/Kconfig                       |    6 +
 kernel/trace/rv/Makefile                      |    5 +-
 kernel/trace/rv/monitors/tlob/.kunitconfig    |    5 +
 kernel/trace/rv/monitors/tlob/Kconfig         |   69 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 1333 +++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          |  171 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    |  881 +++++++++++
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |   58 +
 kernel/trace/rv/rv.c                          |   38 +
 kernel/trace/rv/rv.h                          |    2 +
 kernel/trace/rv/rv_chardev.c                  |  201 +++
 kernel/trace/rv/rv_trace.h                    |    1 +
 kernel/trace/rv/rv_uprobe.c                   |  189 +++
 tools/include/uapi/linux/rv.h                 |   86 ++
 tools/testing/selftests/verification/Makefile |   21 +-
 .../verification/test.d/tlob/ioctl.tc         |   36 +
 .../verification/test.d/tlob/tracefs.tc       |   17 +
 .../verification/test.d/tlob/uprobe_bind.tc   |   34 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |   47 +
 .../test.d/tlob/uprobe_detail_waiting.tc      |   60 +
 .../verification/test.d/tlob/uprobe_multi.tc  |   60 +
 .../test.d/tlob/uprobe_no_event.tc            |   19 +
 .../test.d/tlob/uprobe_violation.tc           |   60 +
 .../selftests/verification/tlob/Makefile      |   21 +
 .../selftests/verification/tlob/tlob_ioctl.c  |  626 ++++++++
 .../selftests/verification/tlob/tlob_target.c |  138 ++
 .../verification/verificationtest-ktap        |    4 +-
 tools/verification/models/tlob.dot            |   21 +
 tools/verification/rvgen/rvgen/automata.py    |   26 +
 tools/verification/rvgen/rvgen/dot2k.py       |  100 +-
 39 files changed, 5043 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 include/uapi/linux/rv.h
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_chardev.c
 create mode 100644 kernel/trace/rv/rv_uprobe.c
 create mode 100644 tools/include/uapi/linux/rv.h
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/ioctl.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tracefs.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
 create mode 100644 tools/testing/selftests/verification/tlob/Makefile
 create mode 100644 tools/testing/selftests/verification/tlob/tlob_ioctl.c
 create mode 100644 tools/testing/selftests/verification/tlob/tlob_target.c
 create mode 100644 tools/verification/models/tlob.dot

-- 
2.25.1

