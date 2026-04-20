Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C834F48E;
	Mon, 20 Apr 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693708; cv=none; b=Ohsf+t4kfJF7qoefNdZnJy35aLLex7YM3l/aAHxi5HW977Iwvfd1SnP59IOPNJCKi6mmqr2vJFAxIS3y+X17zNFkk+kRGp1HIkDBzYNQbg0xkt/aU4LxZF0c71rkvfANOlpJnZKNYL1xg9oWMGgxlW5NoDj9ayRmRdUMKfS/Pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693708; c=relaxed/simple;
	bh=tZR2BVMsPTdwmjNRnZOzYXc0zoDf5+38hsPHRSxqelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJm8YKtVW9RkDgBIen1dskgBtPmXckYo2JP71g+igA1E9OGrDHJK8ENtcbYdM9EsDZALLiobEnAlDorrHG3KA3oCVLkc0t7BOwP24SggfFSOTgYc2IG5IIm18zAtqmnMq7GwlM7R5zlzymY2NrR15X/mkhluxK9U2KT0rr3G3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaTpv2cI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaTpv2cI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D5BC19425;
	Mon, 20 Apr 2026 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693707;
	bh=tZR2BVMsPTdwmjNRnZOzYXc0zoDf5+38hsPHRSxqelg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaTpv2cITf3RjFZB7DnlaVjsXQ7vLL5ystYx6OeIWs7ZPy4vnNrE0aNNUPC0y58Kl
	 RqnH76aK9yEF4oqHoxeAzLwS8EYo15qAIvAbK+Oqoj4Z5xR6IxyE+0Kc3uSMiuqeVf
	 V1eXSgEjH4CBpvLQteRaLp4YJWcAmmKRu6c0u87j2NJxVQ5qgCxQ0cpmuiW3x/jzzv
	 Fqlkk5LsY6nVsCSHBvyOav/44+1D7iI6i38bwhtjqlRHDq+vz0sydGLAcZHNcocuGt
	 +wGhbQkuQWG06CcT/D/7VvdTNPNwZdOElUN9Kr1hGdit9yVUQI9ANNZya3cauKITPr
	 BWDEE+8Tm3WyQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 8/8] selftests/ftrace: Add a testcase for multiple fprobe events
Date: Mon, 20 Apr 2026 23:01:43 +0900
Message-ID:  <177669370353.132053.16801520791509406141.stgit@mhiramat.tok.corp.google.com>
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

