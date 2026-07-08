Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBD41CB3D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525163; cv=none; b=XJLCUK0j93ezUD4kYTfMdwUzBsHe1gSO18E9FZreMsPPehPUjCpN+uUv0tgXT4oAo/spoVfzrK8LfV21xCi3oroZjfDq9lBTzMzo+m/ZVbXdjdBR7K/bjIpLWP3Hwwqt+RdhAtpIYNrgJme8yfF23+GqU29KMZ0UxvfTB5jRImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525163; c=relaxed/simple;
	bh=gOdSiWpTn4TeZyI55lNy+Gz1vsfDuPd/yKF6/uon8wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMdV8Yl8sci3kOtOfBaGxzPmAglkBl+YA2kGK4Css//GDsTiVwl4/E2/l7+RBlslrRHiPj+DNENNjsBNM55li/VphVkV+aO21cKeP6K6YKwg6LXnAblenzcjobHH+txw6YObAUjxm9S3XRgcr5Y303xQu2rioaHsOpd/JwlgZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNJpj81D; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNJpj81D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OWW1LtjRW9h44RTX52dSdmfE9DpHFYbkJ4f6PNfaVhM=;
	b=hNJpj81DcjIDsoMX4x3chh6eKzxDueuKWRa5WnRzn+thk1KGUNSOcVLHdMsqjh1jIau96g
	oDQ8zL4iAEB0QFAQdDRrkq5kL5bKCJUpKvlheT11JQfTpKDJUoGKaGsRkXgXmbpaj/6ONq
	Ikq4uMyKMgOx460SVH4ifnc3V3Q46Jo=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 0/8] rv/tlob: Add task latency over budget RV monitor
Date: Wed,  8 Jul 2026 23:38:26 +0800
Message-Id: <cover.1783524627.git.wen.yang@linux.dev>
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
a user-delimited code section and emits an error when the elapsed time
exceeds a configurable budget.

The monitor tracks three states (running, waiting, sleeping) driven by
sched_switch and sched_wakeup tracepoints.  A single clock invariant,
clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
(HRTIMER_MODE_REL_HARD).  On expiry, error_env_tlob is emitted,
followed by detail_env_tlob carrying a per-state time breakdown
(running_ns, waiting_ns, sleeping_ns).

Tasks are registered for monitoring by writing to the tracefs monitor
file:

  echo "p /path/to/binary:OFFSET_START OFFSET_STOP threshold=NS" \
       > /sys/kernel/tracing/rv/monitors/tlob/monitor

Two uprobes delimit the measured section without modifying the target
binary.  Multiple uprobe pairs can be active simultaneously.

Series structure
----------------
Patch 1: rv/da: introduce DA_MON_ALLOCATION_STRATEGY
  Compile-time allocation strategy selector for per-object DA storage.
  Three strategies: DA_ALLOC_AUTO (default kmalloc), DA_ALLOC_POOL
  (pre-allocated llist pool), DA_ALLOC_MANUAL (caller-managed).

Patch 2: rv: add generic uprobe infrastructure for RV monitors
  Thin wrapper over uprobe_consumer for path resolution, registration,
  and safe synchronous teardown.

Patch 3: rv/tlob: add tlob model DOT file
  Graphviz DOT specification of the tlob hybrid automaton.

Patch 4: rv/ha: fix ha_invariant_passed_ns silent bypass
  Without this fix, ha_invariant_passed_ns() returns 0 on first call and
  leaves env_store at U64_MAX.  Every subsequent state transition resets
  the hrtimer to the full budget instead of the remaining time, so the
  budget never expires for tasks that transition between states.  This
  causes tlob's detail_sleeping and detail_waiting selftests to hang.

  This patch is a minimal fix in the current dual-representation framework.
  Nam's series [1] refactors ha_monitor.h to a single-representation
  model; once it lands, tlob will need to be updated to the new API and
  this patch will be superseded by Gabriele's planned framework-level
  initialisation improvement.  We carry it here to keep the series
  self-contained and testable.

  [1] https://lore.kernel.org/lkml/08188c28f274da63a3f8549add3086a92aef45e5.1780908661.git.namcao@linutronix.de

Patches 5: rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL
  #ifndef guards for da_monitor_reset_hook and EVENT_NONE_LBL.

Patch 6: rv/tlob: add tlob hybrid automaton monitor
  Main tlob implementation.

Patches 7-8: Tests
  KUnit tests for the uprobe-line parser; seven ftrace-style selftests.

Changes since v3
----------------
Patch 1 (rv/da):
- Pool redesigned from spinlock+pointer-stack to lock-free llist
  (cmpxchg-based): pool release from RCU callback context is now safe
  without acquiring a lock
- DA_MON_POOL_SIZE alone selects pool mode; no separate
  DA_MON_ALLOCATION_STRATEGY define required for monitors
- All strategy dispatch uses plain C if() (no ifdeffery in functions)
- da_monitor_destroy_pool() calls da_monitor_reset_all() and
  da_monitor_sync_hook() before the hash iteration, preventing hrtimer
  UAF when timer callbacks are still in flight

Patch 2 (rv_uprobe):
- struct rv_uprobe now embeds struct uprobe_consumer directly; no
  separate heap allocation per probe, no rv_uprobe_free()
- path_put() moved after uprobe_register() to keep the inode
  referenced across the call as required by the uprobe API

Patch 6 (tlob monitor):
- da_get_target_by_id() wrapped in scoped_guard(rcu) in
  tlob_start_task(): hash_for_each_possible_rcu() requires an explicit
  RCU read-side CS on PREEMPT_RT where spinlock_t does not provide one
- tlob_monitor_read() releases mutex before simple_read_from_buffer()
  to avoid holding the mutex across copy_to_user()
- kmem_cache replaced with a pre-allocated llist pool for
  tlob_task_state, eliminating GFP_ATOMIC in the measurement window
- EXPORT_SYMBOL_IF_KUNIT added for tlob_parse_uprobe_line() and
  tlob_parse_remove_line() (required when CONFIG_TLOB_KUNIT_TEST=m)
- tlob_parse_remove_line() rejects negative offsets
- Unnecessary includes removed; Kconfig entry placed after the
  deadline monitors marker

Patch 7 (KUnit):
- Tests now call tlob_parse_uprobe_line() and tlob_parse_remove_line()
  directly; no tracepoint enrollment, no uprobe or filesystem state

Patch 8 (selftests):
- ftracetest walk-up algorithm (Gabriele's suggestion) incorporated;
  the separate verificationtest-ktap fix patch is dropped and the
  series shrinks from 9 to 8 patches
- All test scripts use "! cmd || false" throughout

Testing
-------
Tested on x86_64 with CONFIG_PREEMPT_RT=y (kernel 7.1 + virtme-ng):
- All KUnit tests pass
- All 7 selftests pass (uprobe_bind, uprobe_violation, uprobe_no_event,
  uprobe_multi, uprobe_detail_{running,sleeping,waiting})


Wen Yang (8):
  rv/da: introduce DA_MON_ALLOCATION_STRATEGY
  rv: add generic uprobe infrastructure for RV monitors
  rv/tlob: add tlob model DOT file
  rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
  rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
  rv/tlob: add tlob hybrid automaton monitor
  rv/tlob: add KUnit tests for the tlob monitor
  selftests/verification: add tlob selftests

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_tlob.rst       | 177 ++++
 include/rv/da_monitor.h                       | 247 ++++-
 include/rv/ha_monitor.h                       |  24 +-
 include/rv/rv_uprobe.h                        |  93 ++
 kernel/trace/rv/Kconfig                       |   8 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   6 +-
 kernel/trace/rv/monitors/tlob/.kunitconfig    |   8 +
 kernel/trace/rv/monitors/tlob/Kconfig         |  19 +
 kernel/trace/rv/monitors/tlob/tlob.c          | 970 ++++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          | 153 +++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    | 139 +++
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |  52 +
 kernel/trace/rv/rv_trace.h                    |   1 +
 kernel/trace/rv/rv_uprobe.c                   | 104 ++
 tools/testing/selftests/ftrace/ftracetest     |  18 +-
 .../testing/selftests/verification/.gitignore |   2 +
 tools/testing/selftests/verification/Makefile |  19 +-
 .../verification/test.d/tlob/Makefile         |  28 +
 .../test.d/tlob/run_tlob_tests.sh             |  90 ++
 .../verification/test.d/tlob/tlob_sym.c       | 209 ++++
 .../verification/test.d/tlob/tlob_target.c    | 138 +++
 .../verification/test.d/tlob/uprobe_bind.tc   |  37 +
 .../test.d/tlob/uprobe_detail_running.tc      |  51 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  50 +
 .../test.d/tlob/uprobe_detail_waiting.tc      |  66 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |  64 ++
 .../test.d/tlob/uprobe_no_event.tc            |  19 +
 .../test.d/tlob/uprobe_violation.tc           |  67 ++
 tools/verification/models/tlob.dot            |  22 +
 31 files changed, 2839 insertions(+), 46 deletions(-)
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
 create mode 100755 tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
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
2.25.1

