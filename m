Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D81F9A83;
	Mon, 13 Jan 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811088; cv=none; b=AwgzIoNb2YmdPEhK3kaWbhpbitzBiaA0k+VPEKZmTiA2lFioWueR264HA6CbzBNDFEdwhFjluqI/ytDBQuiNj9/ORfkiKgcEAj30wkZH6qGwH9J56siZlEf4z9rcxXdec2UOqJICOjsfLDcSJkmm/6CqvRdoscvHtDA44OolaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811088; c=relaxed/simple;
	bh=gg+u9fEeYoOlnTIiVbQrorHG/QsEM7+hl22d6Z6uX50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lckXAVB9F9tyGOYApPiyTIiXSoXsGVHguQdXb1YVhIb+zUkvD0QLSJ1FEeWmustGngUUjWUrWrOb3bkpYtTUcEzcC6hnPoCAMLqFV3cJ54Z2Kr46eju0xXmF6PsF8wmlETzaUM53Y3/jF7ZUZi8yAHypshjqbi99M0d0D+55Rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3A9C4CEE2;
	Mon, 13 Jan 2025 23:31:25 +0000 (UTC)
Date: Mon, 13 Jan 2025 18:31:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing: Fix irqsoff and wakeup latency tracers when using
 function graph
Message-ID: <20250113183124.61767419@gandalf.local.home>
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

The function graph tracer is becoming a generic so that kretprobes and BPF
can use it along with function graph tracing itself. Some of the
infrastructure was specific for function graph tracing such as recording
the calltime and return time of the functions. Calling the clock code on
a high volume function does add overhead. The calltime was removed from
the generic code and placed into the function graph tracer itself so that
the other users did not incur this overhead as they did not need that
timestamp.

But this broke both irqsoff and wakeup latency tracer as they still
depended on the trace structure containing the calltime when the option
display-graph is set.

 # cd /sys/kernel/tracing
 # echo 1 > options/display-graph
 # echo irqsoff > current_tracer

The tracers went from:

 #   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
 #      |          |     |    |        ||||      |   |                     |   |   |   |
        0 us |   4)    <idle>-0    |  d..1. |   0.000 us    |  irqentry_enter();
        3 us |   4)    <idle>-0    |  d..2. |               |  irq_enter_rcu() {
        4 us |   4)    <idle>-0    |  d..2. |   0.431 us    |    preempt_count_add();
        5 us |   4)    <idle>-0    |  d.h2. |               |    tick_irq_enter() {
        5 us |   4)    <idle>-0    |  d.h2. |   0.433 us    |      tick_check_oneshot_broadcast_this_cpu();
        6 us |   4)    <idle>-0    |  d.h2. |   2.426 us    |      ktime_get();
        9 us |   4)    <idle>-0    |  d.h2. |               |      tick_nohz_stop_idle() {
       10 us |   4)    <idle>-0    |  d.h2. |   0.398 us    |        nr_iowait_cpu();
       11 us |   4)    <idle>-0    |  d.h1. |   1.903 us    |      }
       11 us |   4)    <idle>-0    |  d.h2. |               |      tick_do_update_jiffies64() {
       12 us |   4)    <idle>-0    |  d.h2. |               |        _raw_spin_lock() {
       12 us |   4)    <idle>-0    |  d.h2. |   0.360 us    |          preempt_count_add();
       13 us |   4)    <idle>-0    |  d.h3. |   0.354 us    |          do_raw_spin_lock();
       14 us |   4)    <idle>-0    |  d.h2. |   2.207 us    |        }
       15 us |   4)    <idle>-0    |  d.h3. |   0.428 us    |        calc_global_load();
       16 us |   4)    <idle>-0    |  d.h3. |               |        _raw_spin_unlock() {
       16 us |   4)    <idle>-0    |  d.h3. |   0.380 us    |          do_raw_spin_unlock();
       17 us |   4)    <idle>-0    |  d.h3. |   0.334 us    |          preempt_count_sub();
       18 us |   4)    <idle>-0    |  d.h1. |   1.768 us    |        }
       18 us |   4)    <idle>-0    |  d.h2. |               |        update_wall_time() {
      [..]

To:

 #   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
 #      |          |     |    |        ||||      |   |                     |   |   |   |
        0 us |   5)    <idle>-0    |  d.s2. |   0.000 us    |  _raw_spin_lock_irqsave();
        0 us |   5)    <idle>-0    |  d.s3. |   312159583 us |      preempt_count_add();
        2 us |   5)    <idle>-0    |  d.s4. |   312159585 us |      do_raw_spin_lock();
        3 us |   5)    <idle>-0    |  d.s4. |               |      _raw_spin_unlock() {
        3 us |   5)    <idle>-0    |  d.s4. |   312159586 us |        do_raw_spin_unlock();
        4 us |   5)    <idle>-0    |  d.s4. |   312159587 us |        preempt_count_sub();
        4 us |   5)    <idle>-0    |  d.s2. |   312159587 us |      }
        5 us |   5)    <idle>-0    |  d.s3. |               |      _raw_spin_lock() {
        5 us |   5)    <idle>-0    |  d.s3. |   312159588 us |        preempt_count_add();
        6 us |   5)    <idle>-0    |  d.s4. |   312159589 us |        do_raw_spin_lock();
        7 us |   5)    <idle>-0    |  d.s3. |   312159590 us |      }
        8 us |   5)    <idle>-0    |  d.s4. |   312159591 us |      calc_wheel_index();
        9 us |   5)    <idle>-0    |  d.s4. |               |      enqueue_timer() {
        9 us |   5)    <idle>-0    |  d.s4. |               |        wake_up_nohz_cpu() {
       11 us |   5)    <idle>-0    |  d.s4. |               |          native_smp_send_reschedule() {
       11 us |   5)    <idle>-0    |  d.s4. |   312171987 us |            default_send_IPI_single_phys();
    12408 us |   5)    <idle>-0    |  d.s3. |   312171990 us |          }
    12408 us |   5)    <idle>-0    |  d.s3. |   312171991 us |        }
    12409 us |   5)    <idle>-0    |  d.s3. |   312171991 us |      }

Where the calculation of the time for each function was the return time
minus zero and not the time it the function started at.

Have these tracers also save the calltime in the fgraph data section and
retrieve it again on the return to get the correct timings again.

Fixes: f1f36e22bee9 ("ftrace: Have calltime be saved in the fgraph storage")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c      | 14 ++++++++++++++
 kernel/trace/trace_sched_wakeup.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..a4e799c1e767 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -182,6 +182,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	struct trace_array_cpu *data;
 	unsigned long flags;
 	unsigned int trace_ctx;
+	u64 *calltime;
 	int ret;
 
 	if (ftrace_graph_ignore_func(gops, trace))
@@ -199,6 +200,12 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return 0;
 
+	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
+	if (!calltime)
+		return 0;
+
+	*calltime = trace_clock_local();
+
 	trace_ctx = tracing_gen_ctx_flags(flags);
 	ret = __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
@@ -213,12 +220,19 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array_cpu *data;
 	unsigned long flags;
 	unsigned int trace_ctx;
+	u64 *calltime;
+	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
+	calltime = fgraph_retrieve_data(gops->idx, &size);
+	if (!calltime)
+		return;
+	trace->calltime = *calltime;
+
 	trace_ctx = tracing_gen_ctx_flags(flags);
 	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index d6c7f18daa15..c58292e424d5 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -118,6 +118,7 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
+	u64 *calltime;
 	int ret = 0;
 
 	if (ftrace_graph_ignore_func(gops, trace))
@@ -135,6 +136,12 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return 0;
 
+	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
+	if (!calltime)
+		return 0;
+
+	*calltime = trace_clock_local();
+
 	ret = __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 	preempt_enable_notrace();
@@ -148,12 +155,19 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
+	u64 *calltime;
+	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
 
+	calltime = fgraph_retrieve_data(gops->idx, &size);
+	if (!calltime)
+		return;
+	trace->calltime = *calltime;
+
 	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 
-- 
2.45.2

