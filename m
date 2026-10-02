Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30649361DA6;
	Fri,  2 Oct 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919874; cv=none; b=kbmcjxlOc5aI/CEefhR+VsYLmNxSzT4CZMqDxbOqisSzk6HwiAPpCeg7MDava0qG/7PCGGDZDxjRhRCQHfTyvabUX1ouEBO/i8QVIKfOpNSDYkocG7szqT1z6oTAEQvWBtKYpLFcmzOYRx8pCCmr1ZWPR9VFGiCm9r5fiI/hmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919874; c=relaxed/simple;
	bh=0sTUHdTBguf9D+ODJqdIL5b6eL2ZzSqEDwWf8Ns29CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAc2H15r1WWw8VHeWaTO+sR+1Pp4nQpnvu1ODnLR52wQfwoBLNLWwTbT4K5JD4RhA5gPXJWpFUMXoODcx7b24jLe4MAqSirf4BZDiC8SlOpB5bjUHl8tInf2o1bnZuJXU9c8d7t7ozVerZn9l3IO/WQEfGzD//DGB0pPG+mPE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0vj/5D1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0vj/5D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992551F000FF;
	Fri,  2 Oct 2026 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790919872;
	bh=b7dMkdKwVdOPUbRXbSR/ZpGWRKdnGU2o7/s4+tCrt7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P0vj/5D1RCIJuoflO9M9xLdRrYHN2zuQaGLnfcHbfjSpKWdYYaBSLA1Vn4m9FpJhD
	 ZARP/MSoNzzOmoOgZHQS8Lsti0/NktOo8bTyRriBT+imeP0XCjBOIBYvICEqUpVcqn
	 LUGmNWeTLBNc9o54aYOI1dvotckHEyi/GaSHeSCSN39HVU5DCvLHn/GerjqoIJxW1W
	 ACzssEsVnijo7krljqe4wrbIp7bqAeuyeofH1TUf5lL6+VP3reCvlFFvcl9UWeFEdm
	 4GMdaW4bvjw/tvzI9gHcp7cPPTkRw8qHS7j0LmgUa1D4eHFTmUghSAc01/L0tyTmpc
	 peMvXa1psKFjA==
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
Subject: [PATCH v2 2/2] selftests/ftrace: Add test case for overriding trace_instance parameter
Date: Fri,  2 Oct 2026 14:44:28 +0900
Message-ID: <179091986836.537422.14557907623051321426.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179091984881.537422.15308457677039592540.stgit@devnote2>
References: <179091984881.537422.15308457677039592540.stgit@devnote2>
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
   - Verifies that a latter kernel command-line trace_instance=
     parameter overrides an earlier trace_instance= on the same
     command line.
   - Confirms that the overridden instance has its previous events
     disabled, new events enabled, and flags (such as traceoff)
     properly applied.

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../cmdline-07-trace-instance-override.bconf       |    2 +
 .../cmdline-07-trace-instance-override.cmdline     |    1 
 .../tests/cmdline-07-trace-instance-override.sh    |   56 ++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh

diff --git a/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf b/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
new file mode 100644
index 000000000000..2551da39f722
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
@@ -0,0 +1,2 @@
+kernel.trace_instance = "foo,sched:sched_switch"
+
diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
new file mode 100644
index 000000000000..1953eb5d6f80
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
@@ -0,0 +1 @@
+trace_instance=foo^traceoff,sched:sched_waking trace_instance=bar,sched:sched_switch trace_instance=bar^traceoff,irq:irq_handler_entry
diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh
new file mode 100644
index 000000000000..a13b7deb6735
--- /dev/null
+++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026, Google LLC.
+# Check trace_instance= override with bootconfig and kernel command-line
+TRACEDIR="/sys/kernel/tracing"
+
+if [ -f /proc/bootconfig ] && grep -q "dump_bconf" /proc/cmdline 2>/dev/null; then
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
+	if [ -f "$TRACEDIR/instances/$instance/events/$old_event/enable" ]; then
+		ENABLE=$(cat "$TRACEDIR/instances/$instance/events/$old_event/enable")
+		if [ "$ENABLE" = "1" ]; then
+			echo "FAIL: overridden event $old_event is still enabled in instance $instance"
+			exit 1
+		fi
+	fi
+
+	if [ ! -d "$TRACEDIR/instances/$instance/events/$new_event" ]; then
+		echo "FAIL: event $new_event does not exist in instance $instance"
+		exit 1
+	fi
+
+	ENABLE=$(cat "$TRACEDIR/instances/$instance/events/$new_event/enable")
+	if [ "$ENABLE" != "1" ]; then
+		echo "FAIL: event $new_event is not enabled in instance $instance ($ENABLE)"
+		exit 1
+	fi
+
+	TRACING_ON=$(cat "$TRACEDIR/instances/$instance/tracing_on")
+	if [ "$TRACING_ON" != "0" ]; then
+		echo "FAIL: tracing_on is not 0 in instance $instance ($TRACING_ON)"
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
+echo "PASS: cmdline-07-trace-instance-override"
+exit 0

