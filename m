Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFC25486D;
	Wed,  8 Oct 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938474; cv=none; b=OonYmOZicDkzoTa5H3DlusSlZ5pyrq1Mm8G3X4IJKKTkjysSsaeZU7mT4AEypQjmjneTZRgh6pH/QcEtjZ2BqG5KXg7f1R/W8LmEOxcOnbmq1F/vC8qbZwcEitZ9UbPDA5BwnOiNpiZeX30cgZuzESAfdgrVuQHOIJk4DztUHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938474; c=relaxed/simple;
	bh=iTPbxraedZD3neNFGfY1HUmZOBnuTBKr9Z6Mu5jfHGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YpuQqslQZNT3+dZSjtp5pJLDHOqwRt0WDlV7ifcSwH14BB+nwQBtP2zl034YOxRBXTigrP/2jF0g77XMdhSRh2jjLyO45mGNUPQID0c0RPJnVdznxd2xaEbmosaixYXGiOaupTHsRzvkEgJE9vfiENFomZ54FU+HZBkqQZpmJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5DB2613B347;
	Wed,  8 Oct 2025 15:47:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 9EC056000D;
	Wed,  8 Oct 2025 15:47:49 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:49:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Fix irqoff tracers on failure of acquiring
 calltime
Message-ID: <20251008114943.6f60f30f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9EC056000D
X-Stat-Signature: pkk4u41ktrogas6r3u5u1mycyheyho9d
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+rO6qzSFGfBADFEp/Zv/mePxJvGgyc4Zs=
X-HE-Tag: 1759938469-557830
X-HE-Meta: U2FsdGVkX1+Likmk7TE9ksRVH3n6t+YtPSlpLPvHiZ/hcW6eNgRNHNpypuG3xqUETUqQNsDUCdY2A/s6gWQHGdGKOTfnL1vVZG7FWF1fJG7ZmFBOhN6pbeThgi0yAgxkhdbWG0+S2AnLJ5DgMLrSTC5DkwlcNAO53UtllWbXXgBLjw0LZMiQUrwi6c6DRCYFtxcV70i8yK6qkNXWg4pc+lTT7LUa6kVaOwL4TYNfsUcoL0FLpFtOVftnky5USYcdVG0/ncUI7HoZCK3g2ojph8RKip6+3sZIEu8ai1D5p7fM7c0wwqIG0bDjQbqYfzNc6SG2xVq8YQy5JCrOHmdB/PXHv6OKy3zYPwA9w57zibhA++ruLjhzn92HgLcP8M+edrQDvwIWBFJbiYngmPDnkg==

From: Steven Rostedt <rostedt@goodmis.org>

The functions irqsoff_graph_entry() and irqsoff_graph_return() both call
func_prolog_dec() that will test if the data->disable is already set and
if not, increment it and return. If it was set, it returns false and the
caller exits.

The caller of this function must decrement the disable counter, but misses
doing so if the calltime fails to be acquired.

Instead of exiting out when calltime is NULL, change the logic to do the
work if it is not NULL and still do the clean up at the end of the
function if it is NULL.

Cc: stable@vger.kernel.org
Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20251006175848.1906912-2-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..4c45c49b06c8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -184,7 +184,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
-	int ret;
+	int ret = 0;
 
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
@@ -202,13 +202,11 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 
 	return ret;
@@ -233,11 +231,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 
 	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	if (calltime) {
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	}
 	local_dec(&data->disabled);
 }
 
-- 
2.51.0

