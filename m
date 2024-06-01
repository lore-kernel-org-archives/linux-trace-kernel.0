Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769811711;
	Sat,  1 Jun 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230179; cv=none; b=GRuZhhD8fQjWh3OYwxEw8Kp6gbgGfBxEmvtK6ZPzqBKTMQpoY80FrmMxNMLoGB47AGVO+4Q9VmR1HjGgAkazz17KRhJWepuUdRPqWI7wwhoHiM7XDjeu+C44WQNq+dgx3bDaOncKuYud2GG2TYgZvmXRuvJo39jipmi53PlhEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230179; c=relaxed/simple;
	bh=ir1GPv/WVZeGeHO6Nly4BHiSZZOFn2vs7jsNY1Z2JXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTIDbgukqSi4UnokVFjuOslOYnFT4l1ZiaiuCfJgk/qi/naBVnL1tK6Cvhv63HTA2FgMV6v+PROvoYcjkd6FzpQkbZ6ArVmRbVIJ7W2POJWTX6xej3bGd/AVnQ+WHKVYYShinH4Zib/vKq3Fm9D/4uWDThUkiFJDp2FA81mSm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLkBfIXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLkBfIXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6C5C116B1;
	Sat,  1 Jun 2024 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717230179;
	bh=ir1GPv/WVZeGeHO6Nly4BHiSZZOFn2vs7jsNY1Z2JXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLkBfIXGZZFBMaImA+rmmP+F0KASs+OeR7q6vA4tFXZo7nUFBTfY7JDy240OCUv/0
	 pLIK5OqREwS4EwZtHzI0gxprdPLqLYE4/g6rI2lzFkTjA+Icl9xV1VkAghGLxABqZT
	 v0phh+7Z9qugL5gMDGLLM5HGvPkoTv0uG7RczE9uMLb3pKcQY1nc6TdENGAU+1WMUK
	 FZAlXfRZ35zmmtXbqR/cyqY5qzaWGJ72EWuW0jNery01qbW7ZTgcFudui509rCdTwa
	 h4qDgNKAM8xdhOHJKKXYSpESOf3CpPF2CGigKtR4ZWXFJtxctJGU1P+g7qZnwW6qvN
	 kVuGIXYaLndkA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v2 3/3] sefltests/tracing: Add a test for tracepoint events on modules
Date: Sat,  1 Jun 2024 17:22:55 +0900
Message-Id: <171723017495.258703.11572784928592807749.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171723014778.258703.6731294779199848686.stgit@devnote2>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
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
 tools/testing/selftests/ftrace/config              |    1 +
 .../test.d/dynevent/add_remove_tprobe_module.tc    |   34 ++++++++++++++++++++
 2 files changed, 35 insertions(+)
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
index 000000000000..2caed9454caa
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc
@@ -0,0 +1,34 @@
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

