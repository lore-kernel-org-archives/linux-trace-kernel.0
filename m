Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78334E741;
	Mon, 20 Apr 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693698; cv=none; b=r5dnlxf6D1Jfji2sd5jaGgtC73FskXZbZZ+mRK9GbdDJgrXaBmgPGE/vBikuO/Qj0odOji530nqQek7EP7N/inRow5rm8bbnzURY66EnQNOpbGKdsTYGMtJGwvAq5Mr8AlDOXFX+NM2AlCobmtKU05enUSSO64G6Vrv2ip6GwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693698; c=relaxed/simple;
	bh=EXwvbf2ZZMYTdLHaRwxD5QLC9E8zW83qZ4rlowt2kyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr+lzY5jA8uHfEnpkm6dy8DxlLgDMQ8aONMfzUqH/bKexMPAVkQPfKiHpz6u4lIAKG0RXx/W9N2whNZdYLxD6KXUDN67QcqLgIyBg3f9fR6be6nkCPjYdMpHwvAb35SBePWMy15eQf7a4NUAqj6h/HhnT9piUJkJv1b6RszKsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNusPUNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNusPUNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56615C19425;
	Mon, 20 Apr 2026 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693698;
	bh=EXwvbf2ZZMYTdLHaRwxD5QLC9E8zW83qZ4rlowt2kyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNusPUNmlEgJC+E1hUBt2foyTUhEk0ds9cc9hEFeItUnjGqyWf2cqR1YbdWfoKKo/
	 1uUbkWriifiAKkphT+LU0HlPd98NO8SzkThzvcZO3x3ROSiVzWl9HEDdeRzWnTGt9c
	 bDGBFLxGemsxCxCXLQNoe6btHMyCpvXHbcbE2Icp4NkOx0ez+qpsLHRr3fY6tRiF8S
	 FBdxzTeURKrcuq2kqtupg4limlBMoKbqIf2EboKJZRmCvrS68sv3E/zewXIVS5jvpS
	 N3jLenKtTd+JJuhdGEGYe8vIMMQYKvS5XnMCfPKltMp0oCrED/JjUioj10r9ko5XjD
	 DY8Mp05AGKgaA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 7/8] selftests/ftrace: Add a testcase for fprobe events on module
Date: Mon, 20 Apr 2026 23:01:35 +0900
Message-ID:  <177669369564.132053.623527664540176496.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
References:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v10:
 - Fix module name typo in error case trap.
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
index 000000000000..2915206777b6
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
+trap "lsmod | grep -q trace_events_sample && rmmod trace-events-sample" EXIT
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

