Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21E20C48C;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219229; cv=none; b=PfyqwYt4LSOYss8u4KN13di35uvdmWIa0jNQuX1UCGr2PFzaH1wTM6mK2U1KRF/Xibh0Uw4QugrAPlWvyI0qJ6VxD7Hlk/Wt390Gg+fi/rmDmZw6W1I5lF+W+lu3A2NWgPd+h/Jm0780yUSHZsAj62XWSdDRCg6zenxfXI2fZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219229; c=relaxed/simple;
	bh=cETHAQ1zqWANjfr1MjlhdGt4/vZ0FNpoIBmdpt8H8+w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MRSltqHYdKeceObxq14kQDbOPI3/OJ4frSYYKTfXtO0PuzXiJYH5emN37bqTXTI+wdyumVFQeL+VkOOBfiOXO7l5a8pHJBayPlVPDZYQCydsab9lLTx3BUzgD7eHGX8F2XEsmQqaCMrH7UnkyMqB1jAjK8mLb6jmr0PFeEXkNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B5FC4CEEF;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOH-000000006DZ-1sYm;
	Fri, 02 May 2025 16:53:49 -0400
Message-ID: <20250502205349.299144667@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 09/12] tracing: branch: Use trace_tracing_is_on_cpu() instead of "disabled"
 field
References: <20250502205147.283272733@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The branch tracer currently checks the per CPU "disabled" field to know if
tracing is enabled or not for the CPU. As the "disabled" value is not used
anymore to turn of tracing generically, use tracing_tracer_is_on_cpu()
instead.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_branch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 6d08a5523ce0..2a1a06eb7939 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -32,7 +32,6 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 {
 	struct trace_array *tr = branch_tracer;
 	struct trace_buffer *buffer;
-	struct trace_array_cpu *data;
 	struct ring_buffer_event *event;
 	struct trace_branch *entry;
 	unsigned long flags;
@@ -54,8 +53,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 
 	raw_local_irq_save(flags);
 	current->trace_recursion |= TRACE_BRANCH_BIT;
-	data = this_cpu_ptr(tr->array_buffer.data);
-	if (atomic_read(&data->disabled))
+	if (!tracer_tracing_is_on_cpu(tr, raw_smp_process_id()))
 		goto out;
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
-- 
2.47.2


