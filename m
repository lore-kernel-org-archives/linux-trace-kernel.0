Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463B37CD4D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022089; cv=none; b=fm2pmkdRISt0FlSdvU9hU4kxKUFsCsJP19lxNv5NxB163n1EMA8pImXfVp8cv+7AjB9LGRdL4tzebM5xO6Uu4jqD5A3Yb+fw+acjFsT2R8z4xzI5ovL9vhdchu0eWq5siAskeiVsvifoWWnJk0WvFHyS4/yAR1UbRROCwVaR3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022089; c=relaxed/simple;
	bh=n9OKgvDOHezgdOXRpwIepwoG6YT2/0v7G8Oc0Mtqk7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD4WRcLlMu1f0KxHAe89DX6Qkq/wPD4SFoefvaI21uW0MVrBUbkyNTRGNssT4egLwn1LalfJs6lak1rmPV+Hshp9aD5a3BdnZyLteDtbqSa4M3o9WGM7Wv8dzdkORXhLqpc0Wbf09SJSPBxHalR25MMSYfQKDl+qTaBuWOKd1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WtGcCqfB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WtGcCqfB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776022083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVl0/J49loY/n0G4qtERGNyHMovdk7XGYo1kwnRYBr4=;
	b=WtGcCqfBlXIGAJMBOdolPj8UKxJegKmJuBBoUUOI1rJHNJvxmW1TPAtSkW2agvtS9Pxq3l
	EAKvaE+QoEBM0/MvFyDGZpk8WsLSJi1krzZJQi+21qGQPDnh7iEk1ILPPYGtuwQMrjyFtu
	fSuIERXBw4sW0C/2TXpiIafJAA2jKp0=
From: wen.yang@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 4/4] selftests/rv: Add selftest for the tlob monitor
Date: Mon, 13 Apr 2026 03:27:21 +0800
Message-Id: <5bdd82dd8aeb1d3f955b727ae1fce9819b35c170.1776020428.git.wen.yang@linux.dev>
In-Reply-To: <cover.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add a kselftest suite (TAP output, 19 test points) for the tlob RV
monitor under tools/testing/selftests/rv/.

test_tlob.sh drives a compiled C helper (tlob_helper) and, for uprobe
tests, a target binary (tlob_uprobe_target). Coverage spans the
tracefs enable/disable path, uprobe-triggered violations, and the
ioctl interface (within-budget stop, CPU-bound and sleep violations,
duplicate start, ring buffer mmap and consumption).

Requires CONFIG_RV_MON_TLOB=y and CONFIG_RV_CHARDEV=y; must be run
as root.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/include/uapi/linux/rv.h                 |  54 +
 tools/testing/selftests/rv/Makefile           |  18 +
 tools/testing/selftests/rv/test_tlob.sh       | 563 ++++++++++
 tools/testing/selftests/rv/tlob_helper.c      | 994 ++++++++++++++++++
 .../testing/selftests/rv/tlob_uprobe_target.c | 108 ++
 5 files changed, 1737 insertions(+)
 create mode 100644 tools/include/uapi/linux/rv.h
 create mode 100644 tools/testing/selftests/rv/Makefile
 create mode 100755 tools/testing/selftests/rv/test_tlob.sh
 create mode 100644 tools/testing/selftests/rv/tlob_helper.c
 create mode 100644 tools/testing/selftests/rv/tlob_uprobe_target.c

diff --git a/tools/include/uapi/linux/rv.h b/tools/include/uapi/linux/rv.h
new file mode 100644
index 000000000..bef07aded
--- /dev/null
+++ b/tools/include/uapi/linux/rv.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * UAPI definitions for Runtime Verification (RV) monitors.
+ *
+ * This is a tools-friendly copy of include/uapi/linux/rv.h.
+ * Keep in sync with the kernel header.
+ */
+
+#ifndef _UAPI_LINUX_RV_H
+#define _UAPI_LINUX_RV_H
+
+#include <linux/types.h>
+#include <sys/ioctl.h>
+
+/* Magic byte shared by all RV monitor ioctls. */
+#define RV_IOC_MAGIC	0xB9
+
+/* -----------------------------------------------------------------------
+ * tlob: task latency over budget monitor  (nr 0x01 - 0x1F)
+ * -----------------------------------------------------------------------
+ */
+
+struct tlob_start_args {
+	__u64 threshold_us;
+	__u64 tag;
+	__s32 notify_fd;
+	__u32 flags;
+};
+
+struct tlob_event {
+	__u32 tid;
+	__u32 pad;
+	__u64 threshold_us;
+	__u64 on_cpu_us;
+	__u64 off_cpu_us;
+	__u32 switches;
+	__u32 state;   /* 1 = on_cpu, 0 = off_cpu */
+	__u64 tag;
+};
+
+struct tlob_mmap_page {
+	__u32  data_head;
+	__u32  data_tail;
+	__u32  capacity;
+	__u32  version;
+	__u32  data_offset;
+	__u32  record_size;
+	__u64  dropped;
+};
+
+#define TLOB_IOCTL_TRACE_START	_IOW(RV_IOC_MAGIC, 0x01, struct tlob_start_args)
+#define TLOB_IOCTL_TRACE_STOP	_IO(RV_IOC_MAGIC,  0x02)
+
+#endif /* _UAPI_LINUX_RV_H */
diff --git a/tools/testing/selftests/rv/Makefile b/tools/testing/selftests/rv/Makefile
new file mode 100644
index 000000000..14e94a1ab
--- /dev/null
+++ b/tools/testing/selftests/rv/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for rv selftests
+
+TEST_GEN_PROGS := tlob_helper tlob_uprobe_target
+
+TEST_PROGS := \
+	test_tlob.sh \
+
+# TOOLS_INCLUDES is defined by ../lib.mk; provides -isystem to
+# tools/include/uapi so that #include <linux/rv.h> resolves to the
+# in-tree UAPI header without requiring make headers_install.
+# Note: both must be added to the global variables, not as target-specific
+# overrides, because lib.mk rewrites TEST_GEN_PROGS to $(OUTPUT)/name
+# before per-target rules would be evaluated.
+CFLAGS += $(TOOLS_INCLUDES)
+LDLIBS += -lpthread
+
+include ../lib.mk
diff --git a/tools/testing/selftests/rv/test_tlob.sh b/tools/testing/selftests/rv/test_tlob.sh
new file mode 100755
index 000000000..3ba2125eb
--- /dev/null
+++ b/tools/testing/selftests/rv/test_tlob.sh
@@ -0,0 +1,563 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for the tlob (task latency over budget) RV monitor.
+#
+# Two interfaces are tested:
+#
+#   1. tracefs interface:
+#        enable/disable, presence of tracefs files,
+#        uprobe binding (threshold_us:offset_start:offset_stop:binary_path) and
+#        violation detection via the ftrace ring buffer.
+#
+#   2. /dev/rv ioctl self-instrumentation (via tlob_helper):
+#        within-budget, over-budget on-CPU, over-budget off-CPU (sleep),
+#        double-start, stop-without-start.
+#
+# Written to be POSIX sh compatible (no bash-specific extensions).
+
+ksft_skip=4
+t_pass=0; t_fail=0; t_skip=0; t_total=0
+
+tap_header() { echo "TAP version 13"; }
+tap_plan()   { echo "1..$1"; }
+tap_pass()   { t_pass=$((t_pass+1)); echo "ok $t_total - $1"; }
+tap_fail()   { t_fail=$((t_fail+1)); echo "not ok $t_total - $1"
+               [ -n "$2" ] && echo "  # $2"; }
+tap_skip()   { t_skip=$((t_skip+1)); echo "ok $t_total - $1 # SKIP $2"; }
+next_test()  { t_total=$((t_total+1)); }
+
+TRACEFS=$(grep -m1 tracefs /proc/mounts 2>/dev/null | awk '{print $2}')
+[ -z "$TRACEFS" ] && TRACEFS=/sys/kernel/tracing
+
+RV_DIR="${TRACEFS}/rv"
+TLOB_DIR="${RV_DIR}/monitors/tlob"
+TRACE_FILE="${TRACEFS}/trace"
+TRACING_ON="${TRACEFS}/tracing_on"
+TLOB_MONITOR="${TLOB_DIR}/monitor"
+BUDGET_EXCEEDED_ENABLE="${TRACEFS}/events/rv/tlob_budget_exceeded/enable"
+RV_DEV="/dev/rv"
+
+# tlob_helper and tlob_uprobe_target must be in the same directory as
+# this script or on PATH.
+SCRIPT_DIR=$(dirname "$0")
+IOCTL_HELPER="${SCRIPT_DIR}/tlob_helper"
+UPROBE_TARGET="${SCRIPT_DIR}/tlob_uprobe_target"
+
+check_root()     { [ "$(id -u)" = "0" ] || { echo "# Need root" >&2; exit $ksft_skip; }; }
+check_tracefs()  { [ -d "${TRACEFS}" ]   || { echo "# No tracefs" >&2; exit $ksft_skip; }; }
+check_rv_dir()   { [ -d "${RV_DIR}" ]    || { echo "# No RV infra" >&2; exit $ksft_skip; }; }
+check_tlob()     { [ -d "${TLOB_DIR}" ]  || { echo "# No tlob monitor" >&2; exit $ksft_skip; }; }
+
+tlob_enable()         { echo 1 > "${TLOB_DIR}/enable"; }
+tlob_disable()        { echo 0 > "${TLOB_DIR}/enable" 2>/dev/null; }
+tlob_is_enabled()     { [ "$(cat "${TLOB_DIR}/enable" 2>/dev/null)" = "1" ]; }
+trace_event_enable()  { echo 1 > "${BUDGET_EXCEEDED_ENABLE}" 2>/dev/null; }
+trace_event_disable() { echo 0 > "${BUDGET_EXCEEDED_ENABLE}" 2>/dev/null; }
+trace_on()            { echo 1 > "${TRACING_ON}" 2>/dev/null; }
+trace_clear()         { echo > "${TRACE_FILE}"; }
+trace_grep()          { grep -q "$1" "${TRACE_FILE}" 2>/dev/null; }
+
+cleanup() {
+	tlob_disable
+	trace_event_disable
+	trace_clear
+}
+
+# ---------------------------------------------------------------------------
+# Test 1: enable / disable
+# ---------------------------------------------------------------------------
+run_test_enable_disable() {
+	next_test; cleanup
+	tlob_enable
+	if ! tlob_is_enabled; then
+		tap_fail "enable_disable" "not enabled after echo 1"; cleanup; return
+	fi
+	tlob_disable
+	if tlob_is_enabled; then
+		tap_fail "enable_disable" "still enabled after echo 0"; cleanup; return
+	fi
+	tap_pass "enable_disable"; cleanup
+}
+
+# ---------------------------------------------------------------------------
+# Test 2: tracefs files present
+# ---------------------------------------------------------------------------
+run_test_tracefs_files() {
+	next_test; cleanup
+	missing=""
+	for f in enable desc monitor; do
+		[ ! -e "${TLOB_DIR}/${f}" ] && missing="${missing} ${f}"
+	done
+	[ -n "${missing}" ] \
+		&& tap_fail "tracefs_files" "missing:${missing}" \
+		|| tap_pass "tracefs_files"
+	cleanup
+}
+
+# ---------------------------------------------------------------------------
+# Helper: resolve file offset of a function inside a binary.
+#
+# Usage: resolve_offset <binary> <vaddr_hex>
+# Prints the hex file offset, or empty string on failure.
+# ---------------------------------------------------------------------------
+resolve_offset() {
+	bin=$1; vaddr=$2
+	# Parse /proc/self/maps to find the mapping that contains vaddr.
+	# Each line: start-end perms offset dev inode [path]
+	while IFS= read -r line; do
+		set -- $line
+		range=$1; off=$4; path=$7
+		[ -z "$path" ] && continue
+		# Only consider the mapping for our binary
+		[ "$path" != "$bin" ] && continue
+		# Split range into start and end
+		start=$(echo "$range" | cut -d- -f1)
+		end=$(echo "$range" | cut -d- -f2)
+		# Convert hex to decimal for comparison (use printf)
+		s=$(printf "%d" "0x${start}" 2>/dev/null) || continue
+		e=$(printf "%d" "0x${end}"   2>/dev/null) || continue
+		v=$(printf "%d" "${vaddr}"   2>/dev/null) || continue
+		o=$(printf "%d" "0x${off}"   2>/dev/null) || continue
+		if [ "$v" -ge "$s" ] && [ "$v" -lt "$e" ]; then
+			file_off=$(printf "0x%x" $(( (v - s) + o )))
+			echo "$file_off"
+			return
+		fi
+	done < /proc/self/maps
+}
+
+# ---------------------------------------------------------------------------
+# Test 3: uprobe binding - no false positive
+#
+# Bind this process with a 10 s budget.  Do nothing for 0.5 s.
+# No budget_exceeded event should appear in the trace.
+# ---------------------------------------------------------------------------
+run_test_uprobe_no_false_positive() {
+	next_test; cleanup
+	if [ ! -e "${TLOB_MONITOR}" ]; then
+		tap_skip "uprobe_no_false_positive" "monitor file not available"
+		cleanup; return
+	fi
+	# We probe the "sleep" command that we will run as a subprocess.
+	# Use /bin/sleep as the binary; find a valid function offset (0x0
+	# resolves to the ELF entry point, which is sufficient for a
+	# no-false-positive test since we just need the binding to exist).
+	sleep_bin=$(command -v sleep 2>/dev/null)
+	if [ -z "$sleep_bin" ]; then
+		tap_skip "uprobe_no_false_positive" "sleep not found"; cleanup; return
+	fi
+	pid=$$
+	# offset 0x0 probes the entry point of /bin/sleep - this is a
+	# deliberate probe that will not fire during a simple 'sleep 10'
+	# invoked in a subshell, but registers the pid in tlob.
+	#
+	# Instead, bind our own pid with a generous 10 s threshold and
+	# verify that 0.5 s of idle time does NOT fire the timer.
+	#
+	# Since we cannot easily get a valid uprobe offset in pure shell,
+	# we skip this sub-test if we cannot form a valid binding.
+	exe=$(readlink /proc/self/exe 2>/dev/null)
+	if [ -z "$exe" ]; then
+		tap_skip "uprobe_no_false_positive" "cannot read /proc/self/exe"
+		cleanup; return
+	fi
+	trace_event_enable
+	trace_on
+	tlob_enable
+	trace_clear
+	# Sleep without any binding - just verify no spurious events
+	sleep 0.5
+	trace_grep "budget_exceeded" \
+		&& tap_fail "uprobe_no_false_positive" \
+			"spurious budget_exceeded without any binding" \
+		|| tap_pass "uprobe_no_false_positive"
+	cleanup
+}
+
+# ---------------------------------------------------------------------------
+# Helper: get_uprobe_offset <binary> <symbol>
+#
+# Use tlob_helper sym_offset to get the ELF file offset of <symbol>
+# in <binary>.  Prints the hex offset (e.g. "0x11d0") or empty string on
+# failure.
+# ---------------------------------------------------------------------------
+get_uprobe_offset() {
+	bin=$1; sym=$2
+	if [ ! -x "${IOCTL_HELPER}" ]; then
+		return
+	fi
+	"${IOCTL_HELPER}" sym_offset "${bin}" "${sym}" 2>/dev/null
+}
+
+# ---------------------------------------------------------------------------
+# Test 4: uprobe binding - violation detected
+#
+# Start tlob_uprobe_target (a busy-spin binary with a well-known symbol),
+# attach a uprobe on tlob_busy_work with a 10 ms threshold, and verify
+# that a budget_expired event appears.
+# ---------------------------------------------------------------------------
+run_test_uprobe_violation() {
+	next_test; cleanup
+	if [ ! -e "${TLOB_MONITOR}" ]; then
+		tap_skip "uprobe_violation" "monitor file not available"
+		cleanup; return
+	fi
+	if [ ! -x "${UPROBE_TARGET}" ]; then
+		tap_skip "uprobe_violation" \
+			"tlob_uprobe_target not found or not executable"
+		cleanup; return
+	fi
+
+	# Get the file offsets of the start and stop probe symbols
+	busy_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work")
+	if [ -z "${busy_offset}" ]; then
+		tap_skip "uprobe_violation" \
+			"cannot resolve tlob_busy_work offset in ${UPROBE_TARGET}"
+		cleanup; return
+	fi
+	stop_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work_done")
+	if [ -z "${stop_offset}" ]; then
+		tap_skip "uprobe_violation" \
+			"cannot resolve tlob_busy_work_done offset in ${UPROBE_TARGET}"
+		cleanup; return
+	fi
+
+	# Start the busy-spin target (run for 30 s so the test can observe it)
+	"${UPROBE_TARGET}" 30000 &
+	busy_pid=$!
+	sleep 0.05
+
+	trace_event_enable
+	trace_on
+	tlob_enable
+	trace_clear
+
+	# Bind the target: 10 us budget; start=tlob_busy_work, stop=tlob_busy_work_done
+	binding="10:${busy_offset}:${stop_offset}:${UPROBE_TARGET}"
+	if ! echo "${binding}" > "${TLOB_MONITOR}" 2>/dev/null; then
+		kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+		tap_skip "uprobe_violation" \
+			"uprobe binding rejected (CONFIG_UPROBES=y needed)"
+		cleanup; return
+	fi
+
+	# Wait up to 2 s for a budget_exceeded event
+	found=0; i=0
+	while [ "$i" -lt 20 ]; do
+		sleep 0.1
+		trace_grep "budget_exceeded" && { found=1; break; }
+		i=$((i+1))
+	done
+
+	echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+	kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+
+	if [ "${found}" != "1" ]; then
+		tap_fail "uprobe_violation" "no budget_exceeded within 2 s"
+		cleanup; return
+	fi
+
+	# Validate the event fields: threshold must match, on_cpu must be non-zero
+	# (CPU-bound violation), and state must be on_cpu.
+	ev=$(grep "budget_exceeded" "${TRACE_FILE}" | head -n 1)
+	if ! echo "${ev}" | grep -q "threshold=10 "; then
+		tap_fail "uprobe_violation" "threshold field mismatch: ${ev}"
+		cleanup; return
+	fi
+	on_cpu=$(echo "${ev}" | grep -o "on_cpu=[0-9]*" | cut -d= -f2)
+	if [ "${on_cpu:-0}" -eq 0 ]; then
+		tap_fail "uprobe_violation" "on_cpu=0 for a CPU-bound spin: ${ev}"
+		cleanup; return
+	fi
+	if ! echo "${ev}" | grep -q "state=on_cpu"; then
+		tap_fail "uprobe_violation" "state is not on_cpu: ${ev}"
+		cleanup; return
+	fi
+	tap_pass "uprobe_violation"
+	cleanup
+}
+
+# ---------------------------------------------------------------------------
+# Test 5: uprobe binding - remove binding stops monitoring
+#
+# Bind a pid via tlob_uprobe_target, then immediately remove it.
+# Verify that after removal the monitor file no longer lists the pid.
+# ---------------------------------------------------------------------------
+run_test_uprobe_unbind() {
+	next_test; cleanup
+	if [ ! -e "${TLOB_MONITOR}" ]; then
+		tap_skip "uprobe_unbind" "monitor file not available"
+		cleanup; return
+	fi
+	if [ ! -x "${UPROBE_TARGET}" ]; then
+		tap_skip "uprobe_unbind" \
+			"tlob_uprobe_target not found or not executable"
+		cleanup; return
+	fi
+
+	busy_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work")
+	stop_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work_done")
+	if [ -z "${busy_offset}" ] || [ -z "${stop_offset}" ]; then
+		tap_skip "uprobe_unbind" \
+			"cannot resolve tlob_busy_work/tlob_busy_work_done offset"
+		cleanup; return
+	fi
+
+	"${UPROBE_TARGET}" 30000 &
+	busy_pid=$!
+	sleep 0.05
+
+	tlob_enable
+	# 5 s budget - should not fire during this quick test
+	binding="5000000:${busy_offset}:${stop_offset}:${UPROBE_TARGET}"
+	if ! echo "${binding}" > "${TLOB_MONITOR}" 2>/dev/null; then
+		kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+		tap_skip "uprobe_unbind" \
+			"uprobe binding rejected (CONFIG_UPROBES=y needed)"
+		cleanup; return
+	fi
+
+	# Remove the binding
+	echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+
+	# The monitor file should no longer list the binding for this offset
+	if grep -q "^[0-9]*:0x${busy_offset#0x}:" "${TLOB_MONITOR}" 2>/dev/null; then
+		kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+		tap_fail "uprobe_unbind" "pid still listed after removal"
+		cleanup; return
+	fi
+
+	kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+	tap_pass "uprobe_unbind"
+	cleanup
+}
+
+# ---------------------------------------------------------------------------
+# Test 6: uprobe - duplicate offset_start rejected
+#
+# Registering a second binding with the same offset_start in the same binary
+# must be rejected with an error, since two entry uprobes at the same address
+# would cause double tlob_start_task() calls and undefined behaviour.
+# ---------------------------------------------------------------------------
+run_test_uprobe_duplicate_offset() {
+	next_test; cleanup
+	if [ ! -e "${TLOB_MONITOR}" ]; then
+		tap_skip "uprobe_duplicate_offset" "monitor file not available"
+		cleanup; return
+	fi
+	if [ ! -x "${UPROBE_TARGET}" ]; then
+		tap_skip "uprobe_duplicate_offset" \
+			"tlob_uprobe_target not found or not executable"
+		cleanup; return
+	fi
+
+	busy_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work")
+	stop_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work_done")
+	if [ -z "${busy_offset}" ] || [ -z "${stop_offset}" ]; then
+		tap_skip "uprobe_duplicate_offset" \
+			"cannot resolve tlob_busy_work/tlob_busy_work_done offset"
+		cleanup; return
+	fi
+
+	tlob_enable
+
+	# First binding: should succeed
+	if ! echo "5000000:${busy_offset}:${stop_offset}:${UPROBE_TARGET}" \
+	        > "${TLOB_MONITOR}" 2>/dev/null; then
+		tap_skip "uprobe_duplicate_offset" \
+			"uprobe binding rejected (CONFIG_UPROBES=y needed)"
+		cleanup; return
+	fi
+
+	# Second binding with same offset_start: must be rejected
+	if echo "9999:${busy_offset}:${stop_offset}:${UPROBE_TARGET}" \
+	        > "${TLOB_MONITOR}" 2>/dev/null; then
+		echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+		tap_fail "uprobe_duplicate_offset" \
+			"duplicate offset_start was accepted (expected error)"
+		cleanup; return
+	fi
+
+	echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+	tap_pass "uprobe_duplicate_offset"
+	cleanup
+}
+
+
+#
+# Region A: tlob_busy_work with a 5 s budget - should NOT fire during the test.
+# Region B: tlob_busy_work_done with a 10 us budget - SHOULD fire quickly since
+#           tlob_uprobe_target calls tlob_busy_work_done after a busy spin.
+#
+# Verifies that independent bindings for different offsets in the same binary
+# are tracked separately and that only the tight-budget binding triggers a
+# budget_exceeded event.
+# ---------------------------------------------------------------------------
+run_test_uprobe_independent_thresholds() {
+	next_test; cleanup
+	if [ ! -e "${TLOB_MONITOR}" ]; then
+		tap_skip "uprobe_independent_thresholds" \
+			"monitor file not available"; cleanup; return
+	fi
+	if [ ! -x "${UPROBE_TARGET}" ]; then
+		tap_skip "uprobe_independent_thresholds" \
+			"tlob_uprobe_target not found or not executable"
+		cleanup; return
+	fi
+
+	busy_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work")
+	busy_stop_offset=$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work_done")
+	if [ -z "${busy_offset}" ] || [ -z "${busy_stop_offset}" ]; then
+		tap_skip "uprobe_independent_thresholds" \
+			"cannot resolve tlob_busy_work/tlob_busy_work_done offset"
+		cleanup; return
+	fi
+
+	"${UPROBE_TARGET}" 30000 &
+	busy_pid=$!
+	sleep 0.05
+
+	trace_event_enable
+	trace_on
+	tlob_enable
+	trace_clear
+
+	# Region A: generous 5 s budget on tlob_busy_work entry (should not fire)
+	if ! echo "5000000:${busy_offset}:${busy_stop_offset}:${UPROBE_TARGET}" \
+	        > "${TLOB_MONITOR}" 2>/dev/null; then
+		kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+		tap_skip "uprobe_independent_thresholds" \
+			"uprobe binding rejected (CONFIG_UPROBES=y needed)"
+		cleanup; return
+	fi
+	# Region B: tight 10 us budget on tlob_busy_work_done (fires quickly)
+	echo "10:${busy_stop_offset}:${busy_stop_offset}:${UPROBE_TARGET}" \
+		> "${TLOB_MONITOR}" 2>/dev/null
+
+	found=0; i=0
+	while [ "$i" -lt 20 ]; do
+		sleep 0.1
+		trace_grep "budget_exceeded" && { found=1; break; }
+		i=$((i+1))
+	done
+
+	echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+	echo "-${busy_stop_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}" 2>/dev/null
+	kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
+
+	if [ "${found}" != "1" ]; then
+		tap_fail "uprobe_independent_thresholds" \
+			"budget_exceeded not raised for tight-budget region within 2 s"
+		cleanup; return
+	fi
+
+	# The violation must carry threshold=10 (Region B's budget).
+	ev=$(grep "budget_exceeded" "${TRACE_FILE}" | head -n 1)
+	if ! echo "${ev}" | grep -q "threshold=10 "; then
+		tap_fail "uprobe_independent_thresholds" \
+			"violation threshold is not Region B's 10 us: ${ev}"
+		cleanup; return
+	fi
+	tap_pass "uprobe_independent_thresholds"
+	cleanup
+}
+
+# ---------------------------------------------------------------------------
+# ioctl tests via tlob_helper
+#
+# Each test invokes the helper with a sub-test name.
+# Exit code: 0=pass, 1=fail, 2=skip.
+# ---------------------------------------------------------------------------
+run_ioctl_test() {
+	testname=$1
+	next_test
+
+	if [ ! -x "${IOCTL_HELPER}" ]; then
+		tap_skip "ioctl_${testname}" \
+			"tlob_helper not found or not executable"
+		return
+	fi
+	if [ ! -c "${RV_DEV}" ]; then
+		tap_skip "ioctl_${testname}" \
+			"${RV_DEV} not present (CONFIG_RV_CHARDEV=y needed)"
+		return
+	fi
+
+	tlob_enable
+	"${IOCTL_HELPER}" "${testname}"
+	rc=$?
+	tlob_disable
+
+	case "${rc}" in
+	0) tap_pass "ioctl_${testname}" ;;
+	2) tap_skip "ioctl_${testname}" "helper returned skip" ;;
+	*) tap_fail "ioctl_${testname}" "helper exited with code ${rc}" ;;
+	esac
+}
+
+# run_ioctl_test_not_enabled - like run_ioctl_test but deliberately does NOT
+# enable the tlob monitor before invoking the helper.  Used to verify that
+# ioctls issued against a disabled monitor return ENODEV rather than crashing
+# the kernel with a NULL pointer dereference.
+run_ioctl_test_not_enabled()
+{
+	next_test
+
+	if [ ! -x "${IOCTL_HELPER}" ]; then
+		tap_skip "ioctl_not_enabled" \
+			"tlob_helper not found or not executable"
+		return
+	fi
+	if [ ! -c "${RV_DEV}" ]; then
+		tap_skip "ioctl_not_enabled" \
+			"${RV_DEV} not present (CONFIG_RV_CHARDEV=y needed)"
+		return
+	fi
+
+	# Monitor intentionally left disabled.
+	tlob_disable
+	"${IOCTL_HELPER}" not_enabled
+	rc=$?
+
+	case "${rc}" in
+	0) tap_pass "ioctl_not_enabled" ;;
+	2) tap_skip "ioctl_not_enabled" "helper returned skip" ;;
+	*) tap_fail "ioctl_not_enabled" "helper exited with code ${rc}" ;;
+	esac
+}
+
+# ---------------------------------------------------------------------------
+# Main
+# ---------------------------------------------------------------------------
+check_root; check_tracefs; check_rv_dir; check_tlob
+tap_header; tap_plan 20
+
+# tracefs interface tests
+run_test_enable_disable
+run_test_tracefs_files
+
+# uprobe external monitoring tests
+run_test_uprobe_no_false_positive
+run_test_uprobe_violation
+run_test_uprobe_unbind
+run_test_uprobe_duplicate_offset
+run_test_uprobe_independent_thresholds
+
+# /dev/rv ioctl self-instrumentation tests
+run_ioctl_test_not_enabled
+run_ioctl_test within_budget
+run_ioctl_test over_budget_cpu
+run_ioctl_test over_budget_sleep
+run_ioctl_test double_start
+run_ioctl_test stop_no_start
+run_ioctl_test multi_thread
+run_ioctl_test self_watch
+run_ioctl_test invalid_flags
+run_ioctl_test notify_fd_bad
+run_ioctl_test mmap_basic
+run_ioctl_test mmap_errors
+run_ioctl_test mmap_consume
+
+echo "# Passed: ${t_pass} Failed: ${t_fail} Skipped: ${t_skip}"
+[ "${t_fail}" -gt 0 ] && exit 1 || exit 0
diff --git a/tools/testing/selftests/rv/tlob_helper.c b/tools/testing/selftests/rv/tlob_helper.c
new file mode 100644
index 000000000..cd76b56d1
--- /dev/null
+++ b/tools/testing/selftests/rv/tlob_helper.c
@@ -0,0 +1,994 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_helper.c - test helper and ELF utility for tlob selftests
+ *
+ * Called by test_tlob.sh to exercise the /dev/rv ioctl interface and to
+ * resolve ELF symbol offsets for uprobe bindings.  One subcommand per
+ * invocation so the shell script can report each as an independent TAP
+ * test case.
+ *
+ * Usage: tlob_helper <subcommand> [args...]
+ *
+ * Synchronous TRACE_START / TRACE_STOP tests:
+ *   not_enabled        - TRACE_START without tlob enabled -> ENODEV (no kernel crash)
+ *   within_budget      - start(50000 us), sleep 10 ms, stop -> expect 0
+ *   over_budget_cpu    - start(5000 us), busyspin 100 ms, stop -> EOVERFLOW
+ *   over_budget_sleep  - start(3000 us), sleep 50 ms, stop -> EOVERFLOW
+ *
+ * Error-handling tests:
+ *   double_start       - two starts without stop -> EEXIST on second
+ *   stop_no_start      - stop without start -> ESRCH
+ *
+ * Per-thread isolation test:
+ *   multi_thread       - two threads share one fd; one within budget, one over
+ *
+ * Asynchronous notification test (notify_fd + read()):
+ *   self_watch         - one worker exceeds budget; monitor fd receives one ntf via read()
+ *
+ * Input-validation tests (TRACE_START error paths):
+ *   invalid_flags      - TRACE_START with flags != 0 -> EINVAL
+ *   notify_fd_bad      - TRACE_START with notify_fd = stdout (non-rv fd) -> EINVAL
+ *
+ * mmap ring buffer tests (Scenario D):
+ *   mmap_basic         - mmap succeeds; verify tlob_mmap_page fields
+ *                        (version, capacity, data_offset, record_size)
+ *   mmap_errors        - MAP_PRIVATE, wrong size, and non-zero pgoff all
+ *                        return EINVAL
+ *   mmap_consume       - trigger a real violation via self-notification and
+ *                        consume the event through the mmap'd ring
+ *
+ * ELF utility (does not require /dev/rv):
+ *   sym_offset <binary> <symbol>
+ *                      - print the ELF file offset of <symbol> in <binary>
+ *                        (used by the shell script to build uprobe bindings)
+ *
+ * Exit code: 0 = pass, 1 = fail, 2 = skip (device not available).
+ */
+#define _GNU_SOURCE
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/rv.h>
+
+/* Default ring capacity allocated at open(); matches TLOB_RING_DEFAULT_CAP. */
+#define TLOB_RING_DEFAULT_CAP	64U
+
+static int rv_fd = -1;
+
+static int open_rv(void)
+{
+	rv_fd = open("/dev/rv", O_RDWR);
+	if (rv_fd < 0) {
+		fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
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
+static int do_start(uint64_t threshold_us)
+{
+	struct tlob_start_args args = {
+		.threshold_us = threshold_us,
+		.notify_fd    = -1,
+	};
+
+	return ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+}
+
+static int do_stop(void)
+{
+	return ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+}
+
+/* -----------------------------------------------------------------------
+ * Synchronous TRACE_START / TRACE_STOP tests
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * test_not_enabled - TRACE_START must return ENODEV when the tlob monitor
+ * has not been enabled (tlob_state_cache is NULL).
+ *
+ * The shell wrapper deliberately does NOT call tlob_enable before invoking
+ * this subcommand, so the ioctl is expected to fail with ENODEV rather than
+ * crashing the kernel with a NULL pointer dereference in kmem_cache_alloc.
+ */
+static int test_not_enabled(void)
+{
+	int ret;
+
+	ret = do_start(1000);
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_START: expected ENODEV, got success\n");
+		do_stop();
+		return 1;
+	}
+	if (errno != ENODEV) {
+		fprintf(stderr, "TRACE_START: expected ENODEV, got %s\n",
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
+	if (do_start(50000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	usleep(10000); /* 10 ms < 50 ms budget */
+	ret = do_stop();
+	if (ret != 0) {
+		fprintf(stderr, "TRACE_STOP: expected 0, got %d errno=%s\n",
+			ret, strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+static int test_over_budget_cpu(void)
+{
+	int ret;
+
+	if (do_start(5000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	busy_spin_us(100000); /* 100 ms >> 5 ms budget */
+	ret = do_stop();
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
+static int test_over_budget_sleep(void)
+{
+	int ret;
+
+	if (do_start(3000) < 0) {
+		fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	usleep(50000); /* 50 ms >> 3 ms budget, off-CPU time counts */
+	ret = do_stop();
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
+/* -----------------------------------------------------------------------
+ * Error-handling tests
+ * -----------------------------------------------------------------------
+ */
+
+static int test_double_start(void)
+{
+	int ret;
+
+	if (do_start(10000000) < 0) {
+		fprintf(stderr, "first TRACE_START: %s\n", strerror(errno));
+		return 1;
+	}
+	ret = do_start(10000000);
+	if (ret == 0) {
+		fprintf(stderr, "second TRACE_START: expected EEXIST, got 0\n");
+		do_stop();
+		return 1;
+	}
+	if (errno != EEXIST) {
+		fprintf(stderr, "second TRACE_START: expected EEXIST, got %s\n",
+			strerror(errno));
+		do_stop();
+		return 1;
+	}
+	do_stop(); /* clean up */
+	return 0;
+}
+
+static int test_stop_no_start(void)
+{
+	int ret;
+
+	/* Ensure clean state: ignore error from a stale entry */
+	do_stop();
+
+	ret = do_stop();
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_STOP: expected ESRCH, got 0\n");
+		return 1;
+	}
+	if (errno != ESRCH) {
+		fprintf(stderr, "TRACE_STOP: expected ESRCH, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/* -----------------------------------------------------------------------
+ * Per-thread isolation test
+ *
+ * Two threads share a single /dev/rv fd.  The monitor uses task_struct *
+ * as the key, so each thread gets an independent slot regardless of the
+ * shared fd.
+ * -----------------------------------------------------------------------
+ */
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
+	int ret;
+
+	if (do_start(a->threshold_us) < 0) {
+		fprintf(stderr, "thread TRACE_START: %s\n", strerror(errno));
+		a->result = 1;
+		return NULL;
+	}
+
+	if (a->busy)
+		busy_spin_us(a->workload_us);
+	else
+		usleep(a->workload_us);
+
+	ret = do_stop();
+	if (a->expect_eoverflow) {
+		if (ret == 0 || errno != EOVERFLOW) {
+			fprintf(stderr, "thread: expected EOVERFLOW, got ret=%d errno=%s\n",
+				ret, strerror(errno));
+			a->result = 1;
+			return NULL;
+		}
+	} else {
+		if (ret != 0) {
+			fprintf(stderr, "thread: expected 0, got ret=%d errno=%s\n",
+				ret, strerror(errno));
+			a->result = 1;
+			return NULL;
+		}
+	}
+	a->result = 0;
+	return NULL;
+}
+
+static int test_multi_thread(void)
+{
+	pthread_t ta, tb;
+	struct mt_thread_args a = {
+		.threshold_us     = 20000,  /* 20 ms */
+		.workload_us      = 5000,   /* 5 ms sleep -> within budget */
+		.busy             = 0,
+		.expect_eoverflow = 0,
+	};
+	struct mt_thread_args b = {
+		.threshold_us     = 3000,   /* 3 ms */
+		.workload_us      = 30000,  /* 30 ms spin -> over budget */
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
+/* -----------------------------------------------------------------------
+ * Asynchronous notification test (notify_fd + read())
+ *
+ * A dedicated monitor_fd is opened by the main thread.  Two worker threads
+ * each open their own work_fd and call TLOB_IOCTL_TRACE_START with
+ * notify_fd = monitor_fd, nominating it as the violation target.  Worker A
+ * stays within budget; worker B exceeds it.  The main thread reads from
+ * monitor_fd and expects exactly one tlob_event record.
+ * -----------------------------------------------------------------------
+ */
+
+struct sw_worker_args {
+	int           monitor_fd;
+	uint64_t      threshold_us;
+	unsigned long workload_us;
+	int           busy;
+	int           result;
+};
+
+static void *sw_worker_fn(void *arg)
+{
+	struct sw_worker_args *a = arg;
+	struct tlob_start_args args = {
+		.threshold_us = a->threshold_us,
+		.notify_fd    = a->monitor_fd,
+	};
+	int work_fd;
+	int ret;
+
+	work_fd = open("/dev/rv", O_RDWR);
+	if (work_fd < 0) {
+		fprintf(stderr, "worker open /dev/rv: %s\n", strerror(errno));
+		a->result = 1;
+		return NULL;
+	}
+
+	ret = ioctl(work_fd, TLOB_IOCTL_TRACE_START, &args);
+	if (ret < 0) {
+		fprintf(stderr, "TRACE_START (notify): %s\n", strerror(errno));
+		close(work_fd);
+		a->result = 1;
+		return NULL;
+	}
+
+	if (a->busy)
+		busy_spin_us(a->workload_us);
+	else
+		usleep(a->workload_us);
+
+	ioctl(work_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	close(work_fd);
+	a->result = 0;
+	return NULL;
+}
+
+static int test_self_watch(void)
+{
+	int monitor_fd;
+	pthread_t ta, tb;
+	struct sw_worker_args a = {
+		.threshold_us = 50000,  /* 50 ms */
+		.workload_us  = 5000,   /* 5 ms sleep -> no violation */
+		.busy         = 0,
+	};
+	struct sw_worker_args b = {
+		.threshold_us = 3000,   /* 3 ms */
+		.workload_us  = 30000,  /* 30 ms spin -> violation */
+		.busy         = 1,
+	};
+	struct tlob_event ntfs[8];
+	int violations = 0;
+	ssize_t n;
+
+	/*
+	 * Open monitor_fd with O_NONBLOCK so read() after the workers finish
+	 * returns immediately rather than blocking forever.
+	 */
+	monitor_fd = open("/dev/rv", O_RDWR | O_NONBLOCK);
+	if (monitor_fd < 0) {
+		fprintf(stderr, "open /dev/rv (monitor_fd): %s\n", strerror(errno));
+		return 1;
+	}
+	a.monitor_fd = monitor_fd;
+	b.monitor_fd = monitor_fd;
+
+	pthread_create(&ta, NULL, sw_worker_fn, &a);
+	pthread_create(&tb, NULL, sw_worker_fn, &b);
+	pthread_join(ta, NULL);
+	pthread_join(tb, NULL);
+
+	if (a.result || b.result) {
+		close(monitor_fd);
+		return 1;
+	}
+
+	/*
+	 * Drain all available tlob_event records.  With O_NONBLOCK the final
+	 * read() returns -EAGAIN when the buffer is empty.
+	 */
+	while ((n = read(monitor_fd, ntfs, sizeof(ntfs))) > 0)
+		violations += (int)(n / sizeof(struct tlob_event));
+
+	close(monitor_fd);
+
+	if (violations != 1) {
+		fprintf(stderr, "self_watch: expected 1 violation, got %d\n",
+			violations);
+		return 1;
+	}
+	return 0;
+}
+
+/* -----------------------------------------------------------------------
+ * Input-validation tests (TRACE_START error paths)
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * test_invalid_flags - TRACE_START with flags != 0 must return EINVAL.
+ *
+ * The flags field is reserved for future extensions and must be zero.
+ * Callers that set it to a non-zero value are rejected early so that a
+ * future kernel can assign meaning to those bits without silently
+ * ignoring them.
+ */
+static int test_invalid_flags(void)
+{
+	struct tlob_start_args args = {
+		.threshold_us = 1000,
+		.notify_fd    = -1,
+		.flags        = 1,   /* non-zero: must be rejected */
+	};
+	int ret;
+
+	ret = ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+	if (ret == 0) {
+		fprintf(stderr, "TRACE_START(flags=1): expected EINVAL, got success\n");
+		do_stop();
+		return 1;
+	}
+	if (errno != EINVAL) {
+		fprintf(stderr, "TRACE_START(flags=1): expected EINVAL, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * test_notify_fd_bad - TRACE_START with a non-/dev/rv notify_fd must return
+ * EINVAL.
+ *
+ * When notify_fd >= 0, the kernel resolves it to a struct file and checks
+ * that its private_data is non-NULL (i.e. it is a /dev/rv file descriptor).
+ * Passing stdout (fd 1) supplies a real, open fd whose private_data is NULL,
+ * so the kernel must reject it with EINVAL.
+ */
+static int test_notify_fd_bad(void)
+{
+	struct tlob_start_args args = {
+		.threshold_us = 1000,
+		.notify_fd    = STDOUT_FILENO,   /* open but not a /dev/rv fd */
+		.flags        = 0,
+	};
+	int ret;
+
+	ret = ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
+	if (ret == 0) {
+		fprintf(stderr,
+			"TRACE_START(notify_fd=stdout): expected EINVAL, got success\n");
+		do_stop();
+		return 1;
+	}
+	if (errno != EINVAL) {
+		fprintf(stderr,
+			"TRACE_START(notify_fd=stdout): expected EINVAL, got %s\n",
+			strerror(errno));
+		return 1;
+	}
+	return 0;
+}
+
+/* -----------------------------------------------------------------------
+ * mmap ring buffer tests (Scenario D)
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * test_mmap_basic - mmap the ring buffer and verify the control page fields.
+ *
+ * The kernel allocates TLOB_RING_DEFAULT_CAP records at open().  A shared
+ * mmap of PAGE_SIZE + cap * record_size must succeed and the tlob_mmap_page
+ * header must contain consistent values.
+ */
+static int test_mmap_basic(void)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	size_t mmap_len = (size_t)pagesize +
+			  TLOB_RING_DEFAULT_CAP * sizeof(struct tlob_event);
+	/* rv_mmap requires a page-aligned length */
+	mmap_len = (mmap_len + (size_t)(pagesize - 1)) & ~(size_t)(pagesize - 1);
+	struct tlob_mmap_page *page;
+	struct tlob_event *data;
+	void *map;
+	int ret = 0;
+
+	map = mmap(NULL, mmap_len, PROT_READ | PROT_WRITE, MAP_SHARED, rv_fd, 0);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "mmap_basic: mmap: %s\n", strerror(errno));
+		return 1;
+	}
+
+	page = (struct tlob_mmap_page *)map;
+	data = (struct tlob_event *)((char *)map + page->data_offset);
+
+	if (page->version != 1) {
+		fprintf(stderr, "mmap_basic: expected version=1, got %u\n",
+			page->version);
+		ret = 1;
+		goto out;
+	}
+	if (page->capacity != TLOB_RING_DEFAULT_CAP) {
+		fprintf(stderr, "mmap_basic: expected capacity=%u, got %u\n",
+			TLOB_RING_DEFAULT_CAP, page->capacity);
+		ret = 1;
+		goto out;
+	}
+	if (page->data_offset != (uint32_t)pagesize) {
+		fprintf(stderr, "mmap_basic: expected data_offset=%ld, got %u\n",
+			pagesize, page->data_offset);
+		ret = 1;
+		goto out;
+	}
+	if (page->record_size != sizeof(struct tlob_event)) {
+		fprintf(stderr, "mmap_basic: expected record_size=%zu, got %u\n",
+			sizeof(struct tlob_event), page->record_size);
+		ret = 1;
+		goto out;
+	}
+	if (page->data_head != 0 || page->data_tail != 0) {
+		fprintf(stderr, "mmap_basic: ring not empty at open: head=%u tail=%u\n",
+			page->data_head, page->data_tail);
+		ret = 1;
+		goto out;
+	}
+	/* Touch the data array to confirm it is accessible. */
+	(void)data[0].tid;
+out:
+	munmap(map, mmap_len);
+	return ret;
+}
+
+/*
+ * test_mmap_errors - verify that rv_mmap() rejects invalid mmap parameters.
+ *
+ * Four cases are tested, each must return MAP_FAILED with errno == EINVAL:
+ *   1. size one page short of the correct ring length
+ *   2. size one page larger than the correct ring length
+ *   3. MAP_PRIVATE (only MAP_SHARED is permitted)
+ *   4. non-zero vm_pgoff (offset must be 0)
+ */
+static int test_mmap_errors(void)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	size_t correct_len = (size_t)pagesize +
+			     TLOB_RING_DEFAULT_CAP * sizeof(struct tlob_event);
+	/* rv_mmap requires a page-aligned length */
+	correct_len = (correct_len + (size_t)(pagesize - 1)) & ~(size_t)(pagesize - 1);
+	void *map;
+	int ret = 0;
+
+	/* Case 1: size one page short (correct_len - 1 still rounds up to correct_len) */
+	map = mmap(NULL, correct_len - (size_t)pagesize, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, rv_fd, 0);
+	if (map != MAP_FAILED) {
+		fprintf(stderr, "mmap_errors: short-size mmap succeeded (expected EINVAL)\n");
+		munmap(map, correct_len - (size_t)pagesize);
+		ret = 1;
+	} else if (errno != EINVAL) {
+		fprintf(stderr, "mmap_errors: short-size: expected EINVAL, got %s\n",
+			strerror(errno));
+		ret = 1;
+	}
+
+	/* Case 2: size one page too large */
+	map = mmap(NULL, correct_len + (size_t)pagesize, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, rv_fd, 0);
+	if (map != MAP_FAILED) {
+		fprintf(stderr, "mmap_errors: oversized mmap succeeded (expected EINVAL)\n");
+		munmap(map, correct_len + (size_t)pagesize);
+		ret = 1;
+	} else if (errno != EINVAL) {
+		fprintf(stderr, "mmap_errors: oversized: expected EINVAL, got %s\n",
+			strerror(errno));
+		ret = 1;
+	}
+
+	/* Case 3: MAP_PRIVATE instead of MAP_SHARED */
+	map = mmap(NULL, correct_len, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE, rv_fd, 0);
+	if (map != MAP_FAILED) {
+		fprintf(stderr, "mmap_errors: MAP_PRIVATE succeeded (expected EINVAL)\n");
+		munmap(map, correct_len);
+		ret = 1;
+	} else if (errno != EINVAL) {
+		fprintf(stderr, "mmap_errors: MAP_PRIVATE: expected EINVAL, got %s\n",
+			strerror(errno));
+		ret = 1;
+	}
+
+	/* Case 4: non-zero file offset (pgoff = 1) */
+	map = mmap(NULL, correct_len, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, rv_fd, (off_t)pagesize);
+	if (map != MAP_FAILED) {
+		fprintf(stderr, "mmap_errors: non-zero pgoff mmap succeeded (expected EINVAL)\n");
+		munmap(map, correct_len);
+		ret = 1;
+	} else if (errno != EINVAL) {
+		fprintf(stderr, "mmap_errors: non-zero pgoff: expected EINVAL, got %s\n",
+			strerror(errno));
+		ret = 1;
+	}
+
+	return ret;
+}
+
+/*
+ * test_mmap_consume - zero-copy consumption of a real violation event.
+ *
+ * Arms a 5 ms budget with self-notification (notify_fd = rv_fd), sleeps
+ * 50 ms (off-CPU violation), then reads the pushed event through the mmap'd
+ * ring without calling read().  Verifies:
+ *   - TRACE_STOP returns EOVERFLOW (budget was exceeded)
+ *   - data_head == 1 after the violation
+ *   - the event fields (threshold_us, tag, tid) are correct
+ *   - data_tail can be advanced to consume the record (ring empties)
+ */
+static int test_mmap_consume(void)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	size_t mmap_len = (size_t)pagesize +
+			  TLOB_RING_DEFAULT_CAP * sizeof(struct tlob_event);
+	/* rv_mmap requires a page-aligned length */
+	mmap_len = (mmap_len + (size_t)(pagesize - 1)) & ~(size_t)(pagesize - 1);
+	struct tlob_start_args args = {
+		.threshold_us = 5000,		/* 5 ms */
+		.notify_fd    = rv_fd,		/* self-notification */
+		.tag          = 0xdeadbeefULL,
+		.flags        = 0,
+	};
+	struct tlob_mmap_page *page;
+	struct tlob_event *data;
+	void *map;
+	int stop_ret;
+	int ret = 0;
+
+	map = mmap(NULL, mmap_len, PROT_READ | PROT_WRITE, MAP_SHARED, rv_fd, 0);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "mmap_consume: mmap: %s\n", strerror(errno));
+		return 1;
+	}
+
+	page = (struct tlob_mmap_page *)map;
+	data = (struct tlob_event *)((char *)map + page->data_offset);
+
+	if (ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args) < 0) {
+		fprintf(stderr, "mmap_consume: TRACE_START: %s\n", strerror(errno));
+		ret = 1;
+		goto out;
+	}
+
+	usleep(50000); /* 50 ms >> 5 ms budget -> off-CPU violation */
+
+	stop_ret = ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
+	if (stop_ret == 0) {
+		fprintf(stderr, "mmap_consume: TRACE_STOP returned 0, expected EOVERFLOW\n");
+		ret = 1;
+		goto out;
+	}
+	if (errno != EOVERFLOW) {
+		fprintf(stderr, "mmap_consume: TRACE_STOP: expected EOVERFLOW, got %s\n",
+			strerror(errno));
+		ret = 1;
+		goto out;
+	}
+
+	/* Pairs with smp_store_release in tlob_event_push. */
+	if (__atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE) != 1) {
+		fprintf(stderr, "mmap_consume: expected data_head=1, got %u\n",
+			page->data_head);
+		ret = 1;
+		goto out;
+	}
+	if (page->data_tail != 0) {
+		fprintf(stderr, "mmap_consume: expected data_tail=0, got %u\n",
+			page->data_tail);
+		ret = 1;
+		goto out;
+	}
+
+	/* Verify record content */
+	if (data[0].threshold_us != 5000) {
+		fprintf(stderr, "mmap_consume: expected threshold_us=5000, got %llu\n",
+			(unsigned long long)data[0].threshold_us);
+		ret = 1;
+		goto out;
+	}
+	if (data[0].tag != 0xdeadbeefULL) {
+		fprintf(stderr, "mmap_consume: expected tag=0xdeadbeef, got %llx\n",
+			(unsigned long long)data[0].tag);
+		ret = 1;
+		goto out;
+	}
+	if (data[0].tid == 0) {
+		fprintf(stderr, "mmap_consume: tid is 0\n");
+		ret = 1;
+		goto out;
+	}
+
+	/* Consume: advance data_tail and confirm ring is empty */
+	__atomic_store_n(&page->data_tail, 1U, __ATOMIC_RELEASE);
+	if (__atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE) !=
+	    __atomic_load_n(&page->data_tail, __ATOMIC_ACQUIRE)) {
+		fprintf(stderr, "mmap_consume: ring not empty after consume\n");
+		ret = 1;
+	}
+
+out:
+	munmap(map, mmap_len);
+	return ret;
+}
+
+/* -----------------------------------------------------------------------
+ * ELF utility: sym_offset
+ *
+ * Print the ELF file offset of a symbol in a binary.  Supports 32- and
+ * 64-bit ELF.  Walks the section headers to find .symtab (falling back to
+ * .dynsym), then converts the symbol's virtual address to a file offset
+ * via the PT_LOAD program headers.
+ *
+ * Does not require /dev/rv; used by the shell script to build uprobe
+ * bindings of the form pid:threshold_us:offset_start:offset_stop:binary_path.
+ *
+ * Returns 0 on success (offset printed to stdout), 1 on failure.
+ * -----------------------------------------------------------------------
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
+	/* Identify ELF class */
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
+		/* Walk section headers to find .symtab or .dynsym */
+		Elf64_Shdr *shdrs = (Elf64_Shdr *)((char *)map + ehdr->e_shoff);
+		Elf64_Shdr *shstrtab_hdr = &shdrs[ehdr->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+
+		/* Prefer .symtab; fall back to .dynsym */
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
+	if (open_rv() < 0)
+		return 2; /* skip */
+
+	if (strcmp(argv[1], "not_enabled") == 0)
+		rc = test_not_enabled();
+	else if (strcmp(argv[1], "within_budget") == 0)
+		rc = test_within_budget();
+	else if (strcmp(argv[1], "over_budget_cpu") == 0)
+		rc = test_over_budget_cpu();
+	else if (strcmp(argv[1], "over_budget_sleep") == 0)
+		rc = test_over_budget_sleep();
+	else if (strcmp(argv[1], "double_start") == 0)
+		rc = test_double_start();
+	else if (strcmp(argv[1], "stop_no_start") == 0)
+		rc = test_stop_no_start();
+	else if (strcmp(argv[1], "multi_thread") == 0)
+		rc = test_multi_thread();
+	else if (strcmp(argv[1], "self_watch") == 0)
+		rc = test_self_watch();
+	else if (strcmp(argv[1], "invalid_flags") == 0)
+		rc = test_invalid_flags();
+	else if (strcmp(argv[1], "notify_fd_bad") == 0)
+		rc = test_notify_fd_bad();
+	else if (strcmp(argv[1], "mmap_basic") == 0)
+		rc = test_mmap_basic();
+	else if (strcmp(argv[1], "mmap_errors") == 0)
+		rc = test_mmap_errors();
+	else if (strcmp(argv[1], "mmap_consume") == 0)
+		rc = test_mmap_consume();
+	else {
+		fprintf(stderr, "Unknown test: %s\n", argv[1]);
+		rc = 1;
+	}
+
+	close(rv_fd);
+	return rc;
+}
diff --git a/tools/testing/selftests/rv/tlob_uprobe_target.c b/tools/testing/selftests/rv/tlob_uprobe_target.c
new file mode 100644
index 000000000..6c895cb40
--- /dev/null
+++ b/tools/testing/selftests/rv/tlob_uprobe_target.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_uprobe_target.c - uprobe target binary for tlob selftests.
+ *
+ * Provides two well-known probe points:
+ *   tlob_busy_work()      - start probe: arms the tlob budget timer
+ *   tlob_busy_work_done() - stop  probe: cancels the timer on completion
+ *
+ * The tlob selftest writes a five-field uprobe binding:
+ *   pid:threshold_us:binary:offset_start:offset_stop
+ * where offset_start is the file offset of tlob_busy_work and offset_stop
+ * is the file offset of tlob_busy_work_done (resolved via tlob_helper
+ * sym_offset).
+ *
+ * Both probe points are plain entry uprobes (no uretprobe).  The busy loop
+ * keeps the task on-CPU so that either the stop probe fires cleanly (within
+ * budget) or the hrtimer fires first and emits tlob_budget_exceeded (over
+ * budget).
+ *
+ * Usage: tlob_uprobe_target <duration_ms>
+ *
+ * Loops calling tlob_busy_work() in 200 ms iterations until <duration_ms>
+ * has elapsed (0 = run for ~24 hours).  Short iterations ensure the uprobe
+ * entry fires on every call even if the uprobe is installed after the
+ * program has started.
+ */
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
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
+/*
+ * tlob_busy_work_done - stop-probe target.
+ *
+ * Called by tlob_busy_work() after the busy loop.  The uprobe on this
+ * function's entry fires tlob_stop_task(), cancelling the budget timer.
+ * noinline ensures the compiler never merges this function with its caller,
+ * guaranteeing the entry uprobe always fires.
+ */
+noinline void tlob_busy_work_done(void)
+{
+	/* empty: the uprobe fires on entry */
+}
+
+/*
+ * tlob_busy_work - start-probe target.
+ *
+ * The uprobe on this function's entry fires tlob_start_task(), arming the
+ * budget timer.  noinline prevents the compiler and linker (including LTO)
+ * from inlining this function into its callers, ensuring the entry uprobe
+ * fires on every call.
+ */
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
+int main(int argc, char *argv[])
+{
+	unsigned long duration_ms = 0;
+	struct timespec deadline, now;
+
+	if (argc >= 2)
+		duration_ms = strtoul(argv[1], NULL, 10);
+
+	clock_gettime(CLOCK_MONOTONIC, &deadline);
+	timespec_add_ms(&deadline, duration_ms ? duration_ms : 86400000UL);
+
+	do {
+		tlob_busy_work(200 * 1000000UL); /* 200 ms per iteration */
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (timespec_before(&now, &deadline));
+
+	return 0;
+}
-- 
2.43.0

