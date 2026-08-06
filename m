Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861613A1A3B;
	Thu,  6 Aug 2026 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978437; cv=none; b=A7Bj8+dTiIrZtEGtB5iRQK9RHbt0pa2O51bhXaT80m7EV8FwqhuiW5EpzY3vrGYx46FFzCxVub18o+dnfLFk5rMChWsRMakkh0NIQ6exgHPzl66NdNZLXyx3An7nWBrvAk7SDR0F5N3G9fUwxbbw/DFqZvjPPiICorlyen5IBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978437; c=relaxed/simple;
	bh=EcFHNNOCECfMjbLjSLKBDOpr7luif1xFAAh+Y2QtGVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNjpv1RIdGzaS+Y2j0lmGYA2zjIETA59ee+HBQOjQLUXP0v8aSKG9GSw2kDJK+y8fQy3s23jr9l9wr5wpstUdGtZbm0DbFa6tFioXLp90OJ8a31IRAGC8PflskST6JMqbFdzMj9apI6F+ogasaXuz82MNqF/Daq4h4CzLBz7FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLWKnRV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLWKnRV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D691F000E9;
	Thu,  6 Aug 2026 01:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978435;
	bh=egClkRG0rWBlFH/FWmWM7obY1gv6+ZKgafn3zgJGUPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLWKnRV9Imz4zG2C/08wKnmzmZ8uk7jUdIRbIMHpHDTtP8NlD6A1/NXrsQ8f1rSxm
	 cD83R3T+7Lag0MCYTt5Npar8HUhld5aMoPYf4m5BDZw+tm6JKVa4BVoObh4tMn6jYC
	 mE5KKUddqbJrtVp3GpSGCehrn2rtNDhRtnof7uP1qEtIg2vzZUY+71r5kVfjvUHMlL
	 T8yGq4JlDRTCQCqZnxoEc21SYu4T0QIVCDZ5+g1ZJ0jyGZRF31UToE8qfw57O3s0pV
	 8CP72L8JhyG1QDjNszEfMFJbk2bAXVIDJIF2FjUMDoDKUN3IgDa1RKMQdUjw4CShu5
	 dVR9icGd2rLSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Add boot-time tracing test framework
Date: Thu,  6 Aug 2026 10:07:10 +0900
Message-ID: <178597843076.123558.16725675716123941033.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178597841107.123558.13065821394773752510.stgit@devnote2>
References: <178597841107.123558.13065821394773752510.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add an automated test framework under
tools/testing/selftests/ftrace/boottime/ to verify boot-time tracing
configuration parsing.

The test runner (run_boottime_test.sh) sources ktap_helpers.sh to
generate output in TAP version 13 format. It builds a minimal
initramfs with busybox, attaches bootconfig examples using
tools/bootconfig/bootconfig, boots QEMU, and runs corresponding
tracefs checker scripts.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/Makefile            |    2 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 +
 tools/testing/selftests/ftrace/boottime/README     |   58 +++++
 .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    5 
 .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 
 .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 
 .../selftests/ftrace/boottime/run_boottime_test.sh |  218 ++++++++++++++++++++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   18 ++
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/06-instance.sh |   23 ++
 tools/testing/selftests/ftrace/config              |    4 
 17 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/Makefile
 create mode 100644 tools/testing/selftests/ftrace/boottime/README
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
 create mode 100755 tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/06-instance.sh

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index 7c12263f8260..8d8881744149 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -3,7 +3,7 @@ all:
 
 TEST_PROGS_EXTENDED := ftracetest
 TEST_PROGS := ftracetest-ktap
-TEST_FILES := test.d settings
+TEST_FILES := test.d settings boottime
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 TEST_GEN_FILES := poll
diff --git a/tools/testing/selftests/ftrace/boottime/Makefile b/tools/testing/selftests/ftrace/boottime/Makefile
new file mode 100644
index 000000000000..fd0975350f10
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+all:
+
+run_tests:
+	@./run_boottime_test.sh
+
+clean:
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/ftrace/boottime/README b/tools/testing/selftests/ftrace/boottime/README
new file mode 100644
index 000000000000..a6f930a6e44c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/README
@@ -0,0 +1,58 @@
+Boot-Time Tracing Test Suite
+============================
+
+This directory contains an automated test framework to verify kernel boot-time
+tracing configuration parsing and tracefs application during early boot.
+
+Overview
+--------
+The test runner (`run_boottime_test.sh`) constructs a lightweight initramfs with
+busybox and a tracefs checker script from `tests/`, attaches a bootconfig example
+from `bootconfigs/` using the `bootconfig` tool, boots the target kernel image under
+QEMU, and reports results according to the TAP version 13 format.
+
+Required Tools
+--------------
+- Host Architecture: x86 (x86_64/i686/i386/x86; tests skip on non-x86 hosts)
+- `qemu-system-x86_64` (or custom QEMU executable)
+- `busybox` (host binary at `/usr/bin/busybox` or custom path)
+- `bootconfig` (compiled from `tools/bootconfig/bootconfig` or in PATH)
+- `cpio` (standard archiver)
+
+Required Kernel Configurations
+------------------------------
+The kernel binary under test must be compiled with:
+- `CONFIG_BOOT_CONFIG=y`
+- `CONFIG_BOOTTIME_TRACING=y`
+
+Additional feature-specific config options enable respective testcases:
+- `CONFIG_KPROBE_EVENTS=y` (for `01-kprobe`)
+- `CONFIG_SYNTH_EVENTS=y`  (for `02-synth`)
+- `CONFIG_EPROBE_EVENTS=y` (for `03-eprobe`)
+- `CONFIG_FPROBE_EVENTS=y` (for `04-fprobe` and `05-tprobe`)
+- `CONFIG_FUNCTION_TRACER=y` (for tracer options in `06-instance`)
+
+Usage
+-----
+To run all test cases with a compiled kernel image:
+
+  $ ./run_boottime_test.sh -k /path/to/bzImage
+
+To run a specific test case (e.g. `01-kprobe`):
+
+  $ ./run_boottime_test.sh -k /path/to/bzImage -t 01-kprobe
+
+Customizing Tool Paths:
+
+  $ ./run_boottime_test.sh -b /path/to/bootconfig \
+                         -k /path/to/bzImage \
+                         -q /path/to/qemu-system-x86_64 \
+                         -B /path/to/busybox
+
+Environment Variables
+---------------------
+Tool locations and kernel paths can also be set via environment variables:
+- `BOOTCONFIG`: Path to the `bootconfig` tool
+- `KERNEL`: Path to the `bzImage` kernel binary
+- `QEMU`: Path to the QEMU binary
+- `BUSYBOX`: Path to the `busybox` binary
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
new file mode 100644
index 000000000000..f607840e3858
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
@@ -0,0 +1,5 @@
+ftrace.event.kprobes.vfs_read {
+	probes = "vfs_read $arg1 $arg2"
+	filter = "common_pid < 200"
+	enable
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
new file mode 100644
index 000000000000..b1f37713f33c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
@@ -0,0 +1,4 @@
+ftrace.event.synthetic.boot_lat {
+	fields = "unsigned long id", "u64 delta"
+	enable
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
new file mode 100644
index 000000000000..f954aa7fb8bd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
@@ -0,0 +1,4 @@
+ftrace.event.eprobes.ep_read {
+	probes = "syscalls/sys_enter_openat"
+	enable
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
new file mode 100644
index 000000000000..82ae2ac0629f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
@@ -0,0 +1,4 @@
+ftrace.event.fprobes.fp_read {
+	probes = "vfs_read"
+	enable
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
new file mode 100644
index 000000000000..02a2803c770a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
@@ -0,0 +1,4 @@
+ftrace.event.tracepoints.tp_sched {
+	probes = "sched_switch"
+	enable
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
new file mode 100644
index 000000000000..31f81da570ea
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.foo {
+	event.sched.sched_switch.enable
+	buffer_size = 1MB
+	tracing_on = 1
+}
diff --git a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
new file mode 100755
index 000000000000..0bf95a47c5d6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
@@ -0,0 +1,218 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Boot-time tracing test runner
+# Builds a lightweight initramfs, attaches a bootconfig, boots QEMU,
+# and verifies tracefs configuration using test scripts.
+
+set -e
+
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+KERNEL_SRC="$(cd "$SCRIPT_DIR/../../../../.." && pwd)"
+
+# Source KTAP helpers
+KSELFTEST_DIR="$(cd "$SCRIPT_DIR/../../kselftest" && pwd)"
+if [ -f "$KSELFTEST_DIR/ktap_helpers.sh" ]; then
+	. "$KSELFTEST_DIR/ktap_helpers.sh"
+else
+	echo "Error: ktap_helpers.sh not found at $KSELFTEST_DIR"
+	exit 1
+fi
+
+BOOTCONFIG="${BOOTCONFIG:-"$KERNEL_SRC/tools/bootconfig/bootconfig"}"
+KERNEL="${KERNEL:-"$KERNEL_SRC/arch/x86/boot/bzImage"}"
+QEMU="${QEMU:-"qemu-system-x86_64"}"
+BUSYBOX="${BUSYBOX:-"$(which busybox 2>/dev/null || echo "/usr/bin/busybox")"}"
+TARGET_TEST="all"
+
+usage() {
+	echo "Usage: $0 [options]"
+	echo "Options:"
+	echo "  -b, --bootconfig PATH   Path to bootconfig tool (default: $BOOTCONFIG)"
+	echo "  -k, --kernel PATH       Path to kernel image (default: $KERNEL)"
+	echo "  -q, --qemu PATH         Path to QEMU executable (default: $QEMU)"
+	echo "  -B, --busybox PATH      Path to busybox binary (default: $BUSYBOX)"
+	echo "  -t, --test NAME         Run specific test (e.g. 01-kprobe) or 'all'"
+	echo "  -h, --help              Show this help message"
+	exit 1
+}
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+		-b|--bootconfig)
+			BOOTCONFIG="$2"
+			shift 2
+			;;
+		-k|--kernel)
+			KERNEL="$2"
+			shift 2
+			;;
+		-q|--qemu)
+			QEMU="$2"
+			shift 2
+			;;
+		-B|--busybox)
+			BUSYBOX="$2"
+			shift 2
+			;;
+		-t|--test)
+			TARGET_TEST="$2"
+			shift 2
+			;;
+		-h|--help)
+			usage
+			;;
+		*)
+			echo "Unknown option: $1"
+			usage
+			;;
+	esac
+done
+
+# Check host architecture
+HOST_ARCH="$(uname -m)"
+case "$HOST_ARCH" in
+	x86_64|i686|i386|x86)
+		;;
+	*)
+		ktap_print_header
+		ktap_skip_all \
+			"Boot-time tracing tests currently support x86 host architecture only ($HOST_ARCH)"
+		exit 0
+		;;
+esac
+
+# Ensure bootconfig tool is built if Makefile exists
+if [ ! -x "$BOOTCONFIG" ]; then
+	if [ -f "$KERNEL_SRC/tools/bootconfig/Makefile" ]; then
+		make -C "$KERNEL_SRC/tools/bootconfig" > /dev/null 2>&1 || true
+	fi
+	if [ ! -x "$BOOTCONFIG" ]; then
+		BOOTCONFIG="$(which bootconfig 2>/dev/null || true)"
+	fi
+fi
+
+if [ ! -x "$BOOTCONFIG" ]; then
+	ktap_print_header
+	ktap_skip_all "bootconfig tool not found at $BOOTCONFIG"
+	exit 0
+fi
+
+if [ ! -f "$KERNEL" ]; then
+	ktap_print_header
+	ktap_skip_all "Kernel image not found at $KERNEL"
+	exit 0
+fi
+
+if ! command -v "$QEMU" >/dev/null 2>&1; then
+	ktap_print_header
+	ktap_skip_all "QEMU binary not found: $QEMU"
+	exit 0
+fi
+
+if [ ! -x "$BUSYBOX" ]; then
+	ktap_print_header
+	ktap_skip_all "busybox binary not found at $BUSYBOX"
+	exit 0
+fi
+
+run_single_test() {
+	local bconf_file="$1"
+	local test_script="$2"
+	local name="$(basename "$bconf_file" .bconf)"
+
+	local workdir="$(mktemp -d)"
+	trap 'rm -rf "$workdir"' EXIT
+
+	local rootfs="$workdir/rootfs"
+	mkdir -p "$rootfs"/{bin,sbin,etc,proc,sys,dev,tmp}
+
+	cp "$BUSYBOX" "$rootfs/bin/busybox"
+	chmod +x "$rootfs/bin/busybox"
+	(cd "$rootfs/bin" && for applet in sh cat mount umount echo sync reboot \
+		poweroff cpio grep; do ln -s busybox $applet; done)
+
+	cat << 'EOF' > "$rootfs/init"
+#!/bin/sh
+mount -t proc proc /proc 2>/dev/null
+mount -t sysfs sys /sys 2>/dev/null
+mount -t tracefs nodev /sys/kernel/tracing 2>/dev/null
+
+/bin/check_test.sh
+RET=$?
+
+if [ $RET -eq 0 ]; then
+	echo "TEST RESULT: PASS"
+else
+	echo "TEST RESULT: FAIL"
+fi
+
+sync
+echo o > /proc/sysrq-trigger 2>/dev/null || reboot -f 2>/dev/null || poweroff -f 2>/dev/null
+EOF
+	chmod +x "$rootfs/init"
+
+	cp "$test_script" "$rootfs/bin/check_test.sh"
+	chmod +x "$rootfs/bin/check_test.sh"
+
+	local initramfs="$workdir/initramfs.cpio"
+	(cd "$rootfs" && find . | cpio -o -H newc --quiet) > "$initramfs"
+
+	# Attach bootconfig
+	"$BOOTCONFIG" -a "$bconf_file" "$initramfs" > /dev/null
+
+	# Run QEMU
+	local logfile="$workdir/qemu.log"
+	"$QEMU" -kernel "$KERNEL" \
+		-initrd "$initramfs" \
+		-append "bootconfig console=ttyS0 quiet panic=-1" \
+		-nographic \
+		-no-reboot > "$logfile" 2>&1 || true
+
+	if grep -q "TEST RESULT: PASS" "$logfile"; then
+		ktap_test_pass "$name"
+		rm -rf "$workdir"
+		trap - EXIT
+		return 0
+	else
+		ktap_test_fail "$name"
+		ktap_print_msg "QEMU Console Output for $name:"
+		while IFS= read -r line; do
+			ktap_print_msg "$line"
+		done < "$logfile"
+		rm -rf "$workdir"
+		trap - EXIT
+		return 1
+	fi
+}
+
+TEST_FILES=("$SCRIPT_DIR/bootconfigs"/*.bconf)
+TOTAL_TESTS=0
+for bconf in "${TEST_FILES[@]}"; do
+	name="$(basename "$bconf" .bconf)"
+	if [ "$TARGET_TEST" != "all" ] && [ "$TARGET_TEST" != "$name" ]; then
+		continue
+	fi
+	TOTAL_TESTS=$((TOTAL_TESTS + 1))
+done
+
+ktap_print_header
+ktap_set_plan "$TOTAL_TESTS"
+
+for bconf in "${TEST_FILES[@]}"; do
+	name="$(basename "$bconf" .bconf)"
+	test_script="$SCRIPT_DIR/tests/$name.sh"
+
+	if [ "$TARGET_TEST" != "all" ] && [ "$TARGET_TEST" != "$name" ]; then
+		continue
+	fi
+
+	if [ ! -f "$test_script" ]; then
+		ktap_test_skip "$name (test script missing)"
+		continue
+	fi
+
+	run_single_test "$bconf" "$test_script" || true
+done
+
+ktap_finished
diff --git a/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh b/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
new file mode 100755
index 000000000000..a20e7e82d158
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check kprobe bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/kprobes/vfs_read" ]; then
+	echo "FAIL: kprobe event kprobes/vfs_read does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/events/kprobes/vfs_read/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: kprobe event kprobes/vfs_read is not enabled ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 01-kprobe"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/02-synth.sh b/tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
new file mode 100755
index 000000000000..46d3b152cbea
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check synthetic event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/synthetic/boot_lat" ]; then
+	echo "FAIL: synthetic event synthetic/boot_lat does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/events/synthetic/boot_lat/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: synthetic event synthetic/boot_lat is not enabled ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 02-synth"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh b/tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
new file mode 100755
index 000000000000..108f9ba31c06
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check eprobe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/eprobes/ep_read" ]; then
+	echo "FAIL: eprobe event eprobes/ep_read does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/events/eprobes/ep_read/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: eprobe event eprobes/ep_read is not enabled ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 03-eprobe"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh b/tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
new file mode 100755
index 000000000000..c0a316bf7dde
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check fprobe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/fprobes/fp_read" ]; then
+	echo "FAIL: fprobe event fprobes/fp_read does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/events/fprobes/fp_read/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: fprobe event fprobes/fp_read is not enabled ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 04-fprobe"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh b/tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
new file mode 100755
index 000000000000..b29119b81e07
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check tracepoint probe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/tracepoints/tp_sched" ]; then
+	echo "FAIL: tracepoint probe event tracepoints/tp_sched does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/events/tracepoints/tp_sched/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: tracepoint probe event tracepoints/tp_sched is not enabled ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 05-tprobe"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/06-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/06-instance.sh
new file mode 100755
index 000000000000..a95fdddaa6a6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/06-instance.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check instance bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/instances/foo" ]; then
+	echo "FAIL: trace instance foo does not exist"
+	exit 1
+fi
+
+if [ ! -d "$TRACEDIR/instances/foo/events/sched/sched_switch" ]; then
+	echo "FAIL: event sched_switch does not exist in instance foo"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/instances/foo/events/sched/sched_switch/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: event sched_switch is not enabled in instance foo ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: 06-instance"
+exit 0
diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 544de0db5f58..fec41c6b290e 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -1,3 +1,5 @@
+CONFIG_BOOT_CONFIG=y
+CONFIG_BOOTTIME_TRACING=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
@@ -8,6 +10,7 @@ CONFIG_FTRACE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_GRAPH_RETVAL=y
 CONFIG_FUNCTION_PROFILER=y
+CONFIG_FUNCTION_TRACER=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_KALLSYMS_ALL=y
@@ -24,6 +27,7 @@ CONFIG_SAMPLE_TRACE_EVENTS=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SCHED_TRACER=y
 CONFIG_STACK_TRACER=y
+CONFIG_SYNTH_EVENTS=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y

