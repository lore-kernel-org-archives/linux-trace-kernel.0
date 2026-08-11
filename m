Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130F3B7759;
	Tue, 11 Aug 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462501; cv=none; b=YUEQKX10nxUQUe2qAnJykwZPi4HKgB4WZci0xF7QEpEmuwgxNHRGOKDqXcmEpSRKcgBQEumFEy65YcPLfUWvu2MBfwbLEXImXo5l2sG4klES27sEQ4nZhJcE2iDbQ4YpVL7FCBgEw+5NuCC9XQVmKihe377P2UgQaD8cxlF2MnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462501; c=relaxed/simple;
	bh=oj155J8WdN24CH7OTppEnli8Za/z6mHS1JU++3ERia4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twZev9894hdAUcn7AryqT+LaH97dyAiG5u8NGew3WqyauOP/cyupdMxK9jRqA5Rb+EPBDIK1xNvtd+CRT7Y56UHtTb1N503/z9INU5M3QhKNntRllSzz7HP+VijNmfAboByfIxCAPXK1z9uum66OpkPkkPRWP3DnSAAJq4uQ+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUsMJZiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUsMJZiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6161F000E9;
	Tue, 11 Aug 2026 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462499;
	bh=bCWjy227zq95PX7LUF27D+H8lsveDD20rzvQ0kh5R1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUsMJZivMrh6CNq1NI/ITkBkhJPHCP2CveytBJ4qV32f128e9SvaL3IEAbEOaIyhZ
	 PG+qJsOSjcDTxOINcnQA6Qwm801fYbcvR2y+946KzrZpVNO6i4oK5zBCEQdrwpxBzB
	 mZEObRslCXaHf02Ciaz7VeAy9u4Wz7+2dTZxrFkt+QRTW23RJUuJ/LAibEPnwQepLU
	 6Gmoy0SSa2HzXrVeG7RZVjMri3yBw6Ile4Pgi8nCjKCTVxP7int8jr7Q8ts8wMdLtU
	 KqVEvVfiYu7tPymmbHoCBt971RZ42eWiVcw7IGqq4O91vJ9XAf346fDHntxzLalIIu
	 l7t3a755u2TAQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/4] selftests/ftrace: Add persistent ring buffer testcases
Date: Wed, 12 Aug 2026 00:34:55 +0900
Message-ID: <178646249546.428104.2188701493913076577.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178646245730.428104.4400499381224001727.stgit@devnote2>
References: <178646245730.428104.4400499381224001727.stgit@devnote2>
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

Add test cases for persistent ring buffer (reserve_mem= combined
with trace_instance=) and backup instance (trace_instance=backup=boot_map).

These test cases verify:
 - persistent-01-reserve-mem: Memory reservation via reserve_mem=
   and trace_instance=boot_map@trace. Verifies trace data retention in
   the boot_map instance across guest crash/reboot via sysrq-trigger.
 - persistent-02-backup-instance: Backup instance creation via
   trace_instance=backup=boot_map. Verifies that previous boot trace
   log is preserved in the backup instance on the subsequent boot.

These test cases specify '# REBOOT: 1' to enable multi-boot guest
crash/reboot testing with doubled QEMU timeout.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Increase reserve_mem alignment to 32M (reserve_mem=12M:32M:trace) to
   ensure stable physical memory placement across KASLR reboots.
---
 .../cmdlines/persistent-01-reserve-mem.cmdline     |    1 +
 .../cmdlines/persistent-02-backup-instance.cmdline |    1 +
 .../boottime/tests/persistent-01-reserve-mem.sh    |   28 ++++++++++++++
 .../tests/persistent-02-backup-instance.sh         |   40 ++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh

diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
new file mode 100644
index 000000000000..c69eeb27deb6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
@@ -0,0 +1 @@
+reserve_mem=12M:32M:trace trace_instance=boot_map@trace
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
new file mode 100644
index 000000000000..43217c986ca1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
@@ -0,0 +1 @@
+reserve_mem=12M:32M:trace trace_instance=boot_map@trace trace_instance=backup=boot_map
diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh b/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
new file mode 100644
index 000000000000..49abaf518481
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check persistent ring buffer across guest crash/reboot
+# REBOOT: 1
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -f "$TRACEDIR/instances/boot_map/trace" ]; then
+	echo "FAIL: persistent trace instance boot_map/trace file missing"
+	exit 1
+fi
+
+# Check if Boot 1 marker was already written
+if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/null; then
+	# Second boot: verify persistent ring buffer content from first boot
+	echo "PASS: persistent-01-reserve-mem"
+	exit 0
+fi
+
+# First boot: write marker to persistent buffer and trigger kernel crash/reboot
+echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
+sync
+
+# Trigger reboot to restart into second boot
+echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger 2>/dev/null || true
+sleep 5
+echo "FAIL: reboot trigger failed on first boot"
+exit 1
diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh
new file mode 100644
index 000000000000..0b2a2f03ce4f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check persistent backup instance across guest crash/reboot
+# REBOOT: 1
+TRACEDIR="/sys/kernel/tracing"
+
+# Ensure both boot_map/trace and backup/trace files exist
+if [ ! -f "$TRACEDIR/instances/boot_map/trace" ]; then
+	echo "FAIL: boot_map/trace file missing"
+	exit 1
+fi
+
+if [ ! -f "$TRACEDIR/instances/backup/trace" ]; then
+	echo "FAIL: backup/trace file missing"
+	exit 1
+fi
+
+# Check if BOOT1_MARKER is in boot_map/trace (indicates second boot)
+if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/null; then
+	# Second boot: verify BOOT1_MARKER was copied into backup/trace from Boot 1
+	if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/backup/trace" 2>/dev/null; then
+		echo "PASS: persistent-02-backup-instance"
+		exit 0
+	else
+		echo "FAIL: BOOT1_MARKER found in boot_map/trace" \
+			"but missing from backup/trace on second boot"
+		exit 1
+	fi
+fi
+
+# First boot: write BOOT1_MARKER to boot_map and reboot via sysrq-trigger
+echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
+sync
+
+# Trigger reboot to restart into second boot
+echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger 2>/dev/null || true
+sleep 5
+echo "FAIL: reboot trigger failed on first boot"
+exit 1

