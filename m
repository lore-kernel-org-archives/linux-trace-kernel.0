Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D354654;
	Thu, 16 Apr 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334671; cv=none; b=tlJMts3LEyF3dd6/u0BTAwRUsTYA6eG5w1B1363PuCzhtdhVM46GLanVSSAEtcP8PFHgwbk/ELnWou3kYrGdcIAb+pUzPGfzF+wHr8YXRfM2hSkic26DsDgSv+h4PfAehEpG+5DfzMG9F9WV6f+rEmpmnYObAutE8NpkdN4VP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334671; c=relaxed/simple;
	bh=tZR2BVMsPTdwmjNRnZOzYXc0zoDf5+38hsPHRSxqelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZDOqg0S8Q++bO2BK4bJZej2Vse9EGgeXxU5IK9Jwo/NAvjaf7QwQaE6w9UvUb5N2uXUm+RSWzSSZkQ+OB2RspOzBS8Dw6H9bYmkTscyQlYb+boo2ISJaL60VeflZk/gw0NuWqN7mWxHO/NnRhGGnIfXrxT6qLLJl/RHeLa3gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE5oNrdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE5oNrdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27145C2BCAF;
	Thu, 16 Apr 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334671;
	bh=tZR2BVMsPTdwmjNRnZOzYXc0zoDf5+38hsPHRSxqelg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sE5oNrdJ/PXxMwtwpYqqE1LgdY7/KtIQxWO8gNyr8g7DxF4KWvldsMXI5hYAM5cXs
	 hTRc1XlSiVMFbmvGg140Kp3J6lM/uhwWywI/mMWAiraFGZBi6Rr6jqyjc0la1W8xAq
	 7Lg8kg8GnGTJaSsuxlslq/e6/4HrbQZjYNkbzn+HMDn7893FNMbAP6lBHsS7LkILPd
	 pQQdld7oKgeqPFGA92zJ83eLjipx1wxrZpONdF+VP+gmu7s5lmEgCjjlk+P/icpUPm
	 cvtIoPzUBPs18kTWNWk+Wd926dHSXU3BWe0pWJOIkVTEBfsWIEKXHFCwoqJiOJ2LZj
	 zYg58n3z4vSEQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] selftests/ftrace: Add a testcase for multiple fprobe events
Date: Thu, 16 Apr 2026 19:17:47 +0900
Message-ID:  <177633466683.3479617.15493325206503059547.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
References:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
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

Add a testcase for multiple fprobe events on the same function
so that it clears ftrace hash map correctly when removing the
events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/add_remove_multiple_fprobe.tc  |   69 ++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc
new file mode 100644
index 000000000000..f2cbf2ffd29b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove multiple fprobe events on the same function
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README enabled_functions
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=vfs_read
+PLACE2=vfs_open
+
+:;: 'Ensure no other ftrace user' ;:
+test `cat enabled_functions | wc -l` -eq 0 || exit_unresolved
+
+:;: 'Test case 1: leave entry event' ;:
+:;: 'Add entry and exit events on the same place' ;:
+echo "f:event1 ${PLACE}" >> dynamic_events
+echo "f:event2 ${PLACE}%return" >> dynamic_events
+
+:;: 'Enable both of them' ;:
+echo 1 > events/fprobes/enable
+test `cat enabled_functions | wc -l` -eq 1
+
+:;: 'Disable and remove exit event' ;:
+echo 0 > events/fprobes/event2/enable
+echo -:event2 >> dynamic_events
+
+:;: 'Disable and remove all events' ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+
+:;: 'Add another event' ;:
+echo "f:event3 ${PLACE2}%return" > dynamic_events
+echo 1 > events/fprobes/enable
+test `cat enabled_functions | wc -l` -eq 1
+
+:;: 'No other ftrace user' ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+test `cat enabled_functions | wc -l` -eq 0
+
+:;: 'Test case 2: leave exit event' ;:
+:;: 'Add entry and exit events on the same place' ;:
+echo "f:event1 ${PLACE}" >> dynamic_events
+echo "f:event2 ${PLACE}%return" >> dynamic_events
+
+:;: 'Enable both of them' ;:
+echo 1 > events/fprobes/enable
+test `cat enabled_functions | wc -l` -eq 1
+
+:;: 'Disable and remove entry event' ;:
+echo 0 > events/fprobes/event1/enable
+echo -:event1 >> dynamic_events
+
+:;: 'Disable and remove all events' ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+
+:;: 'Add another event' ;:
+echo "f:event3 ${PLACE2}" > dynamic_events
+echo 1 > events/fprobes/enable
+test `cat enabled_functions | wc -l` -eq 1
+
+:;: 'No other ftrace user' ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+test `cat enabled_functions | wc -l` -eq 0
+
+clear_trace

