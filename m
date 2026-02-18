Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726819D8A8;
	Wed, 18 Feb 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429367; cv=none; b=hjAHSbRfwHcL40U11JMtho7TvVTkWOmkuY2WNFGB1dNOWhfClf0yB4A7eajTxHjwwj2+LDyIAxrpP49t5aMg9TQvXMwb1MlMTgIb1oF3p0upKyju+1aXloKR/aEWA7eaezAJBvZGY+RMoCb2y7x34BjxU7Y2movyy8mMHc0p8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429367; c=relaxed/simple;
	bh=uiOYwDP2SLEpKOgOUb7OgINKyg6MBDe+KOwvdTofFTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nWPZKKb//8UOuCvB14/rZf5MWPj+Ngu+VcZ23bLsrRPMPXM7wnWlVexOJPb0jnUaHarGEAiHxyhSDo3WVnp4NzE7OyILg5CadJzwCvRsSPou97DeGxFXXuseQK/4E4XFUAaQBLyqMWwTi0IQCJW5wFG/nQXqprJNQFw8c6aHhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B21BD564D6;
	Wed, 18 Feb 2026 15:42:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 18E4E20028;
	Wed, 18 Feb 2026 15:42:43 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:42:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] fgraph: Do not call handlers direct when not using
 ftrace_ops
Message-ID: <20260218104244.5f14dade@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mffmbke1kma7wfnnsu75kxommx7q484r
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 18E4E20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/z+AJ1utPLULIvgCzV7JiAjIyX6WmqWeA=
X-HE-Tag: 1771429363-463030
X-HE-Meta: U2FsdGVkX181AnkQKZNyPJOpatB7FiqH/+wtb8WNe6VfayGpR6j7qcIME0rGPLPM+qV3wYpclj7CXOTiaahi3JT1xkmgveOh95PfZegCNjMUHENdldKzOn0j1+kRaWkGwbmY3nB6lvz4mrriVhzgcnCszgzCL8Ia2QNT/ytmSlU8iUrfVZfv1Sa8sdEpEeulnAGDYbP9XPaQhjySYfspQlSETJhr7JnU83MjY8yT+ZZOHScn3dSDLTlu02F4HbVQdbOR1EwDLP78dw0+FGO8g6oR3erEjkuvDW0v/sYS9s++13LDcsFIN3lGjjbYF7YuYV/nciccIAKQP2+rQP/b6Gs4vmVNvSjseXJrdGrmf855LPfnV6yLcvG0OMJUDo5g

From: Steven Rostedt <rostedt@goodmis.org>

The function graph tracer was modified to us the ftrace_ops of the
function tracer. This simplified the code as well as allowed more features
of the function graph tracer.

Not all architectures were converted over as it required the
implementation of HAVE_DYNAMIC_FTRACE_WITH_ARGS to implement. For those
architectures, it still did it the old way where the function graph tracer
handle was called by the function tracer trampoline. The handler then had
to check the hash to see if the registered handlers wanted to be called by
that function or not.

In order to speed up the function graph tracer that used ftrace_ops, if
only one callback was registered with function graph, it would call its
function directly via a static call.

Now, if the architecture does not support the use of using ftrace_ops and
still has the ftrace function trampoline calling the function graph
handler, then by doing a direct call it removes the check against the
handler's hash (list of functions it wants callbacks to), and it may call
that handler for functions that the handler did not request calls for.

On 32bit x86, which does not support the ftrace_ops use with function
graph tracer, it shows the issue:

 ~# trace-cmd start -p function -l schedule
 ~# trace-cmd show
 # tracer: function_graph
 #
 # CPU  DURATION                  FUNCTION CALLS
 # |     |   |                     |   |   |   |
  2) * 11898.94 us |  schedule();
  3) # 1783.041 us |  schedule();
  1)               |  schedule() {
  ------------------------------------------
  1)   bash-8369    =>  kworker-7669
  ------------------------------------------
  1)               |        schedule() {
  ------------------------------------------
  1)  kworker-7669  =>   bash-8369
  ------------------------------------------
  1) + 97.004 us   |  }
  1)               |  schedule() {
 [..]

Now by starting the function tracer is another instance:

 ~# trace-cmd start -B foo -p function

This causes the function graph tracer to trace all functions (because the
function trace calls the function graph tracer for each on, and the
function graph trace is doing a direct call):

 ~# trace-cmd show
 # tracer: function_graph
 #
 # CPU  DURATION                  FUNCTION CALLS
 # |     |   |                     |   |   |   |
  1)   1.669 us    |          } /* preempt_count_sub */
  1) + 10.443 us   |        } /* _raw_spin_unlock_irqrestore */
  1)               |        tick_program_event() {
  1)               |          clockevents_program_event() {
  1)   1.044 us    |            ktime_get();
  1)   6.481 us    |            lapic_next_event();
  1) + 10.114 us   |          }
  1) + 11.790 us   |        }
  1) ! 181.223 us  |      } /* hrtimer_interrupt */
  1) ! 184.624 us  |    } /* __sysvec_apic_timer_interrupt */
  1)               |    irq_exit_rcu() {
  1)   0.678 us    |      preempt_count_sub();

When it should still only be tracing the schedule() function.

To fix this, add a macro FGRAPH_NO_DIRECT to be set to 0 when the
architecture does not support function graph use of ftrace_ops, and set to
1 otherwise. Then use this macro to know to allow function graph tracer to
call the handlers directly or not.

Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 13 ++++++++++---
 kernel/trace/fgraph.c  | 12 +++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1a4d36fc9085..c242fe49af4c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1092,10 +1092,17 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #ifndef ftrace_graph_func
-#define ftrace_graph_func ftrace_stub
-#define FTRACE_OPS_GRAPH_STUB FTRACE_OPS_FL_STUB
+# define ftrace_graph_func ftrace_stub
+# define FTRACE_OPS_GRAPH_STUB FTRACE_OPS_FL_STUB
+/*
+ * The function graph is called every time the function tracer is called.
+ * It must always test the ops hash and cannot just directly call
+ * the handler.
+ */
+# define FGRAPH_NO_DIRECT	1
 #else
-#define FTRACE_OPS_GRAPH_STUB 0
+# define FTRACE_OPS_GRAPH_STUB	0
+# define FGRAPH_NO_DIRECT	0
 #endif
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4df766c690f9..40d373d65f9b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -539,7 +539,11 @@ static struct fgraph_ops fgraph_stub = {
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
 DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
+#if FGRAPH_NO_DIRECT
+static DEFINE_STATIC_KEY_FALSE(fgraph_do_direct);
+#else
 static DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
+#endif
 
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
@@ -843,7 +847,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	bitmap = get_bitmap_bits(current, offset);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
-	if (static_branch_likely(&fgraph_do_direct)) {
+	if (!FGRAPH_NO_DIRECT && static_branch_likely(&fgraph_do_direct)) {
 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
 			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
 	} else
@@ -1285,6 +1289,9 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	trace_func_graph_ret_t retfunc = NULL;
 	int i;
 
+	if (FGRAPH_NO_DIRECT)
+		return;
+
 	if (gops) {
 		func = gops->entryfunc;
 		retfunc = gops->retfunc;
@@ -1308,6 +1315,9 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 
 static void ftrace_graph_disable_direct(bool disable_branch)
 {
+	if (FGRAPH_NO_DIRECT)
+		return;
+
 	if (disable_branch)
 		static_branch_disable(&fgraph_do_direct);
 	static_call_update(fgraph_func, ftrace_graph_entry_stub);
-- 
2.51.0

