Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3E1C01;
	Tue, 25 Nov 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085633; cv=none; b=efBt12Xc/Zg8yRz3Dt3bnL+EbHqXV0uPfGh9zpDbsuQTba1XMJTVVt8/EEw/SfuflsQxx704jWXgI/pfO4ITJaBM7FiABIIUnXGzXOhypnqdw4Sa7jc0vHq3ZYWc4wXU/6/ZfgD2+BpRd/ko3d/FP5KAvXvsZpKF0gQ3hAY7c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085633; c=relaxed/simple;
	bh=8FUpFcXTnpb2QB70I+SVKADc80o2bBOV7W7OAhb6BcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sbOWAye5vm+To/Zvs9BQ7bHvHzkMUU4EF1DNyTcuLrl2b50djcCB8lgIHyfOjbcztlrR8H6gq5qrYqjVAoWUpVdzozqrAlAd+ENKefheBn/P1ApSIQRlaBKXWFapc4eR4D7IsGd/DGzkoWJg713ojSeEwYi9wboBvzopqjJ0/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E74E686E0C;
	Tue, 25 Nov 2025 15:47:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 3169018;
	Tue, 25 Nov 2025 15:47:08 +0000 (UTC)
Date: Tue, 25 Nov 2025 10:47:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] fgraph: Make fgraph_no_sleep_time signed
Message-ID: <20251125104751.4c9c7f28@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 3169018
X-Stat-Signature: bnxieb5mjuafk9zmm4zk8tb5wex4okxw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vwP08/QDFgFjAQR/RtAyYPHTb1uoGI1Y=
X-HE-Tag: 1764085628-910527
X-HE-Meta: U2FsdGVkX1/fQ3WWVHyzVL0w9saK/VQZcMjSmnQ/mlWbh7p6WScVOVJn1PGmhmgNA4yw8RjTFOH6cbBeVZvVQZwCOhqvn6sK6nk5ozfN/L27Rkh6IUSRleo1QaQejxxNB/somi0v65nmJL6knxwerxac6fGBQILC9Ao2JMv5Yb6AKAeOQ4iscz079LBGGrWSDcmymJ4eisRqFdbwm/PzPTLoFx92IcxLtXpPCkqTFUbSM12oJIzuPxgYWBG4EAexj//cC4YMR45vp/ax5aWG6ORagOk9ZY1YMtyGgm4ipx7G0jbhUpDsIwH9g55seI/QfdM+Mp9re5TGjKbqGOLl/jri0bQUU0pSmpHCFytHnf7EgrBC+k5/7X28SfeWeP9ae8ZcBdJcaLkYERExHzCsik5yuj5b4tmy7uWLRM5gogYJnwb4oo2G7D1k9ZAQfv0wABoxx5KBAUS3x4ASoe9MlA==

From: Steven Rostedt <rostedt@goodmis.org>

The variable fgraph_no_sleep_time changed from being a boolean to being a
counter. A check is made to make sure that it never goes below zero. But
the variable being unsigned makes the check always fail even if it does go
below zero.

Make the variable a signed int so that checking it going below zero still
works.

Fixes: 5abb6ccb58f0 ("tracing: Have function graph tracer option sleep-time be per instance")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aR1yRQxDmlfLZzoo@stanley.mountain/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                 | 2 +-
 kernel/trace/trace_functions_graph.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 58be6d741d72..da5d9527ebd6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1113,7 +1113,7 @@ static inline void ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftra
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
-extern unsigned int fgraph_no_sleep_time;
+extern int fgraph_no_sleep_time;
 extern bool fprofile_no_sleep_time;
 
 static inline bool
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 44d5dc5031e2..d0513cfcd936 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -20,7 +20,7 @@
 static int ftrace_graph_skip_irqs;
 
 /* Do not record function time when task is sleeping */
-unsigned int fgraph_no_sleep_time;
+int fgraph_no_sleep_time;
 
 struct fgraph_cpu_data {
 	pid_t		last_pid;
-- 
2.51.0

