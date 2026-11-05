Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901061;
	b=GltbIBVABwMSEPD+oKKl5IiaeKdAhDaL/SEszXB8aGXoi2YtZIipSql0OdwlivHo90Oy
	 06yKSTOSgBKk73t8Pkh/AR1Oj/XAAiobNSehhRsrVok8bx/xeC5OCO/0Mydv2dT+MNmz8
	 P3qJOS12ORwKzkQ+wOK+Um7SYF8CIE6e5Szm+lflGdLiT44aVuDfktKkZOEGNuOWGNxqA
	 lkr5BvJ3b7ZoRWHLb4bk/OTnFeDYfeHJoazNK7BESZsfnGpVcRu8dFoGpdGX3w4LwHTiK
	 2kpw7i9pOuHzWDbKheCdMnjUqweaoiN4p4XZ7V4oWAMGU3Ki/UFGmZpjuA8Qp6mV8KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901061;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZhdVqYyJgINg9IrwVF2fFSRbyuvUGS+mFdqNxUpqXys=;
	b=wj+nR4iQ2xXY2hnBomyyWR/iYUXyDty7Px3MS5EfK6j87DIPWYj13IIunwD8Hnn8lkSs
	 QMJ9ZBIHLlJk+HM5h4tVGOGO2LvKdwpyFGj8jZFvy2Cz16ANGeQ0ZpkTlT6eAN2DdAjHI
	 gUKQaclAbXFE6GB3pHFlBifsZpByIEQSWkCB5ZOrFgxylaRrrDqzQwsfV1QtIhJmd2rrH
	 UJvyoBWRXW/NuwhU/4ZtKPa0i4z9fkaNAAnC23Hq6HUXnOSBezJ05VVCSYlEnSCPlbAc3
	 OiawX5LWXgufWXWKTkcPij8XDX3avXCtatWd8PuVifMKfZKAZzkPbK3Bk4uZ8ff0PTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WLNoPJU9;
	arc=none smtp.remote-ip=91.218.175.110
Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669D606A332
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0669D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WLNoPJU9
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/BVKvpIADixZ13OwLNYripVHwph2q5FYJij+y5nG44o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901057; v=1; x=1794505857;
 b=WLNoPJU97H7hs8tO3Tvgdj1lmp/j7A4C8uLPv+NuR4lybSTXBtl6PC8i3XR9kcadCpZJZdWu
 XCQfwgd6D6aCh8woW0V8Hxq9XoELOlScrXQsmPjMGBRgWQ0ipsp193kJ6DkNHCM6ATlVKqUfHHn
 DrjstHaqsVQOXJAkU2dwkiXo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b0601804b98257ef;
	Thu, 05 Nov 2026 17:50:57 +0000
X-Mizu-Trace-ID: b0601804b98257ef
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 13/14] selftests/verification: Add tlob selftests
Date: Fri,  6 Nov 2026 01:49:13 +0800
Message-Id: <fb7f7a5e565e0b3e781257b8b870b0b684446d51.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
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

Add thirteen ftrace-style test scripts for the tlob RV monitor under
tools/testing/selftests/verification/test.d/tlob/.  The tests cover
uprobe binding management, budget violation detection, multi-binding,
multi-task sharing of one binding, overlap registration rejection,
unbind and disable on live tasks, start/stop restart (both normal and
after a violation), task exit inside a live window, nested START
reporting, and the 64-task pool exhaustion cap.

Helper binary tlob_target is built via TEST_GEN_FILES, following
the standard kselftests convention.  run_tlob_tests.sh verifies helper
availability and delegates argument handling to ftracetest.

The multi-instance test, covering several tasks bound to the same
uprobe pair, was contributed by Gabriele Monaco.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 .../testing/selftests/verification/.gitignore |   1 +
 tools/testing/selftests/verification/Makefile |   4 +
 tools/testing/selftests/verification/config   |   3 +
 .../selftests/verification/test.d/functions   |   9 +
 .../test.d/tlob/run_tlob_tests.sh             |  32 ++++
 .../verification/test.d/tlob/uprobe_bind.tc   |  47 ++++++
 .../test.d/tlob/uprobe_disable_live.tc        |  79 +++++++++
 .../verification/test.d/tlob/uprobe_multi.tc  |  58 +++++++
 .../test.d/tlob/uprobe_multi_instance.tc      |  65 ++++++++
 .../test.d/tlob/uprobe_nested_start.tc        |  62 +++++++
 .../test.d/tlob/uprobe_no_event.tc            |  17 ++
 .../test.d/tlob/uprobe_overlap_register.tc    |  66 ++++++++
 .../test.d/tlob/uprobe_pool_exhausted.tc      |  75 +++++++++
 .../test.d/tlob/uprobe_restart.tc             |  66 ++++++++
 .../test.d/tlob/uprobe_restart_violation.tc   |  48 ++++++
 .../test.d/tlob/uprobe_task_exit.tc           |  65 ++++++++
 .../test.d/tlob/uprobe_unbind_live.tc         |  65 ++++++++
 .../test.d/tlob/uprobe_violation.tc           |  53 ++++++
 .../selftests/verification/tlob_target.c      | 156 ++++++++++++++++++
 19 files changed, 971 insertions(+)
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

diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testing/selftests/verification/.gitignore
index 2659417cb2c7..92d7ebdb1dd1 100644
--- a/tools/testing/selftests/verification/.gitignore
+++ b/tools/testing/selftests/verification/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
+tlob_target
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
index aa8790c22a71..dcdfe3ea3c06 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -5,4 +5,8 @@ TEST_PROGS := verificationtest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+TEST_GEN_FILES := tlob_target
+
 include ../lib.mk
+
+export VERIFICATIONTEST_BINDIR := $(OUTPUT)
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
index 43072c1c38f4..5869ae4a9217 100644
--- a/tools/testing/selftests/verification/config
+++ b/tools/testing/selftests/verification/config
@@ -1 +1,4 @@
 CONFIG_RV=y
+CONFIG_RV_MON_TLOB=y
+CONFIG_UPROBES=y
+CONFIG_HIGH_RES_TIMERS=y
diff --git a/tools/testing/selftests/verification/test.d/functions b/tools/testing/selftests/verification/test.d/functions
index ec36a092f56e..43c119682c1f 100644
--- a/tools/testing/selftests/verification/test.d/functions
+++ b/tools/testing/selftests/verification/test.d/functions
@@ -25,6 +25,15 @@ check_requires() { # Check required files, monitors and reactors
 	done
 }
 
+sym_offset() { # <binary> <symbol>: print the ELF file offset of <symbol>
+	readelf -W -S -s "$1" | awk -v symbol="$2" '
+		{ gsub(/\[ /, "[") }
+		$1 ~ /^\[[0-9]+\]$/ { sections[$1]="0x"$4; offsets[$1]="0x"$5 }
+		$1 ~ /^[0-9]+:$/ && $NF == symbol { addr="0x"$2; sec="["$7"]" }
+		END { printf "printf \"0x%%x\\n\" $((%s - %s + %s))\n", addr, sections[sec], offsets[sec] }
+	' | sh
+}
+
 initialize_system() { # Reset RV to initial-state
 	echo > enabled_monitors
 	for m in monitors/*; do
diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
new file mode 100755
index 000000000000..c87484813fc8
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Standalone runner for tlob selftests
+
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+BINDIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
+FTRACETEST="$(cd "$SCRIPT_DIR/../../../ftrace" && pwd)/ftracetest"
+
+# The helper is built on the host by the selftests Makefile
+# (TEST_GEN_FILES in $BINDIR/Makefile); the VM (virtme-ng) mounts the
+# source read-only and may lack a compiler, so this runner never builds.
+# Build it on the host first:
+#   make -C "$BINDIR" tlob_target
+if [ ! -x "$BINDIR/tlob_target" ]; then
+	echo "ERROR: tlob_target not built in $BINDIR" >&2
+	echo "       build it on the host: make -C $BINDIR tlob_target" >&2
+	exit 1
+fi
+
+# Flag (not fail) the helper older than its source: git checkouts can bump
+# source mtimes, so a hard check would misfire; a host rebuild picks up
+# the new code.
+if [ -f "$BINDIR/tlob_target.c" ] &&
+   [ "$BINDIR/tlob_target" -ot "$BINDIR/tlob_target.c" ]; then
+	echo "WARNING: $BINDIR/tlob_target is older than $BINDIR/tlob_target.c;" >&2
+	echo "         rebuild on the host to test the current source" >&2
+fi
+
+export VERIFICATIONTEST_BINDIR="$BINDIR"
+
+exec "$FTRACETEST" -K --rv "$SCRIPT_DIR" "$@"
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
new file mode 100644
index 000000000000..6484f37d8d2e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor uprobe binding (named, listed, removable, duplicate name/range rejected, O_TRUNC clears)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
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
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=5000000000" >> "$TLOB_MONITOR"
+
+# Binding must appear in monitor file with canonical hex-offset format.
+grep -qE "^p:busy_work ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=[0-9]+$" "$TLOB_MONITOR"
+grep -q "threshold=5000000000" "$TLOB_MONITOR"
+
+# Duplicate range must be rejected.
+! echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=9999000" >> "$TLOB_MONITOR" 2>/dev/null || false
+
+# Duplicate name on a disjoint range must be rejected too.
+! echo "p:busy_work ${UPROBE_TARGET}:$((stop_offset + 64)) $((stop_offset + 128)) threshold=5000000" >> "$TLOB_MONITOR" 2>/dev/null || false
+
+# Remove the binding; it must no longer appear.
+echo "-:busy_work" >> "$TLOB_MONITOR"
+! grep -q "^p:busy_work " "$TLOB_MONITOR" || false
+
+# '>' opens with O_TRUNC and clears all bindings (ftrace dynamic-event
+# convention); individual commands must use '>>'.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=5000000000" >> "$TLOB_MONITOR"
+echo > "$TLOB_MONITOR"
+! grep -q "^p:" "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc
new file mode 100644
index 000000000000..c997405d75cc
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc
@@ -0,0 +1,79 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor disable with a live window (armed hrtimer cancelled, no post-cycle violation)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+sleep_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work_done)
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 300 ms budget keeps the live window far from expiry at disable; duration 0
+# loops the target so no STOP can fire while the monitor is down.
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${stop_offset} threshold=300000000" >> "$TLOB_MONITOR"
+
+"$UPROBE_TARGET" 0 sleep &
+target_pid=$!
+teardown() {
+    kill "$target_pid" 2>/dev/null || true; wait "$target_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+# Disable with the window open: the armed hrtimer must be cancelled by the
+# disable path, or it fires on freed storage.  Check /proc/timer_list.
+echo 0 > monitors/tlob/enable
+
+if [ ! -r /proc/timer_list ]; then
+    echo "/proc/timer_list unavailable, cannot check for leaked timers" >&2
+    exit_unresolved
+fi
+
+armed=$(grep -c ha_monitor /proc/timer_list || true)
+if [ "$armed" != "0" ]; then
+    echo "===== tlob disable-with-live-window diagnostic =====" >&2
+    echo "$armed armed ha_monitor hrtimer(s) after disable:" >&2
+    grep ha_monitor /proc/timer_list >&2 || true
+    false
+fi
+
+# A leaked timer would fire on freed storage once re-enabled.
+echo 1 > monitors/tlob/enable
+
+# Re-enabled before the 300 ms budget would have elapsed; wait past it.
+sleep 0.5
+
+if grep -q "error_env_tlob" ../trace; then
+    echo "===== tlob disable-with-live-window diagnostic =====" >&2
+    grep "error_env_tlob" ../trace >&2 || true
+    false
+fi
+
+# Disable/enable must not break detection: a 10 us budget fires on the
+# next sleep window.
+echo > ../trace
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${stop_offset} threshold=10000" >> "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+    sleep 0.1
+    grep -q "error_env_tlob" ../trace && { found=1; break; }
+    i=$((i+1))
+done
+
+echo "-:sleep_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
new file mode 100644
index 000000000000..709561ebc94c
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor multiple uprobe bindings (different offsets fire independently)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+busy_stop=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+sleep_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work)
+sleep_stop=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work_done)
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
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loops.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=5000000000" >> "$TLOB_MONITOR"
+# Binding B: 10 us budget on the sleep probe - fires on first invocation.
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=10000" >> "$TLOB_MONITOR"
+
+# Wait up to 2 s for error_env_tlob from binding B.
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "error_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-:busy_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo "-:sleep_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+
+[ "$found" = "1" ]
+# error_env_tlob payload: clock variable must be present.
+# The event field can be "budget_exceeded" (hrtimer path) or the DA event
+# name ("sleep", "preempt") depending on which fires first; don't constrain it.
+grep "error_env_tlob" ../trace | head -n 1 | grep -q "clk_elapsed="
+
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc
new file mode 100644
index 000000000000..238ceed065b0
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor multiple tasks sharing one uprobe binding (concurrent instances)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+UPROBE_COMM=$(basename "$UPROBE_TARGET")
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+busy_stop=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+
+# Start 3 concurrent instances of the target; each one hits the same binding.
+"$UPROBE_TARGET" 30000 &
+pid1=$!
+"$UPROBE_TARGET" 30000 &
+pid2=$!
+"$UPROBE_TARGET" 30000 &
+pid3=$!
+teardown() {
+	kill "$pid1" 2>/dev/null || true; wait "$pid1" 2>/dev/null || true
+	kill "$pid2" 2>/dev/null || true; wait "$pid2" 2>/dev/null || true
+	kill "$pid3" 2>/dev/null || true; wait "$pid3" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 5 s budget on the busy probe: no violation expected in 200 ms loops.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=5000000000" >> "$TLOB_MONITOR"
+
+# Wait up to 2 s for all three pids to register and transition through start.
+# This proves multiple tasks can hit the same uprobe binding concurrently.
+found1=0; found2=0; found3=0
+i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid1}" && found1=1
+	grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid2}" && found2=1
+	grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid3}" && found3=1
+	if [ "$found1" = "1" ] && [ "$found2" = "1" ] && [ "$found3" = "1" ]; then
+		break
+	fi
+	i=$((i+1))
+done
+
+[ "$found1" = "1" ]
+[ "$found2" = "1" ]
+[ "$found3" = "1" ]
+
+# Removing the binding while tasks are active must succeed cleanly.
+echo "-:busy_work" >> "$TLOB_MONITOR"
+! grep -q "^p:busy_work " "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_nested_start.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_nested_start.tc
new file mode 100644
index 000000000000..fe30db3f0134
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_nested_start.tc
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob reporting a nested START (a window is already open)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$(sym_offset "$UPROBE_TARGET" tlob_nested_start)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_nested_done)
+
+echo 1 > ../events/rv/error_tlob/enable
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+
+# Generous budget: anything reported here is the nested START, not the clock.
+echo "p:nested ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=5000000000" >> "$TLOB_MONITOR"
+echo > ../trace
+
+"$UPROBE_TARGET" 0 nest 1 &
+tpid=$!
+teardown() {
+    kill "$tpid" 2>/dev/null || true; wait "$tpid" 2>/dev/null || true
+}
+trap teardown EXIT
+wait "$tpid" || true
+trap - EXIT
+
+# The second entry is a START while the window is open: running x start is an
+# invalid transition, reported through error_tlob rather than silently ignored.
+if ! grep -q "error_tlob: ${tpid}: event start not expected in the state running" ../trace; then
+    echo "ERROR: nested START was not reported" >&2
+    grep -E "event_tlob|error_tlob" ../trace | grep ":${tpid}:" >&2 || true
+    false
+fi
+
+# One START opened the window; the nested one is refused and does not open a
+# second.  The violation resets the monitor, so the STOP that follows is a
+# no-op: no further transition may be recorded for this pid.
+starts=$(grep -c "event_tlob: ${tpid}: stopped x start -> running" ../trace)
+if [ "$starts" -ne 1 ]; then
+    echo "ERROR: expected exactly 1 window for ${tpid}, saw ${starts}" >&2
+    grep "event_tlob" ../trace | grep ":${tpid}:" >&2 || true
+    false
+fi
+
+if grep -q "event_tlob: ${tpid}: running x stop -> stopped" ../trace; then
+    echo "ERROR: STOP after a violation reopened/closed a window" >&2
+    grep "event_tlob" ../trace | grep ":${tpid}:" >&2 || true
+    false
+fi
+
+echo "-:nested" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
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
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.tc
new file mode 100644
index 000000000000..eb3590fa21aa
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.tc
@@ -0,0 +1,66 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob rejecting overlapping uprobe bindings and reporting shadowing
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+busy_stop=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+sleep_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work)
+sleep_stop=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work_done)
+
+echo 1 > ../events/rv/error_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# Scenario 1: overlapping ranges on the same binary are rejected at
+# registration (a task runs one window at a time; the second would shadow).
+# Covers three flavours: identical, nested, and crossing.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=1000000000" >> "$TLOB_MONITOR"
+for r in \
+	"${busy_offset} ${busy_stop}" \
+	"$((busy_offset + 8)) ${busy_stop}" \
+	"$((busy_stop - 8)) $((busy_stop + 8))"; do
+	set -- $r
+	if echo "p:dup ${UPROBE_TARGET}:$1 $2 threshold=1000000000" >> "$TLOB_MONITOR" 2>/dev/null; then
+		echo "ERROR: overlapping binding accepted: $r" >&2
+		false
+	fi
+done
+# Only the original binding survives.
+if [ "$(grep -c "^p:busy_work " "$TLOB_MONITOR")" -ne 1 ]; then
+	echo "ERROR: rejected range left a binding behind" >&2
+	false
+fi
+
+# Scenario 2: two disjoint ranges on the same binary are both accepted, but a
+# task running them sequentially is shadowed by the first binding -- reported
+# via error_tlob instead of a silent no-op.
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=1000000000" >> "$TLOB_MONITOR"
+"$UPROBE_TARGET" 0 seq 2 &
+tpid=$!
+teardown() {
+	kill "$tpid" 2>/dev/null || true; wait "$tpid" 2>/dev/null || true
+}
+trap teardown EXIT
+wait "$tpid" || true
+
+if ! grep -q "error_tlob" ../trace; then
+	echo "ERROR: no error_tlob for sequentially shadowed binding" >&2
+	echo "--- trace ---" >&2
+	grep "error_tlob\|event_tlob" ../trace >&2 || true
+	false
+fi
+
+echo "-:busy_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo "-:sleep_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_pool_exhausted.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_pool_exhausted.tc
new file mode 100644
index 000000000000..2b876566936a
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_pool_exhausted.tc
@@ -0,0 +1,75 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob per-object storage pool cap (64 tasks, the 65th is not monitored)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+# TLOB_MAX_MONITORED in kernel/trace/rv/monitors/tlob/tlob.h.
+POOL_SIZE=64
+
+sleep_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work_done)
+
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+
+# 5 s budget: no window may report here, only the pool accounting matters.
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${stop_offset} threshold=5000000000" >> "$TLOB_MONITOR"
+echo > ../trace
+
+pids=
+for i in $(seq 1 $POOL_SIZE); do
+    "$UPROBE_TARGET" 5000 sleep 0 &
+    pids="$pids $!"
+done
+teardown() {
+    for p in $pids; do kill "$p" 2>/dev/null || true; done
+    wait 2>/dev/null || true
+}
+trap teardown EXIT
+
+# Wait until every slot is taken: each of the 64 tasks opened a window once.
+n=0
+i=0
+while [ "$i" -lt 200 ]; do
+    n=$(sed -n 's/.*event_tlob: \([0-9][0-9]*\): stopped x start -> running.*/\1/p' ../trace | sort -u | wc -l)
+    [ "$n" -ge "$POOL_SIZE" ] && break
+    sleep 0.05
+    i=$((i + 1))
+done
+
+if [ "$n" -ne "$POOL_SIZE" ]; then
+    echo "ERROR: expected $POOL_SIZE monitored tasks, got $n" >&2
+    false
+fi
+
+# One more task must be left unmonitored: no START is possible without a slot.
+"$UPROBE_TARGET" 3000 sleep 0 &
+extra=$!
+pids="$pids $extra"
+sleep 0.5
+
+if grep -q "event_tlob: ${extra}: stopped x start -> running" ../trace; then
+    echo "ERROR: task ${extra} was monitored past the ${POOL_SIZE}-task cap" >&2
+    grep "event_tlob" ../trace | grep ":${extra}:" >&2 || true
+    false
+fi
+
+# A monitored task still holds its slot while the extra one is refused.
+n=$(sed -n 's/.*event_tlob: \([0-9][0-9]*\): stopped x start -> running.*/\1/p' ../trace | sort -u | wc -l)
+[ "$n" -eq "$POOL_SIZE" ] || {
+    echo "ERROR: pool accounting changed while refusing: $n" >&2
+    false
+}
+
+echo "-:sleep_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
new file mode 100644
index 000000000000..1584fc3d84de
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
@@ -0,0 +1,66 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor restarting a parked window on the same task (unbind of a repeatedly-started task works)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+# On failure: dump violations and the target's transitions, to tell a genuine
+# per-window overrun from a broken restart.
+dump_tlob_diag() {
+	TRACE=../trace
+	echo "===== tlob restart diagnostic (pid ${busy_pid}) =====" >&2
+	echo "--- error_env_tlob (violations) ---" >&2
+	grep "error_env_tlob" "$TRACE" >&2 || true
+	echo "--- event_tlob (state transitions for target pid) ---" >&2
+	grep "event_tlob" "$TRACE" | grep ":${busy_pid}:" >&2 || true
+	echo "--- last 50 trace lines (full context) ---" >&2
+	tail -50 "$TRACE" >&2 || true
+}
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+
+# tlob_target busy-loops ~200ms start/stop windows on the same task for
+# 900ms, driving tlob_start_task()'s restart path on every iteration
+# after the first (~4 windows).
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
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 300ms budget covers one ~200ms window.  A restart that failed to re-anchor
+# the budget clock would trip on the second window; with a correct restart,
+# no window exceeds it.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=300000000" >> "$TLOB_MONITOR"
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
+echo "-:busy_work" >> "$TLOB_MONITOR"
+! grep -q "^p:busy_work " "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation.tc
new file mode 100644
index 000000000000..dccb4e5baa11
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation.tc
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor restarting a window after a budget overrun (each later START on the same task starts a fresh window)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+
+# 30 ms budget: every ~200 ms window overruns.  Bind first, clear the trace
+# after, so the target's first window (START soon after launch) is caught.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=30000000" >> "$TLOB_MONITOR"
+echo > ../trace
+
+# 3 iterations (duration arg unused).  Every window overruns; a dropped
+# restart would leave one unmonitored, dropping the count below 3.
+"$UPROBE_TARGET" 0 busy 3 &
+busy_pid=$!
+teardown() {
+    kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+wait "$busy_pid" || true
+
+errors=$(grep -c "error_env_tlob" ../trace || true)
+if [ "$errors" -lt 3 ]; then
+    echo "ERROR: expected >= 3 error_env_tlob (one per window), got $errors" >&2
+    echo "--- error_env_tlob ---" >&2
+    grep "error_env_tlob" ../trace >&2 || true
+    echo "--- event_tlob (state transitions for target pid) ---" >&2
+    grep "event_tlob" ../trace | grep ":${busy_pid}:" >&2 || true
+    false
+fi
+
+echo "-:busy_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_task_exit.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_task_exit.tc
new file mode 100644
index 000000000000..b9122bc002e3
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_task_exit.tc
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob task exiting inside a window (timer disarmed, no late violation)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+
+# 1 s budget: the task is killed well inside its 200 ms busy window, so the
+# exit path (sched_process_exit) is what has to disarm the timer.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=1000000000" >> "$TLOB_MONITOR"
+echo > ../trace
+
+"$UPROBE_TARGET" 0 busy 0 &
+tpid=$!
+teardown() {
+    kill -9 "$tpid" 2>/dev/null || true; wait "$tpid" 2>/dev/null || true
+}
+trap teardown EXIT
+
+# Wait until the target actually opened a window, so the kill below lands
+# inside it rather than before the first START.
+i=0
+while [ "$i" -lt 100 ]; do
+    grep -q "event_tlob: ${tpid}: stopped x start -> running" ../trace && break
+    sleep 0.01
+    i=$((i + 1))
+done
+if ! grep -q "event_tlob: ${tpid}: stopped x start -> running" ../trace; then
+    echo "ERROR: target never opened a window" >&2
+    grep -E "event_tlob|error_tlob" ../trace >&2 || true
+    false
+fi
+
+kill -9 "$tpid"
+wait "$tpid" 2>/dev/null || true
+trap - EXIT
+
+# Past the budget: a timer the exit path left armed fires here and reports
+# against a task that no longer exists.
+sleep 1.3
+
+if grep -q "error_env_tlob: ${tpid}:" ../trace; then
+    echo "ERROR: violation reported for a task that exited inside its window" >&2
+    grep "error_env_tlob" ../trace >&2
+    false
+fi
+
+echo "-:busy_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc
new file mode 100644
index 000000000000..698bf907f653
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob unbind with a live window (no post-unbind violation, detection still works)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+sleep_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_sleep_work_done)
+
+echo 1 > ../events/rv/error_env_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 300 ms budget keeps the live window far from expiry at unbind; duration 0
+# loops the target.
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${stop_offset} threshold=300000000" >> "$TLOB_MONITOR"
+
+"$UPROBE_TARGET" 0 sleep &
+target_pid=$!
+teardown() {
+    kill "$target_pid" 2>/dev/null || true; wait "$target_pid" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+# Unbind while the window is open: the task can no longer reach STOP, so the
+# window must be ended and its timer cancelled before the budget expires.
+echo "-:sleep_work" >> "$TLOB_MONITOR"
+
+# Wait past the 300 ms budget.
+sleep 0.6
+
+if grep -q "error_env_tlob" ../trace; then
+    echo "===== tlob unbind-with-live-window diagnostic =====" >&2
+    grep "error_env_tlob" ../trace >&2 || true
+    false
+fi
+
+# The target survived the unbind (its window was torn down, not the task).
+kill -0 "$target_pid"
+
+# Unbind must not break detection: a 10 us budget fires on the next sleep window.
+echo > ../trace
+echo "p:sleep_work ${UPROBE_TARGET}:${sleep_offset} ${stop_offset} threshold=10000" >> "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+    sleep 0.1
+    grep -q "error_env_tlob" ../trace && { found=1; break; }
+    i=$((i+1))
+done
+
+echo "-:sleep_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/error_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+echo > ../trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
new file mode 100644
index 000000000000..eb4e5c9bd2e3
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor budget violation (error_env_tlob fires with correct fields)
+# requires: tlob:monitor readelf:program
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:="$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET="${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work)
+stop_offset=$(sym_offset "$UPROBE_TARGET" tlob_busy_work_done)
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
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 10 us budget - fires almost immediately; task is busy-spinning on-CPU.
+echo "p:busy_work ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=10000" >> "$TLOB_MONITOR"
+
+# wait up to 2 s for error_env_tlob
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "error_env_tlob" ../trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-:busy_work" >> "$TLOB_MONITOR" 2>/dev/null
+echo 0 > ../events/rv/error_env_tlob/enable
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
+echo > ../trace
diff --git a/tools/testing/selftests/verification/tlob_target.c b/tools/testing/selftests/verification/tlob_target.c
new file mode 100644
index 000000000000..706ff5e1eeca
--- /dev/null
+++ b/tools/testing/selftests/verification/tlob_target.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_target.c - uprobe target binary for tlob selftests.
+ *
+ * Provides two start/stop probe pairs:
+ *
+ *   tlob_busy_work  / tlob_busy_work_done  - busy-spin
+ *   tlob_sleep_work / tlob_sleep_work_done - nanosleep
+ *
+ * Usage: tlob_target <duration_ms> [mode] [iterations]
+ *
+ * mode is one of: busy (default), sleep, seq, nest.
+ * Loops in 200 ms iterations until <duration_ms> has elapsed
+ * (0 = run until killed, capped at TLOB_MAX_DURATION_MS), or exactly
+ * [iterations] times when > 0.
+ * seq runs busy then sleep in each iteration (two ranges back to back).
+ * nest opens a window and re-enters its own start probe once.
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
+/*
+ * Ceiling for duration_ms == 0.  The live tests background the target and
+ * kill it from their EXIT trap; the cap bounds an orphan left behind when
+ * the trap does not run.
+ */
+#define TLOB_MAX_DURATION_MS	60000UL
+
+static inline int timespec_before(const struct timespec *a,
+				  const struct timespec *b)
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
+/* Busy-wait for at least duration_ms ms of wall-clock time. */
+static inline void __tlob_busy_wait(unsigned long duration_ms)
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
+}
+
+/* start probe; busy-spin so the window is spent running */
+noinline void tlob_busy_work(unsigned long duration_ms)
+{
+	__tlob_busy_wait(duration_ms);
+	tlob_busy_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_sleep_work_done(void)
+{
+	asm volatile("" ::: "memory");
+}
+
+/* start probe; nanosleep so the window is spent sleeping */
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
+/*
+ * Nested window: the probe is placed on tlob_nested_start, and the function
+ * re-enters itself once, so the second entry is a START while the window is
+ * already open.
+ */
+static int tlob_nested_depth;
+
+noinline void tlob_nested_start(void)
+{
+	if (tlob_nested_depth++ < 1)
+		tlob_nested_start();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_nested_done(void)
+{
+	asm volatile("" ::: "memory");
+}
+
+static void tlob_nested_work(void)
+{
+	tlob_nested_depth = 0;
+	tlob_nested_start();
+	tlob_nested_done();
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long duration_ms = 0, iterations = 0, i = 0;
+	const char *mode = "busy";
+	struct timespec deadline, now;
+
+	if (argc >= 2)
+		duration_ms = strtoul(argv[1], NULL, 10);
+	if (argc >= 3)
+		mode = argv[2];
+	if (argc >= 4)
+		iterations = strtoul(argv[3], NULL, 10);
+
+	clock_gettime(CLOCK_MONOTONIC, &deadline);
+	timespec_add_ms(&deadline, duration_ms ? duration_ms : TLOB_MAX_DURATION_MS);
+
+	do {
+		if (strcmp(mode, "sleep") == 0)
+			tlob_sleep_work(200);
+		else if (strcmp(mode, "seq") == 0) {
+			tlob_busy_work(200);
+			tlob_sleep_work(200);
+		} else if (strcmp(mode, "nest") == 0)
+			tlob_nested_work();
+		else
+			tlob_busy_work(200);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		i++;
+	} while (iterations ? i < iterations : timespec_before(&now, &deadline));
+
+	return 0;
+}
-- 
2.25.1

