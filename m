Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE23B19D1;
	Tue, 11 Aug 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462482; cv=none; b=sRu4j4gEA6QWPKa5wHHkWgEuTWdm7fyijoQVtAk9dqDYQAVORpcSs6Rno51zDlbzQm/ZJ+ybmmIRsbFtr4MeHLwCE+p6LolmZuAZ1ogySPDS77DVeVJ/vk2d3zV4EC0FTlg+JaUtRYeeP6UWzZoCfkyAMtEKSOTv314pSHG15Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462482; c=relaxed/simple;
	bh=s9W90EukrfC9rhIckxKAWYAjrTJKR308zNW6FQCO9KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyYgm2C9bPaEPzkHk85jqZvJRaVdgjhy/ksezndlYt0BZtRBDIlMzeQHxTAvacII2j53995OP3jVn0OvnKo7rRkl8KmwhIWlk6XbvzGdQKU+JMnE60FfNWKv9w4s3gnaKIckHs20K1XOApXQFD2E8xYdBGcZU4XUs384CCIw7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLwvwgid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLwvwgid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D12B1F000E9;
	Tue, 11 Aug 2026 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462480;
	bh=8rhLh4T/FGEzcoW4SaLoVPimMTJUUICBdRkRnALrYRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLwvwgidfKgMh71OKvBNOzMFLPRhw4BO+sBEifCAgdOTbhSpmNkEX8Wmb/ikmWeO8
	 bEXbMaZDBBRKeS7yeoRrqS0V+sUVm58XfxqA39ZQgCFPCIuma2JnBGVQ9P5nyxfvFl
	 Ppr9qnYQkFfGv5corJa24xNAIMLxZT56+qaHZG/79bPuT55p+1mHf/9gSnFCIzubf8
	 OS1ZBvFVKuAUsTFZXiN907XAiYQ5T3wWY9tjImDfTF2ppLG016HA59P0P48bSpO/Hk
	 FbKmN+FkCmMQFmqw6//bv86weK1fhpjQXlGxbz5Rh/nbzrxS8n6OG6Do6jMhkIF8vx
	 aSxUSnvNIa9mg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/ftrace: Add boot-time tracing testcases
Date: Wed, 12 Aug 2026 00:34:36 +0900
Message-ID: <178646247685.428104.10393955447718273712.stgit@devnote2>
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

Add test cases for boot-time tracing configuration via bootconfig
(see Documentation/trace/boottime-trace.rst).

These test cases verify:
 - 01-kprobe: Dynamic kprobe events via bootconfig
 - 02-synth: Synthetic events via bootconfig
 - 03-eprobe: Event probes (eprobes) via bootconfig
 - 04-fprobe: Function probes (fprobes) via bootconfig
 - 05-tprobe: Tracepoint probes via bootconfig
 - 06-instance: Custom trace instances via bootconfig

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    4 +++
 .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 +++
 .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 +++
 .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 +++
 .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 +++
 .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 +++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   25 +++++++++++++++++
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   25 +++++++++++++++++
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   25 +++++++++++++++++
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   25 +++++++++++++++++
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   25 +++++++++++++++++
 .../selftests/ftrace/boottime/tests/06-instance.sh |   30 ++++++++++++++++++++
 12 files changed, 180 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/06-instance.sh

diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
new file mode 100644
index 000000000000..13d30d1e51a6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
@@ -0,0 +1,4 @@
+ftrace.event.kprobes.vfs_read {
+	probes = "vfs_read $arg1"
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
index 000000000000..c1a8138e605d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
@@ -0,0 +1,4 @@
+ftrace.event.eprobes.ep_read {
+	probes = "sched/sched_switch"
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
index 000000000000..3fdb6717afe2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
@@ -0,0 +1,5 @@
+ftrace.instance.foo {
+	event.sched.sched_switch {
+		enable
+	}
+}
diff --git a/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh b/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
new file mode 100644
index 000000000000..6ed7caca4c5f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check kprobe bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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
new file mode 100644
index 000000000000..745c328dde15
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check synthetic event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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
new file mode 100644
index 000000000000..9b3b7ab23c69
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check eprobe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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
new file mode 100644
index 000000000000..27e090c28a4b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check fprobe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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
new file mode 100644
index 000000000000..810d34055f94
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check tracepoint probe event bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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
new file mode 100644
index 000000000000..f6e8519912e4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/06-instance.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check instance bootconfig settings on tracefs
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
+	echo "=== /proc/bootconfig ==="
+	cat /proc/bootconfig
+	echo "========================"
+fi
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

