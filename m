Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2F33FE19;
	Wed,  5 Nov 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359567; cv=none; b=m26DtlDg7+Coy2TE3lwg5UMRFbQ13SHqPbxgZtocgjKN602Nur5JncdLxUw5Lt1660X03/JOre7KW3tKcSccBi0dI3M4AJAF+pdJDPPOlo6+oo1OdNBZJnyJfQH907wCntrbL1aPYFCq4b871Jreyc8sik4Exiev21QppOk5tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359567; c=relaxed/simple;
	bh=N+TFR99mamonjH8vPWRk0SrejJFvgn4sQrqG8EbDDpA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qegKOyWPE2/Sd2Zu00Z0nH1cSTdbiJrFvqmxJ80LcnKzijJabSIWuO6W8A5FXG70MqfjjMMkC+OalMMDo1b2DoXDs5j5zPnWBCBCunFHRSinrZOhC4224qFd+NffqZweApPO69dW5FLgiGzj2pk39wNGf4KFrTnV6CQ1uSfQw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNgOgTAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNgOgTAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D31C4CEF8;
	Wed,  5 Nov 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359567;
	bh=N+TFR99mamonjH8vPWRk0SrejJFvgn4sQrqG8EbDDpA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=iNgOgTADcEwA7xn3kZGun3yTiHSAKRokB+XxbSMigkkSIHExcTPEZKwcL7NZO0G0H
	 2fxHNQITQWWN5DcLsGO927PcviUMPXRQ2gbQXArh1PWU1kMisZHjLmJm5v4/919aXp
	 Gqs2yvQ2nnNxSxFHPIZ1HotflZf0GRnL84AM7aSoXObKDLLVHpRcR3fsUWHtIEJGDi
	 I7g0ZHUHwtLjG2qD9+p08+oeAndCYOoCcACAr+rBGDBkF0VkNsBatYN996idLCIUdx
	 dbOrEY10Hh7k4EO+Z69yYSVlc/BeTan60GHwu3/F/p8mdeKdHN+la0dfUlWa8IadK3
	 riGvjApb+HvCQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGgES-00000000pX9-05mz;
	Wed, 05 Nov 2025 11:19:36 -0500
Message-ID: <20251105161935.878361977@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 11:19:14 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] tracing: Have function graph tracer define options per instance
References: <20251105161909.590008129@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the function graph tracer's options are saved via a global mask
when it should be per instance. Use the new infrastructure to define a
"default_flags" field in the tracer structure that is used for the top
level instance as well as new ones.

Currently the global mask causes confusion:

  # cd /sys/kernel/tracing
  # mkdir instances/foo
  # echo function_graph > instances/foo/current_tracer
  # echo 1 > options/funcgraph-args
  # echo function_graph > current_tracer
  # cat trace
[..]
 2)               |          _raw_spin_lock_irq(lock=0xffff96b97dea16c0) {
 2)   0.422 us    |            do_raw_spin_lock(lock=0xffff96b97dea16c0);
 7)               |              rcu_sched_clock_irq(user=0) {
 2)   1.478 us    |          }
 7)   0.758 us    |                rcu_is_cpu_rrupt_from_idle();
 2)   0.647 us    |          enqueue_hrtimer(timer=0xffff96b97dea2058, base=0xffff96b97dea1740, mode=0);
 # cat instances/foo/options/funcgraph-args
 1
 # cat instances/foo/trace
[..]
 4)               |  __x64_sys_read() {
 4)               |    ksys_read() {
 4)   0.755 us    |      fdget_pos();
 4)               |      vfs_read() {
 4)               |        rw_verify_area() {
 4)               |          security_file_permission() {
 4)               |            apparmor_file_permission() {
 4)               |              common_file_perm() {
 4)               |                aa_file_perm() {
 4)               |                  rcu_read_lock_held() {
[..]

The above shows that updating the "funcgraph-args" option at the top level
instance also updates the "funcgraph-args" option in the instance but
because the update is only done by the instance that gets changed (as it
should), it's confusing to see that the option is already set in the other
instance.

Fixes: c132be2c4fcc1 ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index fe9607edc8f9..4e86adf6dd4d 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -101,9 +101,9 @@ static struct tracer_flags tracer_flags = {
 	.opts = trace_opts
 };
 
-static bool tracer_flags_is_set(u32 flags)
+static bool tracer_flags_is_set(struct trace_array *tr, u32 flags)
 {
-	return (tracer_flags.val & flags) == flags;
+	return (tr->current_trace_flags->val & flags) == flags;
 }
 
 /*
@@ -263,7 +263,7 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 
 	trace_ctx = tracing_gen_ctx();
 	if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
-	    tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
+	    tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_RETADDR)) {
 		unsigned long retaddr = ftrace_graph_top_ret_addr(current);
 		ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
 	} else {
@@ -441,7 +441,7 @@ static int graph_trace_init(struct trace_array *tr)
 {
 	int ret;
 
-	if (tracer_flags_is_set(TRACE_GRAPH_ARGS))
+	if (tracer_flags_is_set(tr, TRACE_GRAPH_ARGS))
 		tr->gops->entryfunc = trace_graph_entry_args;
 	else
 		tr->gops->entryfunc = trace_graph_entry;
@@ -1459,7 +1459,8 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 static enum print_line_t
 print_graph_function(struct trace_iterator *iter)
 {
-	return print_graph_function_flags(iter, tracer_flags.val);
+	struct trace_array *tr = iter->tr;
+	return print_graph_function_flags(iter, tr->current_trace_flags->val);
 }
 
 static enum print_line_t
@@ -1535,7 +1536,10 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 
 static void print_graph_headers(struct seq_file *s)
 {
-	print_graph_headers_flags(s, tracer_flags.val);
+	struct trace_iterator *iter = s->private;
+	struct trace_array *tr = iter->tr;
+
+	print_graph_headers_flags(s, tr->current_trace_flags->val);
 }
 
 void print_graph_headers_flags(struct seq_file *s, u32 flags)
@@ -1660,7 +1664,7 @@ static struct tracer graph_trace __tracer_data = {
 	.reset		= graph_trace_reset,
 	.print_line	= print_graph_function,
 	.print_header	= print_graph_headers,
-	.flags		= &tracer_flags,
+	.default_flags	= &tracer_flags,
 	.set_flag	= func_graph_set_flag,
 	.allow_instances = true,
 #ifdef CONFIG_FTRACE_SELFTEST
-- 
2.51.0


