Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D536309B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022072; cv=none; b=VFMNp8R5ZC+V3mjctIb6CRbRjrtl3LnZv+iiOQdP8CzmfCE2tA7fR7wBU55+HQKD3Oo9XGvZPCZ0+Gm+tgQikqI9dcFx+imsECWgw6LtFFwjUHJDCAlci1eeGtNVJK9bwuakTwajxdFa8szOzjQe05wxy8v+tp2Vcq/jJbe7/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022072; c=relaxed/simple;
	bh=gR0eIzfMGuiIr8rdev80ueh8iRD/nyUXB3LT0N1Pb0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cipr6N6PmtxRV1TdCEMafDx2cRpem/aemvoNIuDaVElybioz8OaP5zbLRhHeAZSxO7dcl/K3AhmBkS0HkSNqOQcZ+hJt7CiHZBlpDreHLsVK4Cgl7W6iTCzDl1ALJhvTxjOXV66D0I9OsOuhOzErm5fjWrRd7rdHXcng6AYq87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VASexpai; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VASexpai"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776022069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pyE5uA5HN1JUalaWHgdiNixqwIgYZsSQxevGzVDaSms=;
	b=VASexpai0rVF2pfQLPM/fex5U/Nwd30ApAEnJ6heawk6uL3Bo6m34vyqA3qnOj4hixmYQc
	2E6dZaO2GiaHOePGBBNOGLvKOsF9NvjWdYJmmvdT3Drdew9GKEetb810//jFtcqfVuJUXI
	ZQIrpYUXSNo/OL2ALLtL7ymsM8Qvv1Y=
From: wen.yang@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 0/4] rv/tlob: Add task latency over budget RV monitor
Date: Mon, 13 Apr 2026 03:27:17 +0800
Message-Id: <cover.1776020428.git.wen.yang@linux.dev>
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

This series introduces tlob (task latency over budget), a new per-task
Runtime Verification monitor.

Background
----------
The RV framework formalises kernel behavioural properties as
deterministic automata. Existing monitors (wwnr, sssw, opid, etc.) cover
scheduling and locking invariants; none tracks wall-clock latency of
a per-task code path, including off-CPU time. This property is needed
in ADAS perception/planning pipelines, industrial real-time
controllers, and similar mixed-criticality deployments.

tlob adds this capability. A caller demarcates a code path via a
start/stop pair; the kernel arms a per-task hrtimer for the requested
budget. If the task has not called TRACE_STOP before the timer fires,
a violation is recorded, the stop call returns -EOVERFLOW, and an
event is pushed to the caller's mmap ring.

The tracefs interface requires only tracefs write permissions, avoiding
the CAP_BPF privilege needed for equivalent eBPF-based approaches. The
DA model (patch 1) can be independently verified with standard model-
checking tools.

Design
------
The monitor is a three-state deterministic automaton (DA):

  unmonitored --trace_start--> on_cpu
  on_cpu       --switch_out--> off_cpu
  off_cpu      --switch_in---> on_cpu
  {on_cpu, off_cpu} --{trace_stop, budget_expired}--> unmonitored

Per-task state lives in a fixed-size hash table (TLOB_MAX_MONITORED
slots) with RCU-deferred free. Timing is based on CLOCK_MONOTONIC
(ktime_get()), so budgets account for off-CPU time.

Two userspace interfaces are provided:

  tracefs: uprobe pair registration via the monitor/enable files; no
           new UAPI required.

  /dev/rv ioctls (CONFIG_RV_CHARDEV):
    TLOB_IOCTL_TRACE_START  — arm the budget for a target task
    TLOB_IOCTL_TRACE_STOP   — disarm; returns -EOVERFLOW on violation

  Each /dev/rv file descriptor has a per-fd mmap ring (a physically
  contiguous control page struct tlob_mmap_page followed by an array of
  struct tlob_event records). Head/tail/dropped are userspace-readable
  without locking; overflow uses a drop-new policy.

New UAPI (include/uapi/linux/rv.h): tlob_start_args, tlob_event,
tlob_mmap_page, ioctl numbers (RV_IOC_MAGIC=0xB9, registered in
Documentation/userspace-api/ioctl/ioctl-number.rst).

Testing
-------
KUnit (patch 3): six suites (38 cases) gated on CONFIG_TLOB_KUNIT_TEST.

  ./tools/testing/kunit/kunit.py run \
    --kunitconfig kernel/trace/rv/monitors/tlob/.kunitconfig

  Coverage: automaton state transitions, start/stop API error paths,
  scheduler context-switch accounting, tracepoint payload fields,
  ring-buffer push/overflow/wakeup, and the uprobe line parser.

kselftest (patch 4): 19 TAP test points under
tools/testing/selftests/rv/. Requires CONFIG_RV_MON_TLOB=y,
CONFIG_RV_CHARDEV=y, and root.

  make -C tools/testing/selftests/rv
  sudo ./test_tlob.sh

Patch overview
--------------
Patch 1 — DOT model: formal automaton specification for verification.
Patch 2 — monitor implementation, UAPI, and documentation.
Patch 3 — KUnit in-kernel unit tests.
Patch 4 — kselftest user-space integration tests.

Wen Yang (4):
  rv/tlob: Add tlob model DOT file
  rv/tlob: Add tlob deterministic automaton monitor
  rv/tlob: Add KUnit tests for the tlob monitor
  selftests/rv: Add selftest for the tlob monitor

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_tlob.rst       |  381 ++++++
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +
 include/uapi/linux/rv.h                       |  181 +++
 kernel/trace/rv/Kconfig                       |   17 +
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/tlob/.kunitconfig    |    5 +
 kernel/trace/rv/monitors/tlob/Kconfig         |   63 +
 kernel/trace/rv/monitors/tlob/tlob.c          |  987 ++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob.h          |  145 ++
 kernel/trace/rv/monitors/tlob/tlob_kunit.c    | 1194 +++++++++++++++++
 kernel/trace/rv/monitors/tlob/tlob_trace.h    |   42 +
 kernel/trace/rv/rv.c                          |    4 +
 kernel/trace/rv/rv_dev.c                      |  602 +++++++++
 kernel/trace/rv/rv_trace.h                    |   50 +
 tools/include/uapi/linux/rv.h                 |   54 +
 tools/testing/selftests/rv/Makefile           |   18 +
 tools/testing/selftests/rv/test_tlob.sh       |  563 ++++++++
 tools/testing/selftests/rv/tlob_helper.c      |  994 ++++++++++++++
 .../testing/selftests/rv/tlob_uprobe_target.c |  108 ++
 tools/verification/models/tlob.dot            |   25 +
 22 files changed, 5441 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_tlob.rst
 create mode 100644 include/uapi/linux/rv.h
 create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
 create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
 create mode 100644 kernel/trace/rv/rv_dev.c
 create mode 100644 tools/include/uapi/linux/rv.h
 create mode 100644 tools/testing/selftests/rv/Makefile
 create mode 100755 tools/testing/selftests/rv/test_tlob.sh
 create mode 100644 tools/testing/selftests/rv/tlob_helper.c
 create mode 100644 tools/testing/selftests/rv/tlob_uprobe_target.c
 create mode 100644 tools/verification/models/tlob.dot

-- 
2.43.0

