Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FBF9D9;
	Tue,  1 Jul 2025 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413460; cv=none; b=oIO590GBjgk9mPjBIo41P5lWV5453XcKYyEJ4kjT/f5DZCEdmJSt/zc/EwwnhpBZ8mFt57D+LLgPa7nzWL2IPFR33KpwDecHzVJEiHz6XMpuY+zN3gYIOUx2vl0p7OtbQu8Yi5KSBuNN4ijmTFZzvAq1Do7JF+7P+DT100CLpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413460; c=relaxed/simple;
	bh=c0lJLhW9sGJUTVi90BSg3VA0i1FvdVw1WWGoWae/x80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IAti7Kjh53JZZUd/CRclc3n85tVva98Hb7rZyUYXDcOdrsv12ypr9jU50VyV6bWlIt7qFxXPEQ1aiMqWkREs4T5fKq3n5I++gwDoz5hwPQZZZhRBvI2nGIiuvtGfw8G5OMvV/mqlCtN1UoWNboDiAXcHaCDCdHHCfAhrM8JTtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 58CA5805C8;
	Tue,  1 Jul 2025 23:44:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id AE5562F;
	Tue,  1 Jul 2025 23:44:13 +0000 (UTC)
Date: Tue, 1 Jul 2025 19:44:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] fgraph: Keep track of when fgraph_ops are registered or
 not
Message-ID: <20250701194451.22e34724@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 34rgiku93yqq3ynf74xe73cb6g5f1m7m
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AE5562F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fUqFofNwisz3PsArUK+9V/cE8qGI00+Q=
X-HE-Tag: 1751413453-248680
X-HE-Meta: U2FsdGVkX181FSfaV+QlZ8xjKJU6V0UBmycvD0dX+k9HsUc+G9XrvG6I+Z1vgq4TliqXn4DQxsuSRCG8abbiLeSrGIVSvvULpBvbMX3GO7sHtlsloUV5Q8AiCzUTQtdWK3puhaMOeA/l04Zri8KyI6az5cWQJYGy+LmbgiyYhW1WDN+CwG9zQqH/aiopKXFpQq35Y2tx6lhi/O4kNIrB6Nq7Wu44TCq/kgTfqjuIrexLMzBHVo1WF+CdlBeYdPS6o5otTL3Jt6mDuTvr9L0EFCZ5qEHKu3mD0CUvBbb1/31y9WuUX371wCfaepqFZ9vnYJ7zpiQQ21uFcZzU8LxlfCwGM9dg3RG4lw+85R5pZ5haO7IrZsmp8Z8g0zWs4ZE3k7BRS5QHRLB7MxbJTgu57lkgqNu0f0CdYKB60BXyojVb2jbtGRHSjQ==

From: Steven Rostedt <rostedt@goodmis.org>

Add a warning if unregister_ftrace_graph() is called without ever
registering it, or if register_ftrace_graph() is called twice. This can
detect errors when they happen and not later when there's a side effect:

Link: https://lore.kernel.org/all/20250617120830.24fbdd62@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250618073117.024efb2e@gandalf.local.home

- Just zero out the FL_GRAPH flag instead of all flags (Masami Hiramatsu)

 kernel/trace/fgraph.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c5b207992fb4..f4d200f0c610 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1325,6 +1325,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i = -1;
 
+	if (WARN_ONCE(gops->ops.flags & FTRACE_OPS_FL_GRAPH,
+		      "function graph ops registered again"))
+		return -EBUSY;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_stack_cachep) {
@@ -1401,17 +1405,21 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 
+	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
+		      "function graph ops unregistered without registering"))
+		return;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
-		return;
+		goto out;
 
 	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
 		     fgraph_array[gops->idx] != gops))
-		return;
+		goto out;
 
 	if (fgraph_lru_release_index(gops->idx) < 0)
-		return;
+		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
 
@@ -1434,4 +1442,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
 	gops->saved_func = NULL;
+ out:
+	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
 }
-- 
2.47.2

