Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0914A0B3;
	Sat,  8 Feb 2025 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991716; cv=none; b=lyOvoi4JSLqumgjUxvnN3+BUDdio8nJLd46PS510eVkFZntHRPv3+gl8s/CzW5PmVo3AdDuSTyFrb2/169Sp2Qw8oLatUuOcbDcrSERSBJcDd1M2bE6XEmiXkyohA7FCXv/bFxLFr8F80kAkvgxH9KVyXGb+/BAR+LGIdRmASQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991716; c=relaxed/simple;
	bh=IITLHrpQ9HHWrHK0xM3nrmcduVrguCrrRbBJi2jqYTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cpyUZBzLEgUbunt98NDjK9q7HX83OIqlEkkqByKFZs0k7sn/9ICrKpkclEQQoQwTg22stkT17ZcH6PwmTYfFFN9yPeosbnwkE19ijo/GFYfpM/V8tKYeKGk9Ly4Pvf2v+NP8Km+b4VBljwP9sBsFiYqWjiQYsahT1ohcLz/dOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C99CC4CED6;
	Sat,  8 Feb 2025 05:15:14 +0000 (UTC)
Date: Sat, 8 Feb 2025 00:15:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] fgraph: Fix set_graph_notrace with setting
 TRACE_GRAPH_NOTRACE_BIT
Message-ID: <20250208001511.535be150@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The code was restructured where the function graph notrace code, that
would not trace a function and all its children is done by setting a
NOTRACE flag when the function that is not to be traced is hit.

There's a TRACE_GRAPH_NOTRACE_BIT which defines the bit in the flags and a
TRACE_GRAPH_NOTRACE which is the mask with that bit set. But the
restructuring used TRACE_GRAPH_NOTRACE_BIT when it should have used
TRACE_GRAPH_NOTRACE.

For example:

 # cd /sys/kernel/tracing
 # echo set_track_prepare stack_trace_save  > set_graph_notrace
 # echo function_graph > current_tracer
 # cat trace
[..]
 0)               |                          __slab_free() {
 0)               |                            free_to_partial_list() {
 0)               |                                  arch_stack_walk() {
 0)               |                                    __unwind_start() {
 0)   0.501 us    |                                      get_stack_info();

Where a non filter trace looks like:

 # echo > set_graph_notrace
 # cat trace
 0)               |                            free_to_partial_list() {
 0)               |                              set_track_prepare() {
 0)               |                                stack_trace_save() {
 0)               |                                  arch_stack_walk() {
 0)               |                                    __unwind_start() {

Where the filter should look like:

 # cat trace
 0)               |                            free_to_partial_list() {
 0)               |                              _raw_spin_lock_irqsave() {
 0)   0.350 us    |                                preempt_count_add();
 0)   0.351 us    |                                do_raw_spin_lock();
 0)   2.440 us    |                              }

Fixes: b84214890a9bc ("function_graph: Move graph notrace bit to shadow stack global var")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 54d850997c0a..136c750b0b4d 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -198,7 +198,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	 * returning from the function.
 	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
-		*task_var |= TRACE_GRAPH_NOTRACE_BIT;
+		*task_var |= TRACE_GRAPH_NOTRACE;
 		/*
 		 * Need to return 1 to have the return called
 		 * that will clear the NOTRACE bit.
-- 
2.45.2

