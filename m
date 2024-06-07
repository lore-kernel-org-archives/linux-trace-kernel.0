Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FC192B89;
	Fri,  7 Jun 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768101; cv=none; b=EMDAJyvsJ0YLAgITzwwvmuYXMTxHLaD9Uhx/8fUUyLXM9ILM57eHDBDE8113KmIbQXQEw+grePs+WFR2GbCZ6OInCEXmQ0Et44br20uuBl0U01fOUSqG2gvdVoTGSU/xiIEfvxV/UQg/1b9sdu66z7rCe7z92wAnbNFWM8gEWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768101; c=relaxed/simple;
	bh=JdONP7PI4z5eHlGJTSokvp6V8e5bDvrLIcTnte+cj2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rWcMhFqkAXnlM8qVP59CC/VpQvI7f68Rv1J9uZgY2DHQ9qhu9sAjqKx1Ep71yqbE/uyiXT1aaIEYg2NdHsFw+RC7a4FcI2r9EALBs6XZvHq+qg82pPL3m1IlHFjj5nAHIPu0bXT8iPvUo5GMGw2EKHEIg5gEi8lUOjP9BHbMn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94387C2BBFC;
	Fri,  7 Jun 2024 13:48:19 +0000 (UTC)
Date: Fri, 7 Jun 2024 09:48:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] function_graph: Make fgraph_update_pid_func() a stub for
 !DYNAMIC_FTRACE
Message-ID: <20240607094833.6a787d73@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When CONFIG_DYNAMIC_FTRACE is not set, the function
fgraph_update_pid_func() doesn't do anything. Currently, most of its logic
is within a "#ifdef CONFIG_DYNAMIC_FTRACE" block, but its variables were
declared outside that, and when DYNAMIC_FTRACE is not set, it produces
unused variable warnings.

Instead, just place it (and the helper function fgraph_pid_func()) within
the #ifdef block and have the header file use a empty stub function for
when DYNAMIC_FTRACE is not defined.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406071806.BRjaC5FF-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c          | 4 ++--
 kernel/trace/ftrace_internal.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c0e428c87ea5..0859ab112db7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1151,6 +1151,7 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	kfree(ret_stack);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			   struct fgraph_ops *gops)
 {
@@ -1177,7 +1178,6 @@ void fgraph_update_pid_func(void)
 	if (!(graph_ops.flags & FTRACE_OPS_FL_INITIALIZED))
 		return;
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 	list_for_each_entry(op, &graph_ops.subop_list, list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			gops = container_of(op, struct fgraph_ops, ops);
@@ -1187,8 +1187,8 @@ void fgraph_update_pid_func(void)
 				static_call_update(fgraph_func, gops->entryfunc);
 		}
 	}
-#endif
 }
+#endif
 
 /* Allocate a return stack for each task */
 static int start_graph_tracing(void)
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 4bb1e881154a..3235470e61b3 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -52,7 +52,11 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+# ifdef CONFIG_DYNAMIC_FTRACE
 extern void fgraph_update_pid_func(void);
+# else
+static inline void fgraph_update_pid_func(void) {}
+# endif
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
 static inline void fgraph_update_pid_func(void) {}
-- 
2.43.0

