Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855C3B059B;
	Mon, 10 Aug 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354467; cv=none; b=UTwdZW6w9/nORagl1wnH3BVLt/BBOoFcDIfjhvQ8mG88v3LmipyRZbLw7rRulZurjG3p447nJ6zsJ9NvL7AuFAnHXdahg6yt/TJquq9ofDUERYJGvz7klDbnDe8DeoA4q5anIZV08m8zCgLw51veQl7Xs/9fXfxwZVIe1ye2D+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354467; c=relaxed/simple;
	bh=4Td346V3shBa3kOWp1otXBoWThjpSdm7oxq/5NBr/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg5aZ/aQDXkU66PanhMAMVfyT15CjTHQn9XJcU3dDVEUdksE4HpXjaYoEYHTgo5wJ2Eg+y7E1yyevOXbtGmRNX/WD+1WW3nZ3597Hmcr6jyWiK67UXQoY2bO/xmOgozC8Roa7avlPinq/m7AHxIa0vTvu0kQMcXPXJzHUSGyda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm64ts59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm64ts59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873561F00A3F;
	Mon, 10 Aug 2026 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354466;
	bh=HMP5x8PR0FQvUstRmPCUdayJeVK0ap+mE6zOOfJTCBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mm64ts59q7wdRmyq+c3e44ucdSKy/IeXqwbj1Vk5w4NJu5hYonTqymFtyDabogY7K
	 kJWB7pn4yhHlfSMByT49CGdmBv8OB2ldL/PCnNzTek4BtYM4UZm5/p4woKs0RSTsWO
	 GO1j+wmITVGfz8KUDsw3SqkQ1wVOIfrbKsSlnkMWRpA6Gx+tRDVaIr+ajhU+b7lsSB
	 w8isp8JbBec2R6pVcVT9Em/EMdx0kdIQNp7MunbiDiFzQZ6Dgt7FYQXCm0Zs7rfXto
	 ElBFjyCKGbui2bkB9Tb9eW3bwmbo+W9IEsoU5xP7qQMXGc1OthbtQKwcJYahaVWttj
	 aAXgYCgrlXcCQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 4/4] selftests/ftrace: Add persistent ring buffer testcases
Date: Mon, 10 Aug 2026 18:34:22 +0900
Message-ID: <178635446219.380779.14935908214040944426.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178635442508.380779.3709136256425432083.stgit@devnote2>
References: <178635442508.380779.3709136256425432083.stgit@devnote2>
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
index 000000000000..58e53f7edcd4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
@@ -0,0 +1 @@
+reserve_mem=12M:4096:trace trace_instance=boot_map@trace
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
new file mode 100644
index 000000000000..7b0713f550f8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
@@ -0,0 +1 @@
+reserve_mem=12M:4096:trace trace_instance=boot_map@trace trace_instance=backup=boot_map
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

