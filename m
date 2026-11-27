Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791079;
	b=hdJ+ZQuaw2J4Gq29T7+Y+4fA+gAGMXy480PTOrO9mTaaJ+sdvcymNJkbeJxdXx3NDRB8
	 nU+iL5arZuvN3YzD+fsOc+YsYVFw0gKU1K2zESUI6IVewBGJcX1bI53cS/Eo3NP5mZBaJ
	 tlBoxTeccbWDLTHwUGvqZ9IaFwMi8vg5yrdiPnegCd0R8QPpTYhztnR0iJFJ18Zbn8oSG
	 QvVe6a1JpiBiv16/YPFODBvFpMVuQF5qwKvxn3ptVOyyFJjv25r/AwMkmx9nSemIAqVKO
	 wImLwTAZ6en00qv9BFeuYilwhDqGJB2Qo1oWCcecOL2vZ+C8jnihL9zWNbYqUyesG+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QfKueNsUhX0jJ/+JLMjSc1lMENoe/5O/2wYC+K2mAEQ=;
	b=3TT05ueVWttgF7Z6Go2dobdV9xiVMXZm8hz59tJxRziCYU5hzSZweYw3QAf1EvCuvNBP
	 3vH+61p9XBeO/DDvDlC5YKXpOSV2eSimbzyCswrSpmJg8OXL7s4G5RsveCdCPSIH7DhPe
	 1UtXL3De8JHhSh29e1F1M5u+6LylEgakdNU60hlBCkdBkhsqK+5IE39102+7FWlScpjoz
	 5D+F81eRGxcKPsrVv1tVeArZ94T0k7jBEWoaqk0r7PRoZ3xyMJyTGue3ZvSQChqiVJZrG
	 QQ2LqdE4NBwqnvU6N8hFPE7HUK4ZFRxsQvF93mUiQZ0mBPQ7tkLXhbS7hJE5mtVC5Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYi0uAb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61C606A31C;
	Fri, 27 Nov 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYi0uAb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B278E1F00898;
	Fri, 27 Nov 2026 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791079;
	bh=QfKueNsUhX0jJ/+JLMjSc1lMENoe/5O/2wYC+K2mAEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYi0uAb4yheDBJPmD1z9nzlpebMJaja6aQTqRM+aZBL862DK7FwSHvztccTnD6oub
	 bzoJFhCd53kjAgkTvAoxSE2TXtivgYyz4vUsTZXLeR+yyPyw8B+hIOaXNO+4XQIDeQ
	 X0t0WkEmj77T+Xx6WbVhfCZ+YGq4t3e8US8DKV3LcAtaddjN8rcUKwP2mZtRJ90G1o
	 /5ZOcF28AtLHxYuFzVtUlrWAEa4Zt4XX/KZIRdwe5MEcqXYUGMmFIIB7XjViAWzHFL
	 BKl9mK0qXYiku9sY0vxAzrzmU1u4gPt+Poa2hLBZdR0D/QlNr8mE6HMjxTcAtguTV0
	 RaIEIq9wsBmFw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 4/5] selftests/ftrace: Add boottime tests for multiple bootconfig selection
Date: Fri, 27 Nov 2026 14:46:18 +0000
Message-ID: <20261127144614.61194-5-mhiramat@kernel.org>
X-Mailer: UndineD 0.1
In-Reply-To: <20261127144614.61194-1-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Extend the ftrace boottime QEMU test harness to attach multiple named
bootconfig files and add tests covering multi-bootconfig boot behavior:

- Update run_boottime_test.sh and README to attach named
  bootconfigs/<name>.<id>.bconf files and "# BOOTCONFIGS:" headers,
  dump /proc/bootconfig from /init when dump_bconf is set, and preserve
  explicit bootconfig= cmdline overrides.
- Add tests verifying:
  - bconf-multi-01-default: bare bootconfig loads only index 0.
  - bconf-multi-02-select: bootconfig=base,dbg merges and overrides keys.
  - bconf-multi-03-append: bootconfig=+dbg appends onto default index 0.
  - bconf-multi-04-clear: bootconfig= clears an earlier bootconfig option.
  - bconf-multi-05-conflict: conflicting "=" redefinition via
    "# BOOTCONFIGS:" reports the [1:conflict] parse error in dmesg.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../testing/selftests/ftrace/boottime/README  |  4 +-
 .../bootconfigs/bconf-multi-01-default.bconf  |  5 +
 .../bconf-multi-01-default.debug.bconf        |  5 +
 .../bconf-multi-02-select.alt.bconf           |  5 +
 .../bconf-multi-02-select.base.bconf          |  7 ++
 .../bconf-multi-02-select.dbg.bconf           |  7 ++
 .../bootconfigs/bconf-multi-03-append.bconf   |  6 ++
 .../bconf-multi-03-append.dbg.bconf           |  6 ++
 .../bootconfigs/bconf-multi-04-clear.bconf    |  5 +
 .../bootconfigs/bconf-multi-05-conflict.bconf |  6 ++
 .../ftrace/boottime/run_boottime_test.sh      | 99 ++++++++++++++++++-
 .../boottime/tests/bconf-multi-01-default.sh  | 23 +++++
 .../boottime/tests/bconf-multi-02-select.sh   | 53 ++++++++++
 .../boottime/tests/bconf-multi-03-append.sh   | 26 +++++
 .../boottime/tests/bconf-multi-04-clear.sh    | 26 +++++
 .../boottime/tests/bconf-multi-05-conflict.sh | 22 +++++
 16 files changed, 300 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.debug.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.alt.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.base.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.dbg.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.dbg.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-04-clear.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-05-conflict.bconf
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-01-default.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-02-select.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-03-append.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-04-clear.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-05-conflict.sh

diff --git a/tools/testing/selftests/ftrace/boottime/README b/tools/testing/selftests/ftrace/boottime/README
index 1eb0191d75d4..eff7eb2c42d9 100644
--- a/tools/testing/selftests/ftrace/boottime/README
+++ b/tools/testing/selftests/ftrace/boottime/README
@@ -16,7 +16,9 @@ results according to TAP version 13 format.
 Test Specification Format
 -------------------------
 For each test script `tests/<name>.sh`, the harness dynamically detects:
-- `bootconfigs/<name>.bconf` or `<name>.bconf`: Bootconfig configuration file.
+- `bootconfigs/<name>.bconf` or `<name>.bconf`: Bootconfig configuration file (default / index 0).
+- `bootconfigs/<name>.<id>.bconf` or `<name>.<id>.bconf`: Named bootconfig configuration file attached with `-i <id>`.
+- `# BOOTCONFIGS: [<id>:]<file> ...` header in script: Explicit list of unnamed or named (`<id>:<file>`) bootconfig files to attach.
 - `cmdlines/<name>.cmdline` or `# CMDLINE: <opts>` header in script: Kernel boot parameters.
 - `qemuopts/<name>.qemuopts` or `# QEMUOPTS: <opts>` header in script: Additional QEMU CLI arguments.
 - `# APPLETS: <applets>` header in script: Additional BusyBox applet symlinks to create in initramfs.
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.bconf
new file mode 100644
index 000000000000..b20e0371d43d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.def_inst {
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.debug.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.debug.bconf
new file mode 100644
index 000000000000..7c6d1aba99d2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.debug.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.dbg_inst {
+	event.sched.sched_wakeup {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.alt.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.alt.bconf
new file mode 100644
index 000000000000..613fb26400bf
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.alt.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.alt_inst {
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.base.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.base.bconf
new file mode 100644
index 000000000000..033aa3676150
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.base.bconf
@@ -0,0 +1,7 @@
+kernel.bconf_test_arg = from_base
+ftrace.instance.base_inst {
+	buffer_size = 512K
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.dbg.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.dbg.bconf
new file mode 100644
index 000000000000..3117e2b1305c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.dbg.bconf
@@ -0,0 +1,7 @@
+kernel.bconf_test_arg := from_dbg
+ftrace.instance.base_inst.buffer_size := 2048K
+ftrace.instance.dbg_inst {
+	event.sched.sched_wakeup {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.bconf
new file mode 100644
index 000000000000..23b54849a151
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.bconf
@@ -0,0 +1,6 @@
+kernel.bconf_append_key = base_val
+ftrace.instance.app_inst {
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.dbg.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.dbg.bconf
new file mode 100644
index 000000000000..6d4b9dfbf4c3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.dbg.bconf
@@ -0,0 +1,6 @@
+kernel.bconf_append_key += dbg_val
+ftrace.instance.app_inst {
+	event.sched.sched_wakeup {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-04-clear.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-04-clear.bconf
new file mode 100644
index 000000000000..78a1304bce05
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-04-clear.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.cleared_inst {
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-05-conflict.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-05-conflict.bconf
new file mode 100644
index 000000000000..7e8bced3c10d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-05-conflict.bconf
@@ -0,0 +1,6 @@
+kernel.bconf_test_arg = conflict_redef
+ftrace.instance.conflict_inst {
+	event.sched.sched_wakeup {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
index 6e8593d5a2c5..7cc0f2da2838 100755
--- a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
+++ b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
@@ -204,6 +204,25 @@ double_timeout() {
 	fi
 }
 
+apply_bootconfig() {
+	local test_name="$1"
+	local initramfs="$2"
+	local b_path="$3"
+	local b_id="${4:-}"
+	local err_out
+
+	if [ -n "$b_id" ]; then
+		err_out="$("$BOOTCONFIG" -i "$b_id" -a "$b_path" "$initramfs" 2>&1)"
+	else
+		err_out="$("$BOOTCONFIG" -a "$b_path" "$initramfs" 2>&1)"
+	fi || {
+		ktap_test_fail "$test_name (failed to apply $(basename "$b_path"))"
+		[ -n "$err_out" ] && ktap_print_msg "$err_out"
+		return 1
+	}
+	return 0
+}
+
 run_single_test() {
 	local test_script="$1"
 	local name
@@ -218,6 +237,19 @@ run_single_test() {
 		bconf_file="$dir/$name.bconf"
 	fi
 
+	local named_bconfs=()
+	local f
+	while IFS= read -r f; do
+		[ -n "$f" ] && named_bconfs+=("$f")
+	done < <(
+		for f in "$SCRIPT_DIR/bootconfigs/$name".*.bconf "$dir/$name".*.bconf; do
+			[ -f "$f" ] && printf '%s\n' "$f"
+		done | LC_ALL=C sort
+	)
+
+	local inline_bconfs
+	inline_bconfs="$(grep -E '^# *BOOTCONFIGS:' "$test_script" | sed 's/^# *BOOTCONFIGS://' | xargs || true)"
+
 	local test_cmdline=""
 	if [ -f "$SCRIPT_DIR/cmdlines/$name.cmdline" ]; then
 		test_cmdline="$(cat "$SCRIPT_DIR/cmdlines/$name.cmdline")"
@@ -299,11 +331,20 @@ mount -t proc proc /proc 2>/dev/null
 mount -t sysfs sys /sys 2>/dev/null
 mount -t tracefs nodev /sys/kernel/tracing 2>/dev/null
 
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null && \
+   ! grep -q "dump_bconf" /bin/check_test.sh 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
+
 /bin/check_test.sh
 RET=$?
 
 if [ $RET -eq 0 ]; then
 	echo "TEST RESULT: PASS"
+elif [ $RET -eq 4 ]; then
+	echo "TEST RESULT: SKIP"
 else
 	echo "TEST RESULT: FAIL"
 fi
@@ -320,13 +361,61 @@ EOF
 	local initramfs="$workdir/initramfs.cpio"
 	(cd "$rootfs" && find . | cpio -o -H newc --quiet) > "$initramfs"
 
-	if [ -n "$bconf_file" ] && [ -f "$bconf_file" ]; then
-		"$BOOTCONFIG" -a "$bconf_file" "$initramfs" > /dev/null
-	fi
+	if [ -n "$inline_bconfs" ]; then
+		local item b_id b_file b_path
+		for item in $inline_bconfs; do
+			case "$item" in
+				*:*)
+					b_id="${item%%:*}"
+					b_file="${item#*:}"
+					;;
+				*)
+					b_id=""
+					b_file="$item"
+					;;
+			esac
+			if [ -f "$SCRIPT_DIR/bootconfigs/$b_file" ]; then
+				b_path="$SCRIPT_DIR/bootconfigs/$b_file"
+			elif [ -f "$dir/$b_file" ]; then
+				b_path="$dir/$b_file"
+			else
+				ktap_test_fail "$name (bootconfig file '$b_file' not found)"
+				rm -rf "$workdir"
+				trap - EXIT
+				return 0
+			fi
+			if ! apply_bootconfig "$name" "$initramfs" "$b_path" "$b_id"; then
+				rm -rf "$workdir"
+				trap - EXIT
+				return 0
+			fi
+		done
+	else
+		if [ -n "$bconf_file" ] && [ -f "$bconf_file" ]; then
+			if ! apply_bootconfig "$name" "$initramfs" "$bconf_file"; then
+				rm -rf "$workdir"
+				trap - EXIT
+				return 0
+			fi
+		fi
 
+		for f in "${named_bconfs[@]}"; do
+			local id
+			id="$(basename "$f" .bconf)"
+			id="${id#"$name".}"
+			if ! apply_bootconfig "$name" "$initramfs" "$f" "$id"; then
+				rm -rf "$workdir"
+				trap - EXIT
+				return 0
+			fi
+		done
+	fi
 
 	local logfile
-	local base_cmdline="bootconfig console=tty0 console=ttyS0 panic=-1"
+	local base_cmdline="console=tty0 console=ttyS0 panic=-1"
+	if ! [[ "$test_cmdline" =~ (^|[[:space:]])bootconfig(=|[[:space:]]|$) ]]; then
+		base_cmdline="bootconfig $base_cmdline"
+	fi
 	if [ -n "$test_cmdline" ]; then
 		base_cmdline="$base_cmdline $test_cmdline"
 	fi
@@ -358,6 +447,8 @@ EOF
 
 	if grep -q "TEST RESULT: PASS" "$logfile"; then
 		ktap_test_pass "$name"
+	elif grep -q "TEST RESULT: SKIP" "$logfile"; then
+		ktap_test_skip "$name"
 	else
 		ktap_test_fail "$name"
 		ktap_print_msg "QEMU Console Output for $name:"
diff --git a/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-01-default.sh b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-01-default.sh
new file mode 100755
index 000000000000..17a03c1bb0b0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-01-default.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check bare bootconfig loads only index 0 (default) when multiple configs exist
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/instances/def_inst" ]; then
+	echo "FAIL: default instance def_inst does not exist"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/instances/def_inst/events/sched/sched_switch/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: def_inst sched_switch is not enabled ($ENABLE)"
+	exit 1
+fi
+
+if [ -d "$TRACEDIR/instances/dbg_inst" ]; then
+	echo "FAIL: unselected instance dbg_inst should not exist"
+	exit 1
+fi
+
+echo "PASS: bconf-multi-01-default"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-02-select.sh b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-02-select.sh
new file mode 100755
index 000000000000..e132d8e617d8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-02-select.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# CMDLINE: bootconfig=base,dbg
+# Check bootconfig=<id1>,<id2> selects and merges configs with := override
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/instances/base_inst" ]; then
+	echo "FAIL: instance base_inst does not exist"
+	exit 1
+fi
+
+if [ ! -d "$TRACEDIR/instances/dbg_inst" ]; then
+	echo "FAIL: instance dbg_inst does not exist"
+	exit 1
+fi
+
+if [ -d "$TRACEDIR/instances/alt_inst" ]; then
+	echo "FAIL: unselected instance alt_inst should not exist"
+	exit 1
+fi
+
+BUF_RAW=$(cat "$TRACEDIR/instances/base_inst/buffer_size_kb")
+case "$BUF_RAW" in
+	*"expanded:"*)
+		BUFSIZE=$(echo "$BUF_RAW" | sed -n 's/.*expanded: *\([0-9]*\).*/\1/p')
+		;;
+	*)
+		BUFSIZE="$BUF_RAW"
+		;;
+esac
+case "$BUFSIZE" in
+	''|*[!0-9]*)
+		echo "FAIL: base_inst buffer_size_kb is non-numeric ('$BUF_RAW')"
+		exit 1
+		;;
+esac
+if [ "$BUFSIZE" -lt 2048 ] || [ "$BUFSIZE" -ge 2100 ]; then
+	echo "FAIL: base_inst buffer_size_kb is '$BUF_RAW', expected ~2048"
+	exit 1
+fi
+
+if ! grep -q 'ftrace.instance.base_inst.buffer_size = "2048K"' /proc/bootconfig; then
+	echo "FAIL: overridden buffer_size not in /proc/bootconfig"
+	exit 1
+fi
+
+if ! grep -q "bconf_test_arg=from_dbg" /proc/cmdline; then
+	echo "FAIL: overridden kernel.bconf_test_arg not in /proc/cmdline"
+	exit 1
+fi
+
+echo "PASS: bconf-multi-02-select"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-03-append.sh b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-03-append.sh
new file mode 100755
index 000000000000..64a687662dca
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-03-append.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# CMDLINE: bootconfig=+dbg
+# Check bootconfig=+id appends onto default (index 0) with += array append
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/instances/app_inst" ]; then
+	echo "FAIL: instance app_inst does not exist"
+	exit 1
+fi
+
+EN1=$(cat "$TRACEDIR/instances/app_inst/events/sched/sched_switch/enable")
+EN2=$(cat "$TRACEDIR/instances/app_inst/events/sched/sched_wakeup/enable")
+if [ "$EN1" != "1" ] || [ "$EN2" != "1" ]; then
+	echo "FAIL: expected both sched_switch ($EN1) and sched_wakeup ($EN2) enabled"
+	exit 1
+fi
+
+if ! grep -q "bconf_append_key=base_val" /proc/cmdline || \
+   ! grep -q "bconf_append_key=dbg_val" /proc/cmdline; then
+	echo "FAIL: appended kernel.bconf_append_key values missing from /proc/cmdline"
+	exit 1
+fi
+
+echo "PASS: bconf-multi-03-append"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-04-clear.sh b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-04-clear.sh
new file mode 100755
index 000000000000..eec9ec1206fc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-04-clear.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# CMDLINE: bootconfig bootconfig=
+# APPLETS: zcat
+# Check explicit empty bootconfig= disables earlier bootconfig selection
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -r /proc/config.gz ] && \
+   zcat /proc/config.gz 2>/dev/null | grep -q '^CONFIG_BOOT_CONFIG_FORCE=y$'; then
+	echo "SKIP: CONFIG_BOOT_CONFIG_FORCE=y forces default bootconfig"
+	exit 4
+fi
+
+if [ -d "$TRACEDIR/instances/cleared_inst" ]; then
+	echo "FAIL: cleared_inst should not exist when bootconfig= clears selection"
+	exit 1
+fi
+
+if [ -n "$(cat /proc/bootconfig)" ]; then
+	echo "FAIL: /proc/bootconfig should be empty"
+	cat /proc/bootconfig
+	exit 1
+fi
+
+echo "PASS: bconf-multi-04-clear"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-05-conflict.sh b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-05-conflict.sh
new file mode 100755
index 000000000000..577575d8c7b7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/bconf-multi-05-conflict.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# BOOTCONFIGS: base:bconf-multi-02-select.base.bconf conflict:bconf-multi-05-conflict.bconf
+# CMDLINE: bootconfig=base,conflict
+# APPLETS: dmesg
+# Check conflicting '=' redefinition across configs reports [idx:id] error
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -d "$TRACEDIR/instances/base_inst" ] || \
+   [ -d "$TRACEDIR/instances/conflict_inst" ]; then
+	echo "FAIL: conflicting bootconfigs should not be applied"
+	exit 1
+fi
+
+if ! dmesg | grep -q 'Failed to parse bootconfig \[1:conflict\]: Value is redefined'; then
+	echo "FAIL: expected [1:conflict] parse error in dmesg"
+	dmesg | grep -i bootconfig
+	exit 1
+fi
+
+echo "PASS: bconf-multi-05-conflict"
+exit 0
-- 
2.43.0

