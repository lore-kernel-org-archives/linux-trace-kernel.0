Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1096270565;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480148; cv=none; b=qWLiY+G7BfpxptA2zzxYQn/KDQ/go7iA4damwIeI1CwNvTT0J1BfaezKd5WX+fCjztawrlUD+ev94WlSO+QOQypexaIX2RWDtlepCvIA3j4OfVv+ZthYbMJRRuFG/GUByqdsGjSJjMFoWKrixY2Tbl1zfrUZGhwM6dnZDw9006g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480148; c=relaxed/simple;
	bh=TqkD8LxtVBklZh0dnSpjx7PjTTWwl2OLh6qRcV+8HgA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i8ybn8Ys+bUFBkB9VzTk+vqOCLB5OR7sPD63f3qk+aAnVHNSVO4zlPH7HP2TdTWBz9L0tvw3nJdo7sGZeiMdCb5gK7p9HSGJcGYyokdQ7Vc9KfLu7HykHArabQ5LgzyRY/3LYupVn53X+QG7dpIpd/X6mwH6Rjkh5pfQvJU4m1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4402EC4CEEF;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gl-00000000yBl-04qZ;
	Mon, 05 May 2025 17:22:35 -0400
Message-ID: <20250505212234.868972758@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 02/13] ftrace: Do not bother checking per CPU "disabled" flag
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The per CPU "disabled" value was the original way to disable tracing when
the tracing subsystem was first created. Today, the ring buffer
infrastructure has its own way to disable tracing. In fact, things have
changed so much since 2008 that many things ignore the disable flag.

There's no reason for the function tracer to check it, if tracing is
disabled, the ring buffer will not record the event anyway.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 98ccf3f00c51..bd153219a712 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -209,7 +209,6 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = op->private;
-	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	int bit;
 
@@ -224,9 +223,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx_dec();
 
-	data = this_cpu_ptr(tr->array_buffer.data);
-	if (!atomic_read(&data->disabled))
-		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -236,10 +233,8 @@ function_args_trace_call(unsigned long ip, unsigned long parent_ip,
 			 struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = op->private;
-	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	int bit;
-	int cpu;
 
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -250,10 +245,7 @@ function_args_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx();
 
-	cpu = smp_processor_id();
-	data = per_cpu_ptr(tr->array_buffer.data, cpu);
-	if (!atomic_read(&data->disabled))
-		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -352,7 +344,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 {
 	struct trace_func_repeats *last_info;
 	struct trace_array *tr = op->private;
-	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	int bit;
 
@@ -364,8 +355,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
-	data = this_cpu_ptr(tr->array_buffer.data);
-	if (atomic_read(&data->disabled))
+	if (!tracer_tracing_is_on(tr))
 		goto out;
 
 	/*
-- 
2.47.2


