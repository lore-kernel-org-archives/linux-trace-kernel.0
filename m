Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46636AF5;
	Thu, 16 Jan 2025 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990437; cv=none; b=Tl76tCnWPTCzgr5N1Hp2Mg/g7ID+q2E3qHYJaOBcJpyuFHi4JMzyFmwFDxsqLBVXUTJsdmhMyUz/TjIqwCo52LTetq8Q/CPB/cPpnstX+H3olCOvR1f5qvMcx+TaeH5QarLfrx02G4VDZuwJNf7GEdVHo2FbMfs6PAWlbQI111I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990437; c=relaxed/simple;
	bh=VGdJe2e5SEdc/dNfwvsbLaZnhN9BFDQd65/K0mjd/K4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Jrv6uPT73cClYxIrnYQxIlOngbW20bKEHhEMMSHDDOZ4Hk/3oOsvAqAkvVq3IHu/atjp3pVdsL2rvaQQEeZ3ZOfKDvNVczzz/xG0vB72q7C6XThW08TwyiO7pbgvRYPdzUqBS65IgfnSqDg7sEWMDAT3kR4BGELMN4Nxs8dNghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBAC4CED1;
	Thu, 16 Jan 2025 01:20:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYEYs-00000000hd0-0dcF;
	Wed, 15 Jan 2025 20:20:42 -0500
Message-ID: <20250116012041.920751669@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 15 Jan 2025 20:20:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] selftests/tracing: Allow some more tests to run in instances
References: <20250116012009.840870709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The tests:

  trigger-action-hist-xfail.tc
  trigger-onchange-action-hist.tc
  trigger-snapshot-action-hist.tc
  trigger-hist-expressions.tc

can all run in an instance. Test them in an instance as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc      | 1 +
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc   | 1 +
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc   | 1 +
 .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 1590d6bfb857..20a35fea13f8 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger expected fail actions
 # requires: set_event snapshot "snapshot()":README
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 2430f541cd5d..55ab0270e5f7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
 # requires: set_event "onchange(var)":README ping:program
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 334595daa9f4..9eb37c2fa417 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
 # requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
index 05ffba299dbf..0ebda2068a00 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram expression parsing
 # requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log "<var1>=<field|var_ref|numeric_literal>":README
+# flags: instance
 
 
 fail() { #msg
-- 
2.45.2


