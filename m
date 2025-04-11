Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC26230D08;
	Fri, 11 Apr 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392532; cv=none; b=cqV4Q0fKgXCxJ6FqKxNxOGrKLlOsLSLgJngo8fFlrlCjlOaYh5/J3bfkwMTLAYn3z8MgXBeveWwSqvAOV0OKgF1MOlXi6oVRkZv4hDvJlAfRNGz2KabFlNKfJWXSdM8nXy1nOnjVuw80EhiV0/582Y87S+ylTDKyxkLOWIUvHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392532; c=relaxed/simple;
	bh=N/YDbXopgajU9CXeGj4104OGoJtHsueTri0WdMFP9x0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dqI74RojcCAPCBUd9+++YHdbEVD68gCsDAemiW4EacI500mvoZXu102cBaYpOxfD1FJIM7YH4mNKzzGnyMenHcJ3AlpQ2h2Qs6J1Ixrbu7OzwiDJpav7tbu7os98lqS0WxARr/SAJO1fIy1kA++FqoLH9g8E9L/n8Ql2atlO/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAACC4CEE8;
	Fri, 11 Apr 2025 17:28:51 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:30:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH] ftrace: Do not have print_graph_retval() add a newline
Message-ID: <20250411133015.015ca393@gandalf.local.home>
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

The retval and retaddr options for function_graph tracer will add a
comment at the end of a function for both leaf and non leaf functions that
looks like:

               __wake_up_common(); /* ret=0x1 */

               } /* pick_next_task_fair ret=0x0 */

The function print_graph_retval() adds a newline after the "*/". But if
that's not called, the caller function needs to make sure there's a
newline added.

This is confusing and when the function parameters code was added, it
added a newline even when calling print_graph_retval() as the fact that
the print_graph_retval() function prints a newline isn't obvious.

This caused an extra newline to be printed and that made it fail the
selftests when the retval option was set, as the selftests were not
expecting blank lines being injected into the trace.

Instead of having print_graph_retval() print a newline, just have the
caller always print the newline regardless if it calls print_graph_retval()
or not. This not only fixes this bug, but it also simplifies the code.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk/
Fixes: ff5c9c576e754 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2f077d4158e5..0c357a89c58e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -880,8 +880,6 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 
 		if (print_retval || print_retaddr)
 			trace_seq_puts(s, " /*");
-		else
-			trace_seq_putc(s, '\n');
 	} else {
 		print_retaddr = false;
 		trace_seq_printf(s, "} /* %ps", func);
@@ -899,7 +897,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	}
 
 	if (!entry || print_retval || print_retaddr)
-		trace_seq_puts(s, " */\n");
+		trace_seq_puts(s, " */");
 }
 
 #else
@@ -975,7 +973,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 		} else
 			trace_seq_puts(s, "();");
 	}
-	trace_seq_printf(s, "\n");
+	trace_seq_putc(s, '\n');
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -1313,10 +1311,11 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 		 * that if the funcgraph-tail option is enabled.
 		 */
 		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-			trace_seq_puts(s, "}\n");
+			trace_seq_puts(s, "}");
 		else
-			trace_seq_printf(s, "} /* %ps */\n", (void *)func);
+			trace_seq_printf(s, "} /* %ps */", (void *)func);
 	}
+	trace_seq_putc(s, '\n');
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-- 
2.47.2

