Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2D47CC86
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523948; cv=none; b=WvLPssvis+u6eutFKSnXmnImaSAKMzn4kJW0Rt/vUN7Wsr0THuI/VvZUH3HXXNRKLbzIFXjMFMUwjgZGkA8zQosZC/XDst57WCyLVaKwcoa3vNAb8r3qcfwEBAnYetIhXJOFBh+Yxi7es3PKwT6g84ISL35v2DWDcoQaBtPQ3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523948; c=relaxed/simple;
	bh=jt7wFLfwZv/YriPWtL7DTGSVa1XLxA321mI14+fGzOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDTu3Xe4L25+iV9H2veK2XOVrzbyiVL4gfYa38l8yB1Gfxl/KioAeW3qDxO+5tcumjg6WbL1oHPxSsMWfFA8kDdb3G/JcA0F2ODXpzrygr+2fu3sd0wkmot/gBAcx2yl3UFOi1+0DqQKx6yt7mTSdYQRU1p5oTl4cbJObCAvp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TFJcfB/N; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TFJcfB/N"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NnBxbxr+omcJSdpV1L1cGtFbHhIz2Q1hlzpeMQFQCM=;
	b=TFJcfB/NGQZ21EkrYhgR4xnWPXcaP7TqAIpqaEFAg+pG4Lf7mTw2MBk17tmMnvsftNMf0k
	vOuhB0mOjOgRprPmUQuUBxcOH+pjFNvlRr8ksP3u/3swDz5O8uCNopuXGCT4luxsLnOsbm
	h+U3xD52YuXfHPON9xo5wW37nmicBpE=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 10/10] selftests/verification: add tlob selftests
Date: Tue, 12 May 2026 02:24:56 +0800
Message-Id: <8148267505ef90175b6b69e1ffb3aa560ff42d35.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add selftest coverage for the tlob RV monitor in
tools/testing/selftests/verification/.

Two helper binaries are built by tlob/Makefile: tlob_helper for the
ioctl interface (/dev/rv) and tlob_uprobe_target for the uprobe tests.
The top-level Makefile delegates to tlob/ via a generic MONITOR_SUBDIRS
pattern so monitor-specific build details stay within each monitor's
own subdirectory.

Eight test files cover the tracefs control interface (tracefs.tc), the
ioctl self-instrumentation interface (ioctl.tc, 8 scenarios), and the
uprobe external monitoring interface (uprobe_bind.tc, uprobe_violation.tc,
uprobe_no_event.tc, uprobe_multi.tc, uprobe_detail_sleeping.tc,
uprobe_detail_waiting.tc).

Tested on x86_64 with vng (virtme-ng):

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

Suggested-by: Gabriele Monaco <gmonaco@redhat.com> 
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/verification/Makefile |  21 +-
 .../verification/test.d/tlob/ioctl.tc         |  36 +
 .../verification/test.d/tlob/tracefs.tc       |  17 +
 .../verification/test.d/tlob/uprobe_bind.tc   |  34 +
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  47 ++
 .../test.d/tlob/uprobe_detail_waiting.tc      |  60 ++
 .../verification/test.d/tlob/uprobe_multi.tc  |  60 ++
 .../test.d/tlob/uprobe_no_event.tc            |  19 +
 .../test.d/tlob/uprobe_violation.tc           |  60 ++
 .../selftests/verification/tlob/Makefile      |  21 +
 .../selftests/verification/tlob/tlob_ioctl.c  | 626 ++++++++++++++++++
 .../selftests/verification/tlob/tlob_target.c | 138 ++++
 12 files changed, 1138 insertions(+), 1 deletion(-)
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

diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
index aa8790c22a71..b5584fd3762d 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -1,8 +1,27 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
 
 TEST_PROGS := verificationtest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+# Subdirectories that provide helper binaries for the test runner.
+# Each entry must contain a Makefile that accepts OUTDIR= and deposits
+# its binaries there; verificationtest-ktap adds OUTDIR to PATH so
+# the ftracetest require-checks resolve the binaries by name.
+MONITOR_SUBDIRS := tlob
+
 include ../lib.mk
+
+# Build and clean each monitor subdirectory.
+all: $(patsubst %,_build_%,$(MONITOR_SUBDIRS))
+
+clean: $(patsubst %,_clean_%,$(MONITOR_SUBDIRS))
+
+.PHONY: $(patsubst %,_build_%,$(MONITOR_SUBDIRS)) \
+        $(patsubst %,_clean_%,$(MONITOR_SUBDIRS))
+
+$(patsubst %,_build_%,$(MONITOR_SUBDIRS)): _build_%:
+	$(MAKE) -C $* OUTDIR="$(OUTPUT)" TOOLS_INCLUDES="$(TOOLS_INCLUDES)"
+
+$(patsubst %,_clean_%,$(MONITOR_SUBDIRS)): _clean_%:
+	$(MAKE) -C $* OUTDIR="$(OUTPUT)" clean
diff --git a/tools/testing/selftests/verification/test.d/tlob/ioctl.tc b/tools/testing/selftests/verification/test.d/tlob/ioctl.tc
new file mode 100644
index 000000000000..54ae249af9a6
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/ioctl.tc
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob ioctl self-instrumentation (within/over-budget, error paths)
+# requires: tlob:monitor tlob_ioctl:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+
+[ -c /dev/rv ] || exit_unsupported
+
+echo 1 > monitors/tlob/enable
+
+# within budget: 50 ms threshold, 10 ms workload
+"$TLOB_HELPER" within_budget
+
+# over budget in running state: 1 ms threshold, 100 ms busy-spin
+"$TLOB_HELPER" over_budget_running
+
+# over budget in sleeping state: 3 ms threshold, 50 ms sleep
+"$TLOB_HELPER" over_budget_sleeping
+
+# over budget in waiting state: 1 us threshold, sched_yield
+"$TLOB_HELPER" over_budget_waiting
+
+# error paths
+"$TLOB_HELPER" double_start
+"$TLOB_HELPER" stop_no_start
+
+# per-thread isolation
+"$TLOB_HELPER" multi_thread
+
+# bind against disabled monitor must return ENODEV, not crash
+echo 0 > monitors/tlob/enable
+"$TLOB_HELPER" not_enabled
+echo 1 > monitors/tlob/enable
+
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/tracefs.tc b/tools/testing/selftests/verification/test.d/tlob/tracefs.tc
new file mode 100644
index 000000000000..5d1e7cc02498
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/tracefs.tc
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor tracefs interface (enable/disable and files)
+# requires: tlob:monitor
+
+check_requires monitors/tlob/enable monitors/tlob/desc monitors/tlob/monitor
+
+# enable / disable via the enable file
+echo 1 > monitors/tlob/enable
+grep -q 1 monitors/tlob/enable
+echo "tlob" >> enabled_monitors
+grep -q tlob enabled_monitors
+
+echo 0 > monitors/tlob/enable
+grep -q 0 monitors/tlob/enable
+echo "!tlob" >> enabled_monitors
+! grep -q "^tlob$" enabled_monitors
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
new file mode 100644
index 000000000000..41e20d593855
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test uprobe binding (visible in monitor file, removable, duplicate rejected)
+# requires: tlob:monitor tlob_ioctl:program tlob_target:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+UPROBE_TARGET=$(command -v tlob_target)
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+[ -n "$busy_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > monitors/tlob/enable
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=5000000" > "$TLOB_MONITOR"
+
+# Binding must appear in monitor file with canonical hex-offset format.
+grep -qE "^p ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=[0-9]+$" "$TLOB_MONITOR"
+grep -q "threshold=5000000" "$TLOB_MONITOR"
+
+# Duplicate offset_start must be rejected.
+! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=9999" > "$TLOB_MONITOR" 2>/dev/null
+
+# Remove the binding; it must no longer appear.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR"
+
+kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
new file mode 100644
index 000000000000..2b8656e0fef1
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test uprobe detail sleeping (sleeping_ns dominates when task blocks between probes)
+# requires: tlob:monitor tlob_ioctl:program tlob_target:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+UPROBE_TARGET=$(command -v tlob_target)
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+stop_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+[ -n "$start_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 5000 sleep &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# 50 ms budget; task sleeps 200 ms per iteration -> sleeping_ns dominates.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=50000" > "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$sleeping" -gt "$((running + waiting))" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
new file mode 100644
index 000000000000..0705854f24df
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test uprobe detail waiting (waiting_ns dominates when task is preempted between probes)
+# requires: tlob:monitor tlob_ioctl:program tlob_target:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+UPROBE_TARGET=$(command -v tlob_target)
+TLOB_MONITOR=monitors/tlob/monitor
+
+command -v chrt    > /dev/null || exit_unsupported
+command -v taskset > /dev/null || exit_unsupported
+
+start_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_preempt_work 2>/dev/null)
+stop_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_preempt_work_done 2>/dev/null)
+[ -n "$start_offset" ] || exit_unsupported
+[ -n "$stop_offset" ]  || exit_unsupported
+
+cpu=0
+
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# Register probe before the target starts so the start uprobe fires on the
+# first entry to tlob_preempt_work. Budget: 500 ms.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=500000" > "$TLOB_MONITOR"
+
+# Target starts; start probe fires on tlob_preempt_work entry.
+taskset -c "$cpu" "$UPROBE_TARGET" 5000 preempt &
+busy_pid=$!
+sleep 0.05
+
+# RT hog on the same CPU preempts the target; target stays in waiting state
+# (runnable, off-CPU) until the budget expires -> waiting_ns dominates.
+chrt -f 99 taskset -c "$cpu" sh -c 'while true; do :; done' 2>/dev/null &
+hog_pid=$!
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$hog_pid" 2>/dev/null; wait "$hog_pid" 2>/dev/null || true
+kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+[ "$waiting" -gt "$((running + sleeping))" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
new file mode 100644
index 000000000000..c4b8f7108ae9
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test two uprobe bindings on same binary (different offsets fire independently)
+# requires: tlob:monitor tlob_ioctl:program tlob_target:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+UPROBE_TARGET=$(command -v tlob_target)
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+busy_stop=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+sleep_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+sleep_stop=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+[ -n "$busy_offset" ]  || exit_unsupported
+[ -n "$busy_stop" ]    || exit_unsupported
+[ -n "$sleep_offset" ] || exit_unsupported
+[ -n "$sleep_stop" ]   || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &       # busy mode: tlob_busy_work fires every 200 ms
+busy_pid=$!
+"$UPROBE_TARGET" 30000 sleep & # sleep mode: tlob_sleep_work fires every 200 ms
+sleep_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loops.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=5000000" > "$TLOB_MONITOR"
+# Binding B: 10 ns budget on the sleep probe - fires on first invocation.
+echo "p ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=10" > "$TLOB_MONITOR"
+
+# Wait up to 2 s for error_env_tlob from binding B.
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "error_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo "-${UPROBE_TARGET}:${sleep_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$sleep_pid" 2>/dev/null; wait "$sleep_pid" 2>/dev/null || true
+kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
+
+echo 0 > monitors/tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+
+[ "$found" = "1" ]
+# error_env_tlob payload: label and clock variable must be present.
+grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q "budget_exceeded"
+grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q "clk_elapsed="
+# detail_env_tlob must appear alongside the error.
+grep -q "detail_env_tlob" /sys/kernel/tracing/trace
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
new file mode 100644
index 000000000000..4a74853346e3
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test no spurious error_env_tlob events without an active uprobe binding
+# requires: tlob:monitor tlob_ioctl:program
+
+TLOB_MONITOR=monitors/tlob/monitor
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+sleep 0.5
+
+! grep -q "error_env_tlob" /sys/kernel/tracing/trace
+
+echo 0 > monitors/tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
new file mode 100644
index 000000000000..624fdb950f6b
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test uprobe violation (error_env_tlob and detail_env_tlob fire with correct fields)
+# requires: tlob:monitor tlob_ioctl:program tlob_target:program
+
+TLOB_HELPER=$(command -v tlob_ioctl)
+UPROBE_TARGET=$(command -v tlob_target)
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+[ -n "$busy_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# 10 ns budget - fires almost immediately; task is busy-spinning on-CPU.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=10" > "$TLOB_MONITOR"
+
+# wait up to 2 s for detail_env_tlob
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+# error_env_tlob event label must be budget_exceeded
+grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q "budget_exceeded"
+
+# detail_env_tlob must have all five fields with the correct threshold
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+echo "$line" | grep -q "pid="
+echo "$line" | grep -q "threshold_us=10"
+echo "$line" | grep -q "running_ns="
+echo "$line" | grep -q "waiting_ns="
+echo "$line" | grep -q "sleeping_ns="
+
+# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$running" -gt "$sleeping" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/tlob/Makefile b/tools/testing/selftests/verification/tlob/Makefile
new file mode 100644
index 000000000000..1bedf946cb34
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Builds tlob selftest helper binaries.
+#
+# Invoked by ../Makefile; pass OUTDIR to control the output directory
+# and TOOLS_INCLUDES for the in-tree UAPI -isystem flag.
+
+OUTDIR ?= $(CURDIR)/..
+CFLAGS += $(TOOLS_INCLUDES)
+
+.PHONY: all
+all: $(OUTDIR)/tlob_ioctl $(OUTDIR)/tlob_target
+
+$(OUTDIR)/tlob_ioctl: tlob_ioctl.c
+	$(CC) $(CFLAGS) -o $@ $< -lpthread
+
+$(OUTDIR)/tlob_target: tlob_target.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+.PHONY: clean
+clean:
+	$(RM) $(OUTDIR)/tlob_ioctl $(OUTDIR)/tlob_target
diff --git a/tools/testing/selftests/verification/tlob/tlob_ioctl.c b/tools/testing/selftests/verification/tlob/tlob_ioctl.c
new file mode 100644
index 000000000000..abb4e2e80a2c
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob/tlob_ioctl.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_ioctl.c - ioctl test driver and ELF utility for tlob selftests
+ *
+ * Usage: tlob_ioctl <subcommand> [args...]
+ *
+ *   not_enabled          - TRACE_START without monitor enabled -> ENODEV
+ *   within_budget        - sleep within budget -> 0
+ *   over_budget_running  - busy-spin past budget -> EOVERFLOW
+ *   over_budget_sleeping - sleep past budget -> EOVERFLOW
+ *   over_budget_waiting  - sched_yield into waiting state -> EOVERFLOW
+ *   double_start         - two starts without stop -> EALREADY
+ *   stop_no_start        - stop without start -> EINVAL
+ *   multi_thread         - two fds: thread A within budget, thread B over
+ *   bench                - TRACE_START/STOP latency (TAP output, always passes)
+ *   sym_offset <binary> <symbol> - print ELF file offset of symbol
+ *
+ * Exit: 0 = pass, 1 = fail, 2 = skip (device not available).
+ */
+#define _GNU_SOURCE
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/rv.h>
+
+static int rv_fd = -1;
+
+static int open_rv(void)
+{
+	struct rv_bind_args bind = { .monitor_name = "tlob" };
+
+	rv_fd = open("/dev/rv", O_RDWR);
+	if (rv_fd < 0) {
+		fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
+		return -1;
+	}
+	if (ioctl(rv_fd, RV_IOCTL_BIND_MONITOR, &bind) < 0) {
+		fprintf(stderr, "bind tlob: %s\n", strerror(errno));
+		close(rv_fd);
+		rv_fd = -1;
+		return -1;
+	}
+	return 0;
+}
+
+static void busy_spin_us(unsigned long us)
+{
+	struct timespec start, now;
+	unsigned long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (unsigned long)(now.tv_sec - start.tv_sec)
+			  * 1000000000UL
+			+ (unsigned long)(now.tv_nsec - start.tv_nsec);
+	} while (elapsed < us * 1000UL);
+}
+
+static int trace_start(uint64_t threshold_us)
+{
+	struct tlob_start_args args = {
+		.threshold_us = threshold_us,
+	};
+
+	return ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+}
+
+static int trace_stop(void)
+{
+	return ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+}
+
+/* Synchronous TRACE_START / TRACE_STOP tests */
+
+/* Bind to a disabled monitor must return ENODEV without crashing */
+static int test_not_enabled(void)
+{
+	struct rv_bind_args bind = { .monitor_name = "tlob" };
+	int fd;
+	int ret;
+
+	fd = open("/dev/rv", O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
+		return 2; /* skip */
+	}
+
+	ret = ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind);
+	close(fd);
+
+	if (ret == 0) {
+		fprintf(stderr, "RV_IOCTL_BIND_MONITOR: expected ENODEV, got success\n");
+		return 1;
+	}
+	if (errno != ENODEV) {
+		fprintf(stderr, "RV_IOCTL_BIND_MONITOR: expected ENODEV, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int test_within_budget(void)
+{
+	int ret;
+
+	/* 50 ms budget */
+	if (trace_start(50000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	usleep(10000); /* 10 ms */
+	ret = trace_stop();
+	if (ret != 0) {
+		fprintf(stderr, "TRACE_STOP: expected 0, got %d errno=%s\n",
+			ret, strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int test_over_budget_running(void)
+{
+	int ret;
+
+	/* 1 ms budget */
+	if (trace_start(1000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	busy_spin_us(100000); /* 100 ms */
+	ret = trace_stop();
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
+		return 1;
+	}
+	if (errno != EOVERFLOW) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int test_over_budget_sleeping(void)
+{
+	int ret;
+
+	/* 3 ms budget */
+	if (trace_start(3000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	usleep(50000); /* 50 ms; sleeping time counts toward budget */
+	ret = trace_stop();
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
+		return 1;
+	}
+	if (errno != EOVERFLOW) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int test_over_budget_waiting(void)
+{
+	int ret;
+
+	/* 1 us budget */
+	if (trace_start(1) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	sched_yield(); /* running -> waiting -> running */
+	busy_spin_us(10); /* 10 us >> 1 us budget; hrtimer fires during spin */
+	ret = trace_stop();
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
+		return 1;
+	}
+	if (errno != EOVERFLOW) {
+		fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/* Error-handling tests */
+
+static int test_double_start(void)
+{
+	int ret;
+
+	/* 10 s: large enough the hrtimer won't fire during the test */
+	if (trace_start(10000000ULL) < 0) {
+		fprintf(stderr, "first TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	ret = trace_start(10000000);
+	if (ret == 0) {
+		fprintf(stderr, "second TRACE_START: expected EALREADY, got 0\n");
+		trace_stop();
+		return 1;
+	}
+	if (errno != EALREADY) {
+		fprintf(stderr, "second TRACE_START: expected EALREADY, got %s\n",
+			strerror(errno));
+		trace_stop();
+		return 1;
+	}
+	trace_stop();
+	return 0;
+}
+
+static int test_stop_no_start(void)
+{
+	int ret;
+
+	/* Ensure clean state: ignore error from a stale entry */
+	trace_stop();
+
+	ret = trace_stop();
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_STOP: expected EINVAL, got 0\n");
+		return 1;
+	}
+	if (errno != EINVAL) {
+		fprintf(stderr, "TRACE_STOP: expected EINVAL, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/* Two threads, each with its own fd: A within budget, B over budget. */
+
+struct mt_thread_args {
+	uint64_t      threshold_us;
+	unsigned long workload_us;
+	int           busy;
+	int           expect_eoverflow;
+	int           result;
+};
+
+static void *mt_thread_fn(void *arg)
+{
+	struct mt_thread_args *a = arg;
+	struct tlob_start_args args = { .threshold_us = a->threshold_us };
+	struct rv_bind_args bind = { .monitor_name = "tlob" };
+	int fd;
+	int ret;
+
+	fd = open("/dev/rv", O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "thread open /dev/rv: %s\n", strerror(errno));
+		a->result = 1;
+		return NULL;
+	}
+	if (ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind) < 0) {
+		fprintf(stderr, "thread bind tlob: %s\n", strerror(errno));
+		close(fd);
+		a->result = 1;
+		return NULL;
+	}
+
+	ret = ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
+	if (ret < 0) {
+		fprintf(stderr, "thread TRACE_START: %s\n", strerror(errno));
+		close(fd);
+		a->result = 1;
+		return NULL;
+	}
+
+	if (a->busy)
+		busy_spin_us(a->workload_us);
+	else
+		usleep(a->workload_us);
+
+	ret = ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	if (a->expect_eoverflow) {
+		if (ret == 0 || errno != EOVERFLOW) {
+			fprintf(stderr, "thread: expected EOVERFLOW, got ret=%d errno=%s\n",
+				ret, strerror(errno));
+			close(fd);
+			a->result = 1;
+			return NULL;
+		}
+	} else {
+		if (ret != 0) {
+			fprintf(stderr, "thread: expected 0, got ret=%d errno=%s\n",
+				ret, strerror(errno));
+			close(fd);
+			a->result = 1;
+			return NULL;
+		}
+	}
+	close(fd);
+	a->result = 0;
+	return NULL;
+}
+
+static int test_multi_thread(void)
+{
+	pthread_t ta, tb;
+	struct mt_thread_args a = {
+		.threshold_us     = 20000,   /* 20 ms */
+		.workload_us      = 5000,    /* 5 ms sleep -> within budget */
+		.busy             = 0,
+		.expect_eoverflow = 0,
+	};
+	struct mt_thread_args b = {
+		.threshold_us     = 3000,    /* 3 ms */
+		.workload_us      = 30000,   /* 30 ms spin -> over budget */
+		.busy             = 1,
+		.expect_eoverflow = 1,
+	};
+
+	pthread_create(&ta, NULL, mt_thread_fn, &a);
+	pthread_create(&tb, NULL, mt_thread_fn, &b);
+	pthread_join(ta, NULL);
+	pthread_join(tb, NULL);
+
+	return (a.result || b.result) ? 1 : 0;
+}
+
+/*
+ * Benchmark TRACE_START, TRACE_STOP, and round-trip ioctls.
+ * Output uses TAP '#' prefix; always returns 0.
+ */
+#define BENCH_WARMUP  32
+#define BENCH_N      1000
+
+static long long timespec_diff_ns(const struct timespec *a,
+				   const struct timespec *b)
+{
+	return (long long)(b->tv_sec - a->tv_sec) * 1000000000LL
+		+ (b->tv_nsec - a->tv_nsec);
+}
+
+static int test_bench(void)
+{
+	struct tlob_start_args args = {
+		.threshold_us = 10000000ULL, /* 10 s */
+	};
+	struct timespec t0, t1;
+	long long total_start_ns = 0, total_stop_ns = 0, total_rt_ns = 0;
+	int i;
+
+	/* warm up */
+	for (i = 0; i < BENCH_WARMUP; i++) {
+		if (ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args) == 0)
+			ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	}
+
+	/* start only */
+	for (i = 0; i < BENCH_N; i++) {
+		clock_gettime(CLOCK_MONOTONIC, &t0);
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+		clock_gettime(CLOCK_MONOTONIC, &t1);
+		total_start_ns += timespec_diff_ns(&t0, &t1);
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	}
+
+	/* stop only */
+	for (i = 0; i < BENCH_N; i++) {
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+		clock_gettime(CLOCK_MONOTONIC, &t0);
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &t1);
+		total_stop_ns += timespec_diff_ns(&t0, &t1);
+	}
+
+	/* round-trip */
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	for (i = 0; i < BENCH_N; i++) {
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+		ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	}
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	total_rt_ns = timespec_diff_ns(&t0, &t1);
+
+	printf("# start ioctl only:      %lld ns/iter (N=%d, includes syscall)\n",
+	       total_start_ns / BENCH_N, BENCH_N);
+	printf("# stop ioctl only:       %lld ns/iter (N=%d, includes syscall)\n",
+	       total_stop_ns / BENCH_N, BENCH_N);
+	printf("# start+stop roundtrip:  %lld ns/iter (N=%d, includes 2 syscalls)\n",
+	       total_rt_ns / BENCH_N, BENCH_N);
+	return 0;
+}
+
+/*
+ * Print the ELF file offset of <symname> in <binary>.  Walks .symtab
+ * (falling back to .dynsym) and converts vaddr to file offset via PT_LOAD.
+ * Supports 32- and 64-bit ELF.
+ */
+static int sym_offset(const char *binary, const char *symname)
+{
+	int fd;
+	struct stat st;
+	void *map;
+	Elf64_Ehdr *ehdr;
+	Elf32_Ehdr *ehdr32;
+	int is64;
+	uint64_t sym_vaddr = 0;
+	int found = 0;
+	uint64_t file_offset = 0;
+
+	fd = open(binary, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open %s: %s\n", binary, strerror(errno));
+		return 1;
+	}
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return 1;
+	}
+	map = mmap(NULL, (size_t)st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "mmap: %s\n", strerror(errno));
+		return 1;
+	}
+
+	ehdr = (Elf64_Ehdr *)map;
+	ehdr32 = (Elf32_Ehdr *)map;
+	if (st.st_size < 4 ||
+	    ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
+	    ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
+	    ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
+	    ehdr->e_ident[EI_MAG3] != ELFMAG3) {
+		fprintf(stderr, "%s: not an ELF file\n", binary);
+		munmap(map, (size_t)st.st_size);
+		return 1;
+	}
+	is64 = (ehdr->e_ident[EI_CLASS] == ELFCLASS64);
+
+	if (is64) {
+		Elf64_Shdr *shdrs = (Elf64_Shdr *)((char *)map + ehdr->e_shoff);
+		Elf64_Shdr *shstrtab_hdr = &shdrs[ehdr->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+
+		/* prefer .symtab; fall back to .dynsym */
+		for (int pass = 0; pass < 2 && !found; pass++) {
+			const char *target = pass ? ".dynsym" : ".symtab";
+
+			for (si = 0; si < ehdr->e_shnum && !found; si++) {
+				Elf64_Shdr *sh = &shdrs[si];
+				const char *name = shstrtab + sh->sh_name;
+
+				if (strcmp(name, target) != 0)
+					continue;
+
+				Elf64_Shdr *strtab_sh = &shdrs[sh->sh_link];
+				const char *strtab = (char *)map + strtab_sh->sh_offset;
+				Elf64_Sym *syms = (Elf64_Sym *)((char *)map + sh->sh_offset);
+				uint64_t nsyms = sh->sh_size / sizeof(Elf64_Sym);
+				uint64_t j;
+
+				for (j = 0; j < nsyms; j++) {
+					if (strcmp(strtab + syms[j].st_name, symname) == 0) {
+						sym_vaddr = syms[j].st_value;
+						found = 1;
+						break;
+					}
+				}
+			}
+		}
+
+		if (!found) {
+			fprintf(stderr, "symbol '%s' not found in %s\n", symname, binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+
+		/* Convert vaddr to file offset via PT_LOAD segments */
+		Elf64_Phdr *phdrs = (Elf64_Phdr *)((char *)map + ehdr->e_phoff);
+		int pi;
+
+		for (pi = 0; pi < ehdr->e_phnum; pi++) {
+			Elf64_Phdr *ph = &phdrs[pi];
+
+			if (ph->p_type != PT_LOAD)
+				continue;
+			if (sym_vaddr >= ph->p_vaddr &&
+			    sym_vaddr < ph->p_vaddr + ph->p_filesz) {
+				file_offset = sym_vaddr - ph->p_vaddr + ph->p_offset;
+				break;
+			}
+		}
+	} else {
+		/* 32-bit ELF */
+		Elf32_Shdr *shdrs = (Elf32_Shdr *)((char *)map + ehdr32->e_shoff);
+		Elf32_Shdr *shstrtab_hdr = &shdrs[ehdr32->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+		uint32_t sym_vaddr32 = 0;
+
+		for (int pass = 0; pass < 2 && !found; pass++) {
+			const char *target = pass ? ".dynsym" : ".symtab";
+
+			for (si = 0; si < ehdr32->e_shnum && !found; si++) {
+				Elf32_Shdr *sh = &shdrs[si];
+				const char *name = shstrtab + sh->sh_name;
+
+				if (strcmp(name, target) != 0)
+					continue;
+
+				Elf32_Shdr *strtab_sh = &shdrs[sh->sh_link];
+				const char *strtab = (char *)map + strtab_sh->sh_offset;
+				Elf32_Sym *syms = (Elf32_Sym *)((char *)map + sh->sh_offset);
+				uint32_t nsyms = sh->sh_size / sizeof(Elf32_Sym);
+				uint32_t j;
+
+				for (j = 0; j < nsyms; j++) {
+					if (strcmp(strtab + syms[j].st_name, symname) == 0) {
+						sym_vaddr32 = syms[j].st_value;
+						found = 1;
+						break;
+					}
+				}
+			}
+		}
+
+		if (!found) {
+			fprintf(stderr, "symbol '%s' not found in %s\n", symname, binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+
+		Elf32_Phdr *phdrs = (Elf32_Phdr *)((char *)map + ehdr32->e_phoff);
+		int pi;
+
+		for (pi = 0; pi < ehdr32->e_phnum; pi++) {
+			Elf32_Phdr *ph = &phdrs[pi];
+
+			if (ph->p_type != PT_LOAD)
+				continue;
+			if (sym_vaddr32 >= ph->p_vaddr &&
+			    sym_vaddr32 < ph->p_vaddr + ph->p_filesz) {
+				file_offset = sym_vaddr32 - ph->p_vaddr + ph->p_offset;
+				break;
+			}
+		}
+		sym_vaddr = sym_vaddr32;
+	}
+
+	munmap(map, (size_t)st.st_size);
+
+	if (!file_offset && sym_vaddr) {
+		fprintf(stderr, "could not map vaddr 0x%lx to file offset\n",
+			(unsigned long)sym_vaddr);
+		return 1;
+	}
+
+	printf("0x%lx\n", (unsigned long)file_offset);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int rc;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <subcommand> [args...]\n", argv[0]);
+		return 1;
+	}
+
+	/* sym_offset does not need /dev/rv */
+	if (strcmp(argv[1], "sym_offset") == 0) {
+		if (argc < 4) {
+			fprintf(stderr, "Usage: %s sym_offset <binary> <symbol>\n",
+				argv[0]);
+			return 1;
+		}
+		return sym_offset(argv[2], argv[3]);
+	}
+
+	/* not_enabled: monitor is disabled; bind must return ENODEV without open_rv() */
+	if (strcmp(argv[1], "not_enabled") == 0)
+		return test_not_enabled();
+
+	if (open_rv() < 0)
+		return 2; /* skip */
+
+	if (strcmp(argv[1], "bench") == 0)
+		rc = test_bench();
+	else if (strcmp(argv[1], "within_budget") == 0)
+		rc = test_within_budget();
+	else if (strcmp(argv[1], "over_budget_running") == 0)
+		rc = test_over_budget_running();
+	else if (strcmp(argv[1], "over_budget_sleeping") == 0)
+		rc = test_over_budget_sleeping();
+	else if (strcmp(argv[1], "over_budget_waiting") == 0)
+		rc = test_over_budget_waiting();
+	else if (strcmp(argv[1], "double_start") == 0)
+		rc = test_double_start();
+	else if (strcmp(argv[1], "stop_no_start") == 0)
+		rc = test_stop_no_start();
+	else if (strcmp(argv[1], "multi_thread") == 0)
+		rc = test_multi_thread();
+	else {
+		fprintf(stderr, "Unknown test: %s\n", argv[1]);
+		rc = 1;
+	}
+
+	close(rv_fd);
+	return rc;
+}
diff --git a/tools/testing/selftests/verification/tlob/tlob_target.c b/tools/testing/selftests/verification/tlob/tlob_target.c
new file mode 100644
index 000000000000..0fdbc575d71d
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob/tlob_target.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_target.c - uprobe target binary for tlob selftests.
+ *
+ * Provides three start/stop probe pairs, each designed to exercise a
+ * different dominant component of the detail_env_tlob ns breakdown:
+ *
+ *   tlob_busy_work    / tlob_busy_work_done    - busy-spin: running_ns dominates
+ *   tlob_sleep_work   / tlob_sleep_work_done   - nanosleep: sleeping_ns dominates
+ *   tlob_preempt_work / tlob_preempt_work_done - busy-spin: waiting_ns dominates
+ *                                                (needs an RT competitor on the same CPU)
+ *
+ * Usage: tlob_target <duration_ms> [mode]
+ *
+ * mode is one of: busy (default), sleep, preempt.
+ * Loops in 200 ms iterations until <duration_ms> has elapsed
+ * (0 = run for ~24 hours).
+ */
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+static inline int timespec_before(const struct timespec *a,
+				   const struct timespec *b)
+{
+	return a->tv_sec < b->tv_sec ||
+	       (a->tv_sec == b->tv_sec && a->tv_nsec < b->tv_nsec);
+}
+
+static void timespec_add_ms(struct timespec *ts, unsigned long ms)
+{
+	ts->tv_sec  += ms / 1000;
+	ts->tv_nsec += (long)(ms % 1000) * 1000000L;
+	if (ts->tv_nsec >= 1000000000L) {
+		ts->tv_sec++;
+		ts->tv_nsec -= 1000000000L;
+	}
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_busy_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/* start probe; busy-spin so running_ns dominates */
+noinline void tlob_busy_work(unsigned long duration_ns)
+{
+	struct timespec start, now;
+	unsigned long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (unsigned long)(now.tv_sec - start.tv_sec)
+			  * 1000000000UL
+			+ (unsigned long)(now.tv_nsec - start.tv_nsec);
+	} while (elapsed < duration_ns);
+
+	tlob_busy_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_sleep_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/* start probe; nanosleep so sleeping_ns dominates */
+noinline void tlob_sleep_work(unsigned long duration_ms)
+{
+	struct timespec ts = {
+		.tv_sec  = duration_ms / 1000,
+		.tv_nsec = (long)(duration_ms % 1000) * 1000000L,
+	};
+	nanosleep(&ts, NULL);
+	tlob_sleep_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_preempt_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/*
+ * start probe; busy-spin so an RT competitor on the same CPU drives
+ * waiting_ns (prev_state==0 -> preempt event, task stays runnable off-CPU).
+ */
+noinline void tlob_preempt_work(unsigned long duration_ms)
+{
+	struct timespec start, now;
+	unsigned long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (unsigned long)(now.tv_sec - start.tv_sec)
+			  * 1000000000UL
+			+ (unsigned long)(now.tv_nsec - start.tv_nsec);
+	} while (elapsed < duration_ms * 1000000UL);
+
+	tlob_preempt_work_done();
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long duration_ms = 0;
+	const char *mode = "busy";
+	struct timespec deadline, now;
+
+	if (argc >= 2)
+		duration_ms = strtoul(argv[1], NULL, 10);
+	if (argc >= 3)
+		mode = argv[2];
+
+	clock_gettime(CLOCK_MONOTONIC, &deadline);
+	timespec_add_ms(&deadline, duration_ms ? duration_ms : 86400000UL);
+
+	do {
+		if (strcmp(mode, "sleep") == 0)
+			tlob_sleep_work(200);
+		else if (strcmp(mode, "preempt") == 0)
+			tlob_preempt_work(200);
+		else
+			tlob_busy_work(200 * 1000000UL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (timespec_before(&now, &deadline));
+
+	return 0;
+}
-- 
2.25.1

