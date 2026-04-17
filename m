Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90634753F;
	Fri, 17 Apr 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442722; cv=none; b=WP760Jm5AhIyGqxcEP6USzcUzdPvssXdgMTLfMRQzl16hn/ZcdcbzPset0AawlQGc5/DYk2jg4Vmyfjk0JQ0Z+mhzXc2PM7+FUPyYe+dvRJlAca+PuumVvYHPzSRPlsC9sk9A0t/x3G6Oybvi7KSeV6tYe9a7UnO1gX2ANq+zHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442722; c=relaxed/simple;
	bh=pEVTDWITMqNKfplBBLj1hjBHsy+PgbkTjXTBWjivCB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nH/dPjoF11HQQx9LmAL5WrnsDjZWVk/2KDbIvbJndju4ERe5HZp0PyM+cMt7tkM8+Ewe+1YenIHwLM/kmkwJk+7FSq82SoDj2Zqb7BZo3ubYxZBgQ7ai4QU9i1olWKO0CgE7GTNMgvKivv1DATyfuAY+jJ7boXmAz7kpCaNgeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQjMxOmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQjMxOmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6CC19425;
	Fri, 17 Apr 2026 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442722;
	bh=pEVTDWITMqNKfplBBLj1hjBHsy+PgbkTjXTBWjivCB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQjMxOmiMZCK9QXuTFER17Elf8ao0b8gnsXwC8G3sH2hVHDYDVVWGsjJsyy3pkKNo
	 I1Grm5I+3LjWkJbmbEc0vghrWu9RyXt7Hc6bsQAxgy3FggL+ZU84GkXwN+IX0SinCC
	 lLHg2f4DfyHZBJaXpYZqF46J9anEOtRaCWD4LGftBmdVjx/vqFHAoQkJBd1nP7eJDP
	 hYmDww+wU2Y+X91HtAk02ZxzisUnJ28o0Q1xZZOHys5/2Cmb8HM2XqaApECJLxGcMG
	 JpROaE0XG09A9yZYngJdsT87fL3SG5JlGEgAAg8PQtw7UPc3M6jHJj5R7Ql4mjKec+
	 GAWsX21SMDEJQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 7/8] selftests/ftrace: Add a testcase for fprobe events on module
Date: Sat, 18 Apr 2026 01:18:39 +0900
Message-ID:  <177644271967.584467.9751522686479464647.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
References:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
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

Add a testcase for fprobe events on module, which unloads a kernel
module on which fprobe events are probing and ensure the ftrace
hash map is cleared correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
 - Use "trace-events-sample" instead of "trace_events_sample"
 - Add checking unload module and remove core-kernel event case.
 - Check test module exists when unloading it in EXIT.
 Changes in v8:
 - Newly added.
---
 .../test.d/dynevent/add_remove_fprobe_module.tc    |   87 ++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
new file mode 100644
index 000000000000..c358c5071f15
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
@@ -0,0 +1,87 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove fprobe events on module
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README enabled_functions
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved;
+fi
+trap "lsmod | grep -q trace-event-sample && rmmod trace-events-sample" EXIT
+
+echo 0 > events/enable
+echo > dynamic_events
+
+FUNC1='foo_bar*'
+FUNC2='vfs_read'
+
+:;: "Add an event on the test module" ;:
+echo "f:test1 $FUNC1" >> dynamic_events
+echo 1 > events/fprobes/test1/enable
+
+:;: "Ensure it is enabled" ;:
+funcs=`cat enabled_functions | wc -l`
+test $funcs -ne 0
+
+:;: "Check the enabled_functions is cleared on unloading" ;:
+rmmod trace-events-sample
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+:;: "Check it is kept clean" ;:
+modprobe trace-events-sample
+echo 1 > events/fprobes/test1/enable || echo "OK"
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+:;: "Add another event not on the test module" ;:
+echo "f:test2 $FUNC2" >> dynamic_events
+echo 1 > events/fprobes/test2/enable
+
+:;: "Ensure it is enabled" ;:
+ofuncs=`cat enabled_functions | wc -l`
+test $ofuncs -ne 0
+
+:;: "Disable and remove the first event"
+echo 0 > events/fprobes/test1/enable
+echo "-:fprobes/test1" >> dynamic_events
+funcs=`cat enabled_functions | wc -l`
+test $ofuncs -eq $funcs
+
+:;: "Disable and remove other events" ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+rmmod trace-events-sample
+
+:;: "Add events on kernel and test module" ;:
+modprobe trace-events-sample
+echo "f:test1 $FUNC1" >> dynamic_events
+echo 1 > events/fprobes/test1/enable
+echo "f:test2 $FUNC2" >> dynamic_events
+echo 1 > events/fprobes/test2/enable
+ofuncs=`cat enabled_functions | wc -l`
+test $ofuncs -ne 0
+
+:;: "Unload module (ftrace entry should be removed)" ;:
+rmmod trace-events-sample
+funcs=`cat enabled_functions | wc -l`
+test $funcs -ne 0
+test $ofuncs -ne $funcs
+
+:;: "Disable and remove core-kernel fprobe event" ;:
+echo 0 > events/fprobes/test2/enable
+echo "-:fprobes/test2" >> dynamic_events
+
+:;: "Ensure ftrace is disabled." ;:
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+
+trap "" EXIT
+clear_trace

