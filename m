Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3A2586EC;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002686; cv=none; b=QDPbXU+4GHYlGsQUgSx2whlNPZGPtGCWEBdebLEQ0sTxz6ccpTI+GVCtlP+uuZJhe8unXoFv70O8TD+6tPyjt2J+guvByVWF+o+CxDdpK0Osae1CrgTs59aznPVCkfe52Aa3mY1YW6bKcyuZv8DfBVRoXhEuaa0+O6tsvzRQuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002686; c=relaxed/simple;
	bh=ed4oJT8Vvl3M2/8n3hRn6wKpF9ddoi3DZ6J87+Kpego=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C4y21ndlKBD0JgaQOrzUwlbKjDERHIkcUApPhhffDQg13Zv6sgUGPXM7ODUQY8YDT54pxTJ0mkIE0l8SRc1aGoisp7qaFGINRAaWruJAJufpKUr3owqeGtoZYExlYEPtfUd+x0bI3ZYgK9h578m25rMXw6+B7yn9W89PA5chU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE6CC4CED1;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tksBr-00000004qe7-2yMH;
	Wed, 19 Feb 2025 17:05:11 -0500
Message-ID: <20250219220511.557045614@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 17:04:41 -0500
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
Subject: [PATCH v2 5/5] selftests/ftrace: Update fprobe test to check enabled_functions file
References: <20250219220436.498041541@goodmis.org>
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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


