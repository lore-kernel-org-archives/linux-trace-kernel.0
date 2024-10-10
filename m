Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318B1E3DE0;
	Thu, 10 Oct 2024 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603615; cv=none; b=esvl3Stx9q/CaelInQ30OgSiLpCWOJAB6sAk8foHVa25ZcufAZQ3Nl05Fwr1U+1DR2QxwnAKoDYjQAXr/F4iC4UAC2DA4ue4lMkA8HN5vXCmwP7PIs6E05+5SDmqbnlFUv3Lxe/3MWfoDUYKCZP1NbvmT30RihwhNUHGZ4LQt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603615; c=relaxed/simple;
	bh=dJFN72gV9RZOP4y1IjOhN9T6CcWa4weQEqUHyI2Qq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nVhlHULqqtDBGFPKbyWkbjVPQGrRMjYvJ3KLezS0XmisEouANFwbprv1s4JqtZ+l7A2KoNPUorU+ZheO9itvmD+/u3HwM2ZDn0bw3gfgoT4z2pOcxRzgT3OZzQjArEnt8nxTsGlIz4TFbXx/DQp6PhBZBQR/rIs4lf8keJKXQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B2C4CEC5;
	Thu, 10 Oct 2024 23:40:12 +0000 (UTC)
Date: Thu, 10 Oct 2024 19:40:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Donglin Peng <dolinux.peng@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: fgragh: No need to invoke the function call_filter_check_discard()
Message-ID: <20241010194020.46192b21@gandalf.local.home>
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

The function call_filter_check_discard() has been removed in the
commit 49e4154f4b16 ("tracing: Remove TRACE_EVENT_FL_FILTERED logic"),
from another topic branch. But when merged together with commit
21e92806d39c6 ("function_graph: Support recording and printing the
function return address") which added another call to
call_filter_check_discard(), it caused the build to fail. Since the
function call_filter_check_discard() is useless, it can simply be removed
regardless of being merged with commit 49e4154f4b16 or not.

Link: https://lore.kernel.org/all/20241010134649.43ed357c@canb.auug.org.au/

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 20d0c579d3b5..03c5a0d300a5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -137,7 +137,6 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 				unsigned int trace_ctx,
 				unsigned long retaddr)
 {
-	struct trace_event_call *call = &event_fgraph_retaddr_entry;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct fgraph_retaddr_ent_entry *entry;
@@ -150,8 +149,7 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 	entry->graph_ent.func = trace->func;
 	entry->graph_ent.depth = trace->depth;
 	entry->graph_ent.retaddr = retaddr;
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
 }
-- 
2.45.2

