Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36C3B7B84;
	Tue, 11 Aug 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462491; cv=none; b=OgK+M8G4OZFjxcGNusrYkykVvbWgoUzb0uFanbvqtHMCYgW+1jNbjPPx5Wpr1bQ2HxP195fYnaG+8GBaMveSSIh3bdiuHrkE+eI+4UP3NBaSQ8RXxL+F0ZQG1TXipCHJKJFVYuq+rf8mFqL4S/k/3DJ9T4sZDycY0uhQ+oVUsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462491; c=relaxed/simple;
	bh=h0vdLp3uFjraAj3uw5dvEIszs8OhnYAP5MfYsK7xiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvjD3WVvIYUgq3Dl9r269ThCNDMAPNScQHYrZT8U04cAO+Z0Us5u1KNkbro+Fd3WYLx5M2pm+OkiaClIO1lYJ3mLtxGHGOZOPIDffYCCbA9TT0vQeOm4VTvgze10QDGz1ogwwDRmJ0OtIzd4Btj9tCD8O8tGaTRg1LfhuOM5OR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8QtCneF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8QtCneF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9D1F000E9;
	Tue, 11 Aug 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462490;
	bh=DGeNEk6aokux5UuWFWZuvvQt7PgSt+SrH1jOlLCpTw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8QtCneFK8IgXd1Grd4Dl8598BezJ73JZv5WvXwLB2Y3wP8YYWU+d3q5G7HrTW84r
	 qdVLy3pjl1ksMIiMVMGIKDjgywABd/BVtge7SB9OeAmamNothyfFtjmYQV1ALXY6tc
	 3fJAi6az1tm2fG7YmWpW0MTO1of2XpKuqFGZvjAYbEWW1a2UF0jL2v3qH/C33M+dtw
	 GRlSsRxxqOZnWsAWmoesk3MUsaWE+Pnd3eu2vxw4tiupTbMsUg2toh4Oc60wefrAoZ
	 aCxzWLgUDF/98P3Bc/lYL2mUe2VyV5rV32MInFyXcwKlMbSdOxFzu0761i7P55RVhg
	 PlveRA7n1b9Mw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/4] selftests/ftrace: Add kernel cmdline tracing testcases
Date: Wed, 12 Aug 2026 00:34:46 +0900
Message-ID: <178646248625.428104.6475014420560529192.stgit@devnote2>
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

Add test cases for kernel command-line tracing options. It verifies
various parameters like trace_buf_size and trace_options by reading
the output of tracing files in sysfs.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Fix buffer_size_kb parsing in cmdline-03-trace-buf-size.sh to handle
   unexpanded buffer string output '1 (expanded: 2048)'.
 - Use grep -qw in cmdline-04-trace-options.sh to match word options
   and avoid matching disabled 'no<option>' entries.
---
 .../boottime/cmdlines/cmdline-01-ftrace.cmdline    |    1 +
 .../cmdlines/cmdline-02-trace-event.cmdline        |    1 +
 .../cmdlines/cmdline-03-trace-buf-size.cmdline     |    1 +
 .../cmdlines/cmdline-04-trace-options.cmdline      |    1 +
 .../cmdlines/cmdline-05-trace-clock.cmdline        |    1 +
 .../cmdlines/cmdline-06-trace-instance.cmdline     |    1 +
 .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 ++++++++++++++
 .../boottime/tests/cmdline-02-trace-event.sh       |   26 +++++++++++++++++++
 .../boottime/tests/cmdline-03-trace-buf-size.sh    |   28 ++++++++++++++++++++
 .../boottime/tests/cmdline-04-trace-options.sh     |   23 ++++++++++++++++
 .../boottime/tests/cmdline-05-trace-clock.sh       |   19 ++++++++++++++
 .../boottime/tests/cmdline-06-trace-instance.sh    |   24 +++++++++++++++++
 12 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh

diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
new file mode 100644
index 000000000000..4f6fc54240c8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
@@ -0,0 +1 @@
+ftrace=function
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
new file mode 100644
index 000000000000..66bcd29b14cb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
@@ -0,0 +1 @@
+trace_event=sched:sched_switch,kmem:kmalloc
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
new file mode 100644
index 000000000000..e5d1c4a8ca89
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
@@ -0,0 +1 @@
+trace_buf_size=2048K
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
new file mode 100644
index 000000000000..51d82f8e948d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
@@ -0,0 +1 @@
+trace_options=sym-addr,verbose
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
new file mode 100644
index 000000000000..f72a4ac808a3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
@@ -0,0 +1 @@
+trace_clock=global
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
new file mode 100644
index 000000000000..9618e3e2b88b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
@@ -0,0 +1 @@
+trace_instance=bar,sched:sched_switch
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
new file mode 100644
index 000000000000..23a0b15f2dd3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check ftrace= kernel command-line tracer setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -f "$TRACEDIR/current_tracer" ]; then
+	echo "FAIL: current_tracer does not exist"
+	exit 1
+fi
+
+read -r TRACER _ < "$TRACEDIR/current_tracer"
+if [ "$TRACER" != "function" ]; then
+	echo "FAIL: current_tracer is '$TRACER', expected 'function'"
+	exit 1
+fi
+
+echo "PASS: cmdline-01-ftrace"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
new file mode 100644
index 000000000000..b793907c48cd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_event= kernel command-line setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/events/sched/sched_switch" ]; then
+	echo "FAIL: event sched:sched_switch does not exist"
+	exit 1
+fi
+
+if [ ! -d "$TRACEDIR/events/kmem/kmalloc" ]; then
+	echo "FAIL: event kmem:kmalloc does not exist"
+	exit 1
+fi
+
+ENABLE1=$(cat "$TRACEDIR/events/sched/sched_switch/enable")
+ENABLE2=$(cat "$TRACEDIR/events/kmem/kmalloc/enable")
+
+if [ "$ENABLE1" != "1" ] || [ "$ENABLE2" != "1" ]; then
+	echo "FAIL: events not enabled (sched_switch=$ENABLE1, kmalloc=$ENABLE2)"
+	exit 1
+fi
+
+echo "PASS: cmdline-02-trace-event"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
new file mode 100644
index 000000000000..2eab5fb487a3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_buf_size= kernel command-line setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -f "$TRACEDIR/buffer_size_kb" ]; then
+	echo "FAIL: buffer_size_kb does not exist"
+	exit 1
+fi
+
+BUF_RAW=$(cat "$TRACEDIR/buffer_size_kb")
+case "$BUF_RAW" in
+	*"expanded:"*)
+		BUFSIZE=$(echo "$BUF_RAW" | sed -n 's/.*expanded: *\([0-9]*\).*/\1/p')
+		;;
+	*)
+		BUFSIZE=$(echo "$BUF_RAW" | awk '{print $1}')
+		;;
+esac
+
+if [ -z "$BUFSIZE" ] || [ "$BUFSIZE" -lt 2048 ]; then
+	echo "FAIL: buffer_size_kb is '$BUF_RAW', expected >= 2048"
+	exit 1
+fi
+
+echo "PASS: cmdline-03-trace-buf-size"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
new file mode 100644
index 000000000000..53a65b55f7a7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_options= kernel command-line setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -f "$TRACEDIR/trace_options" ]; then
+	echo "FAIL: trace_options file does not exist"
+	exit 1
+fi
+
+if ! grep -qw "sym-addr" "$TRACEDIR/trace_options"; then
+	echo "FAIL: sym-addr option is not set in trace_options"
+	exit 1
+fi
+
+if ! grep -qw "verbose" "$TRACEDIR/trace_options"; then
+	echo "FAIL: verbose option is not set in trace_options"
+	exit 1
+fi
+
+echo "PASS: cmdline-04-trace-options"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
new file mode 100644
index 000000000000..d6de9f6e2090
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_clock= kernel command-line setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -f "$TRACEDIR/trace_clock" ]; then
+	echo "FAIL: trace_clock file does not exist"
+	exit 1
+fi
+
+if ! grep -q '\[global\]' "$TRACEDIR/trace_clock"; then
+	CLOCK=$(cat "$TRACEDIR/trace_clock")
+	echo "FAIL: trace_clock is not set to global ($CLOCK)"
+	exit 1
+fi
+
+echo "PASS: cmdline-05-trace-clock"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
new file mode 100644
index 000000000000..aae7f0a86d81
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_instance= kernel command-line setting
+TRACEDIR="/sys/kernel/tracing"
+
+if [ ! -d "$TRACEDIR/instances/bar" ]; then
+	echo "FAIL: trace instance bar does not exist"
+	exit 1
+fi
+
+if [ ! -d "$TRACEDIR/instances/bar/events/sched/sched_switch" ]; then
+	echo "FAIL: event sched_switch does not exist in instance bar"
+	exit 1
+fi
+
+ENABLE=$(cat "$TRACEDIR/instances/bar/events/sched/sched_switch/enable")
+if [ "$ENABLE" != "1" ]; then
+	echo "FAIL: event sched_switch is not enabled in instance bar ($ENABLE)"
+	exit 1
+fi
+
+echo "PASS: cmdline-06-trace-instance"
+exit 0

