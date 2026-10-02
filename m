Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9646E007;
	Fri,  2 Oct 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949758; cv=none; b=f58brOT4gG6xl/hq1dcePVJQwJNaiKhNy0Ree9rGSx1OM/6xLjrJqCBzv3MCFKbJGzkERJgh4LoDFJpzUjXxppS8cMgpbGm5q2TMGS+LasA0iGzCx8gtHsfgWDmuavXMErXU5iyzie9ZYw8+IK8YoKXtyE9lJfO38/VlXr0ALzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949758; c=relaxed/simple;
	bh=W5dAhDEtmMtVVSaIvKnT2LgLJqc/CcbUxG6q+WTHIQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUoWn8rdFMnOHIBpyYo0rBLz9+bIZLwM6w5XwhVwDiivKU+QKNVzo7Ho2jndPP3egSwSTep/8lg4IbxkdqyazGlDaiK6PajAa31P30FYNb7vGMon3p5WkCNSvgQdp9HoD1oSuOl8OCmQOahJQX4SUdcSIWZUE1uT5qQdRwCTnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKKizei0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKKizei0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892231F00898;
	Fri,  2 Oct 2026 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949756;
	bh=XKEFP5bYfn1KrlzLnxZ61iwyI5TCKxS6l5WDp28/Hc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKKizei09Jx778cqzBwSFbjojNNHOyUG4BkVjsElmVNuRJ0jlzrnV4tTk2sMpC695
	 /SydW4Wzbgo30Nr0kmFNGxJ6gY/7+/XT2KgsGpc8AGvtKA9N6zNDHpadqjeFbWzBRw
	 V2iRMrLIGmlRsG6ji11287N5cgLi9ZNCcEDivWHZnGSkGNyYgneG8+hwznsVD7k1iF
	 iLSqeDHN6C+ROeg+B0gb+coleP2VleR+YBI0edySdiS6H89SAjyRoMUna6LGNRZtxI
	 Sw/g5BErMmB4rPWNWFzlfA4/54jcXeJZbame3dAL23sCWq9df3tRgGSAWz3dA+bLIn
	 UZ6VZy0E5IDaQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/ftrace: Add test case for overriding trace_instance parameter
Date: Fri,  2 Oct 2026 23:02:32 +0900
Message-ID: <179094975229.609715.3664484413379599809.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179094973121.609715.2103310055830923648.stgit@devnote2>
References: <179094973121.609715.2103310055830923648.stgit@devnote2>
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

Add a boot-time tracing test case to verify that specifying multiple
trace_instance= parameters with the same instance name overrides earlier
definitions:

   - Verifies that a kernel command-line trace_instance= parameter
     overrides an earlier trace instance defined via bootconfig
     (kernel.trace_instance).
   - Verifies that a later kernel command-line trace_instance=
     parameter overrides an earlier trace_instance= on the same
     command line.
   - Verifies overriding a memory-mapped trace instance (@trace).
   - Verifies overriding a backup trace instance (=source).
   - Verifies parsing parameters containing multiple tabs and
     gracefully handling empty strings.
   - Confirms that the overridden instance has its previous events
     disabled, new events enabled, and flags (such as traceoff)
     properly applied.

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Add test cases for overriding memory-mapped instances (@trace).
 - Add test cases for overriding backup instances.
 - Add test cases for multiple tabs and empty strings.
 - Add dmesg and basename to required busybox applets.
---
 .../cmdline-07-trace-instance-override.bconf       |    4 +
 .../cmdline-07-trace-instance-override.cmdline     |    1 
 .../selftests/ftrace/boottime/run_boottime_test.sh |    2 
 .../tests/cmdline-07-trace-instance-override.sh    |  148 ++++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh

diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
new file mode 100644
index 000000000000..74d8be54a798
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
@@ -0,0 +1,4 @@
+kernel.trace_instance = "boot_map@trace,sched:sched_switch",
+			"bak_to_norm=boot_map",
+			"bak_from_norm,sched:sched_switch",
+			"foo,sched:sched_switch"
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
new file mode 100644
index 000000000000..3c16bb0f3545
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
@@ -0,0 +1 @@
+reserve_mem=12M:32M:trace trace_instance=foo^traceoff,sched:sched_waking trace_instance=bar,sched:sched_switch trace_instance=bar^traceoff,irq:irq_handler_entry trace_instance=boot_map^traceoff@trace,sched:sched_waking trace_instance=bak_to_norm^traceoff,irq:irq_handler_entry trace_instance=bak_from_norm=boot_map trace_instance="tab1,sched:sched_switch		tab2,sched:sched_switch" trace_instance=tab1^traceoff,sched:sched_waking trace_instance= trace_instance="" trace_instance=,
diff --git a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
index 6e8593d5a2c5..1d30adc388a6 100755
--- a/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
+++ b/tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
@@ -46,6 +46,8 @@ BUSYBOX_APPLETS=(
 	grep
 	sleep
 	sed
+	dmesg
+	basename
 )
 
 usage() {
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh
new file mode 100755
index 000000000000..960a3cf54d97
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_instance= override with bootconfig and kernel command-line
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && \
+   grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
+
+check_instance() {
+	instance="$1"
+	old_event="$2"
+	new_event="$3"
+
+	if [ ! -d "$TRACEDIR/instances/$instance" ]; then
+		echo "FAIL: trace instance $instance does not exist"
+		exit 1
+	fi
+
+	if [ -n "$old_event" ] && \
+	   [ -f "$TRACEDIR/instances/$instance/events/$old_event/enable" ]; then
+		ENABLE=$(cat "$TRACEDIR/instances/$instance/events/$old_event/enable")
+		if [ "$ENABLE" = "1" ]; then
+			echo "FAIL: overridden event $old_event" \
+				"is still enabled in instance $instance"
+			exit 1
+		fi
+	fi
+
+	if [ -n "$new_event" ]; then
+		if [ ! -d "$TRACEDIR/instances/$instance/events/$new_event" ]; then
+			echo "FAIL: event $new_event does not exist in instance $instance"
+			exit 1
+		fi
+
+		ENABLE=$(cat "$TRACEDIR/instances/$instance/events/$new_event/enable")
+		if [ "$ENABLE" != "1" ]; then
+			echo "FAIL: event $new_event is not enabled in instance $instance ($ENABLE)"
+			exit 1
+		fi
+	fi
+
+	TRACING_ON=$(cat "$TRACEDIR/instances/$instance/tracing_on")
+	if [ "$TRACING_ON" != "0" ]; then
+		echo "FAIL: tracing_on is not 0 in instance $instance ($TRACING_ON)"
+		exit 1
+	fi
+}
+
+check_backup_instance() {
+	instance="$1"
+
+	if [ ! -d "$TRACEDIR/instances/$instance" ]; then
+		echo "FAIL: trace instance $instance does not exist"
+		exit 1
+	fi
+
+	# Backup instances have a trace buffer file
+	if [ ! -f "$TRACEDIR/instances/$instance/trace" ]; then
+		echo "FAIL: backup instance $instance has no trace file"
+		exit 1
+	fi
+
+	# Backup instances are read-only and do not have tracing_on
+	if [ -f "$TRACEDIR/instances/$instance/tracing_on" ]; then
+		echo "FAIL: backup instance $instance unexpectedly has tracing_on"
+		exit 1
+	fi
+
+	# Backup instances do not support enabling events
+	if [ -f \
+	   "$TRACEDIR/instances/$instance/events/sched/sched_switch/enable" ]; then
+		echo "FAIL: backup instance $instance unexpectedly has enabled events"
+		exit 1
+	fi
+}
+
+check_mapped_instance() {
+	instance="$1"
+	old_event="$2"
+	new_event="$3"
+
+	check_instance "$instance" "$old_event" "$new_event"
+
+	# Check dmesg to confirm physical mapping occurred
+	if ! dmesg | grep -q "mapped boot instance $instance"; then
+		echo "FAIL: memory-mapped instance $instance was not mapped at boot"
+		exit 1
+	fi
+}
+
+# Test 1: bootconfig trace_instance overridden by cmdline parameter
+check_instance "foo" "sched/sched_switch" "sched/sched_waking"
+
+# Test 2: cmdline trace_instance overridden by subsequent cmdline parameter
+check_instance "bar" "sched/sched_switch" "irq/irq_handler_entry"
+
+# Test 3: memory-mapped (@trace) instance in bootconfig overridden by cmdline
+check_mapped_instance "boot_map" "sched/sched_switch" "sched/sched_waking"
+
+# Test 4a: backup instance in bootconfig overridden by normal
+# instance in cmdline
+check_instance "bak_to_norm" "" "irq/irq_handler_entry"
+
+# Test 4b: normal instance in bootconfig overridden by backup
+# instance in cmdline
+check_backup_instance "bak_from_norm"
+
+# Test 5: instances separated by multiple tabs, where first is overridden
+check_instance "tab1" "sched/sched_switch" "sched/sched_waking"
+# tab2 was not overridden, so its original event should remain enabled
+if [ ! -d "$TRACEDIR/instances/tab2/events/sched/sched_switch" ]; then
+	echo "FAIL: instance tab2 event sched/sched_switch does not exist"
+	exit 1
+fi
+ENABLE=$(cat "$TRACEDIR/instances/tab2/events/sched/sched_switch/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: instance tab2 event sched/sched_switch is not enabled ($ENABLE)"
+	exit 1
+fi
+
+# Test 6: Verify empty strings and malformed entries did not create
+# bogus directories
+for dir in "$TRACEDIR/instances"/*; do
+	[ -d "$dir" ] || continue
+	bname=$(basename "$dir")
+	case "$bname" in
+		foo|bar|boot_map|bak_to_norm|bak_from_norm|tab1|tab2)
+			;;
+		*)
+			echo "FAIL: unexpected trace instance directory found: $bname"
+			exit 1
+			;;
+	esac
+done
+
+# Test 7: Verify no kernel warnings or assertion failures were triggered
+if dmesg | grep -q "WARNING: CPU:"; then
+	echo "FAIL: kernel warning triggered during boot"
+	exit 1
+fi
+
+echo "PASS: cmdline-07-trace-instance-override"
+exit 0

