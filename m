Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB21A8F94
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060474; cv=none; b=ADIp8AzCgIFd9BfImatKNoH5EDCCc5KN+IuH43FgffaKH7WJtX+g5dXT8kITrSRzqUAioPPzFLnbLWhwqZJP8lEu8QNsDOLb3DpoOkn2RRMQ8Q1zKHK8Sa/YutK6Ox7yvHz9GIBmxutgfJX8SWhCPKLDf8JbZdl3v0dCbtfCH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060474; c=relaxed/simple;
	bh=I+MBhbWOY8fw/wnlSvNDYQihrRnx4esg5ubU+djXAHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kmJjbRPjzzJPcPO9iREcLU7yN9jdfjOX7asW0x5vXDmPO6ClQFr+o2jiwFJF5+yIyMPlE0QCEB3MNF8AlmYfPnpdWhFqE2nzFrdeO68lEpH1M+l1g6PH59TjL0wgNX4YAnRXyiOPa8K8XzQ5NsZSd0UQtUC22X8wA+Bk4AWyatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vjP4obKV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCxe42Bi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vjP4obKV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCxe42Bi"
Date: Thu, 20 Feb 2025 15:07:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740060470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MH0oFd2HSVxFdutwygEWJbmJNkelnLGC7oXToNWbw8A=;
	b=vjP4obKVTnRmqRx8WPor31wltayn0RFYFxO6SFlvR7zSqx9+Q//tFQuJQLCwODeZKFWsLD
	zHIMLiklUKGkjUxM2gFw2vtlIJaXyVNHTHoYU+swWdz4xwNWTxTrs3TH+2EPxi6C+a/4J8
	c9kgLi/s/T9zpmIQV7Bn3Fi3qVvsckWFPvPL28Je/O3Hl0hEis3wDvf1I+obLmHrZuQ/3v
	AHplRqWLOAHI37KL3ItT3c/Pi1svYZytEijONny/4DGsDRdjeDUsg1B50aXOqm9GbCSp49
	rL3FRFC4sOvqZH7HUz+cHgQHgMlKTgXAUHmc8kMPo9IxBN6mzkpMWupkXlgnYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740060470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MH0oFd2HSVxFdutwygEWJbmJNkelnLGC7oXToNWbw8A=;
	b=KCxe42Bi11ERzq5sXGdh6a38LR+175Iy/BiGfgYylZ+zqbx6nNPQDFfWrC9Mz+ogF/hb7Z
	jadLCFywYKVsRyDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] ftrace: Correct preemption accounting for function tracing.
Message-ID: <20250220140749.pfw8qoNZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The function tracer should record the preemption level at the point when
the function is invoked. If the tracing subsystem decrement the
preemption counter it needs to correct this before feeding the data into
the trace buffer. This was broken in the commit cited below while
shifting the preempt-disabled section.

Use tracing_gen_ctx_dec() which properly subtracts one from the
preemption counter on a preemptible kernel.

Cc: Wander Lairson Costa <wander@redhat.com>
Fixes: ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I haven't been ftrace for quite some time if I got the fixes tag right.

 kernel/trace/trace_functions.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index d358c9935164d..df56f9b760109 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -216,7 +216,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 
-	trace_ctx = tracing_gen_ctx();
+	trace_ctx = tracing_gen_ctx_dec();
 
 	data = this_cpu_ptr(tr->array_buffer.data);
 	if (!atomic_read(&data->disabled))
@@ -321,7 +321,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
-	unsigned long flags;
 	int bit;
 
 	if (unlikely(!tr->function_enabled))
@@ -347,8 +346,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-	local_save_flags(flags);
-	trace_ctx = tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
-- 
2.47.2

