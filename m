Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74209801;
	Tue,  4 Jun 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529151; cv=none; b=Ws6+vV2euuEClgrjw8G2j1ZyJfrmuRTbrSZQxqs9qUmLplxd82/96LC2TPJkSvz0HIpXnkAmRz4yQxTrWtW9Au8Fi6hOSBXIylRaV3OLZm8CjjI0T50kd+didhu3p7sbij+SdTvAbRcs3xsqlrnRW/NpZ6AQMhAmJsIojw07AzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529151; c=relaxed/simple;
	bh=5k7gRhciOuBbwTDEYqzm+9sLuvG1nIhAitQwJrGdHMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aXXVI+pZGvg9yV01hMTgBGFmR54W5SYi2w1eDHPZ0tGu0tfIiFPra0TL8VpBQxPR9R/6H1NWe9pePtbVZIKiGqFYyeCCcxOYvVKjc6oFouTjVKD8xhHQKsEQ2s9R7MbRbMI4dLYLc3bIu0F9hRfF8P90RuHAXRgURo3SmO5+LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6871CC2BBFC;
	Tue,  4 Jun 2024 19:25:50 +0000 (UTC)
Date: Tue, 4 Jun 2024 15:25:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace/selftests: Fix pid test with function graph not
 showing pids
Message-ID: <20240604152550.0c01d7cd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The pid filtering test will set the pid filters and make sure that both
function and function_graph tracing honors the filters. But the
function_graph tracer test was failing because the PID was not being
filtered properly. That's because the funcgraph-proc option wasn't getting
set. Without that option the PID is not shown.

Instead we get:

	+ cat trace
	# tracer: function_graph
	#
	# CPU  DURATION                  FUNCTION CALLS
	# |     |   |                     |   |   |   |
	 3) ! 143.685 us  |  kernel_clone();
	 3) ! 127.055 us  |  kernel_clone();
	 1) ! 127.170 us  |  kernel_clone();
	 3) ! 126.840 us  |  kernel_clone();

When we should be getting:

	+ cat trace
	# tracer: function_graph
	#
	# CPU  TASK/PID         DURATION                  FUNCTION CALLS
	# |     |    |           |   |                     |   |   |   |
	 4)    bash-939    | # 1070.009 us |  kernel_clone();
	 4)    bash-939    | # 1116.903 us |  kernel_clone();
	 5)    bash-939    | ! 976.133 us  |  kernel_clone();
	 5)    bash-939    | ! 954.012 us  |  kernel_clone();

The test looks for the pids it is filtering and will fail if it can not
find them. Without fungraph-proc option set, it will not be displayed and
the test will fail.

Link: https://lore.kernel.org/all/Zl9JFnzKGuUM10X2@J2N7QTR9R3/

Fixes: 35b944a997e2 ("selftests/ftrace: Add function_graph tracer to func-filter-pid test")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index c6fc9d31a496..8dcce001881d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -8,6 +8,7 @@
 # Also test it on an instance directory
 
 do_function_fork=1
+do_funcgraph_proc=1
 
 if [ ! -f options/function-fork ]; then
     do_function_fork=0
@@ -28,6 +29,7 @@ fi
 
 if [ $do_funcgraph_proc -eq 1 ]; then
     orig_value2=`cat options/funcgraph-proc`
+    echo 1 > options/funcgraph-proc
 fi
 
 do_reset() {
-- 
2.43.0

