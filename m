Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73630BF4F;
	Wed, 12 Aug 2026 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495424; cv=none; b=u3HfeqAiZfCpV3YNYyDx1iKGY+To00COIDnIxRsIgDp5K9hEppSeOiyJ9aqn57BThWq2iCdO1F9lV4DzVqOlzskE3A5baka5ZfIZqdOFUY20MNfh2d25JjnCGc+8GnVp9NcjC7ZWXvY6K8xAJUWW6wKo6ChegUSPVgFLDPy5KRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495424; c=relaxed/simple;
	bh=xKt669PA2XgrDzMUHb8VwQgC1KdI4Dkxy6/f3/YEInI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtrjsUoFMzPWeVn0odt7pN54H7B+RTQagrn0YPwebdaOjZJIL26JP4HVld/WEr5eftkk26hV14rjnhfyhPHxyTldOyNJ+gOrJXQrP1Y/JJJpA3p8oIgxWI1ShSoL+cw9FUrtT+6cb5R6x6cTzNHZ6GRqzlNjheIyQ96dYmA1y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYIcJ1ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYIcJ1ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CF51F000E9;
	Wed, 12 Aug 2026 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495422;
	bh=xCWq/sHOsV+Mxg6OCiVsGgx3CvyKllQVTBr7t74D7AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYIcJ1ciOGKhtaRWvTpxw2xvyTCO/Ol8tu96rQhjYGDAV9RMbl9Ct3lK5EAVeSFsB
	 DYs19671/yZwHKQYNAAqio1Q7u0UJlXamKcheeCsidkilofSJVenunkK56pnW7QjSB
	 k+JDcoXqnJ1TlFbM10xfQgSCXUvzKALqCv54MCmAbFiNAAelJhEAyxRJSmC6MEtWwT
	 uGZ+dxXRn0C3DnMw1rjmiPXJpUF2EBDbwLrV1dxbQZxcEd//3FRbx8E/4Qrz3QVVo7
	 j2yP8NgU+l7P4A6qJPaVCTByKtZ9YnTxBUoevpJHV3wIHsz3oGfi1l2I6hb+XLsXEH
	 spEoJqlA/3HIw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/4] selftests/ftrace: Add generic boot tracing test framework
Date: Wed, 12 Aug 2026 09:43:38 +0900
Message-ID: <178649541846.438282.672153252242971310.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178649540853.438282.4271870161169100680.stgit@devnote2>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
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

Add a generic test framework under tools/testing/selftests/ftrace/boottime/
to verify kernel boot tracing configurations (bootconfig, kernel
command-line tracing options, and persistent ring buffers) during early
boot.

The test runner (run_boottime_test.sh) sources ktap_helpers.sh to generate
output in TAP version 13 format. It builds a minimal initramfs with busybox,
dynamically resolves test specifications (.bconf for bootconfig, .cmdline
for kernel boot parameters, .qemuopts for QEMU options, and # REBOOT: 1
for multi-boot crash/reboot tests with doubled timeout), boots QEMU, and
runs corresponding tracefs checker scripts.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Require file command and check kernel binary architecture via file -bL
   instead of matching kernel path string in run_boottime_test.sh.
 - Use 'cp -L' when copying BUSYBOX into initramfs to dereference
   symbolic links.
 - Use 'ln -sf' when creating BusyBox applet symlinks in initramfs.
 - Add support for '# APPLETS: <applets>' header in test scripts to
   dynamically create BusyBox applet symlinks in initramfs.
 - Update boottime test README to document file command dependency and
   '# APPLETS:' header syntax.
Changes in v2:
 - Add top-level boottime-ktap wrapper script and include it in
   TEST_PROGS in Makefile.
 - Define BUSYBOX_APPLETS as a global array variable including sleep
   and sed.
 - Require timeout tool in run_boottime_test.sh and README, and always
   invoke QEMU under timeout command to prevent infinite execution loops.
 - Add fallback sleep loop safeguard (sleep 100 || break) in guest
   init script.
 - Support multi-line .qemuopts files using read -r -d '' -a qemu_args.
---
 tools/testing/selftests/ftrace/Makefile            |    4 
 tools/testing/selftests/ftrace/boottime-ktap       |    6 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 
 tools/testing/selftests/ftrace/boottime/README     |   74 ++++
 .../selftests/ftrace/boottime/run_boottime_test.sh |  403 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    6 
 6 files changed, 501 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ftrace/boottime-ktap
 create mode 100644 tools/testing/selftests/ftrace/boottime/Makefile
 create mode 100644 tools/testing/selftests/ftrace/boottime/README
 create mode 100755 tools/testing/selftests/ftrace/boottime/run_boottime_test.sh

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index 7c12263f8260..3d41f9545683 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -2,8 +2,8 @@
 all:
 
 TEST_PROGS_EXTENDED := ftracetest
-TEST_PROGS := ftracetest-ktap
-TEST_FILES := test.d settings
+TEST_PROGS := ftracetest-ktap boottime-ktap
+TEST_FILES := test.d settings boottime
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 TEST_GEN_FILES := poll
diff --git a/tools/testing/selftests/ftrace/boottime-ktap b/tools/testing/selftests/ftrace/boottime-ktap
new file mode 100755
index 000000000000..1fed68c8a944
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime-ktap
@@ -0,0 +1,6 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# boottime-ktap: Wrapper to integrate boottime tracing test framework with kselftest runner
+
+exec ./boottime/run_boottime_test.sh "$@"
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
index 000000000000..1eb0191d75d4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/README
@@ -0,0 +1,74 @@
+Boot Tracing Test Suite
+=======================
+
+This directory contains an automated test framework to verify kernel boot
+tracing configurations (bootconfig, kernel command-line tracing options, and
+persistent ring buffers) during early boot.
+
+Overview
+--------
+The test runner (`run_boottime_test.sh`) constructs a lightweight initramfs with
+busybox and a tracefs checker script from `tests/`, attaches optional bootconfigs
+from `bootconfigs/` using the `bootconfig` tool, applies optional command-line
+parameters from `cmdlines/`, boots the target kernel image under QEMU, and reports
+results according to TAP version 13 format.
+
+Test Specification Format
+-------------------------
+For each test script `tests/<name>.sh`, the harness dynamically detects:
+- `bootconfigs/<name>.bconf` or `<name>.bconf`: Bootconfig configuration file.
+- `cmdlines/<name>.cmdline` or `# CMDLINE: <opts>` header in script: Kernel boot parameters.
+- `qemuopts/<name>.qemuopts` or `# QEMUOPTS: <opts>` header in script: Additional QEMU CLI arguments.
+- `# APPLETS: <applets>` header in script: Additional BusyBox applet symlinks to create in initramfs.
+- `# REBOOT: 1` header in script: Multi-boot reboot/crash test mode (omits `-no-reboot` and doubles timeout).
+
+Required Tools
+--------------
+- Host Architecture: x86 (x86_64/i686/i386/x86; tests skip on non-x86 hosts)
+- `qemu-system-x86_64` (or custom QEMU executable)
+- `busybox` (host binary at `/usr/bin/busybox` or custom path)
+- `bootconfig` (compiled from `tools/bootconfig/bootconfig` or in PATH)
+- `file` (standard file architecture identifier)
+- `cpio` (standard archiver)
+- `timeout` (standard coreutils execution timer)
+
+Required Kernel Configurations
+------------------------------
+The kernel binary under test must be compiled with:
+- `CONFIG_BOOT_CONFIG=y`
+- `CONFIG_BOOTTIME_TRACING=y`
+- `CONFIG_MAGIC_SYSRQ=y` (for guest reboot and poweroff)
+
+Additional feature-specific config options enable respective testcases:
+- `CONFIG_KPROBE_EVENTS=y` (for kprobe tests)
+- `CONFIG_SYNTH_EVENTS=y`  (for synthetic event tests)
+- `CONFIG_EPROBE_EVENTS=y` (for eprobe tests)
+- `CONFIG_FPROBE_EVENTS=y` (for fprobe and tracepoint probe tests)
+- `CONFIG_FUNCTION_TRACER=y` (for tracer options)
+- `CONFIG_RESERVE_MEM=y` (for persistent ring buffer tests)
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
+- `LOGDIR`: Directory path to preserve QEMU execution log files
diff --git a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
new file mode 100755
index 000000000000..6e8593d5a2c5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
@@ -0,0 +1,403 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+#
+# Generic Boot Tracing Test Harness
+# Builds a lightweight initramfs, applies bootconfigs and kernel cmdline parameters,
+# boots QEMU, and verifies tracefs configuration using test scripts.
+
+set -e
+
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+if [ -d "$SCRIPT_DIR/boottime" ]; then
+	SCRIPT_DIR="$SCRIPT_DIR/boottime"
+fi
+KERNEL_SRC="$(cd "$SCRIPT_DIR/../../../../.." && pwd)"
+
+# Source KTAP helpers
+if [ -f "$SCRIPT_DIR/../../kselftest/ktap_helpers.sh" ]; then
+	KSELFTEST_DIR="$(cd "$SCRIPT_DIR/../../kselftest" && pwd)"
+elif [ -f "$SCRIPT_DIR/../kselftest/ktap_helpers.sh" ]; then
+	KSELFTEST_DIR="$(cd "$SCRIPT_DIR/../kselftest" && pwd)"
+else
+	echo "Error: ktap_helpers.sh not found relative to $SCRIPT_DIR" >&2
+	exit 1
+fi
+. "$KSELFTEST_DIR/ktap_helpers.sh"
+
+BOOTCONFIG="${BOOTCONFIG:-"$KERNEL_SRC/tools/bootconfig/bootconfig"}"
+KERNEL="${KERNEL:-"$KERNEL_SRC/arch/x86/boot/bzImage"}"
+QEMU="${QEMU:-"qemu-system-x86_64"}"
+BUSYBOX="${BUSYBOX:-"$(which busybox 2>/dev/null || echo "/usr/bin/busybox")"}"
+TIMEOUT="${TIMEOUT:-60s}"
+LOGDIR="${LOGDIR:-""}"
+TARGET_TEST="all"
+
+BUSYBOX_APPLETS=(
+	sh
+	cat
+	mount
+	umount
+	echo
+	sync
+	reboot
+	poweroff
+	cpio
+	grep
+	sleep
+	sed
+)
+
+usage() {
+	echo "Usage: $0 [options]"
+	echo "Options:"
+	echo "  -b, --bootconfig PATH   Path to bootconfig tool (default: $BOOTCONFIG)"
+	echo "  -k, --kernel PATH       Path to kernel image (default: $KERNEL)"
+	echo "  -q, --qemu PATH         Path to QEMU executable (default: $QEMU)"
+	echo "  -B, --busybox PATH      Path to busybox binary (default: $BUSYBOX)"
+	echo "  -T, --timeout DURATION  QEMU execution timeout (default: $TIMEOUT)"
+	echo "  -l, --logdir DIR        Directory to save QEMU log files"
+	echo "  -t, --test NAME         Run specific test (e.g. 01-kprobe) or 'all'"
+	echo "  -h, --help              Show this help message"
+	exit 1
+}
+
+while [ $# -gt 0 ]; do
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
+		-T|--timeout)
+			TIMEOUT="$2"
+			shift 2
+			;;
+		-l|--logdir)
+			LOGDIR="$2"
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
+		if [ "$KERNEL" = "$KERNEL_SRC/arch/x86/boot/bzImage" ]; then
+			ktap_print_header
+			ktap_skip_all \
+				"Default boot tracing test is x86 only ($HOST_ARCH)"
+			exit 0
+		fi
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
+# Verify file command existence and architecture compatibility
+if ! command -v file >/dev/null 2>&1; then
+	ktap_print_header
+	ktap_skip_all "file tool not found"
+	exit 0
+fi
+
+KERNEL_INFO="$(file -bL "$KERNEL" 2>/dev/null || true)"
+case "$KERNEL_INFO" in
+	*x86*)
+		;;
+	*)
+		ktap_print_header
+		ktap_skip_all "Kernel architecture is not x86 ($KERNEL_INFO)"
+		exit 0
+		;;
+esac
+
+BUSYBOX_INFO="$(file -bL "$BUSYBOX" 2>/dev/null || true)"
+case "$BUSYBOX_INFO" in
+	*x86-64*|*x86_64*|*80386*|*i386*)
+		;;
+	*)
+		ktap_print_header
+		ktap_skip_all \
+			"busybox binary architecture is incompatible with x86 kernel ($BUSYBOX_INFO)"
+		exit 0
+		;;
+esac
+
+if ! command -v cpio >/dev/null 2>&1; then
+	ktap_print_header
+	ktap_skip_all "cpio tool not found"
+	exit 0
+fi
+
+if ! command -v timeout >/dev/null 2>&1; then
+	ktap_print_header
+	ktap_skip_all "timeout tool not found"
+	exit 0
+fi
+
+double_timeout() {
+	local val="$1"
+	if [[ "$val" =~ ^([0-9]+)([a-z]*)$ ]]; then
+		local num="${BASH_REMATCH[1]}"
+		local unit="${BASH_REMATCH[2]}"
+		echo "$((num * 2))$unit"
+	else
+		echo "120s"
+	fi
+}
+
+run_single_test() {
+	local test_script="$1"
+	local name
+	local dir
+	name="$(basename "$test_script" .sh)"
+	dir="$(dirname "$test_script")"
+
+	local bconf_file=""
+	if [ -f "$SCRIPT_DIR/bootconfigs/$name.bconf" ]; then
+		bconf_file="$SCRIPT_DIR/bootconfigs/$name.bconf"
+	elif [ -f "$dir/$name.bconf" ]; then
+		bconf_file="$dir/$name.bconf"
+	fi
+
+	local test_cmdline=""
+	if [ -f "$SCRIPT_DIR/cmdlines/$name.cmdline" ]; then
+		test_cmdline="$(cat "$SCRIPT_DIR/cmdlines/$name.cmdline")"
+	elif [ -f "$dir/$name.cmdline" ]; then
+		test_cmdline="$(cat "$dir/$name.cmdline")"
+	fi
+
+	local inline_cmdline
+	inline_cmdline="$(grep -E '^# *CMDLINE:' "$test_script" | sed 's/^# *CMDLINE://' | xargs || true)"
+	if [ -n "$inline_cmdline" ]; then
+		test_cmdline="$test_cmdline $inline_cmdline"
+	fi
+
+	local test_qemuopts=""
+	if [ -f "$SCRIPT_DIR/qemuopts/$name.qemuopts" ]; then
+		test_qemuopts="$(cat "$SCRIPT_DIR/qemuopts/$name.qemuopts")"
+	elif [ -f "$dir/$name.qemuopts" ]; then
+		test_qemuopts="$(cat "$dir/$name.qemuopts")"
+	fi
+
+	local inline_qemuopts
+	inline_qemuopts="$(grep -E '^# *QEMUOPTS:' "$test_script" | sed 's/^# *QEMUOPTS://' | xargs || true)"
+	if [ -n "$inline_qemuopts" ]; then
+		test_qemuopts="$test_qemuopts $inline_qemuopts"
+	fi
+
+	local test_timeout="$TIMEOUT"
+	local inline_timeout
+	inline_timeout="$(grep -E '^# *TIMEOUT:' "$test_script" | sed 's/^# *TIMEOUT://' | xargs || true)"
+	if [ -n "$inline_timeout" ]; then
+		test_timeout="$inline_timeout"
+	fi
+
+	local is_reboot=0
+	if grep -q -E '^# *REBOOT: *1' "$test_script" || [ -f "$dir/$name.reboot" ]; then
+		is_reboot=1
+	fi
+
+	local effective_timeout="$test_timeout"
+	if [ "$is_reboot" -eq 1 ]; then
+		effective_timeout="$(double_timeout "$test_timeout")"
+	fi
+
+	local workdir
+	workdir="$(mktemp -d)"
+	if [ -z "$workdir" ] || [ ! -d "$workdir" ]; then
+		ktap_test_fail "$name (failed to create temporary directory)"
+		return 0
+	fi
+	trap 'rm -rf "$workdir"' EXIT
+
+	local test_applets=("${BUSYBOX_APPLETS[@]}")
+	local inline_applets
+	inline_applets="$(grep -E '^# *APPLETS:' "$test_script" | sed 's/^# *APPLETS://' | xargs || true)"
+	if [ -n "$inline_applets" ]; then
+		read -r -a extra_applets <<< "$inline_applets" || true
+		test_applets+=("${extra_applets[@]}")
+	fi
+
+	local rootfs="$workdir/rootfs"
+	mkdir -p "$rootfs"/{bin,sbin,etc,proc,sys,dev,tmp}
+
+	cp -L "$BUSYBOX" "$rootfs/bin/busybox"
+	chmod +x "$rootfs/bin/busybox"
+	(cd "$rootfs/bin" && for applet in "${test_applets[@]}"; do ln -sf busybox "$applet"; done)
+
+	if command -v ldd >/dev/null 2>&1; then
+		for lib in $(ldd "$BUSYBOX" 2>/dev/null | grep -o '/[^ ]*' || true); do
+			if [ -f "$lib" ]; then
+				mkdir -p "$rootfs$(dirname "$lib")"
+				cp -L "$lib" "$rootfs$lib" 2>/dev/null || true
+			fi
+		done
+	fi
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
+sync
+echo o > /proc/sysrq-trigger 2>/dev/null || true
+poweroff -f 2>/dev/null || reboot -f 2>/dev/null || true
+while true; do sleep 100 2>/dev/null || break; done
+EOF
+	chmod +x "$rootfs/init"
+
+	cp "$test_script" "$rootfs/bin/check_test.sh"
+	chmod +x "$rootfs/bin/check_test.sh"
+
+	local initramfs="$workdir/initramfs.cpio"
+	(cd "$rootfs" && find . | cpio -o -H newc --quiet) > "$initramfs"
+
+	if [ -n "$bconf_file" ] && [ -f "$bconf_file" ]; then
+		"$BOOTCONFIG" -a "$bconf_file" "$initramfs" > /dev/null
+	fi
+
+
+	local logfile
+	local base_cmdline="bootconfig console=tty0 console=ttyS0 panic=-1"
+	if [ -n "$test_cmdline" ]; then
+		base_cmdline="$base_cmdline $test_cmdline"
+	fi
+
+	if [ -n "$LOGDIR" ]; then
+		mkdir -p "$LOGDIR"
+		logfile="$LOGDIR/$name.log"
+		base_cmdline="$base_cmdline dump_bconf"
+	else
+		logfile="$workdir/qemu.log"
+		base_cmdline="quiet $base_cmdline"
+	fi
+
+	local qemu_args=()
+	if [ -n "$test_qemuopts" ]; then
+		read -r -d '' -a qemu_args <<< "$test_qemuopts" || true
+	fi
+
+	if [ "$is_reboot" -ne 1 ]; then
+		qemu_args+=("-no-reboot")
+	fi
+
+	timeout "$effective_timeout" "$QEMU" -kernel "$KERNEL" \
+		-initrd "$initramfs" \
+		-append "$base_cmdline" \
+		-display none \
+		-serial stdio \
+		"${qemu_args[@]}" < /dev/null > "$logfile" 2>&1 || true
+
+	if grep -q "TEST RESULT: PASS" "$logfile"; then
+		ktap_test_pass "$name"
+	else
+		ktap_test_fail "$name"
+		ktap_print_msg "QEMU Console Output for $name:"
+		while IFS= read -r line; do
+			ktap_print_msg "$line"
+		done < "$logfile"
+	fi
+
+	rm -rf "$workdir"
+	trap - EXIT
+	return 0
+}
+
+TEST_SCRIPTS=()
+if [ -d "$SCRIPT_DIR/tests" ]; then
+	while IFS= read -r f; do
+		[ -n "$f" ] && TEST_SCRIPTS+=("$f")
+	done < <(find "$SCRIPT_DIR/tests" -type f -name "*.sh" | sort)
+fi
+
+TOTAL_TESTS=0
+for test_script in "${TEST_SCRIPTS[@]}"; do
+	name="$(basename "$test_script" .sh)"
+	if [ "$TARGET_TEST" != "all" ] && [ "$TARGET_TEST" != "$name" ]; then
+		continue
+	fi
+	TOTAL_TESTS=$((TOTAL_TESTS + 1))
+done
+
+ktap_print_header
+ktap_set_plan "$TOTAL_TESTS"
+
+for test_script in "${TEST_SCRIPTS[@]}"; do
+	name="$(basename "$test_script" .sh)"
+
+	if [ "$TARGET_TEST" != "all" ] && [ "$TARGET_TEST" != "$name" ]; then
+		continue
+	fi
+
+	run_single_test "$test_script"
+done
+
+ktap_finished
diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 544de0db5f58..29f05f7c6e2c 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -1,3 +1,5 @@
+CONFIG_BOOT_CONFIG=y
+CONFIG_BOOTTIME_TRACING=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
@@ -8,22 +10,26 @@ CONFIG_FTRACE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_GRAPH_RETVAL=y
 CONFIG_FUNCTION_PROFILER=y
+CONFIG_FUNCTION_TRACER=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KPROBES=y
 CONFIG_KPROBE_EVENTS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
 CONFIG_PREEMPT_TRACER=y
 CONFIG_PROBE_EVENTS_BTF_ARGS=y
+CONFIG_RESERVE_MEM=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_FTRACE_DIRECT=m
 CONFIG_SAMPLE_TRACE_EVENTS=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SCHED_TRACER=y
 CONFIG_STACK_TRACER=y
+CONFIG_SYNTH_EVENTS=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y

