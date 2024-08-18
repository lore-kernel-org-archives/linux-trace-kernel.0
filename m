Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29238384;
	Sun, 18 Aug 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977818; cv=none; b=jwp6ZY6A7Kj6DUYI7DuKAfot1aSLmY25ymaUaI31vcZ0XxZjC6uXUD3uxOPd+xAvfkA0eUayMateD2eUDP87CMWh94vAE8AixlHpdE8lhaSvto8wL0fyE2B61wws+7RIETvtKbjzapi/j+Z9TEp/Q8kfQiD+bNMaEsgVWSC2IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977818; c=relaxed/simple;
	bh=rCdP5URlZYm+NPBg5WLaSak0xP7BHvZX5yXjGEZvYzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH2a/eiu6c2BlmAxLTZiYxlwCSQFY036aaPXA8khCjWnunf6j67w3A4f8h6muohKdn2qlJWpusgrY2gjTOW3IL7NkdKNI5vA+soLOmxfPE3Bbj6/+oQCPjFaf3Uj0ulcd1jx43O9jEq3Ev1fFNEnucu7q30jhG+CXSMu9UC1Qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB8D/Rah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB8D/Rah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121BAC32786;
	Sun, 18 Aug 2024 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723977818;
	bh=rCdP5URlZYm+NPBg5WLaSak0xP7BHvZX5yXjGEZvYzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rB8D/RahpCQQCg6W6bLp6TlMu846obvdQ29lzrB45XX3KQZM2815ExD0G6EK5sHsD
	 aJIBwjYCcnk9TNtKGM0nIho4gUxX4FczOMVt7DvPxq0YyKat4U6ntIsgSb5usWKc39
	 xvSYLWaesVl6a+w/Ecxj3ZvUsV2TN4ZNiM6Rx8WoxBbYbMYGX6fNPl6mZb4P1QTY7l
	 EqncrjPsY1yNk1dotjSd4wc66EPgftsZ75QEV4W30L7Zin+wVr8QjvW8v12V4Sz/gf
	 Tq/8FaJsuRyMio7gGxbpTTPe45MwdPDWdmMZ4tMqgEcR6+IFLA06kazM85gBZ6Nkg0
	 rX1mxoPj3xbaw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v3 5/5] sefltests/tracing: Add a test for tracepoint events on modules
Date: Sun, 18 Aug 2024 19:43:35 +0900
Message-Id: <172397781494.286558.7581515061075998225.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172397776900.286558.8986646398199362026.stgit@devnote2>
References: <172397776900.286558.8986646398199362026.stgit@devnote2>
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

Add a test case for tracepoint events on modules. This checks if it can add
and remove the events correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add not-loaded module test.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/dynevent/add_remove_tprobe_module.tc    |   61 ++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 048a312abf40..544de0db5f58 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -20,6 +20,7 @@ CONFIG_PREEMPT_TRACER=y
 CONFIG_PROBE_EVENTS_BTF_ARGS=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_FTRACE_DIRECT=m
+CONFIG_SAMPLE_TRACE_EVENTS=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SCHED_TRACER=y
 CONFIG_STACK_TRACER=y
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc
new file mode 100644
index 000000000000..d319d5ed4226
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc
@@ -0,0 +1,61 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove tracepoint probe events on module
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved;
+fi
+trap "rmmod trace-events-sample" EXIT
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TRACEPOINT1=foo_bar
+TRACEPOINT2=foo_bar_with_cond
+
+echo "t:myevent1 $TRACEPOINT1" >> dynamic_events
+echo "t:myevent2 $TRACEPOINT2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/tracepoints/myevent1
+test -d events/tracepoints/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
+
+:;: "Try to put a probe on a tracepoint in non-loaded module" ;:
+rmmod trace-events-sample
+
+echo "t:myevent1 $TRACEPOINT1" >> dynamic_events
+echo "t:myevent2 $TRACEPOINT2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/tracepoints/myevent1
+test -d events/tracepoints/myevent2
+
+echo 1 > events/tracepoints/enable
+
+modprobe trace-events-sample
+
+sleep 2
+
+grep -q "myevent1" trace
+grep -q "myevent2" trace
+
+rmmod trace-events-sample
+trap "" EXIT
+
+echo 0 > events/tracepoints/enable
+echo > dynamic_events
+clear_trace

