Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9F23244D;
	Tue, 14 Jan 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867522; cv=none; b=Dy0SjL5Xv5vJGzCCG8kKXKeDG61TCt+JOmB+e/MT8TyGga+ZHHVK5YOUgqMSDWjQXOWT7/fJdMQvTU46DMv0VhsmFGC9N6ZJdi6+EGGnujrYRof1i8fGyf27oZmEXiF9DUW9JqwessrBj/W/tHPX/wQpjXyOVL5DucccxHmLTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867522; c=relaxed/simple;
	bh=Mkq/wrIpBvm3Er3I1jFH3skSpiNdl/i/q5lpy9JU6uM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ggefm4H9BhYwhF96hxIS2swbldU5j772pCgVLdApW4CJEIWycOleqkUS3/LCpW/sooNY/X0/rZuJJLkKB/ETToXnX8wdL7lGTwmVIYipMvAQC951exdZBhjHarFjsgFOiDO73+HExnhbLxf+Y2+KeUMtoxp88/wVFP7vdIjmxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7E7C4CEDD;
	Tue, 14 Jan 2025 15:12:01 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:12:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Document that multiple function_graph tracing may
 have different times
Message-ID: <20250114101202.02e7bc68@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The function graph tracer now calculates the calltime internally and for
each instance. If there are two instances that are running function graph
tracer and are tracing the same functions, the timings of the length of
those functions may be slightly different:

 # trace-cmd record -B foo -p function_graph -B bar -p function_graph sleep 5
 # trace-cmd report
[..]
bar:            sleep-981   [000] ...1.  1101.109027: funcgraph_entry:        0.764 us   |          mutex_unlock(); (ret=0xffff8abcc256c300)
foo:            sleep-981   [000] ...1.  1101.109028: funcgraph_entry:        0.748 us   |          mutex_unlock(); (ret=0xffff8abcc256c300)
bar:            sleep-981   [000] .....  1101.109029: funcgraph_exit:         2.456 us   |        } (ret=0xffff8abcc256c300)
foo:            sleep-981   [000] .....  1101.109029: funcgraph_exit:         2.403 us   |        } (ret=0xffff8abcc256c300)
bar:            sleep-981   [000] d..1.  1101.109031: funcgraph_entry:        0.844 us   |  fpregs_assert_state_consistent(); (ret=0x0)
foo:            sleep-981   [000] d..1.  1101.109032: funcgraph_entry:        0.803 us   |  fpregs_assert_state_consistent(); (ret=0x0)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 272464bb7c60..2b74f96d09d5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -810,6 +810,12 @@ Here is the list of current tracers that may be configured.
 	to draw a graph of function calls similar to C code
 	source.
 
+	Note that the function graph calculates the timings of when the
+	function starts and returns internally and for each instance. If
+	there are two instances that run function graph tracer and traces
+	the same functions, the length of the timings may be slightly off as
+	each read the timestamp separately and not at the same time.
+
   "blk"
 
 	The block tracer. The tracer used by the blktrace user
-- 
2.45.2

