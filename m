Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7283275868;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480150; cv=none; b=Rbj7xJ4Cm5rJDYiMcqtwix8tbDZvyj9IFxaAWrlsnIax9Zfq/KS4jF+Z2Wk5CQquTGZ6RxoG1aABJsyxfdtRSvNG1qXC9Ll7/qMLt7Bg/3LbyiT01XGjS6OzGo1vXY3eFKdTcXOCZcYbiL19TYyDOsJMH/JA6ThQncNIjcNTnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480150; c=relaxed/simple;
	bh=LfbYZrkrwSHhr03nwF7TAzWMZMSOM7lGFrPKQJo3J/Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VNykoLMHSCmuvjPHvsE+7cQ6KbeKEHVPD3lb0+yKKkT3Mk6ohsPQ7urP0hpxt6CHq3qxhiANq9ivQyCarJbtaO4kMsp4dC+B8pzufohw8ni8kNr2VIzxgGLmMMTHNK6qYje9mtGNFfqCY1QNxdmbw2Iyy/7cYVz40FdLeIjA8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C3AC4CEEE;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gm-00000000yGk-2zaX;
	Mon, 05 May 2025 17:22:36 -0400
Message-ID: <20250505212236.567884756@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 12/13] tracing: Use atomic_inc_return() for updating "disabled" counter in
 irqsoff tracer
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The irqsoff tracer uses the per CPU "disabled" field to prevent corruption
of the accounting when it starts to trace interrupts disabled, but there's
a slight race that could happen if for some reason it was called twice.
Use atomic_inc_return() instead.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 0b6d932a931e..5496758b6c76 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -397,6 +397,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
+	long disabled;
 
 	if (!tracer_enabled || !tracing_is_enabled())
 		return;
@@ -411,15 +412,17 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 	if (unlikely(!data) || local_read(&data->disabled))
 		return;
 
-	local_inc(&data->disabled);
+	disabled = local_inc_return(&data->disabled);
 
-	data->critical_sequence = max_sequence;
-	data->preempt_timestamp = ftrace_now(cpu);
-	data->critical_start = parent_ip ? : ip;
+	if (disabled == 1) {
+		data->critical_sequence = max_sequence;
+		data->preempt_timestamp = ftrace_now(cpu);
+		data->critical_start = parent_ip ? : ip;
 
-	__trace_function(tr, ip, parent_ip, tracing_gen_ctx());
+		__trace_function(tr, ip, parent_ip, tracing_gen_ctx());
 
-	per_cpu(tracing_cpu, cpu) = 1;
+		per_cpu(tracing_cpu, cpu) = 1;
+	}
 
 	local_dec(&data->disabled);
 }
@@ -431,6 +434,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
+	long disabled;
 
 	cpu = raw_smp_processor_id();
 	/* Always clear the tracing cpu on stopping the trace */
@@ -448,12 +452,15 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	    !data->critical_start || local_read(&data->disabled))
 		return;
 
-	local_inc(&data->disabled);
+	disabled = local_inc_return(&data->disabled);
+
+	if (disabled == 1) {
+		trace_ctx = tracing_gen_ctx();
+		__trace_function(tr, ip, parent_ip, trace_ctx);
+		check_critical_timing(tr, data, parent_ip ? : ip, cpu);
+		data->critical_start = 0;
+	}
 
-	trace_ctx = tracing_gen_ctx();
-	__trace_function(tr, ip, parent_ip, trace_ctx);
-	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
-	data->critical_start = 0;
 	local_dec(&data->disabled);
 }
 
-- 
2.47.2


