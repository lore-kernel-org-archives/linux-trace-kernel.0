Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346D271277;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907064; cv=none; b=sXg9jwGdpNKCrNvOVhzzBnmtbr0FxNOCzKnbKDoOP8ClsC+VVqUAOrqOgC9ugzrBo4nP+bdnIeCB5MHE0sT58GOqioXTQgMkRGQRvujM8w3NswpW/5ZLHwEaZBHUHwwfX5L7/dWfCfkdaNHt49JbxhDEcocFEEeA9NAlKCg9Xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907064; c=relaxed/simple;
	bh=2YalSfh1sIK7ZYk5yFfNAwu0MnaY4ZnI8YiB3afchPo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M2AaLnOxs95l+EIKwQ6Y9V+EtJscSf1tJ2P+Njm+7XySNyFs0NKkRUiQ260D1sok4FFRehtq9wIV78GpU5oyDzgKiItLaHQKEVKSKNpFmV+YtmNvWWPHYvEJalOzYSu+702M562/5riBaKkcGmQoycyurtJTDIWZzxHmfmJRug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848CAC4CEE8;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTJX-00000004A1R-0QhQ;
	Tue, 18 Feb 2025 14:31:27 -0500
Message-ID: <20250218193126.956559192@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:30:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 5/5] selftests/ftrace: Update fprobe test to check enabled_functions file
References: <20250218193033.338823920@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A few bugs were found in the fprobe accounting logic along with it using
the function graph infrastructure. Update the fprobe selftest to catch
those bugs in case they or something similar shows up in the future.

The test now checks the enabled_functions file which shows all the
functions attached to ftrace or fgraph. When enabling a fprobe, make sure
that its corresponding function is also added to that file. Also add two
more fprobes to enable to make sure that the fprobe logic works properly
with multiple probes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_fprobe.tc      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index dc25bcf4f9e2..449f9d8be746 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -7,12 +7,38 @@ echo 0 > events/enable
 echo > dynamic_events
 
 PLACE=$FUNCTION_FORK
+PLACE2="kmem_cache_free"
+PLACE3="schedule_timeout"
 
 echo "f:myevent1 $PLACE" >> dynamic_events
+
+# Make sure the event is attached and is the only one
+grep -q $PLACE enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
 echo "f:myevent2 $PLACE%return" >> dynamic_events
 
+# It should till be the only attached function
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+# add another event
+echo "f:myevent3 $PLACE2" >> dynamic_events
+
+grep -q $PLACE2 enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 grep -q myevent1 dynamic_events
 grep -q myevent2 dynamic_events
+grep -q myevent3 dynamic_events
 test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
 
@@ -21,6 +47,34 @@ echo "-:myevent2" >> dynamic_events
 grep -q myevent1 dynamic_events
 ! grep -q myevent2 dynamic_events
 
+# should still have 2 left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 echo > dynamic_events
 
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
+echo "f:myevent4 $PLACE" >> dynamic_events
+
+# Should only have one enabled
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+echo > dynamic_events
+
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
 clear_trace
-- 
2.47.2


