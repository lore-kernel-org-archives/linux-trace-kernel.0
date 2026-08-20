Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60847F768
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244385; cv=none; b=uDmLYSKn+nRurLP05jOwn16pLWwOxjhIzGV4gskoXB3inyhTeov5RCcumxJiUswR2lgoP9zvPSIIw+4wZZOGpevFQ8g0iYt3eomjiVpeZcTWL55VYjR+9dSfA5Y2P8wz1MCMKFD+Ce5acIUA2AjZj/IHmeTHwZXYpQ2Htx6YM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244385; c=relaxed/simple;
	bh=+peesiBSV0+sMYVERKRUtQD093ffMPLJVubrwg4tsYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgRH9hkp3tsNlrwsR6AySH2mfn8rGd+hTtKVvLhONZeYAGZMu+ThDcV1mbGy9GuwD1Qz9OeMFrl11JmxXzZpccVfEOmwn/LhJbNDC6EKCuYQbtVDQIjT7Yqyw3BJTKN8Ag7Spq+v2zxkYYnKQjdDAHWNkWIYSXKAmon5NIKlJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afUMhIcr; arc=none smtp.client-ip=95.215.58.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afUMhIcr"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+peesiBSV0+sMYVERKRUtQD093ffMPLJVubrwg4tsYs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244379; v=1; x=1787849179;
 b=afUMhIcrY+ORSWZtu0xpZR3QqcI9zUzpyW2NiN12X6pQpmhrJXHtLaJ762KRPH9s3T1n5Hgj
 gdBX7ZyXvOMfGOfiXsFybpz8lqgjYzknvMVqByUce2s3E/WQeAajPopvW2bqCAtoAa8e0CZH7M7
 NsL5NOS4rVu9MIoCUzU6RC3Q=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 5eba8a16e5c3c9f6;
	Thu, 20 Aug 2026 16:46:19 +0000
X-Mizu-Trace-ID: 5eba8a16e5c3c9f6
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 8/9] selftests/verification: Add tlob selftests
Date: Fri, 21 Aug 2026 00:45:17 +0800
Message-Id: <c1305284e09e0522c5c88e8ebf4a0f6e59541999.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add seven ftrace-style test scripts for the tlob RV monitor under
tools/testing/selftests/verification/test.d/tlob/.  The tests cover
uprobe binding management, budget violation detection, and per-state
time accounting.

run_tlob_tests.sh is a thin wrapper: it builds the helpers and delegates
all argument handling to ftracetest via exec "$FTRACETEST" -K --rv "$@".

All .tc files that start background processes set up a trap teardown EXIT
immediately after launch so background tasks are cleaned up even when a
subsequent assertion fails under set -e.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 .../testing/selftests/verification/.gitignore |   2 +
 tools/testing/selftests/verification/Makefile |   4 +
 .../test.d/tlob/run_tlob_tests.sh             |  23 ++
 .../verification/test.d/tlob/uprobe_bind.tc   |  39 +++
 .../test.d/tlob/uprobe_detail_running.tc      |  53 +++++
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  52 ++++
 .../test.d/tlob/uprobe_detail_waiting.tc      |  76 ++++++
 .../verification/test.d/tlob/uprobe_multi.tc  |  63 +++++
 .../test.d/tlob/uprobe_no_event.tc            |  17 ++
 .../test.d/tlob/uprobe_restart.tc             |  79 ++++++
 .../test.d/tlob/uprobe_violation.tc           |  69 ++++++
 .../testing/selftests/verification/tlob_sym.c | 225 ++++++++++++++++++
 .../selftests/verification/tlob_target.c      | 138 +++++++++++
 13 files changed, 840 insertions(+)
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

diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testing/selftests/verification/.gitignore
index 2659417cb2c7..d2f231f1bacb 100644
--- a/tools/testing/selftests/verification/.gitignore
+++ b/tools/testing/selftests/verification/.gitignore
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
+tlob_sym
+tlob_target
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
index aa8790c22a71..41445d15b86a 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -5,4 +5,8 @@ TEST_PROGS := verificationtest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+TEST_GEN_FILES := tlob_sym tlob_target
+
 include ../lib.mk
+
+export VERIFICATIONTEST_BINDIR := $(OUTPUT)
diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
new file mode 100755
index 000000000000..d8f96c4ecc2c
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Standalone runner for tlob selftests
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+BINDIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
+FTRACETEST="$(cd "$SCRIPT_DIR/../../../ftrace" && pwd)/ftracetest"
+
+# Rebuild helpers when the Makefile is present (source-tree run).
+# Skip silently in installed kselftest environments where source is absent.
+if [ -f "$BINDIR/Makefile" ]; then
+	make -C "$BINDIR" tlob_target tlob_sym
+fi
+
+if [ ! -x "$BINDIR/tlob_target" ] || [ ! -x "$BINDIR/tlob_sym" ]; then
+	echo "ERROR: tlob_target or tlob_sym not found in $BINDIR" >&2
+	exit 1
+fi
+
+export VERIFICATIONTEST_BINDIR="$BINDIR"
+
+exec "$FTRACETEST" -K --rv "$SCRIPT_DIR" "$@"
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
new file mode 100644
index 000000000000..950ef0497542
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor uprobe binding (visible in monitor file, removable, duplicate rejected)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+teardown() {
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > monitors/tlob/enable
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=5000000000" > "$TLOB_MONITOR"
+
+# Binding must appear in monitor file with canonical hex-offset format.
+grep -qE "^p ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=[0-9]+$" "$TLOB_MONITOR"
+grep -q "threshold=5000000000" "$TLOB_MONITOR"
+
+# Duplicate offset_start must be rejected.
+! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=9999000" > "$TLOB_MONITOR" 2>/dev/null || false
+
+# Remove the binding; it must no longer appear.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
new file mode 100644
index 000000000000..e1e857144237
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail running (running_ns dominates when task busy-spins between probes)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+
+"$UPROBE_TARGET" 5000 &
+busy_pid=$!
+teardown() {
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 10 us budget; task busy-spins 200 ms per iteration -> running_ns dominates.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=10000" > "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" ../trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
+[ "$running" -gt "$sleeping" ]
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
new file mode 100644
index 000000000000..7165190cef7b
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail sleeping (sleeping_ns dominates when task blocks between probes)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+
+"$UPROBE_TARGET" 5000 sleep &
+busy_pid=$!
+teardown() {
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 50 ms budget; task sleeps 200 ms per iteration -> sleeping_ns dominates.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=50000000" > "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" ../trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$sleeping" -gt "$((running + waiting))" ]
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
new file mode 100644
index 000000000000..798a04012b6e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail waiting (waiting_ns dominates when task is preempted between probes)
+# requires: tlob:monitor chrt:program taskset:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+# This test pins a SCHED_FIFO-99 hog on a dedicated CPU; at least 2 CPUs
+# are required so the test runner itself is never starved.
+[ "$(nproc)" -ge 2 ] || exit_unresolved
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work_done 2>/dev/null)
+
+# Pick the last CPU to avoid cpu0 which is used by vng infrastructure.
+cpu=$(($(nproc) - 1))
+
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# tlob_target loops calling tlob_preempt_work(200) / tlob_preempt_work_done()
+# in 200 ms wall-clock iterations.  The stop probe fires when
+# tlob_preempt_work_done() is called, which cancels the budget timer.
+# Budget must be less than 200 ms so the HA timer fires while the target is
+# still inside tlob_preempt_work() and before the stop probe fires.
+# 150 ms gives a comfortable margin: waiting_ns ≈ 140 ms >> running_ns < 10 ms.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=150000000" > "$TLOB_MONITOR"
+
+# Start the RT hog BEFORE the target so the target is immediately preempted
+# when it calls tlob_preempt_work() (start probe fires), minimising running_ns.
+chrt -f 99 taskset -c "$cpu" sh -c 'while true; do :; done' 2>/dev/null &
+hog_pid=$!
+teardown() {
+    kill "$hog_pid"  2>/dev/null || true; wait "$hog_pid"  2>/dev/null || true
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.02
+
+taskset -c "$cpu" "$UPROBE_TARGET" 5000 preempt &
+busy_pid=$!
+
+# Poll up to 3 s (budget 150 ms + generous margin).
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+# Kill the RT hog first so tlob_target can release any in-flight SRCU read
+# section from uprobe_notify_resume; otherwise probe removal blocks in
+# synchronize_srcu with the hog monopolising the CPU at FIFO-99.
+kill "$hog_pid" 2>/dev/null || true; wait "$hog_pid" 2>/dev/null || true
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" ../trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+[ "$waiting" -gt "$((running + sleeping))" ]
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
new file mode 100644
index 000000000000..b24ec9473f3c
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor multiple uprobe bindings (different offsets fire independently)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+busy_stop=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+sleep_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+sleep_stop=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+
+"$UPROBE_TARGET" 30000 &       # busy mode: tlob_busy_work fires every 200 ms
+busy_pid=$!
+"$UPROBE_TARGET" 30000 sleep & # sleep mode: tlob_sleep_work fires every 200 ms
+sleep_pid=$!
+teardown() {
+    kill "$sleep_pid" 2>/dev/null || true; wait "$sleep_pid" 2>/dev/null || true
+    kill "$busy_pid"  2>/dev/null || true; wait "$busy_pid"  2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loops.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=5000000000" > "$TLOB_MONITOR"
+# Binding B: 10 us budget on the sleep probe - fires on first invocation.
+echo "p ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=10000" > "$TLOB_MONITOR"
+
+# Wait up to 2 s for error_env_tlob from binding B.
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "error_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo "-${UPROBE_TARGET}:${sleep_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > ../events/rv/detail_env_tlob/enable
+
+[ "$found" = "1" ]
+# error_env_tlob payload: clock variable must be present.
+# The event field can be "budget_exceeded" (hrtimer path) or the DA event
+# name ("sleep", "preempt") depending on which fires first; don't constrain it.
+grep "error_env_tlob" ../trace | head -n 1 | grep -q "clk_elapsed="
+# detail_env_tlob must appear alongside the error.
+grep -q "detail_env_tlob" ../trace
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
new file mode 100644
index 000000000000..23f8abeca090
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor no spurious events without active uprobe binding
+# requires: tlob:monitor
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+sleep 0.5
+
+! grep -q "error_env_tlob" ../trace || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
new file mode 100644
index 000000000000..fc3788c5fd0a
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
@@ -0,0 +1,79 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor restarting a parked window on the same task (no cross-window accumulator leak, unbind of a repeatedly-started task works)
+# requires: tlob:monitor
+
+set -x
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+# Diagnostic dump for a budget-violation regression: prints the exact
+# error_env_tlob entry (state + clk_elapsed at expiry), the per-state
+# accumulator breakdown, and the full start/stop transition sequence for
+# the monitored pid, so a false-positive violation can be told apart from
+# a genuine per-window overrun (and, if it is the latter, whether the
+# accumulators leaked across a restart).
+dump_tlob_diag() {
+	TRACE=../trace
+	echo "===== tlob restart diagnostic (pid ${busy_pid}) =====" >&2
+	echo "--- error_env_tlob (violations) ---" >&2
+	grep "error_env_tlob" "$TRACE" >&2 || true
+	echo "--- detail_env_tlob (accumulator breakdown) ---" >&2
+	grep "detail_env_tlob" "$TRACE" >&2 || true
+	echo "--- event_tlob (state transitions for target pid) ---" >&2
+	grep "event_tlob" "$TRACE" | grep ":${busy_pid}:" >&2 || true
+	echo "--- last 50 trace lines (full context) ---" >&2
+	tail -50 "$TRACE" >&2 || true
+}
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+
+# tlob_target loops calling tlob_busy_work(200)/tlob_busy_work_done() every
+# ~200ms for the whole run: each call is one start/stop window on the SAME
+# task, driving tlob_start_task()'s restart path (same pid, parked ws) on
+# every iteration after the first.  900ms gives ~4 such windows.
+"$UPROBE_TARGET" 900 &
+busy_pid=$!
+teardown() {
+	kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 300ms budget: comfortably covers one ~200ms window.  If a restart failed
+# to reset ws->accs_ns[]/budget_exceeded (a regression this test exists to
+# catch), running_ns would keep growing across windows and the SECOND
+# window would already exceed budget (~400ms cumulative > 300ms).  With a
+# correct reset, no window ever exceeds it.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=300000000" > "$TLOB_MONITOR"
+
+wait "$busy_pid" || true
+
+if grep -q "error_env_tlob" ../trace; then
+	dump_tlob_diag
+	false
+fi
+
+# The task has exited (tlob_destroy_task() ran via handle_sched_process_exit);
+# removing its now-stale binding must still succeed cleanly.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > ../events/rv/detail_env_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
new file mode 100644
index 000000000000..cf8d38b3a2bc
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor budget violation (error_env_tlob and detail_env_tlob fire with correct fields)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM="${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+teardown() {
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../events/rv/detail_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 10 us budget - fires almost immediately; task is busy-spinning on-CPU.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=10000" > "$TLOB_MONITOR"
+
+# wait up to 2 s for detail_env_tlob
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > ../events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+# error_env_tlob must carry the clk_elapsed environment field.
+# The event label is "budget_exceeded" when detected by the hrtimer callback,
+# or the triggering sched event name when detected by the constraint path on a
+# preemption that races with the timer (common on PREEMPT_RT / VM).  Both are
+# valid detections; check the env field instead of the label.
+grep "error_env_tlob" ../trace | head -n 1 | grep -q "clk_elapsed="
+
+# detail_env_tlob must have all five fields with the correct threshold
+line=$(grep "detail_env_tlob" ../trace | head -n 1)
+echo "$line" | grep -q "pid="
+echo "$line" | grep -q "threshold_ns=10000"
+echo "$line" | grep -q "running_ns="
+echo "$line" | grep -q "waiting_ns="
+echo "$line" | grep -q "sleeping_ns="
+
+# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$running" -gt "$sleeping" ]
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/tlob_sym.c b/tools/testing/selftests/verification/tlob_sym.c
new file mode 100644
index 000000000000..2d9561331d2f
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob_sym.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_sym.c - ELF symbol-to-file-offset utility for tlob selftests
+ *
+ * Usage: tlob_sym sym_offset <binary> <symbol>
+ *
+ *   Prints the ELF file offset of <symbol> in <binary> to stdout.
+ *
+ * Exit: 0 = found, 1 = error / not found.
+ */
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
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
+		Elf64_Shdr *shdrs;
+		Elf64_Shdr *shstrtab_hdr;
+
+		if (ehdr->e_shnum == 0 || ehdr->e_shstrndx >= ehdr->e_shnum ||
+		    (uint64_t)ehdr->e_shoff +
+		    (uint64_t)ehdr->e_shnum * sizeof(Elf64_Shdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF section table\n", binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+		shdrs = (Elf64_Shdr *)((char *)map + ehdr->e_shoff);
+		shstrtab_hdr = &shdrs[ehdr->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+
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
+		if (ehdr->e_phnum == 0 ||
+		    (uint64_t)ehdr->e_phoff +
+		    (uint64_t)ehdr->e_phnum * sizeof(Elf64_Phdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF program table\n", binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+
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
+		Elf32_Shdr *shdrs;
+		Elf32_Shdr *shstrtab_hdr;
+
+		if (ehdr32->e_shnum == 0 || ehdr32->e_shstrndx >= ehdr32->e_shnum ||
+		    (uint64_t)ehdr32->e_shoff +
+		    (uint64_t)ehdr32->e_shnum * sizeof(Elf32_Shdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF section table\n", binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+		shdrs = (Elf32_Shdr *)((char *)map + ehdr32->e_shoff);
+		shstrtab_hdr = &shdrs[ehdr32->e_shstrndx];
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
+		if (ehdr32->e_phnum == 0 ||
+		    (uint64_t)ehdr32->e_phoff +
+		    (uint64_t)ehdr32->e_phnum * sizeof(Elf32_Phdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF program table\n", binary);
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
+	if (argc != 4 || strcmp(argv[1], "sym_offset") != 0) {
+		fprintf(stderr, "Usage: %s sym_offset <binary> <symbol>\n", argv[0]);
+		return 1;
+	}
+	return sym_offset(argv[2], argv[3]);
+}
diff --git a/tools/testing/selftests/verification/tlob_target.c b/tools/testing/selftests/verification/tlob_target.c
new file mode 100644
index 000000000000..b32ee6243c00
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob_target.c
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
+ *   tlob_preempt_work / tlob_preempt_work_done - busy-spin + RT competitor:
+ *                                                waiting_ns dominates
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
+	asm volatile("" ::: "memory");
+}
+
+/* start probe; busy-spin so running_ns dominates */
+noinline void tlob_busy_work(unsigned long duration_ms)
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
+	tlob_busy_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_sleep_work_done(void)
+{
+	asm volatile("" ::: "memory");
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
+	asm volatile("" ::: "memory");
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
+			tlob_busy_work(200);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (timespec_before(&now, &deadline));
+
+	return 0;
+}
-- 
2.25.1

