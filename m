Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2B29993F;
	Mon, 10 Aug 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354458; cv=none; b=QSQnV+sbe4iR3naaAfWr4h4MBIED+y9zl54ekNL6086BvS1Ak6rcqMC5S5w4qVqia/WbHUzxw72IojMSXuTbP+eghxENUHxc4Syy6spU9OmnhGa9t35J+tO83FDKlnW3dBBZEFQMsdTSk6h4h7vfd53hZyiivLuuS7de8i+sQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354458; c=relaxed/simple;
	bh=bKmLfdu9nV38vi7SWsWQAzAnYK+q++UQcRlFl2A3Tt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fri8qWDPK7LdlyeaSs9+QjXCJvHSkR8xCVvXChwkV/OX6zA4R6HbIRitP7e99LAAfMQ8sdAFZ5xVqDMSXNbSRqDSo9J1VcRczt9v2ZHZmZnO8bS7cwNFs8gTXaUaBBPW3vYkPXbd60sLguiitiAywaDEPsHV/aspCLg3SpUwisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy7xMOAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy7xMOAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524FE1F000E9;
	Mon, 10 Aug 2026 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354456;
	bh=GK9pyR6T2P4DM5Pb4s9UsojrvLjENMK3gDEyj5gtWDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gy7xMOALUvLnJMVGW/AbLdNjxHGLndzZihA5awK7W40oaEOZfzBD9bisKSJK8QxWS
	 A6YyT3ULnHHZaOFXsztXF5VJi5+wXSckegfFBYzZoKhjsMyAcrFx/ahbuhOHody6Jf
	 7C3sYwEkv3I1f/HO77YdTyO8MRVCG6xjsprt3BWlFc/jwVFqG/UIi90DwIXjlKBW58
	 xq+EaKuOn7PcO9Pas7ZAZupFpcoLSzWJsl+g+J5KumNpdn61Ti8EUI1KN1BrxEFz6T
	 zU5q6iF72oWaI02HBdhTMcaE/XRbNUuwxFlpkkhEpM12ZNkrkmVO0WDdpbvmwA6BVI
	 tl6owTF57751A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 3/4] selftests/ftrace: Add kernel cmdline tracing testcases
Date: Mon, 10 Aug 2026 18:34:13 +0900
Message-ID: <178635445318.380779.17618494362731257097.stgit@devnote2>
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

Add test cases for kernel command-line tracing options
(see Documentation/admin-guide/kernel-parameters.txt).

These test cases verify:
 - cmdline-01-ftrace: ftrace=[tracer] parameter
 - cmdline-02-trace-event: trace_event=[event1,event2,...] parameter
 - cmdline-03-trace-buf-size: trace_buf_size=NNK parameter
 - cmdline-04-trace-options: trace_options=[option1,option2,...] parameter
 - cmdline-05-trace-clock: trace_clock=[clock] parameter
 - cmdline-06-trace-instance: trace_instance=[instance-info] parameter

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../boottime/cmdlines/cmdline-01-ftrace.cmdline    |    1 +
 .../cmdlines/cmdline-02-trace-event.cmdline        |    1 +
 .../cmdlines/cmdline-03-trace-buf-size.cmdline     |    1 +
 .../cmdlines/cmdline-04-trace-options.cmdline      |    1 +
 .../cmdlines/cmdline-05-trace-clock.cmdline        |    1 +
 .../cmdlines/cmdline-06-trace-instance.cmdline     |    1 +
 .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 +++++++++++++++
 .../boottime/tests/cmdline-02-trace-event.sh       |   26 ++++++++++++++++++++
 .../boottime/tests/cmdline-03-trace-buf-size.sh    |   19 +++++++++++++++
 .../boottime/tests/cmdline-04-trace-options.sh     |   23 ++++++++++++++++++
 .../boottime/tests/cmdline-05-trace-clock.sh       |   19 +++++++++++++++
 .../boottime/tests/cmdline-06-trace-instance.sh    |   24 ++++++++++++++++++
 12 files changed, 136 insertions(+)
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
index 000000000000..c4deb6dc2d9b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
@@ -0,0 +1,19 @@
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
+BUFSIZE=$(cat "$TRACEDIR/buffer_size_kb")
+if [ "$BUFSIZE" -lt 2048 ]; then
+	echo "FAIL: buffer_size_kb is $BUFSIZE, expected >= 2048"
+	exit 1
+fi
+
+echo "PASS: cmdline-03-trace-buf-size"
+exit 0
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
new file mode 100644
index 000000000000..98ada8d245da
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
+if ! grep -q "sym-addr" "$TRACEDIR/trace_options"; then
+	echo "FAIL: sym-addr option is not set in trace_options"
+	exit 1
+fi
+
+if ! grep -q "verbose" "$TRACEDIR/trace_options"; then
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

