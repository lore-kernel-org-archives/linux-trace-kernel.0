Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6F20E01E;
	Fri,  2 May 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219230; cv=none; b=aQnxy+PbQbRs87ttZLThYxZtRM4sSw1Ut2hfVwc3YUmdy4VEeUxJnUCC6P01dwIbSgPjXL7zp+sjsUTiVWJe6rDDM/jQcvXbyeXU7BmntKKJI9kx4HsSU+qlUxgzB6BHoSRvWDZ1aRK71fsRmXl3BCMSsdWGl4d1b27CZtPU6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219230; c=relaxed/simple;
	bh=LfbYZrkrwSHhr03nwF7TAzWMZMSOM7lGFrPKQJo3J/Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P+AD74qqy4Qes0Mj85/yP/aBYdIDIvtHWp4MVQ6GxUQfkzNRKo8gBphWxTUiP9SlLzzwFeZrMPavK+INP0t0I/cVFu68BBrDnxW46KEzvZLu26HQnfj57Wmq/2FM8BuiwAIFJxuGC+u73YzdOKLwb/Dj+Qfi8dP3vUTNWO1GjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F2C4CEF4;
	Fri,  2 May 2025 20:53:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOH-000000006Ea-3Bqw;
	Fri, 02 May 2025 16:53:49 -0400
Message-ID: <20250502205349.623319847@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 11/12] tracing: Use atomic_inc_return() for updating "disabled" counter in
 irqsoff tracer
References: <20250502205147.283272733@goodmis.org>
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


